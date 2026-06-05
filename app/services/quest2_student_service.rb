class Quest2StudentService
  class << self
    # @return [String]
    def all_agents
      Agent.order(:codename).pluck(:codename).join("\n")
    end

    # @return [String]
    def all_missions
      Mission.order(:title).pluck(:title).join("\n")
    end

    # @return [String]
    def agents_with_missions
      Agent.order(:codename).map do |agent|
        missions = agent.missions.order(:title).pluck(:title).join(", ")
        "#{agent.codename}: #{missions}"
      end.join("\n")
    end

    # @return [String]
    def agents_with_missions_sorted_by_mission_count
      Agent.includes(:missions)
        .sort_by { |agent| [-agent.missions.size, agent.codename] }
        .map do |agent|
          missions = agent.missions.order(:title).pluck(:title).join(", ")
          "#{agent.codename} (#{agent.missions.size}): #{missions}"
        end.join("\n")
    end

    # @return [String]
    def agents_with_skills
      Agent.order(:codename).map do |agent|
        skills = agent.skills.order(:name).pluck(:name).join(", ")
        "#{agent.codename}: #{skills}"
      end.join("\n")
    end

    # @return [String]
    def skills_by_agent_count
      Skill.includes(:agents)
        .sort_by { |skill| [-skill.agents.size, skill.name] }
        .map do |skill|
          agents = skill.agents.order(:codename).pluck(:codename).join(", ")
          "#{skill.name} (#{skill.agents.size}): #{agents}"
        end.join("\n")
    end
  end
end

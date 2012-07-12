# pry-coolline.rb
# (C) John Mair (banisterfiend); MIT license

require 'pry'
require "pry-coolline/version"

begin
  require 'coolline'

  Pry.config.input = Coolline.new do |cool|
    cool.word_boundaries = [" ", "\t", ",", ";", '"', "'", "`", "<", ">",
                            "=", ";", "|", "{", "}", "(", ")", "-"]

    # bring saved history into coolline
    cool.history_file = Pry.config.history.file

    cool.transform_proc = proc do
      if Pry.color
        CodeRay.scan(cool.line, :ruby).term
      else
        cool.line
      end
    end
  end

rescue LoadError
end if ENV["TERM"] != "dumb"

# -*- coding: UTF-8 -*-
require 'lita/handlers/forecast/mixins'
require 'lita/handlers/forecast/weather'

module Lita
  module Handlers
    # Lita Forecast.io plugin!
    #
    class ForecastUS < Handler
      include LitaForecast::Mixins
      include LitaForecast::Weather

      route(
        /^wx\s(.*)$/,
        :weather_us,
        command: true,
        help: {
          'wx san francisco' => 'Get the weather for San Francisco'
        }
      )

      def self.default_config(config)
        config.api_key = nil
      end

      def weather_us(response)
        response.reply(weather(response, api_key, 'us'))
      end

      private

      def api_key
        Lita.config.handlers.forecast.api_key
      end

      Lita.register_handler(ForecastUS)
    end
  end
end
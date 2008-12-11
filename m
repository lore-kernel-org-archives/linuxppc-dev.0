Return-Path: <tpiepho@freescale.com>
Date: Thu, 11 Dec 2008 13:33:51 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/4] leds: Support OpenFirmware led bindings
In-Reply-To: <20081210163217.GA20150@oksana.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.64.0812111326480.28806@t2.domain.actdsltmp>
References: <1228923703-16370-1-git-send-email-tpiepho@freescale.com>
	<20081210163217.GA20150@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: devicetree-discuss@ozlabs.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 10 Dec 2008, Anton Vorontsov wrote:
>> +	gpio_direction_output(led_dat->gpio, led_dat->active_low);
>
> This can fail (yeah, the original code didn't check return value
> either).

I've added a check.

>> +		unsigned int flags;
>
> I think it would be better to use `enum of_gpio_flags' type here,
> just for clarity.

You're right, I forgot to change this after the of_get_gpio patch was
changed.

>> +		ret = create_gpio_led(&led, &pdata->led_data[pdata->num_leds++],
>> +				      &ofdev->dev, NULL);
>> +		if (ret < 0)
>
> of_node_put(np); is missing here.

of_node_put(child) you mean.  It's easy to forget this when one exits one
of these iterators early, since there's no explicit get or put otherwise.

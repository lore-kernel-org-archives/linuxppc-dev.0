Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id AFF4DDDFAD
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 09:14:29 +1000 (EST)
Date: Tue, 12 May 2009 19:14:25 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH] leds: Add options to have GPIO LEDs start on or keep
	their state
Message-ID: <20090512191425.7b8c53df@lappy.seanm.ca>
In-Reply-To: <1242167592-14649-1-git-send-email-xyzzy@speakeasy.org>
References: <fa686aa40904172207sc0f923eoefe8fb0a2703d548@mail.gmail.com>
	<1242167592-14649-1-git-send-email-xyzzy@speakeasy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Richard Purdie <rpurdie@rpsys.net>,
	Trent Piepho <xyzzy@speakeasy.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 12 May 2009 15:33:12 -0700
Trent Piepho <xyzzy@speakeasy.org> wrote:

> +			if (!strcmp(state, "keep")) {
> +				led.default_state =
> LEDS_GPIO_DEFSTATE_KEEP;
> +			} else if(!strcmp(state, "on")) {
> +				led.default_state =
> LEDS_GPIO_DEFSTATE_ON;
> +			} else {
> +				led.default_state =
> LEDS_GPIO_DEFSTATE_OFF;
> +			}

Just a nitpick, you don't need the {} braces here. Other than that:

Acked-by: Sean MacLennan <smaclennan@pikatech.com>
Tested-by: Sean MacLennan <smaclennan@pikatech.com>

Tested on a warp with the following:

			power-leds {
				compatible = "gpio-leds";
				green {
					gpios = <&GPIO1 0 0>;
					default-state = "on";
				};
				red {
					gpios = <&GPIO1 1 0>;
					default-state = "keep";
				};
			};

I tested with both the red LED initially off and initially on as set in
u-boot.

Cheers,
   Sean

Return-Path: <pavel@ucw.cz>
Received: from UNKNOWN (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id 4AE3CDDDEC
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 01:48:13 +1100 (EST)
Date: Sun, 23 Nov 2008 13:31:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH 4/4] leds: Let GPIO LEDs keep their current state
Message-ID: <20081123123154.GB7310@ucw.cz>
References: <Pine.LNX.4.64.0810241442240.3790@t2.domain.actdsltmp>
	<1224889741-4167-4-git-send-email-tpiepho@freescale.com>
	<1226933427.17109.15.camel@ted>
	<Pine.LNX.4.64.0811201640570.11673@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0811201640570.11673@t2.domain.actdsltmp>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu 2008-11-20 17:05:56, Trent Piepho wrote:
> On Mon, 17 Nov 2008, Richard Purdie wrote:
> > On Fri, 2008-10-24 at 16:09 -0700, Trent Piepho wrote:
> >> +	if (template->keep_state)
> >> +		state = !!gpio_get_value(led_dat->gpio) ^ led_dat->active_low;
> >> +	else
> >> +		state = template->default_state;
> >>
> >>  		state = of_get_property(child, "default-state", NULL);
> >>  		led.default_state = state && !strcmp(state, "on");
> >> +		led.keep_state = state && !strcmp(state, "keep");
> >>
> >> +++ b/include/linux/leds.h
> >> @@ -138,7 +138,8 @@ struct gpio_led {
> >>  	const char *default_trigger;
> >>  	unsigned 	gpio;
> >>  	u8 		active_low;
> >> -	u8		default_state;
> >> +	u8		default_state;	/* 0 = off, 1 = on */
> >> +	u8		keep_state; /* overrides default_state */
> >>  };
> >
> > How about something simpler here, just make default state have three
> > different values - "keep", "on" and "off"? I'm not keen on having two
> > different state variables like this.
> 
> I thought of that, but it ends up being more complex.  Instead of just
> using:
> static const struct gpio_led myled = {
>  	.name = "something",
>  	.keep_state = 1,
> }
> 
> You'd do something like this:
>  	.default_state = LEDS_GPIO_DEFSTATE_KEEP,
> 
> Is that better?

Yes.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

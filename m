Return-Path: <xyzzy@speakeasy.org>
Received: from mail6.sea5.speakeasy.net (mail6.sea5.speakeasy.net
	[69.17.117.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.speakeasy.net", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE31DDDFEB
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 04:54:34 +1000 (EST)
Date: Wed, 13 May 2009 11:54:28 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] leds: Add options to have GPIO LEDs start on or keep
	their state
In-Reply-To: <20090513091330.GA3078@pengutronix.de>
Message-ID: <Pine.LNX.4.58.0905131148120.7837@shell2.speakeasy.net>
References: <fa686aa40904172207sc0f923eoefe8fb0a2703d548@mail.gmail.com>
	<1242167592-14649-1-git-send-email-xyzzy@speakeasy.org>
	<20090513091330.GA3078@pengutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Richard Purdie <rpurdie@rpsys.net>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 13 May 2009, Wolfram Sang wrote:
> > diff --git a/include/linux/leds.h b/include/linux/leds.h
> > index 376fe07..66e7d75 100644
> > --- a/include/linux/leds.h
> > +++ b/include/linux/leds.h
> > @@ -141,9 +141,14 @@ struct gpio_led {
> >  	const char *name;
> >  	const char *default_trigger;
> >  	unsigned 	gpio;
> > -	u8 		active_low : 1;
> > -	u8		retain_state_suspended : 1;
> > +	unsigned	active_low : 1;
> > +	unsigned	retain_state_suspended : 1;
> > +	unsigned	default_state : 2;
> > +	/* default_state should be one of LEDS_GPIO_DEFSTATE_(ON|OFF|KEEP) */
>
> Any specific reason for the change from u8 to unsigned? Could be
> mentioned in the patch description maybe. And what Sean mentioned :)

I should have mentioned that in the description.  It didn't make sense to
me to declare a bit field with u8.  An eight bit type that is one bit
wide?  The field width overrides the type width, but I think it's better to
just use "unsigned" and only specify a width once.

>
> Other than that:
>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
>
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>

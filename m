Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id DFB96DE02D
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 05:49:07 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so750400anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 11:49:06 -0700 (PDT)
Message-ID: <fa686aa40803251149i605b3fe0u95c630e9bdc54318@mail.gmail.com>
Date: Tue, 25 Mar 2008 12:49:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Bartlomiej Sieka" <tur@semihalf.com>
Subject: Re: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <47E92D60.6090008@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>
	<20080317222836.AFA66241A2@gemini.denx.de>
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
	<47DF7D6F.8010808@semihalf.com>
	<fa686aa40803180747u532f6a0bq1e64e01662bdb6bd@mail.gmail.com>
	<1205858510.7500.35.camel@dax.rpnet.com>
	<fa686aa40803180953v7b704cf4g484324ef6fc8f523@mail.gmail.com>
	<47E92D60.6090008@semihalf.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Richard Purdie <rpurdie@rpsys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 25, 2008 at 10:50 AM, Bartlomiej Sieka <tur@semihalf.com> wrote:
> Grant Likely wrote:
>  > On Tue, Mar 18, 2008 at 10:41 AM, Richard Purdie <rpurdie@rpsys.net> wrote:
>  >>  On Tue, 2008-03-18 at 08:47 -0600, Grant Likely wrote:
>  >>  I don't mind having a specific driver but I don't know anything about
>  >>  the hardware its creating the interface for so I need the community's
>  >>  help with that part. There is drivers/leds/leds-gpio.c if that would
>  >>  work better.
>  >
>  > Yes, I think that would be the right approach.  We would need to add
>  > the binding code to translate from the OF device tree to the leds-gpio
>  > driver.
>
>  I think that leds-gpio.c is a good solution for long-term. Note however,
>  that having the LED-to-GPIO pin mapping defined in the OF device
>  tree is problematic for targets that don't use a device tree, and for a
>  generic driver like leds-gpio.c some other mechanisms should probably be
>  used.

Something to consider:  The device tree is all about describing
hardware and binding it to the driver.  Nothing more.  So; there will
always be glue code to extract the config from the tree and tell the
leds-gpio driver about it (the binding); but once that is done the
driver isn't any different.  I've got several drivers with both
platform bus and of_platform bus bindings where most of the driver is
shared.  Only the bit of code that extracts the configuration from
either pdata or the device tree is bus specific.

>
>  Going back to LEDs on Motion-PRO, using leds-gpio.c for this target
>  won't be achieved quickly. leds-gpio.c uses generic GPIO access
>  routines, which are not implemented for powerpc in general, and MPC5200
>  in particular. One would have to add support for MPC5200 to GPIO LIB
>  API, and implement the above mentioned LED-to-GPIO pin mapping in
>  leds-gpio.c, and then convert Motion-PRO.
>
>  Since both you and Richard don't have objections against a specific
>  driver, and switching Motion-PRO to a generic approach requires quite a
>  bit of work -- then how about we provide a patch that addresses
>  Richard's comments, and have the Motion-PRO LED support merged upstream
>  as a specific driver?

Yes, I'm totally cool with that.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

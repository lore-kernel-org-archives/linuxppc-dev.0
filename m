Return-Path: <rpurdie@rpsys.net>
Received: from tim.rpsys.net (tim.rpsys.net [194.106.48.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 736C4DE286
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 03:42:02 +1100 (EST)
Subject: Re: Please pull linux-2.6-mpc52xx.git
From: Richard Purdie <rpurdie@rpsys.net>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40803180747u532f6a0bq1e64e01662bdb6bd@mail.gmail.com>
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>
	<20080317222836.AFA66241A2@gemini.denx.de>
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
	<47DF7D6F.8010808@semihalf.com>
	<fa686aa40803180747u532f6a0bq1e64e01662bdb6bd@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 18 Mar 2008 16:41:50 +0000
Message-Id: <1205858510.7500.35.camel@dax.rpnet.com>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-03-18 at 08:47 -0600, Grant Likely wrote:
> On Tue, Mar 18, 2008 at 2:29 AM, Bartlomiej Sieka <tur@semihalf.com> wrote:
> >  Grant,
> >
> >  Yes, the Motion-PRO LED driver has been reworked and posted:
> >  http://patchwork.ozlabs.org/linuxppc/patch?q=Motion-pro&id=16617
>
> Okay, I've taken another look at the driver and I've figured out what
> has been bothering me about it.  It seems to me that the motion pro
> led driver is just the first of many that we will see (seeing as some
> many people find the blinking lights rather soothing) and it's a non
> trivial amount of code.
> 
> (Note: I'm not actually opposed to this driver if Richard is okay with
> it; but I do think that in the long term we should move towards a more
> generic approach)
> 
> In essence, this driver sets up two GPIO pins to drive LEDs.  A pretty
> common approach for putting LEDs on a board.  In this case each GPIO
> bank only contains 1 pin; but I imagine that on other boards there
> will be multiple pins in a GPIO bank, only some of which actually used
> for blinking LEDs.
> 
> I've started thinking that it would be better to split things up in
> the device tree to have one node for each GPIO block and a single LED
> node that maps LEDs to gpio pins.  That would allow a common driver to
> be written for all GPIO driven LEDs with a single block of device tree
> parsing code.  Plus, it allows other devices to use GPIO pins within
> the same block (not an issue for the motion pro board; but when other
> boards start coming on-line it would allow us to reduce the amount of
> board specific code).  Finally, it means that the timer pin GPIO
> driver can be used for more than just flashing an attached LED.

I don't mind having a specific driver but I don't know anything about
the hardware its creating the interface for so I need the community's
help with that part. There is drivers/leds/leds-gpio.c if that would
work better.

Regards,

Richard

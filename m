Return-Path: <rpurdie@rpsys.net>
Received: from tim.rpsys.net (tim.rpsys.net [194.106.48.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57E33DDE32
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 21:22:53 +1100 (EST)
Subject: Re: Please pull linux-2.6-mpc52xx.git
From: Richard Purdie <rpurdie@rpsys.net>
To: Bartlomiej Sieka <tur@semihalf.com>
In-Reply-To: <47DF7D6F.8010808@semihalf.com>
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>
	<20080317222836.AFA66241A2@gemini.denx.de>
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
	<47DF7D6F.8010808@semihalf.com>
Content-Type: text/plain
Date: Tue, 18 Mar 2008 10:04:26 +0000
Message-Id: <1205834666.7500.27.camel@dax.rpnet.com>
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

On Tue, 2008-03-18 at 09:29 +0100, Bartlomiej Sieka wrote:
> Grant Likely wrote:
> > The LED code just hasn't been picked up.  IIRC, it was reworked to
> > make it a proper driver in drivers/leds. 
>
> Yes, the Motion-PRO LED driver has been reworked and posted:
> http://patchwork.ozlabs.org/linuxppc/patch?q=Motion-pro&id=16617
> 
>  > I need to look at it again,
> > but it is a lot of code for a very simple thing and I wasn't sure if I
> > should be the one to pick it up because it is in drivers/leds which
> > has a different maintainer.
> 
> I'm copying Richard Purdie who's listed as LED SUBSYSTEM maintainer.
> 
> Richard -- could pick up the above mentioned Motion-PRO LED driver for
> upstream inclusion? It started as a MPC5200-specific thing posted to
> linuxppc-dev and got reviewed there, with the intent to go upstream via
> Grant (MPC52XX maintainer). However, it seems that it should be merged
> through your subsystem.

There are some tweaks this driver needs before it can be merged.

Firstly, it seems to re implement a timer to make the LED blink and I'm
not keen on doing that. I notice that you have default_trigger = "timer"
but that won't make it activate at boot which is probably why the other
code exists? I will accept a patch which allows the default timer state
to be configurable (either from the defconfig or from the commandline)
which should solve your problem?

Secondly, can you confirm what of_get_property(op->node, "label", NULL);
returns and whether this conforms to the LED naming guidelines?

Cheers,

Richard

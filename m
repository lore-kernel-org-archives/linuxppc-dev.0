Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-231-monday.dmz.nerim.net
	[195.5.254.231]) by ozlabs.org (Postfix) with ESMTP id E01FEDDEC1
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 04:45:59 +1000 (EST)
Received: from kraid.nerim.net (smtp-101-monday.nerim.net [62.4.16.101])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id E67E125CF7
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 20:13:31 +0200 (CEST)
Date: Mon, 17 Sep 2007 20:16:30 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] i2c: devtree-aware iic support for PPC4xx
Message-ID: <20070917201630.6924ca1c@hyperion.delvare>
In-Reply-To: <200709170734.09079.sr@denx.de>
References: <200709161352.03459.sr@denx.de>
	<20070916185330.GA32314@gate.ebshome.net>
	<200709170734.09079.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stefan,

On Mon, 17 Sep 2007 07:34:08 +0200, Stefan Roese wrote:
> On Sunday 16 September 2007, Eugene Surovegin wrote:
> > Hmm, I just noticed that you basically added a copy of existing
> > driver with small changes to support OF while keeping OCP one.
> >
> > Why not just add OF support to the existing code (under some ifdef),
> > and then remove OCP support as soon as ppc -> powerpc transition is
> > finished? Why have two almost identical code in the tree?
> 
> My understanding was, that adding many #ifdef's into the code was not the 
> preferred way. I could of course change this patch to not add an additional 
> driver but extend the existing driver with a bunch of #ifdef's to support 
> both versions.
> 
> This approach of multiple drivers seems to be common in the kernel right now:
> 
> drivers/mtd/maps/physmap.c
> drivers/mtd/maps/physmap_of.c
> 
> or
> 
> drivers/usb/host/ohci-ppc-soc.c
> drivers/usb/host/ohci-ppc-of.c
> 
> Any other opinions on this? How should this be handled to get accepted 
> upstream? Two different drivers with removing the "old" one later when 
> arch/ppc is gone, or one driver which supports both versions and removing the 
> ocp support in this driver later?

I'd prefer a single driver with ifdef's. Only the registration and
cleanup parts should be different, the actual I2C bus driving code
should be pretty much the same. With some efforts it should be possible
to reduce the ifdef clutter to a minimum.

> (...)
> The "old" name "i2c-ibm_iic" is kind of redundant. Nearly all bus drivers are 
> named "i2c-platform". Perhaps a better name would be "i2c-ppc4xx" then.

Agreed. But that being said, changing the name now while the old name
has been used for years might cause more trouble than it solves.

-- 
Jean Delvare

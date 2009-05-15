Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2BDFDE0DB
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 01:36:40 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4FFaKSu029335
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 08:36:30 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4FFaJ3j010560
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 10:36:19 -0500 (CDT)
Date: Fri, 15 May 2009 10:36:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] [PowerPC] MPC8272ADS: fix device tree for 8 MB flash, size
Message-ID: <20090515153619.GA24872@b07421-ec1.am.freescale.net>
References: <mailman.7754.1242158509.26545.linuxppc-dev@ozlabs.org>
	<4A0A683B.5010209@denx.de>
	<20090514214819.GA15549@b07421-ec1.am.freescale.net>
	<4A0D03AB.2040602@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A0D03AB.2040602@denx.de>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 15, 2009 at 07:54:51AM +0200, Heiko Schocher wrote:
> Scott Wood wrote:
> > We should proabbly leave out the ranges altogether, and have u-boot
> > populate it from the mappings it establishes.
> 
> No, I vote for manipulating just the entries, which u-boot dynamically
> detect, and let the other entries untouched. It is possible that
> there is a device which u-boot didn;t use/know, and there is in the DTS
> an ranges entry for it (Maybe not on the MPC8727ADS, but we should
> define a rule, how a bootloader has to manipulate entries). So if
> u-boot build the complete ranges entry, it maybe miss something.

If u-boot doesn't know about it, then it didn't create the mapping, and
thus it's not accessible (if something later on creates a mapping, it can
update ranges itself).  The devices themselves would still be described,
just not the non-existent mapping.

The benefit is that you would have just one place that reads out the
localbus config into the device tree, with no error-prone duplication of
data, or separate hacks for each board that has something that is
variable.

We could leave ranges in the dts for cuImage, and have u-boot just
overwrite the entire thing rather than patch up individual entries.

> > I don't see how current u-boot would accomodate more than 8MiB flash on
> > this board (there's some detection in board/freescale/mpc8260ads/flash.c,
> 
> Didn;t this board uses the CFI driver? :-(

Not yet, unfortunately.  This is pretty old code.

-Scott

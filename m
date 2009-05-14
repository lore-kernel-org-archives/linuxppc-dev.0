Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 04EB6DE01F
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 07:48:24 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4ELmKlW017236
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 14:48:21 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n4ELmJpd015146
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 16:48:20 -0500 (CDT)
Date: Thu, 14 May 2009 16:48:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] [PowerPC] MPC8272ADS: fix device tree for 8 MB flash, size
Message-ID: <20090514214819.GA15549@b07421-ec1.am.freescale.net>
References: <mailman.7754.1242158509.26545.linuxppc-dev@ozlabs.org>
	<4A0A683B.5010209@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A0A683B.5010209@denx.de>
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

On Wed, May 13, 2009 at 08:27:07AM +0200, Heiko Schocher wrote:
> Hello Wolfgang,
> 
> > The current device tree for the MPC8272ADS assumes a mapping of 32 MB
> > of NOR flash at 0xFE00.0000, while there are actually only 8 MB on
> > the boards, mapped at 0xFF80.0000. When booting an uImage with such a
> > device tree, the kernel crashes because 0xFE00.0000 is not mapped.
> 
> Wouldn;t it be better, if u-boot fixes the device tree entries?

We should proabbly leave out the ranges altogether, and have u-boot
populate it from the mappings it establishes.

> I think, u-boot should know, where the flash begins and ends, and
> because this is maybe a dynamic variable for this board, it should
> be better, if u-boot fixes this, so no need for adding a device tree
> for every board variant.

Flash is on a SIMM on this board, and the board manual says it's
expandable to 32 MiB.  However, I suspect that the current DTS was just
an error as I based it on a board that had not had its flash SIMM
modified.  That specific flash SIMM is no longer working (or perhaps just
got its contents corrupted -- one of these days I may hook up a BDI and
try to reflash), so I can't go back and check.

I don't see how current u-boot would accomodate more than 8MiB flash on
this board (there's some detection in board/freescale/mpc8260ads/flash.c,
but I don't see any setting of BR0 besides the preliminary value at
0xff800000).

-Scott

Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7F9F12C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 04:41:36 +1000 (EST)
Date: Thu, 8 Aug 2013 20:41:20 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v4 00/31] add COMMON_CLK support for PowerPC MPC512x
Message-ID: <20130808184036.GY2580@book.gsilab.sittig.org>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <BF555A06-59CD-4697-927E-04657E6F1DB1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BF555A06-59CD-4697-927E-04657E6F1DB1@kernel.crashing.org>
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>,
 Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 07, 2013 at 10:40 -0500, Kumar Gala wrote:
> 
> On Aug 6, 2013, at 3:43 PM, Gerhard Sittig wrote:
> 
> > this series
> > - fixes several drivers that are used in the MPC512x platform (UART,
> > SPI, ethernet, PCI, USB, CAN, NAND flash, video capture) in how they
> > handle clocks (appropriately acquire and setup them, hold references
> > during use, release clocks after use)
> > - introduces support for the common clock framework (CCF, COMMON_CLK
> > Kconfig option) in the PowerPC based MPC512x platform, which brings
> > device tree based clock lookup as well
> > 
> > although the series does touch several subsystems -- tty (serial), spi,
> > net (can, fs_enet), mtd (nfc), usb, i2c, media (viu), and dts -- all of
> > the patches are strictly clock related or trivial
> > 
> > it appears most appropriate to take this series through either the clk
> > or the powerpc trees after it has passed review and other subsystem
> > maintainers ACKed the clock setup related driver modifications
> > 
> > the series passes 'checkpatch.pl --strict' except for one warning which
> > cannot get resolved, since that either breaks compilation (the data type
> > is preset by the clk-provider.h API) or requires a cast which shadows
> > real mismatches:
> > 
> > WARNING: static const char * array should probably be static const char * const
> > #431: FILE: arch/powerpc/platforms/512x/clock-commonclk.c:334:
> > +static const char *parent_names_mux0[] = {
> > 
> > total: 0 errors, 1 warnings, 0 checks, 807 lines checked
> > 
> > each step in the series was build and run tested (with a display that is
> > attached to the DIU as well as SPI, with an SPI attached NOR flash, with
> > multiple UART ports such that one is not the boot console, with EEPROMs
> > attached to I2C, with an SD card, booting from network)
> > 
> 
> How do the driver changes impact other PPC SoCs that use the
> same drivers (i2c, fs_enet, usb) ?

For SPI and UART (the PSC component), the hardware is shared
between MPC512x and MPC5200, but only routines and data specific
to MPC512x get changed.

For USB the "fsl.*usb2" hardware appears to be shared among
Freescale SoCs.  AFAICS i.MX has a separate driver under arm/,
MPC83xx has a separate driver under arch/powerpc/platforms/83xx/,
and the driver I'm touching is only changed in routines specific
to MPC512x.

The NAND and VIU drivers only attach to hardware on the MPC512x
platform (checked the compatible string, only referenced from the
mpc5121.dtsi).

I2C, ethernet, PCI all are similar:  A non-fatal clock lookup is
introduced, CCF platforms (512x only ATM) will carry out
appropriate clock operations, non-CCF platforms won't see a
change in behaviour (lookup fails which isn't fatal, and the
drivers assume that somebody else will have taken care of clocks
for them).

MSCAN is shared among 512x and 52xx, the common code introduces
transparent yet optional support for CCF, the 512x code path
makes use of it, 52xx sees no change in behaviour.

The DIU component (display output) is shared among platforms, but
only the platform initialization in the MPC512x code path gets
changed to make use of the CCF support, while no other platform
sees any change.

The MPC512x common clock core driver does use common primitives
and redirects the register access primitives.  But the series
doesn't change register access for ARM (static inline call to the
previous hardcoded routine and thus identical object code), and
doesn't modify nor extend the shared code for gates, dividers and
multiplexers.

The device tree changes only apply to MPC512x, and only provide
hardware related information that formerly was missing.


To summarize, I see no impact for other architectures or
platforms.  Although it would be good to get a second opinion
from persons with USB knowledge, to make sure I haven't missed
something.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de

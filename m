Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 87E3C2C0242
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 02:13:26 +1000 (EST)
Subject: Re: [PATCH v4 00/31] add COMMON_CLK support for PowerPC MPC512x
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
Date: Wed, 7 Aug 2013 10:40:24 -0500
Message-Id: <BF555A06-59CD-4697-927E-04657E6F1DB1@kernel.crashing.org>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
To: Gerhard Sittig <gsi@denx.de>
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


On Aug 6, 2013, at 3:43 PM, Gerhard Sittig wrote:

> this series
> - fixes several drivers that are used in the MPC512x platform (UART,
> SPI, ethernet, PCI, USB, CAN, NAND flash, video capture) in how they
> handle clocks (appropriately acquire and setup them, hold references
> during use, release clocks after use)
> - introduces support for the common clock framework (CCF, COMMON_CLK
> Kconfig option) in the PowerPC based MPC512x platform, which brings
> device tree based clock lookup as well
>=20
> although the series does touch several subsystems -- tty (serial), =
spi,
> net (can, fs_enet), mtd (nfc), usb, i2c, media (viu), and dts -- all =
of
> the patches are strictly clock related or trivial
>=20
> it appears most appropriate to take this series through either the clk
> or the powerpc trees after it has passed review and other subsystem
> maintainers ACKed the clock setup related driver modifications
>=20
> the series passes 'checkpatch.pl --strict' except for one warning =
which
> cannot get resolved, since that either breaks compilation (the data =
type
> is preset by the clk-provider.h API) or requires a cast which shadows
> real mismatches:
>=20
> WARNING: static const char * array should probably be static const =
char * const
> #431: FILE: arch/powerpc/platforms/512x/clock-commonclk.c:334:
> +static const char *parent_names_mux0[] =3D {
>=20
> total: 0 errors, 1 warnings, 0 checks, 807 lines checked
>=20
> each step in the series was build and run tested (with a display that =
is
> attached to the DIU as well as SPI, with an SPI attached NOR flash, =
with
> multiple UART ports such that one is not the boot console, with =
EEPROMs
> attached to I2C, with an SD card, booting from network)
>=20

How do the driver changes impact other PPC SoCs that use the same =
drivers (i2c, fs_enet, usb) ?

- k=

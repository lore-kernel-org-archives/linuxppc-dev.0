Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0155.outbound.protection.outlook.com [207.46.163.155])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 967452C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 09:37:25 +1100 (EST)
Message-ID: <1390257432.24905.329.camel@snotra.buserror.net>
Subject: Re: [PATCH RFC] powerpc/mpc85xx: add support for the kmp204x
 reference board
From: Scott Wood <scottwood@freescale.com>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Date: Mon, 20 Jan 2014 16:37:12 -0600
In-Reply-To: <52DD50F7.1050107@keymile.com>
References: <1389879525-27130-1-git-send-email-valentin.longchamp@keymile.com>
 <1389915301.24905.240.camel@snotra.buserror.net>
 <52D9273E.10008@keymile.com>
 <1389995322.24905.275.camel@snotra.buserror.net>
 <52DD50F7.1050107@keymile.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-01-20 at 17:38 +0100, Valentin Longchamp wrote:
> On 01/17/2014 10:48 PM, Scott Wood wrote:
> > On Fri, 2014-01-17 at 13:51 +0100, Valentin Longchamp wrote:
> >> Hi Scott,
> >>
> >> Thanks for you feedback.
> >>
> >> On 01/17/2014 12:35 AM, Scott Wood wrote:
> >>> On Thu, 2014-01-16 at 14:38 +0100, Valentin Longchamp wrote:
> >>>> This patch introduces the support for Keymile's kmp204x reference
> >>>> design. This design is based on Freescale's P2040/P2041 SoC.
> >>>>
> >>>> The peripherals used by this design are:
> >>>> - SPI NOR Flash as bootloader medium
> >>>> - NAND Flash with a ubi partition
> >>>> - 2 PCIe busses (hosts 1 and 3)
> >>>> - 3 FMAN Ethernet devices (FMAN1 DTSEC1/2/5)
> >>>> - 4 Local Bus windows, with one dedicated to the QRIO reset/power mgmt
> >>>>   FPGA
> >>>> - 2 HW I2C busses
> >>>> - last but not least, the mandatory serial port
> >>>>
> >>>> The patch also adds a defconfig file for this reference design and a DTS
> >>>> file for the kmcoge4 board which is the first one based on this
> >>>> reference design.
> >>>>
> >>>> To try to avoid code duplication, the support was added directly to the
> >>>> corenet_generic.c file.
> >>>>
> >>>> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> >>>> ---
> >>>>  arch/powerpc/boot/dts/kmcoge4.dts             | 165 ++++++++++++++++++
> >>>>  arch/powerpc/configs/85xx/kmp204x_defconfig   | 231 ++++++++++++++++++++++++++
> >>>>  arch/powerpc/platforms/85xx/Kconfig           |  14 ++
> >>>>  arch/powerpc/platforms/85xx/Makefile          |   1 +
> >>>>  arch/powerpc/platforms/85xx/corenet_generic.c |  52 ++++++
> >>>>  5 files changed, 463 insertions(+)
> >>>>  create mode 100644 arch/powerpc/boot/dts/kmcoge4.dts
> >>>>  create mode 100644 arch/powerpc/configs/85xx/kmp204x_defconfig
> >>>>
> >>>> diff --git a/arch/powerpc/boot/dts/kmcoge4.dts b/arch/powerpc/boot/dts/kmcoge4.dts
> >>>> new file mode 100644
> >>>> index 0000000..c10df6d
> >>>> --- /dev/null
> >>>> +++ b/arch/powerpc/boot/dts/kmcoge4.dts
> >>>> @@ -0,0 +1,165 @@
> >>>> +/*
> >>>> + * Keymile kmcoge4 Device Tree Source, based on the P2041RDB DTS
> >>>> + *
> >>>> + * (C) Copyright 2014
> >>>> + * Valentin Longchamp, Keymile AG, valentin.longchamp@keymile.com
> >>>> + *
> >>>> + * Copyright 2011 Freescale Semiconductor Inc.
> >>>> + *
> >>>> + * This program is free software; you can redistribute  it and/or modify it
> >>>> + * under  the terms of  the GNU General  Public License as published by the
> >>>> + * Free Software Foundation;  either version 2 of the  License, or (at your
> >>>> + * option) any later version.
> >>>> + */
> >>>> +
> >>>> +/include/ "fsl/p2041si-pre.dtsi"
> >>>> +
> >>>> +/ {
> >>>> +	model = "keymile,kmcoge4";
> >>>> +	compatible = "keymile,kmp204x";
> >>>
> >>> Don't put wildcards in compatible.
> >>
> >> Well it's a wildcard in the sense that we support both the p2040 and the p2041,
> >> but it's also the name of the plaftorm, similarly to names like '85xx' or 'tqm85xx'.
> > 
> > Names like 85xx are not allowed in device trees.
> > 
> > With "p204x", what would happen if a p2042 were introduced, that were
> > not compatible?
> 
> What would you suggest as a generic name for the architecture that supports both ?
> 
> > 
> > Why isn't the compatible "keymile,kmcoge4", like the model?
> 
> Because kmcoge4 is the board that is based on the kmp204x architecture/design.
> We expect other boards (kmcoge7 for instance) based on the same kmp204x design.

The top-level compatible isn't for the "architecture" or the "design".
It's for the board.  Surely there's something different about kmcoge7
versus kmcoge4 -- is it visible to software?

> You would prefer that I have the model and compatible stricly the same and add
> any future board into the compatible boards[] from corenet_generic ?

That's how it's usually done.  Or, at least provide the board
architecture name as a secondary compatible after the board name.

> If possible I would like to be able to see the boards that are based on a
> similar design, that's what I wanted to achieve with this kmp204x name.

Is "kmp204x" an official name of the architecture, rather than a
generalization of "kmp2040" and "kmp2041"?  If there were a p2042, and
you made a board for it, is there any chance it would be called kmp204x
even if it were very different from the p2040/p2041 board?

> >>>> +			zl30343@1 {
> >>>> +				compatible = "gen,spidev";
> >>>
> >>> Node names are supposed to be generic.  Compatibles are supposed to be
> >>> specific.
> >>
> >> That's a very specific device for which we only have a userspace driver and for
> >> which we must use the generic kernel spidev driver.
> > 
> > The device tree describes the hardware, not what driver you want to use.
> > 
> > Plus, I don't see any driver that matches "gen,spidev" nor any binding
> > for it, and "gen" doesn't make sense as a vendor prefix.  The only
> > instance of that string I can find in the Linux tree is in mgcoge.dts.
> 
> Well it comes from mgcoge and that's why I have used this
> 
> It's for usage with the spidev driver (driver/spi/spidev.c). I agree that the
> gen brings nothing. Would
> 
> spidev@1 {
> 	compatible = "spidev";
> 
> make more sense ?

It doesn't address any of the other comments.

> >>>> +	lbc: localbus@ffe124000 {
> >>>> +		reg = <0xf 0xfe124000 0 0x1000>;
> >>>> +		ranges = <0 0 0xf 0xffa00000 0x00040000		/* LB 0 */
> >>>> +			  1 0 0xf 0xfb000000 0x00010000		/* LB 1 */
> >>>> +			  2 0 0xf 0xd0000000 0x10000000		/* LB 2 */
> >>>> +			  3 0 0xf 0xe0000000 0x10000000>;	/* LB 3 */
> >>>> +
> >>>> +		nand@0,0 {
> >>>> +			#address-cells = <1>;
> >>>> +			#size-cells = <1>;
> >>>> +			compatible = "fsl,elbc-fcm-nand";
> >>>> +			reg = <0 0 0x40000>;
> >>>> +
> >>>> +			partition@0 {
> >>>> +				label = "ubi0";
> >>>> +				reg = <0x0 0x8000000>;
> >>>> +			};
> >>>> +		};
> >>>> +	};
> >>>
> >>> No nodes for those other chipselects?
> >>
> >> Well, there are nodes, but they are internally developed FPGAs and the drivers
> >> are not mainlined that's why I removed the nodes.
> > 
> > The device tree describes the hardware, not what drivers are currently
> > mainlined in Linux.
> 
> What do you want me to do: add the nodes for which there are no bindings ?

No, ideally you'd add bindings and nodes.  I'm not going to insist on it
if bindings aren't ready, but please don't leave things out only because
there's no driver.

> I did this similarly to the situation with the FSL .dtsi that currently in
> mainline do not include the DPAA/QMAN/BMAN nodes.

What we've done with DPAA doesn't make a very good role model,
unfortunately.
 
-Scott

Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3CC642C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 08:48:54 +1100 (EST)
Message-ID: <1389995322.24905.275.camel@snotra.buserror.net>
Subject: Re: [PATCH RFC] powerpc/mpc85xx: add support for the kmp204x
 reference board
From: Scott Wood <scottwood@freescale.com>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Date: Fri, 17 Jan 2014 15:48:42 -0600
In-Reply-To: <52D9273E.10008@keymile.com>
References: <1389879525-27130-1-git-send-email-valentin.longchamp@keymile.com>
 <1389915301.24905.240.camel@snotra.buserror.net>
 <52D9273E.10008@keymile.com>
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

On Fri, 2014-01-17 at 13:51 +0100, Valentin Longchamp wrote:
> Hi Scott,
> 
> Thanks for you feedback.
> 
> On 01/17/2014 12:35 AM, Scott Wood wrote:
> > On Thu, 2014-01-16 at 14:38 +0100, Valentin Longchamp wrote:
> >> This patch introduces the support for Keymile's kmp204x reference
> >> design. This design is based on Freescale's P2040/P2041 SoC.
> >>
> >> The peripherals used by this design are:
> >> - SPI NOR Flash as bootloader medium
> >> - NAND Flash with a ubi partition
> >> - 2 PCIe busses (hosts 1 and 3)
> >> - 3 FMAN Ethernet devices (FMAN1 DTSEC1/2/5)
> >> - 4 Local Bus windows, with one dedicated to the QRIO reset/power mgmt
> >>   FPGA
> >> - 2 HW I2C busses
> >> - last but not least, the mandatory serial port
> >>
> >> The patch also adds a defconfig file for this reference design and a DTS
> >> file for the kmcoge4 board which is the first one based on this
> >> reference design.
> >>
> >> To try to avoid code duplication, the support was added directly to the
> >> corenet_generic.c file.
> >>
> >> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> >> ---
> >>  arch/powerpc/boot/dts/kmcoge4.dts             | 165 ++++++++++++++++++
> >>  arch/powerpc/configs/85xx/kmp204x_defconfig   | 231 ++++++++++++++++++++++++++
> >>  arch/powerpc/platforms/85xx/Kconfig           |  14 ++
> >>  arch/powerpc/platforms/85xx/Makefile          |   1 +
> >>  arch/powerpc/platforms/85xx/corenet_generic.c |  52 ++++++
> >>  5 files changed, 463 insertions(+)
> >>  create mode 100644 arch/powerpc/boot/dts/kmcoge4.dts
> >>  create mode 100644 arch/powerpc/configs/85xx/kmp204x_defconfig
> >>
> >> diff --git a/arch/powerpc/boot/dts/kmcoge4.dts b/arch/powerpc/boot/dts/kmcoge4.dts
> >> new file mode 100644
> >> index 0000000..c10df6d
> >> --- /dev/null
> >> +++ b/arch/powerpc/boot/dts/kmcoge4.dts
> >> @@ -0,0 +1,165 @@
> >> +/*
> >> + * Keymile kmcoge4 Device Tree Source, based on the P2041RDB DTS
> >> + *
> >> + * (C) Copyright 2014
> >> + * Valentin Longchamp, Keymile AG, valentin.longchamp@keymile.com
> >> + *
> >> + * Copyright 2011 Freescale Semiconductor Inc.
> >> + *
> >> + * This program is free software; you can redistribute  it and/or modify it
> >> + * under  the terms of  the GNU General  Public License as published by the
> >> + * Free Software Foundation;  either version 2 of the  License, or (at your
> >> + * option) any later version.
> >> + */
> >> +
> >> +/include/ "fsl/p2041si-pre.dtsi"
> >> +
> >> +/ {
> >> +	model = "keymile,kmcoge4";
> >> +	compatible = "keymile,kmp204x";
> > 
> > Don't put wildcards in compatible.
> 
> Well it's a wildcard in the sense that we support both the p2040 and the p2041,
> but it's also the name of the plaftorm, similarly to names like '85xx' or 'tqm85xx'.

Names like 85xx are not allowed in device trees.

With "p204x", what would happen if a p2042 were introduced, that were
not compatible?

Why isn't the compatible "keymile,kmcoge4", like the model?

> > I realize it's common practice, but it would be good to get away from
> > putting partition layouts in the dts file.  Alternatives include using
> > mtdparts on the command line, or having U-Boot put the partition info
> > into the dtb based on the mtdparts environment variable (there is
> > existing code for this).
> 
> I agree that u-boot also has to know about the addresses because it also
> accesses these partitions.
> 
> But I think it is clearer to have this in the device tree: I try to keep the
> kernel command line small and I don't like having u-boot "fixing" the dtb at
> runtime.

The problem is that the dts source is often far removed from the actual
programming of flash, and the partitioning can vary based on use case,
or change for other reasons (e.g. there have been requests to change
existing partition layouts to accommodate growth in U-Boot size).

Ideally it wouldn't be in the device tree at all, but having U-Boot fix
it up based on an environment variable is better than statically
defining it in a file in the Linux tree.

> >> +			zl30343@1 {
> >> +				compatible = "gen,spidev";
> > 
> > Node names are supposed to be generic.  Compatibles are supposed to be
> > specific.
> 
> That's a very specific device for which we only have a userspace driver and for
> which we must use the generic kernel spidev driver.

The device tree describes the hardware, not what driver you want to use.

Plus, I don't see any driver that matches "gen,spidev" nor any binding
for it, and "gen" doesn't make sense as a vendor prefix.  The only
instance of that string I can find in the Linux tree is in mgcoge.dts.

> >  That's why the node name is
> > so specific and the compatible field very generic.

Userspace can't search for a node by compatible?
 
> >> +	lbc: localbus@ffe124000 {
> >> +		reg = <0xf 0xfe124000 0 0x1000>;
> >> +		ranges = <0 0 0xf 0xffa00000 0x00040000		/* LB 0 */
> >> +			  1 0 0xf 0xfb000000 0x00010000		/* LB 1 */
> >> +			  2 0 0xf 0xd0000000 0x10000000		/* LB 2 */
> >> +			  3 0 0xf 0xe0000000 0x10000000>;	/* LB 3 */
> >> +
> >> +		nand@0,0 {
> >> +			#address-cells = <1>;
> >> +			#size-cells = <1>;
> >> +			compatible = "fsl,elbc-fcm-nand";
> >> +			reg = <0 0 0x40000>;
> >> +
> >> +			partition@0 {
> >> +				label = "ubi0";
> >> +				reg = <0x0 0x8000000>;
> >> +			};
> >> +		};
> >> +	};
> > 
> > No nodes for those other chipselects?
> 
> Well, there are nodes, but they are internally developed FPGAs and the drivers
> are not mainlined that's why I removed the nodes.

The device tree describes the hardware, not what drivers are currently
mainlined in Linux.

> >> diff --git a/arch/powerpc/configs/85xx/kmp204x_defconfig b/arch/powerpc/configs/85xx/kmp204x_defconfig
> >> new file mode 100644
> >> index 0000000..3bbf4fa
> >> --- /dev/null
> >> +++ b/arch/powerpc/configs/85xx/kmp204x_defconfig
> > 
> > Why does this board need its own defconfig?
> 
> Apart from the different drivers and FS that we use (or don't use) on the
> system,

That is not generally a good reason for a separate defconfig.  Just
enable the drivers you need in the main defconfig, and don't worry about
the drivers you don't need.  You may want a smaller kernel for actual
shipping products (though the changelog said this is a reference
board...), but in mainline we want a small number of defconfigs that
cover as many boards as possible (or at least, a reasonably small number
and not one per board).

>  the most notable differences are:
> - lowmem must be set to a bigger size so that we can ioremap the the total
> memory requested for all of our PCIe devices
> - CGROUPS is enabled because that's a mandatory feature for our systems
> - NAND_ECC_BCH is enabled because it is used on all of our NAND devices

I don't think there would be a problem adding CGROUPS or NAND_ECC_BCH to
corenet32_smp_defconfig (though CGROUPS seems more like a use-case
configuration than something to do with the board itself).  The lowmem
adjustment is probably a good reason, though I wish things like that
could be specified as a defconfig that #includes corenet32_smp_defconfig
and then just makes a couple changes.
 
> > The whole point of corenet_generic.c is to avoid duplicating all of this
> > stuff.
> > 
> > Can't you just use corenet_generic as-is other than adding the
> > compatible to boards[]?  If not, explain why and put it in a different
> > file.
> > 
> 
> That's a valid point and I have to admit I have hesitated about that. I have
> mostly based my work on the FSL SDK where every single board has a "dedicated" file.
> 
> I agree that I do nothing different than the corenet_generic does and adding my
> platform to the boards[] would be the same and you are right, I should use that
> and avoid code duplication.
> 
> The only thing that would "bother" me is thus the pr_info print from
> *_gen_setup_arch(), it would be nice if somehow we could differentiate it or at
> least make it more generic since the kmp204x boards are not strictly boards from
> Freescale.

Just remove the "from Freescale Semiconductor" part of the string.

-Scott

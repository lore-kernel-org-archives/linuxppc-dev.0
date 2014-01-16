Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0157.outbound.protection.outlook.com [207.46.163.157])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 241472C009A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 10:35:15 +1100 (EST)
Message-ID: <1389915301.24905.240.camel@snotra.buserror.net>
Subject: Re: [PATCH RFC] powerpc/mpc85xx: add support for the kmp204x
 reference board
From: Scott Wood <scottwood@freescale.com>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Date: Thu, 16 Jan 2014 17:35:01 -0600
In-Reply-To: <1389879525-27130-1-git-send-email-valentin.longchamp@keymile.com>
References: <1389879525-27130-1-git-send-email-valentin.longchamp@keymile.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-01-16 at 14:38 +0100, Valentin Longchamp wrote:
> This patch introduces the support for Keymile's kmp204x reference
> design. This design is based on Freescale's P2040/P2041 SoC.
> 
> The peripherals used by this design are:
> - SPI NOR Flash as bootloader medium
> - NAND Flash with a ubi partition
> - 2 PCIe busses (hosts 1 and 3)
> - 3 FMAN Ethernet devices (FMAN1 DTSEC1/2/5)
> - 4 Local Bus windows, with one dedicated to the QRIO reset/power mgmt
>   FPGA
> - 2 HW I2C busses
> - last but not least, the mandatory serial port
> 
> The patch also adds a defconfig file for this reference design and a DTS
> file for the kmcoge4 board which is the first one based on this
> reference design.
> 
> To try to avoid code duplication, the support was added directly to the
> corenet_generic.c file.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> ---
>  arch/powerpc/boot/dts/kmcoge4.dts             | 165 ++++++++++++++++++
>  arch/powerpc/configs/85xx/kmp204x_defconfig   | 231 ++++++++++++++++++++++++++
>  arch/powerpc/platforms/85xx/Kconfig           |  14 ++
>  arch/powerpc/platforms/85xx/Makefile          |   1 +
>  arch/powerpc/platforms/85xx/corenet_generic.c |  52 ++++++
>  5 files changed, 463 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/kmcoge4.dts
>  create mode 100644 arch/powerpc/configs/85xx/kmp204x_defconfig
> 
> diff --git a/arch/powerpc/boot/dts/kmcoge4.dts b/arch/powerpc/boot/dts/kmcoge4.dts
> new file mode 100644
> index 0000000..c10df6d
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/kmcoge4.dts
> @@ -0,0 +1,165 @@
> +/*
> + * Keymile kmcoge4 Device Tree Source, based on the P2041RDB DTS
> + *
> + * (C) Copyright 2014
> + * Valentin Longchamp, Keymile AG, valentin.longchamp@keymile.com
> + *
> + * Copyright 2011 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/include/ "fsl/p2041si-pre.dtsi"
> +
> +/ {
> +	model = "keymile,kmcoge4";
> +	compatible = "keymile,kmp204x";

Don't put wildcards in compatible.

> +	soc: soc@ffe000000 {
> +		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
> +		reg = <0xf 0xfe000000 0 0x00001000>;
> +		spi@110000 {
> +			flash@0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "spansion,s25fl256s1";
> +				reg = <0>;
> +				spi-max-frequency = <20000000>; /* input clock */
> +				partition@u-boot {
> +					label = "u-boot";
> +					reg = <0x00000000 0x00100000>;
> +					read-only;
> +				};
> +				partition@env {
> +					label = "env";
> +					reg = <0x00100000 0x00010000>;
> +				};
> +				partition@envred {
> +					label = "envred";
> +					reg = <0x00110000 0x00010000>;
> +				};
> +				partition@fman {
> +					label = "fman-ucode";
> +					reg = <0x00120000 0x00010000>;
> +					read-only;
> +				};
> +			};

I realize it's common practice, but it would be good to get away from
putting partition layouts in the dts file.  Alternatives include using
mtdparts on the command line, or having U-Boot put the partition info
into the dtb based on the mtdparts environment variable (there is
existing code for this).

> +			zl30343@1 {
> +				compatible = "gen,spidev";

Node names are supposed to be generic.  Compatibles are supposed to be
specific.

> +	lbc: localbus@ffe124000 {
> +		reg = <0xf 0xfe124000 0 0x1000>;
> +		ranges = <0 0 0xf 0xffa00000 0x00040000		/* LB 0 */
> +			  1 0 0xf 0xfb000000 0x00010000		/* LB 1 */
> +			  2 0 0xf 0xd0000000 0x10000000		/* LB 2 */
> +			  3 0 0xf 0xe0000000 0x10000000>;	/* LB 3 */
> +
> +		nand@0,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,elbc-fcm-nand";
> +			reg = <0 0 0x40000>;
> +
> +			partition@0 {
> +				label = "ubi0";
> +				reg = <0x0 0x8000000>;
> +			};
> +		};
> +	};

No nodes for those other chipselects?

> diff --git a/arch/powerpc/configs/85xx/kmp204x_defconfig b/arch/powerpc/configs/85xx/kmp204x_defconfig
> new file mode 100644
> index 0000000..3bbf4fa
> --- /dev/null
> +++ b/arch/powerpc/configs/85xx/kmp204x_defconfig

Why does this board need its own defconfig?

> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> index fbd871e..8e84e1c 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -122,6 +122,7 @@ static const char * const hv_boards[] __initconst = {
>  	NULL
>  };
>  
> +#ifdef CONFIG_CORENET_GENERIC

corenet_generic.c without CONFIG_CORENET_GENERIC?

>  /*
>   * Called very early, device-tree isn't unflattened
>   */
> @@ -180,3 +181,54 @@ machine_arch_initcall(corenet_generic, corenet_gen_publish_devices);
>  #ifdef CONFIG_SWIOTLB
>  machine_arch_initcall(corenet_generic, swiotlb_setup_bus_notifier);
>  #endif
> +#endif
> +
> +#ifdef CONFIG_KMP204X
> +/*
> + * Called very early, device-tree isn't unflattened
> + */
> +static int __init kmp204x_generic_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	return of_flat_dt_is_compatible(root, "keymile,kmp204x");
> +}
> +
> +
> +/*
> + * Setup the architecture
> + */
> +void __init kmp204x_gen_setup_arch(void)
> +{
> +	mpc85xx_smp_init();
> +
> +	swiotlb_detect_4g();
> +
> +	pr_info("%s platform from Keymile\n", ppc_md.name);
> +}
> +
> +define_machine(kmp204x) {
> +	.name			= "kmp204x",
> +	.probe			= kmp204x_generic_probe,
> +	.setup_arch		= kmp204x_gen_setup_arch,
> +	.init_IRQ		= corenet_gen_pic_init,
> +#ifdef CONFIG_PCI
> +	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +#endif
> +	.get_irq		= mpic_get_coreint_irq,
> +	.restart		= fsl_rstcr_restart,
> +	.calibrate_decr		= generic_calibrate_decr,
> +	.progress		= udbg_progress,
> +#ifdef CONFIG_PPC64
> +	.power_save		= book3e_idle,
> +#else
> +	.power_save		= e500_idle,
> +#endif
> +};
> +
> +machine_arch_initcall(kmp204x, corenet_gen_publish_devices);
> +
> +#ifdef CONFIG_SWIOTLB
> +machine_arch_initcall(kmp204x, swiotlb_setup_bus_notifier);
> +#endif
> +#endif

The whole point of corenet_generic.c is to avoid duplicating all of this
stuff.

Can't you just use corenet_generic as-is other than adding the
compatible to boards[]?  If not, explain why and put it in a different
file.

-Scott

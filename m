Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2EAADDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 07:41:00 +1000 (EST)
In-Reply-To: <11909173512321-git-send-email-ljd015@freescale.com>
References: <11909173512321-git-send-email-ljd015@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <64571158-A0C7-489E-8A52-026364AFC055@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add platform support for the MPC837x RDB board
Date: Thu, 27 Sep 2007 16:40:32 -0500
To: ljd015@freescale.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 27, 2007, at 1:22 PM, ljd015@freescale.com wrote:

> From: Joe D'Abbraccio <ljd015@freescale.com>
>
> The MPC837x RDB is a new member of the Freescale MPC83xx reference  
> design
> boards.
>
> Signed-off-by: Joe D'Abbraccio <ljd015@freescale.com>

Please base your patch against an external tree (like my for-2.6.24  
branch).

See comments inline.

- k

> ---
>  arch/powerpc/boot/dts/mpc8377_rdb.dts      |  306 ++++++++++
>  arch/powerpc/boot/dts/mpc8378_rdb.dts      |  286 +++++++++
>  arch/powerpc/boot/dts/mpc8379_rdb.dts      |  281 +++++++++
>  arch/powerpc/configs/mpc837x_rdb_defconfig |  886 +++++++++++++++++ 
> +++++++++++
>  arch/powerpc/platforms/83xx/Kconfig        |    8 +-
>  arch/powerpc/platforms/83xx/Makefile       |    1 +
>  arch/powerpc/platforms/83xx/mpc837x_rdb.c  |  102 ++++
>  7 files changed, 1869 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/mpc8377_rdb.dts
>  create mode 100644 arch/powerpc/boot/dts/mpc8378_rdb.dts
>  create mode 100644 arch/powerpc/boot/dts/mpc8379_rdb.dts
>  create mode 100644 arch/powerpc/configs/mpc837x_rdb_defconfig
>  create mode 100644 arch/powerpc/platforms/83xx/mpc837x_rdb.c
>
> diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/ 
> boot/dts/mpc8377_rdb.dts
> new file mode 100644
> index 0000000..1ee2a06
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> @@ -0,0 +1,306 @@
> +/*
> + * MPC8377E RDB Device Tree Source
> + *
> + * Copyright 2005, 2006, 2007 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +/ {
> +	model = "fsl,mpc8377erdb";
> +	compatible = "fsl,mpc8377erdb","fsl,mpc837xrdb";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,837x@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <20>;
> +			i-cache-line-size = <20>;
> +			d-cache-size = <8000>;		// L1, 32K
> +			i-cache-size = <8000>;		// L1, 32K
> +			timebase-frequency = <0>;
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <00000000 10000000>;	// 256MB at 0
> +	};
> +
> +	soc837x@e0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <0 e0000000 00100000>;
> +		reg = <e0000000 00000200>;
> +		bus-frequency = <0>;
> +
> +		wdt@200 {
> +			device_type = "watchdog";
> +			compatible = "mpc83xx_wdt";
> +			reg = <200 100>;
> +		};
> +
> +		i2c@3000 {
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <3000 100>;
> +			interrupts = <e 8>;
> +			interrupt-parent = < &ipic >;
> +			dfsrr;
> +		};
> +
> +		i2c@3100 {
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <3100 100>;
> +			interrupts = <f 8>;
> +			interrupt-parent = < &ipic >;
> +			dfsrr;
> +		};
> +
> +		spi@7000 {
> +			device_type = "spi";
> +			compatible = "mpc83xx_spi";
> +			reg = <7000 1000>;
> +			interrupts = <10 8>;
> +			interrupt-parent = < &ipic >;
> +			mode = <0>;
> +		};
> +
> +		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
> +		usb@23000 {
> +			device_type = "usb";
> +			compatible = "fsl-usb2-dr";
> +			reg = <23000 1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupt-parent = < &ipic >;
> +			interrupts = <26 8>;
> +			phy_type = "utmi_wide";
> +		};
> +
> +		mdio@24520 {
> +			device_type = "mdio";
> +			compatible = "gianfar";
> +			reg = <24520 20>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			phy2: ethernet-phy@2 {
> +				interrupt-parent = < &ipic >;
> +				interrupts = <11 8>;
> +				reg = <2>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy3: ethernet-phy@3 {
> +				interrupt-parent = < &ipic >;
> +				interrupts = <12 8>;
> +				reg = <3>;
> +				device_type = "ethernet-phy";
> +			};
> +		};
> +
> +		ethernet@24000 {
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <24000 1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <20 8 21 8 22 8>;
> +			phy-connection-type = "mii";
> +			interrupt-parent = < &ipic >;
> +			phy-handle = < &phy2 >;
> +		};
> +
> +		ethernet@25000 {
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <25000 1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <23 8 24 8 25 8>;
> +			phy-connection-type = "mii";
> +			interrupt-parent = < &ipic >;
> +			phy-handle = < &phy3 >;
> +		};
> +
> +		serial@4500 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4500 100>;
> +			clock-frequency = <0>;
> +			interrupts = <9 8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		serial@4600 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4600 100>;
> +			clock-frequency = <0>;
> +			interrupts = <a 8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		pci@9000 {
> +			device_type = "pci";
> +			compatible = "fsl,mpc83xx-pex";
> +			reg = <9000 1000>;
> +			interrupt-parent = < &ipic >;
> +			interrupts = <1 8>;
> +			phy-handle = < &serdes2 >;
> +		};
> +
> +		pci@a000 {
> +			device_type = "pci";
> +			compatible = "fsl,mpc83xx-pex";
> +			reg = <a000 1000>;
> +			interrupt-parent = < &ipic >;
> +			interrupts = <2 8>;
> +			phy-handle = < &serdes2 >;
> +		};
> +

remove these pci nodes since we don't have kernel support for pex on  
83xx.

> +		crypto@30000 {
> +			device_type = "crypto";
> +			model = "SEC2";
> +			compatible = "talitos";
> +			reg = <30000 7000>;
> +			interrupts = <b 8>;
> +			interrupt-parent = < &ipic >;
> +			/* Rev. 2.2 */
> +			num-channels = <1>;
> +			channel-fifo-len = <18>;
> +			exec-units-mask = <0000004c>;
> +			descriptor-types-mask = <0122003f>;
> +		};
> +
> +		sdhc@2e000 {
> +			model = "eSDHC";
> +			compatible = "fsl,esdhc";
> +			reg = <2e000 1000>;
> +			interrupts = <2a 8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		sata@18000 {
> +			device_type = "sata";
> +			model = "SATA-300";
> +			compatible = "fsl,sata300";
> +			reg = <18000 1000>;
> +			interrupts = <2c 8>;
> +			interrupt-parent = < &ipic >;
> +			phy-handle = < &serdes1 >;
> +		};
> +
> +		sata@19000 {
> +			device_type = "sata";
> +			model = "SATA-300";
> +			compatible = "fsl,sata300";
> +			reg = <19000 1000>;
> +			interrupts = <2d 8>;
> +			interrupt-parent = < &ipic >;
> +			phy-handle = < &serdes1 >;
> +		};
> +
> +		serdes1:serdes@e3000 {
> +			compatible = "fsl,serdes";
> +			reg = <e3000 100>;
> +			vdd-1v;
> +			protocol = "sata";
> +			clock = <d#100>;
> +		};
> +
> +		serdes2:serdes@e3100 {
> +			model = "SerDes";
> +			compatible = "fsl,serdes";
> +			reg = <e3100 100>;
> +			vdd-1v;
> +			protocol = "pex";
> +			clock = <d#100>;
> +		};

remove sata, sdhc, and serdes until the device binding patches that  
describe these are posted.

> +
> +		/* IPIC
> +		 * interrupts cell = <intr #, sense>
> +		 * sense values match linux IORESOURCE_IRQ_* defines:
> +		 * sense == 8: Level, low assertion
> +		 * sense == 2: Edge, high-to-low change
> +		 */
> +		ipic: pic@700 {
> +			compatible = "fsl,ipic";
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <700 100>;
> +		};
> +	};
> +
> +	pci@e0008500 {
> +		interrupt-map-mask = <f800 0 0 7>;
> +		interrupt-map = <
> +
> +				/* IDSEL 0x11 */
> +				 8800 0 0 1 &ipic 14 8
> +				 8800 0 0 2 &ipic 15 8
> +				 8800 0 0 3 &ipic 16 8
> +				 8800 0 0 4 &ipic 17 8
> +
> +				/* IDSEL 0x12 */
> +				 9000 0 0 1 &ipic 16 8
> +				 9000 0 0 2 &ipic 17 8
> +				 9000 0 0 3 &ipic 14 8
> +				 9000 0 0 4 &ipic 15 8
> +
> +				/* IDSEL 0x13 */
> +				 9800 0 0 1 &ipic 17 8
> +				 9800 0 0 2 &ipic 14 8
> +				 9800 0 0 3 &ipic 15 8
> +				 9800 0 0 4 &ipic 16 8
> +
> +				/* IDSEL 0x15 */
> +				 a800 0 0 1 &ipic 14 8
> +				 a800 0 0 2 &ipic 15 8
> +				 a800 0 0 3 &ipic 16 8
> +				 a800 0 0 4 &ipic 17 8
> +
> +				/* IDSEL 0x16 */
> +				 b000 0 0 1 &ipic 17 8
> +				 b000 0 0 2 &ipic 14 8
> +				 b000 0 0 3 &ipic 15 8
> +				 b000 0 0 4 &ipic 16 8
> +
> +				/* IDSEL 0x17 */
> +				 b800 0 0 1 &ipic 16 8
> +				 b800 0 0 2 &ipic 17 8
> +				 b800 0 0 3 &ipic 14 8
> +				 b800 0 0 4 &ipic 15 8
> +
> +				/* IDSEL 0x18 */
> +				 c000 0 0 1 &ipic 15 8
> +				 c000 0 0 2 &ipic 16 8
> +				 c000 0 0 3 &ipic 17 8
> +				 c000 0 0 4 &ipic 14 8>;
> +		interrupt-parent = < &ipic >;
> +		interrupts = <42 8>;
> +		bus-range = <0 0>;
> +		ranges = <02000000 0 90000000 90000000 0 10000000
> +		          42000000 0 80000000 80000000 0 10000000
> +		          01000000 0 00000000 e2000000 0 00100000>;
> +		clock-frequency = <0>;
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		reg = <e0008500 100>;
> +		compatible = "fsl,mpc83xx-pci", "83xx";
> +		device_type = "pci";
> +	};
> +};

(above comments apply to other .dts)

[snip]

> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/ 
> platforms/83xx/Kconfig
> index 0c61e7a..76a623b 100644
> --- a/arch/powerpc/platforms/83xx/Kconfig
> +++ b/arch/powerpc/platforms/83xx/Kconfig
> @@ -55,6 +55,12 @@ config MPC837x_MDS
>  	select DEFAULT_UIMAGE
>  	help
>  	  This option enables support for the MPC837x MDS Processor Board.
> +
> +config MPC837x_RDB
> +	bool "Freescale MPC837x RDB"
> +	select DEFAULT_UIMAGE
> +	help
> +	  This option enables support for the MPC837x RDB Board.
>  endchoice
>
>  config PPC_MPC831x
> @@ -86,4 +92,4 @@ config PPC_MPC837x
>  	select PPC_UDBG_16550
>  	select PPC_INDIRECT_PCI
>  	select FSL_SERDES

FSL_SERDES doesn't exist in any tree at this point.

> -	default y if MPC837x_MDS
> +	default y if MPC837x_MDS || MPC837x_RDB
> diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/ 
> platforms/83xx/Makefile
> index df46629..d64c0ad 100644
> --- a/arch/powerpc/platforms/83xx/Makefile
> +++ b/arch/powerpc/platforms/83xx/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
>  obj-$(CONFIG_MPC836x_MDS)	+= mpc836x_mds.o
>  obj-$(CONFIG_MPC832x_MDS)	+= mpc832x_mds.o
>  obj-$(CONFIG_MPC837x_MDS)	+= mpc837x_mds.o
> +obj-$(CONFIG_MPC837x_RDB)	+= mpc837x_rdb.o

This patch will not apply since 837x_MDS doesn't exist.

> diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/ 
> powerpc/platforms/83xx/mpc837x_rdb.c
> new file mode 100644
> index 0000000..132438f
> --- /dev/null
> +++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
> @@ -0,0 +1,102 @@
> +/*
> + * arch/powerpc/platforms/83xx/mpc837x_rdb.c
> + *
> + * Copyright (C) 2007 Freescale Semicondutor, Inc. All rights  
> reserved.
> + *
> + * MPC837x RDB board specific routines
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +#include <linux/of_platform.h>
> +
> +#include <asm/time.h>
> +#include <asm/ipic.h>
> +#include <asm/udbg.h>
> +
> +#include "mpc83xx.h"
> +
> +#ifndef CONFIG_PCI
> +unsigned long isa_io_base;
> +unsigned long isa_mem_base;
> +#endif
> +
> +/*  
> ********************************************************************** 
> **
> + *
> + * Setup the architecture
> + *
> + */
> +static void __init mpc837x_rdb_setup_arch(void)
> +{
> +#ifdef CONFIG_PCI
> +	struct device_node *np;
> +#endif
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("mpc837x_rdb_setup_arch()", 0);
> +
> +#ifdef CONFIG_PCI
> +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> +		add_bridge(np);

This should be somethine like:

for_each_node_by_type(np, "pci")
       if (of_device_is_compatible(np, "fsl,mpc83xx-pci"))
		add_bridge(np);

> +#endif
> +}
> +
> +static struct of_device_id mpc837x_ids[] = {
> +	{ .type = "soc", },
> +	{ .compatible = "soc", },
> +	{},
> +};
> +
> +static int __init mpc837x_declare_of_platform_devices(void)
> +{
> +	if (!machine_is(mpc837x_rdb))
> +		return 0;
> +
> +	/* Publish of_device */
> +	of_platform_bus_probe(NULL, mpc837x_ids, NULL);
> +
> +	return 0;
> +}
> +device_initcall(mpc837x_declare_of_platform_devices);
> +
> +static void __init mpc837x_rdb_init_IRQ(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
> +	if (!np)
> +		return;
> +
> +	ipic_init(np, 0);
> +
> +	/* Initialize the default interrupt mapping priorities,
> +	 * in case the boot rom changed something on us.
> +	 */
> +	ipic_set_default_priority();
> +}
> +
> +
> +/*
> + * Called very early, MMU is off, device-tree isn't unflattened
> + */
> +static int __init mpc837x_rdb_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	return of_flat_dt_is_compatible(root, "fsl,mpc837xrdb");
> +}
> +
> +define_machine(mpc837x_rdb) {
> +	.name			= "MPC837x RDB",
> +	.probe			= mpc837x_rdb_probe,
> +	.setup_arch		= mpc837x_rdb_setup_arch,
> +	.init_IRQ		= mpc837x_rdb_init_IRQ,
> +	.get_irq		= ipic_get_irq,
> +	.restart		= mpc83xx_restart,
> +	.time_init		= mpc83xx_time_init,
> +	.calibrate_decr		= generic_calibrate_decr,
> +	.progress		= udbg_progress,
> +};
> -- 
> 1.5.2.2
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

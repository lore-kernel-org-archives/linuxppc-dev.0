Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 58B8AB7165
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 09:24:14 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC5C4DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 09:24:12 +1000 (EST)
Message-Id: <DF329655-9763-42EA-8170-645337949CF3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1244673039-1089-1-git-send-email-ncase@xes-inc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH v2 -next] powerpc/85xx: Add support for X-ES MPC85xx boards
Date: Wed, 10 Jun 2009 18:24:05 -0500
References: <1244673039-1089-1-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 10, 2009, at 5:30 PM, Nate Case wrote:

> Add support for X-ES single-board computers based on the Freescale
> MPC85xx processors.  Changes include:
>
>  * New machine support in platforms/85xx
>  * dts files for supported boards
>  * defconfig
>  * Boot wrapper support for XPedite5200 to support legacy boot loader
>
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> ---
> Differences from patch v1:
> * Address comments from Kumar
> * Remove L1 cache setup (submitted as separate patch for all e500  
> CPUs)
>
> arch/powerpc/boot/dts/xcalibur1501.dts          |  759 +++++++++++
> arch/powerpc/boot/dts/xpedite5200.dts           |  472 +++++++
> arch/powerpc/boot/dts/xpedite5200_xmon.dts      |  510 +++++++
> arch/powerpc/boot/dts/xpedite5301.dts           |  647 +++++++++
> arch/powerpc/boot/dts/xpedite5330.dts           |  714 ++++++++++
> arch/powerpc/boot/dts/xpedite5370.dts           |  683 ++++++++++
> arch/powerpc/boot/wrapper                       |    4 +
> arch/powerpc/configs/85xx/xes_mpc85xx_defconfig | 1668 ++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/85xx/Kconfig             |   10 +
> arch/powerpc/platforms/85xx/Makefile            |    1 +
> arch/powerpc/platforms/85xx/xes_mpc85xx.c       |  282 ++++
> 11 files changed, 5750 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/xcalibur1501.dts
> create mode 100644 arch/powerpc/boot/dts/xpedite5200.dts
> create mode 100644 arch/powerpc/boot/dts/xpedite5200_xmon.dts
> create mode 100644 arch/powerpc/boot/dts/xpedite5301.dts
> create mode 100644 arch/powerpc/boot/dts/xpedite5330.dts
> create mode 100644 arch/powerpc/boot/dts/xpedite5370.dts
> create mode 100644 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
> create mode 100644 arch/powerpc/platforms/85xx/xes_mpc85xx.c
>
> diff --git a/arch/powerpc/boot/dts/xcalibur1501.dts b/arch/powerpc/ 
> boot/dts/xcalibur1501.dts
> new file mode 100644
> index 0000000..497af7a
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/xcalibur1501.dts
> @@ -0,0 +1,759 @@
> +/*
> + * Copyright (C) 2008 Extreme Engineering Solutions, Inc.
> + * Based on MPC8572DS device tree from Freescale Semiconductor, Inc.
> + *
> + * XCalibur1501 6U CompactPCI single-board computer based on MPC8572E
> + *
> + * This is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +/ {
> +	model = "xes,xcalibur1501";
> +	compatible = "xes,xcalibur1501", "xes,MPC8572";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	form-factor = "6U cPCI";
> +	boot-bank = <0x0>;	/* 0: Primary flash, 1: Secondary flash */

I'm not a fan of taking device trees with properties that are  
specified anywhere.

> +
> +	aliases {
> +		ethernet0 = &enet0;
> +		ethernet1 = &enet1;
> +		ethernet2 = &enet2;
> +		ethernet3 = &enet3;
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +		pci2 = &pci2;
> +	};
> +
> +	pmcslots {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmcslot@0 {
> +			cell-index = <0>;
> +			/*
> +			 * boolean properties (true if defined):
> +			 *     monarch;
> +			 *     module-present;
> +			 */
> +		};
> +
> +		pmcslot@1 {
> +			cell-index = <1>;
> +			/*
> +			 * boolean properties (true if defined):
> +			 *     monarch;
> +			 *     module-present;
> +			 */
> +		};
> +	};
> +
> +	xmcslots {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		xmcslot@0 {
> +			cell-index = <0>;
> +			/*
> +			 * boolean properties (true if defined):
> +			 *     module-present;
> +			 */
> +		};
> +
> +		xmcslot@1 {
> +			cell-index = <1>;
> +			/*
> +			 * boolean properties (true if defined):
> +			 *     module-present;
> +			 */
> +		};
> +	};
> +
> +	cpci {
> +		/*
> +		 * boolean properties (true if defined):
> +		 *     system-controller;
> +		 */
> +		system-controller;
> +	};
> +

ditto. (see above)

>
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8572@0 {
> +			device_type = "cpu";
> +			reg = <0x0>;
> +			d-cache-line-size = <32>;	// 32 bytes
> +			i-cache-line-size = <32>;	// 32 bytes
> +			d-cache-size = <0x8000>;		// L1, 32K
> +			i-cache-size = <0x8000>;		// L1, 32K
> +			timebase-frequency = <0>;
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		PowerPC,8572@1 {
> +			device_type = "cpu";
> +			reg = <0x1>;
> +			d-cache-line-size = <32>;	// 32 bytes
> +			i-cache-line-size = <32>;	// 32 bytes
> +			d-cache-size = <0x8000>;		// L1, 32K
> +			i-cache-size = <0x8000>;		// L1, 32K
> +			timebase-frequency = <0>;
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
> +			next-level-cache = <&L2>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +	};
> +
> +	localbus@ef005000 {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc8572-elbc", "fsl,elbc", "simple-bus";
> +		reg = <0 0xef005000 0 0x1000>;
> +		interrupts = <19 2>;
> +		interrupt-parent = <&mpic>;
> +		/* Local bus region mappings */
> +		ranges = <0 0 0 0xf8000000 0x8000000  /* CS0: Flash 1 */
> +			  1 0 0 0xf0000000 0x8000000  /* CS1: Flash 2 */
> +			  2 0 0 0xef800000 0x40000    /* CS2: NAND CE1 */
> +			  3 0 0 0xef840000 0x40000    /* CS3: NAND CE2 */
> +			  4 0 0 0xe9000000 0x100000>; /* CS4: USB */
> +
> +		nor-boot@0,0 {
> +			compatible = "amd,s29gl01gp", "cfi-flash";
> +			bank-width = <2>;
> +			reg = <0 0 0x8000000>; /* 128MB */
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@0 {
> +				label = "Primary user space";
> +				reg = <0x00000000 0x6f00000>; /* 111 MB */
> +			};
> +			partition@6f00000 {
> +				label = "Primary kernel";
> +				reg = <0x6f00000 0x1000000>; /* 16 MB */
> +			};
> +			partition@7f00000 {
> +				label = "Primary DTB";
> +				reg = <0x7f00000 0x40000>; /* 256 KB */
> +			};
> +			partition@7f40000 {
> +				label = "Primary U-Boot environment";
> +				reg = <0x7f40000 0x40000>; /* 256 KB */
> +			};
> +			partition@7f80000 {
> +				label = "Primary U-Boot";
> +				reg = <0x7f80000 0x80000>; /* 512 KB */
> +				read-only;
> +			};
> +		};
> +
> +		nor-alternate@1,0 {
> +			compatible = "amd,s29gl01gp", "cfi-flash";
> +			bank-width = <2>;
> +			//reg = <0xf0000000 0x08000000>; /* 128MB */
> +			reg = <1 0 0x8000000>; /* 128MB */
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@0 {
> +				label = "Secondary user space";
> +				reg = <0x00000000 0x6f00000>; /* 111 MB */
> +			};
> +			partition@6f00000 {
> +				label = "Secondary kernel";
> +				reg = <0x6f00000 0x1000000>; /* 16 MB */
> +			};
> +			partition@7f00000 {
> +				label = "Secondary DTB";
> +				reg = <0x7f00000 0x40000>; /* 256 KB */
> +			};
> +			partition@7f40000 {
> +				label = "Secondary U-Boot environment";
> +				reg = <0x7f40000 0x40000>; /* 256 KB */
> +			};
> +			partition@7f80000 {
> +				label = "Secondary U-Boot";
> +				reg = <0x7f80000 0x80000>; /* 512 KB */
> +				read-only;
> +			};
> +		};
> +
> +		nand@2,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			/*
> +			 * Actual part could be ST Micro NAND08GW3B2A (1 GB),
> +			 * Micron MT29F8G08DAA (2x 512 MB), or Micron
> +			 * MT29F16G08FAA (2x 1 GB), depending on the build
> +			 * configuration
> +			 */
> +			compatible = "fsl,mpc8572-fcm-nand",
> +				     "fsl,elbc-fcm-nand";
> +			reg = <2 0 0x40000>;
> +			/* U-Boot should fix this up if chip size > 1 GB */
> +			partition@0 {
> +				label = "NAND Filesystem";
> +				reg = <0 0x40000000>;
> +			};
> +		};
> +
> +		usb@4,0 {
> +			compatible = "nxp,usb-isp1761";
> +			reg = <4 0 0x100000>;
> +			bus-width = <32>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <10 1>;
> +		};
> +	};
> +
> +	soc8572@ef000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		compatible = "simple-bus";

should have a compat like:

                 compatible = "fsl,mpc8572-immr", "simple-bus";


>
> +		ranges = <0x0 0 0xef000000 0x100000>;
> +		bus-frequency = <0>;		// Filled out by uboot.
> +
> +		ecm-law@0 {
> +			compatible = "fsl,ecm-law";
> +			reg = <0x0 0x1000>;
> +			fsl,num-laws = <12>;
> +		};
> +
> +		ecm@1000 {
> +			compatible = "fsl,mpc8572-ecm", "fsl,ecm";
> +			reg = <0x1000 0x1000>;
> +			interrupts = <17 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		memory-controller@2000 {
> +			compatible = "fsl,mpc8572-memory-controller";
> +			reg = <0x2000 0x1000>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <18 2>;
> +		};
> +
> +		memory-controller@6000 {
> +			compatible = "fsl,mpc8572-memory-controller";
> +			reg = <0x6000 0x1000>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <18 2>;
> +		};
> +
> +		L2: l2-cache-controller@20000 {
> +			compatible = "fsl,mpc8572-l2-cache-controller";
> +			reg = <0x20000 0x1000>;
> +			cache-line-size = <32>;	// 32 bytes
> +			cache-size = <0x100000>; // L2, 1M
> +			interrupt-parent = <&mpic>;
> +			interrupts = <16 2>;
> +		};
> +
> +		i2c@3000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cell-index = <0>;
> +			compatible = "fsl-i2c";
> +			reg = <0x3000 0x100>;
> +			interrupts = <43 2>;
> +			interrupt-parent = <&mpic>;
> +			dfsrr;
> +
> +			temp-sensor@48 {
> +				compatible = "dallas,ds1631", "dallas,ds1621";
> +				reg = <0x48>;
> +			};
> +
> +			temp-sensor@4c {
> +				compatible = "adi,adt7461";
> +				reg = <0x4c>;
> +			};
> +
> +			cpu-supervisor@51 {
> +				compatible = "dallas,ds4510";
> +				reg = <0x51>;
> +			};
> +
> +			eeprom@54 {
> +				compatible = "atmel,at24c128b";
> +				reg = <0x54>;
> +			};
> +
> +			rtc@68 {
> +				compatible = "stm,m41t00",
> +				             "dallas,ds1338";
> +				reg = <0x68>;
> +			};
> +
> +			pcie-switch@6a {
> +				compatible = "plx,pex8648";
> +				reg = <0x6a>;
> +			};
> +
> +			/* On-board signals for VID, flash, serial */
> +			gpio1: gpio@18 {
> +				compatible = "nxp,pca9557";
> +				reg = <0x18>;
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				polarity = <0x00>;
> +			};
> +
> +			/* PMC0/XMC0 signals */
> +			gpio2: gpio@1c {
> +				compatible = "nxp,pca9557";
> +				reg = <0x1c>;
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				polarity = <0x00>;
> +			};
> +
> +			/* PMC1/XMC1 signals */
> +			gpio3: gpio@1d {
> +				compatible = "nxp,pca9557";
> +				reg = <0x1d>;
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				polarity = <0x00>;
> +			};
> +
> +			/* CompactPCI signals (sysen, GA[4:0]) */
> +			gpio4: gpio@1e {
> +				compatible = "nxp,pca9557";
> +				reg = <0x1e>;
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				polarity = <0x00>;
> +			};
> +
> +			/* CompactPCI J5 GPIO and FAL/DEG/PRST */
> +			gpio5: gpio@1f {
> +				compatible = "nxp,pca9557";
> +				reg = <0x1f>;
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				polarity = <0x00>;
> +			};
> +		};
> +
> +		i2c@3100 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cell-index = <1>;
> +			compatible = "fsl-i2c";
> +			reg = <0x3100 0x100>;
> +			interrupts = <43 2>;
> +			interrupt-parent = <&mpic>;
> +			dfsrr;
> +		};
> +
> +		dma@c300 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
> +			reg = <0xc300 0x4>;
> +			ranges = <0x0 0xc100 0x200>;
> +			cell-index = <1>;
> +			dma-channel@0 {
> +				compatible = "fsl,mpc8572-dma-channel",
> +						"fsl,eloplus-dma-channel";
> +				reg = <0x0 0x80>;
> +				cell-index = <0>;
> +				interrupt-parent = <&mpic>;
> +				interrupts = <76 2>;
> +			};
> +			dma-channel@80 {
> +				compatible = "fsl,mpc8572-dma-channel",
> +						"fsl,eloplus-dma-channel";
> +				reg = <0x80 0x80>;
> +				cell-index = <1>;
> +				interrupt-parent = <&mpic>;
> +				interrupts = <77 2>;
> +			};
> +			dma-channel@100 {
> +				compatible = "fsl,mpc8572-dma-channel",
> +						"fsl,eloplus-dma-channel";
> +				reg = <0x100 0x80>;
> +				cell-index = <2>;
> +				interrupt-parent = <&mpic>;
> +				interrupts = <78 2>;
> +			};
> +			dma-channel@180 {
> +				compatible = "fsl,mpc8572-dma-channel",
> +						"fsl,eloplus-dma-channel";
> +				reg = <0x180 0x80>;
> +				cell-index = <3>;
> +				interrupt-parent = <&mpic>;
> +				interrupts = <79 2>;
> +			};
> +		};
> +
> +		dma@21300 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
> +			reg = <0x21300 0x4>;
> +			ranges = <0x0 0x21100 0x200>;
> +			cell-index = <0>;
> +			dma-channel@0 {
> +				compatible = "fsl,mpc8572-dma-channel",
> +						"fsl,eloplus-dma-channel";
> +				reg = <0x0 0x80>;
> +				cell-index = <0>;
> +				interrupt-parent = <&mpic>;
> +				interrupts = <20 2>;
> +			};
> +			dma-channel@80 {
> +				compatible = "fsl,mpc8572-dma-channel",
> +						"fsl,eloplus-dma-channel";
> +				reg = <0x80 0x80>;
> +				cell-index = <1>;
> +				interrupt-parent = <&mpic>;
> +				interrupts = <21 2>;
> +			};
> +			dma-channel@100 {
> +				compatible = "fsl,mpc8572-dma-channel",
> +						"fsl,eloplus-dma-channel";
> +				reg = <0x100 0x80>;
> +				cell-index = <2>;
> +				interrupt-parent = <&mpic>;
> +				interrupts = <22 2>;
> +			};
> +			dma-channel@180 {
> +				compatible = "fsl,mpc8572-dma-channel",
> +						"fsl,eloplus-dma-channel";
> +				reg = <0x180 0x80>;
> +				cell-index = <3>;
> +				interrupt-parent = <&mpic>;
> +				interrupts = <23 2>;
> +			};
> +		};
> +
> +		/* eTSEC 1 front panel 0 */
> +		enet0: ethernet@24000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			cell-index = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x24000 0x1000>;
> +			ranges = <0x0 0x24000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <29 2 30 2 34 2>;
> +			interrupt-parent = <&mpic>;
> +			tbi-handle = <&tbi0>;
> +			phy-handle = <&phy0>;
> +			phy-connection-type = "sgmii";
> +
> +			mdio@520 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,gianfar-mdio";
> +				reg = <0x520 0x20>;
> +
> +				phy0: ethernet-phy@1 {
> +					interrupt-parent = <&mpic>;
> +					interrupts = <4 1>;
> +					reg = <0x1>;
> +					device_type = "ethernet-phy";
> +				};
> +				phy1: ethernet-phy@2 {
> +					interrupt-parent = <&mpic>;
> +					interrupts = <4 1>;
> +					reg = <0x2>;
> +					device_type = "ethernet-phy";
> +				};
> +				phy2: ethernet-phy@3 {
> +					interrupt-parent = <&mpic>;
> +					interrupts = <5 1>;
> +					reg = <0x3>;
> +					device_type = "ethernet-phy";
> +				};
> +				phy3: ethernet-phy@4 {
> +					interrupt-parent = <&mpic>;
> +					interrupts = <5 1>;
> +					reg = <0x4>;
> +					device_type = "ethernet-phy";
> +				};
> +				tbi0: tbi-phy@11 {
> +					reg = <0x11>;
> +					device_type = "tbi-phy";
> +				};
> +			};
> +		};
> +
> +		/* eTSEC 2 front panel 1 */
> +		enet1: ethernet@25000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			cell-index = <1>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x25000 0x1000>;
> +			ranges = <0x0 0x25000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <35 2 36 2 40 2>;
> +			interrupt-parent = <&mpic>;
> +			tbi-handle = <&tbi1>;
> +			phy-handle = <&phy1>;
> +			phy-connection-type = "sgmii";
> +
> +			mdio@520 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,gianfar-tbi";
> +				reg = <0x520 0x20>;
> +
> +				tbi1: tbi-phy@11 {
> +					reg = <0x11>;
> +					device_type = "tbi-phy";
> +				};
> +			};
> +		};
> +
> +		/* eTSEC 3 PICMG2.16 backplane port 0 */
> +		enet2: ethernet@26000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			cell-index = <2>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x26000 0x1000>;
> +			ranges = <0x0 0x26000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <31 2 32 2 33 2>;
> +			interrupt-parent = <&mpic>;
> +			tbi-handle = <&tbi2>;
> +			phy-handle = <&phy2>;
> +			phy-connection-type = "sgmii";
> +
> +			mdio@520 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,gianfar-tbi";
> +				reg = <0x520 0x20>;
> +
> +				tbi2: tbi-phy@11 {
> +					reg = <0x11>;
> +					device_type = "tbi-phy";
> +				};
> +			};
> +		};
> +
> +		/* eTSEC 4 PICMG2.16 backplane port 1 */
> +		enet3: ethernet@27000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			cell-index = <3>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x27000 0x1000>;
> +			ranges = <0x0 0x27000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <37 2 38 2 39 2>;
> +			interrupt-parent = <&mpic>;
> +			tbi-handle = <&tbi3>;
> +			phy-handle = <&phy3>;
> +			phy-connection-type = "sgmii";
> +
> +			mdio@520 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,gianfar-tbi";
> +				reg = <0x520 0x20>;
> +
> +				tbi3: tbi-phy@11 {
> +					reg = <0x11>;
> +					device_type = "tbi-phy";
> +				};
> +			};
> +		};
> +
> +		/* UART0 */
> +		serial0: serial@4500 {
> +			cell-index = <0>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <0x4500 0x100>;
> +			clock-frequency = <0>;
> +			interrupts = <42 2>;
> +			interrupt-parent = <&mpic>;
> +			/* U-Boot should populate as RS-232, RS-485, etc */
> +			transceiver-mode = "Unknown";

this is a new property w/o any specification.

>
> +		};
> +
> +		/* UART1 */
> +		serial1: serial@4600 {
> +			cell-index = <1>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <0x4600 0x100>;
> +			clock-frequency = <0>;
> +			interrupts = <42 2>;
> +			interrupt-parent = <&mpic>;
> +			/* U-Boot should populate as RS-232, RS-485, etc */
> +			transceiver-mode = "Unknown";
> +		};
> +
> +		global-utilities@e0000 {	//global utilities block
> +			compatible = "fsl,mpc8572-guts";
> +			reg = <0xe0000 0x1000>;
> +			fsl,has-rstcr;
> +		};
> +
> +		msi@41600 {
> +			compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
> +			reg = <0x41600 0x80>;
> +			msi-available-ranges = <0 0x100>;
> +			interrupts = <
> +				0xe0 0
> +				0xe1 0
> +				0xe2 0
> +				0xe3 0
> +				0xe4 0
> +				0xe5 0
> +				0xe6 0
> +				0xe7 0>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		crypto@30000 {
> +			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
> +				     "fsl,sec2.1", "fsl,sec2.0";
> +			reg = <0x30000 0x10000>;
> +			interrupts = <45 2 58 2>;
> +			interrupt-parent = <&mpic>;
> +			fsl,num-channels = <4>;
> +			fsl,channel-fifo-len = <24>;
> +			fsl,exec-units-mask = <0x9fe>;
> +			fsl,descriptor-types-mask = <0x3ab0ebf>;
> +		};
> +
> +		mpic: pic@40000 {
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <0x40000 0x40000>;
> +			compatible = "chrp,open-pic";
> +			device_type = "open-pic";
> +		};
> +
> +		gpio0: gpio@f000 {
> +			compatible = "fsl,mpc8572-gpio";
> +			reg = <0xf000 0x1000>;
> +			interrupts = <47 2>;
> +			interrupt-parent = <&mpic>;
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +		};
> +
> +		gpio-leds {
> +			compatible = "gpio-leds";
> +
> +			heartbeat {
> +				label = "Heartbeat";
> +				gpios = <&gpio0 4 1>;
> +				linux,default-trigger = "heartbeat";
> +			};
> +
> +			yellow {
> +				label = "Yellow";
> +				gpios = <&gpio0 5 1>;
> +			};
> +
> +			red {
> +				label = "Red";
> +				gpios = <&gpio0 6 1>;
> +			};
> +
> +			green {
> +				label = "Green";
> +				gpios = <&gpio0 7 1>;
> +			};
> +		};
> +
> +		/* PME (pattern-matcher) */
> +		pme@10000 {
> +			compatible = "fsl,mpc8572-pme", "pme8572";
> +			reg = <0x10000 0x5000>;
> +			interrupts = <57 2 64 2 65 2 66 2 67 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		tlu@2f000 {
> +			device_type = "tlu";
> +			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
> +			reg = <0x2f000 0x1000>;
> +			interupts = <61 2 >;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		tlu@15000 {
> +			device_type = "tlu";
> +			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
> +			reg = <0x15000 0x1000>;
> +			interupts = <75 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +	};
> +
> +	/*
> +	 * PCI Express controller 3 @ ef008000 is not used.
> +	 * This would have been pci0 on other mpc85xx platforms.
> +	 *
> +	 * PCI Express controller 2 @ ef009000 is not used.
> +	 * This would have been pci1 on other mpc85xx platforms.
> +	 */
> +
> +	/* PCI Express controller 1, wired to PEX8648 PCIe switch */
> +	pci2: pcie@ef00a000 {
> +		compatible = "fsl,mpc8548-pcie";
> +		device_type = "pci";
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		reg = <0 0xef00a000 0 0x1000>;
> +		bus-range = <0 255>;
> +		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x40000000
> +			  0x1000000 0x0 0x00000000 0 0xe8000000 0x0 0x10000>;
> +		clock-frequency = <33333333>;
> +		interrupt-parent = <&mpic>;
> +		interrupts = <26 2>;
> +		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> +		interrupt-map = <
> +			/* IDSEL 0x0 */
> +			0x0 0x0 0x0 0x1 &mpic 0x0 0x1
> +			0x0 0x0 0x0 0x2 &mpic 0x1 0x1
> +			0x0 0x0 0x0 0x3 &mpic 0x2 0x1
> +			0x0 0x0 0x0 0x4 &mpic 0x3 0x1
> +			>;
> +		pcie@0 {
> +			reg = <0x0 0x0 0x0 0x0 0x0>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			device_type = "pci";
> +			ranges = <0x2000000 0x0 0x80000000
> +				  0x2000000 0x0 0x80000000
> +				  0x0 0x40000000
> +
> +				  0x1000000 0x0 0x0
> +				  0x1000000 0x0 0x0
> +				  0x0 0x100000>;
> +		};
> +	};
> +};

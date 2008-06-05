Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5F6A5DE40D
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 23:44:03 +1000 (EST)
Message-Id: <71165662-0864-4CDE-A1B3-29487253B85F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <4847AC75.8080405@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v2 1/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
Date: Thu, 5 Jun 2008 08:43:51 -0500
References: <4847AC75.8080405@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 5, 2008, at 4:05 AM, Wolfgang Grandegger wrote:

> [POWERPC] 85xx: add board support for the TQM8548 modules
>
> This patch adds support for the TQM8548 modules from TQ-Components
> GmbH (http://www.tqc.de).
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> arch/powerpc/boot/Makefile                  |    1
> arch/powerpc/boot/dts/tqm8548.dts           |  368 +++++++++
> arch/powerpc/boot/wrapper                   |    2
> arch/powerpc/configs/85xx/tqm8548_defconfig | 1094 ++++++++++++++++++ 
> ++++++++++
> arch/powerpc/platforms/85xx/Kconfig         |    8
> arch/powerpc/platforms/85xx/tqm85xx.c       |   15
> 6 files changed, 1485 insertions(+), 3 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/tqm8548.dts
> create mode 100644 arch/powerpc/configs/85xx/tqm8548_defconfig
>
> Index: linux-2.6-galak/arch/powerpc/boot/Makefile
> ===================================================================
> --- linux-2.6-galak.orig/arch/powerpc/boot/Makefile
> +++ linux-2.6-galak/arch/powerpc/boot/Makefile
> @@ -255,6 +255,7 @@ image-$(CONFIG_MPC85xx_DS)		+= cuImage.m
> 					   cuImage.mpc8572ds
> image-$(CONFIG_TQM8540)			+= cuImage.tqm8540
> image-$(CONFIG_TQM8541)			+= cuImage.tqm8541
> +image-$(CONFIG_TQM8548)			+= cuImage.tqm8548
> image-$(CONFIG_TQM8555)			+= cuImage.tqm8555
> image-$(CONFIG_TQM8560)			+= cuImage.tqm8560
> image-$(CONFIG_SBC8548)			+= cuImage.sbc8548
> Index: linux-2.6-galak/arch/powerpc/boot/dts/tqm8548.dts
> ===================================================================
> --- /dev/null
> +++ linux-2.6-galak/arch/powerpc/boot/dts/tqm8548.dts
> @@ -0,0 +1,368 @@
> +/*
> + * TQM8548 Device Tree Source
> + *
> + * Copyright 2006 Freescale Semiconductor Inc.
> + * Copyright 2008 Wolfgang Grandegger <wg@denx.de>
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
> +/dts-v1/;
> +
> +/ {
> +	model = "tqm,8548";
> +	compatible = "tqm,8548", "tqm,85xx";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	aliases {
> +		ethernet0 = &enet0;
> +		ethernet1 = &enet1;
> +		ethernet2 = &enet2;
> +		ethernet3 = &enet3;
> +
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +		pci0 = &pci0;
> +		pci1 = &pci1;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8548@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <32>;	// 32 bytes
> +			i-cache-line-size = <32>;	// 32 bytes
> +			d-cache-size = <0x8000>;	// L1, 32K
> +			i-cache-size = <0x8000>;	// L1, 32K

>
> +			timebase-frequency = <0>;	// from U-Boot
> +			bus-frequency = <0>;	// from U-Boot
> +			clock-frequency = <0>;	// from U-Boot

u-boot will add this for us so no need for them.

>
> +			next-level-cache = <&L2>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>;
> +	};
> +
> +	soc8548@e0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <0x0 0xe0000000 0x100000>;
> +		reg = <0xe0000000 0x1000>;	// CCSRBAR
> +		bus-frequency = <0>;
> +
> +		memory-controller@2000 {
> +			compatible = "fsl,8548-memory-controller";

Can you make this fsl,mpc8548...

I need to fix all the other device trees

>
> +			reg = <0x2000 0x1000>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <18 2>;
> +		};
> +
> +		L2: l2-cache-controller@20000 {
> +			compatible = "fsl,8548-l2-cache-controller";

Can you make this fsl,mpc8548
>
> +			reg = <0x20000 0x1000>;
> +			cache-line-size = <32>;	// 32 bytes
> +			cache-size = <0x80000>;	// L2, 512K
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
> +		mdio@24520 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl,gianfar-mdio";
> +			reg = <0x24520 0x20>;
> +
> +			phy1: ethernet-phy@0 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <8 1>;
> +				reg = <1>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy2: ethernet-phy@1 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <8 1>;
> +				reg = <2>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy3: ethernet-phy@3 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <8 1>;
> +				reg = <3>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy4: ethernet-phy@4 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <8 1>;
> +				reg = <4>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy5: ethernet-phy@5 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <8 1>;
> +				reg = <5>;
> +				device_type = "ethernet-phy";
> +			};
> +		};
> +
> +		enet0: ethernet@24000 {
> +			cell-index = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x24000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <29 2 30 2 34 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy2>;
> +		};
> +
> +		enet1: ethernet@25000 {
> +			cell-index = <1>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x25000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <35 2 36 2 40 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy1>;
> +		};
> +
> +		enet2: ethernet@26000 {
> +			cell-index = <2>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x26000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <31 2 32 2 33 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy3>;
> +		};
> +
> +		enet3: ethernet@27000 {
> +			cell-index = <3>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x27000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <37 2 38 2 39 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy4>;
> +		};
> +
> +		serial0: serial@4500 {
> +			cell-index = <0>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <0x4500 0x100>;	// reg base, size
> +			clock-frequency = <0>;	// should we fill in in uboot?
> +			current-speed = <115200>;
> +			interrupts = <42 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		serial1: serial@4600 {
> +			cell-index = <1>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <0x4600 0x100>;	// reg base, size
> +			clock-frequency = <0>;	// should we fill in in uboot?
> +			current-speed = <115200>;
> +			interrupts = <42 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		global-utilities@e0000 {	// global utilities reg
> +			compatible = "fsl,mpc8548-guts";
> +			reg = <0xe0000 0x1000>;
> +			fsl,has-rstcr;
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
> +	};
> +
> +	localbus@e0005000 {
> +		compatible = "fsl,mpc8548-localbus", "fsl,pq3-localbus",
> +			     "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		reg = <0xe0005000 0x100>;	// BRx, ORx, etc.
> +
> +		ranges = <
> +			0 0x0 0xfc000000 0x04000000	// NOR FLASH bank 1
> +			1 0x0 0xf8000000 0x08000000	// NOR FLASH bank 0
> +			2 0x0 0xe3000000 0x00008000	// CAN (2 x i82527)
> +			3 0x0 0xe3010000 0x00008000	// NAND FLASH
> +
> +		>;
> +
> +		flash@1,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "cfi-flash";
> +			reg = <1 0x0 0x8000000>;
> +			bank-width = <4>;
> +			device-width = <1>;
> +
> +			partition@0 {
> +                                label = "kernel";
> +                                reg = <0x00000000 0x00200000>;
> +                        };
> +                        partition@200000 {
> +                                label = "root";
> +                                reg = <0x00200000 0x00300000>;
> +                        };
> +                        partition@500000 {
> +                                label = "user";
> +                                reg = <0x00500000 0x07a00000>;
> +                        };
> +                        partition@7f00000 {
> +                                label = "env1";
> +                                reg = <0x07f00000 0x00040000>;
> +                        };
> +                        partition@7f40000 {
> +                                label = "env2";
> +                                reg = <0x07f40000 0x00040000>;
> +                        };
> +                        partition@7f80000 {
> +                                label = "u-boot";
> +                                reg = <0x07f80000 0x00080000>;
> +                                read-only;
> +                        };
> +		};
> +
> +		/* Note: CAN support needs be enabled in U-Boot */
> +		can0@2,0 {
> +			compatible = "intel,82527"; // Bosch CC770
> +			reg = <2 0x0 0x100>;
> +			interrupts = <4 0>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		can1@2,100 {
> +			compatible = "intel,82527"; // Bosch CC770
> +			reg = <2 0x100 0x100>;
> +			interrupts = <4 0>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		/* Note: NAND support needs to be enabled in U-Boot */
> +		upm@3,0 {
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			compatible = "fsl,upm-nand";
> +			reg = <3 0x0 0x800>;
> +			fsl,upm-addr-offset = <0x10>;
> +			fsl,upm-cmd-offset = <0x08>;
> +			chip-delay = <30>; // in micro-seconds
> +
> +			nand@0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				partition@0 {
> +					    label = "fs";
> +					    reg = <0x00000000 0x01000000>;
> +				};
> +			};
> +		};
> +	};
> +
> +	pci0: pci@e0008000 {
> +		cell-index = <0>;
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
> +		device_type = "pci";
> +		reg = <0xe0008000 0x1000>;
> +		clock-frequency = <33333333>;
> +		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> +		interrupt-map = <
> +				/* IDSEL 28 */
> +				 0xe000 0 0 1 &mpic 2 1
> +				 0xe000 0 0 2 &mpic 3 1>;
> +
> +		interrupt-parent = <&mpic>;
> +		interrupts = <24 2>;
> +		bus-range = <0 0>;
> +		ranges = <0x02000000 0 0x80000000 0x80000000 0 0x20000000
> +			  0x01000000 0 0x00000000 0xe2000000 0 0x01000000>;
> +	};
> +
> +	pci1: pcie@e000a000 {
> +		cell-index = <2>;
> +		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> +		interrupt-map = <
> +			/* IDSEL 0x0 (PEX) */
> +			0x00000 0 0 1 &mpic 0 1
> +			0x00000 0 0 2 &mpic 1 1
> +			0x00000 0 0 3 &mpic 2 1
> +			0x00000 0 0 4 &mpic 3 1>;
> +
> +		interrupt-parent = <&mpic>;
> +		interrupts = <26 2>;
> +		bus-range = <0 0xff>;
> +		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x20000000
> +			  0x01000000 0 0x00000000 0xef000000 0 0x08000000>;
> +		clock-frequency = <33333333>;
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		reg = <0xe000a000 0x1000>;
> +		compatible = "fsl,mpc8548-pcie";
> +		device_type = "pci";
> +		pcie@0 {
> +			reg = <0 0 0 0 0>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			device_type = "pci";
> +			ranges = <0x02000000 0 0xc0000000 0x02000000 0
> +			          0xc0000000 0 0x20000000
> +				  0x01000000 0 0x00000000 0x01000000 0
> +				  0x00000000 0 0x08000000>;
> +		};
> +	};
> +};
> Index: linux-2.6-galak/arch/powerpc/boot/wrapper
> ===================================================================
> --- linux-2.6-galak.orig/arch/powerpc/boot/wrapper
> +++ linux-2.6-galak/arch/powerpc/boot/wrapper
> @@ -177,7 +177,7 @@ cuboot*)
>    *-tqm8541|*-mpc8560*|*-tqm8560|*-tqm8555|*-ksi8560*)
>        platformo=$object/cuboot-85xx-cpm2.o
>        ;;
> -    *-mpc85*|*-tqm8540|*-sbc85*)
> +    *-mpc85*|*-tqm8540|*-tqm8548|*-sbc85*)

why not just *-tqm85*

>
>        platformo=$object/cuboot-85xx.o
>        ;;
>    esac

- k

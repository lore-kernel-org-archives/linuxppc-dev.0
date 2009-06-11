Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8FDFCB7175
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 12:45:32 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D6E0DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 12:45:30 +1000 (EST)
Message-Id: <C934E2FC-7597-4D10-AA2F-F28884D1DD1B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: hs@denx.de
In-Reply-To: <49F7DC0C.3080409@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH v2] 83xx: add support for the kmeter1 board.
Date: Wed, 10 Jun 2009 21:43:07 -0500
References: <49F00605.1080605@denx.de>
	<6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
	<49F544DE.1010307@denx.de>
	<20090427180503.GB10292@ld0162-tx32.am.freescale.net>
	<49F68943.3090800@denx.de>
	<20090428163540.GA2193@ld0162-tx32.am.freescale.net>
	<49F7DC0C.3080409@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 28, 2009, at 11:48 PM, Heiko Schocher wrote:

> The following series implements basic board support for
> the kmeter1 board from keymile, based on a MPC8360.
>
> This series provides the following functionality:
>
> - The board can boot with a serial console on UART1
> - Ethernet:
>    UCC1 in RGMII mode
>    UCC2 in RGMII mode
>    UCC4 in RMII mode
>    UCC5 in RMII mode
>    UCC6 in RMII mode
>    UCC7 in RMII mode
>    UCC8 in RMII mode
>
>    following patch is necessary for working UCC in RMII mode:
>
>    http://ozlabs.org/pipermail/linuxppc-dev/2009-April/070909.html
>
> - Flash accessed via MTD layer
>
>  On this hardware there is an Intel P30 flash, following patch
>  series is necessary for working with this hardware:
>
>  http://ozlabs.org/pipermail/linuxppc-dev/2009-April/070716.html
>
> - I2C using I2C Bus 1 from the MPC8360 cpu
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> changes since v1:
> - added comments from Kumar Gala and Scott Wood
> - get rid of using get_immrbase() in board specific code
>
> $ ./scripts/checkpatch.pl 0001--Patch-v2-83xx-add-support-for-the- 
> kmeter1-board.patch
> total: 0 errors, 0 warnings, 1626 lines checked
>
> 0001--Patch-v2-83xx-add-support-for-the-kmeter1-board.patch has no  
> obvious style problems and is ready for submission.
>
> arch/powerpc/boot/dts/kmeter1.dts           |  513 +++++++++++++++
> arch/powerpc/configs/83xx/kmeter1_defconfig |  908 ++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/83xx/Kconfig         |    7 +
> arch/powerpc/platforms/83xx/Makefile        |    1 +
> arch/powerpc/platforms/83xx/kmeter1.c       |  188 ++++++
> 5 files changed, 1617 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/kmeter1.dts
> create mode 100644 arch/powerpc/configs/83xx/kmeter1_defconfig
> create mode 100644 arch/powerpc/platforms/83xx/kmeter1.c
>
> diff --git a/arch/powerpc/boot/dts/kmeter1.dts b/arch/powerpc/boot/ 
> dts/kmeter1.dts
> new file mode 100644
> index 0000000..63c27da
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/kmeter1.dts
> @@ -0,0 +1,513 @@
> +/*
> + * Keymile KMETER1 Device Tree Source
> + *
> + * 2008 DENX Software Engineering GmbH
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
> +	model = "KMETER1";
> +	compatible = "keymile,KMETER1";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	aliases {
> +		ethernet0 = &enet_piggy2;
> +		ethernet1 = &enet_estar1;
> +		ethernet2 = &enet_estar2;
> +		ethernet3 = &enet_eth1;
> +		ethernet4 = &enet_eth2;
> +		ethernet5 = &enet_eth3;
> +		ethernet6 = &enet_eth4;
> +		serial0 = &serial0;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8360@0 {
> +			device_type = "cpu";
> +			reg = <0x0>;
> +			d-cache-line-size = <32>;	// 32 bytes
> +			i-cache-line-size = <32>;	// 32 bytes
> +			d-cache-size = <32768>;		// L1, 32K
> +			i-cache-size = <32768>;		// L1, 32K
> +			timebase-frequency = <0>;	/* Filled in by U-Boot */
> +			bus-frequency = <0>;	/* Filled in by U-Boot */
> +			clock-frequency = <0>;	/* Filled in by U-Boot */
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0>;	/* Filled in by U-Boot */
> +	};
> +
> +	soc8360@e0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		compatible = "simple-bus";


this should be:

                 compatible = "fsl,mpc8360-immr", "simple-bus";

>
> +		ranges = <0x0 0xe0000000 0x00200000>;
> +		reg = <0xe0000000 0x00000200>;
> +		bus-frequency = <0>;	/* Filled in by U-Boot */
> +

>
> +		ipic: pic@700 {
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			compatible = "fsl,pq2pro-pic", "fsl,ipic";
> +			interrupt-controller;
> +			reg = <0x700 0x100>;
> +			device_type = "ipic";

drop the device_type.

>
> +		};
> +


> +		qe@100000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			device_type = "qe";
> +			compatible = "fsl,qe";
> +			ranges = <0x0 0x100000 0x100000>;
> +			reg = <0x100000 0x480>;
> +			clock-frequency = <0>;	/* Filled in by U-Boot */
> +			brg-frequency = <0>;	/* Filled in by U-Boot */
> +			bus-frequency = <0>;	/* Filled in by U-Boot */
> +
> +


> +
> +			mdio@3320 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x3320 0x18>;
> +				compatible = "fsl,ucc-mdio";
> +
> +				/* Piggy2 (UCC4, MDIO 0x00, RMII) */
> +				phy_piggy2: ethernet-phy@00 {
> +					reg = <0x0>;
> +					device_type = "ethernet-phy";

drop the device_type (and the one's below)

>
> +				};
> +
> +				/* Eth-1 (UCC5, MDIO 0x08, RMII) */
> +				phy_eth1: ethernet-phy@08 {
> +					reg = <0x08>;
> +					device_type = "ethernet-phy";
> +				};
> +
> +				/* Eth-2 (UCC6, MDIO 0x09, RMII) */
> +				phy_eth2: ethernet-phy@09 {
> +					reg = <0x09>;
> +					device_type = "ethernet-phy";
> +				};
> +
> +				/* Eth-3 (UCC7, MDIO 0x0a, RMII) */
> +				phy_eth3: ethernet-phy@0a {
> +					reg = <0x0a>;
> +					device_type = "ethernet-phy";
> +				};
> +
> +				/* Eth-4 (UCC8, MDIO 0x0b, RMII) */
> +				phy_eth4: ethernet-phy@0b {
> +					reg = <0x0b>;
> +					device_type = "ethernet-phy";
> +				};
> +
> +				/* ESTAR-1 (UCC1, MDIO 0x10, RGMII) */
> +				phy_estar1: ethernet-phy@10 {
> +					interrupt-parent = <&ipic>;
> +					interrupts = <17 0x8>;
> +					reg = <0x10>;
> +					device_type = "ethernet-phy";
> +				};
> +
> +				/* ESTAR-2 (UCC2, MDIO 0x11, RGMII) */
> +				phy_estar2: ethernet-phy@11 {
> +					interrupt-parent = <&ipic>;
> +					interrupts = <18 0x8>;
> +					reg = <0x11>;
> +					device_type = "ethernet-phy";
> +				};
> +			};
> +
> +			qeic: interrupt-controller@80 {
> +				interrupt-controller;
> +				compatible = "fsl,qe-ic";
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +				reg = <0x80 0x80>;
> +				interrupts = <32 8 33 8>;
> +				interrupt-parent = <&ipic>;
> +			};
> +		};
> +	};
> +
> +	localbus@e0005000 {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc8360-localbus", "fsl,pq2pro-localbus",
> +			     "simple-bus";
> +		reg = <0xe0005000 0xd8>;
> +		ranges = <0 0 0xf0000000 0x04000000>;	/* Filled in by U-Boot */
> +
> +		flash@f0000000,0 {
> +			compatible = "cfi-flash";
> +			/*
> +			 * The Intel P30 chip has 2 non-identical chips on
> +			 * one die, so we need to define 2 seperate regions
> +			 * that are scanned by physmap_of independantly.
> +			 */
> +			reg = <0 0x00000000 0x02000000
> +			       0 0x02000000 0x02000000>;	/* Filled in by U-Boot */
> +			bank-width = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@0 {
> +				label = "u-boot";
> +				reg = <0 0x40000>;
> +			};
> +			partition@40000 {
> +				label = "env";
> +				reg = <0x40000 0x40000>;
> +			};
> +			partition@80000 {
> +				label = "dtb";
> +				reg = <0x80000 0x20000>;
> +			};
> +			partition@a0000 {
> +				label = "kernel";
> +				reg = <0xa0000 0x300000>;
> +			};
> +			partition@3a0000 {
> +				label = "ramdisk";
> +				reg = <0x3a0000 0x800000>;
> +			};
> +			partition@ba0000 {
> +				label = "user";
> +				reg = <0xba0000 0x3460000>;
> +			};
> +		};
> +	};
> +};

Sorry for taking so long to review this again.

- k

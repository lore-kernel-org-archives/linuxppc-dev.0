Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10119DE084
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 05:54:58 +1000 (EST)
Message-Id: <FE34CD67-1EA9-4A67-8A3A-4A33BB759BC3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20080821144144.fed06908.martyn.welch@gefanuc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 1/2] powerpc: Board support for GE Fanuc SBC610
Date: Thu, 21 Aug 2008 14:54:50 -0500
References: <20080821133852.17201.3862.stgit@welchma.Radstone.Local>
	<20080821144144.fed06908.martyn.welch@gefanuc.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/ 
> boot/dts/gef_sbc610.dts
> new file mode 100644
> index 0000000..32168c6
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/gef_sbc610.dts
> @@ -0,0 +1,268 @@
> +/*
> + * GE Fanuc SBC610 Device Tree Source
> + *
> + * Copyright 2008 GE Fanuc Intelligent Platforms Embedded Systems,  
> Inc.
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + *
> + * Based on: SBS CM6 Device Tree Source
> + * Copyright 2007 SBS Technologies GmbH & Co. KG
> + */
> +
> +/*
> + * Compiled with dtc -I dts -O dtb -o gef_sbc610.dtb gef_sbc610.dts
> + */
> +
> +/dts-v1/;

Look at fixing whitespace (using tabs instead of spaces)

>
> +
> +/ {
> +	model = "GEF_SBC610";
> +	compatible = "gef,sbc610";
> +	#address-cells = <1>;
> +	#size-cells = <1>;

You should add an aliases node and references as newer u-boots expect  
that to setup various properties.

>
> +
> +	cpus {
> +		#cpus = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8641@0 {
> +			device_type = "cpu";
> +			reg = <0x00000000>;
> +			d-cache-line-size = <32>;	// 32 bytes
> +			i-cache-line-size = <32>;	// 32 bytes
> +			d-cache-size = <32768>;		// L1, 32K
> +			i-cache-size = <32768>;		// L1, 32K
> +			timebase-frequency = <0>;	// From uboot
> +			bus-frequency = <0>;		// From uboot
> +			clock-frequency = <0>;		// From uboot
> +			l2cr = <0x80000000>;		// Enable L2
> +			32-bit;
> +		};
> +		PowerPC,8641@1 {
> +			device_type = "cpu";
> +			reg = <0x00000001>;
> +			d-cache-line-size = <32>;	// 32 bytes
> +			i-cache-line-size = <32>;	// 32 bytes
> +			d-cache-size = <32768>;		// L1, 32K
> +			i-cache-size = <32768>;		// L1, 32K
> +			timebase-frequency = <0>;	// From uboot
> +			bus-frequency = <0>;		// From uboot
> +			clock-frequency = <0>;		// From uboot
> +			l2cr = <0x80000000>;		// Enable L2
> +			32-bit;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x40000000>;	// set by u-boot
> +	};
> +
> +	soc8641@fef00000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;
> +		device_type = "soc";
> +		ranges = <0x00000000 0xfef00000 0x00100000>;
> +		reg = <0xfef00000 0x00100000>;	// CCSRBAR 1M
> +		bus-frequency = <0>;
> +
> +		i2c1: i2c@3000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <0x00003000 0x00000100>;
> +			interrupts = <0x2b 0x2>;
> +			interrupt-parent = <&mpic>;
> +			dfsrr;
> +
> +			eti@6b {
> +				compatible = "dallas,ds1682";
> +				reg = <0x0000006b>;
> +			};
> +		};
> +
> +		i2c2: i2c@3100 {
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <0x00003100 0x00000100>;
> +			interrupts = <0x2b 0x2>;
> +			interrupt-parent = <&mpic>;
> +			dfsrr;
> +		};
> +
> +		ecc@2000 {
> +			device_type = "dram-controller";
> +			compatible = "mpc86xx";
> +			reg = <0x00002000 0x00001000>;
> +			interrupts = <0x12 0x2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		ecc@6000 {
> +			device_type = "dram-controller";
> +			compatible = "mpc86xx";
> +			reg = <0x00006000 0x00001000>;
> +			interrupts = <0x12 0x2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +

Take a look at the mpc8572ds.dts for examples of the memctrl device  
nodes

>
> +		dma@21300 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
> +			reg = <0x21300 0x4>;
> +			ranges = <0x0 0x21100 0x200>;
> +			cell-index = <0>;
> +			dma-channel@0 {
> +				compatible = "fsl,mpc8641-dma-channel",
> +					   "fsl,eloplus-dma-channel";
> +				reg = <0x0 0x80>;
> +				cell-index = <0>;
> +				interrupt-parent = <&mpic>;
> +				interrupts = <20 2>;
> +			};
> +			dma-channel@80 {
> +				compatible = "fsl,mpc8641-dma-channel",
> +					   "fsl,eloplus-dma-channel";
> +				reg = <0x80 0x80>;
> +				cell-index = <1>;
> +				interrupt-parent = <&mpic>;
> +				interrupts = <21 2>;
> +			};
> +			dma-channel@100 {
> +				compatible = "fsl,mpc8641-dma-channel",
> +					   "fsl,eloplus-dma-channel";
> +				reg = <0x100 0x80>;
> +				cell-index = <2>;
> +				interrupt-parent = <&mpic>;
> +				interrupts = <22 2>;
> +			};
> +			dma-channel@180 {
> +				compatible = "fsl,mpc8641-dma-channel",
> +					   "fsl,eloplus-dma-channel";
> +				reg = <0x180 0x80>;
> +				cell-index = <3>;
> +				interrupt-parent = <&mpic>;
> +				interrupts = <23 2>;
> +			};
> +		};
> +
> +		mdio@24520 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "mdio";
> +			compatible = "fsl,gianfar-mdio";
> +			reg = <0x00024520 0x00000020>;
> +
> +			phy0: ethernet-phy@0 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <0x0 0x1>;
> +				reg = <0x00000001>;
> +				device_type = "ethernet-phy";

drop device_type
>
> +			};
> +			phy2: ethernet-phy@2 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <0x0 0x1>;
> +				reg = <0x00000003>;
> +				device_type = "ethernet-phy";
> +			};

ditto
>
> +		};
> +
> +		ethernet@24000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x00024000 0x00001000>;
> +			mac-address = [ 00 00 00 00 00 00 ]; // set by u-boot
> +			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy0>;
> +			phy-connection-type = "gmii";
> +		};
> +
> +		ethernet@26000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x00026000 0x00001000>;
> +			mac-address = [ 00 00 00 00 00 00 ]; // set by u-boot
> +			interrupts = <0x1f 0x2 0x20 0x2 0x21 0x2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy2>;
> +			phy-connection-type = "gmii";
> +		};
> +
> +                serial0: serial@4500 {
> +                        cell-index = <0>;
> +                        device_type = "serial";
> +                        compatible = "ns16550";
> +                        reg = <0x00004500 0x00000100>;
> +			clock-frequency = <0>;
> +                        interrupts = <0x2a 0x2>;
> +                        interrupt-parent = <&mpic>;
> +                };
> +
> +                serial1: serial@4600 {
> +                        cell-index = <1>;
> +                        device_type = "serial";
> +                        compatible = "ns16550";
> +                        reg = <0x00004600 0x00000100>;
> +			clock-frequency = <0>;
> +                        interrupts = <0x1c 0x2>;
> +                        interrupt-parent = <&mpic>;
> +                };
> +
> +		mpic: pic@40000 {
> +			clock-frequency = <0>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <0x00040000 0x00040000>;
> +			built-in;
> +			compatible = "chrp,open-pic";
> +			device_type = "open-pic";
> +                        big-endian;
> +		};
> +
> +		global-utilities@e0000 {
> +			compatible = "fsl,mpc8641-guts";
> +			reg = <0x000e0000 0x00001000>;
> +			fsl,has-rstcr;
> +		};
> +
> +	};
> +
> +	pcie@fef08000 {
> +		compatible = "fsl,mpc8641-pcie";
> +		device_type = "pci";
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		reg = <0xfef08000 0x00001000>;
> +		bus-range = <0x0 0xff>;
> +		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
> +			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
> +		clock-frequency = <33333333>;
> +		interrupt-parent = <&mpic>;
> +		interrupts = <0x18 0x2>;
> +		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> +		interrupt-map = <
> +			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
> +			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
> +			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
> +			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1
> +		>;
> +

You need the pcie@0 sub node to represent the virtual P2P bridge.

>
> +	};
> +
> +};

- k

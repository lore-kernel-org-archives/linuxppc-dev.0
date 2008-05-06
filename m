Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A6CADE00A
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 23:37:26 +1000 (EST)
Message-Id: <8D90346B-3E16-4B77-BFF0-35F1FAA1B2B8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Bryan O'Donoghue" <bodonoghue@codehermit.ie>
In-Reply-To: <20080506032813.19e2d07a@neuromancer.mindspace>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Add support for Analogue & Micro ASP837E board
Date: Tue, 6 May 2008 08:37:16 -0500
References: <20080506032813.19e2d07a@neuromancer.mindspace>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> @@ -0,0 +1,247 @@
> +/*
> + * Analogue & Micro ASP8347 Device Tree Source
> + *
> + * Copyright 2008 Codehermit
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
> +	model = "ASP8347E";
> +	compatible = "ASP8347E";

"analogue-and-micro, ASP8347E";

>
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	aliases {
> +		ethernet0 = &enet0;
> +		ethernet1 = &enet1;
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8347@0 {
> +			device_type = "cpu";
> +			reg = <0x0>;
> +			d-cache-line-size = <32>;
> +			i-cache-line-size = <32>;
> +			d-cache-size = <32768>;
> +			i-cache-size = <32768>;
> +			timebase-frequency = <0>;	// from bootloader
> +			bus-frequency = <0>;		// from bootloader
> +			clock-frequency = <0>;		// from bootloader
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x8000000>;	// 128MB at 0

is memory really fixed on this board or does the bootloader set this  
if, dynamic make it <0 0>

>
> +	};
> +
> +	localbus@ff005000 {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc8347e-localbus",
> +			     "fsl,pq2pro-localbus",
> +			     "simple-bus";
> +		reg = <0xff005000 0x1000>;
> +		interrupts = <77 0x8>;
> +		interrupt-parent = <&ipic>;
> +
> +		ranges = <
> +			0 0 0xf0000000 0x02000000
> +		>;
> +
> +		flash@0,0 {
> +			compatible = "cfi-flash";
> +			reg = <0 0 0x02000000>;
> +			bank-width = <2>;
> +			device-width = <2>;
> +		};
> +	};
> +
> +	soc8349@ff000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <0x0 0xff000000 0xff100000>;

this is wrong, size should be like 0x100000

>
> +		reg = <0xff000000 0x00000200>;
> +		bus-frequency = <0>;
> +
> +		wdt@200 {
> +			device_type = "watchdog";
> +			compatible = "mpc83xx_wdt";
> +			reg = <0x200 0x100>;
> +		};
> +
> +		i2c@3000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cell-index = <0>;
> +			compatible = "fsl-i2c";
> +			reg = <0x3000 0x100>;
> +			interrupts = <14 0x8>;
> +			interrupt-parent = <&ipic>;
> +			dfsrr;
> +
> +			rtc@68 {
> +				compatible = "dallas,ds1374";
> +				reg = <0x68>;
> +			};
> +		};
> +
> +		i2c@3100 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cell-index = <1>;
> +			compatible = "fsl-i2c";
> +			reg = <0x3100 0x100>;
> +			interrupts = <15 0x8>;
> +			interrupt-parent = <&ipic>;
> +			dfsrr;
> +		};
> +
> +		spi@7000 {
> +			cell-index = <0>;
> +			compatible = "fsl,spi";
> +			reg = <0x7000 0x1000>;
> +			interrupts = <16 0x8>;
> +			interrupt-parent = <&ipic>;
> +			mode = "cpu";
> +		};
> +
> +		/* phy type (ULPI or SERIAL) are only types supported for MPH */
> +		/* port = 0 or 1 */
> +		usb@22000 {
> +			compatible = "fsl-usb2-mph";
> +			reg = <0x22000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupt-parent = <&ipic>;
> +			interrupts = <39 0x8>;
> +			phy_type = "ulpi";
> +			port1;
> +		};
> +		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
> +		usb@23000 {
> +			compatible = "fsl-usb2-dr";
> +			reg = <0x23000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupt-parent = <&ipic>;
> +			interrupts = <38 0x8>;
> +			dr_mode = "otg";
> +			phy_type = "ulpi";
> +		};
> +
> +		mdio@24520 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl,gianfar-mdio";
> +			reg = <0x24520 0x20>;
> +
> +			phy0: ethernet-phy@0 {
> +				interrupt-parent = <&ipic>;
> +				interrupts = <17 0x8>;
> +				reg = <0x1>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy1: ethernet-phy@1 {
> +				interrupt-parent = <&ipic>;
> +				interrupts = <18 0x8>;
> +				reg = <0x2>;
> +				device_type = "ethernet-phy";
> +			};
> +		};
> +
> +		enet0: ethernet@24000 {
> +			cell-index = <0>;
> +			device_type = "network";
> +			model = "TSEC";
> +			compatible = "gianfar";
> +			reg = <0x24000 0x1000>;
> +			local-mac-address = [ 00 08 e5 11 32 33 ];
> +			interrupts = <32 0x8 33 0x8 34 0x8>;
> +			interrupt-parent = <&ipic>;
> +			phy-handle = <&phy0>;
> +			linux,network-index = <0>;

you shouldn't need this anymore. we should be using the aliases.

>
> +		};
> +
> +		enet1: ethernet@25000 {
> +			cell-index = <1>;
> +			device_type = "network";
> +			model = "TSEC";
> +			compatible = "gianfar";
> +			reg = <0x25000 0x1000>;
> +			local-mac-address = [ 00 08 e5 11 32 34 ];
> +			interrupts = <35 0x8 36 0x8 37 0x8>;
> +			interrupt-parent = <&ipic>;
> +			phy-handle = <&phy1>;
> +			linux,network-index = <1>;

ditto.

>
> +		};
> +
> +		serial0: serial@4500 {
> +			cell-index = <0>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <0x4500 0x100>;
> +			clock-frequency = <400000000>;
> +			interrupts = <9 0x8>;
> +			interrupt-parent = <&ipic>;
> +		};
> +
> +		serial1: serial@4600 {
> +			cell-index = <1>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <0x4600 0x100>;
> +			clock-frequency = <400000000>;
> +			interrupts = <10 0x8>;
> +			interrupt-parent = <&ipic>;
> +		};
> +
> +		/* May need to remove if on a part without crypto engine */
> +		crypto@30000 {
> +			device_type = "crypto";
> +			model = "SEC2";
> +			compatible = "talitos";
> +			reg = <0x30000 0x10000>;
> +			interrupts = <11 0x8>;
> +			interrupt-parent = <&ipic>;
> +			num-channels = <4>;
> +			channel-fifo-len = <24>;
> +			exec-units-mask = <0x0000007e>;
> +			/* desc mask is for rev2.0,
> +			 * we need runtime fixup for >2.0 */
> +			descriptor-types-mask = <0x01010ebf>;
> +		};
> +
> +		/* IPIC
> +		 * interrupts cell = <intr #, sense>
> +		 * sense values match linux IORESOURCE_IRQ_* defines:
> +		 * sense == 8: Level, low assertion
> +		 * sense == 2: Edge, high-to-low change
> +		 */
> +		ipic: pic@700 {
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <0x700 0x100>;
> +			device_type = "ipic";
> +		};
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,38400 root=/dev/mtdblock3  
> rootfstype=jffs2";
> +		linux,stdout-path = &serial0;
> +	};
> +
> +};

- k

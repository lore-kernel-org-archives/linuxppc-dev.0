Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E4F8DDEF3
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 05:42:27 +1100 (EST)
Message-Id: <10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20071210202934.GA32046@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Date: Tue, 11 Dec 2007 12:42:18 -0600
References: <20071210202934.GA32046@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 10, 2007, at 2:29 PM, Anton Vorontsov wrote:

> This is new board made by Freescale Semiconductor Inc. and
> Logic Product Development.
>
> Currently supported:
> 1. UEC1,2 (UEC2 doesn't work, but I'm sure this is firmware issue)
> 2. I2C
> 3. SPI
> 4. NS16550 serial
>
> Not supported so far:
> 1. StMICRO NAND512W3A2BN6E, 512 Mbit
> 2. UEC3,4
> 3. QE SCCs (slow UCCs)
> 4. PCI
> 5. ADC AD7843
> 6. FHCI USB
> 7. Graphics controller, Fujitsu MB86277
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> Hi all,
>
> That patch is early RFC:
>
> I tend to submit patches just as they are mature enough, thus not bomb
> the list with long queues or huge patches. After I'll fix all upcoming
> issues with that basic support, it would be great if someone will
> merge it, thus I can start do incremental patches supporting this or
> that.
>
> Below is MPC8360E-RDK basic support. I'm following latest fashion,
> so dts is v1. ;-)
>
> Thanks,
>
> p.s. not sending defconfig yet.
>
> arch/powerpc/boot/dts/mpc836x_rdk.dts     |  232 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/83xx/Kconfig       |   10 +-
> arch/powerpc/platforms/83xx/Makefile      |    1 +
> arch/powerpc/platforms/83xx/mpc836x_rdk.c |  109 ++++++++++++++
> 4 files changed, 351 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/mpc836x_rdk.dts
> create mode 100644 arch/powerpc/platforms/83xx/mpc836x_rdk.c
>
> diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/ 
> boot/dts/mpc836x_rdk.dts
> new file mode 100644
> index 0000000..a3b37e8
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
> @@ -0,0 +1,232 @@
> +/*
> + * MPC8360E RDK Device Tree Source
> + *
> + * Copyright 2006 Freescale Semiconductor Inc.
> + * Copyright 2007 MontaVista Software, Inc.
> + * 		  Anton Vorontsov <avorontsov@ru.mvista.com>
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
> +	model = "MPC8360RDK";
> +	compatible = "MPC8360ERDK", "MPC836xRDK", "MPC83xxRDK";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +

let's go ahead w/an aliases node:

	aliases {
		ethernet0 = &enet0;
		ethernet1 = &enet1;
		...
		serial0 = &serial0;
		serial1 = &serial1;
	};

>
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8360@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <32>;
> +			i-cache-line-size = <32>;
> +			d-cache-size = <32768>;
> +			i-cache-size = <32768>;
> +			timebase-frequency = <0>; /* filled by u-boot */
> +			bus-frequency = <0>; /* filled by u-boot */
> +			clock-frequency = <0>; /* filled by u-boot */
> +		};
> +	};
> +
> +	soc8360@e0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <0 0xe0000000 0x00100000>;
> +		reg = <0xe0000000 0x00000200>;
> +		bus-frequency = <0>; /* filled by u-boot */
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
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <0x3000 0x100>;
> +			interrupts = <14 8>;
> +			interrupt-parent = <&ipic>;
> +			dfsrr;
> +		};
> +
> +		i2c@3100 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <0x3100 0x100>;
> +			interrupts = <16 8>;
> +			interrupt-parent = <&ipic>;
> +			dfsrr;
> +		};
> +

Add serial labels:
		serial0: serial@4500 {...
>
> +		serial@4500 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <0x4500 0x100>;
> +			clock-frequency = <0>;
> +			interrupts = <9 8>;
> +			interrupt-parent = <&ipic>;
> +		};
> +
> +		serial@4600 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <0x4600 0x100>;
> +			clock-frequency = <0>;
> +			interrupts = <10 8>;
> +			interrupt-parent = <&ipic>;
> +		};
> +
> +		crypto@30000 {
> +			device_type = "crypto";
> +			model = "SEC2";
> +			compatible = "talitos";
> +			reg = <0x30000 0x10000>;
> +			interrupts = <11 8>;
> +			interrupt-parent = <&ipic>;
> +			num-channels = <4>;
> +			channel-fifo-len = <24>;
> +			exec-units-mask = <0x0000007e>;
> +			/*
> +			 * desc mask is for rev1.x, we need runtime fixup
> +			 * for >=2.x
> +			 */
> +			descriptor-types-mask = <0x01010ebf>;
> +		};
> +
> +		ipic: pic@700 {
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <0x700 0x100>;
> +			device_type = "ipic";
> +		};
> +
> +		par_io@1400 {
> +			reg = <0x1400 0x100>;
> +			num-ports = <7>;
> +		};
> +	};
> +
> +	qe@e0100000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "qe";
> +		model = "QE";
> +		ranges = <0 0xe0100000 0x00100000>;
> +		reg = <0xe0100000 0x480>;
> +		brg-frequency = <0>; /* filled by u-boot */
> +		bus-frequency = <0>; /* filled by u-boot */
> +
> +		muram@10000 {
> +			device_type = "muram";
> +			ranges = <0 0x00010000 0x0000c000>;
> +
> +			data-only@0 {
> +				reg = <0 0xc000>;
> +			};
> +		};
> +
> +		spi@4c0 {
> +			device_type = "spi";
> +			compatible = "fsl_spi";
> +			reg = <0x4c0 0x40>;
> +			interrupts = <2>;
> +			interrupt-parent = <&qeic>;
> +			mode = "cpu";
> +		};
> +
> +		spi@500 {
> +			device_type = "spi";
> +			compatible = "fsl_spi";
> +			reg = <0x500 0x40>;
> +			interrupts = <1>;
> +			interrupt-parent = <&qeic>;
> +			mode = "cpu";
> +		};
> +
> +		usb@6c0 {
> +			device_type = "usb";
> +			compatible = "qe_udc";
> +			reg = <0x6c0 0x40 0x8b00 0x100>;
> +			interrupts = <11>;
> +			interrupt-parent = <&qeic>;
> +			mode = "slave";
> +		};
> +
		ethernet labels
>
> +		ucc@2000 {
> +			device_type = "network";
> +			compatible = "ucc_geth";
> +			model = "UCC";
> +			device-id = <1>;
> +			reg = <0x2000 0x200>;
> +			interrupts = <32>;
> +			interrupt-parent = <&qeic>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			rx-clock = <0>;
> +			tx-clock = <25>;
> +			phy-handle = <&phy2>;
> +			phy-connection-type = "rgmii-id";
> +		};
> +
> +		ucc@3000 {
> +			device_type = "network";
> +			compatible = "ucc_geth";
> +			model = "UCC";
> +			device-id = <2>;
> +			reg = <0x3000 0x200>;
> +			interrupts = <33>;
> +			interrupt-parent = <&qeic>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			rx-clock = <0>;
> +			tx-clock = <20>;
> +			phy-handle = <&phy4>;
> +			phy-connection-type = "rgmii-id";
> +		};
> +
> +		mdio@2120 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2120 0x18>;
> +			device_type = "mdio";
> +			compatible = "ucc_geth_phy";
> +
> +			phy2: ethernet-phy@02 {
> +				interrupt-parent = <&ipic>;
> +				/*interrupts = <17 8>;*/
> +				reg = <2>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy4: ethernet-phy@04 {
> +				interrupt-parent = <&ipic>;
> +				/*interrupts = <18 8>;*/
> +				reg = <4>;
> +				device_type = "ethernet-phy";
> +			};
> +		};
> +
> +		qeic: qeic@80 {
> +			interrupt-controller;
> +			device_type = "qeic";
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			reg = <0x80 0x80>;
> +			big-endian;
> +			interrupts = <32 8 33 8>;
> +			interrupt-parent = <&ipic>;
> +		};
> +	};
> +};


- k

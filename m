Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56A9EDE152
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 00:25:39 +1000 (EST)
Message-Id: <6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: hs@denx.de
In-Reply-To: <49F00605.1080605@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] 83xx: add support for the kmeter1 board.
Date: Thu, 23 Apr 2009 09:25:13 -0500
References: <49F00605.1080605@denx.de>
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
> diff --git a/arch/powerpc/boot/dts/kmeter1.dts b/arch/powerpc/boot/ 
> dts/kmeter1.dts
> new file mode 100644
> index 0000000..4f343ca
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/kmeter1.dts
> @@ -0,0 +1,518 @@
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
> +
> +/*
> +/memreserve/	00000000 1000000;
> +*/

is this needed for something?

>
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
> +			timebase-frequency = <66000000>;
> +			bus-frequency = <264000000>;
> +			clock-frequency = <528000000>;

is the board running at a fixed frequency that isn't possible to change?

> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x10000000>;
> +	};

does u-boot not set this?  Also is the amount of memory fixed?

> +
> +	soc8360@e0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		compatible = "simple-bus";
> +		ranges = <0x0 0xe0000000 0x00100000>;
> +		reg = <0xe0000000 0x00000200>;
> +		bus-frequency = <264000000>;
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
> +		};
> +
> +		serial0: serial@4500 {
> +			cell-index = <0>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <0x4500 0x100>;
> +			clock-frequency = <264000000>;
> +			interrupts = <9 0x8>;
> +			interrupt-parent = <&ipic>;
> +		};
> +
> +		dma@82a8 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,mpc8360-dma", "fsl,elo-dma";
> +			reg = <0x82a8 4>;
> +			ranges = <0 0x8100 0x1a8>;
> +			interrupt-parent = <&ipic>;
> +			interrupts = <71 8>;
> +			cell-index = <0>;
> +			dma-channel@0 {
> +				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
> +				reg = <0 0x80>;
> +				interrupt-parent = <&ipic>;
> +				interrupts = <71 8>;
> +			};
> +			dma-channel@80 {
> +				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
> +				reg = <0x80 0x80>;
> +				interrupt-parent = <&ipic>;
> +				interrupts = <71 8>;
> +			};
> +			dma-channel@100 {
> +				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
> +				reg = <0x100 0x80>;
> +				interrupt-parent = <&ipic>;
> +				interrupts = <71 8>;
> +			};
> +			dma-channel@180 {
> +				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
> +				reg = <0x180 0x28>;
> +				interrupt-parent = <&ipic>;
> +				interrupts = <71 8>;
> +			};
> +		};
> +
> +		ipic: pic@700 {
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			compatible = "fsl,pq2pro-pic", "fsl,ipic";
> +			interrupt-controller;
> +			reg = <0x700 0x100>;
> +			device_type = "ipic";
> +		};
> +
> +		par_io@1400 {
> +			reg = <0x1400 0x100>;
> +			device_type = "par_io";
> +			num-ports = <7>;
> +
> +			pio_ucc1: ucc_pin@00 {
> +				pio-map = <
> +					/* port pin dir open_drain assignment has_irq */
> +					0   1  3  0  2  0	/* MDIO   */
> +					0   2  1  0  1  0	/* MDC    */
> +
> +					0   3  1  0  1  0	/* TxD0   */
> +					0   4  1  0  1  0	/* TxD1   */
> +					0   5  1  0  1  0	/* TxD2   */
> +					0   6  1  0  1  0	/* TxD3   */
> +					0   9  2  0  1  0	/* RxD0   */
> +					0  10  2  0  1  0	/* RxD1   */
> +					0  11  2  0  1  0	/* RxD2   */
> +					0  12  2  0  1  0	/* RxD3   */
> +					0   7  1  0  1  0	/* TX_EN  */
> +					0   8  1  0  1  0	/* TX_ER  */
> +					0  15  2  0  1  0	/* RX_DV  */
> +					0  16  2  0  1  0	/* RX_ER  */
> +					0   0  2  0  1  0	/* RX_CLK */
> +					2   9  1  0  3  0	/* GTX_CLK - CLK10 */
> +					2   8  2  0  1  0	/* GTX125  - CLK9  */
> +				>;
> +			};
> +
> +			pio_ucc2: ucc_pin@01 {
> +				pio-map = <
> +					/* port pin dir open_drain assignment has_irq */
> +					0   1  3  0  2  0	/* MDIO   */
> +					0   2  1  0  1  0	/* MDC    */
> +
> +					0  17  1  0  1  0	/* TxD0   */
> +					0  18  1  0  1  0	/* TxD1   */
> +					0  19  1  0  1  0	/* TxD2   */
> +					0  20  1  0  1  0	/* TxD3   */
> +					0  23  2  0  1  0	/* RxD0   */
> +					0  24  2  0  1  0	/* RxD1   */
> +					0  25  2  0  1  0	/* RxD2   */
> +					0  26  2  0  1  0	/* RxD3   */
> +					0  21  1  0  1  0	/* TX_EN  */
> +					0  22  1  0  1  0	/* TX_ER  */
> +					0  29  2  0  1  0	/* RX_DV  */
> +					0  30  2  0  1  0	/* RX_ER  */
> +					0  31  2  0  1  0	/* RX_CLK */
> +					2  2   1  0  2  0	/* GTX_CLK - CLK3  */
> +					2  3   2  0  1  0	/* GTX125  - CLK4  */
> +				>;
> +			};
> +
> +			pio_ucc4: ucc_pin@03 {
> +				pio-map = <
> +					/* port pin dir open_drain assignment has_irq */
> +					0   1  3  0  2  0	/* MDIO */
> +					0   2  1  0  1  0	/* MDC  */
> +
> +					1  14  1  0  1  0	/* TxD0   (PB14, out, f1) */
> +					1  15  1  0  1  0	/* TxD1   (PB15, out, f1) */
> +					1  20  2  0  1  0	/* RxD0   (PB20, in,  f1) */
> +					1  21  2  0  1  0	/* RxD1   (PB21, in,  f1) */
> +					1  18  1  0  1  0	/* TX_EN  (PB18, out, f1) */
> +					1  26  2  0  1  0	/* RX_DV  (PB26, in,  f1) */
> +					1  27  2  0  1  0	/* RX_ER  (PB27, in,  f1) */
> +
> +					2  16  2  0  1  0	/* UCC4_RMII_CLK (CLK17) */
> +				>;
> +			};
> +
> +			pio_ucc5: ucc_pin@04 {
> +				pio-map = <
> +					/* port pin dir open_drain assignment has_irq */
> +					0   1  3  0  2  0	/* MDIO */
> +					0   2  1  0  1  0	/* MDC  */
> +
> +					3   0  1  0  1  0	/* TxD0  (PD0,  out, f1) */
> +					3   1  1  0  1  0	/* TxD1  (PD1,  out, f1) */
> +					3   6  2  0  1  0	/* RxD0  (PD6,   in, f1) */
> +					3   7  2  0  1  0	/* RxD1  (PD7,   in, f1) */
> +					3   4  1  0  1  0	/* TX_EN (PD4,  out, f1) */
> +					3  12  2  0  1  0	/* RX_DV (PD12,  in, f1) */
> +					3  13  2  0  1  0	/* RX_ER (PD13,  in, f1) */
> +				>;
> +			};
> +
> +			pio_ucc6: ucc_pin@05 {
> +				pio-map = <
> +					/* port pin dir open_drain assignment has_irq */
> +					0   1  3  0  2  0	/* MDIO */
> +					0   2  1  0  1  0	/* MDC  */
> +
> +					3  14  1  0  1  0	/* TxD0   (PD14, out, f1) */
> +					3  15  1  0  1  0	/* TxD1   (PD15, out, f1) */
> +					3  20  2  0  1  0	/* RxD0   (PD20, in,  f1) */
> +					3  21  2  0  1  0	/* RxD1   (PD21, in,  f1) */
> +					3  18  1  0  1  0	/* TX_EN  (PD18, out, f1) */
> +					3  26  2  0  1  0	/* RX_DV  (PD26, in,  f1) */
> +					3  27  2  0  1  0	/* RX_ER  (PD27, in,  f1) */
> +				>;
> +			};
> +
> +			pio_ucc7: ucc_pin@06 {
> +				pio-map = <
> +					/* port pin dir open_drain assignment has_irq */
> +					0   1  3  0  2  0	/* MDIO */
> +					0   2  1  0  1  0	/* MDC  */
> +
> +					4   0  1  0  1  0	/* TxD0   (PE0,  out, f1) */
> +					4   1  1  0  1  0	/* TxD1   (PE1,  out, f1) */
> +					4   6  2  0  1  0	/* RxD0   (PE6,   in, f1) */
> +					4   7  2  0  1  0	/* RxD1   (PE7,   in, f1) */
> +					4   4  1  0  1  0	/* TX_EN  (PE4,  out, f1) */
> +					4  12  2  0  1  0	/* RX_DV  (PE12,  in, f1) */
> +					4  13  2  0  1  0	/* RX_ER  (PE13,  in, f1) */
> +				>;
> +			};
> +
> +			pio_ucc8: ucc_pin@07 {
> +				pio-map = <
> +					/* port pin dir open_drain assignment has_irq */
> +					0   1  3  0  2  0	/* MDIO */
> +					0   2  1  0  1  0	/* MDC  */
> +
> +					4  14  1  0  2  0	/* TxD0   (PE14, out, f2) */
> +					4  15  1  0  1  0	/* TxD1   (PE15, out, f1) */
> +					4  20  2  0  1  0	/* RxD0   (PE20, in,  f1) */
> +					4  21  2  0  1  0	/* RxD1   (PE21, in,  f1) */
> +					4  18  1  0  1  0	/* TX_EN  (PE18, out, f1) */
> +					4  26  2  0  1  0	/* RX_DV  (PE26, in,  f1) */
> +					4  27  2  0  1  0	/* RX_ER  (PE27, in,  f1) */
> +
> +					2  15  2  0  1  0	/* UCCx_RMII_CLK (CLK16) */
> +				>;
> +			};
> +
> +		};
> +	};
> +
> +	qe@e0100000 {

why isn't this under the SOC?

>
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "qe";
> +		compatible = "fsl,qe";
> +		ranges = <0x0 0xe0100000 0x00100000>;
> +		reg = <0xe0100000 0x480>;
> +		brg-frequency = <0>;
> +		bus-frequency = <396000000>;
> +
> +		muram@10000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,qe-muram", "fsl,cpm-muram";
> +			ranges = <0x0 0x00010000 0x0000c000>;
> +
> +			data-only@0 {
> +				compatible = "fsl,qe-muram-data",
> +					     "fsl,cpm-muram-data";
> +				reg = <0x0 0xc000>;
> +			};
> +		};
> +
> +		/* ESTAR-1 (UCC1, MDIO 0x10, RGMII) */
> +		enet_estar1: ucc@2000 {
> +			device_type = "network";
> +			compatible = "ucc_geth";
> +			cell-index = <1>;
> +			reg = <0x2000 0x200>;
> +			interrupts = <32>;
> +			interrupt-parent = <&qeic>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			rx-clock-name = "none";
> +			tx-clock-name = "clk9";
> +			phy-handle = <&phy_estar1>;
> +			phy-connection-type = "rgmii-id";
> +			pio-handle = <&pio_ucc1>;
> +		};
> +
> +		/* ESTAR-2 (UCC2, MDIO 0x11, RGMII) */
> +		enet_estar2: ucc@3000 {
> +			device_type = "network";
> +			compatible = "ucc_geth";
> +			cell-index = <2>;
> +			reg = <0x3000 0x200>;
> +			interrupts = <33>;
> +			interrupt-parent = <&qeic>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			rx-clock-name = "none";
> +			tx-clock-name = "clk4";
> +			phy-handle = <&phy_estar2>;
> +			phy-connection-type = "rgmii-id";
> +			pio-handle = <&pio_ucc2>;
> +		};
> +
> +		/* Piggy2 (UCC4, MDIO 0x00, RMII) */
> +		enet_piggy2: ucc@3200 {
> +			device_type = "network";
> +			compatible = "ucc_geth";
> +			cell-index = <4>;
> +			reg = <0x3200 0x200>;
> +			interrupts = <35>;
> +			interrupt-parent = <&qeic>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			rx-clock-name = "none";
> +			tx-clock-name = "clk17";
> +			phy-handle = <&phy_piggy2>;
> +			phy-connection-type = "rmii";
> +			pio-handle = <&pio_ucc4>;
> +		};
> +
> +		/* Eth-1 (UCC5, MDIO 0x08, RMII) */
> +		enet_eth1: ucc@2400 {
> +			device_type = "network";
> +			compatible = "ucc_geth";
> +			cell-index = <5>;
> +			reg = <0x2400 0x200>;
> +			interrupts = <40>;
> +			interrupt-parent = <&qeic>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			rx-clock-name = "none";
> +			tx-clock-name = "clk16";
> +			phy-handle = <&phy_eth1>;
> +			phy-connection-type = "rmii";
> +			pio-handle = <&pio_ucc5>;
> +		};
> +
> +		/* Eth-2 (UCC6, MDIO 0x09, RMII) */
> +		enet_eth2: ucc@3400 {
> +			device_type = "network";
> +			compatible = "ucc_geth";
> +			cell-index = <6>;
> +			reg = <0x3400 0x200>;
> +			interrupts = <41>;
> +			interrupt-parent = <&qeic>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			rx-clock-name = "none";
> +			tx-clock-name = "clk16";
> +			phy-handle = <&phy_eth2>;
> +			phy-connection-type = "rmii";
> +			pio-handle = <&pio_ucc6>;
> +		};
> +
> +		/* Eth-3 (UCC7, MDIO 0x0a, RMII) */
> +		enet_eth3: ucc@2600 {
> +			device_type = "network";
> +			compatible = "ucc_geth";
> +			cell-index = <7>;
> +			reg = <0x2600 0x200>;
> +			interrupts = <42>;
> +			interrupt-parent = <&qeic>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			rx-clock-name = "none";
> +			tx-clock-name = "clk16";
> +			phy-handle = <&phy_eth3>;
> +			phy-connection-type = "rmii";
> +			pio-handle = <&pio_ucc7>;
> +		};
> +
> +		/* Eth-4 (UCC8, MDIO 0x0b, RMII) */
> +		enet_eth4: ucc@3600 {
> +			device_type = "network";
> +			compatible = "ucc_geth";
> +			cell-index = <8>;
> +			reg = <0x3600 0x200>;
> +			interrupts = <43>;
> +			interrupt-parent = <&qeic>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			rx-clock-name = "none";
> +			tx-clock-name = "clk16";
> +			phy-handle = <&phy_eth4>;
> +			phy-connection-type = "rmii";
> +			pio-handle = <&pio_ucc8>;
> +		};
> +
> +		mdio@3320 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x3320 0x18>;
> +			compatible = "fsl,ucc-mdio";
> +
> +			/* Piggy2 (UCC4, MDIO 0x00, RMII) */
> +			phy_piggy2: ethernet-phy@00 {
> +				reg = <0x0>;
> +				device_type = "ethernet-phy";
> +			};
> +
> +			/* Eth-1 (UCC5, MDIO 0x08, RMII) */
> +			phy_eth1: ethernet-phy@08 {
> +				reg = <0x08>;
> +				device_type = "ethernet-phy";
> +			};
> +
> +			/* Eth-2 (UCC6, MDIO 0x09, RMII) */
> +			phy_eth2: ethernet-phy@09 {
> +				reg = <0x09>;
> +				device_type = "ethernet-phy";
> +			};
> +
> +			/* Eth-3 (UCC7, MDIO 0x0a, RMII) */
> +			phy_eth3: ethernet-phy@0a {
> +				reg = <0x0a>;
> +				device_type = "ethernet-phy";
> +			};
> +
> +			/* Eth-4 (UCC8, MDIO 0x0b, RMII) */
> +			phy_eth4: ethernet-phy@0b {
> +				reg = <0x0b>;
> +				device_type = "ethernet-phy";
> +			};
> +
> +			/* ESTAR-1 (UCC1, MDIO 0x10, RGMII) */
> +			phy_estar1: ethernet-phy@10 {
> +				interrupt-parent = <&ipic>;
> +				interrupts = <17 0x8>;
> +				reg = <0x10>;
> +				device_type = "ethernet-phy";
> +			};
> +
> +			/* ESTAR-2 (UCC2, MDIO 0x11, RGMII) */
> +			phy_estar2: ethernet-phy@11 {
> +				interrupt-parent = <&ipic>;
> +				interrupts = <18 0x8>;
> +				reg = <0x11>;
> +				device_type = "ethernet-phy";
> +			};
> +		};
> +
> +		qeic: interrupt-controller@80 {
> +			interrupt-controller;
> +			compatible = "fsl,qe-ic";
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			reg = <0x80 0x80>;
> +			big-endian;

seems unnecessary .. the qe is only big-endian.

> +			interrupts = <32 8 33 8>;
> +			interrupt-parent = <&ipic>;
> +		};
> +	};


> diff --git a/arch/powerpc/platforms/83xx/kmeter1.c b/arch/powerpc/ 
> platforms/83xx/kmeter1.c
> new file mode 100644
> index 0000000..99cf5c6
> --- /dev/null
> +++ b/arch/powerpc/platforms/83xx/kmeter1.c
> @@ -0,0 +1,170 @@
> +/*
> + * Copyright 2008 DENX Software Engineering GmbH
> + * Author: Heiko Schocher <hs@denx.de>
> + *
> + * Description:
> + * Keymile KMETER1 board specific routines.
> + *
> + * This program is free software; you can redistribute it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/reboot.h>
> +#include <linux/pci.h>
> +#include <linux/kdev_t.h>
> +#include <linux/major.h>
> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/seq_file.h>
> +#include <linux/root_dev.h>
> +#include <linux/initrd.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_device.h>
> +
> +#include <asm/system.h>
> +#include <asm/atomic.h>
> +#include <asm/time.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/ipic.h>
> +#include <asm/irq.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <sysdev/fsl_soc.h>
> +#include <sysdev/fsl_pci.h>
> +#include <asm/qe.h>
> +#include <asm/qe_ic.h>
> +
> +#include "mpc83xx.h"
> +
> +/*  
> ************************************************************************
> + *
> + * Setup the architecture
> + *
> + */
> +static void __init kmeter1_setup_arch(void)
> +{
> +	struct device_node *np;
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("kmeter1_setup_arch()", 0);
> +
> +#ifdef CONFIG_PCI
> +	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
> +		mpc83xx_add_bridge(np);
> +#endif
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +	qe_reset();
> +
> +	np = of_find_node_by_name(NULL, "par_io");
> +	if (np != NULL) {
> +		par_io_init(np);
> +		of_node_put(np);
> +
> +		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
> +			par_io_of_config(np);
> +	}
> +
> +	np = of_find_compatible_node(NULL, "network", "ucc_geth");
> +	if (np != NULL) {
> +		uint svid;
> +
> +		/* handle mpc8360ea rev.2.1 erratum 2: RGMII Timing */
> +		svid = mfspr(SPRN_SVR);
> +		if (svid == 0x80480021) {
> +			void __iomem *immap;
> +
> +			immap = ioremap(get_immrbase() + 0x14a8, 8);

we should add a proper device node to cover whatever register space  
this is.

>
> +
> +			/*
> +			 * IMMR + 0x14A8[4:5] = 11 (clk delay for UCC 2)
> +			 * IMMR + 0x14A8[18:19] = 11 (clk delay for UCC 1)
> +			 */
> +			setbits32(immap, 0x0c003000);
> +
> +			/*
> +			 * IMMR + 0x14AC[20:27] = 10101010
> +			 * (data delay for both UCC's)
> +			 */
> +			clrsetbits_be32(immap + 4, 0xff0, 0xaa0);
> +			iounmap(immap);
> +		}
> +		of_node_put(np);
> +	}
> +#endif				/* CONFIG_QUICC_ENGINE */
> +}
> +

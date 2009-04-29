Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7AC71DDEEC
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 16:06:14 +1000 (EST)
Message-ID: <49F7DC0C.3080409@denx.de>
Date: Wed, 29 Apr 2009 06:48:12 +0200
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2] 83xx: add support for the kmeter1 board.
References: <49F00605.1080605@denx.de>
	<6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
	<49F544DE.1010307@denx.de>
	<20090427180503.GB10292@ld0162-tx32.am.freescale.net>
	<49F68943.3090800@denx.de>
	<20090428163540.GA2193@ld0162-tx32.am.freescale.net>
In-Reply-To: <20090428163540.GA2193@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series implements basic board support for
the kmeter1 board from keymile, based on a MPC8360.

This series provides the following functionality:

- The board can boot with a serial console on UART1
- Ethernet:
    UCC1 in RGMII mode
    UCC2 in RGMII mode
    UCC4 in RMII mode
    UCC5 in RMII mode
    UCC6 in RMII mode
    UCC7 in RMII mode
    UCC8 in RMII mode

    following patch is necessary for working UCC in RMII mode:

    http://ozlabs.org/pipermail/linuxppc-dev/2009-April/070909.html

- Flash accessed via MTD layer

  On this hardware there is an Intel P30 flash, following patch
  series is necessary for working with this hardware:

  http://ozlabs.org/pipermail/linuxppc-dev/2009-April/070716.html

- I2C using I2C Bus 1 from the MPC8360 cpu

Signed-off-by: Heiko Schocher <hs@denx.de>
---
changes since v1:
- added comments from Kumar Gala and Scott Wood
- get rid of using get_immrbase() in board specific code

$ ./scripts/checkpatch.pl 0001--Patch-v2-83xx-add-support-for-the-kmeter1-board.patch
total: 0 errors, 0 warnings, 1626 lines checked

0001--Patch-v2-83xx-add-support-for-the-kmeter1-board.patch has no obvious style problems and is ready for submission.

 arch/powerpc/boot/dts/kmeter1.dts           |  513 +++++++++++++++
 arch/powerpc/configs/83xx/kmeter1_defconfig |  908 +++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/Kconfig         |    7 +
 arch/powerpc/platforms/83xx/Makefile        |    1 +
 arch/powerpc/platforms/83xx/kmeter1.c       |  188 ++++++
 5 files changed, 1617 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/kmeter1.dts
 create mode 100644 arch/powerpc/configs/83xx/kmeter1_defconfig
 create mode 100644 arch/powerpc/platforms/83xx/kmeter1.c

diff --git a/arch/powerpc/boot/dts/kmeter1.dts b/arch/powerpc/boot/dts/kmeter1.dts
new file mode 100644
index 0000000..63c27da
--- /dev/null
+++ b/arch/powerpc/boot/dts/kmeter1.dts
@@ -0,0 +1,513 @@
+/*
+ * Keymile KMETER1 Device Tree Source
+ *
+ * 2008 DENX Software Engineering GmbH
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "KMETER1";
+	compatible = "keymile,KMETER1";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet_piggy2;
+		ethernet1 = &enet_estar1;
+		ethernet2 = &enet_estar2;
+		ethernet3 = &enet_eth1;
+		ethernet4 = &enet_eth2;
+		ethernet5 = &enet_eth3;
+		ethernet6 = &enet_eth4;
+		serial0 = &serial0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8360@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	/* Filled in by U-Boot */
+			bus-frequency = <0>;	/* Filled in by U-Boot */
+			clock-frequency = <0>;	/* Filled in by U-Boot */
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0>;	/* Filled in by U-Boot */
+	};
+
+	soc8360@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "simple-bus";
+		ranges = <0x0 0xe0000000 0x00200000>;
+		reg = <0xe0000000 0x00000200>;
+		bus-frequency = <0>;	/* Filled in by U-Boot */
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <14 0x8>;
+			interrupt-parent = <&ipic>;
+			dfsrr;
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <264000000>;
+			interrupts = <9 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8360-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
+		ipic: pic@700 {
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			compatible = "fsl,pq2pro-pic", "fsl,ipic";
+			interrupt-controller;
+			reg = <0x700 0x100>;
+			device_type = "ipic";
+		};
+
+		par_io@1400 {
+			reg = <0x1400 0x100>;
+			device_type = "par_io";
+			num-ports = <7>;
+
+			pio_ucc1: ucc_pin@00 {
+				pio-map = <
+					/* port pin dir open_drain assignment has_irq */
+					0   1  3  0  2  0	/* MDIO   */
+					0   2  1  0  1  0	/* MDC    */
+
+					0   3  1  0  1  0	/* TxD0   */
+					0   4  1  0  1  0	/* TxD1   */
+					0   5  1  0  1  0	/* TxD2   */
+					0   6  1  0  1  0	/* TxD3   */
+					0   9  2  0  1  0	/* RxD0   */
+					0  10  2  0  1  0	/* RxD1   */
+					0  11  2  0  1  0	/* RxD2   */
+					0  12  2  0  1  0	/* RxD3   */
+					0   7  1  0  1  0	/* TX_EN  */
+					0   8  1  0  1  0	/* TX_ER  */
+					0  15  2  0  1  0	/* RX_DV  */
+					0  16  2  0  1  0	/* RX_ER  */
+					0   0  2  0  1  0	/* RX_CLK */
+					2   9  1  0  3  0	/* GTX_CLK - CLK10 */
+					2   8  2  0  1  0	/* GTX125  - CLK9  */
+				>;
+			};
+
+			pio_ucc2: ucc_pin@01 {
+				pio-map = <
+					/* port pin dir open_drain assignment has_irq */
+					0   1  3  0  2  0	/* MDIO   */
+					0   2  1  0  1  0	/* MDC    */
+
+					0  17  1  0  1  0	/* TxD0   */
+					0  18  1  0  1  0	/* TxD1   */
+					0  19  1  0  1  0	/* TxD2   */
+					0  20  1  0  1  0	/* TxD3   */
+					0  23  2  0  1  0	/* RxD0   */
+					0  24  2  0  1  0	/* RxD1   */
+					0  25  2  0  1  0	/* RxD2   */
+					0  26  2  0  1  0	/* RxD3   */
+					0  21  1  0  1  0	/* TX_EN  */
+					0  22  1  0  1  0	/* TX_ER  */
+					0  29  2  0  1  0	/* RX_DV  */
+					0  30  2  0  1  0	/* RX_ER  */
+					0  31  2  0  1  0	/* RX_CLK */
+					2  2   1  0  2  0	/* GTX_CLK - CLK3  */
+					2  3   2  0  1  0	/* GTX125  - CLK4  */
+				>;
+			};
+
+			pio_ucc4: ucc_pin@03 {
+				pio-map = <
+					/* port pin dir open_drain assignment has_irq */
+					0   1  3  0  2  0	/* MDIO */
+					0   2  1  0  1  0	/* MDC  */
+
+					1  14  1  0  1  0	/* TxD0   (PB14, out, f1) */
+					1  15  1  0  1  0	/* TxD1   (PB15, out, f1) */
+					1  20  2  0  1  0	/* RxD0   (PB20, in,  f1) */
+					1  21  2  0  1  0	/* RxD1   (PB21, in,  f1) */
+					1  18  1  0  1  0	/* TX_EN  (PB18, out, f1) */
+					1  26  2  0  1  0	/* RX_DV  (PB26, in,  f1) */
+					1  27  2  0  1  0	/* RX_ER  (PB27, in,  f1) */
+
+					2  16  2  0  1  0	/* UCC4_RMII_CLK (CLK17) */
+				>;
+			};
+
+			pio_ucc5: ucc_pin@04 {
+				pio-map = <
+					/* port pin dir open_drain assignment has_irq */
+					0   1  3  0  2  0	/* MDIO */
+					0   2  1  0  1  0	/* MDC  */
+
+					3   0  1  0  1  0	/* TxD0  (PD0,  out, f1) */
+					3   1  1  0  1  0	/* TxD1  (PD1,  out, f1) */
+					3   6  2  0  1  0	/* RxD0  (PD6,   in, f1) */
+					3   7  2  0  1  0	/* RxD1  (PD7,   in, f1) */
+					3   4  1  0  1  0	/* TX_EN (PD4,  out, f1) */
+					3  12  2  0  1  0	/* RX_DV (PD12,  in, f1) */
+					3  13  2  0  1  0	/* RX_ER (PD13,  in, f1) */
+				>;
+			};
+
+			pio_ucc6: ucc_pin@05 {
+				pio-map = <
+					/* port pin dir open_drain assignment has_irq */
+					0   1  3  0  2  0	/* MDIO */
+					0   2  1  0  1  0	/* MDC  */
+
+					3  14  1  0  1  0	/* TxD0   (PD14, out, f1) */
+					3  15  1  0  1  0	/* TxD1   (PD15, out, f1) */
+					3  20  2  0  1  0	/* RxD0   (PD20, in,  f1) */
+					3  21  2  0  1  0	/* RxD1   (PD21, in,  f1) */
+					3  18  1  0  1  0	/* TX_EN  (PD18, out, f1) */
+					3  26  2  0  1  0	/* RX_DV  (PD26, in,  f1) */
+					3  27  2  0  1  0	/* RX_ER  (PD27, in,  f1) */
+				>;
+			};
+
+			pio_ucc7: ucc_pin@06 {
+				pio-map = <
+					/* port pin dir open_drain assignment has_irq */
+					0   1  3  0  2  0	/* MDIO */
+					0   2  1  0  1  0	/* MDC  */
+
+					4   0  1  0  1  0	/* TxD0   (PE0,  out, f1) */
+					4   1  1  0  1  0	/* TxD1   (PE1,  out, f1) */
+					4   6  2  0  1  0	/* RxD0   (PE6,   in, f1) */
+					4   7  2  0  1  0	/* RxD1   (PE7,   in, f1) */
+					4   4  1  0  1  0	/* TX_EN  (PE4,  out, f1) */
+					4  12  2  0  1  0	/* RX_DV  (PE12,  in, f1) */
+					4  13  2  0  1  0	/* RX_ER  (PE13,  in, f1) */
+				>;
+			};
+
+			pio_ucc8: ucc_pin@07 {
+				pio-map = <
+					/* port pin dir open_drain assignment has_irq */
+					0   1  3  0  2  0	/* MDIO */
+					0   2  1  0  1  0	/* MDC  */
+
+					4  14  1  0  2  0	/* TxD0   (PE14, out, f2) */
+					4  15  1  0  1  0	/* TxD1   (PE15, out, f1) */
+					4  20  2  0  1  0	/* RxD0   (PE20, in,  f1) */
+					4  21  2  0  1  0	/* RxD1   (PE21, in,  f1) */
+					4  18  1  0  1  0	/* TX_EN  (PE18, out, f1) */
+					4  26  2  0  1  0	/* RX_DV  (PE26, in,  f1) */
+					4  27  2  0  1  0	/* RX_ER  (PE27, in,  f1) */
+
+					2  15  2  0  1  0	/* UCCx_RMII_CLK (CLK16) */
+				>;
+			};
+
+		};
+
+		qe@100000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "qe";
+			compatible = "fsl,qe";
+			ranges = <0x0 0x100000 0x100000>;
+			reg = <0x100000 0x480>;
+			clock-frequency = <0>;	/* Filled in by U-Boot */
+			brg-frequency = <0>;	/* Filled in by U-Boot */
+			bus-frequency = <0>;	/* Filled in by U-Boot */
+
+			muram@10000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,qe-muram", "fsl,cpm-muram";
+				ranges = <0x0 0x00010000 0x0000c000>;
+
+				data-only@0 {
+					compatible = "fsl,qe-muram-data",
+						     "fsl,cpm-muram-data";
+					reg = <0x0 0xc000>;
+				};
+			};
+
+			/* ESTAR-1 (UCC1, MDIO 0x10, RGMII) */
+			enet_estar1: ucc@2000 {
+				device_type = "network";
+				compatible = "ucc_geth";
+				cell-index = <1>;
+				reg = <0x2000 0x200>;
+				interrupts = <32>;
+				interrupt-parent = <&qeic>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				rx-clock-name = "none";
+				tx-clock-name = "clk9";
+				phy-handle = <&phy_estar1>;
+				phy-connection-type = "rgmii-id";
+				pio-handle = <&pio_ucc1>;
+			};
+
+			/* ESTAR-2 (UCC2, MDIO 0x11, RGMII) */
+			enet_estar2: ucc@3000 {
+				device_type = "network";
+				compatible = "ucc_geth";
+				cell-index = <2>;
+				reg = <0x3000 0x200>;
+				interrupts = <33>;
+				interrupt-parent = <&qeic>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				rx-clock-name = "none";
+				tx-clock-name = "clk4";
+				phy-handle = <&phy_estar2>;
+				phy-connection-type = "rgmii-id";
+				pio-handle = <&pio_ucc2>;
+			};
+
+			/* Piggy2 (UCC4, MDIO 0x00, RMII) */
+			enet_piggy2: ucc@3200 {
+				device_type = "network";
+				compatible = "ucc_geth";
+				cell-index = <4>;
+				reg = <0x3200 0x200>;
+				interrupts = <35>;
+				interrupt-parent = <&qeic>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				rx-clock-name = "none";
+				tx-clock-name = "clk17";
+				phy-handle = <&phy_piggy2>;
+				phy-connection-type = "rmii";
+				pio-handle = <&pio_ucc4>;
+			};
+
+			/* Eth-1 (UCC5, MDIO 0x08, RMII) */
+			enet_eth1: ucc@2400 {
+				device_type = "network";
+				compatible = "ucc_geth";
+				cell-index = <5>;
+				reg = <0x2400 0x200>;
+				interrupts = <40>;
+				interrupt-parent = <&qeic>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				rx-clock-name = "none";
+				tx-clock-name = "clk16";
+				phy-handle = <&phy_eth1>;
+				phy-connection-type = "rmii";
+				pio-handle = <&pio_ucc5>;
+			};
+
+			/* Eth-2 (UCC6, MDIO 0x09, RMII) */
+			enet_eth2: ucc@3400 {
+				device_type = "network";
+				compatible = "ucc_geth";
+				cell-index = <6>;
+				reg = <0x3400 0x200>;
+				interrupts = <41>;
+				interrupt-parent = <&qeic>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				rx-clock-name = "none";
+				tx-clock-name = "clk16";
+				phy-handle = <&phy_eth2>;
+				phy-connection-type = "rmii";
+				pio-handle = <&pio_ucc6>;
+			};
+
+			/* Eth-3 (UCC7, MDIO 0x0a, RMII) */
+			enet_eth3: ucc@2600 {
+				device_type = "network";
+				compatible = "ucc_geth";
+				cell-index = <7>;
+				reg = <0x2600 0x200>;
+				interrupts = <42>;
+				interrupt-parent = <&qeic>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				rx-clock-name = "none";
+				tx-clock-name = "clk16";
+				phy-handle = <&phy_eth3>;
+				phy-connection-type = "rmii";
+				pio-handle = <&pio_ucc7>;
+			};
+
+			/* Eth-4 (UCC8, MDIO 0x0b, RMII) */
+			enet_eth4: ucc@3600 {
+				device_type = "network";
+				compatible = "ucc_geth";
+				cell-index = <8>;
+				reg = <0x3600 0x200>;
+				interrupts = <43>;
+				interrupt-parent = <&qeic>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				rx-clock-name = "none";
+				tx-clock-name = "clk16";
+				phy-handle = <&phy_eth4>;
+				phy-connection-type = "rmii";
+				pio-handle = <&pio_ucc8>;
+			};
+
+			mdio@3320 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x3320 0x18>;
+				compatible = "fsl,ucc-mdio";
+
+				/* Piggy2 (UCC4, MDIO 0x00, RMII) */
+				phy_piggy2: ethernet-phy@00 {
+					reg = <0x0>;
+					device_type = "ethernet-phy";
+				};
+
+				/* Eth-1 (UCC5, MDIO 0x08, RMII) */
+				phy_eth1: ethernet-phy@08 {
+					reg = <0x08>;
+					device_type = "ethernet-phy";
+				};
+
+				/* Eth-2 (UCC6, MDIO 0x09, RMII) */
+				phy_eth2: ethernet-phy@09 {
+					reg = <0x09>;
+					device_type = "ethernet-phy";
+				};
+
+				/* Eth-3 (UCC7, MDIO 0x0a, RMII) */
+				phy_eth3: ethernet-phy@0a {
+					reg = <0x0a>;
+					device_type = "ethernet-phy";
+				};
+
+				/* Eth-4 (UCC8, MDIO 0x0b, RMII) */
+				phy_eth4: ethernet-phy@0b {
+					reg = <0x0b>;
+					device_type = "ethernet-phy";
+				};
+
+				/* ESTAR-1 (UCC1, MDIO 0x10, RGMII) */
+				phy_estar1: ethernet-phy@10 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x10>;
+					device_type = "ethernet-phy";
+				};
+
+				/* ESTAR-2 (UCC2, MDIO 0x11, RGMII) */
+				phy_estar2: ethernet-phy@11 {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x11>;
+					device_type = "ethernet-phy";
+				};
+			};
+
+			qeic: interrupt-controller@80 {
+				interrupt-controller;
+				compatible = "fsl,qe-ic";
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				reg = <0x80 0x80>;
+				interrupts = <32 8 33 8>;
+				interrupt-parent = <&ipic>;
+			};
+		};
+	};
+
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8360-localbus", "fsl,pq2pro-localbus",
+			     "simple-bus";
+		reg = <0xe0005000 0xd8>;
+		ranges = <0 0 0xf0000000 0x04000000>;	/* Filled in by U-Boot */
+
+		flash@f0000000,0 {
+			compatible = "cfi-flash";
+			/*
+			 * The Intel P30 chip has 2 non-identical chips on
+			 * one die, so we need to define 2 seperate regions
+			 * that are scanned by physmap_of independantly.
+			 */
+			reg = <0 0x00000000 0x02000000
+			       0 0x02000000 0x02000000>;	/* Filled in by U-Boot */
+			bank-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "u-boot";
+				reg = <0 0x40000>;
+			};
+			partition@40000 {
+				label = "env";
+				reg = <0x40000 0x40000>;
+			};
+			partition@80000 {
+				label = "dtb";
+				reg = <0x80000 0x20000>;
+			};
+			partition@a0000 {
+				label = "kernel";
+				reg = <0xa0000 0x300000>;
+			};
+			partition@3a0000 {
+				label = "ramdisk";
+				reg = <0x3a0000 0x800000>;
+			};
+			partition@ba0000 {
+				label = "user";
+				reg = <0xba0000 0x3460000>;
+			};
+		};
+	};
+};
diff --git a/arch/powerpc/configs/83xx/kmeter1_defconfig b/arch/powerpc/configs/83xx/kmeter1_defconfig
new file mode 100644
index 0000000..bf0853f
--- /dev/null
+++ b/arch/powerpc/configs/83xx/kmeter1_defconfig
@@ -0,0 +1,908 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.28
+# Fri Apr  3 10:34:33 2009
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+CONFIG_6xx=y
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_PPC_FPU=y
+# CONFIG_FSL_EMB_PERFMON is not set
+# CONFIG_ALTIVEC is not set
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
+CONFIG_PPC32=y
+CONFIG_WORD_SIZE=32
+# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
+CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_HARDIRQS=y
+# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
+CONFIG_IRQ_PER_CPU=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_OF=y
+CONFIG_PPC_UDBG_16550=y
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+CONFIG_DEFAULT_UIMAGE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+# CONFIG_HOTPLUG is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_COMPAT_BRK=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
+CONFIG_HAVE_IOREMAP_PROT=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_ARCH_TRACEHOOK=y
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+CONFIG_CLASSIC_RCU=y
+# CONFIG_FREEZER is not set
+
+#
+# Platform support
+#
+CONFIG_PPC_MULTIPLATFORM=y
+CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_MPC5121_ADS is not set
+# CONFIG_MPC5121_GENERIC is not set
+# CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_PMAC is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PPC_82xx is not set
+# CONFIG_PQ2ADS is not set
+CONFIG_PPC_83xx=y
+# CONFIG_MPC831x_RDB is not set
+# CONFIG_MPC832x_MDS is not set
+# CONFIG_MPC832x_RDB is not set
+# CONFIG_MPC834x_MDS is not set
+# CONFIG_MPC834x_ITX is not set
+# CONFIG_MPC836x_MDS is not set
+# CONFIG_MPC836x_RDK is not set
+# CONFIG_MPC837x_MDS is not set
+# CONFIG_MPC837x_RDB is not set
+# CONFIG_SBC834x is not set
+# CONFIG_ASP834x is not set
+CONFIG_KMETER1=y
+# CONFIG_PPC_86xx is not set
+# CONFIG_EMBEDDED6xx is not set
+CONFIG_IPIC=y
+# CONFIG_MPIC is not set
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_TAU is not set
+CONFIG_QUICC_ENGINE=y
+# CONFIG_QE_GPIO is not set
+# CONFIG_FSL_ULI1575 is not set
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_SCHED_HRTICK=y
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT=y
+# CONFIG_PREEMPT_RCU is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_IOMMU_HELPER is not set
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_HAS_WALK_MEMORY=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
+# CONFIG_KEXEC is not set
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_MIGRATION=y
+# CONFIG_RESOURCES_64BIT is not set
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+CONFIG_UNEVICTABLE_LRU=y
+CONFIG_FORCE_MAX_ZONEORDER=11
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+CONFIG_EXTRA_TARGETS=""
+# CONFIG_PM is not set
+# CONFIG_SECCOMP is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_FSL_SOC=y
+CONFIG_PPC_PCI_CHOICE=y
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_HAS_RAPIDIO is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_PAGE_OFFSET=0xc0000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_PHYSICAL_START=0x00000000
+CONFIG_TASK_SIZE=0xc0000000
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+CONFIG_STP=m
+CONFIG_BRIDGE=m
+# CONFIG_NET_DSA is not set
+CONFIG_VLAN_8021Q=y
+# CONFIG_VLAN_8021Q_GVRP is not set
+# CONFIG_DECNET is not set
+CONFIG_LLC=m
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+# CONFIG_PHONET is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_OF_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+CONFIG_MTD_PHRAM=y
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_WL_THRESHOLD=4096
+CONFIG_MTD_UBI_BEB_RESERVE=1
+CONFIG_MTD_UBI_GLUEBI=y
+
+#
+# UBI debugging options
+#
+CONFIG_MTD_UBI_DEBUG=y
+# CONFIG_MTD_UBI_DEBUG_MSG is not set
+# CONFIG_MTD_UBI_DEBUG_PARANOID is not set
+# CONFIG_MTD_UBI_DEBUG_DISABLE_BGT is not set
+# CONFIG_MTD_UBI_DEBUG_USERSPACE_IO is not set
+# CONFIG_MTD_UBI_DEBUG_EMULATE_BITFLIPS is not set
+# CONFIG_MTD_UBI_DEBUG_EMULATE_WRITE_FAILURES is not set
+# CONFIG_MTD_UBI_DEBUG_EMULATE_ERASE_FAILURES is not set
+
+#
+# Additional UBI debugging messages
+#
+# CONFIG_MTD_UBI_DEBUG_MSG_BLD is not set
+# CONFIG_MTD_UBI_DEBUG_MSG_EBA is not set
+# CONFIG_MTD_UBI_DEBUG_MSG_WL is not set
+# CONFIG_MTD_UBI_DEBUG_MSG_IO is not set
+CONFIG_OF_DEVICE=y
+CONFIG_OF_I2C=y
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=y
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+CONFIG_TUN=y
+# CONFIG_VETH is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+CONFIG_MARVELL_PHY=y
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_B44 is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_GIANFAR is not set
+CONFIG_UCC_GETH=y
+# CONFIG_UGETH_MAGIC_PACKET is not set
+# CONFIG_UGETH_FILTERING is not set
+# CONFIG_UGETH_TX_ON_DEMAND is not set
+# CONFIG_MV643XX_ETH is not set
+# CONFIG_NETDEV_10000 is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
+CONFIG_WAN=y
+CONFIG_HDLC=y
+# CONFIG_HDLC_RAW is not set
+# CONFIG_HDLC_RAW_ETH is not set
+# CONFIG_HDLC_CISCO is not set
+# CONFIG_HDLC_FR is not set
+# CONFIG_HDLC_PPP is not set
+
+#
+# X.25/LAPB support is disabled
+#
+CONFIG_HDLC_KM=y
+CONFIG_FS_UCC_HDLC=y
+# CONFIG_DLCI is not set
+CONFIG_PPP=y
+CONFIG_PPP_MULTILINK=y
+# CONFIG_PPP_FILTER is not set
+# CONFIG_PPP_ASYNC is not set
+# CONFIG_PPP_SYNC_TTY is not set
+# CONFIG_PPP_DEFLATE is not set
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPP_MPPE is not set
+CONFIG_PPPOE=y
+# CONFIG_PPPOL2TP is not set
+# CONFIG_SLIP is not set
+CONFIG_SLHC=y
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+# CONFIG_INPUT is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_DEVKMEM is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_OF_PLATFORM is not set
+# CONFIG_SERIAL_QE is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_IPMI_HANDLER is not set
+CONFIG_HW_RANDOM=y
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_BOOTCOUNT=y
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_HELPER_AUTO=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+CONFIG_I2C_MPC=y
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_DS1682 is not set
+# CONFIG_AT24 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_MCU_MPC8349EMITX is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+# CONFIG_SPI is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+# CONFIG_GPIOLIB is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_REGULATOR is not set
+
+#
+# Multimedia devices
+#
+
+#
+# Multimedia core support
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_VIDEO_MEDIA is not set
+
+#
+# Multimedia drivers
+#
+# CONFIG_DAB is not set
+
+#
+# Graphics support
+#
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_SOUND is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_EDAC is not set
+# CONFIG_RTC_CLASS is not set
+# CONFIG_DMADEVICES is not set
+CONFIG_UIO=y
+# CONFIG_UIO_PDRV is not set
+# CONFIG_UIO_PDRV_GENIRQ is not set
+# CONFIG_UIO_SMX is not set
+# CONFIG_UIO_SERCOS3 is not set
+# CONFIG_STAGING is not set
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+CONFIG_FILE_LOCKING=y
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_PROC_KCORE is not set
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_UBIFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_REGISTER_V4 is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+# CONFIG_MSDOS_PARTITION is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
+# CONFIG_NLS is not set
+# CONFIG_DLM is not set
+CONFIG_UCC_FAST=y
+CONFIG_UCC=y
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_HEADERS_CHECK is not set
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_LATENCYTOP is not set
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_HAVE_FUNCTION_TRACER=y
+
+#
+# Tracers
+#
+# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_IRQSTACKS is not set
+# CONFIG_VIRQ_DEBUG is not set
+# CONFIG_BOOTX_TEXT is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+# CONFIG_CRYPTO is not set
+# CONFIG_PPC_CLOCK is not set
+CONFIG_PPC_LIB_RHEAP=y
+# CONFIG_VIRTUALIZATION is not set
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 437d29a..083ebee 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -96,6 +96,13 @@ config ASP834x
 	  This enables support for the Analogue & Micro ASP 83xx
 	  board.

+config KMETER1
+	bool "Keymile KMETER1"
+	select DEFAULT_UIMAGE
+	select QUICC_ENGINE
+	help
+	  This enables support for the Keymile KMETER1 board.
+

 endif

diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index 051777c..e139c36 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_MPC837x_MDS)	+= mpc837x_mds.o
 obj-$(CONFIG_SBC834x)		+= sbc834x.o
 obj-$(CONFIG_MPC837x_RDB)	+= mpc837x_rdb.o
 obj-$(CONFIG_ASP834x)		+= asp834x.o
+obj-$(CONFIG_KMETER1)		+= kmeter1.o
diff --git a/arch/powerpc/platforms/83xx/kmeter1.c b/arch/powerpc/platforms/83xx/kmeter1.c
new file mode 100644
index 0000000..1906f62
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/kmeter1.c
@@ -0,0 +1,188 @@
+/*
+ * Copyright 2008 DENX Software Engineering GmbH
+ * Author: Heiko Schocher <hs@denx.de>
+ *
+ * Description:
+ * Keymile KMETER1 board specific routines.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/initrd.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
+
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ipic.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+#include <asm/qe.h>
+#include <asm/qe_ic.h>
+
+#include "mpc83xx.h"
+
+#define SVR_REV(svr)    (((svr) >>  0) & 0xFFFF) /* Revision field */
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+static void __init kmeter1_setup_arch(void)
+{
+	struct device_node *np;
+
+	if (ppc_md.progress)
+		ppc_md.progress("kmeter1_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
+		mpc83xx_add_bridge(np);
+#endif
+
+#ifdef CONFIG_QUICC_ENGINE
+	qe_reset();
+
+	np = of_find_node_by_name(NULL, "par_io");
+	if (np != NULL) {
+		par_io_init(np);
+		of_node_put(np);
+
+		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
+			par_io_of_config(np);
+	}
+
+	np = of_find_compatible_node(NULL, "network", "ucc_geth");
+	if (np != NULL) {
+		uint svid;
+
+		/* handle mpc8360ea rev.2.1 erratum 2: RGMII Timing */
+		svid = mfspr(SPRN_SVR);
+		if (SVR_REV(svid) == 0x0021) {
+			struct	device_node *np_par;
+			struct	resource res;
+			void	__iomem *base;
+			int	ret;
+
+			np_par = of_find_node_by_name(NULL, "par_io");
+			if (np_par == NULL) {
+				printk(KERN_WARNING "%s couldn;t find par_io node\n",
+					__func__);
+				return;
+			}
+			/* Map Parallel I/O ports registers */
+			ret = of_address_to_resource(np_par, 0, &res);
+			if (ret) {
+				printk(KERN_WARNING "%s couldn;t map par_io registers\n",
+					__func__);
+				return;
+			}
+			base = ioremap(res.start, res.end - res.start + 1);
+
+			/*
+			 * IMMR + 0x14A8[4:5] = 11 (clk delay for UCC 2)
+			 * IMMR + 0x14A8[18:19] = 11 (clk delay for UCC 1)
+			 */
+			setbits32((base + 0xa8), 0x0c003000);
+
+			/*
+			 * IMMR + 0x14AC[20:27] = 10101010
+			 * (data delay for both UCC's)
+			 */
+			clrsetbits_be32((base + 0xac), 0xff0, 0xaa0);
+			iounmap(base);
+			of_node_put(np_par);
+		}
+		of_node_put(np);
+	}
+#endif				/* CONFIG_QUICC_ENGINE */
+}
+
+static struct of_device_id kmeter_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{ .type = "qe", },
+	{ .compatible = "fsl,qe", },
+	{},
+};
+
+static int __init kmeter_declare_of_platform_devices(void)
+{
+	/* Publish the QE devices */
+	of_platform_bus_probe(NULL, kmeter_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(kmeter1, kmeter_declare_of_platform_devices);
+
+static void __init kmeter1_init_IRQ(void)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_type(NULL, "ipic");
+	if (!np)
+		return;
+
+	ipic_init(np, 0);
+
+	/* Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	ipic_set_default_priority();
+	of_node_put(np);
+
+#ifdef CONFIG_QUICC_ENGINE
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
+	if (!np) {
+		np = of_find_node_by_type(NULL, "qeic");
+		if (!np)
+			return;
+	}
+	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
+	of_node_put(np);
+#endif				/* CONFIG_QUICC_ENGINE */
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init kmeter1_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "keymile,KMETER1");
+}
+
+define_machine(kmeter1) {
+	.name		= "KMETER1",
+	.probe		= kmeter1_probe,
+	.setup_arch	= kmeter1_setup_arch,
+	.init_IRQ	= kmeter1_init_IRQ,
+	.get_irq	= ipic_get_irq,
+	.restart	= mpc83xx_restart,
+	.time_init	= mpc83xx_time_init,
+	.calibrate_decr	= generic_calibrate_decr,
+	.progress	= udbg_progress,
+};
-- 
1.6.0.6


-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

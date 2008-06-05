Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5DAA3DE30D
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 19:09:25 +1000 (EST)
Message-ID: <4847AD42.1000201@grandegger.com>
Date: Thu, 05 Jun 2008 11:09:22 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 2/4] [POWERPC] 85xx: support for the TQM8548 module using
	the big Flash
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some TQM85xx boards could be equipped with up to 1 GiB (NOR) flash
memory and therefore a modified memory map is required and setup by
the board loader. This patch adds an appropriate DTS file.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |  368 +++++++++++++++++++++++++++++
 1 file changed, 368 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/tqm8548-bigflash.dts

Index: linux-2.6/arch/powerpc/boot/dts/tqm8548-bigflash.dts
===================================================================
--- /dev/null
+++ linux-2.6/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -0,0 +1,368 @@
+/*
+ * TQM8548 Device Tree Source
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ * Copyright 2008 Wolfgang Grandegger <wg@denx.de>
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
+	model = "tqm,8548";
+	compatible = "tqm,8548", "tqm,85xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8548@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <0x8000>;	// L1, 32K
+			i-cache-size = <0x8000>;	// L1, 32K
+			timebase-frequency = <0>;	// from U-Boot
+			bus-frequency = <0>;	// from U-Boot
+			clock-frequency = <0>;	// from U-Boot
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+	soc8548@a0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x0 0xa0000000 0x100000>;
+		reg = <0xa0000000 0x1000>;	// CCSRBAR
+		bus-frequency = <0>;
+
+		memory-controller@2000 {
+			compatible = "fsl,8548-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		L2: l2-cache-controller@20000 {
+			compatible = "fsl,8548-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;	// 32 bytes
+			cache-size = <0x80000>;	// L2, 512K
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+
+			phy1: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+			phy2: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+			phy4: ethernet-phy@4 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <4>;
+				device_type = "ethernet-phy";
+			};
+			phy5: ethernet-phy@5 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <5>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet0: ethernet@24000 {
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy2>;
+		};
+
+		enet1: ethernet@25000 {
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+		};
+
+		enet2: ethernet@26000 {
+			cell-index = <2>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <31 2 32 2 33 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy3>;
+		};
+
+		enet3: ethernet@27000 {
+			cell-index = <3>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x27000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <37 2 38 2 39 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy4>;
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;	// reg base, size
+			clock-frequency = <0>;	// should we fill in in uboot?
+			current-speed = <115200>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;	// reg base, size
+			clock-frequency = <0>;	// should we fill in in uboot?
+			current-speed = <115200>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	// global utilities reg
+			compatible = "fsl,mpc8548-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+	};
+
+	localbus@a0005000 {
+		compatible = "fsl,mpc8548-localbus", "fsl,pq3-localbus",
+			     "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0xa0005000 0x100>;	// BRx, ORx, etc.
+
+		ranges = <
+			0 0x0 0xfc000000 0x04000000	// NOR FLASH bank 1
+			1 0x0 0xf8000000 0x08000000	// NOR FLASH bank 0
+			2 0x0 0xa3000000 0x00008000	// CAN (2 x i82527)
+			3 0x0 0xa3010000 0x00008000	// NAND FLASH
+
+		>;
+
+		flash@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <1 0x0 0x8000000>;
+			bank-width = <4>;
+			device-width = <1>;
+
+			partition@0 {
+				label = "kernel";
+				reg = <0x00000000 0x00200000>;
+			};
+			partition@200000 {
+				label = "root";
+				reg = <0x00200000 0x00300000>;
+			};
+			partition@500000 {
+				label = "user";
+				reg = <0x00500000 0x07a00000>;
+			};
+			partition@7f00000 {
+				label = "env1";
+				reg = <0x07f00000 0x00040000>;
+			};
+			partition@7f40000 {
+				label = "env2";
+				reg = <0x07f40000 0x00040000>;
+			};
+			partition@7f80000 {
+				label = "u-boot";
+				reg = <0x07f80000 0x00080000>;
+				read-only;
+			};
+		};
+
+		/* Note: CAN support needs be enabled in U-Boot */
+		can0@2,0 {
+			compatible = "intel,82527"; // Bosch CC770
+			reg = <2 0x0 0x100>;
+			interrupts = <4 0>;
+			interrupt-parent = <&mpic>;
+		};
+
+		can1@2,100 {
+			compatible = "intel,82527"; // Bosch CC770
+			reg = <2 0x100 0x100>;
+			interrupts = <4 0>;
+			interrupt-parent = <&mpic>;
+		};
+
+		/* Note: NAND support needs to be enabled in U-Boot */
+		upm@3,0 {
+			#address-cells = <0>;
+			#size-cells = <0>;
+			compatible = "fsl,upm-nand";
+			reg = <3 0x0 0x800>;
+			fsl,upm-addr-offset = <0x10>;
+			fsl,upm-cmd-offset = <0x08>;
+			chip-delay = <30>; // in micro-seconds
+
+			nand@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					    label = "fs";
+					    reg = <0x00000000 0x01000000>;
+				};
+			};
+		};
+	};
+
+	pci0: pci@a0008000 {
+		cell-index = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+		reg = <0xa0008000 0x1000>;
+		clock-frequency = <33333333>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+				/* IDSEL 28 */
+				 0xe000 0 0 1 &mpic 2 1
+				 0xe000 0 0 2 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <24 2>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0 0x80000000 0x80000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xa2000000 0 0x01000000>;
+	};
+
+	pci1: pcie@a000a000 {
+		cell-index = <2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 (PEX) */
+			0x00000 0 0 1 &mpic 0 1
+			0x00000 0 0 2 &mpic 1 1
+			0x00000 0 0 3 &mpic 2 1
+			0x00000 0 0 4 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <26 2>;
+		bus-range = <0 0xff>;
+		ranges = <0x02000000 0 0xb0000000 0xb0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xaf000000 0 0x08000000>;
+		clock-frequency = <33333333>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xa000a000 0x1000>;
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0 0xb0000000 0x02000000 0
+			          0xb0000000 0 0x10000000
+				  0x01000000 0 0x00000000 0x01000000 0
+				  0x00000000 0 0x08000000>;
+		};
+	};
+};

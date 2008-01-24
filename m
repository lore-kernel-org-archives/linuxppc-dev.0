Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 0DD39DDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 10:41:39 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/10] sbc8548: Add v1 device tree source for Wind River
	SBC8548 board
Date: Thu, 24 Jan 2008 18:41:28 -0500
Message-Id: <12012180971068-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1201218096476-git-send-email-paul.gortmaker@windriver.com>
References: <12012180922447-git-send-email-paul.gortmaker@windriver.com>
	<12012180943940-git-send-email-paul.gortmaker@windriver.com>
	<12012180944056-git-send-email-paul.gortmaker@windriver.com>
	<12012180951674-git-send-email-paul.gortmaker@windriver.com>
	<12012180961689-git-send-email-paul.gortmaker@windriver.com>
	<1201218096476-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <2f25b75cad6c228a687093741f4ed1c5d1f1d4e7.1201217172.git.paul.gortmaker@windriver.com>
In-Reply-To: <e3ccba7097a77e66f07663fe9d1f174c06183528.1201217172.git.paul.gortmaker@windriver.com>
References: <e3ccba7097a77e66f07663fe9d1f174c06183528.1201217172.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a v1 device tree source for the Wind River SBC8548 board.
The biggest difference between this and the MPC8548CDS reference
platform is the absence of the CDS's Arcadia peripherals and physical
access to the PCI#2 bus.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8548.dts |  244 +++++++++++++++++++++++++++++++++++++
 1 files changed, 244 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
new file mode 100644
index 0000000..14be38a
--- /dev/null
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -0,0 +1,244 @@
+/*
+ * SBC8548 Device Tree Source
+ *
+ * Copyright 2007 Wind River Systems Inc.
+ *
+ * Paul Gortmaker (see MAINTAINERS for contact information)
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/dts-v1/;
+
+/ {
+	model = "SBC8548";
+	compatible = "SBC8548";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		/* pci1 doesn't have a corresponding physical connector */
+		pci2 = &pci2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8548@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <0x20>;	// 32 bytes
+			i-cache-line-size = <0x20>;	// 32 bytes
+			d-cache-size = <0x8000>;	// L1, 32K
+			i-cache-size = <0x8000>;	// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	soc8548@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x00000000 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00001000>;	// CCSRBAR
+		bus-frequency = <0>;
+
+		memory-controller@2000 {
+			compatible = "fsl,8548-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <0x12 0x2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8548-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <0x20>;	// 32 bytes
+			cache-size = <0x80000>;	// L2, 512K
+			interrupt-parent = <&mpic>;
+			interrupts = <0x10 0x2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <0x2b 0x2>;
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
+			interrupts = <0x2b 0x2>;
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
+			phy0: ethernet-phy@19 {
+				interrupt-parent = <&mpic>;
+				interrupts = <0x6 0x1>;
+				reg = <0x19>;
+				device_type = "ethernet-phy";
+			};
+			phy1: ethernet-phy@1a {
+				interrupt-parent = <&mpic>;
+				interrupts = <0x7 0x1>;
+				reg = <0x1a>;
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
+			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+		};
+
+		enet1: ethernet@25000 {
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;	// reg base, size
+			clock-frequency = <0>;	// should we fill in in uboot?
+			interrupts = <0x2a 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;	// reg base, size
+			clock-frequency = <0>;	// should we fill in in uboot?
+			interrupts = <0x2a 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	//global utilities reg
+			compatible = "fsl,mpc8548-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+                        big-endian;
+		};
+	};
+
+	pci0: pci@e0008000 {
+		cell-index = <0>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x01 (PCI-X slot) */
+			0x0800 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0800 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0800 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0800 0x0 0x0 0x4 &mpic 0x3 0x1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <0x18 0x2>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00800000>;
+		clock-frequency = <66666666>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xe0008000 0x1000>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+	};
+
+	pci2: pcie@e000a000 {
+		cell-index = <2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+
+			/* IDSEL 0x0 (PEX) */
+			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <0x1a 0x2>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x08000000>;
+		clock-frequency = <33333333>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xe000a000 0x1000>;
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0xa0000000
+				  0x02000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x08000000>;
+		};
+	};
+};
-- 
1.5.0.rc1.gf4b6c

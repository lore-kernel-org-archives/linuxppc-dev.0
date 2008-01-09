Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 5ACD0DDF51
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 16:18:33 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] sbc8548: Add device tree source for Wind River SBC8548
	board
Date: Wed,  9 Jan 2008 00:18:27 -0500
Message-Id: <11998559121892-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <11998559111835-git-send-email-paul.gortmaker@windriver.com>
References: <1199855910574-git-send-email-paul.gortmaker@windriver.com>
	<11998559111835-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <1724e4d26c5ca07da10a860259eb644a4058a870.1199854466.git.paul.gortmaker@windriver.com>
In-Reply-To: <93a0b006474cd6884392682c82b232fc2aea7794.1199854466.git.paul.gortmaker@windriver.com>
References: <93a0b006474cd6884392682c82b232fc2aea7794.1199854466.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the device tree source for the Wind River SBC8548 board.  The
biggest difference between this and the MPC8548CDS reference platform
is the absence of the CDS's Arcadia peripherals and physical access to PCI#2.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8548.dts |  242 +++++++++++++++++++++++++++++++++++++
 1 files changed, 242 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
new file mode 100644
index 0000000..e63ed20
--- /dev/null
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -0,0 +1,242 @@
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
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 10000000>;
+	};
+
+	soc8548@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <00000000 e0000000 00100000>;
+		reg = <e0000000 00001000>;	// CCSRBAR
+		bus-frequency = <0>;
+
+		memory-controller@2000 {
+			compatible = "fsl,8548-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <12 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8548-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <80000>;	// L2, 512K
+			interrupt-parent = <&mpic>;
+			interrupts = <10 2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <2b 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <3100 100>;
+			interrupts = <2b 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <24520 20>;
+
+			phy0: ethernet-phy@19 {
+				interrupt-parent = <&mpic>;
+				interrupts = <6 1>;
+				reg = <19>;
+				device_type = "ethernet-phy";
+			};
+			phy1: ethernet-phy@1a {
+				interrupt-parent = <&mpic>;
+				interrupts = <7 1>;
+				reg = <1a>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet0: ethernet@24000 {
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <1d 2 1e 2 22 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+		};
+
+		enet1: ethernet@25000 {
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <23 2 24 2 28 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>;	// reg base, size
+			clock-frequency = <0>;	// should we fill in in uboot?
+			interrupts = <2a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;	// reg base, size
+			clock-frequency = <0>;	// should we fill in in uboot?
+			interrupts = <2a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	//global utilities reg
+			compatible = "fsl,mpc8548-guts";
+			reg = <e0000 1000>;
+			fsl,has-rstcr;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+                        big-endian;
+		};
+	};
+
+	pci0: pci@e0008000 {
+		cell-index = <0>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x01 (PCI-X slot) */
+			00800 0 0 1 &mpic 0 1
+			00800 0 0 2 &mpic 1 1
+			00800 0 0 3 &mpic 2 1
+			00800 0 0 4 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <18 2>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 80000000 80000000 0 10000000
+			  01000000 0 00000000 e2000000 0 00800000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008000 1000>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+	};
+
+	pci2: pcie@e000a000 {
+		cell-index = <2>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+			/* IDSEL 0x0 (PEX) */
+			00000 0 0 1 &mpic 0 1
+			00000 0 0 2 &mpic 1 1
+			00000 0 0 3 &mpic 2 1
+			00000 0 0 4 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <1a 2>;
+		bus-range = <0 ff>;
+		ranges = <02000000 0 a0000000 a0000000 0 20000000
+			  01000000 0 00000000 e3000000 0 08000000>;
+		clock-frequency = <1fca055>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e000a000 1000>;
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <02000000 0 a0000000
+				  02000000 0 a0000000
+				  0 20000000
+
+				  01000000 0 00000000
+				  01000000 0 00000000
+				  0 08000000>;
+		};
+	};
+};
-- 
1.5.0.rc1.gf4b6c

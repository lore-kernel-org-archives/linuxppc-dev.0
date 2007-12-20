Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 002ADDDE36
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 05:38:37 +1100 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id lBKEsZoK025825
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 06:54:35 -0800 (PST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] sbc8560: Add device tree source for Wind River SBC8560
	board
Date: Thu, 20 Dec 2007 09:54:31 -0500
Message-Id: <11981624742139-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <11981624741263-git-send-email-paul.gortmaker@windriver.com>
References: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
	<11981624732110-git-send-email-paul.gortmaker@windriver.com>
	<11981624741263-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <6be237dcf5b58d604afa6cea3079ec7de02a8de9.1198107769.git.paul.gortmaker@windriver.com>
In-Reply-To: <442fe9c9343f3c694932bcdc5f819c493c33c76b.1198107769.git.paul.gortmaker@windriver.com>
References: <442fe9c9343f3c694932bcdc5f819c493c33c76b.1198107769.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the device tree source for the Wind River SBC8560 board.  The
biggest difference between this and the MPC8560ADS reference platform
is the use of an external 16550 compatible UART instead of the CPM2.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8560.dts |  202 +++++++++++++++++++++++++++++++++++++
 1 files changed, 202 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
new file mode 100644
index 0000000..85fc488
--- /dev/null
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -0,0 +1,202 @@
+/*
+ * SBC8560 Device Tree Source
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
+	model = "SBC8560";
+	compatible = "SBC8560";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8560@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			32-bit;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 20000000>;
+	};
+
+	soc8560@ff700000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 ff700000 00100000>;
+		reg = <ff700000 00100000>;
+		bus-frequency = <0>;
+
+		memory-controller@2000 {
+			compatible = "fsl,8560-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <12 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8560-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <40000>;	// L2, 256K
+			interrupt-parent = <&mpic>;
+			interrupts = <10 2>;
+		};
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <2b 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
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
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <1d 2 1e 2 22 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+		};
+
+		ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <23 2 24 2 28 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+		};
+
+
+		pci@8000 {
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x02 */
+				1000 0 0 1 &mpic 2 1
+				1000 0 0 2 &mpic 3 1
+				1000 0 0 3 &mpic 4 1
+				1000 0 0 4 &mpic 5 1>;
+
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 80000000 80000000 0 20000000
+				  01000000 0 00000000 e2000000 0 00100000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+			compatible = "fsl,mpc8540-pci";
+			device_type = "pci";
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+			big-endian;
+		};
+
+		global-utilities@e0000 {
+			compatible = "fsl,mpc8560-guts";
+			reg = <e0000 1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	duart@fc700000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";		// console checks for this!
+		ranges = <0 fc700000 00200000>;
+		reg = <fc700000 00200000>;
+
+		serial@000000 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <000000 100>;
+			clock-frequency = <1C2000>;
+			interrupts = <9 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial@100000 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <100000 100>;
+			clock-frequency = <1C2000>;
+			interrupts = <a 2>;
+			interrupt-parent = <&mpic>;
+		};
+	};
+
+	rtc@fc900000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "rtc";
+		compatible = "m48t59";
+		reg = <fc900000 2000>;
+	};
+};
-- 
1.5.0.rc1.gf4b6c

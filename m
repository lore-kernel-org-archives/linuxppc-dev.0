Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 8C928DDEF4
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 01:25:37 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/7] sbc8560: Add device tree source for Wind River SBC8560
	board
Date: Mon,  7 Jan 2008 09:25:29 -0500
Message-Id: <1199715935439-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <11997159352727-git-send-email-paul.gortmaker@windriver.com>
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
	<11997159331132-git-send-email-paul.gortmaker@windriver.com>
	<11997159342128-git-send-email-paul.gortmaker@windriver.com>
	<11997159352727-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <d10d083bafb978936975111f09669120201072ec.1199715362.git.paul.gortmaker@windriver.com>
In-Reply-To: <ef7d84e06c45289f51f35845ccaa63bbf31827db.1199715362.git.paul.gortmaker@windriver.com>
References: <ef7d84e06c45289f51f35845ccaa63bbf31827db.1199715362.git.paul.gortmaker@windriver.com>
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
dts is the use of an external 16550 compatible UART instead of the CPM2.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8560.dts |  285 +++++++++++++++++++++++++++++++++++++
 1 files changed, 285 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
new file mode 100644
index 0000000..858e8bf
--- /dev/null
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -0,0 +1,285 @@
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
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
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
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 20000000>;
+	};
+
+	soc@ff700000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0 ff700000 00100000>;
+		reg = <ff700000 00100000>;
+		clock-frequency = <0>;
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
+			phy2: ethernet-phy@1b {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <1b>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@1c {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <1c>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet0: ethernet@24000 {
+			cell-index = <0>;
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
+		enet1: ethernet@25000 {
+			cell-index = <1>;
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
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			device_type = "open-pic";
+		};
+
+		cpm@919c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8560-cpm", "fsl,cpm2";
+			reg = <919c0 30>;
+			ranges;
+
+			muram@80000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 80000 10000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 4000 9000 2000>;
+				};
+			};
+
+			brg@919f0 {
+				compatible = "fsl,mpc8560-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <919f0 10 915f0 10>;
+				clock-frequency = <d#165000000>;
+			};
+
+			cpmpic: pic@90c00 {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				interrupts = <2e 2>;
+				interrupt-parent = <&mpic>;
+				reg = <90c00 80>;
+				compatible = "fsl,mpc8560-cpm-pic", "fsl,cpm2-pic";
+			};
+
+			enet2: ethernet@91320 {
+				device_type = "network";
+				compatible = "fsl,mpc8560-fcc-enet",
+				             "fsl,cpm2-fcc-enet";
+				reg = <91320 20 88500 100 913b0 1>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				fsl,cpm-command = <16200300>;
+				interrupts = <21 8>;
+				interrupt-parent = <&cpmpic>;
+				phy-handle = <&phy2>;
+			};
+
+			enet3: ethernet@91340 {
+				device_type = "network";
+				compatible = "fsl,mpc8560-fcc-enet",
+				             "fsl,cpm2-fcc-enet";
+				reg = <91340 20 88600 100 913d0 1>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				fsl,cpm-command = <1a400300>;
+				interrupts = <22 8>;
+				interrupt-parent = <&cpmpic>;
+				phy-handle = <&phy3>;
+			};
+		};
+
+		global-utilities@e0000 {
+			compatible = "fsl,mpc8560-guts";
+			reg = <e0000 1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	pci0: pci@ff708000 {
+		cell-index = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+		reg = <ff708000 1000>;
+		clock-frequency = <3f940aa>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+				/* IDSEL 0x02 */
+				1000 0 0 1 &mpic 2 1
+				1000 0 0 2 &mpic 3 1
+				1000 0 0 3 &mpic 4 1
+				1000 0 0 4 &mpic 5 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <18 2>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 80000000 80000000 0 20000000
+			  01000000 0 00000000 e2000000 0 01000000>;
+	};
+
+	epld@fc000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "localbus";
+		ranges = <0 fc000000 00c00000>;
+
+		serial0: serial@700000 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <700000 100>;
+			clock-frequency = <1C2000>;
+			interrupts = <9 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@800000 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <800000 100>;
+			clock-frequency = <1C2000>;
+			interrupts = <a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		rtc@900000 {
+			compatible = "m48t59";
+			reg = <900000 2000>;
+		};
+	};
+};
-- 
1.5.0.rc1.gf4b6c

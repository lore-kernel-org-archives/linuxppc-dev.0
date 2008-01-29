Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7A9A9DDDFC
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 21:18:20 +1100 (EST)
Message-ID: <479EFE71.5090201@denx.de>
Date: Tue, 29 Jan 2008 11:22:41 +0100
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] 82xx: MGCOGE support
References: <mailman.813.1200609119.6908.linuxppc-dev@ozlabs.org>
In-Reply-To: <mailman.813.1200609119.6908.linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

The following Patch adds the DTS File for the MGCOGE
plattform from keymile.

Signed-off-by: Heiko Schocher <hs@denx.de>
---
 arch/powerpc/boot/dts/mgcoge.dts |  153 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 153 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mgcoge.dts

diff --git a/arch/powerpc/boot/dts/mgcoge.dts b/arch/powerpc/boot/dts/mgcoge.dts
new file mode 100644
index 0000000..1033e5a
--- /dev/null
+++ b/arch/powerpc/boot/dts/mgcoge.dts
@@ -0,0 +1,153 @@
+/*
+ * Device Tree for the MGCOGE plattform from keymile.
+ *
+ * Copyright 2008 DENX Software Engineering GmbH
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+/ {
+	model = "MGCOGE";
+	compatible = "fsl,mgcoge";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &eth0;
+		serial0 = &smc2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8247@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <16384>;
+			i-cache-size = <16384>;
+			timebase-frequency = <0>;
+			clock-frequency = <0>;
+			bus-frequency = <0>;
+		};
+	};
+
+	localbus@f0010100 {
+		compatible = "fsl,mpc8248-localbus",
+		             "fsl,pq2-localbus",
+		             "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0xf0010100 0x40>;
+
+		ranges = <0 0 0xfe000000 0x00400000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0x0 0x400000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bank-width = <1>;
+			device-width = <1>;
+			partition@0 {
+				label = "u-boot";
+				reg = <0 0x40000>;
+			};
+			partition@40000 {
+				label = "env";
+				reg = <0x40000 0x20000>;
+			};
+			partition@60000 {
+				label = "user";
+				reg = <0x60000 0x3a0000>;
+			};
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0>;
+	};
+
+	soc@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8248-immr", "fsl,pq2-soc", "simple-bus";
+		ranges = <0x00000000 0xf0000000 0x00053000>;
+
+		// Temporary until code stops depending on it.
+		device_type = "soc";
+
+		// Temporary -- will go away once kernel uses ranges for get_immrbase().
+		reg = <0xf0000000 0x00053000>;
+
+		cpm@119c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <2>;
+			compatible = "fsl,mpc8248-cpm", "fsl,cpm2",
+					"simple-bus";
+			reg = <0x119c0 0x30>;
+			ranges;
+
+			muram {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 0x10000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 0x1100 0x1140
+					       0xec0 0x9800 0x800>;
+				};
+			};
+
+			brg@119f0 {
+				compatible = "fsl,mpc8248-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <0x119f0 0x10 0x115f0 0x10>;
+			};
+
+			/* Monitor port/SMC2 */
+			smc2: serial@11a90 {
+				device_type = "serial";
+				compatible = "fsl,mpc8248-smc-uart",
+				             "fsl,cpm2-smc-uart";
+				reg = <0x11a90 0x20 0x1100 0x40 0x88fc 4>;
+				interrupts = <5 8>;
+				interrupt-parent = <&PIC>;
+				fsl,cpm-brg = <2>;
+				fsl,cpm-command = <0x21200000>;
+				current-speed = <0x1c200>;
+			};
+
+			eth0: ethernet@11a60 {
+				device_type = "network";
+				compatible = "fsl,mpc8272-scc-enet",
+				             "fsl,cpm2-scc-enet";
+				reg = <0x11a60 0x20 0x8300 0x100 0x11390 1>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				interrupts = <43 8>;
+				interrupt-parent = <&PIC>;
+				linux,network-index = <0>;
+				fsl,cpm-command = <0xce00000>;
+				fixed-link = <0 0 10 0 0>;
+			};
+
+		};
+
+		PIC: interrupt-controller@10c00 {
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <0x10c00 0x80>;
+			compatible = "fsl,mpc8248-pic", "fsl,pq2-pic";
+		};
+	};
+};
-- 
1.5.2.2


bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

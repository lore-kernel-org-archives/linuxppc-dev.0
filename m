Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F466DF126
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:12 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1a5jO019205
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:36:06 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1a5mA001581
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:05 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BOS0007983
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:24 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 4D314AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:04 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1a4GX015458
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:36:04 -0500
Date: Tue, 17 Jul 2007 20:36:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 49/61] 8xx: Update device trees.
Message-ID: <20070718013604.GU15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This updates the device trees to use a more suitable binding, and to clean
up some miscellaneous cruft.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc866ads.dts          |  118 ++++++++++---------
 arch/powerpc/boot/dts/mpc885ads.dts          |  157 ++++++++++++++------------
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |   10 +--
 3 files changed, 148 insertions(+), 137 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index 9b5bf77..26d3296 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -12,7 +12,7 @@
 
 / {
 	model = "MPC866ADS";
-	compatible = "mpc8xx";
+	compatible = "fsl,mpc866ads";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -23,16 +23,15 @@
 		PowerPC,866@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <2000>;		// L1, 8K
-			i-cache-size = <4000>;		// L1, 16K
+			d-cache-line-size = <d#32>;
+			i-cache-line-size = <d#32>;
+			d-cache-size = <d#8192>;
+			i-cache-size = <d#16384>;
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			32-bit;
 			interrupts = <f 2>;	// decrementer interrupt
-			interrupt-parent = <&Mpc8xx_pic>;
+			interrupt-parent = <&PIC>;
 		};
 	};
 
@@ -44,105 +43,110 @@
 	soc866@ff000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
-		ranges = <0 ff000000 00100000>;
+		ranges = <0 ff000000 00004000>;
 		reg = <ff000000 00000200>;
 		bus-frequency = <0>;
-		mdio@e80 {
+
+		mdio@e00 {
 			device_type = "mdio";
-			compatible = "fs_enet";
-			reg = <e80 8>;
+			compatible = "fsl,mpc866-fec-mdio", "fsl,pq1-fec-mdio";
+			reg = <e00 188>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			phy: ethernet-phy@f {
+
+			PHY: ethernet-phy@f {
 				reg = <f>;
 				device_type = "ethernet-phy";
 			};
 		};
 
-		fec@e00 {
+		ethernet@e00 {
 			device_type = "network";
-			compatible = "fs_enet";
-			model = "FEC";
-			device-id = <1>;
+			compatible = "fsl,mpc866-fec-enet",
+			             "fsl,pq1-fec-enet",
+			             "fsl,cpm-enet";
 			reg = <e00 188>;
-			mac-address = [ 00 00 0C 00 01 FD ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <3 1>;
-			interrupt-parent = <&Mpc8xx_pic>;
-			phy-handle = <&Phy>;
+			interrupt-parent = <&PIC>;
+			phy-handle = <&PHY>;
+			linux,network-index = <0>;
 		};
 
-		mpc8xx_pic: pic@ff000000 {
+		PIC: pic@0 {
 			interrupt-controller;
-			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0 24>;
-			built-in;
 			compatible = "fsl,mpc866-pic", "fsl,pq1-pic";
 		};
 
-		cpm@ff000000 {
+		cpm@9c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			#interrupt-cells = <2>;
 			compatible = "fsl,mpc866-cpm", "fsl,cpm1", "fsl,cpm";
-			ranges = <0 0 4000>;
-			reg = <860 f0>;
 			command-proc = <9c0>;
 			fsl,brg-frequency = <0>;
 			interrupts = <0 2>;	// cpm error interrupt
-			interrupt-parent = <&Cpm_pic>;
+			interrupt-parent = <&CPM_PIC>;
+			reg = <9c0 40 2000 1c00>;
+			ranges;
 
-			cpm_pic: pic@930 {
+			CPM_PIC: pic@930 {
 				interrupt-controller;
-				#address-cells = <0>;
 				#interrupt-cells = <2>;
 				interrupts = <5 2 0 2>;
-				interrupt-parent = <&Mpc8xx_pic>;
+				interrupt-parent = <&PIC>;
 				reg = <930 20>;
-				built-in;
 				compatible = "fsl,mpc866-cpm-pic", "fsl,cpm1-pic";
 			};
 
-			smc@a80 {
+			serial@a80 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SMC";
-				device-id = <1>;
+				compatible = "fsl,mpc866-smc-uart",
+				             "fsl,cpm1-smc-uart",
+				             "fsl,cpm1-uart",
+				             "fsl,cpm-smc-uart",
+				             "fsl,cpm-uart";
 				reg = <a80 10 3e80 40>;
-				clock-setup = <00ffffff 0>;
-				rx-clock = <1>;
-				tx-clock = <1>;
-				current-speed = <0>;
 				interrupts = <4 3>;
-				interrupt-parent = <&Cpm_pic>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <0090>;
 			};
 
-			smc@a90 {
+			serial@a90 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SMC";
-				device-id = <2>;
+				compatible = "fsl,mpc866-smc-uart",
+				             "fsl,cpm1-smc-uart",
+				             "fsl,cpm1-uart",
+				             "fsl,cpm-smc-uart",
+				             "fsl,cpm-uart";
 				reg = <a90 20 3f80 40>;
-				clock-setup = <ff00ffff 90000>;
-				rx-clock = <2>;
-				tx-clock = <2>;
-				current-speed = <0>;
 				interrupts = <3 3>;
-				interrupt-parent = <&Cpm_pic>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-brg = <2>;
+				fsl,cpm-command = <00d0>;
 			};
 
-			scc@a00 {
+			ethernet@a00 {
 				device_type = "network";
-				compatible = "fs_enet";
-				model = "SCC";
-				device-id = <1>;
-				reg = <a00 18 3c00 80>;
-				mac-address = [ 00 00 0C 00 03 FD ];
+				compatible = "fsl,mpc866-scc-enet",
+				             "fsl,cpm1-scc-enet",
+				             "fsl,cpm1-enet",
+				             "fsl,cpm-scc-enet",
+				             "fsl,cpm-enet";
+				reg = <a00 18 3c00 100>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
 				interrupts = <1e 3>;
-				interrupt-parent = <&Cpm_pic>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-command = <0000>;
+				linux,network-index = <1>;
 			};
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc/cpm/serial@a80";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index de81407..fbacb1d 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -2,6 +2,7 @@
  * MPC885 ADS Device Tree Source
  *
  * Copyright 2006 MontaVista Software, Inc.
+ * Copyright 2007 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -12,7 +13,7 @@
 
 / {
 	model = "MPC885ADS";
-	compatible = "mpc8xx";
+	compatible = "fsl,mpc885ads";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -23,158 +24,170 @@
 		PowerPC,885@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <2000>;		// L1, 8K
-			i-cache-size = <2000>;		// L1, 8K
+			d-cache-line-size = <d#32>;
+			i-cache-line-size = <d#32>;
+			d-cache-size = <d#8192>;
+			i-cache-size = <d#8192>;
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			32-bit;
 			interrupts = <f 2>;	// decrementer interrupt
-			interrupt-parent = <&Mpc8xx_pic>;
+			interrupt-parent = <&PIC>;
 		};
 	};
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 800000>;
+		reg = <0 0>;
 	};
 
-	soc885@ff000000 {
+	bcsr@ff080000 {
+		reg = <ff080000 20 ff0a0300 4>;
+		compatible = "fsl,mpc885ads-bcsr";
+	};
+
+	soc@ff000000 {
+		compatible = "fsl,mpc885", "fsl,pq1-soc";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
-		ranges = <0 ff000000 00100000>;
+		ranges = <0 ff000000 00004000>;
 		reg = <ff000000 00000200>;
 		bus-frequency = <0>;
-		mdio@e80 {
-			device_type = "mdio";
-			compatible = "fs_enet";
-			reg = <e80 8>;
+
+		mdio@e00 {
+			compatible = "fsl,mpc885-fec-mdio", "fsl,pq1-fec-mdio";
+			reg = <e00 188>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			Phy0: ethernet-phy@0 {
+
+			PHY0: ethernet-phy@0 {
 				reg = <0>;
 				device_type = "ethernet-phy";
 			};
-			Phy1: ethernet-phy@1 {
+
+			PHY1: ethernet-phy@1 {
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
-			Phy2: ethernet-phy@2 {
+
+			PHY2: ethernet-phy@2 {
 				reg = <2>;
 				device_type = "ethernet-phy";
 			};
 		};
 
-		fec@e00 {
+		ethernet@e00 {
 			device_type = "network";
-			compatible = "fs_enet";
-			model = "FEC";
-			device-id = <1>;
+			compatible = "fsl,mpc885-fec-enet",
+			             "fsl,pq1-fec-enet",
+			             "fsl,cpm-enet";
 			reg = <e00 188>;
-			mac-address = [ 00 00 0C 00 01 FD ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <3 1>;
-			interrupt-parent = <&Mpc8xx_pic>;
-			phy-handle = <&Phy1>;
+			interrupt-parent = <&PIC>;
+			phy-handle = <&PHY0>;
+			linux,network-index = <0>;
 		};
 
-		fec@1e00 {
+		ethernet@1e00 {
 			device_type = "network";
-			compatible = "fs_enet";
-			model = "FEC";
-			device-id = <2>;
+			compatible = "fsl,mpc885-fec-enet",
+			             "fsl,pq1-fec-enet",
+			             "fsl,cpm-enet";
 			reg = <1e00 188>;
-			mac-address = [ 00 00 0C 00 02 FD ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <7 1>;
-			interrupt-parent = <&Mpc8xx_pic>;
-			phy-handle = <&Phy2>;
+			interrupt-parent = <&PIC>;
+			phy-handle = <&PHY1>;
+			linux,network-index = <1>;
 		};
 
-		Mpc8xx_pic: pic@ff000000 {
+		PIC: pic@0 {
 			interrupt-controller;
-			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0 24>;
-			built-in;
 			compatible = "fsl,mpc885-pic", "fsl,pq1-pic";
 		};
 
-		pcmcia@0080 {
+		pcmcia@80 {
 			#address-cells = <3>;
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			compatible = "fsl,pq-pcmcia";
 			device_type = "pcmcia";
 			reg = <80 80>;
-			interrupt-parent = <&Mpc8xx_pic>;
+			interrupt-parent = <&PIC>;
 			interrupts = <d 1>;
 		};
 
-		cpm@ff000000 {
+		cpm@9c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			#interrupt-cells = <2>;
 			compatible = "fsl,mpc885-cpm", "fsl,cpm1", "fsl,cpm";
-			ranges = <0 0 4000>;
-			reg = <860 f0>;
 			command-proc = <9c0>;
 			fsl,brg-frequency = <0>;
 			interrupts = <0 2>;	// cpm error interrupt
-			interrupt-parent = <&Cpm_pic>;
+			interrupt-parent = <&CPM_PIC>;
+			reg = <9c0 40 2000 1c00>;
+			ranges;
 
-			Cpm_pic: pic@930 {
+			CPM_PIC: pic@930 {
 				interrupt-controller;
-				#address-cells = <0>;
 				#interrupt-cells = <2>;
 				interrupts = <5 2 0 2>;
-				interrupt-parent = <&Mpc8xx_pic>;
+				interrupt-parent = <&PIC>;
 				reg = <930 20>;
-				built-in;
 				compatible = "fsl,mpc885-cpm-pic", "fsl,cpm1-pic";
 			};
 
-			smc@a80 {
+			serial@a80 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SMC";
-				device-id = <1>;
+				compatible = "fsl,mpc885-smc-uart",
+				             "fsl,cpm1-smc-uart",
+				             "fsl,cpm1-uart",
+				             "fsl,cpm-smc-uart",
+				             "fsl,cpm-uart";
 				reg = <a80 10 3e80 40>;
-				clock-setup = <00ffffff 0>;
-				rx-clock = <1>;
-				tx-clock = <1>;
-				current-speed = <0>;
 				interrupts = <4 3>;
-				interrupt-parent = <&Cpm_pic>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <0090>;
 			};
 
-			smc@a90 {
+			serial@a90 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SMC";
-				device-id = <2>;
+				compatible = "fsl,mpc885-smc-uart",
+				             "fsl,cpm1-smc-uart",
+				             "fsl,cpm1-uart",
+				             "fsl,cpm-smc-uart",
+				             "fsl,cpm-uart";
 				reg = <a90 20 3f80 40>;
-				clock-setup = <ff00ffff 90000>;
-				rx-clock = <2>;
-				tx-clock = <2>;
-				current-speed = <0>;
 				interrupts = <3 3>;
-				interrupt-parent = <&Cpm_pic>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-brg = <2>;
+				fsl,cpm-command = <00d0>;
 			};
 
-			scc@a40 {
+			ethernet@a40 {
 				device_type = "network";
-				compatible = "fs_enet";
-				model = "SCC";
-				device-id = <3>;
-				reg = <a40 18 3e00 80>;
-				mac-address = [ 00 00 0C 00 03 FD ];
+				compatible = "fsl,mpc885-scc-enet",
+				             "fsl,cpm1-scc-enet",
+				             "fsl,cpm1-enet",
+				             "fsl,cpm-scc-enet",
+				             "fsl,cpm-enet";
+				reg = <a40 18 3e00 100>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
 				interrupts = <1c 3>;
-				interrupt-parent = <&Cpm_pic>;
-				phy-handle = <&Phy2>;
+				interrupt-parent = <&CPM_PIC>;
+				phy-handle = <&PHY2>;
+				fsl,cpm-command = <0080>;
+				linux,network-index = <2>;
 			};
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc/cpm/serial@a80";
+	};
 };
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index cf0e7bc..15a60be 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -277,14 +277,8 @@ static void __init mpc86xads_setup_arch(void)
 
 static int __init mpc86xads_probe(void)
 {
-	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
-					  "model", NULL);
-	if (model == NULL)
-		return 0;
-	if (strcmp(model, "MPC866ADS"))
-		return 0;
-
-	return 1;
+	unsigned long root = of_get_flat_dt_root();
+	return of_flat_dt_is_compatible(root, "fsl,mpc866ads");
 }
 
 define_machine(mpc86x_ads) {
-- 
1.5.0.3

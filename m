Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17CBADED7F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:51:12 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m3HEp7BJ027216
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 09:51:08 -0500
Date: Thu, 17 Apr 2008 09:47:24 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] fsl: Convert dts to v1 syntax
Message-ID: <Pine.LNX.4.64.0804170946470.18068@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

In my powerpc-next tree.  posting for review.

 arch/powerpc/boot/dts/ep88xc.dts      |   73 +++++++++---------
 arch/powerpc/boot/dts/kuroboxHD.dts   |   83 +++++++++++----------
 arch/powerpc/boot/dts/kuroboxHG.dts   |   83 +++++++++++----------
 arch/powerpc/boot/dts/mpc7448hpc2.dts |   97 ++++++++++++------------
 arch/powerpc/boot/dts/mpc8272ads.dts  |  132 +++++++++++++++++----------------
 arch/powerpc/boot/dts/mpc866ads.dts   |   58 ++++++++-------
 arch/powerpc/boot/dts/mpc885ads.dts   |   77 ++++++++++----------
 arch/powerpc/boot/dts/pq2fads.dts     |  126 ++++++++++++++++---------------
 8 files changed, 372 insertions(+), 357 deletions(-)

diff --git a/arch/powerpc/boot/dts/ep88xc.dts b/arch/powerpc/boot/dts/ep88xc.dts
index 02705f2..ae57d62 100644
--- a/arch/powerpc/boot/dts/ep88xc.dts
+++ b/arch/powerpc/boot/dts/ep88xc.dts
@@ -2,7 +2,7 @@
  * EP88xC Device Tree Source
  *
  * Copyright 2006 MontaVista Software, Inc.
- * Copyright 2007 Freescale Semiconductor, Inc.
+ * Copyright 2007,2008 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -10,6 +10,7 @@
  * option) any later version.
  */

+/dts-v1/;

 / {
 	model = "EP88xC";
@@ -23,44 +24,44 @@

 		PowerPC,885@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <d#16>;
-			i-cache-line-size = <d#16>;
-			d-cache-size = <d#8192>;
-			i-cache-size = <d#8192>;
+			reg = <0x0>;
+			d-cache-line-size = <16>;
+			i-cache-line-size = <16>;
+			d-cache-size = <8192>;
+			i-cache-size = <8192>;
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			interrupts = <f 2>;	// decrementer interrupt
+			interrupts = <15 2>;	// decrementer interrupt
 			interrupt-parent = <&PIC>;
 		};
 	};

 	memory {
 		device_type = "memory";
-		reg = <0 0>;
+		reg = <0x0 0x0>;
 	};

 	localbus@fa200100 {
 		compatible = "fsl,mpc885-localbus", "fsl,pq1-localbus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-		reg = <fa200100 40>;
+		reg = <0xfa200100 0x40>;

 		ranges = <
-			0 0 fc000000 04000000
-			3 0 fa000000 01000000
+			0x0 0x0 0xfc000000 0x4000000
+			0x3 0x0 0xfa000000 0x1000000
 		>;

 		flash@0,2000000 {
 			compatible = "cfi-flash";
-			reg = <0 2000000 2000000>;
+			reg = <0x0 0x2000000 0x2000000>;
 			bank-width = <4>;
 			device-width = <2>;
 		};

 		board-control@3,400000 {
-			reg = <3 400000 10>;
+			reg = <0x3 0x400000 0x10>;
 			compatible = "fsl,ep88xc-bcsr";
 		};
 	};
@@ -70,25 +71,25 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <0 fa200000 00004000>;
+		ranges = <0x0 0xfa200000 0x4000>;
 		bus-frequency = <0>;

 		// Temporary -- will go away once kernel uses ranges for get_immrbase().
-		reg = <fa200000 4000>;
+		reg = <0xfa200000 0x4000>;

 		mdio@e00 {
 			compatible = "fsl,mpc885-fec-mdio", "fsl,pq1-fec-mdio";
-			reg = <e00 188>;
+			reg = <0xe00 0x188>;
 			#address-cells = <1>;
 			#size-cells = <0>;

 			PHY0: ethernet-phy@0 {
-				reg = <0>;
+				reg = <0x0>;
 				device_type = "ethernet-phy";
 			};

 			PHY1: ethernet-phy@1 {
-				reg = <1>;
+				reg = <0x1>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -97,7 +98,7 @@
 			device_type = "network";
 			compatible = "fsl,mpc885-fec-enet",
 			             "fsl,pq1-fec-enet";
-			reg = <e00 188>;
+			reg = <0xe00 0x188>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <3 1>;
 			interrupt-parent = <&PIC>;
@@ -109,7 +110,7 @@
 			device_type = "network";
 			compatible = "fsl,mpc885-fec-enet",
 			             "fsl,pq1-fec-enet";
-			reg = <1e00 188>;
+			reg = <0x1e00 0x188>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <7 1>;
 			interrupt-parent = <&PIC>;
@@ -120,7 +121,7 @@
 		PIC: interrupt-controller@0 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			reg = <0 24>;
+			reg = <0x0 0x24>;
 			compatible = "fsl,mpc885-pic", "fsl,pq1-pic";
 		};

@@ -130,29 +131,29 @@
 			#size-cells = <2>;
 			compatible = "fsl,pq-pcmcia";
 			device_type = "pcmcia";
-			reg = <80 80>;
+			reg = <0x80 0x80>;
 			interrupt-parent = <&PIC>;
-			interrupts = <d 1>;
+			interrupts = <13 1>;
 		};

 		cpm@9c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "fsl,mpc885-cpm", "fsl,cpm1";
-			command-proc = <9c0>;
+			command-proc = <0x9c0>;
 			interrupts = <0>;	// cpm error interrupt
 			interrupt-parent = <&CPM_PIC>;
-			reg = <9c0 40>;
+			reg = <0x9c0 0x40>;
 			ranges;

 			muram@2000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				ranges = <0 2000 2000>;
+				ranges = <0x0 0x2000 0x2000>;

 				data@0 {
 					compatible = "fsl,cpm-muram-data";
-					reg = <0 1c00>;
+					reg = <0x0 0x1c00>;
 				};
 			};

@@ -160,7 +161,7 @@
 				compatible = "fsl,mpc885-brg",
 				             "fsl,cpm1-brg",
 				             "fsl,cpm-brg";
-				reg = <9f0 10>;
+				reg = <0x9f0 0x10>;
 			};

 			CPM_PIC: interrupt-controller@930 {
@@ -168,7 +169,7 @@
 				#interrupt-cells = <1>;
 				interrupts = <5 2 0 2>;
 				interrupt-parent = <&PIC>;
-				reg = <930 20>;
+				reg = <0x930 0x20>;
 				compatible = "fsl,mpc885-cpm-pic",
 				             "fsl,cpm1-pic";
 			};
@@ -178,11 +179,11 @@
 				device_type = "serial";
 				compatible = "fsl,mpc885-smc-uart",
 				             "fsl,cpm1-smc-uart";
-				reg = <a80 10 3e80 40>;
+				reg = <0xa80 0x10 0x3e80 0x40>;
 				interrupts = <4>;
 				interrupt-parent = <&CPM_PIC>;
 				fsl,cpm-brg = <1>;
-				fsl,cpm-command = <0090>;
+				fsl,cpm-command = <0x90>;
 				linux,planetcore-label = "SMC1";
 			};

@@ -191,11 +192,11 @@
 				device_type = "serial";
 				compatible = "fsl,mpc885-scc-uart",
 				             "fsl,cpm1-scc-uart";
-				reg = <a20 20 3d00 80>;
-				interrupts = <1d>;
+				reg = <0xa20 0x20 0x3d00 0x80>;
+				interrupts = <29>;
 				interrupt-parent = <&CPM_PIC>;
 				fsl,cpm-brg = <2>;
-				fsl,cpm-command = <0040>;
+				fsl,cpm-command = <0x40>;
 				linux,planetcore-label = "SCC2";
 			};

@@ -204,9 +205,9 @@
 				#size-cells = <0>;
 				compatible = "fsl,mpc885-usb",
 				             "fsl,cpm1-usb";
-				reg = <a00 18 1c00 80>;
+				reg = <0xa00 0x18 0x1c00 0x80>;
 				interrupt-parent = <&CPM_PIC>;
-				interrupts = <1e>;
+				interrupts = <30>;
 				fsl,cpm-command = <0000>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index 4469588..2e5a1a1 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -7,6 +7,7 @@
  * Based on sandpoint.dts
  *
  * 2006 (c) G. Liakhovetski <g.liakhovetski@gmx.de>
+ * Copyright 2008 Freescale Semiconductor, Inc.
  *
  * This file is licensed under
  * the terms of the GNU General Public License version 2.  This program
@@ -17,6 +18,8 @@ XXXX add flash parts, rtc, ??

  */

+/dts-v1/;
+
 / {
 	model = "KuroboxHD";
 	compatible = "linkstation";
@@ -35,19 +38,19 @@ XXXX add flash parts, rtc, ??

 		PowerPC,603e { /* Really 8241 */
 			device_type = "cpu";
-			reg = <0>;
-			clock-frequency = <bebc200>;	/* Fixed by bootloader */
-			timebase-frequency = <1743000>; /* Fixed by bootloader */
+			reg = <0x0>;
+			clock-frequency = <200000000>;	/* Fixed by bootloader */
+			timebase-frequency = <24391680>; /* Fixed by bootloader */
 			bus-frequency = <0>;		/* Fixed by bootloader */
 			/* Following required by dtc but not used */
-			i-cache-size = <4000>;
-			d-cache-size = <4000>;
+			i-cache-size = <0x4000>;
+			d-cache-size = <0x4000>;
 		};
 	};

 	memory {
 		device_type = "memory";
-		reg = <00000000 04000000>;
+		reg = <0x0 0x4000000>;
 	};

 	soc10x { /* AFAICT need to make soc for 8245's uarts to be defined */
@@ -56,26 +59,26 @@ XXXX add flash parts, rtc, ??
 		device_type = "soc";
 		compatible = "mpc10x";
 		store-gathering = <0>; /* 0 == off, !0 == on */
-		reg = <80000000 00100000>;
-		ranges = <80000000 80000000 70000000	/* pci mem space */
-			  fc000000 fc000000 00100000	/* EUMB */
-			  fe000000 fe000000 00c00000	/* pci i/o space */
-			  fec00000 fec00000 00300000	/* pci cfg regs */
-			  fef00000 fef00000 00100000>;	/* pci iack */
+		reg = <0x80000000 0x100000>;
+		ranges = <0x80000000 0x80000000 0x70000000	/* pci mem space */
+			  0xfc000000 0xfc000000 0x100000	/* EUMB */
+			  0xfe000000 0xfe000000 0xc00000	/* pci i/o space */
+			  0xfec00000 0xfec00000 0x300000	/* pci cfg regs */
+			  0xfef00000 0xfef00000 0x100000>;	/* pci iack */

 		i2c@80003000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl-i2c";
-			reg = <80003000 1000>;
+			reg = <0x80003000 0x1000>;
 			interrupts = <5 2>;
 			interrupt-parent = <&mpic>;

 			rtc@32 {
 				device_type = "rtc";
 				compatible = "ricoh,rs5c372a";
-				reg = <32>;
+				reg = <0x32>;
 			};
 		};

@@ -83,9 +86,9 @@ XXXX add flash parts, rtc, ??
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <80004500 8>;
-			clock-frequency = <5d08d88>;
-			current-speed = <2580>;
+			reg = <0x80004500 0x8>;
+			clock-frequency = <97553800>;
+			current-speed = <9600>;
 			interrupts = <9 0>;
 			interrupt-parent = <&mpic>;
 		};
@@ -94,10 +97,10 @@ XXXX add flash parts, rtc, ??
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <80004600 8>;
-			clock-frequency = <5d08d88>;
-			current-speed = <e100>;
-			interrupts = <a 0>;
+			reg = <0x80004600 0x8>;
+			clock-frequency = <97553800>;
+			current-speed = <57600>;
+			interrupts = <10 0>;
 			interrupt-parent = <&mpic>;
 		};

@@ -107,7 +110,7 @@ XXXX add flash parts, rtc, ??
 			device_type = "open-pic";
 			compatible = "chrp,open-pic";
 			interrupt-controller;
-			reg = <80040000 40000>;
+			reg = <0x80040000 0x40000>;
 		};

 		pci0: pci@fec00000 {
@@ -116,29 +119,29 @@ XXXX add flash parts, rtc, ??
 			#interrupt-cells = <1>;
 			device_type = "pci";
 			compatible = "mpc10x-pci";
-			reg = <fec00000 400000>;
-			ranges = <01000000 0        0 fe000000 0 00c00000
-				  02000000 0 80000000 80000000 0 70000000>;
-			bus-range = <0 ff>;
-			clock-frequency = <7f28155>;
+			reg = <0xfec00000 0x400000>;
+			ranges = <0x1000000 0x0        0x0 0xfe000000 0x0 0xc00000
+				  0x2000000 0x0 0x80000000 0x80000000 0x0 0x70000000>;
+			bus-range = <0 255>;
+			clock-frequency = <133333333>;
 			interrupt-parent = <&mpic>;
-			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 			interrupt-map = <
 				/* IDSEL 11 - IRQ0 ETH */
-				5800 0 0 1 &mpic 0 1
-				5800 0 0 2 &mpic 1 1
-				5800 0 0 3 &mpic 2 1
-				5800 0 0 4 &mpic 3 1
+				0x5800 0x0 0x0 0x1 &mpic 0x0 0x1
+				0x5800 0x0 0x0 0x2 &mpic 0x1 0x1
+				0x5800 0x0 0x0 0x3 &mpic 0x2 0x1
+				0x5800 0x0 0x0 0x4 &mpic 0x3 0x1
 				/* IDSEL 12 - IRQ1 IDE0 */
-				6000 0 0 1 &mpic 1 1
-				6000 0 0 2 &mpic 2 1
-				6000 0 0 3 &mpic 3 1
-				6000 0 0 4 &mpic 0 1
+				0x6000 0x0 0x0 0x1 &mpic 0x1 0x1
+				0x6000 0x0 0x0 0x2 &mpic 0x2 0x1
+				0x6000 0x0 0x0 0x3 &mpic 0x3 0x1
+				0x6000 0x0 0x0 0x4 &mpic 0x0 0x1
 				/* IDSEL 14 - IRQ3 USB2.0 */
-				7000 0 0 1 &mpic 3 1
-				7000 0 0 2 &mpic 3 1
-				7000 0 0 3 &mpic 3 1
-				7000 0 0 4 &mpic 3 1
+				0x7000 0x0 0x0 0x1 &mpic 0x3 0x1
+				0x7000 0x0 0x0 0x2 &mpic 0x3 0x1
+				0x7000 0x0 0x0 0x3 &mpic 0x3 0x1
+				0x7000 0x0 0x0 0x4 &mpic 0x3 0x1
 			>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index 8443c85..e4916e6 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -7,6 +7,7 @@
  * Based on sandpoint.dts
  *
  * 2006 (c) G. Liakhovetski <g.liakhovetski@gmx.de>
+ * Copyright 2008 Freescale Semiconductor, Inc.
  *
  * This file is licensed under
  * the terms of the GNU General Public License version 2.  This program
@@ -17,6 +18,8 @@ XXXX add flash parts, rtc, ??

  */

+/dts-v1/;
+
 / {
 	model = "KuroboxHG";
 	compatible = "linkstation";
@@ -35,19 +38,19 @@ XXXX add flash parts, rtc, ??

 		PowerPC,603e { /* Really 8241 */
 			device_type = "cpu";
-			reg = <0>;
-			clock-frequency = <fdad680>;	/* Fixed by bootloader */
-			timebase-frequency = <1F04000>; /* Fixed by bootloader */
+			reg = <0x0>;
+			clock-frequency = <266000000>;	/* Fixed by bootloader */
+			timebase-frequency = <32522240>; /* Fixed by bootloader */
 			bus-frequency = <0>;		/* Fixed by bootloader */
 			/* Following required by dtc but not used */
-			i-cache-size = <4000>;
-			d-cache-size = <4000>;
+			i-cache-size = <0x4000>;
+			d-cache-size = <0x4000>;
 		};
 	};

 	memory {
 		device_type = "memory";
-		reg = <00000000 08000000>;
+		reg = <0x0 0x8000000>;
 	};

 	soc10x { /* AFAICT need to make soc for 8245's uarts to be defined */
@@ -56,26 +59,26 @@ XXXX add flash parts, rtc, ??
 		device_type = "soc";
 		compatible = "mpc10x";
 		store-gathering = <0>; /* 0 == off, !0 == on */
-		reg = <80000000 00100000>;
-		ranges = <80000000 80000000 70000000	/* pci mem space */
-			  fc000000 fc000000 00100000	/* EUMB */
-			  fe000000 fe000000 00c00000	/* pci i/o space */
-			  fec00000 fec00000 00300000	/* pci cfg regs */
-			  fef00000 fef00000 00100000>;	/* pci iack */
+		reg = <0x80000000 0x100000>;
+		ranges = <0x80000000 0x80000000 0x70000000	/* pci mem space */
+			  0xfc000000 0xfc000000 0x100000	/* EUMB */
+			  0xfe000000 0xfe000000 0xc00000	/* pci i/o space */
+			  0xfec00000 0xfec00000 0x300000	/* pci cfg regs */
+			  0xfef00000 0xfef00000 0x100000>;	/* pci iack */

 		i2c@80003000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl-i2c";
-			reg = <80003000 1000>;
+			reg = <0x80003000 0x1000>;
 			interrupts = <5 2>;
 			interrupt-parent = <&mpic>;

 			rtc@32 {
 				device_type = "rtc";
 				compatible = "ricoh,rs5c372a";
-				reg = <32>;
+				reg = <0x32>;
 			};
 		};

@@ -83,9 +86,9 @@ XXXX add flash parts, rtc, ??
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <80004500 8>;
-			clock-frequency = <7c044a8>;
-			current-speed = <2580>;
+			reg = <0x80004500 0x8>;
+			clock-frequency = <130041000>;
+			current-speed = <9600>;
 			interrupts = <9 0>;
 			interrupt-parent = <&mpic>;
 		};
@@ -94,10 +97,10 @@ XXXX add flash parts, rtc, ??
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <80004600 8>;
-			clock-frequency = <7c044a8>;
-			current-speed = <e100>;
-			interrupts = <a 0>;
+			reg = <0x80004600 0x8>;
+			clock-frequency = <130041000>;
+			current-speed = <57600>;
+			interrupts = <10 0>;
 			interrupt-parent = <&mpic>;
 		};

@@ -107,7 +110,7 @@ XXXX add flash parts, rtc, ??
 			device_type = "open-pic";
 			compatible = "chrp,open-pic";
 			interrupt-controller;
-			reg = <80040000 40000>;
+			reg = <0x80040000 0x40000>;
 		};

 		pci0: pci@fec00000 {
@@ -116,29 +119,29 @@ XXXX add flash parts, rtc, ??
 			#interrupt-cells = <1>;
 			device_type = "pci";
 			compatible = "mpc10x-pci";
-			reg = <fec00000 400000>;
-			ranges = <01000000 0        0 fe000000 0 00c00000
-				  02000000 0 80000000 80000000 0 70000000>;
-			bus-range = <0 ff>;
-			clock-frequency = <7f28155>;
+			reg = <0xfec00000 0x400000>;
+			ranges = <0x1000000 0x0        0x0 0xfe000000 0x0 0xc00000
+				  0x2000000 0x0 0x80000000 0x80000000 0x0 0x70000000>;
+			bus-range = <0 255>;
+			clock-frequency = <133333333>;
 			interrupt-parent = <&mpic>;
-			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 			interrupt-map = <
 				/* IDSEL 11 - IRQ0 ETH */
-				5800 0 0 1 &mpic 0 1
-				5800 0 0 2 &mpic 1 1
-				5800 0 0 3 &mpic 2 1
-				5800 0 0 4 &mpic 3 1
+				0x5800 0x0 0x0 0x1 &mpic 0x0 0x1
+				0x5800 0x0 0x0 0x2 &mpic 0x1 0x1
+				0x5800 0x0 0x0 0x3 &mpic 0x2 0x1
+				0x5800 0x0 0x0 0x4 &mpic 0x3 0x1
 				/* IDSEL 12 - IRQ1 IDE0 */
-				6000 0 0 1 &mpic 1 1
-				6000 0 0 2 &mpic 2 1
-				6000 0 0 3 &mpic 3 1
-				6000 0 0 4 &mpic 0 1
+				0x6000 0x0 0x0 0x1 &mpic 0x1 0x1
+				0x6000 0x0 0x0 0x2 &mpic 0x2 0x1
+				0x6000 0x0 0x0 0x3 &mpic 0x3 0x1
+				0x6000 0x0 0x0 0x4 &mpic 0x0 0x1
 				/* IDSEL 14 - IRQ3 USB2.0 */
-				7000 0 0 1 &mpic 3 1
-				7000 0 0 2 &mpic 3 1
-				7000 0 0 3 &mpic 3 1
-				7000 0 0 4 &mpic 3 1
+				0x7000 0x0 0x0 0x1 &mpic 0x3 0x1
+				0x7000 0x0 0x0 0x2 &mpic 0x3 0x1
+				0x7000 0x0 0x0 0x3 &mpic 0x3 0x1
+				0x7000 0x0 0x0 0x4 &mpic 0x3 0x1
 			>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index 8fb5423..4936349 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -1,7 +1,7 @@
 /*
  * MPC7448HPC2 (Taiga) board Device Tree Source
  *
- * Copyright 2006 Freescale Semiconductor Inc.
+ * Copyright 2006, 2008 Freescale Semiconductor Inc.
  * 2006 Roy Zang <Roy Zang at freescale.com>.
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -10,6 +10,7 @@
  * option) any later version.
  */

+/dts-v1/;

 / {
 	model = "mpc7448hpc2";
@@ -23,11 +24,11 @@

 		PowerPC,7448@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <8000>;		// L1, 32K bytes
-			i-cache-size = <8000>;		// L1, 32K bytes
+			reg = <0x0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <0x8000>;		// L1, 32K bytes
+			i-cache-size = <0x8000>;		// L1, 32K bytes
 			timebase-frequency = <0>;	// 33 MHz, from uboot
 			clock-frequency = <0>;		// From U-Boot
 			bus-frequency = <0>;		// From U-Boot
@@ -36,7 +37,7 @@

 	memory {
 		device_type = "memory";
-		reg = <00000000 20000000	// DDR2   512M at 0
+		reg = <0x0 0x20000000	// DDR2   512M at 0
 		       >;
 	};

@@ -44,14 +45,14 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "tsi-bridge";
-		ranges = <00000000 c0000000 00010000>;
-		reg = <c0000000 00010000>;
+		ranges = <0x0 0xc0000000 0x10000>;
+		reg = <0xc0000000 0x10000>;
 		bus-frequency = <0>;

 		i2c@7000 {
 			interrupt-parent = <&mpic>;
-			interrupts = <E 0>;
-			reg = <7000 400>;
+			interrupts = <14 0>;
+			reg = <0x7000 0x400>;
 			device_type = "i2c";
 			compatible  = "tsi108-i2c";
 		};
@@ -59,20 +60,20 @@
 		MDIO: mdio@6000 {
 			device_type = "mdio";
 			compatible = "tsi108-mdio";
-			reg = <6000 50>;
+			reg = <0x6000 0x50>;
 			#address-cells = <1>;
 			#size-cells = <0>;

 			phy8: ethernet-phy@8 {
 				interrupt-parent = <&mpic>;
 				interrupts = <2 1>;
-				reg = <8>;
+				reg = <0x8>;
 			};

 			phy9: ethernet-phy@9 {
 				interrupt-parent = <&mpic>;
 				interrupts = <2 1>;
-				reg = <9>;
+				reg = <0x9>;
 			};

 		};
@@ -82,9 +83,9 @@
 			#size-cells = <0>;
 			device_type = "network";
 			compatible = "tsi108-ethernet";
-			reg = <6000 200>;
+			reg = <0x6000 0x200>;
 			address = [ 00 06 D2 00 00 01 ];
-			interrupts = <10 2>;
+			interrupts = <16 2>;
 			interrupt-parent = <&mpic>;
 			mdio-handle = <&MDIO>;
 			phy-handle = <&phy8>;
@@ -96,9 +97,9 @@
 			#size-cells = <0>;
 			device_type = "network";
 			compatible = "tsi108-ethernet";
-			reg = <6400 200>;
+			reg = <0x6400 0x200>;
 			address = [ 00 06 D2 00 00 02 ];
-			interrupts = <11 2>;
+			interrupts = <17 2>;
 			interrupt-parent = <&mpic>;
 			mdio-handle = <&MDIO>;
 			phy-handle = <&phy9>;
@@ -107,18 +108,18 @@
 		serial@7808 {
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <7808 200>;
-			clock-frequency = <3f6b5a00>;
-			interrupts = <c 0>;
+			reg = <0x7808 0x200>;
+			clock-frequency = <1064000000>;
+			interrupts = <12 0>;
 			interrupt-parent = <&mpic>;
 		};

 		serial@7c08 {
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <7c08 200>;
-			clock-frequency = <3f6b5a00>;
-			interrupts = <d 0>;
+			reg = <0x7c08 0x200>;
+			clock-frequency = <1064000000>;
+			interrupts = <13 0>;
 			interrupt-parent = <&mpic>;
 		};

@@ -127,7 +128,7 @@
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
-			reg = <7400 400>;
+			reg = <0x7400 0x400>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
                        	big-endian;
@@ -138,39 +139,39 @@
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			reg = <1000 1000>;
+			reg = <0x1000 0x1000>;
 			bus-range = <0 0>;
-			ranges = <02000000 0 e0000000 e0000000 0 1A000000
-				  01000000 0 00000000 fa000000 0 00010000>;
-			clock-frequency = <7f28154>;
+			ranges = <0x2000000 0x0 0xe0000000 0xe0000000 0x0 0x1a000000
+				  0x1000000 0x0 0x0 0xfa000000 0x0 0x10000>;
+			clock-frequency = <133333332>;
 			interrupt-parent = <&mpic>;
-			interrupts = <17 2>;
-			interrupt-map-mask = <f800 0 0 7>;
+			interrupts = <23 2>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 			interrupt-map = <

 				/* IDSEL 0x11 */
-				0800 0 0 1 &RT0 24 0
-				0800 0 0 2 &RT0 25 0
-				0800 0 0 3 &RT0 26 0
-				0800 0 0 4 &RT0 27 0
+				0x800 0x0 0x0 0x1 &RT0 0x24 0x0
+				0x800 0x0 0x0 0x2 &RT0 0x25 0x0
+				0x800 0x0 0x0 0x3 &RT0 0x26 0x0
+				0x800 0x0 0x0 0x4 &RT0 0x27 0x0

 				/* IDSEL 0x12 */
-				1000 0 0 1 &RT0 25 0
-				1000 0 0 2 &RT0 26 0
-				1000 0 0 3 &RT0 27 0
-				1000 0 0 4 &RT0 24 0
+				0x1000 0x0 0x0 0x1 &RT0 0x25 0x0
+				0x1000 0x0 0x0 0x2 &RT0 0x26 0x0
+				0x1000 0x0 0x0 0x3 &RT0 0x27 0x0
+				0x1000 0x0 0x0 0x4 &RT0 0x24 0x0

 				/* IDSEL 0x13 */
-				1800 0 0 1 &RT0 26 0
-				1800 0 0 2 &RT0 27 0
-				1800 0 0 3 &RT0 24 0
-				1800 0 0 4 &RT0 25 0
+				0x1800 0x0 0x0 0x1 &RT0 0x26 0x0
+				0x1800 0x0 0x0 0x2 &RT0 0x27 0x0
+				0x1800 0x0 0x0 0x3 &RT0 0x24 0x0
+				0x1800 0x0 0x0 0x4 &RT0 0x25 0x0

 				/* IDSEL 0x14 */
-				2000 0 0 1 &RT0 27 0
-				2000 0 0 2 &RT0 24 0
-				2000 0 0 3 &RT0 25 0
-				2000 0 0 4 &RT0 26 0
+				0x2000 0x0 0x0 0x1 &RT0 0x27 0x0
+				0x2000 0x0 0x0 0x2 &RT0 0x24 0x0
+				0x2000 0x0 0x0 0x3 &RT0 0x25 0x0
+				0x2000 0x0 0x0 0x4 &RT0 0x26 0x0
 				>;

 			RT0: router@1180 {
@@ -180,7 +181,7 @@
 				#address-cells = <0>;
 				#interrupt-cells = <2>;
 				big-endian;
-				interrupts = <17 2>;
+				interrupts = <23 2>;
 				interrupt-parent = <&mpic>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 7285ca1..46e2da3 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -1,7 +1,7 @@
 /*
  * MPC8272 ADS Device Tree Source
  *
- * Copyright 2005 Freescale Semiconductor Inc.
+ * Copyright 2005,2008 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -9,6 +9,8 @@
  * option) any later version.
  */

+/dts-v1/;
+
 / {
 	model = "MPC8272ADS";
 	compatible = "fsl,mpc8272ads";
@@ -21,11 +23,11 @@

 		PowerPC,8272@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <d#32>;
-			i-cache-line-size = <d#32>;
-			d-cache-size = <d#16384>;
-			i-cache-size = <d#16384>;
+			reg = <0x0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <16384>;
+			i-cache-size = <16384>;
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
@@ -34,7 +36,7 @@

 	memory {
 		device_type = "memory";
-		reg = <0 0>;
+		reg = <0x0 0x0>;
 	};

 	localbus@f0010100 {
@@ -42,21 +44,21 @@
 		             "fsl,pq2-localbus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-		reg = <f0010100 40>;
+		reg = <0xf0010100 0x40>;

-		ranges = <0 0 fe000000 02000000
-		          1 0 f4500000 00008000
-		          3 0 f8200000 00008000>;
+		ranges = <0x0 0x0 0xfe000000 0x2000000
+		          0x1 0x0 0xf4500000 0x8000
+		          0x3 0x0 0xf8200000 0x8000>;

 		flash@0,0 {
 			compatible = "jedec-flash";
-			reg = <0 0 2000000>;
+			reg = <0x0 0x0 0x2000000>;
 			bank-width = <4>;
 			device-width = <1>;
 		};

 		board-control@1,0 {
-			reg = <1 0 20>;
+			reg = <0x1 0x0 0x20>;
 			compatible = "fsl,mpc8272ads-bcsr";
 		};

@@ -65,46 +67,46 @@
 			             "fsl,pq2ads-pci-pic";
 			#interrupt-cells = <1>;
 			interrupt-controller;
-			reg = <3 0 8>;
+			reg = <0x3 0x0 0x8>;
 			interrupt-parent = <&PIC>;
-			interrupts = <14 8>;
+			interrupts = <20 8>;
 		};
 	};


 	pci@f0010800 {
 		device_type = "pci";
-		reg = <f0010800 10c f00101ac 8 f00101c4 8>;
+		reg = <0xf0010800 0x10c 0xf00101ac 0x8 0xf00101c4 0x8>;
 		compatible = "fsl,mpc8272-pci", "fsl,pq2-pci";
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		clock-frequency = <d#66666666>;
-		interrupt-map-mask = <f800 0 0 7>;
+		clock-frequency = <66666666>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 		                 /* IDSEL 0x16 */
-		                 b000 0 0 1 &PCI_PIC 0
-		                 b000 0 0 2 &PCI_PIC 1
-		                 b000 0 0 3 &PCI_PIC 2
-		                 b000 0 0 4 &PCI_PIC 3
+		                 0xb000 0x0 0x0 0x1 &PCI_PIC 0
+		                 0xb000 0x0 0x0 0x2 &PCI_PIC 1
+		                 0xb000 0x0 0x0 0x3 &PCI_PIC 2
+		                 0xb000 0x0 0x0 0x4 &PCI_PIC 3

 		                 /* IDSEL 0x17 */
-		                 b800 0 0 1 &PCI_PIC 4
-		                 b800 0 0 2 &PCI_PIC 5
-		                 b800 0 0 3 &PCI_PIC 6
-		                 b800 0 0 4 &PCI_PIC 7
+		                 0xb800 0x0 0x0 0x1 &PCI_PIC 4
+		                 0xb800 0x0 0x0 0x2 &PCI_PIC 5
+		                 0xb800 0x0 0x0 0x3 &PCI_PIC 6
+		                 0xb800 0x0 0x0 0x4 &PCI_PIC 7

 		                 /* IDSEL 0x18 */
-		                 c000 0 0 1 &PCI_PIC 8
-		                 c000 0 0 2 &PCI_PIC 9
-		                 c000 0 0 3 &PCI_PIC a
-		                 c000 0 0 4 &PCI_PIC b>;
+		                 0xc000 0x0 0x0 0x1 &PCI_PIC 8
+		                 0xc000 0x0 0x0 0x2 &PCI_PIC 9
+		                 0xc000 0x0 0x0 0x3 &PCI_PIC 10
+		                 0xc000 0x0 0x0 0x4 &PCI_PIC 11>;

 		interrupt-parent = <&PIC>;
-		interrupts = <12 8>;
-		ranges = <42000000 0 80000000 80000000 0 20000000
-		          02000000 0 a0000000 a0000000 0 20000000
-		          01000000 0 00000000 f6000000 0 02000000>;
+		interrupts = <18 8>;
+		ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x20000000
+		          0x2000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
+		          0x1000000 0x0 0x0 0xf6000000 0x0 0x2000000>;
 	};

 	soc@f0000000 {
@@ -112,26 +114,26 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		compatible = "fsl,mpc8272", "fsl,pq2-soc";
-		ranges = <00000000 f0000000 00053000>;
+		ranges = <0x0 0xf0000000 0x53000>;

 		// Temporary -- will go away once kernel uses ranges for get_immrbase().
-		reg = <f0000000 00053000>;
+		reg = <0xf0000000 0x53000>;

 		cpm@119c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "fsl,mpc8272-cpm", "fsl,cpm2";
-			reg = <119c0 30>;
+			reg = <0x119c0 0x30>;
 			ranges;

 			muram@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				ranges = <0 0 10000>;
+				ranges = <0x0 0x0 0x10000>;

 				data@0 {
 					compatible = "fsl,cpm-muram-data";
-					reg = <0 2000 9800 800>;
+					reg = <0x0 0x2000 0x9800 0x800>;
 				};
 			};

@@ -139,29 +141,29 @@
 				compatible = "fsl,mpc8272-brg",
 				             "fsl,cpm2-brg",
 				             "fsl,cpm-brg";
-				reg = <119f0 10 115f0 10>;
+				reg = <0x119f0 0x10 0x115f0 0x10>;
 			};

 			serial@11a00 {
 				device_type = "serial";
 				compatible = "fsl,mpc8272-scc-uart",
 				             "fsl,cpm2-scc-uart";
-				reg = <11a00 20 8000 100>;
-				interrupts = <28 8>;
+				reg = <0x11a00 0x20 0x8000 0x100>;
+				interrupts = <40 8>;
 				interrupt-parent = <&PIC>;
 				fsl,cpm-brg = <1>;
-				fsl,cpm-command = <00800000>;
+				fsl,cpm-command = <0x800000>;
 			};

 			serial@11a60 {
 				device_type = "serial";
 				compatible = "fsl,mpc8272-scc-uart",
 				             "fsl,cpm2-scc-uart";
-				reg = <11a60 20 8300 100>;
-				interrupts = <2b 8>;
+				reg = <0x11a60 0x20 0x8300 0x100>;
+				interrupts = <43 8>;
 				interrupt-parent = <&PIC>;
 				fsl,cpm-brg = <4>;
-				fsl,cpm-command = <0ce00000>;
+				fsl,cpm-command = <0xce00000>;
 			};

 			mdio@10d40 {
@@ -169,23 +171,23 @@
 				compatible = "fsl,mpc8272ads-mdio-bitbang",
 				             "fsl,mpc8272-mdio-bitbang",
 				             "fsl,cpm2-mdio-bitbang";
-				reg = <10d40 14>;
+				reg = <0x10d40 0x14>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				fsl,mdio-pin = <12>;
-				fsl,mdc-pin = <13>;
+				fsl,mdio-pin = <18>;
+				fsl,mdc-pin = <19>;

 				PHY0: ethernet-phy@0 {
 					interrupt-parent = <&PIC>;
-					interrupts = <17 8>;
-					reg = <0>;
+					interrupts = <23 8>;
+					reg = <0x0>;
 					device_type = "ethernet-phy";
 				};

 				PHY1: ethernet-phy@1 {
 					interrupt-parent = <&PIC>;
-					interrupts = <17 8>;
-					reg = <3>;
+					interrupts = <23 8>;
+					reg = <0x3>;
 					device_type = "ethernet-phy";
 				};
 			};
@@ -194,33 +196,33 @@
 				device_type = "network";
 				compatible = "fsl,mpc8272-fcc-enet",
 				             "fsl,cpm2-fcc-enet";
-				reg = <11300 20 8400 100 11390 1>;
+				reg = <0x11300 0x20 0x8400 0x100 0x11390 0x1>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
-				interrupts = <20 8>;
+				interrupts = <32 8>;
 				interrupt-parent = <&PIC>;
 				phy-handle = <&PHY0>;
 				linux,network-index = <0>;
-				fsl,cpm-command = <12000300>;
+				fsl,cpm-command = <0x12000300>;
 			};

 			ethernet@11320 {
 				device_type = "network";
 				compatible = "fsl,mpc8272-fcc-enet",
 				             "fsl,cpm2-fcc-enet";
-				reg = <11320 20 8500 100 113b0 1>;
+				reg = <0x11320 0x20 0x8500 0x100 0x113b0 0x1>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
-				interrupts = <21 8>;
+				interrupts = <33 8>;
 				interrupt-parent = <&PIC>;
 				phy-handle = <&PHY1>;
 				linux,network-index = <1>;
-				fsl,cpm-command = <16200300>;
+				fsl,cpm-command = <0x16200300>;
 			};
 		};

 		PIC: interrupt-controller@10c00 {
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			reg = <10c00 80>;
+			reg = <0x10c00 0x80>;
 			compatible = "fsl,mpc8272-pic", "fsl,cpm2-pic";
 		};

@@ -232,14 +234,14 @@
 			             "fsl,talitos-sec2",
 			             "fsl,talitos",
 			             "talitos";
-			reg = <30000 10000>;
-			interrupts = <b 8>;
+			reg = <0x30000 0x10000>;
+			interrupts = <11 8>;
 			interrupt-parent = <&PIC>;
 			num-channels = <4>;
-			channel-fifo-len = <18>;
-			exec-units-mask = <0000007e>;
+			channel-fifo-len = <24>;
+			exec-units-mask = <0x7e>;
 /* desc mask is for rev1.x, we need runtime fixup for >=2.x */
-			descriptor-types-mask = <01010ebf>;
+			descriptor-types-mask = <0x1010ebf>;
 		};
 	};

diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index daf9433..765e43c 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -2,6 +2,7 @@
  * MPC866 ADS Device Tree Source
  *
  * Copyright 2006 MontaVista Software, Inc.
+ * Copyright 2008 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -9,6 +10,7 @@
  * option) any later version.
  */

+/dts-v1/;

 / {
 	model = "MPC866ADS";
@@ -22,37 +24,37 @@

 		PowerPC,866@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <10>;	// 16 bytes
-			i-cache-line-size = <10>;	// 16 bytes
-			d-cache-size = <2000>;		// L1, 8K
-			i-cache-size = <4000>;		// L1, 16K
+			reg = <0x0>;
+			d-cache-line-size = <16>;	// 16 bytes
+			i-cache-line-size = <16>;	// 16 bytes
+			d-cache-size = <0x2000>;		// L1, 8K
+			i-cache-size = <0x4000>;		// L1, 16K
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			interrupts = <f 2>;	// decrementer interrupt
+			interrupts = <15 2>;	// decrementer interrupt
 			interrupt-parent = <&PIC>;
 		};
 	};

 	memory {
 		device_type = "memory";
-		reg = <00000000 800000>;
+		reg = <0x0 0x800000>;
 	};

 	localbus@ff000100 {
 		compatible = "fsl,mpc866-localbus", "fsl,pq1-localbus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-		reg = <ff000100 40>;
+		reg = <0xff000100 0x40>;

 		ranges = <
-			1 0 ff080000 00008000
-			5 0 ff0a0000 00008000
+			0x1 0x0 0xff080000 0x8000
+			0x5 0x0 0xff0a0000 0x8000
 		>;

 		board-control@1,0 {
-			reg = <1 0 20 5 300 4>;
+			reg = <0x1 0x0 0x20 0x5 0x300 0x4>;
 			compatible = "fsl,mpc866ads-bcsr";
 		};
 	};
@@ -61,17 +63,17 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <0 ff000000 00100000>;
-		reg = <ff000000 00000200>;
+		ranges = <0x0 0xff000000 0x100000>;
+		reg = <0xff000000 0x200>;
 		bus-frequency = <0>;

 		mdio@e00 {
 			compatible = "fsl,mpc866-fec-mdio", "fsl,pq1-fec-mdio";
-			reg = <e00 188>;
+			reg = <0xe00 0x188>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			PHY: ethernet-phy@f {
-				reg = <f>;
+				reg = <0xf>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -80,7 +82,7 @@
 			device_type = "network";
 			compatible = "fsl,mpc866-fec-enet",
 			             "fsl,pq1-fec-enet";
-			reg = <e00 188>;
+			reg = <0xe00 0x188>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <3 1>;
 			interrupt-parent = <&PIC>;
@@ -91,7 +93,7 @@
 		PIC: pic@0 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			reg = <0 24>;
+			reg = <0x0 0x24>;
 			compatible = "fsl,mpc866-pic", "fsl,pq1-pic";
 		};

@@ -100,7 +102,7 @@
 			#size-cells = <1>;
 			compatible = "fsl,mpc866-cpm", "fsl,cpm1";
 			ranges;
-			reg = <9c0 40>;
+			reg = <0x9c0 0x40>;
 			brg-frequency = <0>;
 			interrupts = <0 2>;	// cpm error interrupt
 			interrupt-parent = <&CPM_PIC>;
@@ -108,11 +110,11 @@
 			muram@2000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				ranges = <0 2000 2000>;
+				ranges = <0x0 0x2000 0x2000>;

 				data@0 {
 					compatible = "fsl,cpm-muram-data";
-					reg = <0 1c00>;
+					reg = <0x0 0x1c00>;
 				};
 			};

@@ -120,7 +122,7 @@
 				compatible = "fsl,mpc866-brg",
 					     "fsl,cpm1-brg",
 					     "fsl,cpm-brg";
-				reg = <9f0 10>;
+				reg = <0x9f0 0x10>;
 				clock-frequency = <0>;
 			};

@@ -130,7 +132,7 @@
 				#interrupt-cells = <1>;
 				interrupts = <5 2 0 2>;
 				interrupt-parent = <&PIC>;
-				reg = <930 20>;
+				reg = <0x930 0x20>;
 				compatible = "fsl,mpc866-cpm-pic",
 				             "fsl,cpm1-pic";
 			};
@@ -140,31 +142,31 @@
 				device_type = "serial";
 				compatible = "fsl,mpc866-smc-uart",
 				             "fsl,cpm1-smc-uart";
-				reg = <a80 10 3e80 40>;
+				reg = <0xa80 0x10 0x3e80 0x40>;
 				interrupts = <4>;
 				interrupt-parent = <&CPM_PIC>;
 				fsl,cpm-brg = <1>;
-				fsl,cpm-command = <0090>;
+				fsl,cpm-command = <0x90>;
 			};

 			serial@a90 {
 				device_type = "serial";
 				compatible = "fsl,mpc866-smc-uart",
 				             "fsl,cpm1-smc-uart";
-				reg = <a90 10 3f80 40>;
+				reg = <0xa90 0x10 0x3f80 0x40>;
 				interrupts = <3>;
 				interrupt-parent = <&CPM_PIC>;
 				fsl,cpm-brg = <2>;
-				fsl,cpm-command = <00d0>;
+				fsl,cpm-command = <0xd0>;
 			};

 			ethernet@a00 {
 				device_type = "network";
 				compatible = "fsl,mpc866-scc-enet",
 				             "fsl,cpm1-scc-enet";
-				reg = <a00 18 3c00 100>;
+				reg = <0xa00 0x18 0x3c00 0x100>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
-				interrupts = <1e>;
+				interrupts = <30>;
 				interrupt-parent = <&CPM_PIC>;
 				fsl,cpm-command = <0000>;
 				linux,network-index = <1>;
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index d84a012..9895043 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -2,7 +2,7 @@
  * MPC885 ADS Device Tree Source
  *
  * Copyright 2006 MontaVista Software, Inc.
- * Copyright 2007 Freescale Semiconductor, Inc.
+ * Copyright 2007,2008 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -10,6 +10,7 @@
  * option) any later version.
  */

+/dts-v1/;

 / {
 	model = "MPC885ADS";
@@ -23,45 +24,45 @@

 		PowerPC,885@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <d#16>;
-			i-cache-line-size = <d#16>;
-			d-cache-size = <d#8192>;
-			i-cache-size = <d#8192>;
+			reg = <0x0>;
+			d-cache-line-size = <16>;
+			i-cache-line-size = <16>;
+			d-cache-size = <8192>;
+			i-cache-size = <8192>;
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			interrupts = <f 2>;	// decrementer interrupt
+			interrupts = <15 2>;	// decrementer interrupt
 			interrupt-parent = <&PIC>;
 		};
 	};

 	memory {
 		device_type = "memory";
-		reg = <0 0>;
+		reg = <0x0 0x0>;
 	};

 	localbus@ff000100 {
 		compatible = "fsl,mpc885-localbus", "fsl,pq1-localbus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-		reg = <ff000100 40>;
+		reg = <0xff000100 0x40>;

 		ranges = <
-			0 0 fe000000 00800000
-			1 0 ff080000 00008000
-			5 0 ff0a0000 00008000
+			0x0 0x0 0xfe000000 0x800000
+			0x1 0x0 0xff080000 0x8000
+			0x5 0x0 0xff0a0000 0x8000
 		>;

 		flash@0,0 {
 			compatible = "jedec-flash";
-			reg = <0 0 800000>;
+			reg = <0x0 0x0 0x800000>;
 			bank-width = <4>;
 			device-width = <1>;
 		};

 		board-control@1,0 {
-			reg = <1 0 20 5 300 4>;
+			reg = <0x1 0x0 0x20 0x5 0x300 0x4>;
 			compatible = "fsl,mpc885ads-bcsr";
 		};
 	};
@@ -71,30 +72,30 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <0 ff000000 00004000>;
+		ranges = <0x0 0xff000000 0x4000>;
 		bus-frequency = <0>;

 		// Temporary -- will go away once kernel uses ranges for get_immrbase().
-		reg = <ff000000 4000>;
+		reg = <0xff000000 0x4000>;

 		mdio@e00 {
 			compatible = "fsl,mpc885-fec-mdio", "fsl,pq1-fec-mdio";
-			reg = <e00 188>;
+			reg = <0xe00 0x188>;
 			#address-cells = <1>;
 			#size-cells = <0>;

 			PHY0: ethernet-phy@0 {
-				reg = <0>;
+				reg = <0x0>;
 				device_type = "ethernet-phy";
 			};

 			PHY1: ethernet-phy@1 {
-				reg = <1>;
+				reg = <0x1>;
 				device_type = "ethernet-phy";
 			};

 			PHY2: ethernet-phy@2 {
-				reg = <2>;
+				reg = <0x2>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -103,7 +104,7 @@
 			device_type = "network";
 			compatible = "fsl,mpc885-fec-enet",
 			             "fsl,pq1-fec-enet";
-			reg = <e00 188>;
+			reg = <0xe00 0x188>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <3 1>;
 			interrupt-parent = <&PIC>;
@@ -115,7 +116,7 @@
 			device_type = "network";
 			compatible = "fsl,mpc885-fec-enet",
 			             "fsl,pq1-fec-enet";
-			reg = <1e00 188>;
+			reg = <0x1e00 0x188>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <7 1>;
 			interrupt-parent = <&PIC>;
@@ -126,7 +127,7 @@
 		PIC: interrupt-controller@0 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			reg = <0 24>;
+			reg = <0x0 0x24>;
 			compatible = "fsl,mpc885-pic", "fsl,pq1-pic";
 		};

@@ -136,29 +137,29 @@
 			#size-cells = <2>;
 			compatible = "fsl,pq-pcmcia";
 			device_type = "pcmcia";
-			reg = <80 80>;
+			reg = <0x80 0x80>;
 			interrupt-parent = <&PIC>;
-			interrupts = <d 1>;
+			interrupts = <13 1>;
 		};

 		cpm@9c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "fsl,mpc885-cpm", "fsl,cpm1";
-			command-proc = <9c0>;
+			command-proc = <0x9c0>;
 			interrupts = <0>;	// cpm error interrupt
 			interrupt-parent = <&CPM_PIC>;
-			reg = <9c0 40>;
+			reg = <0x9c0 0x40>;
 			ranges;

 			muram@2000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				ranges = <0 2000 2000>;
+				ranges = <0x0 0x2000 0x2000>;

 				data@0 {
 					compatible = "fsl,cpm-muram-data";
-					reg = <0 1c00>;
+					reg = <0x0 0x1c00>;
 				};
 			};

@@ -167,7 +168,7 @@
 				             "fsl,cpm1-brg",
 				             "fsl,cpm-brg";
 				clock-frequency = <0>;
-				reg = <9f0 10>;
+				reg = <0x9f0 0x10>;
 			};

 			CPM_PIC: interrupt-controller@930 {
@@ -175,7 +176,7 @@
 				#interrupt-cells = <1>;
 				interrupts = <5 2 0 2>;
 				interrupt-parent = <&PIC>;
-				reg = <930 20>;
+				reg = <0x930 0x20>;
 				compatible = "fsl,mpc885-cpm-pic",
 				             "fsl,cpm1-pic";
 			};
@@ -184,34 +185,34 @@
 				device_type = "serial";
 				compatible = "fsl,mpc885-smc-uart",
 				             "fsl,cpm1-smc-uart";
-				reg = <a80 10 3e80 40>;
+				reg = <0xa80 0x10 0x3e80 0x40>;
 				interrupts = <4>;
 				interrupt-parent = <&CPM_PIC>;
 				fsl,cpm-brg = <1>;
-				fsl,cpm-command = <0090>;
+				fsl,cpm-command = <0x90>;
 			};

 			serial@a90 {
 				device_type = "serial";
 				compatible = "fsl,mpc885-smc-uart",
 				             "fsl,cpm1-smc-uart";
-				reg = <a90 10 3f80 40>;
+				reg = <0xa90 0x10 0x3f80 0x40>;
 				interrupts = <3>;
 				interrupt-parent = <&CPM_PIC>;
 				fsl,cpm-brg = <2>;
-				fsl,cpm-command = <00d0>;
+				fsl,cpm-command = <0xd0>;
 			};

 			ethernet@a40 {
 				device_type = "network";
 				compatible = "fsl,mpc885-scc-enet",
 				             "fsl,cpm1-scc-enet";
-				reg = <a40 18 3e00 100>;
+				reg = <0xa40 0x18 0x3e00 0x100>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
-				interrupts = <1c>;
+				interrupts = <28>;
 				interrupt-parent = <&CPM_PIC>;
 				phy-handle = <&PHY2>;
-				fsl,cpm-command = <0080>;
+				fsl,cpm-command = <0x80>;
 				linux,network-index = <2>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/pq2fads.dts b/arch/powerpc/boot/dts/pq2fads.dts
index 2d56492..b2d6109 100644
--- a/arch/powerpc/boot/dts/pq2fads.dts
+++ b/arch/powerpc/boot/dts/pq2fads.dts
@@ -1,7 +1,7 @@
 /*
  * Device Tree for the PQ2FADS-ZU board with an MPC8280 chip.
  *
- * Copyright 2007 Freescale Semiconductor Inc.
+ * Copyright 2007,2008 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -9,6 +9,8 @@
  * option) any later version.
  */

+/dts-v1/;
+
 / {
 	model = "pq2fads";
 	compatible = "fsl,pq2fads";
@@ -21,11 +23,11 @@

 		cpu@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <d#32>;
-			i-cache-line-size = <d#32>;
-			d-cache-size = <d#16384>;
-			i-cache-size = <d#16384>;
+			reg = <0x0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <16384>;
+			i-cache-size = <16384>;
 			timebase-frequency = <0>;
 			clock-frequency = <0>;
 		};
@@ -33,7 +35,7 @@

 	memory {
 		device_type = "memory";
-		reg = <0 0>;
+		reg = <0x0 0x0>;
 	};

 	localbus@f0010100 {
@@ -41,67 +43,67 @@
 		             "fsl,pq2-localbus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-		reg = <f0010100 60>;
+		reg = <0xf0010100 0x60>;

-		ranges = <0 0 fe000000 00800000
-		          1 0 f4500000 00008000
-		          8 0 f8200000 00008000>;
+		ranges = <0x0 0x0 0xfe000000 0x800000
+		          0x1 0x0 0xf4500000 0x8000
+		          0x8 0x0 0xf8200000 0x8000>;

 		flash@0,0 {
 			compatible = "jedec-flash";
-			reg = <0 0 800000>;
+			reg = <0x0 0x0 0x800000>;
 			bank-width = <4>;
 			device-width = <1>;
 		};

 		bcsr@1,0 {
-			reg = <1 0 20>;
+			reg = <0x1 0x0 0x20>;
 			compatible = "fsl,pq2fads-bcsr";
 		};

 		PCI_PIC: pic@8,0 {
 			#interrupt-cells = <1>;
 			interrupt-controller;
-			reg = <8 0 8>;
+			reg = <0x8 0x0 0x8>;
 			compatible = "fsl,pq2ads-pci-pic";
 			interrupt-parent = <&PIC>;
-			interrupts = <18 8>;
+			interrupts = <24 8>;
 		};
 	};

 	pci@f0010800 {
 		device_type = "pci";
-		reg = <f0010800 10c f00101ac 8 f00101c4 8>;
+		reg = <0xf0010800 0x10c 0xf00101ac 0x8 0xf00101c4 0x8>;
 		compatible = "fsl,mpc8280-pci", "fsl,pq2-pci";
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		clock-frequency = <d#66000000>;
-		interrupt-map-mask = <f800 0 0 7>;
+		clock-frequency = <66000000>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 		                /* IDSEL 0x16 */
-		                 b000 0 0 1 &PCI_PIC 0
-		                 b000 0 0 2 &PCI_PIC 1
-		                 b000 0 0 3 &PCI_PIC 2
-		                 b000 0 0 4 &PCI_PIC 3
+		                 0xb000 0x0 0x0 0x1 &PCI_PIC 0
+		                 0xb000 0x0 0x0 0x2 &PCI_PIC 1
+		                 0xb000 0x0 0x0 0x3 &PCI_PIC 2
+		                 0xb000 0x0 0x0 0x4 &PCI_PIC 3

 		                /* IDSEL 0x17 */
-		                 b800 0 0 1 &PCI_PIC 4
-		                 b800 0 0 2 &PCI_PIC 5
-		                 b800 0 0 3 &PCI_PIC 6
-		                 b800 0 0 4 &PCI_PIC 7
+		                 0xb800 0x0 0x0 0x1 &PCI_PIC 4
+		                 0xb800 0x0 0x0 0x2 &PCI_PIC 5
+		                 0xb800 0x0 0x0 0x3 &PCI_PIC 6
+		                 0xb800 0x0 0x0 0x4 &PCI_PIC 7

 		                /* IDSEL 0x18 */
-		                 c000 0 0 1 &PCI_PIC 8
-		                 c000 0 0 2 &PCI_PIC 9
-		                 c000 0 0 3 &PCI_PIC a
-		                 c000 0 0 4 &PCI_PIC b>;
+		                 0xc000 0x0 0x0 0x1 &PCI_PIC 8
+		                 0xc000 0x0 0x0 0x2 &PCI_PIC 9
+		                 0xc000 0x0 0x0 0x3 &PCI_PIC 10
+		                 0xc000 0x0 0x0 0x4 &PCI_PIC 11>;

 		interrupt-parent = <&PIC>;
-		interrupts = <12 8>;
-		ranges = <42000000 0 80000000 80000000 0 20000000
-		          02000000 0 a0000000 a0000000 0 20000000
-		          01000000 0 00000000 f6000000 0 02000000>;
+		interrupts = <18 8>;
+		ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x20000000
+		          0x2000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
+		          0x1000000 0x0 0x0 0xf6000000 0x0 0x2000000>;
 	};

 	soc@f0000000 {
@@ -109,27 +111,27 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		compatible = "fsl,mpc8280", "fsl,pq2-soc";
-		ranges = <00000000 f0000000 00053000>;
+		ranges = <0x0 0xf0000000 0x53000>;

 		// Temporary -- will go away once kernel uses ranges for get_immrbase().
-		reg = <f0000000 00053000>;
+		reg = <0xf0000000 0x53000>;

 		cpm@119c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			#interrupt-cells = <2>;
 			compatible = "fsl,mpc8280-cpm", "fsl,cpm2";
-			reg = <119c0 30>;
+			reg = <0x119c0 0x30>;
 			ranges;

 			muram@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				ranges = <0 0 10000>;
+				ranges = <0x0 0x0 0x10000>;

 				data@0 {
 					compatible = "fsl,cpm-muram-data";
-					reg = <0 2000 9800 800>;
+					reg = <0x0 0x2000 0x9800 0x800>;
 				};
 			};

@@ -137,53 +139,53 @@
 				compatible = "fsl,mpc8280-brg",
 				             "fsl,cpm2-brg",
 				             "fsl,cpm-brg";
-				reg = <119f0 10 115f0 10>;
+				reg = <0x119f0 0x10 0x115f0 0x10>;
 			};

 			serial@11a00 {
 				device_type = "serial";
 				compatible = "fsl,mpc8280-scc-uart",
 				             "fsl,cpm2-scc-uart";
-				reg = <11a00 20 8000 100>;
-				interrupts = <28 8>;
+				reg = <0x11a00 0x20 0x8000 0x100>;
+				interrupts = <40 8>;
 				interrupt-parent = <&PIC>;
 				fsl,cpm-brg = <1>;
-				fsl,cpm-command = <00800000>;
+				fsl,cpm-command = <0x800000>;
 			};

 			serial@11a20 {
 				device_type = "serial";
 				compatible = "fsl,mpc8280-scc-uart",
 				             "fsl,cpm2-scc-uart";
-				reg = <11a20 20 8100 100>;
-				interrupts = <29 8>;
+				reg = <0x11a20 0x20 0x8100 0x100>;
+				interrupts = <41 8>;
 				interrupt-parent = <&PIC>;
 				fsl,cpm-brg = <2>;
-				fsl,cpm-command = <04a00000>;
+				fsl,cpm-command = <0x4a00000>;
 			};

 			ethernet@11320 {
 				device_type = "network";
 				compatible = "fsl,mpc8280-fcc-enet",
 				             "fsl,cpm2-fcc-enet";
-				reg = <11320 20 8500 100 113b0 1>;
-				interrupts = <21 8>;
+				reg = <0x11320 0x20 0x8500 0x100 0x113b0 0x1>;
+				interrupts = <33 8>;
 				interrupt-parent = <&PIC>;
 				phy-handle = <&PHY0>;
 				linux,network-index = <0>;
-				fsl,cpm-command = <16200300>;
+				fsl,cpm-command = <0x16200300>;
 			};

 			ethernet@11340 {
 				device_type = "network";
 				compatible = "fsl,mpc8280-fcc-enet",
 				             "fsl,cpm2-fcc-enet";
-				reg = <11340 20 8600 100 113d0 1>;
-				interrupts = <22 8>;
+				reg = <0x11340 0x20 0x8600 0x100 0x113d0 0x1>;
+				interrupts = <34 8>;
 				interrupt-parent = <&PIC>;
 				phy-handle = <&PHY1>;
 				linux,network-index = <1>;
-				fsl,cpm-command = <1a400300>;
+				fsl,cpm-command = <0x1a400300>;
 				local-mac-address = [00 e0 0c 00 79 01];
 			};

@@ -194,21 +196,21 @@
 				             "fsl,cpm2-mdio-bitbang";
 				#address-cells = <1>;
 				#size-cells = <0>;
-				reg = <10d40 14>;
+				reg = <0x10d40 0x14>;
 				fsl,mdio-pin = <9>;
-				fsl,mdc-pin = <a>;
+				fsl,mdc-pin = <10>;

 				PHY0: ethernet-phy@0 {
 					interrupt-parent = <&PIC>;
-					interrupts = <19 2>;
-					reg = <0>;
+					interrupts = <25 2>;
+					reg = <0x0>;
 					device_type = "ethernet-phy";
 				};

 				PHY1: ethernet-phy@1 {
 					interrupt-parent = <&PIC>;
-					interrupts = <19 2>;
-					reg = <3>;
+					interrupts = <25 2>;
+					reg = <0x3>;
 					device_type = "ethernet-phy";
 				};
 			};
@@ -218,17 +220,17 @@
 				#size-cells = <0>;
 				compatible = "fsl,mpc8280-usb",
 				             "fsl,cpm2-usb";
-				reg = <11b60 18 8b00 100>;
+				reg = <0x11b60 0x18 0x8b00 0x100>;
 				interrupt-parent = <&PIC>;
-				interrupts = <b 8>;
-				fsl,cpm-command = <2e600000>;
+				interrupts = <11 8>;
+				fsl,cpm-command = <0x2e600000>;
 			};
 		};

 		PIC: interrupt-controller@10c00 {
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			reg = <10c00 80>;
+			reg = <0x10c00 0x80>;
 			compatible = "fsl,mpc8280-pic", "fsl,cpm2-pic";
 		};

-- 
1.5.4.1

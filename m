Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E31AB723B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 16:09:38 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p4K69YHM001067
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 01:09:35 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/14] powerpc/85xx: Updates to P4080DS device tree
Date: Fri, 20 May 2011 01:09:22 -0500
Message-Id: <1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1305871771-16334-4-git-send-email-galak@kernel.crashing.org>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-3-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-4-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Added BSD dual-license
* Moved mpic-parent to root so we dont need to duplicate everywhere
* Added next level cache from L2 to CPC
* Moved to 4-cell MPIC interrupt properties
* Added 3 MSI banks
* Added numerous missing nodes: soc-sram-error, guts, pins, clockgen,
  rcpm, sfp, serdes, etc.
* Reworked PCIe interrupts to be at virtual bridge level

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p4080ds.dts |  319 +++++++++++++++++++++++++------------
 1 files changed, 217 insertions(+), 102 deletions(-)

diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 5b7fc29..6f60a0d 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -1,12 +1,35 @@
 /*
  * P4080DS Device Tree Source
  *
- * Copyright 2009 Freescale Semiconductor Inc.
+ * Copyright 2009-2011 Freescale Semiconductor Inc.
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 /dts-v1/;
@@ -16,6 +39,7 @@
 	compatible = "fsl,P4080DS";
 	#address-cells = <2>;
 	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
 
 	aliases {
 		ccsr = &soc;
@@ -32,6 +56,9 @@
 		dma0 = &dma0;
 		dma1 = &dma1;
 		sdhc = &sdhc;
+		msi0 = &msi0;
+		msi1 = &msi1;
+		msi2 = &msi2;
 
 		rio0 = &rapidio0;
 	};
@@ -45,6 +72,7 @@
 			reg = <0>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
+				next-level-cache = <&cpc>;
 			};
 		};
 		cpu1: PowerPC,4080@1 {
@@ -52,6 +80,7 @@
 			reg = <1>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
+				next-level-cache = <&cpc>;
 			};
 		};
 		cpu2: PowerPC,4080@2 {
@@ -59,6 +88,7 @@
 			reg = <2>;
 			next-level-cache = <&L2_2>;
 			L2_2: l2-cache {
+				next-level-cache = <&cpc>;
 			};
 		};
 		cpu3: PowerPC,4080@3 {
@@ -66,6 +96,7 @@
 			reg = <3>;
 			next-level-cache = <&L2_3>;
 			L2_3: l2-cache {
+				next-level-cache = <&cpc>;
 			};
 		};
 		cpu4: PowerPC,4080@4 {
@@ -73,6 +104,7 @@
 			reg = <4>;
 			next-level-cache = <&L2_4>;
 			L2_4: l2-cache {
+				next-level-cache = <&cpc>;
 			};
 		};
 		cpu5: PowerPC,4080@5 {
@@ -80,6 +112,7 @@
 			reg = <5>;
 			next-level-cache = <&L2_5>;
 			L2_5: l2-cache {
+				next-level-cache = <&cpc>;
 			};
 		};
 		cpu6: PowerPC,4080@6 {
@@ -87,6 +120,7 @@
 			reg = <6>;
 			next-level-cache = <&L2_6>;
 			L2_6: l2-cache {
+				next-level-cache = <&cpc>;
 			};
 		};
 		cpu7: PowerPC,4080@7 {
@@ -94,6 +128,7 @@
 			reg = <7>;
 			next-level-cache = <&L2_7>;
 			L2_7: l2-cache {
+				next-level-cache = <&cpc>;
 			};
 		};
 	};
@@ -110,6 +145,11 @@
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
 
+		soc-sram-error {
+			compatible = "fsl,soc-sram-error";
+			interrupts = <16 2 1 29>;
+		};
+
 		corenet-law@0 {
 			compatible = "fsl,corenet-law";
 			reg = <0x0 0x1000>;
@@ -117,42 +157,132 @@
 		};
 
 		memory-controller@8000 {
-			compatible = "fsl,p4080-memory-controller";
+			compatible = "fsl,qoriq-memory-controller-v4.4", "fsl,qoriq-memory-controller";
 			reg = <0x8000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <0x12 2>;
+			interrupts = <16 2 1 23>;
 		};
 
 		memory-controller@9000 {
-			compatible = "fsl,p4080-memory-controller";
+			compatible = "fsl,qoriq-memory-controller-v4.4","fsl,qoriq-memory-controller";
 			reg = <0x9000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <0x12 2>;
+			interrupts = <16 2 1 22>;
+		};
+
+		cpc: l3-cache-controller@10000 {
+			compatible = "fsl,p4080-l3-cache-controller", "cache";
+			reg = <0x10000 0x1000
+			       0x11000 0x1000>;
+			interrupts = <16 2 1 27
+				      16 2 1 26>;
 		};
 
 		corenet-cf@18000 {
 			compatible = "fsl,corenet-cf";
 			reg = <0x18000 0x1000>;
+			interrupts = <16 2 1 31>;
 			fsl,ccf-num-csdids = <32>;
 			fsl,ccf-num-snoopids = <32>;
 		};
 
 		iommu@20000 {
-			compatible = "fsl,p4080-pamu";
-			reg = <0x20000 0x10000>;
-			interrupts = <24 2>;
-			interrupt-parent = <&mpic>;
+			compatible = "fsl,pamu-v1.0", "fsl,pamu";
+			reg = <0x20000 0x5000>;
+			interrupts = <
+				24 2 0 0
+				16 2 1 30>;
 		};
 
 		mpic: pic@40000 {
+			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <4>;
 			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
+			compatible = "fsl,mpic", "chrp,open-pic";
 			device_type = "open-pic";
 		};
 
+		msi0: msi@41600 {
+			compatible = "fsl,mpic-msi";
+			reg = <0x41600 0x200>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0 0 0
+				0xe1 0 0 0
+				0xe2 0 0 0
+				0xe3 0 0 0
+				0xe4 0 0 0
+				0xe5 0 0 0
+				0xe6 0 0 0
+				0xe7 0 0 0>;
+		};
+
+		msi1: msi@41800 {
+			compatible = "fsl,mpic-msi";
+			reg = <0x41800 0x200>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe8 0 0 0
+				0xe9 0 0 0
+				0xea 0 0 0
+				0xeb 0 0 0
+				0xec 0 0 0
+				0xed 0 0 0
+				0xee 0 0 0
+				0xef 0 0 0>;
+		};
+
+		msi2: msi@41a00 {
+			compatible = "fsl,mpic-msi";
+			reg = <0x41a00 0x200>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xf0 0 0 0
+				0xf1 0 0 0
+				0xf2 0 0 0
+				0xf3 0 0 0
+				0xf4 0 0 0
+				0xf5 0 0 0
+				0xf6 0 0 0
+				0xf7 0 0 0>;
+		};
+
+		guts: global-utilities@e0000 {
+			compatible = "fsl,qoriq-device-config-1.0";
+			reg = <0xe0000 0xe00>;
+			fsl,has-rstcr;
+			#sleep-cells = <1>;
+			fsl,liodn-bits = <12>;
+		};
+
+		pins: global-utilities@e0e00 {
+			compatible = "fsl,qoriq-pin-control-1.0";
+			reg = <0xe0e00 0x200>;
+			#sleep-cells = <2>;
+		};
+
+		clockgen: global-utilities@e1000 {
+			compatible = "fsl,p4080-clockgen", "fsl,qoriq-clockgen-1.0";
+			reg = <0xe1000 0x1000>;
+			clock-frequency = <0>;
+		};
+
+		rcpm: global-utilities@e2000 {
+			compatible = "fsl,qoriq-rcpm-1.0";
+			reg = <0xe2000 0x1000>;
+			#sleep-cells = <1>;
+		};
+
+		sfp: sfp@e8000 {
+			compatible = "fsl,p4080-sfp", "fsl,qoriq-sfp-1.0";
+			reg	   = <0xe8000 0x1000>;
+		};
+
+		serdes: serdes@ea000 {
+			compatible = "fsl,p4080-serdes";
+			reg	   = <0xea000 0x1000>;
+		};
+
 		dma0: dma@100300 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -165,32 +295,28 @@
 						"fsl,eloplus-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <28 2>;
+				interrupts = <28 2 0 0>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,p4080-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <29 2>;
+				interrupts = <29 2 0 0>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,p4080-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x100 0x80>;
 				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <30 2>;
+				interrupts = <30 2 0 0>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,p4080-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x180 0x80>;
 				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <31 2>;
+				interrupts = <31 2 0 0>;
 			};
 		};
 
@@ -206,32 +332,28 @@
 						"fsl,eloplus-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <32 2>;
+				interrupts = <32 2 0 0>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,p4080-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <33 2>;
+				interrupts = <33 2 0 0>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,p4080-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x100 0x80>;
 				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <34 2>;
+				interrupts = <34 2 0 0>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,p4080-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x180 0x80>;
 				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <35 2>;
+				interrupts = <35 2 0 0>;
 			};
 		};
 
@@ -240,8 +362,7 @@
 			#size-cells = <0>;
 			compatible = "fsl,p4080-espi", "fsl,mpc8536-espi";
 			reg = <0x110000 0x1000>;
-			interrupts = <53 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <53 0x2 0 0>;
 			fsl,espi-num-chipselects = <4>;
 
 			flash@0 {
@@ -275,10 +396,10 @@
 		sdhc: sdhc@114000 {
 			compatible = "fsl,p4080-esdhc", "fsl,esdhc";
 			reg = <0x114000 0x1000>;
-			interrupts = <48 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <48 2 0 0>;
 			voltage-ranges = <3300 3300>;
 			sdhci,auto-cmd12;
+			clock-frequency = <0>;
 		};
 
 		i2c@118000 {
@@ -287,8 +408,7 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x118000 0x100>;
-			interrupts = <38 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <38 2 0 0>;
 			dfsrr;
 		};
 
@@ -298,8 +418,7 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x118100 0x100>;
-			interrupts = <38 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <38 2 0 0>;
 			dfsrr;
 			eeprom@51 {
 				compatible = "at24,24c256";
@@ -312,8 +431,7 @@
 			rtc@68 {
 				compatible = "dallas,ds3232";
 				reg = <0x68>;
-				interrupts = <0 0x1>;
-				interrupt-parent = <&mpic>;
+				interrupts = <0x1 0x1 0 0>;
 			};
 		};
 
@@ -323,8 +441,7 @@
 			cell-index = <2>;
 			compatible = "fsl-i2c";
 			reg = <0x119000 0x100>;
-			interrupts = <39 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <39 2 0 0>;
 			dfsrr;
 		};
 
@@ -334,8 +451,7 @@
 			cell-index = <3>;
 			compatible = "fsl-i2c";
 			reg = <0x119100 0x100>;
-			interrupts = <39 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <39 2 0 0>;
 			dfsrr;
 		};
 
@@ -345,8 +461,7 @@
 			compatible = "ns16550";
 			reg = <0x11c500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <36 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <36 2 0 0>;
 		};
 
 		serial1: serial@11c600 {
@@ -355,8 +470,7 @@
 			compatible = "ns16550";
 			reg = <0x11c600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <36 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <36 2 0 0>;
 		};
 
 		serial2: serial@11d500 {
@@ -365,8 +479,7 @@
 			compatible = "ns16550";
 			reg = <0x11d500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <37 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <37 2 0 0>;
 		};
 
 		serial3: serial@11d600 {
@@ -375,15 +488,13 @@
 			compatible = "ns16550";
 			reg = <0x11d600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <37 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <37 2 0 0>;
 		};
 
 		gpio0: gpio@130000 {
-			compatible = "fsl,p4080-gpio";
+			compatible = "fsl,p4080-gpio", "fsl,qoriq-gpio";
 			reg = <0x130000 0x1000>;
-			interrupts = <55 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <55 2 0 0>;
 			#gpio-cells = <2>;
 			gpio-controller;
 		};
@@ -394,8 +505,7 @@
 			reg = <0x210000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = <&mpic>;
-			interrupts = <44 0x2>;
+			interrupts = <44 0x2 0 0>;
 			phy_type = "ulpi";
 		};
 
@@ -405,8 +515,7 @@
 			reg = <0x211000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = <&mpic>;
-			interrupts = <45 0x2>;
+			interrupts = <45 0x2 0 0>;
 			dr_mode = "host";
 			phy_type = "ulpi";
 		};
@@ -417,17 +526,21 @@
 		#size-cells = <2>;
 		compatible = "fsl,rapidio-delta";
 		reg = <0xf 0xfe0c0000 0 0x20000>;
-		ranges = <0 0 0xf 0xf5000000 0 0x01000000>;
-		interrupt-parent = <&mpic>;
-		/* err_irq bell_outb_irq bell_inb_irq
-			msg1_tx_irq msg1_rx_irq	msg2_tx_irq msg2_rx_irq */
-		interrupts = <16 2 56 2 57 2 60 2 61 2 62 2 63 2>;
+		ranges = <0 0 0xc 0x20000000 0 0x01000000>;
+		interrupts = <
+			16 2 1 11 /* err_irq */
+			56 2 0 0  /* bell_outb_irq */
+			57 2 0 0  /* bell_inb_irq */
+			60 2 0 0  /* msg1_tx_irq */
+			61 2 0 0  /* msg1_rx_irq */
+			62 2 0 0  /* msg2_tx_irq */
+			63 2 0 0>; /* msg2_rx_irq */
 	};
 
 	localbus@ffe124000 {
 		compatible = "fsl,p4080-elbc", "fsl,elbc", "simple-bus";
 		reg = <0xf 0xfe124000 0 0x1000>;
-		interrupts = <25 2>;
+		interrupts = <25 2 0 0>;
 		#address-cells = <2>;
 		#size-cells = <1>;
 
@@ -444,7 +557,6 @@
 	pci0: pcie@ffe200000 {
 		compatible = "fsl,p4080-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xf 0xfe200000 0 0x1000>;
@@ -452,22 +564,23 @@
 		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
 		clock-frequency = <0x1fca055>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
-
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 40 1
-			0000 0 0 2 &mpic 1 1
-			0000 0 0 3 &mpic 2 1
-			0000 0 0 4 &mpic 3 1
-			>;
+		fsl,msi = <&msi0>;
+		interrupts = <16 2 1 15>;
 		pcie@0 {
 			reg = <0 0 0 0 0>;
+			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
+			interrupts = <16 2 1 15>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 40 1 0 0
+				0000 0 0 2 &mpic 1 1 0 0
+				0000 0 0 3 &mpic 2 1 0 0
+				0000 0 0 4 &mpic 3 1 0 0
+				>;
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
 				  0 0x20000000
@@ -481,7 +594,6 @@
 	pci1: pcie@ffe201000 {
 		compatible = "fsl,p4080-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xf 0xfe201000 0 0x1000>;
@@ -489,21 +601,23 @@
 		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
 		clock-frequency = <0x1fca055>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 41 1
-			0000 0 0 2 &mpic 5 1
-			0000 0 0 3 &mpic 6 1
-			0000 0 0 4 &mpic 7 1
-			>;
+		fsl,msi = <&msi1>;
+		interrupts = <16 2 1 14>;
 		pcie@0 {
 			reg = <0 0 0 0 0>;
+			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
+			interrupts = <16 2 1 14>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 41 1 0 0
+				0000 0 0 2 &mpic 5 1 0 0
+				0000 0 0 3 &mpic 6 1 0 0
+				0000 0 0 4 &mpic 7 1 0 0
+				>;
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
 				  0 0x20000000
@@ -517,7 +631,6 @@
 	pci2: pcie@ffe202000 {
 		compatible = "fsl,p4080-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xf 0xfe202000 0 0x1000>;
@@ -525,21 +638,23 @@
 		ranges = <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
 		clock-frequency = <0x1fca055>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 42 1
-			0000 0 0 2 &mpic 9 1
-			0000 0 0 3 &mpic 10 1
-			0000 0 0 4 &mpic 11 1
-			>;
+		fsl,msi = <&msi2>;
+		interrupts = <16 2 1 13>;
 		pcie@0 {
 			reg = <0 0 0 0 0>;
+			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
+			interrupts = <16 2 1 13>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 42 1 0 0
+				0000 0 0 2 &mpic 9 1 0 0
+				0000 0 0 3 &mpic 10 1 0 0
+				0000 0 0 4 &mpic 11 1 0 0
+				>;
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
 				  0 0x20000000
-- 
1.7.3.4

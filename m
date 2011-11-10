Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F3557B743F
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:14:38 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAGEX3u031682
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:14:33 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 15/30] powerpc/85xx: Rework P1022DS device tree
Date: Thu, 10 Nov 2011 10:13:58 -0600
Message-Id: <1320941653-29797-16-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941653-29797-15-git-send-email-galak@kernel.crashing.org>
References: <1320941653-29797-1-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-2-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-3-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-4-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-5-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-6-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-7-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-8-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-9-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-10-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-11-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-12-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-13-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-14-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-15-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi |  235 +++++++++++++++
 arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi  |   68 +++++
 arch/powerpc/boot/dts/p1022ds.dts           |  431 +--------------------------
 3 files changed, 318 insertions(+), 416 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
new file mode 100644
index 0000000..16239b1
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -0,0 +1,235 @@
+/*
+ * P1022/P1013 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
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
+ */
+
+&lbc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	compatible = "fsl,p1022-elbc", "fsl,elbc", "simple-bus";
+	interrupts = <19 2 0 0>;
+};
+
+/* controller at 0x9000 */
+&pci0 {
+	compatible = "fsl,p1022-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 255>;
+	clock-frequency = <33333333>;
+	interrupts = <16 2 0 0>;
+
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <16 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x4 0x1 0x0 0x0
+			0000 0x0 0x0 0x2 &mpic 0x5 0x1 0x0 0x0
+			0000 0x0 0x0 0x3 &mpic 0x6 0x1 0x0 0x0
+			0000 0x0 0x0 0x4 &mpic 0x7 0x1 0x0 0x0
+			>;
+	};
+};
+
+/* controller at 0xa000 */
+&pci1 {
+	compatible = "fsl,p1022-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 255>;
+	clock-frequency = <33333333>;
+	interrupts = <16 2 0 0>;
+
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <16 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x0 0x1 0x0 0x0
+			0000 0x0 0x0 0x2 &mpic 0x1 0x1 0x0 0x0
+			0000 0x0 0x0 0x3 &mpic 0x2 0x1 0x0 0x0
+			0000 0x0 0x0 0x4 &mpic 0x3 0x1 0x0 0x0
+			>;
+	};
+};
+
+/* controller at 0xb000 */
+&pci2 {
+	compatible = "fsl,p1022-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 255>;
+	clock-frequency = <33333333>;
+	interrupts = <16 2 0 0>;
+
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <16 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x8 0x1 0x0 0x0
+			0000 0x0 0x0 0x2 &mpic 0x9 0x1 0x0 0x0
+			0000 0x0 0x0 0x3 &mpic 0xa 0x1 0x0 0x0
+			0000 0x0 0x0 0x4 &mpic 0xb 0x1 0x0 0x0
+			>;
+	};
+};
+
+&soc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "soc";
+	compatible = "fsl,p1022-immr", "simple-bus";
+	bus-frequency = <0>;		// Filled out by uboot.
+
+	ecm-law@0 {
+		compatible = "fsl,ecm-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <12>;
+	};
+
+	ecm@1000 {
+		compatible = "fsl,p1022-ecm", "fsl,ecm";
+		reg = <0x1000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
+	memory-controller@2000 {
+		compatible = "fsl,p1022-memory-controller";
+		reg = <0x2000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-i2c-0.dtsi"
+/include/ "pq3-i2c-1.dtsi"
+/include/ "pq3-duart-0.dtsi"
+/include/ "pq3-espi-0.dtsi"
+	spi@7000 {
+		fsl,espi-num-chipselects = <4>;
+	};
+
+/include/ "pq3-dma-1.dtsi"
+	dma@c300 {
+		dma00: dma-channel@0 {
+			compatible = "fsl,ssi-dma-channel";
+		};
+		dma01: dma-channel@80 {
+			compatible = "fsl,ssi-dma-channel";
+		};
+	};
+
+/include/ "pq3-gpio-0.dtsi"
+
+	display@10000 {
+		compatible = "fsl,diu", "fsl,p1022-diu";
+		reg = <0x10000 1000>;
+		interrupts = <64 2 0 0>;
+	};
+
+	ssi@15000 {
+		compatible = "fsl,mpc8610-ssi";
+		cell-index = <0>;
+		reg = <0x15000 0x100>;
+		interrupts = <75 2 0 0>;
+		fsl,playback-dma = <&dma00>;
+		fsl,capture-dma = <&dma01>;
+		fsl,fifo-depth = <15>;
+	};
+
+/include/ "pq3-sata2-0.dtsi"
+/include/ "pq3-sata2-1.dtsi"
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,p1022-l2-cache-controller";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>;	// 32 bytes
+		cache-size = <0x40000>; // L2,256K
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-dma-0.dtsi"
+/include/ "pq3-usb2-dr-0.dtsi"
+/include/ "pq3-usb2-dr-1.dtsi"
+
+/include/ "pq3-esdhc-0.dtsi"
+	sdhc@2e000 {
+		fsl,sdhci-auto-cmd12;
+	};
+
+/include/ "pq3-sec3.3-0.dtsi"
+/include/ "pq3-mpic.dtsi"
+/include/ "pq3-mpic-timer-B.dtsi"
+
+/include/ "pq3-etsec2-0.dtsi"
+	enet0: enet0_grp2: ethernet@b0000 {
+	};
+
+/include/ "pq3-etsec2-1.dtsi"
+	enet1: enet1_grp2: ethernet@b1000 {
+	};
+
+	global-utilities@e0000 {
+		compatible = "fsl,p1022-guts";
+		reg = <0xe0000 0x1000>;
+		fsl,has-rstcr;
+	};
+
+	power@e0070{
+		compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc";
+		reg = <0xe0070 0x20>;
+	};
+
+};
+
+/include/ "pq3-etsec2-grp2-0.dtsi"
+/include/ "pq3-etsec2-grp2-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
new file mode 100644
index 0000000..e930f4f
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
@@ -0,0 +1,68 @@
+/*
+ * P1022/P1013 Silicon/SoC Device Tree Source (pre include)
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
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
+ */
+
+/dts-v1/;
+/ {
+	compatible = "fsl,P1022";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,P1022@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,P1022@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index b9b8719..d6dd788 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -8,52 +8,17 @@
  * kind, whether express or implied.
  */
 
-/dts-v1/;
+/include/ "fsl/p1022si-pre.dtsi"
 / {
-	model = "fsl,P1022";
+	model = "fsl,P1022DS";
 	compatible = "fsl,P1022DS";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-		pci1 = &pci1;
-		pci2 = &pci2;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,P1022@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			next-level-cache = <&L2>;
-		};
-
-		PowerPC,P1022@1 {
-			device_type = "cpu";
-			reg = <0x1>;
-			next-level-cache = <&L2>;
-		};
-	};
 
 	memory {
 		device_type = "memory";
 	};
 
-	localbus@fffe05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,p1022-elbc", "fsl,elbc", "simple-bus";
+	lbc: localbus@fffe05000 {
 		reg = <0 0xffe05000 0 0x1000>;
-		interrupts = <19 2 0 0>;
-
 		ranges = <0x0 0x0 0xf 0xe8000000 0x08000000
 			  0x1 0x0 0xf 0xe0000000 0x08000000
 			  0x2 0x0 0x0 0xffa00000 0x00040000
@@ -161,51 +126,10 @@
 		};
 	};
 
-	soc@fffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "fsl,p1022-immr", "simple-bus";
+	soc: soc@fffe00000 {
 		ranges = <0x0 0xf 0xffe00000 0x100000>;
-		bus-frequency = <0>;		// Filled out by uboot.
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <12>;
-		};
-
-		ecm@1000 {
-			compatible = "fsl,p1022-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <16 2 0 0>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,p1022-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupts = <16 2 0 0>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2 0 0>;
-			dfsrr;
-		};
 
 		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2 0 0>;
-			dfsrr;
-
 			wm8776:codec@1a {
 				compatible = "wlf,wm8776";
 				reg = <0x1a>;
@@ -216,41 +140,14 @@
 			};
 		};
 
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2 0 0>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2 0 0>;
-		};
-
 		spi@7000 {
-			cell-index = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,espi";
-			reg = <0x7000 0x1000>;
-			interrupts = <59 0x2 0 0>;
-			espi,num-ss-bits = <4>;
-			mode = "cpu";
-
-			fsl_m25p80@0 {
+			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "fsl,espi-flash";
+				compatible = "spansion,s25sl12801";
 				reg = <0>;
-				linux,modalias = "fsl_m25p80";
 				spi-max-frequency = <40000000>; /* input clock */
+
 				partition@0 {
 					label = "u-boot-spi";
 					reg = <0x00000000 0x00100000>;
@@ -274,115 +171,20 @@
 		};
 
 		ssi@15000 {
-			compatible = "fsl,mpc8610-ssi";
-			cell-index = <0>;
-			reg = <0x15000 0x100>;
-			interrupts = <75 2 0 0>;
 			fsl,mode = "i2s-slave";
 			codec-handle = <&wm8776>;
-			fsl,playback-dma = <&dma00>;
-			fsl,capture-dma = <&dma01>;
-			fsl,fifo-depth = <15>;
 			fsl,ssi-asynchronous;
 		};
 
-		dma@c300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,eloplus-dma";
-			reg = <0xc300 0x4>;
-			ranges = <0x0 0xc100 0x200>;
-			cell-index = <1>;
-			dma00: dma-channel@0 {
-				compatible = "fsl,ssi-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupts = <76 2 0 0>;
-			};
-			dma01: dma-channel@80 {
-				compatible = "fsl,ssi-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupts = <77 2 0 0>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupts = <78 2 0 0>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupts = <79 2 0 0>;
-			};
-		};
-
-		gpio: gpio-controller@f000 {
-			#gpio-cells = <2>;
-			compatible = "fsl,mpc8572-gpio";
-			reg = <0xf000 0x100>;
-			interrupts = <47 0x2 0 0>;
-			gpio-controller;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,p1022-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>;	// 32 bytes
-			cache-size = <0x40000>; // L2, 256K
-			interrupts = <16 2 0 0>;
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupts = <20 2 0 0>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupts = <21 2 0 0>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupts = <22 2 0 0>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupts = <23 2 0 0>;
-			};
-		};
-
 		usb@22000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-usb2-dr";
-			reg = <0x22000 0x1000>;
-			interrupts = <28 0x2 0 0>;
 			phy_type = "ulpi";
 		};
 
-		mdio@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,etsec2-mdio";
-			reg = <0x24000 0x1000 0xb0030 0x4>;
+		usb@23000 {
+			status = "disabled";
+		};
 
+		mdio@24000 {
 			phy0: ethernet-phy@0 {
 				interrupts = <3 1 0 0>;
 				reg = <0x1>;
@@ -393,187 +195,22 @@
 			};
 		};
 
-		mdio@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,etsec2-mdio";
-			reg = <0x25000 0x1000 0xb1030 0x4>;
-		};
-
-		enet0: ethernet@B0000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "fsl,etsec2";
-			fsl,num_rx_queues = <0x8>;
-			fsl,num_tx_queues = <0x8>;
-			fsl,magic-packet;
-			fsl,wake-on-filer;
-			local-mac-address = [ 00 00 00 00 00 00 ];
+		ethernet@b0000 {
 			phy-handle = <&phy0>;
 			phy-connection-type = "rgmii-id";
-			queue-group@0{
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xB0000 0x1000>;
-				interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
-			};
-			queue-group@1{
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xB4000 0x1000>;
-				interrupts = <17 2 0 0 18 2 0 0 24 2 0 0>;
-			};
 		};
 
-		enet1: ethernet@B1000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "fsl,etsec2";
-			fsl,num_rx_queues = <0x8>;
-			fsl,num_tx_queues = <0x8>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
+		ethernet@b1000 {
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
-			queue-group@0{
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xB1000 0x1000>;
-				interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
-			};
-			queue-group@1{
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xB5000 0x1000>;
-				interrupts = <51 2 0 0 52 2 0 0 67 2 0 0>;
-			};
-		};
-
-		sdhci@2e000 {
-			compatible = "fsl,p1022-esdhc", "fsl,esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <72 0x2 0 0>;
-			fsl,sdhci-auto-cmd12;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
-		};
-
-		crypto@30000 {
-			compatible = "fsl,sec3.3", "fsl,sec3.1", "fsl,sec3.0",
-				     "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
-				     "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <45 2 0 0 58 2 0 0>;
-			fsl,num-channels = <4>;
-			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0x97c>;
-			fsl,descriptor-types-mask = <0x3a30abf>;
-		};
-
-		sata@18000 {
-			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
-			reg = <0x18000 0x1000>;
-			cell-index = <1>;
-			interrupts = <74 0x2 0 0>;
-		};
-
-		sata@19000 {
-			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
-			reg = <0x19000 0x1000>;
-			cell-index = <2>;
-			interrupts = <41 0x2 0 0>;
-		};
-
-		power@e0070{
-			compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc";
-			reg = <0xe0070 0x20>;
-		};
-
-		display@10000 {
-			compatible = "fsl,diu", "fsl,p1022-diu";
-			reg = <0x10000 1000>;
-			interrupts = <64 2 0 0>;
-		};
-
-		timer@41100 {
-			compatible = "fsl,mpic-global-timer";
-			reg = <0x41100 0x100 0x41300 4>;
-			interrupts = <0 0 3 0
-			              1 0 3 0
-			              2 0 3 0
-			              3 0 3 0>;
-		};
-
-		timer@42100 {
-			compatible = "fsl,mpic-global-timer";
-			reg = <0x42100 0x100 0x42300 4>;
-			interrupts = <4 0 3 0
-			              5 0 3 0
-			              6 0 3 0
-			              7 0 3 0>;
-		};
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <4>;
-			reg = <0x40000 0x40000>;
-			compatible = "fsl,mpic";
-			device_type = "open-pic";
-		};
-
-		msi@41600 {
-			compatible = "fsl,p1022-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0 0 0
-				0xe1 0 0 0
-				0xe2 0 0 0
-				0xe3 0 0 0
-				0xe4 0 0 0
-				0xe5 0 0 0
-				0xe6 0 0 0
-				0xe7 0 0 0>;
-		};
-
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,p1022-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
 		};
 	};
 
 	pci0: pcie@fffe09000 {
-		compatible = "fsl,p1022-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xf 0xffe09000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xa0000000 0xc 0x20000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupts = <16 2 0 0>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 4 1
-			0000 0 0 2 &mpic 5 1
-			0000 0 0 3 &mpic 6 1
-			0000 0 0 4 &mpic 7 1
-			>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xe0000000
 				  0x2000000 0x0 0xe0000000
 				  0x0 0x20000000
@@ -585,30 +222,11 @@
 	};
 
 	pci1: pcie@fffe0a000 {
-		compatible = "fsl,p1022-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xf 0xffe0a000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xc0000000 0xc 0x40000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc20000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupts = <16 2 0 0>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 0 1
-			0000 0 0 2 &mpic 1 1
-			0000 0 0 3 &mpic 2 1
-			0000 0 0 4 &mpic 3 1
-			>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xe0000000
 				  0x2000000 0x0 0xe0000000
 				  0x0 0x20000000
@@ -619,32 +237,11 @@
 		};
 	};
 
-
 	pci2: pcie@fffe0b000 {
-		compatible = "fsl,p1022-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xf 0xffe0b000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupts = <16 2 0 0>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 8 1
-			0000 0 0 2 &mpic 9 1
-			0000 0 0 3 &mpic 10 1
-			0000 0 0 4 &mpic 11 1
-			>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xe0000000
 				  0x2000000 0x0 0xe0000000
 				  0x0 0x20000000
@@ -655,3 +252,5 @@
 		};
 	};
 };
+
+/include/ "fsl/p1022si-post.dtsi"
-- 
1.7.3.4

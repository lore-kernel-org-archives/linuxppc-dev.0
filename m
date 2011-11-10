Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3D148100D29
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:14:49 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAGEfP8031781
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:14:42 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 18/30] powerpc/85xx: Rework P1021MDS device tree
Date: Thu, 10 Nov 2011 10:14:01 -0600
Message-Id: <1320941653-29797-19-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941653-29797-18-git-send-email-galak@kernel.crashing.org>
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
 <1320941653-29797-16-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-17-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-18-git-send-email-galak@kernel.crashing.org>
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
 arch/powerpc/boot/dts/fsl/p1021si-post.dtsi |  225 ++++++++++++++
 arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi  |   68 +++++
 arch/powerpc/boot/dts/p1021mds.dts          |  421 ++-------------------------
 3 files changed, 314 insertions(+), 400 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
new file mode 100644
index 0000000..38ba54d
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
@@ -0,0 +1,225 @@
+/*
+ * P1021/P1012 Silicon/SoC Device Tree Source (post include)
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
+	compatible = "fsl,p1021-elbc", "fsl,elbc", "simple-bus";
+	interrupts = <19 2 0 0>;
+};
+
+/* controller at 0x9000 */
+&pci0 {
+	compatible = "fsl,mpc8548-pcie";
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
+	compatible = "fsl,mpc8548-pcie";
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
+&soc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "soc";
+	compatible = "fsl,p1021-immr", "simple-bus";
+	bus-frequency = <0>;		// Filled out by uboot.
+
+	ecm-law@0 {
+		compatible = "fsl,ecm-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <12>;
+	};
+
+	ecm@1000 {
+		compatible = "fsl,p1021-ecm", "fsl,ecm";
+		reg = <0x1000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
+	memory-controller@2000 {
+		compatible = "fsl,p1021-memory-controller";
+		reg = <0x2000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-i2c-0.dtsi"
+/include/ "pq3-i2c-1.dtsi"
+/include/ "pq3-duart-0.dtsi"
+
+/include/ "pq3-espi-0.dtsi"
+	spi@7000 {
+		fsl,espi-num-chipselects = <4>;
+	};
+
+/include/ "pq3-gpio-0.dtsi"
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,p1021-l2-cache-controller";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>;	// 32 bytes
+		cache-size = <0x40000>; // L2,256K
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-dma-0.dtsi"
+/include/ "pq3-usb2-dr-0.dtsi"
+
+/include/ "pq3-esdhc-0.dtsi"
+/include/ "pq3-sec3.3-0.dtsi"
+
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
+/include/ "pq3-etsec2-2.dtsi"
+	enet2: enet2_grp2: ethernet@b2000 {
+	};
+
+	global-utilities@e0000 {
+		compatible = "fsl,p1021-guts";
+		reg = <0xe0000 0x1000>;
+		fsl,has-rstcr;
+	};
+};
+
+&qe {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "qe";
+	compatible = "fsl,qe";
+	fsl,qe-num-riscs = <1>;
+	fsl,qe-num-snums = <28>;
+
+	qeic: interrupt-controller@80 {
+		interrupt-controller;
+		compatible = "fsl,qe-ic";
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		reg = <0x80 0x80>;
+		interrupts = <63 2 0 0 60 2 0 0>; //high:47 low:44
+	};
+
+	ucc@2000 {
+		cell-index = <1>;
+		reg = <0x2000 0x200>;
+		interrupts = <32>;
+		interrupt-parent = <&qeic>;
+	};
+
+	mdio@2120 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x2120 0x18>;
+		compatible = "fsl,ucc-mdio";
+	};
+
+	ucc@2400 {
+		cell-index = <5>;
+		reg = <0x2400 0x200>;
+		interrupts = <40>;
+		interrupt-parent = <&qeic>;
+	};
+
+	muram@10000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,qe-muram", "fsl,cpm-muram";
+		ranges = <0x0 0x10000 0x6000>;
+
+		data-only@0 {
+			compatible = "fsl,qe-muram-data",
+			"fsl,cpm-muram-data";
+			reg = <0x0 0x6000>;
+		};
+	};
+};
+
+/include/ "pq3-etsec2-grp2-0.dtsi"
+/include/ "pq3-etsec2-grp2-1.dtsi"
+/include/ "pq3-etsec2-grp2-2.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi
new file mode 100644
index 0000000..4abd54b
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi
@@ -0,0 +1,68 @@
+/*
+ * P1021/P1012 Silicon/SoC Device Tree Source (pre include)
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
+	compatible = "fsl,P1021";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,P1021@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,P1021@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1021mds.dts b/arch/powerpc/boot/dts/p1021mds.dts
index ad5b852..b1bef1f 100644
--- a/arch/powerpc/boot/dts/p1021mds.dts
+++ b/arch/powerpc/boot/dts/p1021mds.dts
@@ -9,53 +9,22 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "fsl/p1021si-pre.dtsi"
 / {
 	model = "fsl,P1021";
 	compatible = "fsl,P1021MDS";
-	#address-cells = <2>;
-	#size-cells = <2>;
 
 	aliases {
-		serial0 = &serial0;
-		serial1 = &serial1;
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
 		ethernet3 = &enet3;
 		ethernet4 = &enet4;
-		pci0 = &pci0;
-		pci1 = &pci1;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,P1021@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			next-level-cache = <&L2>;
-		};
-
-		PowerPC,P1021@1 {
-			device_type = "cpu";
-			reg = <0x1>;
-			next-level-cache = <&L2>;
-		};
 	};
 
 	memory {
 		device_type = "memory";
 	};
 
-	localbus@ffe05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,p1021-elbc", "fsl,elbc", "simple-bus";
-		reg = <0 0xffe05000 0 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
+	lbc: localbus@ffe05000 {
+		reg = <0x0 0xffe05000 0x0 0x1000>;
 
 		/* NAND Flash, BCSR, PMC0/1*/
 		ranges = <0x0 0x0 0x0 0xfc000000 0x02000000
@@ -138,99 +107,26 @@
 		};
 	};
 
-	soc@ffe00000 {
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
+	soc: soc@ffe00000 {
 		compatible = "fsl,p1021-immr", "simple-bus";
-		ranges = <0x0  0x0 0xffe00000 0x100000>;
-		bus-frequency = <0>;		// Filled out by uboot.
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <12>;
-		};
-
-		ecm@1000 {
-			compatible = "fsl,p1021-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <16 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,p1021-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-		};
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
 
 		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
 			rtc@68 {
 				compatible = "dallas,ds1374";
 				reg = <0x68>;
 			};
 		};
 
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
-
 		spi@7000 {
-			cell-index = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,espi";
-			reg = <0x7000 0x1000>;
-			interrupts = <59 0x2>;
-			interrupt-parent = <&mpic>;
-			espi,num-ss-bits = <4>;
-			mode = "cpu";
-
-			fsl_m25p80@0 {
+
+			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "fsl,espi-flash";
+				compatible = "spansion,s25sl12801";
 				reg = <0>;
-				linux,modalias = "fsl_m25p80";
 				spi-max-frequency = <40000000>; /* input clock */
+
 				partition@u-boot {
 					label = "u-boot-spi";
 					reg = <0x00000000 0x00100000>;
@@ -253,237 +149,45 @@
 			};
 		};
 
-		gpio: gpio-controller@f000 {
-			#gpio-cells = <2>;
-			compatible = "fsl,mpc8572-gpio";
-			reg = <0xf000 0x100>;
-			interrupts = <47 0x2>;
-			interrupt-parent = <&mpic>;
-			gpio-controller;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,p1021-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>;	// 32 bytes
-			cache-size = <0x40000>; // L2,256K
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
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
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
 		usb@22000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-usb2-dr";
-			reg = <0x22000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <28 0x2>;
 			phy_type = "ulpi";
 		};
 
-		 mdio@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,etsec2-mdio";
-			reg = <0x24000 0x1000 0xb0030 0x4>;
-
+		mdio@24000 {
 			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <1 1>;
+				interrupts = <1 1 0 0>;
 				reg = <0x0>;
 			};
 			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <2 1>;
+				interrupts = <2 1 0 0>;
 				reg = <0x1>;
 			};
 			phy4: ethernet-phy@4 {
-				interrupt-parent = <&mpic>;
 				reg = <0x4>;
 			};
 		};
 
 		mdio@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,etsec2-tbi";
-			reg = <0x25000 0x1000 0xb1030 0x4>;
 			tbi0: tbi-phy@11 {
 				reg = <0x11>;
 				device_type = "tbi-phy";
 			};
 		};
 
-		enet0: ethernet@B0000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "fsl,etsec2";
-			fsl,num_rx_queues = <0x8>;
-			fsl,num_tx_queues = <0x8>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupt-parent = <&mpic>;
+		ethernet@b0000 {
 			phy-handle = <&phy0>;
 			phy-connection-type = "rgmii-id";
-			queue-group@0{
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xB0000 0x1000>;
-				interrupts = <29 2 30 2 34 2>;
-			};
-			queue-group@1{
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xB4000 0x1000>;
-				interrupts = <17 2 18 2 24 2>;
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
-			interrupt-parent = <&mpic>;
+		ethernet@b1000 {
 			phy-handle = <&phy4>;
 			tbi-handle = <&tbi0>;
 			phy-connection-type = "sgmii";
-			queue-group@0{
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xB1000 0x1000>;
-				interrupts = <35 2 36 2 40 2>;
-			};
-			queue-group@1{
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xB5000 0x1000>;
-				interrupts = <51 2 52 2 67 2>;
-			};
 		};
 
-		enet2: ethernet@B2000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "fsl,etsec2";
-			fsl,num_rx_queues = <0x8>;
-			fsl,num_tx_queues = <0x8>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupt-parent = <&mpic>;
+		ethernet@b2000 {
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
-			queue-group@0{
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xB2000 0x1000>;
-				interrupts = <31 2 32 2 33 2>;
-			};
-			queue-group@1{
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xB6000 0x1000>;
-				interrupts = <25 2 26 2 27 2>;
-			};
-		};
-
-		sdhci@2e000 {
-			compatible = "fsl,p1021-esdhc", "fsl,esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <72 0x2>;
-			interrupt-parent = <&mpic>;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
-		};
-
-		crypto@30000 {
-			compatible = "fsl,sec3.3", "fsl,sec3.1",
-				     "fsl,sec3.0", "fsl,sec2.4",
-				     "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <45 2 58 2>;
-			interrupt-parent = <&mpic>;
-			fsl,num-channels = <4>;
-			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0x97c>;
-			fsl,descriptor-types-mask = <0x3a30abf>;
-		};
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-		};
-
-		msi@41600 {
-			compatible = "fsl,p1021-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
-		};
-
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,p1021-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
 		};
 
 		par_io@e0100 {
@@ -499,8 +203,7 @@
 					0x1  0x13 0x1  0x0  0x1  0x0    /* QE_MUX_MDC */
 					0x1  0x14 0x3  0x0  0x1  0x0    /* QE_MUX_MDIO */
 					0x0  0x17 0x2  0x0  0x2  0x0    /* CLK12 */
-					0x0  0x18 0x2  0x0  0x1  0x0    /* CLK9
-*/
+					0x0  0x18 0x2  0x0  0x1  0x0    /* CLK9 */
 					0x0  0x7  0x1  0x0  0x2  0x0    /* ENET1_TXD0_SER1_TXD0 */
 					0x0  0x9  0x1  0x0  0x2  0x0    /* ENET1_TXD1_SER1_TXD1 */
 					0x0  0xb  0x1  0x0  0x2  0x0    /* ENET1_TXD2_SER1_TXD2 */
@@ -535,31 +238,10 @@
 	};
 
 	pci0: pcie@ffe09000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0 0xffe09000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
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
 			ranges = <0x2000000 0x0 0xa0000000
 				  0x2000000 0x0 0xa0000000
 				  0x0 0x20000000
@@ -571,31 +253,10 @@
 	};
 
 	pci1: pcie@ffe0a000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0 0xffe0a000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 0 1
-			0000 0 0 2 &mpic 1 1
-			0000 0 0 3 &mpic 2 1
-			0000 0 0 4 &mpic 3 1
-			>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xc0000000
 				  0x2000000 0x0 0xc0000000
 				  0x0 0x20000000
@@ -606,36 +267,16 @@
 		};
 	};
 
-	qe@ffe80000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "qe";
-		compatible = "fsl,qe";
+	qe: qe@ffe80000 {
 		ranges = <0x0 0x0 0xffe80000 0x40000>;
 		reg = <0 0xffe80000 0 0x480>;
 		brg-frequency = <0>;
 		bus-frequency = <0>;
-		fsl,qe-num-riscs = <1>;
-		fsl,qe-num-snums = <28>;
 		status = "disabled"; /* no firmware loaded */
 
-		qeic: interrupt-controller@80 {
-			interrupt-controller;
-			compatible = "fsl,qe-ic";
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-			reg = <0x80 0x80>;
-			interrupts = <63 2 60 2>; //high:47 low:44
-			interrupt-parent = <&mpic>;
-		};
-
 		enet3: ucc@2000 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			cell-index = <1>;
-			reg = <0x2000 0x200>;
-			interrupts = <32>;
-			interrupt-parent = <&qeic>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock-name = "clk12";
 			tx-clock-name = "clk9";
@@ -645,20 +286,15 @@
 		};
 
 		mdio@2120 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x2120 0x18>;
-			compatible = "fsl,ucc-mdio";
-
 			qe_phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
-				interrupts = <4 1>;
+				interrupts = <4 1 0 0>;
 				reg = <0x0>;
 				device_type = "ethernet-phy";
 			};
 			qe_phy1: ethernet-phy@03 {
 				interrupt-parent = <&mpic>;
-				interrupts = <5 1>;
+				interrupts = <5 1 0 0>;
 				reg = <0x3>;
 				device_type = "ethernet-phy";
 			};
@@ -671,10 +307,6 @@
 		enet4: ucc@2400 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			cell-index = <5>;
-			reg = <0x2400 0x200>;
-			interrupts = <40>;
-			interrupt-parent = <&qeic>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock-name = "none";
 			tx-clock-name = "clk13";
@@ -682,18 +314,7 @@
 			phy-handle = <&qe_phy1>;
 			phy-connection-type = "rmii";
 		};
-
-		muram@10000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,qe-muram", "fsl,cpm-muram";
-			ranges = <0x0 0x10000 0x6000>;
-
-			data-only@0 {
-				compatible = "fsl,qe-muram-data",
-				"fsl,cpm-muram-data";
-				reg = <0x0 0x6000>;
-			};
-		};
 	};
 };
+
+/include/ "fsl/p1021si-post.dtsi"
-- 
1.7.3.4

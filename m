Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E782CB7535
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 18:16:35 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAH7GVrU026584
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 01:16:31 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/29] powerpc/85xx: Rework MPC8568MDS device tree
Date: Thu, 17 Nov 2011 01:16:03 -0600
Message-Id: <1321514181-28897-11-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1321514181-28897-10-git-send-email-galak@kernel.crashing.org>
References: <1321514181-28897-1-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-2-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-3-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-4-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-5-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-6-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-7-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-8-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-9-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-10-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Utilize new split between board & SoC, and new SoC device trees split
into pre & post utilizing 'template' includes for SoC IP blocks.

Other changes include:
* Moved to a standard 2 #address-cells & #size-cells at top-level
* Moved to specifying interrupt-parent for mpic at root
* Moved to 4-cell mpic interrupt cells to support MPIC timers
* Removed CPU properties setup by u-boot to match other .dts
* Reworked PCIe nodes to allow supportin IRQs for controller (errors)
  and moved PCI device IRQs down to virtual bridge level
* Dropping "fsl,mpc8568-IP..." from compatibles for standard blocks

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi |  265 ++++++++++++++
 arch/powerpc/boot/dts/fsl/mpc8568si-pre.dtsi  |   65 ++++
 arch/powerpc/boot/dts/mpc8568mds.dts          |  480 ++++---------------------
 3 files changed, 393 insertions(+), 417 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8568si-pre.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi
new file mode 100644
index 0000000..6a9cca8
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi
@@ -0,0 +1,265 @@
+/*
+ * MPC8568 Silicon/SoC Device Tree Source (post include)
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
+	compatible = "fsl,mpc8568-localbus", "fsl,pq3-localbus", "simple-bus";
+	interrupts = <19 2 0 0>;
+	sleep = <&pmc 0x08000000>;
+};
+
+/* controller at 0x8000 */
+&pci0 {
+	compatible = "fsl,mpc8540-pci";
+	device_type = "pci";
+	interrupts = <24 0x2 0 0>;
+	bus-range = <0 0xff>;
+	#interrupt-cells = <1>;
+	#size-cells = <2>;
+	#address-cells = <3>;
+	sleep = <&pmc 0x80000000>;
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
+	interrupts = <26 2 0 0>;
+	sleep = <&pmc 0x20000000>;
+
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <26 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
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
+&rio {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	compatible = "fsl,mpc8568-rapidio", "fsl,rapidio-delta";
+	interrupts = <48 2 0 0 /* error     */
+		      49 2 0 0 /* bell_outb */
+		      50 2 0 0 /* bell_inb  */
+		      53 2 0 0 /* msg1_tx   */
+		      54 2 0 0 /* msg1_rx   */
+		      55 2 0 0 /* msg2_tx   */
+		      56 2 0 0 /* msg2_rx   */>;
+	sleep = <&pmc 0x00080000   /* controller */
+		 &pmc 0x00040000>; /* message unit */
+};
+
+&soc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "soc";
+	compatible = "fsl,mpc8568-immr", "simple-bus";
+	bus-frequency = <0>;		// Filled out by uboot.
+
+	ecm-law@0 {
+		compatible = "fsl,ecm-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <10>;
+	};
+
+	ecm@1000 {
+		compatible = "fsl,mpc8568-ecm", "fsl,ecm";
+		reg = <0x1000 0x1000>;
+		interrupts = <17 2 0 0>;
+	};
+
+	memory-controller@2000 {
+		compatible = "fsl,mpc8568-memory-controller";
+		reg = <0x2000 0x1000>;
+		interrupts = <18 2 0 0>;
+	};
+
+	i2c-sleep-nexus {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		sleep = <&pmc 0x00000004>;
+		ranges;
+
+/include/ "pq3-i2c-0.dtsi"
+/include/ "pq3-i2c-1.dtsi"
+
+	};
+
+	duart-sleep-nexus {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		sleep = <&pmc 0x00000002>;
+		ranges;
+
+/include/ "pq3-duart-0.dtsi"
+
+	};
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,mpc8568-l2-cache-controller";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>;	// 32 bytes
+		cache-size = <0x80000>; // L2, 512K
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-dma-0.dtsi"
+	dma@21300 {
+		sleep = <&pmc 0x00000400>;
+	};
+
+/include/ "pq3-etsec1-0.dtsi"
+	ethernet@24000 {
+		sleep = <&pmc 0x00000080>;
+	};
+
+/include/ "pq3-etsec1-1.dtsi"
+	ethernet@25000 {
+		sleep = <&pmc 0x00000040>;
+	};
+
+	par_io@e0100 {
+		reg = <0xe0100 0x100>;
+		device_type = "par_io";
+	};
+
+/include/ "pq3-sec2.1-0.dtsi"
+	crypto@30000 {
+		sleep = <&pmc 0x01000000>;
+	};
+
+/include/ "pq3-mpic.dtsi"
+
+	global-utilities@e0000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8568-guts", "fsl,mpc8548-guts";
+		reg = <0xe0000 0x1000>;
+		ranges = <0 0xe0000 0x1000>;
+		fsl,has-rstcr;
+
+		pmc: power@70 {
+			compatible = "fsl,mpc8568-pmc",
+				     "fsl,mpc8548-pmc";
+			reg = <0x70 0x20>;
+		};
+	};
+};
+
+&qe {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "qe";
+	compatible = "fsl,qe";
+	sleep = <&pmc 0x00000800>;
+	brg-frequency = <0>;
+	bus-frequency = <396000000>;
+	fsl,qe-num-riscs = <2>;
+	fsl,qe-num-snums = <28>;
+
+	qeic: interrupt-controller@80 {
+		interrupt-controller;
+		compatible = "fsl,qe-ic";
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		reg = <0x80 0x80>;
+		interrupts = <46 2 0 0 46 2 0 0>; //high:30 low:30
+		interrupt-parent = <&mpic>;
+	};
+
+	spi@4c0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,spi";
+		reg = <0x4c0 0x40>;
+		cell-index = <0>;
+		interrupts = <2>;
+		interrupt-parent = <&qeic>;
+	};
+
+	spi@500 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cell-index = <1>;
+		compatible = "fsl,spi";
+		reg = <0x500 0x40>;
+		interrupts = <1>;
+		interrupt-parent = <&qeic>;
+	};
+
+	ucc@2000 {
+		cell-index = <1>;
+		reg = <0x2000 0x200>;
+		interrupts = <32>;
+		interrupt-parent = <&qeic>;
+	};
+
+	ucc@3000 {
+		cell-index = <2>;
+		reg = <0x3000 0x200>;
+		interrupts = <33>;
+		interrupt-parent = <&qeic>;
+	};
+
+	muram@10000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,qe-muram", "fsl,cpm-muram";
+		ranges = <0x0 0x10000 0x10000>;
+
+		data-only@0 {
+			compatible = "fsl,qe-muram-data",
+				     "fsl,cpm-muram-data";
+			reg = <0x0 0x10000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/mpc8568si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8568si-pre.dtsi
new file mode 100644
index 0000000..eacd62c
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8568si-pre.dtsi
@@ -0,0 +1,65 @@
+/*
+ * MPC8568 Silicon/SoC Device Tree Source (pre include)
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
+	compatible = "fsl,MPC8568";
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
+		ethernet3 = &enet3;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8568@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+			sleep = <&pmc 0x00008000	// core
+				 &pmc 0x00004000>;	// timebase
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 647daf8..02eaad3 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -9,60 +9,25 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "fsl/mpc8568si-pre.dtsi"
 
 / {
 	model = "MPC8568EMDS";
 	compatible = "MPC8568EMDS", "MPC85xxMDS";
-	#address-cells = <1>;
-	#size-cells = <1>;
 
 	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		ethernet3 = &enet3;
-		serial0 = &serial0;
-		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
-		rapidio0 = &rio0;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8568@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <0x8000>;		// L1, 32K
-			i-cache-size = <0x8000>;		// L1, 32K
-			sleep = <&pmc 0x00008000	// core
-				 &pmc 0x00004000>;	// timebase
-			timebase-frequency = <0>;
-			bus-frequency = <0>;
-			clock-frequency = <0>;
-			next-level-cache = <&L2>;
-		};
+		rapidio0 = &rio;
 	};
 
 	memory {
 		device_type = "memory";
-		reg = <0x0 0x10000000>;
+		reg = <0x0 0x0 0x0 0x0>;
 	};
 
-	localbus@e0005000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8568-localbus", "fsl,pq3-localbus",
-			     "simple-bus";
-		reg = <0xe0005000 0x1000>;
-		interrupt-parent = <&mpic>;
-		interrupts = <19 2>;
-
+	lbc: localbus@e0005000 {
+		reg = <0x0 0xe0005000 0x0 0x1000>;
 		ranges = <0x0 0x0 0xfe000000 0x02000000
 			  0x1 0x0 0xf8000000 0x00008000
 			  0x2 0x0 0xf0000000 0x04000000
@@ -104,288 +69,65 @@
 		};
 	};
 
-	soc8568@e0000000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
-		ranges = <0x0 0xe0000000 0x100000>;
-		bus-frequency = <0>;
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		ecm@1000 {
-			compatible = "fsl,mpc8568-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,mpc8568-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,mpc8568-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>;	// 32 bytes
-			cache-size = <0x80000>;	// L2, 512K
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-		};
+	soc: soc8568@e0000000 {
+		ranges = <0x0 0x0 0xe0000000 0x100000>;
 
 		i2c-sleep-nexus {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			sleep = <&pmc 0x00000004>;
-			ranges;
-
 			i2c@3000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				cell-index = <0>;
-				compatible = "fsl-i2c";
-				reg = <0x3000 0x100>;
-				interrupts = <43 2>;
-				interrupt-parent = <&mpic>;
-				dfsrr;
-
 				rtc@68 {
 					compatible = "dallas,ds1374";
 					reg = <0x68>;
-					interrupts = <3 1>;
-					interrupt-parent = <&mpic>;
+					interrupts = <3 1 0 0>;
 				};
 			};
+		};
 
-			i2c@3100 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				cell-index = <1>;
-				compatible = "fsl-i2c";
-				reg = <0x3100 0x100>;
-				interrupts = <43 2>;
-				interrupt-parent = <&mpic>;
-				dfsrr;
-			};
+		enet0: ethernet@24000 {
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy2>;
 		};
 
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8568-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			sleep = <&pmc 0x00000400>;
-
-			dma-channel@0 {
-				compatible = "fsl,mpc8568-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
+		mdio@24520 {
+			phy0: ethernet-phy@7 {
+				interrupts = <1 1 0 0>;
+				reg = <0x7>;
+				device_type = "ethernet-phy";
 			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8568-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
+			phy1: ethernet-phy@1 {
+				interrupts = <2 1 0 0>;
+				reg = <0x1>;
+				device_type = "ethernet-phy";
 			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8568-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
+			phy2: ethernet-phy@2 {
+				interrupts = <1 1 0 0>;
+				reg = <0x2>;
+				device_type = "ethernet-phy";
 			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8568-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
+			phy3: ethernet-phy@3 {
+				interrupts = <2 1 0 0>;
+				reg = <0x3>;
+				device_type = "ethernet-phy";
 			};
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
- 			interrupts = <29 2 30 2 34 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy2>;
-			sleep = <&pmc 0x00000080>;
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@7 {
-					interrupt-parent = <&mpic>;
-					interrupts = <1 1>;
-					reg = <0x7>;
-					device_type = "ethernet-phy";
-				};
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <2 1>;
-					reg = <0x1>;
-					device_type = "ethernet-phy";
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&mpic>;
-					interrupts = <1 1>;
-					reg = <0x2>;
-					device_type = "ethernet-phy";
-				};
-				phy3: ethernet-phy@3 {
-					interrupt-parent = <&mpic>;
-					interrupts = <2 1>;
-					reg = <0x3>;
-					device_type = "ethernet-phy";
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			ranges = <0x0 0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
- 			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy3>;
 			sleep = <&pmc 0x00000040>;
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi1: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
 		};
 
-		duart-sleep-nexus {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			sleep = <&pmc 0x00000002>;
-			ranges;
-
-			serial0: serial@4500 {
-				cell-index = <0>;
-				device_type = "serial";
-				compatible = "ns16550";
-				reg = <0x4500 0x100>;
-				clock-frequency = <0>;
-				interrupts = <42 2>;
-				interrupt-parent = <&mpic>;
-			};
-
-			serial1: serial@4600 {
-				cell-index = <1>;
-				device_type = "serial";
-				compatible = "ns16550";
-				reg = <0x4600 0x100>;
-				clock-frequency = <0>;
-				interrupts = <42 2>;
-				interrupt-parent = <&mpic>;
+		mdio@25520 {
+			tbi1: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
-		global-utilities@e0000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8568-guts", "fsl,mpc8548-guts";
-			reg = <0xe0000 0x1000>;
-			ranges = <0 0xe0000 0x1000>;
-			fsl,has-rstcr;
-
-			pmc: power@70 {
-				compatible = "fsl,mpc8568-pmc",
-					     "fsl,mpc8548-pmc";
-				reg = <0x70 0x20>;
-			};
-		};
-
-		crypto@30000 {
-			compatible = "fsl,sec2.1", "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <45 2>;
-			interrupt-parent = <&mpic>;
-			fsl,num-channels = <4>;
-			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0xfe>;
-			fsl,descriptor-types-mask = <0x12b0ebf>;
-			sleep = <&pmc 0x01000000>;
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
-			compatible = "fsl,mpc8568-msi", "fsl,mpic-msi";
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
 		par_io@e0100 {
-			reg = <0xe0100 0x100>;
-			device_type = "par_io";
 			num-ports = <7>;
 
 			pio1: ucc_pin@01 {
@@ -448,57 +190,21 @@
 		};
 	};
 
-	qe@e0080000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "qe";
-		compatible = "fsl,qe";
-		ranges = <0x0 0xe0080000 0x40000>;
-		reg = <0xe0080000 0x480>;
-		sleep = <&pmc 0x00000800>;
-		brg-frequency = <0>;
-		bus-frequency = <396000000>;
-		fsl,qe-num-riscs = <2>;
-		fsl,qe-num-snums = <28>;
-
-		muram@10000 {
- 			#address-cells = <1>;
- 			#size-cells = <1>;
-			compatible = "fsl,qe-muram", "fsl,cpm-muram";
-			ranges = <0x0 0x10000 0x10000>;
-
-			data-only@0 {
-				compatible = "fsl,qe-muram-data",
-					     "fsl,cpm-muram-data";
-				reg = <0x0 0x10000>;
-			};
-		};
+	qe: qe@e0080000 {
+		ranges = <0x0 0x0 0xe0080000 0x40000>;
+		reg = <0x0 0xe0080000 0x0 0x480>;
 
 		spi@4c0 {
-			cell-index = <0>;
-			compatible = "fsl,spi";
-			reg = <0x4c0 0x40>;
-			interrupts = <2>;
-			interrupt-parent = <&qeic>;
 			mode = "cpu";
 		};
 
 		spi@500 {
-			cell-index = <1>;
-			compatible = "fsl,spi";
-			reg = <0x500 0x40>;
-			interrupts = <1>;
-			interrupt-parent = <&qeic>;
 			mode = "cpu";
 		};
 
 		enet2: ucc@2000 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			cell-index = <1>;
-			reg = <0x2000 0x200>;
-			interrupts = <32>;
-			interrupt-parent = <&qeic>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock-name = "none";
 			tx-clock-name = "clk16";
@@ -510,10 +216,6 @@
 		enet3: ucc@3000 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			cell-index = <2>;
-			reg = <0x3000 0x200>;
-			interrupts = <33>;
-			interrupt-parent = <&qeic>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock-name = "none";
 			tx-clock-name = "clk16";
@@ -532,102 +234,57 @@
 			 * gianfar's MDIO bus */
 			qe_phy0: ethernet-phy@07 {
 				interrupt-parent = <&mpic>;
-				interrupts = <1 1>;
+				interrupts = <1 1 0 0>;
 				reg = <0x7>;
 				device_type = "ethernet-phy";
 			};
 			qe_phy1: ethernet-phy@01 {
 				interrupt-parent = <&mpic>;
-				interrupts = <2 1>;
+				interrupts = <2 1 0 0>;
 				reg = <0x1>;
 				device_type = "ethernet-phy";
 			};
 			qe_phy2: ethernet-phy@02 {
 				interrupt-parent = <&mpic>;
-				interrupts = <1 1>;
+				interrupts = <1 1 0 0>;
 				reg = <0x2>;
 				device_type = "ethernet-phy";
 			};
 			qe_phy3: ethernet-phy@03 {
 				interrupt-parent = <&mpic>;
-				interrupts = <2 1>;
+				interrupts = <2 1 0 0>;
 				reg = <0x3>;
 				device_type = "ethernet-phy";
 			};
 		};
-
-		qeic: interrupt-controller@80 {
-			interrupt-controller;
-			compatible = "fsl,qe-ic";
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-			reg = <0x80 0x80>;
-			big-endian;
-			interrupts = <46 2 46 2>; //high:30 low:30
-			interrupt-parent = <&mpic>;
-		};
-
 	};
 
 	pci0: pci@e0008000 {
+		reg = <0x0 0xe0008000 0x0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0x0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0x0 0xe2000000 0x0 0x800000>;
+		clock-frequency = <66666666>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			/* IDSEL 0x12 AD18 */
-			0x9000 0x0 0x0 0x1 &mpic 0x5 0x1
-			0x9000 0x0 0x0 0x2 &mpic 0x6 0x1
-			0x9000 0x0 0x0 0x3 &mpic 0x7 0x1
-			0x9000 0x0 0x0 0x4 &mpic 0x4 0x1
+			0x9000 0x0 0x0 0x1 &mpic 0x5 0x1 0 0
+			0x9000 0x0 0x0 0x2 &mpic 0x6 0x1 0 0
+			0x9000 0x0 0x0 0x3 &mpic 0x7 0x1 0 0
+			0x9000 0x0 0x0 0x4 &mpic 0x4 0x1 0 0
 
 			/* IDSEL 0x13 AD19 */
-			0x9800 0x0 0x0 0x1 &mpic 0x6 0x1
-			0x9800 0x0 0x0 0x2 &mpic 0x7 0x1
-			0x9800 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x9800 0x0 0x0 0x4 &mpic 0x5 0x1>;
-
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
-		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0x80000000 0x80000000 0x0 0x20000000
-			  0x1000000 0x0 0x0 0xe2000000 0x0 0x800000>;
-		sleep = <&pmc 0x80000000>;
-		clock-frequency = <66666666>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xe0008000 0x1000>;
-		compatible = "fsl,mpc8540-pci";
-		device_type = "pci";
+			0x9800 0x0 0x0 0x1 &mpic 0x6 0x1 0 0
+			0x9800 0x0 0x0 0x2 &mpic 0x7 0x1 0 0
+			0x9800 0x0 0x0 0x3 &mpic 0x4 0x1 0 0
+			0x9800 0x0 0x0 0x4 &mpic 0x5 0x1 0 0>;
 	};
 
 	/* PCI Express */
 	pci1: pcie@e000a000 {
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-
-			/* IDSEL 0x0 (PEX) */
-			00000 0x0 0x0 0x1 &mpic 0x0 0x1
-			00000 0x0 0x0 0x2 &mpic 0x1 0x1
-			00000 0x0 0x0 0x3 &mpic 0x2 0x1
-			00000 0x0 0x0 0x4 &mpic 0x3 0x1>;
-
-		interrupt-parent = <&mpic>;
-		interrupts = <26 2>;
-		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
-			  0x1000000 0x0 0x0 0xe2800000 0x0 0x800000>;
-		sleep = <&pmc 0x20000000>;
-		clock-frequency = <33333333>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xe000a000 0x1000>;
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
+		ranges = <0x2000000 0x0 0xa0000000 0x0 0xa0000000 0x0 0x10000000
+			  0x1000000 0x0 0x00000000 0x0 0xe2800000 0x0 0x800000>;
+		reg = <0x0 0xe000a000 0x0 0x1000>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xa0000000
 				  0x2000000 0x0 0xa0000000
 				  0x0 0x10000000
@@ -638,22 +295,9 @@
 		};
 	};
 
-	rio0: rapidio@e00c00000 {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		compatible = "fsl,mpc8568-rapidio", "fsl,rapidio-delta";
-		reg = <0xe00c0000 0x20000>;
-		ranges = <0x0 0x0 0xc0000000 0x0 0x20000000>;
-		interrupts = <48 2 /* error     */
-			      49 2 /* bell_outb */
-			      50 2 /* bell_inb  */
-			      53 2 /* msg1_tx   */
-			      54 2 /* msg1_rx   */
-			      55 2 /* msg2_tx   */
-			      56 2 /* msg2_rx   */>;
-		interrupt-parent = <&mpic>;
-		sleep = <&pmc 0x00080000   /* controller */
-			 &pmc 0x00040000>; /* message unit */
+	rio: rapidio@e00c00000 {
+		reg = <0x0 0xe00c0000 0x0 0x20000>;
+		ranges = <0x0 0x0 0x0 0xc0000000 0x0 0x20000000>;
 	};
 
 	leds {
@@ -672,3 +316,5 @@
 		};
 	};
 };
+
+/include/ "fsl/mpc8568si-post.dtsi"
-- 
1.7.3.4

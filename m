Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B2CE1100871
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:14:41 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAGEaeV031719
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:14:36 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 16/30] powerpc/85xx: Rework P2020DS device tree
Date: Thu, 10 Nov 2011 10:13:59 -0600
Message-Id: <1320941653-29797-17-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941653-29797-16-git-send-email-galak@kernel.crashing.org>
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
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi |  194 +++++++++++++++
 arch/powerpc/boot/dts/fsl/p2020si-pre.dtsi  |   69 ++++++
 arch/powerpc/boot/dts/p2020ds.dts           |  353 ++-------------------------
 arch/powerpc/boot/dts/p2020ds.dtsi          |  316 ++++++++++++++++++++++++
 arch/powerpc/boot/dts/p2020si.dtsi          |   99 +++-----
 5 files changed, 634 insertions(+), 397 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p2020si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/p2020ds.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
new file mode 100644
index 0000000..c041050
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
@@ -0,0 +1,194 @@
+/*
+ * P2020/P2010 Silicon/SoC Device Tree Source (post include)
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
+	compatible = "fsl,p2020-elbc", "fsl,elbc", "simple-bus";
+	interrupts = <19 2 0 0>;
+};
+
+/* controller at 0xa000 */
+&pci0 {
+	compatible = "fsl,mpc8548-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 255>;
+	clock-frequency = <33333333>;
+	interrupts = <26 2 0 0>;
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
+/* controller at 0x9000 */
+&pci1 {
+	compatible = "fsl,mpc8548-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 255>;
+	clock-frequency = <33333333>;
+	interrupts = <25 2 0 0>;
+
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <25 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+
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
+/* controller at 0x8000 */
+&pci2 {
+	compatible = "fsl,mpc8548-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 255>;
+	clock-frequency = <33333333>;
+	interrupts = <24 2 0 0>;
+
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <24 2 0 0>;
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
+	compatible = "fsl,p2020-immr", "simple-bus";
+	bus-frequency = <0>;		// Filled out by uboot.
+
+	ecm-law@0 {
+		compatible = "fsl,ecm-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <12>;
+	};
+
+	ecm@1000 {
+		compatible = "fsl,p2020-ecm", "fsl,ecm";
+		reg = <0x1000 0x1000>;
+		interrupts = <17 2 0 0>;
+	};
+
+	memory-controller@2000 {
+		compatible = "fsl,p2020-memory-controller";
+		reg = <0x2000 0x1000>;
+		interrupts = <18 2 0 0>;
+	};
+
+/include/ "pq3-i2c-0.dtsi"
+/include/ "pq3-i2c-1.dtsi"
+/include/ "pq3-duart-0.dtsi"
+/include/ "pq3-espi-0.dtsi"
+	spi0: spi@7000 {
+		fsl,espi-num-chipselects = <4>;
+	};
+
+/include/ "pq3-dma-1.dtsi"
+/include/ "pq3-gpio-0.dtsi"
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,p2020-l2-cache-controller";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>;	// 32 bytes
+		cache-size = <0x80000>; // L2,512K
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-dma-0.dtsi"
+/include/ "pq3-usb2-dr-0.dtsi"
+/include/ "pq3-etsec1-0.dtsi"
+/include/ "pq3-etsec1-timer-0.dtsi"
+
+	ptp_clock@24e00 {
+		interrupts = <68 2 0 0 69 2 0 0 70 2 0 0>;
+	};
+
+
+/include/ "pq3-etsec1-1.dtsi"
+/include/ "pq3-etsec1-2.dtsi"
+/include/ "pq3-esdhc-0.dtsi"
+/include/ "pq3-sec3.1-0.dtsi"
+/include/ "pq3-mpic.dtsi"
+/include/ "pq3-mpic-timer-B.dtsi"
+
+	global-utilities@e0000 {
+		compatible = "fsl,p2020-guts";
+		reg = <0xe0000 0x1000>;
+		fsl,has-rstcr;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/p2020si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p2020si-pre.dtsi
new file mode 100644
index 0000000..3213288
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p2020si-pre.dtsi
@@ -0,0 +1,69 @@
+/*
+ * P2020/P2010 Silicon/SoC Device Tree Source (pre include)
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
+	compatible = "fsl,P2020";
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
+		pci2 = &pci2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,P2020@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,P2020@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/p2020ds.dts
index 66f03d6..237310c 100644
--- a/arch/powerpc/boot/dts/p2020ds.dts
+++ b/arch/powerpc/boot/dts/p2020ds.dts
@@ -9,30 +9,17 @@
  * option) any later version.
  */
 
-/include/ "p2020si.dtsi"
+/include/ "fsl/p2020si-pre.dtsi"
 
 / {
 	model = "fsl,P2020DS";
 	compatible = "fsl,P2020DS";
 
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-		pci1 = &pci1;
-		pci2 = &pci2;
-	};
-
-
 	memory {
 		device_type = "memory";
 	};
 
-	localbus@ffe05000 {
-		compatible = "fsl,elbc", "simple-bus";
+	board_lbc: lbc: localbus@ffe05000 {
 		ranges = <0x0 0x0 0x0 0xe8000000 0x08000000
 			  0x1 0x0 0x0 0xe0000000 0x08000000
 			  0x2 0x0 0x0 0xffa00000 0x00040000
@@ -40,203 +27,18 @@
 			  0x4 0x0 0x0 0xffa40000 0x00040000
 			  0x5 0x0 0x0 0xffa80000 0x00040000
 			  0x6 0x0 0x0 0xffac0000 0x00040000>;
-
-		nor@0,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "cfi-flash";
-			reg = <0x0 0x0 0x8000000>;
-			bank-width = <2>;
-			device-width = <1>;
-
-			ramdisk@0 {
-				reg = <0x0 0x03000000>;
-				read-only;
-			};
-
-			diagnostic@3000000 {
-				reg = <0x03000000 0x00e00000>;
-				read-only;
-			};
-
-			dink@3e00000 {
-				reg = <0x03e00000 0x00200000>;
-				read-only;
-			};
-
-			kernel@4000000 {
-				reg = <0x04000000 0x00400000>;
-				read-only;
-			};
-
-			jffs2@4400000 {
-				reg = <0x04400000 0x03b00000>;
-			};
-
-			dtb@7f00000 {
-				reg = <0x07f00000 0x00080000>;
-				read-only;
-			};
-
-			u-boot@7f80000 {
-				reg = <0x07f80000 0x00080000>;
-				read-only;
-			};
-		};
-
-		nand@2,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,elbc-fcm-nand";
-			reg = <0x2 0x0 0x40000>;
-
-			u-boot@0 {
-				reg = <0x0 0x02000000>;
-				read-only;
-			};
-
-			jffs2@2000000 {
-				reg = <0x02000000 0x10000000>;
-			};
-
-			ramdisk@12000000 {
-				reg = <0x12000000 0x08000000>;
-				read-only;
-			};
-
-			kernel@1a000000 {
-				reg = <0x1a000000 0x04000000>;
-			};
-
-			dtb@1e000000 {
-				reg = <0x1e000000 0x01000000>;
-				read-only;
-			};
-
-			empty@1f000000 {
-				reg = <0x1f000000 0x21000000>;
-			};
-		};
-
-		board-control@3,0 {
-			compatible = "fsl,p2020ds-fpga", "fsl,fpga-ngpixis";
-			reg = <0x3 0x0 0x30>;
-		};
-
-		nand@4,0 {
-			compatible = "fsl,elbc-fcm-nand";
-			reg = <0x4 0x0 0x40000>;
-		};
-
-		nand@5,0 {
-			compatible = "fsl,elbc-fcm-nand";
-			reg = <0x5 0x0 0x40000>;
-		};
-
-		nand@6,0 {
-			compatible = "fsl,elbc-fcm-nand";
-			reg = <0x6 0x0 0x40000>;
-		};
+		reg = <0 0xffe05000 0 0x1000>;
 	};
 
-	soc@ffe00000 {
-
-		usb@22000 {
-			phy_type = "ulpi";
-		};
-
-		mdio@24520 {
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <3 1>;
-				reg = <0x0>;
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <3 1>;
-				reg = <0x1>;
-			};
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <3 1>;
-				reg = <0x2>;
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-
-		};
-
-		mdio@25520 {
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@26520 {
-			tbi2: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-
-		};
-
-		ptp_clock@24E00 {
-			compatible = "fsl,etsec-ptp";
-			reg = <0x24E00 0xB0>;
-			interrupts = <68 2 69 2 70 2>;
-			interrupt-parent = < &mpic >;
-			fsl,tclk-period = <5>;
-			fsl,tmr-prsc = <200>;
-			fsl,tmr-add = <0xCCCCCCCD>;
-			fsl,tmr-fiper1 = <0x3B9AC9FB>;
-			fsl,tmr-fiper2 = <0x0001869B>;
-			fsl,max-adj = <249999999>;
-		};
-
-		enet0: ethernet@24000 {
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "rgmii-id";
-		};
-
-		enet1: ethernet@25000 {
-			tbi-handle = <&tbi1>;
-			phy-handle = <&phy1>;
-			phy-connection-type = "rgmii-id";
-
-		};
-
-		enet2: ethernet@26000 {
-			tbi-handle = <&tbi2>;
-			phy-handle = <&phy2>;
-			phy-connection-type = "rgmii-id";
-		};
-
-
-		msi@41600 {
-			compatible = "fsl,mpic-msi";
-		};
+	board_soc: soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
 	};
 
-	pci0: pcie@ffe08000 {
+	pci2: pcie@ffe08000 {
 		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x8 0x1
-			0000 0x0 0x0 0x2 &mpic 0x9 0x1
-			0000 0x0 0x0 0x3 &mpic 0xa 0x1
-			0000 0x0 0x0 0x4 &mpic 0xb 0x1
-			>;
+		reg = <0 0xffe08000 0 0x1000>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0x80000000
 				  0x2000000 0x0 0x80000000
 				  0x0 0x20000000
@@ -247,61 +49,11 @@
 		};
 	};
 
-	pci1: pcie@ffe09000 {
+	board_pci1: pci1: pcie@ffe09000 {
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
-		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
-		interrupt-map = <
-
-			// IDSEL 0x11 func 0 - PCI slot 1
-			0x8800 0x0 0x0 0x1 &i8259 0x9 0x2
-			0x8800 0x0 0x0 0x2 &i8259 0xa 0x2
-
-			// IDSEL 0x11 func 1 - PCI slot 1
-			0x8900 0x0 0x0 0x1 &i8259 0x9 0x2
-			0x8900 0x0 0x0 0x2 &i8259 0xa 0x2
-
-			// IDSEL 0x11 func 2 - PCI slot 1
-			0x8a00 0x0 0x0 0x1 &i8259 0x9 0x2
-			0x8a00 0x0 0x0 0x2 &i8259 0xa 0x2
-
-			// IDSEL 0x11 func 3 - PCI slot 1
-			0x8b00 0x0 0x0 0x1 &i8259 0x9 0x2
-			0x8b00 0x0 0x0 0x2 &i8259 0xa 0x2
-
-			// IDSEL 0x11 func 4 - PCI slot 1
-			0x8c00 0x0 0x0 0x1 &i8259 0x9 0x2
-			0x8c00 0x0 0x0 0x2 &i8259 0xa 0x2
-
-			// IDSEL 0x11 func 5 - PCI slot 1
-			0x8d00 0x0 0x0 0x1 &i8259 0x9 0x2
-			0x8d00 0x0 0x0 0x2 &i8259 0xa 0x2
-
-			// IDSEL 0x11 func 6 - PCI slot 1
-			0x8e00 0x0 0x0 0x1 &i8259 0x9 0x2
-			0x8e00 0x0 0x0 0x2 &i8259 0xa 0x2
-
-			// IDSEL 0x11 func 7 - PCI slot 1
-			0x8f00 0x0 0x0 0x1 &i8259 0x9 0x2
-			0x8f00 0x0 0x0 0x2 &i8259 0xa 0x2
-
-			// IDSEL 0x1d  Audio
-			0xe800 0x0 0x0 0x1 &i8259 0x6 0x2
-
-			// IDSEL 0x1e Legacy
-			0xf000 0x0 0x0 0x1 &i8259 0x7 0x2
-			0xf100 0x0 0x0 0x1 &i8259 0x7 0x2
-
-			// IDSEL 0x1f IDE/SATA
-			0xf800 0x0 0x0 0x1 &i8259 0xe 0x2
-			0xf900 0x0 0x0 0x1 &i8259 0x5 0x2
-			>;
-
+		reg = <0 0xffe09000 0 0x1000>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xa0000000
 				  0x2000000 0x0 0xa0000000
 				  0x0 0x20000000
@@ -309,89 +61,14 @@
 				  0x1000000 0x0 0x0
 				  0x1000000 0x0 0x0
 				  0x0 0x10000>;
-			uli1575@0 {
-				reg = <0x0 0x0 0x0 0x0 0x0>;
-				#size-cells = <2>;
-				#address-cells = <3>;
-				ranges = <0x2000000 0x0 0xa0000000
-					  0x2000000 0x0 0xa0000000
-					  0x0 0x20000000
-
-					  0x1000000 0x0 0x0
-					  0x1000000 0x0 0x0
-					  0x0 0x10000>;
-				isa@1e {
-					device_type = "isa";
-					#interrupt-cells = <2>;
-					#size-cells = <1>;
-					#address-cells = <2>;
-					reg = <0xf000 0x0 0x0 0x0 0x0>;
-					ranges = <0x1 0x0 0x1000000 0x0 0x0
-						  0x1000>;
-					interrupt-parent = <&i8259>;
-
-					i8259: interrupt-controller@20 {
-						reg = <0x1 0x20 0x2
-						       0x1 0xa0 0x2
-						       0x1 0x4d0 0x2>;
-						interrupt-controller;
-						device_type = "interrupt-controller";
-						#address-cells = <0>;
-						#interrupt-cells = <2>;
-						compatible = "chrp,iic";
-						interrupts = <4 1>;
-						interrupt-parent = <&mpic>;
-					};
-
-					i8042@60 {
-						#size-cells = <0>;
-						#address-cells = <1>;
-						reg = <0x1 0x60 0x1 0x1 0x64 0x1>;
-						interrupts = <1 3 12 3>;
-						interrupt-parent =
-							<&i8259>;
-
-						keyboard@0 {
-							reg = <0x0>;
-							compatible = "pnpPNP,303";
-						};
-
-						mouse@1 {
-							reg = <0x1>;
-							compatible = "pnpPNP,f03";
-						};
-					};
-
-					rtc@70 {
-						compatible = "pnpPNP,b00";
-						reg = <0x1 0x70 0x2>;
-					};
-
-					gpio@400 {
-						reg = <0x1 0x400 0x80>;
-					};
-				};
-			};
 		};
-
 	};
 
-	pci2: pcie@ffe0a000 {
+	pci0: pcie@ffe0a000 {
 		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0000 0x0 0x0 0x4 &mpic 0x3 0x1
-			>;
+		reg = <0 0xffe0a000 0 0x1000>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xc0000000
 				  0x2000000 0x0 0xc0000000
 				  0x0 0x20000000
@@ -402,3 +79,11 @@
 		};
 	};
 };
+
+/*
+ * p2020ds.dtsi must be last to ensure board_pci0 overrides pci0 settings
+ * for interrupt-map & interrupt-map-mask
+ */
+
+/include/ "fsl/p2020si-post.dtsi"
+/include/ "p2020ds.dtsi"
diff --git a/arch/powerpc/boot/dts/p2020ds.dtsi b/arch/powerpc/boot/dts/p2020ds.dtsi
new file mode 100644
index 0000000..c1cf6ce
--- /dev/null
+++ b/arch/powerpc/boot/dts/p2020ds.dtsi
@@ -0,0 +1,316 @@
+/*
+ * P2020DS Device Tree Source stub (no addresses or top-level ranges)
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
+&board_lbc {
+	nor@0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x8000000>;
+		bank-width = <2>;
+		device-width = <1>;
+
+		ramdisk@0 {
+			reg = <0x0 0x03000000>;
+			read-only;
+		};
+
+		diagnostic@3000000 {
+			reg = <0x03000000 0x00e00000>;
+			read-only;
+		};
+
+		dink@3e00000 {
+			reg = <0x03e00000 0x00200000>;
+			read-only;
+		};
+
+		kernel@4000000 {
+			reg = <0x04000000 0x00400000>;
+			read-only;
+		};
+
+		jffs2@4400000 {
+			reg = <0x04400000 0x03b00000>;
+		};
+
+		dtb@7f00000 {
+			reg = <0x07f00000 0x00080000>;
+			read-only;
+		};
+
+		u-boot@7f80000 {
+			reg = <0x07f80000 0x00080000>;
+			read-only;
+		};
+	};
+
+	nand@2,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,elbc-fcm-nand";
+		reg = <0x2 0x0 0x40000>;
+
+		u-boot@0 {
+			reg = <0x0 0x02000000>;
+			read-only;
+		};
+
+		jffs2@2000000 {
+			reg = <0x02000000 0x10000000>;
+		};
+
+		ramdisk@12000000 {
+			reg = <0x12000000 0x08000000>;
+			read-only;
+		};
+
+		kernel@1a000000 {
+			reg = <0x1a000000 0x04000000>;
+		};
+
+		dtb@1e000000 {
+			reg = <0x1e000000 0x01000000>;
+			read-only;
+		};
+
+		empty@1f000000 {
+			reg = <0x1f000000 0x21000000>;
+		};
+	};
+
+	board-control@3,0 {
+		compatible = "fsl,p2020ds-fpga", "fsl,fpga-ngpixis";
+		reg = <0x3 0x0 0x30>;
+	};
+
+	nand@4,0 {
+		compatible = "fsl,elbc-fcm-nand";
+		reg = <0x4 0x0 0x40000>;
+	};
+
+	nand@5,0 {
+		compatible = "fsl,elbc-fcm-nand";
+		reg = <0x5 0x0 0x40000>;
+	};
+
+	nand@6,0 {
+		compatible = "fsl,elbc-fcm-nand";
+		reg = <0x6 0x0 0x40000>;
+	};
+};
+
+&board_soc {
+	usb@22000 {
+		phy_type = "ulpi";
+	};
+
+	mdio@24520 {
+		phy0: ethernet-phy@0 {
+			interrupts = <3 1 0 0>;
+			reg = <0x0>;
+		};
+		phy1: ethernet-phy@1 {
+			interrupts = <3 1 0 0>;
+			reg = <0x1>;
+		};
+		phy2: ethernet-phy@2 {
+			interrupts = <3 1 0 0>;
+			reg = <0x2>;
+		};
+		tbi0: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+
+	};
+
+	mdio@25520 {
+		tbi1: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	mdio@26520 {
+		tbi2: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+
+	};
+
+	ptp_clock@24e00 {
+		fsl,tclk-period = <5>;
+		fsl,tmr-prsc = <200>;
+		fsl,tmr-add = <0xCCCCCCCD>;
+		fsl,tmr-fiper1 = <0x3B9AC9FB>;
+		fsl,tmr-fiper2 = <0x0001869B>;
+		fsl,max-adj = <249999999>;
+	};
+
+	enet0: ethernet@24000 {
+		tbi-handle = <&tbi0>;
+		phy-handle = <&phy0>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	enet1: ethernet@25000 {
+		tbi-handle = <&tbi1>;
+		phy-handle = <&phy1>;
+		phy-connection-type = "rgmii-id";
+
+	};
+
+	enet2: ethernet@26000 {
+		tbi-handle = <&tbi2>;
+		phy-handle = <&phy2>;
+		phy-connection-type = "rgmii-id";
+	};
+};
+
+&board_pci1 {
+	pcie@0 {
+		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
+		interrupt-map = <
+
+			// IDSEL 0x11 func 0 - PCI slot 1
+			0x8800 0x0 0x0 0x1 &i8259 0x9 0x2
+			0x8800 0x0 0x0 0x2 &i8259 0xa 0x2
+
+			// IDSEL 0x11 func 1 - PCI slot 1
+			0x8900 0x0 0x0 0x1 &i8259 0x9 0x2
+			0x8900 0x0 0x0 0x2 &i8259 0xa 0x2
+
+			// IDSEL 0x11 func 2 - PCI slot 1
+			0x8a00 0x0 0x0 0x1 &i8259 0x9 0x2
+			0x8a00 0x0 0x0 0x2 &i8259 0xa 0x2
+
+			// IDSEL 0x11 func 3 - PCI slot 1
+			0x8b00 0x0 0x0 0x1 &i8259 0x9 0x2
+			0x8b00 0x0 0x0 0x2 &i8259 0xa 0x2
+
+			// IDSEL 0x11 func 4 - PCI slot 1
+			0x8c00 0x0 0x0 0x1 &i8259 0x9 0x2
+			0x8c00 0x0 0x0 0x2 &i8259 0xa 0x2
+
+			// IDSEL 0x11 func 5 - PCI slot 1
+			0x8d00 0x0 0x0 0x1 &i8259 0x9 0x2
+			0x8d00 0x0 0x0 0x2 &i8259 0xa 0x2
+
+			// IDSEL 0x11 func 6 - PCI slot 1
+			0x8e00 0x0 0x0 0x1 &i8259 0x9 0x2
+			0x8e00 0x0 0x0 0x2 &i8259 0xa 0x2
+
+			// IDSEL 0x11 func 7 - PCI slot 1
+			0x8f00 0x0 0x0 0x1 &i8259 0x9 0x2
+			0x8f00 0x0 0x0 0x2 &i8259 0xa 0x2
+
+			// IDSEL 0x1d  Audio
+			0xe800 0x0 0x0 0x1 &i8259 0x6 0x2
+
+			// IDSEL 0x1e Legacy
+			0xf000 0x0 0x0 0x1 &i8259 0x7 0x2
+			0xf100 0x0 0x0 0x1 &i8259 0x7 0x2
+
+			// IDSEL 0x1f IDE/SATA
+			0xf800 0x0 0x0 0x1 &i8259 0xe 0x2
+			0xf900 0x0 0x0 0x1 &i8259 0x5 0x2
+			>;
+
+		uli1575@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			ranges = <0x2000000 0x0 0xa0000000
+				  0x2000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x10000>;
+			isa@1e {
+				device_type = "isa";
+				#interrupt-cells = <2>;
+				#size-cells = <1>;
+				#address-cells = <2>;
+				reg = <0xf000 0x0 0x0 0x0 0x0>;
+				ranges = <0x1 0x0 0x1000000 0x0 0x0
+					  0x1000>;
+				interrupt-parent = <&i8259>;
+
+				i8259: interrupt-controller@20 {
+					reg = <0x1 0x20 0x2
+					       0x1 0xa0 0x2
+					       0x1 0x4d0 0x2>;
+					interrupt-controller;
+					device_type = "interrupt-controller";
+					#address-cells = <0>;
+					#interrupt-cells = <2>;
+					compatible = "chrp,iic";
+					interrupts = <4 1 0 0>;
+					interrupt-parent = <&mpic>;
+				};
+
+				i8042@60 {
+					#size-cells = <0>;
+					#address-cells = <1>;
+					reg = <0x1 0x60 0x1 0x1 0x64 0x1>;
+					interrupts = <1 3 12 3>;
+					interrupt-parent =
+						<&i8259>;
+
+					keyboard@0 {
+						reg = <0x0>;
+						compatible = "pnpPNP,303";
+					};
+
+					mouse@1 {
+						reg = <0x1>;
+						compatible = "pnpPNP,f03";
+					};
+				};
+
+				rtc@70 {
+					compatible = "pnpPNP,b00";
+					reg = <0x1 0x70 0x2>;
+				};
+
+				gpio@400 {
+					reg = <0x1 0x400 0x80>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/p2020si.dtsi b/arch/powerpc/boot/dts/p2020si.dtsi
index 6def17f..37f7194 100644
--- a/arch/powerpc/boot/dts/p2020si.dtsi
+++ b/arch/powerpc/boot/dts/p2020si.dtsi
@@ -14,6 +14,7 @@
 	compatible = "fsl,P2020";
 	#address-cells = <2>;
 	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
 
 	cpus {
 		#address-cells = <1>;
@@ -37,8 +38,7 @@
 		#size-cells = <1>;
 		compatible = "fsl,p2020-elbc", "fsl,elbc", "simple-bus";
 		reg = <0 0xffe05000 0 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
+		interrupts = <19 2 0 0>;
 	};
 
 	soc@ffe00000 {
@@ -58,15 +58,13 @@
 		ecm@1000 {
 			compatible = "fsl,p2020-ecm", "fsl,ecm";
 			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <17 2 0 0>;
 		};
 
 		memory-controller@2000 {
 			compatible = "fsl,p2020-memory-controller";
 			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
+			interrupts = <18 2 0 0>;
 		};
 
 		i2c@3000 {
@@ -75,8 +73,7 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <43 2 0 0>;
 			dfsrr;
 		};
 
@@ -86,8 +83,7 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <43 2 0 0>;
 			dfsrr;
 		};
 
@@ -97,8 +93,7 @@
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <42 2 0 0>;
 		};
 
 		serial1: serial@4600 {
@@ -107,8 +102,7 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <42 2 0 0>;
 		};
 
 		spi@7000 {
@@ -117,8 +111,7 @@
 			#size-cells = <0>;
 			compatible = "fsl,espi";
 			reg = <0x7000 0x1000>;
-			interrupts = <59 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <59 0x2 0 0>;
 			mode = "cpu";
 		};
 
@@ -133,29 +126,25 @@
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <76 2>;
+				interrupts = <76 2 0 0>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <77 2>;
+				interrupts = <77 2 0 0>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x100 0x80>;
 				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <78 2>;
+				interrupts = <78 2 0 0>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x180 0x80>;
 				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <79 2>;
+				interrupts = <79 2 0 0>;
 			};
 		};
 
@@ -163,8 +152,7 @@
 			#gpio-cells = <2>;
 			compatible = "fsl,mpc8572-gpio";
 			reg = <0xf000 0x100>;
-			interrupts = <47 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <47 0x2 0 0>;
 			gpio-controller;
 		};
 
@@ -173,8 +161,7 @@
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
 			cache-size = <0x80000>; // L2,512K
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
+			interrupts = <16 2 0 0>;
 		};
 
 		dma@21300 {
@@ -188,29 +175,25 @@
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
+				interrupts = <20 2 0 0>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
+				interrupts = <21 2 0 0>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x100 0x80>;
 				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
+				interrupts = <22 2 0 0>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x180 0x80>;
 				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
+				interrupts = <23 2 0 0>;
 			};
 		};
 
@@ -219,8 +202,7 @@
 			#size-cells = <0>;
 			compatible = "fsl-usb2-dr";
 			reg = <0x22000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <28 0x2>;
+			interrupts = <28 0x2 0 0>;
 		};
 
 		mdio@24520 {
@@ -254,8 +236,7 @@
 			reg = <0x24000 0x1000>;
 			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30 2 34 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
 		};
 
 		enet1: ethernet@25000 {
@@ -268,8 +249,7 @@
 			reg = <0x25000 0x1000>;
 			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
 
 		};
 
@@ -283,16 +263,14 @@
 			reg = <0x26000 0x1000>;
 			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 
 		};
 
 		sdhci@2e000 {
 			compatible = "fsl,p2020-esdhc", "fsl,esdhc";
 			reg = <0x2e000 0x1000>;
-			interrupts = <72 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <72 0x2 0 0>;
 			/* Filled in by U-Boot */
 			clock-frequency = <0>;
 		};
@@ -301,8 +279,7 @@
 			compatible = "fsl,sec3.1", "fsl,sec3.0", "fsl,sec2.4",
 				     "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
-			interrupts = <45 2 58 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <45 2 0 0 58 2 0 0>;
 			fsl,num-channels = <4>;
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0xbfe>;
@@ -323,15 +300,14 @@
 			reg = <0x41600 0x80>;
 			msi-available-ranges = <0 0x100>;
 			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
+				0xe0 0 0 0
+				0xe1 0 0 0
+				0xe2 0 0 0
+				0xe3 0 0 0
+				0xe4 0 0 0
+				0xe5 0 0 0
+				0xe6 0 0 0
+				0xe7 0 0 0>;
 		};
 
 		global-utilities@e0000 {	//global utilities block
@@ -350,8 +326,7 @@
 		reg = <0 0xffe08000 0 0x1000>;
 		bus-range = <0 255>;
 		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
+		interrupts = <24 2 0 0>;
 	};
 
 	pci1: pcie@ffe09000 {
@@ -363,8 +338,7 @@
 		reg = <0 0xffe09000 0 0x1000>;
 		bus-range = <0 255>;
 		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
+		interrupts = <25 2 0 0>;
 	};
 
 	pci2: pcie@ffe0a000 {
@@ -376,7 +350,6 @@
 		reg = <0 0xffe0a000 0 0x1000>;
 		bus-range = <0 255>;
 		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <26 2>;
+		interrupts = <26 2 0 0>;
 	};
 };
-- 
1.7.3.4

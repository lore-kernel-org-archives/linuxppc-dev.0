Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7D725B7237
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:14:31 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAGERvf031607
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:14:27 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 11/30] powerpc/85xx: Rework P1010RDB and P1010 device tree
Date: Thu, 10 Nov 2011 10:13:54 -0600
Message-Id: <1320941653-29797-12-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941653-29797-11-git-send-email-galak@kernel.crashing.org>
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

Moved to 4 cell interrupt nodes to deal with FSL timer and moved
interrupt-parent to root so we don't duplicate it per IP block.

During rework fixed:
* PCI interrupt map - wrong IRQs for PCI-0 controller
* SDHC interrupt sense was wrong

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi |  197 ++++++++++++++
 arch/powerpc/boot/dts/fsl/p1010si-pre.dtsi  |   64 +++++
 arch/powerpc/boot/dts/p1010rdb.dts          |  228 +----------------
 arch/powerpc/boot/dts/p1010rdb.dtsi         |  222 ++++++++++++++++
 arch/powerpc/boot/dts/p1010si.dtsi          |  374 ---------------------------
 5 files changed, 493 insertions(+), 592 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1010si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1010rdb.dtsi
 delete mode 100644 arch/powerpc/boot/dts/p1010si.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
new file mode 100644
index 0000000..75eb921
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
@@ -0,0 +1,197 @@
+/*
+ * P1010/P1014 Silicon/SoC Device Tree Source (post include)
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
+&ifc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	compatible = "fsl,ifc", "simple-bus";
+	interrupts = <16 2 0 0 19 2 0 0>;
+};
+
+/* controller at 0x9000 */
+&pci0 {
+	compatible = "fsl,p1010-pcie", "fsl,qoriq-pcie-v2.3", "fsl,qoriq-pcie-v2.2";
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
+	compatible = "fsl,p1010-pcie", "fsl,qoriq-pcie-v2.3", "fsl,qoriq-pcie-v2.2";
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
+	compatible = "fsl,p1010-immr", "simple-bus";
+	bus-frequency = <0>;		// Filled out by uboot.
+
+	ecm-law@0 {
+		compatible = "fsl,ecm-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <12>;
+	};
+
+	ecm@1000 {
+		compatible = "fsl,p1010-ecm", "fsl,ecm";
+		reg = <0x1000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
+	memory-controller@2000 {
+		compatible = "fsl,p1010-memory-controller";
+		reg = <0x2000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-i2c-0.dtsi"
+/include/ "pq3-i2c-1.dtsi"
+/include/ "pq3-duart-0.dtsi"
+/include/ "pq3-espi-0.dtsi"
+	spi0: spi@7000 {
+		fsl,espi-num-chipselects = <1>;
+	};
+
+/include/ "pq3-gpio-0.dtsi"
+/include/ "pq3-sata2-0.dtsi"
+/include/ "pq3-sata2-1.dtsi"
+
+	can0: can@1c000 {
+		compatible = "fsl,p1010-flexcan";
+		reg = <0x1c000 0x1000>;
+		interrupts = <48 0x2 0 0>;
+	};
+
+	can1: can@1d000 {
+		compatible = "fsl,p1010-flexcan";
+		reg = <0x1d000 0x1000>;
+		interrupts = <61 0x2 0 0>;
+	};
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,p1010-l2-cache-controller",
+				"fsl,p1014-l2-cache-controller";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>;	// 32 bytes
+		cache-size = <0x40000>; // L2,256K
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-dma-0.dtsi"
+/include/ "pq3-usb2-dr-0.dtsi"
+/include/ "pq3-esdhc-0.dtsi"
+	sdhc@2e000 {
+		fsl,sdhci-auto-cmd12;
+	};
+
+/include/ "pq3-mpic.dtsi"
+/include/ "pq3-mpic-timer-B.dtsi"
+
+/include/ "pq3-etsec2-0.dtsi"
+	enet0: ethernet@b0000 {
+		queue-group@b0000 {
+			fsl,rx-bit-map = <0xff>;
+			fsl,tx-bit-map = <0xff>;
+		};
+	};
+
+/include/ "pq3-etsec2-1.dtsi"
+	enet1: ethernet@b1000 {
+		queue-group@b1000 {
+			fsl,rx-bit-map = <0xff>;
+			fsl,tx-bit-map = <0xff>;
+		};
+	};
+
+/include/ "pq3-etsec2-2.dtsi"
+	enet2: ethernet@b2000 {
+		queue-group@b2000 {
+			fsl,rx-bit-map = <0xff>;
+			fsl,tx-bit-map = <0xff>;
+		};
+
+	};
+
+	global-utilities@e0000 {
+		compatible = "fsl,p1010-guts";
+		reg = <0xe0000 0x1000>;
+		fsl,has-rstcr;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/p1010si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-pre.dtsi
new file mode 100644
index 0000000..7354a8f
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p1010si-pre.dtsi
@@ -0,0 +1,64 @@
+/*
+ * P1010/P1014 Silicon/SoC Device Tree Source (pre include)
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
+	compatible = "fsl,P1010";
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
+		can0 = &can0;
+		can1 = &can1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,P1010@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1010rdb.dts b/arch/powerpc/boot/dts/p1010rdb.dts
index d6c669c..b868d22 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dts
+++ b/arch/powerpc/boot/dts/p1010rdb.dts
@@ -9,230 +9,33 @@
  * option) any later version.
  */
 
-/include/ "p1010si.dtsi"
+/include/ "fsl/p1010si-pre.dtsi"
 
 / {
 	model = "fsl,P1010RDB";
 	compatible = "fsl,P1010RDB";
 
-	aliases {
-		serial0 = &serial0;
-		serial1 = &serial1;
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		pci0 = &pci0;
-		pci1 = &pci1;
-		can0 = &can0;
-		can1 = &can1;
-	};
-
 	memory {
 		device_type = "memory";
 	};
 
-	ifc@ffe1e000 {
+	board_ifc: ifc: ifc@ffe1e000 {
 		/* NOR, NAND Flashes and CPLD on board */
 		ranges = <0x0 0x0 0x0 0xee000000 0x02000000
 			  0x1 0x0 0x0 0xff800000 0x00010000
 			  0x3 0x0 0x0 0xffb00000 0x00000020>;
-
-		nor@0,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "cfi-flash";
-			reg = <0x0 0x0 0x2000000>;
-			bank-width = <2>;
-			device-width = <1>;
-
-			partition@40000 {
-				/* 256KB for DTB Image */
-				reg = <0x00040000 0x00040000>;
-				label = "NOR DTB Image";
-			};
-
-			partition@80000 {
-				/* 7 MB for Linux Kernel Image */
-				reg = <0x00080000 0x00700000>;
-				label = "NOR Linux Kernel Image";
-			};
-
-			partition@800000 {
-				/* 20MB for JFFS2 based Root file System */
-				reg = <0x00800000 0x01400000>;
-				label = "NOR JFFS2 Root File System";
-			};
-
-			partition@1f00000 {
-				/* This location must not be altered  */
-				/* 512KB for u-boot Bootloader Image */
-				/* 512KB for u-boot Environment Variables */
-				reg = <0x01f00000 0x00100000>;
-				label = "NOR U-Boot Image";
-				read-only;
-			};
-		};
-
-		nand@1,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,ifc-nand";
-			reg = <0x1 0x0 0x10000>;
-
-			partition@0 {
-				/* This location must not be altered  */
-				/* 1MB for u-boot Bootloader Image */
-				reg = <0x0 0x00100000>;
-				label = "NAND U-Boot Image";
-				read-only;
-			};
-
-			partition@100000 {
-				/* 1MB for DTB Image */
-				reg = <0x00100000 0x00100000>;
-				label = "NAND DTB Image";
-			};
-
-			partition@200000 {
-				/* 4MB for Linux Kernel Image */
-				reg = <0x00200000 0x00400000>;
-				label = "NAND Linux Kernel Image";
-			};
-
-			partition@600000 {
-				/* 4MB for Compressed Root file System Image */
-				reg = <0x00600000 0x00400000>;
-				label = "NAND Compressed RFS Image";
-			};
-
-			partition@a00000 {
-				/* 15MB for JFFS2 based Root file System */
-				reg = <0x00a00000 0x00f00000>;
-				label = "NAND JFFS2 Root File System";
-			};
-
-			partition@1900000 {
-				/* 7MB for User Area */
-				reg = <0x01900000 0x00700000>;
-				label = "NAND User area";
-			};
-		};
-
-		cpld@3,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,p1010rdb-cpld";
-			reg = <0x3 0x0 0x0000020>;
-			bank-width = <1>;
-			device-width = <1>;
-		};
+		reg = <0x0 0xffe1e000 0 0x2000>;
 	};
 
-	soc@ffe00000 {
-		spi@7000 {
-			flash@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "spansion,s25sl12801";
-				reg = <0>;
-				spi-max-frequency = <50000000>;
-
-				partition@0 {
-					/* 1MB for u-boot Bootloader Image */
-					/* 1MB for Environment */
-					reg = <0x0 0x00100000>;
-					label = "SPI Flash U-Boot Image";
-					read-only;
-				};
-
-				partition@100000 {
-					/* 512KB for DTB Image */
-					reg = <0x00100000 0x00080000>;
-					label = "SPI Flash DTB Image";
-				};
-
-				partition@180000 {
-					/* 4MB for Linux Kernel Image */
-					reg = <0x00180000 0x00400000>;
-					label = "SPI Flash Linux Kernel Image";
-				};
-
-				partition@580000 {
-					/* 4MB for Compressed RFS Image */
-					reg = <0x00580000 0x00400000>;
-					label = "SPI Flash Compressed RFSImage";
-				};
-
-				partition@980000 {
-					/* 6.5MB for JFFS2 based RFS */
-					reg = <0x00980000 0x00680000>;
-					label = "SPI Flash JFFS2 RFS";
-				};
-			};
-		};
-
-		usb@22000 {
-			phy_type = "utmi";
-		};
-
-		mdio@24000 {
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <3 1>;
-				reg = <0x1>;
-			};
-
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <2 1>;
-				reg = <0x0>;
-			};
-
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <2 1>;
-				reg = <0x2>;
-			};
-		};
-
-		enet0: ethernet@b0000 {
-			phy-handle = <&phy0>;
-			phy-connection-type = "rgmii-id";
-		};
-
-		enet1: ethernet@b1000 {
-			phy-handle = <&phy1>;
-			tbi-handle = <&tbi0>;
-			phy-connection-type = "sgmii";
-		};
-
-		enet2: ethernet@b2000 {
-			phy-handle = <&phy2>;
-			tbi-handle = <&tbi1>;
-			phy-connection-type = "sgmii";
-		};
+	board_soc: soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
 	};
 
 	pci0: pcie@ffe09000 {
+		reg = <0 0xffe09000 0 0x1000>;
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-			interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x4 0x1
-			0000 0x0 0x0 0x2 &mpic 0x5 0x1
-			0000 0x0 0x0 0x3 &mpic 0x6 0x1
-			0000 0x0 0x0 0x4 &mpic 0x7 0x1
-			>;
-
 			ranges = <0x2000000 0x0 0xa0000000
 				  0x2000000 0x0 0xa0000000
 				  0x0 0x20000000
@@ -244,24 +47,10 @@
 	};
 
 	pci1: pcie@ffe0a000 {
+		reg = <0 0xffe0a000 0 0x1000>;
 		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-			interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x4 0x1
-			0000 0x0 0x0 0x2 &mpic 0x5 0x1
-			0000 0x0 0x0 0x3 &mpic 0x6 0x1
-			0000 0x0 0x0 0x4 &mpic 0x7 0x1
-			>;
 			ranges = <0x2000000 0x0 0x80000000
 				  0x2000000 0x0 0x80000000
 				  0x0 0x20000000
@@ -272,3 +61,6 @@
 		};
 	};
 };
+
+/include/ "p1010rdb.dtsi"
+/include/ "fsl/p1010si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
new file mode 100644
index 0000000..149d196
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -0,0 +1,222 @@
+/*
+ * P1010 RDB Device Tree Source stub (no addresses or top-level ranges)
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
+&board_ifc {
+	nor@0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x2000000>;
+		bank-width = <2>;
+		device-width = <1>;
+
+		partition@40000 {
+			/* 256KB for DTB Image */
+			reg = <0x00040000 0x00040000>;
+			label = "NOR DTB Image";
+		};
+
+		partition@80000 {
+			/* 7 MB for Linux Kernel Image */
+			reg = <0x00080000 0x00700000>;
+			label = "NOR Linux Kernel Image";
+		};
+
+		partition@800000 {
+			/* 20MB for JFFS2 based Root file System */
+			reg = <0x00800000 0x01400000>;
+			label = "NOR JFFS2 Root File System";
+		};
+
+		partition@1f00000 {
+			/* This location must not be altered  */
+			/* 512KB for u-boot Bootloader Image */
+			/* 512KB for u-boot Environment Variables */
+			reg = <0x01f00000 0x00100000>;
+			label = "NOR U-Boot Image";
+			read-only;
+		};
+	};
+
+	nand@1,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,ifc-nand";
+		reg = <0x1 0x0 0x10000>;
+
+		partition@0 {
+			/* This location must not be altered  */
+			/* 1MB for u-boot Bootloader Image */
+			reg = <0x0 0x00100000>;
+			label = "NAND U-Boot Image";
+			read-only;
+		};
+
+		partition@100000 {
+			/* 1MB for DTB Image */
+			reg = <0x00100000 0x00100000>;
+			label = "NAND DTB Image";
+		};
+
+		partition@200000 {
+			/* 4MB for Linux Kernel Image */
+			reg = <0x00200000 0x00400000>;
+			label = "NAND Linux Kernel Image";
+		};
+
+		partition@600000 {
+			/* 4MB for Compressed Root file System Image */
+			reg = <0x00600000 0x00400000>;
+			label = "NAND Compressed RFS Image";
+		};
+
+		partition@a00000 {
+			/* 15MB for JFFS2 based Root file System */
+			reg = <0x00a00000 0x00f00000>;
+			label = "NAND JFFS2 Root File System";
+		};
+
+		partition@1900000 {
+			/* 7MB for User Area */
+			reg = <0x01900000 0x00700000>;
+			label = "NAND User area";
+		};
+	};
+
+	cpld@3,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,p1010rdb-cpld";
+		reg = <0x3 0x0 0x0000020>;
+		bank-width = <1>;
+		device-width = <1>;
+	};
+};
+
+&board_soc {
+	spi@7000 {
+		flash@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "spansion,s25sl12801";
+			reg = <0>;
+			spi-max-frequency = <50000000>;
+
+			partition@0 {
+				/* 1MB for u-boot Bootloader Image */
+				/* 1MB for Environment */
+				reg = <0x0 0x00100000>;
+				label = "SPI Flash U-Boot Image";
+				read-only;
+			};
+
+			partition@100000 {
+				/* 512KB for DTB Image */
+				reg = <0x00100000 0x00080000>;
+				label = "SPI Flash DTB Image";
+			};
+
+			partition@180000 {
+				/* 4MB for Linux Kernel Image */
+				reg = <0x00180000 0x00400000>;
+				label = "SPI Flash Linux Kernel Image";
+			};
+
+			partition@580000 {
+				/* 4MB for Compressed RFS Image */
+				reg = <0x00580000 0x00400000>;
+				label = "SPI Flash Compressed RFSImage";
+			};
+
+			partition@980000 {
+				/* 6.5MB for JFFS2 based RFS */
+				reg = <0x00980000 0x00680000>;
+				label = "SPI Flash JFFS2 RFS";
+			};
+		};
+	};
+
+	usb@22000 {
+		phy_type = "utmi";
+		dr_mode = "host";
+	};
+
+	mdio@24000 {
+		phy0: ethernet-phy@0 {
+			interrupts = <3 1 0 0>;
+			reg = <0x1>;
+		};
+
+		phy1: ethernet-phy@1 {
+			interrupts = <2 1 0 0>;
+			reg = <0x0>;
+		};
+
+		phy2: ethernet-phy@2 {
+			interrupts = <2 1 0 0>;
+			reg = <0x2>;
+		};
+	};
+
+	mdio@25000 {
+		tbi0: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	mdio@26000 {
+		tbi1: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	enet0: ethernet@b0000 {
+		phy-handle = <&phy0>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	enet1: ethernet@b1000 {
+		phy-handle = <&phy1>;
+		tbi-handle = <&tbi0>;
+		phy-connection-type = "sgmii";
+	};
+
+	enet2: ethernet@b2000 {
+		phy-handle = <&phy2>;
+		tbi-handle = <&tbi1>;
+		phy-connection-type = "sgmii";
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1010si.dtsi b/arch/powerpc/boot/dts/p1010si.dtsi
deleted file mode 100644
index cabe0a4..0000000
--- a/arch/powerpc/boot/dts/p1010si.dtsi
+++ /dev/null
@@ -1,374 +0,0 @@
-/*
- * P1010si Device Tree Source
- *
- * Copyright 2011 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-/dts-v1/;
-/ {
-	compatible = "fsl,P1010";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,P1010@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			next-level-cache = <&L2>;
-		};
-	};
-
-	ifc@ffe1e000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,ifc", "simple-bus";
-		reg = <0x0 0xffe1e000 0 0x2000>;
-		interrupts = <16 2 19 2>;
-		interrupt-parent = <&mpic>;
-	};
-
-	soc@ffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "fsl,p1010-immr", "simple-bus";
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
-			compatible = "fsl,p1010-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <16 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,p1010-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
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
-		spi@7000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,mpc8536-espi";
-			reg = <0x7000 0x1000>;
-			interrupts = <59 0x2>;
-			interrupt-parent = <&mpic>;
-			fsl,espi-num-chipselects = <1>;
-		};
-
-		gpio: gpio-controller@f000 {
-			#gpio-cells = <2>;
-			compatible = "fsl,mpc8572-gpio";
-			reg = <0xf000 0x100>;
-			interrupts = <47 0x2>;
-			interrupt-parent = <&mpic>;
-			gpio-controller;
-		};
-
-		sata@18000 {
-			compatible = "fsl,pq-sata-v2";
-			reg = <0x18000 0x1000>;
-			cell-index = <1>;
-			interrupts = <74 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		sata@19000 {
-			compatible = "fsl,pq-sata-v2";
-			reg = <0x19000 0x1000>;
-			cell-index = <2>;
-			interrupts = <41 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		can0: can@1c000 {
-			compatible = "fsl,p1010-flexcan";
-			reg = <0x1c000 0x1000>;
-			interrupts = <48 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		can1: can@1d000 {
-			compatible = "fsl,p1010-flexcan";
-			reg = <0x1d000 0x1000>;
-			interrupts = <61 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,p1010-l2-cache-controller",
-					"fsl,p1014-l2-cache-controller";
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
-			compatible = "fsl,p1010-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,p1010-dma-channel", "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,p1010-dma-channel", "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,p1010-dma-channel", "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,p1010-dma-channel", "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
-		usb@22000 {
-			compatible = "fsl-usb2-dr";
-			reg = <0x22000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupt-parent = <&mpic>;
-			interrupts = <28 0x2>;
-			dr_mode = "host";
-		};
-
-		mdio@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,etsec2-mdio";
-			reg = <0x24000 0x1000 0xb0030 0x4>;
-		};
-
-		mdio@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,etsec2-tbi";
-			reg = <0x25000 0x1000 0xb1030 0x4>;
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@26000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,etsec2-tbi";
-			reg = <0x26000 0x1000 0xb1030 0x4>;
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		sdhci@2e000 {
-			compatible = "fsl,esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <72 0x8>;
-			interrupt-parent = <&mpic>;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
-			fsl,sdhci-auto-cmd12;
-		};
-
-		enet0: ethernet@b0000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "fsl,etsec2";
-			fsl,num_rx_queues = <0x8>;
-			fsl,num_tx_queues = <0x8>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupt-parent = <&mpic>;
-
-			queue-group@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xb0000 0x1000>;
-				fsl,rx-bit-map = <0xff>;
-				fsl,tx-bit-map = <0xff>;
-				interrupts = <29 2 30 2 34 2>;
-			};
-
-		};
-
-		enet1: ethernet@b1000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "fsl,etsec2";
-			fsl,num_rx_queues = <0x8>;
-			fsl,num_tx_queues = <0x8>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupt-parent = <&mpic>;
-
-			queue-group@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xb1000 0x1000>;
-				fsl,rx-bit-map = <0xff>;
-				fsl,tx-bit-map = <0xff>;
-				interrupts = <35 2 36 2 40 2>;
-			};
-
-		};
-
-		enet2: ethernet@b2000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "fsl,etsec2";
-			fsl,num_rx_queues = <0x8>;
-			fsl,num_tx_queues = <0x8>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupt-parent = <&mpic>;
-
-			queue-group@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xb2000 0x1000>;
-				fsl,rx-bit-map = <0xff>;
-				fsl,tx-bit-map = <0xff>;
-				interrupts = <31 2 32 2 33 2>;
-			};
-
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
-			compatible = "fsl,p1010-msi", "fsl,mpic-msi";
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
-			compatible = "fsl,p1010-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-	};
-
-	pci0: pcie@ffe09000 {
-		compatible = "fsl,p1010-pcie", "fsl,qoriq-pcie-v2.3", "fsl,qoriq-pcie-v2.2";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe09000 0 0x1000>;
-		bus-range = <0 255>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
-	};
-
-	pci1: pcie@ffe0a000 {
-		compatible = "fsl,p1010-pcie", "fsl,qoriq-pcie-v2.3", "fsl,qoriq-pcie-v2.2";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe0a000 0 0x1000>;
-		bus-range = <0 255>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
-	};
-};
-- 
1.7.3.4

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1B7DEB7508
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 18:16:34 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAH7GUDe026573
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 01:16:31 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/29] powerpc/85xx: Rework MPC8548CDS device trees
Date: Thu, 17 Nov 2011 01:16:02 -0600
Message-Id: <1321514181-28897-10-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1321514181-28897-9-git-send-email-galak@kernel.crashing.org>
References: <1321514181-28897-1-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-2-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-3-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-4-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-5-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-6-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-7-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-8-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-9-git-send-email-galak@kernel.crashing.org>
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
* Moved mdio nodes up one level instead of under tsec nodes
* Reworked PCIe nodes to allow supportin IRQs for controller (errors)
  and moved PCI device IRQs down to virtual bridge level
* Removed CPU properties setup by u-boot to match other .dts
* Added localbus node, but no chipselect details at this point
* Added MPIC / PCIe msi node
* Dropping "fsl,mpc8548-IP..." from compatibles for standard blocks

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi |  143 +++++++
 arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi  |   62 +++
 arch/powerpc/boot/dts/mpc8548cds.dts          |  505 ++++++-------------------
 3 files changed, 327 insertions(+), 383 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
new file mode 100644
index 0000000..9d8023a
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
@@ -0,0 +1,143 @@
+/*
+ * MPC8548 Silicon/SoC Device Tree Source (post include)
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
+	compatible = "fsl,mpc8548-lbc", "fsl,pq3-localbus", "simple-bus";
+	interrupts = <19 2 0 0>;
+};
+
+/* controller at 0x8000 */
+&pci0 {
+	compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+	device_type = "pci";
+	interrupts = <24 0x2 0 0>;
+	bus-range = <0 0xff>;
+	#interrupt-cells = <1>;
+	#size-cells = <2>;
+	#address-cells = <3>;
+};
+
+/* controller at 0x9000 */
+&pci1 {
+	compatible = "fsl,mpc8540-pci";
+	device_type = "pci";
+	interrupts = <25 0x2 0 0>;
+	bus-range = <0 0xff>;
+	#interrupt-cells = <1>;
+	#size-cells = <2>;
+	#address-cells = <3>;
+};
+
+/* controller at 0xa000 */
+&pci2 {
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
+&soc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "soc";
+	compatible = "fsl,mpc8548-immr", "simple-bus";
+	bus-frequency = <0>;		// Filled out by uboot.
+
+	ecm-law@0 {
+		compatible = "fsl,ecm-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <10>;
+	};
+
+	ecm@1000 {
+		compatible = "fsl,mpc8548-ecm", "fsl,ecm";
+		reg = <0x1000 0x1000>;
+		interrupts = <17 2 0 0>;
+	};
+
+	memory-controller@2000 {
+		compatible = "fsl,mpc8548-memory-controller";
+		reg = <0x2000 0x1000>;
+		interrupts = <18 2 0 0>;
+	};
+
+/include/ "pq3-i2c-0.dtsi"
+/include/ "pq3-i2c-1.dtsi"
+/include/ "pq3-duart-0.dtsi"
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,mpc8548-l2-cache-controller";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>;	// 32 bytes
+		cache-size = <0x80000>; // L2, 512K
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-dma-0.dtsi"
+/include/ "pq3-etsec1-0.dtsi"
+/include/ "pq3-etsec1-1.dtsi"
+/include/ "pq3-etsec1-2.dtsi"
+/include/ "pq3-etsec1-3.dtsi"
+
+/include/ "pq3-sec2.1-0.dtsi"
+/include/ "pq3-mpic.dtsi"
+
+	global-utilities@e0000 {
+		compatible = "fsl,mpc8548-guts";
+		reg = <0xe0000 0x1000>;
+		fsl,has-rstcr;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi
new file mode 100644
index 0000000..289f121
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi
@@ -0,0 +1,62 @@
+/*
+ * MPC8548 Silicon/SoC Device Tree Source (pre include)
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
+	compatible = "fsl,MPC8548";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		ethernet0 = &enet0;
+		ethernet1 = &enet2;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8548@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index a17a557..07b8dae 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -9,13 +9,11 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "fsl/mpc8548si-pre.dtsi"
 
 / {
 	model = "MPC8548CDS";
 	compatible = "MPC8548CDS", "MPC85xxCDS";
-	#address-cells = <1>;
-	#size-cells = <1>;
 
 	aliases {
 		ethernet0 = &enet0;
@@ -29,76 +27,19 @@
 		pci2 = &pci2;
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8548@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <0x8000>;		// L1, 32K
-			i-cache-size = <0x8000>;		// L1, 32K
-			timebase-frequency = <0>;	//  33 MHz, from uboot
-			bus-frequency = <0>;	// 166 MHz
-			clock-frequency = <0>;	// 825 MHz, from uboot
-			next-level-cache = <&L2>;
-		};
-	};
-
 	memory {
 		device_type = "memory";
-		reg = <0x0 0x8000000>;	// 128M at 0x0
+		reg = <0 0 0x0 0x8000000>;	// 128M at 0x0
 	};
 
-	soc8548@e0000000 {
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
-			compatible = "fsl,mpc8548-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,mpc8548-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-		};
+	lbc: localbus@e0005000 {
+		reg = <0 0xe0005000 0 0x1000>;
+	};
 
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,mpc8548-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>;	// 32 bytes
-			cache-size = <0x80000>;	// L2, 512K
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-		};
+	soc: soc8548@e0000000 {
+		ranges = <0 0x0 0xe0000000 0x100000>;
 
 		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-
 			eeprom@50 {
 				compatible = "atmel,24c64";
 				reg = <0x50>;
@@ -116,351 +57,178 @@
 		};
 
 		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-
 			eeprom@50 {
 				compatible = "atmel,24c64";
 				reg = <0x50>;
 			};
 		};
 
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8548-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8548-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8548-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8548-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8548-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
 		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30 2 34 2>;
-			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
+		};
 
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&mpic>;
-					interrupts = <5 1>;
-					reg = <0x0>;
-					device_type = "ethernet-phy";
-				};
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <5 1>;
-					reg = <0x1>;
-					device_type = "ethernet-phy";
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&mpic>;
-					interrupts = <5 1>;
-					reg = <0x2>;
-					device_type = "ethernet-phy";
-				};
-				phy3: ethernet-phy@3 {
-					interrupt-parent = <&mpic>;
-					interrupts = <5 1>;
-					reg = <0x3>;
-					device_type = "ethernet-phy";
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+		mdio@24520 {
+			phy0: ethernet-phy@0 {
+				interrupts = <5 1 0 0>;
+				reg = <0x0>;
+				device_type = "ethernet-phy";
+			};
+			phy1: ethernet-phy@1 {
+				interrupts = <5 1 0 0>;
+				reg = <0x1>;
+				device_type = "ethernet-phy";
+			};
+			phy2: ethernet-phy@2 {
+				interrupts = <5 1 0 0>;
+				reg = <0x2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupts = <5 1 0 0>;
+				reg = <0x3>;
+				device_type = "ethernet-phy";
+			};
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
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
+		};
 
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
+		mdio@25520 {
+			tbi1: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet2: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
+		};
 
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+		mdio@26520 {
+			tbi2: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet3: ethernet@27000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <3>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x27000 0x1000>;
-			ranges = <0x0 0x27000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <37 2 38 2 39 2>;
-			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi3>;
 			phy-handle = <&phy3>;
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi3: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4500 0x100>;	// reg base, size
-			clock-frequency = <0>;	// should we fill in in uboot?
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4600 0x100>;	// reg base, size
-			clock-frequency = <0>;	// should we fill in in uboot?
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
 		};
 
-		global-utilities@e0000 {	//global utilities reg
-			compatible = "fsl,mpc8548-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
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
-		};
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
+		mdio@27520 {
+			tbi3: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 	};
 
 	pci0: pci@e0008000 {
+		reg = <0 0xe0008000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x10000000
+			  0x1000000 0x0 0x00000000 0 0xe2000000 0x0 0x800000>;
+		clock-frequency = <66666666>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			/* IDSEL 0x4 (PCIX Slot 2) */
-			0x2000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0x2000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0x2000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0x2000 0x0 0x0 0x4 &mpic 0x3 0x1
+			0x2000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+			0x2000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+			0x2000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+			0x2000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
 
 			/* IDSEL 0x5 (PCIX Slot 3) */
-			0x2800 0x0 0x0 0x1 &mpic 0x1 0x1
-			0x2800 0x0 0x0 0x2 &mpic 0x2 0x1
-			0x2800 0x0 0x0 0x3 &mpic 0x3 0x1
-			0x2800 0x0 0x0 0x4 &mpic 0x0 0x1
+			0x2800 0x0 0x0 0x1 &mpic 0x1 0x1 0 0
+			0x2800 0x0 0x0 0x2 &mpic 0x2 0x1 0 0
+			0x2800 0x0 0x0 0x3 &mpic 0x3 0x1 0 0
+			0x2800 0x0 0x0 0x4 &mpic 0x0 0x1 0 0
 
 			/* IDSEL 0x6 (PCIX Slot 4) */
-			0x3000 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x3000 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x3000 0x0 0x0 0x3 &mpic 0x0 0x1
-			0x3000 0x0 0x0 0x4 &mpic 0x1 0x1
+			0x3000 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+			0x3000 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+			0x3000 0x0 0x0 0x3 &mpic 0x0 0x1 0 0
+			0x3000 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
 
 			/* IDSEL 0x8 (PCIX Slot 5) */
-			0x4000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0x4000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0x4000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0x4000 0x0 0x0 0x4 &mpic 0x3 0x1
+			0x4000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+			0x4000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+			0x4000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+			0x4000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
 
 			/* IDSEL 0xC (Tsi310 bridge) */
-			0x6000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0x6000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0x6000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0x6000 0x0 0x0 0x4 &mpic 0x3 0x1
+			0x6000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+			0x6000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+			0x6000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+			0x6000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
 
 			/* IDSEL 0x14 (Slot 2) */
-			0xa000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0xa000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0xa000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0xa000 0x0 0x0 0x4 &mpic 0x3 0x1
+			0xa000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+			0xa000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+			0xa000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+			0xa000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
 
 			/* IDSEL 0x15 (Slot 3) */
-			0xa800 0x0 0x0 0x1 &mpic 0x1 0x1
-			0xa800 0x0 0x0 0x2 &mpic 0x2 0x1
-			0xa800 0x0 0x0 0x3 &mpic 0x3 0x1
-			0xa800 0x0 0x0 0x4 &mpic 0x0 0x1
+			0xa800 0x0 0x0 0x1 &mpic 0x1 0x1 0 0
+			0xa800 0x0 0x0 0x2 &mpic 0x2 0x1 0 0
+			0xa800 0x0 0x0 0x3 &mpic 0x3 0x1 0 0
+			0xa800 0x0 0x0 0x4 &mpic 0x0 0x1 0 0
 
 			/* IDSEL 0x16 (Slot 4) */
-			0xb000 0x0 0x0 0x1 &mpic 0x2 0x1
-			0xb000 0x0 0x0 0x2 &mpic 0x3 0x1
-			0xb000 0x0 0x0 0x3 &mpic 0x0 0x1
-			0xb000 0x0 0x0 0x4 &mpic 0x1 0x1
+			0xb000 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+			0xb000 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+			0xb000 0x0 0x0 0x3 &mpic 0x0 0x1 0 0
+			0xb000 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
 
 			/* IDSEL 0x18 (Slot 5) */
-			0xc000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0xc000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0xc000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0xc000 0x0 0x0 0x4 &mpic 0x3 0x1
+			0xc000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+			0xc000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+			0xc000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+			0xc000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
 
 			/* IDSEL 0x1C (Tsi310 bridge PCI primary) */
-			0xe000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0xe000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0xe000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0xe000 0x0 0x0 0x4 &mpic 0x3 0x1>;
-
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
-		bus-range = <0 0>;
-		ranges = <0x2000000 0x0 0x80000000 0x80000000 0x0 0x10000000
-			  0x1000000 0x0 0x0 0xe2000000 0x0 0x800000>;
-		clock-frequency = <66666666>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xe0008000 0x1000>;
-		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
-		device_type = "pci";
+			0xe000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+			0xe000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+			0xe000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+			0xe000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0>;
 
 		pci_bridge@1c {
 			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 			interrupt-map = <
 
 				/* IDSEL 0x00 (PrPMC Site) */
-				0000 0x0 0x0 0x1 &mpic 0x0 0x1
-				0000 0x0 0x0 0x2 &mpic 0x1 0x1
-				0000 0x0 0x0 0x3 &mpic 0x2 0x1
-				0000 0x0 0x0 0x4 &mpic 0x3 0x1
+				0000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+				0000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+				0000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+				0000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
 
 				/* IDSEL 0x04 (VIA chip) */
-				0x2000 0x0 0x0 0x1 &mpic 0x0 0x1
-				0x2000 0x0 0x0 0x2 &mpic 0x1 0x1
-				0x2000 0x0 0x0 0x3 &mpic 0x2 0x1
-				0x2000 0x0 0x0 0x4 &mpic 0x3 0x1
+				0x2000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+				0x2000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+				0x2000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+				0x2000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
 
 				/* IDSEL 0x05 (8139) */
-				0x2800 0x0 0x0 0x1 &mpic 0x1 0x1
+				0x2800 0x0 0x0 0x1 &mpic 0x1 0x1 0 0
 
 				/* IDSEL 0x06 (Slot 6) */
-				0x3000 0x0 0x0 0x1 &mpic 0x2 0x1
-				0x3000 0x0 0x0 0x2 &mpic 0x3 0x1
-				0x3000 0x0 0x0 0x3 &mpic 0x0 0x1
-				0x3000 0x0 0x0 0x4 &mpic 0x1 0x1
+				0x3000 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+				0x3000 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+				0x3000 0x0 0x0 0x3 &mpic 0x0 0x1 0 0
+				0x3000 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
 
 				/* IDESL 0x07 (Slot 7) */
-				0x3800 0x0 0x0 0x1 &mpic 0x3 0x1
-				0x3800 0x0 0x0 0x2 &mpic 0x0 0x1
-				0x3800 0x0 0x0 0x3 &mpic 0x1 0x1
-				0x3800 0x0 0x0 0x4 &mpic 0x2 0x1>;
+				0x3800 0x0 0x0 0x1 &mpic 0x3 0x1 0 0
+				0x3800 0x0 0x0 0x2 &mpic 0x0 0x1 0 0
+				0x3800 0x0 0x0 0x3 &mpic 0x1 0x1 0 0
+				0x3800 0x0 0x0 0x4 &mpic 0x2 0x1 0 0>;
 
 			reg = <0xe000 0x0 0x0 0x0 0x0>;
 			#interrupt-cells = <1>;
@@ -492,7 +260,7 @@
 					#address-cells = <0>;
 					#interrupt-cells = <2>;
 					compatible = "chrp,iic";
-					interrupts = <0 1>;
+					interrupts = <0 1 0 0>;
 					interrupt-parent = <&mpic>;
 				};
 
@@ -505,56 +273,25 @@
 	};
 
 	pci1: pci@e0009000 {
+		reg = <0 0xe0009000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x90000000 0 0x90000000 0x0 0x10000000
+			  0x1000000 0x0 0x00000000 0 0xe2800000 0x0 0x800000>;
+		clock-frequency = <66666666>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 
 			/* IDSEL 0x15 */
-			0xa800 0x0 0x0 0x1 &mpic 0xb 0x1
-			0xa800 0x0 0x0 0x2 &mpic 0x1 0x1
-			0xa800 0x0 0x0 0x3 &mpic 0x2 0x1
-			0xa800 0x0 0x0 0x4 &mpic 0x3 0x1>;
-
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
-		bus-range = <0 0>;
-		ranges = <0x2000000 0x0 0x90000000 0x90000000 0x0 0x10000000
-			  0x1000000 0x0 0x0 0xe2800000 0x0 0x800000>;
-		clock-frequency = <66666666>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xe0009000 0x1000>;
-		compatible = "fsl,mpc8540-pci";
-		device_type = "pci";
+			0xa800 0x0 0x0 0x1 &mpic 0xb 0x1 0 0
+			0xa800 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+			0xa800 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+			0xa800 0x0 0x0 0x4 &mpic 0x3 0x1 0 0>;
 	};
 
 	pci2: pcie@e000a000 {
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
-		ranges = <0x2000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
-			  0x1000000 0x0 0x0 0xe3000000 0x0 0x100000>;
-		clock-frequency = <33333333>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xe000a000 0x1000>;
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
+		reg = <0 0xe000a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xe3000000 0x0 0x100000>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xa0000000
 				  0x2000000 0x0 0xa0000000
 				  0x0 0x20000000
@@ -565,3 +302,5 @@
 		};
 	};
 };
+
+/include/ "fsl/mpc8548si-post.dtsi"
-- 
1.7.3.4

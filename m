Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C63BC100BB2
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:14:50 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAGEkp6031835
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:14:47 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 19/30] powerpc/85xx: Rework MPC8572DS device tree
Date: Thu, 10 Nov 2011 10:14:02 -0600
Message-Id: <1320941653-29797-20-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941653-29797-19-git-send-email-galak@kernel.crashing.org>
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
 <1320941653-29797-19-git-send-email-galak@kernel.crashing.org>
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
 arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi  |  196 ++++++
 arch/powerpc/boot/dts/fsl/mpc8572si-pre.dtsi   |   70 +++
 arch/powerpc/boot/dts/mpc8572ds.dts            |  757 +-----------------------
 arch/powerpc/boot/dts/mpc8572ds.dtsi           |  397 +++++++++++++
 arch/powerpc/boot/dts/mpc8572ds_36b.dts        |  746 +-----------------------
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |  487 +--------------
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |  245 +++------
 7 files changed, 788 insertions(+), 2110 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8572si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/mpc8572ds.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
new file mode 100644
index 0000000..d44e25a
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
@@ -0,0 +1,196 @@
+/*
+ * MPC8572 Silicon/SoC Device Tree Source (post include)
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
+	compatible = "fsl,mpc8572-elbc", "fsl,elbc", "simple-bus";
+	interrupts = <19 2 0 0>;
+};
+
+/* controller at 0x8000 */
+&pci0 {
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
+	compatible = "fsl,mpc8572-immr", "simple-bus";
+	bus-frequency = <0>;		// Filled out by uboot.
+
+	ecm-law@0 {
+		compatible = "fsl,ecm-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <12>;
+	};
+
+	ecm@1000 {
+		compatible = "fsl,mpc8572-ecm", "fsl,ecm";
+		reg = <0x1000 0x1000>;
+		interrupts = <17 2 0 0>;
+	};
+
+	memory-controller@2000 {
+		compatible = "fsl,mpc8572-memory-controller";
+		reg = <0x2000 0x1000>;
+		interrupts = <18 2 0 0>;
+	};
+
+	memory-controller@6000 {
+		compatible = "fsl,mpc8572-memory-controller";
+		reg = <0x6000 0x1000>;
+		interrupts = <18 2 0 0>;
+	};
+
+/include/ "pq3-i2c-0.dtsi"
+/include/ "pq3-i2c-1.dtsi"
+/include/ "pq3-duart-0.dtsi"
+/include/ "pq3-dma-1.dtsi"
+/include/ "pq3-gpio-0.dtsi"
+	gpio-controller@f000 {
+		compatible = "fsl,mpc8572-gpio", "fsl,pq3-gpio";
+	};
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,mpc8572-l2-cache-controller";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>;	// 32 bytes
+		cache-size = <0x100000>; // L2,1M
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-dma-0.dtsi"
+/include/ "pq3-etsec1-0.dtsi"
+/include/ "pq3-etsec1-timer-0.dtsi"
+
+	ptp_clock@24e00 {
+		interrupts = <68 2 0 0 69 2 0 0 70 2 0 0 71 2 0 0>;
+	};
+
+/include/ "pq3-etsec1-1.dtsi"
+/include/ "pq3-etsec1-2.dtsi"
+/include/ "pq3-etsec1-3.dtsi"
+/include/ "pq3-sec3.0-0.dtsi"
+/include/ "pq3-mpic.dtsi"
+/include/ "pq3-mpic-timer-B.dtsi"
+
+	global-utilities@e0000 {
+		compatible = "fsl,mpc8572-guts";
+		reg = <0xe0000 0x1000>;
+		fsl,has-rstcr;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/mpc8572si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8572si-pre.dtsi
new file mode 100644
index 0000000..ca18832
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8572si-pre.dtsi
@@ -0,0 +1,70 @@
+/*
+ * MPC8572 Silicon/SoC Device Tree Source (pre include)
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
+	compatible = "fsl,MPC8572";
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
+		pci2 = &pci2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8572@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,8572@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index f6c04d2..0c9f295 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -9,67 +9,18 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "fsl/mpc8572si-pre.dtsi"
+
 / {
 	model = "fsl,MPC8572DS";
 	compatible = "fsl,MPC8572DS";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		ethernet3 = &enet3;
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
-		PowerPC,8572@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <0x8000>;		// L1, 32K
-			i-cache-size = <0x8000>;		// L1, 32K
-			timebase-frequency = <0>;
-			bus-frequency = <0>;
-			clock-frequency = <0>;
-			next-level-cache = <&L2>;
-		};
-
-		PowerPC,8572@1 {
-			device_type = "cpu";
-			reg = <0x1>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <0x8000>;		// L1, 32K
-			i-cache-size = <0x8000>;		// L1, 32K
-			timebase-frequency = <0>;
-			bus-frequency = <0>;
-			clock-frequency = <0>;
-			next-level-cache = <&L2>;
-		};
-	};
 
 	memory {
 		device_type = "memory";
 	};
 
-	localbus@ffe05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8572-elbc", "fsl,elbc", "simple-bus";
+	board_lbc: lbc: localbus@ffe05000 {
 		reg = <0 0xffe05000 0 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
 
 		ranges = <0x0 0x0 0x0 0xe8000000 0x08000000
 			  0x1 0x0 0x0 0xe0000000 0x08000000
@@ -78,601 +29,17 @@
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
-			compatible = "fsl,mpc8572-fcm-nand",
-				     "fsl,elbc-fcm-nand";
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
-		nand@4,0 {
-			compatible = "fsl,mpc8572-fcm-nand",
-				     "fsl,elbc-fcm-nand";
-			reg = <0x4 0x0 0x40000>;
-		};
-
-		nand@5,0 {
-			compatible = "fsl,mpc8572-fcm-nand",
-				     "fsl,elbc-fcm-nand";
-			reg = <0x5 0x0 0x40000>;
-		};
-
-		nand@6,0 {
-			compatible = "fsl,mpc8572-fcm-nand",
-				     "fsl,elbc-fcm-nand";
-			reg = <0x6 0x0 0x40000>;
-		};
 	};
 
-	soc8572@ffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
+	board_soc: soc: soc8572@ffe00000 {
 		ranges = <0x0 0 0xffe00000 0x100000>;
-		bus-frequency = <0>;		// Filled out by uboot.
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <12>;
-		};
-
-		ecm@1000 {
-			compatible = "fsl,mpc8572-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,mpc8572-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-		};
-
-		memory-controller@6000 {
-			compatible = "fsl,mpc8572-memory-controller";
-			reg = <0x6000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,mpc8572-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>;	// 32 bytes
-			cache-size = <0x100000>; // L2, 1M
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
-		dma@c300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
-			reg = <0xc300 0x4>;
-			ranges = <0x0 0xc100 0x200>;
-			cell-index = <1>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <76 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <77 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <78 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <79 2>;
-			};
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
-		ptp_clock@24E00 {
-			compatible = "fsl,etsec-ptp";
-			reg = <0x24E00 0xB0>;
-			interrupts = <68 2 69 2 70 2 71 2>;
-			interrupt-parent = < &mpic >;
-			fsl,tclk-period = <5>;
-			fsl,tmr-prsc = <200>;
-			fsl,tmr-add = <0xAAAAAAAB>;
-			fsl,tmr-fiper1 = <0x3B9AC9FB>;
-			fsl,tmr-fiper2 = <0x3B9AC9FB>;
-			fsl,max-adj = <499999999>;
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
-			interrupts = <29 2 30 2 34 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0x0>;
-				};
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0x1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0x2>;
-				};
-				phy3: ethernet-phy@3 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0x3>;
-				};
-
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet1: ethernet@25000 {
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
-			tbi-handle = <&tbi1>;
-			phy-handle = <&phy1>;
-			phy-connection-type = "rgmii-id";
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
-		};
-
-		enet2: ethernet@26000 {
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
-			tbi-handle = <&tbi2>;
-			phy-handle = <&phy2>;
-			phy-connection-type = "rgmii-id";
-
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
-			};
-		};
-
-		enet3: ethernet@27000 {
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
-			tbi-handle = <&tbi3>;
-			phy-handle = <&phy3>;
-			phy-connection-type = "rgmii-id";
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
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,mpc8572-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-
-		msi@41600 {
-			compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
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
-		crypto@30000 {
-			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
-				     "fsl,sec2.1", "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <45 2 58 2>;
-			interrupt-parent = <&mpic>;
-			fsl,num-channels = <4>;
-			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0x9fe>;
-			fsl,descriptor-types-mask = <0x3ab0ebf>;
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
 	};
 
-	pci0: pcie@ffe08000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
+	board_pci0: pci0: pcie@ffe08000 {
 		reg = <0 0xffe08000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
-		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x11 func 0 - PCI slot 1 */
-			0x8800 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8800 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8800 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8800 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 1 - PCI slot 1 */
-			0x8900 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8900 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8900 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8900 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 2 - PCI slot 1 */
-			0x8a00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8a00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8a00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8a00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 3 - PCI slot 1 */
-			0x8b00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8b00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8b00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8b00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 4 - PCI slot 1 */
-			0x8c00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8c00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8c00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8c00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 5 - PCI slot 1 */
-			0x8d00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8d00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8d00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8d00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 6 - PCI slot 1 */
-			0x8e00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8e00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8e00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8e00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 7 - PCI slot 1 */
-			0x8f00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8f00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8f00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8f00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x12 func 0 - PCI slot 2 */
-			0x9000 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9000 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9000 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9000 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 1 - PCI slot 2 */
-			0x9100 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9100 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9100 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9100 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 2 - PCI slot 2 */
-			0x9200 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9200 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9200 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9200 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 3 - PCI slot 2 */
-			0x9300 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9300 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9300 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9300 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 4 - PCI slot 2 */
-			0x9400 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9400 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9400 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9400 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 5 - PCI slot 2 */
-			0x9500 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9500 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9500 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9500 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 6 - PCI slot 2 */
-			0x9600 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9600 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9600 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9600 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 7 - PCI slot 2 */
-			0x9700 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9700 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9700 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9700 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			// IDSEL 0x1c  USB
-			0xe000 0x0 0x0 0x1 &i8259 0xc 0x2
-			0xe100 0x0 0x0 0x2 &i8259 0x9 0x2
-			0xe200 0x0 0x0 0x3 &i8259 0xa 0x2
-			0xe300 0x0 0x0 0x4 &i8259 0xb 0x2
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
-
-			>;
-
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0x80000000
 				  0x2000000 0x0 0x80000000
 				  0x0 0x20000000
@@ -680,99 +47,14 @@
 				  0x1000000 0x0 0x0
 				  0x1000000 0x0 0x0
 				  0x0 0x10000>;
-			uli1575@0 {
-				reg = <0x0 0x0 0x0 0x0 0x0>;
-				#size-cells = <2>;
-				#address-cells = <3>;
-				ranges = <0x2000000 0x0 0x80000000
-					  0x2000000 0x0 0x80000000
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
-						interrupts = <9 2>;
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
 
 	pci1: pcie@ffe09000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0 0xffe09000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x4 0x1
-			0000 0x0 0x0 0x2 &mpic 0x5 0x1
-			0000 0x0 0x0 0x3 &mpic 0x6 0x1
-			0000 0x0 0x0 0x4 &mpic 0x7 0x1
-			>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xa0000000
 				  0x2000000 0x0 0xa0000000
 				  0x0 0x20000000
@@ -784,31 +66,10 @@
 	};
 
 	pci2: pcie@ffe0a000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0 0xffe0a000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <26 2>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0000 0x0 0x0 0x4 &mpic 0x3 0x1
-			>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xc0000000
 				  0x2000000 0x0 0xc0000000
 				  0x0 0x20000000
@@ -819,3 +80,11 @@
 		};
 	};
 };
+
+/*
+ * mpc8572ds.dtsi must be last to ensure board_pci0 overrides pci0 settings
+ * for interrupt-map & interrupt-map-mask
+ */
+
+/include/ "fsl/mpc8572si-post.dtsi"
+/include/ "mpc8572ds.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dtsi b/arch/powerpc/boot/dts/mpc8572ds.dtsi
new file mode 100644
index 0000000..c3d4fac
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8572ds.dtsi
@@ -0,0 +1,397 @@
+/*
+ * MPC8572DS Device Tree Source stub (no addresses or top-level ranges)
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
+		compatible = "fsl,mpc8572-fcm-nand",
+			     "fsl,elbc-fcm-nand";
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
+	nand@4,0 {
+		compatible = "fsl,mpc8572-fcm-nand",
+			     "fsl,elbc-fcm-nand";
+		reg = <0x4 0x0 0x40000>;
+	};
+
+	nand@5,0 {
+		compatible = "fsl,mpc8572-fcm-nand",
+			     "fsl,elbc-fcm-nand";
+		reg = <0x5 0x0 0x40000>;
+	};
+
+	nand@6,0 {
+		compatible = "fsl,mpc8572-fcm-nand",
+			     "fsl,elbc-fcm-nand";
+		reg = <0x6 0x0 0x40000>;
+	};
+};
+
+&board_soc {
+	enet0: ethernet@24000 {
+		tbi-handle = <&tbi0>;
+		phy-handle = <&phy0>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	mdio@24520 {
+		phy0: ethernet-phy@0 {
+			interrupts = <10 1 0 0>;
+			reg = <0x0>;
+		};
+		phy1: ethernet-phy@1 {
+			interrupts = <10 1 0 0>;
+			reg = <0x1>;
+		};
+		phy2: ethernet-phy@2 {
+			interrupts = <10 1 0 0>;
+			reg = <0x2>;
+		};
+		phy3: ethernet-phy@3 {
+			interrupts = <10 1 0 0>;
+			reg = <0x3>;
+		};
+
+		tbi0: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	ptp_clock@24e00 {
+		fsl,tclk-period = <5>;
+		fsl,tmr-prsc = <200>;
+		fsl,tmr-add = <0xAAAAAAAB>;
+		fsl,tmr-fiper1 = <0x3B9AC9FB>;
+		fsl,tmr-fiper2 = <0x3B9AC9FB>;
+		fsl,max-adj = <499999999>;
+	};
+
+	enet1: ethernet@25000 {
+		tbi-handle = <&tbi1>;
+		phy-handle = <&phy1>;
+		phy-connection-type = "rgmii-id";
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
+	enet2: ethernet@26000 {
+		tbi-handle = <&tbi2>;
+		phy-handle = <&phy2>;
+		phy-connection-type = "rgmii-id";
+
+	};
+	mdio@26520 {
+		tbi2: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	enet3: ethernet@27000 {
+		tbi-handle = <&tbi3>;
+		phy-handle = <&phy3>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	mdio@27520 {
+		tbi3: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+};
+
+&board_pci0 {
+	pcie@0 {
+		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x11 func 0 - PCI slot 1 */
+			0x8800 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+			0x8800 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+			0x8800 0x0 0x0 0x3 &mpic 0x4 0x1 0 0
+			0x8800 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
+
+			/* IDSEL 0x11 func 1 - PCI slot 1 */
+			0x8900 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+			0x8900 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+			0x8900 0x0 0x0 0x3 &mpic 0x4 0x1 0 0
+			0x8900 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
+
+			/* IDSEL 0x11 func 2 - PCI slot 1 */
+			0x8a00 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+			0x8a00 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+			0x8a00 0x0 0x0 0x3 &mpic 0x4 0x1 0 0
+			0x8a00 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
+
+			/* IDSEL 0x11 func 3 - PCI slot 1 */
+			0x8b00 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+			0x8b00 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+			0x8b00 0x0 0x0 0x3 &mpic 0x4 0x1 0 0
+			0x8b00 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
+
+			/* IDSEL 0x11 func 4 - PCI slot 1 */
+			0x8c00 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+			0x8c00 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+			0x8c00 0x0 0x0 0x3 &mpic 0x4 0x1 0 0
+			0x8c00 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
+
+			/* IDSEL 0x11 func 5 - PCI slot 1 */
+			0x8d00 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+			0x8d00 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+			0x8d00 0x0 0x0 0x3 &mpic 0x4 0x1 0 0
+			0x8d00 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
+
+			/* IDSEL 0x11 func 6 - PCI slot 1 */
+			0x8e00 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+			0x8e00 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+			0x8e00 0x0 0x0 0x3 &mpic 0x4 0x1 0 0
+			0x8e00 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
+
+			/* IDSEL 0x11 func 7 - PCI slot 1 */
+			0x8f00 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+			0x8f00 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+			0x8f00 0x0 0x0 0x3 &mpic 0x4 0x1 0 0
+			0x8f00 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
+
+			/* IDSEL 0x12 func 0 - PCI slot 2 */
+			0x9000 0x0 0x0 0x1 &mpic 0x3 0x1 0 0
+			0x9000 0x0 0x0 0x2 &mpic 0x4 0x1 0 0
+			0x9000 0x0 0x0 0x3 &mpic 0x1 0x1 0 0
+			0x9000 0x0 0x0 0x4 &mpic 0x2 0x1 0 0
+
+			/* IDSEL 0x12 func 1 - PCI slot 2 */
+			0x9100 0x0 0x0 0x1 &mpic 0x3 0x1 0 0
+			0x9100 0x0 0x0 0x2 &mpic 0x4 0x1 0 0
+			0x9100 0x0 0x0 0x3 &mpic 0x1 0x1 0 0
+			0x9100 0x0 0x0 0x4 &mpic 0x2 0x1 0 0
+
+			/* IDSEL 0x12 func 2 - PCI slot 2 */
+			0x9200 0x0 0x0 0x1 &mpic 0x3 0x1 0 0
+			0x9200 0x0 0x0 0x2 &mpic 0x4 0x1 0 0
+			0x9200 0x0 0x0 0x3 &mpic 0x1 0x1 0 0
+			0x9200 0x0 0x0 0x4 &mpic 0x2 0x1 0 0
+
+			/* IDSEL 0x12 func 3 - PCI slot 2 */
+			0x9300 0x0 0x0 0x1 &mpic 0x3 0x1 0 0
+			0x9300 0x0 0x0 0x2 &mpic 0x4 0x1 0 0
+			0x9300 0x0 0x0 0x3 &mpic 0x1 0x1 0 0
+			0x9300 0x0 0x0 0x4 &mpic 0x2 0x1 0 0
+
+			/* IDSEL 0x12 func 4 - PCI slot 2 */
+			0x9400 0x0 0x0 0x1 &mpic 0x3 0x1 0 0
+			0x9400 0x0 0x0 0x2 &mpic 0x4 0x1 0 0
+			0x9400 0x0 0x0 0x3 &mpic 0x1 0x1 0 0
+			0x9400 0x0 0x0 0x4 &mpic 0x2 0x1 0 0
+
+			/* IDSEL 0x12 func 5 - PCI slot 2 */
+			0x9500 0x0 0x0 0x1 &mpic 0x3 0x1 0 0
+			0x9500 0x0 0x0 0x2 &mpic 0x4 0x1 0 0
+			0x9500 0x0 0x0 0x3 &mpic 0x1 0x1 0 0
+			0x9500 0x0 0x0 0x4 &mpic 0x2 0x1 0 0
+
+			/* IDSEL 0x12 func 6 - PCI slot 2 */
+			0x9600 0x0 0x0 0x1 &mpic 0x3 0x1 0 0
+			0x9600 0x0 0x0 0x2 &mpic 0x4 0x1 0 0
+			0x9600 0x0 0x0 0x3 &mpic 0x1 0x1 0 0
+			0x9600 0x0 0x0 0x4 &mpic 0x2 0x1 0 0
+
+			/* IDSEL 0x12 func 7 - PCI slot 2 */
+			0x9700 0x0 0x0 0x1 &mpic 0x3 0x1 0 0
+			0x9700 0x0 0x0 0x2 &mpic 0x4 0x1 0 0
+			0x9700 0x0 0x0 0x3 &mpic 0x1 0x1 0 0
+			0x9700 0x0 0x0 0x4 &mpic 0x2 0x1 0 0
+
+			// IDSEL 0x1c  USB
+			0xe000 0x0 0x0 0x1 &i8259 0xc 0x2
+			0xe100 0x0 0x0 0x2 &i8259 0x9 0x2
+			0xe200 0x0 0x0 0x3 &i8259 0xa 0x2
+			0xe300 0x0 0x0 0x4 &i8259 0xb 0x2
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
+
+		uli1575@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
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
+					interrupts = <9 2 0 0>;
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
diff --git a/arch/powerpc/boot/dts/mpc8572ds_36b.dts b/arch/powerpc/boot/dts/mpc8572ds_36b.dts
index f6365db..6c3d0b3 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_36b.dts
@@ -1,5 +1,5 @@
 /*
- * MPC8572 DS Device Tree Source
+ * MPC8572DS Device Tree Source (36-bit address map)
  *
  * Copyright 2007-2009 Freescale Semiconductor Inc.
  *
@@ -9,67 +9,18 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "fsl/mpc8572si-pre.dtsi"
+
 / {
 	model = "fsl,MPC8572DS";
 	compatible = "fsl,MPC8572DS";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		ethernet3 = &enet3;
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
-		PowerPC,8572@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <0x8000>;		// L1, 32K
-			i-cache-size = <0x8000>;		// L1, 32K
-			timebase-frequency = <0>;
-			bus-frequency = <0>;
-			clock-frequency = <0>;
-			next-level-cache = <&L2>;
-		};
-
-		PowerPC,8572@1 {
-			device_type = "cpu";
-			reg = <0x1>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <0x8000>;		// L1, 32K
-			i-cache-size = <0x8000>;		// L1, 32K
-			timebase-frequency = <0>;
-			bus-frequency = <0>;
-			clock-frequency = <0>;
-			next-level-cache = <&L2>;
-		};
-	};
 
 	memory {
 		device_type = "memory";
 	};
 
-	localbus@fffe05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8572-elbc", "fsl,elbc", "simple-bus";
+	board_lbc: lbc: localbus@fffe05000 {
 		reg = <0xf 0xffe05000 0 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
 
 		ranges = <0x0 0x0 0xf 0xe8000000 0x08000000
 			  0x1 0x0 0xf 0xe0000000 0x08000000
@@ -78,588 +29,17 @@
 			  0x4 0x0 0xf 0xffa40000 0x00040000
 			  0x5 0x0 0xf 0xffa80000 0x00040000
 			  0x6 0x0 0xf 0xffac0000 0x00040000>;
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
-			compatible = "fsl,mpc8572-fcm-nand",
-				     "fsl,elbc-fcm-nand";
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
-		nand@4,0 {
-			compatible = "fsl,mpc8572-fcm-nand",
-				     "fsl,elbc-fcm-nand";
-			reg = <0x4 0x0 0x40000>;
-		};
-
-		nand@5,0 {
-			compatible = "fsl,mpc8572-fcm-nand",
-				     "fsl,elbc-fcm-nand";
-			reg = <0x5 0x0 0x40000>;
-		};
-
-		nand@6,0 {
-			compatible = "fsl,mpc8572-fcm-nand",
-				     "fsl,elbc-fcm-nand";
-			reg = <0x6 0x0 0x40000>;
-		};
 	};
 
-	soc8572@fffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
+	board_soc: soc: soc8572@fffe00000 {
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
-			compatible = "fsl,mpc8572-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,mpc8572-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-		};
-
-		memory-controller@6000 {
-			compatible = "fsl,mpc8572-memory-controller";
-			reg = <0x6000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,mpc8572-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>;	// 32 bytes
-			cache-size = <0x100000>; // L2, 1M
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
-		dma@c300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
-			reg = <0xc300 0x4>;
-			ranges = <0x0 0xc100 0x200>;
-			cell-index = <1>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <76 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <77 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <78 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <79 2>;
-			};
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
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
-			interrupts = <29 2 30 2 34 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0x0>;
-				};
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0x1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0x2>;
-				};
-				phy3: ethernet-phy@3 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0x3>;
-				};
-
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet1: ethernet@25000 {
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
-			tbi-handle = <&tbi1>;
-			phy-handle = <&phy1>;
-			phy-connection-type = "rgmii-id";
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
-		};
-
-		enet2: ethernet@26000 {
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
-			tbi-handle = <&tbi2>;
-			phy-handle = <&phy2>;
-			phy-connection-type = "rgmii-id";
-
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
-			};
-		};
-
-		enet3: ethernet@27000 {
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
-			tbi-handle = <&tbi3>;
-			phy-handle = <&phy3>;
-			phy-connection-type = "rgmii-id";
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
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,mpc8572-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-
-		msi@41600 {
-			compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
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
-		crypto@30000 {
-			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
-				     "fsl,sec2.1", "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <45 2 58 2>;
-			interrupt-parent = <&mpic>;
-			fsl,num-channels = <4>;
-			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0x9fe>;
-			fsl,descriptor-types-mask = <0x3ab0ebf>;
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
 	};
 
-	pci0: pcie@fffe08000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
+	board_pci0: pci0: pcie@fffe08000 {
 		reg = <0xf 0xffe08000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
-		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x11 func 0 - PCI slot 1 */
-			0x8800 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8800 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8800 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8800 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 1 - PCI slot 1 */
-			0x8900 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8900 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8900 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8900 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 2 - PCI slot 1 */
-			0x8a00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8a00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8a00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8a00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 3 - PCI slot 1 */
-			0x8b00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8b00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8b00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8b00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 4 - PCI slot 1 */
-			0x8c00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8c00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8c00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8c00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 5 - PCI slot 1 */
-			0x8d00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8d00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8d00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8d00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 6 - PCI slot 1 */
-			0x8e00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8e00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8e00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8e00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 7 - PCI slot 1 */
-			0x8f00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8f00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8f00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8f00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x12 func 0 - PCI slot 2 */
-			0x9000 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9000 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9000 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9000 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 1 - PCI slot 2 */
-			0x9100 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9100 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9100 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9100 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 2 - PCI slot 2 */
-			0x9200 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9200 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9200 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9200 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 3 - PCI slot 2 */
-			0x9300 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9300 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9300 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9300 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 4 - PCI slot 2 */
-			0x9400 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9400 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9400 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9400 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 5 - PCI slot 2 */
-			0x9500 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9500 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9500 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9500 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 6 - PCI slot 2 */
-			0x9600 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9600 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9600 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9600 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 7 - PCI slot 2 */
-			0x9700 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9700 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9700 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9700 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			// IDSEL 0x1c  USB
-			0xe000 0x0 0x0 0x1 &i8259 0xc 0x2
-			0xe100 0x0 0x0 0x2 &i8259 0x9 0x2
-			0xe200 0x0 0x0 0x3 &i8259 0xa 0x2
-			0xe300 0x0 0x0 0x4 &i8259 0xb 0x2
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
-
-			>;
-
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xe0000000
 				  0x2000000 0x0 0xe0000000
 				  0x0 0x20000000
@@ -667,99 +47,14 @@
 				  0x1000000 0x0 0x0
 				  0x1000000 0x0 0x0
 				  0x0 0x10000>;
-			uli1575@0 {
-				reg = <0x0 0x0 0x0 0x0 0x0>;
-				#size-cells = <2>;
-				#address-cells = <3>;
-				ranges = <0x2000000 0x0 0xe0000000
-					  0x2000000 0x0 0xe0000000
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
-						interrupts = <9 2>;
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
 
 	pci1: pcie@fffe09000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xf 0xffe09000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x4 0x1
-			0000 0x0 0x0 0x2 &mpic 0x5 0x1
-			0000 0x0 0x0 0x3 &mpic 0x6 0x1
-			0000 0x0 0x0 0x4 &mpic 0x7 0x1
-			>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xe0000000
 				  0x2000000 0x0 0xe0000000
 				  0x0 0x20000000
@@ -771,31 +66,10 @@
 	};
 
 	pci2: pcie@fffe0a000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xf 0xffe0a000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xe0000000 0xc 0x40000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc20000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <26 2>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0000 0x0 0x0 0x4 &mpic 0x3 0x1
-			>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xe0000000
 				  0x2000000 0x0 0xe0000000
 				  0x0 0x20000000
@@ -806,3 +80,11 @@
 		};
 	};
 };
+
+/*
+ * mpc8572ds.dtsi must be last to ensure board_pci0 overrides pci0 settings
+ * for interrupt-map & interrupt-map-mask
+ */
+
+/include/ "fsl/mpc8572si-post.dtsi"
+/include/ "mpc8572ds.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
index 3375c2a..d34d127 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
@@ -14,494 +14,69 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "mpc8572ds.dts"
+
 / {
 	model = "fsl,MPC8572DS";
 	compatible = "fsl,MPC8572DS", "fsl,MPC8572DS-CAMP";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		serial0 = &serial0;
-		pci0 = &pci0;
-		pci1 = &pci1;
-	};
 
 	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		PowerPC,8572@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <0x8000>;		// L1, 32K
-			i-cache-size = <0x8000>;		// L1, 32K
-			timebase-frequency = <0>;
-			bus-frequency = <0>;
-			clock-frequency = <0>;
-			next-level-cache = <&L2>;
 		};
-
+		PowerPC,8572@1 {
+			status = "disabled";
+		};
 	};
 
-	memory {
-		device_type = "memory";
-		reg = <0x0 0x0>;	// Filled by U-Boot
+	localbus@ffe05000 {
+		status = "disabled";
 	};
 
 	soc8572@ffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
-		ranges = <0x0 0xffe00000 0x100000>;
-		bus-frequency = <0>;		// Filled out by uboot.
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <12>;
+		serial@4600 {
+			status = "disabled";
 		};
-
-		ecm@1000 {
-			compatible = "fsl,mpc8572-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
+		dma@c300 {
+			status = "disabled";
 		};
-
-		memory-controller@2000 {
-			compatible = "fsl,mpc8572-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
+		gpio-controller@f000 {
 		};
-
-		memory-controller@6000 {
-			compatible = "fsl,mpc8572-memory-controller";
-			reg = <0x6000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,mpc8572-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>;	// 32 bytes
+		l2-cache-controller@20000 {
 			cache-size = <0x80000>;	// L2, 512K
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
 		};
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
+		ethernet@26000 {
+			status = "disabled";
 		};
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
+		mdio@26520 {
+			status = "disabled";
 		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
+		ethernet@27000 {
+			status = "disabled";
 		};
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
-			interrupts = <29 2 30 2 34 2>;
-			interrupt-parent = <&mpic>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0x0>;
-				};
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0x1>;
-				};
-			};
+		mdio@27520 {
+			status = "disabled";
 		};
-
-		enet1: ethernet@25000 {
-			cell-index = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
-			phy-handle = <&phy1>;
-			phy-connection-type = "rgmii-id";
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
+		pic@40000 {
+			protected-sources = <
+			31 32 33 37 38 39       /* enet2 enet3 */
+			76 77 78 79 26 42	/* dma2 pci2 serial*/
+			0xe4 0xe5 0xe6 0xe7	/* msi */
+			>;
 		};
 
 		msi@41600 {
-			compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
 			msi-available-ranges = <0 0x80>;
 			interrupts = <
 				0xe0 0
 				0xe1 0
 				0xe2 0
 				0xe3 0>;
-			interrupt-parent = <&mpic>;
-		};
-
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,mpc8572-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-
-		crypto@30000 {
-			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
-				     "fsl,sec2.1", "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <45 2 58 2>;
-			interrupt-parent = <&mpic>;
-			fsl,num-channels = <4>;
-			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0x9fe>;
-			fsl,descriptor-types-mask = <0x3ab0ebf>;
-		};
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-			protected-sources = <
-			31 32 33 37 38 39       /* enet2 enet3 */
-			76 77 78 79 26 42	/* dma2 pci2 serial*/
-			0xe4 0xe5 0xe6 0xe7	/* msi */
-			>;
 		};
-	};
-
-	pci0: pcie@ffe08000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xffe08000 0x1000>;
-		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0x80000000 0x80000000 0x0 0x20000000
-			  0x1000000 0x0 0x0 0xffc00000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
-		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x11 func 0 - PCI slot 1 */
-			0x8800 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8800 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8800 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8800 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 1 - PCI slot 1 */
-			0x8900 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8900 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8900 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8900 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 2 - PCI slot 1 */
-			0x8a00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8a00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8a00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8a00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 3 - PCI slot 1 */
-			0x8b00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8b00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8b00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8b00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 4 - PCI slot 1 */
-			0x8c00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8c00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8c00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8c00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 5 - PCI slot 1 */
-			0x8d00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8d00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8d00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8d00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 6 - PCI slot 1 */
-			0x8e00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8e00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8e00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8e00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 func 7 - PCI slot 1 */
-			0x8f00 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8f00 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8f00 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8f00 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x12 func 0 - PCI slot 2 */
-			0x9000 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9000 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9000 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9000 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 1 - PCI slot 2 */
-			0x9100 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9100 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9100 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9100 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 2 - PCI slot 2 */
-			0x9200 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9200 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9200 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9200 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 3 - PCI slot 2 */
-			0x9300 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9300 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9300 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9300 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 4 - PCI slot 2 */
-			0x9400 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9400 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9400 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9400 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 5 - PCI slot 2 */
-			0x9500 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9500 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9500 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9500 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 6 - PCI slot 2 */
-			0x9600 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9600 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9600 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9600 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			/* IDSEL 0x12 func 7 - PCI slot 2 */
-			0x9700 0x0 0x0 0x1 &mpic 0x3 0x1
-			0x9700 0x0 0x0 0x2 &mpic 0x4 0x1
-			0x9700 0x0 0x0 0x3 &mpic 0x1 0x1
-			0x9700 0x0 0x0 0x4 &mpic 0x2 0x1
-
-			// IDSEL 0x1c  USB
-			0xe000 0x0 0x0 0x1 &i8259 0xc 0x2
-			0xe100 0x0 0x0 0x2 &i8259 0x9 0x2
-			0xe200 0x0 0x0 0x3 &i8259 0xa 0x2
-			0xe300 0x0 0x0 0x4 &i8259 0xb 0x2
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
-
-			>;
-
-		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x2000000 0x0 0x80000000
-				  0x2000000 0x0 0x80000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x10000>;
-			uli1575@0 {
-				reg = <0x0 0x0 0x0 0x0 0x0>;
-				#size-cells = <2>;
-				#address-cells = <3>;
-				ranges = <0x2000000 0x0 0x80000000
-					  0x2000000 0x0 0x80000000
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
-						interrupts = <9 2>;
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
+		timer@42100 {
+			status = "disabled";
 		};
-
 	};
-
-	pci1: pcie@ffe09000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xffe09000 0x1000>;
-		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
-			  0x1000000 0x0 0x0 0xffc10000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x4 0x1
-			0000 0x0 0x0 0x2 &mpic 0x5 0x1
-			0000 0x0 0x0 0x3 &mpic 0x6 0x1
-			0000 0x0 0x0 0x4 &mpic 0x7 0x1
-			>;
-		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x2000000 0x0 0xa0000000
-				  0x2000000 0x0 0xa0000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x10000>;
-		};
+	pcie@ffe0a000 {
+		status = "disabled";
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
index e7b477f..d6a8faf 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
@@ -15,169 +15,74 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "mpc8572ds.dts"
+
 / {
 	model = "fsl,MPC8572DS";
 	compatible = "fsl,MPC8572DS", "fsl,MPC8572DS-CAMP";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		ethernet2 = &enet2;
-		ethernet3 = &enet3;
-		serial0 = &serial0;
-		pci2 = &pci2;
-	};
 
 	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
+		PowerPC,8572@0 {
+			status = "disabled";
+		};
 		PowerPC,8572@1 {
-			device_type = "cpu";
-			reg = <0x1>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <0x8000>;		// L1, 32K
-			i-cache-size = <0x8000>;		// L1, 32K
-			timebase-frequency = <0>;
-			bus-frequency = <0>;
-			clock-frequency = <0>;
-			next-level-cache = <&L2>;
 		};
 	};
 
-	memory {
-		device_type = "memory";
-		reg = <0x0 0x0>;	// Filled by U-Boot
+	localbus@ffe05000 {
+		status = "disabled";
 	};
 
 	soc8572@ffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
-		ranges = <0x0 0xffe00000 0x100000>;
-		bus-frequency = <0>;		// Filled out by uboot.
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,mpc8572-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>; // 32 bytes
-			cache-size = <0x80000>; // L2, 512K
-			interrupt-parent = <&mpic>;
+		ecm-law@0 {
+			status = "disabled";
 		};
-
-		dma@c300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
-			reg = <0xc300 0x4>;
-			ranges = <0x0 0xc100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <76 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <77 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <78 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8572-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <79 2>;
-			};
+		ecm@1000 {
+			status = "disabled";
+		};
+		memory-controller@2000 {
+			status = "disabled";
+		};
+		memory-controller@6000 {
+			status = "disabled";
+		};
+		i2c@3000 {
+			status = "disabled";
+		};
+		i2c@3100 {
+			status = "disabled";
+		};
+		serial@4500 {
+			status = "disabled";
+		};
+		gpio-controller@f000 {
+			status = "disabled";
+		};
+		l2-cache-controller@20000 {
+			cache-size = <0x80000>;	// L2, 512K
+		};
+		dma@21300 {
+			status = "disabled";
+		};
+		ethernet@24000 {
+			status = "disabled";
 		};
-
 		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				reg = <0x2>;
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				reg = <0x3>;
-			};
+			status = "disabled";
 		};
-
-		enet2: ethernet@26000 {
-			cell-index = <2>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
-			phy-handle = <&phy2>;
-			phy-connection-type = "rgmii-id";
+		ptp_clock@24e00 {
+			status = "disabled";
 		};
-
-		enet3: ethernet@27000 {
-			cell-index = <3>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x27000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <37 2 38 2 39 2>;
-			interrupt-parent = <&mpic>;
-			phy-handle = <&phy3>;
-			phy-connection-type = "rgmii-id";
+		ethernet@25000 {
+			status = "disabled";
 		};
-
-		msi@41600 {
-			compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0x80 0x80>;
-			interrupts = <
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
+		mdio@25520 {
+			status = "disabled";
 		};
-
-		serial0: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
+		crypto@30000 {
+			status = "disabled";
 		};
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
+		pic@40000 {
 			protected-sources = <
 			18 16 10 42 45 58	/* MEM L2 mdio serial crypto */
 			29 30 34 35 36 40	/* enet0 enet1 */
@@ -189,41 +94,25 @@
 			0xe0 0xe1 0xe2 0xe3	/* msi */
 			>;
 		};
-	};
-
-	pci2: pcie@ffe0a000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xffe0a000 0x1000>;
-		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0xc0000000 0xc0000000 0x0 0x20000000
-			  0x1000000 0x0 0x0 0xffc20000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <26 2>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0000 0x0 0x0 0x4 &mpic 0x3 0x1
-			>;
-		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x10000>;
+		timer@41100 {
+			status = "disabled";
 		};
+		msi@41600 {
+			msi-available-ranges = <0x80 0x80>;
+			interrupts = <
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+		};
+		global-utilities@e0000 {
+			status = "disabled";
+		};
+	};
+	pcie@ffe08000 {
+		status = "disabled";
+	};
+	pcie@ffe09000 {
+		status = "disabled";
 	};
 };
-- 
1.7.3.4

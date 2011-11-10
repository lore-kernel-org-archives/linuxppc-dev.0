Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 235FF100C41
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:14:52 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAGEmju031857
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:14:48 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 20/30] powerpc/85xx: Rework MPC8536DS device trees
Date: Thu, 10 Nov 2011 10:14:03 -0600
Message-Id: <1320941653-29797-21-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941653-29797-20-git-send-email-galak@kernel.crashing.org>
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
 <1320941653-29797-20-git-send-email-galak@kernel.crashing.org>
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
 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |  248 ++++++++++++++
 arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi  |   63 ++++
 arch/powerpc/boot/dts/mpc8536ds.dts           |  456 +------------------------
 arch/powerpc/boot/dts/mpc8536ds.dtsi          |  141 ++++++++
 arch/powerpc/boot/dts/mpc8536ds_36b.dts       |  410 ++---------------------
 5 files changed, 489 insertions(+), 829 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/mpc8536ds.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
new file mode 100644
index 0000000..8365be6
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
@@ -0,0 +1,248 @@
+/*
+ * MPC8536 Silicon/SoC Device Tree Source (post include)
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
+	compatible = "fsl,mpc8536-elbc", "fsl,elbc", "simple-bus";
+	interrupts = <19 2 0 0>;
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
+/* controller at 0xb000 */
+&pci3 {
+	compatible = "fsl,mpc8548-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 255>;
+	clock-frequency = <33333333>;
+	interrupts = <27 2 0 0>;
+
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <27 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x8 0x1 0x0 0x0
+			0000 0x0 0x0 0x2 &mpic 0x9 0x1 0x0 0x0
+			0000 0x0 0x0 0x3 &mpic 0xa 0x1 0x0 0x0
+			0000 0x0 0x0 0x4 &mpic 0xb 0x1 0x0 0x0
+			>;
+	};
+};
+&soc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "soc";
+	compatible = "fsl,mpc8536-immr", "simple-bus";
+	bus-frequency = <0>;		// Filled out by uboot.
+
+	ecm-law@0 {
+		compatible = "fsl,ecm-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <12>;
+	};
+
+	ecm@1000 {
+		compatible = "fsl,mpc8536-ecm", "fsl,ecm";
+		reg = <0x1000 0x1000>;
+		interrupts = <17 2 0 0>;
+	};
+
+	memory-controller@2000 {
+		compatible = "fsl,mpc8536-memory-controller";
+		reg = <0x2000 0x1000>;
+		interrupts = <18 2 0 0>;
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
+	/* mark compat w/8572 to get some erratum treatment */
+	gpio-controller@f000 {
+		compatible = "fsl,mpc8572-gpio", "fsl,pq3-gpio";
+	};
+
+	sata@18000 {
+		compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
+		reg = <0x18000 0x1000>;
+		cell-index = <1>;
+		interrupts = <74 0x2 0 0>;
+	};
+
+	sata@19000 {
+		compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
+		reg = <0x19000 0x1000>;
+		cell-index = <2>;
+		interrupts = <41 0x2 0 0>;
+	};
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,mpc8536-l2-cache-controller";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>;	// 32 bytes
+		cache-size = <0x80000>; // L2, 512K
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-dma-0.dtsi"
+/include/ "pq3-etsec1-0.dtsi"
+/include/ "pq3-etsec1-timer-0.dtsi"
+
+	usb@22000 {
+		compatible = "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
+		reg = <0x22000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <28 0x2 0 0>;
+	};
+
+	usb@23000 {
+		compatible = "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
+		reg = <0x23000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <46 0x2 0 0>;
+	};
+
+	ptp_clock@24e00 {
+		interrupts = <68 2 0 0 69 2 0 0 70 2 0 0 71 2 0 0>;
+	};
+
+/include/ "pq3-etsec1-2.dtsi"
+	
+	ethernet@26000 {
+		cell-index = <1>;
+	};
+
+	usb@2b000 {
+		compatible = "fsl,mpc8536-usb2-dr", "fsl-usb2-dr";
+		reg = <0x2b000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <60 0x2 0 0>;
+	};
+
+/include/ "pq3-esdhc-0.dtsi"
+/include/ "pq3-sec3.0-0.dtsi"
+/include/ "pq3-mpic.dtsi"
+/include/ "pq3-mpic-timer-B.dtsi"
+
+	global-utilities@e0000 {
+		compatible = "fsl,mpc8536-guts";
+		reg = <0xe0000 0x1000>;
+		fsl,has-rstcr;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi
new file mode 100644
index 0000000..7de45a7
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi
@@ -0,0 +1,63 @@
+/*
+ * MPC8536 Silicon/SoC Device Tree Source (pre include)
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
+	compatible = "fsl,MPC8536";
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
+		pci3 = &pci3;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8536@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index a75c10e..c158815 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -9,24 +9,11 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "fsl/mpc8536si-pre.dtsi"
 
 / {
 	model = "fsl,mpc8536ds";
 	compatible = "fsl,mpc8536ds";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-		pci1 = &pci1;
-		pci2 = &pci2;
-		pci3 = &pci3;
-	};
 
 	cpus {
 		#cpus = <1>;
@@ -45,403 +32,34 @@
 		reg = <0 0 0 0>;	// Filled by U-Boot
 	};
 
-	soc@ffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
-		ranges = <0x0 0 0xffe00000 0x100000>;
-		bus-frequency = <0>;		// Filled out by uboot.
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <12>;
-		};
-
-		ecm@1000 {
-			compatible = "fsl,mpc8536-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,mpc8536-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 0x2>;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,mpc8536-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <16 0x2>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 0x2>;
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
-			interrupts = <43 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-			rtc@68 {
-				compatible = "dallas,ds3232";
-				reg = <0x68>;
-				interrupts = <0 0x1>;
-				interrupt-parent = <&mpic>;
-			};
-		};
-
-		spi@7000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,mpc8536-espi";
-			reg = <0x7000 0x1000>;
-			interrupts = <59 0x2>;
-			interrupt-parent = <&mpic>;
-			fsl,espi-num-chipselects = <4>;
-
-			flash@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "spansion,s25sl12801";
-				reg = <0>;
-				spi-max-frequency = <40000000>;
-				partition@u-boot {
-					label = "u-boot";
-					reg = <0x00000000 0x00100000>;
-					read-only;
-				};
-				partition@kernel {
-					label = "kernel";
-					reg = <0x00100000 0x00500000>;
-					read-only;
-				};
-				partition@dtb {
-					label = "dtb";
-					reg = <0x00600000 0x00100000>;
-					read-only;
-				};
-				partition@fs {
-					label = "file system";
-					reg = <0x00700000 0x00900000>;
-				};
-			};
-			flash@1 {
-				compatible = "spansion,s25sl12801";
-				reg = <1>;
-				spi-max-frequency = <40000000>;
-			};
-			flash@2 {
-				compatible = "spansion,s25sl12801";
-				reg = <2>;
-				spi-max-frequency = <40000000>;
-			};
-			flash@3 {
-				compatible = "spansion,s25sl12801";
-				reg = <3>;
-				spi-max-frequency = <40000000>;
-			};
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8536-dma", "fsl,eloplus-dma";
-			reg = <0x21300 4>;
-			ranges = <0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8536-dma-channel",
-					     "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8536-dma-channel",
-					     "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8536-dma-channel",
-					     "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8536-dma-channel",
-					     "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
-		usb@22000 {
-			compatible = "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
-			reg = <0x22000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupt-parent = <&mpic>;
-			interrupts = <28 0x2>;
-			phy_type = "ulpi";
-		};
-
-		usb@23000 {
-			compatible = "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
-			reg = <0x23000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupt-parent = <&mpic>;
-			interrupts = <46 0x2>;
-			phy_type = "ulpi";
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
-			phy-handle = <&phy1>;
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
-					interrupts = <10 0x1>;
-					reg = <0>;
-					device_type = "ethernet-phy";
-				};
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 0x1>;
-					reg = <1>;
-					device_type = "ethernet-phy";
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet1: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi1>;
-			phy-handle = <&phy0>;
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
-		usb@2b000 {
-			compatible = "fsl,mpc8536-usb2-dr", "fsl-usb2-dr";
-			reg = <0x2b000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupt-parent = <&mpic>;
-			interrupts = <60 0x2>;
-			dr_mode = "peripheral";
-			phy_type = "ulpi";
-		};
-
-		sdhci@2e000 {
-			compatible = "fsl,mpc8536-esdhc", "fsl,esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <72 0x2>;
-			interrupt-parent = <&mpic>;
-			clock-frequency = <250000000>;
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 0x2>;
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
-		sata@18000 {
-			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
-			reg = <0x18000 0x1000>;
-			cell-index = <1>;
-			interrupts = <74 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		sata@19000 {
-			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
-			reg = <0x19000 0x1000>;
-			cell-index = <2>;
-			interrupts = <41 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,mpc8548-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-			big-endian;
-		};
+	lbc: localbus@ffe05000 {
+		reg = <0 0xffe05000 0 0x1000>;
+	};
 
-		msi@41600 {
-			compatible = "fsl,mpc8536-msi", "fsl,mpic-msi";
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
+	board_soc: soc: soc@ffe00000 {
+		ranges = <0x0 0 0xffe00000 0x100000>;
 	};
 
 	pci0: pci@ffe08000 {
-		compatible = "fsl,mpc8540-pci";
-		device_type = "pci";
+		reg = <0 0xffe08000 0 0x1000>;
+		ranges = <0x02000000 0 0x80000000 0 0x80000000 0 0x10000000
+			  0x01000000 0 0x00000000 0 0xffc00000 0 0x00010000>;
+		clock-frequency = <66666666>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 
 			/* IDSEL 0x11 J17 Slot 1 */
-			0x8800 0 0 1 &mpic 1 1
-			0x8800 0 0 2 &mpic 2 1
-			0x8800 0 0 3 &mpic 3 1
-			0x8800 0 0 4 &mpic 4 1>;
-
-		interrupt-parent = <&mpic>;
-		interrupts = <24 0x2>;
-		bus-range = <0 0xff>;
-		ranges = <0x02000000 0 0x80000000 0 0x80000000 0 0x10000000
-			  0x01000000 0 0x00000000 0 0xffc00000 0 0x00010000>;
-		clock-frequency = <66666666>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe08000 0 0x1000>;
+			0x8800 0 0 1 &mpic 1 1 0 0
+			0x8800 0 0 2 &mpic 2 1 0 0
+			0x8800 0 0 3 &mpic 3 1 0 0
+			0x8800 0 0 4 &mpic 4 1 0 0>;
 	};
 
 	pci1: pcie@ffe09000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0 0xffe09000 0 0x1000>;
-		bus-range = <0 0xff>;
 		ranges = <0x02000000 0 0x98000000 0 0x98000000 0 0x08000000
 			  0x01000000 0 0x00000000 0 0xffc20000 0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 0x2>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 4 1
-			0000 0 0 2 &mpic 5 1
-			0000 0 0 3 &mpic 6 1
-			0000 0 0 4 &mpic 7 1
-			>;
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0 0x98000000
 				  0x02000000 0 0x98000000
 				  0 0x08000000
@@ -453,31 +71,10 @@
 	};
 
 	pci2: pcie@ffe0a000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0 0xffe0a000 0 0x1000>;
-		bus-range = <0 0xff>;
 		ranges = <0x02000000 0 0x90000000 0 0x90000000 0 0x08000000
 			  0x01000000 0 0x00000000 0 0xffc10000 0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <26 0x2>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 0 1
-			0000 0 0 2 &mpic 1 1
-			0000 0 0 3 &mpic 2 1
-			0000 0 0 4 &mpic 3 1
-			>;
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0 0x90000000
 				  0x02000000 0 0x90000000
 				  0 0x08000000
@@ -489,32 +86,10 @@
 	};
 
 	pci3: pcie@ffe0b000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0 0xffe0b000 0 0x1000>;
-		bus-range = <0 0xff>;
 		ranges = <0x02000000 0 0xa0000000 0 0xa0000000 0 0x20000000
 			  0x01000000 0 0x00000000 0 0xffc30000 0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <27 0x2>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 8 1
-			0000 0 0 2 &mpic 9 1
-			0000 0 0 3 &mpic 10 1
-			0000 0 0 4 &mpic 11 1
-			>;
-
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0 0xa0000000
 				  0x02000000 0 0xa0000000
 				  0 0x20000000
@@ -525,3 +100,6 @@
 		};
 	};
 };
+
+/include/ "fsl/mpc8536si-post.dtsi"
+/include/ "mpc8536ds.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dtsi b/arch/powerpc/boot/dts/mpc8536ds.dtsi
new file mode 100644
index 0000000..1462e4c
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8536ds.dtsi
@@ -0,0 +1,141 @@
+/*
+ * MPC8536DS Device Tree Source stub (no addresses or top-level ranges)
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
+&board_soc {
+	i2c@3100 {
+		rtc@68 {
+			compatible = "dallas,ds3232";
+			reg = <0x68>;
+			interrupts = <0 0x1 0 0>;
+		};
+	};
+
+	spi@7000 {
+		flash@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "spansion,s25sl12801";
+			reg = <0>;
+			spi-max-frequency = <40000000>;
+			partition@u-boot {
+				label = "u-boot";
+				reg = <0x00000000 0x00100000>;
+				read-only;
+			};
+			partition@kernel {
+				label = "kernel";
+				reg = <0x00100000 0x00500000>;
+				read-only;
+			};
+			partition@dtb {
+				label = "dtb";
+				reg = <0x00600000 0x00100000>;
+				read-only;
+			};
+			partition@fs {
+				label = "file system";
+				reg = <0x00700000 0x00900000>;
+			};
+		};
+		flash@1 {
+			compatible = "spansion,s25sl12801";
+			reg = <1>;
+			spi-max-frequency = <40000000>;
+		};
+		flash@2 {
+			compatible = "spansion,s25sl12801";
+			reg = <2>;
+			spi-max-frequency = <40000000>;
+		};
+		flash@3 {
+			compatible = "spansion,s25sl12801";
+			reg = <3>;
+			spi-max-frequency = <40000000>;
+		};
+	};
+
+	usb@22000 {
+		phy_type = "ulpi";
+	};
+
+	usb@23000 {
+		phy_type = "ulpi";
+	};
+
+	enet0: ethernet@24000 {
+		tbi-handle = <&tbi0>;
+		phy-handle = <&phy1>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	mdio@24520 {
+		phy0: ethernet-phy@0 {
+			interrupts = <10 0x1 0 0>;
+			reg = <0>;
+			device_type = "ethernet-phy";
+		};
+		phy1: ethernet-phy@1 {
+			interrupts = <10 0x1 0 0>;
+			reg = <1>;
+			device_type = "ethernet-phy";
+		};
+		tbi0: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	enet2: ethernet@26000 {
+		tbi-handle = <&tbi1>;
+		phy-handle = <&phy0>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	mdio@26520 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,gianfar-tbi";
+		reg = <0x26520 0x20>;
+
+		tbi1: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	usb@2b000 {
+		dr_mode = "peripheral";
+		phy_type = "ulpi";
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8536ds_36b.dts b/arch/powerpc/boot/dts/mpc8536ds_36b.dts
index d95b260..8f4b929 100644
--- a/arch/powerpc/boot/dts/mpc8536ds_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds_36b.dts
@@ -1,5 +1,5 @@
 /*
- * MPC8536 DS Device Tree Source
+ * MPC8536DS Device Tree Source (36-bit address map)
  *
  * Copyright 2008-2009 Freescale Semiconductor, Inc.
  *
@@ -9,24 +9,11 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "fsl/mpc8536si-pre.dtsi"
 
 / {
 	model = "fsl,mpc8536ds";
 	compatible = "fsl,mpc8536ds";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-		pci1 = &pci1;
-		pci2 = &pci2;
-		pci3 = &pci3;
-	};
 
 	cpus {
 		#cpus = <1>;
@@ -45,351 +32,34 @@
 		reg = <0 0 0 0>;	// Filled by U-Boot
 	};
 
-	soc@fffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
-		ranges = <0x0 0xf 0xffe00000 0x100000>;
-		bus-frequency = <0>;		// Filled out by uboot.
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <12>;
-		};
-
-		ecm@1000 {
-			compatible = "fsl,mpc8536-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,mpc8536-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 0x2>;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,mpc8536-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <16 0x2>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 0x2>;
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
-			interrupts = <43 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-			rtc@68 {
-				compatible = "dallas,ds3232";
-				reg = <0x68>;
-				interrupts = <0 0x1>;
-				interrupt-parent = <&mpic>;
-			};
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8536-dma", "fsl,eloplus-dma";
-			reg = <0x21300 4>;
-			ranges = <0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8536-dma-channel",
-					     "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8536-dma-channel",
-					     "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8536-dma-channel",
-					     "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8536-dma-channel",
-					     "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
-		usb@22000 {
-			compatible = "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
-			reg = <0x22000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupt-parent = <&mpic>;
-			interrupts = <28 0x2>;
-			phy_type = "ulpi";
-		};
-
-		usb@23000 {
-			compatible = "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
-			reg = <0x23000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupt-parent = <&mpic>;
-			interrupts = <46 0x2>;
-			phy_type = "ulpi";
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
-			phy-handle = <&phy1>;
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
-					interrupts = <10 0x1>;
-					reg = <0>;
-					device_type = "ethernet-phy";
-				};
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 0x1>;
-					reg = <1>;
-					device_type = "ethernet-phy";
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet1: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi1>;
-			phy-handle = <&phy0>;
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
-		usb@2b000 {
-			compatible = "fsl,mpc8536-usb2-dr", "fsl-usb2-dr";
-			reg = <0x2b000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupt-parent = <&mpic>;
-			interrupts = <60 0x2>;
-			dr_mode = "peripheral";
-			phy_type = "ulpi";
-		};
-
-		sdhci@2e000 {
-			compatible = "fsl,mpc8536-esdhc", "fsl,esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <72 0x2>;
-			interrupt-parent = <&mpic>;
-			clock-frequency = <250000000>;
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 0x2>;
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
-		sata@18000 {
-			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
-			reg = <0x18000 0x1000>;
-			cell-index = <1>;
-			interrupts = <74 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		sata@19000 {
-			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
-			reg = <0x19000 0x1000>;
-			cell-index = <2>;
-			interrupts = <41 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,mpc8548-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-			big-endian;
-		};
+	lbc: localbus@ffe05000 {
+		reg = <0 0xffe05000 0 0x1000>;
+	};
 
-		msi@41600 {
-			compatible = "fsl,mpc8536-msi", "fsl,mpic-msi";
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
+	board_soc: soc: soc@fffe00000 {
+		ranges = <0x0 0xf 0xffe00000 0x100000>;
 	};
 
-	pci0: pci@fffe08000 {
-		compatible = "fsl,mpc8540-pci";
-		device_type = "pci";
+	pci0: pci@ffe08000 {
+		reg = <0xf 0xffe08000 0 0x1000>;
+		ranges = <0x02000000 0 0xf0000000 0xc 0x00000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xf 0xffc00000 0 0x00010000>;
+		clock-frequency = <66666666>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 
 			/* IDSEL 0x11 J17 Slot 1 */
-			0x8800 0 0 1 &mpic 1 1
-			0x8800 0 0 2 &mpic 2 1
-			0x8800 0 0 3 &mpic 3 1
-			0x8800 0 0 4 &mpic 4 1>;
-
-		interrupt-parent = <&mpic>;
-		interrupts = <24 0x2>;
-		bus-range = <0 0xff>;
-		ranges = <0x02000000 0 0xf0000000 0xc 0x00000000 0 0x10000000
-			  0x01000000 0 0x00000000 0xf 0xffc00000 0 0x00010000>;
-		clock-frequency = <66666666>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xf 0xffe08000 0 0x1000>;
+			0x8800 0 0 1 &mpic 1 1 0 0
+			0x8800 0 0 2 &mpic 2 1 0 0
+			0x8800 0 0 3 &mpic 3 1 0 0
+			0x8800 0 0 4 &mpic 4 1 0 0>;
 	};
 
-	pci1: pcie@fffe09000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
+	pci1: pcie@ffe09000 {
 		reg = <0xf 0xffe09000 0 0x1000>;
-		bus-range = <0 0xff>;
 		ranges = <0x02000000 0 0xf8000000 0xc 0x18000000 0 0x08000000
 			  0x01000000 0 0x00000000 0xf 0xffc20000 0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 0x2>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 4 1
-			0000 0 0 2 &mpic 5 1
-			0000 0 0 3 &mpic 6 1
-			0000 0 0 4 &mpic 7 1
-			>;
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0 0xf8000000
 				  0x02000000 0 0xf8000000
 				  0 0x08000000
@@ -401,31 +71,10 @@
 	};
 
 	pci2: pcie@fffe0a000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xf 0xffe0a000 0 0x1000>;
-		bus-range = <0 0xff>;
 		ranges = <0x02000000 0 0xf8000000 0xc 0x10000000 0 0x08000000
 			  0x01000000 0 0x00000000 0xf 0xffc10000 0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <26 0x2>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 0 1
-			0000 0 0 2 &mpic 1 1
-			0000 0 0 3 &mpic 2 1
-			0000 0 0 4 &mpic 3 1
-			>;
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0 0xf8000000
 				  0x02000000 0 0xf8000000
 				  0 0x08000000
@@ -437,32 +86,10 @@
 	};
 
 	pci3: pcie@fffe0b000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xf 0xffe0b000 0 0x1000>;
-		bus-range = <0 0xff>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x20000000 0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xffc30000 0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <27 0x2>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 8 1
-			0000 0 0 2 &mpic 9 1
-			0000 0 0 3 &mpic 10 1
-			0000 0 0 4 &mpic 11 1
-			>;
-
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
 				  0 0x20000000
@@ -473,3 +100,6 @@
 		};
 	};
 };
+
+/include/ "fsl/mpc8536si-post.dtsi"
+/include/ "mpc8536ds.dtsi"
-- 
1.7.3.4

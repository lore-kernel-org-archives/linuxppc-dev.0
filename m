Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4E949B7490
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 18:16:55 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAH7GoZs026794
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 01:16:51 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 22/29] powerpc/85xx: Rework P1023RDS device tree
Date: Thu, 17 Nov 2011 01:16:14 -0600
Message-Id: <1321514181-28897-22-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1321514181-28897-21-git-send-email-galak@kernel.crashing.org>
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
 <1321514181-28897-11-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-12-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-13-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-14-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-15-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-16-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-17-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-18-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-19-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-20-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-21-git-send-email-galak@kernel.crashing.org>
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
* Moved to specifying interrupt-parent for mpic at root
* Moved to 4-cell mpic interrupt cells to support MPIC timers
* Dropping "fsl,p1023-IP..." from compatibles for standard blocks
* Removed incorrect power/pmc node, there are no etsec on P1023

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi |  224 ++++++++++++++++
 arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi  |   76 ++++++
 arch/powerpc/boot/dts/p1023rds.dts          |  380 ++-------------------------
 3 files changed, 322 insertions(+), 358 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
new file mode 100644
index 0000000..b06bb4c
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
@@ -0,0 +1,224 @@
+/*
+ * P1023/P1017 Silicon/SoC Device Tree Source (post include)
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
+	compatible = "fsl,p1023-elbc", "fsl,elbc", "simple-bus";
+	interrupts = <19 2 0 0>;
+};
+
+/* controller at 0xa000 */
+&pci0 {
+	compatible = "fsl,p1023-pcie", "fsl,qoriq-pcie-v2.2";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	clock-frequency = <33333333>;
+	interrupts = <16 2 0 0>;
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <16 2 0 0>;
+	};
+};
+
+/* controller at 0x9000 */
+&pci1 {
+	compatible = "fsl,p1023-pcie", "fsl,qoriq-pcie-v2.2";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 0xff>;
+	clock-frequency = <33333333>;
+	interrupts = <16 2 0 0>;
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <16 2 0 0>;
+	};
+};
+
+/* controller at 0xb000 */
+&pci2 {
+	compatible = "fsl,p1023-pcie", "fsl,qoriq-pcie-v2.2";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	clock-frequency = <33333333>;
+	interrupts = <16 2 0 0>;
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <16 2 0 0>;
+	};
+};
+
+&soc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "soc";
+	compatible = "fsl,p1023-immr", "simple-bus";
+	bus-frequency = <0>;		// Filled out by uboot.
+
+	ecm-law@0 {
+		compatible = "fsl,ecm-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <12>;
+	};
+
+	ecm@1000 {
+		compatible = "fsl,p1023-ecm", "fsl,ecm";
+		reg = <0x1000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
+	memory-controller@2000 {
+		compatible = "fsl,p1023-memory-controller";
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
+		compatible = "fsl,p1023-l2-cache-controller";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>;	// 32 bytes
+		cache-size = <0x40000>; // L2,256K
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-dma-0.dtsi"
+/include/ "pq3-usb2-dr-0.dtsi"
+
+	crypto: crypto@300000 {
+		compatible = "fsl,sec-v4.2", "fsl,sec-v4.0";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x30000 0x10000>;
+		ranges = <0 0x30000 0x10000>;
+		interrupts = <58 2 0 0>;
+
+		sec_jr0: jr@1000 {
+			compatible = "fsl,sec-v4.2-job-ring",
+				     "fsl,sec-v4.0-job-ring";
+			reg = <0x1000 0x1000>;
+			interrupts = <45 2 0 0>;
+		};
+
+		sec_jr1: jr@2000 {
+			compatible = "fsl,sec-v4.2-job-ring",
+				     "fsl,sec-v4.0-job-ring";
+			reg = <0x2000 0x1000>;
+			interrupts = <45 2 0 0>;
+		};
+
+		sec_jr2: jr@3000 {
+			compatible = "fsl,sec-v4.2-job-ring",
+				     "fsl,sec-v4.0-job-ring";
+			reg = <0x3000 0x1000>;
+			interrupts = <57 2 0 0>;
+		};
+
+		sec_jr3: jr@4000 {
+			compatible = "fsl,sec-v4.2-job-ring",
+				     "fsl,sec-v4.0-job-ring";
+			reg = <0x4000 0x1000>;
+			interrupts = <57 2 0 0>;
+		};
+
+		rtic@6000 {
+			compatible = "fsl,sec-v4.2-rtic",
+				     "fsl,sec-v4.0-rtic";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x6000 0x100>;
+			ranges = <0x0 0x6100 0xe00>;
+
+			rtic_a: rtic-a@0 {
+				compatible = "fsl,sec-v4.2-rtic-memory",
+					     "fsl,sec-v4.0-rtic-memory";
+				reg = <0x00 0x20 0x100 0x80>;
+			};
+
+			rtic_b: rtic-b@20 {
+				compatible = "fsl,sec-v4.2-rtic-memory",
+					     "fsl,sec-v4.0-rtic-memory";
+				reg = <0x20 0x20 0x200 0x80>;
+			};
+
+			rtic_c: rtic-c@40 {
+				compatible = "fsl,sec-v4.2-rtic-memory",
+					     "fsl,sec-v4.0-rtic-memory";
+				reg = <0x40 0x20 0x300 0x80>;
+			};
+
+			rtic_d: rtic-d@60 {
+				compatible = "fsl,sec-v4.2-rtic-memory",
+					     "fsl,sec-v4.0-rtic-memory";
+				reg = <0x60 0x20 0x500 0x80>;
+			};
+		};
+	};
+
+/include/ "pq3-mpic.dtsi"
+/include/ "pq3-mpic-timer-B.dtsi"
+
+	global-utilities@e0000 {
+		compatible = "fsl,p1023-guts";
+		reg = <0xe0000 0x1000>;
+		fsl,has-rstcr;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
new file mode 100644
index 0000000..ac45f6d
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
@@ -0,0 +1,76 @@
+/*
+ * P1023/P1017 Silicon/SoC Device Tree Source (pre include)
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
+	compatible = "fsl,P1023";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+
+		crypto = &crypto;
+		sec_jr0 = &sec_jr0;
+		sec_jr1 = &sec_jr1;
+		sec_jr2 = &sec_jr2;
+		sec_jr3 = &sec_jr3;
+		rtic_a = &rtic_a;
+		rtic_b = &rtic_b;
+		rtic_c = &rtic_c;
+		rtic_d = &rtic_d;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,P1023@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,P1023@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1023rds.dts b/arch/powerpc/boot/dts/p1023rds.dts
index d3b4782..beb6cb1 100644
--- a/arch/powerpc/boot/dts/p1023rds.dts
+++ b/arch/powerpc/boot/dts/p1023rds.dts
@@ -34,137 +34,30 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/dts-v1/;
+/include/ "fsl/p1023si-pre.dtsi"
 
 / {
 	model = "fsl,P1023";
 	compatible = "fsl,P1023RDS";
 	#address-cells = <2>;
 	#size-cells = <2>;
-
-	aliases {
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-		pci1 = &pci1;
-		pci2 = &pci2;
-
-		crypto = &crypto;
-		sec_jr0 = &sec_jr0;
-		sec_jr1 = &sec_jr1;
-		sec_jr2 = &sec_jr2;
-		sec_jr3 = &sec_jr3;
-		rtic_a = &rtic_a;
-		rtic_b = &rtic_b;
-		rtic_c = &rtic_c;
-		rtic_d = &rtic_d;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: PowerPC,P1023@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			next-level-cache = <&L2>;
-		};
-
-		cpu1: PowerPC,P1023@1 {
-			device_type = "cpu";
-			reg = <0x1>;
-			next-level-cache = <&L2>;
-		};
-	};
+	interrupt-parent = <&mpic>;
 
 	memory {
 		device_type = "memory";
 	};
 
-	soc@ff600000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "fsl,p1023-immr", "simple-bus";
+	soc: soc@ff600000 {
 		ranges = <0x0 0x0 0xff600000 0x200000>;
-		bus-frequency = <0>;		// Filled out by uboot.
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <12>;
-		};
-
-		ecm@1000 {
-			compatible = "fsl,p1023-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <16 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,p1023-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-		};
 
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
-			compatible = "fsl,p1023-espi", "fsl,mpc8536-espi";
-			reg = <0x7000 0x1000>;
-			interrupts = <59 0x2>;
-			interrupt-parent = <&mpic>;
-			fsl,espi-num-chipselects = <4>;
-
 			fsl_dataflash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
@@ -186,197 +79,14 @@
 			};
 		};
 
-		gpio: gpio-controller@f000 {
-			#gpio-cells = <2>;
-			compatible = "fsl,qoriq-gpio";
-			reg = <0xf000 0x100>;
-			interrupts = <47 0x2>;
-			interrupt-parent = <&mpic>;
-			gpio-controller;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,p1023-l2-cache-controller";
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
 			dr_mode = "host";
 			phy_type = "ulpi";
 		};
-
-		crypto: crypto@300000 {
-			compatible = "fsl,sec-v4.2", "fsl,sec-v4.0";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x30000 0x10000>;
-			ranges = <0 0x30000 0x10000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <58 2>;
-
-			sec_jr0: jr@1000 {
-				compatible = "fsl,sec-v4.2-job-ring",
-					     "fsl,sec-v4.0-job-ring";
-				reg = <0x1000 0x1000>;
-				interrupts = <45 2>;
-			};
-
-			sec_jr1: jr@2000 {
-				compatible = "fsl,sec-v4.2-job-ring",
-					     "fsl,sec-v4.0-job-ring";
-				reg = <0x2000 0x1000>;
-				interrupts = <45 2>;
-			};
-
-			sec_jr2: jr@3000 {
-				compatible = "fsl,sec-v4.2-job-ring",
-					     "fsl,sec-v4.0-job-ring";
-				reg = <0x3000 0x1000>;
-				interrupts = <57 2>;
-			};
-
-			sec_jr3: jr@4000 {
-				compatible = "fsl,sec-v4.2-job-ring",
-					     "fsl,sec-v4.0-job-ring";
-				reg = <0x4000 0x1000>;
-				interrupts = <57 2>;
-			};
-
-			rtic@6000 {
-				compatible = "fsl,sec-v4.2-rtic",
-					     "fsl,sec-v4.0-rtic";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0x6000 0x100>;
-				ranges = <0x0 0x6100 0xe00>;
-
-				rtic_a: rtic-a@0 {
-					compatible = "fsl,sec-v4.2-rtic-memory",
-						     "fsl,sec-v4.0-rtic-memory";
-					reg = <0x00 0x20 0x100 0x80>;
-				};
-
-				rtic_b: rtic-b@20 {
-					compatible = "fsl,sec-v4.2-rtic-memory",
-						     "fsl,sec-v4.0-rtic-memory";
-					reg = <0x20 0x20 0x200 0x80>;
-				};
-
-				rtic_c: rtic-c@40 {
-					compatible = "fsl,sec-v4.2-rtic-memory",
-						     "fsl,sec-v4.0-rtic-memory";
-					reg = <0x40 0x20 0x300 0x80>;
-				};
-
-				rtic_d: rtic-d@60 {
-					compatible = "fsl,sec-v4.2-rtic-memory",
-						     "fsl,sec-v4.0-rtic-memory";
-					reg = <0x60 0x20 0x500 0x80>;
-				};
-			};
-		};
-
-		power@e0070{
-			compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc",
-			             "fsl,p1022-pmc";
-			reg = <0xe0070 0x20>;
-			etsec1_clk: soc-clk@B0{
-				fsl,pmcdr-mask = <0x00000080>;
-			};
-			etsec2_clk: soc-clk@B1{
-				fsl,pmcdr-mask = <0x00000040>;
-			};
-			etsec3_clk: soc-clk@B2{
-				fsl,pmcdr-mask = <0x00000020>;
-			};
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
-			compatible = "fsl,p1023-msi", "fsl,mpic-msi";
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
-			compatible = "fsl,p1023-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
 	};
 
-	localbus@ff605000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,p1023-elbc", "fsl,elbc", "simple-bus";
+	lbc: localbus@ff605000 {
 		reg = <0 0xff605000 0 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
 
 		/* NOR Flash, BCSR */
 		ranges = <0x0 0x0 0x0 0xee000000 0x02000000
@@ -428,34 +138,18 @@
 	};
 
 	pci0: pcie@ff60a000 {
-		compatible = "fsl,p1023-pcie", "fsl,qoriq-pcie-v2.2";
-		cell-index = <1>;
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0 0xff60a000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-			interrupt-map-mask = <0xf800 0 0 7>;
 			/* IRQ[0:3] are pulled up on board, set to active-low */
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map = <
 				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 0 1
-				0000 0 0 2 &mpic 1 1
-				0000 0 0 3 &mpic 2 1
-				0000 0 0 4 &mpic 3 1
+				0000 0 0 1 &mpic 0 1 0 0
+				0000 0 0 2 &mpic 1 1 0 0
+				0000 0 0 3 &mpic 2 1 0 0
+				0000 0 0 4 &mpic 3 1 0 0
 				>;
 			ranges = <0x2000000 0x0 0xc0000000
 				  0x2000000 0x0 0xc0000000
@@ -467,38 +161,22 @@
 		};
 	};
 
-	pci1: pcie@ff609000 {
-		compatible = "fsl,p1023-pcie", "fsl,qoriq-pcie-v2.2";
-		cell-index = <2>;
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
+	board_pci1: pci1: pcie@ff609000 {
 		reg = <0 0xff609000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-			interrupt-map-mask = <0xf800 0 0 7>;
 			/*
 			 * IRQ[4:6] only for PCIe, set to active-high,
 			 * IRQ[7] is pulled up on board, set to active-low
 			 */
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map = <
 				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 4 2
-				0000 0 0 2 &mpic 5 2
-				0000 0 0 3 &mpic 6 2
-				0000 0 0 4 &mpic 7 1
+				0000 0 0 1 &mpic 4 2 0 0
+				0000 0 0 2 &mpic 5 2 0 0
+				0000 0 0 3 &mpic 6 2 0 0
+				0000 0 0 4 &mpic 7 1 0 0
 				>;
 			ranges = <0x2000000 0x0 0xa0000000
 				  0x2000000 0x0 0xa0000000
@@ -511,37 +189,21 @@
 	};
 
 	pci2: pcie@ff60b000 {
-		cell-index = <3>;
-		compatible = "fsl,p1023-pcie", "fsl,qoriq-pcie-v2.2";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0 0xff60b000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-			interrupt-map-mask = <0xf800 0 0 7>;
 			/*
 			 * IRQ[8:10] are pulled up on board, set to active-low
 			 * IRQ[11] only for PCIe, set to active-high,
 			 */
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map = <
 				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 8 1
-				0000 0 0 2 &mpic 9 1
-				0000 0 0 3 &mpic 10 1
-				0000 0 0 4 &mpic 11 2
+				0000 0 0 1 &mpic 8 1 0 0
+				0000 0 0 2 &mpic 9 1 0 0
+				0000 0 0 3 &mpic 10 1 0 0
+				0000 0 0 4 &mpic 11 2 0 0
 				>;
 			ranges = <0x2000000 0x0 0x80000000
 				  0x2000000 0x0 0x80000000
@@ -553,3 +215,5 @@
 		};
 	};
 };
+
+/include/ "fsl/p1023si-post.dtsi"
-- 
1.7.3.4

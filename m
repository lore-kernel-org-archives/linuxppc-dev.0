Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m1.elettra.trieste.it [140.105.206.201])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qqZXG0x9LzDqBh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 18:18:34 +1000 (AEST)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [PATCH v1 1/1] powerpc/86xx: Mode pci1 definition to the include file
Date: Wed, 20 Apr 2016 10:18:29 +0200
Message-Id: <1461140309-2522-1-git-send-email-alessio.bogani@elettra.eu>
In-Reply-To: <1461101600.32510.207.camel@buserror.net>
References: <1461101600.32510.207.camel@buserror.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
Please note that this patch replaces completely
https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-April/141785.html

 arch/powerpc/boot/dts/fsl/gef_ppc9a.dts        |  4 ++++
 arch/powerpc/boot/dts/fsl/gef_sbc310.dts       | 22 ---------------------
 arch/powerpc/boot/dts/fsl/gef_sbc610.dts       |  4 ++++
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts     | 24 +----------------------
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts | 24 +----------------------
 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi  | 27 ++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi   |  1 +
 arch/powerpc/boot/dts/fsl/sbc8641d.dts         | 23 ----------------------
 8 files changed, 38 insertions(+), 91 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts b/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
index 0424fc2..c88d4ef 100644
--- a/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
+++ b/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
@@ -211,6 +211,10 @@
 				  0x0 0x00400000>;
 		};
 	};
+
+	pci1: pcie@fef09000 {
+		status = "disabled";
+	};
 };
 
 /include/ "mpc8641si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
index 84b3d38..8385157 100644
--- a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
@@ -24,10 +24,6 @@
 	model = "GEF_SBC310";
 	compatible = "gef,sbc310";
 
-	aliases {
-		pci1 = &pci1;
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x0 0x40000000>;	// set by uboot
@@ -223,29 +219,11 @@
 	};
 
 	pci1: pcie@fef09000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xfef09000 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0xc0000000 0xc0000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xfe400000 0x0 0x00400000>;
-		clock-frequency = <100000000>;
-		interrupts = <0x19 0x2 0 0>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			0x0000 0x0 0x0 0x1 &mpic 0x4 0x2
-			0x0000 0x0 0x0 0x2 &mpic 0x5 0x2
-			0x0000 0x0 0x0 0x3 &mpic 0x6 0x2
-			0x0000 0x0 0x0 0x4 &mpic 0x7 0x2
-			>;
 
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0x0 0xc0000000
 				  0x02000000 0x0 0xc0000000
 				  0x0 0x20000000
diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc610.dts b/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
index 974446a..ff423ab 100644
--- a/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
@@ -209,6 +209,10 @@
 				  0x0 0x00400000>;
 		};
 	};
+
+	pci1: pcie@fef09000 {
+		status = "disabled";
+	};
 };
 
 /include/ "mpc8641si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
index 554001f..11bea3e 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
@@ -15,10 +15,6 @@
 	model = "MPC8641HPCN";
 	compatible = "fsl,mpc8641hpcn";
 
-	aliases {
-		pci1 = &pci1;
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x00000000 0x40000000>;	// 1G at 0x0
@@ -359,29 +355,11 @@
 	};
 
 	pci1: pcie@ffe09000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xffe09000 0x1000>;
-		bus-range = <0 0xff>;
 		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xffc10000 0x0 0x00010000>;
-		clock-frequency = <100000000>;
-		interrupts = <25 2 0 0>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0x0000 0 0 1 &mpic 4 1
-			0x0000 0 0 2 &mpic 5 1
-			0x0000 0 0 3 &mpic 6 1
-			0x0000 0 0 4 &mpic 7 1
-			>;
+
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0x0 0xa0000000
 				  0x02000000 0x0 0xa0000000
 				  0x0 0x20000000
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
index fec5867..7ff6204 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
@@ -17,10 +17,6 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		pci1 = &pci1;
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x0 0x00000000 0x0 0x40000000>;	// 1G at 0x0
@@ -326,29 +322,11 @@
 	};
 
 	pci1: pcie@fffe09000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0x0f 0xffe09000 0x0 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0xe0000000 0x0c 0x20000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0x0f 0xffc10000 0x0 0x00010000>;
-		clock-frequency = <100000000>;
-		interrupts = <25 2 0 0>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0x0000 0 0 1 &mpic 4 1
-			0x0000 0 0 2 &mpic 5 1
-			0x0000 0 0 3 &mpic 6 1
-			0x0000 0 0 4 &mpic 7 1
-			>;
+
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0x0 0xe0000000
 				  0x02000000 0x0 0xe0000000
 				  0x0 0x20000000
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
index 70889d8..a76ffda 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
@@ -113,6 +113,33 @@
 
 	pcie@0 {
 		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+	};
+};
+
+&pci1 {
+	compatible = "fsl,mpc8641-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	clock-frequency = <100000000>;
+	interrupts = <25 2 0 0>;
+	interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+
+	interrupt-map = <
+		0x0000 0x0 0x0 0x1 &mpic 0x4 0x1
+		0x0000 0x0 0x0 0x2 &mpic 0x5 0x1
+		0x0000 0x0 0x0 0x3 &mpic 0x6 0x1
+		0x0000 0x0 0x0 0x4 &mpic 0x7 0x1
+		>;
+
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		device_type = "pci";
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi
index 9e03328..7c6db6f 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi
@@ -25,6 +25,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		pci1 = &pci1;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/fsl/sbc8641d.dts b/arch/powerpc/boot/dts/fsl/sbc8641d.dts
index 0a9733c..75870a1 100644
--- a/arch/powerpc/boot/dts/fsl/sbc8641d.dts
+++ b/arch/powerpc/boot/dts/fsl/sbc8641d.dts
@@ -19,10 +19,6 @@
 	model = "SBC8641D";
 	compatible = "wind,sbc8641";
 
-	aliases {
-		pci1 = &pci1;
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>;	// 512M at 0x0
@@ -165,30 +161,11 @@
 	};
 
 	pci1: pcie@f8009000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xf8009000 0x1000>;
-		bus-range = <0 0xff>;
 		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x00100000>;
-		clock-frequency = <100000000>;
-		interrupts = <25 2 0 0>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0x0000 0 0 1 &mpic 4 1
-			0x0000 0 0 2 &mpic 5 1
-			0x0000 0 0 3 &mpic 6 1
-			0x0000 0 0 4 &mpic 7 1
-			>;
 
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0x0 0xa0000000
 				  0x02000000 0x0 0xa0000000
 				  0x0 0x20000000
-- 
2.8.0

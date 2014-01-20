Return-Path: <Yuantian.Tang@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D781C2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 20:24:33 +1100 (EST)
From: <Yuantian.Tang@freescale.com>
To: <b07421@freescale.com>
Subject: [PATCH] powerpc/mpc85xx: Update clock nodes in device tree
Date: Mon, 20 Jan 2014 16:26:13 +0800
Message-ID: <1390206373-31810-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <yuantian.tang@freescale.com>

The following SoCs will be affected: p2041, p3041, p4080,
p5020, p5040, b4420, b4860, t4240

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |  36 +++++++++
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |   2 +
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  36 +++++++++
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   4 +
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |  60 +++++++++++++++
 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi  |   4 +
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |  61 +++++++++++++++
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi  |   4 +
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 113 ++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi  |   8 ++
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |  43 +++++++++++
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi  |   2 +
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi |  61 +++++++++++++++
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi  |   4 +
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |  86 +++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi  |  12 +++
 16 files changed, 536 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
index 5a6615d..60566f99 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -86,6 +86,42 @@
 
 	clockgen: global-utilities@e1000 {
 		compatible = "fsl,b4420-clockgen", "fsl,qoriq-clockgen-2.0";
+		ranges = <0x0 0xe1000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysclk: sysclk {
+			#clock-cells = <0>;
+			compatible = "fsl,qoriq-sysclk-2.0";
+			clock-output-names = "sysclk";
+		};
+
+		pll0: pll0@800 {
+			#clock-cells = <1>;
+			reg = <0x800 0x4>;
+			compatible = "fsl,qoriq-core-pll-2.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
+		};
+
+		pll1: pll1@820 {
+			#clock-cells = <1>;
+			reg = <0x820 0x4>;
+			compatible = "fsl,qoriq-core-pll-2.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
+		};
+
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0 0x4>;
+			compatible = "fsl,qoriq-core-mux-2.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
+				<&pll1 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0", "pll0-div2", "pll0-div4",
+				"pll1", "pll1-div2", "pll1-div4";
+			clock-output-names = "cmux0";
+		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
index c6e451a..2419731 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -64,11 +64,13 @@
 		cpu0: PowerPC,e6500@0 {
 			device_type = "cpu";
 			reg = <0 1>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index 9813975..cbc354b 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -130,6 +130,42 @@
 
 	clockgen: global-utilities@e1000 {
 		compatible = "fsl,b4860-clockgen", "fsl,qoriq-clockgen-2.0";
+		ranges = <0x0 0xe1000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysclk: sysclk {
+			#clock-cells = <0>;
+			compatible = "fsl,qoriq-sysclk-2.0";
+			clock-output-names = "sysclk";
+		};
+
+		pll0: pll0@800 {
+			#clock-cells = <1>;
+			reg = <0x800 0x4>;
+			compatible = "fsl,qoriq-core-pll-2.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
+		};
+
+		pll1: pll1@820 {
+			#clock-cells = <1>;
+			reg = <0x820 0x4>;
+			compatible = "fsl,qoriq-core-pll-2.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
+		};
+
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0 0x4>;
+			compatible = "fsl,qoriq-core-mux-2.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
+				<&pll1 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0", "pll0-div2", "pll0-div4",
+				"pll1", "pll1-div2", "pll1-div4";
+			clock-output-names = "cmux0";
+		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
index 9bc26b1..142ac86 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -64,21 +64,25 @@
 		cpu0: PowerPC,e6500@0 {
 			device_type = "cpu";
 			reg = <0 1>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2>;
 		};
 		cpu2: PowerPC,e6500@4 {
 			device_type = "cpu";
 			reg = <4 5>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2>;
 		};
 		cpu3: PowerPC,e6500@6 {
 			device_type = "cpu";
 			reg = <6 7>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index dc6cc5a..e2987a3 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -306,8 +306,68 @@
 
 	clockgen: global-utilities@e1000 {
 		compatible = "fsl,p2041-clockgen", "fsl,qoriq-clockgen-1.0";
+		ranges = <0x0 0xe1000 0x1000>;
 		reg = <0xe1000 0x1000>;
 		clock-frequency = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysclk: sysclk {
+			#clock-cells = <0>;
+			compatible = "fsl,qoriq-sysclk-1.0";
+			clock-output-names = "sysclk";
+		};
+
+		pll0: pll0@800 {
+			#clock-cells = <1>;
+			reg = <0x800 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll0", "pll0-div2";
+		};
+
+		pll1: pll1@820 {
+			#clock-cells = <1>;
+			reg = <0x820 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll1", "pll1-div2";
+		};
+
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux0";
+		};
+
+		mux1: mux1@20 {
+			#clock-cells = <0>;
+			reg = <0x20 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux1";
+		};
+
+		mux2: mux2@40 {
+			#clock-cells = <0>;
+			reg = <0x40 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+		};
+
+		mux3: mux3@60 {
+			#clock-cells = <0>;
+			reg = <0x60 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux3";
+		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
index 7a2697d..22f3b14 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
@@ -81,6 +81,7 @@
 		cpu0: PowerPC,e500mc@0 {
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				next-level-cache = <&cpc>;
@@ -89,6 +90,7 @@
 		cpu1: PowerPC,e500mc@1 {
 			device_type = "cpu";
 			reg = <1>;
+			clocks = <&mux1>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 				next-level-cache = <&cpc>;
@@ -97,6 +99,7 @@
 		cpu2: PowerPC,e500mc@2 {
 			device_type = "cpu";
 			reg = <2>;
+			clocks = <&mux2>;
 			next-level-cache = <&L2_2>;
 			L2_2: l2-cache {
 				next-level-cache = <&cpc>;
@@ -105,6 +108,7 @@
 		cpu3: PowerPC,e500mc@3 {
 			device_type = "cpu";
 			reg = <3>;
+			clocks = <&mux3>;
 			next-level-cache = <&L2_3>;
 			L2_3: l2-cache {
 				next-level-cache = <&cpc>;
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index 3fa1e22..7af6d45 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -333,8 +333,69 @@
 
 	clockgen: global-utilities@e1000 {
 		compatible = "fsl,p3041-clockgen", "fsl,qoriq-clockgen-1.0";
+		ranges = <0x0 0xe1000 0x1000>;
 		reg = <0xe1000 0x1000>;
 		clock-frequency = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysclk: sysclk {
+			#clock-cells = <0>;
+			compatible = "fsl,qoriq-sysclk-1.0";
+			clock-output-names = "sysclk";
+		};
+
+		pll0: pll0@800 {
+			#clock-cells = <1>;
+			reg = <0x800 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll0", "pll0-div2";
+		};
+
+		pll1: pll1@820 {
+			#clock-cells = <1>;
+			reg = <0x820 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll1", "pll1-div2";
+		};
+
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux0";
+		};
+
+		mux1: mux1@20 {
+			#clock-cells = <0>;
+			reg = <0x20 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux1";
+		};
+
+		mux2: mux2@40 {
+			#clock-cells = <0>;
+			reg = <0x40 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux2";
+		};
+
+		mux3: mux3@60 {
+			#clock-cells = <0>;
+			reg = <0x60 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux3";
+		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
index c9ca2c3..468e8be 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
@@ -82,6 +82,7 @@
 		cpu0: PowerPC,e500mc@0 {
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				next-level-cache = <&cpc>;
@@ -90,6 +91,7 @@
 		cpu1: PowerPC,e500mc@1 {
 			device_type = "cpu";
 			reg = <1>;
+			clocks = <&mux1>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 				next-level-cache = <&cpc>;
@@ -98,6 +100,7 @@
 		cpu2: PowerPC,e500mc@2 {
 			device_type = "cpu";
 			reg = <2>;
+			clocks = <&mux2>;
 			next-level-cache = <&L2_2>;
 			L2_2: l2-cache {
 				next-level-cache = <&cpc>;
@@ -106,6 +109,7 @@
 		cpu3: PowerPC,e500mc@3 {
 			device_type = "cpu";
 			reg = <3>;
+			clocks = <&mux3>;
 			next-level-cache = <&L2_3>;
 			L2_3: l2-cache {
 				next-level-cache = <&cpc>;
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 34769a7..2415e1f 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -353,8 +353,121 @@
 
 	clockgen: global-utilities@e1000 {
 		compatible = "fsl,p4080-clockgen", "fsl,qoriq-clockgen-1.0";
+		ranges = <0x0 0xe1000 0x1000>;
 		reg = <0xe1000 0x1000>;
 		clock-frequency = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysclk: sysclk {
+			#clock-cells = <0>;
+			compatible = "fsl,qoriq-sysclk-1.0";
+			clock-output-names = "sysclk";
+		};
+
+		pll0: pll0@800 {
+			#clock-cells = <1>;
+			reg = <0x800 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll0", "pll0-div2";
+		};
+
+		pll1: pll1@820 {
+			#clock-cells = <1>;
+			reg = <0x820 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll1", "pll1-div2";
+		};
+
+		pll2: pll2@840 {
+			#clock-cells = <1>;
+			reg = <0x840 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll2", "pll2-div2";
+		};
+
+		pll3: pll3@860 {
+			#clock-cells = <1>;
+			reg = <0x860 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll3", "pll3-div2";
+		};
+
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux0";
+		};
+
+		mux1: mux1@20 {
+			#clock-cells = <0>;
+			reg = <0x20 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux1";
+		};
+
+		mux2: mux2@40 {
+			#clock-cells = <0>;
+			reg = <0x40 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux2";
+		};
+
+		mux3: mux3@60 {
+			#clock-cells = <0>;
+			reg = <0x60 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux3";
+		};
+
+		mux4: mux4@80 {
+			#clock-cells = <0>;
+			reg = <0x80 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
+			clock-names = "pll2", "pll2-div2", "pll3", "pll3-div2";
+			clock-output-names = "cmux4";
+		};
+
+		mux5: mux5@a0 {
+			#clock-cells = <0>;
+			reg = <0xa0 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
+			clock-names = "pll2", "pll2-div2", "pll3", "pll3-div2";
+			clock-output-names = "cmux5";
+		};
+
+		mux6: mux6@c0 {
+			#clock-cells = <0>;
+			reg = <0xc0 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
+			clock-names = "pll2", "pll2-div2", "pll3", "pll3-div2";
+			clock-output-names = "cmux6";
+		};
+
+		mux7: mux7@e0 {
+			#clock-cells = <0>;
+			reg = <0xe0 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
+			clock-names = "pll2", "pll2-div2", "pll3", "pll3-div2";
+			clock-output-names = "cmux7";
+		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
index 493d9a0..0040b5a 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
@@ -81,6 +81,7 @@
 		cpu0: PowerPC,e500mc@0 {
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				next-level-cache = <&cpc>;
@@ -89,6 +90,7 @@
 		cpu1: PowerPC,e500mc@1 {
 			device_type = "cpu";
 			reg = <1>;
+			clocks = <&mux1>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 				next-level-cache = <&cpc>;
@@ -97,6 +99,7 @@
 		cpu2: PowerPC,e500mc@2 {
 			device_type = "cpu";
 			reg = <2>;
+			clocks = <&mux2>;
 			next-level-cache = <&L2_2>;
 			L2_2: l2-cache {
 				next-level-cache = <&cpc>;
@@ -105,6 +108,7 @@
 		cpu3: PowerPC,e500mc@3 {
 			device_type = "cpu";
 			reg = <3>;
+			clocks = <&mux3>;
 			next-level-cache = <&L2_3>;
 			L2_3: l2-cache {
 				next-level-cache = <&cpc>;
@@ -113,6 +117,7 @@
 		cpu4: PowerPC,e500mc@4 {
 			device_type = "cpu";
 			reg = <4>;
+			clocks = <&mux4>;
 			next-level-cache = <&L2_4>;
 			L2_4: l2-cache {
 				next-level-cache = <&cpc>;
@@ -121,6 +126,7 @@
 		cpu5: PowerPC,e500mc@5 {
 			device_type = "cpu";
 			reg = <5>;
+			clocks = <&mux5>;
 			next-level-cache = <&L2_5>;
 			L2_5: l2-cache {
 				next-level-cache = <&cpc>;
@@ -129,6 +135,7 @@
 		cpu6: PowerPC,e500mc@6 {
 			device_type = "cpu";
 			reg = <6>;
+			clocks = <&mux6>;
 			next-level-cache = <&L2_6>;
 			L2_6: l2-cache {
 				next-level-cache = <&cpc>;
@@ -137,6 +144,7 @@
 		cpu7: PowerPC,e500mc@7 {
 			device_type = "cpu";
 			reg = <7>;
+			clocks = <&mux7>;
 			next-level-cache = <&L2_7>;
 			L2_7: l2-cache {
 				next-level-cache = <&cpc>;
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index bc3ae5a..2985de4 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -338,8 +338,51 @@
 
 	clockgen: global-utilities@e1000 {
 		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
+		ranges = <0x0 0xe1000 0x1000>;
 		reg = <0xe1000 0x1000>;
 		clock-frequency = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysclk: sysclk {
+			#clock-cells = <0>;
+			compatible = "fsl,qoriq-sysclk-1.0";
+			clock-output-names = "sysclk";
+		};
+
+		pll0: pll0@800 {
+			#clock-cells = <1>;
+			reg = <0x800 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll0", "pll0-div2";
+		};
+
+		pll1: pll1@820 {
+			#clock-cells = <1>;
+			reg = <0x820 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll1", "pll1-div2";
+		};
+
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux0";
+		};
+
+		mux1: mux1@20 {
+			#clock-cells = <0>;
+			reg = <0x20 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux1";
+		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
index 8df47fc..fe1a2e6 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
@@ -88,6 +88,7 @@
 		cpu0: PowerPC,e5500@0 {
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				next-level-cache = <&cpc>;
@@ -96,6 +97,7 @@
 		cpu1: PowerPC,e5500@1 {
 			device_type = "cpu";
 			reg = <1>;
+			clocks = <&mux1>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 				next-level-cache = <&cpc>;
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index a91897f..546a899 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -298,8 +298,69 @@
 
 	clockgen: global-utilities@e1000 {
 		compatible = "fsl,p5040-clockgen", "fsl,qoriq-clockgen-1.0";
+		ranges = <0x0 0xe1000 0x1000>;
 		reg = <0xe1000 0x1000>;
 		clock-frequency = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysclk: sysclk {
+			#clock-cells = <0>;
+			compatible = "fsl,qoriq-sysclk-1.0";
+			clock-output-names = "sysclk";
+		};
+
+		pll0: pll0@800 {
+			#clock-cells = <1>;
+			reg = <0x800 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll0", "pll0-div2";
+		};
+
+		pll1: pll1@820 {
+			#clock-cells = <1>;
+			reg = <0x820 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll1", "pll1-div2";
+		};
+
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux0";
+		};
+
+		mux1: mux1@20 {
+			#clock-cells = <0>;
+			reg = <0x20 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux1";
+		};
+
+		mux2: mux2@40 {
+			#clock-cells = <0>;
+			reg = <0x40 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux2";
+		};
+
+		mux3: mux3@60 {
+			#clock-cells = <0>;
+			reg = <0x60 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux3";
+		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
index 40ca943..3674686 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
@@ -81,6 +81,7 @@
 		cpu0: PowerPC,e5500@0 {
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				next-level-cache = <&cpc>;
@@ -89,6 +90,7 @@
 		cpu1: PowerPC,e5500@1 {
 			device_type = "cpu";
 			reg = <1>;
+			clocks = <&mux1>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 				next-level-cache = <&cpc>;
@@ -97,6 +99,7 @@
 		cpu2: PowerPC,e5500@2 {
 			device_type = "cpu";
 			reg = <2>;
+			clocks = <&mux2>;
 			next-level-cache = <&L2_2>;
 			L2_2: l2-cache {
 				next-level-cache = <&cpc>;
@@ -105,6 +108,7 @@
 		cpu3: PowerPC,e5500@3 {
 			device_type = "cpu";
 			reg = <3>;
+			clocks = <&mux3>;
 			next-level-cache = <&L2_3>;
 			L2_3: l2-cache {
 				next-level-cache = <&cpc>;
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index 4143a97..f99d74f 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -369,7 +369,93 @@
 
 	clockgen: global-utilities@e1000 {
 		compatible = "fsl,t4240-clockgen", "fsl,qoriq-clockgen-2.0";
+		ranges = <0x0 0xe1000 0x1000>;
 		reg = <0xe1000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysclk: sysclk {
+			#clock-cells = <0>;
+			compatible = "fsl,qoriq-sysclk-2.0";
+			clock-output-names = "sysclk";
+		};
+
+		pll0: pll0@800 {
+			#clock-cells = <1>;
+			reg = <0x800 0x4>;
+			compatible = "fsl,qoriq-core-pll-2.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
+		};
+
+		pll1: pll1@820 {
+			#clock-cells = <1>;
+			reg = <0x820 0x4>;
+			compatible = "fsl,qoriq-core-pll-2.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
+		};
+
+		pll2: pll2@840 {
+			#clock-cells = <1>;
+			reg = <0x840 0x4>;
+			compatible = "fsl,qoriq-core-pll-2.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll2", "pll2-div2", "pll2-div4";
+		};
+
+		pll3: pll3@860 {
+			#clock-cells = <1>;
+			reg = <0x860 0x4>;
+			compatible = "fsl,qoriq-core-pll-2.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll3", "pll3-div2", "pll3-div4";
+		};
+
+		pll4: pll4@880 {
+			#clock-cells = <1>;
+			reg = <0x880 0x4>;
+			compatible = "fsl,qoriq-core-pll-2.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll4", "pll4-div2", "pll4-div4";
+		};
+
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0 0x4>;
+			compatible = "fsl,qoriq-core-mux-2.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
+				<&pll1 0>, <&pll1 1>, <&pll1 2>,
+				<&pll2 0>, <&pll2 1>, <&pll2 2>;
+			clock-names = "pll0", "pll0-div2", "pll0-div4",
+				"pll1", "pll1-div2", "pll1-div4",
+				"pll2", "pll2-div2", "pll2-div4";
+			clock-output-names = "cmux0";
+		};
+
+		mux1: mux1@20 {
+			#clock-cells = <0>;
+			reg = <0x20 0x4>;
+			compatible = "fsl,qoriq-core-mux-2.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
+				<&pll1 0>, <&pll1 1>, <&pll1 2>,
+				<&pll2 0>, <&pll2 1>, <&pll2 2>;
+			clock-names = "pll0", "pll0-div2", "pll0-div4",
+				"pll1", "pll1-div2", "pll1-div4",
+				"pll2", "pll2-div2", "pll2-div4";
+			clock-output-names = "cmux1";
+		};
+
+		mux2: mux2@40 {
+			#clock-cells = <0>;
+			reg = <0x40 0x4>;
+			compatible = "fsl,qoriq-core-mux-2.0";
+			clocks = <&pll3 0>, <&pll3 1>, <&pll3 2>,
+				<&pll4 0>, <&pll4 1>, <&pll4 2>;
+			clock-names = "pll3", "pll3-div2", "pll3-div4",
+				"pll4", "pll4-div2", "pll4-div4";
+			clock-output-names = "cmux2";
+		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
index a93c55a..0b8ccc5 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
@@ -67,61 +67,73 @@
 		cpu0: PowerPC,e6500@0 {
 			device_type = "cpu";
 			reg = <0 1>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2_1>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2_1>;
 		};
 		cpu2: PowerPC,e6500@4 {
 			device_type = "cpu";
 			reg = <4 5>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2_1>;
 		};
 		cpu3: PowerPC,e6500@6 {
 			device_type = "cpu";
 			reg = <6 7>;
+			clocks = <&mux0>;
 			next-level-cache = <&L2_1>;
 		};
 		cpu4: PowerPC,e6500@8 {
 			device_type = "cpu";
 			reg = <8 9>;
+			clocks = <&mux1>;
 			next-level-cache = <&L2_2>;
 		};
 		cpu5: PowerPC,e6500@10 {
 			device_type = "cpu";
 			reg = <10 11>;
+			clocks = <&mux1>;
 			next-level-cache = <&L2_2>;
 		};
 		cpu6: PowerPC,e6500@12 {
 			device_type = "cpu";
 			reg = <12 13>;
+			clocks = <&mux1>;
 			next-level-cache = <&L2_2>;
 		};
 		cpu7: PowerPC,e6500@14 {
 			device_type = "cpu";
 			reg = <14 15>;
+			clocks = <&mux1>;
 			next-level-cache = <&L2_2>;
 		};
 		cpu8: PowerPC,e6500@16 {
 			device_type = "cpu";
 			reg = <16 17>;
+			clocks = <&mux2>;
 			next-level-cache = <&L2_3>;
 		};
 		cpu9: PowerPC,e6500@18 {
 			device_type = "cpu";
 			reg = <18 19>;
+			clocks = <&mux2>;
 			next-level-cache = <&L2_3>;
 		};
 		cpu10: PowerPC,e6500@20 {
 			device_type = "cpu";
 			reg = <20 21>;
+			clocks = <&mux2>;
 			next-level-cache = <&L2_3>;
 		};
 		cpu11: PowerPC,e6500@22 {
 			device_type = "cpu";
 			reg = <22 23>;
+			clocks = <&mux2>;
 			next-level-cache = <&L2_3>;
 		};
 	};
-- 
1.8.0

Return-Path: <B29983@freescale.com>
From: <Yuantian.Tang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2][RFC] PowerPC/85xx: Add clock nodes support
Date: Tue, 12 Mar 2013 15:07:32 +0800
Message-ID: <1363072053-32736-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>,
 devicetree-discuss@lists.ozlabs.org, R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
take p5020 for example.

 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |   44 ++++++++++++++++++++++++++-
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi  |    2 +
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index 9ea77c3..2db0d3c 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -337,9 +337,51 @@
 	};
 
 	clockgen: global-utilities@e1000 {
-		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
+		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0", "fixed-clock";
 		reg = <0xe1000 0x1000>;
 		clock-frequency = <0>;
+		clock-output-names = "sysclk";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pll1: pll1@800 {
+			#clock-cells = <1>;
+			reg = <0x800>;
+			compatible = "fsl,core-pll-clock";
+			clocks = <&clockgen>;
+			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
+		};
+
+		pll2: pll2@820 {
+			#clock-cells = <1>;
+			reg = <0x820>;
+			compatible = "fsl,core-pll-clock";
+			clocks = <&clockgen>;
+			clock-output-names = "pll2", "pll2-div2", "pll2-div4";
+		};
+
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0>;
+			compatible = "fsl,core-mux-clock";
+			clocks = <&pll1 0>, <&pll1 1>, <&pll1 2>,
+				 <&pll2 0>, <&pll2 1>, <&pll2 2>;
+			clock-names = "pll1_0", "pll1_1", "pll1_2",
+				"pll2_0", "pll2_1", "pll2_2";
+			clock-output-names = "cmux0";
+		};
+
+		mux1: mux1@20 {
+			#clock-cells = <0>;
+			reg = <0x20>;
+			compatible = "fsl,core-mux-clock";
+			clocks = <&pll1 0>, <&pll1 1>, <&pll1 2>,
+				 <&pll2 0>, <&pll2 1>, <&pll2 2>;
+			clock-names = "pll1_0", "pll1_1", "pll1_2",
+				"pll2_0", "pll2_1", "pll2_2";
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
-- 
1.7.0.4

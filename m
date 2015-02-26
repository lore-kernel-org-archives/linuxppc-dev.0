Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0116.outbound.protection.outlook.com [207.46.100.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9B2D1A0035
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 02:32:27 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH 1/3] powerpc/mpc85xx: Add FMan clock nodes
Date: Thu, 26 Feb 2015 09:26:55 -0600
Message-ID: <1424964417-13760-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Igal Liberman <Igal.Liberman@Freescale.com>, afleming@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <Igal.Liberman@freescale.com>

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    | 11 +++++++++++
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |  8 ++++++++
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |  8 ++++++++
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 16 ++++++++++++++++
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 13 +++++++++++++
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 26 ++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi |  8 ++++++++
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi | 11 +++++++++++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 20 ++++++++++++++++++++
 9 files changed, 121 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index f8c325e..38621ef 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -395,6 +395,17 @@
 		reg = <0xe0000 0xe00>;
 		fsl,has-rstcr;
 		fsl,liodn-bits = <12>;
+
+		fm0clk: fm0-clk-mux {
+			#clock-cells = <0>;
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>, <&pll0 3>,
+				 <&platform_pll 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0", "pll0-div2", "pll0-div3",
+				      "pll0-div4", "platform-pll", "pll1-div2",
+				      "pll1-div3";
+			clock-output-names = "fm0-clk";
+		};
 	};
 
 /include/ "qoriq-clockgen2.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 1f18b8b..60f63dc 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -316,6 +316,14 @@
 		fsl,has-rstcr;
 		#sleep-cells = <1>;
 		fsl,liodn-bits = <12>;
+
+		fm0clk: fm0-clk-mux {
+			#clock-cells = <0>;
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&platform_pll 1>, <&pll1 1>;
+			clock-names = "platform-pll-div2", "pll1-div2";
+			clock-output-names = "fm0-clk";
+		};
 	};
 
 	pins: global-utilities@e0e00 {
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index a555d24..d4e6677 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -343,6 +343,14 @@
 		fsl,has-rstcr;
 		#sleep-cells = <1>;
 		fsl,liodn-bits = <12>;
+
+		fm0clk: fm0-clk-mux {
+			#clock-cells = <0>;
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&platform_pll 1>, <&pll1 1>;
+			clock-names = "platform-pll-div2", "pll1-div2";
+			clock-output-names = "fm0-clk";
+		};
 	};
 
 	pins: global-utilities@e0e00 {
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 0fe7281..d1cb691 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -363,6 +363,22 @@
 		fsl,has-rstcr;
 		#sleep-cells = <1>;
 		fsl,liodn-bits = <12>;
+
+		fm0clk: fm0-clk-mux {
+			#clock-cells = <0>;
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&platform_pll 1>, <&pll2 1>;
+			clock-names = "platform-pll-div2", "pll2-div2";
+			clock-output-names = "fm0-clk";
+		};
+
+		fm1clk: fm1-clk-mux {
+			#clock-cells = <0>;
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&platform_pll 1>, <&pll2 1>;
+			clock-names = "platform-pll-div2", "pll2-div2";
+			clock-output-names = "fm1-clk";
+		};
 	};
 
 	pins: global-utilities@e0e00 {
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index a34ca20..9f3049d 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -348,6 +348,15 @@
 		fsl,has-rstcr;
 		#sleep-cells = <1>;
 		fsl,liodn-bits = <12>;
+
+		fm0clk: fm0-clk-mux {
+			#clock-cells = <0>;
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&platform_pll 1>, <&pll1 1>, <&pll1 2>;
+			clock-names = "platform-pll-div2", "pll1-div2",
+				      "pll1-div4";
+			clock-output-names = "fm0-clk";
+		};
 	};
 
 	pins: global-utilities@e0e00 {
@@ -359,6 +368,10 @@
 /include/ "qoriq-clockgen1.dtsi"
 	global-utilities@e1000 {
 		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
+
+		pll1: pll1@820 {
+			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
+		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index bf57513..3dea4b6 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -308,6 +308,24 @@
 		fsl,has-rstcr;
 		#sleep-cells = <1>;
 		fsl,liodn-bits = <12>;
+
+		fm0clk: fm0-clk-mux {
+			#clock-cells = <0>;
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&platform_pll 1>, <&pll2 1>, <&pll2 2>;
+			clock-names = "platform-pll-div2", "pll2-div2",
+				      "pll2-div4";
+			clock-output-names = "fm0-clk";
+		};
+
+		fm1clk: fm1-clk-mux {
+			#clock-cells = <0>;
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&platform_pll 1>, <&pll2 1>, <&pll2 2>;
+			clock-names = "platform-pll-div2", "pll2-div2",
+				      "pll2-div4";
+			clock-output-names = "fm1-clk";
+		};
 	};
 
 	pins: global-utilities@e0e00 {
@@ -320,6 +338,14 @@
 	global-utilities@e1000 {
 		compatible = "fsl,p5040-clockgen", "fsl,qoriq-clockgen-1.0";
 
+		pll2: pll2@840 {
+			#clock-cells = <1>;
+			reg = <0x840 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll2", "pll2-div2", "pll2-div4";
+		};
+
 		mux2: mux2@40 {
 			#clock-cells = <0>;
 			reg = <0x40 0x4>;
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 4d41ce1..8f718c6 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -418,6 +418,14 @@
 		reg = <0xe0000 0xe00>;
 		fsl,has-rstcr;
 		fsl,liodn-bits = <12>;
+
+		fm0clk: fm0-clk-mux {
+			#clock-cells = <0>;
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&platform_pll 0>;
+			clock-names = "platform-pll";
+			clock-output-names = "fm0-clk";
+		};
 	};
 
 /include/ "qoriq-clockgen2.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index c2cb0f3..06e76ec 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -530,6 +530,17 @@
 		reg = <0xe0000 0xe00>;
 		fsl,has-rstcr;
 		fsl,liodn-bits = <12>;
+
+		fm0clk: fm0-clk-mux {
+			#clock-cells = <0>;
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>, <&pll0 3>,
+				 <&platform_pll 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0", "pll0-div2", "pll0-div3",
+				      "pll0-div4", "platform-pll", "pll1-div2",
+				      "pll1-div3";
+			clock-output-names = "fm0-clk";
+		};
 	};
 
 /include/ "qoriq-clockgen2.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index c18245e..5ef5ff0 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -945,6 +945,26 @@
 		reg = <0xe0000 0xe00>;
 		fsl,has-rstcr;
 		fsl,liodn-bits = <12>;
+
+		fm0clk: fm0-clk-mux {
+			#clock-cells = <0>;
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&pll0 1>, <&pll0 2>, <&pll0 3>,
+				 <&platform_pll 0>, <&pll1 1>;
+			clock-names = "pll0-div2", "pll0-div3", "pll0-div4",
+				      "platform-pll", "pll1-div2";
+			clock-output-names = "fm0-clk";
+		};
+
+		fm1clk: fm1-clk-mux {
+			#clock-cells = <0>;
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&pll1 1>, <&pll1 2>, <&pll1 3>,
+				 <&platform_pll 0>, <&pll0 1>, <&pll0 2>;
+			clock-names = "pll1-div2", "pll1-div3", "pll1-div4",
+				      "platform-pll", "pll0-div2", "pll0-div3";
+			clock-output-names = "fm1-clk";
+		};
 	};
 
 /include/ "qoriq-clockgen2.dtsi"
-- 
2.3.0

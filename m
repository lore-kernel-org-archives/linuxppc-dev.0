Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0127.outbound.protection.outlook.com [207.46.100.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DDD91A042E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 21:18:45 +1100 (AEDT)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/dts: Unify B4 mux nodes
Date: Mon, 12 Jan 2015 08:03:57 +0200
Message-ID: <1421042637-13970-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>,
 Emilian.Medve@freescale.com
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
Change-Id: Ic5f28f7b492b708f00a5ff74dda723ce5e1da0ba
---
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |   15 ++-------------
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |   15 ++-------------
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |   12 ++++++++++++
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
index 86161ae..1ea8602 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -80,20 +80,9 @@
 		compatible = "fsl,b4420-device-config", "fsl,qoriq-device-config-2.0";
 	};
 
-/include/ "qoriq-clockgen2.dtsi"
 	global-utilities@e1000 {
-		compatible = "fsl,b4420-clockgen", "fsl,qoriq-clockgen-2.0";
-
-		mux0: mux0@0 {
-			#clock-cells = <0>;
-			reg = <0x0 0x4>;
-			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				<&pll1 0>, <&pll1 1>, <&pll1 2>;
-			clock-names = "pll0", "pll0-div2", "pll0-div4",
-				"pll1", "pll1-div2", "pll1-div4";
-			clock-output-names = "cmux0";
-		};
+		compatible = "fsl,b4420-clockgen", "fsl,b4-clockgen",
+			      "fsl,qoriq-clockgen-2.0";
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index 65100b9..d0a5cde 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -124,20 +124,9 @@
 		compatible = "fsl,b4860-device-config", "fsl,qoriq-device-config-2.0";
 	};
 
-/include/ "qoriq-clockgen2.dtsi"
 	global-utilities@e1000 {
-		compatible = "fsl,b4860-clockgen", "fsl,qoriq-clockgen-2.0";
-
-		mux0: mux0@0 {
-			#clock-cells = <0>;
-			reg = <0x0 0x4>;
-			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				<&pll1 0>, <&pll1 1>, <&pll1 2>;
-			clock-names = "pll0", "pll0-div2", "pll0-div4",
-				"pll1", "pll1-div2", "pll1-div4";
-			clock-output-names = "cmux0";
-		};
+		compatible = "fsl,b4860-clockgen", "fsl,b4-clockgen",
+			      "fsl,qoriq-clockgen-2.0";
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 1a54ba7..e4e69b0 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -214,9 +214,21 @@
 		fsl,liodn-bits = <12>;
 	};
 
+/include/ "qoriq-clockgen2.dtsi"
 	clockgen: global-utilities@e1000 {
 		compatible = "fsl,b4-clockgen", "fsl,qoriq-clockgen-2.0";
 		reg = <0xe1000 0x1000>;
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
-- 
1.7.9.5

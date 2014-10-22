Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0137.outbound.protection.outlook.com [207.46.100.137])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65B251A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 02:24:08 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <yuantian.tang@Freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 2/3] dt/bindings: qoriq-clock: Add binding for the platform PLL
Date: Wed, 22 Oct 2014 09:42:16 -0500
Message-ID: <1413988937-27885-2-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1413988937-27885-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1413988937-27885-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
Change-Id: I7950afa9650d15ec7ce2cca89bb2a1e38586d4a5
---
 Documentation/devicetree/bindings/clock/qoriq-clock.txt | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index 5666812..407fb01 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -62,6 +62,8 @@ Required properties:
 		It takes parent's clock-frequency as its clock.
 	* "fsl,qoriq-sysclk-2.0": for input system clock (v2.0).
 		It takes parent's clock-frequency as its clock.
+	* "fsl,qoriq-platform-pll-1.0" for the platform PLL clock (v1.0)
+	* "fsl,qoriq-platform-pll-2.0" for the platform PLL clock (v2.0)
 - #clock-cells: From common clock binding. The number of cells in a
 	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2].0"
 	clocks, or <1> for "fsl,qoriq-core-pll-[1,2].0" clocks.
@@ -94,7 +96,6 @@ Example for clock block and clock provider:
 			compatible = "fsl,qoriq-sysclk-1.0";
 			clock-output-names = "sysclk";
 		};
-
 		pll0: pll0@800 {
 			#clock-cells = <1>;
 			reg = <0x800 0x4>;
@@ -102,7 +103,6 @@ Example for clock block and clock provider:
 			clocks = <&sysclk>;
 			clock-output-names = "pll0", "pll0-div2";
 		};
-
 		pll1: pll1@820 {
 			#clock-cells = <1>;
 			reg = <0x820 0x4>;
@@ -110,7 +110,6 @@ Example for clock block and clock provider:
 			clocks = <&sysclk>;
 			clock-output-names = "pll1", "pll1-div2";
 		};
-
 		mux0: mux0@0 {
 			#clock-cells = <0>;
 			reg = <0x0 0x4>;
@@ -119,7 +118,6 @@ Example for clock block and clock provider:
 			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
 			clock-output-names = "cmux0";
 		};
-
 		mux1: mux1@20 {
 			#clock-cells = <0>;
 			reg = <0x20 0x4>;
@@ -128,8 +126,15 @@ Example for clock block and clock provider:
 			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
 			clock-output-names = "cmux1";
 		};
+		platform-pll: platform-pll@c00 {
+			#clock-cells = <1>;
+			reg = <0xc00 0x4>;
+			compatible = "fsl,qoriq-platform-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "platform-pll", "platform-pll-div2";
+		};
 	};
-  }
+};
 
 Example for clock consumer:
 
@@ -139,4 +144,4 @@ Example for clock consumer:
 		clocks = <&mux0>;
 		...
 	};
-  }
+};
-- 
2.1.2

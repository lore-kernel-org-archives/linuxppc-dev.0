Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0138.outbound.protection.outlook.com [65.55.169.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB92F1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 18:10:46 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] dt/bindings: qoriq-clock: Add binding for FMan clock mux
Date: Tue, 7 Apr 2015 07:08:40 +0300
Message-ID: <1428379720-3247-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>
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
 .../devicetree/bindings/clock/qoriq-clock.txt      |   59 ++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index df4a259..a7e84ce 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -65,6 +65,7 @@ Required properties:
 		It takes parent's clock-frequency as its clock.
 	* "fsl,qoriq-platform-pll-1.0" for the platform PLL clock (v1.0)
 	* "fsl,qoriq-platform-pll-2.0" for the platform PLL clock (v2.0)
+	* "fsl,fman-clk-mux" for the Frame Manager clock.
 - #clock-cells: From common clock binding. The number of cells in a
 	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2].0"
 	clocks, or <1> for "fsl,qoriq-core-pll-[1,2].0" clocks.
@@ -73,6 +74,52 @@ Required properties:
 	* 0 - equal to the PLL frequency
 	* 1 - equal to the PLL frequency divided by 2
 	* 2 - equal to the PLL frequency divided by 4
+	For "fsl,fman-clk-mux" clocks, the single clock-specifier cell may
+	take values according the Reset Configuration Word of the specific
+	device:
+		* P2041, P3041:
+			* 0 - equal to platform PLL divided by 2
+			* 1 - equal to PLL2 divided by 2
+		* P4080 (Both FMans):
+			* 0 - equal to platform PLL divided by 2
+			* 1 - equal to PLL3 divided by 2
+		* P5020:
+			* 0 - equal to platform PLL divided by 2
+			* 1 - equal to PLL2 divided by 2
+			* 2 - equal to PLL2 divided by 4
+		* P5040 (Both FMans):
+			* 0 - equal to platform PLL divided by 2
+			* 1 - equal to PLL3 divided by 2
+			* 2 - equal to PLL3 divided by 4
+		* T1024:
+			* 0 - equal to PLL1 divided by 2
+		* T1040:
+			* 0 - equal to platform PLL
+		* T2080, B4860, B4420:
+			* 0 - equal to PLL1
+			* 1 - equal to PLL1 divided by 2
+			* 2 - equal to PLL1 divided by 3
+			* 3 - equal to PLL1 divided by 4
+			* 4 - equal to platform PLL
+			* 5 - equal to PLL2 divided by 2
+			* 6 - equal to PLL2 divided by 3
+		* T4240:
+			* FM1:
+			* 0 equal to PLL1 divided by 2
+			* 1 equal to PLL1 divided by 3
+			* 2 equal to PLL1 divided by 4
+			* 3 equal to platform PLL
+			* 4 equal to PLL2 divided by 2
+			* FM2:
+			* 0 equal to PLL2 divided by 2
+			* 1 equal to PLL2 divided by 3
+			* 2 equal to PLL2 divided by 4
+			* 3 equal to platform PLL
+			* 4 equal to PLL1 divided by 2
+			* 5 equal to PLL1 divided by 3
+		In Part of FMan V3 devices (B4, T2, T4) the single
+		clock-specifier cell may be determined by the CLKCGxHWACSR
+		register in addtion to RCW.
 
 Recommended properties:
 - clocks: Should be the phandle of input parent clock
@@ -139,6 +186,18 @@ Example for clock block and clock provider:
 			clocks = <&sysclk>;
 			clock-output-names = "platform-pll", "platform-pll-div2";
 		};
+
+		fm0clk: fm0-clk-mux {
+			#clock-cells = <0>;
+			reg = <0x10 4>
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>, <&pll0 3>,
+				 <&platform_pll 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0", "pll0-div2", "pll0-div3",
+				      "pll0-div4", "platform-pll", "pll1-div2",
+				      "pll1-div3";
+			clock-output-names = "fm0-clk";
+		};
 	};
 };
 
-- 
1.7.9.5

Return-Path: <andy.tang@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428T6702ylzF38l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 12:15:41 +1000 (AEST)
From: andy.tang@nxp.com
To: oss@buserror.net
Cc: robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] powerpc/mpc85xx: fix issues in clock node
Date: Tue, 11 Sep 2018 10:12:24 +0800
Message-Id: <20180911021224.30558-1-andy.tang@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yuantian Tang <andy.tang@nxp.com>

The compatible string is not correct in the clock node.
The clocks property refers to the wrong node too.
This patch is to fix them.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
index 4908af5..763caf4 100644
--- a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
@@ -348,7 +348,7 @@
 		mux0: mux0@0 {
 			#clock-cells = <0>;
 			reg = <0x0 4>;
-			compatible = "fsl,core-mux-clock";
+			compatible = "fsl,qoriq-core-mux-2.0";
 			clocks = <&pll0 0>, <&pll0 1>;
 			clock-names = "pll0_0", "pll0_1";
 			clock-output-names = "cmux0";
@@ -356,9 +356,9 @@
 		mux1: mux1@20 {
 			#clock-cells = <0>;
 			reg = <0x20 4>;
-			compatible = "fsl,core-mux-clock";
-			clocks = <&pll0 0>, <&pll0 1>;
-			clock-names = "pll0_0", "pll0_1";
+			compatible = "fsl,qoriq-core-mux-2.0";
+			clocks = <&pll1 0>, <&pll1 1>;
+			clock-names = "pll1_0", "pll1_1";
 			clock-output-names = "cmux1";
 		};
 	};
-- 
1.7.1

Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0109.outbound.protection.outlook.com [157.56.111.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F22391A2C83
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2015 04:13:40 +1000 (AEST)
From: Poonam Aggrwal <poonam.aggrwal@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <devicetree-discuss@lists.ozlabs.org>
CC: <scottwood@freescale.com>, Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Shaveta Leekha <shaveta@freescale.com>
Subject: [PATCH 1/4]fsl/powerpc/b4860: Renamed the L2 caches
Date: Sat, 19 Sep 2015 23:45:42 +0530
Message-ID: <1442686542-14279-1-git-send-email-poonam.aggrwal@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To make provision for more than one L2 caches in the system, change the name
from L2 to L2_1; same as in T4 platforms.
* Also remove the L2 entry from common file 
  "arch/powerpc/boot/dts/fsl/b4si-post.dtsi"
  Keep them only in separate files for b4860 and b4420. 

Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
- based of: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  branch master 
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi | 4 +++-
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  | 4 ++--
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi | 4 +++-
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  | 8 ++++----
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    | 6 ------
 5 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
index 1ea8602..f996cce 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -89,7 +89,9 @@
 		compatible = "fsl,b4420-rcpm", "fsl,qoriq-rcpm-2.0";
 	};
 
-	L2: l2-cache-controller@c20000 {
+	L2_1: l2-cache-controller@c20000 {
 		compatible = "fsl,b4420-l2-cache-controller";
+		reg = <0xc20000 0x40000>;
+		next-level-cache = <&cpc>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
index 338af7e..4257a77 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -65,14 +65,14 @@
 			device_type = "cpu";
 			reg = <0 1>;
 			clocks = <&mux0>;
-			next-level-cache = <&L2>;
+			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
 			clocks = <&mux0>;
-			next-level-cache = <&L2>;
+			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index d1e26a7..be91803 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -258,7 +258,9 @@
 		compatible = "fsl,b4860-rcpm", "fsl,qoriq-rcpm-2.0";
 	};
 
-	L2: l2-cache-controller@c20000 {
+	L2_1: l2-cache-controller@c20000 {
 		compatible = "fsl,b4860-l2-cache-controller";
+		reg = <0xc20000 0x40000>;
+		next-level-cache = <&cpc>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
index 1948f73..6823caa 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -65,28 +65,28 @@
 			device_type = "cpu";
 			reg = <0 1>;
 			clocks = <&mux0>;
-			next-level-cache = <&L2>;
+			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
 			clocks = <&mux0>;
-			next-level-cache = <&L2>;
+			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu2: PowerPC,e6500@4 {
 			device_type = "cpu";
 			reg = <4 5>;
 			clocks = <&mux0>;
-			next-level-cache = <&L2>;
+			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu3: PowerPC,e6500@6 {
 			device_type = "cpu";
 			reg = <6 7>;
 			clocks = <&mux0>;
-			next-level-cache = <&L2>;
+			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 603910a..d45ff04 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -465,10 +465,4 @@
 	bman: bman@31a000 {
 		interrupts = <16 2 1 29>;
 	};
-
-	L2: l2-cache-controller@c20000 {
-		compatible = "fsl,b4-l2-cache-controller";
-		reg = <0xc20000 0x1000>;
-		next-level-cache = <&cpc>;
-	};
 };
-- 
1.9.1

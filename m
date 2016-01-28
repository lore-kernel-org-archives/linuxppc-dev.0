Return-Path: <b37399@nmglablinux22.freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0083.outbound.protection.outlook.com [157.56.111.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9BE21A030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 19:24:46 +1100 (AEDT)
From: Ashish Kumar <Ashish.Kumar@nxp.com>
To: <scott.wood@nxp.com>, <linuxppc-dev@lists.ozlabs.org>
CC: Ashish Kumar <Ashish.Kumar@nxp.com>, Shaveta Leekha
 <Shaveta.Leekha@nxp.com>
Subject: [PATCH] B4860qds/B4420qds: Updates to device trees for B4860 for DSP
 clusters and their L2 caches
Date: Thu, 28 Jan 2016 13:22:34 +0530
Message-ID: <1453967554-16989-1-git-send-email-Ashish.Kumar@nxp.com>
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

B4860 has 1 PPC core cluster and 3 DSP core clusters.
Similarly B4420 has 1 PPC core cluster and 1 DSP core cluster.

Each DSP core cluster consists of 2 SC3900 cores and a shared L2 cache.

1. Add DSP clusters for B4420
2. Reorganized the L2 cache nodes such that they now appear in only the
soc specific dtsi files(b4860si-post.dtsi and b4420si-post.dtsi).
Earlier they were shown partly in common b4si-post.dtsi and si specific
b4860si-post.dtsi files .

Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
Signed-off-by: Shaveta Leekha  <Shaveta.Leekha@nxp.com>
---
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |    8 ++++
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |   23 ++++++++++++
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |   18 +++++++++
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   52 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |    5 ---
 5 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
index 86161ae..c0fe250 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -102,5 +102,13 @@
 
 	L2: l2-cache-controller@c20000 {
 		compatible = "fsl,b4420-l2-cache-controller";
+		reg = <0xc20000 0x1000>;
+		next-level-cache = <&cpc>;
+	};
+/* Following is DSP L2 cache*/
+	L2_2: l2-cache-controller@c60000 {
+		compatible = "fsl,b4420-l2-cache-controller";
+		reg = <0xc60000 0x1000>;
+		next-level-cache = <&cpc>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
index 338af7e..5fec4ea 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -76,4 +76,27 @@
 			fsl,portid-mapping = <0x80000000>;
 		};
 	};
+
+	dsp-clusters {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dsp-cluster0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,sc3900-cluster";
+			reg = <0>;
+
+			dsp0: dsp@0 {
+				compatible = "fsl,sc3900";
+				reg = <0>;
+				next-level-cache = <&L2_2>;
+			};
+			dsp1: dsp@1 {
+				compatible = "fsl,sc3900";
+				reg = <1>;
+				next-level-cache = <&L2_2>;
+			};
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index f35e9e0..19679d3 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -204,5 +204,23 @@
 
 	L2: l2-cache-controller@c20000 {
 		compatible = "fsl,b4860-l2-cache-controller";
+		reg = <0xc20000 0x1000>;
+		next-level-cache = <&cpc>;
+	};
+/* Following are DSP L2 cache */
+	L2_2: l2-cache-controller@c60000 {
+		compatible = "fsl,b4860-l2-cache-controller";
+		reg = <0xc60000 0x1000>;
+		next-level-cache = <&cpc>;
+	};
+	L2_3: l2-cache-controller@ca0000 {
+		compatible = "fsl,b4860-l2-cache-controller";
+		reg = <0xca0000 0x1000>;
+		next-level-cache = <&cpc>;
+	};
+	L2_4: l2-cache-controller@ce0000 {
+		compatible = "fsl,b4860-l2-cache-controller";
+		reg = <0xce0000 0x1000>;
+		next-level-cache = <&cpc>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
index 1948f73..2e5dcb6 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -90,4 +90,56 @@
 			fsl,portid-mapping = <0x80000000>;
 		};
 	};
+	dsp-clusters {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dsp-cluster0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,sc3900-cluster";
+			reg = <0>;
+			dsp0: dsp@0 {
+				compatible = "fsl,sc3900";
+				reg = <0>;
+				next-level-cache = <&L2_2>;
+			};
+			dsp1: dsp@1 {
+				compatible = "fsl,sc3900";
+				reg = <1>;
+				next-level-cache = <&L2_2>;
+			};
+		};
+		dsp-cluster1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,sc3900-cluster";
+			reg = <1>;
+			dsp2: dsp@2 {
+				compatible = "fsl,sc3900";
+				reg = <2>;
+				next-level-cache = <&L2_3>;
+			};
+			dsp3: dsp@3 {
+				compatible = "fsl,sc3900";
+				reg = <3>;
+				next-level-cache = <&L2_3>;
+			};
+		};
+		dsp-cluster2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,sc3900-cluster";
+			reg = <2>;
+			dsp4: dsp@4 {
+				compatible = "fsl,sc3900";
+				reg = <4>;
+				next-level-cache = <&L2_4>;
+			};
+			dsp5: dsp@5 {
+				compatible = "fsl,sc3900";
+				reg = <5>;
+				next-level-cache = <&L2_4>;
+			};
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 73136c0..350ea50 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -348,9 +348,4 @@
 		interrupts = <16 2 1 29>;
 	};
 
-	L2: l2-cache-controller@c20000 {
-		compatible = "fsl,b4-l2-cache-controller";
-		reg = <0xc20000 0x1000>;
-		next-level-cache = <&cpc>;
-	};
 };
-- 
1.7.6.GIT

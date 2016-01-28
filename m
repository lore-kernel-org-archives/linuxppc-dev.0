Return-Path: <b37399@nmglablinux22.freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0091.outbound.protection.outlook.com [65.55.169.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B66D1A030F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 00:33:29 +1100 (AEDT)
From: Ashish Kumar <Ashish.Kumar@nxp.com>
To: <scott.wood@nxp.com>, <linuxppc-dev@lists.ozlabs.org>
CC: Ashish Kumar <Ashish.Kumar@nxp.com>, Shaveta Leekha
 <Shaveta.Leekha@nxp.com>
Subject: [PATCH] arch/PPC:B4860qds/B4420qds: Updates to device trees for B4860
 for DSP clusters and their L2 caches
Date: Thu, 28 Jan 2016 18:47:39 +0530
Message-ID: <1453987059-26263-1-git-send-email-Ashish.Kumar@nxp.com>
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

Add DSP clusters for B4420
The L2 cache nodes such that they now appear in only the
soc specific dtsi files(b4860si-post.dtsi and b4420si-post.dtsi).

Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
Signed-off-by: Shaveta Leekha  <Shaveta.Leekha@nxp.com>
---
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |    7 +++-
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |   23 ++++++++++++
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |   20 ++++++++++-
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   52 +++++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
index f996cce..cc70adb 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -91,7 +91,12 @@
 
 	L2_1: l2-cache-controller@c20000 {
 		compatible = "fsl,b4420-l2-cache-controller";
-		reg = <0xc20000 0x40000>;
+		reg = <0xc20000 0x1000>;
+		next-level-cache = <&cpc>;
+	};
+	L2_2: l2-cache-controller@c60000 {
+		compatible = "fsl,b4420-l2-cache-controller";
+		reg = <0xc60000 0x1000>;
 		next-level-cache = <&cpc>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
index bc3bf93..87c2712 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -81,4 +81,27 @@
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
index 8687198..833d483 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -278,7 +278,25 @@
 
 	L2_1: l2-cache-controller@c20000 {
 		compatible = "fsl,b4860-l2-cache-controller";
-		reg = <0xc20000 0x40000>;
+		reg = <0xc20000 0x1000>;
+		next-level-cache = <&cpc>;
+	};
+
+	L2_2: l2-cache-controller@c60000 {
+		compatible = "fsl,b4860-l2-cache-controller";
+		reg = <0xc60000 0x1000>;
+		next-level-cache = <&cpc>;
+	};
+
+	L2_3: l2-cache-controller@ca0000 {
+		compatible = "fsl,b4860-l2-cache-controller";
+		reg = <0xca0000 0x1000>;
+		next-level-cache = <&cpc>;
+	};
+
+	L2_4: l2-cache-controller@ce0000 {
+		compatible = "fsl,b4860-l2-cache-controller";
+		reg = <0xce0000 0x1000>;
 		next-level-cache = <&cpc>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
index 8797ce1..a45800d 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -100,4 +100,56 @@
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
-- 
1.7.6.GIT

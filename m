Return-Path: <ashish.kumar@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0058.outbound.protection.outlook.com [157.55.234.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429B21A0325
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 21:25:03 +1100 (AEDT)
From: Ashish Kumar <ashish.kumar@nxp.com>
To: Scott Wood <scott.wood@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: Shaveta Leekha <shaveta.leekha@nxp.com>
Subject: RE: [PATCH] B4860qds/B4420qds: Updates to device trees for B4860 for
 DSP clusters and their L2 caches
Date: Thu, 28 Jan 2016 09:51:22 +0000
Message-ID: <AMXPR04MB101DE5A2DCA0D225C49D9A695DA0@AMXPR04MB101.eurprd04.prod.outlook.com>
References: <1453967554-16989-1-git-send-email-Ashish.Kumar@nxp.com>
In-Reply-To: <1453967554-16989-1-git-send-email-Ashish.Kumar@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please ignore this mail. Will send another revision.

Regards
Ashish

-----Original Message-----
From: Ashish Kumar [mailto:Ashish.Kumar@nxp.com]=20
Sent: Thursday, January 28, 2016 1:23 PM
To: Scott Wood <scott.wood@nxp.com>; linuxppc-dev@lists.ozlabs.org
Cc: Ashish Kumar <ashish.kumar@nxp.com>; Shaveta Leekha <shaveta.leekha@nxp=
.com>
Subject: [PATCH] B4860qds/B4420qds: Updates to device trees for B4860 for D=
SP clusters and their L2 caches

B4860 has 1 PPC core cluster and 3 DSP core clusters.
Similarly B4420 has 1 PPC core cluster and 1 DSP core cluster.

Each DSP core cluster consists of 2 SC3900 cores and a shared L2 cache.

1. Add DSP clusters for B4420
2. Reorganized the L2 cache nodes such that they now appear in only the soc=
 specific dtsi files(b4860si-post.dtsi and b4420si-post.dtsi).
Earlier they were shown partly in common b4si-post.dtsi and si specific b48=
60si-post.dtsi files .

Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
Signed-off-by: Shaveta Leekha  <Shaveta.Leekha@nxp.com>
---
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |    8 ++++
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |   23 ++++++++++++
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |   18 +++++++++
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   52 +++++++++++++++++++++++=
++++
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |    5 ---
 5 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boo=
t/dts/fsl/b4420si-post.dtsi
index 86161ae..c0fe250 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -102,5 +102,13 @@
=20
 	L2: l2-cache-controller@c20000 {
 		compatible =3D "fsl,b4420-l2-cache-controller";
+		reg =3D <0xc20000 0x1000>;
+		next-level-cache =3D <&cpc>;
+	};
+/* Following is DSP L2 cache*/
+	L2_2: l2-cache-controller@c60000 {
+		compatible =3D "fsl,b4420-l2-cache-controller";
+		reg =3D <0xc60000 0x1000>;
+		next-level-cache =3D <&cpc>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot=
/dts/fsl/b4420si-pre.dtsi
index 338af7e..5fec4ea 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -76,4 +76,27 @@
 			fsl,portid-mapping =3D <0x80000000>;
 		};
 	};
+
+	dsp-clusters {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		dsp-cluster0 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			compatible =3D "fsl,sc3900-cluster";
+			reg =3D <0>;
+
+			dsp0: dsp@0 {
+				compatible =3D "fsl,sc3900";
+				reg =3D <0>;
+				next-level-cache =3D <&L2_2>;
+			};
+			dsp1: dsp@1 {
+				compatible =3D "fsl,sc3900";
+				reg =3D <1>;
+				next-level-cache =3D <&L2_2>;
+			};
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boo=
t/dts/fsl/b4860si-post.dtsi
index f35e9e0..19679d3 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -204,5 +204,23 @@
=20
 	L2: l2-cache-controller@c20000 {
 		compatible =3D "fsl,b4860-l2-cache-controller";
+		reg =3D <0xc20000 0x1000>;
+		next-level-cache =3D <&cpc>;
+	};
+/* Following are DSP L2 cache */
+	L2_2: l2-cache-controller@c60000 {
+		compatible =3D "fsl,b4860-l2-cache-controller";
+		reg =3D <0xc60000 0x1000>;
+		next-level-cache =3D <&cpc>;
+	};
+	L2_3: l2-cache-controller@ca0000 {
+		compatible =3D "fsl,b4860-l2-cache-controller";
+		reg =3D <0xca0000 0x1000>;
+		next-level-cache =3D <&cpc>;
+	};
+	L2_4: l2-cache-controller@ce0000 {
+		compatible =3D "fsl,b4860-l2-cache-controller";
+		reg =3D <0xce0000 0x1000>;
+		next-level-cache =3D <&cpc>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot=
/dts/fsl/b4860si-pre.dtsi
index 1948f73..2e5dcb6 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -90,4 +90,56 @@
 			fsl,portid-mapping =3D <0x80000000>;
 		};
 	};
+	dsp-clusters {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		dsp-cluster0 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			compatible =3D "fsl,sc3900-cluster";
+			reg =3D <0>;
+			dsp0: dsp@0 {
+				compatible =3D "fsl,sc3900";
+				reg =3D <0>;
+				next-level-cache =3D <&L2_2>;
+			};
+			dsp1: dsp@1 {
+				compatible =3D "fsl,sc3900";
+				reg =3D <1>;
+				next-level-cache =3D <&L2_2>;
+			};
+		};
+		dsp-cluster1 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			compatible =3D "fsl,sc3900-cluster";
+			reg =3D <1>;
+			dsp2: dsp@2 {
+				compatible =3D "fsl,sc3900";
+				reg =3D <2>;
+				next-level-cache =3D <&L2_3>;
+			};
+			dsp3: dsp@3 {
+				compatible =3D "fsl,sc3900";
+				reg =3D <3>;
+				next-level-cache =3D <&L2_3>;
+			};
+		};
+		dsp-cluster2 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			compatible =3D "fsl,sc3900-cluster";
+			reg =3D <2>;
+			dsp4: dsp@4 {
+				compatible =3D "fsl,sc3900";
+				reg =3D <4>;
+				next-level-cache =3D <&L2_4>;
+			};
+			dsp5: dsp@5 {
+				compatible =3D "fsl,sc3900";
+				reg =3D <5>;
+				next-level-cache =3D <&L2_4>;
+			};
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/d=
ts/fsl/b4si-post.dtsi
index 73136c0..350ea50 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -348,9 +348,4 @@
 		interrupts =3D <16 2 1 29>;
 	};
=20
-	L2: l2-cache-controller@c20000 {
-		compatible =3D "fsl,b4-l2-cache-controller";
-		reg =3D <0xc20000 0x1000>;
-		next-level-cache =3D <&cpc>;
-	};
 };
--
1.7.6.GIT

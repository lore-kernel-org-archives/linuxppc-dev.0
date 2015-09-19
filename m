Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0120.outbound.protection.outlook.com [207.46.100.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B9DF1A2C84
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2015 04:29:24 +1000 (AEST)
From: Poonam Aggrwal <poonam.aggrwal@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <devicetree-discuss@lists.ozlabs.org>
CC: <scottwood@freescale.com>, Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Shaveta Leekha <shaveta@freescale.com>
Subject: [PATCH 3/4]fsl/powerpc/b4860: Adds DSP cores/clusters and their L2
 caches
Date: Sat, 19 Sep 2015 23:46:31 +0530
Message-ID: <1442686591-14362-1-git-send-email-poonam.aggrwal@freescale.com>
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

B4860 has 3 DSP clusters, each cluster having 2 DSP cores (SC3900),
and every cluster has a shared L2 cache.

Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
- based of: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  branch master 
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi | 18 +++++++++
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  | 59 +++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index be91803..f6c3b9b 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -263,4 +263,22 @@
 		reg = <0xc20000 0x40000>;
 		next-level-cache = <&cpc>;
 	};
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
+		next-level-cache = <&cpc>;
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
index 6823caa..dbfb2a6 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -90,4 +90,63 @@
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
+
+		dsp-cluster1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,sc3900-cluster";
+			reg = <1>;
+
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
+
+		dsp-cluster2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,sc3900-cluster";
+			reg = <2>;
+
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
1.9.1

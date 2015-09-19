Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0104.outbound.protection.outlook.com [157.56.111.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B93CF1A2CB0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2015 04:29:36 +1000 (AEST)
From: Poonam Aggrwal <poonam.aggrwal@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <devicetree-discuss@lists.ozlabs.org>
CC: <scottwood@freescale.com>, Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Shaveta Leekha <shaveta@freescale.com>
Subject: [PATCH 4/4]fsl/powerpc/b4420: Adds DSP cores/clusters and their L2
 caches
Date: Sat, 19 Sep 2015 23:46:50 +0530
Message-ID: <1442686610-14403-1-git-send-email-poonam.aggrwal@freescale.com>
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

B4420 has 1 DSP cluster, having 2 DSP cores (SC3900), and a shared L2 cache.

Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
- based of: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  branch master 
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |  6 ++++++
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
index f996cce..02fa374 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -94,4 +94,10 @@
 		reg = <0xc20000 0x40000>;
 		next-level-cache = <&cpc>;
 	};
+
+	L2_2: l2-cache-controller@c60000 {
+		compatible = "fsl,b4420-l2-cache-controller";
+		reg = <0xc60000 0x40000>;
+		next-level-cache = <&cpc>;
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
index 4257a77..900086b 100644
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
-- 
1.9.1

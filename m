Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0142.outbound.protection.outlook.com [157.56.111.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE3B81A2C86
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2015 04:46:13 +1000 (AEST)
From: Poonam Aggrwal <poonam.aggrwal@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <devicetree-discuss@lists.ozlabs.org>
CC: <scottwood@freescale.com>, poonam aggrwal <poonam.aggrwal@freescale.com>
Subject: [PATCH 2/4] powerpc/device-tree: bindings for DSP cores/clusters for
 Freescale SOCs
Date: Sat, 19 Sep 2015 23:46:07 +0530
Message-ID: <1442686567-14320-1-git-send-email-poonam.aggrwal@freescale.com>
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

From: poonam aggrwal <poonam.aggrwal@freescale.com>

Device Tree Bindings for DSP CPU clusters and DSP CPUs for Freescale PowerPC
SOCs which have DSP CPUs in addition to PowerPC CPUs.
For example B4860 has 3 DSP clusters which have 2 SC3900 cores each.

Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
- based of: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  branch master 

This patch was sent earlier and some comments were received. Some have been
taken care; others we can further discuss.  Apologize for not following up
on them in time.
 .../devicetree/bindings/powerpc/fsl/dsp-cpus.txt   | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt b/Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt
new file mode 100644
index 0000000..6d901ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt
@@ -0,0 +1,78 @@
+===================================================================
+Binding for DSP CPU clusters and DSP CPUs for Freescale SOCs which
+have DSP CPUs in addition to PowerPC cpus.
+Copyright 2013 Freescale Semiconductor Inc.
+
+Power Architecture CPUs in Freescale SOCs are represented in device trees as
+per the definition in ePAPR.
+
+Required properties for DSP CPU cluster:
+- compatible : should be "fsl,sc3900-cluster".
+- reg : should contain the cluster index
+
+Required properties for DSP CPU:
+- compatible : should be "fsl,sc3900".
+- reg : should contain index of DSP CPU within the DSP clsuter. 
+- next-level-cache : should point to the phandle of the next-level L2 cache.
+
+Example for B4860:
+B4860 SOC of Freescale has 3 DSP clusters. Each DSP cluster has 2 DSP CPUs each.
+The DSP CPUs are SC3900. There is a shared L2 cache per DSP cluster.
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
-- 
1.9.1

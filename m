Return-Path: <b10812@nmglablinux19.freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A95352C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 19:26:01 +1000 (EST)
From: Poonam Aggrwal <poonam.aggrwal@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] Device Tree bindings for DSP clusters and DSP CPUs
Date: Wed, 21 Aug 2013 14:55:49 +0530
Message-ID: <1377077149-24347-1-git-send-email-poonam.aggrwal@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Binding for DSP CPU clusters and DSP CPUs for Freescale SOCs which
have DSP CPUs in addition to PowerPC CPUs. For example B4860.

Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/dsp-cpus.txt   |   78 ++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt b/Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt
new file mode 100644
index 0000000..da7f5d4
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
+- compatible : should be "fsl,dsp-cluster" or "fsl,sc3900-cluster".
+- reg : should contain the cluster index
+
+Required properties for DSP CPU:
+- compatible : should be "fsl,dsp" or "fsl,sc3900".
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
1.7.4.1

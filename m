Return-Path: <hongtao.jia@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0130.outbound.protection.outlook.com [207.46.100.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2FCE1A0A05
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 17:35:49 +1100 (AEDT)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH] QorIQ/TMU: add TMU node to device tree for QorIQ T104x
Date: Tue, 31 Mar 2015 14:17:49 +0800
Message-ID: <1427782669-20368-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: hongtao.jia@freescale.com, devicetree@vger.kernel.org, rui.zhang@intel.com,
 robh+dt@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is Thermal Monitoring Unit for QorIQ platform.

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
---
 .../devicetree/bindings/thermal/qoriq-thermal.txt  | 58 +++++++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi   | 82 ++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  1 +
 3 files changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
new file mode 100644
index 0000000..dfc17fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
@@ -0,0 +1,58 @@
+* Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
+
+Required properties:
+- compatible : "fsl,qoriq-tmu".
+- reg : address range of TMU registers.
+- interrupts : should contain the interrupt for TMU.
+- calibration : calibration table for TMU.
+
+Example:
+
+tmu@f0000 {
+	compatible = "fsl,qoriq-tmu";
+	reg = <0xf0000 0x1000>;
+	interrupts = <18 2 0 0>;
+	calibration = <0x00000000 0x0000000f
+		       0x00000001 0x00000017
+		       0x00000002 0x0000001e
+		       0x00000003 0x00000026
+		       0x00000004 0x0000002e
+		       0x00000005 0x00000035
+		       0x00000006 0x0000003d
+		       0x00000007 0x00000044
+		       0x00000008 0x0000004c
+		       0x00000009 0x00000053
+		       0x0000000a 0x0000005b
+		       0x0000000b 0x00000062
+
+		       0x00010000 0x00000011
+		       0x00010001 0x00000019
+		       0x00010002 0x00000021
+		       0x00010003 0x0000002a
+		       0x00010004 0x00000032
+		       0x00010005 0x0000003a
+		       0x00010006 0x00000042
+		       0x00010007 0x0000004b
+		       0x00010008 0x00000053
+		       0x00010009 0x0000005b
+		       0x0001000a 0x00000063
+
+		       0x00020000 0x00000012
+		       0x00020001 0x0000001b
+		       0x00020002 0x00000024
+		       0x00020003 0x0000002c
+		       0x00020004 0x00000035
+		       0x00020005 0x0000003d
+		       0x00020006 0x00000046
+		       0x00020007 0x0000004e
+		       0x00020008 0x00000057
+
+		       0x00030000 0x00000009
+		       0x00030001 0x00000011
+		       0x00030002 0x00000019
+		       0x00030003 0x00000021
+		       0x00030004 0x00000029
+		       0x00030005 0x00000031
+		       0x00030006 0x00000039
+		       0x00030007 0x00000041>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi
new file mode 100644
index 0000000..d85c77d
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi
@@ -0,0 +1,82 @@
+/*
+ * QorIQ TMU device tree stub [ controller @ offset 0xf0000 ]
+ *
+ * Copyright 2015 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+tmu@f0000 {
+	compatible = "fsl,qoriq-tmu";
+	reg = <0xf0000 0x1000>;
+	interrupts = <18 2 0 0>;
+	calibration = <0x00000000 0x0000000f
+		       0x00000001 0x00000017
+		       0x00000002 0x0000001e
+		       0x00000003 0x00000026
+		       0x00000004 0x0000002e
+		       0x00000005 0x00000035
+		       0x00000006 0x0000003d
+		       0x00000007 0x00000044
+		       0x00000008 0x0000004c
+		       0x00000009 0x00000053
+		       0x0000000a 0x0000005b
+		       0x0000000b 0x00000062
+
+		       0x00010000 0x00000011
+		       0x00010001 0x00000019
+		       0x00010002 0x00000021
+		       0x00010003 0x0000002a
+		       0x00010004 0x00000032
+		       0x00010005 0x0000003a
+		       0x00010006 0x00000042
+		       0x00010007 0x0000004b
+		       0x00010008 0x00000053
+		       0x00010009 0x0000005b
+		       0x0001000a 0x00000063
+
+		       0x00020000 0x00000012
+		       0x00020001 0x0000001b
+		       0x00020002 0x00000024
+		       0x00020003 0x0000002c
+		       0x00020004 0x00000035
+		       0x00020005 0x0000003d
+		       0x00020006 0x00000046
+		       0x00020007 0x0000004e
+		       0x00020008 0x00000057
+
+		       0x00030000 0x00000009
+		       0x00030001 0x00000011
+		       0x00030002 0x00000019
+		       0x00030003 0x00000021
+		       0x00030004 0x00000029
+		       0x00030005 0x00000031
+		       0x00030006 0x00000039
+		       0x00030007 0x00000041>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 15ae462..bb9f792 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -345,6 +345,7 @@
 		reg	   = <0xea000 0x4000>;
 	};
 
+/include/ "qoriq-tmu-t104xsi.dtsi"
 /include/ "elo3-dma-0.dtsi"
 /include/ "elo3-dma-1.dtsi"
 /include/ "qoriq-espi-0.dtsi"
-- 
2.1.0.27.g96db324

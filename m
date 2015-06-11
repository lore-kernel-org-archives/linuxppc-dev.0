Return-Path: <hongtao.jia@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0129.outbound.protection.outlook.com [207.46.100.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49F621A09BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 17:57:29 +1000 (AEST)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <scottwood@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
 <robh+dt@kernel.org>, <edubezval@gmail.com>, <hongtao.jia@freescale.com>
Subject: [PATCH V3] QorIQ/TMU: add TMU node to device tree for QorIQ T1040
Date: Thu, 11 Jun 2015 15:53:08 +0800
Message-ID: <1434009188-25644-1-git-send-email-hongtao.jia@freescale.com>
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

This is Thermal Monitoring Unit for QorIQ platform.

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
---
Changes of V3:
* Put TMU node directly into t1040si-post.dtsi file.
* Add "fsl,tmu-range" property.
* Change "calibration" property to "fsl,tmu-calibration".
* Update the calibration data.

Changes of V2:
* Provide more details on compatible and calibration properties.

 .../devicetree/bindings/thermal/qoriq-thermal.txt  | 63 ++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        | 42 +++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
new file mode 100644
index 0000000..2bc9cb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
@@ -0,0 +1,63 @@
+* Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
+
+Required properties:
+- compatible : Must include "fsl,qoriq-tmu". The version of the device is
+	determined by the TMU IP Block Revision Register (IPBRR0) at
+	offset 0x0BF8.
+	Table of correspondences between IPBRR0 values and example  chips:
+		Value           Device
+		----------      -----
+		0x01900102      T1040
+- reg : Address range of TMU registers.
+- interrupts : Contains the interrupt for TMU.
+- fsl,tmu-range : Temperature range for TMU. Including the starting
+	temperature and number of calibration points for each range.
+- fsl,tmu-calibration : Calibration table for TMU. This is required to
+	determine what a specific sensor reading translates to in degrees
+	Celsius. There are four calibration ranges, for each range we need
+	a couple of calibration data formatted like <TTCFGR, TSCFGR>.
+	Freescale provides the data required.
+
+Example:
+
+tmu@f0000 {
+	compatible = "fsl,qoriq-tmu";
+	reg = <0xf0000 0x1000>;
+	interrupts = <18 2 0 0>;
+	fsl,tmu-range = <0x000a0000 0x00090026 0x0008004a 0x0001006a>;
+	fsl,tmu-calibration = <0x00000000 0x00000025
+			       0x00000001 0x00000028
+			       0x00000002 0x0000002d
+			       0x00000003 0x00000031
+			       0x00000004 0x00000036
+			       0x00000005 0x0000003a
+			       0x00000006 0x00000040
+			       0x00000007 0x00000044
+			       0x00000008 0x0000004a
+			       0x00000009 0x0000004f
+			       0x0000000a 0x00000054
+
+			       0x00010000 0x0000000d
+			       0x00010001 0x00000013
+			       0x00010002 0x00000019
+			       0x00010003 0x0000001f
+			       0x00010004 0x00000025
+			       0x00010005 0x0000002d
+			       0x00010006 0x00000033
+			       0x00010007 0x00000043
+			       0x00010008 0x0000004b
+			       0x00010009 0x00000053
+
+			       0x00020000 0x00000010
+			       0x00020001 0x00000017
+			       0x00020002 0x0000001f
+			       0x00020003 0x00000029
+			       0x00020004 0x00000031
+			       0x00020005 0x0000003c
+			       0x00020006 0x00000042
+			       0x00020007 0x0000004d
+			       0x00020008 0x00000056
+
+			       0x00030000 0x00000012
+			       0x00030001 0x0000001d>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 5cc01be..6d9ca4d 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -407,6 +407,48 @@
 		reg	   = <0xea000 0x4000>;
 	};
 
+	tmu@f0000 {
+		compatible = "fsl,qoriq-tmu";
+		reg = <0xf0000 0x1000>;
+		interrupts = <18 2 0 0>;
+		fsl,tmu-range = <0x000a0000 0x00090026 0x0008004a 0x0001006a>;
+		fsl,tmu-calibration = <0x00000000 0x00000025
+				       0x00000001 0x00000028
+				       0x00000002 0x0000002d
+				       0x00000003 0x00000031
+				       0x00000004 0x00000036
+				       0x00000005 0x0000003a
+				       0x00000006 0x00000040
+				       0x00000007 0x00000044
+				       0x00000008 0x0000004a
+				       0x00000009 0x0000004f
+				       0x0000000a 0x00000054
+
+				       0x00010000 0x0000000d
+				       0x00010001 0x00000013
+				       0x00010002 0x00000019
+				       0x00010003 0x0000001f
+				       0x00010004 0x00000025
+				       0x00010005 0x0000002d
+				       0x00010006 0x00000033
+				       0x00010007 0x00000043
+				       0x00010008 0x0000004b
+				       0x00010009 0x00000053
+
+				       0x00020000 0x00000010
+				       0x00020001 0x00000017
+				       0x00020002 0x0000001f
+				       0x00020003 0x00000029
+				       0x00020004 0x00000031
+				       0x00020005 0x0000003c
+				       0x00020006 0x00000042
+				       0x00020007 0x0000004d
+				       0x00020008 0x00000056
+
+				       0x00030000 0x00000012
+				       0x00030001 0x0000001d>;
+	};
+
 /include/ "elo3-dma-0.dtsi"
 /include/ "elo3-dma-1.dtsi"
 /include/ "qoriq-espi-0.dtsi"
-- 
2.1.0.27.g96db324

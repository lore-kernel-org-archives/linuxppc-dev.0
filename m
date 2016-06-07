Return-Path: <hongtao.jia@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0060.outbound.protection.outlook.com [207.46.100.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNy2Z0Mg7zDqsY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 13:38:13 +1000 (AEST)
From: Jia Hongtao <hongtao.jia@nxp.com>
To: <edubezval@gmail.com>, <rui.zhang@intel.com>, <robh+dt@kernel.org>,
 <galak@codeaurora.org>, <scott.wood@nxp.com>, <shawnguo@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <hongtao.jia@nxp.com>
Subject: [PATCH V2 1/7] dt-bindings: Update QorIQ TMU thermal bindings
Date: Tue, 7 Jun 2016 11:27:34 +0800
Message-ID: <1465270054-31512-1-git-send-email-hongtao.jia@nxp.com>
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

For different types of SoC the sensor id and endianness may vary.
"#thermal-sensor-cells" is used to provide sensor id information.
"little-endian" property is to tell the endianness of TMU.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
Changes for V2:
* Remove formatting chnages.

 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
index 66223d5..20ca4ef 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
@@ -17,6 +17,12 @@ Required properties:
 	calibration data, as specified by the SoC reference manual.
 	The first cell of each pair is the value to be written to TTCFGR,
 	and the second is the value to be written to TSCFGR.
+- #thermal-sensor-cells : Must be 1. The sensor specifier is the monitoring
+	site ID, and represents the "n" in TRITSRn and TRATSRn.
+
+Optional property:
+- little-endian : If present, the TMU registers are little endian. If absent,
+	the default is big endian.

 Example:

@@ -60,4 +66,5 @@ tmu@f0000 {

 			       0x00030000 0x00000012
 			       0x00030001 0x0000001d>;
+	#thermal-sensor-cells = <1>;
 };
--
2.1.0.27.g96db324

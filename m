Return-Path: <hongtao.jia@nxp.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0052.outbound.protection.outlook.com [104.47.38.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssDdp1gwCzDrc5
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Oct 2016 17:59:41 +1100 (AEDT)
From: Jia Hongtao <hongtao.jia@nxp.com>
To: <rui.zhang@intel.com>, <edubezval@gmail.com>, <robh+dt@kernel.org>,
 <scott.wood@nxp.com>, <shawnguo@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <hongtao.jia@nxp.com>
Subject: [PATCH V2 4/5] arm64:dt:ls1043a: Add TMU device tree support for
 LS1043A
Date: Sun, 9 Oct 2016 14:47:05 +0800
Message-ID: <1475995626-14049-4-git-send-email-hongtao.jia@nxp.com>
In-Reply-To: <1475995626-14049-1-git-send-email-hongtao.jia@nxp.com>
References: <1475995626-14049-1-git-send-email-hongtao.jia@nxp.com>
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

From: Hongtao Jia <hongtao.jia@nxp.com>

Also add nodes and properties for thermal management support.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
Changes for V2:
* Rebase on latest linux-next tree (next-20161006).

 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi    | 78 +++++++++++++++++++++++
 3 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index dd9e919..0989d63 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -45,7 +45,7 @@
  */
 
 /dts-v1/;
-/include/ "fsl-ls1043a.dtsi"
+#include "fsl-ls1043a.dtsi"
 
 / {
 	model = "LS1043A QDS Board";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index d2313e0..c37110b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -45,7 +45,7 @@
  */
 
 /dts-v1/;
-/include/ "fsl-ls1043a.dtsi"
+#include "fsl-ls1043a.dtsi"
 
 / {
 	model = "LS1043A RDB Board";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 220ac70..41e5dc1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -44,6 +44,8 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/thermal/thermal.h>
+
 / {
 	compatible = "fsl,ls1043a";
 	interrupt-parent = <&gic>;
@@ -66,6 +68,7 @@
 			reg = <0x0>;
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -254,6 +257,81 @@
 			big-endian;
 		};
 
+		tmu: tmu@1f00000 {
+			compatible = "fsl,qoriq-tmu";
+			reg = <0x0 0x1f00000 0x0 0x10000>;
+			interrupts = <0 33 0x4>;
+			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
+			fsl,tmu-calibration = <0x00000000 0x00000026
+					       0x00000001 0x0000002d
+					       0x00000002 0x00000032
+					       0x00000003 0x00000039
+					       0x00000004 0x0000003f
+					       0x00000005 0x00000046
+					       0x00000006 0x0000004d
+					       0x00000007 0x00000054
+					       0x00000008 0x0000005a
+					       0x00000009 0x00000061
+					       0x0000000a 0x0000006a
+					       0x0000000b 0x00000071
+
+					       0x00010000 0x00000025
+					       0x00010001 0x0000002c
+					       0x00010002 0x00000035
+					       0x00010003 0x0000003d
+					       0x00010004 0x00000045
+					       0x00010005 0x0000004e
+					       0x00010006 0x00000057
+					       0x00010007 0x00000061
+					       0x00010008 0x0000006b
+					       0x00010009 0x00000076
+
+					       0x00020000 0x00000029
+					       0x00020001 0x00000033
+					       0x00020002 0x0000003d
+					       0x00020003 0x00000049
+					       0x00020004 0x00000056
+					       0x00020005 0x00000061
+					       0x00020006 0x0000006d
+
+					       0x00030000 0x00000021
+					       0x00030001 0x0000002a
+					       0x00030002 0x0000003c
+					       0x00030003 0x0000004e>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		thermal-zones {
+			cpu_thermal: cpu-thermal {
+				polling-delay-passive = <1000>;
+				polling-delay = <5000>;
+
+				thermal-sensors = <&tmu 3>;
+
+				trips {
+					cpu_alert: cpu-alert {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu_crit: cpu-crit {
+						temperature = <95000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&cpu_alert>;
+						cooling-device =
+							<&cpu0 THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+					};
+				};
+			};
+		};
+
 		dspi0: dspi@2100000 {
 			compatible = "fsl,ls1043a-dspi", "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
-- 
2.1.0.27.g96db324

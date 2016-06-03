Return-Path: <hongtao.jia@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0089.outbound.protection.outlook.com [207.46.100.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLbDF5KvXzDqmC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 17:23:25 +1000 (AEST)
From: Jia Hongtao <hongtao.jia@nxp.com>
To: <edubezval@gmail.com>, <rui.zhang@intel.com>, <robh+dt@kernel.org>,
 <galak@codeaurora.org>, <scott.wood@nxp.com>, <shawnguo@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <hongtao.jia@nxp.com>
Subject: [PATCH 6/7] arm64:dt:ls2080a: Add TMU device tree support for LS2080A
Date: Fri, 3 Jun 2016 14:57:38 +0800
Message-ID: <1464937059-19349-6-git-send-email-hongtao.jia@nxp.com>
In-Reply-To: <1464937059-19349-1-git-send-email-hongtao.jia@nxp.com>
References: <1464937059-19349-1-git-send-email-hongtao.jia@nxp.com>
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

Also add nodes and properties for thermal management support.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts  |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     | 116 +++++++++++++++++++--
 4 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
index e8801fa..18e99f4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
@@ -46,7 +46,7 @@
 
 /dts-v1/;
 
-/include/ "fsl-ls2080a.dtsi"
+#include "fsl-ls2080a.dtsi"
 
 / {
 	model = "Freescale Layerscape 2080a QDS Board";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
index e127f0b..f1c8115 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
@@ -46,7 +46,7 @@
 
 /dts-v1/;
 
-/include/ "fsl-ls2080a.dtsi"
+#include "fsl-ls2080a.dtsi"
 
 / {
 	model = "Freescale Layerscape 2080a RDB Board";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
index 505d038..290604b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
@@ -46,7 +46,7 @@
 
 /dts-v1/;
 
-/include/ "fsl-ls2080a.dtsi"
+#include "fsl-ls2080a.dtsi"
 
 / {
 	model = "Freescale Layerscape 2080a software Simulator model";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 3187c82..5cc27df 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -44,6 +44,8 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/thermal/thermal.h>
+
 / {
 	compatible = "fsl,ls2080a";
 	interrupt-parent = <&gic>;
@@ -62,56 +64,60 @@
 		 */
 
 		/* We have 4 clusters having 2 Cortex-A57 cores each */
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x0>;
 			clocks = <&clockgen 1 0>;
+			#cooling-cells = <2>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x1>;
 			clocks = <&clockgen 1 0>;
 		};
 
-		cpu@100 {
+		cpu2: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x100>;
 			clocks = <&clockgen 1 1>;
+			#cooling-cells = <2>;
 		};
 
-		cpu@101 {
+		cpu3: cpu@101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x101>;
 			clocks = <&clockgen 1 1>;
 		};
 
-		cpu@200 {
+		cpu4: cpu@200 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x200>;
 			clocks = <&clockgen 1 2>;
+			#cooling-cells = <2>;
 		};
 
-		cpu@201 {
+		cpu5: cpu@201 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x201>;
 			clocks = <&clockgen 1 2>;
 		};
 
-		cpu@300 {
+		cpu6: cpu@300 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x300>;
 			clocks = <&clockgen 1 3>;
+			#cooling-cells = <2>;
 		};
 
-		cpu@301 {
+		cpu7: cpu@301 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x301>;
@@ -191,6 +197,100 @@
 			clocks = <&sysclk>;
 		};
 
+		tmu: tmu@1f80000 {
+			compatible = "fsl,qoriq-tmu";
+			reg = <0x0 0x1f80000 0x0 0x10000>;
+			interrupts = <0 23 0x4>;
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
+			little-endian;
+			#thermal-sensor-cells = <1>;
+		};
+
+		thermal-zones {
+			cpu_thermal: cpu-thermal {
+				polling-delay-passive = <1000>;
+				polling-delay = <5000>;
+
+				thermal-sensors = <&tmu 4>;
+
+				trips {
+					cpu_alert: cpu-alert {
+						temperature = <75000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu_crit: cpu-crit {
+						temperature = <85000>;
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
+					map1 {
+						trip = <&cpu_alert>;
+						cooling-device =
+							<&cpu2 THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+					};
+					map2 {
+						trip = <&cpu_alert>;
+						cooling-device =
+							<&cpu4 THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+					};
+					map3 {
+						trip = <&cpu_alert>;
+						cooling-device =
+							<&cpu6 THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+					};
+				};
+			};
+		};
+
 		serial0: serial@21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21c0500 0x0 0x100>;
-- 
2.1.0.27.g96db324

Return-Path: <hongtao.jia@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0098.outbound.protection.outlook.com [207.46.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLbBy6wNVzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 17:22:18 +1000 (AEST)
From: Jia Hongtao <hongtao.jia@nxp.com>
To: <edubezval@gmail.com>, <rui.zhang@intel.com>, <robh+dt@kernel.org>,
 <galak@codeaurora.org>, <scott.wood@nxp.com>, <shawnguo@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <hongtao.jia@nxp.com>
Subject: [PATCH 4/7] arm:dt:ls1021a: Add TMU device tree support for LS1021A
Date: Fri, 3 Jun 2016 14:57:36 +0800
Message-ID: <1464937059-19349-4-git-send-email-hongtao.jia@nxp.com>
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
 arch/arm/boot/dts/ls1021a.dtsi | 84 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 5ae8e92..1bac9d8 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -47,6 +47,7 @@
 
 #include "skeleton64.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "fsl,ls1021a";
@@ -70,14 +71,15 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@f00 {
+		cpu0: cpu@f00 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0xf00>;
 			clocks = <&cluster1_clk>;
+			#cooling-cells = <2>;
 		};
 
-		cpu@f01 {
+		cpu1: cpu@f01 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0xf01>;
@@ -251,6 +253,84 @@
 			};
 		};
 
+		tmu: tmu@1f00000 {
+			compatible = "fsl,qoriq-tmu";
+			reg = <0x0 0x1f00000 0x0 0x10000>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x30061>;
+			fsl,tmu-calibration = <0x00000000 0x0000000f
+					       0x00000001 0x00000017
+					       0x00000002 0x0000001e
+					       0x00000003 0x00000026
+					       0x00000004 0x0000002e
+					       0x00000005 0x00000035
+					       0x00000006 0x0000003d
+					       0x00000007 0x00000044
+					       0x00000008 0x0000004c
+					       0x00000009 0x00000053
+					       0x0000000a 0x0000005b
+					       0x0000000b 0x00000064
+
+					       0x00010000 0x00000011
+					       0x00010001 0x0000001c
+					       0x00010002 0x00000024
+					       0x00010003 0x0000002b
+					       0x00010004 0x00000034
+					       0x00010005 0x00000039
+					       0x00010006 0x00000042
+					       0x00010007 0x0000004c
+					       0x00010008 0x00000051
+					       0x00010009 0x0000005a
+					       0x0001000a 0x00000063
+
+					       0x00020000 0x00000013
+					       0x00020001 0x00000019
+					       0x00020002 0x00000024
+					       0x00020003 0x0000002c
+					       0x00020004 0x00000035
+					       0x00020005 0x0000003d
+					       0x00020006 0x00000046
+					       0x00020007 0x00000050
+					       0x00020008 0x00000059
+
+					       0x00030000 0x00000002
+					       0x00030001 0x0000000d
+					       0x00030002 0x00000019
+					       0x00030003 0x00000024>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		thermal-zones {
+			cpu_thermal: cpu-thermal {
+				polling-delay-passive = <1000>;
+				polling-delay = <5000>;
+
+				thermal-sensors = <&tmu 0>;
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
 			compatible = "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
-- 
2.1.0.27.g96db324

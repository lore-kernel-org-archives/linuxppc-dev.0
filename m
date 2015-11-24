Return-Path: <hongtao.jia@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0127.outbound.protection.outlook.com [65.55.169.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7ABD11A0289
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 18:14:18 +1100 (AEDT)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <edubezval@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, <scottwood@freescale.com>,
 <hongtao.jia@freescale.com>
Subject: [PATCH V4 3/5] powerpc/mpc85xx: Add TMU device tree support for
 T1040/T1042
Date: Tue, 24 Nov 2015 14:52:46 +0800
Message-ID: <1448347968-37766-4-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1448347968-37766-1-git-send-email-hongtao.jia@freescale.com>
References: <1448347968-37766-1-git-send-email-hongtao.jia@freescale.com>
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

Also add nodes and properties for thermal management support. Meanwhile
preprocessor support is needed using thermal of framework.

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
Reviewed-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/fsl/t1040d4rdb.dts    |  2 +-
 arch/powerpc/boot/dts/fsl/t1040qds.dts      |  2 +-
 arch/powerpc/boot/dts/fsl/t1040rdb.dts      |  2 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi | 94 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1042d4rdb.dts    |  2 +-
 arch/powerpc/boot/dts/fsl/t1042qds.dts      |  2 +-
 arch/powerpc/boot/dts/fsl/t1042rdb.dts      |  2 +-
 arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts   |  2 +-
 arch/powerpc/boot/dts/fsl/t1042si-post.dtsi |  2 +-
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi  |  4 ++
 10 files changed, 106 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1040d4rdb.dts b/arch/powerpc/boot/dts/fsl/t1040d4rdb.dts
index 681746e..fb6bc02 100644
--- a/arch/powerpc/boot/dts/fsl/t1040d4rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040d4rdb.dts
@@ -43,4 +43,4 @@
 	interrupt-parent = <&mpic>;
 };
 
-/include/ "t1040si-post.dtsi"
+#include "t1040si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/t1040qds.dts b/arch/powerpc/boot/dts/fsl/t1040qds.dts
index 4d29865..5f76edc 100644
--- a/arch/powerpc/boot/dts/fsl/t1040qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040qds.dts
@@ -43,4 +43,4 @@
 	interrupt-parent = <&mpic>;
 };
 
-/include/ "t1040si-post.dtsi"
+#include "t1040si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/t1040rdb.dts b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
index 8f9e65b..cf19415 100644
--- a/arch/powerpc/boot/dts/fsl/t1040rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
@@ -45,4 +45,4 @@
 	};
 };
 
-/include/ "t1040si-post.dtsi"
+#include "t1040si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index d30b3de..e0f4da5 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -32,6 +32,8 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+#include <dt-bindings/thermal/thermal.h>
+
 &bman_fbpr {
 	compatible = "fsl,bman-fbpr";
 	alloc-ranges = <0 0 0x10000 0>;
@@ -484,6 +486,98 @@
 		reg	   = <0xea000 0x4000>;
 	};
 
+	tmu: tmu@f0000 {
+		compatible = "fsl,qoriq-tmu";
+		reg = <0xf0000 0x1000>;
+		interrupts = <18 2 0 0>;
+		fsl,tmu-range = <0xa0000 0x90026 0x8004a 0x1006a>;
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
+		#thermal-sensor-cells = <0>;
+	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+
+			thermal-sensors = <&tmu>;
+
+			trips {
+				cpu_alert: cpu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit: cpu-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device =
+						<&cpu0 THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_alert>;
+					cooling-device =
+						<&cpu1 THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+				};
+				map2 {
+					trip = <&cpu_alert>;
+					cooling-device =
+						<&cpu2 THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+				};
+				map3 {
+					trip = <&cpu_alert>;
+					cooling-device =
+						<&cpu3 THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	scfg: global-utilities@fc000 {
 		compatible = "fsl,t1040-scfg";
 		reg = <0xfc000 0x1000>;
diff --git a/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts b/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
index b245b31..2a5a90d 100644
--- a/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
@@ -50,4 +50,4 @@
 	};
 };
 
-/include/ "t1040si-post.dtsi"
+#include "t1042si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/t1042qds.dts b/arch/powerpc/boot/dts/fsl/t1042qds.dts
index 4ab9bbe..90a4a73 100644
--- a/arch/powerpc/boot/dts/fsl/t1042qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042qds.dts
@@ -43,4 +43,4 @@
 	interrupt-parent = <&mpic>;
 };
 
-/include/ "t1042si-post.dtsi"
+#include "t1042si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/t1042rdb.dts b/arch/powerpc/boot/dts/fsl/t1042rdb.dts
index 67af56b..8d908e7 100644
--- a/arch/powerpc/boot/dts/fsl/t1042rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042rdb.dts
@@ -45,4 +45,4 @@
 	};
 };
 
-/include/ "t1042si-post.dtsi"
+#include "t1042si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts b/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts
index 2f67677..98c0010 100644
--- a/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts
@@ -54,4 +54,4 @@
 	};
 };
 
-/include/ "t1042si-post.dtsi"
+#include "t1042si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/t1042si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
index 319b74f..a5544f9 100644
--- a/arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
@@ -32,6 +32,6 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "t1040si-post.dtsi"
+#include "t1040si-post.dtsi"
 
 /* Place holder for ethernet related device tree nodes */
diff --git a/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
index fcfa38a..6db0ee8 100644
--- a/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
@@ -76,6 +76,7 @@
 			reg = <0>;
 			clocks = <&mux0>;
 			next-level-cache = <&L2_1>;
+			#cooling-cells = <2>;
 			L2_1: l2-cache {
 				next-level-cache = <&cpc>;
 			};
@@ -85,6 +86,7 @@
 			reg = <1>;
 			clocks = <&mux1>;
 			next-level-cache = <&L2_2>;
+			#cooling-cells = <2>;
 			L2_2: l2-cache {
 				next-level-cache = <&cpc>;
 			};
@@ -94,6 +96,7 @@
 			reg = <2>;
 			clocks = <&mux2>;
 			next-level-cache = <&L2_3>;
+			#cooling-cells = <2>;
 			L2_3: l2-cache {
 				next-level-cache = <&cpc>;
 			};
@@ -103,6 +106,7 @@
 			reg = <3>;
 			clocks = <&mux3>;
 			next-level-cache = <&L2_4>;
+			#cooling-cells = <2>;
 			L2_4: l2-cache {
 				next-level-cache = <&cpc>;
 			};
-- 
2.1.0.27.g96db324

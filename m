Return-Path: <chenhui.zhao@nxp.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0075.outbound.protection.outlook.com [104.47.37.75])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3dvw4SBxzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 00:32:43 +1000 (AEST)
From: Chenhui Zhao <chenhui.zhao@nxp.com>
To: <oss@buserror.net>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
CC: <jason.jin@nxp.com>, <z.chenhui@gmail.com>, Chenhui Zhao
 <chenhui.zhao@nxp.com>
Subject: [PATCH v3 1/5] powerpc/dts: add mcke-gpios for PM feature
Date: Tue, 2 Aug 2016 19:59:27 +0800
Message-ID: <1470139172-12699-1-git-send-email-chenhui.zhao@nxp.com>
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

Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
---
 Documentation/devicetree/bindings/soc/fsl/rcpm.txt | 13 +++++++++++++
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
index e284e4e..1d44a80 100644
--- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
@@ -21,6 +21,10 @@ Required properites:
 	* "fsl,qoriq-rcpm-2.0": for chassis 2.0 rcpm
 	* "fsl,qoriq-rcpm-2.1": for chassis 2.1 rcpm
 
+Optional properites:
+  - mcke-gpios : The GPIO pin is used for keeping the MCKE signal of DDR modules
+		 low in the LPM35 state on some platforms, such as T1040.
+
 All references to "1.0" and "2.0" refer to the QorIQ chassis version to
 which the chip complies.
 Chassis Version		Example Chips
@@ -37,6 +41,15 @@ The RCPM node for T4240:
 		fsl,#rcpm-wakeup-cells = <2>;
 	};
 
+The RCPM node for T1040 (which supports LPM35 state):
+	rcpm: global-utilities@e2000 {
+		compatible = "fsl,t1040-rcpm", "fsl,qoriq-rcpm-2.1";
+		reg = <0xe2000 0x1000>;
+		fsl,#rcpm-wakeup-cells = <1>;
+		mcke-gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>
+	};
+
+
 * Freescale RCPM Wakeup Source Device Tree Bindings
 -------------------------------------------
 Required fsl,rcpm-wakeup property should be added to a device node if the device
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 507649e..f66e7dd 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -33,6 +33,7 @@
  */
 
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/gpio/gpio.h>
 
 &bman_fbpr {
 	compatible = "fsl,bman-fbpr";
@@ -474,6 +475,8 @@
 	rcpm: global-utilities@e2000 {
 		compatible = "fsl,t1040-rcpm", "fsl,qoriq-rcpm-2.1";
 		reg = <0xe2000 0x1000>;
+		fsl,#rcpm-wakeup-cells = <1>;
+		mcke-gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
 	};
 
 	sfp: sfp@e8000 {
-- 
1.9.1

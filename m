Return-Path: <Dongsheng.Wang@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8F09A2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 17:29:58 +1100 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>, <galak@codeaurora.org>
Subject: [PATCH 1/2] powerpc/dts: fix lbc lack of error interrupt
Date: Tue, 7 Jan 2014 14:26:42 +0800
Message-ID: <1389076002-18674-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

P1020, P1021, P1022, P1023 when the lbc get error, the error
interrupt will be triggered. The corresponding interrupt is
internal IRQ0. So system have to process the lbc IRQ0 interrupt.

The corresponding lbc general interrupt is internal IRQ3.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
index 68cc5e7..13f209f 100644
--- a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
@@ -36,7 +36,8 @@
 	#address-cells = <2>;
 	#size-cells = <1>;
 	compatible = "fsl,p1020-elbc", "fsl,elbc", "simple-bus";
-	interrupts = <19 2 0 0>;
+	interrupts = <19 2 0 0
+		      16 2 0 0>;
 };
 
 /* controller at 0x9000 */
diff --git a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
index adb82fd..cffc93e 100644
--- a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
@@ -36,7 +36,8 @@
 	#address-cells = <2>;
 	#size-cells = <1>;
 	compatible = "fsl,p1021-elbc", "fsl,elbc", "simple-bus";
-	interrupts = <19 2 0 0>;
+	interrupts = <19 2 0 0
+		      16 2 0 0>;
 };
 
 /* controller at 0x9000 */
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index e179803..979670d 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -40,7 +40,8 @@
 	 * pin muxing when the DIU is enabled.
 	 */
 	compatible = "fsl,p1022-elbc", "fsl,elbc";
-	interrupts = <19 2 0 0>;
+	interrupts = <19 2 0 0
+		      16 2 0 0>;
 };
 
 /* controller at 0x9000 */
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
index f1105bf..f5f5043 100644
--- a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
@@ -36,7 +36,8 @@
 	#address-cells = <2>;
 	#size-cells = <1>;
 	compatible = "fsl,p1023-elbc", "fsl,elbc", "simple-bus";
-	interrupts = <19 2 0 0>;
+	interrupts = <19 2 0 0
+		      16 2 0 0>;
 };
 
 /* controller at 0xa000 */
-- 
1.8.5

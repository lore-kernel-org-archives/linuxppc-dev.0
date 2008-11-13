Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E2DBDDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 19:56:47 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] katmai.dts: extend DMA ranges; add dma/sysace nodes
Date: Thu, 13 Nov 2008 11:49:14 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811131149.14715.yur@emcraft.com>
Cc: Ilya Yanok <yanok@emcraft.com>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

This patch extends DMA ranges for PCI(X) to 4GB, so that it could
work on Katmais with 4GB RAM installed.

Add new nodes for the PPC440SPe DMA, XOR engines to
be used in the PPC440SPe ADMA driver, and the SysACE
controller, which connects Compact Flash to Katmai.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
---
 arch/powerpc/boot/dts/katmai.dts |   46 +++++++++++++++++++++++++++++++------
 1 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index 077819b..7749478 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -245,8 +245,8 @@
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000d 0x80000000 0x00000000 0x80000000
 				  0x01000000 0x00000000 0x00000000 0x0000000c 0x08000000 0x00000000 0x00010000>;
 
-			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
+			/* Inbound 4GB range starting at 0 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
 
 			/* This drives busses 0 to 0xf */
 			bus-range = <0x0 0xf>;
@@ -289,8 +289,8 @@
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x00000000 0x00000000 0x80000000
 				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80000000 0x00000000 0x00010000>;
 
-			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
+			/* Inbound 4GB range starting at 0 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
 
 			/* This drives busses 10 to 0x1f */
 			bus-range = <0x10 0x1f>;
@@ -330,8 +330,8 @@
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x80000000 0x00000000 0x80000000
 				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80010000 0x00000000 0x00010000>;
 
-			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
+			/* Inbound 4GB range starting at 0 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
 
 			/* This drives busses 10 to 0x1f */
 			bus-range = <0x20 0x2f>;
@@ -371,8 +371,8 @@
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000f 0x00000000 0x00000000 0x80000000
 				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80020000 0x00000000 0x00010000>;
 
-			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
+			/* Inbound 4GB range starting at 0 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
 
 			/* This drives busses 10 to 0x1f */
 			bus-range = <0x30 0x3f>;
@@ -392,6 +392,36 @@
 				0x0 0x0 0x0 0x3 &UIC3 0xa 0x4 /* swizzled int C */
 				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /* swizzled int D */>;
 		};
+		DMA0: dma0 {
+			interrupt-parent = <&DMA0>;
+			interrupts = <0 1>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = <
+				0 &UIC0 0x14 4
+				1 &UIC1 0x16 4>;
+		};
+		DMA1: dma1 {
+			interrupt-parent = <&DMA1>;
+			interrupts = <0 1>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = <
+				0 &UIC0 0x16 4
+				1 &UIC1 0x16 4>;
+		};
+		xor {
+			interrupt-parent = <&UIC1>;
+			interrupts = <0x1f 4>;
+		};
+		sysacecf@4fe000000 {
+			compatible = "xlnx,opb-sysace-1.00.b";
+			interrupt-parent = <&UIC2>;
+			interrupts = <0x19 4>;
+			reg = <0x00000004 0xfe000000 0x100>;
+		};
 	};
 
 	chosen {
-- 
1.5.6.1


-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com

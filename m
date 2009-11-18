Return-Path: <pbathija@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AE8F31007D3
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 11:19:51 +1100 (EST)
From: pbathija@amcc.com
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [PPC4xx] Fix device tree dts file for katmai board.
Date: Tue, 17 Nov 2009 16:19:48 -0800
Message-Id: <1258503588-7844-1-git-send-email-pbathija@amcc.com>
Cc: Pravin Bathija <pbathija@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Pravin Bathija <pbathija@amcc.com>

   Set size cell value to 2 for 4GB memory support in katmai. Also set PCI-E
   node inbound DMA ranges size to 4GB for correct boot up of katmai.
Content-Type: text/plain; charset=utf-8

Signed-off-by: Pravin Bathija <pbathija@amcc.com>
Acked-by: Feng Kan <fkan@amcc.com>
Acked-by: Prodyut Hazarika <phazarika@amcc.com>
Acked-by: Loc Ho <lho@amcc.com>
Acked-by: Tirumala Reddy Marri <tmarri@amcc.com>
Acked-by: Victor Gallardo <vgallardo@amcc.com>
---
 arch/powerpc/boot/dts/katmai.dts |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index 077819b..8b40fd8 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -16,7 +16,7 @@
 
 / {
 	#address-cells = <2>;
-	#size-cells = <1>;
+	#size-cells = <2>;
 	model = "amcc,katmai";
 	compatible = "amcc,katmai";
 	dcr-parent = <&{/cpus/cpu@0}>;
@@ -49,7 +49,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by zImage */
+		reg = < 0x0 0x00000000 0x0 0x00000000>; /* Filled in by zImage */
 	};
 
 	UIC0: interrupt-controller0 {
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
-- 
1.5.5

Return-Path: <B25806@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C429DB6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Aug 2011 18:40:54 +1000 (EST)
Received: from mail118-ch1 (localhost.localdomain [127.0.0.1])	by
	mail118-ch1-R.bigfish.com (Postfix) with ESMTP id 697382E026D	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2011 08:40:49 +0000 (UTC)
Received: from CH1EHSMHS008.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.247])	by mail118-ch1.bigfish.com (Postfix) with ESMTP id
	35514192004B	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Aug 2011 08:40:49 +0000 (UTC)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/p1023rds: Add nand flash node support in the dts
Date: Mon, 15 Aug 2011 16:43:10 +0800
Message-ID: <1313397790-15432-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, kumar.gala@freescale.com,
	Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the p1023rds, accessing exclusively nor flash or nand flash
device by BR0/OR0. When booting from nor flash, nand node is
disabled and nor node is enabled in the default dts. So, when
booting from nand flash, u-boot should do some operations:

   o The "status" property of nand node should be enabled.
   o The "status" property of nor node should be disabled.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 arch/powerpc/boot/dts/p1023rds.dts |   46 +++++++++++++++++++++++++++++++++--
 1 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1023rds.dts b/arch/powerpc/boot/dts/p1023rds.dts
index d9b7767..aa63b81 100644
--- a/arch/powerpc/boot/dts/p1023rds.dts
+++ b/arch/powerpc/boot/dts/p1023rds.dts
@@ -58,6 +58,9 @@
 		rtic_b = &rtic_b;
 		rtic_c = &rtic_c;
 		rtic_d = &rtic_d;
+
+		nor_flash = &nor_flash;
+		nand_flash = &nand_flash;
 	};
 
 	cpus {
@@ -378,11 +381,12 @@
 		interrupts = <19 2>;
 		interrupt-parent = <&mpic>;
 
-		/* NOR Flash, BCSR */
+		/* NOR Flash, BCSR, NAND Flash */
 		ranges = <0x0 0x0 0x0 0xee000000 0x02000000
-			  0x1 0x0 0x0 0xe0000000 0x00008000>;
+			  0x1 0x0 0x0 0xe0000000 0x00008000
+			  0x2 0x0 0x0 0xffa00000 0x00040000>;
 
-		nor@0,0 {
+		nor_flash: nor@0,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "cfi-flash";
@@ -425,6 +429,42 @@
 				reg = <0x20 0x20>;
 			};
 		};
+
+		nand_flash: nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,p1023-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <0x2 0x0 0x00040000>;
+			status = "disabled";
+
+			u-boot-nand@0 {
+				/* This location must not be altered  */
+				/* 1MB for u-boot Bootloader Image */
+				reg = <0x0 0x00100000>;
+				read-only;
+			};
+
+			dtb-nand@100000 {
+				/* 1MB for DTB Image */
+				reg = <0x00100000 0x00100000>;
+			};
+
+			kernel-nand@200000 {
+				/* 4MB for Linux Kernel Image */
+				reg = <0x00200000 0x00400000>;
+			};
+
+			ramdisk-nand@600000 {
+				/* 57MB for Compressed Root file System Image */
+				reg = <0x00600000 0x03900000>;
+			};
+
+			empty-nand@3f00000 {
+				/* 1MB for reserved space */
+				reg = <0x03f00000 0x00100000>;
+			};
+		};
 	};
 
 	pci0: pcie@ff60a000 {
-- 
1.5.6.5

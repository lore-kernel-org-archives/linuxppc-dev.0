Return-Path: <B38951@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe006.messaging.microsoft.com
 [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8BC7B6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2012 13:16:28 +1100 (EST)
Received: from mail66-am1 (localhost [127.0.0.1])	by mail66-am1-R.bigfish.com
 (Postfix) with ESMTP id E4680380148	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 21 Feb 2012 02:16:17 +0000 (UTC)
Received: from AM1EHSMHS012.bigfish.com (unknown [10.3.201.248])	by
 mail66-am1.bigfish.com (Postfix) with ESMTP id 601F620007C	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2012 02:16:16 +0000 (UTC)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Clean up partition nodes in dts for MPC8572DS
Date: Tue, 21 Feb 2012 10:11:23 +0800
Message-ID: <1329790283-22962-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8572ds.dtsi |   50 +++++++++++++++++++++------------
 1 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8572ds.dtsi b/arch/powerpc/boot/dts/mpc8572ds.dtsi
index c3d4fac..1417894 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dtsi
+++ b/arch/powerpc/boot/dts/mpc8572ds.dtsi
@@ -41,37 +41,47 @@
 		bank-width = <2>;
 		device-width = <1>;
 
-		ramdisk@0 {
+		partition@0 {
 			reg = <0x0 0x03000000>;
-			read-only;
+			label = "ramdisk-nor";
 		};
 
-		diagnostic@3000000 {
+		partition@3000000 {
 			reg = <0x03000000 0x00e00000>;
+			label = "diagnostic-nor";
 			read-only;
 		};
 
-		dink@3e00000 {
+		partition@3e00000 {
 			reg = <0x03e00000 0x00200000>;
+			label = "dink-nor";
 			read-only;
 		};
 
-		kernel@4000000 {
+		partition@4000000 {
 			reg = <0x04000000 0x00400000>;
-			read-only;
+			label = "kernel-nor";
 		};
 
-		jffs2@4400000 {
+		partition@4400000 {
 			reg = <0x04400000 0x03b00000>;
+			label = "fs-nor";
+		};
+
+		partition@7f00000 {
+			reg = <0x07f00000 0x00060000>;
+			label = "dtb-nor";
 		};
 
-		dtb@7f00000 {
-			reg = <0x07f00000 0x00080000>;
+		partition@7f60000 {
+			reg = <0x07f60000 0x00020000>;
+			label = "env-nor";
 			read-only;
 		};
 
-		u-boot@7f80000 {
+		partition@7f80000 {
 			reg = <0x07f80000 0x00080000>;
+			label = "u-boot-nor";
 			read-only;
 		};
 	};
@@ -83,31 +93,35 @@
 			     "fsl,elbc-fcm-nand";
 		reg = <0x2 0x0 0x40000>;
 
-		u-boot@0 {
+		partition@0 {
 			reg = <0x0 0x02000000>;
+			label = "u-boot-nand";
 			read-only;
 		};
 
-		jffs2@2000000 {
+		partition@2000000 {
 			reg = <0x02000000 0x10000000>;
+			label = "fs-nand";
 		};
 
-		ramdisk@12000000 {
+		partition@12000000 {
 			reg = <0x12000000 0x08000000>;
-			read-only;
+			label = "ramdisk-nand";
 		};
 
-		kernel@1a000000 {
+		partition@1a000000 {
 			reg = <0x1a000000 0x04000000>;
+			label = "kernel-nand";
 		};
 
-		dtb@1e000000 {
+		partition@1e000000 {
 			reg = <0x1e000000 0x01000000>;
-			read-only;
+			label = "dtb-nand";
 		};
 
-		empty@1f000000 {
+		partition@1f000000 {
 			reg = <0x1f000000 0x21000000>;
+			label = "empty-nand";
 		};
 	};
 
-- 
1.7.5.1

Return-Path: <B21989@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 410341007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 20:01:25 +1000 (EST)
Received: from mail67-am1 (localhost [127.0.0.1])	by mail67-am1-R.bigfish.com
 (Postfix) with ESMTP id 168CF4A02B7	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 29 Jun 2012 09:59:31 +0000 (UTC)
Received: from AM1EHSMHS009.bigfish.com (unknown [10.3.201.247])	by
 mail67-am1.bigfish.com (Postfix) with ESMTP id 141EF60043	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 09:59:30 +0000 (UTC)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/p2041rdb: add NAND node in device tree
Date: Fri, 29 Jun 2012 17:41:11 +0800
Message-ID: <1340962871-10617-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NAND on p2041 uses CS1 as chip select.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 arch/powerpc/boot/dts/p2041rdb.dts |   41 +++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/p2041rdb.dts b/arch/powerpc/boot/dts/p2041rdb.dts
index 2852139..baab034 100644
--- a/arch/powerpc/boot/dts/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/p2041rdb.dts
@@ -121,7 +121,8 @@
 
 	lbc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x1000>;
-		ranges = <0 0 0xf 0xe8000000 0x08000000>;
+		ranges = <0 0 0xf 0xe8000000 0x08000000
+			  1 0 0xf 0xffa00000 0x00040000>;
 
 		flash@0,0 {
 			compatible = "cfi-flash";
@@ -129,6 +130,44 @@
 			bank-width = <2>;
 			device-width = <2>;
 		};
+
+		nand@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,elbc-fcm-nand";
+			reg = <0x1 0x0 0x40000>;
+
+			partition@0 {
+				label = "NAND U-Boot Image";
+				reg = <0x0 0x02000000>;
+				read-only;
+			};
+
+			partition@2000000 {
+				label = "NAND Root File System";
+				reg = <0x02000000 0x10000000>;
+			};
+
+			partition@12000000 {
+				label = "NAND Compressed RFS Image";
+				reg = <0x12000000 0x08000000>;
+			};
+
+			partition@1a000000 {
+				label = "NAND Linux Kernel Image";
+				reg = <0x1a000000 0x04000000>;
+			};
+
+			partition@1e000000 {
+				label = "NAND DTB Image";
+				reg = <0x1e000000 0x01000000>;
+			};
+
+			partition@1f000000 {
+				label = "NAND Writable User area";
+				reg = <0x1f000000 0x01000000>;
+			};
+		};
 	};
 
 	pci0: pcie@ffe200000 {
-- 
1.6.4

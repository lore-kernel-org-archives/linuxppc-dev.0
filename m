Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 982121007E3
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2011 09:09:05 +1100 (EST)
Received: from mail49-db3 (localhost [127.0.0.1])	by mail49-db3-R.bigfish.com
 (Postfix) with ESMTP id CDDBB2C0123	for <linuxppc-dev@ozlabs.org>;
 Fri,  2 Dec 2011 22:08:59 +0000 (UTC)
Received: from DB3EHSMHS005.bigfish.com (unknown [10.3.81.252])	by
 mail49-db3.bigfish.com (Postfix) with ESMTP id AD18B700042	for
 <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 22:08:59 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc/85xx: fix localbus and PCI addresses in the
 P1022DS 36-bit device tree
Date: Fri, 2 Dec 2011 16:08:33 -0600
Message-ID: <1322863714-6818-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the PCI buses in the 36-bit device tree for the P1022DS.  It was using
values copy-pasted from another device tree.

Also fix the NAND localbus bus address from ffa00000 to ff800000, which is
what U-boot sets it to.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/p1022ds.dts |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 3e85d8c..a54dd13 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -21,7 +21,7 @@
 		reg = <0xf 0xffe05000 0 0x1000>;
 		ranges = <0x0 0x0 0xf 0xe8000000 0x08000000
 			  0x1 0x0 0xf 0xe0000000 0x08000000
-			  0x2 0x0 0xf 0xffa00000 0x00040000
+			  0x2 0x0 0xf 0xff800000 0x00040000
 			  0x3 0x0 0xf 0xffdf0000 0x00008000>;
 
 		/*
@@ -222,7 +222,7 @@
 
 	pci0: pcie@fffe09000 {
 		reg = <0xf 0xffe09000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xa0000000 0xc 0x20000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
@@ -237,7 +237,7 @@
 
 	pci1: pcie@fffe0a000 {
 		reg = <0xf 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xc0000000 0xc 0x40000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x40000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc20000 0x0 0x10000>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
@@ -253,7 +253,7 @@
 
 	pci2: pcie@fffe0b000 {
 		reg = <0xf 0xffe0b000 0 0x1000>;
-		ranges = <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
-- 
1.7.3.4

Return-Path: <B21989@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 39F742C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 21:09:42 +1000 (EST)
Received: from mail214-tx2 (localhost [127.0.0.1])	by
 mail214-tx2-R.bigfish.com (Postfix) with ESMTP id BAB05C01D9	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 11:09:37 +0000 (UTC)
Received: from TX2EHSMHS032.bigfish.com (unknown [10.9.14.252])	by
 mail214-tx2.bigfish.com (Postfix) with ESMTP id 8BBA63C0048	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 11:09:36 +0000 (UTC)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/p5040: fix dtb build warning of p5040ds.dtb
Date: Wed, 12 Sep 2012 18:36:03 +0800
Message-ID: <1347446163-15470-1-git-send-email-Shaohui.Xie@freescale.com>
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

Device node adt7461 was wrongly added in p5040ds.dts, it should be added
into i2c instead of localbus, when build p5040ds.dtb, a warning will dump:

Warning (reg_format): "reg" property in
/localbus@ffe124000/nand@2,0/adt7461@4c has invalid length (4 bytes)
(#address-cells == 1, #size-cells == 1)

This was introduced by:

commit ea6b1ba692bcb5f6e39f409a78cf8b04fdf23baa
Author: Jia Hongtao <B38951@freescale.com>
Date:   Tue Aug 28 10:00:55 2012 +0800

    powerpc: add adt7461 thermal monitor support to applicable boards

    Add thermal monitor support to following boards:
    P1022DS, MPC8536DS, P2041RDB, P3041DS, P4080DS, P5020DS, P5040DS

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
based on next branch of http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git

 arch/powerpc/boot/dts/p5040ds.dts |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/p5040ds.dts b/arch/powerpc/boot/dts/p5040ds.dts
index 8165c93..860b5cc 100644
--- a/arch/powerpc/boot/dts/p5040ds.dts
+++ b/arch/powerpc/boot/dts/p5040ds.dts
@@ -95,6 +95,10 @@
 				reg = <0x68>;
 				interrupts = <0x1 0x1 0 0>;
 			};
+			adt7461@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
 		};
 	};
 
@@ -146,10 +150,6 @@
 				label = "NAND Writable User area";
 				reg = <0x1f000000 0x01000000>;
 			};
-			adt7461@4c {
-				compatible = "adi,adt7461";
-				reg = <0x4c>;
-			};
 		};
 
 		board-control@3,0 {
-- 
1.6.4

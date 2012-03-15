Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3B622B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 04:39:26 +1100 (EST)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/p2020rdb: move the NAND address.
Date: Thu, 15 Mar 2012 18:40:27 +0100
Message-Id: <1331833228-14903-1-git-send-email-bigeasy@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is not at 0xffa00000. According to current u-boot source the NAND
controller is always at 0xff800000 and it is either at CS0 or CS1
depending on NAND or NAND+NOR mode. In 36bit mode it is shifted to
0xfff800000 but it has always an eight there and never an A.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/boot/dts/p2020rdb.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
index eb8a6aa..8f25ef2 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -34,7 +34,7 @@
 
 		/* NOR and NAND Flashes */
 		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
-			  0x1 0x0 0x0 0xffa00000 0x00040000
+			  0x1 0x0 0x0 0xff800000 0x00040000
 			  0x2 0x0 0x0 0xffb00000 0x00020000>;
 
 		nor@0,0 {
-- 
1.7.9.1

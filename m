Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A359EDDE04
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 01:17:15 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m06EGRiT021441
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Jan 2008 07:17:00 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m06EGQP2013349
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Jan 2008 08:16:26 -0600 (CST)
From: Liu Yu <Yu.Liu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix remainder calculating bug in single floating point
	division
Date: Sun,  6 Jan 2008 22:26:53 +0800
Message-Id: <11996296134110-git-send-email-Yu.Liu@freescale.com>
Cc: Liu Yu <Yu.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This bug exists in the emulation of floating point division for powerpc.

The original code cannot count the remainder correctly. 
I can provide a test case to trigger this bug. 
When use fdiv to count 1.1754941e-38f / 0.9999999f, 
the result is expected to be 1.175494e-38f, 
but we will get 1.174921e-38f in the original case.

Comments are always welcomed!

Signed-off-by: Liu Yu <Yu.Liu@freescale.com>
---
 arch/powerpc/math-emu/sfp-machine.h |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/math-emu/sfp-machine.h b/arch/powerpc/math-emu/sfp-machine.h
index 4b17d83..644cee2 100644
--- a/arch/powerpc/math-emu/sfp-machine.h
+++ b/arch/powerpc/math-emu/sfp-machine.h
@@ -324,10 +324,10 @@ extern int  fp_pack_ds(void *, long, unsigned long, unsigned long, long, long);
     __r1 = __r1 * __ll_B | __ll_highpart (n0);				\
     if (__r1 < __m)							\
       {									\
-	__q1--, __r1 += (d);						\
-	if (__r1 >= (d)) /* we didn't get carry when adding to __r1 */	\
-	  if (__r1 < __m)						\
+	do {								\
 	    __q1--, __r1 += (d);					\
+	  /* we didn't get carry when adding to __r1 */			\
+	} while (__r1 >= (d) && __r1 < __m);				\
       }									\
     __r1 -= __m;							\
 									\
@@ -337,10 +337,9 @@ extern int  fp_pack_ds(void *, long, unsigned long, unsigned long, long, long);
     __r0 = __r0 * __ll_B | __ll_lowpart (n0);				\
     if (__r0 < __m)							\
       {									\
-	__q0--, __r0 += (d);						\
-	if (__r0 >= (d))						\
-	  if (__r0 < __m)						\
+	do {								\
 	    __q0--, __r0 += (d);					\
+	} while (__r0 >= (d) && __r0 < __m);				\
       }									\
     __r0 -= __m;							\
 									\
-- 
1.5.2

Return-Path: <Yu.Liu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 60BEBDDE04
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 01:15:55 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m06EFnbu021774
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Jan 2008 07:15:50 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m06EFlIT002550
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Jan 2008 08:15:49 -0600 (CST)
From: Liu Yu <Yu.Liu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix carry bug in 128-bit unsigned integer adding
Date: Sun,  6 Jan 2008 22:26:14 +0800
Message-Id: <11996295742378-git-send-email-Yu.Liu@freescale.com>
Cc: Liu Yu <Yu.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This bug exists in math emulation for powerpc.
The macro define are mainly used by multiplication.

When adding two unsigned operands ( r = x + y ),
the carry bit can be counted by whether r is less than x.
However, when adding three unsigned operands, this method does not work.

The original code below uses this method to count carry,
it apparently overlook the case of three operands. 
Assume all the operands is 32-bit wide,
( r = x + y + last_carry , x = 0, y = 0xffffffff, last_carry = 1),
then r is no less than x but it actually gets a carry.

I tried to fix this bug, but this patch seems not that pretty.
Are there any better ideas? 
Comments are always welcomed!


Signed-off-by: Liu Yu <Yu.Liu@freescale.com>
---
 arch/powerpc/math-emu/op-4.h |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/math-emu/op-4.h b/arch/powerpc/math-emu/op-4.h
index fcdd6d0..93c7390 100644
--- a/arch/powerpc/math-emu/op-4.h
+++ b/arch/powerpc/math-emu/op-4.h
@@ -195,18 +195,24 @@
 
 #ifndef __FP_FRAC_ADD_4
 #define __FP_FRAC_ADD_4(r3,r2,r1,r0,x3,x2,x1,x0,y3,y2,y1,y0)		\
-  (r0 = x0 + y0,							\
-   r1 = x1 + y1 + (r0 < x0),						\
-   r2 = x2 + y2 + (r1 < x1),						\
-   r3 = x3 + y3 + (r2 < x2))
+   do {									\
+	_FP_W_TYPE _x0 = x0, _x1 = x1, _x2 = x2, _y1 = y1, _y2 = y2; 	\
+	r0 = x0 + y0;							\
+	r1 = x1 + y1 + (r0 < _x0);					\
+	r2 = x2 + y2 + (r1 < _x1 || (r1 == _x1 && !(_y1 + 1)));		\
+	r3 = x3 + y3 + (r2 < _x2 || (r2 == _x2 && !(_y2 + 1)));		\
+   } while(0)
 #endif
 
 #ifndef __FP_FRAC_SUB_4
 #define __FP_FRAC_SUB_4(r3,r2,r1,r0,x3,x2,x1,x0,y3,y2,y1,y0)		\
-  (r0 = x0 - y0,                                                        \
-   r1 = x1 - y1 - (r0 > x0),                                            \
-   r2 = x2 - y2 - (r1 > x1),                                            \
-   r3 = x3 - y3 - (r2 > x2))
+   do {									\
+	_FP_W_TYPE _x0 = x0, _x1 = x1, _x2 = x2, _y1 = y1, _y2 = y2; 	\
+	r0 = x0 - y0;							\
+	r1 = x1 - y1 - (r0 > _x0);					\
+	r2 = x2 - y2 - (r1 > _x1 || (r1 == _x1 && !(_y1 + 1)));		\
+	r3 = x3 - y3 - (r2 > _x2 || (r2 == _x2 && !(_y2 + 1)));		\
+   } while(0)
 #endif
 
 #ifndef __FP_FRAC_ADDI_4
-- 

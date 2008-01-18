Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B0ABBDDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 14:11:06 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m0I3B09O013836
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 20:11:00 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0I3Axof014506
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 21:10:59 -0600 (CST)
From: Liu Yu <Yu.Liu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix carry bug in 128-bit unsigned integer adding
Date: Fri, 18 Jan 2008 11:21:39 +0800
Message-Id: <12006264992105-git-send-email-Yu.Liu@freescale.com>
Cc: Liu Yu <Yu.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Synchronize it to the definition in include/math-emu/op-4.h for short term.

Signed-off-by: Liu Yu <Yu.Liu@freescale.com>
---
 arch/powerpc/math-emu/op-4.h |   40 ++++++++++++++++++++++++++++++----------
 1 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/math-emu/op-4.h b/arch/powerpc/math-emu/op-4.h
index fcdd6d0..c9ae626 100644
--- a/arch/powerpc/math-emu/op-4.h
+++ b/arch/powerpc/math-emu/op-4.h
@@ -194,19 +194,39 @@
   (X##_f[3] = I3, X##_f[2] = I2, X##_f[1] = I1, X##_f[0] = I0)
 
 #ifndef __FP_FRAC_ADD_4
-#define __FP_FRAC_ADD_4(r3,r2,r1,r0,x3,x2,x1,x0,y3,y2,y1,y0)		\
-  (r0 = x0 + y0,							\
-   r1 = x1 + y1 + (r0 < x0),						\
-   r2 = x2 + y2 + (r1 < x1),						\
-   r3 = x3 + y3 + (r2 < x2))
+#define __FP_FRAC_ADD_4(r3,r2,r1,r0,x3,x2,x1,x0,y3,y2,y1,y0)	\
+  do {								\
+    int _c1, _c2, _c3;						\
+    r0 = x0 + y0;						\
+    _c1 = r0 < x0;						\
+    r1 = x1 + y1;						\
+    _c2 = r1 < x1;						\
+    r1 += _c1;							\
+    _c2 |= r1 < _c1;						\
+    r2 = x2 + y2;						\
+    _c3 = r2 < x2;						\
+    r2 += _c2;							\
+    _c3 |= r2 < _c2;						\
+    r3 = x3 + y3 + _c3;						\
+  } while (0)
 #endif
 
 #ifndef __FP_FRAC_SUB_4
-#define __FP_FRAC_SUB_4(r3,r2,r1,r0,x3,x2,x1,x0,y3,y2,y1,y0)		\
-  (r0 = x0 - y0,                                                        \
-   r1 = x1 - y1 - (r0 > x0),                                            \
-   r2 = x2 - y2 - (r1 > x1),                                            \
-   r3 = x3 - y3 - (r2 > x2))
+#define __FP_FRAC_SUB_4(r3,r2,r1,r0,x3,x2,x1,x0,y3,y2,y1,y0)	\
+  do {								\
+    int _c1, _c2, _c3;						\
+    r0 = x0 - y0;						\
+    _c1 = r0 > x0;						\
+    r1 = x1 - y1;						\
+    _c2 = r1 > x1;						\
+    r1 -= _c1;							\
+    _c2 |= r1 > _c1;						\
+    r2 = x2 - y2;						\
+    _c3 = r2 > x2;						\
+    r2 -= _c2;							\
+    _c3 |= r2 > _c2;						\
+    r3 = x3 - y3 - _c3;						\
+  } while (0)
 #endif
 
 #ifndef __FP_FRAC_ADDI_4
-- 
1.5.2

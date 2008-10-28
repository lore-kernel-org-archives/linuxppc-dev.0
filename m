Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0EF71DDDF9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 14:57:29 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m9S3vOdQ026117
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 20:57:25 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m9S3vIg3014573
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 22:57:23 -0500 (CDT)
From: Liu Yu <yu.liu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] math-emu: Adopt new version of _FP_CHOOSENAN
Date: Tue, 28 Oct 2008 11:50:19 +0800
Message-Id: <1225165821-15998-3-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1225165821-15998-2-git-send-email-yu.liu@freescale.com>
References: <1225165821-15998-1-git-send-email-yu.liu@freescale.com>
	<1225165821-15998-2-git-send-email-yu.liu@freescale.com>
Cc: kumar.gala@freescale.com, Liu Yu <yu.liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move to using the same macro definition for _FP_CHOOSENAN as s390,  
sh, sparc32/64.  The original author didn't understand this and  
matched what sparc64 was doing and they have updated to this definition.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
 arch/powerpc/include/asm/sfp-machine.h |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
index da12ea7..88af036 100644
--- a/arch/powerpc/include/asm/sfp-machine.h
+++ b/arch/powerpc/include/asm/sfp-machine.h
@@ -111,16 +111,24 @@
 #define FP_EX_DIVZERO         (1 << (31 - 5))
 #define FP_EX_INEXACT         (1 << (31 - 6))
 
-/* This macro appears to be called when both X and Y are NaNs, and
- * has to choose one and copy it to R. i386 goes for the larger of the
- * two, sparc64 just picks Y. I don't understand this at all so I'll
- * go with sparc64 because it's shorter :->   -- PMM
+/*
+ * If one NaN is signaling and the other is not,
+ * we choose that one, otherwise we choose X.
  */
-#define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)		\
-  do {							\
-    R##_s = Y##_s;					\
-    _FP_FRAC_COPY_##wc(R,Y);				\
-    R##_c = FP_CLS_NAN;					\
+#define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)			\
+  do {								\
+    if ((_FP_FRAC_HIGH_RAW_##fs(Y) & _FP_QNANBIT_##fs)		\
+	&& !(_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs))	\
+      {								\
+	R##_s = X##_s;						\
+	_FP_FRAC_COPY_##wc(R,X);				\
+      }								\
+    else							\
+      {								\
+	R##_s = Y##_s;						\
+	_FP_FRAC_COPY_##wc(R,Y);				\
+      }								\
+    R##_c = FP_CLS_NAN;						\
   } while (0)
 
 
-- 
1.5.4

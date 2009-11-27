Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id C31C3100977
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 09:33:50 +1100 (EST)
Date: Sat, 28 Nov 2009 01:33:49 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 7/8] Implement _div64 and _mod64 for ppc32
Message-ID: <20091127223349.GG21805@oksana.dev.rtsoft.ru>
References: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

_div64 and _mod64 arch-specific details were taken from gcc/longlong.h,
just as it was done for i386.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 runtime/arith.c |   42 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/runtime/arith.c b/runtime/arith.c
index 4c818a7..a032e9c 100644
--- a/runtime/arith.c
+++ b/runtime/arith.c
@@ -20,7 +20,8 @@
 /* 64-bit division for 64-bit cpus and i386 */
 /* Other 32-bit cpus will need to modify this file. */
 
-#if defined (__i386__) || defined(__arm__)
+#if defined (__i386__) || defined(__arm__) || \
+	(defined(__powerpc__) && !defined(__powerpc64__))
 static long long _div64 (long long u, long long v);
 static long long _mod64 (long long u, long long v);
 #endif
@@ -114,7 +115,8 @@ static int _stp_random_pm (unsigned n)
 
 
 
-#if defined (__i386__) || defined (__arm__)
+#if defined (__i386__) || defined (__arm__) || \
+	(defined(__powerpc__) && !defined(__powerpc64__))
 
 /* 64-bit division functions extracted from libgcc */
 typedef long long DWtype;
@@ -181,6 +183,40 @@ typedef union
 		(count) = __cbtmp ^ 31;					\
 	} while (0)
 
+#elif defined (__powerpc__)
+/* these are the ppc versions of these macros from gcc/longlong.h */
+
+#define sub_ddmmss(sh, sl, ah, al, bh, bl) \
+  do {									\
+    if (__builtin_constant_p (ah) && (ah) == 0)				\
+      __asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{sfze|subfze} %0,%2"	\
+	       : "=r" (sh), "=&r" (sl) : "r" (bh), "rI" (al), "r" (bl));\
+    else if (__builtin_constant_p (ah) && (ah) == ~(USItype) 0)		\
+      __asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{sfme|subfme} %0,%2"	\
+	       : "=r" (sh), "=&r" (sl) : "r" (bh), "rI" (al), "r" (bl));\
+    else if (__builtin_constant_p (bh) && (bh) == 0)			\
+      __asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{ame|addme} %0,%2"		\
+	       : "=r" (sh), "=&r" (sl) : "r" (ah), "rI" (al), "r" (bl));\
+    else if (__builtin_constant_p (bh) && (bh) == ~(USItype) 0)		\
+      __asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{aze|addze} %0,%2"		\
+	       : "=r" (sh), "=&r" (sl) : "r" (ah), "rI" (al), "r" (bl));\
+    else								\
+      __asm__ ("{sf%I4|subf%I4c} %1,%5,%4\n\t{sfe|subfe} %0,%3,%2"	\
+	       : "=r" (sh), "=&r" (sl)					\
+	       : "r" (ah), "r" (bh), "rI" (al), "r" (bl));		\
+  } while (0)
+
+#define count_leading_zeros(count, x) \
+  __asm__ ("{cntlz|cntlzw} %0,%1" : "=r" (count) : "r" (x))
+#define COUNT_LEADING_ZEROS_0 32
+
+#define umul_ppmm(ph, pl, m0, m1) \
+  do {									\
+    USItype __m0 = (m0), __m1 = (m1);					\
+    __asm__ ("mulhwu %0,%1,%2" : "=r" (ph) : "%r" (m0), "r" (m1));	\
+    (pl) = __m0 * __m1;							\
+  } while (0)
+
 #elif defined (__arm__)
 
 #define sub_ddmmss(sh, sl, ah, al, bh, bl) \
@@ -548,6 +584,6 @@ static long long _mod64 (long long u, long long v)
 	return w;
 }
 
-#endif /* __i386__ || __arm__ */
+#endif /* __i386__ || __arm__ || (__powerpc__ && !__powerpc64__) */
 
 #endif /* _ARITH_C_ */
-- 
1.6.3.3

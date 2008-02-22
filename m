Return-Path: <segher@gcc12.fsffrance.org>
Received: from snail.fsffrance.org (eucd.info [88.191.250.43])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55026DE27F
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 07:38:33 +1100 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Get rid of invalid shifts in math-emu
Date: Fri, 22 Feb 2008 21:01:02 +0100
Message-Id: <410c322e7d7e4b9a420a7209f12dfbd105583f6f.1203708822.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/math-emu/op-2.h |   75 ++++++++++++++++-------------------------
 1 files changed, 29 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/math-emu/op-2.h b/arch/powerpc/math-emu/op-2.h
index 7d6f17c..16d3e3c 100644
--- a/arch/powerpc/math-emu/op-2.h
+++ b/arch/powerpc/math-emu/op-2.h
@@ -11,58 +11,43 @@
 
 #define _FP_FRAC_SLL_2(X,N)						\
   do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
+    int n = (N);							\
+    if (n >= _FP_W_TYPE_SIZE)						\
       {									\
-        if (__builtin_constant_p(N) && (N) == 1) 			\
-          {								\
-            X##_f1 = X##_f1 + X##_f1 + (((_FP_WS_TYPE)(X##_f0)) < 0);	\
-            X##_f0 += X##_f0;						\
-          }								\
-        else								\
-          {								\
-	    X##_f1 = X##_f1 << (N) | X##_f0 >> (_FP_W_TYPE_SIZE - (N));	\
-	    X##_f0 <<= (N);						\
-	  }								\
-      }									\
-    else								\
-      {									\
-	X##_f1 = X##_f0 << ((N) - _FP_W_TYPE_SIZE);			\
+	X##_f1 = X##_f0;						\
 	X##_f0 = 0;							\
+	n -= _FP_W_TYPE_SIZE;						\
       }									\
+    X##_f1 = X##_f1 << n | X##_f0 >> (_FP_W_TYPE_SIZE - n - 1) >> 1;	\
+    X##_f0 <<= n;							\
   } while (0)
 
 #define _FP_FRAC_SRL_2(X,N)						\
   do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
-	X##_f0 = X##_f0 >> (N) | X##_f1 << (_FP_W_TYPE_SIZE - (N));	\
-	X##_f1 >>= (N);							\
-      }									\
-    else								\
+    int n = (N);							\
+    if (n >= _FP_W_TYPE_SIZE)						\
       {									\
-	X##_f0 = X##_f1 >> ((N) - _FP_W_TYPE_SIZE);			\
+	X##_f0 = X##_f1;						\
 	X##_f1 = 0;							\
+	n -= _FP_W_TYPE_SIZE;						\
       }									\
+    X##_f0 = X##_f0 >> n | X##_f1 << (_FP_W_TYPE_SIZE - n - 1) << 1;	\
+    X##_f1 >>= n;							\
   } while (0)
 
 /* Right shift with sticky-lsb.  */
 #define _FP_FRAC_SRS_2(X,N,sz)						\
   do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
-	X##_f0 = (X##_f1 << (_FP_W_TYPE_SIZE - (N)) | X##_f0 >> (N) |	\
-		  (__builtin_constant_p(N) && (N) == 1			\
-		   ? X##_f0 & 1						\
-		   : (X##_f0 << (_FP_W_TYPE_SIZE - (N))) != 0));	\
-	X##_f1 >>= (N);							\
-      }									\
-    else								\
+    int n = (N);							\
+    if (n >= _FP_W_TYPE_SIZE)						\
       {									\
-	X##_f0 = (X##_f1 >> ((N) - _FP_W_TYPE_SIZE) |			\
-	          (((X##_f1 << (2 * _FP_W_TYPE_SIZE - (N))) |		\
-		   X##_f0) != 0));					\
+	X##_f0 = X##_f1;						\
 	X##_f1 = 0;							\
+	n -= _FP_W_TYPE_SIZE;						\
       }									\
+    X##_f0 = (X##_f1 << (_FP_W_TYPE_SIZE - n - 1) << 1 | X##_f0 >> n |	\
+	      ((X##_f0 << (_FP_W_TYPE_SIZE - n - 1) << 1) != 0));	\
+    X##_f1 >>= n;							\
   } while (0)
 
 #define _FP_FRAC_ADDI_2(X,I) \
@@ -398,20 +383,18 @@
 
 #define _FP_FRAC_ASSEMBLE_2(r, X, rsize)	\
   do {						\
-    if (rsize <= _FP_W_TYPE_SIZE)		\
-      r = X##_f0;				\
-    else					\
-      {						\
-	r = X##_f1;				\
-	r <<= _FP_W_TYPE_SIZE;			\
-	r += X##_f0;				\
-      }						\
+    r = X##_f1;					\
+    r <<= _FP_W_TYPE_SIZE - 1;			\
+    r <<= 1;					\
+    r += X##_f0;				\
   } while (0)
 
-#define _FP_FRAC_DISASSEMBLE_2(X, r, rsize)				\
-  do {									\
-    X##_f0 = r;								\
-    X##_f1 = (rsize <= _FP_W_TYPE_SIZE ? 0 : r >> _FP_W_TYPE_SIZE);	\
+#define _FP_FRAC_DISASSEMBLE_2(X, r, rsize)	\
+  do {						\
+    X##_f0 = r;					\
+    r >>= _FP_W_TYPE_SIZE - 1;			\
+    r >>= 1;					\
+    X##_f1 = r;					\
   } while (0)
 
 /*
-- 
1.5.3.4.208.g805a

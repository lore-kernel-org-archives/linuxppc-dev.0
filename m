Return-Path: <Yu.Liu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6AD2BDDEF2
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 19:51:41 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m258owf2017674
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 01:50:58 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m258orbS003933
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 02:50:57 -0600 (CST)
From: Liu Yu <Yu.Liu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] math-emu: modify the sfp-machine.h to fit the new interface
	of common math-emu headers
Date: Wed,  5 Mar 2008 17:02:27 +0800
Message-Id: <12047077492663-git-send-email-Yu.Liu@freescale.com>
In-Reply-To: <12047077481825-git-send-email-Yu.Liu@freescale.com>
References: <12047077481825-git-send-email-Yu.Liu@freescale.com>
Cc: Liu Yu <Yu.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Liu Yu <Yu.Liu@freescale.com>
---
 include/asm-powerpc/sfp-machine.h |  217 +++++++++++++------------------------
 1 files changed, 75 insertions(+), 142 deletions(-)

diff --git a/include/asm-powerpc/sfp-machine.h b/include/asm-powerpc/sfp-machine.h
index 4b17d83..5dac9cd 100644
--- a/include/asm-powerpc/sfp-machine.h
+++ b/include/asm-powerpc/sfp-machine.h
@@ -45,159 +45,46 @@
  * gcc's longlong.h is useful.
  */
 
-/* We need to know how to multiply and divide. If the host word size
- * is >= 2*fracbits you can use FP_MUL_MEAT_n_imm(t,R,X,Y) which
- * codes the multiply with whatever gcc does to 'a * b'.
- * _FP_MUL_MEAT_n_wide(t,R,X,Y,f) is used when you have an asm
- * function that can multiply two 1W values and get a 2W result.
- * Otherwise you're stuck with _FP_MUL_MEAT_n_hard(t,R,X,Y) which
- * does bitshifting to avoid overflow.
- * For division there is FP_DIV_MEAT_n_imm(t,R,X,Y,f) for word size
- * >= 2*fracbits, where f is either _FP_DIV_HELP_imm or
- * _FP_DIV_HELP_ldiv (see op-1.h).
- * _FP_DIV_MEAT_udiv() is if you have asm to do 2W/1W => (1W, 1W).
- * [GCC and glibc have longlong.h which has the asm macro udiv_qrnnd
- * to do this.]
- * In general, 'n' is the number of words required to hold the type,
- * and 't' is either S, D or Q for single/double/quad.
- *           -- PMM
- */
-/* Example: SPARC64:
- * #define _FP_MUL_MEAT_S(R,X,Y)	_FP_MUL_MEAT_1_imm(S,R,X,Y)
- * #define _FP_MUL_MEAT_D(R,X,Y)	_FP_MUL_MEAT_1_wide(D,R,X,Y,umul_ppmm)
- * #define _FP_MUL_MEAT_Q(R,X,Y)	_FP_MUL_MEAT_2_wide(Q,R,X,Y,umul_ppmm)
- *
- * #define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_imm(S,R,X,Y,_FP_DIV_HELP_imm)
- * #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_1_udiv(D,R,X,Y)
- * #define _FP_DIV_MEAT_Q(R,X,Y)	_FP_DIV_MEAT_2_udiv_64(Q,R,X,Y)
- *
- * Example: i386:
- * #define _FP_MUL_MEAT_S(R,X,Y)   _FP_MUL_MEAT_1_wide(S,R,X,Y,_i386_mul_32_64)
- * #define _FP_MUL_MEAT_D(R,X,Y)   _FP_MUL_MEAT_2_wide(D,R,X,Y,_i386_mul_32_64)
- *
- * #define _FP_DIV_MEAT_S(R,X,Y)   _FP_DIV_MEAT_1_udiv(S,R,X,Y,_i386_div_64_32)
- * #define _FP_DIV_MEAT_D(R,X,Y)   _FP_DIV_MEAT_2_udiv_64(D,R,X,Y)
- */
-
-#define _FP_MUL_MEAT_S(R,X,Y)   _FP_MUL_MEAT_1_wide(S,R,X,Y,umul_ppmm)
-#define _FP_MUL_MEAT_D(R,X,Y)   _FP_MUL_MEAT_2_wide(D,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_S(R,X,Y)					\
+  _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_D(R,X,Y)					\
+  _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
 
 #define _FP_DIV_MEAT_S(R,X,Y)   _FP_DIV_MEAT_1_udiv(S,R,X,Y)
-#define _FP_DIV_MEAT_D(R,X,Y)   _FP_DIV_MEAT_2_udiv_64(D,R,X,Y)
+#define _FP_DIV_MEAT_D(R,X,Y)   _FP_DIV_MEAT_2_udiv(D,R,X,Y)
 
 /* These macros define what NaN looks like. They're supposed to expand to
  * a comma-separated set of 32bit unsigned ints that encode NaN.
  */
-#define _FP_NANFRAC_S		_FP_QNANBIT_S
-#define _FP_NANFRAC_D		_FP_QNANBIT_D, 0
-#define _FP_NANFRAC_Q           _FP_QNANBIT_Q, 0, 0, 0
+#define _FP_NANFRAC_S		((_FP_QNANBIT_S << 1) - 1)
+#define _FP_NANFRAC_D		((_FP_QNANBIT_D << 1) - 1), -1
+#define _FP_NANFRAC_Q		((_FP_QNANBIT_Q << 1) - 1), -1, -1, -1
+#define _FP_NANSIGN_S		0
+#define _FP_NANSIGN_D		0
+#define _FP_NANSIGN_Q		0
 
 #define _FP_KEEPNANFRACP 1
 
-/* This macro appears to be called when both X and Y are NaNs, and
- * has to choose one and copy it to R. i386 goes for the larger of the
- * two, sparc64 just picks Y. I don't understand this at all so I'll
- * go with sparc64 because it's shorter :->   -- PMM
+/*
+ * If one NaN is signaling and the other is not,
+ * we choose that one, otherwise we choose X.
  */
-#define _FP_CHOOSENAN(fs, wc, R, X, Y)			\
-  do {							\
-    R##_s = Y##_s;					\
-    _FP_FRAC_COPY_##wc(R,Y);				\
-    R##_c = FP_CLS_NAN;					\
-  } while (0)
-
-
-extern void fp_unpack_d(long *, unsigned long *, unsigned long *,
-			long *, long *, void *);
-extern int  fp_pack_d(void *, long, unsigned long, unsigned long, long, long);
-extern int  fp_pack_ds(void *, long, unsigned long, unsigned long, long, long);
-
-#define __FP_UNPACK_RAW_1(fs, X, val)			\
-  do {							\
-    union _FP_UNION_##fs *_flo =			\
-    	(union _FP_UNION_##fs *)val;			\
-							\
-    X##_f = _flo->bits.frac;				\
-    X##_e = _flo->bits.exp;				\
-    X##_s = _flo->bits.sign;				\
-  } while (0)
-
-#define __FP_UNPACK_RAW_2(fs, X, val)			\
-  do {							\
-    union _FP_UNION_##fs *_flo =			\
-    	(union _FP_UNION_##fs *)val;			\
-							\
-    X##_f0 = _flo->bits.frac0;				\
-    X##_f1 = _flo->bits.frac1;				\
-    X##_e  = _flo->bits.exp;				\
-    X##_s  = _flo->bits.sign;				\
+#define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)                      \
+  do {                                                          \
+    if ((_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs)          \
+        && !(_FP_FRAC_HIGH_RAW_##fs(Y) & _FP_QNANBIT_##fs))     \
+      {                                                         \
+        R##_s = Y##_s;                                          \
+        _FP_FRAC_COPY_##wc(R,Y);                                \
+      }                                                         \
+    else                                                        \
+      {                                                         \
+        R##_s = X##_s;                                          \
+        _FP_FRAC_COPY_##wc(R,X);                                \
+      }                                                         \
+    R##_c = FP_CLS_NAN;                                         \
   } while (0)
 
-#define __FP_UNPACK_S(X,val)		\
-  do {					\
-    __FP_UNPACK_RAW_1(S,X,val);		\
-    _FP_UNPACK_CANONICAL(S,1,X);	\
-  } while (0)
-
-#define __FP_UNPACK_D(X,val)		\
-	fp_unpack_d(&X##_s, &X##_f1, &X##_f0, &X##_e, &X##_c, val)
-
-#define __FP_PACK_RAW_1(fs, val, X)			\
-  do {							\
-    union _FP_UNION_##fs *_flo =			\
-    	(union _FP_UNION_##fs *)val;			\
-							\
-    _flo->bits.frac = X##_f;				\
-    _flo->bits.exp  = X##_e;				\
-    _flo->bits.sign = X##_s;				\
-  } while (0)
-
-#define __FP_PACK_RAW_2(fs, val, X)			\
-  do {							\
-    union _FP_UNION_##fs *_flo =			\
-    	(union _FP_UNION_##fs *)val;			\
-							\
-    _flo->bits.frac0 = X##_f0;				\
-    _flo->bits.frac1 = X##_f1;				\
-    _flo->bits.exp   = X##_e;				\
-    _flo->bits.sign  = X##_s;				\
-  } while (0)
-
-#include <linux/kernel.h>
-#include <linux/sched.h>
-
-#define __FPU_FPSCR	(current->thread.fpscr.val)
-
-/* We only actually write to the destination register
- * if exceptions signalled (if any) will not trap.
- */
-#define __FPU_ENABLED_EXC \
-({						\
-	(__FPU_FPSCR >> 3) & 0x1f;	\
-})
-
-#define __FPU_TRAP_P(bits) \
-	((__FPU_ENABLED_EXC & (bits)) != 0)
-
-#define __FP_PACK_S(val,X)			\
-({  int __exc = _FP_PACK_CANONICAL(S,1,X);	\
-    if(!__exc || !__FPU_TRAP_P(__exc))		\
-        __FP_PACK_RAW_1(S,val,X);		\
-    __exc;					\
-})
-
-#define __FP_PACK_D(val,X)			\
-	fp_pack_d(val, X##_s, X##_f1, X##_f0, X##_e, X##_c)
-
-#define __FP_PACK_DS(val,X)			\
-	fp_pack_ds(val, X##_s, X##_f1, X##_f0, X##_e, X##_c)
-
-/* Obtain the current rounding mode. */
-#define FP_ROUNDMODE			\
-({					\
-	__FPU_FPSCR & 0x3;		\
-})
-
 /* the asm fragments go here: all these are taken from glibc-2.0.5's
  * stdlib/longlong.h
  */
@@ -359,13 +246,49 @@ extern int  fp_pack_ds(void *, long, unsigned long, unsigned long, long, long);
 #define __BYTE_ORDER __LITTLE_ENDIAN
 #endif
 
+#include <linux/kernel.h>
+#include <linux/sched.h>
+
+#define __FPU_FPSCR	(current->thread.fpscr.val)
+
+/* We only actually write to the destination register
+ * if exceptions signalled (if any) will not trap.
+ */
+#define __FPU_ENABLED_EXC \
+({						\
+	(__FPU_FPSCR >> 3) & 0x1f;	\
+})
+
+#define __FPU_TRAP_P(bits) \
+	((__FPU_ENABLED_EXC & (bits)) != 0)
+
+#define __FP_PACK_DS(val,X)			\
+  do {						\
+    FP_DECL_S(__X);				\
+    FP_CONV(S, D, 1, 2, __X, X);		\
+    _FP_PACK_CANONICAL(S, 1, __X);		\
+    if (!FP_INHIBIT_RESULTS) {			\
+      _FP_UNPACK_CANONICAL(S, 1, __X);		\
+      FP_CONV(D, S, 2, 1, X, __X);		\
+      _FP_PACK_CANONICAL(D, 2, X);		\
+        if (!FP_INHIBIT_RESULTS) {		\
+          _FP_PACK_RAW_2_P(D,val,X);		\
+	}					\
+    }						\
+  } while (0)
+
+/* Obtain the current rounding mode. */
+#define FP_ROUNDMODE			\
+({					\
+	__FPU_FPSCR & 0x3;		\
+})
+
 /* Exception flags. */
 #define EFLAG_INVALID		(1 << (31 - 2))
 #define EFLAG_OVERFLOW		(1 << (31 - 3))
 #define EFLAG_UNDERFLOW		(1 << (31 - 4))
 #define EFLAG_DIVZERO		(1 << (31 - 5))
 #define EFLAG_INEXACT		(1 << (31 - 6))
-
 #define EFLAG_VXSNAN		(1 << (31 - 7))
 #define EFLAG_VXISI		(1 << (31 - 8))
 #define EFLAG_VXIDI		(1 << (31 - 9))
@@ -375,3 +298,13 @@ extern int  fp_pack_ds(void *, long, unsigned long, unsigned long, long, long);
 #define EFLAG_VXSOFT		(1 << (31 - 21))
 #define EFLAG_VXSQRT		(1 << (31 - 22))
 #define EFLAG_VXCVI		(1 << (31 - 23))
+
+#define FP_EX_INVALID           EFLAG_INVALID
+#define FP_EX_DIVZERO           EFLAG_DIVZERO
+#define FP_EX_OVERFLOW          EFLAG_OVERFLOW
+#define FP_EX_UNDERFLOW         EFLAG_UNDERFLOW
+#define FP_EX_INEXACT           EFLAG_INEXACT
+#define FP_INHIBIT_RESULTS	(!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS))
+
+#define FP_TRAPPING_EXCEPTIONS	__FPU_ENABLED_EXC
+
-- 
1.5.2

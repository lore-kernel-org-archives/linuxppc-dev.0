Return-Path: <joseph_myers@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 01C001A0FF1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 01:50:33 +1000 (AEST)
Date: Thu, 2 Jul 2015 15:50:28 +0000
From: Joseph Myers <joseph@codesourcery.com>
To: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <mpe@ellerman.id.au>
Subject: [PATCH 4/8] powerpc/math-emu: Move powerpc from math-emu-old to
 math-emu
Message-ID: <alpine.DEB.2.10.1507021549250.29415@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joseph Myers <joseph@codesourcery.com>

This patch moves powerpc from math-emu-old to math-emu, updating it
for the API changes.

The following cleanups or bug fixes (that might change how the
emulation behaves, or that go beyond mechanical conversion to new
APIs) are included in this patch because of their close connection to
the API changes:

* On PowerPC, fused multiply-add operations now use the new soft-fp
  fma support (meaning they are properly fused rather than only having
  3 extra bits precision on the intermediate result of the
  multiplication).

* On PowerPC for SPE floating-point emulation, the pre-existing bug of
  comparisons using cooked unpacking is fixed (as the structure of the
  code meant unpacking types naturally needed specifying explicitly
  for all operations).  This should not in fact change how the
  emulation behaves, other than making it more efficient.  Various
  operations that should not have unpacked at all now no longer unpack
  instead of using cooked unpacking, so avoiding spurious exceptions
  on signaling NaNs (on the other case of arguments that are actually
  a different floating-point type but would wrongly be interpreted as
  signaling NaNs by the unpacking, FP_CLEAR_EXCEPTIONS may have
  avoided the issue).

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
index d89beab..607ee14 100644
--- a/arch/powerpc/include/asm/sfp-machine.h
+++ b/arch/powerpc/include/asm/sfp-machine.h
@@ -82,6 +82,9 @@
 #define _FP_MUL_MEAT_S(R,X,Y)   _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
 #define _FP_MUL_MEAT_D(R,X,Y)   _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
 
+#define _FP_MUL_MEAT_DW_S(R,X,Y)   _FP_MUL_MEAT_DW_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_DW_D(R,X,Y)   _FP_MUL_MEAT_DW_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
+
 #define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_udiv_norm(S,R,X,Y)
 #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_2_udiv(D,R,X,Y)
 
@@ -96,6 +99,7 @@
 #define _FP_NANSIGN_Q		0
 
 #define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
 
 #ifdef FP_EX_BOOKE_E500_SPE
 #define FP_EX_INEXACT		(1 << 21)
@@ -178,15 +182,40 @@
 		_FP_PACK_RAW_2_P(D, val, X);				\
    } while (0)
 
+#define __FP_PACK_SEMIRAW_D(val,X)			\
+   do {									\
+	_FP_PACK_SEMIRAW(D, 2, X);					\
+	if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS))	\
+		_FP_PACK_RAW_2_P(D, val, X);				\
+   } while (0)
+
 #define __FP_PACK_DS(val,X)							\
    do {										\
 	   FP_DECL_S(__X);							\
-	   FP_CONV(S, D, 1, 2, __X, X);						\
+	   if (X##_c != FP_CLS_NAN)						\
+		   _FP_FRAC_SRS_2(X, _FP_WFRACBITS_D - _FP_WFRACBITS_S,		\
+			   _FP_WFRACBITS_D);					\
+	   else									\
+		   _FP_FRAC_SRL_2(X, _FP_WFRACBITS_D - _FP_WFRACBITS_S);	\
+	   _FP_FRAC_COPY_1_2(__X, X);						\
+	   __X##_e = X##_e;							\
+	   __X##_c = X##_c;							\
+	   __X##_s = X##_s;							\
 	   _FP_PACK_CANONICAL(S, 1, __X);					\
 	   if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS)) {	\
-		   _FP_UNPACK_CANONICAL(S, 1, __X);				\
-		   FP_CONV(D, S, 2, 1, X, __X);					\
-		   _FP_PACK_CANONICAL(D, 2, X);					\
+		   FP_EXTEND(D, S, 2, 1, X, __X);				\
+		   if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS))	\
+		   _FP_PACK_RAW_2_P(D, val, X);					\
+	   }									\
+   } while (0)
+
+#define __FP_PACK_SEMIRAW_DS(val,X)						\
+   do {										\
+	   FP_DECL_S(__X);							\
+	   FP_TRUNC(S, D, 1, 2, __X, X);					\
+	   _FP_PACK_SEMIRAW(S, 1, __X);						\
+	   if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS)) {	\
+		   FP_EXTEND(D, S, 2, 1, X, __X);				\
 		   if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS))	\
 		   _FP_PACK_RAW_2_P(D, val, X);					\
 	   }									\
@@ -198,6 +227,8 @@
 	__FPU_FPSCR & 0x3;		\
 })
 
+#define _FP_TININESS_AFTER_ROUNDING 0
+
 /* the asm fragments go here: all these are taken from glibc-2.0.5's
  * stdlib/longlong.h
  */
diff --git a/arch/powerpc/math-emu/fadd.c b/arch/powerpc/math-emu/fadd.c
index 3c821be..6deb27a 100644
--- a/arch/powerpc/math-emu/fadd.c
+++ b/arch/powerpc/math-emu/fadd.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fadd(void *frD, void *frA, void *frB)
@@ -18,8 +18,8 @@ fadd(void *frD, void *frA, void *frB)
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	FP_UNPACK_DP(A, frA);
-	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_SEMIRAW_DP(A, frA);
+	FP_UNPACK_SEMIRAW_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -32,7 +32,7 @@ fadd(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	__FP_PACK_D(frD, R);
+	__FP_PACK_SEMIRAW_D(frD, R);
 
 	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fadds.c b/arch/powerpc/math-emu/fadds.c
index 14bc579..9e2fb9e 100644
--- a/arch/powerpc/math-emu/fadds.c
+++ b/arch/powerpc/math-emu/fadds.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/single.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fadds(void *frD, void *frA, void *frB)
@@ -19,8 +19,8 @@ fadds(void *frD, void *frA, void *frB)
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	FP_UNPACK_DP(A, frA);
-	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_SEMIRAW_DP(A, frA);
+	FP_UNPACK_SEMIRAW_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -33,7 +33,7 @@ fadds(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	__FP_PACK_DS(frD, R);
+	__FP_PACK_SEMIRAW_DS(frD, R);
 
 	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fcmpo.c b/arch/powerpc/math-emu/fcmpo.c
index 3c4afbf..8ebdb28 100644
--- a/arch/powerpc/math-emu/fcmpo.c
+++ b/arch/powerpc/math-emu/fcmpo.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fcmpo(u32 *ccr, int crfD, void *frA, void *frB)
@@ -30,7 +30,7 @@ fcmpo(u32 *ccr, int crfD, void *frA, void *frB)
 	if (A_c == FP_CLS_NAN || B_c == FP_CLS_NAN)
 		FP_SET_EXCEPTION(EFLAG_VXVC);
 
-	FP_CMP_D(cmp, A, B, 2);
+	FP_CMP_D(cmp, A, B, 2, 0);
 	cmp = code[(cmp + 1) & 3];
 
 	__FPU_FPSCR &= ~(0x1f000);
diff --git a/arch/powerpc/math-emu/fcmpu.c b/arch/powerpc/math-emu/fcmpu.c
index 948d9db..3b385c6 100644
--- a/arch/powerpc/math-emu/fcmpu.c
+++ b/arch/powerpc/math-emu/fcmpu.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
@@ -27,7 +27,7 @@ fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
 	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
 #endif
 
-	FP_CMP_D(cmp, A, B, 2);
+	FP_CMP_D(cmp, A, B, 2, 0);
 	cmp = code[(cmp + 1) & 3];
 
 	__FPU_FPSCR &= ~(0x1f000);
diff --git a/arch/powerpc/math-emu/fctiw.c b/arch/powerpc/math-emu/fctiw.c
index d3efc14..9d7c7c9 100644
--- a/arch/powerpc/math-emu/fctiw.c
+++ b/arch/powerpc/math-emu/fctiw.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fctiw(u32 *frD, void *frB)
@@ -13,7 +13,7 @@ fctiw(u32 *frD, void *frB)
 	FP_DECL_EX;
 	unsigned int r;
 
-	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_RAW_DP(B, frB);
 	FP_TO_INT_D(r, B, 32, 1);
 	frD[1] = r;
 
diff --git a/arch/powerpc/math-emu/fctiwz.c b/arch/powerpc/math-emu/fctiwz.c
index cce3457..d55b3e7 100644
--- a/arch/powerpc/math-emu/fctiwz.c
+++ b/arch/powerpc/math-emu/fctiwz.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fctiwz(u32 *frD, void *frB)
@@ -18,7 +18,7 @@ fctiwz(u32 *frD, void *frB)
 	__FPU_FPSCR &= ~(3);
 	__FPU_FPSCR |= FP_RND_ZERO;
 
-	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_RAW_DP(B, frB);
 	FP_TO_INT_D(r, B, 32, 1);
 	frD[1] = r;
 
diff --git a/arch/powerpc/math-emu/fdiv.c b/arch/powerpc/math-emu/fdiv.c
index f3084fd..a29239c 100644
--- a/arch/powerpc/math-emu/fdiv.c
+++ b/arch/powerpc/math-emu/fdiv.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fdiv(void *frD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/fdivs.c b/arch/powerpc/math-emu/fdivs.c
index 4fde33b..526bc26 100644
--- a/arch/powerpc/math-emu/fdivs.c
+++ b/arch/powerpc/math-emu/fdivs.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/single.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fdivs(void *frD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/fmadd.c b/arch/powerpc/math-emu/fmadd.c
index 9a2b1ff..0f450fb 100644
--- a/arch/powerpc/math-emu/fmadd.c
+++ b/arch/powerpc/math-emu/fmadd.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fmadd(void *frD, void *frA, void *frB, void *frC)
@@ -13,7 +13,6 @@ fmadd(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -34,12 +33,7 @@ fmadd(void *frD, void *frA, void *frB, void *frC)
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
                 FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
-	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
diff --git a/arch/powerpc/math-emu/fmadds.c b/arch/powerpc/math-emu/fmadds.c
index 3dac172..79885eb 100644
--- a/arch/powerpc/math-emu/fmadds.c
+++ b/arch/powerpc/math-emu/fmadds.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/single.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fmadds(void *frD, void *frA, void *frB, void *frC)
@@ -14,7 +14,6 @@ fmadds(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -35,12 +34,7 @@ fmadds(void *frD, void *frA, void *frB, void *frC)
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
                 FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
-	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
diff --git a/arch/powerpc/math-emu/fmsub.c b/arch/powerpc/math-emu/fmsub.c
index bfcf698..ee2385d 100644
--- a/arch/powerpc/math-emu/fmsub.c
+++ b/arch/powerpc/math-emu/fmsub.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fmsub(void *frD, void *frA, void *frB, void *frC)
@@ -13,7 +13,6 @@ fmsub(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -34,15 +33,10 @@ fmsub(void *frD, void *frA, void *frB, void *frC)
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
 		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
 	if (B_c != FP_CLS_NAN)
 		B_s ^= 1;
 
-	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
diff --git a/arch/powerpc/math-emu/fmsubs.c b/arch/powerpc/math-emu/fmsubs.c
index 144d43a..fe081c0 100644
--- a/arch/powerpc/math-emu/fmsubs.c
+++ b/arch/powerpc/math-emu/fmsubs.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/single.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fmsubs(void *frD, void *frA, void *frB, void *frC)
@@ -14,7 +14,6 @@ fmsubs(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -35,15 +34,10 @@ fmsubs(void *frD, void *frA, void *frB, void *frC)
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
 		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
 	if (B_c != FP_CLS_NAN)
 		B_s ^= 1;
 
-	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
diff --git a/arch/powerpc/math-emu/fmul.c b/arch/powerpc/math-emu/fmul.c
index 1ea819d..2c19297 100644
--- a/arch/powerpc/math-emu/fmul.c
+++ b/arch/powerpc/math-emu/fmul.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fmul(void *frD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/fmuls.c b/arch/powerpc/math-emu/fmuls.c
index 6f62191..f5ad5c9 100644
--- a/arch/powerpc/math-emu/fmuls.c
+++ b/arch/powerpc/math-emu/fmuls.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/single.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fmuls(void *frD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/fnmadd.c b/arch/powerpc/math-emu/fnmadd.c
index e290ef7..330353e6 100644
--- a/arch/powerpc/math-emu/fnmadd.c
+++ b/arch/powerpc/math-emu/fnmadd.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fnmadd(void *frD, void *frA, void *frB, void *frC)
@@ -13,7 +13,6 @@ fnmadd(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -34,12 +33,7 @@ fnmadd(void *frD, void *frA, void *frB, void *frC)
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
                 FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
-	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 	if (R_c != FP_CLS_NAN)
 		R_s ^= 1;
diff --git a/arch/powerpc/math-emu/fnmadds.c b/arch/powerpc/math-emu/fnmadds.c
index 41a5a4c..dd27045 100644
--- a/arch/powerpc/math-emu/fnmadds.c
+++ b/arch/powerpc/math-emu/fnmadds.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/single.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fnmadds(void *frD, void *frA, void *frB, void *frC)
@@ -14,7 +14,6 @@ fnmadds(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -35,12 +34,7 @@ fnmadds(void *frD, void *frA, void *frB, void *frC)
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
                 FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
-	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 	if (R_c != FP_CLS_NAN)
 		R_s ^= 1;
diff --git a/arch/powerpc/math-emu/fnmsub.c b/arch/powerpc/math-emu/fnmsub.c
index 7e6168a..87c8b4c 100644
--- a/arch/powerpc/math-emu/fnmsub.c
+++ b/arch/powerpc/math-emu/fnmsub.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fnmsub(void *frD, void *frA, void *frB, void *frC)
@@ -13,7 +13,6 @@ fnmsub(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -34,15 +33,10 @@ fnmsub(void *frD, void *frA, void *frB, void *frC)
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
 		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
 	if (B_c != FP_CLS_NAN)
 		B_s ^= 1;
 
-	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 	if (R_c != FP_CLS_NAN)
 		R_s ^= 1;
diff --git a/arch/powerpc/math-emu/fnmsubs.c b/arch/powerpc/math-emu/fnmsubs.c
index bb4a27f..72b860b 100644
--- a/arch/powerpc/math-emu/fnmsubs.c
+++ b/arch/powerpc/math-emu/fnmsubs.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/single.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fnmsubs(void *frD, void *frA, void *frB, void *frC)
@@ -14,7 +14,6 @@ fnmsubs(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -35,15 +34,10 @@ fnmsubs(void *frD, void *frA, void *frB, void *frC)
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
 		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
 	if (B_c != FP_CLS_NAN)
 		B_s ^= 1;
 
-	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 	if (R_c != FP_CLS_NAN)
 		R_s ^= 1;
diff --git a/arch/powerpc/math-emu/frsp.c b/arch/powerpc/math-emu/frsp.c
index 6fda802..ddcc146 100644
--- a/arch/powerpc/math-emu/frsp.c
+++ b/arch/powerpc/math-emu/frsp.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/single.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 frsp(void *frD, void *frB)
diff --git a/arch/powerpc/math-emu/fsel.c b/arch/powerpc/math-emu/fsel.c
index 681898d..1b0c144 100644
--- a/arch/powerpc/math-emu/fsel.c
+++ b/arch/powerpc/math-emu/fsel.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fsel(u32 *frD, void *frA, u32 *frB, u32 *frC)
diff --git a/arch/powerpc/math-emu/fsqrt.c b/arch/powerpc/math-emu/fsqrt.c
index f66b52e..a55fc7d 100644
--- a/arch/powerpc/math-emu/fsqrt.c
+++ b/arch/powerpc/math-emu/fsqrt.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fsqrt(void *frD, void *frB)
diff --git a/arch/powerpc/math-emu/fsqrts.c b/arch/powerpc/math-emu/fsqrts.c
index b042ff6..31dccbf 100644
--- a/arch/powerpc/math-emu/fsqrts.c
+++ b/arch/powerpc/math-emu/fsqrts.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/single.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fsqrts(void *frD, void *frB)
diff --git a/arch/powerpc/math-emu/fsub.c b/arch/powerpc/math-emu/fsub.c
index aa2105f..8070976 100644
--- a/arch/powerpc/math-emu/fsub.c
+++ b/arch/powerpc/math-emu/fsub.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fsub(void *frD, void *frA, void *frB)
@@ -18,8 +18,8 @@ fsub(void *frD, void *frA, void *frB)
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	FP_UNPACK_DP(A, frA);
-	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_SEMIRAW_DP(A, frA);
+	FP_UNPACK_SEMIRAW_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -38,7 +38,7 @@ fsub(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	__FP_PACK_D(frD, R);
+	__FP_PACK_SEMIRAW_D(frD, R);
 
 	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fsubs.c b/arch/powerpc/math-emu/fsubs.c
index 9fd6cf6..5b96755 100644
--- a/arch/powerpc/math-emu/fsubs.c
+++ b/arch/powerpc/math-emu/fsubs.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/single.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fsubs(void *frD, void *frA, void *frB)
@@ -19,8 +19,8 @@ fsubs(void *frD, void *frA, void *frB)
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	FP_UNPACK_DP(A, frA);
-	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_SEMIRAW_DP(A, frA);
+	FP_UNPACK_SEMIRAW_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -39,7 +39,7 @@ fsubs(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	__FP_PACK_DS(frD, R);
+	__FP_PACK_SEMIRAW_DS(frD, R);
 
 	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/lfd.c b/arch/powerpc/math-emu/lfd.c
index acc5a3f..79ac76d 100644
--- a/arch/powerpc/math-emu/lfd.c
+++ b/arch/powerpc/math-emu/lfd.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/double.h>
+#include <math-emu/double.h>
 
 int
 lfd(void *frD, void *ea)
diff --git a/arch/powerpc/math-emu/lfs.c b/arch/powerpc/math-emu/lfs.c
index 582e0b8..16da2c2 100644
--- a/arch/powerpc/math-emu/lfs.c
+++ b/arch/powerpc/math-emu/lfs.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/single.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 lfs(void *frD, void *ea)
@@ -22,25 +22,20 @@ lfs(void *frD, void *ea)
 	if (copy_from_user(&f, ea, sizeof(float)))
 		return -EFAULT;
 
-	FP_UNPACK_S(A, f);
+	FP_UNPACK_RAW_S(A, f);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %ld (%ld) [%08lx]\n", A_s, A_f, A_e, A_c,
 	       *(unsigned long *)&f);
 #endif
 
-	FP_CONV(D, S, 2, 1, R, A);
+	_FP_EXTEND_CNAN(D, S, 2, 1, R, A, 0);
 
 #ifdef DEBUG
 	printk("R: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	if (R_c == FP_CLS_NAN) {
-		R_e = _FP_EXPMAX_D;
-		_FP_PACK_RAW_2_P(D, frD, R);
-	} else {
-		__FP_PACK_D(frD, R);
-	}
+	FP_PACK_RAW_DP(frD, R);
 
 	return 0;
 }
diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index d6e1a8f..ab151f0 100644
--- a/arch/powerpc/math-emu/math.c
+++ b/arch/powerpc/math-emu/math.c
@@ -10,7 +10,7 @@
 #include <asm/switch_to.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/double.h>
+#include <math-emu/double.h>
 
 #define FLOATFUNC(x)	extern int x(void *, void *, void *, void *)
 
diff --git a/arch/powerpc/math-emu/math_efp.c b/arch/powerpc/math-emu/math_efp.c
index 8d87cf9..833394c 100644
--- a/arch/powerpc/math-emu/math_efp.c
+++ b/arch/powerpc/math-emu/math_efp.c
@@ -28,9 +28,9 @@
 #define FP_EX_BOOKE_E500_SPE
 #include <asm/sfp-machine.h>
 
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/single.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+#include <math-emu/double.h>
 
 #define EFAPU		0x4
 
@@ -99,6 +99,11 @@
 #define XB	4
 #define XCR	5
 #define NOTYPE	0
+#define TYPE_MASK	7
+#define UNONE	0
+#define URAW	8
+#define USEMI	16
+#define UCOOK	24
 
 #define SIGN_BIT_S	(1UL << 31)
 #define SIGN_BIT_D	(1ULL << 63)
@@ -114,64 +119,64 @@ union dw_union {
 
 static unsigned long insn_type(unsigned long speinsn)
 {
-	unsigned long ret = NOTYPE;
+	unsigned long ret = NOTYPE|UNONE;
 
 	switch (speinsn & 0x7ff) {
-	case EFSABS:	ret = XA;	break;
-	case EFSADD:	ret = AB;	break;
-	case EFSCFD:	ret = XB;	break;
-	case EFSCMPEQ:	ret = XCR;	break;
-	case EFSCMPGT:	ret = XCR;	break;
-	case EFSCMPLT:	ret = XCR;	break;
-	case EFSCTSF:	ret = XB;	break;
-	case EFSCTSI:	ret = XB;	break;
-	case EFSCTSIZ:	ret = XB;	break;
-	case EFSCTUF:	ret = XB;	break;
-	case EFSCTUI:	ret = XB;	break;
-	case EFSCTUIZ:	ret = XB;	break;
-	case EFSDIV:	ret = AB;	break;
-	case EFSMUL:	ret = AB;	break;
-	case EFSNABS:	ret = XA;	break;
-	case EFSNEG:	ret = XA;	break;
-	case EFSSUB:	ret = AB;	break;
-	case EFSCFSI:	ret = XB;	break;
-
-	case EVFSABS:	ret = XA;	break;
-	case EVFSADD:	ret = AB;	break;
-	case EVFSCMPEQ:	ret = XCR;	break;
-	case EVFSCMPGT:	ret = XCR;	break;
-	case EVFSCMPLT:	ret = XCR;	break;
-	case EVFSCTSF:	ret = XB;	break;
-	case EVFSCTSI:	ret = XB;	break;
-	case EVFSCTSIZ:	ret = XB;	break;
-	case EVFSCTUF:	ret = XB;	break;
-	case EVFSCTUI:	ret = XB;	break;
-	case EVFSCTUIZ:	ret = XB;	break;
-	case EVFSDIV:	ret = AB;	break;
-	case EVFSMUL:	ret = AB;	break;
-	case EVFSNABS:	ret = XA;	break;
-	case EVFSNEG:	ret = XA;	break;
-	case EVFSSUB:	ret = AB;	break;
-
-	case EFDABS:	ret = XA;	break;
-	case EFDADD:	ret = AB;	break;
-	case EFDCFS:	ret = XB;	break;
-	case EFDCMPEQ:	ret = XCR;	break;
-	case EFDCMPGT:	ret = XCR;	break;
-	case EFDCMPLT:	ret = XCR;	break;
-	case EFDCTSF:	ret = XB;	break;
-	case EFDCTSI:	ret = XB;	break;
-	case EFDCTSIDZ:	ret = XB;	break;
-	case EFDCTSIZ:	ret = XB;	break;
-	case EFDCTUF:	ret = XB;	break;
-	case EFDCTUI:	ret = XB;	break;
-	case EFDCTUIDZ:	ret = XB;	break;
-	case EFDCTUIZ:	ret = XB;	break;
-	case EFDDIV:	ret = AB;	break;
-	case EFDMUL:	ret = AB;	break;
-	case EFDNABS:	ret = XA;	break;
-	case EFDNEG:	ret = XA;	break;
-	case EFDSUB:	ret = AB;	break;
+	case EFSABS:	ret = XA|UNONE;	break;
+	case EFSADD:	ret = AB|USEMI;	break;
+	case EFSCFD:	ret = XB|UNONE;	break;
+	case EFSCMPEQ:	ret = XCR|URAW;	break;
+	case EFSCMPGT:	ret = XCR|URAW;	break;
+	case EFSCMPLT:	ret = XCR|URAW;	break;
+	case EFSCTSF:	ret = XB|URAW;	break;
+	case EFSCTSI:	ret = XB|URAW;	break;
+	case EFSCTSIZ:	ret = XB|URAW;	break;
+	case EFSCTUF:	ret = XB|URAW;	break;
+	case EFSCTUI:	ret = XB|URAW;	break;
+	case EFSCTUIZ:	ret = XB|URAW;	break;
+	case EFSDIV:	ret = AB|UCOOK;	break;
+	case EFSMUL:	ret = AB|UCOOK;	break;
+	case EFSNABS:	ret = XA|UNONE;	break;
+	case EFSNEG:	ret = XA|UNONE;	break;
+	case EFSSUB:	ret = AB|USEMI;	break;
+	case EFSCFSI:	ret = XB|UNONE;	break;
+
+	case EVFSABS:	ret = XA|UNONE;	break;
+	case EVFSADD:	ret = AB|USEMI;	break;
+	case EVFSCMPEQ:	ret = XCR|URAW;	break;
+	case EVFSCMPGT:	ret = XCR|URAW;	break;
+	case EVFSCMPLT:	ret = XCR|URAW;	break;
+	case EVFSCTSF:	ret = XB|URAW;	break;
+	case EVFSCTSI:	ret = XB|URAW;	break;
+	case EVFSCTSIZ:	ret = XB|URAW;	break;
+	case EVFSCTUF:	ret = XB|URAW;	break;
+	case EVFSCTUI:	ret = XB|URAW;	break;
+	case EVFSCTUIZ:	ret = XB|URAW;	break;
+	case EVFSDIV:	ret = AB|UCOOK;	break;
+	case EVFSMUL:	ret = AB|UCOOK;	break;
+	case EVFSNABS:	ret = XA|UNONE;	break;
+	case EVFSNEG:	ret = XA|UNONE;	break;
+	case EVFSSUB:	ret = AB|USEMI;	break;
+
+	case EFDABS:	ret = XA|UNONE;	break;
+	case EFDADD:	ret = AB|USEMI;	break;
+	case EFDCFS:	ret = XB|UNONE;	break;
+	case EFDCMPEQ:	ret = XCR|URAW;	break;
+	case EFDCMPGT:	ret = XCR|URAW;	break;
+	case EFDCMPLT:	ret = XCR|URAW;	break;
+	case EFDCTSF:	ret = XB|URAW;	break;
+	case EFDCTSI:	ret = XB|URAW;	break;
+	case EFDCTSIDZ:	ret = XB|URAW;	break;
+	case EFDCTSIZ:	ret = XB|URAW;	break;
+	case EFDCTUF:	ret = XB|URAW;	break;
+	case EFDCTUI:	ret = XB|URAW;	break;
+	case EFDCTUIDZ:	ret = XB|URAW;	break;
+	case EFDCTUIZ:	ret = XB|URAW;	break;
+	case EFDDIV:	ret = AB|UCOOK;	break;
+	case EFDMUL:	ret = AB|UCOOK;	break;
+	case EFDNABS:	ret = XA|UNONE;	break;
+	case EFDNEG:	ret = XA|UNONE;	break;
+	case EFDSUB:	ret = AB|USEMI;	break;
 	}
 
 	return ret;
@@ -191,7 +196,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 		return -EINVAL;         /* not an spe instruction */
 
 	type = insn_type(speinsn);
-	if (type == NOTYPE)
+	if (type == (NOTYPE|UNONE))
 		goto illegal;
 
 	func = speinsn & 0x7ff;
@@ -219,14 +224,18 @@ int do_spe_mathemu(struct pt_regs *regs)
 		FP_DECL_S(SA); FP_DECL_S(SB); FP_DECL_S(SR);
 
 		switch (type) {
-		case AB:
-		case XCR:
-			FP_UNPACK_SP(SA, va.wp + 1);
-		case XB:
-			FP_UNPACK_SP(SB, vb.wp + 1);
+		case XCR|URAW:
+			FP_UNPACK_RAW_SP(SA, va.wp + 1);
+		case XB|URAW:
+			FP_UNPACK_RAW_SP(SB, vb.wp + 1);
+			break;
+		case AB|USEMI:
+			FP_UNPACK_SEMIRAW_SP(SA, va.wp + 1);
+			FP_UNPACK_SEMIRAW_SP(SB, vb.wp + 1);
 			break;
-		case XA:
+		case AB|UCOOK:
 			FP_UNPACK_SP(SA, va.wp + 1);
+			FP_UNPACK_SP(SB, vb.wp + 1);
 			break;
 		}
 
@@ -248,11 +257,11 @@ int do_spe_mathemu(struct pt_regs *regs)
 
 		case EFSADD:
 			FP_ADD_S(SR, SA, SB);
-			goto pack_s;
+			goto pack_semiraw_s;
 
 		case EFSSUB:
 			FP_SUB_S(SR, SA, SB);
-			goto pack_s;
+			goto pack_semiraw_s;
 
 		case EFSMUL:
 			FP_MUL_S(SR, SA, SB);
@@ -288,14 +297,13 @@ int do_spe_mathemu(struct pt_regs *regs)
 
 		case EFSCFD: {
 			FP_DECL_D(DB);
-			FP_CLEAR_EXCEPTIONS;
-			FP_UNPACK_DP(DB, vb.dp);
+			FP_UNPACK_SEMIRAW_DP(DB, vb.dp);
 
-			pr_debug("DB: %ld %08lx %08lx %ld (%ld)\n",
-					DB_s, DB_f1, DB_f0, DB_e, DB_c);
+			pr_debug("DB: %ld %08lx %08lx %ld\n",
+					DB_s, DB_f1, DB_f0, DB_e);
 
-			FP_CONV(S, D, 1, 2, SR, DB);
-			goto pack_s;
+			FP_TRUNC(S, D, 1, 2, SR, DB);
+			goto pack_semiraw_s;
 		}
 
 		case EFSCTSI:
@@ -325,6 +333,12 @@ int do_spe_mathemu(struct pt_regs *regs)
 		}
 		break;
 
+pack_semiraw_s:
+		pr_debug("SR: %ld %08lx %ld\n", SR_s, SR_f, SR_e);
+
+		FP_PACK_SEMIRAW_SP(vc.wp + 1, SR);
+		goto update_regs;
+
 pack_s:
 		pr_debug("SR: %ld %08lx %ld (%ld)\n", SR_s, SR_f, SR_e, SR_c);
 
@@ -332,9 +346,7 @@ pack_s:
 		goto update_regs;
 
 cmp_s:
-		FP_CMP_S(IR, SA, SB, 3);
-		if (IR == 3 && (FP_ISSIGNAN_S(SA) || FP_ISSIGNAN_S(SB)))
-			FP_SET_EXCEPTION(FP_EX_INVALID);
+		FP_CMP_S(IR, SA, SB, 3, 1);
 		if (IR == cmp) {
 			IR = 0x4;
 		} else {
@@ -347,14 +359,18 @@ cmp_s:
 		FP_DECL_D(DA); FP_DECL_D(DB); FP_DECL_D(DR);
 
 		switch (type) {
-		case AB:
-		case XCR:
-			FP_UNPACK_DP(DA, va.dp);
-		case XB:
-			FP_UNPACK_DP(DB, vb.dp);
+		case XCR|URAW:
+			FP_UNPACK_RAW_DP(DA, va.dp);
+		case XB|URAW:
+			FP_UNPACK_RAW_DP(DB, vb.dp);
 			break;
-		case XA:
+		case AB|USEMI:
+			FP_UNPACK_SEMIRAW_DP(DA, va.dp);
+			FP_UNPACK_SEMIRAW_DP(DB, vb.dp);
+			break;
+		case AB|UCOOK:
 			FP_UNPACK_DP(DA, va.dp);
+			FP_UNPACK_DP(DB, vb.dp);
 			break;
 		}
 
@@ -378,11 +394,11 @@ cmp_s:
 
 		case EFDADD:
 			FP_ADD_D(DR, DA, DB);
-			goto pack_d;
+			goto pack_semiraw_d;
 
 		case EFDSUB:
 			FP_SUB_D(DR, DA, DB);
-			goto pack_d;
+			goto pack_semiraw_d;
 
 		case EFDMUL:
 			FP_MUL_D(DR, DA, DB);
@@ -418,14 +434,13 @@ cmp_s:
 
 		case EFDCFS: {
 			FP_DECL_S(SB);
-			FP_CLEAR_EXCEPTIONS;
-			FP_UNPACK_SP(SB, vb.wp + 1);
+			FP_UNPACK_RAW_SP(SB, vb.wp + 1);
 
-			pr_debug("SB: %ld %08lx %ld (%ld)\n",
-					SB_s, SB_f, SB_e, SB_c);
+			pr_debug("SB: %ld %08lx %ld\n",
+					SB_s, SB_f, SB_e);
 
-			FP_CONV(D, S, 2, 1, DR, SB);
-			goto pack_d;
+			FP_EXTEND(D, S, 2, 1, DR, SB);
+			goto pack_raw_d;
 		}
 
 		case EFDCTUIDZ:
@@ -466,6 +481,20 @@ cmp_s:
 		}
 		break;
 
+pack_raw_d:
+		pr_debug("DR: %ld %08lx %08lx %ld\n",
+				DR_s, DR_f1, DR_f0, DR_e);
+
+		FP_PACK_RAW_DP(vc.dp, DR);
+		goto update_regs;
+
+pack_semiraw_d:
+		pr_debug("DR: %ld %08lx %08lx %ld\n",
+				DR_s, DR_f1, DR_f0, DR_e);
+
+		FP_PACK_SEMIRAW_DP(vc.dp, DR);
+		goto update_regs;
+
 pack_d:
 		pr_debug("DR: %ld %08lx %08lx %ld (%ld)\n",
 				DR_s, DR_f1, DR_f0, DR_e, DR_c);
@@ -474,9 +503,7 @@ pack_d:
 		goto update_regs;
 
 cmp_d:
-		FP_CMP_D(IR, DA, DB, 3);
-		if (IR == 3 && (FP_ISSIGNAN_D(DA) || FP_ISSIGNAN_D(DB)))
-			FP_SET_EXCEPTION(FP_EX_INVALID);
+		FP_CMP_D(IR, DA, DB, 3, 1);
 		if (IR == cmp) {
 			IR = 0x4;
 		} else {
@@ -492,18 +519,25 @@ cmp_d:
 		int IR0, IR1;
 
 		switch (type) {
-		case AB:
-		case XCR:
+		case XCR|URAW:
+			FP_UNPACK_RAW_SP(SA0, va.wp);
+			FP_UNPACK_RAW_SP(SA1, va.wp + 1);
+		case XB|URAW:
+			FP_UNPACK_RAW_SP(SB0, vb.wp);
+			FP_UNPACK_RAW_SP(SB1, vb.wp + 1);
+			break;
+		case AB|USEMI:
+			FP_UNPACK_SEMIRAW_SP(SA0, va.wp);
+			FP_UNPACK_SEMIRAW_SP(SA1, va.wp + 1);
+			FP_UNPACK_SEMIRAW_SP(SB0, vb.wp);
+			FP_UNPACK_SEMIRAW_SP(SB1, vb.wp + 1);
+			break;
+		case AB|UCOOK:
 			FP_UNPACK_SP(SA0, va.wp);
 			FP_UNPACK_SP(SA1, va.wp + 1);
-		case XB:
 			FP_UNPACK_SP(SB0, vb.wp);
 			FP_UNPACK_SP(SB1, vb.wp + 1);
 			break;
-		case XA:
-			FP_UNPACK_SP(SA0, va.wp);
-			FP_UNPACK_SP(SA1, va.wp + 1);
-			break;
 		}
 
 		pr_debug("SA0: %ld %08lx %ld (%ld)\n",
@@ -534,12 +568,12 @@ cmp_d:
 		case EVFSADD:
 			FP_ADD_S(SR0, SA0, SB0);
 			FP_ADD_S(SR1, SA1, SB1);
-			goto pack_vs;
+			goto pack_semiraw_vs;
 
 		case EVFSSUB:
 			FP_SUB_S(SR0, SA0, SB0);
 			FP_SUB_S(SR1, SA1, SB1);
-			goto pack_vs;
+			goto pack_semiraw_vs;
 
 		case EVFSMUL:
 			FP_MUL_S(SR0, SA0, SB0);
@@ -624,6 +658,16 @@ cmp_d:
 		}
 		break;
 
+pack_semiraw_vs:
+		pr_debug("SR0: %ld %08lx %ld\n",
+				SR0_s, SR0_f, SR0_e);
+		pr_debug("SR1: %ld %08lx %ld\n",
+				SR1_s, SR1_f, SR1_e);
+
+		FP_PACK_SEMIRAW_SP(vc.wp, SR0);
+		FP_PACK_SEMIRAW_SP(vc.wp + 1, SR1);
+		goto update_regs;
+
 pack_vs:
 		pr_debug("SR0: %ld %08lx %ld (%ld)\n",
 				SR0_s, SR0_f, SR0_e, SR0_c);
@@ -638,12 +682,8 @@ cmp_vs:
 		{
 			int ch, cl;
 
-			FP_CMP_S(IR0, SA0, SB0, 3);
-			FP_CMP_S(IR1, SA1, SB1, 3);
-			if (IR0 == 3 && (FP_ISSIGNAN_S(SA0) || FP_ISSIGNAN_S(SB0)))
-				FP_SET_EXCEPTION(FP_EX_INVALID);
-			if (IR1 == 3 && (FP_ISSIGNAN_S(SA1) || FP_ISSIGNAN_S(SB1)))
-				FP_SET_EXCEPTION(FP_EX_INVALID);
+			FP_CMP_S(IR0, SA0, SB0, 3, 1);
+			FP_CMP_S(IR1, SA1, SB1, 3, 1);
 			ch = (IR0 == cmp) ? 1 : 0;
 			cl = (IR1 == cmp) ? 1 : 0;
 			IR = (ch << 3) | (cl << 2) | ((ch | cl) << 1) |
@@ -737,7 +777,7 @@ int speround_handler(struct pt_regs *regs)
 		return -EINVAL;         /* not an spe instruction */
 
 	func = speinsn & 0x7ff;
-	type = insn_type(func);
+	type = insn_type(func) & TYPE_MASK;
 	if (type == XCR) return -ENOSYS;
 
 	__FPU_FPSCR = mfspr(SPRN_SPEFSCR);
diff --git a/arch/powerpc/math-emu/mcrfs.c b/arch/powerpc/math-emu/mcrfs.c
index f37ea50..e948d57 100644
--- a/arch/powerpc/math-emu/mcrfs.c
+++ b/arch/powerpc/math-emu/mcrfs.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
+#include <math-emu/soft-fp.h>
 
 int
 mcrfs(u32 *ccr, u32 crfD, u32 crfS)
diff --git a/arch/powerpc/math-emu/mffs.c b/arch/powerpc/math-emu/mffs.c
index 558e621..5526cf9 100644
--- a/arch/powerpc/math-emu/mffs.c
+++ b/arch/powerpc/math-emu/mffs.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
+#include <math-emu/soft-fp.h>
 
 int
 mffs(u32 *frD)
diff --git a/arch/powerpc/math-emu/mtfsb0.c b/arch/powerpc/math-emu/mtfsb0.c
index 7c325d8..bc98558 100644
--- a/arch/powerpc/math-emu/mtfsb0.c
+++ b/arch/powerpc/math-emu/mtfsb0.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
+#include <math-emu/soft-fp.h>
 
 int
 mtfsb0(int crbD)
diff --git a/arch/powerpc/math-emu/mtfsb1.c b/arch/powerpc/math-emu/mtfsb1.c
index d15f724..fe6ed5a 100644
--- a/arch/powerpc/math-emu/mtfsb1.c
+++ b/arch/powerpc/math-emu/mtfsb1.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
+#include <math-emu/soft-fp.h>
 
 int
 mtfsb1(int crbD)
diff --git a/arch/powerpc/math-emu/mtfsf.c b/arch/powerpc/math-emu/mtfsf.c
index b352968..44b0fc8 100644
--- a/arch/powerpc/math-emu/mtfsf.c
+++ b/arch/powerpc/math-emu/mtfsf.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
+#include <math-emu/soft-fp.h>
 
 int
 mtfsf(unsigned int FM, u32 *frB)
diff --git a/arch/powerpc/math-emu/mtfsfi.c b/arch/powerpc/math-emu/mtfsfi.c
index 8abeb3c..fd2acc2 100644
--- a/arch/powerpc/math-emu/mtfsfi.c
+++ b/arch/powerpc/math-emu/mtfsfi.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
+#include <math-emu/soft-fp.h>
 
 int
 mtfsfi(unsigned int crfD, unsigned int IMM)
diff --git a/arch/powerpc/math-emu/stfs.c b/arch/powerpc/math-emu/stfs.c
index 8430631..6072b14 100644
--- a/arch/powerpc/math-emu/stfs.c
+++ b/arch/powerpc/math-emu/stfs.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/single.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 stfs(void *frS, void *ea)
@@ -19,19 +19,19 @@ stfs(void *frS, void *ea)
 	printk("%s: S %p, ea %p\n", __func__, frS, ea);
 #endif
 
-	FP_UNPACK_DP(A, frS);
+	FP_UNPACK_SEMIRAW_DP(A, frS);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
 #endif
 
-	FP_CONV(S, D, 1, 2, R, A);
+	FP_TRUNC(S, D, 1, 2, R, A);
 
 #ifdef DEBUG
 	printk("R: %ld %lu %ld (%ld)\n", R_s, R_f, R_e, R_c);
 #endif
 
-	_FP_PACK_CANONICAL(S, 1, R);
+	_FP_PACK_SEMIRAW(S, 1, R);
 	if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS)) {
 		_FP_PACK_RAW_1_P(S, &f, R);
 		if (copy_to_user(ea, &f, sizeof(float)))
diff --git a/arch/powerpc/math-emu/udivmodti4.c b/arch/powerpc/math-emu/udivmodti4.c
index 86e4013..6172044 100644
--- a/arch/powerpc/math-emu/udivmodti4.c
+++ b/arch/powerpc/math-emu/udivmodti4.c
@@ -1,6 +1,6 @@
 /* This has so very few changes over libgcc2's __udivmoddi4 it isn't funny.  */
 
-#include <math-emu-old/soft-fp.h>
+#include <math-emu/soft-fp.h>
 
 #undef count_leading_zeros
 #define count_leading_zeros  __FP_CLZ

-- 
Joseph S. Myers
joseph@codesourcery.com

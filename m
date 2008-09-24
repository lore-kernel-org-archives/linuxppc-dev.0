Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4CCEDDF4A
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 01:01:00 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m8OF0uIA002015
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 10:00:57 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/math-emu: Use kernel generic math-emu code
Date: Wed, 24 Sep 2008 10:00:56 -0500
Message-Id: <1222268456-22541-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The math emulation code is centered around a set of generic macros that
provide the core of the emulation that are shared by the various
architectures and other projects (like glibc).  Each arch implements its
own sfp-machine.h to specific various arch specific details.

For historic reasons that are now lost the powerpc math-emu code had
its own version of the common headers.  This moves us to using the
kernel generic version and thus getting fixes when those are updated.

Also cleaned up exception/error reporting from the FP emulation functions.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

With a better commit message, no code changes.

- k

 .../{math-emu => include/asm}/sfp-machine.h        |  114 ++--
 arch/powerpc/math-emu/Makefile                     |    7 +-
 arch/powerpc/math-emu/double.h                     |  129 ----
 arch/powerpc/math-emu/fadd.c                       |   17 +-
 arch/powerpc/math-emu/fadds.c                      |   20 +-
 arch/powerpc/math-emu/fcmpo.c                      |   10 +-
 arch/powerpc/math-emu/fcmpu.c                      |   10 +-
 arch/powerpc/math-emu/fctiw.c                      |    8 +-
 arch/powerpc/math-emu/fctiwz.c                     |    8 +-
 arch/powerpc/math-emu/fdiv.c                       |   14 +-
 arch/powerpc/math-emu/fdivs.c                      |   16 +-
 arch/powerpc/math-emu/fmadd.c                      |   16 +-
 arch/powerpc/math-emu/fmadds.c                     |   18 +-
 arch/powerpc/math-emu/fmsub.c                      |   16 +-
 arch/powerpc/math-emu/fmsubs.c                     |   18 +-
 arch/powerpc/math-emu/fmul.c                       |   14 +-
 arch/powerpc/math-emu/fmuls.c                      |   16 +-
 arch/powerpc/math-emu/fnmadd.c                     |   16 +-
 arch/powerpc/math-emu/fnmadds.c                    |   18 +-
 arch/powerpc/math-emu/fnmsub.c                     |   16 +-
 arch/powerpc/math-emu/fnmsubs.c                    |   18 +-
 arch/powerpc/math-emu/frsp.c                       |   14 +-
 arch/powerpc/math-emu/fsel.c                       |    8 +-
 arch/powerpc/math-emu/fsqrt.c                      |   12 +-
 arch/powerpc/math-emu/fsqrts.c                     |   14 +-
 arch/powerpc/math-emu/fsub.c                       |   14 +-
 arch/powerpc/math-emu/fsubs.c                      |   16 +-
 arch/powerpc/math-emu/lfd.c                        |    4 +-
 arch/powerpc/math-emu/lfs.c                        |   19 +-
 arch/powerpc/math-emu/math.c                       |    8 +-
 arch/powerpc/math-emu/mcrfs.c                      |    3 +-
 arch/powerpc/math-emu/mffs.c                       |    3 +-
 arch/powerpc/math-emu/mtfsb0.c                     |    3 +-
 arch/powerpc/math-emu/mtfsb1.c                     |    3 +-
 arch/powerpc/math-emu/mtfsf.c                      |   20 +-
 arch/powerpc/math-emu/mtfsfi.c                     |    3 +-
 arch/powerpc/math-emu/op-1.h                       |  245 -------
 arch/powerpc/math-emu/op-2.h                       |  434 ------------
 arch/powerpc/math-emu/op-4.h                       |  317 ---------
 arch/powerpc/math-emu/op-common.h                  |  688 --------------------
 arch/powerpc/math-emu/single.h                     |   66 --
 arch/powerpc/math-emu/soft-fp.h                    |  104 ---
 arch/powerpc/math-emu/stfs.c                       |   19 +-
 arch/powerpc/math-emu/types.c                      |   51 --
 arch/powerpc/math-emu/udivmodti4.c                 |    2 +-
 45 files changed, 323 insertions(+), 2266 deletions(-)
 rename arch/powerpc/{math-emu => include/asm}/sfp-machine.h (83%)
 delete mode 100644 arch/powerpc/math-emu/double.h
 delete mode 100644 arch/powerpc/math-emu/op-1.h
 delete mode 100644 arch/powerpc/math-emu/op-2.h
 delete mode 100644 arch/powerpc/math-emu/op-4.h
 delete mode 100644 arch/powerpc/math-emu/op-common.h
 delete mode 100644 arch/powerpc/math-emu/single.h
 delete mode 100644 arch/powerpc/math-emu/soft-fp.h
 delete mode 100644 arch/powerpc/math-emu/types.c

diff --git a/arch/powerpc/math-emu/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
similarity index 83%
rename from arch/powerpc/math-emu/sfp-machine.h
rename to arch/powerpc/include/asm/sfp-machine.h
index 4b17d83..ced34f1 100644
--- a/arch/powerpc/math-emu/sfp-machine.h
+++ b/arch/powerpc/include/asm/sfp-machine.h
@@ -79,27 +79,44 @@
  * #define _FP_DIV_MEAT_D(R,X,Y)   _FP_DIV_MEAT_2_udiv_64(D,R,X,Y)
  */
 
-#define _FP_MUL_MEAT_S(R,X,Y)   _FP_MUL_MEAT_1_wide(S,R,X,Y,umul_ppmm)
-#define _FP_MUL_MEAT_D(R,X,Y)   _FP_MUL_MEAT_2_wide(D,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_S(R,X,Y)   _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_D(R,X,Y)   _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
 
-#define _FP_DIV_MEAT_S(R,X,Y)   _FP_DIV_MEAT_1_udiv(S,R,X,Y)
-#define _FP_DIV_MEAT_D(R,X,Y)   _FP_DIV_MEAT_2_udiv_64(D,R,X,Y)
+#define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_udiv(S,R,X,Y)
+#define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_2_udiv(D,R,X,Y)
 
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
 
+/* Exception flags.  We use the bit positions of the appropriate bits
+   in the FPSCR, which also correspond to the FE_* bits.  This makes
+   everything easier ;-).  */
+#define FP_EX_INVALID         (1 << (31 - 2))
+#define FP_EX_INVALID_SNAN	EFLAG_VXSNAN
+#define FP_EX_INVALID_ISI	EFLAG_VXISI
+#define FP_EX_INVALID_IDI	EFLAG_VXIDI
+#define FP_EX_INVALID_ZDZ	EFLAG_VXZDZ
+#define FP_EX_INVALID_IMZ	EFLAG_VXIMZ
+#define FP_EX_OVERFLOW        (1 << (31 - 3))
+#define FP_EX_UNDERFLOW       (1 << (31 - 4))
+#define FP_EX_DIVZERO         (1 << (31 - 5))
+#define FP_EX_INEXACT         (1 << (31 - 6))
+
 /* This macro appears to be called when both X and Y are NaNs, and
  * has to choose one and copy it to R. i386 goes for the larger of the
  * two, sparc64 just picks Y. I don't understand this at all so I'll
  * go with sparc64 because it's shorter :->   -- PMM
  */
-#define _FP_CHOOSENAN(fs, wc, R, X, Y)			\
+#define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)		\
   do {							\
     R##_s = Y##_s;					\
     _FP_FRAC_COPY_##wc(R,Y);				\
@@ -107,62 +124,6 @@
   } while (0)
 
 
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
-  } while (0)
-
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
 #include <linux/kernel.h>
 #include <linux/sched.h>
 
@@ -182,15 +143,30 @@ extern int  fp_pack_ds(void *, long, unsigned long, unsigned long, long, long);
 #define __FP_PACK_S(val,X)			\
 ({  int __exc = _FP_PACK_CANONICAL(S,1,X);	\
     if(!__exc || !__FPU_TRAP_P(__exc))		\
-        __FP_PACK_RAW_1(S,val,X);		\
+        _FP_PACK_RAW_1_P(S,val,X);		\
     __exc;					\
 })
 
 #define __FP_PACK_D(val,X)			\
-	fp_pack_d(val, X##_s, X##_f1, X##_f0, X##_e, X##_c)
-
-#define __FP_PACK_DS(val,X)			\
-	fp_pack_ds(val, X##_s, X##_f1, X##_f0, X##_e, X##_c)
+   do {									\
+	_FP_PACK_CANONICAL(D, 2, X);					\
+	if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS))	\
+		_FP_PACK_RAW_2_P(D, val, X);				\
+   } while (0)
+
+#define __FP_PACK_DS(val,X)							\
+   do {										\
+	   FP_DECL_S(__X);							\
+	   FP_CONV(S, D, 1, 2, __X, X);						\
+	   _FP_PACK_CANONICAL(S, 1, __X);					\
+	   if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS)) {	\
+		   _FP_UNPACK_CANONICAL(S, 1, __X);				\
+		   FP_CONV(D, S, 2, 1, X, __X);					\
+		   _FP_PACK_CANONICAL(D, 2, X);					\
+		   if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS))	\
+		   _FP_PACK_RAW_2_P(D, val, X);					\
+	   }									\
+   } while (0)
 
 /* Obtain the current rounding mode. */
 #define FP_ROUNDMODE			\
diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
index 29bc912..03aa98d 100644
--- a/arch/powerpc/math-emu/Makefile
+++ b/arch/powerpc/math-emu/Makefile
@@ -4,13 +4,14 @@ obj-y				:= math.o fmr.o lfd.o stfd.o
 obj-$(CONFIG_MATH_EMULATION)	+= fabs.o fadd.o fadds.o fcmpo.o fcmpu.o \
 					fctiw.o fctiwz.o fdiv.o fdivs.o \
 					fmadd.o fmadds.o fmsub.o fmsubs.o \
-					fmul.o fmuls.o fnabs.o fneg.o types.o \
+					fmul.o fmuls.o fnabs.o fneg.o \
 					fnmadd.o fnmadds.o fnmsub.o fnmsubs.o \
 					fres.o frsp.o frsqrte.o fsel.o lfs.o \
 					fsqrt.o	fsqrts.o fsub.o fsubs.o \
 					mcrfs.o mffs.o mtfsb0.o mtfsb1.o \
-					mtfsf.o mtfsfi.o stfiwx.o stfs.o \
-					udivmodti4.o
+					mtfsf.o mtfsfi.o stfiwx.o stfs.o
 
 CFLAGS_fabs.o = -fno-builtin-fabs
 CFLAGS_math.o = -fno-builtin-fabs
+
+EXTRA_CFLAGS = -I. -Iinclude/math-emu -w
diff --git a/arch/powerpc/math-emu/double.h b/arch/powerpc/math-emu/double.h
deleted file mode 100644
index ffba8b6..0000000
--- a/arch/powerpc/math-emu/double.h
+++ /dev/null
@@ -1,129 +0,0 @@
-/*
- * Definitions for IEEE Double Precision
- */
-
-#if _FP_W_TYPE_SIZE < 32
-#error "Here's a nickel kid.  Go buy yourself a real computer."
-#endif
-
-#if _FP_W_TYPE_SIZE < 64
-#define _FP_FRACTBITS_D		(2 * _FP_W_TYPE_SIZE)
-#else
-#define _FP_FRACTBITS_D		_FP_W_TYPE_SIZE
-#endif
-
-#define _FP_FRACBITS_D		53
-#define _FP_FRACXBITS_D		(_FP_FRACTBITS_D - _FP_FRACBITS_D)
-#define _FP_WFRACBITS_D		(_FP_WORKBITS + _FP_FRACBITS_D)
-#define _FP_WFRACXBITS_D	(_FP_FRACTBITS_D - _FP_WFRACBITS_D)
-#define _FP_EXPBITS_D		11
-#define _FP_EXPBIAS_D		1023
-#define _FP_EXPMAX_D		2047
-
-#define _FP_QNANBIT_D		\
-	((_FP_W_TYPE)1 << ((_FP_FRACBITS_D-2) % _FP_W_TYPE_SIZE))
-#define _FP_IMPLBIT_D		\
-	((_FP_W_TYPE)1 << ((_FP_FRACBITS_D-1) % _FP_W_TYPE_SIZE))
-#define _FP_OVERFLOW_D		\
-	((_FP_W_TYPE)1 << (_FP_WFRACBITS_D % _FP_W_TYPE_SIZE))
-
-#if _FP_W_TYPE_SIZE < 64
-
-union _FP_UNION_D
-{
-  double flt;
-  struct {
-#if __BYTE_ORDER == __BIG_ENDIAN
-    unsigned sign  : 1;
-    unsigned exp   : _FP_EXPBITS_D;
-    unsigned frac1 : _FP_FRACBITS_D - (_FP_IMPLBIT_D != 0) - _FP_W_TYPE_SIZE;
-    unsigned frac0 : _FP_W_TYPE_SIZE;
-#else
-    unsigned frac0 : _FP_W_TYPE_SIZE;
-    unsigned frac1 : _FP_FRACBITS_D - (_FP_IMPLBIT_D != 0) - _FP_W_TYPE_SIZE;
-    unsigned exp   : _FP_EXPBITS_D;
-    unsigned sign  : 1;
-#endif
-  } bits __attribute__((packed));
-};
-
-#define FP_DECL_D(X)		_FP_DECL(2,X)
-#define FP_UNPACK_RAW_D(X,val)	_FP_UNPACK_RAW_2(D,X,val)
-#define FP_PACK_RAW_D(val,X)	_FP_PACK_RAW_2(D,val,X)
-
-#define FP_UNPACK_D(X,val)		\
-  do {					\
-    _FP_UNPACK_RAW_2(D,X,val);		\
-    _FP_UNPACK_CANONICAL(D,2,X);	\
-  } while (0)
-
-#define FP_PACK_D(val,X)		\
-  do {					\
-    _FP_PACK_CANONICAL(D,2,X);		\
-    _FP_PACK_RAW_2(D,val,X);		\
-  } while (0)
-
-#define FP_NEG_D(R,X)		_FP_NEG(D,2,R,X)
-#define FP_ADD_D(R,X,Y)		_FP_ADD(D,2,R,X,Y)
-#define FP_SUB_D(R,X,Y)		_FP_SUB(D,2,R,X,Y)
-#define FP_MUL_D(R,X,Y)		_FP_MUL(D,2,R,X,Y)
-#define FP_DIV_D(R,X,Y)		_FP_DIV(D,2,R,X,Y)
-#define FP_SQRT_D(R,X)		_FP_SQRT(D,2,R,X)
-
-#define FP_CMP_D(r,X,Y,un)	_FP_CMP(D,2,r,X,Y,un)
-#define FP_CMP_EQ_D(r,X,Y)	_FP_CMP_EQ(D,2,r,X,Y)
-
-#define FP_TO_INT_D(r,X,rsz,rsg)  _FP_TO_INT(D,2,r,X,rsz,rsg)
-#define FP_FROM_INT_D(X,r,rs,rt)  _FP_FROM_INT(D,2,X,r,rs,rt)
-
-#else
-
-union _FP_UNION_D
-{
-  double flt;
-  struct {
-#if __BYTE_ORDER == __BIG_ENDIAN
-    unsigned sign : 1;
-    unsigned exp  : _FP_EXPBITS_D;
-    unsigned long frac : _FP_FRACBITS_D - (_FP_IMPLBIT_D != 0);
-#else
-    unsigned long frac : _FP_FRACBITS_D - (_FP_IMPLBIT_D != 0);
-    unsigned exp  : _FP_EXPBITS_D;
-    unsigned sign : 1;
-#endif
-  } bits __attribute__((packed));
-};
-
-#define FP_DECL_D(X)		_FP_DECL(1,X)
-#define FP_UNPACK_RAW_D(X,val)	_FP_UNPACK_RAW_1(D,X,val)
-#define FP_PACK_RAW_D(val,X)	_FP_PACK_RAW_1(D,val,X)
-
-#define FP_UNPACK_D(X,val)		\
-  do {					\
-    _FP_UNPACK_RAW_1(D,X,val);		\
-    _FP_UNPACK_CANONICAL(D,1,X);	\
-  } while (0)
-
-#define FP_PACK_D(val,X)		\
-  do {					\
-    _FP_PACK_CANONICAL(D,1,X);		\
-    _FP_PACK_RAW_1(D,val,X);		\
-  } while (0)
-
-#define FP_NEG_D(R,X)		_FP_NEG(D,1,R,X)
-#define FP_ADD_D(R,X,Y)		_FP_ADD(D,1,R,X,Y)
-#define FP_SUB_D(R,X,Y)		_FP_SUB(D,1,R,X,Y)
-#define FP_MUL_D(R,X,Y)		_FP_MUL(D,1,R,X,Y)
-#define FP_DIV_D(R,X,Y)		_FP_DIV(D,1,R,X,Y)
-#define FP_SQRT_D(R,X)		_FP_SQRT(D,1,R,X)
-
-/* The implementation of _FP_MUL_D and _FP_DIV_D should be chosen by
-   the target machine.  */
-
-#define FP_CMP_D(r,X,Y,un)	_FP_CMP(D,1,r,X,Y,un)
-#define FP_CMP_EQ_D(r,X,Y)	_FP_CMP_EQ(D,1,r,X,Y)
-
-#define FP_TO_INT_D(r,X,rsz,rsg)  _FP_TO_INT(D,1,r,X,rsz,rsg)
-#define FP_FROM_INT_D(X,r,rs,rt)  _FP_FROM_INT(D,1,X,r,rs,rt)
-
-#endif /* W_TYPE_SIZE < 64 */
diff --git a/arch/powerpc/math-emu/fadd.c b/arch/powerpc/math-emu/fadd.c
index 7befbbf..04d3b4a 100644
--- a/arch/powerpc/math-emu/fadd.c
+++ b/arch/powerpc/math-emu/fadd.c
@@ -2,8 +2,9 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fadd(void *frD, void *frA, void *frB)
@@ -11,28 +12,28 @@ fadd(void *frD, void *frA, void *frB)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
 	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
 #endif
 
-	if (A_s != B_s && A_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
-
 	FP_ADD_D(R, A, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_D(frD, R));
+	__FP_PACK_D(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fadds.c b/arch/powerpc/math-emu/fadds.c
index 2b346b3..5930f40 100644
--- a/arch/powerpc/math-emu/fadds.c
+++ b/arch/powerpc/math-emu/fadds.c
@@ -2,9 +2,10 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fadds(void *frD, void *frA, void *frB)
@@ -12,28 +13,27 @@ fadds(void *frD, void *frA, void *frB)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
-	int ret = 0;
+	FP_DECL_EX;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
 	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
 #endif
 
-	if (A_s != B_s && A_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
-
 	FP_ADD_D(R, A, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_DS(frD, R));
+	__FP_PACK_DS(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fcmpo.c b/arch/powerpc/math-emu/fcmpo.c
index 36d6890..b5dc449 100644
--- a/arch/powerpc/math-emu/fcmpo.c
+++ b/arch/powerpc/math-emu/fcmpo.c
@@ -2,14 +2,16 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fcmpo(u32 *ccr, int crfD, void *frA, void *frB)
 {
 	FP_DECL_D(A);
 	FP_DECL_D(B);
+	FP_DECL_EX;
 	int code[4] = { (1 << 3), (1 << 1), (1 << 2), (1 << 0) };
 	long cmp;
 	int ret = 0;
@@ -18,8 +20,8 @@ fcmpo(u32 *ccr, int crfD, void *frA, void *frB)
 	printk("%s: %p (%08x) %d %p %p\n", __func__, ccr, *ccr, crfD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
diff --git a/arch/powerpc/math-emu/fcmpu.c b/arch/powerpc/math-emu/fcmpu.c
index 53d9389..d4fb1ba 100644
--- a/arch/powerpc/math-emu/fcmpu.c
+++ b/arch/powerpc/math-emu/fcmpu.c
@@ -2,14 +2,16 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
 {
 	FP_DECL_D(A);
 	FP_DECL_D(B);
+	FP_DECL_EX;
 	int code[4] = { (1 << 3), (1 << 1), (1 << 2), (1 << 0) };
 	long cmp;
 
@@ -17,8 +19,8 @@ fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
 	printk("%s: %p (%08x) %d %p %p\n", __func__, ccr, *ccr, crfD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
diff --git a/arch/powerpc/math-emu/fctiw.c b/arch/powerpc/math-emu/fctiw.c
index fcd7a95..f694440 100644
--- a/arch/powerpc/math-emu/fctiw.c
+++ b/arch/powerpc/math-emu/fctiw.c
@@ -2,16 +2,18 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fctiw(u32 *frD, void *frB)
 {
 	FP_DECL_D(B);
+	FP_DECL_EX;
 	unsigned int r;
 
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(B, frB);
 	FP_TO_INT_D(r, B, 32, 1);
 	frD[1] = r;
 
diff --git a/arch/powerpc/math-emu/fctiwz.c b/arch/powerpc/math-emu/fctiwz.c
index 1514d59..71e782f 100644
--- a/arch/powerpc/math-emu/fctiwz.c
+++ b/arch/powerpc/math-emu/fctiwz.c
@@ -2,13 +2,15 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fctiwz(u32 *frD, void *frB)
 {
 	FP_DECL_D(B);
+	FP_DECL_EX;
 	u32 fpscr;
 	unsigned int r;
 
@@ -16,7 +18,7 @@ fctiwz(u32 *frD, void *frB)
 	__FPU_FPSCR &= ~(3);
 	__FPU_FPSCR |= FP_RND_ZERO;
 
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(B, frB);
 	FP_TO_INT_D(r, B, 32, 1);
 	frD[1] = r;
 
diff --git a/arch/powerpc/math-emu/fdiv.c b/arch/powerpc/math-emu/fdiv.c
index 18a20fe..2db1509 100644
--- a/arch/powerpc/math-emu/fdiv.c
+++ b/arch/powerpc/math-emu/fdiv.c
@@ -2,8 +2,9 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fdiv(void *frD, void *frA, void *frB)
@@ -11,14 +12,15 @@ fdiv(void *frD, void *frA, void *frB)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -49,5 +51,7 @@ fdiv(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_D(frD, R));
+	__FP_PACK_D(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fdivs.c b/arch/powerpc/math-emu/fdivs.c
index 24feed6..797f6a9 100644
--- a/arch/powerpc/math-emu/fdivs.c
+++ b/arch/powerpc/math-emu/fdivs.c
@@ -2,9 +2,10 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fdivs(void *frD, void *frA, void *frB)
@@ -12,14 +13,15 @@ fdivs(void *frD, void *frA, void *frB)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -51,5 +53,7 @@ fdivs(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_DS(frD, R));
+	__FP_PACK_DS(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fmadd.c b/arch/powerpc/math-emu/fmadd.c
index dedb465..925313a 100644
--- a/arch/powerpc/math-emu/fmadd.c
+++ b/arch/powerpc/math-emu/fmadd.c
@@ -2,8 +2,9 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fmadd(void *frD, void *frA, void *frB, void *frC)
@@ -13,15 +14,16 @@ fmadd(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -44,5 +46,7 @@ fmadd(void *frD, void *frA, void *frB, void *frC)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_D(frD, R));
+	__FP_PACK_D(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fmadds.c b/arch/powerpc/math-emu/fmadds.c
index 6bbb56d..aea80ef 100644
--- a/arch/powerpc/math-emu/fmadds.c
+++ b/arch/powerpc/math-emu/fmadds.c
@@ -2,9 +2,10 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fmadds(void *frD, void *frA, void *frB, void *frC)
@@ -14,15 +15,16 @@ fmadds(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -45,5 +47,7 @@ fmadds(void *frD, void *frA, void *frB, void *frC)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_DS(frD, R));
+	__FP_PACK_DS(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fmsub.c b/arch/powerpc/math-emu/fmsub.c
index f311e2c..a644d52 100644
--- a/arch/powerpc/math-emu/fmsub.c
+++ b/arch/powerpc/math-emu/fmsub.c
@@ -2,8 +2,9 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fmsub(void *frD, void *frA, void *frB, void *frC)
@@ -13,15 +14,16 @@ fmsub(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -47,5 +49,7 @@ fmsub(void *frD, void *frA, void *frB, void *frC)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_D(frD, R));
+	__FP_PACK_D(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fmsubs.c b/arch/powerpc/math-emu/fmsubs.c
index 81a716d..2fdeeb9 100644
--- a/arch/powerpc/math-emu/fmsubs.c
+++ b/arch/powerpc/math-emu/fmsubs.c
@@ -2,9 +2,10 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fmsubs(void *frD, void *frA, void *frB, void *frC)
@@ -14,15 +15,16 @@ fmsubs(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -48,5 +50,7 @@ fmsubs(void *frD, void *frA, void *frB, void *frC)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_DS(frD, R));
+	__FP_PACK_DS(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fmul.c b/arch/powerpc/math-emu/fmul.c
index 2f3d327..391fd17 100644
--- a/arch/powerpc/math-emu/fmul.c
+++ b/arch/powerpc/math-emu/fmul.c
@@ -2,8 +2,9 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fmul(void *frD, void *frA, void *frB)
@@ -11,14 +12,15 @@ fmul(void *frD, void *frA, void *frB)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld) [%08lx.%08lx %lx]\n",
@@ -38,5 +40,7 @@ fmul(void *frD, void *frA, void *frB)
 	       R_s, R_f1, R_f0, R_e, R_c, R_f1, R_f0, R_e + 1023);
 #endif
 
-	return (ret | __FP_PACK_D(frD, R));
+	__FP_PACK_D(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fmuls.c b/arch/powerpc/math-emu/fmuls.c
index 962b588..2d3ec5f 100644
--- a/arch/powerpc/math-emu/fmuls.c
+++ b/arch/powerpc/math-emu/fmuls.c
@@ -2,9 +2,10 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fmuls(void *frD, void *frA, void *frB)
@@ -12,14 +13,15 @@ fmuls(void *frD, void *frA, void *frB)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld) [%08lx.%08lx %lx]\n",
@@ -39,5 +41,7 @@ fmuls(void *frD, void *frA, void *frB)
 	       R_s, R_f1, R_f0, R_e, R_c, R_f1, R_f0, R_e + 1023);
 #endif
 
-	return (ret | __FP_PACK_DS(frD, R));
+	__FP_PACK_DS(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fnmadd.c b/arch/powerpc/math-emu/fnmadd.c
index 8cf7827..2497b86 100644
--- a/arch/powerpc/math-emu/fnmadd.c
+++ b/arch/powerpc/math-emu/fnmadd.c
@@ -2,8 +2,9 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fnmadd(void *frD, void *frA, void *frB, void *frC)
@@ -13,15 +14,16 @@ fnmadd(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -47,5 +49,7 @@ fnmadd(void *frD, void *frA, void *frB, void *frC)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_D(frD, R));
+	__FP_PACK_D(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fnmadds.c b/arch/powerpc/math-emu/fnmadds.c
index f1c4f0f..ee9d71e 100644
--- a/arch/powerpc/math-emu/fnmadds.c
+++ b/arch/powerpc/math-emu/fnmadds.c
@@ -2,9 +2,10 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fnmadds(void *frD, void *frA, void *frB, void *frC)
@@ -14,15 +15,16 @@ fnmadds(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -48,5 +50,7 @@ fnmadds(void *frD, void *frA, void *frB, void *frC)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_DS(frD, R));
+	__FP_PACK_DS(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fnmsub.c b/arch/powerpc/math-emu/fnmsub.c
index 98944e6..3885a77 100644
--- a/arch/powerpc/math-emu/fnmsub.c
+++ b/arch/powerpc/math-emu/fnmsub.c
@@ -2,8 +2,9 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fnmsub(void *frD, void *frA, void *frB, void *frC)
@@ -13,15 +14,16 @@ fnmsub(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -50,5 +52,7 @@ fnmsub(void *frD, void *frA, void *frB, void *frC)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_D(frD, R));
+	__FP_PACK_D(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fnmsubs.c b/arch/powerpc/math-emu/fnmsubs.c
index b20f4eb..f835dfe 100644
--- a/arch/powerpc/math-emu/fnmsubs.c
+++ b/arch/powerpc/math-emu/fnmsubs.c
@@ -2,9 +2,10 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fnmsubs(void *frD, void *frA, void *frB, void *frC)
@@ -14,15 +15,16 @@ fnmsubs(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -51,5 +53,7 @@ fnmsubs(void *frD, void *frA, void *frB, void *frC)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_DS(frD, R));
+	__FP_PACK_DS(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/frsp.c b/arch/powerpc/math-emu/frsp.c
index 724ccbc..ddcc146 100644
--- a/arch/powerpc/math-emu/frsp.c
+++ b/arch/powerpc/math-emu/frsp.c
@@ -2,24 +2,28 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 frsp(void *frD, void *frB)
 {
 	FP_DECL_D(B);
+	FP_DECL_EX;
 
 #ifdef DEBUG
 	printk("%s: D %p, B %p\n", __func__, frD, frB);
 #endif
 
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
 #endif
 
-	return __FP_PACK_DS(frD, B);
+	__FP_PACK_DS(frD, B);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fsel.c b/arch/powerpc/math-emu/fsel.c
index ecb5f28..1b0c144 100644
--- a/arch/powerpc/math-emu/fsel.c
+++ b/arch/powerpc/math-emu/fsel.c
@@ -2,19 +2,21 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fsel(u32 *frD, void *frA, u32 *frB, u32 *frC)
 {
 	FP_DECL_D(A);
+	FP_DECL_EX;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
+	FP_UNPACK_DP(A, frA);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
diff --git a/arch/powerpc/math-emu/fsqrt.c b/arch/powerpc/math-emu/fsqrt.c
index 38ec2b7..3e90072 100644
--- a/arch/powerpc/math-emu/fsqrt.c
+++ b/arch/powerpc/math-emu/fsqrt.c
@@ -2,21 +2,23 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fsqrt(void *frD, void *frB)
 {
 	FP_DECL_D(B);
 	FP_DECL_D(R);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frB);
 #endif
 
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
@@ -33,5 +35,7 @@ fsqrt(void *frD, void *frB)
 	printk("R: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_D(frD, R));
+	__FP_PACK_D(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fsqrts.c b/arch/powerpc/math-emu/fsqrts.c
index 335263e..2843be9 100644
--- a/arch/powerpc/math-emu/fsqrts.c
+++ b/arch/powerpc/math-emu/fsqrts.c
@@ -2,22 +2,24 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fsqrts(void *frD, void *frB)
 {
 	FP_DECL_D(B);
 	FP_DECL_D(R);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frB);
 #endif
 
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
@@ -34,5 +36,7 @@ fsqrts(void *frD, void *frB)
 	printk("R: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_DS(frD, R));
+	__FP_PACK_DS(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fsub.c b/arch/powerpc/math-emu/fsub.c
index 208d20f..78b0944 100644
--- a/arch/powerpc/math-emu/fsub.c
+++ b/arch/powerpc/math-emu/fsub.c
@@ -2,8 +2,9 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fsub(void *frD, void *frA, void *frB)
@@ -11,14 +12,15 @@ fsub(void *frD, void *frA, void *frB)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -37,5 +39,7 @@ fsub(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_D(frD, R));
+	__FP_PACK_D(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fsubs.c b/arch/powerpc/math-emu/fsubs.c
index 0e61b80..d3bf908 100644
--- a/arch/powerpc/math-emu/fsubs.c
+++ b/arch/powerpc/math-emu/fsubs.c
@@ -2,9 +2,10 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fsubs(void *frD, void *frA, void *frB)
@@ -12,14 +13,15 @@ fsubs(void *frD, void *frA, void *frB)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
+	FP_DECL_EX;
 	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -38,5 +40,7 @@ fsubs(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_DS(frD, R));
+	__FP_PACK_DS(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/lfd.c b/arch/powerpc/math-emu/lfd.c
index 6ec90b5..79ac76d 100644
--- a/arch/powerpc/math-emu/lfd.c
+++ b/arch/powerpc/math-emu/lfd.c
@@ -2,8 +2,8 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "sfp-machine.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/double.h>
 
 int
 lfd(void *frD, void *ea)
diff --git a/arch/powerpc/math-emu/lfs.c b/arch/powerpc/math-emu/lfs.c
index 6f18ebe..434ed27 100644
--- a/arch/powerpc/math-emu/lfs.c
+++ b/arch/powerpc/math-emu/lfs.c
@@ -2,15 +2,17 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 lfs(void *frD, void *ea)
 {
 	FP_DECL_D(R);
 	FP_DECL_S(A);
+	FP_DECL_EX;
 	float f;
 
 #ifdef DEBUG
@@ -20,7 +22,7 @@ lfs(void *frD, void *ea)
 	if (copy_from_user(&f, ea, sizeof(float)))
 		return -EFAULT;
 
-	__FP_UNPACK_S(A, &f);
+	FP_UNPACK_S(A, f);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %ld (%ld) [%08lx]\n", A_s, A_f, A_e, A_c,
@@ -33,5 +35,12 @@ lfs(void *frD, void *ea)
 	printk("R: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return __FP_PACK_D(frD, R);
+	if (R_c == FP_CLS_NAN) {
+		R_e = _FP_EXPMAX_D;
+		_FP_PACK_RAW_2_P(D, frD, R);
+	} else {
+		__FP_PACK_D(frD, R);
+	}
+
+	return 0;
 }
diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index 29e545e..164d559 100644
--- a/arch/powerpc/math-emu/math.c
+++ b/arch/powerpc/math-emu/math.c
@@ -8,8 +8,8 @@
 #include <asm/uaccess.h>
 #include <asm/reg.h>
 
-#include "sfp-machine.h"
-#include "double.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/double.h>
 
 #define FLOATFUNC(x)	extern int x(void *, void *, void *, void *)
 
@@ -168,6 +168,8 @@ record_exception(struct pt_regs *regs, int eflag)
 			fpscr |= FPSCR_ZX;
 		if (eflag & EFLAG_INEXACT)
 			fpscr |= FPSCR_XX;
+		if (eflag & EFLAG_INVALID)
+			fpscr |= FPSCR_VX;
 		if (eflag & EFLAG_VXSNAN)
 			fpscr |= FPSCR_VXSNAN;
 		if (eflag & EFLAG_VXISI)
@@ -188,7 +190,7 @@ record_exception(struct pt_regs *regs, int eflag)
 			fpscr |= FPSCR_VXCVI;
 	}
 
-	fpscr &= ~(FPSCR_VX);
+//	fpscr &= ~(FPSCR_VX);
 	if (fpscr & (FPSCR_VXSNAN | FPSCR_VXISI | FPSCR_VXIDI |
 		     FPSCR_VXZDZ | FPSCR_VXIMZ | FPSCR_VXVC |
 		     FPSCR_VXSOFT | FPSCR_VXSQRT | FPSCR_VXCVI))
diff --git a/arch/powerpc/math-emu/mcrfs.c b/arch/powerpc/math-emu/mcrfs.c
index 41ba247..e948d57 100644
--- a/arch/powerpc/math-emu/mcrfs.c
+++ b/arch/powerpc/math-emu/mcrfs.c
@@ -2,7 +2,8 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
 
 int
 mcrfs(u32 *ccr, u32 crfD, u32 crfS)
diff --git a/arch/powerpc/math-emu/mffs.c b/arch/powerpc/math-emu/mffs.c
index b0e2106..5526cf9 100644
--- a/arch/powerpc/math-emu/mffs.c
+++ b/arch/powerpc/math-emu/mffs.c
@@ -2,7 +2,8 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
 
 int
 mffs(u32 *frD)
diff --git a/arch/powerpc/math-emu/mtfsb0.c b/arch/powerpc/math-emu/mtfsb0.c
index d306235..bc98558 100644
--- a/arch/powerpc/math-emu/mtfsb0.c
+++ b/arch/powerpc/math-emu/mtfsb0.c
@@ -2,7 +2,8 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
 
 int
 mtfsb0(int crbD)
diff --git a/arch/powerpc/math-emu/mtfsb1.c b/arch/powerpc/math-emu/mtfsb1.c
index 2e94870..fe6ed5a 100644
--- a/arch/powerpc/math-emu/mtfsb1.c
+++ b/arch/powerpc/math-emu/mtfsb1.c
@@ -2,7 +2,8 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
 
 int
 mtfsb1(int crbD)
diff --git a/arch/powerpc/math-emu/mtfsf.c b/arch/powerpc/math-emu/mtfsf.c
index 48014d8..dbce92e 100644
--- a/arch/powerpc/math-emu/mtfsf.c
+++ b/arch/powerpc/math-emu/mtfsf.c
@@ -2,12 +2,14 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
 
 int
 mtfsf(unsigned int FM, u32 *frB)
 {
 	u32 mask;
+	u32 fpscr;
 
 	if (FM == 0)
 		return 0;
@@ -37,6 +39,22 @@ mtfsf(unsigned int FM, u32 *frB)
 	__FPU_FPSCR &= ~(mask);
 	__FPU_FPSCR |= (frB[1] & mask);
 
+	__FPU_FPSCR &= ~(FPSCR_VX);
+	if (__FPU_FPSCR & (FPSCR_VXSNAN | FPSCR_VXISI | FPSCR_VXIDI |
+		     FPSCR_VXZDZ | FPSCR_VXIMZ | FPSCR_VXVC |
+		     FPSCR_VXSOFT | FPSCR_VXSQRT | FPSCR_VXCVI))
+		__FPU_FPSCR |= FPSCR_VX;
+
+	fpscr = __FPU_FPSCR;
+	fpscr &= ~(FPSCR_FEX);
+	if (((fpscr & FPSCR_VX) && (fpscr & FPSCR_VE)) ||
+	    ((fpscr & FPSCR_OX) && (fpscr & FPSCR_OE)) ||
+	    ((fpscr & FPSCR_UX) && (fpscr & FPSCR_UE)) ||
+	    ((fpscr & FPSCR_ZX) && (fpscr & FPSCR_ZE)) ||
+	    ((fpscr & FPSCR_XX) && (fpscr & FPSCR_XE)))
+		fpscr |= FPSCR_FEX;
+	__FPU_FPSCR = fpscr;
+
 #ifdef DEBUG
 	printk("%s: %02x %p: %08lx\n", __func__, FM, frB, __FPU_FPSCR);
 #endif
diff --git a/arch/powerpc/math-emu/mtfsfi.c b/arch/powerpc/math-emu/mtfsfi.c
index 031e200..fd2acc2 100644
--- a/arch/powerpc/math-emu/mtfsfi.c
+++ b/arch/powerpc/math-emu/mtfsfi.c
@@ -2,7 +2,8 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
 
 int
 mtfsfi(unsigned int crfD, unsigned int IMM)
diff --git a/arch/powerpc/math-emu/op-1.h b/arch/powerpc/math-emu/op-1.h
deleted file mode 100644
index c92fa95..0000000
--- a/arch/powerpc/math-emu/op-1.h
+++ /dev/null
@@ -1,245 +0,0 @@
-/*
- * Basic one-word fraction declaration and manipulation.
- */
-
-#define _FP_FRAC_DECL_1(X)	_FP_W_TYPE X##_f
-#define _FP_FRAC_COPY_1(D,S)	(D##_f = S##_f)
-#define _FP_FRAC_SET_1(X,I)	(X##_f = I)
-#define _FP_FRAC_HIGH_1(X)	(X##_f)
-#define _FP_FRAC_LOW_1(X)	(X##_f)
-#define _FP_FRAC_WORD_1(X,w)	(X##_f)
-
-#define _FP_FRAC_ADDI_1(X,I)	(X##_f += I)
-#define _FP_FRAC_SLL_1(X,N)			\
-  do {						\
-    if (__builtin_constant_p(N) && (N) == 1)	\
-      X##_f += X##_f;				\
-    else					\
-      X##_f <<= (N);				\
-  } while (0)
-#define _FP_FRAC_SRL_1(X,N)	(X##_f >>= N)
-
-/* Right shift with sticky-lsb.  */
-#define _FP_FRAC_SRS_1(X,N,sz)	__FP_FRAC_SRS_1(X##_f, N, sz)
-
-#define __FP_FRAC_SRS_1(X,N,sz)						\
-   (X = (X >> (N) | (__builtin_constant_p(N) && (N) == 1		\
-		     ? X & 1 : (X << (_FP_W_TYPE_SIZE - (N))) != 0)))
-
-#define _FP_FRAC_ADD_1(R,X,Y)	(R##_f = X##_f + Y##_f)
-#define _FP_FRAC_SUB_1(R,X,Y)	(R##_f = X##_f - Y##_f)
-#define _FP_FRAC_CLZ_1(z, X)	__FP_CLZ(z, X##_f)
-
-/* Predicates */
-#define _FP_FRAC_NEGP_1(X)	((_FP_WS_TYPE)X##_f < 0)
-#define _FP_FRAC_ZEROP_1(X)	(X##_f == 0)
-#define _FP_FRAC_OVERP_1(fs,X)	(X##_f & _FP_OVERFLOW_##fs)
-#define _FP_FRAC_EQ_1(X, Y)	(X##_f == Y##_f)
-#define _FP_FRAC_GE_1(X, Y)	(X##_f >= Y##_f)
-#define _FP_FRAC_GT_1(X, Y)	(X##_f > Y##_f)
-
-#define _FP_ZEROFRAC_1		0
-#define _FP_MINFRAC_1		1
-
-/*
- * Unpack the raw bits of a native fp value.  Do not classify or
- * normalize the data.
- */
-
-#define _FP_UNPACK_RAW_1(fs, X, val)				\
-  do {								\
-    union _FP_UNION_##fs _flo; _flo.flt = (val);		\
-								\
-    X##_f = _flo.bits.frac;					\
-    X##_e = _flo.bits.exp;					\
-    X##_s = _flo.bits.sign;					\
-  } while (0)
-
-
-/*
- * Repack the raw bits of a native fp value.
- */
-
-#define _FP_PACK_RAW_1(fs, val, X)				\
-  do {								\
-    union _FP_UNION_##fs _flo;					\
-								\
-    _flo.bits.frac = X##_f;					\
-    _flo.bits.exp  = X##_e;					\
-    _flo.bits.sign = X##_s;					\
-								\
-    (val) = _flo.flt;						\
-  } while (0)
-
-
-/*
- * Multiplication algorithms:
- */
-
-/* Basic.  Assuming the host word size is >= 2*FRACBITS, we can do the
-   multiplication immediately.  */
-
-#define _FP_MUL_MEAT_1_imm(fs, R, X, Y)					\
-  do {									\
-    R##_f = X##_f * Y##_f;						\
-    /* Normalize since we know where the msb of the multiplicands	\
-       were (bit B), we know that the msb of the of the product is	\
-       at either 2B or 2B-1.  */					\
-    _FP_FRAC_SRS_1(R, _FP_WFRACBITS_##fs-1, 2*_FP_WFRACBITS_##fs);	\
-  } while (0)
-
-/* Given a 1W * 1W => 2W primitive, do the extended multiplication.  */
-
-#define _FP_MUL_MEAT_1_wide(fs, R, X, Y, doit)				\
-  do {									\
-    _FP_W_TYPE _Z_f0, _Z_f1;						\
-    doit(_Z_f1, _Z_f0, X##_f, Y##_f);					\
-    /* Normalize since we know where the msb of the multiplicands	\
-       were (bit B), we know that the msb of the of the product is	\
-       at either 2B or 2B-1.  */					\
-    _FP_FRAC_SRS_2(_Z, _FP_WFRACBITS_##fs-1, 2*_FP_WFRACBITS_##fs);	\
-    R##_f = _Z_f0;							\
-  } while (0)
-
-/* Finally, a simple widening multiply algorithm.  What fun!  */
-
-#define _FP_MUL_MEAT_1_hard(fs, R, X, Y)				\
-  do {									\
-    _FP_W_TYPE _xh, _xl, _yh, _yl, _z_f0, _z_f1, _a_f0, _a_f1;		\
-									\
-    /* split the words in half */					\
-    _xh = X##_f >> (_FP_W_TYPE_SIZE/2);					\
-    _xl = X##_f & (((_FP_W_TYPE)1 << (_FP_W_TYPE_SIZE/2)) - 1);		\
-    _yh = Y##_f >> (_FP_W_TYPE_SIZE/2);					\
-    _yl = Y##_f & (((_FP_W_TYPE)1 << (_FP_W_TYPE_SIZE/2)) - 1);		\
-									\
-    /* multiply the pieces */						\
-    _z_f0 = _xl * _yl;							\
-    _a_f0 = _xh * _yl;							\
-    _a_f1 = _xl * _yh;							\
-    _z_f1 = _xh * _yh;							\
-									\
-    /* reassemble into two full words */				\
-    if ((_a_f0 += _a_f1) < _a_f1)					\
-      _z_f1 += (_FP_W_TYPE)1 << (_FP_W_TYPE_SIZE/2);			\
-    _a_f1 = _a_f0 >> (_FP_W_TYPE_SIZE/2);				\
-    _a_f0 = _a_f0 << (_FP_W_TYPE_SIZE/2);				\
-    _FP_FRAC_ADD_2(_z, _z, _a);						\
-									\
-    /* normalize */							\
-    _FP_FRAC_SRS_2(_z, _FP_WFRACBITS_##fs - 1, 2*_FP_WFRACBITS_##fs);	\
-    R##_f = _z_f0;							\
-  } while (0)
-
-
-/*
- * Division algorithms:
- */
-
-/* Basic.  Assuming the host word size is >= 2*FRACBITS, we can do the
-   division immediately.  Give this macro either _FP_DIV_HELP_imm for
-   C primitives or _FP_DIV_HELP_ldiv for the ISO function.  Which you
-   choose will depend on what the compiler does with divrem4.  */
-
-#define _FP_DIV_MEAT_1_imm(fs, R, X, Y, doit)		\
-  do {							\
-    _FP_W_TYPE _q, _r;					\
-    X##_f <<= (X##_f < Y##_f				\
-	       ? R##_e--, _FP_WFRACBITS_##fs		\
-	       : _FP_WFRACBITS_##fs - 1);		\
-    doit(_q, _r, X##_f, Y##_f);				\
-    R##_f = _q | (_r != 0);				\
-  } while (0)
-
-/* GCC's longlong.h defines a 2W / 1W => (1W,1W) primitive udiv_qrnnd
-   that may be useful in this situation.  This first is for a primitive
-   that requires normalization, the second for one that does not.  Look
-   for UDIV_NEEDS_NORMALIZATION to tell which your machine needs.  */
-
-#define _FP_DIV_MEAT_1_udiv_norm(fs, R, X, Y)				\
-  do {									\
-    _FP_W_TYPE _nh, _nl, _q, _r;					\
-									\
-    /* Normalize Y -- i.e. make the most significant bit set.  */	\
-    Y##_f <<= _FP_WFRACXBITS_##fs - 1;					\
-									\
-    /* Shift X op correspondingly high, that is, up one full word.  */	\
-    if (X##_f <= Y##_f)							\
-      {									\
-	_nl = 0;							\
-	_nh = X##_f;							\
-      }									\
-    else								\
-      {									\
-	R##_e++;							\
-	_nl = X##_f << (_FP_W_TYPE_SIZE-1);				\
-	_nh = X##_f >> 1;						\
-      }									\
-    									\
-    udiv_qrnnd(_q, _r, _nh, _nl, Y##_f);				\
-    R##_f = _q | (_r != 0);						\
-  } while (0)
-
-#define _FP_DIV_MEAT_1_udiv(fs, R, X, Y)		\
-  do {							\
-    _FP_W_TYPE _nh, _nl, _q, _r;			\
-    if (X##_f < Y##_f)					\
-      {							\
-	R##_e--;					\
-	_nl = X##_f << _FP_WFRACBITS_##fs;		\
-	_nh = X##_f >> _FP_WFRACXBITS_##fs;		\
-      }							\
-    else						\
-      {							\
-	_nl = X##_f << (_FP_WFRACBITS_##fs - 1);	\
-	_nh = X##_f >> (_FP_WFRACXBITS_##fs + 1);	\
-      }							\
-    udiv_qrnnd(_q, _r, _nh, _nl, Y##_f);		\
-    R##_f = _q | (_r != 0);				\
-  } while (0)
-
-
-/*
- * Square root algorithms:
- * We have just one right now, maybe Newton approximation
- * should be added for those machines where division is fast.
- */
-
-#define _FP_SQRT_MEAT_1(R, S, T, X, q)			\
-  do {							\
-    while (q)						\
-      {							\
-        T##_f = S##_f + q;				\
-        if (T##_f <= X##_f)				\
-          {						\
-            S##_f = T##_f + q;				\
-            X##_f -= T##_f;				\
-            R##_f += q;					\
-          }						\
-        _FP_FRAC_SLL_1(X, 1);				\
-        q >>= 1;					\
-      }							\
-  } while (0)
-
-/*
- * Assembly/disassembly for converting to/from integral types.
- * No shifting or overflow handled here.
- */
-
-#define _FP_FRAC_ASSEMBLE_1(r, X, rsize)	(r = X##_f)
-#define _FP_FRAC_DISASSEMBLE_1(X, r, rsize)	(X##_f = r)
-
-
-/*
- * Convert FP values between word sizes
- */
-
-#define _FP_FRAC_CONV_1_1(dfs, sfs, D, S)				\
-  do {									\
-    D##_f = S##_f;							\
-    if (_FP_WFRACBITS_##sfs > _FP_WFRACBITS_##dfs)			\
-      _FP_FRAC_SRS_1(D, (_FP_WFRACBITS_##sfs-_FP_WFRACBITS_##dfs),	\
-		     _FP_WFRACBITS_##sfs);				\
-    else								\
-      D##_f <<= _FP_WFRACBITS_##dfs - _FP_WFRACBITS_##sfs;		\
-  } while (0)
diff --git a/arch/powerpc/math-emu/op-2.h b/arch/powerpc/math-emu/op-2.h
deleted file mode 100644
index 7d6f17c..0000000
--- a/arch/powerpc/math-emu/op-2.h
+++ /dev/null
@@ -1,434 +0,0 @@
-/*
- * Basic two-word fraction declaration and manipulation.
- */
-
-#define _FP_FRAC_DECL_2(X)	_FP_W_TYPE X##_f0, X##_f1
-#define _FP_FRAC_COPY_2(D,S)	(D##_f0 = S##_f0, D##_f1 = S##_f1)
-#define _FP_FRAC_SET_2(X,I)	__FP_FRAC_SET_2(X, I)
-#define _FP_FRAC_HIGH_2(X)	(X##_f1)
-#define _FP_FRAC_LOW_2(X)	(X##_f0)
-#define _FP_FRAC_WORD_2(X,w)	(X##_f##w)
-
-#define _FP_FRAC_SLL_2(X,N)						\
-  do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
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
-	X##_f0 = 0;							\
-      }									\
-  } while (0)
-
-#define _FP_FRAC_SRL_2(X,N)						\
-  do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
-	X##_f0 = X##_f0 >> (N) | X##_f1 << (_FP_W_TYPE_SIZE - (N));	\
-	X##_f1 >>= (N);							\
-      }									\
-    else								\
-      {									\
-	X##_f0 = X##_f1 >> ((N) - _FP_W_TYPE_SIZE);			\
-	X##_f1 = 0;							\
-      }									\
-  } while (0)
-
-/* Right shift with sticky-lsb.  */
-#define _FP_FRAC_SRS_2(X,N,sz)						\
-  do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
-	X##_f0 = (X##_f1 << (_FP_W_TYPE_SIZE - (N)) | X##_f0 >> (N) |	\
-		  (__builtin_constant_p(N) && (N) == 1			\
-		   ? X##_f0 & 1						\
-		   : (X##_f0 << (_FP_W_TYPE_SIZE - (N))) != 0));	\
-	X##_f1 >>= (N);							\
-      }									\
-    else								\
-      {									\
-	X##_f0 = (X##_f1 >> ((N) - _FP_W_TYPE_SIZE) |			\
-	          (((X##_f1 << (2 * _FP_W_TYPE_SIZE - (N))) |		\
-		   X##_f0) != 0));					\
-	X##_f1 = 0;							\
-      }									\
-  } while (0)
-
-#define _FP_FRAC_ADDI_2(X,I) \
-  __FP_FRAC_ADDI_2(X##_f1, X##_f0, I)
-
-#define _FP_FRAC_ADD_2(R,X,Y) \
-  __FP_FRAC_ADD_2(R##_f1, R##_f0, X##_f1, X##_f0, Y##_f1, Y##_f0)
-
-#define _FP_FRAC_SUB_2(R,X,Y) \
-  __FP_FRAC_SUB_2(R##_f1, R##_f0, X##_f1, X##_f0, Y##_f1, Y##_f0)
-
-#define _FP_FRAC_CLZ_2(R,X)	\
-  do {				\
-    if (X##_f1)			\
-      __FP_CLZ(R,X##_f1);	\
-    else 			\
-    {				\
-      __FP_CLZ(R,X##_f0);	\
-      R += _FP_W_TYPE_SIZE;	\
-    }				\
-  } while(0)
-
-/* Predicates */
-#define _FP_FRAC_NEGP_2(X)	((_FP_WS_TYPE)X##_f1 < 0)
-#define _FP_FRAC_ZEROP_2(X)	((X##_f1 | X##_f0) == 0)
-#define _FP_FRAC_OVERP_2(fs,X)	(X##_f1 & _FP_OVERFLOW_##fs)
-#define _FP_FRAC_EQ_2(X, Y)	(X##_f1 == Y##_f1 && X##_f0 == Y##_f0)
-#define _FP_FRAC_GT_2(X, Y)	\
-  ((X##_f1 > Y##_f1) || (X##_f1 == Y##_f1 && X##_f0 > Y##_f0))
-#define _FP_FRAC_GE_2(X, Y)	\
-  ((X##_f1 > Y##_f1) || (X##_f1 == Y##_f1 && X##_f0 >= Y##_f0))
-
-#define _FP_ZEROFRAC_2		0, 0
-#define _FP_MINFRAC_2		0, 1
-
-/*
- * Internals
- */
-
-#define __FP_FRAC_SET_2(X,I1,I0)	(X##_f0 = I0, X##_f1 = I1)
-
-#define __FP_CLZ_2(R, xh, xl)	\
-  do {				\
-    if (xh)			\
-      __FP_CLZ(R,xl);		\
-    else 			\
-    {				\
-      __FP_CLZ(R,xl);		\
-      R += _FP_W_TYPE_SIZE;	\
-    }				\
-  } while(0)
-
-#if 0
-
-#ifndef __FP_FRAC_ADDI_2
-#define __FP_FRAC_ADDI_2(xh, xl, i) \
-  (xh += ((xl += i) < i))
-#endif
-#ifndef __FP_FRAC_ADD_2
-#define __FP_FRAC_ADD_2(rh, rl, xh, xl, yh, yl) \
-  (rh = xh + yh + ((rl = xl + yl) < xl))
-#endif
-#ifndef __FP_FRAC_SUB_2
-#define __FP_FRAC_SUB_2(rh, rl, xh, xl, yh, yl) \
-  (rh = xh - yh - ((rl = xl - yl) > xl))
-#endif
-
-#else
-
-#undef __FP_FRAC_ADDI_2
-#define __FP_FRAC_ADDI_2(xh, xl, i)	add_ssaaaa(xh, xl, xh, xl, 0, i)
-#undef __FP_FRAC_ADD_2
-#define __FP_FRAC_ADD_2			add_ssaaaa
-#undef __FP_FRAC_SUB_2
-#define __FP_FRAC_SUB_2			sub_ddmmss
-
-#endif
-
-/*
- * Unpack the raw bits of a native fp value.  Do not classify or
- * normalize the data.
- */
-
-#define _FP_UNPACK_RAW_2(fs, X, val)			\
-  do {							\
-    union _FP_UNION_##fs _flo; _flo.flt = (val);	\
-							\
-    X##_f0 = _flo.bits.frac0;				\
-    X##_f1 = _flo.bits.frac1;				\
-    X##_e  = _flo.bits.exp;				\
-    X##_s  = _flo.bits.sign;				\
-  } while (0)
-
-
-/*
- * Repack the raw bits of a native fp value.
- */
-
-#define _FP_PACK_RAW_2(fs, val, X)			\
-  do {							\
-    union _FP_UNION_##fs _flo;				\
-							\
-    _flo.bits.frac0 = X##_f0;				\
-    _flo.bits.frac1 = X##_f1;				\
-    _flo.bits.exp   = X##_e;				\
-    _flo.bits.sign  = X##_s;				\
-							\
-    (val) = _flo.flt;					\
-  } while (0)
-
-
-/*
- * Multiplication algorithms:
- */
-
-/* Given a 1W * 1W => 2W primitive, do the extended multiplication.  */
-
-#define _FP_MUL_MEAT_2_wide(fs, R, X, Y, doit)				\
-  do {									\
-    _FP_FRAC_DECL_4(_z); _FP_FRAC_DECL_2(_b); _FP_FRAC_DECL_2(_c);	\
-									\
-    doit(_FP_FRAC_WORD_4(_z,1), _FP_FRAC_WORD_4(_z,0), X##_f0, Y##_f0); \
-    doit(_b_f1, _b_f0, X##_f0, Y##_f1);					\
-    doit(_c_f1, _c_f0, X##_f1, Y##_f0);					\
-    doit(_FP_FRAC_WORD_4(_z,3), _FP_FRAC_WORD_4(_z,2), X##_f1, Y##_f1); \
-									\
-    __FP_FRAC_ADD_4(_FP_FRAC_WORD_4(_z,3),_FP_FRAC_WORD_4(_z,2),	\
-		    _FP_FRAC_WORD_4(_z,1),_FP_FRAC_WORD_4(_z,0),	\
-		    0, _b_f1, _b_f0, 0,					\
-		    _FP_FRAC_WORD_4(_z,3),_FP_FRAC_WORD_4(_z,2),	\
-		    _FP_FRAC_WORD_4(_z,1),_FP_FRAC_WORD_4(_z,0));	\
-    __FP_FRAC_ADD_4(_FP_FRAC_WORD_4(_z,3),_FP_FRAC_WORD_4(_z,2),	\
-		    _FP_FRAC_WORD_4(_z,1),_FP_FRAC_WORD_4(_z,0),	\
-		    0, _c_f1, _c_f0, 0,					\
-		    _FP_FRAC_WORD_4(_z,3),_FP_FRAC_WORD_4(_z,2),	\
-		    _FP_FRAC_WORD_4(_z,1),_FP_FRAC_WORD_4(_z,0));	\
-									\
-    /* Normalize since we know where the msb of the multiplicands	\
-       were (bit B), we know that the msb of the of the product is	\
-       at either 2B or 2B-1.  */					\
-    _FP_FRAC_SRS_4(_z, _FP_WFRACBITS_##fs-1, 2*_FP_WFRACBITS_##fs);	\
-    R##_f0 = _FP_FRAC_WORD_4(_z,0);					\
-    R##_f1 = _FP_FRAC_WORD_4(_z,1);					\
-  } while (0)
-
-/* This next macro appears to be totally broken. Fortunately nowhere
- * seems to use it :-> The problem is that we define _z[4] but
- * then use it in _FP_FRAC_SRS_4, which will attempt to access
- * _z_f[n] which will cause an error. The fix probably involves
- * declaring it with _FP_FRAC_DECL_4, see previous macro. -- PMM 02/1998
- */
-#define _FP_MUL_MEAT_2_gmp(fs, R, X, Y)					\
-  do {									\
-    _FP_W_TYPE _x[2], _y[2], _z[4];					\
-    _x[0] = X##_f0; _x[1] = X##_f1;					\
-    _y[0] = Y##_f0; _y[1] = Y##_f1;					\
-									\
-    mpn_mul_n(_z, _x, _y, 2);						\
-									\
-    /* Normalize since we know where the msb of the multiplicands	\
-       were (bit B), we know that the msb of the of the product is	\
-       at either 2B or 2B-1.  */					\
-    _FP_FRAC_SRS_4(_z, _FP_WFRACBITS##_fs-1, 2*_FP_WFRACBITS_##fs);	\
-    R##_f0 = _z[0];							\
-    R##_f1 = _z[1];							\
-  } while (0)
-
-
-/*
- * Division algorithms:
- * This seems to be giving me difficulties -- PMM
- * Look, NetBSD seems to be able to comment algorithms. Can't you?
- * I've thrown printks at the problem.
- * This now appears to work, but I still don't really know why.
- * Also, I don't think the result is properly normalised...
- */
-
-#define _FP_DIV_MEAT_2_udiv_64(fs, R, X, Y)				\
-  do {									\
-    extern void _fp_udivmodti4(_FP_W_TYPE q[2], _FP_W_TYPE r[2],	\
-			       _FP_W_TYPE n1, _FP_W_TYPE n0,		\
-			       _FP_W_TYPE d1, _FP_W_TYPE d0);		\
-    _FP_W_TYPE _n_f3, _n_f2, _n_f1, _n_f0, _r_f1, _r_f0;		\
-    _FP_W_TYPE _q_f1, _q_f0, _m_f1, _m_f0;				\
-    _FP_W_TYPE _rmem[2], _qmem[2];					\
-    /* I think this check is to ensure that the result is normalised.   \
-     * Assuming X,Y normalised (ie in [1.0,2.0)) X/Y will be in         \
-     * [0.5,2.0). Furthermore, it will be less than 1.0 iff X < Y.      \
-     * In this case we tweak things. (this is based on comments in      \
-     * the NetBSD FPU emulation code. )                                 \
-     * We know X,Y are normalised because we ensure this as part of     \
-     * the unpacking process. -- PMM                                    \
-     */									\
-    if (_FP_FRAC_GT_2(X, Y))						\
-      {									\
-/*	R##_e++; */							\
-	_n_f3 = X##_f1 >> 1;						\
-	_n_f2 = X##_f1 << (_FP_W_TYPE_SIZE - 1) | X##_f0 >> 1;		\
-	_n_f1 = X##_f0 << (_FP_W_TYPE_SIZE - 1);			\
-	_n_f0 = 0;							\
-      }									\
-    else								\
-      {									\
-	R##_e--;							\
-	_n_f3 = X##_f1;							\
-	_n_f2 = X##_f0;							\
-	_n_f1 = _n_f0 = 0;						\
-      }									\
-									\
-    /* Normalize, i.e. make the most significant bit of the 		\
-       denominator set.  CHANGED: - 1 to nothing -- PMM */		\
-    _FP_FRAC_SLL_2(Y, _FP_WFRACXBITS_##fs /* -1 */);			\
-									\
-    /* Do the 256/128 bit division given the 128-bit _fp_udivmodtf4 	\
-       primitive snagged from libgcc2.c.  */				\
-									\
-    _fp_udivmodti4(_qmem, _rmem, _n_f3, _n_f2, 0, Y##_f1);		\
-    _q_f1 = _qmem[0];							\
-    umul_ppmm(_m_f1, _m_f0, _q_f1, Y##_f0);				\
-    _r_f1 = _rmem[0];							\
-    _r_f0 = _n_f1;							\
-    if (_FP_FRAC_GT_2(_m, _r))						\
-      {									\
-	_q_f1--;							\
-	_FP_FRAC_ADD_2(_r, _r, Y);					\
-	if (_FP_FRAC_GE_2(_r, Y) && _FP_FRAC_GT_2(_m, _r))		\
-	  {								\
-	    _q_f1--;							\
-	    _FP_FRAC_ADD_2(_r, _r, Y);					\
-	  }								\
-      }									\
-    _FP_FRAC_SUB_2(_r, _r, _m);						\
-									\
-    _fp_udivmodti4(_qmem, _rmem, _r_f1, _r_f0, 0, Y##_f1);		\
-    _q_f0 = _qmem[0];							\
-    umul_ppmm(_m_f1, _m_f0, _q_f0, Y##_f0);				\
-    _r_f1 = _rmem[0];							\
-    _r_f0 = _n_f0;							\
-    if (_FP_FRAC_GT_2(_m, _r))						\
-      {									\
-	_q_f0--;							\
-	_FP_FRAC_ADD_2(_r, _r, Y);					\
-	if (_FP_FRAC_GE_2(_r, Y) && _FP_FRAC_GT_2(_m, _r))		\
-	  {								\
-	    _q_f0--;							\
-	    _FP_FRAC_ADD_2(_r, _r, Y);					\
-	  }								\
-      }									\
-    _FP_FRAC_SUB_2(_r, _r, _m);						\
-									\
-    R##_f1 = _q_f1;							\
-    R##_f0 = _q_f0 | ((_r_f1 | _r_f0) != 0);				\
-    /* adjust so answer is normalized again. I'm not sure what the 	\
-     * final sz param should be. In practice it's never used since      \
-     * N is 1 which is always going to be < _FP_W_TYPE_SIZE...		\
-     */									\
-    /* _FP_FRAC_SRS_2(R,1,_FP_WFRACBITS_##fs);	*/			\
-  } while (0)
-
-
-#define _FP_DIV_MEAT_2_gmp(fs, R, X, Y)					\
-  do {									\
-    _FP_W_TYPE _x[4], _y[2], _z[4];					\
-    _y[0] = Y##_f0; _y[1] = Y##_f1;					\
-    _x[0] = _x[3] = 0;							\
-    if (_FP_FRAC_GT_2(X, Y))						\
-      {									\
-	R##_e++;							\
-	_x[1] = (X##_f0 << (_FP_WFRACBITS-1 - _FP_W_TYPE_SIZE) |	\
-		 X##_f1 >> (_FP_W_TYPE_SIZE -				\
-			    (_FP_WFRACBITS-1 - _FP_W_TYPE_SIZE)));	\
-	_x[2] = X##_f1 << (_FP_WFRACBITS-1 - _FP_W_TYPE_SIZE);		\
-      }									\
-    else								\
-      {									\
-	_x[1] = (X##_f0 << (_FP_WFRACBITS - _FP_W_TYPE_SIZE) |		\
-		 X##_f1 >> (_FP_W_TYPE_SIZE -				\
-			    (_FP_WFRACBITS - _FP_W_TYPE_SIZE)));	\
-	_x[2] = X##_f1 << (_FP_WFRACBITS - _FP_W_TYPE_SIZE);		\
-      }									\
-									\
-    (void) mpn_divrem (_z, 0, _x, 4, _y, 2);				\
-    R##_f1 = _z[1];							\
-    R##_f0 = _z[0] | ((_x[0] | _x[1]) != 0);				\
-  } while (0)
-
-
-/*
- * Square root algorithms:
- * We have just one right now, maybe Newton approximation
- * should be added for those machines where division is fast.
- */
-
-#define _FP_SQRT_MEAT_2(R, S, T, X, q)			\
-  do {							\
-    while (q)						\
-      {							\
-        T##_f1 = S##_f1 + q;				\
-        if (T##_f1 <= X##_f1)				\
-          {						\
-            S##_f1 = T##_f1 + q;			\
-            X##_f1 -= T##_f1;				\
-            R##_f1 += q;				\
-          }						\
-        _FP_FRAC_SLL_2(X, 1);				\
-        q >>= 1;					\
-      }							\
-    q = (_FP_W_TYPE)1 << (_FP_W_TYPE_SIZE - 1);		\
-    while (q)						\
-      {							\
-        T##_f0 = S##_f0 + q;				\
-        T##_f1 = S##_f1;				\
-        if (T##_f1 < X##_f1 || 				\
-            (T##_f1 == X##_f1 && T##_f0 < X##_f0))	\
-          {						\
-            S##_f0 = T##_f0 + q;			\
-            if (((_FP_WS_TYPE)T##_f0) < 0 &&		\
-                ((_FP_WS_TYPE)S##_f0) >= 0)		\
-              S##_f1++;					\
-            _FP_FRAC_SUB_2(X, X, T);			\
-            R##_f0 += q;				\
-          }						\
-        _FP_FRAC_SLL_2(X, 1);				\
-        q >>= 1;					\
-      }							\
-  } while (0)
-
-
-/*
- * Assembly/disassembly for converting to/from integral types.
- * No shifting or overflow handled here.
- */
-
-#define _FP_FRAC_ASSEMBLE_2(r, X, rsize)	\
-  do {						\
-    if (rsize <= _FP_W_TYPE_SIZE)		\
-      r = X##_f0;				\
-    else					\
-      {						\
-	r = X##_f1;				\
-	r <<= _FP_W_TYPE_SIZE;			\
-	r += X##_f0;				\
-      }						\
-  } while (0)
-
-#define _FP_FRAC_DISASSEMBLE_2(X, r, rsize)				\
-  do {									\
-    X##_f0 = r;								\
-    X##_f1 = (rsize <= _FP_W_TYPE_SIZE ? 0 : r >> _FP_W_TYPE_SIZE);	\
-  } while (0)
-
-/*
- * Convert FP values between word sizes
- */
-
-#define _FP_FRAC_CONV_1_2(dfs, sfs, D, S)				\
-  do {									\
-    _FP_FRAC_SRS_2(S, (_FP_WFRACBITS_##sfs - _FP_WFRACBITS_##dfs),	\
-		   _FP_WFRACBITS_##sfs);				\
-    D##_f = S##_f0;							\
-  } while (0)
-
-#define _FP_FRAC_CONV_2_1(dfs, sfs, D, S)				\
-  do {									\
-    D##_f0 = S##_f;							\
-    D##_f1 = 0;								\
-    _FP_FRAC_SLL_2(D, (_FP_WFRACBITS_##dfs - _FP_WFRACBITS_##sfs));	\
-  } while (0)
-
diff --git a/arch/powerpc/math-emu/op-4.h b/arch/powerpc/math-emu/op-4.h
deleted file mode 100644
index c9ae626..0000000
--- a/arch/powerpc/math-emu/op-4.h
+++ /dev/null
@@ -1,317 +0,0 @@
-/*
- * Basic four-word fraction declaration and manipulation.
- *
- * When adding quadword support for 32 bit machines, we need
- * to be a little careful as double multiply uses some of these
- * macros: (in op-2.h)
- * _FP_MUL_MEAT_2_wide() uses _FP_FRAC_DECL_4, _FP_FRAC_WORD_4,
- * _FP_FRAC_ADD_4, _FP_FRAC_SRS_4
- * _FP_MUL_MEAT_2_gmp() uses _FP_FRAC_SRS_4 (and should use
- * _FP_FRAC_DECL_4: it appears to be broken and is not used
- * anywhere anyway. )
- *
- * I've now fixed all the macros that were here from the sparc64 code.
- * [*none* of the shift macros were correct!] -- PMM 02/1998
- *
- * The only quadword stuff that remains to be coded is:
- * 1) the conversion to/from ints, which requires
- * that we check (in op-common.h) that the following do the right thing
- * for quadwords: _FP_TO_INT(Q,4,r,X,rsz,rsg), _FP_FROM_INT(Q,4,X,r,rs,rt)
- * 2) multiply, divide and sqrt, which require:
- * _FP_MUL_MEAT_4_*(R,X,Y), _FP_DIV_MEAT_4_*(R,X,Y), _FP_SQRT_MEAT_4(R,S,T,X,q),
- * This also needs _FP_MUL_MEAT_Q and _FP_DIV_MEAT_Q to be defined to
- * some suitable _FP_MUL_MEAT_4_* macros in sfp-machine.h.
- * [we're free to choose whatever FP_MUL_MEAT_4_* macros we need for
- * these; they are used nowhere else. ]
- */
-
-#define _FP_FRAC_DECL_4(X)	_FP_W_TYPE X##_f[4]
-#define _FP_FRAC_COPY_4(D,S)			\
-  (D##_f[0] = S##_f[0], D##_f[1] = S##_f[1],	\
-   D##_f[2] = S##_f[2], D##_f[3] = S##_f[3])
-/* The _FP_FRAC_SET_n(X,I) macro is intended for use with another
- * macro such as _FP_ZEROFRAC_n which returns n comma separated values.
- * The result is that we get an expansion of __FP_FRAC_SET_n(X,I0,I1,I2,I3)
- * which just assigns the In values to the array X##_f[].
- * This is why the number of parameters doesn't appear to match
- * at first glance...      -- PMM
- */
-#define _FP_FRAC_SET_4(X,I)	__FP_FRAC_SET_4(X, I)
-#define _FP_FRAC_HIGH_4(X)	(X##_f[3])
-#define _FP_FRAC_LOW_4(X)	(X##_f[0])
-#define _FP_FRAC_WORD_4(X,w)	(X##_f[w])
-
-#define _FP_FRAC_SLL_4(X,N)						\
-  do {									\
-    _FP_I_TYPE _up, _down, _skip, _i;					\
-    _skip = (N) / _FP_W_TYPE_SIZE;					\
-    _up = (N) % _FP_W_TYPE_SIZE;					\
-    _down = _FP_W_TYPE_SIZE - _up;					\
-    for (_i = 3; _i > _skip; --_i)					\
-      X##_f[_i] = X##_f[_i-_skip] << _up | X##_f[_i-_skip-1] >> _down;	\
-/* bugfixed: was X##_f[_i] <<= _up;  -- PMM 02/1998 */                  \
-    X##_f[_i] = X##_f[0] << _up; 	                                \
-    for (--_i; _i >= 0; --_i)						\
-      X##_f[_i] = 0;							\
-  } while (0)
-
-/* This one was broken too */
-#define _FP_FRAC_SRL_4(X,N)						\
-  do {									\
-    _FP_I_TYPE _up, _down, _skip, _i;					\
-    _skip = (N) / _FP_W_TYPE_SIZE;					\
-    _down = (N) % _FP_W_TYPE_SIZE;					\
-    _up = _FP_W_TYPE_SIZE - _down;					\
-    for (_i = 0; _i < 3-_skip; ++_i)					\
-      X##_f[_i] = X##_f[_i+_skip] >> _down | X##_f[_i+_skip+1] << _up;	\
-    X##_f[_i] = X##_f[3] >> _down;			         	\
-    for (++_i; _i < 4; ++_i)						\
-      X##_f[_i] = 0;							\
-  } while (0)
-
-
-/* Right shift with sticky-lsb.
- * What this actually means is that we do a standard right-shift,
- * but that if any of the bits that fall off the right hand side
- * were one then we always set the LSbit.
- */
-#define _FP_FRAC_SRS_4(X,N,size)					\
-  do {									\
-    _FP_I_TYPE _up, _down, _skip, _i;					\
-    _FP_W_TYPE _s;							\
-    _skip = (N) / _FP_W_TYPE_SIZE;					\
-    _down = (N) % _FP_W_TYPE_SIZE;					\
-    _up = _FP_W_TYPE_SIZE - _down;					\
-    for (_s = _i = 0; _i < _skip; ++_i)					\
-      _s |= X##_f[_i];							\
-    _s |= X##_f[_i] << _up;						\
-/* s is now != 0 if we want to set the LSbit */                         \
-    for (_i = 0; _i < 3-_skip; ++_i)					\
-      X##_f[_i] = X##_f[_i+_skip] >> _down | X##_f[_i+_skip+1] << _up;	\
-    X##_f[_i] = X##_f[3] >> _down;					\
-    for (++_i; _i < 4; ++_i)						\
-      X##_f[_i] = 0;							\
-    /* don't fix the LSB until the very end when we're sure f[0] is stable */ \
-    X##_f[0] |= (_s != 0);                                              \
-  } while (0)
-
-#define _FP_FRAC_ADD_4(R,X,Y)						\
-  __FP_FRAC_ADD_4(R##_f[3], R##_f[2], R##_f[1], R##_f[0],		\
-		  X##_f[3], X##_f[2], X##_f[1], X##_f[0],		\
-		  Y##_f[3], Y##_f[2], Y##_f[1], Y##_f[0])
-
-#define _FP_FRAC_SUB_4(R,X,Y)                                           \
-  __FP_FRAC_SUB_4(R##_f[3], R##_f[2], R##_f[1], R##_f[0],		\
-		  X##_f[3], X##_f[2], X##_f[1], X##_f[0],		\
-		  Y##_f[3], Y##_f[2], Y##_f[1], Y##_f[0])
-
-#define _FP_FRAC_ADDI_4(X,I)                                            \
-  __FP_FRAC_ADDI_4(X##_f[3], X##_f[2], X##_f[1], X##_f[0], I)
-
-#define _FP_ZEROFRAC_4  0,0,0,0
-#define _FP_MINFRAC_4   0,0,0,1
-
-#define _FP_FRAC_ZEROP_4(X)     ((X##_f[0] | X##_f[1] | X##_f[2] | X##_f[3]) == 0)
-#define _FP_FRAC_NEGP_4(X)      ((_FP_WS_TYPE)X##_f[3] < 0)
-#define _FP_FRAC_OVERP_4(fs,X)  (X##_f[0] & _FP_OVERFLOW_##fs)
-
-#define _FP_FRAC_EQ_4(X,Y)                              \
- (X##_f[0] == Y##_f[0] && X##_f[1] == Y##_f[1]          \
-  && X##_f[2] == Y##_f[2] && X##_f[3] == Y##_f[3])
-
-#define _FP_FRAC_GT_4(X,Y)                              \
- (X##_f[3] > Y##_f[3] ||                                \
-  (X##_f[3] == Y##_f[3] && (X##_f[2] > Y##_f[2] ||      \
-   (X##_f[2] == Y##_f[2] && (X##_f[1] > Y##_f[1] ||     \
-    (X##_f[1] == Y##_f[1] && X##_f[0] > Y##_f[0])       \
-   ))                                                   \
-  ))                                                    \
- )
-
-#define _FP_FRAC_GE_4(X,Y)                              \
- (X##_f[3] > Y##_f[3] ||                                \
-  (X##_f[3] == Y##_f[3] && (X##_f[2] > Y##_f[2] ||      \
-   (X##_f[2] == Y##_f[2] && (X##_f[1] > Y##_f[1] ||     \
-    (X##_f[1] == Y##_f[1] && X##_f[0] >= Y##_f[0])      \
-   ))                                                   \
-  ))                                                    \
- )
-
-
-#define _FP_FRAC_CLZ_4(R,X)             \
-  do {                                  \
-    if (X##_f[3])                       \
-    {                                   \
-        __FP_CLZ(R,X##_f[3]);           \
-    }                                   \
-    else if (X##_f[2])                  \
-    {                                   \
-        __FP_CLZ(R,X##_f[2]);           \
-        R += _FP_W_TYPE_SIZE;           \
-    }                                   \
-    else if (X##_f[1])                  \
-    {                                   \
-        __FP_CLZ(R,X##_f[2]);           \
-        R += _FP_W_TYPE_SIZE*2;         \
-    }                                   \
-    else                                \
-    {                                   \
-        __FP_CLZ(R,X##_f[0]);           \
-        R += _FP_W_TYPE_SIZE*3;         \
-    }                                   \
-  } while(0)
-
-
-#define _FP_UNPACK_RAW_4(fs, X, val)                            \
-  do {                                                          \
-    union _FP_UNION_##fs _flo; _flo.flt = (val);        	\
-    X##_f[0] = _flo.bits.frac0;                                 \
-    X##_f[1] = _flo.bits.frac1;                                 \
-    X##_f[2] = _flo.bits.frac2;                                 \
-    X##_f[3] = _flo.bits.frac3;                                 \
-    X##_e  = _flo.bits.exp;                                     \
-    X##_s  = _flo.bits.sign;                                    \
-  } while (0)
-
-#define _FP_PACK_RAW_4(fs, val, X)                              \
-  do {                                                          \
-    union _FP_UNION_##fs _flo;					\
-    _flo.bits.frac0 = X##_f[0];                                 \
-    _flo.bits.frac1 = X##_f[1];                                 \
-    _flo.bits.frac2 = X##_f[2];                                 \
-    _flo.bits.frac3 = X##_f[3];                                 \
-    _flo.bits.exp   = X##_e;                                    \
-    _flo.bits.sign  = X##_s;                                    \
-    (val) = _flo.flt;                                   	\
-  } while (0)
-
-
-/*
- * Internals
- */
-
-#define __FP_FRAC_SET_4(X,I3,I2,I1,I0)					\
-  (X##_f[3] = I3, X##_f[2] = I2, X##_f[1] = I1, X##_f[0] = I0)
-
-#ifndef __FP_FRAC_ADD_4
-#define __FP_FRAC_ADD_4(r3,r2,r1,r0,x3,x2,x1,x0,y3,y2,y1,y0)	\
-  do {								\
-    int _c1, _c2, _c3;						\
-    r0 = x0 + y0;						\
-    _c1 = r0 < x0;						\
-    r1 = x1 + y1;						\
-    _c2 = r1 < x1;						\
-    r1 += _c1;							\
-    _c2 |= r1 < _c1;						\
-    r2 = x2 + y2;						\
-    _c3 = r2 < x2;						\
-    r2 += _c2;							\
-    _c3 |= r2 < _c2;						\
-    r3 = x3 + y3 + _c3;						\
-  } while (0)
-#endif
-
-#ifndef __FP_FRAC_SUB_4
-#define __FP_FRAC_SUB_4(r3,r2,r1,r0,x3,x2,x1,x0,y3,y2,y1,y0)	\
-  do {								\
-    int _c1, _c2, _c3;						\
-    r0 = x0 - y0;						\
-    _c1 = r0 > x0;						\
-    r1 = x1 - y1;						\
-    _c2 = r1 > x1;						\
-    r1 -= _c1;							\
-    _c2 |= r1 > _c1;						\
-    r2 = x2 - y2;						\
-    _c3 = r2 > x2;						\
-    r2 -= _c2;							\
-    _c3 |= r2 > _c2;						\
-    r3 = x3 - y3 - _c3;						\
-  } while (0)
-#endif
-
-#ifndef __FP_FRAC_ADDI_4
-/* I always wanted to be a lisp programmer :-> */
-#define __FP_FRAC_ADDI_4(x3,x2,x1,x0,i)                                 \
-  (x3 += ((x2 += ((x1 += ((x0 += i) < x0)) < x1) < x2)))
-#endif
-
-/* Convert FP values between word sizes. This appears to be more
- * complicated than I'd have expected it to be, so these might be
- * wrong... These macros are in any case somewhat bogus because they
- * use information about what various FRAC_n variables look like
- * internally [eg, that 2 word vars are X_f0 and x_f1]. But so do
- * the ones in op-2.h and op-1.h.
- */
-#define _FP_FRAC_CONV_1_4(dfs, sfs, D, S)                               \
-   do {                                                                 \
-     _FP_FRAC_SRS_4(S, (_FP_WFRACBITS_##sfs - _FP_WFRACBITS_##dfs),     \
-                        _FP_WFRACBITS_##sfs);                           \
-     D##_f = S##_f[0];                                                   \
-  } while (0)
-
-#define _FP_FRAC_CONV_2_4(dfs, sfs, D, S)                               \
-   do {                                                                 \
-     _FP_FRAC_SRS_4(S, (_FP_WFRACBITS_##sfs - _FP_WFRACBITS_##dfs),     \
-                        _FP_WFRACBITS_##sfs);                           \
-     D##_f0 = S##_f[0];                                                  \
-     D##_f1 = S##_f[1];                                                  \
-  } while (0)
-
-/* Assembly/disassembly for converting to/from integral types.
- * No shifting or overflow handled here.
- */
-/* Put the FP value X into r, which is an integer of size rsize. */
-#define _FP_FRAC_ASSEMBLE_4(r, X, rsize)                                \
-  do {                                                                  \
-    if (rsize <= _FP_W_TYPE_SIZE)                                       \
-      r = X##_f[0];                                                     \
-    else if (rsize <= 2*_FP_W_TYPE_SIZE)                                \
-    {                                                                   \
-      r = X##_f[1];                                                     \
-      r <<= _FP_W_TYPE_SIZE;                                            \
-      r += X##_f[0];                                                    \
-    }                                                                   \
-    else                                                                \
-    {                                                                   \
-      /* I'm feeling lazy so we deal with int == 3words (implausible)*/ \
-      /* and int == 4words as a single case.                         */ \
-      r = X##_f[3];                                                     \
-      r <<= _FP_W_TYPE_SIZE;                                            \
-      r += X##_f[2];                                                    \
-      r <<= _FP_W_TYPE_SIZE;                                            \
-      r += X##_f[1];                                                    \
-      r <<= _FP_W_TYPE_SIZE;                                            \
-      r += X##_f[0];                                                    \
-    }                                                                   \
-  } while (0)
-
-/* "No disassemble Number Five!" */
-/* move an integer of size rsize into X's fractional part. We rely on
- * the _f[] array consisting of words of size _FP_W_TYPE_SIZE to avoid
- * having to mask the values we store into it.
- */
-#define _FP_FRAC_DISASSEMBLE_4(X, r, rsize)                             \
-  do {                                                                  \
-    X##_f[0] = r;                                                       \
-    X##_f[1] = (rsize <= _FP_W_TYPE_SIZE ? 0 : r >> _FP_W_TYPE_SIZE);   \
-    X##_f[2] = (rsize <= 2*_FP_W_TYPE_SIZE ? 0 : r >> 2*_FP_W_TYPE_SIZE); \
-    X##_f[3] = (rsize <= 3*_FP_W_TYPE_SIZE ? 0 : r >> 3*_FP_W_TYPE_SIZE); \
-  } while (0)
-
-#define _FP_FRAC_CONV_4_1(dfs, sfs, D, S)                               \
-   do {                                                                 \
-     D##_f[0] = S##_f;                                                  \
-     D##_f[1] = D##_f[2] = D##_f[3] = 0;                                \
-     _FP_FRAC_SLL_4(D, (_FP_WFRACBITS_##dfs - _FP_WFRACBITS_##sfs));    \
-   } while (0)
-
-#define _FP_FRAC_CONV_4_2(dfs, sfs, D, S)                               \
-   do {                                                                 \
-     D##_f[0] = S##_f0;                                                 \
-     D##_f[1] = S##_f1;                                                 \
-     D##_f[2] = D##_f[3] = 0;                                           \
-     _FP_FRAC_SLL_4(D, (_FP_WFRACBITS_##dfs - _FP_WFRACBITS_##sfs));    \
-   } while (0)
-
-/* FIXME! This has to be written */
-#define _FP_SQRT_MEAT_4(R, S, T, X, q)
diff --git a/arch/powerpc/math-emu/op-common.h b/arch/powerpc/math-emu/op-common.h
deleted file mode 100644
index afb82b6..0000000
--- a/arch/powerpc/math-emu/op-common.h
+++ /dev/null
@@ -1,688 +0,0 @@
-#define _FP_DECL(wc, X)			\
-  _FP_I_TYPE X##_c, X##_s, X##_e;	\
-  _FP_FRAC_DECL_##wc(X)
-
-/*
- * Finish truely unpacking a native fp value by classifying the kind
- * of fp value and normalizing both the exponent and the fraction.
- */
-
-#define _FP_UNPACK_CANONICAL(fs, wc, X)					\
-do {									\
-  switch (X##_e)							\
-  {									\
-  default:								\
-    _FP_FRAC_HIGH_##wc(X) |= _FP_IMPLBIT_##fs;				\
-    _FP_FRAC_SLL_##wc(X, _FP_WORKBITS);					\
-    X##_e -= _FP_EXPBIAS_##fs;						\
-    X##_c = FP_CLS_NORMAL;						\
-    break;								\
-									\
-  case 0:								\
-    if (_FP_FRAC_ZEROP_##wc(X))						\
-      X##_c = FP_CLS_ZERO;						\
-    else								\
-      {									\
-	/* a denormalized number */					\
-	_FP_I_TYPE _shift;						\
-	_FP_FRAC_CLZ_##wc(_shift, X);					\
-	_shift -= _FP_FRACXBITS_##fs;					\
-	_FP_FRAC_SLL_##wc(X, (_shift+_FP_WORKBITS));			\
-	X##_e -= _FP_EXPBIAS_##fs - 1 + _shift;				\
-	X##_c = FP_CLS_NORMAL;						\
-      }									\
-    break;								\
-									\
-  case _FP_EXPMAX_##fs:							\
-    if (_FP_FRAC_ZEROP_##wc(X))						\
-      X##_c = FP_CLS_INF;						\
-    else								\
-      /* we don't differentiate between signaling and quiet nans */	\
-      X##_c = FP_CLS_NAN;						\
-    break;								\
-  }									\
-} while (0)
-
-
-/*
- * Before packing the bits back into the native fp result, take care
- * of such mundane things as rounding and overflow.  Also, for some
- * kinds of fp values, the original parts may not have been fully
- * extracted -- but that is ok, we can regenerate them now.
- */
-
-#define _FP_PACK_CANONICAL(fs, wc, X)				\
-({int __ret = 0;						\
-  switch (X##_c)						\
-  {								\
-  case FP_CLS_NORMAL:						\
-    X##_e += _FP_EXPBIAS_##fs;					\
-    if (X##_e > 0)						\
-      {								\
-	__ret |= _FP_ROUND(wc, X);				\
-	if (_FP_FRAC_OVERP_##wc(fs, X))				\
-	  {							\
-	    _FP_FRAC_SRL_##wc(X, (_FP_WORKBITS+1));		\
-	    X##_e++;						\
-	  }							\
-	else							\
-	  _FP_FRAC_SRL_##wc(X, _FP_WORKBITS);			\
-	if (X##_e >= _FP_EXPMAX_##fs)				\
-	  {							\
-	    /* overflow to infinity */				\
-	    X##_e = _FP_EXPMAX_##fs;				\
-	    _FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);		\
-            __ret |= EFLAG_OVERFLOW;				\
-	  }							\
-      }								\
-    else							\
-      {								\
-	/* we've got a denormalized number */			\
-	X##_e = -X##_e + 1;					\
-	if (X##_e <= _FP_WFRACBITS_##fs)			\
-	  {							\
-	    _FP_FRAC_SRS_##wc(X, X##_e, _FP_WFRACBITS_##fs);	\
-	    _FP_FRAC_SLL_##wc(X, 1);				\
-	    if (_FP_FRAC_OVERP_##wc(fs, X))			\
-	      {							\
-	        X##_e = 1;					\
-	        _FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);	\
-	      }							\
-	    else						\
-	      {							\
-		X##_e = 0;					\
-		_FP_FRAC_SRL_##wc(X, _FP_WORKBITS+1);		\
-                __ret |= EFLAG_UNDERFLOW;			\
-	      }							\
-	  }							\
-	else							\
-	  {							\
-	    /* underflow to zero */				\
-	    X##_e = 0;						\
-	    _FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);		\
-            __ret |= EFLAG_UNDERFLOW;				\
-	  }							\
-      }								\
-    break;							\
-								\
-  case FP_CLS_ZERO:						\
-    X##_e = 0;							\
-    _FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);			\
-    break;							\
-								\
-  case FP_CLS_INF:						\
-    X##_e = _FP_EXPMAX_##fs;					\
-    _FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);			\
-    break;							\
-								\
-  case FP_CLS_NAN:						\
-    X##_e = _FP_EXPMAX_##fs;					\
-    if (!_FP_KEEPNANFRACP)					\
-      {								\
-	_FP_FRAC_SET_##wc(X, _FP_NANFRAC_##fs);			\
-	X##_s = 0;						\
-      }								\
-    else							\
-      _FP_FRAC_HIGH_##wc(X) |= _FP_QNANBIT_##fs;		\
-    break;							\
-  }								\
-  __ret;							\
-})
-
-
-/*
- * Main addition routine.  The input values should be cooked.
- */
-
-#define _FP_ADD(fs, wc, R, X, Y)					     \
-do {									     \
-  switch (_FP_CLS_COMBINE(X##_c, Y##_c))				     \
-  {									     \
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_NORMAL):			     \
-    {									     \
-      /* shift the smaller number so that its exponent matches the larger */ \
-      _FP_I_TYPE diff = X##_e - Y##_e;					     \
-									     \
-      if (diff < 0)							     \
-	{								     \
-	  diff = -diff;							     \
-	  if (diff <= _FP_WFRACBITS_##fs)				     \
-	    _FP_FRAC_SRS_##wc(X, diff, _FP_WFRACBITS_##fs);		     \
-	  else if (!_FP_FRAC_ZEROP_##wc(X))				     \
-	    _FP_FRAC_SET_##wc(X, _FP_MINFRAC_##wc);			     \
-	  else								     \
-	    _FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);			     \
-	  R##_e = Y##_e;						     \
-	}								     \
-      else								     \
-	{								     \
-	  if (diff > 0)							     \
-	    {								     \
-	      if (diff <= _FP_WFRACBITS_##fs)				     \
-	        _FP_FRAC_SRS_##wc(Y, diff, _FP_WFRACBITS_##fs);		     \
-	      else if (!_FP_FRAC_ZEROP_##wc(Y))				     \
-	        _FP_FRAC_SET_##wc(Y, _FP_MINFRAC_##wc);			     \
-	      else							     \
-	        _FP_FRAC_SET_##wc(Y, _FP_ZEROFRAC_##wc);		     \
-	    }								     \
-	  R##_e = X##_e;						     \
-	}								     \
-									     \
-      R##_c = FP_CLS_NORMAL;						     \
-									     \
-      if (X##_s == Y##_s)						     \
-	{								     \
-	  R##_s = X##_s;						     \
-	  _FP_FRAC_ADD_##wc(R, X, Y);					     \
-	  if (_FP_FRAC_OVERP_##wc(fs, R))				     \
-	    {								     \
-	      _FP_FRAC_SRS_##wc(R, 1, _FP_WFRACBITS_##fs);		     \
-	      R##_e++;							     \
-	    }								     \
-	}								     \
-      else								     \
-	{								     \
-	  R##_s = X##_s;						     \
-	  _FP_FRAC_SUB_##wc(R, X, Y);					     \
-	  if (_FP_FRAC_ZEROP_##wc(R))					     \
-	    {								     \
-	      /* return an exact zero */				     \
-	      if (FP_ROUNDMODE == FP_RND_MINF)				     \
-		R##_s |= Y##_s;						     \
-	      else							     \
-		R##_s &= Y##_s;						     \
-	      R##_c = FP_CLS_ZERO;					     \
-	    }								     \
-	  else								     \
-	    {								     \
-	      if (_FP_FRAC_NEGP_##wc(R))				     \
-		{							     \
-		  _FP_FRAC_SUB_##wc(R, Y, X);				     \
-		  R##_s = Y##_s;					     \
-		}							     \
-									     \
-	      /* renormalize after subtraction */			     \
-	      _FP_FRAC_CLZ_##wc(diff, R);				     \
-	      diff -= _FP_WFRACXBITS_##fs;				     \
-	      if (diff)							     \
-		{							     \
-		  R##_e -= diff;					     \
-		  _FP_FRAC_SLL_##wc(R, diff);				     \
-		}							     \
-	    }								     \
-	}								     \
-      break;								     \
-    }									     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_NAN):				     \
-    _FP_CHOOSENAN(fs, wc, R, X, Y);					     \
-    break;								     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_ZERO):			     \
-    R##_e = X##_e;							     \
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_NORMAL):			     \
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_INF):				     \
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_ZERO):				     \
-    _FP_FRAC_COPY_##wc(R, X);						     \
-    R##_s = X##_s;							     \
-    R##_c = X##_c;							     \
-    break;								     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_NORMAL):			     \
-    R##_e = Y##_e;							     \
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_NAN):			     \
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_NAN):				     \
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_NAN):				     \
-    _FP_FRAC_COPY_##wc(R, Y);						     \
-    R##_s = Y##_s;							     \
-    R##_c = Y##_c;							     \
-    break;								     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_INF):				     \
-    if (X##_s != Y##_s)							     \
-      {									     \
-	/* +INF + -INF => NAN */					     \
-	_FP_FRAC_SET_##wc(R, _FP_NANFRAC_##fs);				     \
-	R##_s = X##_s ^ Y##_s;						     \
-	R##_c = FP_CLS_NAN;						     \
-	break;								     \
-      }									     \
-    /* FALLTHRU */							     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_NORMAL):			     \
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_ZERO):				     \
-    R##_s = X##_s;							     \
-    R##_c = FP_CLS_INF;							     \
-    break;								     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_INF):			     \
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_INF):				     \
-    R##_s = Y##_s;							     \
-    R##_c = FP_CLS_INF;							     \
-    break;								     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_ZERO):			     \
-    /* make sure the sign is correct */					     \
-    if (FP_ROUNDMODE == FP_RND_MINF)					     \
-      R##_s = X##_s | Y##_s;						     \
-    else								     \
-      R##_s = X##_s & Y##_s;						     \
-    R##_c = FP_CLS_ZERO;						     \
-    break;								     \
-									     \
-  default:								     \
-    abort();								     \
-  }									     \
-} while (0)
-
-
-/*
- * Main negation routine.  FIXME -- when we care about setting exception
- * bits reliably, this will not do.  We should examine all of the fp classes.
- */
-
-#define _FP_NEG(fs, wc, R, X)		\
-  do {					\
-    _FP_FRAC_COPY_##wc(R, X);		\
-    R##_c = X##_c;			\
-    R##_e = X##_e;			\
-    R##_s = 1 ^ X##_s;			\
-  } while (0)
-
-
-/*
- * Main multiplication routine.  The input values should be cooked.
- */
-
-#define _FP_MUL(fs, wc, R, X, Y)			\
-do {							\
-  R##_s = X##_s ^ Y##_s;				\
-  switch (_FP_CLS_COMBINE(X##_c, Y##_c))		\
-  {							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_NORMAL):	\
-    R##_c = FP_CLS_NORMAL;				\
-    R##_e = X##_e + Y##_e + 1;				\
-							\
-    _FP_MUL_MEAT_##fs(R,X,Y);				\
-							\
-    if (_FP_FRAC_OVERP_##wc(fs, R))			\
-      _FP_FRAC_SRS_##wc(R, 1, _FP_WFRACBITS_##fs);	\
-    else						\
-      R##_e--;						\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_NAN):		\
-    _FP_CHOOSENAN(fs, wc, R, X, Y);			\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_NORMAL):	\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_INF):		\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_ZERO):		\
-    R##_s = X##_s;					\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_INF):		\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_NORMAL):	\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_NORMAL):	\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_ZERO):	\
-    _FP_FRAC_COPY_##wc(R, X);				\
-    R##_c = X##_c;					\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_NAN):	\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_NAN):		\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_NAN):		\
-    R##_s = Y##_s;					\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_INF):	\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_ZERO):	\
-    _FP_FRAC_COPY_##wc(R, Y);				\
-    R##_c = Y##_c;					\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_ZERO):		\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_INF):		\
-    R##_c = FP_CLS_NAN;					\
-    _FP_FRAC_SET_##wc(R, _FP_NANFRAC_##fs);		\
-    break;						\
-							\
-  default:						\
-    abort();						\
-  }							\
-} while (0)
-
-
-/*
- * Main division routine.  The input values should be cooked.
- */
-
-#define _FP_DIV(fs, wc, R, X, Y)			\
-do {							\
-  R##_s = X##_s ^ Y##_s;				\
-  switch (_FP_CLS_COMBINE(X##_c, Y##_c))		\
-  {							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_NORMAL):	\
-    R##_c = FP_CLS_NORMAL;				\
-    R##_e = X##_e - Y##_e;				\
-							\
-    _FP_DIV_MEAT_##fs(R,X,Y);				\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_NAN):		\
-    _FP_CHOOSENAN(fs, wc, R, X, Y);			\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_NORMAL):	\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_INF):		\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_ZERO):		\
-    R##_s = X##_s;					\
-    _FP_FRAC_COPY_##wc(R, X);				\
-    R##_c = X##_c;					\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_NAN):	\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_NAN):		\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_NAN):		\
-    R##_s = Y##_s;					\
-    _FP_FRAC_COPY_##wc(R, Y);				\
-    R##_c = Y##_c;					\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_INF):	\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_INF):		\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_NORMAL):	\
-    R##_c = FP_CLS_ZERO;				\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_ZERO):	\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_ZERO):		\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_NORMAL):	\
-    R##_c = FP_CLS_INF;					\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_INF):		\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_ZERO):	\
-    R##_c = FP_CLS_NAN;					\
-    _FP_FRAC_SET_##wc(R, _FP_NANFRAC_##fs);		\
-    break;						\
-							\
-  default:						\
-    abort();						\
-  }							\
-} while (0)
-
-
-/*
- * Main differential comparison routine.  The inputs should be raw not
- * cooked.  The return is -1,0,1 for normal values, 2 otherwise.
- */
-
-#define _FP_CMP(fs, wc, ret, X, Y, un)					\
-  do {									\
-    /* NANs are unordered */						\
-    if ((X##_e == _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc(X))		\
-	|| (Y##_e == _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc(Y)))	\
-      {									\
-	ret = un;							\
-      }									\
-    else								\
-      {									\
-        int __x_zero = (!X##_e && _FP_FRAC_ZEROP_##wc(X)) ? 1 : 0;	\
-        int __y_zero = (!Y##_e && _FP_FRAC_ZEROP_##wc(Y)) ? 1 : 0;	\
-									\
-	if (__x_zero && __y_zero)					\
-	  ret = 0;							\
-	else if (__x_zero)						\
-	  ret = Y##_s ? 1 : -1;						\
-	else if (__y_zero)						\
-	  ret = X##_s ? -1 : 1;						\
-	else if (X##_s != Y##_s)					\
-	  ret = X##_s ? -1 : 1;						\
-	else if (X##_e > Y##_e)						\
-	  ret = X##_s ? -1 : 1;						\
-	else if (X##_e < Y##_e)						\
-	  ret = X##_s ? 1 : -1;						\
-	else if (_FP_FRAC_GT_##wc(X, Y))				\
-	  ret = X##_s ? -1 : 1;						\
-	else if (_FP_FRAC_GT_##wc(Y, X))				\
-	  ret = X##_s ? 1 : -1;						\
-	else								\
-	  ret = 0;							\
-      }									\
-  } while (0)
-
-
-/* Simplification for strict equality.  */
-
-#define _FP_CMP_EQ(fs, wc, ret, X, Y)					  \
-  do {									  \
-    /* NANs are unordered */						  \
-    if ((X##_e == _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc(X))		  \
-	|| (Y##_e == _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc(Y)))	  \
-      {									  \
-	ret = 1;							  \
-      }									  \
-    else								  \
-      {									  \
-	ret = !(X##_e == Y##_e						  \
-		&& _FP_FRAC_EQ_##wc(X, Y)				  \
-		&& (X##_s == Y##_s || !X##_e && _FP_FRAC_ZEROP_##wc(X))); \
-      }									  \
-  } while (0)
-
-/*
- * Main square root routine.  The input value should be cooked.
- */
-
-#define _FP_SQRT(fs, wc, R, X)						\
-do {									\
-    _FP_FRAC_DECL_##wc(T); _FP_FRAC_DECL_##wc(S);			\
-    _FP_W_TYPE q;							\
-    switch (X##_c)							\
-    {									\
-    case FP_CLS_NAN:							\
-    	R##_s = 0;							\
-    	R##_c = FP_CLS_NAN;						\
-    	_FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);			\
-    	break;								\
-    case FP_CLS_INF:							\
-    	if (X##_s)							\
-    	  {								\
-    	    R##_s = 0;							\
-	    R##_c = FP_CLS_NAN; /* sNAN */				\
-    	  }								\
-    	else								\
-    	  {								\
-    	    R##_s = 0;							\
-    	    R##_c = FP_CLS_INF; /* sqrt(+inf) = +inf */			\
-    	  }								\
-    	break;								\
-    case FP_CLS_ZERO:							\
-	R##_s = X##_s;							\
-    	R##_c = FP_CLS_ZERO; /* sqrt(+-0) = +-0 */			\
-	break;								\
-    case FP_CLS_NORMAL:							\
-    	R##_s = 0;							\
-        if (X##_s)							\
-          {								\
-	    R##_c = FP_CLS_NAN; /* sNAN */				\
-	    break;							\
-          }								\
-    	R##_c = FP_CLS_NORMAL;						\
-        if (X##_e & 1)							\
-          _FP_FRAC_SLL_##wc(X, 1);					\
-        R##_e = X##_e >> 1;						\
-        _FP_FRAC_SET_##wc(S, _FP_ZEROFRAC_##wc);			\
-        _FP_FRAC_SET_##wc(R, _FP_ZEROFRAC_##wc);			\
-        q = _FP_OVERFLOW_##fs;						\
-        _FP_FRAC_SLL_##wc(X, 1);					\
-        _FP_SQRT_MEAT_##wc(R, S, T, X, q);				\
-        _FP_FRAC_SRL_##wc(R, 1);					\
-    }									\
-  } while (0)
-
-/*
- * Convert from FP to integer
- */
-
-/* "When a NaN, infinity, large positive argument >= 2147483648.0, or
- * large negative argument <= -2147483649.0 is converted to an integer,
- * the invalid_current bit...should be set and fp_exception_IEEE_754 should
- * be raised. If the floating point invalid trap is disabled, no trap occurs
- * and a numerical result is generated: if the sign bit of the operand
- * is 0, the result is 2147483647; if the sign bit of the operand is 1,
- * the result is -2147483648."
- * Similarly for conversion to extended ints, except that the boundaries
- * are >= 2^63, <= -(2^63 + 1), and the results are 2^63 + 1 for s=0 and
- * -2^63 for s=1.
- * -- SPARC Architecture Manual V9, Appendix B, which specifies how
- * SPARCs resolve implementation dependencies in the IEEE-754 spec.
- * I don't believe that the code below follows this. I'm not even sure
- * it's right!
- * It doesn't cope with needing to convert to an n bit integer when there
- * is no n bit integer type. Fortunately gcc provides long long so this
- * isn't a problem for sparc32.
- * I have, however, fixed its NaN handling to conform as above.
- *         -- PMM 02/1998
- * NB: rsigned is not 'is r declared signed?' but 'should the value stored
- * in r be signed or unsigned?'. r is always(?) declared unsigned.
- * Comments below are mine, BTW -- PMM
- */
-#define _FP_TO_INT(fs, wc, r, X, rsize, rsigned)			\
-  do {									\
-    switch (X##_c)							\
-      {									\
-      case FP_CLS_NORMAL:						\
-	if (X##_e < 0)							\
-	  {								\
-	  /* case FP_CLS_NAN: see above! */				\
-	  case FP_CLS_ZERO:						\
-	    r = 0;							\
-	  }								\
-	else if (X##_e >= rsize - (rsigned != 0))			\
-	  {	/* overflow */						\
-	  case FP_CLS_NAN:                                              \
-          case FP_CLS_INF:						\
-	    if (rsigned)						\
-	      {								\
-		r = 1;							\
-		r <<= rsize - 1;					\
-		r -= 1 - X##_s;						\
-	      }								\
-	    else							\
-	      {								\
-		r = 0;							\
-		if (!X##_s)						\
-		  r = ~r;						\
-	      }								\
-	  }								\
-	else								\
-	  {								\
-	    if (_FP_W_TYPE_SIZE*wc < rsize)				\
-	      {								\
-		_FP_FRAC_ASSEMBLE_##wc(r, X, rsize);			\
-		r <<= X##_e - _FP_WFRACBITS_##fs;			\
-	      }								\
-	    else							\
-	      {								\
-		if (X##_e >= _FP_WFRACBITS_##fs)			\
-		  _FP_FRAC_SLL_##wc(X, (X##_e - _FP_WFRACBITS_##fs + 1));\
-		else							\
-		  _FP_FRAC_SRL_##wc(X, (_FP_WFRACBITS_##fs - X##_e - 1));\
-		_FP_FRAC_ASSEMBLE_##wc(r, X, rsize);			\
-	      }								\
-	    if (rsigned && X##_s)					\
-	      r = -r;							\
-	  }								\
-	break;								\
-      }									\
-  } while (0)
-
-#define _FP_FROM_INT(fs, wc, X, r, rsize, rtype)			\
-  do {									\
-    if (r)								\
-      {									\
-	X##_c = FP_CLS_NORMAL;						\
-									\
-	if ((X##_s = (r < 0)))						\
-	  r = -r;							\
-	/* Note that `r' is now considered unsigned, so we don't have	\
-	   to worry about the single signed overflow case.  */		\
-									\
-	if (rsize <= _FP_W_TYPE_SIZE)					\
-	  __FP_CLZ(X##_e, r);						\
-	else								\
-	  __FP_CLZ_2(X##_e, (_FP_W_TYPE)(r >> _FP_W_TYPE_SIZE), 	\
-		     (_FP_W_TYPE)r);					\
-	if (rsize < _FP_W_TYPE_SIZE)					\
-		X##_e -= (_FP_W_TYPE_SIZE - rsize);			\
-	X##_e = rsize - X##_e - 1;					\
-									\
-	if (_FP_FRACBITS_##fs < rsize && _FP_WFRACBITS_##fs < X##_e)	\
-	  __FP_FRAC_SRS_1(r, (X##_e - _FP_WFRACBITS_##fs), rsize);	\
-	r &= ~((_FP_W_TYPE)1 << X##_e);					\
-	_FP_FRAC_DISASSEMBLE_##wc(X, ((unsigned rtype)r), rsize);	\
-	_FP_FRAC_SLL_##wc(X, (_FP_WFRACBITS_##fs - X##_e - 1));		\
-      }									\
-    else								\
-      {									\
-	X##_c = FP_CLS_ZERO, X##_s = 0;					\
-      }									\
-  } while (0)
-
-
-#define FP_CONV(dfs,sfs,dwc,swc,D,S)			\
-  do {							\
-    _FP_FRAC_CONV_##dwc##_##swc(dfs, sfs, D, S);	\
-    D##_e = S##_e;					\
-    D##_c = S##_c;					\
-    D##_s = S##_s;					\
-  } while (0)
-
-/*
- * Helper primitives.
- */
-
-/* Count leading zeros in a word.  */
-
-#ifndef __FP_CLZ
-#if _FP_W_TYPE_SIZE < 64
-/* this is just to shut the compiler up about shifts > word length -- PMM 02/1998 */
-#define __FP_CLZ(r, x)				\
-  do {						\
-    _FP_W_TYPE _t = (x);			\
-    r = _FP_W_TYPE_SIZE - 1;			\
-    if (_t > 0xffff) r -= 16;			\
-    if (_t > 0xffff) _t >>= 16;			\
-    if (_t > 0xff) r -= 8;			\
-    if (_t > 0xff) _t >>= 8;			\
-    if (_t & 0xf0) r -= 4;			\
-    if (_t & 0xf0) _t >>= 4;			\
-    if (_t & 0xc) r -= 2;			\
-    if (_t & 0xc) _t >>= 2;			\
-    if (_t & 0x2) r -= 1;			\
-  } while (0)
-#else /* not _FP_W_TYPE_SIZE < 64 */
-#define __FP_CLZ(r, x)				\
-  do {						\
-    _FP_W_TYPE _t = (x);			\
-    r = _FP_W_TYPE_SIZE - 1;			\
-    if (_t > 0xffffffff) r -= 32;		\
-    if (_t > 0xffffffff) _t >>= 32;		\
-    if (_t > 0xffff) r -= 16;			\
-    if (_t > 0xffff) _t >>= 16;			\
-    if (_t > 0xff) r -= 8;			\
-    if (_t > 0xff) _t >>= 8;			\
-    if (_t & 0xf0) r -= 4;			\
-    if (_t & 0xf0) _t >>= 4;			\
-    if (_t & 0xc) r -= 2;			\
-    if (_t & 0xc) _t >>= 2;			\
-    if (_t & 0x2) r -= 1;			\
-  } while (0)
-#endif /* not _FP_W_TYPE_SIZE < 64 */
-#endif /* ndef __FP_CLZ */
-
-#define _FP_DIV_HELP_imm(q, r, n, d)		\
-  do {						\
-    q = n / d, r = n % d;			\
-  } while (0)
-
diff --git a/arch/powerpc/math-emu/single.h b/arch/powerpc/math-emu/single.h
deleted file mode 100644
index f19d994..0000000
--- a/arch/powerpc/math-emu/single.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * Definitions for IEEE Single Precision
- */
-
-#if _FP_W_TYPE_SIZE < 32
-#error "Here's a nickel kid.  Go buy yourself a real computer."
-#endif
-
-#define _FP_FRACBITS_S		24
-#define _FP_FRACXBITS_S		(_FP_W_TYPE_SIZE - _FP_FRACBITS_S)
-#define _FP_WFRACBITS_S		(_FP_WORKBITS + _FP_FRACBITS_S)
-#define _FP_WFRACXBITS_S	(_FP_W_TYPE_SIZE - _FP_WFRACBITS_S)
-#define _FP_EXPBITS_S		8
-#define _FP_EXPBIAS_S		127
-#define _FP_EXPMAX_S		255
-#define _FP_QNANBIT_S		((_FP_W_TYPE)1 << (_FP_FRACBITS_S-2))
-#define _FP_IMPLBIT_S		((_FP_W_TYPE)1 << (_FP_FRACBITS_S-1))
-#define _FP_OVERFLOW_S		((_FP_W_TYPE)1 << (_FP_WFRACBITS_S))
-
-/* The implementation of _FP_MUL_MEAT_S and _FP_DIV_MEAT_S should be
-   chosen by the target machine.  */
-
-union _FP_UNION_S
-{
-  float flt;
-  struct {
-#if __BYTE_ORDER == __BIG_ENDIAN
-    unsigned sign : 1;
-    unsigned exp  : _FP_EXPBITS_S;
-    unsigned frac : _FP_FRACBITS_S - (_FP_IMPLBIT_S != 0);
-#else
-    unsigned frac : _FP_FRACBITS_S - (_FP_IMPLBIT_S != 0);
-    unsigned exp  : _FP_EXPBITS_S;
-    unsigned sign : 1;
-#endif
-  } bits __attribute__((packed));
-};
-
-#define FP_DECL_S(X)		_FP_DECL(1,X)
-#define FP_UNPACK_RAW_S(X,val)	_FP_UNPACK_RAW_1(S,X,val)
-#define FP_PACK_RAW_S(val,X)	_FP_PACK_RAW_1(S,val,X)
-
-#define FP_UNPACK_S(X,val)		\
-  do {					\
-    _FP_UNPACK_RAW_1(S,X,val);		\
-    _FP_UNPACK_CANONICAL(S,1,X);	\
-  } while (0)
-
-#define FP_PACK_S(val,X)		\
-  do {					\
-    _FP_PACK_CANONICAL(S,1,X);		\
-    _FP_PACK_RAW_1(S,val,X);		\
-  } while (0)
-
-#define FP_NEG_S(R,X)		_FP_NEG(S,1,R,X)
-#define FP_ADD_S(R,X,Y)		_FP_ADD(S,1,R,X,Y)
-#define FP_SUB_S(R,X,Y)		_FP_SUB(S,1,R,X,Y)
-#define FP_MUL_S(R,X,Y)		_FP_MUL(S,1,R,X,Y)
-#define FP_DIV_S(R,X,Y)		_FP_DIV(S,1,R,X,Y)
-#define FP_SQRT_S(R,X)		_FP_SQRT(S,1,R,X)
-
-#define FP_CMP_S(r,X,Y,un)	_FP_CMP(S,1,r,X,Y,un)
-#define FP_CMP_EQ_S(r,X,Y)	_FP_CMP_EQ(S,1,r,X,Y)
-
-#define FP_TO_INT_S(r,X,rsz,rsg)  _FP_TO_INT(S,1,r,X,rsz,rsg)
-#define FP_FROM_INT_S(X,r,rs,rt)  _FP_FROM_INT(S,1,X,r,rs,rt)
diff --git a/arch/powerpc/math-emu/soft-fp.h b/arch/powerpc/math-emu/soft-fp.h
deleted file mode 100644
index cca3959..0000000
--- a/arch/powerpc/math-emu/soft-fp.h
+++ /dev/null
@@ -1,104 +0,0 @@
-#ifndef SOFT_FP_H
-#define SOFT_FP_H
-
-#include "sfp-machine.h"
-
-#define _FP_WORKBITS		3
-#define _FP_WORK_LSB		((_FP_W_TYPE)1 << 3)
-#define _FP_WORK_ROUND		((_FP_W_TYPE)1 << 2)
-#define _FP_WORK_GUARD		((_FP_W_TYPE)1 << 1)
-#define _FP_WORK_STICKY		((_FP_W_TYPE)1 << 0)
-
-#ifndef FP_RND_NEAREST
-# define FP_RND_NEAREST		0
-# define FP_RND_ZERO		1
-# define FP_RND_PINF		2
-# define FP_RND_MINF		3
-#ifndef FP_ROUNDMODE
-# define FP_ROUNDMODE		FP_RND_NEAREST
-#endif
-#endif
-
-#define _FP_ROUND_NEAREST(wc, X)			\
-({  int __ret = 0;					\
-    int __frac = _FP_FRAC_LOW_##wc(X) & 15;		\
-    if (__frac & 7) {					\
-      __ret = EFLAG_INEXACT;				\
-      if ((__frac & 7) != _FP_WORK_ROUND)		\
-        _FP_FRAC_ADDI_##wc(X, _FP_WORK_ROUND);		\
-      else if (__frac & _FP_WORK_LSB)			\
-        _FP_FRAC_ADDI_##wc(X, _FP_WORK_ROUND);		\
-    }							\
-    __ret;						\
-})
-
-#define _FP_ROUND_ZERO(wc, X)				\
-({  int __ret = 0;					\
-    if (_FP_FRAC_LOW_##wc(X) & 7)			\
-      __ret = EFLAG_INEXACT;				\
-    __ret;						\
-})
-
-#define _FP_ROUND_PINF(wc, X)				\
-({  int __ret = EFLAG_INEXACT;				\
-    if (!X##_s && (_FP_FRAC_LOW_##wc(X) & 7))		\
-      _FP_FRAC_ADDI_##wc(X, _FP_WORK_LSB);		\
-    else __ret = 0;					\
-    __ret;						\
-})
-
-#define _FP_ROUND_MINF(wc, X)				\
-({  int __ret = EFLAG_INEXACT;				\
-    if (X##_s && (_FP_FRAC_LOW_##wc(X) & 7))		\
-      _FP_FRAC_ADDI_##wc(X, _FP_WORK_LSB);		\
-    else __ret = 0;					\
-    __ret;						\
-})
-
-#define _FP_ROUND(wc, X)			\
-({	int __ret = 0;				\
-	switch (FP_ROUNDMODE)			\
-	{					\
-	  case FP_RND_NEAREST:			\
-	    __ret |= _FP_ROUND_NEAREST(wc,X);	\
-	    break;				\
-	  case FP_RND_ZERO:			\
-	    __ret |= _FP_ROUND_ZERO(wc,X);	\
-	    break;				\
-	  case FP_RND_PINF:			\
-	    __ret |= _FP_ROUND_PINF(wc,X);	\
-	    break;				\
-	  case FP_RND_MINF:			\
-	    __ret |= _FP_ROUND_MINF(wc,X);	\
-	    break;				\
-	};					\
-	__ret;					\
-})
-
-#define FP_CLS_NORMAL		0
-#define FP_CLS_ZERO		1
-#define FP_CLS_INF		2
-#define FP_CLS_NAN		3
-
-#define _FP_CLS_COMBINE(x,y)	(((x) << 2) | (y))
-
-#include "op-1.h"
-#include "op-2.h"
-#include "op-4.h"
-#include "op-common.h"
-
-/* Sigh.  Silly things longlong.h needs.  */
-#define UWtype		_FP_W_TYPE
-#define W_TYPE_SIZE	_FP_W_TYPE_SIZE
-
-typedef int SItype __attribute__((mode(SI)));
-typedef int DItype __attribute__((mode(DI)));
-typedef unsigned int USItype __attribute__((mode(SI)));
-typedef unsigned int UDItype __attribute__((mode(DI)));
-#if _FP_W_TYPE_SIZE == 32
-typedef unsigned int UHWtype __attribute__((mode(HI)));
-#elif _FP_W_TYPE_SIZE == 64
-typedef USItype UHWtype;
-#endif
-
-#endif
diff --git a/arch/powerpc/math-emu/stfs.c b/arch/powerpc/math-emu/stfs.c
index 8689aa4..6122147 100644
--- a/arch/powerpc/math-emu/stfs.c
+++ b/arch/powerpc/math-emu/stfs.c
@@ -2,23 +2,24 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <asm/sfp-machine.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 stfs(void *frS, void *ea)
 {
 	FP_DECL_D(A);
 	FP_DECL_S(R);
+	FP_DECL_EX;
 	float f;
-	int err;
 
 #ifdef DEBUG
 	printk("%s: S %p, ea %p\n", __func__, frS, ea);
 #endif
 
-	__FP_UNPACK_D(A, frS);
+	FP_UNPACK_DP(A, frS);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -30,12 +31,12 @@ stfs(void *frS, void *ea)
 	printk("R: %ld %lu %ld (%ld)\n", R_s, R_f, R_e, R_c);
 #endif
 
-	err = _FP_PACK_CANONICAL(S, 1, R);
-	if (!err || !__FPU_TRAP_P(err)) {
-		__FP_PACK_RAW_1(S, &f, R);
+	_FP_PACK_CANONICAL(S, 1, R);
+	if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS)) {
+		_FP_PACK_RAW_1_P(S, &f, R);
 		if (copy_to_user(ea, &f, sizeof(float)))
 			return -EFAULT;
 	}
 
-	return err;
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/types.c b/arch/powerpc/math-emu/types.c
deleted file mode 100644
index e1ed15d..0000000
--- a/arch/powerpc/math-emu/types.c
+++ /dev/null
@@ -1,51 +0,0 @@
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
-
-void
-fp_unpack_d(long *_s, unsigned long *_f1, unsigned long *_f0,
-	    long *_e, long *_c, void *val)
-{
-	FP_DECL_D(X);
-
-	__FP_UNPACK_RAW_2(D, X, val);
-
-	_FP_UNPACK_CANONICAL(D, 2, X);
-
-	*_s = X_s;
-	*_f1 = X_f1;
-	*_f0 = X_f0;
-	*_e = X_e;
-	*_c = X_c;
-}
-
-int
-fp_pack_d(void *val, long X_s, unsigned long X_f1,
-	  unsigned long X_f0, long X_e, long X_c)
-{
-	int exc;
-
-	exc = _FP_PACK_CANONICAL(D, 2, X);
-	if (!exc || !__FPU_TRAP_P(exc))
-		__FP_PACK_RAW_2(D, val, X);
-	return exc;
-}
-
-int
-fp_pack_ds(void *val, long X_s, unsigned long X_f1,
-	   unsigned long X_f0, long X_e, long X_c)
-{
-	FP_DECL_S(__X);
-	int exc;
-
-	FP_CONV(S, D, 1, 2, __X, X);
-	exc = _FP_PACK_CANONICAL(S, 1, __X);
-	if (!exc || !__FPU_TRAP_P(exc)) {
-		_FP_UNPACK_CANONICAL(S, 1, __X);
-		FP_CONV(D, S, 2, 1, X, __X);
-		exc |= _FP_PACK_CANONICAL(D, 2, X);
-		if (!exc || !__FPU_TRAP_P(exc))
-			__FP_PACK_RAW_2(D, val, X);
-	}
-	return exc;
-}
diff --git a/arch/powerpc/math-emu/udivmodti4.c b/arch/powerpc/math-emu/udivmodti4.c
index 7e112dc..6172044 100644
--- a/arch/powerpc/math-emu/udivmodti4.c
+++ b/arch/powerpc/math-emu/udivmodti4.c
@@ -1,6 +1,6 @@
 /* This has so very few changes over libgcc2's __udivmoddi4 it isn't funny.  */
 
-#include "soft-fp.h"
+#include <math-emu/soft-fp.h>
 
 #undef count_leading_zeros
 #define count_leading_zeros  __FP_CLZ
-- 
1.5.5.1

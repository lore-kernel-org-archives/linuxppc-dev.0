Return-Path: <Yu.Liu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6A78EDDEDF
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 19:51:38 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m258ox0o009828
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 01:51:00 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m258orbU003933
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 02:50:59 -0600 (CST)
From: Liu Yu <Yu.Liu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] math-emu: use new interface of common math-emu headers in
	PowerPC math-emu C file
Date: Wed,  5 Mar 2008 17:02:28 +0800
Message-Id: <12047077501016-git-send-email-Yu.Liu@freescale.com>
In-Reply-To: <12047077492663-git-send-email-Yu.Liu@freescale.com>
References: <12047077481825-git-send-email-Yu.Liu@freescale.com>
	<12047077492663-git-send-email-Yu.Liu@freescale.com>
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
 arch/powerpc/math-emu/Makefile     |    2 +-
 arch/powerpc/math-emu/fadd.c       |   16 +++++++++-------
 arch/powerpc/math-emu/fadds.c      |   17 +++++++++--------
 arch/powerpc/math-emu/fcmpo.c      |   22 +++++++++++++---------
 arch/powerpc/math-emu/fcmpu.c      |   20 +++++++++++++-------
 arch/powerpc/math-emu/fctiw.c      |    9 +++++----
 arch/powerpc/math-emu/fctiwz.c     |    9 +++++----
 arch/powerpc/math-emu/fdiv.c       |   22 +++++++++-------------
 arch/powerpc/math-emu/fdivs.c      |   25 ++++++++++---------------
 arch/powerpc/math-emu/fmadd.c      |   19 ++++++++++---------
 arch/powerpc/math-emu/fmadds.c     |   21 +++++++++++----------
 arch/powerpc/math-emu/fmsub.c      |   19 ++++++++++---------
 arch/powerpc/math-emu/fmsubs.c     |   21 +++++++++++----------
 arch/powerpc/math-emu/fmul.c       |   15 ++++++++-------
 arch/powerpc/math-emu/fmuls.c      |   17 +++++++++--------
 arch/powerpc/math-emu/fnmadd.c     |   19 ++++++++++---------
 arch/powerpc/math-emu/fnmadds.c    |   21 +++++++++++----------
 arch/powerpc/math-emu/fnmsub.c     |   19 ++++++++++---------
 arch/powerpc/math-emu/fnmsubs.c    |   21 +++++++++++----------
 arch/powerpc/math-emu/frsp.c       |   12 +++++++-----
 arch/powerpc/math-emu/fsel.c       |    9 +++++----
 arch/powerpc/math-emu/fsqrt.c      |   15 ++++++++-------
 arch/powerpc/math-emu/fsqrts.c     |   17 +++++++++--------
 arch/powerpc/math-emu/fsub.c       |   15 ++++++++-------
 arch/powerpc/math-emu/fsubs.c      |   17 +++++++++--------
 arch/powerpc/math-emu/lfd.c        |    4 ++--
 arch/powerpc/math-emu/lfs.c        |   12 +++++++-----
 arch/powerpc/math-emu/math.c       |    4 ++--
 arch/powerpc/math-emu/mcrfs.c      |    2 +-
 arch/powerpc/math-emu/mffs.c       |    2 +-
 arch/powerpc/math-emu/mtfsb0.c     |    2 +-
 arch/powerpc/math-emu/mtfsb1.c     |    2 +-
 arch/powerpc/math-emu/mtfsf.c      |    2 +-
 arch/powerpc/math-emu/mtfsfi.c     |    2 +-
 arch/powerpc/math-emu/stfs.c       |   18 +++++++++---------
 arch/powerpc/math-emu/udivmodti4.c |    2 +-
 36 files changed, 248 insertions(+), 223 deletions(-)

diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
index 29bc912..578c39a 100644
--- a/arch/powerpc/math-emu/Makefile
+++ b/arch/powerpc/math-emu/Makefile
@@ -4,7 +4,7 @@ obj-y				:= math.o fmr.o lfd.o stfd.o
 obj-$(CONFIG_MATH_EMULATION)	+= fabs.o fadd.o fadds.o fcmpo.o fcmpu.o \
 					fctiw.o fctiwz.o fdiv.o fdivs.o \
 					fmadd.o fmadds.o fmsub.o fmsubs.o \
-					fmul.o fmuls.o fnabs.o fneg.o types.o \
+					fmul.o fmuls.o fnabs.o fneg.o \
 					fnmadd.o fnmadds.o fnmsub.o fnmsubs.o \
 					fres.o frsp.o frsqrte.o fsel.o lfs.o \
 					fsqrt.o	fsqrts.o fsub.o fsubs.o \
diff --git a/arch/powerpc/math-emu/fadd.c b/arch/powerpc/math-emu/fadd.c
index fc88364..18643ea 100644
--- a/arch/powerpc/math-emu/fadd.c
+++ b/arch/powerpc/math-emu/fadd.c
@@ -2,23 +2,23 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fadd(void *frD, void *frA, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __FUNCTION__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -26,7 +26,7 @@ fadd(void *frD, void *frA, void *frB)
 #endif
 
 	if (A_s != B_s && A_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, A, B);
 
@@ -34,5 +34,7 @@ fadd(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	return (ret | __FP_PACK_D(frD, R));
+	FP_PACK_DP(frD, R);
+
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fadds.c b/arch/powerpc/math-emu/fadds.c
index 93025b6..2b4fe58 100644
--- a/arch/powerpc/math-emu/fadds.c
+++ b/arch/powerpc/math-emu/fadds.c
@@ -2,24 +2,24 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fadds(void *frD, void *frA, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __FUNCTION__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -27,13 +27,14 @@ fadds(void *frD, void *frA, void *frB)
 #endif
 
 	if (A_s != B_s && A_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, A, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	__FP_PACK_DS(frD, R);
 
-	return (ret | __FP_PACK_DS(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fcmpo.c b/arch/powerpc/math-emu/fcmpo.c
index 4efac39..adcc4b4 100644
--- a/arch/powerpc/math-emu/fcmpo.c
+++ b/arch/powerpc/math-emu/fcmpo.c
@@ -2,24 +2,24 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fcmpo(u32 *ccr, int crfD, void *frA, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	int code[4] = { (1 << 3), (1 << 1), (1 << 2), (1 << 0) };
 	long cmp;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p (%08x) %d %p %p\n", __FUNCTION__, ccr, *ccr, crfD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -27,10 +27,14 @@ fcmpo(u32 *ccr, int crfD, void *frA, void *frB)
 #endif
 
 	if (A_c == FP_CLS_NAN || B_c == FP_CLS_NAN)
-		ret |= EFLAG_VXVC;
+		FP_SET_EXCEPTION(EFLAG_VXVC);
 
-	FP_CMP_D(cmp, A, B, 2);
-	cmp = code[(cmp + 1) & 3];
+	FP_CMP_D(cmp, A, B, 3);
+	if (cmp == 3 && (FP_ISSIGNAN_D(A) || FP_ISSIGNAN_D(B))){
+		FP_SET_EXCEPTION (FP_EX_INVALID);
+		cmp = 1;
+	} else
+		cmp = code[(cmp + 1) & 3];
 
 	__FPU_FPSCR &= ~(0x1f000);
 	__FPU_FPSCR |= (cmp << 12);
@@ -42,5 +46,5 @@ fcmpo(u32 *ccr, int crfD, void *frA, void *frB)
 	printk("CR: %08x\n", *ccr);
 #endif
 
-	return ret;
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fcmpu.c b/arch/powerpc/math-emu/fcmpu.c
index b7e3317..8f91e0b 100644
--- a/arch/powerpc/math-emu/fcmpu.c
+++ b/arch/powerpc/math-emu/fcmpu.c
@@ -2,12 +2,13 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	int code[4] = { (1 << 3), (1 << 1), (1 << 2), (1 << 0) };
@@ -17,16 +18,21 @@ fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
 	printk("%s: %p (%08x) %d %p %p\n", __FUNCTION__, ccr, *ccr, crfD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
 	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
 #endif
 
-	FP_CMP_D(cmp, A, B, 2);
-	cmp = code[(cmp + 1) & 3];
+	FP_CMP_D(cmp, A, B, 3);
+	if (cmp == 3 && (FP_ISSIGNAN_D(A) || FP_ISSIGNAN_D(B))){
+		FP_SET_EXCEPTION (FP_EX_INVALID);
+		cmp = 1;
+	} else
+		cmp = code[(cmp + 1) & 3];
+
 
 	__FPU_FPSCR &= ~(0x1f000);
 	__FPU_FPSCR |= (cmp << 12);
@@ -38,5 +44,5 @@ fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
 	printk("CR: %08x\n", *ccr);
 #endif
 
-	return 0;
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fctiw.c b/arch/powerpc/math-emu/fctiw.c
index 3b3c98b..f0ae59d 100644
--- a/arch/powerpc/math-emu/fctiw.c
+++ b/arch/powerpc/math-emu/fctiw.c
@@ -2,16 +2,17 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fctiw(u32 *frD, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(B);
 	unsigned int r;
 
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(B, frB);
 	FP_TO_INT_D(r, B, 32, 1);
 	frD[1] = r;
 
@@ -21,5 +22,5 @@ fctiw(u32 *frD, void *frB)
 	printk("\n");
 #endif
 
-	return 0;
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fctiwz.c b/arch/powerpc/math-emu/fctiwz.c
index 7717eb6..7dfdd9e 100644
--- a/arch/powerpc/math-emu/fctiwz.c
+++ b/arch/powerpc/math-emu/fctiwz.c
@@ -2,12 +2,13 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fctiwz(u32 *frD, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(B);
 	u32 fpscr;
 	unsigned int r;
@@ -16,7 +17,7 @@ fctiwz(u32 *frD, void *frB)
 	__FPU_FPSCR &= ~(3);
 	__FPU_FPSCR |= FP_RND_ZERO;
 
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(B, frB);
 	FP_TO_INT_D(r, B, 32, 1);
 	frD[1] = r;
 
@@ -28,5 +29,5 @@ fctiwz(u32 *frD, void *frB)
 	printk("\n");
 #endif
 
-	return 0;
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fdiv.c b/arch/powerpc/math-emu/fdiv.c
index f2fba82..371d4da 100644
--- a/arch/powerpc/math-emu/fdiv.c
+++ b/arch/powerpc/math-emu/fdiv.c
@@ -2,23 +2,23 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fdiv(void *frD, void *frA, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __FUNCTION__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -26,28 +26,24 @@ fdiv(void *frD, void *frA, void *frB)
 #endif
 
 	if (A_c == FP_CLS_ZERO && B_c == FP_CLS_ZERO) {
-		ret |= EFLAG_VXZDZ;
+		FP_SET_EXCEPTION(EFLAG_VXZDZ);
 #ifdef DEBUG
 		printk("%s: FPSCR_VXZDZ raised\n", __FUNCTION__);
 #endif
 	}
 	if (A_c == FP_CLS_INF && B_c == FP_CLS_INF) {
-		ret |= EFLAG_VXIDI;
+		FP_SET_EXCEPTION(EFLAG_VXIDI);
 #ifdef DEBUG
 		printk("%s: FPSCR_VXIDI raised\n", __FUNCTION__);
 #endif
 	}
 
-	if (B_c == FP_CLS_ZERO && A_c != FP_CLS_ZERO) {
-		ret |= EFLAG_DIVZERO;
-		if (__FPU_TRAP_P(EFLAG_DIVZERO))
-			return ret;
-	}
 	FP_DIV_D(R, A, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	FP_PACK_DP(frD, R);
 
-	return (ret | __FP_PACK_D(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fdivs.c b/arch/powerpc/math-emu/fdivs.c
index b971196..2dbd79d 100644
--- a/arch/powerpc/math-emu/fdivs.c
+++ b/arch/powerpc/math-emu/fdivs.c
@@ -2,24 +2,24 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fdivs(void *frD, void *frA, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __FUNCTION__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -27,29 +27,24 @@ fdivs(void *frD, void *frA, void *frB)
 #endif
 
 	if (A_c == FP_CLS_ZERO && B_c == FP_CLS_ZERO) {
-		ret |= EFLAG_VXZDZ;
+		FP_SET_EXCEPTION(EFLAG_VXZDZ);
 #ifdef DEBUG
 		printk("%s: FPSCR_VXZDZ raised\n", __FUNCTION__);
 #endif
 	}
 	if (A_c == FP_CLS_INF && B_c == FP_CLS_INF) {
-		ret |= EFLAG_VXIDI;
+		FP_SET_EXCEPTION(EFLAG_VXIDI);
 #ifdef DEBUG
 		printk("%s: FPSCR_VXIDI raised\n", __FUNCTION__);
 #endif
 	}
 
-	if (B_c == FP_CLS_ZERO && A_c != FP_CLS_ZERO) {
-		ret |= EFLAG_DIVZERO;
-		if (__FPU_TRAP_P(EFLAG_DIVZERO))
-			return ret;
-	}
-
 	FP_DIV_D(R, A, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	__FP_PACK_DS(frD, R);
 
-	return (ret | __FP_PACK_DS(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fmadd.c b/arch/powerpc/math-emu/fmadd.c
index 0a1dbce..06f49ff 100644
--- a/arch/powerpc/math-emu/fmadd.c
+++ b/arch/powerpc/math-emu/fmadd.c
@@ -2,26 +2,26 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fmadd(void *frD, void *frA, void *frB, void *frC)
 {
+	FP_DECL_EX;
 	FP_DECL_D(R);
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __FUNCTION__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -31,18 +31,19 @@ fmadd(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-                ret |= EFLAG_VXIMZ;
+                FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	FP_PACK_DP(frD, R);
 
-	return (ret | __FP_PACK_D(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fmadds.c b/arch/powerpc/math-emu/fmadds.c
index 0f70bba..ef0bac0 100644
--- a/arch/powerpc/math-emu/fmadds.c
+++ b/arch/powerpc/math-emu/fmadds.c
@@ -2,27 +2,27 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fmadds(void *frD, void *frA, void *frB, void *frC)
 {
+	FP_DECL_EX;
 	FP_DECL_D(R);
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __FUNCTION__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -32,18 +32,19 @@ fmadds(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-                ret |= EFLAG_VXIMZ;
+                FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	__FP_PACK_DS(frD, R);
 
-	return (ret | __FP_PACK_DS(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fmsub.c b/arch/powerpc/math-emu/fmsub.c
index 203fd48..55c851e 100644
--- a/arch/powerpc/math-emu/fmsub.c
+++ b/arch/powerpc/math-emu/fmsub.c
@@ -2,26 +2,26 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fmsub(void *frD, void *frA, void *frB, void *frC)
 {
+	FP_DECL_EX;
 	FP_DECL_D(R);
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __FUNCTION__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -31,7 +31,7 @@ fmsub(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-		ret |= EFLAG_VXIMZ;
+		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
@@ -39,13 +39,14 @@ fmsub(void *frD, void *frA, void *frB, void *frC)
 		B_s ^= 1;
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	FP_PACK_DP(frD, R);
 
-	return (ret | __FP_PACK_D(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fmsubs.c b/arch/powerpc/math-emu/fmsubs.c
index 8ce6862..81941df 100644
--- a/arch/powerpc/math-emu/fmsubs.c
+++ b/arch/powerpc/math-emu/fmsubs.c
@@ -2,27 +2,27 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fmsubs(void *frD, void *frA, void *frB, void *frC)
 {
+	FP_DECL_EX;
 	FP_DECL_D(R);
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __FUNCTION__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -32,7 +32,7 @@ fmsubs(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-		ret |= EFLAG_VXIMZ;
+		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
@@ -40,13 +40,14 @@ fmsubs(void *frD, void *frA, void *frB, void *frC)
 		B_s ^= 1;
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	__FP_PACK_DS(frD, R);
 
-	return (ret | __FP_PACK_DS(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fmul.c b/arch/powerpc/math-emu/fmul.c
index 66c7e79..6f44699 100644
--- a/arch/powerpc/math-emu/fmul.c
+++ b/arch/powerpc/math-emu/fmul.c
@@ -2,23 +2,23 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fmul(void *frD, void *frA, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __FUNCTION__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld) [%08lx.%08lx %lx]\n",
@@ -29,7 +29,7 @@ fmul(void *frD, void *frA, void *frB)
 
 	if ((A_c == FP_CLS_INF && B_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && B_c == FP_CLS_INF))
-		ret |= EFLAG_VXIMZ;
+		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(R, A, B);
 
@@ -37,6 +37,7 @@ fmul(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld) [%08lx.%08lx %lx]\n",
 	       R_s, R_f1, R_f0, R_e, R_c, R_f1, R_f0, R_e + 1023);
 #endif
+	FP_PACK_DP(frD, R);
 
-	return (ret | __FP_PACK_D(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fmuls.c b/arch/powerpc/math-emu/fmuls.c
index 26bc427..6035a10 100644
--- a/arch/powerpc/math-emu/fmuls.c
+++ b/arch/powerpc/math-emu/fmuls.c
@@ -2,24 +2,24 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fmuls(void *frD, void *frA, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __FUNCTION__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld) [%08lx.%08lx %lx]\n",
@@ -30,7 +30,7 @@ fmuls(void *frD, void *frA, void *frB)
 
 	if ((A_c == FP_CLS_INF && B_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && B_c == FP_CLS_INF))
-		ret |= EFLAG_VXIMZ;
+		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(R, A, B);
 
@@ -38,6 +38,7 @@ fmuls(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld) [%08lx.%08lx %lx]\n",
 	       R_s, R_f1, R_f0, R_e, R_c, R_f1, R_f0, R_e + 1023);
 #endif
+	__FP_PACK_DS(frD, R);
 
-	return (ret | __FP_PACK_DS(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fnmadd.c b/arch/powerpc/math-emu/fnmadd.c
index 7f31227..8741b56 100644
--- a/arch/powerpc/math-emu/fnmadd.c
+++ b/arch/powerpc/math-emu/fnmadd.c
@@ -2,26 +2,26 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fnmadd(void *frD, void *frA, void *frB, void *frC)
 {
+	FP_DECL_EX;
 	FP_DECL_D(R);
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __FUNCTION__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -31,12 +31,12 @@ fnmadd(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-                ret |= EFLAG_VXIMZ;
+                FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
@@ -46,6 +46,7 @@ fnmadd(void *frD, void *frA, void *frB, void *frC)
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	FP_PACK_DP(frD, R);
 
-	return (ret | __FP_PACK_D(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fnmadds.c b/arch/powerpc/math-emu/fnmadds.c
index 65454c9..d04d4aa 100644
--- a/arch/powerpc/math-emu/fnmadds.c
+++ b/arch/powerpc/math-emu/fnmadds.c
@@ -2,27 +2,27 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fnmadds(void *frD, void *frA, void *frB, void *frC)
 {
+	FP_DECL_EX;
 	FP_DECL_D(R);
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __FUNCTION__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -32,12 +32,12 @@ fnmadds(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-                ret |= EFLAG_VXIMZ;
+                FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
@@ -47,6 +47,7 @@ fnmadds(void *frD, void *frA, void *frB, void *frC)
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	__FP_PACK_DS(frD, R);
 
-	return (ret | __FP_PACK_DS(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fnmsub.c b/arch/powerpc/math-emu/fnmsub.c
index f1ca748..0d91e9e 100644
--- a/arch/powerpc/math-emu/fnmsub.c
+++ b/arch/powerpc/math-emu/fnmsub.c
@@ -2,26 +2,26 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fnmsub(void *frD, void *frA, void *frB, void *frC)
 {
+	FP_DECL_EX;
 	FP_DECL_D(R);
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __FUNCTION__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -31,7 +31,7 @@ fnmsub(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-		ret |= EFLAG_VXIMZ;
+		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
@@ -39,7 +39,7 @@ fnmsub(void *frD, void *frA, void *frB, void *frC)
 		B_s ^= 1;
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
@@ -49,6 +49,7 @@ fnmsub(void *frD, void *frA, void *frB, void *frC)
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	FP_PACK_DP(frD, R);
 
-	return (ret | __FP_PACK_D(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fnmsubs.c b/arch/powerpc/math-emu/fnmsubs.c
index 5c9a09a..1e1e168 100644
--- a/arch/powerpc/math-emu/fnmsubs.c
+++ b/arch/powerpc/math-emu/fnmsubs.c
@@ -2,27 +2,27 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fnmsubs(void *frD, void *frA, void *frB, void *frC)
 {
+	FP_DECL_EX;
 	FP_DECL_D(R);
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
 	FP_DECL_D(T);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __FUNCTION__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
-	__FP_UNPACK_D(C, frC);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_DP(C, frC);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -32,7 +32,7 @@ fnmsubs(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-		ret |= EFLAG_VXIMZ;
+		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
@@ -40,7 +40,7 @@ fnmsubs(void *frD, void *frA, void *frB, void *frC)
 		B_s ^= 1;
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
@@ -50,6 +50,7 @@ fnmsubs(void *frD, void *frA, void *frB, void *frC)
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	__FP_PACK_DS(frD, R);
 
-	return (ret | __FP_PACK_DS(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/frsp.c b/arch/powerpc/math-emu/frsp.c
index d879b2a..6438823 100644
--- a/arch/powerpc/math-emu/frsp.c
+++ b/arch/powerpc/math-emu/frsp.c
@@ -2,24 +2,26 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 frsp(void *frD, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(B);
 
 #ifdef DEBUG
 	printk("%s: D %p, B %p\n", __FUNCTION__, frD, frB);
 #endif
 
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
 #endif
+	__FP_PACK_DS(frD, B);
 
-	return __FP_PACK_DS(frD, B);
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fsel.c b/arch/powerpc/math-emu/fsel.c
index e36e6e7..6fadfb3 100644
--- a/arch/powerpc/math-emu/fsel.c
+++ b/arch/powerpc/math-emu/fsel.c
@@ -2,19 +2,20 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fsel(u32 *frD, void *frA, u32 *frB, u32 *frC)
 {
+	FP_DECL_EX;
 	FP_DECL_D(A);
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __FUNCTION__, frD, frA, frB, frC);
 #endif
 
-	__FP_UNPACK_D(A, frA);
+	FP_UNPACK_DP(A, frA);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -34,5 +35,5 @@ fsel(u32 *frD, void *frA, u32 *frB, u32 *frC)
 	printk("D: %08x.%08x\n", frD[0], frD[1]);
 #endif
 
-	return 0;
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fsqrt.c b/arch/powerpc/math-emu/fsqrt.c
index 6f8319f..febd878 100644
--- a/arch/powerpc/math-emu/fsqrt.c
+++ b/arch/powerpc/math-emu/fsqrt.c
@@ -2,36 +2,37 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fsqrt(void *frD, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(B);
 	FP_DECL_D(R);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __FUNCTION__, frD, frB);
 #endif
 
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
 #endif
 
 	if (B_s && B_c != FP_CLS_ZERO)
-		ret |= EFLAG_VXSQRT;
+		FP_SET_EXCEPTION(EFLAG_VXSQRT);
 	if (B_c == FP_CLS_NAN)
-		ret |= EFLAG_VXSNAN;
+		FP_SET_EXCEPTION(EFLAG_VXSNAN);
 
 	FP_SQRT_D(R, B);
 
 #ifdef DEBUG
 	printk("R: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	FP_PACK_DP(frD, R);
 
-	return (ret | __FP_PACK_D(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fsqrts.c b/arch/powerpc/math-emu/fsqrts.c
index 3b2b1cf..fad4f8b 100644
--- a/arch/powerpc/math-emu/fsqrts.c
+++ b/arch/powerpc/math-emu/fsqrts.c
@@ -2,37 +2,38 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fsqrts(void *frD, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(B);
 	FP_DECL_D(R);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __FUNCTION__, frD, frB);
 #endif
 
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
 #endif
 
 	if (B_s && B_c != FP_CLS_ZERO)
-		ret |= EFLAG_VXSQRT;
+		FP_SET_EXCEPTION(EFLAG_VXSQRT);
 	if (B_c == FP_CLS_NAN)
-		ret |= EFLAG_VXSNAN;
+		FP_SET_EXCEPTION(EFLAG_VXSNAN);
 
 	FP_SQRT_D(R, B);
 
 #ifdef DEBUG
 	printk("R: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	__FP_PACK_DS(frD, R);
 
-	return (ret | __FP_PACK_DS(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fsub.c b/arch/powerpc/math-emu/fsub.c
index 9566790..d973919 100644
--- a/arch/powerpc/math-emu/fsub.c
+++ b/arch/powerpc/math-emu/fsub.c
@@ -2,23 +2,23 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
 
 int
 fsub(void *frD, void *frA, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __FUNCTION__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -29,13 +29,14 @@ fsub(void *frD, void *frA, void *frB)
 		B_s ^= 1;
 
 	if (A_s != B_s && A_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, A, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	FP_PACK_DP(frD, R);
 
-	return (ret | __FP_PACK_D(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fsubs.c b/arch/powerpc/math-emu/fsubs.c
index 3428117..3162382 100644
--- a/arch/powerpc/math-emu/fsubs.c
+++ b/arch/powerpc/math-emu/fsubs.c
@@ -2,24 +2,24 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 fsubs(void *frD, void *frA, void *frB)
 {
+	FP_DECL_EX;
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(R);
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __FUNCTION__, frD, frA, frB);
 #endif
 
-	__FP_UNPACK_D(A, frA);
-	__FP_UNPACK_D(B, frB);
+	FP_UNPACK_DP(A, frA);
+	FP_UNPACK_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -30,13 +30,14 @@ fsubs(void *frD, void *frA, void *frB)
 		B_s ^= 1;
 
 	if (A_s != B_s && A_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, A, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	__FP_PACK_DS(frD, R);
 
-	return (ret | __FP_PACK_DS(frD, R));
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/lfd.c b/arch/powerpc/math-emu/lfd.c
index 7d38101..e5ad147 100644
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
index c86dee3..67d3a3e 100644
--- a/arch/powerpc/math-emu/lfs.c
+++ b/arch/powerpc/math-emu/lfs.c
@@ -2,13 +2,14 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 lfs(void *frD, void *ea)
 {
+	FP_DECL_EX;
 	FP_DECL_D(R);
 	FP_DECL_S(A);
 	float f;
@@ -20,7 +21,7 @@ lfs(void *frD, void *ea)
 	if (copy_from_user(&f, ea, sizeof(float)))
 		return -EFAULT;
 
-	__FP_UNPACK_S(A, &f);
+	FP_UNPACK_SP(A, &f);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %ld (%ld) [%08lx]\n", A_s, A_f, A_e, A_c,
@@ -32,6 +33,7 @@ lfs(void *frD, void *ea)
 #ifdef DEBUG
 	printk("R: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
+	FP_PACK_DP(frD, R);
 
-	return __FP_PACK_D(frD, R);
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index 381306b..2f355df 100644
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
 
diff --git a/arch/powerpc/math-emu/mcrfs.c b/arch/powerpc/math-emu/mcrfs.c
index 106dd91..219b09f 100644
--- a/arch/powerpc/math-emu/mcrfs.c
+++ b/arch/powerpc/math-emu/mcrfs.c
@@ -2,7 +2,7 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
+#include <math-emu/soft-fp.h>
 
 int
 mcrfs(u32 *ccr, u32 crfD, u32 crfS)
diff --git a/arch/powerpc/math-emu/mffs.c b/arch/powerpc/math-emu/mffs.c
index f477c91..329ff94 100644
--- a/arch/powerpc/math-emu/mffs.c
+++ b/arch/powerpc/math-emu/mffs.c
@@ -2,7 +2,7 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
+#include <math-emu/soft-fp.h>
 
 int
 mffs(u32 *frD)
diff --git a/arch/powerpc/math-emu/mtfsb0.c b/arch/powerpc/math-emu/mtfsb0.c
index 99bfd80..3404b2f 100644
--- a/arch/powerpc/math-emu/mtfsb0.c
+++ b/arch/powerpc/math-emu/mtfsb0.c
@@ -2,7 +2,7 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
+#include <math-emu/soft-fp.h>
 
 int
 mtfsb0(int crbD)
diff --git a/arch/powerpc/math-emu/mtfsb1.c b/arch/powerpc/math-emu/mtfsb1.c
index 3d9e7ed..933b333 100644
--- a/arch/powerpc/math-emu/mtfsb1.c
+++ b/arch/powerpc/math-emu/mtfsb1.c
@@ -2,7 +2,7 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
+#include <math-emu/soft-fp.h>
 
 int
 mtfsb1(int crbD)
diff --git a/arch/powerpc/math-emu/mtfsf.c b/arch/powerpc/math-emu/mtfsf.c
index d70cf71..caeceaa 100644
--- a/arch/powerpc/math-emu/mtfsf.c
+++ b/arch/powerpc/math-emu/mtfsf.c
@@ -2,7 +2,7 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
+#include <math-emu/soft-fp.h>
 
 int
 mtfsf(unsigned int FM, u32 *frB)
diff --git a/arch/powerpc/math-emu/mtfsfi.c b/arch/powerpc/math-emu/mtfsfi.c
index 71df854..4c9777a 100644
--- a/arch/powerpc/math-emu/mtfsfi.c
+++ b/arch/powerpc/math-emu/mtfsfi.c
@@ -2,7 +2,7 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
+#include <math-emu/soft-fp.h>
 
 int
 mtfsfi(unsigned int crfD, unsigned int IMM)
diff --git a/arch/powerpc/math-emu/stfs.c b/arch/powerpc/math-emu/stfs.c
index e87ca23..d392b38 100644
--- a/arch/powerpc/math-emu/stfs.c
+++ b/arch/powerpc/math-emu/stfs.c
@@ -2,23 +2,23 @@
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-#include "soft-fp.h"
-#include "double.h"
-#include "single.h"
+#include <math-emu/soft-fp.h>
+#include <math-emu/double.h>
+#include <math-emu/single.h>
 
 int
 stfs(void *frS, void *ea)
 {
+	FP_DECL_EX;
 	FP_DECL_D(A);
 	FP_DECL_S(R);
 	float f;
-	int err;
 
 #ifdef DEBUG
 	printk("%s: S %p, ea %p\n", __FUNCTION__, frS, ea);
 #endif
 
-	__FP_UNPACK_D(A, frS);
+	FP_UNPACK_DP(A, frS);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -30,12 +30,12 @@ stfs(void *frS, void *ea)
 	printk("R: %ld %lu %ld (%ld)\n", R_s, R_f, R_e, R_c);
 #endif
 
-	err = _FP_PACK_CANONICAL(S, 1, R);
-	if (!err || !__FPU_TRAP_P(err)) {
-		__FP_PACK_RAW_1(S, &f, R);
+	FP_PACK_SP(&f,R);
+
+	if (!FP_INHIBIT_RESULTS) {
 		if (copy_to_user(ea, &f, sizeof(float)))
 			return -EFAULT;
 	}
 
-	return err;
+	return FP_CUR_EXCEPTIONS;
 }
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
1.5.2

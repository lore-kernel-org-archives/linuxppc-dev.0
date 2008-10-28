Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB97DDDED9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 14:57:34 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m9S3vSKG026125
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 20:57:28 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m9S3vIg5014573
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 22:57:25 -0500 (CDT)
From: Liu Yu <yu.liu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] math-emu: Remove redundant 'ret'
Date: Tue, 28 Oct 2008 11:50:20 +0800
Message-Id: <1225165821-15998-4-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1225165821-15998-3-git-send-email-yu.liu@freescale.com>
References: <1225165821-15998-1-git-send-email-yu.liu@freescale.com>
	<1225165821-15998-2-git-send-email-yu.liu@freescale.com>
	<1225165821-15998-3-git-send-email-yu.liu@freescale.com>
Cc: kumar.gala@freescale.com, Liu Yu <yu.liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FP_DECL_EX is already used, so ret is redundant.
And FP_SET_EXCEPTION will add status into return value.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
 arch/powerpc/math-emu/fadd.c    |    1 -
 arch/powerpc/math-emu/fcmpo.c   |    5 ++---
 arch/powerpc/math-emu/fdiv.c    |    9 ++++-----
 arch/powerpc/math-emu/fdivs.c   |    9 ++++-----
 arch/powerpc/math-emu/fmadd.c   |    5 ++---
 arch/powerpc/math-emu/fmadds.c  |    5 ++---
 arch/powerpc/math-emu/fmsub.c   |    5 ++---
 arch/powerpc/math-emu/fmsubs.c  |    5 ++---
 arch/powerpc/math-emu/fmul.c    |    3 +--
 arch/powerpc/math-emu/fmuls.c   |    3 +--
 arch/powerpc/math-emu/fnmadd.c  |    5 ++---
 arch/powerpc/math-emu/fnmadds.c |    5 ++---
 arch/powerpc/math-emu/fnmsub.c  |    5 ++---
 arch/powerpc/math-emu/fnmsubs.c |    5 ++---
 arch/powerpc/math-emu/fsqrt.c   |    5 ++---
 arch/powerpc/math-emu/fsqrts.c  |    5 ++---
 arch/powerpc/math-emu/fsub.c    |    3 +--
 arch/powerpc/math-emu/fsubs.c   |    3 +--
 18 files changed, 34 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/math-emu/fadd.c b/arch/powerpc/math-emu/fadd.c
index 04d3b4a..0158a16 100644
--- a/arch/powerpc/math-emu/fadd.c
+++ b/arch/powerpc/math-emu/fadd.c
@@ -13,7 +13,6 @@ fadd(void *frD, void *frA, void *frB)
 	FP_DECL_D(B);
 	FP_DECL_D(R);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
diff --git a/arch/powerpc/math-emu/fcmpo.c b/arch/powerpc/math-emu/fcmpo.c
index b5dc449..5bce011 100644
--- a/arch/powerpc/math-emu/fcmpo.c
+++ b/arch/powerpc/math-emu/fcmpo.c
@@ -14,7 +14,6 @@ fcmpo(u32 *ccr, int crfD, void *frA, void *frB)
 	FP_DECL_EX;
 	int code[4] = { (1 << 3), (1 << 1), (1 << 2), (1 << 0) };
 	long cmp;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p (%08x) %d %p %p\n", __func__, ccr, *ccr, crfD, frA, frB);
@@ -29,7 +28,7 @@ fcmpo(u32 *ccr, int crfD, void *frA, void *frB)
 #endif
 
 	if (A_c == FP_CLS_NAN || B_c == FP_CLS_NAN)
-		ret |= EFLAG_VXVC;
+		FP_SET_EXCEPTION(EFLAG_VXVC);
 
 	FP_CMP_D(cmp, A, B, 2);
 	cmp = code[(cmp + 1) & 3];
@@ -44,5 +43,5 @@ fcmpo(u32 *ccr, int crfD, void *frA, void *frB)
 	printk("CR: %08x\n", *ccr);
 #endif
 
-	return ret;
+	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fdiv.c b/arch/powerpc/math-emu/fdiv.c
index 2db1509..a29239c 100644
--- a/arch/powerpc/math-emu/fdiv.c
+++ b/arch/powerpc/math-emu/fdiv.c
@@ -13,7 +13,6 @@ fdiv(void *frD, void *frA, void *frB)
 	FP_DECL_D(B);
 	FP_DECL_D(R);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
@@ -28,22 +27,22 @@ fdiv(void *frD, void *frA, void *frB)
 #endif
 
 	if (A_c == FP_CLS_ZERO && B_c == FP_CLS_ZERO) {
-		ret |= EFLAG_VXZDZ;
+		FP_SET_EXCEPTION(EFLAG_VXZDZ);
 #ifdef DEBUG
 		printk("%s: FPSCR_VXZDZ raised\n", __func__);
 #endif
 	}
 	if (A_c == FP_CLS_INF && B_c == FP_CLS_INF) {
-		ret |= EFLAG_VXIDI;
+		FP_SET_EXCEPTION(EFLAG_VXIDI);
 #ifdef DEBUG
 		printk("%s: FPSCR_VXIDI raised\n", __func__);
 #endif
 	}
 
 	if (B_c == FP_CLS_ZERO && A_c != FP_CLS_ZERO) {
-		ret |= EFLAG_DIVZERO;
+		FP_SET_EXCEPTION(EFLAG_DIVZERO);
 		if (__FPU_TRAP_P(EFLAG_DIVZERO))
-			return ret;
+			return FP_CUR_EXCEPTIONS;
 	}
 	FP_DIV_D(R, A, B);
 
diff --git a/arch/powerpc/math-emu/fdivs.c b/arch/powerpc/math-emu/fdivs.c
index 797f6a9..526bc26 100644
--- a/arch/powerpc/math-emu/fdivs.c
+++ b/arch/powerpc/math-emu/fdivs.c
@@ -14,7 +14,6 @@ fdivs(void *frD, void *frA, void *frB)
 	FP_DECL_D(B);
 	FP_DECL_D(R);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
@@ -29,22 +28,22 @@ fdivs(void *frD, void *frA, void *frB)
 #endif
 
 	if (A_c == FP_CLS_ZERO && B_c == FP_CLS_ZERO) {
-		ret |= EFLAG_VXZDZ;
+		FP_SET_EXCEPTION(EFLAG_VXZDZ);
 #ifdef DEBUG
 		printk("%s: FPSCR_VXZDZ raised\n", __func__);
 #endif
 	}
 	if (A_c == FP_CLS_INF && B_c == FP_CLS_INF) {
-		ret |= EFLAG_VXIDI;
+		FP_SET_EXCEPTION(EFLAG_VXIDI);
 #ifdef DEBUG
 		printk("%s: FPSCR_VXIDI raised\n", __func__);
 #endif
 	}
 
 	if (B_c == FP_CLS_ZERO && A_c != FP_CLS_ZERO) {
-		ret |= EFLAG_DIVZERO;
+		FP_SET_EXCEPTION(EFLAG_DIVZERO);
 		if (__FPU_TRAP_P(EFLAG_DIVZERO))
-			return ret;
+			return FP_CUR_EXCEPTIONS;
 	}
 
 	FP_DIV_D(R, A, B);
diff --git a/arch/powerpc/math-emu/fmadd.c b/arch/powerpc/math-emu/fmadd.c
index 925313a..8c3f20a 100644
--- a/arch/powerpc/math-emu/fmadd.c
+++ b/arch/powerpc/math-emu/fmadd.c
@@ -15,7 +15,6 @@ fmadd(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(C);
 	FP_DECL_D(T);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
@@ -33,12 +32,12 @@ fmadd(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-                ret |= EFLAG_VXIMZ;
+                FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
diff --git a/arch/powerpc/math-emu/fmadds.c b/arch/powerpc/math-emu/fmadds.c
index aea80ef..794fb31 100644
--- a/arch/powerpc/math-emu/fmadds.c
+++ b/arch/powerpc/math-emu/fmadds.c
@@ -16,7 +16,6 @@ fmadds(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(C);
 	FP_DECL_D(T);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
@@ -34,12 +33,12 @@ fmadds(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-                ret |= EFLAG_VXIMZ;
+                FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
diff --git a/arch/powerpc/math-emu/fmsub.c b/arch/powerpc/math-emu/fmsub.c
index a644d52..626f6fe 100644
--- a/arch/powerpc/math-emu/fmsub.c
+++ b/arch/powerpc/math-emu/fmsub.c
@@ -15,7 +15,6 @@ fmsub(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(C);
 	FP_DECL_D(T);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
@@ -33,7 +32,7 @@ fmsub(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-		ret |= EFLAG_VXIMZ;
+		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
@@ -41,7 +40,7 @@ fmsub(void *frD, void *frA, void *frB, void *frC)
 		B_s ^= 1;
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
diff --git a/arch/powerpc/math-emu/fmsubs.c b/arch/powerpc/math-emu/fmsubs.c
index 2fdeeb9..3425bc8 100644
--- a/arch/powerpc/math-emu/fmsubs.c
+++ b/arch/powerpc/math-emu/fmsubs.c
@@ -16,7 +16,6 @@ fmsubs(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(C);
 	FP_DECL_D(T);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
@@ -34,7 +33,7 @@ fmsubs(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-		ret |= EFLAG_VXIMZ;
+		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
@@ -42,7 +41,7 @@ fmsubs(void *frD, void *frA, void *frB, void *frC)
 		B_s ^= 1;
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
diff --git a/arch/powerpc/math-emu/fmul.c b/arch/powerpc/math-emu/fmul.c
index 391fd17..2c19297 100644
--- a/arch/powerpc/math-emu/fmul.c
+++ b/arch/powerpc/math-emu/fmul.c
@@ -13,7 +13,6 @@ fmul(void *frD, void *frA, void *frB)
 	FP_DECL_D(B);
 	FP_DECL_D(R);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
@@ -31,7 +30,7 @@ fmul(void *frD, void *frA, void *frB)
 
 	if ((A_c == FP_CLS_INF && B_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && B_c == FP_CLS_INF))
-		ret |= EFLAG_VXIMZ;
+		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(R, A, B);
 
diff --git a/arch/powerpc/math-emu/fmuls.c b/arch/powerpc/math-emu/fmuls.c
index 2d3ec5f..f5ad5c9 100644
--- a/arch/powerpc/math-emu/fmuls.c
+++ b/arch/powerpc/math-emu/fmuls.c
@@ -14,7 +14,6 @@ fmuls(void *frD, void *frA, void *frB)
 	FP_DECL_D(B);
 	FP_DECL_D(R);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
@@ -32,7 +31,7 @@ fmuls(void *frD, void *frA, void *frB)
 
 	if ((A_c == FP_CLS_INF && B_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && B_c == FP_CLS_INF))
-		ret |= EFLAG_VXIMZ;
+		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(R, A, B);
 
diff --git a/arch/powerpc/math-emu/fnmadd.c b/arch/powerpc/math-emu/fnmadd.c
index 2497b86..e817bc5 100644
--- a/arch/powerpc/math-emu/fnmadd.c
+++ b/arch/powerpc/math-emu/fnmadd.c
@@ -15,7 +15,6 @@ fnmadd(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(C);
 	FP_DECL_D(T);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
@@ -33,12 +32,12 @@ fnmadd(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-                ret |= EFLAG_VXIMZ;
+                FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
diff --git a/arch/powerpc/math-emu/fnmadds.c b/arch/powerpc/math-emu/fnmadds.c
index ee9d71e..4db4b7d 100644
--- a/arch/powerpc/math-emu/fnmadds.c
+++ b/arch/powerpc/math-emu/fnmadds.c
@@ -16,7 +16,6 @@ fnmadds(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(C);
 	FP_DECL_D(T);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
@@ -34,12 +33,12 @@ fnmadds(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-                ret |= EFLAG_VXIMZ;
+                FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
diff --git a/arch/powerpc/math-emu/fnmsub.c b/arch/powerpc/math-emu/fnmsub.c
index 3885a77..f65979f 100644
--- a/arch/powerpc/math-emu/fnmsub.c
+++ b/arch/powerpc/math-emu/fnmsub.c
@@ -15,7 +15,6 @@ fnmsub(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(C);
 	FP_DECL_D(T);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
@@ -33,7 +32,7 @@ fnmsub(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-		ret |= EFLAG_VXIMZ;
+		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
@@ -41,7 +40,7 @@ fnmsub(void *frD, void *frA, void *frB, void *frC)
 		B_s ^= 1;
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
diff --git a/arch/powerpc/math-emu/fnmsubs.c b/arch/powerpc/math-emu/fnmsubs.c
index f835dfe..9021dac 100644
--- a/arch/powerpc/math-emu/fnmsubs.c
+++ b/arch/powerpc/math-emu/fnmsubs.c
@@ -16,7 +16,6 @@ fnmsubs(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(C);
 	FP_DECL_D(T);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frA, frB, frC);
@@ -34,7 +33,7 @@ fnmsubs(void *frD, void *frA, void *frB, void *frC)
 
 	if ((A_c == FP_CLS_INF && C_c == FP_CLS_ZERO) ||
 	    (A_c == FP_CLS_ZERO && C_c == FP_CLS_INF))
-		ret |= EFLAG_VXIMZ;
+		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
 	FP_MUL_D(T, A, C);
 
@@ -42,7 +41,7 @@ fnmsubs(void *frD, void *frA, void *frB, void *frC)
 		B_s ^= 1;
 
 	if (T_s != B_s && T_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, T, B);
 
diff --git a/arch/powerpc/math-emu/fsqrt.c b/arch/powerpc/math-emu/fsqrt.c
index 3e90072..a55fc7d 100644
--- a/arch/powerpc/math-emu/fsqrt.c
+++ b/arch/powerpc/math-emu/fsqrt.c
@@ -12,7 +12,6 @@ fsqrt(void *frD, void *frB)
 	FP_DECL_D(B);
 	FP_DECL_D(R);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frB);
@@ -25,9 +24,9 @@ fsqrt(void *frD, void *frB)
 #endif
 
 	if (B_s && B_c != FP_CLS_ZERO)
-		ret |= EFLAG_VXSQRT;
+		FP_SET_EXCEPTION(EFLAG_VXSQRT);
 	if (B_c == FP_CLS_NAN)
-		ret |= EFLAG_VXSNAN;
+		FP_SET_EXCEPTION(EFLAG_VXSNAN);
 
 	FP_SQRT_D(R, B);
 
diff --git a/arch/powerpc/math-emu/fsqrts.c b/arch/powerpc/math-emu/fsqrts.c
index 2843be9..31dccbf 100644
--- a/arch/powerpc/math-emu/fsqrts.c
+++ b/arch/powerpc/math-emu/fsqrts.c
@@ -13,7 +13,6 @@ fsqrts(void *frD, void *frB)
 	FP_DECL_D(B);
 	FP_DECL_D(R);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p %p\n", __func__, frD, frB);
@@ -26,9 +25,9 @@ fsqrts(void *frD, void *frB)
 #endif
 
 	if (B_s && B_c != FP_CLS_ZERO)
-		ret |= EFLAG_VXSQRT;
+		FP_SET_EXCEPTION(EFLAG_VXSQRT);
 	if (B_c == FP_CLS_NAN)
-		ret |= EFLAG_VXSNAN;
+		FP_SET_EXCEPTION(EFLAG_VXSNAN);
 
 	FP_SQRT_D(R, B);
 
diff --git a/arch/powerpc/math-emu/fsub.c b/arch/powerpc/math-emu/fsub.c
index 78b0944..02c5dff 100644
--- a/arch/powerpc/math-emu/fsub.c
+++ b/arch/powerpc/math-emu/fsub.c
@@ -13,7 +13,6 @@ fsub(void *frD, void *frA, void *frB)
 	FP_DECL_D(B);
 	FP_DECL_D(R);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
@@ -31,7 +30,7 @@ fsub(void *frD, void *frA, void *frB)
 		B_s ^= 1;
 
 	if (A_s != B_s && A_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, A, B);
 
diff --git a/arch/powerpc/math-emu/fsubs.c b/arch/powerpc/math-emu/fsubs.c
index d3bf908..5d9b18c 100644
--- a/arch/powerpc/math-emu/fsubs.c
+++ b/arch/powerpc/math-emu/fsubs.c
@@ -14,7 +14,6 @@ fsubs(void *frD, void *frA, void *frB)
 	FP_DECL_D(B);
 	FP_DECL_D(R);
 	FP_DECL_EX;
-	int ret = 0;
 
 #ifdef DEBUG
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
@@ -32,7 +31,7 @@ fsubs(void *frD, void *frA, void *frB)
 		B_s ^= 1;
 
 	if (A_s != B_s && A_c == FP_CLS_INF && B_c == FP_CLS_INF)
-		ret |= EFLAG_VXISI;
+		FP_SET_EXCEPTION(EFLAG_VXISI);
 
 	FP_ADD_D(R, A, B);
 
-- 
1.5.4

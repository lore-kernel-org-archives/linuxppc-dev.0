Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id DA8AAB6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Aug 2010 08:48:46 +1000 (EST)
Date: Sun, 22 Aug 2010 18:48:44 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: mtmsrd not defined
Message-ID: <20100822184844.37c30d5e@lappy.seanm.ca>
In-Reply-To: <1282516494.22370.440.camel@pasglop>
References: <20100822180958.6305f5b1@lappy.seanm.ca>
	<1282516494.22370.440.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 23 Aug 2010 08:34:54 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> I'd rather have a macro somewhere in ppc_asm.h (MTMSR ?) that does the
> right thing. We might even already have one...

We do.... here is a new, improved patch.

Replace the BOOK3S_64 specific mtmsrd with the generic MTMSRD macro.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/lib/ldstfp.S b/arch/powerpc/lib/ldstfp.S
index f644863..ce818a5 100644
--- a/arch/powerpc/lib/ldstfp.S
+++ b/arch/powerpc/lib/ldstfp.S
@@ -81,7 +81,7 @@ _GLOBAL(do_lfs)
 	mfmsr	r6
 	ori	r7,r6,MSR_FP
 	cmpwi	cr7,r3,0
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	stfd	fr0,STKFRM-16(r1)
@@ -93,7 +93,7 @@ _GLOBAL(do_lfs)
 	lfd	fr0,STKFRM-16(r1)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -108,7 +108,7 @@ _GLOBAL(do_lfd)
 	mfmsr	r6
 	ori	r7,r6,MSR_FP
 	cmpwi	cr7,r3,0
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	stfd	fr0,STKFRM-16(r1)
@@ -120,7 +120,7 @@ _GLOBAL(do_lfd)
 	lfd	fr0,STKFRM-16(r1)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -135,7 +135,7 @@ _GLOBAL(do_stfs)
 	mfmsr	r6
 	ori	r7,r6,MSR_FP
 	cmpwi	cr7,r3,0
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	stfd	fr0,STKFRM-16(r1)
@@ -147,7 +147,7 @@ _GLOBAL(do_stfs)
 	lfd	fr0,STKFRM-16(r1)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -162,7 +162,7 @@ _GLOBAL(do_stfd)
 	mfmsr	r6
 	ori	r7,r6,MSR_FP
 	cmpwi	cr7,r3,0
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	stfd	fr0,STKFRM-16(r1)
@@ -174,7 +174,7 @@ _GLOBAL(do_stfd)
 	lfd	fr0,STKFRM-16(r1)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -229,7 +229,7 @@ _GLOBAL(do_lvx)
 	oris	r7,r6,MSR_VEC@h
 	cmpwi	cr7,r3,0
 	li	r8,STKFRM-16
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	stvx	vr0,r1,r8
@@ -241,7 +241,7 @@ _GLOBAL(do_lvx)
 	lvx	vr0,r1,r8
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -257,7 +257,7 @@ _GLOBAL(do_stvx)
 	oris	r7,r6,MSR_VEC@h
 	cmpwi	cr7,r3,0
 	li	r8,STKFRM-16
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	stvx	vr0,r1,r8
@@ -269,7 +269,7 @@ _GLOBAL(do_stvx)
 	lvx	vr0,r1,r8
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -325,7 +325,7 @@ _GLOBAL(do_lxvd2x)
 	oris	r7,r6,MSR_VSX@h
 	cmpwi	cr7,r3,0
 	li	r8,STKFRM-16
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	STXVD2X(0,r1,r8)
@@ -337,7 +337,7 @@ _GLOBAL(do_lxvd2x)
 	LXVD2X(0,r1,r8)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -353,7 +353,7 @@ _GLOBAL(do_stxvd2x)
 	oris	r7,r6,MSR_VSX@h
 	cmpwi	cr7,r3,0
 	li	r8,STKFRM-16
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	STXVD2X(0,r1,r8)
@@ -365,7 +365,7 @@ _GLOBAL(do_stxvd2x)
 	LXVD2X(0,r1,r8)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM



Cheers,
   Sean

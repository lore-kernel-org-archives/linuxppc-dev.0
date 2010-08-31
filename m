Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A596FB7259
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:15:31 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: Linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] PPC: s/mtmsrd/MTMSR in ldstfp.S
Date: Tue, 31 Aug 2010 04:15:20 +0200
Message-Id: <1283220922-20369-2-git-send-email-agraf@suse.de>
In-Reply-To: <1283220922-20369-1-git-send-email-agraf@suse.de>
References: <1283220922-20369-1-git-send-email-agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 0016a4cf introduced a lot of mtmsrd's that were plainly written out.
These failed to compile on my e500v2 system, so let's better use the macro
that is around just for that purpose.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/lib/ldstfp.S |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

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
-- 
1.6.0.2

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1BE9EDDF26
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 08:21:24 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n2GLLLN4003192
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 16:21:21 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 3/4] powerpc/mm: Used free register to save a few cycles in
	SW TLB miss handling
Date: Mon, 16 Mar 2009 16:21:17 -0500
Message-Id: <1237238478-30493-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1237238478-30493-2-git-send-email-galak@kernel.crashing.org>
References: <1237238478-30493-1-git-send-email-galak@kernel.crashing.org>
	<1237238478-30493-2-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that r0 is free we can keep the value of I/DMISS in r3 and not reload
it before doing the tlbli/d.  This saves us a few cycles in the fast path
case.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/head_32.S |   51 +++++++++++++++++++---------------------
 1 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index f37df0c..58dcc7c 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -498,28 +498,27 @@ InstructionTLBMiss:
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
 	beq-	InstructionAddressInvalid	/* return if no mapping */
 	rlwimi	r2,r3,22,20,29		/* insert next 10 bits of address */
-	lwz	r3,0(r2)		/* get linux-style pte */
-	andc.	r1,r1,r3		/* check access & ~permission */
+	lwz	r0,0(r2)		/* get linux-style pte */
+	andc.	r1,r1,r0		/* check access & ~permission */
 	bne-	InstructionAddressInvalid /* return if access not permitted */
-	ori	r3,r3,_PAGE_ACCESSED	/* set _PAGE_ACCESSED in pte */
+	ori	r0,r0,_PAGE_ACCESSED	/* set _PAGE_ACCESSED in pte */
 	/*
 	 * NOTE! We are assuming this is not an SMP system, otherwise
 	 * we would need to update the pte atomically with lwarx/stwcx.
 	 */
-	stw	r3,0(r2)		/* update PTE (accessed bit) */
+	stw	r0,0(r2)		/* update PTE (accessed bit) */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwinm	r1,r3,32-10,31,31	/* _PAGE_RW -> PP lsb */
-	rlwinm	r2,r3,32-7,31,31	/* _PAGE_DIRTY -> PP lsb */
+	rlwinm	r1,r0,32-10,31,31	/* _PAGE_RW -> PP lsb */
+	rlwinm	r2,r0,32-7,31,31	/* _PAGE_DIRTY -> PP lsb */
 	and	r1,r1,r2		/* writable if _RW and _DIRTY */
-	rlwimi	r3,r3,32-1,30,30	/* _PAGE_USER -> PP msb */
-	rlwimi	r3,r3,32-1,31,31	/* _PAGE_USER -> PP lsb */
+	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
+	rlwimi	r0,r0,32-1,31,31	/* _PAGE_USER -> PP lsb */
 	ori	r1,r1,0xe04		/* clear out reserved bits */
-	andc	r1,r3,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
+	andc	r1,r0,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
 BEGIN_FTR_SECTION
 	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
-	mfspr	r3,SPRN_IMISS
 	tlbli	r3
 	mfspr	r3,SPRN_SRR1		/* Need to restore CR0 */
 	mtcrf	0x80,r3
@@ -573,28 +572,27 @@ DataLoadTLBMiss:
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
 	beq-	DataAddressInvalid	/* return if no mapping */
 	rlwimi	r2,r3,22,20,29		/* insert next 10 bits of address */
-	lwz	r3,0(r2)		/* get linux-style pte */
-	andc.	r1,r1,r3		/* check access & ~permission */
+	lwz	r0,0(r2)		/* get linux-style pte */
+	andc.	r1,r1,r0		/* check access & ~permission */
 	bne-	DataAddressInvalid	/* return if access not permitted */
-	ori	r3,r3,_PAGE_ACCESSED	/* set _PAGE_ACCESSED in pte */
+	ori	r0,r0,_PAGE_ACCESSED	/* set _PAGE_ACCESSED in pte */
 	/*
 	 * NOTE! We are assuming this is not an SMP system, otherwise
 	 * we would need to update the pte atomically with lwarx/stwcx.
 	 */
-	stw	r3,0(r2)		/* update PTE (accessed bit) */
+	stw	r0,0(r2)		/* update PTE (accessed bit) */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwinm	r1,r3,32-10,31,31	/* _PAGE_RW -> PP lsb */
-	rlwinm	r2,r3,32-7,31,31	/* _PAGE_DIRTY -> PP lsb */
+	rlwinm	r1,r0,32-10,31,31	/* _PAGE_RW -> PP lsb */
+	rlwinm	r2,r0,32-7,31,31	/* _PAGE_DIRTY -> PP lsb */
 	and	r1,r1,r2		/* writable if _RW and _DIRTY */
-	rlwimi	r3,r3,32-1,30,30	/* _PAGE_USER -> PP msb */
-	rlwimi	r3,r3,32-1,31,31	/* _PAGE_USER -> PP lsb */
+	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
+	rlwimi	r0,r0,32-1,31,31	/* _PAGE_USER -> PP lsb */
 	ori	r1,r1,0xe04		/* clear out reserved bits */
-	andc	r1,r3,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
+	andc	r1,r0,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
 BEGIN_FTR_SECTION
 	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
-	mfspr	r3,SPRN_DMISS
 	tlbld	r3
 	mfspr	r3,SPRN_SRR1		/* Need to restore CR0 */
 	mtcrf	0x80,r3
@@ -646,24 +644,23 @@ DataStoreTLBMiss:
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
 	beq-	DataAddressInvalid	/* return if no mapping */
 	rlwimi	r2,r3,22,20,29		/* insert next 10 bits of address */
-	lwz	r3,0(r2)		/* get linux-style pte */
-	andc.	r1,r1,r3		/* check access & ~permission */
+	lwz	r0,0(r2)		/* get linux-style pte */
+	andc.	r1,r1,r0		/* check access & ~permission */
 	bne-	DataAddressInvalid	/* return if access not permitted */
-	ori	r3,r3,_PAGE_ACCESSED|_PAGE_DIRTY
+	ori	r0,r0,_PAGE_ACCESSED|_PAGE_DIRTY
 	/*
 	 * NOTE! We are assuming this is not an SMP system, otherwise
 	 * we would need to update the pte atomically with lwarx/stwcx.
 	 */
-	stw	r3,0(r2)		/* update PTE (accessed/dirty bits) */
+	stw	r0,0(r2)		/* update PTE (accessed/dirty bits) */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwimi	r3,r3,32-1,30,30	/* _PAGE_USER -> PP msb */
+	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
 	li	r1,0xe05		/* clear out reserved bits & PP lsb */
-	andc	r1,r3,r1		/* PP = user? 2: 0 */
+	andc	r1,r0,r1		/* PP = user? 2: 0 */
 BEGIN_FTR_SECTION
 	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
-	mfspr	r3,SPRN_DMISS
 	tlbld	r3
 	mfspr	r3,SPRN_SRR1		/* Need to restore CR0 */
 	mtcrf	0x80,r3
-- 
1.5.6.6

Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0118.outbound.protection.outlook.com [157.56.110.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06CED1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 14:14:25 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/e6500: Optimize hugepage TLB misses
Date: Thu, 2 Apr 2015 22:14:11 -0500
Message-ID: <1428030851-2233-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some workloads take a lot of TLB misses despite using traditional
hugepages.  Handle these TLB misses in the asm fastpath rather than
going through a bunch of C code.  With this patch I measured around a
5x speedup in handling hugepage TLB misses.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/mm/tlb_low_64e.S | 51 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 89bf95b..765b419 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -398,18 +398,18 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_SMT)
 	rldicl	r15,r16,64-PUD_SHIFT+3,64-PUD_INDEX_SIZE-3
 	clrrdi	r15,r15,3
 	cmpdi	cr0,r14,0
-	bge	tlb_miss_fault_e6500	/* Bad pgd entry or hugepage; bail */
+	bge	tlb_miss_huge_e6500	/* Bad pgd entry or hugepage; bail */
 	ldx	r14,r14,r15		/* grab pud entry */
 
 	rldicl	r15,r16,64-PMD_SHIFT+3,64-PMD_INDEX_SIZE-3
 	clrrdi	r15,r15,3
 	cmpdi	cr0,r14,0
-	bge	tlb_miss_fault_e6500
+	bge	tlb_miss_huge_e6500
 	ldx	r14,r14,r15		/* Grab pmd entry */
 
 	mfspr	r10,SPRN_MAS0
 	cmpdi	cr0,r14,0
-	bge	tlb_miss_fault_e6500
+	bge	tlb_miss_huge_e6500
 
 	/* Now we build the MAS for a 2M indirect page:
 	 *
@@ -428,6 +428,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_SMT)
 	clrrdi	r15,r16,21		/* make EA 2M-aligned */
 	mtspr	SPRN_MAS2,r15
 
+tlb_miss_huge_done_e6500:
 	lbz	r15,TCD_ESEL_NEXT(r11)
 	lbz	r16,TCD_ESEL_MAX(r11)
 	lbz	r14,TCD_ESEL_FIRST(r11)
@@ -456,6 +457,50 @@ END_FTR_SECTION_IFSET(CPU_FTR_SMT)
 	tlb_epilog_bolted
 	rfi
 
+tlb_miss_huge_e6500:
+	beq	tlb_miss_fault_e6500
+	li	r10,1
+	andi.	r15,r14,HUGEPD_SHIFT_MASK@l /* r15 = psize */
+	rldimi	r14,r10,63,0		/* Set PD_HUGE */
+	xor	r14,r14,r15		/* Clear size bits */
+	ldx	r14,0,r14
+
+	/*
+	 * Now we build the MAS for a huge page.
+	 *
+	 * MAS 0   :	ESEL needs to be filled by software round-robin
+	 *		 - can be handled by indirect code
+	 * MAS 1   :	Need to clear IND and set TSIZE
+	 * MAS 2,3+7:	Needs to be redone similar to non-tablewalk handler
+	 */
+
+	subi	r15,r15,10		/* Convert psize to tsize */
+	mfspr	r10,SPRN_MAS1
+	rlwinm	r10,r10,0,~MAS1_IND
+	rlwimi	r10,r15,MAS1_TSIZE_SHIFT,MAS1_TSIZE_MASK
+	mtspr	SPRN_MAS1,r10
+
+	li	r10,-0x400
+	sld	r15,r10,r15		/* Generate mask based on size */
+	and	r10,r16,r15
+	rldicr	r15,r14,64-(PTE_RPN_SHIFT-PAGE_SHIFT),63-PAGE_SHIFT
+	rlwimi	r10,r14,32-19,27,31	/* Insert WIMGE */
+	clrldi	r15,r15,PAGE_SHIFT	/* Clear crap at the top */
+	rlwimi	r15,r14,32-8,22,25	/* Move in U bits */
+	mtspr	SPRN_MAS2,r10
+	andi.	r10,r14,_PAGE_DIRTY
+	rlwimi	r15,r14,32-2,26,31	/* Move in BAP bits */
+
+	/* Mask out SW and UW if !DIRTY (XXX optimize this !) */
+	bne	1f
+	li	r10,MAS3_SW|MAS3_UW
+	andc	r15,r15,r10
+1:
+	mtspr	SPRN_MAS7_MAS3,r15
+
+	mfspr	r10,SPRN_MAS0
+	b	tlb_miss_huge_done_e6500
+
 tlb_miss_kernel_e6500:
 	ld	r14,PACA_KERNELPGD(r13)
 	cmpldi	cr1,r15,8		/* Check for vmalloc region */
-- 
2.1.0

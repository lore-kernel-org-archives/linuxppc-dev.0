Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6430FB7204
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 07:51:23 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/13] powerpc: Whitespace/comment changes to tlb_low_64e.S
Date: Mon, 10 Oct 2011 15:50:41 -0500
Message-Id: <13182798761457-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <13182798731357-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
 <13182798681100-git-send-email-beckyb@kernel.crashing.org>
 <1318279870278-git-send-email-beckyb@kernel.crashing.org>
 <13182798731357-git-send-email-beckyb@kernel.crashing.org>
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

I happened to comment this code while I was digging through it;
we might as well commit that.  I also made some whitespace
changes - the existing code had a lot of unnecessary newlines
that I found annoying when I was working on my tiny laptop.

No functional changes.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/mm/tlb_low_64e.S |   28 +++++++++++-----------------
 1 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index dc4a5f3..71d5d9a 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -94,11 +94,11 @@
 
 	srdi	r15,r16,60		/* get region */
 	rldicl.	r10,r16,64-PGTABLE_EADDR_SIZE,PGTABLE_EADDR_SIZE+4
-	bne-	dtlb_miss_fault_bolted
+	bne-	dtlb_miss_fault_bolted	/* Bail if fault addr is invalid */
 
 	rlwinm	r10,r11,32-19,27,27
 	rlwimi	r10,r11,32-16,19,19
-	cmpwi	r15,0
+	cmpwi	r15,0			/* user vs kernel check */
 	ori	r10,r10,_PAGE_PRESENT
 	oris	r11,r10,_PAGE_ACCESSED@h
 
@@ -120,44 +120,38 @@ tlb_miss_common_bolted:
 	rldicl	r15,r16,64-PGDIR_SHIFT+3,64-PGD_INDEX_SIZE-3
 	cmpldi	cr0,r14,0
 	clrrdi	r15,r15,3
-	beq	tlb_miss_fault_bolted
+	beq	tlb_miss_fault_bolted	/* No PGDIR, bail */
 
 BEGIN_MMU_FTR_SECTION
 	/* Set the TLB reservation and search for existing entry. Then load
 	 * the entry.
 	 */
 	PPC_TLBSRX_DOT(0,r16)
-	ldx	r14,r14,r15
-	beq	normal_tlb_miss_done
+	ldx	r14,r14,r15		/* grab pgd entry */
+	beq	normal_tlb_miss_done	/* tlb exists already, bail */
 MMU_FTR_SECTION_ELSE
-	ldx	r14,r14,r15
+	ldx	r14,r14,r15		/* grab pgd entry */
 ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
 
 #ifndef CONFIG_PPC_64K_PAGES
 	rldicl	r15,r16,64-PUD_SHIFT+3,64-PUD_INDEX_SIZE-3
 	clrrdi	r15,r15,3
-
-	cmpldi	cr0,r14,0
-	beq	tlb_miss_fault_bolted
-
-	ldx	r14,r14,r15
+	cmlpdi	cr0,r14,0
+	beq	tlb_miss_fault_bolted	/* Bad pgd entry */
+	ldx	r14,r14,r15		/* grab pud entry */
 #endif /* CONFIG_PPC_64K_PAGES */
 
 	rldicl	r15,r16,64-PMD_SHIFT+3,64-PMD_INDEX_SIZE-3
 	clrrdi	r15,r15,3
-
 	cmpldi	cr0,r14,0
 	beq	tlb_miss_fault_bolted
-
-	ldx	r14,r14,r15
+	ldx	r14,r14,r15		/* Grab pmd entry */
 
 	rldicl	r15,r16,64-PAGE_SHIFT+3,64-PTE_INDEX_SIZE-3
 	clrrdi	r15,r15,3
-
 	cmpldi	cr0,r14,0
 	beq	tlb_miss_fault_bolted
-
-	ldx	r14,r14,r15
+	ldx	r14,r14,r15		/* Grab PTE */
 
 	/* Check if required permissions are met */
 	andc.	r15,r11,r14
-- 
1.5.6.5

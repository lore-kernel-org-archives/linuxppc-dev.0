Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DDBCEB7400
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 07:51:27 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/13] powerpc: Add hugepage support to 64-bit tablewalk code
 for FSL_BOOK3E
Date: Mon, 10 Oct 2011 15:50:42 -0500
Message-Id: <13182798791090-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <13182798761457-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
 <13182798681100-git-send-email-beckyb@kernel.crashing.org>
 <1318279870278-git-send-email-beckyb@kernel.crashing.org>
 <13182798731357-git-send-email-beckyb@kernel.crashing.org>
 <13182798761457-git-send-email-beckyb@kernel.crashing.org>
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

Before hugetlb, at each level of the table, we test for
!0 to determine if we have a valid table entry.  With hugetlb, this
compare becomes:
        < 0 is a normal entry
        0 is an invalid entry
        > 0 is huge

This works because the hugepage code pulls the top bit off the entry
(which for non-huge entries always has the top bit set) as an
indicator that we have a hugepage.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/mm/tlb_low_64e.S |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 71d5d9a..ff672bd 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -136,22 +136,22 @@ ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
 #ifndef CONFIG_PPC_64K_PAGES
 	rldicl	r15,r16,64-PUD_SHIFT+3,64-PUD_INDEX_SIZE-3
 	clrrdi	r15,r15,3
-	cmlpdi	cr0,r14,0
-	beq	tlb_miss_fault_bolted	/* Bad pgd entry */
+	cmpdi	cr0,r14,0
+	bge	tlb_miss_fault_bolted	/* Bad pgd entry or hugepage; bail */
 	ldx	r14,r14,r15		/* grab pud entry */
 #endif /* CONFIG_PPC_64K_PAGES */
 
 	rldicl	r15,r16,64-PMD_SHIFT+3,64-PMD_INDEX_SIZE-3
 	clrrdi	r15,r15,3
-	cmpldi	cr0,r14,0
-	beq	tlb_miss_fault_bolted
+	cmpdi	cr0,r14,0
+	bge	tlb_miss_fault_bolted
 	ldx	r14,r14,r15		/* Grab pmd entry */
 
 	rldicl	r15,r16,64-PAGE_SHIFT+3,64-PTE_INDEX_SIZE-3
 	clrrdi	r15,r15,3
-	cmpldi	cr0,r14,0
-	beq	tlb_miss_fault_bolted
-	ldx	r14,r14,r15		/* Grab PTE */
+	cmpdi	cr0,r14,0
+	bge	tlb_miss_fault_bolted
+	ldx	r14,r14,r15		/* Grab PTE, normal (!huge) page */
 
 	/* Check if required permissions are met */
 	andc.	r15,r11,r14
-- 
1.5.6.5

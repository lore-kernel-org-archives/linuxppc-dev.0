Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0108.outbound.protection.outlook.com [157.56.110.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BCD51A03C8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2015 10:45:20 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/hugetlb: Call mm_dec_nr_pmds() in
 hugetlb_free_pmd_range()
Date: Fri, 10 Apr 2015 19:45:05 -0500
Message-ID: <1428713105-11796-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit dc6c9a35b66b5 ("mm: account pmd page tables to the process")
added a counter that is incremented whenever a PMD is allocated and
decremented whenever a PMD is freed.  For hugepages on PPC, common code
is used to allocated PMDs, but arch-specific code is used to free PMDs.

This results in kernel output such as "BUG: non-zero nr_pmds on freeing
mm: 1" when using hugepages.

Update the PPC hugepage PMD freeing code to decrement the count, just
as the above commit did for free_pmd_range().

Fixes: dc6c9a35b66b5 ("mm: account pmd page tables to the process")
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Should we also be touching nr_ptes when we alloc/free hugepage PTEs?

 arch/powerpc/mm/hugetlbpage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 7e408bf..cecbe00 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -581,6 +581,7 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	pmd = pmd_offset(pud, start);
 	pud_clear(pud);
 	pmd_free_tlb(tlb, pmd, start);
+	mm_dec_nr_pmds(tlb->mm);
 }
 
 static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
-- 
2.1.0

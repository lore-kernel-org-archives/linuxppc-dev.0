Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2ZC44lMlzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 03:42:56 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a188so658807pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 10:42:56 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: arbab@linux.vnet.ibm.com, bsingharora@gmail.com, linux-nvdimm@lists.01.org,
 Oliver O'Halloran <oohall@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-mm@kvack.org
Subject: [PATCH 1/9] mm/huge_memory: Use zap_deposited_table() more
Date: Wed, 12 Apr 2017 03:42:25 +1000
Message-Id: <20170411174233.21902-2-oohall@gmail.com>
In-Reply-To: <20170411174233.21902-1-oohall@gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Depending flags of the PMD being zapped there may or may not be a
deposited pgtable to be freed. In two of the three cases this is open
coded while the third uses the zap_deposited_table() helper. This patch
converts the others to use the helper to clean things up a bit.

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-mm@kvack.org
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
For reference:

void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
{
        pgtable_t pgtable;

        pgtable = pgtable_trans_huge_withdraw(mm, pmd);
        pte_free(mm, pgtable);
        atomic_long_dec(&mm->nr_ptes);
}
---
 mm/huge_memory.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b787c4cfda0e..aa01dd47cc65 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1615,8 +1615,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		if (is_huge_zero_pmd(orig_pmd))
 			tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
-		pte_free(tlb->mm, pgtable_trans_huge_withdraw(tlb->mm, pmd));
-		atomic_long_dec(&tlb->mm->nr_ptes);
+		zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 		tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
 	} else {
@@ -1625,10 +1624,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
 		VM_BUG_ON_PAGE(!PageHead(page), page);
 		if (PageAnon(page)) {
-			pgtable_t pgtable;
-			pgtable = pgtable_trans_huge_withdraw(tlb->mm, pmd);
-			pte_free(tlb->mm, pgtable);
-			atomic_long_dec(&tlb->mm->nr_ptes);
+			zap_deposited_table(tlb->mm, pmd);
 			add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PMD_NR);
 		} else {
 			if (arch_needs_pgtable_deposit())
-- 
2.9.3

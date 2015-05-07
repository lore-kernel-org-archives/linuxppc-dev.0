Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3517E1A058C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 23:42:10 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 7 May 2015 23:42:08 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 584A12BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 23:42:01 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t47DfrBo15728670
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 23:42:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t47DfSaK002338
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 23:41:28 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 david@gibson.dropbear.id.au
Subject: [PATCH V2] powerpc/mm: Return NULL for not present hugetlb page
Date: Thu,  7 May 2015 19:11:00 +0530
Message-Id: <1431006060-5193-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to check whether pte is present in follow_huge_addr and
properly return NULL if mapping is not present. Also use READ_ONCE
when dereferencing pte_t address.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V1:
--------------
* Fix build failures with some platform configs.
  involves pmd_trans_huge(__pmd(pte_val(pte)))

 arch/powerpc/mm/hugetlbpage.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 0ce968b00b7c..3385e3d0506e 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -689,27 +689,34 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 struct page *
 follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 {
-	pte_t *ptep;
-	struct page *page;
+	pte_t *ptep, pte;
 	unsigned shift;
 	unsigned long mask, flags;
+	struct page *page = ERR_PTR(-EINVAL);
+
+	local_irq_save(flags);
+	ptep = find_linux_pte_or_hugepte(mm->pgd, address, &shift);
+	if (!ptep)
+		goto no_page;
+	pte = READ_ONCE(*ptep);
 	/*
+	 * Verify it is a huge page else bail.
 	 * Transparent hugepages are handled by generic code. We can skip them
 	 * here.
 	 */
-	local_irq_save(flags);
-	ptep = find_linux_pte_or_hugepte(mm->pgd, address, &shift);
+	if (!shift || pmd_trans_huge(__pmd(pte_val(pte))))
+		goto no_page;
 
-	/* Verify it is a huge page else bail. */
-	if (!ptep || !shift || pmd_trans_huge(*(pmd_t *)ptep)) {
-		local_irq_restore(flags);
-		return ERR_PTR(-EINVAL);
+	if (!pte_present(pte)) {
+		page = NULL;
+		goto no_page;
 	}
 	mask = (1UL << shift) - 1;
-	page = pte_page(*ptep);
+	page = pte_page(pte);
 	if (page)
 		page += (address & mask) / PAGE_SIZE;
 
+no_page:
 	local_irq_restore(flags);
 	return page;
 }
-- 
2.1.4

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 882D31A0B86
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 16:28:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 11 May 2015 11:58:38 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E9C58E0056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 12:01:31 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4B6SZx554853876
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 11:58:35 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4B6SYhW013080
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 11:58:35 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V3] powerpc/mm: Return NULL for not present hugetlb page
Date: Mon, 11 May 2015 11:58:29 +0530
Message-Id: <1431325709-21852-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Without this patch, we may wrongly return a zero pfn page in follow_huge_addr.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V2:
* Add Reviewed-by
* Update commit message.

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

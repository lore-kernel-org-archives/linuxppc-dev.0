Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GPsC4WvDzF3ND
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 04:10:07 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8KI9Ivc050562
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:10:05 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mmegx5pwa-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:10:04 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 20 Sep 2018 14:10:03 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V3 3/6] powerpc/mm/book3s: Check for pmd_large instead of
 pmd_trans_huge
Date: Thu, 20 Sep 2018 23:39:44 +0530
In-Reply-To: <20180920180947.17893-1-aneesh.kumar@linux.ibm.com>
References: <20180920180947.17893-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180920180947.17893-3-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update few code paths to check for pmd_large.

set_pmd_at:
We want to use this to store swap pte at pmd level. For swap ptes we don't want
to set H_PAGE_THP_HUGE. Hence check for pmd_large in set_pmd_at. This remove
the false WARN_ON when using this with swap pmd entry.

pmd_page:
We don't really use them on pmd migration entries. But they can also work with
migration entries and we don't differentiate at the pte level. Hence update
pmd_page to work with pmd migration entries too

__find_linux_pte:
lockless page table walk need to handle pmd migration entries. pmd_trans_huge
check will return false on them. We don't set thp = 1 for such entries, but
update hpage_shift correctly. Without this we will walk pmd migration entries
as a pte page pointer which is wrong.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c      | 8 ++++++--
 arch/powerpc/mm/pgtable-book3s64.c | 2 +-
 arch/powerpc/mm/pgtable_64.c       | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index c6df73c66c40..9504641bd4d9 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -837,8 +837,12 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 				ret_pte = (pte_t *) pmdp;
 				goto out;
 			}
-
-			if (pmd_huge(pmd)) {
+			/*
+			 * pmd_large check below will handle the swap pmd pte
+			 * we need to do both the check because they are config
+			 * dependent.
+			 */
+			if (pmd_huge(pmd) || pmd_large(pmd)) {
 				ret_pte = (pte_t *) pmdp;
 				goto out;
 			} else if (is_hugepd(__hugepd(pmd_val(pmd))))
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 654000da8b15..43e99e1d947b 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -75,7 +75,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	 */
 	WARN_ON(pte_val(pmd_pte(*pmdp)) & _PAGE_PRESENT);
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
-	WARN_ON(!(pmd_trans_huge(pmd) || pmd_devmap(pmd)));
+	WARN_ON(!(pmd_large(pmd) || pmd_devmap(pmd)));
 #endif
 	trace_hugepage_set_pmd(addr, pmd_val(pmd));
 	return set_pte_at(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 53e9eeecd5d4..e15e63079ba8 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -306,7 +306,7 @@ struct page *pud_page(pud_t pud)
  */
 struct page *pmd_page(pmd_t pmd)
 {
-	if (pmd_trans_huge(pmd) || pmd_huge(pmd) || pmd_devmap(pmd))
+	if (pmd_large(pmd) || pmd_huge(pmd) || pmd_devmap(pmd))
 		return pte_page(pmd_pte(pmd));
 	return virt_to_page(pmd_page_vaddr(pmd));
 }
-- 
2.17.1

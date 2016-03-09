Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C9E31A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:11:57 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 22:11:56 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9B27F3578057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:11:43 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u29CBZ5G28246158
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 23:11:43 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u29CBAmV021321
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 23:11:11 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net,
 aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [RFC 1/9] mm/hugetlb: Make GENERAL_HUGETLB functions PGD
 implementation aware
Date: Wed,  9 Mar 2016 17:40:42 +0530
Message-Id: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently both the ARCH_WANT_GENERAL_HUGETLB functions 'huge_pte_alloc'
and 'huge_pte_offset' dont take into account huge page implementation
at the PGD level. With addition of PGD awareness into these functions,
more architectures like POWER which also implements huge pages at PGD
level (along with PMD level), can use ARCH_WANT_GENERAL_HUGETLB option.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 mm/hugetlb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 01f2b48..a478b7b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4251,6 +4251,11 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, addr);
+	if (sz == PGDIR_SIZE) {
+		pte = (pte_t *)pgd;
+		goto huge_pgd;
+	}
+
 	pud = pud_alloc(mm, pgd, addr);
 	if (pud) {
 		if (sz == PUD_SIZE) {
@@ -4263,6 +4268,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
 		}
 	}
+
+huge_pgd:
 	BUG_ON(pte && !pte_none(*pte) && !pte_huge(*pte));
 
 	return pte;
@@ -4276,6 +4283,8 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 
 	pgd = pgd_offset(mm, addr);
 	if (pgd_present(*pgd)) {
+		if (pgd_huge(*pgd))
+			return (pte_t *)pgd;
 		pud = pud_offset(pgd, addr);
 		if (pud_present(*pud)) {
 			if (pud_huge(*pud))
-- 
2.1.0

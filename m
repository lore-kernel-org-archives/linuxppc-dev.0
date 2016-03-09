Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8EC4F1A004B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:11:57 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 22:11:56 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9108F357805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:11:53 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u29CBjCw3473680
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 23:11:53 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u29CBK4R021624
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 23:11:21 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net,
 aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [RFC 5/9] powerpc/mm: Split huge_pte_offset function for BOOK3S 64K
Date: Wed,  9 Mar 2016 17:40:46 +0530
Message-Id: <1457525450-4262-5-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the 'huge_pte_offset' function has only one version for
all the configuations and platforms. This change splits the function
into two versions, one for 64K page size based BOOK3S implementation
and the other one for everything else. This change is also one of the
prerequisites towards enabling GENERAL_HUGETLB implementation for
BOOK3S 64K based huge pages.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index a49c6ae..f834a74 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -53,11 +53,46 @@ static unsigned nr_gpages;
 
 #define hugepd_none(hpd)	((hpd).pd == 0)
 
+#if !defined(CONFIG_PPC_64K_PAGES) || !defined(CONFIG_PPC_BOOK3S_64)
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	/* Only called for hugetlbfs pages, hence can ignore THP */
 	return __find_linux_pte_or_hugepte(mm->pgd, addr, NULL, NULL);
 }
+#else
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t pgd, *pgdp;
+	pud_t pud, *pudp;
+	pmd_t pmd, *pmdp;
+
+	pgdp = mm->pgd + pgd_index(addr);
+	pgd  = READ_ONCE(*pgdp);
+
+	if (pgd_none(pgd))
+		return NULL;
+
+	if (pgd_huge(pgd))
+		return (pte_t *)pgdp;
+
+	pudp = pud_offset(&pgd, addr);
+	pud  = READ_ONCE(*pudp);
+	if (pud_none(pud))
+		return NULL;
+
+	if (pud_huge(pud))
+		return (pte_t *)pudp;
+
+	pmdp = pmd_offset(&pud, addr);
+	pmd  = READ_ONCE(*pmdp);
+	if (pmd_none(pmd))
+		return NULL;
+
+	if (pmd_huge(pmd))
+		return (pte_t *)pmdp;
+	return NULL;
+}
+#endif /* !defined(CONFIG_PPC_64K_PAGES) || !defined(CONFIG_PPC_BOOK3S_64) */
 
 #if !defined(CONFIG_PPC_64K_PAGES) || !defined(CONFIG_PPC_BOOK3S_64)
 static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
-- 
2.1.0

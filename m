Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CFE41A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:11:55 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 22:11:54 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 39A552CE805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:11:51 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u29CBhog6226208
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 23:11:51 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u29CBH03021501
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 23:11:19 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net,
 aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [RFC 4/9] powerpc/mm: Split huge_pte_alloc function for BOOK3S 64K
Date: Wed,  9 Mar 2016 17:40:45 +0530
Message-Id: <1457525450-4262-4-git-send-email-khandual@linux.vnet.ibm.com>
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

From: root <root@ltcalpine2-lp8.aus.stglabs.ibm.com>

Currently the 'huge_pte_alloc' function has two versions, one for the
BOOK3S and the other one for the BOOK3E platforms. This change splits
the BOOK3S version into two parts, one for the 4K page size based
implementation and the other one for the 64K page sized implementation.
This change is one of the prerequisites towards enabling GENERAL_HUGETLB
implementation for BOOK3S 64K based huge pages.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 67 +++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 744e24b..a49c6ae 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -59,6 +59,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 	return __find_linux_pte_or_hugepte(mm->pgd, addr, NULL, NULL);
 }
 
+#if !defined(CONFIG_PPC_64K_PAGES) || !defined(CONFIG_PPC_BOOK3S_64)
 static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 			   unsigned long address, unsigned pdshift, unsigned pshift)
 {
@@ -117,6 +118,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
+#endif /* !defined(CONFIG_PPC_64K_PAGES) || !defined(CONFIG_PPC_BOOK3S_64) */
 
 /*
  * These macros define how to determine which level of the page table holds
@@ -131,6 +133,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_4K_PAGES
 /*
  * At this point we do the placement change only for BOOK3S 64. This would
  * possibly work on other subarchs.
@@ -146,32 +149,23 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 
 	addr &= ~(sz-1);
 	pg = pgd_offset(mm, addr);
-
-	if (pshift == PGDIR_SHIFT)
-		/* 16GB huge page */
-		return (pte_t *) pg;
-	else if (pshift > PUD_SHIFT)
-		/*
-		 * We need to use hugepd table
-		 */
+	if (pshift > PUD_SHIFT) {
 		hpdp = (hugepd_t *)pg;
-	else {
-		pdshift = PUD_SHIFT;
-		pu = pud_alloc(mm, pg, addr);
-		if (pshift == PUD_SHIFT)
-			return (pte_t *)pu;
-		else if (pshift > PMD_SHIFT)
-			hpdp = (hugepd_t *)pu;
-		else {
-			pdshift = PMD_SHIFT;
-			pm = pmd_alloc(mm, pu, addr);
-			if (pshift == PMD_SHIFT)
-				/* 16MB hugepage */
-				return (pte_t *)pm;
-			else
-				hpdp = (hugepd_t *)pm;
-		}
+		goto hugepd_search;
+	}
+
+	pdshift = PUD_SHIFT;
+	pu = pud_alloc(mm, pg, addr);
+	if (pshift > PMD_SHIFT) {
+		hpdp = (hugepd_t *)pu;
+		goto hugepd_search;
 	}
+
+	pdshift = PMD_SHIFT;
+	pm = pmd_alloc(mm, pu, addr);
+	hpdp = (hugepd_t *)pm;
+
+hugepd_search:
 	if (!hpdp)
 		return NULL;
 
@@ -184,6 +178,31 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 }
 
 #else
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
+{
+	pgd_t *pg;
+	pud_t *pu;
+	pmd_t *pm;
+	unsigned pshift = __ffs(sz);
+
+	addr &= ~(sz-1);
+	pg = pgd_offset(mm, addr);
+
+	if (pshift == PGDIR_SHIFT)	/* 16GB Huge Page */
+		return (pte_t *)pg;
+
+	pu = pud_alloc(mm, pg, addr);	/* NA, skipped */
+	if (pshift == PUD_SHIFT)
+		return (pte_t *)pu;
+
+	pm = pmd_alloc(mm, pu, addr);	/* 16MB Huge Page */
+	if (pshift == PMD_SHIFT)
+		return (pte_t *)pm;
+
+	return NULL;
+}
+#endif
+#else
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
 {
-- 
2.1.0

Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C9971A0312
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:12:03 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 22:12:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D0B222BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:11:59 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u29CBptG13435350
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 23:11:59 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u29CBPub021915
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 23:11:27 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net,
 aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [RFC 7/9] powerpc/hugetlb: Change follow_huge_* routines for BOOK3S
 64K
Date: Wed,  9 Mar 2016 17:40:48 +0530
Message-Id: <1457525450-4262-7-git-send-email-khandual@linux.vnet.ibm.com>
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

With this change, BOOK3S 64K platforms will not use 'follow_huge_addr'
function any more and always return ERR_PTR(-ENIVAL), hence skipping
the BUG_ON(flags & FOLL_GET) test in 'follow_page_mask' function. These
platforms will then fall back on generic follow_huge_* functions for
everything else. While being here, also added 'follow_huge_pgd' function
which was missing earlier.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index f6e4712..89b748a 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -631,6 +631,10 @@ follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 	unsigned long mask, flags;
 	struct page *page = ERR_PTR(-EINVAL);
 
+#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_BOOK3S_64)
+	return ERR_PTR(-EINVAL);
+#endif
+
 	local_irq_save(flags);
 	ptep = find_linux_pte_or_hugepte(mm->pgd, address, &is_thp, &shift);
 	if (!ptep)
@@ -658,6 +662,7 @@ no_page:
 	return page;
 }
 
+#if !defined(CONFIG_PPC_64K_PAGES) || !defined(CONFIG_PPC_BOOK3S_64)
 struct page *
 follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 		pmd_t *pmd, int write)
@@ -674,6 +679,15 @@ follow_huge_pud(struct mm_struct *mm, unsigned long address,
 	return NULL;
 }
 
+struct page *
+follow_huge_pgd(struct mm_struct *mm, unsigned long address,
+		pgd_t *pgd, int write)
+{
+	BUG();
+	return NULL;
+}
+#endif /* !defined(CONFIG_PPC_64K_PAGE) || !defined(CONFIG_BOOK3S_64) */
+
 static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 				      unsigned long sz)
 {
-- 
2.1.0

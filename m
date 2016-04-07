Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgWpd3Q8yzDqWP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 15:48:09 +1000 (AEST)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 7 Apr 2016 11:08:03 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u375cHo433488946
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 11:08:17 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u375bprD006249
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 11:07:58 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net,
 dave.hansen@intel.com, aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH 07/10] powerpc/hugetlb: Prepare arch functions for
 ARCH_WANT_GENERAL_HUGETLB
Date: Thu,  7 Apr 2016 11:07:41 +0530
Message-Id: <1460007464-26726-8-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1460007464-26726-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1460007464-26726-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arch override function 'follow_huge_addr' is called from 'follow_page_mask'
looking out for the associated page struct. Right now, it does not support
the FOLL_GET option.

With ARCH_WANTS_GENERAL_HUGETLB, we will need function 'follow_page_mask'
to use generic 'follow_huge_*' functions instead of the arch overrides. So,
here it modifies 'follow_huge_addr' function to return ERR_PTR(-EINVAL)
when ARCH_WANT_GENERAL_HUGETLB option is enabled. This also hides away all
the arch specific 'follow_huge_*' overrides allowing it to fall back on the
generic 'follow_huge_*' functions instead.

While here, this also implements the function 'pte_huge' which is required
by the generic call 'huge_pte_alloc'.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 10 ++++++++++
 arch/powerpc/mm/hugetlbpage.c                 | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 0a7956a..3b6dff4 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -146,6 +146,16 @@ extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
  * Defined in such a way that we can optimize away code block at build time
  * if CONFIG_HUGETLB_PAGE=n.
  */
+#ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
+static inline int pte_huge(pte_t pte)
+{
+	/*
+	 * leaf pte for huge page
+	 */
+	return !!(pte_val(pte) & _PAGE_PTE);
+}
+#endif
+
 static inline int pmd_huge(pmd_t pmd)
 {
 	/*
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 8fc6d23..4f44c62 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -690,6 +690,10 @@ follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 	unsigned long mask, flags;
 	struct page *page = ERR_PTR(-EINVAL);
 
+#ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
+	return ERR_PTR(-EINVAL);
+#endif
+
 	local_irq_save(flags);
 	ptep = find_linux_pte_or_hugepte(mm->pgd, address, &is_thp, &shift);
 	if (!ptep)
@@ -717,6 +721,7 @@ no_page:
 	return page;
 }
 
+#ifndef CONFIG_ARCH_WANT_GENERAL_HUGETLB
 struct page *
 follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 		pmd_t *pmd, int write)
@@ -733,6 +738,15 @@ follow_huge_pud(struct mm_struct *mm, unsigned long address,
 	return NULL;
 }
 
+struct page *
+follow_huge_pgd(struct mm_struct *mm, unsigned long address,
+		pgd_t *pgd, int write)
+{
+	BUG();
+	return NULL;
+}
+#endif /* !CONFIG_ARCH_WANT_GENERAL_HUGETLB */
+
 static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 				      unsigned long sz)
 {
-- 
2.1.0

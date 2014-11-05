Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DCBB1A0035
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 03:28:47 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 6 Nov 2014 02:28:45 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 262D12BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 03:28:44 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA5GSUZD37224594
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Nov 2014 03:28:39 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA5GSAvx004028
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Nov 2014 03:28:11 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, Steve Capper <steve.capper@linaro.org>,
 Andrea Arcangeli <aarcange@redhat.com>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, David Miller <davem@davemloft.net>
Subject: [PATCH V5 2/3] mm: Update generic gup implementation to handle
 hugepage directory
Date: Wed,  5 Nov 2014 21:57:40 +0530
Message-Id: <1415204861-22016-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1415204861-22016-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1415204861-22016-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update generic gup implementation with powerpc specific details.
On powerpc at pmd level we can have hugepte, normal pmd pointer
or a pointer to the hugepage directory.

Tested-by: Steve Capper <steve.capper@linaro.org>
Acked-by: Steve Capper <steve.capper@linaro.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V4:
* Add pmd accessor needed for the change to ppc64
* Drop the assumption that we can access pmd using pte_* functions.

 arch/powerpc/include/asm/page.h |  1 +
 include/linux/hugetlb.h         | 46 +++++++++++++++++++++++
 mm/gup.c                        | 81 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 120 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 26fe1ae15212..f973fce73a43 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -380,6 +380,7 @@ static inline int hugepd_ok(hugepd_t hpd)
 #endif
 
 #define is_hugepd(pdep)               (hugepd_ok(*((hugepd_t *)(pdep))))
+#define pgd_huge pgd_huge
 int pgd_huge(pgd_t pgd);
 #else /* CONFIG_HUGETLB_PAGE */
 #define is_hugepd(pdep)			0
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6e6d338641fe..e6b62f30ab21 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -175,6 +175,52 @@ static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
 }
 
 #endif /* !CONFIG_HUGETLB_PAGE */
+/*
+ * hugepages at page global directory. If arch support
+ * hugepages at pgd level, they need to define this.
+ */
+#ifndef pgd_huge
+#define pgd_huge(x)	0
+#endif
+
+#ifndef pgd_write
+static inline int pgd_write(pgd_t pgd)
+{
+	BUG();
+	return 0;
+}
+#endif
+
+#ifndef pud_write
+static inline int pud_write(pud_t pud)
+{
+	BUG();
+	return 0;
+}
+#endif
+
+#ifndef is_hugepd
+/*
+ * Some architectures requires a hugepage directory format that is
+ * required to support multiple hugepage sizes. For example
+ * a4fe3ce76 "powerpc/mm: Allow more flexible layouts for hugepage pagetables"
+ * introduced the same on powerpc. This allows for a more flexible hugepage
+ * pagetable layout.
+ */
+typedef struct { unsigned long pd; } hugepd_t;
+#define is_hugepd(hugepd) (0)
+#define __hugepd(x) ((hugepd_t) { (x) })
+static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
+			      unsigned pdshift, unsigned long end,
+			      int write, struct page **pages, int *nr)
+{
+	return 0;
+}
+#else
+extern int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
+		       unsigned pdshift, unsigned long end,
+		       int write, struct page **pages, int *nr);
+#endif
 
 #define HUGETLB_ANON_FILE "anon_hugepage"
 
diff --git a/mm/gup.c b/mm/gup.c
index cd62c8c90d4a..0ca1df9075ab 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3,7 +3,6 @@
 #include <linux/err.h>
 #include <linux/spinlock.h>
 
-#include <linux/hugetlb.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
@@ -12,6 +11,7 @@
 
 #include <linux/sched.h>
 #include <linux/rwsem.h>
+#include <linux/hugetlb.h>
 #include <asm/pgtable.h>
 
 #include "internal.h"
@@ -875,6 +875,49 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	return 1;
 }
 
+static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
+			unsigned long end, int write,
+			struct page **pages, int *nr)
+{
+	int refs;
+	struct page *head, *page, *tail;
+
+	if (write && !pgd_write(orig))
+		return 0;
+
+	refs = 0;
+	head = pgd_page(orig);
+	page = head + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
+	tail = page;
+	do {
+		VM_BUG_ON_PAGE(compound_head(page) != head, page);
+		pages[*nr] = page;
+		(*nr)++;
+		page++;
+		refs++;
+	} while (addr += PAGE_SIZE, addr != end);
+
+	if (!page_cache_add_speculative(head, refs)) {
+		*nr -= refs;
+		return 0;
+	}
+
+	if (unlikely(pgd_val(orig) != pgd_val(*pgdp))) {
+		*nr -= refs;
+		while (refs--)
+			put_page(head);
+		return 0;
+	}
+
+	while (refs--) {
+		if (PageTail(tail))
+			get_huge_page_tail(tail);
+		tail++;
+	}
+
+	return 1;
+}
+
 static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 		int write, struct page **pages, int *nr)
 {
@@ -902,6 +945,14 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 				pages, nr))
 				return 0;
 
+		} else if (unlikely(is_hugepd(__hugepd(pmd_val(pmd))))) {
+			/*
+			 * architecture have different format for hugetlbfs
+			 * pmd format and THP pmd format
+			 */
+			if (!gup_huge_pd(__hugepd(pmd_val(pmd)), addr,
+					 PMD_SHIFT, next, write, pages, nr))
+				return 0;
 		} else if (!gup_pte_range(pmd, addr, next, write, pages, nr))
 				return 0;
 	} while (pmdp++, addr = next, addr != end);
@@ -909,22 +960,26 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 	return 1;
 }
 
-static int gup_pud_range(pgd_t *pgdp, unsigned long addr, unsigned long end,
-		int write, struct page **pages, int *nr)
+static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
+			 int write, struct page **pages, int *nr)
 {
 	unsigned long next;
 	pud_t *pudp;
 
-	pudp = pud_offset(pgdp, addr);
+	pudp = pud_offset(&pgd, addr);
 	do {
 		pud_t pud = ACCESS_ONCE(*pudp);
 
 		next = pud_addr_end(addr, end);
 		if (pud_none(pud))
 			return 0;
-		if (pud_huge(pud)) {
+		if (unlikely(pud_huge(pud))) {
 			if (!gup_huge_pud(pud, pudp, addr, next, write,
-					pages, nr))
+					  pages, nr))
+				return 0;
+		} else if (unlikely(is_hugepd(__hugepd(pud_val(pud))))) {
+			if (!gup_huge_pd(__hugepd(pud_val(pud)), addr,
+					 PUD_SHIFT, next, write, pages, nr))
 				return 0;
 		} else if (!gup_pmd_range(pud, addr, next, write, pages, nr))
 			return 0;
@@ -970,10 +1025,20 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	local_irq_save(flags);
 	pgdp = pgd_offset(mm, addr);
 	do {
+		pgd_t pgd = ACCESS_ONCE(*pgdp);
+
 		next = pgd_addr_end(addr, end);
-		if (pgd_none(*pgdp))
+		if (pgd_none(pgd))
 			break;
-		else if (!gup_pud_range(pgdp, addr, next, write, pages, &nr))
+		if (unlikely(pgd_huge(pgd))) {
+			if (!gup_huge_pgd(pgd, pgdp, addr, next, write,
+					  pages, &nr))
+				break;
+		} else if (unlikely(is_hugepd(__hugepd(pgd_val(pgd))))) {
+			if (!gup_huge_pd(__hugepd(pgd_val(pgd)), addr,
+					 PGDIR_SHIFT, next, write, pages, &nr))
+				break;
+		} else if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
 			break;
 	} while (pgdp++, addr = next, addr != end);
 	local_irq_restore(flags);
-- 
2.1.0

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E2D72C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 02:14:44 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 12 May 2013 21:40:58 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1B512E004A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 21:47:01 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4CGEUnX5570822
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 21:44:30 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4CGEbe2023458
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 02:14:37 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com
Subject: [PATCH -V8 10/18] powerpc: move find_linux_pte_or_hugepte and
 gup_hugepte to common code
Date: Sun, 12 May 2013 21:44:17 +0530
Message-Id: <1368375265-19593-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1368375265-19593-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1368375265-19593-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We will use this in the later patch for handling THP pages

Reviewed-by: David Gibson <dwg@au1.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hugetlb.h       |   8 +-
 arch/powerpc/include/asm/pgtable-ppc64.h |  13 --
 arch/powerpc/include/asm/pgtable.h       |   2 +
 arch/powerpc/mm/Makefile                 |   2 +-
 arch/powerpc/mm/hugetlbpage.c            | 251 ++++++++++++++++---------------
 5 files changed, 138 insertions(+), 138 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index f2498c8..d750336 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -191,8 +191,14 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
 				      unsigned long vmaddr)
 {
 }
-#endif /* CONFIG_HUGETLB_PAGE */
 
+#define hugepd_shift(x) 0
+static inline pte_t *hugepte_offset(hugepd_t *hpdp, unsigned long addr,
+				    unsigned pdshift)
+{
+	return 0;
+}
+#endif /* CONFIG_HUGETLB_PAGE */
 
 /*
  * FSL Book3E platforms require special gpage handling - the gpages
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index d8642fb..74ce13b 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -367,19 +367,6 @@ static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea)
 	return pt;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE
-pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
-				 unsigned *shift);
-#else
-static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
-					       unsigned *shift)
-{
-	if (shift)
-		*shift = 0;
-	return find_linux_pte(pgdir, ea);
-}
-#endif /* !CONFIG_HUGETLB_PAGE */
-
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index d53db93..959d575 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -224,6 +224,8 @@ extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 #define pmd_large(pmd)		0
 #define has_transparent_hugepage() 0
 #endif
+pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
+				 unsigned *shift);
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index cf16b57..fde36e6 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -28,8 +28,8 @@ obj-$(CONFIG_44x)		+= 44x_mmu.o
 obj-$(CONFIG_PPC_FSL_BOOK3E)	+= fsl_booke_mmu.o
 obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
-ifeq ($(CONFIG_HUGETLB_PAGE),y)
 obj-y				+= hugetlbpage.o
+ifeq ($(CONFIG_HUGETLB_PAGE),y)
 obj-$(CONFIG_PPC_STD_MMU_64)	+= hugetlbpage-hash64.o
 obj-$(CONFIG_PPC_BOOK3E_MMU)	+= hugetlbpage-book3e.o
 endif
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 237c8e5..2865077 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -21,6 +21,9 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/setup.h>
+#include <asm/hugetlb.h>
+
+#ifdef CONFIG_HUGETLB_PAGE
 
 #define PAGE_SHIFT_64K	16
 #define PAGE_SHIFT_16M	24
@@ -100,66 +103,6 @@ int pgd_huge(pgd_t pgd)
 }
 #endif
 
-/*
- * We have 4 cases for pgds and pmds:
- * (1) invalid (all zeroes)
- * (2) pointer to next table, as normal; bottom 6 bits == 0
- * (3) leaf pte for huge page, bottom two bits != 00
- * (4) hugepd pointer, bottom two bits == 00, next 4 bits indicate size of table
- */
-pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift)
-{
-	pgd_t *pg;
-	pud_t *pu;
-	pmd_t *pm;
-	pte_t *ret_pte;
-	hugepd_t *hpdp = NULL;
-	unsigned pdshift = PGDIR_SHIFT;
-
-	if (shift)
-		*shift = 0;
-
-	pg = pgdir + pgd_index(ea);
-
-	if (pgd_huge(*pg)) {
-		ret_pte = (pte_t *) pg;
-		goto out;
-	} else if (is_hugepd(pg))
-		hpdp = (hugepd_t *)pg;
-	else if (!pgd_none(*pg)) {
-		pdshift = PUD_SHIFT;
-		pu = pud_offset(pg, ea);
-
-		if (pud_huge(*pu)) {
-			ret_pte = (pte_t *) pu;
-			goto out;
-		} else if (is_hugepd(pu))
-			hpdp = (hugepd_t *)pu;
-		else if (!pud_none(*pu)) {
-			pdshift = PMD_SHIFT;
-			pm = pmd_offset(pu, ea);
-
-			if (pmd_huge(*pm)) {
-				ret_pte = (pte_t *) pm;
-				goto out;
-			} else if (is_hugepd(pm))
-				hpdp = (hugepd_t *)pm;
-			else if (!pmd_none(*pm))
-				return pte_offset_kernel(pm, ea);
-		}
-	}
-	if (!hpdp)
-		return NULL;
-
-	ret_pte = hugepte_offset(hpdp, ea, pdshift);
-	pdshift = hugepd_shift(*hpdp);
-out:
-	if (shift)
-		*shift = pdshift;
-	return ret_pte;
-}
-EXPORT_SYMBOL_GPL(find_linux_pte_or_hugepte);
-
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	return find_linux_pte_or_hugepte(mm->pgd, addr, NULL);
@@ -753,69 +696,6 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 	return NULL;
 }
 
-int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
-		unsigned long end, int write, struct page **pages, int *nr)
-{
-	unsigned long mask;
-	unsigned long pte_end;
-	struct page *head, *page, *tail;
-	pte_t pte;
-	int refs;
-
-	pte_end = (addr + sz) & ~(sz-1);
-	if (pte_end < end)
-		end = pte_end;
-
-	pte = *ptep;
-	mask = _PAGE_PRESENT | _PAGE_USER;
-	if (write)
-		mask |= _PAGE_RW;
-
-	if ((pte_val(pte) & mask) != mask)
-		return 0;
-
-	/* hugepages are never "special" */
-	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
-
-	refs = 0;
-	head = pte_page(pte);
-
-	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
-	tail = page;
-	do {
-		VM_BUG_ON(compound_head(page) != head);
-		pages[*nr] = page;
-		(*nr)++;
-		page++;
-		refs++;
-	} while (addr += PAGE_SIZE, addr != end);
-
-	if (!page_cache_add_speculative(head, refs)) {
-		*nr -= refs;
-		return 0;
-	}
-
-	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
-		/* Could be optimized better */
-		*nr -= refs;
-		while (refs--)
-			put_page(head);
-		return 0;
-	}
-
-	/*
-	 * Any tail page need their mapcount reference taken before we
-	 * return.
-	 */
-	while (refs--) {
-		if (PageTail(tail))
-			get_huge_page_tail(tail);
-		tail++;
-	}
-
-	return 1;
-}
-
 static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 				      unsigned long sz)
 {
@@ -1032,3 +912,128 @@ void flush_dcache_icache_hugepage(struct page *page)
 		}
 	}
 }
+
+#endif /* CONFIG_HUGETLB_PAGE */
+
+/*
+ * We have 4 cases for pgds and pmds:
+ * (1) invalid (all zeroes)
+ * (2) pointer to next table, as normal; bottom 6 bits == 0
+ * (3) leaf pte for huge page, bottom two bits != 00
+ * (4) hugepd pointer, bottom two bits == 00, next 4 bits indicate size of table
+ */
+pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift)
+{
+	pgd_t *pg;
+	pud_t *pu;
+	pmd_t *pm;
+	pte_t *ret_pte;
+	hugepd_t *hpdp = NULL;
+	unsigned pdshift = PGDIR_SHIFT;
+
+	if (shift)
+		*shift = 0;
+
+	pg = pgdir + pgd_index(ea);
+
+	if (pgd_huge(*pg)) {
+		ret_pte = (pte_t *) pg;
+		goto out;
+	} else if (is_hugepd(pg))
+		hpdp = (hugepd_t *)pg;
+	else if (!pgd_none(*pg)) {
+		pdshift = PUD_SHIFT;
+		pu = pud_offset(pg, ea);
+
+		if (pud_huge(*pu)) {
+			ret_pte = (pte_t *) pu;
+			goto out;
+		} else if (is_hugepd(pu))
+			hpdp = (hugepd_t *)pu;
+		else if (!pud_none(*pu)) {
+			pdshift = PMD_SHIFT;
+			pm = pmd_offset(pu, ea);
+
+			if (pmd_huge(*pm)) {
+				ret_pte = (pte_t *) pm;
+				goto out;
+			} else if (is_hugepd(pm))
+				hpdp = (hugepd_t *)pm;
+			else if (!pmd_none(*pm))
+				return pte_offset_kernel(pm, ea);
+		}
+	}
+	if (!hpdp)
+		return NULL;
+
+	ret_pte = hugepte_offset(hpdp, ea, pdshift);
+	pdshift = hugepd_shift(*hpdp);
+out:
+	if (shift)
+		*shift = pdshift;
+	return ret_pte;
+}
+EXPORT_SYMBOL_GPL(find_linux_pte_or_hugepte);
+
+int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
+		unsigned long end, int write, struct page **pages, int *nr)
+{
+	unsigned long mask;
+	unsigned long pte_end;
+	struct page *head, *page, *tail;
+	pte_t pte;
+	int refs;
+
+	pte_end = (addr + sz) & ~(sz-1);
+	if (pte_end < end)
+		end = pte_end;
+
+	pte = *ptep;
+	mask = _PAGE_PRESENT | _PAGE_USER;
+	if (write)
+		mask |= _PAGE_RW;
+
+	if ((pte_val(pte) & mask) != mask)
+		return 0;
+
+	/* hugepages are never "special" */
+	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
+
+	refs = 0;
+	head = pte_page(pte);
+
+	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
+	tail = page;
+	do {
+		VM_BUG_ON(compound_head(page) != head);
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
+	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
+		/* Could be optimized better */
+		*nr -= refs;
+		while (refs--)
+			put_page(head);
+		return 0;
+	}
+
+	/*
+	 * Any tail page need their mapcount reference taken before we
+	 * return.
+	 */
+	while (refs--) {
+		if (PageTail(tail))
+			get_huge_page_tail(tail);
+		tail++;
+	}
+
+	return 1;
+}
-- 
1.8.1.2

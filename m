Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 830F01A0EC4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 18:16:45 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 12:46:43 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 28EE7394005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:41 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0C7GVPF14024706
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:31 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0C7GRkE013475
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:27 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 08/33] mm: Some arch may want to use HPAGE_PMD related
 values as variables
Date: Tue, 12 Jan 2016 12:45:43 +0530
Message-Id: <1452582968-22669-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Architecture supporting multiple page table formats have the hugepage
related values as variable. So we can't use them in #define constants

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/arm/include/asm/pgtable-3level.h |  8 ++++++++
 arch/arm64/include/asm/pgtable.h      |  7 +++++++
 arch/mips/include/asm/pgtable.h       |  8 ++++++++
 arch/powerpc/mm/pgtable_64.c          |  7 +++++++
 arch/s390/include/asm/pgtable.h       |  8 ++++++++
 arch/sparc/include/asm/pgtable_64.h   |  7 +++++++
 arch/tile/include/asm/pgtable.h       |  9 +++++++++
 arch/x86/include/asm/pgtable.h        |  7 +++++++
 include/linux/huge_mm.h               |  3 ---
 mm/huge_memory.c                      | 11 +++++++----
 10 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index dc46398bc3a5..4b934de4d088 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -281,6 +281,14 @@ static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	flush_pmd_entry(pmdp);
 }
 
+#if HPAGE_PMD_ORDER >= MAX_ORDER
+#error "hugepages can't be allocated by the buddy allocator"
+#endif
+
+#if HPAGE_PMD_ORDER < 2
+#error "We need more than 2 pages to do deferred thp split"
+#endif
+
 static inline int has_transparent_hugepage(void)
 {
 	return 1;
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4be63692f275..99a2ccc4e7d4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -379,6 +379,13 @@ static inline pgprot_t mk_sect_prot(pgprot_t prot)
 
 #define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
 
+#if HPAGE_PMD_ORDER >= MAX_ORDER
+#error "hugepages can't be allocated by the buddy allocator"
+#endif
+
+#if HPAGE_PMD_ORDER < 2
+#error "We need more than 2 pages to do deferred thp split"
+#endif
 static inline int has_transparent_hugepage(void)
 {
 	return 1;
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 6995b4a02e23..93810618c302 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -468,6 +468,14 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
+#if HPAGE_PMD_ORDER >= MAX_ORDER
+#error "hugepages can't be allocated by the buddy allocator"
+#endif
+
+#if HPAGE_PMD_ORDER < 2
+#error "We need more than 2 pages to do deferred thp split"
+#endif
+
 extern int has_transparent_hugepage(void);
 
 static inline int pmd_trans_huge(pmd_t pmd)
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 3124a20d0fab..e5f600d19326 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -785,6 +785,13 @@ pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 
 int has_transparent_hugepage(void)
 {
+
+	BUILD_BUG_ON_MSG((PMD_SHIFT - PAGE_SHIFT) >= MAX_ORDER,
+		"hugepages can't be allocated by the buddy allocator");
+
+	BUILD_BUG_ON_MSG((PMD_SHIFT - PAGE_SHIFT) < 2,
+			 "We need more than 2 pages to do deferred thp split");
+
 	if (!mmu_has_feature(MMU_FTR_16M_PAGE))
 		return 0;
 	/*
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 64ead8091248..79e7ea6e272c 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1617,6 +1617,14 @@ static inline int pmd_trans_huge(pmd_t pmd)
 	return pmd_val(pmd) & _SEGMENT_ENTRY_LARGE;
 }
 
+#if HPAGE_PMD_ORDER >= MAX_ORDER
+#error "hugepages can't be allocated by the buddy allocator"
+#endif
+
+#if HPAGE_PMD_ORDER < 2
+#error "We need more than 2 pages to do deferred thp split"
+#endif
+
 static inline int has_transparent_hugepage(void)
 {
 	return MACHINE_HAS_HPAGE ? 1 : 0;
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index bf13625f8f90..1f62c5447513 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -683,6 +683,13 @@ static inline unsigned long pmd_trans_huge(pmd_t pmd)
 	return pte_val(pte) & _PAGE_PMD_HUGE;
 }
 
+#if HPAGE_PMD_ORDER >= MAX_ORDER
+#error "hugepages can't be allocated by the buddy allocator"
+#endif
+
+#if HPAGE_PMD_ORDER < 2
+#error "We need more than 2 pages to do deferred thp split"
+#endif
 #define has_transparent_hugepage() 1
 
 static inline pmd_t pmd_mkold(pmd_t pmd)
diff --git a/arch/tile/include/asm/pgtable.h b/arch/tile/include/asm/pgtable.h
index 983f1ed37d62..d8c1306e3a2f 100644
--- a/arch/tile/include/asm/pgtable.h
+++ b/arch/tile/include/asm/pgtable.h
@@ -488,6 +488,15 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+
+#if HPAGE_PMD_ORDER >= MAX_ORDER
+#error "hugepages can't be allocated by the buddy allocator"
+#endif
+
+#if HPAGE_PMD_ORDER < 2
+#error "We need more than 2 pages to do deferred thp split"
+#endif
+
 #define has_transparent_hugepage() 1
 #define pmd_trans_huge pmd_huge_page
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index c69f385d946f..6c4d2792a117 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -173,6 +173,13 @@ static inline int pmd_devmap(pmd_t pmd)
 	return !!(pmd_val(pmd) & _PAGE_DEVMAP);
 }
 
+#if HPAGE_PMD_ORDER >= MAX_ORDER
+#error "hugepages can't be allocated by the buddy allocator"
+#endif
+
+#if HPAGE_PMD_ORDER < 2
+#error "We need more than 2 pages to do deferred thp split"
+#endif
 static inline int has_transparent_hugepage(void)
 {
 	return cpu_has_pse;
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index bc141a65b736..b226d965ce2d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -111,9 +111,6 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			__split_huge_pmd(__vma, __pmd, __address);	\
 	}  while (0)
 
-#if HPAGE_PMD_ORDER >= MAX_ORDER
-#error "hugepages can't be allocated by the buddy allocator"
-#endif
 extern int hugepage_madvise(struct vm_area_struct *vma,
 			    unsigned long *vm_flags, int advice);
 extern void vma_adjust_trans_huge(struct vm_area_struct *vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 76ccead6cf2c..07f69f985702 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -81,7 +81,7 @@ unsigned long transparent_hugepage_flags __read_mostly =
 	(1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
 
 /* default scan 8*512 pte (or vmas) every 30 second */
-static unsigned int khugepaged_pages_to_scan __read_mostly = HPAGE_PMD_NR*8;
+static unsigned int khugepaged_pages_to_scan __read_mostly;
 static unsigned int khugepaged_pages_collapsed;
 static unsigned int khugepaged_full_scans;
 static unsigned int khugepaged_scan_sleep_millisecs __read_mostly = 10000;
@@ -96,8 +96,8 @@ static DECLARE_WAIT_QUEUE_HEAD(khugepaged_wait);
  * it would have happened if the vma was large enough during page
  * fault.
  */
-static unsigned int khugepaged_max_ptes_none __read_mostly = HPAGE_PMD_NR-1;
-static unsigned int khugepaged_max_ptes_swap __read_mostly = HPAGE_PMD_NR/8;
+static unsigned int khugepaged_max_ptes_none __read_mostly;
+static unsigned int khugepaged_max_ptes_swap __read_mostly;
 
 static int khugepaged(void *none);
 static int khugepaged_slab_init(void);
@@ -685,6 +685,10 @@ static int __init hugepage_init(void)
 	int err;
 	struct kobject *hugepage_kobj;
 
+	khugepaged_pages_to_scan = HPAGE_PMD_NR*8;
+	khugepaged_max_ptes_none = HPAGE_PMD_NR-1;
+	khugepaged_max_ptes_swap = HPAGE_PMD_NR/8;
+
 	if (!has_transparent_hugepage()) {
 		transparent_hugepage_flags = 0;
 		return -EINVAL;
@@ -794,7 +798,6 @@ void prep_transhuge_page(struct page *page)
 	 * we use page->mapping and page->indexlru in second tail page
 	 * as list_head: assuming THP order >= 2
 	 */
-	BUILD_BUG_ON(HPAGE_PMD_ORDER < 2);
 
 	INIT_LIST_HEAD(page_deferred_list(page));
 	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
-- 
2.5.0

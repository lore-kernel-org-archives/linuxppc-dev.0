Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 145681A0B6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 15:15:35 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 29 Feb 2016 21:15:34 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 4F93B1FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 21:03:41 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u214FVtX45088910
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 21:15:31 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u214FUYg031681
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 21:15:31 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 4/4] mm: Some arch may want to use HPAGE_PMD related values as
 variables
Date: Tue,  1 Mar 2016 09:45:14 +0530
Message-Id: <1456805714-21774-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1456805714-21774-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1456805714-21774-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

With next generation power processor, we are having a new mmu model
[1] that require us to maintain a different linux page table format.

Inorder to support both current and future ppc64 systems with a single
kernel we need to make sure kernel can select between different page
table format at runtime. With the new MMU (radix MMU) added, we will
have two different pmd hugepage size 16MB for hash model and 2MB for
Radix model. Hence make HPAGE_PMD related values as a variable.

Actual conversion of HPAGE_PMD to a variable for ppc64 happens in a
followup patch.

[1] http://ibm.biz/power-isa3 (Needs registration).

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable_64.c |  7 +++++++
 include/linux/bug.h          |  9 +++++++++
 include/linux/huge_mm.h      |  3 ---
 mm/huge_memory.c             | 17 ++++++++++++++---
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index af304e6d5a89..0eb53128ca2a 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -817,6 +817,13 @@ pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 
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
diff --git a/include/linux/bug.h b/include/linux/bug.h
index 7f4818673c41..e51b0709e78d 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -20,6 +20,7 @@ struct pt_regs;
 #define BUILD_BUG_ON_MSG(cond, msg) (0)
 #define BUILD_BUG_ON(condition) (0)
 #define BUILD_BUG() (0)
+#define MAYBE_BUILD_BUG_ON(cond) (0)
 #else /* __CHECKER__ */
 
 /* Force a compilation error if a constant expression is not a power of 2 */
@@ -83,6 +84,14 @@ struct pt_regs;
  */
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
 
+#define MAYBE_BUILD_BUG_ON(cond)			\
+	do {						\
+		if (__builtin_constant_p((cond)))       \
+			BUILD_BUG_ON(cond);             \
+		else                                    \
+			BUG_ON(cond);                   \
+	} while (0)
+
 #endif	/* __CHECKER__ */
 
 #ifdef CONFIG_GENERIC_BUG
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 459fd25b378e..f12513a20a06 100644
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
index aea8f7a42df9..36c22a89df61 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -83,7 +83,7 @@ unsigned long transparent_hugepage_flags __read_mostly =
 	(1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
 
 /* default scan 8*512 pte (or vmas) every 30 second */
-static unsigned int khugepaged_pages_to_scan __read_mostly = HPAGE_PMD_NR*8;
+static unsigned int khugepaged_pages_to_scan __read_mostly;
 static unsigned int khugepaged_pages_collapsed;
 static unsigned int khugepaged_full_scans;
 static unsigned int khugepaged_scan_sleep_millisecs __read_mostly = 10000;
@@ -98,7 +98,7 @@ static DECLARE_WAIT_QUEUE_HEAD(khugepaged_wait);
  * it would have happened if the vma was large enough during page
  * fault.
  */
-static unsigned int khugepaged_max_ptes_none __read_mostly = HPAGE_PMD_NR-1;
+static unsigned int khugepaged_max_ptes_none __read_mostly;
 
 static int khugepaged(void *none);
 static int khugepaged_slab_init(void);
@@ -660,6 +660,18 @@ static int __init hugepage_init(void)
 		return -EINVAL;
 	}
 
+	khugepaged_pages_to_scan = HPAGE_PMD_NR * 8;
+	khugepaged_max_ptes_none = HPAGE_PMD_NR - 1;
+	/*
+	 * hugepages can't be allocated by the buddy allocator
+	 */
+	MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER >= MAX_ORDER);
+	/*
+	 * we use page->mapping and page->index in second tail page
+	 * as list_head: assuming THP order >= 2
+	 */
+	MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER < 2);
+
 	err = hugepage_init_sysfs(&hugepage_kobj);
 	if (err)
 		goto err_sysfs;
@@ -764,7 +776,6 @@ void prep_transhuge_page(struct page *page)
 	 * we use page->mapping and page->indexlru in second tail page
 	 * as list_head: assuming THP order >= 2
 	 */
-	BUILD_BUG_ON(HPAGE_PMD_ORDER < 2);
 
 	INIT_LIST_HEAD(page_deferred_list(page));
 	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
-- 
2.5.0

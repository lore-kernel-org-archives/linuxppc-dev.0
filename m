Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BFBD014017A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 19:28:52 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 8 May 2014 14:58:47 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 01711E0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 14:59:11 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s489SUe917039502
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 May 2014 14:58:31 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s489SJ3s027904
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 May 2014 14:58:22 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org
Subject: [PATCH V4 1/2] mm: move FAULT_AROUND_ORDER to arch/
Date: Thu,  8 May 2014 14:58:15 +0530
Message-Id: <1399541296-18810-2-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: riel@redhat.com, ak@linux.intel.com, peterz@infradead.org,
 rusty@rustcorp.com.au, dave.hansen@intel.com,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, paulus@samba.org,
 mgorman@suse.de, akpm@linux-foundation.org, mingo@kernel.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kirill A. Shutemov with 8c6e50b029 commit introduced
vm_ops->map_pages() for mapping easy accessible pages around
fault address in hope to reduce number of minor page faults.

This patch creates infrastructure to modify the FAULT_AROUND_ORDER
value using mm/Kconfig. This will enable architecture maintainers
to decide on suitable FAULT_AROUND_ORDER value based on
performance data for that architecture. Patch also defaults
FAULT_AROUND_ORDER Kconfig element to 4.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 mm/Kconfig  |    8 ++++++++
 mm/memory.c |   25 ++++++-------------------
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index ebe5880..c7fc4f1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -176,6 +176,14 @@ config MOVABLE_NODE
 config HAVE_BOOTMEM_INFO_NODE
 	def_bool n
 
+#
+# Fault around order is a control knob to decide the fault around pages.
+# Default value is set to 4 , but the arch can override it as desired.
+#
+config FAULT_AROUND_ORDER
+	int
+	default	4
+
 # eventually, we can have this option just 'select SPARSEMEM'
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
diff --git a/mm/memory.c b/mm/memory.c
index 037b812..e3931ef 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3402,11 +3402,9 @@ void do_set_pte(struct vm_area_struct *vma, unsigned long address,
 	update_mmu_cache(vma, address, pte);
 }
 
-#define FAULT_AROUND_ORDER 4
+unsigned int fault_around_order __read_mostly = CONFIG_FAULT_AROUND_ORDER;
 
 #ifdef CONFIG_DEBUG_FS
-static unsigned int fault_around_order = FAULT_AROUND_ORDER;
-
 static int fault_around_order_get(void *data, u64 *val)
 {
 	*val = fault_around_order;
@@ -3415,7 +3413,6 @@ static int fault_around_order_get(void *data, u64 *val)
 
 static int fault_around_order_set(void *data, u64 val)
 {
-	BUILD_BUG_ON((1UL << FAULT_AROUND_ORDER) > PTRS_PER_PTE);
 	if (1UL << val > PTRS_PER_PTE)
 		return -EINVAL;
 	fault_around_order = val;
@@ -3435,31 +3432,21 @@ static int __init fault_around_debugfs(void)
 	return 0;
 }
 late_initcall(fault_around_debugfs);
+#endif
 
 static inline unsigned long fault_around_pages(void)
 {
-	return 1UL << fault_around_order;
-}
-
-static inline unsigned long fault_around_mask(void)
-{
-	return ~((1UL << (PAGE_SHIFT + fault_around_order)) - 1);
-}
-#else
-static inline unsigned long fault_around_pages(void)
-{
 	unsigned long nr_pages;
 
-	nr_pages = 1UL << FAULT_AROUND_ORDER;
-	BUILD_BUG_ON(nr_pages > PTRS_PER_PTE);
+	nr_pages = 1UL << fault_around_order;
+	VM_BUG_ON(nr_pages > PTRS_PER_PTE);
 	return nr_pages;
 }
 
 static inline unsigned long fault_around_mask(void)
 {
-	return ~((1UL << (PAGE_SHIFT + FAULT_AROUND_ORDER)) - 1);
+	return ~((1UL << (PAGE_SHIFT + fault_around_order)) - 1);
 }
-#endif
 
 static void do_fault_around(struct vm_area_struct *vma, unsigned long address,
 		pte_t *pte, pgoff_t pgoff, unsigned int flags)
@@ -3515,7 +3502,7 @@ static int do_read_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * if page by the offset is not ready to be mapped (cold cache or
 	 * something).
 	 */
-	if (vma->vm_ops->map_pages) {
+	if ((vma->vm_ops->map_pages) && fault_around_order) {
 		pte = pte_offset_map_lock(mm, pmd, address, &ptl);
 		do_fault_around(vma, address, pte, pgoff, flags);
 		if (!pte_same(*pte, orig_pte))
-- 
1.7.10.4

Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 770B71400C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 17:27:29 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 4 Apr 2014 11:57:25 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7A29C125805F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 11:59:53 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s346RF9c41549900
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Apr 2014 11:57:15 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s346RKkO027443
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Apr 2014 11:57:21 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org
Subject: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
Date: Fri,  4 Apr 2014 11:57:14 +0530
Message-Id: <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: riel@redhat.com, ak@linux.intel.com, peterz@infradead.org,
 rusty@rustcorp.com.au, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 paulus@samba.org, mgorman@suse.de, akpm@linux-foundation.org, mingo@kernel.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kirill A. Shutemov with faultaround patchset introduced
vm_ops->map_pages() for mapping easy accessible pages around
fault address in hope to reduce number of minor page faults.

This patch creates infrastructure to move the FAULT_AROUND_ORDER
to arch/ using Kconfig. This will enable architecture maintainers
to decide on suitable FAULT_AROUND_ORDER value based on
performance data for that architecture. Patch also adds
FAULT_AROUND_ORDER Kconfig element in arch/X86.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/x86/Kconfig   |    4 ++++
 include/linux/mm.h |    9 +++++++++
 mm/memory.c        |   12 +++++-------
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9c0a657..5833f22 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1177,6 +1177,10 @@ config DIRECT_GBPAGES
 	  support it. This can improve the kernel's performance a tiny bit by
 	  reducing TLB pressure. If in doubt, say "Y".
 
+config FAULT_AROUND_ORDER
+	int
+	default "4"
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0bd4359..b93c1c3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -26,6 +26,15 @@ struct file_ra_state;
 struct user_struct;
 struct writeback_control;
 
+/*
+ * Fault around order is a control knob to decide the fault around pages.
+ * Default value is set to 0UL (disabled), but the arch can override it as
+ * desired.
+ */
+#ifndef CONFIG_FAULT_AROUND_ORDER
+#define CONFIG_FAULT_AROUND_ORDER 0
+#endif
+
 #ifndef CONFIG_NEED_MULTIPLE_NODES	/* Don't use mapnrs, do it properly */
 extern unsigned long max_mapnr;
 
diff --git a/mm/memory.c b/mm/memory.c
index b02c584..22a4a89 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3358,10 +3358,8 @@ void do_set_pte(struct vm_area_struct *vma, unsigned long address,
 	update_mmu_cache(vma, address, pte);
 }
 
-#define FAULT_AROUND_ORDER 4
-
 #ifdef CONFIG_DEBUG_FS
-static unsigned int fault_around_order = FAULT_AROUND_ORDER;
+static unsigned int fault_around_order = CONFIG_FAULT_AROUND_ORDER;
 
 static int fault_around_order_get(void *data, u64 *val)
 {
@@ -3371,7 +3369,7 @@ static int fault_around_order_get(void *data, u64 *val)
 
 static int fault_around_order_set(void *data, u64 val)
 {
-	BUILD_BUG_ON((1UL << FAULT_AROUND_ORDER) > PTRS_PER_PTE);
+	BUILD_BUG_ON((1UL << CONFIG_FAULT_AROUND_ORDER) > PTRS_PER_PTE);
 	if (1UL << val > PTRS_PER_PTE)
 		return -EINVAL;
 	fault_around_order = val;
@@ -3406,14 +3404,14 @@ static inline unsigned long fault_around_pages(void)
 {
 	unsigned long nr_pages;
 
-	nr_pages = 1UL << FAULT_AROUND_ORDER;
+	nr_pages = 1UL << CONFIG_FAULT_AROUND_ORDER;
 	BUILD_BUG_ON(nr_pages > PTRS_PER_PTE);
 	return nr_pages;
 }
 
 static inline unsigned long fault_around_mask(void)
 {
-	return ~((1UL << (PAGE_SHIFT + FAULT_AROUND_ORDER)) - 1);
+	return ~((1UL << (PAGE_SHIFT + CONFIG_FAULT_AROUND_ORDER)) - 1);
 }
 #endif
 
@@ -3471,7 +3469,7 @@ static int do_read_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * if page by the offset is not ready to be mapped (cold cache or
 	 * something).
 	 */
-	if (vma->vm_ops->map_pages) {
+	if ((vma->vm_ops->map_pages) && (fault_around_pages() > 1)) {
 		pte = pte_offset_map_lock(mm, pmd, address, &ptl);
 		do_fault_around(vma, address, pte, pgoff, flags);
 		if (!pte_same(*pte, orig_pte))
-- 
1.7.10.4

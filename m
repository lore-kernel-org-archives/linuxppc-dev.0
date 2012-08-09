Return-Path: <kas@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by ozlabs.org (Postfix) with ESMTP id 9F50D2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 01:03:25 +1000 (EST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: linux-mm@kvack.org
Subject: [PATCH v2 5/6] mm: make clear_huge_page cache clear only around the
 fault address
Date: Thu,  9 Aug 2012 18:03:02 +0300
Message-Id: <1344524583-1096-6-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
 Jan Beulich <jbeulich@novell.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
 Andi Kleen <ak@linux.intel.com>, Robert Richter <robert.richter@amd.com>,
 x86@kernel.org, Hugh Dickins <hughd@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Alex Shi <alex.shu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

Clearing a 2MB huge page will typically blow away several levels
of CPU caches. To avoid this only cache clear the 4K area
around the fault address and use a cache avoiding clears
for the rest of the 2MB area.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/memory.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b47199a..e9a75c2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3969,18 +3969,35 @@ EXPORT_SYMBOL(might_fault);
 #endif
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+
+#ifndef ARCH_HAS_USER_NOCACHE
+#define ARCH_HAS_USER_NOCACHE 0
+#endif
+
+#if ARCH_HAS_USER_NOCACHE == 0
+#define clear_user_highpage_nocache clear_user_highpage
+#endif
+
 static void clear_gigantic_page(struct page *page,
 				unsigned long addr,
 				unsigned int pages_per_huge_page)
 {
 	int i;
 	struct page *p = page;
+	unsigned long vaddr;
+	unsigned long haddr = addr & HPAGE_PMD_MASK;
+	int target = (addr - haddr) >> PAGE_SHIFT;
 
 	might_sleep();
+	vaddr = haddr;
 	for (i = 0; i < pages_per_huge_page;
 	     i++, p = mem_map_next(p, page, i)) {
 		cond_resched();
-		clear_user_highpage(p, addr + i * PAGE_SIZE);
+		vaddr = haddr + i*PAGE_SIZE;
+		if (!ARCH_HAS_USER_NOCACHE  || i == target)
+			clear_user_highpage(p, vaddr);
+		else
+			clear_user_highpage_nocache(p, vaddr);
 	}
 }
 void clear_huge_page(struct page *page,
@@ -3988,16 +4005,23 @@ void clear_huge_page(struct page *page,
 {
 	int i;
 	unsigned long haddr = addr & HPAGE_PMD_MASK;
+	unsigned long vaddr;
+	int target = (addr - haddr) >> PAGE_SHIFT;
 
 	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
-		clear_gigantic_page(page, haddr, pages_per_huge_page);
+		clear_gigantic_page(page, addr, pages_per_huge_page);
 		return;
 	}
 
 	might_sleep();
+	vaddr = haddr;
 	for (i = 0; i < pages_per_huge_page; i++) {
 		cond_resched();
-		clear_user_highpage(page + i, haddr + i * PAGE_SIZE);
+		vaddr = haddr + i*PAGE_SIZE;
+		if (!ARCH_HAS_USER_NOCACHE || i == target)
+			clear_user_highpage(page + i, vaddr);
+		else
+			clear_user_highpage_nocache(page + i, vaddr);
 	}
 }
 
-- 
1.7.7.6

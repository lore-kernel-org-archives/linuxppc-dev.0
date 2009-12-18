Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1F08F100A06
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 11:46:09 +1100 (EST)
Message-Id: <200912180044.nBI0ic1w028405@imap1.linux-foundation.org>
Subject: [patch 2/5] mm: add notifier in pageblock isolation for balloon
	drivers
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Thu, 17 Dec 2009 16:44:38 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Cc: mel@csn.ul.ie, geralds@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, brking@linux.vnet.ibm.com,
	schwidefsky@de.ibm.com, akpm@linux-foundation.org, mingo@elte.hu,
	kamezawa.hiroyu@jp.fujitsu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Robert Jennings <rcj@linux.vnet.ibm.com>

Memory balloon drivers can allocate a large amount of memory which is not
movable but could be freed to accomodate memory hotplug remove.

Prior to calling the memory hotplug notifier chain the memory in the
pageblock is isolated.  Currently, if the migrate type is not
MIGRATE_MOVABLE the isolation will not proceed, causing the memory removal
for that page range to fail.

Rather than failing pageblock isolation if the migrateteype is not
MIGRATE_MOVABLE, this patch checks if all of the pages in the pageblock,
and not on the LRU, are owned by a registered balloon driver (or other
entity) using a notifier chain.  If all of the non-movable pages are owned
by a balloon, they can be freed later through the memory notifier chain
and the range can still be isolated in set_migratetype_isolate().

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
Cc: Mel Gorman <mel@csn.ul.ie>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Brian King <brking@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Gerald Schaefer <geralds@linux.vnet.ibm.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/base/memory.c  |   19 +++++++++++++
 include/linux/memory.h |   27 ++++++++++++++++++
 mm/page_alloc.c        |   57 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 96 insertions(+), 7 deletions(-)

diff -puN drivers/base/memory.c~mm-add-notifier-in-pageblock-isolation-for-balloon-drivers drivers/base/memory.c
--- a/drivers/base/memory.c~mm-add-notifier-in-pageblock-isolation-for-balloon-drivers
+++ a/drivers/base/memory.c
@@ -63,6 +63,20 @@ void unregister_memory_notifier(struct n
 }
 EXPORT_SYMBOL(unregister_memory_notifier);
 
+static ATOMIC_NOTIFIER_HEAD(memory_isolate_chain);
+
+int register_memory_isolate_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&memory_isolate_chain, nb);
+}
+EXPORT_SYMBOL(register_memory_isolate_notifier);
+
+void unregister_memory_isolate_notifier(struct notifier_block *nb)
+{
+	atomic_notifier_chain_unregister(&memory_isolate_chain, nb);
+}
+EXPORT_SYMBOL(unregister_memory_isolate_notifier);
+
 /*
  * register_memory - Setup a sysfs device for a memory block
  */
@@ -157,6 +171,11 @@ int memory_notify(unsigned long val, voi
 	return blocking_notifier_call_chain(&memory_chain, val, v);
 }
 
+int memory_isolate_notify(unsigned long val, void *v)
+{
+	return atomic_notifier_call_chain(&memory_isolate_chain, val, v);
+}
+
 /*
  * MEMORY_HOTPLUG depends on SPARSEMEM in mm/Kconfig, so it is
  * OK to have direct references to sparsemem variables in here.
diff -puN include/linux/memory.h~mm-add-notifier-in-pageblock-isolation-for-balloon-drivers include/linux/memory.h
--- a/include/linux/memory.h~mm-add-notifier-in-pageblock-isolation-for-balloon-drivers
+++ a/include/linux/memory.h
@@ -50,6 +50,19 @@ struct memory_notify {
 	int status_change_nid;
 };
 
+/*
+ * During pageblock isolation, count the number of pages within the
+ * range [start_pfn, start_pfn + nr_pages) which are owned by code
+ * in the notifier chain.
+ */
+#define MEM_ISOLATE_COUNT	(1<<0)
+
+struct memory_isolate_notify {
+	unsigned long start_pfn;	/* Start of range to check */
+	unsigned int nr_pages;		/* # pages in range to check */
+	unsigned int pages_found;	/* # pages owned found by callbacks */
+};
+
 struct notifier_block;
 struct mem_section;
 
@@ -76,14 +89,28 @@ static inline int memory_notify(unsigned
 {
 	return 0;
 }
+static inline int register_memory_isolate_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+static inline void unregister_memory_isolate_notifier(struct notifier_block *nb)
+{
+}
+static inline int memory_isolate_notify(unsigned long val, void *v)
+{
+	return 0;
+}
 #else
 extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
+extern int register_memory_isolate_notifier(struct notifier_block *nb);
+extern void unregister_memory_isolate_notifier(struct notifier_block *nb);
 extern int register_new_memory(int, struct mem_section *);
 extern int unregister_memory_section(struct mem_section *);
 extern int memory_dev_init(void);
 extern int remove_memory_block(unsigned long, struct mem_section *, int);
 extern int memory_notify(unsigned long val, void *v);
+extern int memory_isolate_notify(unsigned long val, void *v);
 extern struct memory_block *find_memory_block(struct mem_section *);
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 enum mem_add_context { BOOT, HOTPLUG };
diff -puN mm/page_alloc.c~mm-add-notifier-in-pageblock-isolation-for-balloon-drivers mm/page_alloc.c
--- a/mm/page_alloc.c~mm-add-notifier-in-pageblock-isolation-for-balloon-drivers
+++ a/mm/page_alloc.c
@@ -48,6 +48,7 @@
 #include <linux/page_cgroup.h>
 #include <linux/debugobjects.h>
 #include <linux/kmemleak.h>
+#include <linux/memory.h>
 #include <trace/events/kmem.h>
 
 #include <asm/tlbflush.h>
@@ -5008,23 +5009,65 @@ void set_pageblock_flags_group(struct pa
 int set_migratetype_isolate(struct page *page)
 {
 	struct zone *zone;
-	unsigned long flags;
+	struct page *curr_page;
+	unsigned long flags, pfn, iter;
+	unsigned long immobile = 0;
+	struct memory_isolate_notify arg;
+	int notifier_ret;
 	int ret = -EBUSY;
 	int zone_idx;
 
 	zone = page_zone(page);
 	zone_idx = zone_idx(zone);
+
 	spin_lock_irqsave(&zone->lock, flags);
+	if (get_pageblock_migratetype(page) == MIGRATE_MOVABLE ||
+	    zone_idx == ZONE_MOVABLE) {
+		ret = 0;
+		goto out;
+	}
+
+	pfn = page_to_pfn(page);
+	arg.start_pfn = pfn;
+	arg.nr_pages = pageblock_nr_pages;
+	arg.pages_found = 0;
+
 	/*
-	 * In future, more migrate types will be able to be isolation target.
+	 * It may be possible to isolate a pageblock even if the
+	 * migratetype is not MIGRATE_MOVABLE. The memory isolation
+	 * notifier chain is used by balloon drivers to return the
+	 * number of pages in a range that are held by the balloon
+	 * driver to shrink memory. If all the pages are accounted for
+	 * by balloons, are free, or on the LRU, isolation can continue.
+	 * Later, for example, when memory hotplug notifier runs, these
+	 * pages reported as "can be isolated" should be isolated(freed)
+	 * by the balloon driver through the memory notifier chain.
 	 */
-	if (get_pageblock_migratetype(page) != MIGRATE_MOVABLE &&
-	    zone_idx != ZONE_MOVABLE)
+	notifier_ret = memory_isolate_notify(MEM_ISOLATE_COUNT, &arg);
+	notifier_ret = notifier_to_errno(notifier_ret);
+	if (notifier_ret || !arg.pages_found)
 		goto out;
-	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
-	move_freepages_block(zone, page, MIGRATE_ISOLATE);
-	ret = 0;
+
+	for (iter = pfn; iter < (pfn + pageblock_nr_pages); iter++) {
+		if (!pfn_valid_within(pfn))
+			continue;
+
+		curr_page = pfn_to_page(iter);
+		if (!page_count(curr_page) || PageLRU(curr_page))
+			continue;
+
+		immobile++;
+	}
+
+	if (arg.pages_found == immobile)
+		ret = 0;
+
 out:
+	if (!ret) {
+		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
+		move_freepages_block(zone, page, MIGRATE_ISOLATE);
+	}
+
 	spin_unlock_irqrestore(&zone->lock, flags);
 	if (!ret)
 		drain_all_pages();
_

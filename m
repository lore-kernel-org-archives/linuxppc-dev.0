Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2E8DDE07F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 00:00:56 +1100 (EST)
Message-Id: <20070207124611.630390000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Date: Wed, 07 Feb 2007 13:45:40 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/12] powerpc: mark pages that dont exist as Nosave
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On some powerpc architectures (notably 64-bit powermac) there is a memory
hole, for example on powermacs between 2G and 4G. Since we use the flat
memory model regardless, these pages must be marked as Nosave (for suspend
to disk.)

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>

---
This replaces swsusp-dont-copy-pages-that-arent-ram.patch and works just as
well, except that it doesn't modify the generic code.

Tested on powerbook and powermac.

--- linux-2.6-git.orig/arch/powerpc/mm/mem.c	2007-02-07 02:55:03.319884289 +0100
+++ linux-2.6-git/arch/powerpc/mm/mem.c	2007-02-07 02:55:30.496884289 +0100
@@ -284,6 +284,27 @@ void __init do_init_bootmem(void)
 	init_bootmem_done = 1;
 }
 
+/* mark lowmem pages that don't exist as nosave, highmem
+ * pages always exist but aren't treated as RAM pages */
+static int __init mark_nonram_nosave(void)
+{
+	struct zone *zone;
+	unsigned long pfn, max_zone_pfn;
+
+	for_each_zone(zone) {
+		if (is_highmem(zone))
+			continue;
+
+		max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
+
+		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
+			if (!page_is_ram(pfn))
+				SetPageNosave(pfn_to_page(pfn));
+	}
+
+	return 0;
+}
+
 /*
  * paging_init() sets up the page tables - in fact we've already done this.
  */
@@ -315,6 +336,8 @@ void __init paging_init(void)
 	max_zone_pfns[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
 #endif
 	free_area_init_nodes(max_zone_pfns);
+
+	mark_nonram_nosave();
 }
 #endif /* ! CONFIG_NEED_MULTIPLE_NODES */
 

--

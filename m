Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D49C8DDEFE
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 23:12:49 +1100 (EST)
Message-Id: <20070321104211.584777000@sipsolutions.net>
References: <20070321104037.696668000@sipsolutions.net>
Date: Wed, 21 Mar 2007 11:40:41 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 4/6] powerpc: mark pages that dont exist as nosave
Mime-Version: 1.0
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
memory model regardless, these pages must be marked as nosave (for suspend
to disk.)

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Tested on powerbook and G5 powermac.

---
 arch/powerpc/mm/mem.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- linux-2.6-git.orig/arch/powerpc/mm/mem.c	2007-03-21 11:05:32.853447142 +0100
+++ linux-2.6-git/arch/powerpc/mm/mem.c	2007-03-21 11:06:08.338447142 +0100
@@ -31,6 +31,7 @@
 #include <linux/highmem.h>
 #include <linux/initrd.h>
 #include <linux/pagemap.h>
+#include <linux/suspend.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -280,6 +281,28 @@ void __init do_init_bootmem(void)
 	init_bootmem_done = 1;
 }
 
+/* mark pages that don't exist as nosave */
+static int __init mark_nonram_nosave(void)
+{
+	unsigned long lmb_next_region_start_pfn,
+		      lmb_region_max_pfn;
+	int i;
+
+	for (i = 0; i < lmb.memory.cnt - 1; i++) {
+		lmb_region_max_pfn =
+			(lmb.memory.region[i].base >> PAGE_SHIFT) +
+			(lmb.memory.region[i].size >> PAGE_SHIFT);
+		lmb_next_region_start_pfn =
+			lmb.memory.region[i+1].base >> PAGE_SHIFT;
+
+		if (lmb_region_max_pfn < lmb_next_region_start_pfn)
+			register_nosave_region(lmb_region_max_pfn,
+					       lmb_next_region_start_pfn);
+	}
+
+	return 0;
+}
+
 /*
  * paging_init() sets up the page tables - in fact we've already done this.
  */
@@ -311,6 +334,8 @@ void __init paging_init(void)
 	max_zone_pfns[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
 #endif
 	free_area_init_nodes(max_zone_pfns);
+
+	mark_nonram_nosave();
 }
 #endif /* ! CONFIG_NEED_MULTIPLE_NODES */
 

--

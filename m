Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF7D8DDE20
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 19:23:03 +1000 (EST)
Subject: [PATCH] powerpc: mark pages that don't exist as nosave
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 08 May 2007 11:25:00 +0200
Message-Id: <1178616300.18162.43.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
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
Tested on powerbook and G5 powermac, this patch is required for suspend
to disk on G5 as well due to the memory hole.

---
 arch/powerpc/mm/mem.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- powerpc.orig/arch/powerpc/mm/mem.c	2007-05-08 11:18:12.279080051 +0200
+++ powerpc/arch/powerpc/mm/mem.c	2007-05-08 11:22:02.559080051 +0200
@@ -31,6 +31,7 @@
 #include <linux/highmem.h>
 #include <linux/initrd.h>
 #include <linux/pagemap.h>
+#include <linux/suspend.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -276,6 +277,28 @@ void __init do_init_bootmem(void)
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
@@ -307,6 +330,8 @@ void __init paging_init(void)
 	max_zone_pfns[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
 #endif
 	free_area_init_nodes(max_zone_pfns);
+
+	mark_nonram_nosave();
 }
 #endif /* ! CONFIG_NEED_MULTIPLE_NODES */
 

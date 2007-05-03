Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0DE42DDF9D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 22:28:30 +1000 (EST)
Subject: [PATCH] powerpc: mark pages that don't exist as nosave
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1178195106.13233.108.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178195106.13233.108.camel@johannes.berg>
Content-Type: text/plain
Date: Thu, 03 May 2007 14:29:30 +0200
Message-Id: <1178195370.13233.113.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
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
Cc: Rafael J. Wysocki <rjw@sisk.pl>

---
Tested on powerbook and G5 powermac.

---
 arch/powerpc/mm/mem.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- wireless-dev.orig/arch/powerpc/mm/mem.c	2007-05-03 14:20:25.959165535 +0200
+++ wireless-dev/arch/powerpc/mm/mem.c	2007-05-03 14:21:09.659165535 +0200
@@ -31,6 +31,7 @@
 #include <linux/highmem.h>
 #include <linux/initrd.h>
 #include <linux/pagemap.h>
+#include <linux/suspend.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -277,6 +278,28 @@ void __init do_init_bootmem(void)
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
@@ -308,6 +331,8 @@ void __init paging_init(void)
 	max_zone_pfns[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
 #endif
 	free_area_init_nodes(max_zone_pfns);
+
+	mark_nonram_nosave();
 }
 #endif /* ! CONFIG_NEED_MULTIPLE_NODES */
 

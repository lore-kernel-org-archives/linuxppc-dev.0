Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCA7D1A092F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 14:39:45 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 4/6] powerpc: Remove ppc_md.remove_memory
Date: Wed, 17 Sep 2014 14:39:37 +1000
Message-Id: <1410928779-20938-4-git-send-email-anton@samba.org>
In-Reply-To: <1410928779-20938-1-git-send-email-anton@samba.org>
References: <1410928779-20938-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have an extra level of indirection on memory hot remove which is not
matched on memory hot add. Memory hotplug is book3s only, so there is
no need for it.

This also enables means remove_memory() (ie memory hot unplug) works
on powernv.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/machdep.h              |  4 ----
 arch/powerpc/mm/mem.c                           | 12 ++++++++++--
 arch/powerpc/platforms/pseries/hotplug-memory.c | 21 ---------------------
 3 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 902ab20..327e8dd 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -294,10 +294,6 @@ struct machdep_calls {
 #ifdef CONFIG_ARCH_RANDOM
 	int (*get_random_long)(unsigned long *v);
 #endif
-
-#ifdef CONFIG_MEMORY_HOTREMOVE
-	int (*remove_memory)(u64, u64);
-#endif
 };
 
 extern void e500_idle(void);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index e0f7a18..28b27b1 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -35,6 +35,7 @@
 #include <linux/memblock.h>
 #include <linux/hugetlb.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -144,8 +145,15 @@ int arch_remove_memory(u64 start, u64 size)
 
 	zone = page_zone(pfn_to_page(start_pfn));
 	ret = __remove_pages(zone, start_pfn, nr_pages);
-	if (!ret && (ppc_md.remove_memory))
-		ret = ppc_md.remove_memory(start, size);
+
+	start = (unsigned long)__va(start);
+	if (!ret)
+		ret = remove_section_mapping(start, start + size);
+
+	/* Ensure all vmalloc mappings are flushed in case they also
+	 * hit that section of memory
+	 */
+	vm_unmap_aliases();
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index e5171f5..eee55db 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -14,7 +14,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/memblock.h>
-#include <linux/vmalloc.h>
 #include <linux/memory.h>
 #include <linux/memory_hotplug.h>
 #include <linux/slab.h>
@@ -121,22 +120,6 @@ static struct memory_block *lmb_to_memblock(struct of_drconf_cell *lmb)
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-static int pseries_remove_memory(u64 start, u64 size)
-{
-	int ret;
-
-	/* Remove htab bolted mappings for this section of memory */
-	start = (unsigned long)__va(start);
-	ret = remove_section_mapping(start, start + size);
-
-	/* Ensure all vmalloc mappings are flushed in case they also
-	 * hit that section of memory
-	 */
-	vm_unmap_aliases();
-
-	return ret;
-}
-
 static int pseries_remove_memblock(unsigned long base, unsigned int memblock_size)
 {
 	unsigned long block_sz, start_pfn;
@@ -592,10 +575,6 @@ static int __init pseries_memory_hotplug_init(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		of_reconfig_notifier_register(&pseries_mem_nb);
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
-	ppc_md.remove_memory = pseries_remove_memory;
-#endif
-
 	return 0;
 }
 machine_device_initcall(pseries, pseries_memory_hotplug_init);
-- 
1.9.1

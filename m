Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7085B1A0A6A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Aug 2014 09:41:09 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc: Dynamic DMA zone limits
Date: Fri, 8 Aug 2014 18:40:42 -0500
Message-ID: <1407541245-27617-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Platform code can call limit_zone_pfn() to set appropriate limits
for ZONE_DMA and ZONE_DMA32, and dma_direct_alloc_coherent() will
select a suitable zone based on a device's mask and the pfn limits that
platform code has configured.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 arch/powerpc/Kconfig               |  4 +++
 arch/powerpc/include/asm/pgtable.h |  3 ++
 arch/powerpc/kernel/dma.c          | 20 +++++++++++++
 arch/powerpc/mm/mem.c              | 61 ++++++++++++++++++++++++++++++++++----
 4 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 80b94b0..56dc47a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -286,6 +286,10 @@ config PPC_EMULATE_SSTEP
 	bool
 	default y if KPROBES || UPROBES || XMON || HAVE_HW_BREAKPOINT
 
+config ZONE_DMA32
+	bool
+	default y if PPC64
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index d98c1ec..6d74167 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -4,6 +4,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/mmdebug.h>
+#include <linux/mmzone.h>
 #include <asm/processor.h>		/* For TASK_SIZE */
 #include <asm/mmu.h>
 #include <asm/page.h>
@@ -281,6 +282,8 @@ extern unsigned long empty_zero_page[];
 
 extern pgd_t swapper_pg_dir[];
 
+void limit_zone_pfn(enum zone_type zone, unsigned long max_pfn);
+int dma_pfn_limit_to_zone(u64 pfn_limit);
 extern void paging_init(void);
 
 /*
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index ee78f6e..dfd99ef 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -40,6 +40,26 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 #else
 	struct page *page;
 	int node = dev_to_node(dev);
+	u64 pfn = (dev->coherent_dma_mask >> PAGE_SHIFT) + 1;
+	int zone;
+
+	zone = dma_pfn_limit_to_zone(pfn);
+	if (zone < 0) {
+		dev_err(dev, "%s: No suitable zone for pfn %#llx\n",
+			__func__, pfn);
+		return NULL;
+	}
+
+	switch (zone) {
+	case ZONE_DMA:
+		flag |= GFP_DMA;
+		break;
+#ifdef CONFIG_ZONE_DMA32
+	case ZONE_DMA32:
+		flag |= GFP_DMA32;
+		break;
+#endif
+	};
 
 	/* ignore region specifiers */
 	flag  &= ~(__GFP_HIGHMEM);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index e0f7a18..3b23e17 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -261,6 +261,54 @@ static int __init mark_nonram_nosave(void)
 	return 0;
 }
 
+static bool zone_limits_final;
+
+static unsigned long max_zone_pfns[MAX_NR_ZONES] = {
+	[0 ... MAX_NR_ZONES - 1] = ~0UL
+};
+
+/*
+ * Restrict the specified zone and all more restrictive zones
+ * to be below the specified pfn.  May not be called after
+ * paging_init().
+ */
+void __init limit_zone_pfn(enum zone_type zone, unsigned long pfn_limit)
+{
+	int i;
+
+	if (WARN_ON(zone_limits_final))
+		return;
+
+	for (i = zone; i >= 0; i--) {
+		if (max_zone_pfns[i] > pfn_limit)
+			max_zone_pfns[i] = pfn_limit;
+	}
+}
+
+/*
+ * Find the least restrictive zone that is entirely below the
+ * specified pfn limit.  Returns < 0 if no suitable zone is found.
+ *
+ * pfn_limit must be u64 because it can exceed 32 bits even on 32-bit
+ * systems -- the DMA limit can be higher than any possible real pfn.
+ */
+int dma_pfn_limit_to_zone(u64 pfn_limit)
+{
+	enum zone_type top_zone = ZONE_NORMAL;
+	int i;
+
+#ifdef CONFIG_HIGHMEM
+	top_zone = ZONE_HIGHMEM;
+#endif
+
+	for (i = top_zone; i >= 0; i--) {
+		if (max_zone_pfns[i] <= pfn_limit)
+			return i;
+	}
+
+	return -EPERM;
+}
+
 /*
  * paging_init() sets up the page tables - in fact we've already done this.
  */
@@ -268,7 +316,7 @@ void __init paging_init(void)
 {
 	unsigned long long total_ram = memblock_phys_mem_size();
 	phys_addr_t top_of_ram = memblock_end_of_DRAM();
-	unsigned long max_zone_pfns[MAX_NR_ZONES];
+	enum zone_type top_zone;
 
 #ifdef CONFIG_PPC32
 	unsigned long v = __fix_to_virt(__end_of_fixed_addresses - 1);
@@ -290,13 +338,16 @@ void __init paging_init(void)
 	       (unsigned long long)top_of_ram, total_ram);
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (long int)((top_of_ram - total_ram) >> 20));
-	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+
 #ifdef CONFIG_HIGHMEM
-	max_zone_pfns[ZONE_DMA] = lowmem_end_addr >> PAGE_SHIFT;
-	max_zone_pfns[ZONE_HIGHMEM] = top_of_ram >> PAGE_SHIFT;
+	top_zone = ZONE_HIGHMEM;
+	limit_zone_pfn(ZONE_NORMAL, lowmem_end_addr >> PAGE_SHIFT);
 #else
-	max_zone_pfns[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
+	top_zone = ZONE_NORMAL;
 #endif
+
+	limit_zone_pfn(top_zone, top_of_ram >> PAGE_SHIFT);
+	zone_limits_final = true;
 	free_area_init_nodes(max_zone_pfns);
 
 	mark_nonram_nosave();
-- 
1.9.1

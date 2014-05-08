Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B31D1140104
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 17:40:37 +1000 (EST)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2 v3] bootmem/powerpc: Unify bootmem initialization
Date: Thu, 8 May 2014 02:06:38 -0500
Message-ID: <1399532799-1557-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unify the low/highmem code path from do_init_bootmem() by using (the)
lowmem related variables/parameters even when the low/highmem split
is not needed (64-bit) or configured. In such cases the "lowmem"
variables/parameters continue to observe the definition by referring
to memory directly mapped by the kernel

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

v2: Rebased, no changes

v3: No changes

 arch/powerpc/mm/mem.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 32202c9..eaf5d1d8 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -188,27 +188,31 @@ EXPORT_SYMBOL_GPL(walk_system_ram_range);
 void __init do_init_bootmem(void)
 {
 	unsigned long start, bootmap_pages;
-	unsigned long total_pages;
 	struct memblock_region *reg;
 	int boot_mapsize;
+	phys_addr_t _total_lowmem;
+	phys_addr_t _lowmem_end_addr;
 
-	max_low_pfn = max_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
-	total_pages = (memblock_end_of_DRAM() - memstart_addr) >> PAGE_SHIFT;
-#ifdef CONFIG_HIGHMEM
-	total_pages = total_lowmem >> PAGE_SHIFT;
-	max_low_pfn = lowmem_end_addr >> PAGE_SHIFT;
+#ifndef CONFIG_HIGHMEM
+	_lowmem_end_addr = memblock_end_of_DRAM();
+#else
+	_lowmem_end_addr = lowmem_end_addr;
 #endif
 
+	max_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
+	max_low_pfn = _lowmem_end_addr >> PAGE_SHIFT;
+	min_low_pfn = MEMORY_START >> PAGE_SHIFT;
+
 	/*
 	 * Find an area to use for the bootmem bitmap.  Calculate the size of
 	 * bitmap required as (Total Memory) / PAGE_SIZE / BITS_PER_BYTE.
 	 * Add 1 additional page in case the address isn't page-aligned.
 	 */
-	bootmap_pages = bootmem_bootmap_pages(total_pages);
+	_total_lowmem = _lowmem_end_addr - memstart_addr;
+	bootmap_pages = bootmem_bootmap_pages(_total_lowmem >> PAGE_SHIFT);
 
 	start = memblock_alloc(bootmap_pages << PAGE_SHIFT, PAGE_SIZE);
 
-	min_low_pfn = MEMORY_START >> PAGE_SHIFT;
 	boot_mapsize = init_bootmem_node(NODE_DATA(0), start >> PAGE_SHIFT, min_low_pfn, max_low_pfn);
 
 	/* Place all memblock_regions in the same node and merge contiguous
@@ -219,26 +223,18 @@ void __init do_init_bootmem(void)
 	/* Add all physical memory to the bootmem map, mark each area
 	 * present.
 	 */
-#ifdef CONFIG_HIGHMEM
-	free_bootmem_with_active_regions(0, lowmem_end_addr >> PAGE_SHIFT);
+	free_bootmem_with_active_regions(0, max_low_pfn);
 
 	/* reserve the sections we're already using */
 	for_each_memblock(reserved, reg) {
-		unsigned long top = reg->base + reg->size - 1;
-		if (top < lowmem_end_addr)
+		if (reg->base + reg->size - 1 < _lowmem_end_addr)
 			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
-		else if (reg->base < lowmem_end_addr) {
-			unsigned long trunc_size = lowmem_end_addr - reg->base;
+		else if (reg->base < _lowmem_end_addr) {
+			unsigned long trunc_size = _lowmem_end_addr - reg->base;
 			reserve_bootmem(reg->base, trunc_size, BOOTMEM_DEFAULT);
 		}
 	}
-#else
-	free_bootmem_with_active_regions(0, max_pfn);
 
-	/* reserve the sections we're already using */
-	for_each_memblock(reserved, reg)
-		reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
-#endif
 	/* XXX need to clip this if using highmem? */
 	sparse_memory_present_with_active_regions(0);
 
-- 
1.9.2

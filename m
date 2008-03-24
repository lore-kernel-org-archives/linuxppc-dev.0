Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29E44DE1C5
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 10:37:02 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m2ONavqA002404
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 18:36:58 -0500
Date: Mon, 24 Mar 2008 18:33:15 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Introduce lowmem_end_addr to distiguish from
	total_lowmem
Message-ID: <Pine.LNX.4.64.0803241832570.29472@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

total_lowmem represents the amount of low memory not the physical address
that low memory ends at.  If the start of memory is at 0 it happends that
total_lowmem can be used as both the size and the address that lowmem
ends at. (technical its one byte beyond the end)

To make the code a bit more clear and deal with the case when the start of
memory isn't at physical 0, we introduce lowmem_end_addr that represents
one byte beyond the last physical address in the lowmem region.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/44x_mmu.c |    2 +-
 arch/powerpc/mm/init_32.c |    4 +++-
 arch/powerpc/mm/init_64.c |    2 ++
 arch/powerpc/mm/mem.c     |   16 +++++++++-------
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index 04dc087..953fb91 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -67,7 +67,7 @@ unsigned long __init mmu_mapin_ram(void)

 	/* Pin in enough TLBs to cover any lowmem not covered by the
 	 * initial 256M mapping established in head_44x.S */
-	for (addr = PPC_PIN_SIZE; addr < total_lowmem;
+	for (addr = PPC_PIN_SIZE; addr < lowmem_end_addr;
 	     addr += PPC_PIN_SIZE)
 		ppc44x_pin_tlb(addr + PAGE_OFFSET, addr);

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 01a81a0..345a275 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -147,6 +147,7 @@ void __init MMU_init(void)
 	}

 	total_lowmem = total_memory = lmb_end_of_DRAM() - memstart_addr;
+	lowmem_end_addr = memstart_addr + total_lowmem;

 #ifdef CONFIG_FSL_BOOKE
 	/* Freescale Book-E parts expect lowmem to be mapped by fixed TLB
@@ -157,9 +158,10 @@ void __init MMU_init(void)

 	if (total_lowmem > __max_low_memory) {
 		total_lowmem = __max_low_memory;
+		lowmem_end_addr = memstart_addr + total_lowmem;
 #ifndef CONFIG_HIGHMEM
 		total_memory = total_lowmem;
-		lmb_enforce_memory_limit(total_lowmem);
+		lmb_enforce_memory_limit(lowmem_end_addr);
 		lmb_analyze();
 #endif /* CONFIG_HIGHMEM */
 	}
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index abeb0eb..f18b203 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -75,6 +75,8 @@
 /* max amount of RAM to use */
 unsigned long __max_memory;

+phys_addr_t memstart_addr;
+
 void free_initmem(void)
 {
 	unsigned long addr;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 60c019c..9c10b14 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -217,9 +217,11 @@ void __init do_init_bootmem(void)
 	unsigned long total_pages;
 	int boot_mapsize;

-	max_pfn = total_pages = lmb_end_of_DRAM() >> PAGE_SHIFT;
+	max_pfn = lmb_end_of_DRAM() >> PAGE_SHIFT;
+	total_pages = (lmb_end_of_DRAM() - memstart_addr) >> PAGE_SHIFT;
 #ifdef CONFIG_HIGHMEM
 	total_pages = total_lowmem >> PAGE_SHIFT;
+	max_low_pfn = lowmem_end_addr >> PAGE_SHIFT;
 #endif

 	/*
@@ -245,18 +247,18 @@ void __init do_init_bootmem(void)
 	 * present.
 	 */
 #ifdef CONFIG_HIGHMEM
-	free_bootmem_with_active_regions(0, total_lowmem >> PAGE_SHIFT);
+	free_bootmem_with_active_regions(0, lowmem_end_addr >> PAGE_SHIFT);

 	/* reserve the sections we're already using */
 	for (i = 0; i < lmb.reserved.cnt; i++) {
 		unsigned long addr = lmb.reserved.region[i].base +
 				     lmb_size_bytes(&lmb.reserved, i) - 1;
-		if (addr < total_lowmem)
+		if (addr < lowmem_end_addr)
 			reserve_bootmem(lmb.reserved.region[i].base,
 					lmb_size_bytes(&lmb.reserved, i),
 					BOOTMEM_DEFAULT);
-		else if (lmb.reserved.region[i].base < total_lowmem) {
-			unsigned long adjusted_size = total_lowmem -
+		else if (lmb.reserved.region[i].base < lowmem_end_addr) {
+			unsigned long adjusted_size = lowmem_end_addr -
 				      lmb.reserved.region[i].base;
 			reserve_bootmem(lmb.reserved.region[i].base,
 					adjusted_size, BOOTMEM_DEFAULT);
@@ -326,7 +328,7 @@ void __init paging_init(void)
 	       (top_of_ram - total_ram) >> 20);
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 #ifdef CONFIG_HIGHMEM
-	max_zone_pfns[ZONE_DMA] = total_lowmem >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_DMA] = lowmem_end_addr >> PAGE_SHIFT;
 	max_zone_pfns[ZONE_HIGHMEM] = top_of_ram >> PAGE_SHIFT;
 #else
 	max_zone_pfns[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
@@ -381,7 +383,7 @@ void __init mem_init(void)
 	{
 		unsigned long pfn, highmem_mapnr;

-		highmem_mapnr = total_lowmem >> PAGE_SHIFT;
+		highmem_mapnr = lowmem_end_addr >> PAGE_SHIFT;
 		for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
 			struct page *page = pfn_to_page(pfn);
 			if (lmb_is_reserved(pfn << PAGE_SHIFT))
-- 
1.5.4.1

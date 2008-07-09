Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 91517DDF7C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 23:45:17 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix problems with 32bit PPC's running with more than
	2GB of RAM
Date: Wed,  9 Jul 2008 15:44:36 +0200
Message-Id: <1215611076-13518-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch enables 32bit PPC's (with 36bit physical address space, e.g.
IBM/AMCC PPC44x) to run with more than 2GB of RAM. Mostly its just
replacing types (unsigned long -> phys_addr_t).

Tested on an AMCC Katmai with 4GB of DDR2.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/mm/init_32.c  |    4 ++--
 arch/powerpc/mm/mem.c      |    8 ++++----
 arch/powerpc/mm/mmu_decl.h |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 1952b4d..325ccdd 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -56,8 +56,8 @@
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
-unsigned long total_memory;
-unsigned long total_lowmem;
+phys_addr_t total_memory;
+phys_addr_t total_lowmem;
 
 phys_addr_t memstart_addr = (phys_addr_t)~0ull;
 EXPORT_SYMBOL(memstart_addr);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 51f82d8..55ef772 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -329,7 +329,7 @@ static int __init mark_nonram_nosave(void)
 void __init paging_init(void)
 {
 	unsigned long total_ram = lmb_phys_mem_size();
-	unsigned long top_of_ram = lmb_end_of_DRAM();
+	phys_addr_t top_of_ram = lmb_end_of_DRAM();
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
 #ifdef CONFIG_PPC32
@@ -348,10 +348,10 @@ void __init paging_init(void)
 	kmap_prot = PAGE_KERNEL;
 #endif /* CONFIG_HIGHMEM */
 
-	printk(KERN_DEBUG "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
-	       top_of_ram, total_ram);
+	printk(KERN_DEBUG "Top of RAM: 0x%llx, Total RAM: 0x%lx\n",
+	       (u64)top_of_ram, total_ram);
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
-	       (top_of_ram - total_ram) >> 20);
+	       (long int)((top_of_ram - total_ram) >> 20));
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 #ifdef CONFIG_HIGHMEM
 	max_zone_pfns[ZONE_DMA] = lowmem_end_addr >> PAGE_SHIFT;
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 0480225..4e46c63 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -49,8 +49,8 @@ extern unsigned int num_tlbcam_entries;
 extern unsigned long ioremap_bot;
 extern unsigned long __max_low_memory;
 extern phys_addr_t __initial_memory_limit_addr;
-extern unsigned long total_memory;
-extern unsigned long total_lowmem;
+extern phys_addr_t total_memory;
+extern phys_addr_t total_lowmem;
 extern phys_addr_t memstart_addr;
 extern phys_addr_t lowmem_end_addr;
 
-- 
1.5.6.2

Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 22 Mar 2007 13:59:42 +1100
Subject: [PATCH 4/4] [PATCH] powerpc: DEBUG_PAGEALLOC for 64 bits
Message-Id: <20070322030116.5E7B8DDF59@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's an implementation of DEBUG_PAGEALLOC for 64 bits powerpc.
It applies on top of the 32 bits patch.

Unlike Anton's previous attempt, I'm not using updatepp. I'm removing
the hash entries from the bolted mapping (using a map in RAM of all the
slots). Expensive but it doesn't really matter, does it ? :-)

Memory hot-added doesn't benefit from this unless it's added at an
address that is below end_of_DRAM() as calculated at boot time.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/Kconfig.debug      |    2 
 arch/powerpc/mm/hash_utils_64.c |   84 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 82 insertions(+), 4 deletions(-)

Index: linux-cell/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/hash_utils_64.c	2007-03-22 13:24:25.000000000 +1100
+++ linux-cell/arch/powerpc/mm/hash_utils_64.c	2007-03-22 13:25:02.000000000 +1100
@@ -100,6 +100,11 @@ unsigned int HPAGE_SHIFT;
 #ifdef CONFIG_PPC_64K_PAGES
 int mmu_ci_restrictions;
 #endif
+#ifdef CONFIG_DEBUG_PAGEALLOC
+static u8 *linear_map_hash_slots;
+static unsigned long linear_map_hash_count;
+static spinlock_t linear_map_hash_lock;
+#endif /* CONFIG_DEBUG_PAGEALLOC */
 
 /* There are definitions of page sizes arrays to be used when none
  * is provided by the firmware.
@@ -152,11 +157,10 @@ int htab_bolt_mapping(unsigned long vsta
 
 	for (vaddr = vstart, paddr = pstart; vaddr < vend;
 	     vaddr += step, paddr += step) {
-		unsigned long vpn, hash, hpteg;
+		unsigned long hash, hpteg;
 		unsigned long vsid = get_kernel_vsid(vaddr);
 		unsigned long va = (vsid << 28) | (vaddr & 0x0fffffff);
 
-		vpn = va >> shift;
 		tmp_mode = mode;
 		
 		/* Make non-kernel text non-executable */
@@ -174,6 +178,10 @@ int htab_bolt_mapping(unsigned long vsta
 
 		if (ret < 0)
 			break;
+#ifdef CONFIG_DEBUG_PAGEALLOC
+		if ((paddr >> PAGE_SHIFT) < linear_map_hash_count)
+			linear_map_hash_slots[paddr >> PAGE_SHIFT] = ret | 0x80;
+#endif /* CONFIG_DEBUG_PAGEALLOC */
 	}
 	return ret < 0 ? ret : 0;
 }
@@ -281,6 +289,7 @@ static void __init htab_init_page_sizes(
 		memcpy(mmu_psize_defs, mmu_psize_defaults_gp,
 		       sizeof(mmu_psize_defaults_gp));
  found:
+#ifndef CONFIG_DEBUG_PAGEALLOC
 	/*
 	 * Pick a size for the linear mapping. Currently, we only support
 	 * 16M, 1M and 4K which is the default
@@ -289,6 +298,7 @@ static void __init htab_init_page_sizes(
 		mmu_linear_psize = MMU_PAGE_16M;
 	else if (mmu_psize_defs[MMU_PAGE_1M].shift)
 		mmu_linear_psize = MMU_PAGE_1M;
+#endif /* CONFIG_DEBUG_PAGEALLOC */
 
 #ifdef CONFIG_PPC_64K_PAGES
 	/*
@@ -303,12 +313,14 @@ static void __init htab_init_page_sizes(
 	if (mmu_psize_defs[MMU_PAGE_64K].shift) {
 		mmu_virtual_psize = MMU_PAGE_64K;
 		mmu_vmalloc_psize = MMU_PAGE_64K;
+		if (mmu_linear_psize == MMU_PAGE_4K)
+			mmu_linear_psize = MMU_PAGE_64K;
 		if (cpu_has_feature(CPU_FTR_CI_LARGE_PAGE))
 			mmu_io_psize = MMU_PAGE_64K;
 		else
 			mmu_ci_restrictions = 1;
 	}
-#endif
+#endif /* CONFIG_PPC_64K_PAGES */
 
 	printk(KERN_DEBUG "Page orders: linear mapping = %d, "
 	       "virtual = %d, io = %d\n",
@@ -476,6 +488,13 @@ void __init htab_initialize(void)
 
 	mode_rw = _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX;
 
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	linear_map_hash_count = lmb_end_of_DRAM() >> PAGE_SHIFT;
+	linear_map_hash_slots = __va(lmb_alloc_base(linear_map_hash_count,
+						    1, lmb.rmo_size));
+	memset(linear_map_hash_slots, 0, linear_map_hash_count);
+#endif /* CONFIG_DEBUG_PAGEALLOC */
+
 	/* On U3 based machines, we need to reserve the DART area and
 	 * _NOT_ map it to avoid cache paradoxes as it's remapped non
 	 * cacheable later on
@@ -825,3 +844,62 @@ void low_hash_fault(struct pt_regs *regs
 	}
 	bad_page_fault(regs, address, SIGBUS);
 }
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
+{
+	unsigned long hash, hpteg, vsid = get_kernel_vsid(vaddr);
+	unsigned long va = (vsid << 28) | (vaddr & 0x0fffffff);
+	unsigned long mode = _PAGE_ACCESSED | _PAGE_DIRTY |
+		_PAGE_COHERENT | PP_RWXX | HPTE_R_N;
+	int ret;
+
+	hash = hpt_hash(va, PAGE_SHIFT);
+	hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
+
+	ret = ppc_md.hpte_insert(hpteg, va, __pa(vaddr),
+				 mode, HPTE_V_BOLTED, mmu_linear_psize);
+	BUG_ON (ret < 0);
+	spin_lock(&linear_map_hash_lock);
+	BUG_ON(linear_map_hash_slots[lmi] & 0x80);
+	linear_map_hash_slots[lmi] = ret | 0x80;
+	spin_unlock(&linear_map_hash_lock);
+}
+
+static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
+{
+	unsigned long hash, hidx, slot, vsid = get_kernel_vsid(vaddr);
+	unsigned long va = (vsid << 28) | (vaddr & 0x0fffffff);
+
+	hash = hpt_hash(va, PAGE_SHIFT);
+	spin_lock(&linear_map_hash_lock);
+	BUG_ON(!(linear_map_hash_slots[lmi] & 0x80));
+	hidx = linear_map_hash_slots[lmi] & 0x7f;
+	linear_map_hash_slots[lmi] = 0;
+	spin_unlock(&linear_map_hash_lock);
+	if (hidx & _PTEIDX_SECONDARY)
+		hash = ~hash;
+	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+	slot += hidx & _PTEIDX_GROUP_IX;
+	ppc_md.hpte_invalidate(slot, va, mmu_linear_psize, 0);
+}
+
+void kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	unsigned long flags, vaddr, lmi;
+	int i;
+
+	local_irq_save(flags);
+	for (i = 0; i < numpages; i++, page++) {
+		vaddr = (unsigned long)page_address(page);
+		lmi = __pa(vaddr) >> PAGE_SHIFT;
+		if (lmi >= linear_map_hash_count)
+			continue;
+		if (enable)
+			kernel_map_linear_page(vaddr, lmi);
+		else
+			kernel_unmap_linear_page(vaddr, lmi);
+	}
+	local_irq_restore(flags);
+}
+#endif /* CONFIG_DEBUG_PAGEALLOC */
Index: linux-cell/arch/powerpc/Kconfig.debug
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig.debug	2007-03-22 13:24:25.000000000 +1100
+++ linux-cell/arch/powerpc/Kconfig.debug	2007-03-22 13:24:27.000000000 +1100
@@ -20,7 +20,7 @@ config DEBUG_STACK_USAGE
 
 config DEBUG_PAGEALLOC
         bool "Debug page memory allocations"
-        depends on DEBUG_KERNEL && !SOFTWARE_SUSPEND && PPC32
+        depends on DEBUG_KERNEL && !SOFTWARE_SUSPEND
         help
           Unmap pages from the kernel linear mapping after free_pages().
           This results in a large slowdown, but helps to find certain types

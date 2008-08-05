Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 05 Aug 2008 16:19:56 +1000
Subject: [PATCH] powerpc/mm: Fix attribute confusion with htab_bolt_mapping()
Message-Id: <20080805062012.2A161DDE1A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The function htab_bolt_mapping() is used to create permanent
mappings in the MMU hash table, for example, in order to create
the linear mapping of vmemmap. It's also used by early boot
ioremap (before mem_init_done).

However, the way ioremap uses it is incorrect as it passes it
the protection flags in the "linux PTE" form while htab_bolt_mapping()
expects them in the hash table format. This is made more confusing
by the fact that some of those flags are actually in the same
position in both cases.

This patch fixes it all by making htab_bolt_mapping() take normal
linux protection flags instead, and use a little helper to convert
them to htab flags. Callers can now use the usual PAGE_* definitions
safely.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/include/asm/mmu-hash64.h |    2 -
 arch/powerpc/mm/hash_utils_64.c       |   65 ++++++++++++++++++++--------------
 arch/powerpc/mm/init_64.c             |    9 +---
 3 files changed, 44 insertions(+), 32 deletions(-)

--- linux-work.orig/arch/powerpc/mm/hash_utils_64.c	2008-08-05 15:15:06.000000000 +1000
+++ linux-work/arch/powerpc/mm/hash_utils_64.c	2008-08-05 16:09:47.000000000 +1000
@@ -18,7 +18,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#undef DEBUG
+#define DEBUG
 #undef DEBUG_LOW
 
 #include <linux/spinlock.h>
@@ -151,39 +151,53 @@ static struct mmu_psize_def mmu_psize_de
 	},
 };
 
+static unsigned long htab_convert_pte_flags(unsigned long pteflags)
+{
+	unsigned long rflags = pteflags & 0x1fa;
+
+	/* _PAGE_EXEC -> NOEXEC */
+	if ((pteflags & _PAGE_EXEC) == 0)
+		rflags |= HPTE_R_N;
+
+	/* PP bits. PAGE_USER is already PP bit 0x2, so we only
+	 * need to add in 0x1 if it's a read-only user page
+	 */
+	if ((pteflags & _PAGE_USER) && !((pteflags & _PAGE_RW) &&
+					 (pteflags & _PAGE_DIRTY)))
+		rflags |= 1;
+
+	/* Always add C */
+	return rflags | HPTE_R_C;
+}
 
 int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
-		      unsigned long pstart, unsigned long mode,
+		      unsigned long pstart, unsigned long prot,
 		      int psize, int ssize)
 {
 	unsigned long vaddr, paddr;
 	unsigned int step, shift;
-	unsigned long tmp_mode;
 	int ret = 0;
 
 	shift = mmu_psize_defs[psize].shift;
 	step = 1 << shift;
 
+	prot = htab_convert_pte_flags(prot);
+
+	DBG("htab_bolt_mapping(%lx..%lx -> %lx (%lx,%d,%d)\n",
+	    vstart, vend, pstart, prot, psize, ssize);
+
 	for (vaddr = vstart, paddr = pstart; vaddr < vend;
 	     vaddr += step, paddr += step) {
 		unsigned long hash, hpteg;
 		unsigned long vsid = get_kernel_vsid(vaddr, ssize);
 		unsigned long va = hpt_va(vaddr, vsid, ssize);
 
-		tmp_mode = mode;
-		
-		/* Make non-kernel text non-executable */
-		if (!in_kernel_text(vaddr))
-			tmp_mode = mode | HPTE_R_N;
-
 		hash = hpt_hash(va, shift, ssize);
 		hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
 
-		DBG("htab_bolt_mapping: calling %p\n", ppc_md.hpte_insert);
-
 		BUG_ON(!ppc_md.hpte_insert);
-		ret = ppc_md.hpte_insert(hpteg, va, paddr,
-				tmp_mode, HPTE_V_BOLTED, psize, ssize);
+		ret = ppc_md.hpte_insert(hpteg, va, paddr, prot,
+					 HPTE_V_BOLTED, psize, ssize);
 
 		if (ret < 0)
 			break;
@@ -519,9 +533,9 @@ static unsigned long __init htab_get_tab
 #ifdef CONFIG_MEMORY_HOTPLUG
 void create_section_mapping(unsigned long start, unsigned long end)
 {
-		BUG_ON(htab_bolt_mapping(start, end, __pa(start),
-			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX,
-			mmu_linear_psize, mmu_kernel_ssize));
+	BUG_ON(htab_bolt_mapping(start, end, __pa(start),
+				 PAGE_KERNEL, mmu_linear_psize,
+				 mmu_kernel_ssize));
 }
 
 int remove_section_mapping(unsigned long start, unsigned long end)
@@ -570,7 +584,7 @@ void __init htab_initialize(void)
 {
 	unsigned long table;
 	unsigned long pteg_count;
-	unsigned long mode_rw;
+	unsigned long prot, tprot;
 	unsigned long base = 0, size = 0, limit;
 	int i;
 
@@ -628,7 +642,7 @@ void __init htab_initialize(void)
 		mtspr(SPRN_SDR1, _SDR1);
 	}
 
-	mode_rw = _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX;
+	prot = PAGE_KERNEL;
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	linear_map_hash_count = lmb_end_of_DRAM() >> PAGE_SHIFT;
@@ -646,8 +660,10 @@ void __init htab_initialize(void)
 	for (i=0; i < lmb.memory.cnt; i++) {
 		base = (unsigned long)__va(lmb.memory.region[i].base);
 		size = lmb.memory.region[i].size;
+		tprot = prot | (in_kernel_text(base) ? _PAGE_EXEC : 0);
 
-		DBG("creating mapping for region: %lx : %lx\n", base, size);
+		DBG("creating mapping for region: %lx..%lx (prot: %x)\n",
+		    base, size, tprot);
 
 #ifdef CONFIG_U3_DART
 		/* Do not map the DART space. Fortunately, it will be aligned
@@ -664,21 +680,21 @@ void __init htab_initialize(void)
 			unsigned long dart_table_end = dart_tablebase + 16 * MB;
 			if (base != dart_tablebase)
 				BUG_ON(htab_bolt_mapping(base, dart_tablebase,
-							__pa(base), mode_rw,
+							__pa(base), tprot,
 							mmu_linear_psize,
 							mmu_kernel_ssize));
 			if ((base + size) > dart_table_end)
 				BUG_ON(htab_bolt_mapping(dart_tablebase+16*MB,
 							base + size,
 							__pa(dart_table_end),
-							 mode_rw,
+							 tprot,
 							 mmu_linear_psize,
 							 mmu_kernel_ssize));
 			continue;
 		}
 #endif /* CONFIG_U3_DART */
 		BUG_ON(htab_bolt_mapping(base, base + size, __pa(base),
-				mode_rw, mmu_linear_psize, mmu_kernel_ssize));
+				tprot, mmu_linear_psize, mmu_kernel_ssize));
        }
 
 	/*
@@ -696,7 +712,7 @@ void __init htab_initialize(void)
 			tce_alloc_start = base + size + 1;
 
 		BUG_ON(htab_bolt_mapping(tce_alloc_start, tce_alloc_end,
-					 __pa(tce_alloc_start), mode_rw,
+					 __pa(tce_alloc_start), prot,
 					 mmu_linear_psize, mmu_kernel_ssize));
 	}
 
@@ -1117,8 +1133,7 @@ static void kernel_map_linear_page(unsig
 	unsigned long hash, hpteg;
 	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
 	unsigned long va = hpt_va(vaddr, vsid, mmu_kernel_ssize);
-	unsigned long mode = _PAGE_ACCESSED | _PAGE_DIRTY |
-		_PAGE_COHERENT | PP_RWXX | HPTE_R_N;
+	unsigned long mode = htab_convert_pte_flags(PAGE_KERNEL);
 	int ret;
 
 	hash = hpt_hash(va, PAGE_SHIFT, mmu_kernel_ssize);
Index: linux-work/arch/powerpc/mm/init_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/init_64.c	2008-08-05 15:15:06.000000000 +1000
+++ linux-work/arch/powerpc/mm/init_64.c	2008-08-05 16:09:47.000000000 +1000
@@ -206,13 +206,10 @@ static int __meminit vmemmap_populated(u
 int __meminit vmemmap_populate(struct page *start_page,
 			       unsigned long nr_pages, int node)
 {
-	unsigned long mode_rw;
 	unsigned long start = (unsigned long)start_page;
 	unsigned long end = (unsigned long)(start_page + nr_pages);
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
 
-	mode_rw = _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX;
-
 	/* Align to the page size of the linear mapping. */
 	start = _ALIGN_DOWN(start, page_size);
 
@@ -230,9 +227,9 @@ int __meminit vmemmap_populate(struct pa
 		pr_debug("vmemmap %08lx allocated at %p, physical %08lx.\n",
 			start, p, __pa(p));
 
-		mapped = htab_bolt_mapping(start, start + page_size,
-					__pa(p), mode_rw, mmu_vmemmap_psize,
-					mmu_kernel_ssize);
+		mapped = htab_bolt_mapping(start, start + page_size, __pa(p),
+					   PAGE_KERNEL, mmu_vmemmap_psize,
+					   mmu_kernel_ssize);
 		BUG_ON(mapped < 0);
 	}
 
Index: linux-work/arch/powerpc/include/asm/mmu-hash64.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu-hash64.h	2008-08-05 15:15:06.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu-hash64.h	2008-08-05 16:09:47.000000000 +1000
@@ -278,7 +278,7 @@ extern int hash_huge_page(struct mm_stru
 			  unsigned long trap);
 
 extern int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
-			     unsigned long pstart, unsigned long mode,
+			     unsigned long pstart, unsigned long prot,
 			     int psize, int ssize);
 extern void set_huge_psize(int psize);
 extern void add_gpage(unsigned long addr, unsigned long page_size,

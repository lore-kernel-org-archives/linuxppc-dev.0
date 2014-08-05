Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D5EF1A0185
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 16:32:17 +1000 (EST)
Date: Tue, 5 Aug 2014 16:32:18 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 paulmck@linux.vnet.ibm.com, Emilian.Medve@Freescale.com
Subject: [PATCH 1/5] powerpc: Remove bootmem allocator
Message-ID: <20140805163218.47c86615@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment we transition from the memblock alloctor to the bootmem
allocator. Removing the bootmem allocator removes a bunch of complicated
code (most of which I owe the dubious honour of being responsible for
writing).

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/Kconfig
===================================================================
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -145,6 +145,7 @@ config PPC
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select ARCH_USE_CMPXCHG_LOCKREF if PPC64
 	select HAVE_ARCH_AUDITSYSCALL
+	select NO_BOOTMEM
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
Index: b/arch/powerpc/include/asm/setup.h
===================================================================
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -8,7 +8,6 @@ extern void ppc_printk_progress(char *s,
 
 extern unsigned int rtas_data;
 extern int mem_init_done;	/* set on boot once kmalloc can be called */
-extern int init_bootmem_done;	/* set once bootmem is available */
 extern unsigned long long memory_limit;
 extern unsigned long klimit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
@@ -24,7 +23,7 @@ extern void reloc_got2(unsigned long);
 #define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
 
 void check_for_initrd(void);
-void do_init_bootmem(void);
+void initmem_init(void);
 void setup_panic(void);
 #define ARCH_PANIC_TIMEOUT 180
 
Index: b/arch/powerpc/kernel/setup_32.c
===================================================================
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -311,9 +311,8 @@ void __init setup_arch(char **cmdline_p)
 
 	irqstack_early_init();
 
-	/* set up the bootmem stuff with available memory */
-	do_init_bootmem();
-	if ( ppc_md.progress ) ppc_md.progress("setup_arch: bootmem", 0x3eab);
+	initmem_init();
+	if ( ppc_md.progress ) ppc_md.progress("setup_arch: initmem", 0x3eab);
 
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
Index: b/arch/powerpc/kernel/setup_64.c
===================================================================
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -677,8 +677,7 @@ void __init setup_arch(char **cmdline_p)
 	exc_lvl_early_init();
 	emergency_stack_init();
 
-	/* set up the bootmem stuff with available memory */
-	do_init_bootmem();
+	initmem_init();
 	sparse_init();
 
 #ifdef CONFIG_DUMMY_CONSOLE
Index: b/arch/powerpc/mm/init_32.c
===================================================================
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -195,15 +195,6 @@ void __init MMU_init(void)
 	memblock_set_current_limit(lowmem_end_addr);
 }
 
-/* This is only called until mem_init is done. */
-void __init *early_get_page(void)
-{
-	if (init_bootmem_done)
-		return alloc_bootmem_pages(PAGE_SIZE);
-	else
-		return __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
-}
-
 #ifdef CONFIG_8xx /* No 8xx specific .c file to put that in ... */
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
Index: b/arch/powerpc/mm/mem.c
===================================================================
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -60,7 +60,6 @@
 #define CPU_FTR_NOEXECUTE	0
 #endif
 
-int init_bootmem_done;
 int mem_init_done;
 unsigned long long memory_limit;
 
@@ -179,70 +178,22 @@ walk_system_ram_range(unsigned long star
 }
 EXPORT_SYMBOL_GPL(walk_system_ram_range);
 
-/*
- * Initialize the bootmem system and give it all the memory we
- * have available.  If we are using highmem, we only put the
- * lowmem into the bootmem system.
- */
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-void __init do_init_bootmem(void)
+void __init initmem_init(void)
 {
-	unsigned long start, bootmap_pages;
-	unsigned long total_pages;
-	struct memblock_region *reg;
-	int boot_mapsize;
-
 	max_low_pfn = max_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
-	total_pages = (memblock_end_of_DRAM() - memstart_addr) >> PAGE_SHIFT;
+	min_low_pfn = MEMORY_START >> PAGE_SHIFT;
 #ifdef CONFIG_HIGHMEM
-	total_pages = total_lowmem >> PAGE_SHIFT;
 	max_low_pfn = lowmem_end_addr >> PAGE_SHIFT;
 #endif
 
-	/*
-	 * Find an area to use for the bootmem bitmap.  Calculate the size of
-	 * bitmap required as (Total Memory) / PAGE_SIZE / BITS_PER_BYTE.
-	 * Add 1 additional page in case the address isn't page-aligned.
-	 */
-	bootmap_pages = bootmem_bootmap_pages(total_pages);
-
-	start = memblock_alloc(bootmap_pages << PAGE_SHIFT, PAGE_SIZE);
-
-	min_low_pfn = MEMORY_START >> PAGE_SHIFT;
-	boot_mapsize = init_bootmem_node(NODE_DATA(0), start >> PAGE_SHIFT, min_low_pfn, max_low_pfn);
-
 	/* Place all memblock_regions in the same node and merge contiguous
 	 * memblock_regions
 	 */
 	memblock_set_node(0, (phys_addr_t)ULLONG_MAX, &memblock.memory, 0);
 
-	/* Add all physical memory to the bootmem map, mark each area
-	 * present.
-	 */
-#ifdef CONFIG_HIGHMEM
-	free_bootmem_with_active_regions(0, lowmem_end_addr >> PAGE_SHIFT);
-
-	/* reserve the sections we're already using */
-	for_each_memblock(reserved, reg) {
-		unsigned long top = reg->base + reg->size - 1;
-		if (top < lowmem_end_addr)
-			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
-		else if (reg->base < lowmem_end_addr) {
-			unsigned long trunc_size = lowmem_end_addr - reg->base;
-			reserve_bootmem(reg->base, trunc_size, BOOTMEM_DEFAULT);
-		}
-	}
-#else
-	free_bootmem_with_active_regions(0, max_pfn);
-
-	/* reserve the sections we're already using */
-	for_each_memblock(reserved, reg)
-		reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
-#endif
 	/* XXX need to clip this if using highmem? */
 	sparse_memory_present_with_active_regions(0);
-
-	init_bootmem_done = 1;
 }
 
 /* mark pages that don't exist as nosave */
@@ -302,14 +253,6 @@ void __init paging_init(void)
 }
 #endif /* ! CONFIG_NEED_MULTIPLE_NODES */
 
-static void __init register_page_bootmem_info(void)
-{
-	int i;
-
-	for_each_online_node(i)
-		register_page_bootmem_info_node(NODE_DATA(i));
-}
-
 void __init mem_init(void)
 {
 	/*
@@ -322,7 +265,6 @@ void __init mem_init(void)
 	swiotlb_init(0);
 #endif
 
-	register_page_bootmem_info();
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 	set_max_mapnr(max_pfn);
 	free_all_bootmem();
Index: b/arch/powerpc/mm/numa.c
===================================================================
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -132,28 +132,6 @@ static int __init fake_numa_create_new_n
 	return 0;
 }
 
-/*
- * get_node_active_region - Return active region containing pfn
- * Active range returned is empty if none found.
- * @pfn: The page to return the region for
- * @node_ar: Returned set to the active region containing @pfn
- */
-static void __init get_node_active_region(unsigned long pfn,
-					  struct node_active_region *node_ar)
-{
-	unsigned long start_pfn, end_pfn;
-	int i, nid;
-
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
-		if (pfn >= start_pfn && pfn < end_pfn) {
-			node_ar->nid = nid;
-			node_ar->start_pfn = start_pfn;
-			node_ar->end_pfn = end_pfn;
-			break;
-		}
-	}
-}
-
 static void reset_numa_cpu_lookup_table(void)
 {
 	unsigned int cpu;
@@ -924,134 +902,48 @@ static void __init dump_numa_memory_topo
 	}
 }
 
-/*
- * Allocate some memory, satisfying the memblock or bootmem allocator where
- * required. nid is the preferred node and end is the physical address of
- * the highest address in the node.
- *
- * Returns the virtual address of the memory.
- */
-static void __init *careful_zallocation(int nid, unsigned long size,
-				       unsigned long align,
-				       unsigned long end_pfn)
-{
-	void *ret;
-	int new_nid;
-	unsigned long ret_paddr;
-
-	ret_paddr = __memblock_alloc_base(size, align, end_pfn << PAGE_SHIFT);
-
-	/* retry over all memory */
-	if (!ret_paddr)
-		ret_paddr = __memblock_alloc_base(size, align, memblock_end_of_DRAM());
-
-	if (!ret_paddr)
-		panic("numa.c: cannot allocate %lu bytes for node %d",
-		      size, nid);
-
-	ret = __va(ret_paddr);
-
-	/*
-	 * We initialize the nodes in numeric order: 0, 1, 2...
-	 * and hand over control from the MEMBLOCK allocator to the
-	 * bootmem allocator.  If this function is called for
-	 * node 5, then we know that all nodes <5 are using the
-	 * bootmem allocator instead of the MEMBLOCK allocator.
-	 *
-	 * So, check the nid from which this allocation came
-	 * and double check to see if we need to use bootmem
-	 * instead of the MEMBLOCK.  We don't free the MEMBLOCK memory
-	 * since it would be useless.
-	 */
-	new_nid = early_pfn_to_nid(ret_paddr >> PAGE_SHIFT);
-	if (new_nid < nid) {
-		ret = __alloc_bootmem_node(NODE_DATA(new_nid),
-				size, align, 0);
-
-		dbg("alloc_bootmem %p %lx\n", ret, size);
-	}
-
-	memset(ret, 0, size);
-	return ret;
-}
-
 static struct notifier_block ppc64_numa_nb = {
 	.notifier_call = cpu_numa_callback,
 	.priority = 1 /* Must run before sched domains notifier. */
 };
 
-static void __init mark_reserved_regions_for_nid(int nid)
+/* Initialize NODE_DATA for a node on the local memory */
+static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 {
-	struct pglist_data *node = NODE_DATA(nid);
-	struct memblock_region *reg;
+	u64 spanned_pages = end_pfn - start_pfn;
+	const size_t nd_size = roundup(sizeof(pg_data_t), SMP_CACHE_BYTES);
+	u64 nd_pa;
+	void *nd;
+	int tnid;
+
+	if (spanned_pages)
+		pr_info("Initmem setup node %d [mem %#010Lx-%#010Lx]\n",
+			nid, start_pfn << PAGE_SHIFT,
+			(end_pfn << PAGE_SHIFT) - 1);
+	else
+		pr_info("Initmem setup node %d\n", nid);
 
-	for_each_memblock(reserved, reg) {
-		unsigned long physbase = reg->base;
-		unsigned long size = reg->size;
-		unsigned long start_pfn = physbase >> PAGE_SHIFT;
-		unsigned long end_pfn = PFN_UP(physbase + size);
-		struct node_active_region node_ar;
-		unsigned long node_end_pfn = pgdat_end_pfn(node);
+	nd_pa = memblock_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
+	nd = __va(nd_pa);
 
-		/*
-		 * Check to make sure that this memblock.reserved area is
-		 * within the bounds of the node that we care about.
-		 * Checking the nid of the start and end points is not
-		 * sufficient because the reserved area could span the
-		 * entire node.
-		 */
-		if (end_pfn <= node->node_start_pfn ||
-		    start_pfn >= node_end_pfn)
-			continue;
-
-		get_node_active_region(start_pfn, &node_ar);
-		while (start_pfn < end_pfn &&
-			node_ar.start_pfn < node_ar.end_pfn) {
-			unsigned long reserve_size = size;
-			/*
-			 * if reserved region extends past active region
-			 * then trim size to active region
-			 */
-			if (end_pfn > node_ar.end_pfn)
-				reserve_size = (node_ar.end_pfn << PAGE_SHIFT)
-					- physbase;
-			/*
-			 * Only worry about *this* node, others may not
-			 * yet have valid NODE_DATA().
-			 */
-			if (node_ar.nid == nid) {
-				dbg("reserve_bootmem %lx %lx nid=%d\n",
-					physbase, reserve_size, node_ar.nid);
-				reserve_bootmem_node(NODE_DATA(node_ar.nid),
-						physbase, reserve_size,
-						BOOTMEM_DEFAULT);
-			}
-			/*
-			 * if reserved region is contained in the active region
-			 * then done.
-			 */
-			if (end_pfn <= node_ar.end_pfn)
-				break;
-
-			/*
-			 * reserved region extends past the active region
-			 *   get next active region that contains this
-			 *   reserved region
-			 */
-			start_pfn = node_ar.end_pfn;
-			physbase = start_pfn << PAGE_SHIFT;
-			size = size - reserve_size;
-			get_node_active_region(start_pfn, &node_ar);
-		}
-	}
+	/* report and initialize */
+	pr_info("  NODE_DATA [mem %#010Lx-%#010Lx]\n",
+		nd_pa, nd_pa + nd_size - 1);
+	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
+	if (tnid != nid)
+		pr_info("    NODE_DATA(%d) on node %d\n", nid, tnid);
+
+	node_data[nid] = nd;
+	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
+	NODE_DATA(nid)->node_id = nid;
+	NODE_DATA(nid)->node_start_pfn = start_pfn;
+	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
 }
 
-
-void __init do_init_bootmem(void)
+void __init initmem_init(void)
 {
 	int nid;
 
-	min_low_pfn = 0;
 	max_low_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
 	max_pfn = max_low_pfn;
 
@@ -1060,64 +952,16 @@ void __init do_init_bootmem(void)
 	else
 		dump_numa_memory_topology();
 
+	memblock_dump_all();
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
-		void *bootmem_vaddr;
-		unsigned long bootmap_pages;
 
 		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
-
-		/*
-		 * Allocate the node structure node local if possible
-		 *
-		 * Be careful moving this around, as it relies on all
-		 * previous nodes' bootmem to be initialized and have
-		 * all reserved areas marked.
-		 */
-		NODE_DATA(nid) = careful_zallocation(nid,
-					sizeof(struct pglist_data),
-					SMP_CACHE_BYTES, end_pfn);
-
-  		dbg("node %d\n", nid);
-		dbg("NODE_DATA() = %p\n", NODE_DATA(nid));
-
-		NODE_DATA(nid)->bdata = &bootmem_node_data[nid];
-		NODE_DATA(nid)->node_start_pfn = start_pfn;
-		NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
-
-		if (NODE_DATA(nid)->node_spanned_pages == 0)
-  			continue;
-
-  		dbg("start_paddr = %lx\n", start_pfn << PAGE_SHIFT);
-  		dbg("end_paddr = %lx\n", end_pfn << PAGE_SHIFT);
-
-		bootmap_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
-		bootmem_vaddr = careful_zallocation(nid,
-					bootmap_pages << PAGE_SHIFT,
-					PAGE_SIZE, end_pfn);
-
-		dbg("bootmap_vaddr = %p\n", bootmem_vaddr);
-
-		init_bootmem_node(NODE_DATA(nid),
-				  __pa(bootmem_vaddr) >> PAGE_SHIFT,
-				  start_pfn, end_pfn);
-
-		free_bootmem_with_active_regions(nid, end_pfn);
-		/*
-		 * Be very careful about moving this around.  Future
-		 * calls to careful_zallocation() depend on this getting
-		 * done correctly.
-		 */
-		mark_reserved_regions_for_nid(nid);
+		setup_node_data(nid, start_pfn, end_pfn);
 		sparse_memory_present_with_active_regions(nid);
 	}
 
-	init_bootmem_done = 1;
-
-	/*
-	 * Now bootmem is initialised we can create the node to cpumask
-	 * lookup tables and setup the cpu callback to populate them.
-	 */
 	setup_node_to_cpumask_map();
 
 	reset_numa_cpu_lookup_table();
Index: b/arch/powerpc/mm/pgtable_32.c
===================================================================
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -100,12 +100,11 @@ __init_refok pte_t *pte_alloc_one_kernel
 {
 	pte_t *pte;
 	extern int mem_init_done;
-	extern void *early_get_page(void);
 
 	if (mem_init_done) {
 		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	} else {
-		pte = (pte_t *)early_get_page();
+		pte = __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
 		if (pte)
 			clear_page(pte);
 	}
Index: b/arch/powerpc/mm/pgtable_64.c
===================================================================
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -72,11 +72,7 @@ static void *early_alloc_pgtable(unsigne
 {
 	void *pt;
 
-	if (init_bootmem_done)
-		pt = __alloc_bootmem(size, size, __pa(MAX_DMA_ADDRESS));
-	else
-		pt = __va(memblock_alloc_base(size, size,
-					 __pa(MAX_DMA_ADDRESS)));
+	pt = __va(memblock_alloc_base(size, size, __pa(MAX_DMA_ADDRESS)));
 	memset(pt, 0, size);
 
 	return pt;

Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0E90B7B8A
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 13:22:34 +1000 (EST)
Message-ID: <4ABC376D.1020704@kernel.org>
Date: Fri, 25 Sep 2009 12:22:21 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.31-git5 kernel boot hangs on powerpc
References: <4AB0D947.8010301@in.ibm.com> <4AB214C3.4040109@in.ibm.com>	
	<1253185994.8375.352.camel@pasglop>	<4AB25B61.9020609@kernel.org>	
	<4AB266AF.9080705@in.ibm.com> <4AB49C37.6020003@in.ibm.com>	
	<4AB9DAEC.3060309@in.ibm.com> <4AB9DD8F.1040305@kernel.org>	
	<4ABA2DE2.6000601@kernel.org> <4ABB269F.6020309@in.ibm.com>	
	<4ABB6D33.6060706@kernel.org> <4ABB72BD.9050905@in.ibm.com>
	<1253826309.7103.461.camel@pasglop>
In-Reply-To: <1253826309.7103.461.camel@pasglop>
Content-Type: multipart/mixed; boundary="------------020001020206040400080501"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020001020206040400080501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
>> --- Exception: 301 at .memset+0x60/0xfc
>>     LR = .pcpu_alloc+0x718/0x8fc
> 
> So it's memsetting something that causes it to hash_page(), ie, faulting
> in pages (vmalloc space ?) so far nothing obviously wrong....

It's probably memset() call near the end of pcpu_populate_chunk()
where percpu allocator clears the allocated areas before returning to
user.  I don't think the first chunk is causing the problem as they're
all in the linear mapped area.  From the second chunk on, they're on
vmalloc area and very near to the top of it, so that might be exposing
a hidden problem in paging code?  BTW, for some reason, the problem is
not reproducible on my powerstation.

Sachin, can you please apply the attached patch on top of the current
linus tree, reproduce the hang and report full kernel log?  Let's see
which address is causing the problem.

Thanks.

-- 
tejun

--------------020001020206040400080501
Content-Type: text/x-patch;
 name="pcpu-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcpu-debug.patch"

Index: work/mm/percpu.c
===================================================================
--- work.orig/mm/percpu.c
+++ work/mm/percpu.c
@@ -100,9 +100,11 @@ struct pcpu_chunk {
 	int			*map;		/* allocation map */
 	struct vm_struct	**vms;		/* mapped vmalloc regions */
 	bool			immutable;	/* no [de]population allowed */
+	int			id;
 	unsigned long		populated[];	/* populated bitmap */
 };
 
+static int pcpu_chunk_id = 0;
 static int pcpu_unit_pages __read_mostly;
 static int pcpu_unit_size __read_mostly;
 static int pcpu_nr_units __read_mostly;
@@ -314,10 +316,15 @@ static void pcpu_chunk_relocate(struct p
 	int nslot = pcpu_chunk_slot(chunk);
 
 	if (chunk != pcpu_reserved_chunk && oslot != nslot) {
+		printk("PERCPU: chunk %d relocating %d -> %d %p <%p:%p>\n",
+		       chunk->id, oslot, nslot, &chunk->list,
+		       chunk->list.prev, chunk->list.next);
 		if (oslot < nslot)
 			list_move(&chunk->list, &pcpu_slot[nslot]);
 		else
 			list_move_tail(&chunk->list, &pcpu_slot[nslot]);
+		printk("PERCPU: relocated <%p:%p>\n",
+		       chunk->list.prev, chunk->list.next);
 	}
 }
 
@@ -789,6 +796,11 @@ static void pcpu_post_unmap_tlb_flush(st
 static int __pcpu_map_pages(unsigned long addr, struct page **pages,
 			    int nr_pages)
 {
+	int i;
+	printk("PERCPU: map 0x%lx, %d pages", addr, nr_pages);
+	for (i = 0; i < nr_pages; i++)
+		printk(" %lu", page_to_pfn(pages[i]));
+	printk("\n");
 	return map_kernel_range_noflush(addr, nr_pages << PAGE_SHIFT,
 					PAGE_KERNEL, pages);
 }
@@ -957,6 +969,7 @@ static int pcpu_populate_chunk(struct pc
 
 	/* alloc and map */
 	pcpu_for_each_unpop_region(chunk, rs, re, page_start, page_end) {
+		printk("PERCPU: chunk %d, alloc pages [%d,%d)\n", chunk->id, rs, re);
 		rc = pcpu_alloc_pages(chunk, pages, populated, rs, re);
 		if (rc)
 			goto err_free;
@@ -964,6 +977,7 @@ static int pcpu_populate_chunk(struct pc
 	}
 
 	pcpu_for_each_unpop_region(chunk, rs, re, page_start, page_end) {
+		printk("PERCPU: chunk %d, map pages [%d,%d)\n", chunk->id, rs, re);
 		rc = pcpu_map_pages(chunk, pages, populated, rs, re);
 		if (rc)
 			goto err_unmap;
@@ -973,6 +987,10 @@ static int pcpu_populate_chunk(struct pc
 
 	/* commit new bitmap */
 	bitmap_copy(chunk->populated, populated, pcpu_unit_pages);
+	printk("PERCPU: chunk %d, will clear %db/unit", chunk->id, size);
+	for_each_possible_cpu(cpu)
+		printk(" %p", (void *)pcpu_chunk_addr(chunk, cpu, 0) + off);
+	printk("\n");
 clear:
 	for_each_possible_cpu(cpu)
 		memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, size);
@@ -1043,7 +1061,9 @@ static struct pcpu_chunk *alloc_pcpu_chu
  */
 static void *pcpu_alloc(size_t size, size_t align, bool reserved)
 {
+	static int warn_limit = 10;
 	struct pcpu_chunk *chunk;
+	const char *err;
 	int slot, off;
 
 	if (unlikely(!size || size > PCPU_MIN_UNIT_SIZE || align > PAGE_SIZE)) {
@@ -1059,11 +1079,14 @@ static void *pcpu_alloc(size_t size, siz
 	if (reserved && pcpu_reserved_chunk) {
 		chunk = pcpu_reserved_chunk;
 		if (size > chunk->contig_hint ||
-		    pcpu_extend_area_map(chunk) < 0)
+		    pcpu_extend_area_map(chunk) < 0) {
+			err = "failed to extend area map of reserved chunk";
 			goto fail_unlock;
+		}
 		off = pcpu_alloc_area(chunk, size, align);
 		if (off >= 0)
 			goto area_found;
+		err = "alloc from reserved chunk failed";
 		goto fail_unlock;
 	}
 
@@ -1080,6 +1103,7 @@ restart:
 			case 1:
 				goto restart;	/* pcpu_lock dropped, restart */
 			default:
+				err = "failed to extend area map";
 				goto fail_unlock;
 			}
 
@@ -1093,10 +1117,13 @@ restart:
 	spin_unlock_irq(&pcpu_lock);
 
 	chunk = alloc_pcpu_chunk();
-	if (!chunk)
+	if (!chunk) {
+		err = "failed to allocate new chunk";
 		goto fail_unlock_mutex;
+	}
 
 	spin_lock_irq(&pcpu_lock);
+	chunk->id = pcpu_chunk_id++;
 	pcpu_chunk_relocate(chunk, -1);
 	goto restart;
 
@@ -1107,6 +1134,7 @@ area_found:
 	if (pcpu_populate_chunk(chunk, off, size)) {
 		spin_lock_irq(&pcpu_lock);
 		pcpu_free_area(chunk, off);
+		err = "failed to populate";
 		goto fail_unlock;
 	}
 
@@ -1119,6 +1147,13 @@ fail_unlock:
 	spin_unlock_irq(&pcpu_lock);
 fail_unlock_mutex:
 	mutex_unlock(&pcpu_alloc_mutex);
+	if (warn_limit) {
+		pr_warning("PERCPU: allocation failed, size=%zu align=%zu, "
+			   "%s\n", size, align, err);
+		dump_stack();
+		if (!--warn_limit)
+			pr_info("PERCPU: limit reached, disable warning\n");
+	}
 	return NULL;
 }
 
@@ -1347,6 +1382,10 @@ struct pcpu_alloc_info * __init pcpu_bui
 	struct pcpu_alloc_info *ai;
 	unsigned int *cpu_map;
 
+	/* this function may be called multiple times */
+	memset(group_map, 0, sizeof(group_map));
+	memset(group_cnt, 0, sizeof(group_map));
+
 	/*
 	 * Determine min_unit_size, alloc_size and max_upa such that
 	 * alloc_size is multiple of atom_size and is the smallest
@@ -1574,6 +1613,7 @@ static void pcpu_dump_alloc_info(const c
 int __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 				  void *base_addr)
 {
+	static char cpus_buf[4096] __initdata;
 	static int smap[2], dmap[2];
 	size_t dyn_size = ai->dyn_size;
 	size_t size_sum = ai->static_size + ai->reserved_size + dyn_size;
@@ -1585,17 +1625,26 @@ int __init pcpu_setup_first_chunk(const
 	int *unit_map;
 	int group, unit, i;
 
+	cpumask_scnprintf(cpus_buf, sizeof(cpus_buf), cpu_possible_mask);
+
+#define PCPU_SETUP_BUG_ON(cond)	do {					\
+	if (unlikely(cond)) {						\
+		pr_emerg("PERCPU: failed to initialize, %s", #cond);	\
+		pr_emerg("PERCPU: cpu_possible_mask=%s\n", cpus_buf);	\
+		pcpu_dump_alloc_info(KERN_EMERG, ai);			\
+		BUG();							\
+	}								\
+} while (0)
+
 	/* sanity checks */
 	BUILD_BUG_ON(ARRAY_SIZE(smap) >= PCPU_DFL_MAP_ALLOC ||
 		     ARRAY_SIZE(dmap) >= PCPU_DFL_MAP_ALLOC);
-	BUG_ON(ai->nr_groups <= 0);
-	BUG_ON(!ai->static_size);
-	BUG_ON(!base_addr);
-	BUG_ON(ai->unit_size < size_sum);
-	BUG_ON(ai->unit_size & ~PAGE_MASK);
-	BUG_ON(ai->unit_size < PCPU_MIN_UNIT_SIZE);
-
-	pcpu_dump_alloc_info(KERN_DEBUG, ai);
+	PCPU_SETUP_BUG_ON(ai->nr_groups <= 0);
+	PCPU_SETUP_BUG_ON(!ai->static_size);
+	PCPU_SETUP_BUG_ON(!base_addr);
+	PCPU_SETUP_BUG_ON(ai->unit_size < size_sum);
+	PCPU_SETUP_BUG_ON(ai->unit_size & ~PAGE_MASK);
+	PCPU_SETUP_BUG_ON(ai->unit_size < PCPU_MIN_UNIT_SIZE);
 
 	/* process group information and build config tables accordingly */
 	group_offsets = alloc_bootmem(ai->nr_groups * sizeof(group_offsets[0]));
@@ -1618,8 +1667,9 @@ int __init pcpu_setup_first_chunk(const
 			if (cpu == NR_CPUS)
 				continue;
 
-			BUG_ON(cpu > nr_cpu_ids || !cpu_possible(cpu));
-			BUG_ON(unit_map[cpu] != NR_CPUS);
+			PCPU_SETUP_BUG_ON(cpu > nr_cpu_ids);
+			PCPU_SETUP_BUG_ON(!cpu_possible(cpu));
+			PCPU_SETUP_BUG_ON(unit_map[cpu] != NR_CPUS);
 
 			unit_map[cpu] = unit + i;
 			unit_off[cpu] = gi->base_offset + i * ai->unit_size;
@@ -1632,7 +1682,11 @@ int __init pcpu_setup_first_chunk(const
 	pcpu_nr_units = unit;
 
 	for_each_possible_cpu(cpu)
-		BUG_ON(unit_map[cpu] == NR_CPUS);
+		PCPU_SETUP_BUG_ON(unit_map[cpu] == NR_CPUS);
+
+	/* we're done parsing the input, undefine BUG macro and dump config */
+#undef PCPU_SETUP_BUG_ON
+	pcpu_dump_alloc_info(KERN_INFO, ai);
 
 	pcpu_nr_groups = ai->nr_groups;
 	pcpu_group_offsets = group_offsets;
@@ -1655,6 +1709,8 @@ int __init pcpu_setup_first_chunk(const
 	pcpu_slot = alloc_bootmem(pcpu_nr_slots * sizeof(pcpu_slot[0]));
 	for (i = 0; i < pcpu_nr_slots; i++)
 		INIT_LIST_HEAD(&pcpu_slot[i]);
+	printk("PERCPU: initialized %d slots [%p,%p)\n", pcpu_nr_slots,
+	       &pcpu_slot[0], &pcpu_slot[i]);
 
 	/*
 	 * Initialize static chunk.  If reserved_size is zero, the
@@ -1673,6 +1729,7 @@ int __init pcpu_setup_first_chunk(const
 
 	if (ai->reserved_size) {
 		schunk->free_size = ai->reserved_size;
+		schunk->id = -1;
 		pcpu_reserved_chunk = schunk;
 		pcpu_reserved_chunk_limit = ai->static_size + ai->reserved_size;
 	} else {
@@ -1702,6 +1759,7 @@ int __init pcpu_setup_first_chunk(const
 
 	/* link the first chunk in */
 	pcpu_first_chunk = dchunk ?: schunk;
+	pcpu_first_chunk->id = pcpu_chunk_id++;
 	pcpu_chunk_relocate(pcpu_first_chunk, -1);
 
 	/* we're done */
@@ -1782,7 +1840,7 @@ int __init pcpu_embed_first_chunk(size_t
 	void *base = (void *)ULONG_MAX;
 	void **areas = NULL;
 	struct pcpu_alloc_info *ai;
-	size_t size_sum, areas_size;
+	size_t size_sum, areas_size, max_distance;
 	int group, i, rc;
 
 	ai = pcpu_build_alloc_info(reserved_size, dyn_size, atom_size,
@@ -1832,8 +1890,24 @@ int __init pcpu_embed_first_chunk(size_t
 	}
 
 	/* base address is now known, determine group base offsets */
-	for (group = 0; group < ai->nr_groups; group++)
+	max_distance = 0;
+	for (group = 0; group < ai->nr_groups; group++) {
 		ai->groups[group].base_offset = areas[group] - base;
+		max_distance = max(max_distance, ai->groups[group].base_offset);
+	}
+	max_distance += ai->unit_size;
+
+	/* warn if maximum distance is further than 75% of vmalloc space */
+	if (max_distance > (VMALLOC_END - VMALLOC_START) * 3 / 4) {
+		pr_warning("PERCPU: max_distance=0x%lx too large for vmalloc "
+			   "space 0x%lx\n",
+			   max_distance, VMALLOC_END - VMALLOC_START);
+#ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
+		/* and fail if we have fallback */
+		rc = -EINVAL;
+		goto out_free;
+#endif
+	}
 
 	pr_info("PERCPU: Embedded %zu pages/cpu @%p s%zu r%zu d%zu u%zu\n",
 		PFN_DOWN(size_sum), base, ai->static_size, ai->reserved_size,
Index: work/arch/sparc/Kconfig
===================================================================
--- work.orig/arch/sparc/Kconfig
+++ work/arch/sparc/Kconfig
@@ -102,6 +102,9 @@ config HAVE_SETUP_PER_CPU_AREA
 config NEED_PER_CPU_EMBED_FIRST_CHUNK
 	def_bool y if SPARC64
 
+config NEED_PER_CPU_PAGE_FIRST_CHUNK
+	def_bool y if SPARC64
+
 config GENERIC_HARDIRQS_NO__DO_IRQ
 	bool
 	def_bool y if SPARC64
Index: work/arch/sparc/kernel/smp_64.c
===================================================================
--- work.orig/arch/sparc/kernel/smp_64.c
+++ work/arch/sparc/kernel/smp_64.c
@@ -1420,7 +1420,7 @@ static void __init pcpu_free_bootmem(voi
 	free_bootmem(__pa(ptr), size);
 }
 
-static int pcpu_cpu_distance(unsigned int from, unsigned int to)
+static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
 {
 	if (cpu_to_node(from) == cpu_to_node(to))
 		return LOCAL_DISTANCE;
@@ -1428,18 +1428,53 @@ static int pcpu_cpu_distance(unsigned in
 		return REMOTE_DISTANCE;
 }
 
+static void __init pcpu_populate_pte(unsigned long addr)
+{
+	pgd_t *pgd = pgd_offset_k(addr);
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pud = pud_offset(pgd, addr);
+	if (pud_none(*pud)) {
+		pmd_t *new;
+
+		new = __alloc_bootmem(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+		pud_populate(&init_mm, pud, new);
+	}
+
+	pmd = pmd_offset(pud, addr);
+	if (!pmd_present(*pmd)) {
+		pte_t *new;
+
+		new = __alloc_bootmem(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+		pmd_populate_kernel(&init_mm, pmd, new);
+	}
+}
+
 void __init setup_per_cpu_areas(void)
 {
 	unsigned long delta;
 	unsigned int cpu;
-	int rc;
+	int rc = -EINVAL;
 
-	rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
-				    PERCPU_DYNAMIC_RESERVE, 4 << 20,
-				    pcpu_cpu_distance, pcpu_alloc_bootmem,
-				    pcpu_free_bootmem);
-	if (rc)
-		panic("failed to initialize first chunk (%d)", rc);
+	if (pcpu_chosen_fc != PCPU_FC_PAGE) {
+		rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
+					    PERCPU_DYNAMIC_RESERVE, 4 << 20,
+					    pcpu_cpu_distance,
+					    pcpu_alloc_bootmem,
+					    pcpu_free_bootmem);
+		if (rc)
+			pr_warning("PERCPU: %s allocator failed (%d), "
+				   "falling back to page size\n",
+				   pcpu_fc_names[pcpu_chosen_fc], rc);
+	}
+	if (rc < 0)
+		rc = pcpu_page_first_chunk(PERCPU_MODULE_RESERVE,
+					   pcpu_alloc_bootmem,
+					   pcpu_free_bootmem,
+					   pcpu_populate_pte);
+	if (rc < 0)
+		panic("cannot initialize percpu area (err=%d)", rc);
 
 	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
 	for_each_possible_cpu(cpu)

--------------020001020206040400080501--

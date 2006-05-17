Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 17 May 2006 18:00:46 +1000
Subject: [PATCH 3/5] powerpc: Unify mem= handling
In-Reply-To: <1147852841.148164.91320074069.qpush@concordia>
Message-Id: <20060517080046.DE42067A05@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We currently do mem= handling in three seperate places. And as benh pointed out
I wrote two of them. Now that we parse command line parameters earlier we can
clean this mess up.

Moving the parsing out of prom_init means the device tree might be allocated
above the memory limit. If that happens we'd have to move it. As it happens
we already have logic to do that for kdump, so just genericise it.

This also means we might have reserved regions above the memory limit, if we
do the bootmem allocator will blow up, so we have to modify
lmb_enforce_memory_limit() to truncate the reserves as well.

Tested on P5 LPAR, iSeries, F50, 44p. Tested moving device tree on P5 and
44p and F50.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/machine_kexec_64.c |    5 +
 arch/powerpc/kernel/prom.c             |   89 +++++++++++++++++----------------
 arch/powerpc/kernel/prom_init.c        |   55 +-------------------
 arch/powerpc/kernel/setup_64.c         |    3 -
 arch/powerpc/mm/lmb.c                  |   43 +++++++++++----
 arch/powerpc/platforms/iseries/setup.c |   22 --------
 include/asm-powerpc/kexec.h            |   13 ++++
 7 files changed, 100 insertions(+), 130 deletions(-)

Index: to-merge/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/machine_kexec_64.c
+++ to-merge/arch/powerpc/kernel/machine_kexec_64.c
@@ -339,3 +339,8 @@ void __init kexec_setup(void)
 {
 	export_htab_values();
 }
+
+int overlaps_crashkernel(unsigned long start, unsigned long size)
+{
+	return (start + size) > crashk_res.start && start <= crashk_res.end;
+}
Index: to-merge/arch/powerpc/kernel/prom.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/prom.c
+++ to-merge/arch/powerpc/kernel/prom.c
@@ -50,6 +50,7 @@
 #include <asm/machdep.h>
 #include <asm/pSeries_reconfig.h>
 #include <asm/pci-bridge.h>
+#include <asm/kexec.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) printk(KERN_ERR fmt)
@@ -836,6 +837,42 @@ static unsigned long __init unflatten_dt
 	return mem;
 }
 
+static int __init early_parse_mem(char *p)
+{
+	if (!p)
+		return 1;
+
+	memory_limit = PAGE_ALIGN(memparse(p, &p));
+	DBG("memory limit = 0x%lx\n", memory_limit);
+
+	return 0;
+}
+early_param("mem", early_parse_mem);
+
+/*
+ * The device tree may be allocated below our memory limit, or inside the
+ * crash kernel region for kdump. If so, move it out now.
+ */
+static void move_device_tree(void)
+{
+	unsigned long start, size;
+	void *p;
+
+	DBG("-> move_device_tree\n");
+
+	start = __pa(initial_boot_params);
+	size = initial_boot_params->totalsize;
+
+	if ((memory_limit && (start + size) > memory_limit) ||
+			overlaps_crashkernel(start, size)) {
+		p = __va(lmb_alloc_base(size, PAGE_SIZE, lmb.rmo_size));
+		memcpy(p, initial_boot_params, size);
+		initial_boot_params = (struct boot_param_header *)p;
+		DBG("Moved device tree to 0x%p\n", p);
+	}
+
+	DBG("<- move_device_tree\n");
+}
 
 /**
  * unflattens the device-tree passed by the firmware, creating the
@@ -1070,6 +1107,7 @@ static int __init early_init_dt_scan_cho
 		iommu_force_on = 1;
 #endif
 
+	/* mem=x on the command line is the preferred mechanism */
  	lprop = of_get_flat_dt_prop(node, "linux,memory-limit", NULL);
  	if (lprop)
  		memory_limit = *lprop;
@@ -1123,17 +1161,6 @@ static int __init early_init_dt_scan_cho
 
 	DBG("Command line is: %s\n", cmd_line);
 
-	if (strstr(cmd_line, "mem=")) {
-		char *p, *q;
-
-		for (q = cmd_line; (p = strstr(q, "mem=")) != 0; ) {
-			q = p + 4;
-			if (p > cmd_line && p[-1] != ' ')
-				continue;
-			memory_limit = memparse(q, &q);
-		}
-	}
-
 	/* break now */
 	return 1;
 }
@@ -1297,11 +1324,6 @@ void __init early_init_devtree(void *par
 	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
 	parse_early_param();
 
-	lmb_enforce_memory_limit(memory_limit);
-	lmb_analyze();
-
-	DBG("Phys. mem: %lx\n", lmb_phys_mem_size());
-
 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
 	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
 #ifdef CONFIG_CRASH_DUMP
@@ -1309,6 +1331,15 @@ void __init early_init_devtree(void *par
 #endif
 	early_reserve_mem();
 
+	lmb_enforce_memory_limit(memory_limit);
+	lmb_analyze();
+
+	DBG("Phys. mem: %lx\n", lmb_phys_mem_size());
+
+	/* We may need to relocate the flat tree, do it now.
+	 * FIXME .. and the initrd too? */
+	move_device_tree();
+
 	DBG("Scanning CPUs ...\n");
 
 	/* Retreive CPU related informations from the flat tree
@@ -2058,29 +2089,3 @@ int prom_update_property(struct device_n
 	return 0;
 }
 
-#ifdef CONFIG_KEXEC
-/* We may have allocated the flat device tree inside the crash kernel region
- * in prom_init. If so we need to move it out into regular memory. */
-void kdump_move_device_tree(void)
-{
-	unsigned long start, end;
-	struct boot_param_header *new;
-
-	start = __pa((unsigned long)initial_boot_params);
-	end = start + initial_boot_params->totalsize;
-
-	if (end < crashk_res.start || start > crashk_res.end)
-		return;
-
-	new = (struct boot_param_header*)
-		__va(lmb_alloc(initial_boot_params->totalsize, PAGE_SIZE));
-
-	memcpy(new, initial_boot_params, initial_boot_params->totalsize);
-
-	initial_boot_params = new;
-
-	DBG("Flat device tree blob moved to %p\n", initial_boot_params);
-
-	/* XXX should we unreserve the old DT? */
-}
-#endif /* CONFIG_KEXEC */
Index: to-merge/arch/powerpc/kernel/prom_init.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/prom_init.c
+++ to-merge/arch/powerpc/kernel/prom_init.c
@@ -194,8 +194,6 @@ static int __initdata of_platform;
 
 static char __initdata prom_cmd_line[COMMAND_LINE_SIZE];
 
-static unsigned long __initdata prom_memory_limit;
-
 static unsigned long __initdata alloc_top;
 static unsigned long __initdata alloc_top_high;
 static unsigned long __initdata alloc_bottom;
@@ -594,16 +592,6 @@ static void __init early_cmdline_parse(v
 	}
 #endif
 
-	opt = strstr(RELOC(prom_cmd_line), RELOC("mem="));
-	if (opt) {
-		opt += 4;
-		RELOC(prom_memory_limit) = prom_memparse(opt, (const char **)&opt);
-#ifdef CONFIG_PPC64
-		/* Align to 16 MB == size of ppc64 large page */
-		RELOC(prom_memory_limit) = ALIGN(RELOC(prom_memory_limit), 0x1000000);
-#endif
-	}
-
 #ifdef CONFIG_KEXEC
 	/*
 	 * crashkernel=size@addr specifies the location to reserve for
@@ -1115,29 +1103,6 @@ static void __init prom_init_mem(void)
 	}
 
 	/*
-	 * If prom_memory_limit is set we reduce the upper limits *except* for
-	 * alloc_top_high. This must be the real top of RAM so we can put
-	 * TCE's up there.
-	 */
-
-	RELOC(alloc_top_high) = RELOC(ram_top);
-
-	if (RELOC(prom_memory_limit)) {
-		if (RELOC(prom_memory_limit) <= RELOC(alloc_bottom)) {
-			prom_printf("Ignoring mem=%x <= alloc_bottom.\n",
-				RELOC(prom_memory_limit));
-			RELOC(prom_memory_limit) = 0;
-		} else if (RELOC(prom_memory_limit) >= RELOC(ram_top)) {
-			prom_printf("Ignoring mem=%x >= ram_top.\n",
-				RELOC(prom_memory_limit));
-			RELOC(prom_memory_limit) = 0;
-		} else {
-			RELOC(ram_top) = RELOC(prom_memory_limit);
-			RELOC(rmo_top) = min(RELOC(rmo_top), RELOC(prom_memory_limit));
-		}
-	}
-
-	/*
 	 * Setup our top alloc point, that is top of RMO or top of
 	 * segment 0 when running non-LPAR.
 	 * Some RS64 machines have buggy firmware where claims up at
@@ -1149,9 +1114,9 @@ static void __init prom_init_mem(void)
 		RELOC(rmo_top) = RELOC(ram_top);
 	RELOC(rmo_top) = min(0x30000000ul, RELOC(rmo_top));
 	RELOC(alloc_top) = RELOC(rmo_top);
+	RELOC(alloc_top_high) = RELOC(ram_top);
 
 	prom_printf("memory layout at init:\n");
-	prom_printf("  memory_limit : %x (16 MB aligned)\n", RELOC(prom_memory_limit));
 	prom_printf("  alloc_bottom : %x\n", RELOC(alloc_bottom));
 	prom_printf("  alloc_top    : %x\n", RELOC(alloc_top));
 	prom_printf("  alloc_top_hi : %x\n", RELOC(alloc_top_high));
@@ -1348,16 +1313,10 @@ static void __init prom_initialize_tce_t
 
 	reserve_mem(local_alloc_bottom, local_alloc_top - local_alloc_bottom);
 
-	if (RELOC(prom_memory_limit)) {
-		/*
-		 * We align the start to a 16MB boundary so we can map
-		 * the TCE area using large pages if possible.
-		 * The end should be the top of RAM so no need to align it.
-		 */
-		RELOC(prom_tce_alloc_start) = _ALIGN_DOWN(local_alloc_bottom,
-							  0x1000000);
-		RELOC(prom_tce_alloc_end) = local_alloc_top;
-	}
+	/* These are only really needed if there is a memory limit in
+	 * effect, but we don't know so export them always. */
+	RELOC(prom_tce_alloc_start) = local_alloc_bottom;
+	RELOC(prom_tce_alloc_end) = local_alloc_top;
 
 	/* Flag the first invalid entry */
 	prom_debug("ending prom_initialize_tce_table\n");
@@ -2265,10 +2224,6 @@ unsigned long __init prom_init(unsigned 
 	/*
 	 * Fill in some infos for use by the kernel later on
 	 */
-	if (RELOC(prom_memory_limit))
-		prom_setprop(_prom->chosen, "/chosen", "linux,memory-limit",
-			     &RELOC(prom_memory_limit),
-			     sizeof(prom_memory_limit));
 #ifdef CONFIG_PPC64
 	if (RELOC(ppc64_iommu_off))
 		prom_setprop(_prom->chosen, "/chosen", "linux,iommu-off",
Index: to-merge/arch/powerpc/kernel/setup_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_64.c
+++ to-merge/arch/powerpc/kernel/setup_64.c
@@ -353,9 +353,6 @@ void __init setup_system(void)
 {
 	DBG(" -> setup_system()\n");
 
-#ifdef CONFIG_KEXEC
-	kdump_move_device_tree();
-#endif
 	/*
 	 * Unflatten the device-tree passed by prom_init or kexec
 	 */
Index: to-merge/arch/powerpc/mm/lmb.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/lmb.c
+++ to-merge/arch/powerpc/mm/lmb.c
@@ -89,20 +89,25 @@ static long __init lmb_regions_adjacent(
 	return lmb_addrs_adjacent(base1, size1, base2, size2);
 }
 
-/* Assumption: base addr of region 1 < base addr of region 2 */
-static void __init lmb_coalesce_regions(struct lmb_region *rgn,
-		unsigned long r1, unsigned long r2)
+static void __init lmb_remove_region(struct lmb_region *rgn, unsigned long r)
 {
 	unsigned long i;
 
-	rgn->region[r1].size += rgn->region[r2].size;
-	for (i=r2; i < rgn->cnt-1; i++) {
-		rgn->region[i].base = rgn->region[i+1].base;
-		rgn->region[i].size = rgn->region[i+1].size;
+	for (i = r; i < rgn->cnt - 1; i++) {
+		rgn->region[i].base = rgn->region[i + 1].base;
+		rgn->region[i].size = rgn->region[i + 1].size;
 	}
 	rgn->cnt--;
 }
 
+/* Assumption: base addr of region 1 < base addr of region 2 */
+static void __init lmb_coalesce_regions(struct lmb_region *rgn,
+		unsigned long r1, unsigned long r2)
+{
+	rgn->region[r1].size += rgn->region[r2].size;
+	lmb_remove_region(rgn, r2);
+}
+
 /* This routine called with relocation disabled. */
 void __init lmb_init(void)
 {
@@ -294,17 +299,16 @@ unsigned long __init lmb_end_of_DRAM(voi
 	return (lmb.memory.region[idx].base + lmb.memory.region[idx].size);
 }
 
-/*
- * Truncate the lmb list to memory_limit if it's set
- * You must call lmb_analyze() after this.
- */
+/* You must call lmb_analyze() after this. */
 void __init lmb_enforce_memory_limit(unsigned long memory_limit)
 {
 	unsigned long i, limit;
+	struct lmb_property *p;
 
 	if (! memory_limit)
 		return;
 
+	/* Truncate the lmb regions to satisfy the memory limit. */
 	limit = memory_limit;
 	for (i = 0; i < lmb.memory.cnt; i++) {
 		if (limit > lmb.memory.region[i].size) {
@@ -316,4 +320,21 @@ void __init lmb_enforce_memory_limit(uns
 		lmb.memory.cnt = i + 1;
 		break;
 	}
+
+	lmb.rmo_size = lmb.memory.region[0].size;
+
+	/* And truncate any reserves above the limit also. */
+	for (i = 0; i < lmb.reserved.cnt; i++) {
+		p = &lmb.reserved.region[i];
+
+		if (p->base > memory_limit)
+			p->size = 0;
+		else if ((p->base + p->size) > memory_limit)
+			p->size = memory_limit - p->base;
+
+		if (p->size == 0) {
+			lmb_remove_region(&lmb.reserved, i);
+			i--;
+		}
+	}
 }
Index: to-merge/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/setup.c
+++ to-merge/arch/powerpc/platforms/iseries/setup.c
@@ -90,8 +90,6 @@ extern unsigned long embedded_sysmap_end
 extern unsigned long iSeries_recal_tb;
 extern unsigned long iSeries_recal_titan;
 
-static unsigned long cmd_mem_limit;
-
 struct MemoryBlock {
 	unsigned long absStart;
 	unsigned long absEnd;
@@ -1023,8 +1021,6 @@ void build_flat_dt(struct iseries_flat_d
 	/* /chosen */
 	dt_start_node(dt, "chosen");
 	dt_prop_str(dt, "bootargs", cmd_line);
-	if (cmd_mem_limit)
-		dt_prop_u64(dt, "linux,memory-limit", cmd_mem_limit);
 	dt_end_node(dt);
 
 	dt_cpus(dt);
@@ -1050,29 +1046,11 @@ void * __init iSeries_early_setup(void)
 
 	iSeries_get_cmdline();
 
-	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
-
-	/* Parse early parameters, in particular mem=x */
-	parse_early_param();
-
 	build_flat_dt(&iseries_dt, phys_mem_size);
 
 	return (void *) __pa(&iseries_dt);
 }
 
-/*
- * On iSeries we just parse the mem=X option from the command line.
- * On pSeries it's a bit more complicated, see prom_init_mem()
- */
-static int __init early_parsemem(char *p)
-{
-	if (p)
-		cmd_mem_limit = ALIGN(memparse(p, &p), PAGE_SIZE);
-	return 0;
-}
-early_param("mem", early_parsemem);
-
 static void hvputc(char c)
 {
 	if (c == '\n')
Index: to-merge/include/asm-powerpc/kexec.h
===================================================================
--- to-merge.orig/include/asm-powerpc/kexec.h
+++ to-merge/include/asm-powerpc/kexec.h
@@ -31,9 +31,10 @@
 #define KEXEC_ARCH KEXEC_ARCH_PPC
 #endif
 
+#ifndef __ASSEMBLY__
+
 #ifdef CONFIG_KEXEC
 
-#ifndef __ASSEMBLY__
 #ifdef __powerpc64__
 /*
  * This function is responsible for capturing register states if coming
@@ -123,8 +124,16 @@ extern int default_machine_kexec_prepare
 extern void default_machine_crash_shutdown(struct pt_regs *regs);
 
 extern void machine_kexec_simple(struct kimage *image);
+extern int overlaps_crashkernel(unsigned long start, unsigned long size);
+
+#else /* !CONFIG_KEXEC */
+
+static inline int overlaps_crashkernel(unsigned long start, unsigned long size)
+{
+	return 0;
+}
 
-#endif /* ! __ASSEMBLY__ */
 #endif /* CONFIG_KEXEC */
+#endif /* ! __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_KEXEC_H */

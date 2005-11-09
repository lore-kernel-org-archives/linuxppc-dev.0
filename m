Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 14:07:53 +1100
Message-Id: <1131505673.24637.37.camel@gaston>
Mime-Version: 1.0
Subject: [PATCH] Merge platform codes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch merges the _MACH_* and PLATFORM_* codes together, and changes
ppc64 to use _machine instead of systemcfg.h. (The later is also moved
to asm-powerpc, it will be renamed & made common in the next patch that
merges the vDSO).
Later, we'll eventually completely get rid of the platform numbers.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/asm-offsets.c	2005-11-08 11:00:17.000000000 +1100
+++ linux-work/arch/powerpc/kernel/asm-offsets.c	2005-11-09 12:00:55.000000000 +1100
@@ -106,7 +106,6 @@
 	DEFINE(ICACHEL1LINESIZE, offsetof(struct ppc64_caches, iline_size));
 	DEFINE(ICACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_iline_size));
 	DEFINE(ICACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, ilines_per_page));
-	DEFINE(PLATFORM, offsetof(struct systemcfg, platform));
 	DEFINE(PLATFORM_LPAR, PLATFORM_LPAR);
 
 	/* paca */
Index: linux-work/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_64.S	2005-11-08 11:00:17.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_64.S	2005-11-09 12:00:55.000000000 +1100
@@ -28,7 +28,6 @@
 #include <asm/reg.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
-#include <asm/systemcfg.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/bug.h>
@@ -1735,9 +1734,7 @@
 	sc				/* HvCall_setASR */
 #else
 	/* set the ASR */
-	ld	r3,systemcfg@got(r2)	/* r3 = ptr to systemcfg	 */
-	ld	r3,0(r3)
-	lwz	r3,PLATFORM(r3)		/* r3 = platform flags		 */
+	ld	r3,_machine@got(r2)	/* r3 = machine type	 */
 	andi.	r3,r3,PLATFORM_LPAR	/* Test if bit 0 is set (LPAR bit) */
 	beq	98f			/* branch if result is 0  */
 	mfspr	r3,SPRN_PVR
@@ -1899,9 +1896,7 @@
 	/* set the ASR */
 	ld	r3,PACASTABREAL(r13)
 	ori	r4,r3,1			/* turn on valid bit		 */
-	ld	r3,systemcfg@got(r2)	/* r3 = ptr to systemcfg */
-	ld	r3,0(r3)
-	lwz	r3,PLATFORM(r3)		/* r3 = platform flags */
+	ld	r3,_machine@got(r2)	/* r3 = machine type */
 	andi.	r3,r3,PLATFORM_LPAR	/* Test if bit 0 is set (LPAR bit) */
 	beq	98f			/* branch if result is 0  */
 	mfspr	r3,SPRN_PVR
@@ -1919,9 +1914,7 @@
 	mtasr	r4			/* set the stab location	*/
 99:
 	/* Set SDR1 (hash table pointer) */
-	ld	r3,systemcfg@got(r2)	/* r3 = ptr to systemcfg */
-	ld	r3,0(r3)
-	lwz	r3,PLATFORM(r3)		/* r3 = platform flags */
+	ld	r3,_machine@got(r2)	/* r3 = machine */
 	/* Test if bit 0 is set (LPAR bit) */
 	andi.	r3,r3,PLATFORM_LPAR
 	bne	98f			/* branch if result is !0  */
Index: linux-work/arch/powerpc/kernel/prom.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom.c	2005-11-09 12:00:55.000000000 +1100
@@ -48,9 +48,6 @@
 #include <asm/machdep.h>
 #include <asm/pSeries_reconfig.h>
 #include <asm/pci-bridge.h>
-#ifdef CONFIG_PPC64
-#include <asm/systemcfg.h>
-#endif
 
 #ifdef DEBUG
 #define DBG(fmt...) printk(KERN_ERR fmt)
@@ -391,7 +388,7 @@
 
 #ifdef CONFIG_PPC64
 		/* We offset irq numbers for the u3 MPIC by 128 in PowerMac */
-		if (systemcfg->platform == PLATFORM_POWERMAC && ic && ic->parent) {
+		if (_machine == PLATFORM_POWERMAC && ic && ic->parent) {
 			char *name = get_property(ic->parent, "name", NULL);
 			if (name && !strcmp(name, "u3"))
 				np->intrs[intrcount].line += 128;
@@ -1161,13 +1158,9 @@
 	prop = (u32 *)of_get_flat_dt_prop(node, "linux,platform", NULL);
 	if (prop == NULL)
 		return 0;
-#ifdef CONFIG_PPC64
-	systemcfg->platform = *prop;
-#else
-#ifdef CONFIG_PPC_MULTIPLATFORM
+#if defined(CONFIG_PPC64) || defined(CONFIG_PPC_MULTIPLATFORM)
 	_machine = *prop;
 #endif
-#endif
 
 #ifdef CONFIG_PPC64
 	/* check if iommu is forced on or off */
@@ -1339,9 +1332,6 @@
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 	lmb_enforce_memory_limit(memory_limit);
 	lmb_analyze();
-#ifdef CONFIG_PPC64
-	systemcfg->physicalMemorySize = lmb_phys_mem_size();
-#endif
 	lmb_reserve(0, __pa(klimit));
 
 	DBG("Phys. mem: %lx\n", lmb_phys_mem_size());
@@ -1908,7 +1898,7 @@
 	/* We don't support that function on PowerMac, at least
 	 * not yet
 	 */
-	if (systemcfg->platform == PLATFORM_POWERMAC)
+	if (_machine == PLATFORM_POWERMAC)
 		return -ENODEV;
 
 	/* fix up new node's linux_phandle field */
Index: linux-work/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/rtas.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/powerpc/kernel/rtas.c	2005-11-09 12:00:55.000000000 +1100
@@ -29,9 +29,6 @@
 #include <asm/delay.h>
 #include <asm/uaccess.h>
 #include <asm/lmb.h>
-#ifdef CONFIG_PPC64
-#include <asm/systemcfg.h>
-#endif
 
 struct rtas_t rtas = {
 	.lock = SPIN_LOCK_UNLOCKED
@@ -671,7 +668,7 @@
 	 * the stop-self token if any
 	 */
 #ifdef CONFIG_PPC64
-	if (systemcfg->platform == PLATFORM_PSERIES_LPAR)
+	if (_machine == PLATFORM_PSERIES_LPAR)
 		rtas_region = min(lmb.rmo_size, RTAS_INSTANTIATE_MAX);
 #endif
 	rtas_rmo_buf = lmb_alloc_base(RTAS_RMOBUF_MAX, PAGE_SIZE, rtas_region);
Index: linux-work/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup-common.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/powerpc/kernel/setup-common.c	2005-11-09 12:00:55.000000000 +1100
@@ -33,6 +33,7 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
+#include <asm/systemcfg.h>
 #include <asm/pgtable.h>
 #include <asm/smp.h>
 #include <asm/elf.h>
@@ -510,8 +511,8 @@
 	 * On pSeries LPAR, we need to know how many cpus
 	 * could possibly be added to this partition.
 	 */
-	if (systemcfg->platform == PLATFORM_PSERIES_LPAR &&
-				(dn = of_find_node_by_path("/rtas"))) {
+	if (_machine == PLATFORM_PSERIES_LPAR &&
+	    (dn = of_find_node_by_path("/rtas"))) {
 		int num_addr_cell, num_size_cell, maxcpus;
 		unsigned int *ireg;
 
@@ -555,7 +556,7 @@
 			cpu_set(cpu ^ 0x1, cpu_sibling_map[cpu]);
 	}
 
-	systemcfg->processorCount = num_present_cpus();
+	_systemcfg->processorCount = num_present_cpus();
 #endif /* CONFIG_PPC64 */
 }
 #endif /* CONFIG_SMP */
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/powerpc/kernel/setup_64.c	2005-11-09 13:25:41.000000000 +1100
@@ -108,6 +108,8 @@
 int boot_cpuid_phys = 0;
 dev_t boot_dev;
 u64 ppc64_pft_size;
+int _machine;
+EXPORT_SYMBOL(_machine);
 
 struct ppc64_caches ppc64_caches;
 EXPORT_SYMBOL_GPL(ppc64_caches);
@@ -254,11 +256,10 @@
 	 * Iterate all ppc_md structures until we find the proper
 	 * one for the current machine type
 	 */
-	DBG("Probing machine type for platform %x...\n",
-	    systemcfg->platform);
+	DBG("Probing machine type for platform %x...\n", _machine);
 
 	for (mach = machines; *mach; mach++) {
-		if ((*mach)->probe(systemcfg->platform))
+		if ((*mach)->probe(_machine))
 			break;
 	}
 	/* What can we do if we didn't find ? */
@@ -315,7 +316,8 @@
 #endif /* CONFIG_SMP || CONFIG_KEXEC */
 
 /*
- * Initialize some remaining members of the ppc64_caches and systemcfg structures
+ * Initialize some remaining members of the ppc64_caches and systemcfg
+ * structures
  * (at least until we get rid of them completely). This is mostly some
  * cache informations about the CPU that will be used by cache flush
  * routines and/or provided to userland
@@ -340,7 +342,7 @@
 			const char *dc, *ic;
 
 			/* Then read cache informations */
-			if (systemcfg->platform == PLATFORM_POWERMAC) {
+			if (_machine == PLATFORM_POWERMAC) {
 				dc = "d-cache-block-size";
 				ic = "i-cache-block-size";
 			} else {
@@ -360,8 +362,8 @@
 				DBG("Argh, can't find dcache properties ! "
 				    "sizep: %p, lsizep: %p\n", sizep, lsizep);
 
-			systemcfg->dcache_size = ppc64_caches.dsize = size;
-			systemcfg->dcache_line_size =
+			_systemcfg->dcache_size = ppc64_caches.dsize = size;
+			_systemcfg->dcache_line_size =
 				ppc64_caches.dline_size = lsize;
 			ppc64_caches.log_dline_size = __ilog2(lsize);
 			ppc64_caches.dlines_per_page = PAGE_SIZE / lsize;
@@ -378,8 +380,8 @@
 				DBG("Argh, can't find icache properties ! "
 				    "sizep: %p, lsizep: %p\n", sizep, lsizep);
 
-			systemcfg->icache_size = ppc64_caches.isize = size;
-			systemcfg->icache_line_size =
+			_systemcfg->icache_size = ppc64_caches.isize = size;
+			_systemcfg->icache_line_size =
 				ppc64_caches.iline_size = lsize;
 			ppc64_caches.log_iline_size = __ilog2(lsize);
 			ppc64_caches.ilines_per_page = PAGE_SIZE / lsize;
@@ -387,10 +389,12 @@
 	}
 
 	/* Add an eye catcher and the systemcfg layout version number */
-	strcpy(systemcfg->eye_catcher, "SYSTEMCFG:PPC64");
-	systemcfg->version.major = SYSTEMCFG_MAJOR;
-	systemcfg->version.minor = SYSTEMCFG_MINOR;
-	systemcfg->processor = mfspr(SPRN_PVR);
+	strcpy(_systemcfg->eye_catcher, "SYSTEMCFG:PPC64");
+	_systemcfg->version.major = SYSTEMCFG_MAJOR;
+	_systemcfg->version.minor = SYSTEMCFG_MINOR;
+	_systemcfg->processor = mfspr(SPRN_PVR);
+	_systemcfg->platform = _machine;
+	_systemcfg->physicalMemorySize = lmb_phys_mem_size();
 
 	DBG(" <- initialize_cache_info()\n");
 }
@@ -479,10 +483,10 @@
 	printk("-----------------------------------------------------\n");
 	printk("ppc64_pft_size                = 0x%lx\n", ppc64_pft_size);
 	printk("ppc64_interrupt_controller    = 0x%ld\n", ppc64_interrupt_controller);
-	printk("systemcfg                     = 0x%p\n", systemcfg);
-	printk("systemcfg->platform           = 0x%x\n", systemcfg->platform);
-	printk("systemcfg->processorCount     = 0x%lx\n", systemcfg->processorCount);
-	printk("systemcfg->physicalMemorySize = 0x%lx\n", systemcfg->physicalMemorySize);
+	printk("systemcfg                     = 0x%p\n", _systemcfg);
+	printk("systemcfg->platform           = 0x%x\n", _systemcfg->platform);
+	printk("systemcfg->processorCount     = 0x%lx\n", _systemcfg->processorCount);
+	printk("systemcfg->physicalMemorySize = 0x%lx\n", _systemcfg->physicalMemorySize);
 	printk("ppc64_caches.dcache_line_size = 0x%x\n",
 			ppc64_caches.dline_size);
 	printk("ppc64_caches.icache_line_size = 0x%x\n",
@@ -564,12 +568,12 @@
 	for (i = 0; i < __NR_syscalls; i++) {
 		if (sys_call_table[i*2] != sys_ni_syscall) {
 			count64++;
-			systemcfg->syscall_map_64[i >> 5] |=
+			_systemcfg->syscall_map_64[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
 		}
 		if (sys_call_table[i*2+1] != sys_ni_syscall) {
 			count32++;
-			systemcfg->syscall_map_32[i >> 5] |=
+			_systemcfg->syscall_map_32[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
 		}
 	}
Index: linux-work/arch/powerpc/kernel/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/smp.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/powerpc/kernel/smp.c	2005-11-09 12:00:55.000000000 +1100
@@ -44,6 +44,7 @@
 #include <asm/cputable.h>
 #include <asm/system.h>
 #include <asm/mpic.h>
+#include <asm/systemcfg.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 #endif
@@ -368,7 +369,9 @@
 	if (cpu == boot_cpuid)
 		return -EBUSY;
 
-	systemcfg->processorCount--;
+#ifdef CONFIG_PPC64
+	_systemcfg->processorCount--;
+#endif
 	cpu_clear(cpu, cpu_online_map);
 	fixup_irqs(cpu_online_map);
 	return 0;
Index: linux-work/arch/powerpc/kernel/sys_ppc32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/sys_ppc32.c	2005-11-01 14:13:52.000000000 +1100
+++ linux-work/arch/powerpc/kernel/sys_ppc32.c	2005-11-09 12:00:55.000000000 +1100
@@ -52,7 +52,6 @@
 #include <asm/semaphore.h>
 #include <asm/time.h>
 #include <asm/mmu_context.h>
-#include <asm/systemcfg.h>
 #include <asm/ppc-pci.h>
 
 /* readdir & getdents */
Index: linux-work/arch/powerpc/kernel/time.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/time.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/powerpc/kernel/time.c	2005-11-09 12:00:55.000000000 +1100
@@ -271,13 +271,13 @@
 	 * tb_to_xs and stamp_xsec values are consistent.  If not, then it
 	 * loops back and reads them again until this criteria is met.
 	 */
-	++(systemcfg->tb_update_count);
+	++(_systemcfg->tb_update_count);
 	smp_wmb();
-	systemcfg->tb_orig_stamp = new_tb_stamp;
-	systemcfg->stamp_xsec = new_stamp_xsec;
-	systemcfg->tb_to_xs = new_tb_to_xs;
+	_systemcfg->tb_orig_stamp = new_tb_stamp;
+	_systemcfg->stamp_xsec = new_stamp_xsec;
+	_systemcfg->tb_to_xs = new_tb_to_xs;
 	smp_wmb();
-	++(systemcfg->tb_update_count);
+	++(_systemcfg->tb_update_count);
 #endif
 }
 
@@ -357,8 +357,9 @@
 				do_gtod.tb_ticks_per_sec = tb_ticks_per_sec;
 				tb_to_xs = divres.result_low;
 				do_gtod.varp->tb_to_xs = tb_to_xs;
-				systemcfg->tb_ticks_per_sec = tb_ticks_per_sec;
-				systemcfg->tb_to_xs = tb_to_xs;
+				_systemcfg->tb_ticks_per_sec =
+					tb_ticks_per_sec;
+				_systemcfg->tb_to_xs = tb_to_xs;
 			}
 			else {
 				printk( "Titan recalibrate: FAILED (difference > 4 percent)\n"
@@ -559,8 +560,8 @@
 	update_gtod(tb_last_jiffy, new_xsec, do_gtod.varp->tb_to_xs);
 
 #ifdef CONFIG_PPC64
-	systemcfg->tz_minuteswest = sys_tz.tz_minuteswest;
-	systemcfg->tz_dsttime = sys_tz.tz_dsttime;
+	_systemcfg->tz_minuteswest = sys_tz.tz_minuteswest;
+	_systemcfg->tz_dsttime = sys_tz.tz_dsttime;
 #endif
 
 	write_sequnlock_irqrestore(&xtime_lock, flags);
@@ -711,11 +712,11 @@
 	do_gtod.varp->tb_to_xs = tb_to_xs;
 	do_gtod.tb_to_us = tb_to_us;
 #ifdef CONFIG_PPC64
-	systemcfg->tb_orig_stamp = tb_last_jiffy;
-	systemcfg->tb_update_count = 0;
-	systemcfg->tb_ticks_per_sec = tb_ticks_per_sec;
-	systemcfg->stamp_xsec = xtime.tv_sec * XSEC_PER_SEC;
-	systemcfg->tb_to_xs = tb_to_xs;
+	_systemcfg->tb_orig_stamp = tb_last_jiffy;
+	_systemcfg->tb_update_count = 0;
+	_systemcfg->tb_ticks_per_sec = tb_ticks_per_sec;
+	_systemcfg->stamp_xsec = xtime.tv_sec * XSEC_PER_SEC;
+	_systemcfg->tb_to_xs = tb_to_xs;
 #endif
 
 	time_freq = 0;
Index: linux-work/arch/ppc64/kernel/asm-offsets.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/asm-offsets.c	2005-11-08 11:00:17.000000000 +1100
+++ linux-work/arch/ppc64/kernel/asm-offsets.c	2005-11-09 12:00:55.000000000 +1100
@@ -74,7 +74,6 @@
 	DEFINE(ICACHEL1LINESIZE, offsetof(struct ppc64_caches, iline_size));
 	DEFINE(ICACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_iline_size));
 	DEFINE(ICACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, ilines_per_page));
-	DEFINE(PLATFORM, offsetof(struct systemcfg, platform));
 	DEFINE(PLATFORM_LPAR, PLATFORM_LPAR);
 
 	/* paca */
Index: linux-work/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/eeh.c	2005-11-01 14:13:53.000000000 +1100
+++ linux-work/arch/ppc64/kernel/eeh.c	2005-11-09 12:00:55.000000000 +1100
@@ -32,7 +32,6 @@
 #include <asm/machdep.h>
 #include <asm/rtas.h>
 #include <asm/atomic.h>
-#include <asm/systemcfg.h>
 #include <asm/ppc-pci.h>
 
 #undef DEBUG
@@ -932,11 +931,12 @@
 {
 	struct proc_dir_entry *e;
 
-	if (systemcfg->platform & PLATFORM_PSERIES) {
-		e = create_proc_entry("ppc64/eeh", 0, NULL);
-		if (e)
-			e->proc_fops = &proc_eeh_operations;
-	}
+	if (_machine != PLATFORM_PSERIES && _machine != PLATFORM_PSERIES_LPAR)
+		return 0;
+
+	e = create_proc_entry("ppc64/eeh", 0, NULL);
+	if (e)
+		e->proc_fops = &proc_eeh_operations;
 
 	return 0;
 }
Index: linux-work/arch/ppc64/kernel/head.S
===================================================================
--- linux-work.orig/arch/ppc64/kernel/head.S	2005-11-08 11:00:17.000000000 +1100
+++ linux-work/arch/ppc64/kernel/head.S	2005-11-09 12:00:55.000000000 +1100
@@ -28,7 +28,6 @@
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
-#include <asm/systemcfg.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/bug.h>
@@ -1735,9 +1734,7 @@
 	sc				/* HvCall_setASR */
 #else
 	/* set the ASR */
-	ld	r3,systemcfg@got(r2)	/* r3 = ptr to systemcfg	 */
-	ld	r3,0(r3)
-	lwz	r3,PLATFORM(r3)		/* r3 = platform flags		 */
+	ld	r3,_machine@got(r2)	/* r3 = machine type	 */
 	andi.	r3,r3,PLATFORM_LPAR	/* Test if bit 0 is set (LPAR bit) */
 	beq	98f			/* branch if result is 0  */
 	mfspr	r3,SPRN_PVR
@@ -1899,9 +1896,7 @@
 	/* set the ASR */
 	ld	r3,PACASTABREAL(r13)
 	ori	r4,r3,1			/* turn on valid bit		 */
-	ld	r3,systemcfg@got(r2)	/* r3 = ptr to systemcfg */
-	ld	r3,0(r3)
-	lwz	r3,PLATFORM(r3)		/* r3 = platform flags */
+	ld	r3,_machine@got(r2)	/* r3 = machine type */
 	andi.	r3,r3,PLATFORM_LPAR	/* Test if bit 0 is set (LPAR bit) */
 	beq	98f			/* branch if result is 0  */
 	mfspr	r3,SPRN_PVR
@@ -1919,9 +1914,7 @@
 	mtasr	r4			/* set the stab location	*/
 99:
 	/* Set SDR1 (hash table pointer) */
-	ld	r3,systemcfg@got(r2)	/* r3 = ptr to systemcfg */
-	ld	r3,0(r3)
-	lwz	r3,PLATFORM(r3)		/* r3 = platform flags */
+	ld	r3,_machine@got(r2)	/* r3 = machine type */
 	/* Test if bit 0 is set (LPAR bit) */
 	andi.	r3,r3,PLATFORM_LPAR
 	bne	98f			/* branch if result is !0  */
Index: linux-work/arch/ppc64/kernel/idle.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/idle.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/ppc64/kernel/idle.c	2005-11-09 12:00:55.000000000 +1100
@@ -26,7 +26,6 @@
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/time.h>
-#include <asm/systemcfg.h>
 #include <asm/machdep.h>
 #include <asm/smp.h>
 
Index: linux-work/arch/ppc64/kernel/lparcfg.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/lparcfg.c	2005-11-08 11:00:17.000000000 +1100
+++ linux-work/arch/ppc64/kernel/lparcfg.c	2005-11-09 12:00:55.000000000 +1100
@@ -35,6 +35,7 @@
 #include <asm/time.h>
 #include <asm/iseries/it_exp_vpd_panel.h>
 #include <asm/prom.h>
+#include <asm/systemcfg.h>
 
 #define MODULE_VERS "1.6"
 #define MODULE_NAME "lparcfg"
@@ -371,7 +372,7 @@
 	lrdrp = (int *)get_property(rtas_node, "ibm,lrdr-capacity", NULL);
 
 	if (lrdrp == NULL) {
-		partition_potential_processors = systemcfg->processorCount;
+		partition_potential_processors = _systemcfg->processorCount;
 	} else {
 		partition_potential_processors = *(lrdrp + 4);
 	}
Index: linux-work/arch/ppc64/kernel/nvram.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/nvram.c	2005-10-26 12:43:38.000000000 +1000
+++ linux-work/arch/ppc64/kernel/nvram.c	2005-11-09 12:00:55.000000000 +1100
@@ -31,7 +31,6 @@
 #include <asm/rtas.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
-#include <asm/systemcfg.h>
 
 #undef DEBUG_NVRAM
 
@@ -167,7 +166,7 @@
 	case IOC_NVRAM_GET_OFFSET: {
 		int part, offset;
 
-		if (systemcfg->platform != PLATFORM_POWERMAC)
+		if (_machine != PLATFORM_POWERMAC)
 			return -EINVAL;
 		if (copy_from_user(&part, (void __user*)arg, sizeof(part)) != 0)
 			return -EFAULT;
@@ -450,7 +449,7 @@
 	 * in our nvram, as Apple defined partitions use pretty much
 	 * all of the space
 	 */
-	if (systemcfg->platform == PLATFORM_POWERMAC)
+	if (_machine == PLATFORM_POWERMAC)
 		return -ENOSPC;
 
 	/* see if we have an OS partition that meets our needs.
Index: linux-work/arch/ppc64/kernel/prom.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/prom.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/ppc64/kernel/prom.c	2005-11-09 12:00:55.000000000 +1100
@@ -318,7 +318,7 @@
 		}
 
 		/* We offset irq numbers for the u3 MPIC by 128 in PowerMac */
-		if (systemcfg->platform == PLATFORM_POWERMAC && ic && ic->parent) {
+		if (_machine == PLATFORM_POWERMAC && ic && ic->parent) {
 			char *name = get_property(ic->parent, "name", NULL);
 			if (name && !strcmp(name, "u3"))
 				np->intrs[intrcount].line += 128;
@@ -1065,7 +1065,7 @@
 	prop = (u32 *)of_get_flat_dt_prop(node, "linux,platform", NULL);
 	if (prop == NULL)
 		return 0;
-	systemcfg->platform = *prop;
+	_machine = *prop;
 
 	/* check if iommu is forced on or off */
 	if (of_get_flat_dt_prop(node, "linux,iommu-off", NULL) != NULL)
@@ -1230,11 +1230,8 @@
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 	lmb_enforce_memory_limit(memory_limit);
 	lmb_analyze();
-	systemcfg->physicalMemorySize = lmb_phys_mem_size();
 	lmb_reserve(0, __pa(klimit));
 
-	DBG("Phys. mem: %lx\n", systemcfg->physicalMemorySize);
-
 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
 	early_reserve_mem();
 
@@ -1753,7 +1750,7 @@
 	/* We don't support that function on PowerMac, at least
 	 * not yet
 	 */
-	if (systemcfg->platform == PLATFORM_POWERMAC)
+	if (_machine == PLATFORM_POWERMAC)
 		return -ENODEV;
 
 	/* fix up new node's linux_phandle field */
Index: linux-work/include/asm-powerpc/firmware.h
===================================================================
--- linux-work.orig/include/asm-powerpc/firmware.h	2005-11-01 14:13:56.000000000 +1100
+++ linux-work/include/asm-powerpc/firmware.h	2005-11-09 13:26:19.000000000 +1100
@@ -43,6 +43,7 @@
 #define FW_FEATURE_ISERIES	(1UL<<21)
 
 enum {
+#ifdef CONFIG_PPC64
 	FW_FEATURE_PSERIES_POSSIBLE = FW_FEATURE_PFT | FW_FEATURE_TCE |
 		FW_FEATURE_SPRG0 | FW_FEATURE_DABR | FW_FEATURE_COPY |
 		FW_FEATURE_ASR | FW_FEATURE_DEBUG | FW_FEATURE_TERM |
@@ -70,6 +71,11 @@
 		FW_FEATURE_ISERIES_ALWAYS &
 #endif
 		FW_FEATURE_POSSIBLE,
+
+#else /* CONFIG_PPC64 */
+	FW_FEATURE_POSSIBLE = 0,
+	FW_FEATURE_ALWAYS = 0,
+#endif
 };
 
 /* This is used to identify firmware features which are available
Index: linux-work/include/asm-powerpc/processor.h
===================================================================
--- linux-work.orig/include/asm-powerpc/processor.h	2005-11-07 10:31:41.000000000 +1100
+++ linux-work/include/asm-powerpc/processor.h	2005-11-09 14:02:41.000000000 +1100
@@ -17,65 +17,71 @@
 #include <linux/compiler.h>
 #include <asm/ptrace.h>
 #include <asm/types.h>
-#ifdef CONFIG_PPC64
-#include <asm/systemcfg.h>
-#endif
 
-#ifdef CONFIG_PPC32
-/* 32-bit platform types */
-/* We only need to define a new _MACH_xxx for machines which are part of
- * a configuration which supports more than one type of different machine.
- * This is currently limited to CONFIG_PPC_MULTIPLATFORM and CHRP/PReP/PMac.
- * -- Tom
+/* We do _not_ want to define new machine types at all, those must die
+ * in favor of using the device-tree
+ * -- BenH.
  */
-#define _MACH_prep	0x00000001
-#define _MACH_Pmac	0x00000002	/* pmac or pmac clone (non-chrp) */
-#define _MACH_chrp	0x00000004	/* chrp machine */
 
-/* see residual.h for these */
+/* Platforms codes (to be obsoleted) */
+#define PLATFORM_PSERIES      0x0100
+#define PLATFORM_PSERIES_LPAR 0x0101
+#define PLATFORM_ISERIES_LPAR 0x0201
+#define PLATFORM_LPAR         0x0001
+#define PLATFORM_POWERMAC     0x0400
+#define PLATFORM_MAPLE        0x0500
+#define PLATFORM_PREP	      0x0600
+#define PLATFORM_CHRP	      0x0700
+#define PLATFORM_CELL         0x1000
+
+/* Compat platform codes for 32 bits */
+#define _MACH_prep	PLATFORM_PREP
+#define _MACH_Pmac	PLATFORM_POWERMAC
+#define _MACH_chrp	PLATFORM_CHRP
+
+/* PREP sub-platform types see residual.h for these */
 #define _PREP_Motorola	0x01	/* motorola prep */
 #define _PREP_Firm	0x02	/* firmworks prep */
 #define _PREP_IBM	0x00	/* ibm prep */
 #define _PREP_Bull	0x03	/* bull prep */
 
-/* these are arbitrary */
+/* CHRP sub-platform types. These are arbitrary */
 #define _CHRP_Motorola	0x04	/* motorola chrp, the cobra */
 #define _CHRP_IBM	0x05	/* IBM chrp, the longtrail and longtrail 2 */
 #define _CHRP_Pegasos	0x06	/* Genesi/bplan's Pegasos and Pegasos2 */
 
+#define platform_is_pseries()	(_machine == PLATFORM_PSERIES || \
+				 _machine == PLATFORM_PSERIES_LPAR)
+#define platform_is_lpar()	(!!(_machine & PLATFORM_LPAR))
+
 #ifdef CONFIG_PPC_MULTIPLATFORM
 extern int _machine;
 
+#ifdef CONFIG_PPC32
+
 /* what kind of prep workstation we are */
 extern int _prep_type;
 extern int _chrp_type;
 
 /*
  * This is used to identify the board type from a given PReP board
- * vendor. Board revision is also made available.
+ * vendor. Board revision is also made available. This will be moved
+ * elsewhere soon
  */
 extern unsigned char ucSystemType;
 extern unsigned char ucBoardRev;
 extern unsigned char ucBoardRevMaj, ucBoardRevMin;
-#else
+
+#endif /* CONFIG_PPC32 */
+
+#else /* CONFIG_PPC_MULTIPLATFORM */
 #define _machine 0
+#define platform_is_pseries()	(0)
+#define platform_is_lpar()	(0)
 #endif /* CONFIG_PPC_MULTIPLATFORM */
-#endif /* CONFIG_PPC32 */
 
-#ifdef CONFIG_PPC64
-/* Platforms supported by PPC64 */
-#define PLATFORM_PSERIES      0x0100
-#define PLATFORM_PSERIES_LPAR 0x0101
-#define PLATFORM_ISERIES_LPAR 0x0201
-#define PLATFORM_LPAR         0x0001
-#define PLATFORM_POWERMAC     0x0400
-#define PLATFORM_MAPLE        0x0500
-#define PLATFORM_CELL         0x1000
 
-/* Compatibility with drivers coming from PPC32 world */
-#define _machine	(systemcfg->platform)
-#define _MACH_Pmac	PLATFORM_POWERMAC
-#endif
+
 
 /*
  * Default implementation of macro that returns current
Index: linux-work/include/asm-ppc64/systemcfg.h
===================================================================
--- linux-work.orig/include/asm-ppc64/systemcfg.h	2005-09-23 12:44:12.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,64 +0,0 @@
-#ifndef _SYSTEMCFG_H
-#define _SYSTEMCFG_H
-
-/* 
- * Copyright (C) 2002 Peter Bergner <bergner@vnet.ibm.com>, IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-/* Change Activity:
- * 2002/09/30 : bergner  : Created
- * End Change Activity 
- */
-
-/*
- * If the major version changes we are incompatible.
- * Minor version changes are a hint.
- */
-#define SYSTEMCFG_MAJOR 1
-#define SYSTEMCFG_MINOR 1
-
-#ifndef __ASSEMBLY__
-
-#include <linux/unistd.h>
-
-#define SYSCALL_MAP_SIZE      ((__NR_syscalls + 31) / 32)
-
-struct systemcfg {
-	__u8  eye_catcher[16];		/* Eyecatcher: SYSTEMCFG:PPC64	0x00 */
-	struct {			/* Systemcfg version numbers	     */
-		__u32 major;		/* Major number			0x10 */
-		__u32 minor;		/* Minor number			0x14 */
-	} version;
-
-	__u32 platform;			/* Platform flags		0x18 */
-	__u32 processor;		/* Processor type		0x1C */
-	__u64 processorCount;		/* # of physical processors	0x20 */
-	__u64 physicalMemorySize;	/* Size of real memory(B)	0x28 */
-	__u64 tb_orig_stamp;		/* Timebase at boot		0x30 */
-	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
-	__u64 tb_to_xs;			/* Inverse of TB to 2^20	0x40 */
-	__u64 stamp_xsec;		/*				0x48 */
-	__u64 tb_update_count;		/* Timebase atomicity ctr	0x50 */
-	__u32 tz_minuteswest;		/* Minutes west of Greenwich	0x58 */
-	__u32 tz_dsttime;		/* Type of dst correction	0x5C */
-	/* next four are no longer used except to be exported to /proc */
-	__u32 dcache_size;		/* L1 d-cache size		0x60 */
-	__u32 dcache_line_size;		/* L1 d-cache line size		0x64 */
-	__u32 icache_size;		/* L1 i-cache size		0x68 */
-	__u32 icache_line_size;		/* L1 i-cache line size		0x6C */
-   	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of available syscalls 0x70 */
-   	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of available syscalls */
-};
-
-#ifdef __KERNEL__
-extern struct systemcfg *systemcfg;
-#endif
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* _SYSTEMCFG_H */
Index: linux-work/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_init.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom_init.c	2005-11-09 12:00:55.000000000 +1100
@@ -111,11 +111,6 @@
 #define prom_debug(x...)
 #endif
 
-#ifdef CONFIG_PPC32
-#define PLATFORM_POWERMAC	_MACH_Pmac
-#define PLATFORM_CHRP		_MACH_chrp
-#endif
-
 
 typedef u32 prom_arg_t;
 
@@ -1996,7 +1991,8 @@
 	/*
 	 * On pSeries, inform the firmware about our capabilities
 	 */
-	if (RELOC(of_platform) & PLATFORM_PSERIES)
+	if (RELOC(of_platform) == PLATFORM_PSERIES ||
+	    RELOC(of_platform) == PLATFORM_PSERIES_LPAR)
 		prom_send_capabilities();
 #endif
 
Index: linux-work/arch/powerpc/kernel/rtas-proc.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/rtas-proc.c	2005-11-07 10:31:39.000000000 +1100
+++ linux-work/arch/powerpc/kernel/rtas-proc.c	2005-11-09 13:56:02.000000000 +1100
@@ -259,7 +259,7 @@
 {
 	struct proc_dir_entry *entry;
 
-	if (!(systemcfg->platform & PLATFORM_PSERIES))
+	if (_machine != PLATFORM_PSERIES && _machine != PLATFORM_PSERIES_LPAR)
 		return 1;
 
 	rtas_node = of_find_node_by_name(NULL, "rtas");
Index: linux-work/arch/powerpc/kernel/traps.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/traps.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/powerpc/kernel/traps.c	2005-11-09 12:00:55.000000000 +1100
@@ -129,7 +129,7 @@
 	nl = 1;
 #endif
 #ifdef CONFIG_PPC64
-	switch (systemcfg->platform) {
+	switch (_machine) {
 	case PLATFORM_PSERIES:
 		printk("PSERIES ");
 		nl = 1;
Index: linux-work/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_utils_64.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/powerpc/mm/hash_utils_64.c	2005-11-09 12:00:55.000000000 +1100
@@ -165,7 +165,7 @@
 		 * normal insert callback here.
 		 */
 #ifdef CONFIG_PPC_ISERIES
-		if (systemcfg->platform == PLATFORM_ISERIES_LPAR)
+		if (_machine == PLATFORM_ISERIES_LPAR)
 			ret = iSeries_hpte_insert(hpteg, va,
 						  virt_to_abs(paddr),
 						  tmp_mode,
@@ -174,7 +174,7 @@
 		else
 #endif
 #ifdef CONFIG_PPC_PSERIES
-		if (systemcfg->platform & PLATFORM_LPAR)
+		if (_machine & PLATFORM_LPAR)
 			ret = pSeries_lpar_hpte_insert(hpteg, va,
 						       virt_to_abs(paddr),
 						       tmp_mode,
@@ -293,7 +293,7 @@
 	 * Not in the device-tree, let's fallback on known size
 	 * list for 16M capable GP & GR
 	 */
-	if ((systemcfg->platform != PLATFORM_ISERIES_LPAR) &&
+	if ((_machine != PLATFORM_ISERIES_LPAR) &&
 	    cpu_has_feature(CPU_FTR_16M_PAGE))
 		memcpy(mmu_psize_defs, mmu_psize_defaults_gp,
 		       sizeof(mmu_psize_defaults_gp));
@@ -364,7 +364,7 @@
 
 static unsigned long __init htab_get_table_size(void)
 {
-	unsigned long rnd_mem_size, pteg_count;
+	unsigned long mem_size, rnd_mem_size, pteg_count;
 
 	/* If hash size isn't already provided by the platform, we try to
 	 * retreive it from the device-tree. If it's not there neither, we
@@ -376,8 +376,9 @@
 		return 1UL << ppc64_pft_size;
 
 	/* round mem_size up to next power of 2 */
-	rnd_mem_size = 1UL << __ilog2(systemcfg->physicalMemorySize);
-	if (rnd_mem_size < systemcfg->physicalMemorySize)
+	mem_size = lmb_phys_mem_size();
+	rnd_mem_size = 1UL << __ilog2(mem_size);
+	if (rnd_mem_size < mem_size)
 		rnd_mem_size <<= 1;
 
 	/* # pages / 2 */
@@ -410,7 +411,7 @@
 
 	htab_hash_mask = pteg_count - 1;
 
-	if (systemcfg->platform & PLATFORM_LPAR) {
+	if (_machine & PLATFORM_LPAR) {
 		/* Using a hypervisor which owns the htab */
 		htab_address = NULL;
 		_SDR1 = 0; 
Index: linux-work/arch/powerpc/oprofile/op_model_power4.c
===================================================================
--- linux-work.orig/arch/powerpc/oprofile/op_model_power4.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/powerpc/oprofile/op_model_power4.c	2005-11-09 12:00:55.000000000 +1100
@@ -233,8 +233,7 @@
 	mmcra = mfspr(SPRN_MMCRA);
 
 	/* Were we in the hypervisor? */
-	if ((systemcfg->platform == PLATFORM_PSERIES_LPAR) &&
-	    (mmcra & MMCRA_SIHV))
+	if (platform_is_lpar() && (mmcra & MMCRA_SIHV))
 		/* function descriptor madness */
 		return *((unsigned long *)hypervisor_bucket);
 
Index: linux-work/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/iommu.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/iommu.c	2005-11-09 12:00:55.000000000 +1100
@@ -42,7 +42,6 @@
 #include <asm/machdep.h>
 #include <asm/abs_addr.h>
 #include <asm/pSeries_reconfig.h>
-#include <asm/systemcfg.h>
 #include <asm/firmware.h>
 #include <asm/tce.h>
 #include <asm/ppc-pci.h>
@@ -582,7 +581,7 @@
 		return;
 	}
 
-	if (systemcfg->platform & PLATFORM_LPAR) {
+	if (platform_is_lpar()) {
 		if (firmware_has_feature(FW_FEATURE_MULTITCE)) {
 			ppc_md.tce_build = tce_buildmulti_pSeriesLP;
 			ppc_md.tce_free	 = tce_freemulti_pSeriesLP;
Index: linux-work/arch/powerpc/platforms/pseries/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/pci.c	2005-11-01 14:13:53.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/pci.c	2005-11-09 12:00:55.000000000 +1100
@@ -123,7 +123,7 @@
 	int i;
 	unsigned int reg;
 
-	if (!(systemcfg->platform & PLATFORM_PSERIES))
+	if (!platform_is_pseries())
 		return;
 
 	printk("Using INTC for W82c105 IDE controller.\n");
Index: linux-work/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/reconfig.c	2005-11-08 11:00:17.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/reconfig.c	2005-11-09 12:00:55.000000000 +1100
@@ -408,7 +408,7 @@
 {
 	struct proc_dir_entry *ent;
 
-	if (!(systemcfg->platform & PLATFORM_PSERIES))
+	if (!platform_is_pseries())
 		return 0;
 
 	ent = create_proc_entry("ppc64/ofdt", S_IWUSR, NULL);
Index: linux-work/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/rtasd.c	2005-11-07 10:31:39.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/rtasd.c	2005-11-09 12:00:55.000000000 +1100
@@ -482,10 +482,12 @@
 {
 	struct proc_dir_entry *entry;
 
-	/* No RTAS, only warn if we are on a pSeries box  */
+	if (!platform_is_pseries())
+		return 0;
+
+	/* No RTAS */
 	if (rtas_token("event-scan") == RTAS_UNKNOWN_SERVICE) {
-		if (systemcfg->platform & PLATFORM_PSERIES)
-			printk(KERN_INFO "rtasd: no event-scan on system\n");
+		printk(KERN_INFO "rtasd: no event-scan on system\n");
 		return 1;
 	}
 
Index: linux-work/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/setup.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/setup.c	2005-11-09 12:00:55.000000000 +1100
@@ -249,7 +249,7 @@
 		ppc_md.idle_loop = default_idle;
 	}
 
-	if (systemcfg->platform & PLATFORM_LPAR)
+	if (platform_is_lpar())
 		ppc_md.enable_pmcs = pseries_lpar_enable_pmcs;
 	else
 		ppc_md.enable_pmcs = power4_enable_pmcs;
@@ -378,7 +378,7 @@
 
 	fw_feature_init();
 	
-	if (systemcfg->platform & PLATFORM_LPAR)
+	if (platform_is_lpar())
 		hpte_init_lpar();
 	else {
 		hpte_init_native();
@@ -388,7 +388,7 @@
 
 	generic_find_legacy_serial_ports(&physport, &default_speed);
 
-	if (systemcfg->platform & PLATFORM_LPAR)
+	if (platform_is_lpar())
 		find_udbg_vterm();
 	else if (physport) {
 		/* Map the uart for udbg. */
@@ -592,7 +592,7 @@
 
 static int pSeries_pci_probe_mode(struct pci_bus *bus)
 {
-	if (systemcfg->platform & PLATFORM_LPAR)
+	if (platform_is_lpar())
 		return PCI_PROBE_DEVTREE;
 	return PCI_PROBE_NORMAL;
 }
Index: linux-work/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/smp.c	2005-11-07 10:31:39.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/smp.c	2005-11-09 12:00:55.000000000 +1100
@@ -46,6 +46,7 @@
 #include <asm/rtas.h>
 #include <asm/pSeries_reconfig.h>
 #include <asm/mpic.h>
+#include <asm/systemcfg.h>
 
 #include "plpar_wrappers.h"
 
@@ -96,7 +97,7 @@
 	int cpu = smp_processor_id();
 
 	cpu_clear(cpu, cpu_online_map);
-	systemcfg->processorCount--;
+	_systemcfg->processorCount--;
 
 	/*fix boot_cpuid here*/
 	if (cpu == boot_cpuid)
@@ -441,7 +442,7 @@
 	smp_ops->cpu_die = pSeries_cpu_die;
 
 	/* Processors can be added/removed only on LPAR */
-	if (systemcfg->platform == PLATFORM_PSERIES_LPAR)
+	if (platform_is_lpar())
 		pSeries_reconfig_notifier_register(&pSeries_smp_nb);
 #endif
 
Index: linux-work/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/xics.c	2005-11-01 14:13:53.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/xics.c	2005-11-09 12:00:55.000000000 +1100
@@ -545,7 +545,9 @@
 		of_node_put(np);
 	}
 
-	if (systemcfg->platform == PLATFORM_PSERIES) {
+	if (platform_is_lpar())
+		ops = &pSeriesLP_ops;
+	else {
 #ifdef CONFIG_SMP
 		for_each_cpu(i) {
 			int hard_id;
@@ -561,8 +563,6 @@
 #else
 		xics_per_cpu[0] = ioremap(intr_base, intr_size);
 #endif /* CONFIG_SMP */
-	} else if (systemcfg->platform == PLATFORM_PSERIES_LPAR) {
-		ops = &pSeriesLP_ops;
 	}
 
 	xics_8259_pic.enable = i8259_pic.enable;
Index: linux-work/arch/ppc64/kernel/pacaData.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pacaData.c	2005-11-08 11:00:17.000000000 +1100
+++ linux-work/arch/ppc64/kernel/pacaData.c	2005-11-09 13:24:34.000000000 +1100
@@ -15,7 +15,7 @@
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/page.h>
-
+#include <asm/systemcfg.h>
 #include <asm/lppaca.h>
 #include <asm/iseries/it_lp_queue.h>
 #include <asm/paca.h>
@@ -24,8 +24,7 @@
 	struct systemcfg	data;
 	u8			page[PAGE_SIZE];
 } systemcfg_store __attribute__((__section__(".data.page.aligned")));
-struct systemcfg *systemcfg = &systemcfg_store.data;
-EXPORT_SYMBOL(systemcfg);
+struct systemcfg *_systemcfg = &systemcfg_store.data;
 
 
 /* This symbol is provided by the linker - let it fill in the paca
Index: linux-work/arch/ppc64/kernel/proc_ppc64.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/proc_ppc64.c	2005-11-07 10:31:39.000000000 +1100
+++ linux-work/arch/ppc64/kernel/proc_ppc64.c	2005-11-09 12:00:55.000000000 +1100
@@ -53,7 +53,7 @@
 	if (!root)
 		return 1;
 
-	if (!(systemcfg->platform & (PLATFORM_PSERIES | PLATFORM_CELL)))
+	if (!(platform_is_pseries() || _machine == PLATFORM_CELL))
 		return 0;
 
 	if (!proc_mkdir("rtas", root))
@@ -74,7 +74,7 @@
 	if (!pde)
 		return 1;
 	pde->nlink = 1;
-	pde->data = systemcfg;
+	pde->data = _systemcfg;
 	pde->size = PAGE_SIZE;
 	pde->proc_fops = &page_map_fops;
 
Index: linux-work/arch/ppc64/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/prom_init.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/ppc64/kernel/prom_init.c	2005-11-09 12:00:55.000000000 +1100
@@ -1934,7 +1934,8 @@
 	/*
 	 * On pSeries, inform the firmware about our capabilities
 	 */
-	if (RELOC(of_platform) & PLATFORM_PSERIES)
+	if (RELOC(of_platform) == PLATFORM_PSERIES ||
+	    RELOC(of_platform) == PLATFORM_PSERIES_LPAR)
 		prom_send_capabilities();
 
 	/*
Index: linux-work/arch/ppc64/kernel/vdso.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/vdso.c	2005-11-01 14:13:53.000000000 +1100
+++ linux-work/arch/ppc64/kernel/vdso.c	2005-11-09 12:00:55.000000000 +1100
@@ -34,6 +34,7 @@
 #include <asm/machdep.h>
 #include <asm/cputable.h>
 #include <asm/sections.h>
+#include <asm/systemcfg.h>
 #include <asm/vdso.h>
 
 #undef DEBUG
@@ -179,7 +180,7 @@
 	 * Last page is systemcfg.
 	 */
 	if ((vma->vm_end - address) <= PAGE_SIZE)
-		pg = virt_to_page(systemcfg);
+		pg = virt_to_page(_systemcfg);
 	else
 		pg = virt_to_page(vbase + offset);
 
@@ -604,7 +605,7 @@
 		get_page(pg);
 	}
 
-	get_page(virt_to_page(systemcfg));
+	get_page(virt_to_page(_systemcfg));
 }
 
 int in_gate_area_no_task(unsigned long addr)
Index: linux-work/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/ppc_ksyms.c	2005-11-07 10:31:39.000000000 +1100
+++ linux-work/arch/powerpc/kernel/ppc_ksyms.c	2005-11-09 13:26:09.000000000 +1100
@@ -188,9 +188,6 @@
 EXPORT_SYMBOL(cuda_request);
 EXPORT_SYMBOL(cuda_poll);
 #endif /* CONFIG_ADB_CUDA */
-#if defined(CONFIG_PPC_MULTIPLATFORM) && defined(CONFIG_PPC32)
-EXPORT_SYMBOL(_machine);
-#endif
 #ifdef CONFIG_PPC_PMAC
 EXPORT_SYMBOL(sys_ctrler);
 #endif
Index: linux-work/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_32.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/powerpc/kernel/setup_32.c	2005-11-09 13:25:32.000000000 +1100
@@ -71,6 +71,7 @@
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
 int _machine = 0;
+EXPORT_SYMBOL(_machine);
 
 extern void prep_init(void);
 extern void pmac_init(void);
Index: linux-work/arch/ppc/kernel/ppc_ksyms.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/ppc_ksyms.c	2005-11-07 10:31:39.000000000 +1100
+++ linux-work/arch/ppc/kernel/ppc_ksyms.c	2005-11-09 13:25:57.000000000 +1100
@@ -217,9 +217,6 @@
 EXPORT_SYMBOL(cuda_request);
 EXPORT_SYMBOL(cuda_poll);
 #endif /* CONFIG_ADB_CUDA */
-#ifdef CONFIG_PPC_MULTIPLATFORM
-EXPORT_SYMBOL(_machine);
-#endif
 #ifdef CONFIG_PPC_PMAC
 EXPORT_SYMBOL(sys_ctrler);
 EXPORT_SYMBOL(pmac_newworld);
Index: linux-work/arch/ppc/kernel/setup.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/setup.c	2005-11-01 14:13:53.000000000 +1100
+++ linux-work/arch/ppc/kernel/setup.c	2005-11-09 13:25:15.000000000 +1100
@@ -76,6 +76,7 @@
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
 int _machine = 0;
+EXPORT_SYMBOL(_machine);
 
 extern void prep_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7);
Index: linux-work/arch/ppc64/kernel/pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pci.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/arch/ppc64/kernel/pci.c	2005-11-09 13:04:41.000000000 +1100
@@ -1277,12 +1277,9 @@
 	 * G5 machines... So when something asks for bus 0 io base
 	 * (bus 0 is HT root), we return the AGP one instead.
 	 */
-#ifdef CONFIG_PPC_PMAC
-	if (systemcfg->platform == PLATFORM_POWERMAC &&
-	    machine_is_compatible("MacRISC4"))
+	if (machine_is_compatible("MacRISC4"))
 		if (in_bus == 0)
 			in_bus = 0xf0;
-#endif /* CONFIG_PPC_PMAC */
 
 	/* That syscall isn't quite compatible with PCI domains, but it's
 	 * used on pre-domains setup. We return the first match
Index: linux-work/include/asm-powerpc/systemcfg.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/include/asm-powerpc/systemcfg.h	2005-11-09 14:03:02.000000000 +1100
@@ -0,0 +1,64 @@
+#ifndef _SYSTEMCFG_H
+#define _SYSTEMCFG_H
+
+/*
+ * Copyright (C) 2002 Peter Bergner <bergner@vnet.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/* Change Activity:
+ * 2002/09/30 : bergner  : Created
+ * End Change Activity
+ */
+
+/*
+ * If the major version changes we are incompatible.
+ * Minor version changes are a hint.
+ */
+#define SYSTEMCFG_MAJOR 1
+#define SYSTEMCFG_MINOR 1
+
+#ifndef __ASSEMBLY__
+
+#include <linux/unistd.h>
+
+#define SYSCALL_MAP_SIZE      ((__NR_syscalls + 31) / 32)
+
+struct systemcfg {
+	__u8  eye_catcher[16];		/* Eyecatcher: SYSTEMCFG:PPC64	0x00 */
+	struct {			/* Systemcfg version numbers	     */
+		__u32 major;		/* Major number			0x10 */
+		__u32 minor;		/* Minor number			0x14 */
+	} version;
+
+	__u32 platform;			/* Platform flags		0x18 */
+	__u32 processor;		/* Processor type		0x1C */
+	__u64 processorCount;		/* # of physical processors	0x20 */
+	__u64 physicalMemorySize;	/* Size of real memory(B)	0x28 */
+	__u64 tb_orig_stamp;		/* Timebase at boot		0x30 */
+	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
+	__u64 tb_to_xs;			/* Inverse of TB to 2^20	0x40 */
+	__u64 stamp_xsec;		/*				0x48 */
+	__u64 tb_update_count;		/* Timebase atomicity ctr	0x50 */
+	__u32 tz_minuteswest;		/* Minutes west of Greenwich	0x58 */
+	__u32 tz_dsttime;		/* Type of dst correction	0x5C */
+	/* next four are no longer used except to be exported to /proc */
+	__u32 dcache_size;		/* L1 d-cache size		0x60 */
+	__u32 dcache_line_size;		/* L1 d-cache line size		0x64 */
+	__u32 icache_size;		/* L1 i-cache size		0x68 */
+	__u32 icache_line_size;		/* L1 i-cache line size		0x6C */
+   	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of available syscalls 0x70 */
+   	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of available syscalls */
+};
+
+#ifdef __KERNEL__
+extern struct systemcfg *_systemcfg; /* to be renamed */
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _SYSTEMCFG_H */

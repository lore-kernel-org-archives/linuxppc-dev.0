Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 30 Mar 2006 17:12:57 +1100
Subject: [PATCH 1/5] powerpc: Initialise ppc_md htab pointers earlier
In-Reply-To: <1143699173.339118.857634197021.qpush@concordia>
Message-Id: <20060330061257.3CDD067A5A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Initialise the ppc_md htab callbacks earlier, in the probe routines. This
allows us to call htab_finish_init() from htab_initialize(), and makes it
private to hash_utils_64.c.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/setup_64.c          |    6 --
 arch/powerpc/mm/hash_native_64.c        |    3 -
 arch/powerpc/mm/hash_utils_64.c         |   72 ++++++++++++++++----------------
 arch/powerpc/platforms/iseries/htab.c   |    4 -
 arch/powerpc/platforms/iseries/setup.c  |    7 ---
 arch/powerpc/platforms/maple/setup.c    |    7 ---
 arch/powerpc/platforms/powermac/setup.c |    9 ----
 arch/powerpc/platforms/pseries/lpar.c   |    4 -
 arch/powerpc/platforms/pseries/setup.c  |   10 ++--
 include/asm-powerpc/mmu.h               |    1 
 10 files changed, 52 insertions(+), 71 deletions(-)

Index: to-merge/arch/powerpc/kernel/setup_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_64.c
+++ to-merge/arch/powerpc/kernel/setup_64.c
@@ -371,11 +371,7 @@ void __init setup_system(void)
 	 * Fill the ppc64_caches & systemcfg structures with informations
 	 * retrieved from the device-tree. Need to be called before
 	 * finish_device_tree() since the later requires some of the
-	 * informations filled up here to properly parse the interrupt
-	 * tree.
-	 * It also sets up the cache line sizes which allows to call
-	 * routines like flush_icache_range (used by the hash init
-	 * later on).
+	 * informations filled up here to properly parse the interrupt tree.
 	 */
 	initialize_cache_info();
 
Index: to-merge/arch/powerpc/mm/hash_native_64.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/hash_native_64.c
+++ to-merge/arch/powerpc/mm/hash_native_64.c
@@ -520,7 +520,7 @@ static inline int tlb_batching_enabled(v
 }
 #endif
 
-void hpte_init_native(void)
+void __init hpte_init_native(void)
 {
 	ppc_md.hpte_invalidate	= native_hpte_invalidate;
 	ppc_md.hpte_updatepp	= native_hpte_updatepp;
@@ -530,5 +530,4 @@ void hpte_init_native(void)
 	ppc_md.hpte_clear_all	= native_hpte_clear;
 	if (tlb_batching_enabled())
 		ppc_md.flush_hash_range = native_flush_hash_range;
-	htab_finish_init();
 }
Index: to-merge/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/hash_utils_64.c
+++ to-merge/arch/powerpc/mm/hash_utils_64.c
@@ -397,6 +397,41 @@ void create_section_mapping(unsigned lon
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
+static inline void make_bl(unsigned int *insn_addr, void *func)
+{
+	unsigned long funcp = *((unsigned long *)func);
+	int offset = funcp - (unsigned long)insn_addr;
+
+	*insn_addr = (unsigned int)(0x48000001 | (offset & 0x03fffffc));
+	flush_icache_range((unsigned long)insn_addr, 4+
+			   (unsigned long)insn_addr);
+}
+
+static void __init htab_finish_init(void)
+{
+	extern unsigned int *htab_call_hpte_insert1;
+	extern unsigned int *htab_call_hpte_insert2;
+	extern unsigned int *htab_call_hpte_remove;
+	extern unsigned int *htab_call_hpte_updatepp;
+
+#ifdef CONFIG_PPC_64K_PAGES
+	extern unsigned int *ht64_call_hpte_insert1;
+	extern unsigned int *ht64_call_hpte_insert2;
+	extern unsigned int *ht64_call_hpte_remove;
+	extern unsigned int *ht64_call_hpte_updatepp;
+
+	make_bl(ht64_call_hpte_insert1, ppc_md.hpte_insert);
+	make_bl(ht64_call_hpte_insert2, ppc_md.hpte_insert);
+	make_bl(ht64_call_hpte_remove, ppc_md.hpte_remove);
+	make_bl(ht64_call_hpte_updatepp, ppc_md.hpte_updatepp);
+#endif /* CONFIG_PPC_64K_PAGES */
+
+	make_bl(htab_call_hpte_insert1, ppc_md.hpte_insert);
+	make_bl(htab_call_hpte_insert2, ppc_md.hpte_insert);
+	make_bl(htab_call_hpte_remove, ppc_md.hpte_remove);
+	make_bl(htab_call_hpte_updatepp, ppc_md.hpte_updatepp);
+}
+
 void __init htab_initialize(void)
 {
 	unsigned long table;
@@ -509,6 +544,8 @@ void __init htab_initialize(void)
 					 mmu_linear_psize));
 	}
 
+	htab_finish_init();
+
 	DBG(" <- htab_initialize()\n");
 }
 #undef KB
@@ -721,16 +758,6 @@ void flush_hash_range(unsigned long numb
 	}
 }
 
-static inline void make_bl(unsigned int *insn_addr, void *func)
-{
-	unsigned long funcp = *((unsigned long *)func);
-	int offset = funcp - (unsigned long)insn_addr;
-
-	*insn_addr = (unsigned int)(0x48000001 | (offset & 0x03fffffc));
-	flush_icache_range((unsigned long)insn_addr, 4+
-			   (unsigned long)insn_addr);
-}
-
 /*
  * low_hash_fault is called when we the low level hash code failed
  * to instert a PTE due to an hypervisor error
@@ -749,28 +776,3 @@ void low_hash_fault(struct pt_regs *regs
 	}
 	bad_page_fault(regs, address, SIGBUS);
 }
-
-void __init htab_finish_init(void)
-{
-	extern unsigned int *htab_call_hpte_insert1;
-	extern unsigned int *htab_call_hpte_insert2;
-	extern unsigned int *htab_call_hpte_remove;
-	extern unsigned int *htab_call_hpte_updatepp;
-
-#ifdef CONFIG_PPC_64K_PAGES
-	extern unsigned int *ht64_call_hpte_insert1;
-	extern unsigned int *ht64_call_hpte_insert2;
-	extern unsigned int *ht64_call_hpte_remove;
-	extern unsigned int *ht64_call_hpte_updatepp;
-
-	make_bl(ht64_call_hpte_insert1, ppc_md.hpte_insert);
-	make_bl(ht64_call_hpte_insert2, ppc_md.hpte_insert);
-	make_bl(ht64_call_hpte_remove, ppc_md.hpte_remove);
-	make_bl(ht64_call_hpte_updatepp, ppc_md.hpte_updatepp);
-#endif /* CONFIG_PPC_64K_PAGES */
-
-	make_bl(htab_call_hpte_insert1, ppc_md.hpte_insert);
-	make_bl(htab_call_hpte_insert2, ppc_md.hpte_insert);
-	make_bl(htab_call_hpte_remove, ppc_md.hpte_remove);
-	make_bl(htab_call_hpte_updatepp, ppc_md.hpte_updatepp);
-}
Index: to-merge/arch/powerpc/platforms/iseries/htab.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/htab.c
+++ to-merge/arch/powerpc/platforms/iseries/htab.c
@@ -242,13 +242,11 @@ static void iSeries_hpte_invalidate(unsi
 	local_irq_restore(flags);
 }
 
-void hpte_init_iSeries(void)
+void __init hpte_init_iSeries(void)
 {
 	ppc_md.hpte_invalidate	= iSeries_hpte_invalidate;
 	ppc_md.hpte_updatepp	= iSeries_hpte_updatepp;
 	ppc_md.hpte_updateboltedpp = iSeries_hpte_updateboltedpp;
 	ppc_md.hpte_insert	= iSeries_hpte_insert;
 	ppc_md.hpte_remove	= iSeries_hpte_remove;
-
-	htab_finish_init();
 }
Index: to-merge/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/setup.c
+++ to-merge/arch/powerpc/platforms/iseries/setup.c
@@ -326,11 +326,6 @@ static void __init iSeries_init_early(vo
 	iSeries_recal_titan = HvCallXm_loadTod();
 
 	/*
-	 * Initialize the hash table management pointers
-	 */
-	hpte_init_iSeries();
-
-	/*
 	 * Initialize the DMA/TCE management
 	 */
 	iommu_init_early_iSeries();
@@ -684,6 +679,8 @@ static int __init iseries_probe(void)
 	powerpc_firmware_features |= FW_FEATURE_ISERIES;
 	powerpc_firmware_features |= FW_FEATURE_LPAR;
 
+	hpte_init_iSeries();
+
 	return 1;
 }
 
Index: to-merge/arch/powerpc/platforms/maple/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/maple/setup.c
+++ to-merge/arch/powerpc/platforms/maple/setup.c
@@ -199,11 +199,6 @@ static void __init maple_init_early(void
 {
 	DBG(" -> maple_init_early\n");
 
-	/* Initialize hash table, from now on, we can take hash faults
-	 * and call ioremap
-	 */
-	hpte_init_native();
-
 	/* Setup interrupt mapping options */
 	ppc64_interrupt_controller = IC_OPEN_PIC;
 
@@ -272,6 +267,8 @@ static int __init maple_probe(void)
 	 */
 	alloc_dart_table();
 
+	hpte_init_native();
+
 	return 1;
 }
 
Index: to-merge/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/powermac/setup.c
+++ to-merge/arch/powerpc/platforms/powermac/setup.c
@@ -588,13 +588,6 @@ pmac_halt(void)
  */
 static void __init pmac_init_early(void)
 {
-#ifdef CONFIG_PPC64
-	/* Initialize hash table, from now on, we can take hash faults
-	 * and call ioremap
-	 */
-	hpte_init_native();
-#endif
-
 	/* Enable early btext debug if requested */
 	if (strstr(cmd_line, "btextdbg")) {
 		udbg_adb_init_early();
@@ -671,6 +664,8 @@ static int __init pmac_probe(void)
 	 * part of the cacheable linar mapping
 	 */
 	alloc_dart_table();
+
+	hpte_init_native();
 #endif
 
 #ifdef CONFIG_PPC32
Index: to-merge/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/lpar.c
+++ to-merge/arch/powerpc/platforms/pseries/lpar.c
@@ -512,7 +512,7 @@ void pSeries_lpar_flush_hash_range(unsig
 		spin_unlock_irqrestore(&pSeries_lpar_tlbie_lock, flags);
 }
 
-void hpte_init_lpar(void)
+void __init hpte_init_lpar(void)
 {
 	ppc_md.hpte_invalidate	= pSeries_lpar_hpte_invalidate;
 	ppc_md.hpte_updatepp	= pSeries_lpar_hpte_updatepp;
@@ -521,6 +521,4 @@ void hpte_init_lpar(void)
 	ppc_md.hpte_remove	= pSeries_lpar_hpte_remove;
 	ppc_md.flush_hash_range	= pSeries_lpar_flush_hash_range;
 	ppc_md.hpte_clear_all   = pSeries_lpar_hptab_clear;
-
-	htab_finish_init();
 }
Index: to-merge/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/setup.c
+++ to-merge/arch/powerpc/platforms/pseries/setup.c
@@ -322,11 +322,6 @@ static void __init pSeries_init_early(vo
 	DBG(" -> pSeries_init_early()\n");
 
 	fw_feature_init();
-	
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		hpte_init_lpar();
-	else
-		hpte_init_native();
 
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		find_udbg_vterm();
@@ -384,6 +379,11 @@ static int __init pSeries_probe_hypertas
 	if (of_get_flat_dt_prop(node, "ibm,hypertas-functions", NULL) != NULL)
  		powerpc_firmware_features |= FW_FEATURE_LPAR;
 
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		hpte_init_lpar();
+	else
+		hpte_init_native();
+
  	return 1;
 }
 
Index: to-merge/include/asm-powerpc/mmu.h
===================================================================
--- to-merge.orig/include/asm-powerpc/mmu.h
+++ to-merge/include/asm-powerpc/mmu.h
@@ -226,7 +226,6 @@ extern int hash_huge_page(struct mm_stru
 			  unsigned long ea, unsigned long vsid, int local,
 			  unsigned long trap);
 
-extern void htab_finish_init(void);
 extern int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 			     unsigned long pstart, unsigned long mode,
 			     int psize);

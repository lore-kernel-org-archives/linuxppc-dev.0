Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Mar 2009 14:53:40 +1100
Subject: [PATCH 9/9] powerpc/mm: Introduce early_init_mmu() on 64-bit
In-Reply-To: <1236743604.932194.842849421348.qpush@grosgo>
Message-Id: <20090311035343.1CA87DE198@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This moves some MMU related init code out of setup_64.c into hash_utils_64.c
and calls it early_init_mmu() and early_init_mmu_secondary(). This will
make it easier to plug in a new MMU type.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/mmu-hash64.h |    2 -
 arch/powerpc/include/asm/mmu.h        |    4 +++
 arch/powerpc/kernel/setup_64.c        |   35 ++++-----------------------------
 arch/powerpc/mm/hash_utils_64.c       |   36 ++++++++++++++++++++++++++++++++--
 4 files changed, 43 insertions(+), 34 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/mmu-hash64.h	2009-03-11 13:43:26.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/mmu-hash64.h	2009-03-11 13:43:29.000000000 +1100
@@ -284,8 +284,6 @@ extern void add_gpage(unsigned long addr
 			  unsigned long number_of_pages);
 extern void demote_segment_4k(struct mm_struct *mm, unsigned long addr);
 
-extern void htab_initialize(void);
-extern void htab_initialize_secondary(void);
 extern void hpte_init_native(void);
 extern void hpte_init_lpar(void);
 extern void hpte_init_iSeries(void);
Index: linux-work/arch/powerpc/include/asm/mmu.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu.h	2009-03-11 13:43:39.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/mmu.h	2009-03-11 13:48:40.000000000 +1100
@@ -56,6 +56,10 @@ static inline int mmu_has_feature(unsign
 
 extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
 
+/* MMU initialization (64-bit only fo now) */
+extern void early_init_mmu(void);
+extern void early_init_mmu_secondary(void);
+
 #endif /* !__ASSEMBLY__ */
 
 
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2009-03-11 13:42:09.000000000 +1100
+++ linux-work/arch/powerpc/kernel/setup_64.c	2009-03-11 13:55:15.000000000 +1100
@@ -202,8 +202,6 @@ void __init early_setup(unsigned long dt
 
 	/* Fix up paca fields required for the boot cpu */
 	get_paca()->cpu_start = 1;
-	get_paca()->stab_real = __pa((u64)&initial_stab);
-	get_paca()->stab_addr = (u64)&initial_stab;
 
 	/* Probe the machine type */
 	probe_machine();
@@ -212,20 +210,8 @@ void __init early_setup(unsigned long dt
 
 	DBG("Found, Initializing memory management...\n");
 
-	/*
-	 * Initialize the MMU Hash table and create the linear mapping
-	 * of memory. Has to be done before stab/slb initialization as
-	 * this is currently where the page size encoding is obtained
-	 */
-	htab_initialize();
-
-	/*
-	 * Initialize stab / SLB management except on iSeries
-	 */
-	if (cpu_has_feature(CPU_FTR_SLB))
-		slb_initialize();
-	else if (!firmware_has_feature(FW_FEATURE_ISERIES))
-		stab_initialize(get_paca()->stab_real);
+	/* Initialize the hash table or TLB handling */
+	early_init_mmu();
 
 	DBG(" <- early_setup()\n");
 }
@@ -233,22 +219,11 @@ void __init early_setup(unsigned long dt
 #ifdef CONFIG_SMP
 void early_setup_secondary(void)
 {
-	struct paca_struct *lpaca = get_paca();
-
 	/* Mark interrupts enabled in PACA */
-	lpaca->soft_enabled = 0;
-
-	/* Initialize hash table for that CPU */
-	htab_initialize_secondary();
+	get_paca()->soft_enabled = 0;
 
-	/* Initialize STAB/SLB. We use a virtual address as it works
-	 * in real mode on pSeries and we want a virutal address on
-	 * iSeries anyway
-	 */
-	if (cpu_has_feature(CPU_FTR_SLB))
-		slb_initialize();
-	else
-		stab_initialize(lpaca->stab_addr);
+	/* Initialize the hash table or TLB handling */
+	early_init_mmu_secondary();
 }
 
 #endif /* CONFIG_SMP */
Index: linux-work/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_utils_64.c	2009-03-11 13:41:36.000000000 +1100
+++ linux-work/arch/powerpc/mm/hash_utils_64.c	2009-03-11 13:54:50.000000000 +1100
@@ -590,7 +590,7 @@ static void __init htab_finish_init(void
 	make_bl(htab_call_hpte_updatepp, ppc_md.hpte_updatepp);
 }
 
-void __init htab_initialize(void)
+static void __init htab_initialize(void)
 {
 	unsigned long table;
 	unsigned long pteg_count;
@@ -732,11 +732,43 @@ void __init htab_initialize(void)
 #undef KB
 #undef MB
 
-void htab_initialize_secondary(void)
+void __init early_init_mmu(void)
 {
+	/* Setup initial STAB address in the PACA */
+	get_paca()->stab_real = __pa((u64)&initial_stab);
+	get_paca()->stab_addr = (u64)&initial_stab;
+
+	/* Initialize the MMU Hash table and create the linear mapping
+	 * of memory. Has to be done before stab/slb initialization as
+	 * this is currently where the page size encoding is obtained
+	 */
+	htab_initialize();
+
+	/* Initialize stab / SLB management except on iSeries
+	 */
+	if (cpu_has_feature(CPU_FTR_SLB))
+		slb_initialize();
+	else if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		stab_initialize(get_paca()->stab_real);
+}
+
+#ifdef CONFIG_SMP
+void __init early_init_mmu_secondary(void)
+{
+	/* Initialize hash table for that CPU */
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		mtspr(SPRN_SDR1, _SDR1);
+
+	/* Initialize STAB/SLB. We use a virtual address as it works
+	 * in real mode on pSeries and we want a virutal address on
+	 * iSeries anyway
+	 */
+	if (cpu_has_feature(CPU_FTR_SLB))
+		slb_initialize();
+	else
+		stab_initialize(get_paca()->stab_addr);
 }
+#endif /* CONFIG_SMP */
 
 /*
  * Called by asm hashtable.S for doing lazy icache flush

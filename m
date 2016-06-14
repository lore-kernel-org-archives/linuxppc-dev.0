Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTL4T4Wq6zDqhd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 16:55:05 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5E6rxI3111653
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:03 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gcydp99c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:03 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 00:55:02 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 02/10] powerpc/mm: Convert early cpu/mmu feature check
 to use the new helpers
Date: Tue, 14 Jun 2016 12:24:40 +0530
In-Reply-To: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465887288-12952-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This switch most of the early feature check to use the non static key
variant of the function. In later patches we will be switching
cpu_has_feature and mmu_has_feature to use static keys and we can use
them only after static key/jump label is initialized. Any check for
feature before jump label init should be done using this new helper.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  2 +-
 arch/powerpc/kernel/paca.c                    |  2 +-
 arch/powerpc/kernel/setup-common.c            |  6 +++---
 arch/powerpc/kernel/setup_32.c                | 14 +++++++-------
 arch/powerpc/kernel/setup_64.c                | 12 ++++++------
 arch/powerpc/kernel/smp.c                     |  2 +-
 arch/powerpc/kvm/book3s_hv_builtin.c          |  2 +-
 arch/powerpc/mm/44x_mmu.c                     |  6 +++---
 arch/powerpc/mm/hash_native_64.c              |  2 +-
 arch/powerpc/mm/hash_utils_64.c               | 18 +++++++++---------
 arch/powerpc/mm/hugetlbpage.c                 |  2 +-
 arch/powerpc/mm/mmu_context_nohash.c          |  4 ++--
 arch/powerpc/mm/pgtable-hash64.c              |  2 +-
 arch/powerpc/mm/ppc_mmu_32.c                  |  2 +-
 arch/powerpc/platforms/44x/iss4xx.c           |  2 +-
 arch/powerpc/platforms/44x/ppc476.c           |  2 +-
 arch/powerpc/platforms/85xx/smp.c             |  6 +++---
 arch/powerpc/platforms/cell/pervasive.c       |  2 +-
 arch/powerpc/platforms/cell/smp.c             |  2 +-
 arch/powerpc/platforms/powermac/setup.c       |  2 +-
 arch/powerpc/platforms/powermac/smp.c         |  4 ++--
 arch/powerpc/platforms/powernv/setup.c        |  2 +-
 arch/powerpc/platforms/powernv/smp.c          |  4 ++--
 arch/powerpc/platforms/powernv/subcore.c      |  2 +-
 arch/powerpc/platforms/pseries/lpar.c         |  4 ++--
 arch/powerpc/platforms/pseries/smp.c          |  6 +++---
 27 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 5f9ee699da5f..fde50026603e 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -256,7 +256,7 @@ static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
 	 */
 	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
 	v <<= HPTE_V_AVPN_SHIFT;
-	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+	if (!__cpu_has_feature(CPU_FTR_ARCH_300))
 		v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
 	return v;
 }
@@ -284,7 +284,7 @@ static inline unsigned long hpte_encode_r(unsigned long pa, int base_psize,
 					  int actual_psize, int ssize)
 {
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
+	if (__cpu_has_feature(CPU_FTR_ARCH_300))
 		pa |= ((unsigned long) ssize) << HPTE_R_3_0_SSIZE_SHIFT;
 
 	/* A 4K page needs no special encoding */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 71f0d8ead71d..4c48b87d46f2 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -806,7 +806,7 @@ static inline int __meminit vmemmap_create_mapping(unsigned long start,
 						   unsigned long page_size,
 						   unsigned long phys)
 {
-	if (radix_enabled())
+	if (__radix_enabled())
 		return radix__vmemmap_create_mapping(start, page_size, phys);
 	return hash__vmemmap_create_mapping(start, page_size, phys);
 }
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 93dae296b6be..1b0b89e80824 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -184,7 +184,7 @@ void setup_paca(struct paca_struct *new_paca)
 	 * if we do a GET_PACA() before the feature fixups have been
 	 * applied
 	 */
-	if (cpu_has_feature(CPU_FTR_HVMODE))
+	if (__cpu_has_feature(CPU_FTR_HVMODE))
 		mtspr(SPRN_SPRG_HPACA, local_paca);
 #endif
 	mtspr(SPRN_SPRG_PACA, local_paca);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 8ca79b7503d8..f43d2d76d81f 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -236,7 +236,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "unknown (%08x)", pvr);
 
 #ifdef CONFIG_ALTIVEC
-	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+	if (__cpu_has_feature(CPU_FTR_ALTIVEC))
 		seq_printf(m, ", altivec supported");
 #endif /* CONFIG_ALTIVEC */
 
@@ -484,7 +484,7 @@ void __init smp_setup_cpu_maps(void)
 	}
 
 	/* If no SMT supported, nthreads is forced to 1 */
-	if (!cpu_has_feature(CPU_FTR_SMT)) {
+	if (!__cpu_has_feature(CPU_FTR_SMT)) {
 		DBG("  SMT disabled ! nthreads forced to 1\n");
 		nthreads = 1;
 	}
@@ -510,7 +510,7 @@ void __init smp_setup_cpu_maps(void)
 		maxcpus = be32_to_cpup(ireg + num_addr_cell + num_size_cell);
 
 		/* Double maxcpus for processors which have SMT capability */
-		if (cpu_has_feature(CPU_FTR_SMT))
+		if (__cpu_has_feature(CPU_FTR_SMT))
 			maxcpus *= nthreads;
 
 		if (maxcpus > nr_cpu_ids) {
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index d544fa311757..ecdc42d44951 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -132,14 +132,14 @@ notrace void __init machine_init(u64 dt_ptr)
 	setup_kdump_trampoline();
 
 #ifdef CONFIG_6xx
-	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
-	    cpu_has_feature(CPU_FTR_CAN_NAP))
+	if (__cpu_has_feature(CPU_FTR_CAN_DOZE) ||
+	    __cpu_has_feature(CPU_FTR_CAN_NAP))
 		ppc_md.power_save = ppc6xx_idle;
 #endif
 
 #ifdef CONFIG_E500
-	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
-	    cpu_has_feature(CPU_FTR_CAN_NAP))
+	if (__cpu_has_feature(CPU_FTR_CAN_DOZE) ||
+	    __cpu_has_feature(CPU_FTR_CAN_NAP))
 		ppc_md.power_save = e500_idle;
 #endif
 	if (ppc_md.progress)
@@ -149,7 +149,7 @@ notrace void __init machine_init(u64 dt_ptr)
 /* Checks "l2cr=xxxx" command-line option */
 int __init ppc_setup_l2cr(char *str)
 {
-	if (cpu_has_feature(CPU_FTR_L2CR)) {
+	if (__cpu_has_feature(CPU_FTR_L2CR)) {
 		unsigned long val = simple_strtoul(str, NULL, 0);
 		printk(KERN_INFO "l2cr set to %lx\n", val);
 		_set_L2CR(0);		/* force invalidate by disable cache */
@@ -162,7 +162,7 @@ __setup("l2cr=", ppc_setup_l2cr);
 /* Checks "l3cr=xxxx" command-line option */
 int __init ppc_setup_l3cr(char *str)
 {
-	if (cpu_has_feature(CPU_FTR_L3CR)) {
+	if (__cpu_has_feature(CPU_FTR_L3CR)) {
 		unsigned long val = simple_strtoul(str, NULL, 0);
 		printk(KERN_INFO "l3cr set to %lx\n", val);
 		_set_L3CR(val);		/* and enable it */
@@ -294,7 +294,7 @@ void __init setup_arch(char **cmdline_p)
 	dcache_bsize = cur_cpu_spec->dcache_bsize;
 	icache_bsize = cur_cpu_spec->icache_bsize;
 	ucache_bsize = 0;
-	if (cpu_has_feature(CPU_FTR_UNIFIED_ID_CACHE))
+	if (__cpu_has_feature(CPU_FTR_UNIFIED_ID_CACHE))
 		ucache_bsize = icache_bsize = dcache_bsize;
 
 	if (ppc_md.panic)
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 96d4a2b23d0f..86aea0537270 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -125,7 +125,7 @@ static void setup_tlb_core_data(void)
 		 * will be racy and could produce duplicate entries.
 		 */
 		if (smt_enabled_at_boot >= 2 &&
-		    !mmu_has_feature(MMU_FTR_USE_TLBRSRV) &&
+		    !__mmu_has_feature(MMU_FTR_USE_TLBRSRV) &&
 		    book3e_htw_mode != PPC_HTW_E6500) {
 			/* Should we panic instead? */
 			WARN_ONCE("%s: unsupported MMU configuration -- expect problems\n",
@@ -216,8 +216,8 @@ static void cpu_ready_for_interrupts(void)
 	 * not in hypervisor mode, we enable relocation-on interrupts later
 	 * in pSeries_setup_arch() using the H_SET_MODE hcall.
 	 */
-	if (cpu_has_feature(CPU_FTR_HVMODE) &&
-	    cpu_has_feature(CPU_FTR_ARCH_207S)) {
+	if (__cpu_has_feature(CPU_FTR_HVMODE) &&
+	    __cpu_has_feature(CPU_FTR_ARCH_207S)) {
 		unsigned long lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
 	}
@@ -588,13 +588,13 @@ static u64 safe_stack_limit(void)
 {
 #ifdef CONFIG_PPC_BOOK3E
 	/* Freescale BookE bolts the entire linear mapping */
-	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E))
+	if (__mmu_has_feature(MMU_FTR_TYPE_FSL_E))
 		return linear_map_top;
 	/* Other BookE, we assume the first GB is bolted */
 	return 1ul << 30;
 #else
 	/* BookS, the first segment is bolted */
-	if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
+	if (__mmu_has_feature(MMU_FTR_1T_SEGMENT))
 		return 1UL << SID_SHIFT_1T;
 	return 1UL << SID_SHIFT;
 #endif
@@ -639,7 +639,7 @@ static void __init exc_lvl_early_init(void)
 		paca[i].mc_kstack = __va(sp + THREAD_SIZE);
 	}
 
-	if (cpu_has_feature(CPU_FTR_DEBUG_LVL_EXC))
+	if (__cpu_has_feature(CPU_FTR_DEBUG_LVL_EXC))
 		patch_exception(0x040, exc_debug_debug_book3e);
 }
 #else
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 55c924b65f71..8c0ee8fae5d9 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -94,7 +94,7 @@ int smp_generic_cpu_bootable(unsigned int nr)
 	/* Special case - we inhibit secondary thread startup
 	 * during boot if the user requests it.
 	 */
-	if (system_state == SYSTEM_BOOTING && cpu_has_feature(CPU_FTR_SMT)) {
+	if (system_state == SYSTEM_BOOTING && __cpu_has_feature(CPU_FTR_SMT)) {
 		if (!smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
 			return 0;
 		if (smt_enabled_at_boot
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 5f0380db3eab..cadb2d0f9892 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -80,7 +80,7 @@ void __init kvm_cma_reserve(void)
 	/*
 	 * We need CMA reservation only when we are in HV mode
 	 */
-	if (!cpu_has_feature(CPU_FTR_HVMODE))
+	if (!__cpu_has_feature(CPU_FTR_HVMODE))
 		return;
 	/*
 	 * We cannot use memblock_phys_mem_size() here, because
diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index 82b1ff759e26..0b17851b0f90 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -187,12 +187,12 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 	 * initial 256M mapping established in head_44x.S */
 	for (addr = memstart + PPC_PIN_SIZE; addr < lowmem_end_addr;
 	     addr += PPC_PIN_SIZE) {
-		if (mmu_has_feature(MMU_FTR_TYPE_47x))
+		if (__mmu_has_feature(MMU_FTR_TYPE_47x))
 			ppc47x_pin_tlb(addr + PAGE_OFFSET, addr);
 		else
 			ppc44x_pin_tlb(addr + PAGE_OFFSET, addr);
 	}
-	if (mmu_has_feature(MMU_FTR_TYPE_47x)) {
+	if (__mmu_has_feature(MMU_FTR_TYPE_47x)) {
 		ppc47x_update_boltmap();
 
 #ifdef DEBUG
@@ -245,7 +245,7 @@ void mmu_init_secondary(int cpu)
 	 */
 	for (addr = memstart + PPC_PIN_SIZE; addr < lowmem_end_addr;
 	     addr += PPC_PIN_SIZE) {
-		if (mmu_has_feature(MMU_FTR_TYPE_47x))
+		if (__mmu_has_feature(MMU_FTR_TYPE_47x))
 			ppc47x_pin_tlb(addr + PAGE_OFFSET, addr);
 		else
 			ppc44x_pin_tlb(addr + PAGE_OFFSET, addr);
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 4dabd40e5398..eb18ca9fce88 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -740,6 +740,6 @@ void __init hpte_init_native(void)
 	ppc_md.flush_hash_range = native_flush_hash_range;
 	ppc_md.hugepage_invalidate   = native_hugepage_invalidate;
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
+	if (__cpu_has_feature(CPU_FTR_ARCH_300))
 		ppc_md.update_partition_table = native_update_partition_table;
 }
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 7bab130174b4..fcf676f7f522 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -510,7 +510,7 @@ static bool might_have_hea(void)
 	 * we will never see an HEA ethernet device.
 	 */
 #ifdef CONFIG_IBMEBUS
-	return !cpu_has_feature(CPU_FTR_ARCH_207S);
+	return !__cpu_has_feature(CPU_FTR_ARCH_207S);
 #else
 	return false;
 #endif
@@ -540,7 +540,7 @@ static void __init htab_init_page_sizes(void)
 	 * Not in the device-tree, let's fallback on known size
 	 * list for 16M capable GP & GR
 	 */
-	if (mmu_has_feature(MMU_FTR_16M_PAGE))
+	if (__mmu_has_feature(MMU_FTR_16M_PAGE))
 		memcpy(mmu_psize_defs, mmu_psize_defaults_gp,
 		       sizeof(mmu_psize_defaults_gp));
 found:
@@ -570,7 +570,7 @@ found:
 		mmu_vmalloc_psize = MMU_PAGE_64K;
 		if (mmu_linear_psize == MMU_PAGE_4K)
 			mmu_linear_psize = MMU_PAGE_64K;
-		if (mmu_has_feature(MMU_FTR_CI_LARGE_PAGE)) {
+		if (__mmu_has_feature(MMU_FTR_CI_LARGE_PAGE)) {
 			/*
 			 * When running on pSeries using 64k pages for ioremap
 			 * would stop us accessing the HEA ethernet. So if we
@@ -714,7 +714,7 @@ static void __init hash_partition_table_initialize(phys_addr_t hash_table,
 	/* Initialize the Partition Table with no entries */
 	memset((void *)partition_tb, 0, patb_size);
 	partition_tb->patb0 = cpu_to_be64(ps_field | hash_table | htab_size);
-	if (!mmu_has_feature(MMU_FTR_TYPE_SEG_TABLE))
+	if (!__mmu_has_feature(MMU_FTR_TYPE_SEG_TABLE))
 		partition_tb->patb1 = 0;
 	pr_info("Partition table %p\n", partition_tb);
 	/*
@@ -785,7 +785,7 @@ static void __init htab_initialize(void)
 	/* Initialize page sizes */
 	htab_init_page_sizes();
 
-	if (mmu_has_feature(MMU_FTR_1T_SEGMENT)) {
+	if (__mmu_has_feature(MMU_FTR_1T_SEGMENT)) {
 		mmu_kernel_ssize = MMU_SEGSIZE_1T;
 		mmu_highuser_ssize = MMU_SEGSIZE_1T;
 		printk(KERN_INFO "Using 1TB segments\n");
@@ -837,7 +837,7 @@ static void __init htab_initialize(void)
 		/* Initialize the HPT with no entries */
 		memset((void *)table, 0, htab_size_bytes);
 
-		if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		if (!__cpu_has_feature(CPU_FTR_ARCH_300))
 			/* Set SDR1 */
 			mtspr(SPRN_SDR1, _SDR1);
 		else
@@ -965,7 +965,7 @@ void __init hash__early_init_mmu(void)
 	 */
 	htab_initialize();
 
-	if (mmu_has_feature(MMU_FTR_TYPE_SEG_TABLE)) {
+	if (__mmu_has_feature(MMU_FTR_TYPE_SEG_TABLE)) {
 		unsigned long prtb;
 		unsigned long lpcr;
 		/*
@@ -988,7 +988,7 @@ void __init hash__early_init_mmu(void)
 #ifdef CONFIG_SMP
 void hash__early_init_mmu_secondary(void)
 {
-	if (mmu_has_feature(MMU_FTR_TYPE_SEG_TABLE)) {
+	if (__mmu_has_feature(MMU_FTR_TYPE_SEG_TABLE)) {
 		unsigned long lpcr;
 		/*
 		 * setup LPCR UPRT based on mmu_features
@@ -1001,7 +1001,7 @@ void hash__early_init_mmu_secondary(void)
 
 	/* Initialize hash table for that CPU */
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
-		if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		if (!__cpu_has_feature(CPU_FTR_ARCH_300))
 			mtspr(SPRN_SDR1, _SDR1);
 		else
 			mtspr(SPRN_PTCR,
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 5aac1a3f86cd..060cdf5324ff 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -828,7 +828,7 @@ static int __init hugetlbpage_init(void)
 {
 	int psize;
 
-	if (!radix_enabled() && !mmu_has_feature(MMU_FTR_16M_PAGE))
+	if (!radix_enabled() && !__mmu_has_feature(MMU_FTR_16M_PAGE))
 		return -ENODEV;
 
 	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 7d95bc402dba..4ec513e506fb 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -442,11 +442,11 @@ void __init mmu_context_init(void)
 	 * present if needed.
 	 *      -- BenH
 	 */
-	if (mmu_has_feature(MMU_FTR_TYPE_8xx)) {
+	if (__mmu_has_feature(MMU_FTR_TYPE_8xx)) {
 		first_context = 0;
 		last_context = 15;
 		no_selective_tlbil = true;
-	} else if (mmu_has_feature(MMU_FTR_TYPE_47x)) {
+	} else if (__mmu_has_feature(MMU_FTR_TYPE_47x)) {
 		first_context = 1;
 		last_context = 65535;
 		no_selective_tlbil = false;
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index c23e286a6b8f..d9b5804bdce9 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -313,7 +313,7 @@ pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 int hash__has_transparent_hugepage(void)
 {
 
-	if (!mmu_has_feature(MMU_FTR_16M_PAGE))
+	if (!__mmu_has_feature(MMU_FTR_16M_PAGE))
 		return 0;
 	/*
 	 * We support THP only if PMD_SIZE is 16MB.
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 2a049fb8523d..0915733d8ae4 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -187,7 +187,7 @@ void __init MMU_init_hw(void)
 	extern unsigned int hash_page[];
 	extern unsigned int flush_hash_patch_A[], flush_hash_patch_B[];
 
-	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
+	if (!__mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
 		/*
 		 * Put a blr (procedure return) instruction at the
 		 * start of hash_page, since we can still get DSI
diff --git a/arch/powerpc/platforms/44x/iss4xx.c b/arch/powerpc/platforms/44x/iss4xx.c
index c7c6758b3cfe..506b711828b0 100644
--- a/arch/powerpc/platforms/44x/iss4xx.c
+++ b/arch/powerpc/platforms/44x/iss4xx.c
@@ -131,7 +131,7 @@ static struct smp_ops_t iss_smp_ops = {
 
 static void __init iss4xx_smp_init(void)
 {
-	if (mmu_has_feature(MMU_FTR_TYPE_47x))
+	if (__mmu_has_feature(MMU_FTR_TYPE_47x))
 		smp_ops = &iss_smp_ops;
 }
 
diff --git a/arch/powerpc/platforms/44x/ppc476.c b/arch/powerpc/platforms/44x/ppc476.c
index c11ce6516c8f..895dc63d6a49 100644
--- a/arch/powerpc/platforms/44x/ppc476.c
+++ b/arch/powerpc/platforms/44x/ppc476.c
@@ -201,7 +201,7 @@ static struct smp_ops_t ppc47x_smp_ops = {
 
 static void __init ppc47x_smp_init(void)
 {
-	if (mmu_has_feature(MMU_FTR_TYPE_47x))
+	if (__mmu_has_feature(MMU_FTR_TYPE_47x))
 		smp_ops = &ppc47x_smp_ops;
 }
 
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index fe9f19e5e935..a4705d964187 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -280,7 +280,7 @@ static int smp_85xx_kick_cpu(int nr)
 
 #ifdef CONFIG_PPC64
 	if (threads_per_core == 2) {
-		if (WARN_ON_ONCE(!cpu_has_feature(CPU_FTR_SMT)))
+		if (WARN_ON_ONCE(!__cpu_has_feature(CPU_FTR_SMT)))
 			return -ENOENT;
 
 		booting_thread_hwid = cpu_thread_in_core(nr);
@@ -462,7 +462,7 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 
 static void smp_85xx_basic_setup(int cpu_nr)
 {
-	if (cpu_has_feature(CPU_FTR_DBELL))
+	if (__cpu_has_feature(CPU_FTR_DBELL))
 		doorbell_setup_this_cpu();
 }
 
@@ -485,7 +485,7 @@ void __init mpc85xx_smp_init(void)
 	} else
 		smp_85xx_ops.setup_cpu = smp_85xx_basic_setup;
 
-	if (cpu_has_feature(CPU_FTR_DBELL)) {
+	if (__cpu_has_feature(CPU_FTR_DBELL)) {
 		/*
 		 * If left NULL, .message_pass defaults to
 		 * smp_muxed_ipi_message_pass
diff --git a/arch/powerpc/platforms/cell/pervasive.c b/arch/powerpc/platforms/cell/pervasive.c
index d17e98bc0c10..f053602e63fa 100644
--- a/arch/powerpc/platforms/cell/pervasive.c
+++ b/arch/powerpc/platforms/cell/pervasive.c
@@ -115,7 +115,7 @@ void __init cbe_pervasive_init(void)
 {
 	int cpu;
 
-	if (!cpu_has_feature(CPU_FTR_PAUSE_ZERO))
+	if (!__cpu_has_feature(CPU_FTR_PAUSE_ZERO))
 		return;
 
 	for_each_possible_cpu(cpu) {
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index 895560f4be69..4d373c6375a8 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -148,7 +148,7 @@ void __init smp_init_cell(void)
 	smp_ops = &bpa_iic_smp_ops;
 
 	/* Mark threads which are still spinning in hold loops. */
-	if (cpu_has_feature(CPU_FTR_SMT)) {
+	if (__cpu_has_feature(CPU_FTR_SMT)) {
 		for_each_present_cpu(i) {
 			if (cpu_thread_in_core(i) == 0)
 				cpumask_set_cpu(i, &of_spin_map);
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 8dd78f4e1af4..615bb39b82d3 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -248,7 +248,7 @@ static void __init ohare_init(void)
 static void __init l2cr_init(void)
 {
 	/* Checks "l2cr-value" property in the registry */
-	if (cpu_has_feature(CPU_FTR_L2CR)) {
+	if (__cpu_has_feature(CPU_FTR_L2CR)) {
 		struct device_node *np = of_find_node_by_name(NULL, "cpus");
 		if (np == 0)
 			np = of_find_node_by_type(NULL, "cpu");
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 28a147ca32ba..d917ebad551e 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -670,7 +670,7 @@ volatile static long int core99_l3_cache;
 static void core99_init_caches(int cpu)
 {
 #ifndef CONFIG_PPC64
-	if (!cpu_has_feature(CPU_FTR_L2CR))
+	if (!__cpu_has_feature(CPU_FTR_L2CR))
 		return;
 
 	if (cpu == 0) {
@@ -683,7 +683,7 @@ static void core99_init_caches(int cpu)
 		printk("CPU%d: L2CR set to %lx\n", cpu, core99_l2_cache);
 	}
 
-	if (!cpu_has_feature(CPU_FTR_L3CR))
+	if (!__cpu_has_feature(CPU_FTR_L3CR))
 		return;
 
 	if (cpu == 0){
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index ee6430bedcc3..aed4ba5017aa 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -273,7 +273,7 @@ static int __init pnv_probe(void)
 	if (!of_flat_dt_is_compatible(root, "ibm,powernv"))
 		return 0;
 
-	if (IS_ENABLED(CONFIG_PPC_RADIX_MMU) && radix_enabled())
+	if (IS_ENABLED(CONFIG_PPC_RADIX_MMU) && __radix_enabled())
 		radix_init_native();
 	else if (IS_ENABLED(CONFIG_PPC_STD_MMU_64))
 		hpte_init_native();
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index ad7b1a3dbed0..a9f20306d305 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -50,7 +50,7 @@ static void pnv_smp_setup_cpu(int cpu)
 		xics_setup_cpu();
 
 #ifdef CONFIG_PPC_DOORBELL
-	if (cpu_has_feature(CPU_FTR_DBELL))
+	if (__cpu_has_feature(CPU_FTR_DBELL))
 		doorbell_setup_this_cpu();
 #endif
 }
@@ -233,7 +233,7 @@ static int pnv_cpu_bootable(unsigned int nr)
 	 * switches. So on those machines we ignore the smt_enabled_at_boot
 	 * setting (smt-enabled on the kernel command line).
 	 */
-	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+	if (__cpu_has_feature(CPU_FTR_ARCH_207S))
 		return 1;
 
 	return smp_generic_cpu_bootable(nr);
diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index 0babef11136f..abf308fbb385 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -407,7 +407,7 @@ static DEVICE_ATTR(subcores_per_core, 0644,
 
 static int subcore_init(void)
 {
-	if (!cpu_has_feature(CPU_FTR_SUBCORE))
+	if (!__cpu_has_feature(CPU_FTR_SUBCORE))
 		return 0;
 
 	/*
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 7f6100d91b4b..c6b20c24ecc9 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -75,10 +75,10 @@ void vpa_init(int cpu)
 	 */
 	WARN_ON(cpu != smp_processor_id());
 
-	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+	if (__cpu_has_feature(CPU_FTR_ALTIVEC))
 		lppaca_of(cpu).vmxregs_in_use = 1;
 
-	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+	if (__cpu_has_feature(CPU_FTR_ARCH_207S))
 		lppaca_of(cpu).ebb_regs_in_use = 1;
 
 	addr = __pa(&lppaca_of(cpu));
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 6932ea803e33..720d9ecffc58 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -144,7 +144,7 @@ static void smp_xics_setup_cpu(int cpu)
 {
 	if (cpu != boot_cpuid)
 		xics_setup_cpu();
-	if (cpu_has_feature(CPU_FTR_DBELL))
+	if (__cpu_has_feature(CPU_FTR_DBELL))
 		doorbell_setup_this_cpu();
 
 	if (firmware_has_feature(FW_FEATURE_SPLPAR))
@@ -201,7 +201,7 @@ static __init void pSeries_smp_probe(void)
 {
 	xics_smp_probe();
 
-	if (cpu_has_feature(CPU_FTR_DBELL)) {
+	if (__cpu_has_feature(CPU_FTR_DBELL)) {
 		xics_cause_ipi = smp_ops->cause_ipi;
 		smp_ops->cause_ipi = pSeries_cause_ipi_mux;
 	}
@@ -239,7 +239,7 @@ static void __init smp_init_pseries(void)
 	 * query-cpu-stopped-state.
 	 */
 	if (rtas_token("query-cpu-stopped-state") == RTAS_UNKNOWN_SERVICE) {
-		if (cpu_has_feature(CPU_FTR_SMT)) {
+		if (__cpu_has_feature(CPU_FTR_SMT)) {
 			for_each_present_cpu(i) {
 				if (cpu_thread_in_core(i) == 0)
 					cpumask_set_cpu(i, of_spin_mask);
-- 
2.7.4

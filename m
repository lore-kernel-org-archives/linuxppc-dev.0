Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgBvv2XCLzF0nw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 04:08:43 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id j9so6824066pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 09:08:43 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 03/12] powerpc/64s: allocate lppacas individually
Date: Tue, 13 Feb 2018 03:08:13 +1000
Message-Id: <20180212170822.14612-4-npiggin@gmail.com>
In-Reply-To: <20180212170822.14612-1-npiggin@gmail.com>
References: <20180212170822.14612-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allocate LPPACAs individually.

We no longer allocate lppacas in an array, so this patch removes the 1kB
static alignment for the structure, and enforces the PAPR alignment
requirements at allocation time. We can not reduce the 1kB allocation size
however, due to existing KVM hypervisors.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/lppaca.h      | 24 ++++-----
 arch/powerpc/kernel/machine_kexec_64.c | 15 ++++--
 arch/powerpc/kernel/paca.c             | 89 ++++++++++++----------------------
 arch/powerpc/kvm/book3s_hv.c           |  3 +-
 arch/powerpc/mm/numa.c                 |  4 +-
 arch/powerpc/platforms/pseries/kexec.c |  7 ++-
 6 files changed, 63 insertions(+), 79 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 6e4589eee2da..65d589689f01 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -36,14 +36,16 @@
 #include <asm/mmu.h>
 
 /*
- * We only have to have statically allocated lppaca structs on
- * legacy iSeries, which supports at most 64 cpus.
- */
-#define NR_LPPACAS	1
-
-/*
- * The Hypervisor barfs if the lppaca crosses a page boundary.  A 1k
- * alignment is sufficient to prevent this
+ * The lppaca is the "virtual processor area" registered with the hypervisor,
+ * H_REGISTER_VPA etc.
+ *
+ * According to PAPR, the structure is 640 bytes long, must be L1 cache line
+ * aligned, and must not cross a 4kB boundary. Its size field must be at
+ * least 640 bytes (but may be more).
+ *
+ * Pre-v4.14 KVM hypervisors reject the VPA if its size field is smaller than
+ * 1kB, so we dynamically allocate 1kB and advertise size as 1kB, but keep
+ * this structure as the canonical 640 byte size.
  */
 struct lppaca {
 	/* cacheline 1 contains read-only data */
@@ -97,11 +99,9 @@ struct lppaca {
 
 	__be32	page_ins;		/* CMO Hint - # page ins by OS */
 	u8	reserved11[148];
-	volatile __be64 dtl_idx;		/* Dispatch Trace Log head index */
+	volatile __be64 dtl_idx;	/* Dispatch Trace Log head index */
 	u8	reserved12[96];
-} __attribute__((__aligned__(0x400)));
-
-extern struct lppaca lppaca[];
+} ____cacheline_aligned;
 
 #define lppaca_of(cpu)	(*paca_ptrs[cpu]->lppaca_ptr)
 
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index a250e3331f94..1044bf15d5ed 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -323,17 +323,24 @@ void default_machine_kexec(struct kimage *image)
 	kexec_stack.thread_info.cpu = current_thread_info()->cpu;
 
 	/* We need a static PACA, too; copy this CPU's PACA over and switch to
-	 * it.  Also poison per_cpu_offset to catch anyone using non-static
-	 * data.
+	 * it. Also poison per_cpu_offset and NULL lppaca to catch anyone using
+	 * non-static data.
 	 */
 	memcpy(&kexec_paca, get_paca(), sizeof(struct paca_struct));
 	kexec_paca.data_offset = 0xedeaddeadeeeeeeeUL;
+#ifdef CONFIG_PPC_PSERIES
+	kexec_paca.lppaca_ptr = NULL;
+#endif
 	paca_ptrs[kexec_paca.paca_index] = &kexec_paca;
+
 	setup_paca(&kexec_paca);
 
-	/* XXX: If anyone does 'dynamic lppacas' this will also need to be
-	 * switched to a static version!
+	/*
+	 * The lppaca should be unregistered at this point so the HV won't
+	 * touch it. In the case of a crash, none of the lppacas are
+	 * unregistered so there is not much we can do about it here.
 	 */
+
 	/*
 	 * On Book3S, the copy must happen with the MMU off if we are either
 	 * using Radix page tables or we are not in an LPAR since we can
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index eef4891c9af6..6cddb9bdc151 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -23,82 +23,50 @@
 #ifdef CONFIG_PPC_PSERIES
 
 /*
- * The structure which the hypervisor knows about - this structure
- * should not cross a page boundary.  The vpa_init/register_vpa call
- * is now known to fail if the lppaca structure crosses a page
- * boundary.  The lppaca is also used on POWER5 pSeries boxes.
- * The lppaca is 640 bytes long, and cannot readily
- * change since the hypervisor knows its layout, so a 1kB alignment
- * will suffice to ensure that it doesn't cross a page boundary.
+ * See asm/lppaca.h for more detail.
+ *
+ * lppaca structures must must be 1kB in size, L1 cache line aligned,
+ * and not cross 4kB boundary. A 1kB size and 1kB alignment will satisfy
+ * these requirements.
  */
-struct lppaca lppaca[] = {
-	[0 ... (NR_LPPACAS-1)] = {
+static inline void init_lppaca(struct lppaca *lppaca)
+{
+	BUILD_BUG_ON(sizeof(struct lppaca) != 640);
+
+	*lppaca = (struct lppaca) {
 		.desc = cpu_to_be32(0xd397d781),	/* "LpPa" */
-		.size = cpu_to_be16(sizeof(struct lppaca)),
+		.size = cpu_to_be16(0x400),
 		.fpregs_in_use = 1,
 		.slb_count = cpu_to_be16(64),
 		.vmxregs_in_use = 0,
-		.page_ins = 0,
-	},
+		.page_ins = 0, };
 };
 
-static struct lppaca *extra_lppacas;
-static long __initdata lppaca_size;
-
-static void __init allocate_lppacas(int nr_cpus, unsigned long limit)
-{
-	if (early_cpu_has_feature(CPU_FTR_HVMODE))
-		return;
-
-	if (nr_cpus <= NR_LPPACAS)
-		return;
-
-	lppaca_size = PAGE_ALIGN(sizeof(struct lppaca) *
-				 (nr_cpus - NR_LPPACAS));
-	extra_lppacas = __va(memblock_alloc_base(lppaca_size,
-						 PAGE_SIZE, limit));
-}
-
-static struct lppaca * __init new_lppaca(int cpu)
+static struct lppaca * __init new_lppaca(int cpu, unsigned long limit)
 {
 	struct lppaca *lp;
+	size_t size = 0x400;
+
+	BUILD_BUG_ON(size < sizeof(struct lppaca));
 
 	if (early_cpu_has_feature(CPU_FTR_HVMODE))
 		return NULL;
 
-	if (cpu < NR_LPPACAS)
-		return &lppaca[cpu];
-
-	lp = extra_lppacas + (cpu - NR_LPPACAS);
-	*lp = lppaca[0];
+	lp = __va(memblock_alloc_base(size, 0x400, limit));
+	init_lppaca(lp);
 
 	return lp;
 }
 
-static void __init free_lppacas(void)
+static void __init free_lppaca(struct lppaca *lp)
 {
-	long new_size = 0, nr;
+	size_t size = 0x400;
 
 	if (early_cpu_has_feature(CPU_FTR_HVMODE))
 		return;
 
-	if (!lppaca_size)
-		return;
-	nr = num_possible_cpus() - NR_LPPACAS;
-	if (nr > 0)
-		new_size = PAGE_ALIGN(nr * sizeof(struct lppaca));
-	if (new_size >= lppaca_size)
-		return;
-
-	memblock_free(__pa(extra_lppacas) + new_size, lppaca_size - new_size);
-	lppaca_size = new_size;
+	memblock_free(__pa(lp), size);
 }
-
-#else
-
-static inline void allocate_lppacas(int nr_cpus, unsigned long limit) { }
-static inline void free_lppacas(void) { }
-
 #endif /* CONFIG_PPC_BOOK3S */
 
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -167,7 +135,7 @@ EXPORT_SYMBOL(paca_ptrs);
 void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 {
 #ifdef CONFIG_PPC_PSERIES
-	new_paca->lppaca_ptr = new_lppaca(cpu);
+	new_paca->lppaca_ptr = NULL;
 #endif
 #ifdef CONFIG_PPC_BOOK3E
 	new_paca->kernel_pgd = swapper_pg_dir;
@@ -254,13 +222,15 @@ void __init allocate_pacas(void)
 	printk(KERN_DEBUG "Allocated %lu bytes for %u pacas\n",
 			size, nr_cpu_ids);
 
-	allocate_lppacas(nr_cpu_ids, limit);
-
 	allocate_slb_shadows(nr_cpu_ids, limit);
 
 	/* Can't use for_each_*_cpu, as they aren't functional yet */
-	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
 		initialise_paca(paca_ptrs[cpu], cpu);
+#ifdef CONFIG_PPC_PSERIES
+		paca_ptrs[cpu]->lppaca_ptr = new_lppaca(cpu, limit);
+#endif
+	}
 }
 
 void __init free_unused_pacas(void)
@@ -272,6 +242,9 @@ void __init free_unused_pacas(void)
 	for (cpu = 0; cpu < paca_nr_cpu_ids; cpu++) {
 		if (!cpu_possible(cpu)) {
 			unsigned long pa = __pa(paca_ptrs[cpu]);
+#ifdef CONFIG_PPC_PSERIES
+			free_lppaca(paca_ptrs[cpu]->lppaca_ptr);
+#endif
 			memblock_free(pa, sizeof(struct paca_struct));
 			paca_ptrs[cpu] = NULL;
 			size += sizeof(struct paca_struct);
@@ -288,8 +261,6 @@ void __init free_unused_pacas(void)
 	if (size)
 		printk(KERN_DEBUG "Freed %lu bytes for unused pacas\n", size);
 
-	free_lppacas();
-
 	paca_nr_cpu_ids = nr_cpu_ids;
 	paca_ptrs_size = new_ptrs_size;
 }
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d340bda12067..61928510ed1b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -495,7 +495,8 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 		 * use 640 bytes of the structure though, so we should accept
 		 * clients that set a size of 640.
 		 */
-		if (len < 640)
+		BUILD_BUG_ON(sizeof(struct lppaca) != 640);
+		if (len < sizeof(struct lppaca))
 			break;
 		vpap = &tvcpu->arch.vpa;
 		err = 0;
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 314d19ab9385..e9ec465068f1 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1110,7 +1110,7 @@ static void setup_cpu_associativity_change_counters(void)
 	for_each_possible_cpu(cpu) {
 		int i;
 		u8 *counts = vphn_cpu_change_counts[cpu];
-		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
+		volatile u8 *hypervisor_counts = lppaca_of(cpu).vphn_assoc_counts;
 
 		for (i = 0; i < distance_ref_points_depth; i++)
 			counts[i] = hypervisor_counts[i];
@@ -1136,7 +1136,7 @@ static int update_cpu_associativity_changes_mask(void)
 	for_each_possible_cpu(cpu) {
 		int i, changed = 0;
 		u8 *counts = vphn_cpu_change_counts[cpu];
-		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
+		volatile u8 *hypervisor_counts = lppaca_of(cpu).vphn_assoc_counts;
 
 		for (i = 0; i < distance_ref_points_depth; i++) {
 			if (hypervisor_counts[i] != counts[i]) {
diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
index eeb13429d685..3fe126796975 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -23,7 +23,12 @@
 
 void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
 {
-	/* Don't risk a hypervisor call if we're crashing */
+	/*
+	 * Don't risk a hypervisor call if we're crashing
+	 * XXX: Why? The hypervisor is not crashing. It might be better
+	 * to at least attempt unregister to avoid the hypervisor stepping
+	 * on our memory.
+	 */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR) && !crash_shutdown) {
 		int ret;
 		int cpu = smp_processor_id();
-- 
2.16.1

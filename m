Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDqWx0vhkzDqxB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 11:18:21 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id z1so6524734pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 18:18:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 09/11] powerpc/64s: Allocate LPPACAs node-local if possible
Date: Sat, 22 Jul 2017 11:17:39 +1000
Message-Id: <20170722011741.13942-10-npiggin@gmail.com>
In-Reply-To: <20170722011741.13942-1-npiggin@gmail.com>
References: <20170722011741.13942-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similary to the previous patch, allocate LPPACAs on a per-CPU basis,
attempting to get node-local memory.
---
 arch/powerpc/include/asm/lppaca.h      | 13 ++-----
 arch/powerpc/kernel/machine_kexec_64.c | 15 ++++++--
 arch/powerpc/kernel/paca.c             | 65 +++++++++++++++++++---------------
 arch/powerpc/mm/numa.c                 |  4 +--
 4 files changed, 52 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 6e4589eee2da..78f171f298b7 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -36,14 +36,7 @@
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
+ * The Hypervisor barfs if the lppaca crosses a page boundary.
  */
 struct lppaca {
 	/* cacheline 1 contains read-only data */
@@ -99,9 +92,7 @@ struct lppaca {
 	u8	reserved11[148];
 	volatile __be64 dtl_idx;		/* Dispatch Trace Log head index */
 	u8	reserved12[96];
-} __attribute__((__aligned__(0x400)));
-
-extern struct lppaca lppaca[];
+} ____cacheline_aligned;
 
 #define lppaca_of(cpu)	(*paca_ptrs[cpu]->lppaca_ptr)
 
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 700cd25fbd28..c439277e0cf8 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -286,6 +286,10 @@ static union thread_union kexec_stack __init_task_data =
  * static PACA; we switch to kexec_paca.
  */
 struct paca_struct kexec_paca;
+#ifdef CONFIG_PPC_PSERIES
+/* align lppaca to 1K to avoid crossing page boundary */
+struct lppaca kexec_lppaca __attribute__((aligned(0x400)));
+#endif
 
 /* Our assembly helper, in misc_64.S */
 extern void kexec_sequence(void *newstack, unsigned long start,
@@ -329,11 +333,16 @@ void default_machine_kexec(struct kimage *image)
 	memcpy(&kexec_paca, get_paca(), sizeof(struct paca_struct));
 	kexec_paca.data_offset = 0xedeaddeadeeeeeeeUL;
 	paca_ptrs[kexec_paca.paca_index] = &kexec_paca;
+
+#ifdef CONFIG_PPC_PSERIES
+	if (firmware_has_feature(FW_FEATURE_LPAR)) {
+		memcpy(&kexec_lppaca, get_lppaca(), sizeof(struct lppaca));
+		kexec_paca.lppaca_ptr = &kexec_lppaca;
+	}
+#endif
+
 	setup_paca(&kexec_paca);
 
-	/* XXX: If anyone does 'dynamic lppacas' this will also need to be
-	 * switched to a static version!
-	 */
 	/*
 	 * On Book3S, the copy must happen with the MMU off if we are either
 	 * using Radix page tables or we are not in an LPAR since we can
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index bf5f5820a3e4..d929d146b977 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -18,6 +18,8 @@
 #include <asm/pgtable.h>
 #include <asm/kexec.h>
 
+static int __initdata paca_nr_cpu_ids;
+
 #ifdef CONFIG_PPC_PSERIES
 
 /*
@@ -29,32 +31,42 @@
  * change since the hypervisor knows its layout, so a 1kB alignment
  * will suffice to ensure that it doesn't cross a page boundary.
  */
-struct lppaca lppaca[] = {
-	[0 ... (NR_LPPACAS-1)] = {
+static inline void init_lppaca(struct lppaca *lppaca)
+{
+	*lppaca = (struct lppaca) {
 		.desc = cpu_to_be32(0xd397d781),	/* "LpPa" */
 		.size = cpu_to_be16(sizeof(struct lppaca)),
 		.fpregs_in_use = 1,
 		.slb_count = cpu_to_be16(64),
 		.vmxregs_in_use = 0,
-		.page_ins = 0,
-	},
+		.page_ins = 0, };
 };
 
-static struct lppaca *extra_lppacas;
-static long __initdata lppaca_size;
+static struct lppaca ** __initdata lppaca_ptrs;
+
+static long __initdata lppaca_ptrs_size;
 
 static void __init allocate_lppacas(int nr_cpus, unsigned long limit)
 {
+	int cpu;
+
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		return;
 
-	if (nr_cpus <= NR_LPPACAS)
-		return;
+	lppaca_ptrs_size = sizeof(struct lppaca *) * nr_cpu_ids;
+	lppaca_ptrs = __va(memblock_alloc_base(lppaca_ptrs_size, 0, limit));
+
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
+		unsigned long pa;
 
-	lppaca_size = PAGE_ALIGN(sizeof(struct lppaca) *
-				 (nr_cpus - NR_LPPACAS));
-	extra_lppacas = __va(memblock_alloc_base(lppaca_size,
-						 PAGE_SIZE, limit));
+		pa = memblock_alloc_base_nid(sizeof(struct lppaca), 0x400,
+						limit, early_cpu_to_node(cpu),
+						MEMBLOCK_NONE);
+		if (!pa)
+			pa = memblock_alloc_base(sizeof(struct lppaca), 0x400,
+							limit);
+		lppaca_ptrs[cpu] = __va(pa);
+	}
 }
 
 static struct lppaca * __init new_lppaca(int cpu)
@@ -64,29 +76,25 @@ static struct lppaca * __init new_lppaca(int cpu)
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		return NULL;
 
-	if (cpu < NR_LPPACAS)
-		return &lppaca[cpu];
-
-	lp = extra_lppacas + (cpu - NR_LPPACAS);
-	*lp = lppaca[0];
+	lp = lppaca_ptrs[cpu];
+	init_lppaca(lp);
 
 	return lp;
 }
 
 static void __init free_lppacas(void)
 {
-	long new_size = 0, nr;
+	int cpu;
 
-	if (!lppaca_size)
-		return;
-	nr = num_possible_cpus() - NR_LPPACAS;
-	if (nr > 0)
-		new_size = PAGE_ALIGN(nr * sizeof(struct lppaca));
-	if (new_size >= lppaca_size)
-		return;
+	for (cpu = 0; cpu < paca_nr_cpu_ids; cpu++) {
+		if (!cpu_possible(cpu)) {
+			memblock_free(__pa(lppaca_ptrs[cpu]),
+						sizeof(struct lppaca));
+			lppaca_ptrs[cpu] = NULL;
+		}
+	}
 
-	memblock_free(__pa(extra_lppacas) + new_size, lppaca_size - new_size);
-	lppaca_size = new_size;
+	memblock_free(__pa(lppaca_ptrs), lppaca_ptrs_size);
 }
 
 #else
@@ -105,7 +113,7 @@ static inline void free_lppacas(void) { }
  * If you make the number of persistent SLB entries dynamic, please also
  * update PR KVM to flush and restore them accordingly.
  */
-static struct slb_shadow *slb_shadow;
+static struct slb_shadow * __initdata slb_shadow;
 
 static void __init allocate_slb_shadows(int nr_cpus, int limit)
 {
@@ -208,7 +216,6 @@ void setup_paca(struct paca_struct *new_paca)
 
 }
 
-static int __initdata paca_nr_cpu_ids;
 static int __initdata paca_ptrs_size;
 
 static __init unsigned long safe_paca_limit(void)
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b95c584ce19d..55e3fa5fcfb0 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1168,7 +1168,7 @@ static void setup_cpu_associativity_change_counters(void)
 	for_each_possible_cpu(cpu) {
 		int i;
 		u8 *counts = vphn_cpu_change_counts[cpu];
-		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
+		volatile u8 *hypervisor_counts = lppaca_of(cpu).vphn_assoc_counts;
 
 		for (i = 0; i < distance_ref_points_depth; i++)
 			counts[i] = hypervisor_counts[i];
@@ -1194,7 +1194,7 @@ static int update_cpu_associativity_changes_mask(void)
 	for_each_possible_cpu(cpu) {
 		int i, changed = 0;
 		u8 *counts = vphn_cpu_change_counts[cpu];
-		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
+		volatile u8 *hypervisor_counts = lppaca_of(cpu).vphn_assoc_counts;
 
 		for (i = 0; i < distance_ref_points_depth; i++) {
 			if (hypervisor_counts[i] != counts[i]) {
-- 
2.11.0

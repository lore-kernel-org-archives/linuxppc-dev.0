Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVLrd1LCbzDrCt
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 11:34:41 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 83so5969522pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 18:34:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 9/9] powerpc/64: Use a table of lppaca pointers and
 allocate lppacas individually
Date: Sun, 13 Aug 2017 11:33:46 +1000
Message-Id: <20170813013346.14002-9-npiggin@gmail.com>
In-Reply-To: <20170812113416.15978-1-npiggin@gmail.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similary to the previous patch, allocate LPPACAs individually.

We no longer allocate lppacas in an array, so this patch removes the 1kB
static alignment for the structure, and enforce the PAPR alignment
requirements at allocation time. We can not reduce the 1kB allocation size
however, due to existing KVM hypervisors.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/lppaca.h      | 24 +++++------
 arch/powerpc/kernel/machine_kexec_64.c |  8 +++-
 arch/powerpc/kernel/paca.c             | 76 ++++++++++++++++++----------------
 arch/powerpc/kvm/book3s_hv.c           |  9 +---
 arch/powerpc/mm/numa.c                 |  4 +-
 arch/powerpc/platforms/pseries/kexec.c |  7 +++-
 6 files changed, 68 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 6e4589eee2da..457a81f0fb58 100644
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
+ * 1kB, so we dynamically allocate 1kB and set size to 1kB, but keep the
+ * structure as the canonical 640 byte size.
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
index 700cd25fbd28..fb6acf822088 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -329,11 +329,15 @@ void default_machine_kexec(struct kimage *image)
 	memcpy(&kexec_paca, get_paca(), sizeof(struct paca_struct));
 	kexec_paca.data_offset = 0xedeaddeadeeeeeeeUL;
 	paca_ptrs[kexec_paca.paca_index] = &kexec_paca;
+
 	setup_paca(&kexec_paca);
 
-	/* XXX: If anyone does 'dynamic lppacas' this will also need to be
-	 * switched to a static version!
+	/*
+	 * The lppaca should be unregistered at this point. In the case
+	 * of a crash, none of the lppacas are unregistered so there is
+	 * not much we can do about it here.
 	 */
+
 	/*
 	 * On Book3S, the copy must happen with the MMU off if we are either
 	 * using Radix page tables or we are not in an LPAR since we can
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 780c65a847d4..b3fcd5df84ee 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -19,44 +19,53 @@
 #include <asm/kexec.h>
 
 #include "setup.h"
+static int __initdata paca_nr_cpu_ids;
 
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
+static struct lppaca ** __initdata lppaca_ptrs;
+
+static long __initdata lppaca_ptrs_size;
 
 static void __init allocate_lppacas(int nr_cpus, unsigned long limit)
 {
+	size_t size = 0x400;
+	int cpu;
+
+	BUILD_BUG_ON(size < sizeof(struct lppaca));
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
+		pa = memblock_alloc_base(size, 0x400, limit);
+		lppaca_ptrs[cpu] = __va(pa);
+	}
 }
 
 static struct lppaca * __init new_lppaca(int cpu)
@@ -66,32 +75,28 @@ static struct lppaca * __init new_lppaca(int cpu)
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
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		return;
 
-	if (!lppaca_size)
-		return;
-	nr = num_possible_cpus() - NR_LPPACAS;
-	if (nr > 0)
-		new_size = PAGE_ALIGN(nr * sizeof(struct lppaca));
-	if (new_size >= lppaca_size)
-		return;
+	for (cpu = 0; cpu < paca_nr_cpu_ids; cpu++) {
+		if (!cpu_possible(cpu)) {
+			unsigned long pa = __pa(lppaca_ptrs[cpu]);
+			memblock_free(pa, sizeof(struct lppaca));
+			lppaca_ptrs[cpu] = NULL;
+		}
+	}
 
-	memblock_free(__pa(extra_lppacas) + new_size, lppaca_size - new_size);
-	lppaca_size = new_size;
+	memblock_free(__pa(lppaca_ptrs), lppaca_ptrs_size);
 }
 
 #else
@@ -213,7 +218,6 @@ void setup_paca(struct paca_struct *new_paca)
 
 }
 
-static int __initdata paca_nr_cpu_ids;
 static int __initdata paca_ptrs_size;
 
 void __init allocate_pacas(void)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index f24406de4ebc..a3cd052476bf 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -485,13 +485,8 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 
 	switch (subfunc) {
 	case H_VPA_REG_VPA:		/* register VPA */
-		/*
-		 * The size of our lppaca is 1kB because of the way we align
-		 * it for the guest to avoid crossing a 4kB boundary. We only
-		 * use 640 bytes of the structure though, so we should accept
-		 * clients that set a size of 640.
-		 */
-		if (len < 640)
+		BUILD_BUG_ON(sizeof(struct lppaca) != 640);
+		if (len < sizeof(struct lppaca))
 			break;
 		vpap = &tvcpu->arch.vpa;
 		err = 0;
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
diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
index 6681ac97fb18..2ad3e3919b25 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -22,7 +22,12 @@
 
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
2.13.3

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7whP3jcjzDqmB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 11:53:41 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc/mm/radix: Workaround prefetch issue with KVM
Date: Fri, 14 Jul 2017 11:52:58 +1000
Message-Id: <20170714015258.7933-4-benh@kernel.crashing.org>
In-Reply-To: <20170714015258.7933-1-benh@kernel.crashing.org>
References: <20170714015258.7933-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There's a somewhat architectural issue with Radix MMU and KVM.

When coming out of a guest with AIL (ie, MMU enabled), we start
executing hypervisor code with the PID register still containing
whatever the guest has been using.

The problem is that the CPU can (and will) then start prefetching
or speculatively load from whatever host context has that same
PID (if any), thus bringing translations for that context into
the TLB, which Linux doesn't know about.

This can cause stale translations and subsequent crashes.

Fixing this in a way that is neither racy nor a huge performance
impact is difficult. We could just make the host invalidations
always use broadcast forms but that would hurt single threaded
programs for example.

We chose to fix it instead by partitioning the PID space between
guest and host. This is possible because today Linux only use 19
out of the 20 bits of PID space, so existing guests will work
if we make the host use the top half of the 20 bits space.

We additionally add a property to indicate to Linux the size of
the PID register which will be useful if we eventually have
processors with a larger PID space available.

There is still an issue with malicious guests purposefully setting
the PID register to a value in the host range. Hopefully future HW
can prevent that, but in the meantime, we handle it with a pair of
kludges:

 - On the way out of a guest, before we clear the current VCPU
in the PACA, we check the PID and if it's outside of the permitted
range we flush the TLB for that PID.

 - When context switching, if the mm is "new" on that CPU (the
corresponding bit was set for the first time in the mm cpumask), we
check if any sibling thread is in KVM (has a non-NULL VCPU pointer
in the PACA). If that is the case, we also flush the PID for that
CPU (core).

This second part is needed to handle the case where a process is
migrated (or starts a new pthread) on a sibling thread of the CPU
coming out of KVM, as there's a window where stale translations
can exist before we detect it and flush them out.

A future optimization could be added by keeping track of whether
the PID has ever been used and avoid doing that for completely
fresh PIDs. We could similarily mark PIDs that have been the subject of
a global invalidation as "fresh". But for now this will do.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
---
 arch/powerpc/include/asm/book3s/64/mmu.h           | 15 ++++----
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  3 ++
 arch/powerpc/include/asm/mmu_context.h             | 25 +++++++++----
 arch/powerpc/kernel/head_32.S                      |  6 +--
 arch/powerpc/kernel/swsusp.c                       |  2 +-
 arch/powerpc/kvm/book3s_32_sr.S                    |  2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            | 12 ++++++
 arch/powerpc/mm/mmu_context_book3s64.c             | 43 ++++++++++++++++++++--
 arch/powerpc/mm/mmu_context_nohash.c               |  4 +-
 arch/powerpc/mm/pgtable-radix.c                    | 31 +++++++++++++++-
 arch/powerpc/mm/pgtable_64.c                       |  3 ++
 arch/powerpc/mm/tlb-radix.c                        | 10 +++--
 drivers/cpufreq/pmac32-cpufreq.c                   |  2 +-
 drivers/macintosh/via-pmu.c                        |  4 +-
 14 files changed, 131 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 77529a3..5b4023c 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -59,13 +59,14 @@ extern struct patb_entry *partition_tb;
 #define PRTS_MASK	0x1f		/* process table size field */
 #define PRTB_MASK	0x0ffffffffffff000UL
 
-/*
- * Limit process table to PAGE_SIZE table. This
- * also limit the max pid we can support.
- * MAX_USER_CONTEXT * 16 bytes of space.
- */
-#define PRTB_SIZE_SHIFT	(CONTEXT_BITS + 4)
-#define PRTB_ENTRIES	(1ul << CONTEXT_BITS)
+/* Number of supported PID bits */
+extern unsigned int mmu_pid_bits;
+
+/* Base PID to allocate from */
+extern unsigned int mmu_base_pid;
+
+#define PRTB_SIZE_SHIFT	(mmu_pid_bits + 4)
+#define PRTB_ENTRIES	(1ul << mmu_pid_bits)
 
 /*
  * Power9 currently only support 64K partition table size.
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 9b433a6..2e0a6b4 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -21,10 +21,13 @@ extern void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long sta
 extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 extern void radix__local_flush_tlb_mm(struct mm_struct *mm);
+extern void radix__local_flush_all_mm(struct mm_struct *mm);
 extern void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 					      int psize);
 extern void radix__tlb_flush(struct mmu_gather *tlb);
+extern void radix_flush_pid(unsigned long pid);
+
 #ifdef CONFIG_SMP
 extern void radix__flush_tlb_mm(struct mm_struct *mm);
 extern void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index da7e943..26a587a 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -45,13 +45,15 @@ extern void set_context(unsigned long id, pgd_t *pgd);
 
 #ifdef CONFIG_PPC_BOOK3S_64
 extern void radix__switch_mmu_context(struct mm_struct *prev,
-				     struct mm_struct *next);
+				      struct mm_struct *next,
+				      bool new_on_cpu);
 static inline void switch_mmu_context(struct mm_struct *prev,
 				      struct mm_struct *next,
-				      struct task_struct *tsk)
+				      struct task_struct *tsk,
+				      bool new_on_cpu)
 {
 	if (radix_enabled())
-		return radix__switch_mmu_context(prev, next);
+		return radix__switch_mmu_context(prev, next, new_on_cpu);
 	return switch_slb(tsk, next);
 }
 
@@ -60,8 +62,13 @@ extern void hash__reserve_context_id(int id);
 extern void __destroy_context(int context_id);
 static inline void mmu_context_init(void) { }
 #else
-extern void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
-			       struct task_struct *tsk);
+extern void __switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
+				 struct task_struct *tsk);
+static inline void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
+				      struct task_struct *tsk, bool new_on_cpu)
+{
+	__switch_mmu_context(prev, next, tsk);
+}
 extern unsigned long __init_new_context(void);
 extern void __destroy_context(unsigned long context_id);
 extern void mmu_context_init(void);
@@ -79,9 +86,13 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev,
 				      struct mm_struct *next,
 				      struct task_struct *tsk)
 {
+	bool new_on_cpu = false;
+
 	/* Mark this context has been used on the new CPU */
-	if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next)))
+	if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next))) {
 		cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
+		new_on_cpu = true;
+	}
 
 	/* 32-bit keeps track of the current PGDIR in the thread struct */
 #ifdef CONFIG_PPC32
@@ -113,7 +124,7 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev,
 	 * The actual HW switching method differs between the various
 	 * sub architectures. Out of line for now
 	 */
-	switch_mmu_context(prev, next, tsk);
+	switch_mmu_context(prev, next, tsk, new_on_cpu);
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index e227342..a530124 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -1003,11 +1003,11 @@ start_here:
 	RFI
 
 /*
- * void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next);
+ * void __switch_mmu_context(struct mm_struct *prev, struct mm_struct *next);
  *
  * Set up the segment registers for a new context.
  */
-_ENTRY(switch_mmu_context)
+_ENTRY(__switch_mmu_context)
 	lwz	r3,MMCONTEXTID(r4)
 	cmpwi	cr0,r3,0
 	blt-	4f
@@ -1040,7 +1040,7 @@ _ENTRY(switch_mmu_context)
 4:	trap
 	EMIT_BUG_ENTRY 4b,__FILE__,__LINE__,0
 	blr
-EXPORT_SYMBOL(switch_mmu_context)
+EXPORT_SYMBOL(__switch_mmu_context)
 
 /*
  * An undocumented "feature" of 604e requires that the v bit
diff --git a/arch/powerpc/kernel/swsusp.c b/arch/powerpc/kernel/swsusp.c
index 0050b2d..9c32cfd 100644
--- a/arch/powerpc/kernel/swsusp.c
+++ b/arch/powerpc/kernel/swsusp.c
@@ -32,6 +32,6 @@ void save_processor_state(void)
 void restore_processor_state(void)
 {
 #ifdef CONFIG_PPC32
-	switch_mmu_context(current->active_mm, current->active_mm, NULL);
+	__switch_mmu_context(current->active_mm, current->active_mm, NULL);
 #endif
 }
diff --git a/arch/powerpc/kvm/book3s_32_sr.S b/arch/powerpc/kvm/book3s_32_sr.S
index 7e06a6f..a1705d4 100644
--- a/arch/powerpc/kvm/book3s_32_sr.S
+++ b/arch/powerpc/kvm/book3s_32_sr.S
@@ -138,6 +138,6 @@
 	lwz	r4, MM(r4)
 	tophys(r4, r4)
 	/* This only clobbers r0, r3, r4 and r5 */
-	bl	switch_mmu_context
+	bl	__switch_mmu_context
 
 .endm
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 6ea4b53..4fb3581b 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1522,6 +1522,18 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	std	r6, VCPU_BESCR(r9)
 	stw	r7, VCPU_GUEST_PID(r9)
 	std	r8, VCPU_WORT(r9)
+
+	/* Handle the case where the guest used an illegal PID */
+	LOAD_REG_ADDR(r4, mmu_base_pid)
+	lwz	r3, 0(r4)
+	cmpw	cr0,r7,r3
+	blt	1f
+
+	/* Illegal PID, flush the TLB */
+	bl	radix_flush_pid
+	ld	r9, HSTATE_KVM_VCPU(r13)
+1:
+
 BEGIN_FTR_SECTION
 	mfspr	r5, SPRN_TCSCR
 	mfspr	r6, SPRN_ACOP
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index abed1fe..183a67b 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -25,6 +25,10 @@
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+#include <asm/kvm_book3s_asm.h>
+#endif
+
 #include "icswx.h"
 
 static DEFINE_SPINLOCK(mmu_context_lock);
@@ -126,9 +130,10 @@ static int hash__init_new_context(struct mm_struct *mm)
 static int radix__init_new_context(struct mm_struct *mm)
 {
 	unsigned long rts_field;
-	int index;
+	int index, max_id;
 
-	index = alloc_context_id(1, PRTB_ENTRIES - 1);
+	max_id = (1 << mmu_pid_bits) - 1;
+	index = alloc_context_id(mmu_base_pid, max_id);
 	if (index < 0)
 		return index;
 
@@ -247,8 +252,40 @@ void destroy_context(struct mm_struct *mm)
 }
 
 #ifdef CONFIG_PPC_RADIX_MMU
-void radix__switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
+void radix__switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
+			       bool new_on_cpu)
 {
+	/*
+	 * If this context hasn't run on that CPU before and KVM is
+	 * around, there's a slim chance that the guest on another
+	 * CPU just brought in obsolete translation into the TLB of
+	 * this CPU due to a bad prefetch using the guest PID on
+	 * the way into the hypervisor.
+	 *
+	 * We work around this here. If KVM is possible, we check if
+	 * any sibling thread is in KVM. If it is, the window may exist
+	 * and thus we flush that PID from the core.
+	 *
+	 * A potential future improvement would be to mark which PIDs
+	 * have never been used on the system and avoid it if the PID
+	 * is new and the process has no other cpumask bit set.
+	 */
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	if (cpu_has_feature(CPU_FTR_HVMODE) && new_on_cpu) {
+		int cpu = smp_processor_id();
+		int sib = cpu_first_thread_sibling(cpu);
+		bool flush = false;
+
+		for (; sib <= cpu_last_thread_sibling(cpu) && !flush; sib++) {
+			if (sib == cpu)
+				continue;
+			if (paca[sib].kvm_hstate.kvm_vcpu)
+				flush = true;
+		}
+		if (flush)
+			radix__local_flush_all_mm(next);
+	}
+#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
 	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
 		isync();
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 4554d65..47d84d0 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -226,8 +226,8 @@ static void context_check_map(void)
 static void context_check_map(void) { }
 #endif
 
-void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
-			struct task_struct *tsk)
+void __switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
+			  struct task_struct *tsk)
 {
 	unsigned int i, id, cpu = smp_processor_id();
 	unsigned long *map;
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 83d70f7..3888aea 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -168,11 +168,34 @@ static void __init radix_init_pgtable(void)
 	for_each_memblock(memory, reg)
 		WARN_ON(create_physical_mapping(reg->base,
 						reg->base + reg->size));
+
+	/* Find out how many PID bits are supported */
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		if (!mmu_pid_bits)
+			mmu_pid_bits = 20;
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+		/*
+		 * When KVM is possible, we only use the top half of the
+		 * PID space to avoid collisions between host and guest PIDs
+		 * which can cause problems due to prefetch when exiting the
+		 * guest with AIL=3
+		 */
+		mmu_base_pid = 1 << (mmu_pid_bits - 1);
+#else
+		mmu_base_pid = 1;
+#endif
+	} else {
+		/* The guest uses the bottom half of the PID space */
+		if (!mmu_pid_bits)
+			mmu_pid_bits = 19;
+		mmu_base_pid = 1;
+	}
+
 	/*
 	 * Allocate Partition table and process table for the
 	 * host.
 	 */
-	BUILD_BUG_ON_MSG((PRTB_SIZE_SHIFT > 36), "Process table size too large.");
+	BUG_ON(PRTB_SIZE_SHIFT > 36);
 	process_tb = early_alloc_pgtable(1UL << PRTB_SIZE_SHIFT);
 	/*
 	 * Fill in the process table.
@@ -245,6 +268,12 @@ static int __init radix_dt_scan_page_sizes(unsigned long node,
 	if (type == NULL || strcmp(type, "cpu") != 0)
 		return 0;
 
+	/* Find MMU PID size */
+	prop = of_get_flat_dt_prop(node, "ibm,mmu-pid-bits", &size);
+	if (prop && size == 4)
+		mmu_pid_bits = be32_to_cpup(prop);
+
+	/* Grab page size encodings */
 	prop = of_get_flat_dt_prop(node, "ibm,processor-radix-AP-encodings", &size);
 	if (!prop)
 		return 0;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index b165bab..5cc73f1 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -68,6 +68,9 @@
  */
 struct prtb_entry *process_tb;
 struct patb_entry *partition_tb;
+unsigned int mmu_pid_bits;
+unsigned int mmu_base_pid;
+
 /*
  * page table size
  */
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 73d3fbf..54d5c75 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -66,6 +66,12 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
 }
 
+/* Used by KVM */
+void radix_flush_pid(unsigned long pid)
+{
+	_tlbiel_pid(pid, RIC_FLUSH_ALL);
+}
+
 static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
@@ -138,8 +144,7 @@ void radix__local_flush_tlb_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(radix__local_flush_tlb_mm);
 
-#ifndef CONFIG_SMP
-static void radix__local_flush_all_mm(struct mm_struct *mm)
+void radix__local_flush_all_mm(struct mm_struct *mm)
 {
 	unsigned long pid;
 
@@ -149,7 +154,6 @@ static void radix__local_flush_all_mm(struct mm_struct *mm)
 		_tlbiel_pid(pid, RIC_FLUSH_ALL);
 	preempt_enable();
 }
-#endif /* CONFIG_SMP */
 
 void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 				       int psize)
diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index ff44016..51026f2 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -300,7 +300,7 @@ static int pmu_set_cpu_speed(int low_speed)
  		_set_L3CR(save_l3cr);
 
 	/* Restore userland MMU context */
-	switch_mmu_context(NULL, current->active_mm, NULL);
+	__switch_mmu_context(NULL, current->active_mm, NULL);
 
 #ifdef DEBUG_FREQ
 	printk(KERN_DEBUG "HID1, after: %x\n", mfspr(SPRN_HID1));
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index cce99f7..c06f08d 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1851,7 +1851,7 @@ static int powerbook_sleep_grackle(void)
  		_set_L2CR(save_l2cr);
 	
 	/* Restore userland MMU context */
-	switch_mmu_context(NULL, current->active_mm, NULL);
+	__switch_mmu_context(NULL, current->active_mm, NULL);
 
 	/* Power things up */
 	pmu_unlock();
@@ -1940,7 +1940,7 @@ powerbook_sleep_Core99(void)
  		_set_L3CR(save_l3cr);
 	
 	/* Restore userland MMU context */
-	switch_mmu_context(NULL, current->active_mm, NULL);
+	__switch_mmu_context(NULL, current->active_mm, NULL);
 
 	/* Tell PMU we are ready */
 	pmu_unlock();
-- 
2.9.4

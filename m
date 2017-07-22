Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDqWt3G6PzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 11:18:18 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id d193so6506787pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 18:18:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 08/11] powerpc/64: Allocate PACAs node-local if possible
Date: Sat, 22 Jul 2017 11:17:38 +1000
Message-Id: <20170722011741.13942-9-npiggin@gmail.com>
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

Change the paca array into an array of pointers to pacas. Allocate
pacas individually per CPU. Try to allocate node-local if possible.

Book3E not yet compiled.

Hash mode won't be able to get per-node allocations, but in theory
on node > 0 CPUs we could bolt an SLB at the bottom of their node
memory to provide SLB-safe node-local memory. For now just get it to
work with radix.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/kvm_ppc.h           |  8 ++--
 arch/powerpc/include/asm/lppaca.h            |  2 +-
 arch/powerpc/include/asm/paca.h              |  4 +-
 arch/powerpc/include/asm/smp.h               |  4 +-
 arch/powerpc/kernel/crash.c                  |  2 +-
 arch/powerpc/kernel/head_64.S                | 12 +++--
 arch/powerpc/kernel/machine_kexec_64.c       | 22 ++++-----
 arch/powerpc/kernel/paca.c                   | 68 ++++++++++++++++++++--------
 arch/powerpc/kernel/setup_64.c               | 18 ++++----
 arch/powerpc/kernel/smp.c                    | 10 ++--
 arch/powerpc/kvm/book3s_hv.c                 | 21 +++++----
 arch/powerpc/kvm/book3s_hv_builtin.c         |  2 +-
 arch/powerpc/platforms/85xx/smp.c            |  8 ++--
 arch/powerpc/platforms/cell/smp.c            |  4 +-
 arch/powerpc/platforms/powernv/idle.c        | 13 +++---
 arch/powerpc/platforms/powernv/setup.c       |  4 +-
 arch/powerpc/platforms/powernv/smp.c         |  2 +-
 arch/powerpc/platforms/powernv/subcore.c     |  2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  2 +-
 arch/powerpc/platforms/pseries/lpar.c        |  4 +-
 arch/powerpc/platforms/pseries/setup.c       |  2 +-
 arch/powerpc/platforms/pseries/smp.c         |  4 +-
 arch/powerpc/sysdev/xics/icp-native.c        |  2 +-
 arch/powerpc/xmon/xmon.c                     |  2 +-
 24 files changed, 128 insertions(+), 94 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index ba5fadd6f3c9..49da5d47c693 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -428,15 +428,15 @@ struct openpic;
 extern void kvm_cma_reserve(void) __init;
 static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
 {
-	paca[cpu].kvm_hstate.xics_phys = (void __iomem *)addr;
+	paca_ptrs[cpu]->kvm_hstate.xics_phys = (void __iomem *)addr;
 }
 
 static inline void kvmppc_set_xive_tima(int cpu,
 					unsigned long phys_addr,
 					void __iomem *virt_addr)
 {
-	paca[cpu].kvm_hstate.xive_tima_phys = (void __iomem *)phys_addr;
-	paca[cpu].kvm_hstate.xive_tima_virt = virt_addr;
+	paca_ptrs[cpu]->kvm_hstate.xive_tima_phys = (void __iomem *)phys_addr;
+	paca_ptrs[cpu]->kvm_hstate.xive_tima_virt = virt_addr;
 }
 
 static inline u32 kvmppc_get_xics_latch(void)
@@ -450,7 +450,7 @@ static inline u32 kvmppc_get_xics_latch(void)
 
 static inline void kvmppc_set_host_ipi(int cpu, u8 host_ipi)
 {
-	paca[cpu].kvm_hstate.host_ipi = host_ipi;
+	paca_ptrs[cpu]->kvm_hstate.host_ipi = host_ipi;
 }
 
 static inline void kvmppc_fast_vcpu_kick(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index d0a2a2f99564..6e4589eee2da 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -103,7 +103,7 @@ struct lppaca {
 
 extern struct lppaca lppaca[];
 
-#define lppaca_of(cpu)	(*paca[cpu].lppaca_ptr)
+#define lppaca_of(cpu)	(*paca_ptrs[cpu]->lppaca_ptr)
 
 /*
  * We are using a non architected field to determine if a partition is
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index de47c5a4f132..f332f92996ab 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -228,10 +228,10 @@ struct paca_struct {
 	struct sibling_subcore_state *sibling_subcore_state;
 #endif
 #endif
-};
+} ____cacheline_aligned;
 
 extern void copy_mm_to_paca(struct mm_struct *mm);
-extern struct paca_struct *paca;
+extern struct paca_struct **paca_ptrs;
 extern void initialise_paca(struct paca_struct *new_paca, int cpu);
 extern void setup_paca(struct paca_struct *new_paca);
 extern void allocate_pacas(void);
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 8ea98504f900..1100574bcccd 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -164,12 +164,12 @@ static inline const struct cpumask *cpu_sibling_mask(int cpu)
 #ifdef CONFIG_PPC64
 static inline int get_hard_smp_processor_id(int cpu)
 {
-	return paca[cpu].hw_cpu_id;
+	return paca_ptrs[cpu]->hw_cpu_id;
 }
 
 static inline void set_hard_smp_processor_id(int cpu, int phys)
 {
-	paca[cpu].hw_cpu_id = phys;
+	paca_ptrs[cpu]->hw_cpu_id = phys;
 }
 #else
 /* 32-bit */
diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index cbabb5adccd9..99eb8fd87d6f 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -230,7 +230,7 @@ static void __maybe_unused crash_kexec_wait_realmode(int cpu)
 		if (i == cpu)
 			continue;
 
-		while (paca[i].kexec_state < KEXEC_STATE_REAL_MODE) {
+		while (paca_ptrs[i]->kexec_state < KEXEC_STATE_REAL_MODE) {
 			barrier();
 			if (!cpu_possible(i) || !cpu_online(i) || (msecs <= 0))
 				break;
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 0ddc602b33a4..f71f468ebe7f 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -386,19 +386,21 @@ generic_secondary_common_init:
 	 * physical cpu id in r24, we need to search the pacas to find
 	 * which logical id maps to our physical one.
 	 */
-	LOAD_REG_ADDR(r13, paca)	/* Load paca pointer		 */
-	ld	r13,0(r13)		/* Get base vaddr of paca array	 */
+	LOAD_REG_ADDR(r8, paca_ptrs)	/* Load paca_ptrs pointe	 */
+	ld	r8,0(r8)		/* Get base vaddr of array	 */
 #ifndef CONFIG_SMP
-	addi	r13,r13,PACA_SIZE	/* know r13 if used accidentally */
+	li	r13,r13,0		/* kill r13 if used accidentally */
 	b	kexec_wait		/* wait for next kernel if !SMP	 */
 #else
 	LOAD_REG_ADDR(r7, nr_cpu_ids)	/* Load nr_cpu_ids address       */
 	lwz	r7,0(r7)		/* also the max paca allocated 	 */
 	li	r5,0			/* logical cpu id                */
-1:	lhz	r6,PACAHWCPUID(r13)	/* Load HW procid from paca      */
+1:
+	sldi	r9,r5,3			/* get paca_ptrs[] index from cpu id */
+	ldx	r13,r8,r9		/* r13 = paca_ptrs[cpu id]       */
+	lhz	r6,PACAHWCPUID(r13)	/* Load HW procid from paca      */
 	cmpw	r6,r24			/* Compare to our id             */
 	beq	2f
-	addi	r13,r13,PACA_SIZE	/* Loop to next PACA on miss     */
 	addi	r5,r5,1
 	cmpw	r5,r7			/* Check if more pacas exist     */
 	blt	1b
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 5c12e21d0d1a..700cd25fbd28 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -168,24 +168,25 @@ static void kexec_prepare_cpus_wait(int wait_state)
 	 * are correctly onlined.  If somehow we start a CPU on boot with RTAS
 	 * start-cpu, but somehow that CPU doesn't write callin_cpu_map[] in
 	 * time, the boot CPU will timeout.  If it does eventually execute
-	 * stuff, the secondary will start up (paca[].cpu_start was written) and
-	 * get into a peculiar state.  If the platform supports
-	 * smp_ops->take_timebase(), the secondary CPU will probably be spinning
-	 * in there.  If not (i.e. pseries), the secondary will continue on and
-	 * try to online itself/idle/etc. If it survives that, we need to find
-	 * these possible-but-not-online-but-should-be CPUs and chaperone them
-	 * into kexec_smp_wait().
+	 * stuff, the secondary will start up (paca_ptrs[]->cpu_start was
+	 * written) and get into a peculiar state.
+	 * If the platform supports smp_ops->take_timebase(), the secondary CPU
+	 * will probably be spinning in there.  If not (i.e. pseries), the
+	 * secondary will continue on and try to online itself/idle/etc. If it
+	 * survives that, we need to find these
+	 * possible-but-not-online-but-should-be CPUs and chaperone them into
+	 * kexec_smp_wait().
 	 */
 	for_each_online_cpu(i) {
 		if (i == my_cpu)
 			continue;
 
-		while (paca[i].kexec_state < wait_state) {
+		while (paca_ptrs[i]->kexec_state < wait_state) {
 			barrier();
 			if (i != notified) {
 				printk(KERN_INFO "kexec: waiting for cpu %d "
 				       "(physical %d) to enter %i state\n",
-				       i, paca[i].hw_cpu_id, wait_state);
+				       i, paca_ptrs[i]->hw_cpu_id, wait_state);
 				notified = i;
 			}
 		}
@@ -327,8 +328,7 @@ void default_machine_kexec(struct kimage *image)
 	 */
 	memcpy(&kexec_paca, get_paca(), sizeof(struct paca_struct));
 	kexec_paca.data_offset = 0xedeaddeadeeeeeeeUL;
-	paca = (struct paca_struct *)RELOC_HIDE(&kexec_paca, 0) -
-		kexec_paca.paca_index;
+	paca_ptrs[kexec_paca.paca_index] = &kexec_paca;
 	setup_paca(&kexec_paca);
 
 	/* XXX: If anyone does 'dynamic lppacas' this will also need to be
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 801ce2e9c9ac..bf5f5820a3e4 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -156,8 +156,8 @@ static void __init allocate_slb_shadows(int nr_cpus, int limit) { }
  * processors.  The processor VPD array needs one entry per physical
  * processor (not thread).
  */
-struct paca_struct *paca;
-EXPORT_SYMBOL(paca);
+struct paca_struct **paca_ptrs __read_mostly;
+EXPORT_SYMBOL(paca_ptrs);
 
 void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 {
@@ -208,7 +208,8 @@ void setup_paca(struct paca_struct *new_paca)
 
 }
 
-static int __initdata paca_size;
+static int __initdata paca_nr_cpu_ids;
+static int __initdata paca_ptrs_size;
 
 static __init unsigned long safe_paca_limit(void)
 {
@@ -241,15 +242,32 @@ static __init unsigned long safe_paca_limit(void)
 void __init allocate_pacas(void)
 {
 	unsigned long limit = safe_paca_limit();
+	unsigned long size = 0;
 	int cpu;
 
-	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpu_ids);
+	paca_nr_cpu_ids = nr_cpu_ids;
 
-	paca = __va(memblock_alloc_base(paca_size, PAGE_SIZE, limit));
-	memset(paca, 0, paca_size);
+	paca_ptrs_size = sizeof(struct paca_struct *) * nr_cpu_ids;
+	paca_ptrs = __va(memblock_alloc_base(paca_ptrs_size, 0, limit));
+	memset(paca_ptrs, 0, paca_ptrs_size);
 
-	printk(KERN_DEBUG "Allocated %u bytes for %d pacas at %p\n",
-		paca_size, nr_cpu_ids, paca);
+	size += paca_ptrs_size;
+
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
+		unsigned long pa;
+
+		pa = memblock_alloc_base_nid(sizeof(struct paca_struct), 0,
+						limit, early_cpu_to_node(cpu),
+						MEMBLOCK_NONE);
+		if (!pa)
+			pa = memblock_alloc_base(sizeof(struct paca_struct), 0,
+							limit);
+		paca_ptrs[cpu] = __va(pa);
+
+		size += sizeof(struct paca_struct);
+	}
+
+	printk(KERN_DEBUG "Allocated %lu bytes for %d pacas\n", size, nr_cpu_ids);
 
 	allocate_lppacas(nr_cpu_ids, limit);
 
@@ -257,26 +275,38 @@ void __init allocate_pacas(void)
 
 	/* Can't use for_each_*_cpu, as they aren't functional yet */
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
-		initialise_paca(&paca[cpu], cpu);
+		initialise_paca(paca_ptrs[cpu], cpu);
 }
 
 void __init free_unused_pacas(void)
 {
-	int new_size;
-
-	new_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpu_ids);
-
-	if (new_size >= paca_size)
-		return;
+	unsigned long size = 0;
+	int new_ptrs_size;
+	int cpu;
 
-	memblock_free(__pa(paca) + new_size, paca_size - new_size);
+	for (cpu = 0; cpu < paca_nr_cpu_ids; cpu++) {
+		if (!cpu_possible(cpu)) {
+			memblock_free(__pa(paca_ptrs[cpu]),
+						sizeof(struct paca_struct));
+			paca_ptrs[cpu] = NULL;
+			size += sizeof(struct paca_struct);
+		}
+	}
 
-	printk(KERN_DEBUG "Freed %u bytes for unused pacas\n",
-		paca_size - new_size);
+	new_ptrs_size = sizeof(struct paca_struct *) * nr_cpu_ids;
+	if (new_ptrs_size < paca_ptrs_size) {
+		memblock_free(__pa(paca_ptrs) + new_ptrs_size,
+					paca_ptrs_size - new_ptrs_size);
+		size += paca_ptrs_size - new_ptrs_size;
+	}
 
-	paca_size = new_size;
+	if (size)
+		printk(KERN_DEBUG "Freed %lu bytes for unused pacas\n", size);
 
 	free_lppacas();
+
+	paca_nr_cpu_ids = nr_cpu_ids;
+	paca_ptrs_size = new_ptrs_size;
 }
 
 void copy_mm_to_paca(struct mm_struct *mm)
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4ecc4315b308..d3c506a93b0b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -108,7 +108,7 @@ void __init setup_tlb_core_data(void)
 		if (cpu_first_thread_sibling(boot_cpuid) == first)
 			first = boot_cpuid;
 
-		paca[cpu].tcd_ptr = &paca[first].tcd;
+		paca_ptrs[cpu]->tcd_ptr = paca_ptrs[first].tcd;
 
 		/*
 		 * If we have threads, we need either tlbsrx.
@@ -300,7 +300,7 @@ void __init early_setup(unsigned long dt_ptr)
 	early_init_devtree(__va(dt_ptr));
 
 	/* Now we know the logical id of our boot cpu, setup the paca. */
-	setup_paca(&paca[boot_cpuid]);
+	setup_paca(paca_ptrs[boot_cpuid]);
 	fixup_boot_paca();
 
 	/*
@@ -602,15 +602,15 @@ void __init exc_lvl_early_init(void)
 	for_each_possible_cpu(i) {
 		sp = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
 		critirq_ctx[i] = (struct thread_info *)__va(sp);
-		paca[i].crit_kstack = __va(sp + THREAD_SIZE);
+		paca_ptrs[i]->crit_kstack = __va(sp + THREAD_SIZE);
 
 		sp = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
 		dbgirq_ctx[i] = (struct thread_info *)__va(sp);
-		paca[i].dbg_kstack = __va(sp + THREAD_SIZE);
+		paca_ptrs[i]->dbg_kstack = __va(sp + THREAD_SIZE);
 
 		sp = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
 		mcheckirq_ctx[i] = (struct thread_info *)__va(sp);
-		paca[i].mc_kstack = __va(sp + THREAD_SIZE);
+		paca_ptrs[i]->mc_kstack = __va(sp + THREAD_SIZE);
 	}
 
 	if (cpu_has_feature(CPU_FTR_DEBUG_LVL_EXC))
@@ -666,20 +666,20 @@ void __init emergency_stack_init(void)
 		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
 		memset(ti, 0, THREAD_SIZE);
 		emerg_stack_init_thread_info(ti, i);
-		paca[i].emergency_sp = (void *)ti + THREAD_SIZE;
+		paca_ptrs[i]->emergency_sp = (void *)ti + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		/* emergency stack for NMI exception handling. */
 		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
 		memset(ti, 0, THREAD_SIZE);
 		emerg_stack_init_thread_info(ti, i);
-		paca[i].nmi_emergency_sp = (void *)ti + THREAD_SIZE;
+		paca_ptrs[i]->nmi_emergency_sp = (void *)ti + THREAD_SIZE;
 
 		/* emergency stack for machine check exception handling. */
 		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
 		memset(ti, 0, THREAD_SIZE);
 		emerg_stack_init_thread_info(ti, i);
-		paca[i].mc_emergency_sp = (void *)ti + THREAD_SIZE;
+		paca_ptrs[i]->mc_emergency_sp = (void *)ti + THREAD_SIZE;
 #endif
 	}
 }
@@ -735,7 +735,7 @@ void __init setup_per_cpu_areas(void)
 	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
 	for_each_possible_cpu(cpu) {
                 __per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
-		paca[cpu].data_offset = __per_cpu_offset[cpu];
+		paca_ptrs[cpu]->data_offset = __per_cpu_offset[cpu];
 	}
 }
 #endif
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 997c88d54acf..cfb856575b08 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -121,8 +121,8 @@ int smp_generic_kick_cpu(int nr)
 	 * cpu_start field to become non-zero After we set cpu_start,
 	 * the processor will continue on to secondary_start
 	 */
-	if (!paca[nr].cpu_start) {
-		paca[nr].cpu_start = 1;
+	if (!paca_ptrs[nr]->cpu_start) {
+		paca_ptrs[nr]->cpu_start = 1;
 		smp_mb();
 		return 0;
 	}
@@ -613,7 +613,7 @@ void smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != boot_cpuid);
 #ifdef CONFIG_PPC64
-	paca[boot_cpuid].__current = current;
+	paca_ptrs[boot_cpuid]->__current = current;
 #endif
 	set_numa_node(numa_cpu_lookup_table[boot_cpuid]);
 	current_set[boot_cpuid] = task_thread_info(current);
@@ -704,8 +704,8 @@ static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
 	struct thread_info *ti = task_thread_info(idle);
 
 #ifdef CONFIG_PPC64
-	paca[cpu].__current = idle;
-	paca[cpu].kstack = (unsigned long)ti + THREAD_SIZE - STACK_FRAME_OVERHEAD;
+	paca_ptrs[cpu]->__current = idle;
+	paca_ptrs[cpu]->kstack = (unsigned long)ti + THREAD_SIZE - STACK_FRAME_OVERHEAD;
 #endif
 	ti->cpu = cpu;
 	secondary_ti = current_set[cpu] = ti;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 0b436df746fc..f45fd7f36256 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -163,7 +163,7 @@ static bool kvmppc_ipi_thread(int cpu)
 
 #if defined(CONFIG_PPC_ICP_NATIVE) && defined(CONFIG_SMP)
 	if (cpu >= 0 && cpu < nr_cpu_ids) {
-		if (paca[cpu].kvm_hstate.xics_phys) {
+		if (paca_ptrs[cpu]->kvm_hstate.xics_phys) {
 			xics_wake_cpu(cpu);
 			return true;
 		}
@@ -2111,7 +2111,7 @@ static int kvmppc_grab_hwthread(int cpu)
 	struct paca_struct *tpaca;
 	long timeout = 10000;
 
-	tpaca = &paca[cpu];
+	tpaca = paca_ptrs[cpu];
 
 	/* Ensure the thread won't go into the kernel if it wakes */
 	tpaca->kvm_hstate.kvm_vcpu = NULL;
@@ -2144,7 +2144,7 @@ static void kvmppc_release_hwthread(int cpu)
 {
 	struct paca_struct *tpaca;
 
-	tpaca = &paca[cpu];
+	tpaca = paca_ptrs[cpu];
 	tpaca->kvm_hstate.hwthread_req = 0;
 	tpaca->kvm_hstate.kvm_vcpu = NULL;
 	tpaca->kvm_hstate.kvm_vcore = NULL;
@@ -2210,7 +2210,7 @@ static void kvmppc_start_thread(struct kvm_vcpu *vcpu, struct kvmppc_vcore *vc)
 		vcpu->arch.thread_cpu = cpu;
 		cpumask_set_cpu(cpu, &kvm->arch.cpu_in_guest);
 	}
-	tpaca = &paca[cpu];
+	tpaca = paca_ptrs[cpu];
 	tpaca->kvm_hstate.kvm_vcpu = vcpu;
 	tpaca->kvm_hstate.ptid = cpu - vc->pcpu;
 	/* Order stores to hstate.kvm_vcpu etc. before store to kvm_vcore */
@@ -2236,7 +2236,7 @@ static void kvmppc_wait_for_nap(void)
 		 * for any threads that still have a non-NULL vcore ptr.
 		 */
 		for (i = 1; i < n_threads; ++i)
-			if (paca[cpu + i].kvm_hstate.kvm_vcore)
+			if (paca_ptrs[cpu + i]->kvm_hstate.kvm_vcore)
 				break;
 		if (i == n_threads) {
 			HMT_medium();
@@ -2246,7 +2246,7 @@ static void kvmppc_wait_for_nap(void)
 	}
 	HMT_medium();
 	for (i = 1; i < n_threads; ++i)
-		if (paca[cpu + i].kvm_hstate.kvm_vcore)
+		if (paca_ptrs[cpu + i]->kvm_hstate.kvm_vcore)
 			pr_err("KVM: CPU %d seems to be stuck\n", cpu + i);
 }
 
@@ -2737,7 +2737,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 		smp_wmb();
 	}
 	for (thr = 0; thr < controlled_threads; ++thr)
-		paca[pcpu + thr].kvm_hstate.kvm_split_mode = sip;
+		paca_ptrs[pcpu + thr]->kvm_hstate.kvm_split_mode = sip;
 
 	/* Initiate micro-threading (split-core) if required */
 	if (cmd_bit) {
@@ -4247,7 +4247,7 @@ static int kvm_init_subcore_bitmap(void)
 		int node = cpu_to_node(first_cpu);
 
 		/* Ignore if it is already allocated. */
-		if (paca[first_cpu].sibling_subcore_state)
+		if (paca_ptrs[first_cpu]->sibling_subcore_state)
 			continue;
 
 		sibling_subcore_state =
@@ -4262,7 +4262,8 @@ static int kvm_init_subcore_bitmap(void)
 		for (j = 0; j < threads_per_core; j++) {
 			int cpu = first_cpu + j;
 
-			paca[cpu].sibling_subcore_state = sibling_subcore_state;
+			paca_ptrs[cpu]->sibling_subcore_state =
+						sibling_subcore_state;
 		}
 	}
 	return 0;
@@ -4289,7 +4290,7 @@ static int kvmppc_book3s_init_hv(void)
 
 	/*
 	 * We need a way of accessing the XICS interrupt controller,
-	 * either directly, via paca[cpu].kvm_hstate.xics_phys, or
+	 * either directly, via paca_ptrs[cpu]->kvm_hstate.xics_phys, or
 	 * indirectly, via OPAL.
 	 */
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 90644db9d38e..b57e42ab37bb 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -251,7 +251,7 @@ void kvmhv_rm_send_ipi(int cpu)
 	    return;
 
 	/* Else poke the target with an IPI */
-	xics_phys = paca[cpu].kvm_hstate.xics_phys;
+	xics_phys = paca_ptrs[cpu]->kvm_hstate.xics_phys;
 	if (xics_phys)
 		__raw_rm_writeb(IPI_PRIORITY, xics_phys + XICS_MFRR);
 	else
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index f51fd35f4618..7e966f4cf19a 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -147,7 +147,7 @@ static void qoriq_cpu_kill(unsigned int cpu)
 	for (i = 0; i < 500; i++) {
 		if (is_cpu_dead(cpu)) {
 #ifdef CONFIG_PPC64
-			paca[cpu].cpu_start = 0;
+			paca_ptrs[cpu]->cpu_start = 0;
 #endif
 			return;
 		}
@@ -328,7 +328,7 @@ static int smp_85xx_kick_cpu(int nr)
 		return ret;
 
 done:
-	paca[nr].cpu_start = 1;
+	paca_ptrs[nr]->cpu_start = 1;
 	generic_set_cpu_up(nr);
 
 	return ret;
@@ -409,14 +409,14 @@ void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
 	}
 
 	if (disable_threadbit) {
-		while (paca[disable_cpu].kexec_state < KEXEC_STATE_REAL_MODE) {
+		while (paca_ptrs[disable_cpu]->kexec_state < KEXEC_STATE_REAL_MODE) {
 			barrier();
 			now = mftb();
 			if (!notified && now - start > 1000000) {
 				pr_info("%s/%d: waiting for cpu %d to enter KEXEC_STATE_REAL_MODE (%d)\n",
 					__func__, smp_processor_id(),
 					disable_cpu,
-					paca[disable_cpu].kexec_state);
+					paca_ptrs[disable_cpu]->kexec_state);
 				notified = true;
 			}
 		}
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index f84d52a2db40..1aeac5761e0b 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -83,7 +83,7 @@ static inline int smp_startup_cpu(unsigned int lcpu)
 	pcpu = get_hard_smp_processor_id(lcpu);
 
 	/* Fixup atomic count: it exited inside IRQ handler. */
-	task_thread_info(paca[lcpu].__current)->preempt_count	= 0;
+	task_thread_info(paca_ptrs[lcpu]->__current)->preempt_count	= 0;
 
 	/*
 	 * If the RTAS start-cpu token does not exist then presume the
@@ -126,7 +126,7 @@ static int smp_cell_kick_cpu(int nr)
 	 * cpu_start field to become non-zero After we set cpu_start,
 	 * the processor will continue on to secondary_start
 	 */
-	paca[nr].cpu_start = 1;
+	paca_ptrs[nr]->cpu_start = 1;
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 2abee070373f..d974a5c877c4 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -79,7 +79,7 @@ static int pnv_save_sprs_for_deep_states(void)
 
 	for_each_possible_cpu(cpu) {
 		uint64_t pir = get_hard_smp_processor_id(cpu);
-		uint64_t hsprg0_val = (uint64_t)&paca[cpu];
+		uint64_t hsprg0_val = (uint64_t)paca_ptrs[cpu];
 
 		rc = opal_slw_set_reg(pir, SPRN_HSPRG0, hsprg0_val);
 		if (rc != 0)
@@ -172,12 +172,12 @@ static void pnv_alloc_idle_core_states(void)
 		for (j = 0; j < threads_per_core; j++) {
 			int cpu = first_cpu + j;
 
-			paca[cpu].core_idle_state_ptr = core_idle_state;
-			paca[cpu].thread_idle_state = PNV_THREAD_RUNNING;
-			paca[cpu].thread_mask = 1 << j;
+			paca_ptrs[cpu]->core_idle_state_ptr = core_idle_state;
+			paca_ptrs[cpu]->thread_idle_state = PNV_THREAD_RUNNING;
+			paca_ptrs[cpu]->thread_mask = 1 << j;
 			if (!cpu_has_feature(CPU_FTR_POWER9_DD1))
 				continue;
-			paca[cpu].thread_sibling_pacas =
+			paca_ptrs[cpu]->thread_sibling_pacas =
 				kmalloc_node(paca_ptr_array_size,
 					     GFP_KERNEL, node);
 		}
@@ -676,7 +676,8 @@ static int __init pnv_init_idle_states(void)
 			for (i = 0; i < threads_per_core; i++) {
 				int j = base_cpu + i;
 
-				paca[j].thread_sibling_pacas[idx] = &paca[cpu];
+				paca_ptrs[j]->thread_sibling_pacas[idx] =
+					paca_ptrs[cpu];
 			}
 		}
 	}
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 897aa1400eb8..be563e913b43 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -204,7 +204,7 @@ static void pnv_kexec_wait_secondaries_down(void)
 			if (i != notified) {
 				printk(KERN_INFO "kexec: waiting for cpu %d "
 				       "(physical %d) to enter OPAL\n",
-				       i, paca[i].hw_cpu_id);
+				       i, paca_ptrs[i]->hw_cpu_id);
 				notified = i;
 			}
 
@@ -216,7 +216,7 @@ static void pnv_kexec_wait_secondaries_down(void)
 			if (timeout-- == 0) {
 				printk(KERN_ERR "kexec: timed out waiting for "
 				       "cpu %d (physical %d) to enter OPAL\n",
-				       i, paca[i].hw_cpu_id);
+				       i, paca_ptrs[i]->hw_cpu_id);
 				break;
 			}
 		}
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 40dae96f7e20..e4e48fdf4c1f 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -70,7 +70,7 @@ static int pnv_smp_kick_cpu(int nr)
 	 * If we already started or OPAL is not supported, we just
 	 * kick the CPU via the PACA
 	 */
-	if (paca[nr].cpu_start || !firmware_has_feature(FW_FEATURE_OPAL))
+	if (paca_ptrs[nr]->cpu_start || !firmware_has_feature(FW_FEATURE_OPAL))
 		goto kick;
 
 	/*
diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index 596ae2e98040..45563004feda 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -280,7 +280,7 @@ void update_subcore_sibling_mask(void)
 		int offset = (tid / threads_per_subcore) * threads_per_subcore;
 		int mask = sibling_mask_first_cpu << offset;
 
-		paca[cpu].subcore_sibling_mask = mask;
+		paca_ptrs[cpu]->subcore_sibling_mask = mask;
 
 	}
 }
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 6afd1efd3633..2245b8e47969 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -226,7 +226,7 @@ static void pseries_cpu_die(unsigned int cpu)
 	 * done here.  Change isolate state to Isolate and
 	 * change allocation-state to Unusable.
 	 */
-	paca[cpu].cpu_start = 0;
+	paca_ptrs[cpu]->cpu_start = 0;
 }
 
 /*
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 495ba4e7336d..eb0064d50ac6 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -99,7 +99,7 @@ void vpa_init(int cpu)
 	 * reports that.  All SPLPAR support SLB shadow buffer.
 	 */
 	if (!radix_enabled() && firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		addr = __pa(paca[cpu].slb_shadow_ptr);
+		addr = __pa(paca_ptrs[cpu]->slb_shadow_ptr);
 		ret = register_slb_shadow(hwcpu, addr);
 		if (ret)
 			pr_err("WARNING: SLB shadow buffer registration for "
@@ -111,7 +111,7 @@ void vpa_init(int cpu)
 	/*
 	 * Register dispatch trace log, if one has been allocated.
 	 */
-	pp = &paca[cpu];
+	pp = paca_ptrs[cpu];
 	dtl = pp->dispatch_log;
 	if (dtl) {
 		pp->dtl_ridx = 0;
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index b5d86426e97b..e0fc426e2ce2 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -242,7 +242,7 @@ static int alloc_dispatch_logs(void)
 		return 0;
 
 	for_each_possible_cpu(cpu) {
-		pp = &paca[cpu];
+		pp = paca_ptrs[cpu];
 		dtl = kmem_cache_alloc(dtl_cache, GFP_KERNEL);
 		if (!dtl) {
 			pr_warn("Failed to allocate dispatch trace log for cpu %d\n",
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 24785f63fb40..942274c109ee 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -109,7 +109,7 @@ static inline int smp_startup_cpu(unsigned int lcpu)
 	}
 
 	/* Fixup atomic count: it exited inside IRQ handler. */
-	task_thread_info(paca[lcpu].__current)->preempt_count	= 0;
+	task_thread_info(paca_ptrs[lcpu]->__current)->preempt_count	= 0;
 #ifdef CONFIG_HOTPLUG_CPU
 	if (get_cpu_current_state(lcpu) == CPU_STATE_INACTIVE)
 		goto out;
@@ -162,7 +162,7 @@ static int smp_pSeries_kick_cpu(int nr)
 	 * cpu_start field to become non-zero After we set cpu_start,
 	 * the processor will continue on to secondary_start
 	 */
-	paca[nr].cpu_start = 1;
+	paca_ptrs[nr]->cpu_start = 1;
 #ifdef CONFIG_HOTPLUG_CPU
 	set_preferred_offline_state(nr, CPU_STATE_ONLINE);
 
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 2bfb9968d562..68663723ba22 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -164,7 +164,7 @@ void icp_native_cause_ipi_rm(int cpu)
 	 * Just like the cause_ipi functions, it is required to
 	 * include a full barrier before causing the IPI.
 	 */
-	xics_phys = paca[cpu].kvm_hstate.xics_phys;
+	xics_phys = paca_ptrs[cpu]->kvm_hstate.xics_phys;
 	mb();
 	__raw_rm_writeb(IPI_PRIORITY, xics_phys + XICS_MFRR);
 }
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 08e367e3e8c3..e36935dc5017 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2247,7 +2247,7 @@ static void dump_one_paca(int cpu)
 	catch_memory_errors = 1;
 	sync();
 
-	p = &paca[cpu];
+	p = paca_ptrs[cpu];
 
 	printf("paca for cpu 0x%x @ %p:\n", cpu, p);
 
-- 
2.11.0

Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Jpgr21NpzF3FT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 01:55:20 +1000 (AEST)
Message-Id: <e5570c4405663c0dd99527003fada04a95e5422c.1537802981.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537802981.git.christophe.leroy@c-s.fr>
References: <cover.1537802981.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 5/9] powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 24 Sep 2018 15:52:29 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch activates CONFIG_THREAD_INFO_IN_TASK which
moves the thread_info into task_struct.

Moving thread_info into task_struct has the following advantages:
- It protects thread_info from corruption in the case of stack
overflows.
- Its address is harder to determine if stack addresses are
leaked, making a number of attacks more difficult.

This has the following consequences:
- thread_info is now located at the top of task_struct.
- The 'cpu' field is now in task_struct, and only exists when
CONFIG_SMP is active.
- thread_info doesn't have anymore the 'task' field.

This patch:
- Removes all recopy of thread_info struct when the stack changes.
- Changes the CURRENT_THREAD_INFO() macro to point to current.
- Selects CONFIG_THREAD_INFO_IN_TASK

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/smp.h         |  3 ++-
 arch/powerpc/include/asm/thread_info.h | 17 ++----------
 arch/powerpc/kernel/asm-offsets.c      |  5 ++--
 arch/powerpc/kernel/entry_32.S         |  9 +++----
 arch/powerpc/kernel/exceptions-64e.S   | 11 --------
 arch/powerpc/kernel/head_32.S          |  6 ++---
 arch/powerpc/kernel/head_44x.S         |  4 +--
 arch/powerpc/kernel/head_64.S          |  1 +
 arch/powerpc/kernel/head_booke.h       |  8 +-----
 arch/powerpc/kernel/head_fsl_booke.S   |  7 +++--
 arch/powerpc/kernel/irq.c              | 49 ++--------------------------------
 arch/powerpc/kernel/kgdb.c             | 28 -------------------
 arch/powerpc/kernel/machine_kexec_64.c |  6 ++---
 arch/powerpc/kernel/setup-common.c     |  2 +-
 arch/powerpc/kernel/setup_64.c         | 21 ---------------
 arch/powerpc/kernel/smp.c              |  2 +-
 17 files changed, 28 insertions(+), 152 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a80669209155..c6c0b91ebd33 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -237,6 +237,7 @@ config PPC
 	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
+	select THREAD_INFO_IN_TASK
 	select VIRT_TO_BUS			if !PPC64
 	#
 	# Please keep this list sorted alphabetically.
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 95b66a0c639b..7a197a669311 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -28,6 +28,7 @@
 #include <asm/paca.h>
 #endif
 #include <asm/percpu.h>
+#include <linux/sched.h>
 
 extern int boot_cpuid;
 extern int spinning_secondaries;
@@ -83,7 +84,7 @@ int is_cpu_dead(unsigned int cpu);
 /* 32-bit */
 extern int smp_hw_index[];
 
-#define raw_smp_processor_id()	(current_thread_info()->cpu)
+#define raw_smp_processor_id()	(current->cpu)
 #define hard_smp_processor_id() 	(smp_hw_index[smp_processor_id()])
 
 static inline int get_hard_smp_processor_id(int cpu)
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 406eb952b808..62eb9ff31292 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -18,9 +18,9 @@
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
 #ifdef CONFIG_PPC64
-#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(clrrdi dest, sp, THREAD_SHIFT)
+#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(ld dest, PACACURRENT(r13))
 #else
-#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(rlwinm dest, sp, 0, 0, 31-THREAD_SHIFT)
+#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(mr dest, r2)
 #endif
 
 #ifndef __ASSEMBLY__
@@ -34,8 +34,6 @@
  * low level task data.
  */
 struct thread_info {
-	struct task_struct *task;		/* main task structure */
-	int		cpu;			/* cpu we're on */
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
 	unsigned long	local_flags;		/* private flags for thread */
@@ -58,8 +56,6 @@ struct thread_info {
  */
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	.task =		&tsk,			\
-	.cpu =		0,			\
 	.preempt_count = INIT_PREEMPT_COUNT,	\
 	.flags =	0,			\
 }
@@ -67,15 +63,6 @@ struct thread_info {
 #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
 
 /* how to get the thread information struct from C */
-static inline struct thread_info *current_thread_info(void)
-{
-	unsigned long val;
-
-	asm (CURRENT_THREAD_INFO(%0,1) : "=r" (val));
-
-	return (struct thread_info *)val;
-}
-
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index d1f161e48945..b042d85325f5 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -89,6 +89,9 @@ int main(void)
 	OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
 #endif /* CONFIG_PPC64 */
 	OFFSET(TASK_STACK, task_struct, stack);
+#ifdef CONFIG_SMP
+	OFFSET(TI_CPU, task_struct, cpu);
+#endif
 
 #ifdef CONFIG_LIVEPATCH
 	OFFSET(TI_livepatch_sp, thread_info, livepatch_sp);
@@ -156,8 +159,6 @@ int main(void)
 	OFFSET(TI_FLAGS, thread_info, flags);
 	OFFSET(TI_LOCAL_FLAGS, thread_info, local_flags);
 	OFFSET(TI_PREEMPT, thread_info, preempt_count);
-	OFFSET(TI_TASK, thread_info, task);
-	OFFSET(TI_CPU, thread_info, cpu);
 
 #ifdef CONFIG_PPC64
 	OFFSET(DCACHEL1BLOCKSIZE, ppc64_caches, l1d.block_size);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 12c0721f65ea..a14f9b5f2762 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1166,10 +1166,6 @@ ret_from_debug_exc:
 	mfspr	r9,SPRN_SPRG_THREAD
 	lwz	r10,SAVED_KSP_LIMIT(r1)
 	stw	r10,KSP_LIMIT(r9)
-	lwz	r9,TASK_STACK-THREAD(r9)
-	CURRENT_THREAD_INFO(r10, r1)
-	lwz	r10,TI_PREEMPT(r10)
-	stw	r10,TI_PREEMPT(r9)
 	RESTORE_xSRR(SRR0,SRR1);
 	RESTORE_xSRR(CSRR0,CSRR1);
 	RESTORE_MMU_REGS;
@@ -1292,10 +1288,13 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_601)
 	lwz	r3,_TRAP(r1)
 	andi.	r0,r3,1
-	beq	4f
+	beq	5f
 	SAVE_NVGPRS(r1)
 	rlwinm	r3,r3,0,0,30
 	stw	r3,_TRAP(r1)
+5:	mfspr	r2,SPRN_SPRG_THREAD
+	addi	r2,r2,-THREAD
+	tovirt(r2,r2)			/* set back r2 to current */
 4:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	nonrecoverable_exception
 	/* shouldn't return */
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 6d6e144a28ce..231d066b4a3d 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -77,17 +77,6 @@ special_reg_save:
 	andi.	r3,r3,MSR_PR
 	bnelr
 
-	/* Copy info into temporary exception thread info */
-	ld	r11,PACAKSAVE(r13)
-	CURRENT_THREAD_INFO(r11, r11)
-	CURRENT_THREAD_INFO(r12, r1)
-	ld	r10,TI_FLAGS(r11)
-	std	r10,TI_FLAGS(r12)
-	ld	r10,TI_PREEMPT(r11)
-	std	r10,TI_PREEMPT(r12)
-	ld	r10,TI_TASK(r11)
-	std	r10,TI_TASK(r12)
-
 	/*
 	 * Advance to the next TLB exception frame for handler
 	 * types that don't do it automatically.
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index dce6f2ff07e5..44dfd73b2a62 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -844,9 +844,9 @@ __secondary_start:
 	/* get current's stack and current */
 	lis	r1,secondary_ti@ha
 	tophys(r1,r1)
-	lwz	r1,secondary_ti@l(r1)
-	tophys(r2,r1)
-	lwz	r2,TI_TASK(r2)
+	lwz	r2,secondary_ti@l(r1)
+	tophys(r1,r2)
+	lwz	r1,TASK_STACK(r1)
 
 	/* stack */
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 15d39b2499de..2c7e90f36358 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -1022,8 +1022,8 @@ _GLOBAL(start_secondary_47x)
 
 	/* Get current's stack and current */
 	lis	r1,secondary_ti@ha
-	lwz	r1,secondary_ti@l(r1)
-	lwz	r2,TI_TASK(r1)
+	lwz	r2,secondary_ti@l(r1)
+	lwz	r1,TASK_STACK(r2)
 
 	/* Current stack pointer */
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4898e9491a1c..c6a9bf7b34bf 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -805,6 +805,7 @@ __secondary_start:
 	LOAD_REG_ADDR(r3, current_set)
 	sldi	r28,r24,3		/* get current_set[cpu#]	 */
 	ldx	r14,r3,r28
+	ld	r14,TASK_STACK(r14)
 	addi	r14,r14,THREAD_SIZE-STACK_FRAME_OVERHEAD
 	std	r14,PACAKSAVE(r13)
 
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 20fe0c93a0bd..9f7f10896928 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -143,13 +143,7 @@
 	stw	r10,GPR11(r11);						     \
 	b	2f;							     \
 	/* COMING FROM PRIV MODE */					     \
-1:	lwz	r9,TI_FLAGS-EXC_LVL_FRAME_OVERHEAD(r11);		     \
-	lwz	r10,TI_PREEMPT-EXC_LVL_FRAME_OVERHEAD(r11);		     \
-	stw	r9,TI_FLAGS-EXC_LVL_FRAME_OVERHEAD(r8);			     \
-	stw	r10,TI_PREEMPT-EXC_LVL_FRAME_OVERHEAD(r8);		     \
-	lwz	r9,TI_TASK-EXC_LVL_FRAME_OVERHEAD(r11);			     \
-	stw	r9,TI_TASK-EXC_LVL_FRAME_OVERHEAD(r8);			     \
-	mr	r11,r8;							     \
+1:	mr	r11,r8;							     \
 2:	mfspr	r8,SPRN_SPRG_RSCRATCH_##exc_level;			     \
 	stw	r12,GPR12(r11);		/* save various registers	   */\
 	mflr	r10;							     \
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 239ad8a4754e..b8a2b789677e 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -704,8 +704,7 @@ finish_tlb_load:
 
 	/* Get the next_tlbcam_idx percpu var */
 #ifdef CONFIG_SMP
-	lwz	r12, TASK_STACK-THREAD(r12)
-	lwz	r15, TI_CPU(r12)
+	lwz	r15, TI_CPU-THREAD(r12)
 	lis     r14, __per_cpu_offset@h
 	ori     r14, r14, __per_cpu_offset@l
 	rlwinm  r15, r15, 2, 0, 29
@@ -1078,8 +1077,8 @@ __secondary_start:
 
 	/* get current's stack and current */
 	lis	r1,secondary_ti@ha
-	lwz	r1,secondary_ti@l(r1)
-	lwz	r2,TI_TASK(r1)
+	lwz	r2,secondary_ti@l(r1)
+	lwz	r1,TASK_STACK(r2)
 
 	/* stack */
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 916ddc4aac44..699f0f816687 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -663,7 +663,7 @@ void do_IRQ(struct pt_regs *regs)
 	struct thread_info *curtp, *irqtp, *sirqtp;
 
 	/* Switch to the irq stack to handle this */
-	curtp = current_thread_info();
+	curtp = (void*)(current_stack_pointer() & ~(THREAD_SIZE - 1));
 	irqtp = hardirq_ctx[raw_smp_processor_id()];
 	sirqtp = softirq_ctx[raw_smp_processor_id()];
 
@@ -673,24 +673,9 @@ void do_IRQ(struct pt_regs *regs)
 		set_irq_regs(old_regs);
 		return;
 	}
-
-	/* Prepare the thread_info in the irq stack */
-	irqtp->task = curtp->task;
-	irqtp->flags = 0;
-
-	/* Copy the preempt_count so that the [soft]irq checks work. */
-	irqtp->preempt_count = curtp->preempt_count;
-
 	/* Switch stack and call */
 	call_do_irq(regs, irqtp);
 
-	/* Restore stack limit */
-	irqtp->task = NULL;
-
-	/* Copy back updates to the thread_info */
-	if (irqtp->flags)
-		set_bits(irqtp->flags, &curtp->flags);
-
 	set_irq_regs(old_regs);
 }
 
@@ -711,7 +696,6 @@ struct thread_info *mcheckirq_ctx[NR_CPUS] __read_mostly;
 
 void exc_lvl_ctx_init(void)
 {
-	struct thread_info *tp;
 	int i, cpu_nr;
 
 	for_each_possible_cpu(i) {
@@ -726,20 +710,9 @@ void exc_lvl_ctx_init(void)
 #endif
 
 		memset((void *)critirq_ctx[cpu_nr], 0, THREAD_SIZE);
-		tp = critirq_ctx[cpu_nr];
-		tp->cpu = cpu_nr;
-		tp->preempt_count = 0;
-
 #ifdef CONFIG_BOOKE
 		memset((void *)dbgirq_ctx[cpu_nr], 0, THREAD_SIZE);
-		tp = dbgirq_ctx[cpu_nr];
-		tp->cpu = cpu_nr;
-		tp->preempt_count = 0;
-
 		memset((void *)mcheckirq_ctx[cpu_nr], 0, THREAD_SIZE);
-		tp = mcheckirq_ctx[cpu_nr];
-		tp->cpu = cpu_nr;
-		tp->preempt_count = HARDIRQ_OFFSET;
 #endif
 	}
 }
@@ -750,38 +723,20 @@ struct thread_info *hardirq_ctx[NR_CPUS] __read_mostly;
 
 void irq_ctx_init(void)
 {
-	struct thread_info *tp;
 	int i;
 
 	for_each_possible_cpu(i) {
 		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
-		tp = softirq_ctx[i];
-		tp->cpu = i;
-		klp_init_thread_info(tp);
-
 		memset((void *)hardirq_ctx[i], 0, THREAD_SIZE);
-		tp = hardirq_ctx[i];
-		tp->cpu = i;
-		klp_init_thread_info(tp);
 	}
 }
 
 void do_softirq_own_stack(void)
 {
-	struct thread_info *curtp, *irqtp;
+	struct thread_info *irqtp;
 
-	curtp = current_thread_info();
 	irqtp = softirq_ctx[smp_processor_id()];
-	irqtp->task = curtp->task;
-	irqtp->flags = 0;
 	call_do_softirq(irqtp);
-	irqtp->task = NULL;
-
-	/* Set any flag that may have been set on the
-	 * alternate stack
-	 */
-	if (irqtp->flags)
-		set_bits(irqtp->flags, &curtp->flags);
 }
 
 irq_hw_number_t virq_to_hw(unsigned int virq)
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 59c578f865aa..5056e54b5239 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -151,41 +151,13 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
 	return 1;
 }
 
-static DEFINE_PER_CPU(struct thread_info, kgdb_thread_info);
 static int kgdb_singlestep(struct pt_regs *regs)
 {
-	struct thread_info *thread_info, *exception_thread_info;
-	struct thread_info *backup_current_thread_info =
-		this_cpu_ptr(&kgdb_thread_info);
-
 	if (user_mode(regs))
 		return 0;
 
-	/*
-	 * On Book E and perhaps other processors, singlestep is handled on
-	 * the critical exception stack.  This causes current_thread_info()
-	 * to fail, since it it locates the thread_info by masking off
-	 * the low bits of the current stack pointer.  We work around
-	 * this issue by copying the thread_info from the kernel stack
-	 * before calling kgdb_handle_exception, and copying it back
-	 * afterwards.  On most processors the copy is avoided since
-	 * exception_thread_info == thread_info.
-	 */
-	thread_info = (struct thread_info *)(regs->gpr[1] & ~(THREAD_SIZE-1));
-	exception_thread_info = current_thread_info();
-
-	if (thread_info != exception_thread_info) {
-		/* Save the original current_thread_info. */
-		memcpy(backup_current_thread_info, exception_thread_info, sizeof *thread_info);
-		memcpy(exception_thread_info, thread_info, sizeof *thread_info);
-	}
-
 	kgdb_handle_exception(0, SIGTRAP, 0, regs);
 
-	if (thread_info != exception_thread_info)
-		/* Restore current_thread_info lastly. */
-		memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
-
 	return 1;
 }
 
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index a0f6f45005bd..75692c327ba0 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -317,10 +317,8 @@ void default_machine_kexec(struct kimage *image)
 	 * We setup preempt_count to avoid using VMX in memcpy.
 	 * XXX: the task struct will likely be invalid once we do the copy!
 	 */
-	kexec_stack.thread_info.task = current_thread_info()->task;
-	kexec_stack.thread_info.flags = 0;
-	kexec_stack.thread_info.preempt_count = HARDIRQ_OFFSET;
-	kexec_stack.thread_info.cpu = current_thread_info()->cpu;
+	current_thread_info()->flags = 0;
+	current_thread_info()->preempt_count = HARDIRQ_OFFSET;
 
 	/* We need a static PACA, too; copy this CPU's PACA over and switch to
 	 * it. Also poison per_cpu_offset and NULL lppaca to catch anyone using
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 93fa0c99681e..d84351ad1379 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -939,7 +939,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Reserve large chunks of memory for use by CMA for KVM. */
 	kvm_cma_reserve();
 
-	klp_init_thread_info(&init_thread_info);
+	klp_init_thread_info(&init_task.thread_info);
 
 	init_mm.start_code = (unsigned long)_stext;
 	init_mm.end_code = (unsigned long) _etext;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index faf00222b324..2d682f3e31c6 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -691,24 +691,6 @@ void __init exc_lvl_early_init(void)
 #endif
 
 /*
- * Emergency stacks are used for a range of things, from asynchronous
- * NMIs (system reset, machine check) to synchronous, process context.
- * We set preempt_count to zero, even though that isn't necessarily correct. To
- * get the right value we'd need to copy it from the previous thread_info, but
- * doing that might fault causing more problems.
- * TODO: what to do with accounting?
- */
-static void emerg_stack_init_thread_info(struct thread_info *ti, int cpu)
-{
-	ti->task = NULL;
-	ti->cpu = cpu;
-	ti->preempt_count = 0;
-	ti->local_flags = 0;
-	ti->flags = 0;
-	klp_init_thread_info(ti);
-}
-
-/*
  * Stack space used when we detect a bad kernel stack pointer, and
  * early in SMP boots before relocation is enabled. Exclusive emergency
  * stack for machine checks.
@@ -739,20 +721,17 @@ void __init emergency_stack_init(void)
 
 		ti = alloc_stack(limit, i);
 		memset(ti, 0, THREAD_SIZE);
-		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->emergency_sp = (void *)ti + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		/* emergency stack for NMI exception handling. */
 		ti = alloc_stack(limit, i);
 		memset(ti, 0, THREAD_SIZE);
-		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->nmi_emergency_sp = (void *)ti + THREAD_SIZE;
 
 		/* emergency stack for machine check exception handling. */
 		ti = alloc_stack(limit, i);
 		memset(ti, 0, THREAD_SIZE);
-		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->mc_emergency_sp = (void *)ti + THREAD_SIZE;
 #endif
 	}
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 19dd0ea55714..f22fcbeb9898 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -816,7 +816,7 @@ static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
 	paca_ptrs[cpu]->kstack = (unsigned long)task_stack_page(idle) +
 				  THREAD_SIZE - STACK_FRAME_OVERHEAD;
 #endif
-	ti->cpu = cpu;
+	idle->cpu = cpu;
 	secondary_ti = current_set[cpu] = ti;
 }
 
-- 
2.13.3

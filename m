Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Jpgw45VwzF3FW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 01:55:24 +1000 (AEST)
Message-Id: <a63c973e56504c7b78116a201f03715fe0c0dcd1.1537802981.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537802981.git.christophe.leroy@c-s.fr>
References: <cover.1537802981.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 4/9] powerpc: Prepare for moving thread_info into
 task_struct
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 24 Sep 2018 15:52:27 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch cleans the powerpc kernel before activating
CONFIG_THREAD_INFO_IN_TASK:
- The purpose of the pointer given to call_do_softirq() and
call_do_irq() is to point the new stack ==> change it to void*
- current_pt_regs() is in the stack, not in thread_info.
- Don't use CURRENT_THREAD_INFO() to locate the stack.
- Fixed a few comments.
- TI_CPU is only used when CONFIG_SMP is set.
- Replace current_thread_info()->task by current
- Remove unnecessary casts to thread_info, as they'll become
invalid once thread_info is not in stack anymore.
- Ensure task_struct 'cpu' fields is not used directly out of SMP code

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/irq.h       |  4 ++--
 arch/powerpc/include/asm/livepatch.h |  2 +-
 arch/powerpc/include/asm/processor.h |  4 ++--
 arch/powerpc/include/asm/ptrace.h    |  2 +-
 arch/powerpc/include/asm/reg.h       |  2 +-
 arch/powerpc/kernel/entry_64.S       |  2 +-
 arch/powerpc/kernel/head_32.S        |  2 +-
 arch/powerpc/kernel/head_44x.S       |  2 +-
 arch/powerpc/kernel/head_fsl_booke.S |  4 +++-
 arch/powerpc/kernel/misc_32.S        |  8 ++++++--
 arch/powerpc/kernel/process.c        |  6 +++---
 arch/powerpc/kernel/setup_32.c       | 15 +++++----------
 arch/powerpc/kernel/smp.c            |  4 +++-
 arch/powerpc/xmon/xmon.c             |  2 +-
 14 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index ee39ce56b2a2..8108d1fe33ca 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -63,8 +63,8 @@ extern struct thread_info *hardirq_ctx[NR_CPUS];
 extern struct thread_info *softirq_ctx[NR_CPUS];
 
 extern void irq_ctx_init(void);
-extern void call_do_softirq(struct thread_info *tp);
-extern void call_do_irq(struct pt_regs *regs, struct thread_info *tp);
+extern void call_do_softirq(void *tp);
+extern void call_do_irq(struct pt_regs *regs, void *tp);
 extern void do_IRQ(struct pt_regs *regs);
 extern void __init init_IRQ(void);
 extern void __do_irq(struct pt_regs *regs);
diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index 47a03b9b528b..818451bf629c 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -49,7 +49,7 @@ static inline void klp_init_thread_info(struct thread_info *ti)
 	ti->livepatch_sp = (unsigned long *)(ti + 1) + 1;
 }
 #else
-static void klp_init_thread_info(struct thread_info *ti) { }
+static inline void klp_init_thread_info(struct thread_info *ti) { }
 #endif /* CONFIG_LIVEPATCH */
 
 #endif /* _ASM_POWERPC_LIVEPATCH_H */
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 353879db3e98..31873614392f 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -40,7 +40,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
-#include <asm/thread_info.h>
+#include <linux/thread_info.h>
 #include <asm/ptrace.h>
 #include <asm/hw_breakpoint.h>
 
@@ -333,7 +333,7 @@ struct thread_struct {
 
 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
 #define INIT_SP_LIMIT \
-	(_ALIGN_UP(sizeof(init_thread_info), 16) + (unsigned long) &init_stack)
+	(_ALIGN_UP(sizeof(struct thread_info), 16) + (unsigned long) &init_stack)
 
 #ifdef CONFIG_SPE
 #define SPEFSCR_INIT \
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 447cbd1bee99..3a7e5561630b 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -120,7 +120,7 @@ extern int ptrace_put_reg(struct task_struct *task, int regno,
 			  unsigned long data);
 
 #define current_pt_regs() \
-	((struct pt_regs *)((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
+	((struct pt_regs *)((unsigned long)task_stack_page(current) + THREAD_SIZE) - 1)
 /*
  * We use the least-significant bit of the trap field to indicate
  * whether we have saved the full set of registers, or only a
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index e5b314ed054e..f3a9cf19a986 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1053,7 +1053,7 @@
  *	- SPRG9 debug exception scratch
  *
  * All 32-bit:
- *	- SPRG3 current thread_info pointer
+ *	- SPRG3 current thread_struct physical addr pointer
  *        (virtual on BookE, physical on others)
  *
  * 32-bit classic:
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 77a888bfcb53..697406572592 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -680,7 +680,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 2:
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
-	CURRENT_THREAD_INFO(r7, r8)  /* base of new stack */
+	clrrdi	r7, r8, THREAD_SHIFT	/* base of new stack */
 	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
 	   because we don't need to leave the 288-byte ABI gap at the
 	   top of the kernel stack. */
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index dbb096c32332..dce6f2ff07e5 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -841,7 +841,7 @@ __secondary_start:
 	bl	init_idle_6xx
 #endif /* CONFIG_6xx */
 
-	/* get current_thread_info and current */
+	/* get current's stack and current */
 	lis	r1,secondary_ti@ha
 	tophys(r1,r1)
 	lwz	r1,secondary_ti@l(r1)
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 37e4a7cf0065..15d39b2499de 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -1020,7 +1020,7 @@ _GLOBAL(start_secondary_47x)
 
 	/* Now we can get our task struct and real stack pointer */
 
-	/* Get current_thread_info and current */
+	/* Get current's stack and current */
 	lis	r1,secondary_ti@ha
 	lwz	r1,secondary_ti@l(r1)
 	lwz	r2,TI_TASK(r1)
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 35d35067acf7..239ad8a4754e 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -243,8 +243,10 @@ set_ivor:
 	li	r0,0
 	stwu	r0,THREAD_SIZE-STACK_FRAME_OVERHEAD(r1)
 
+#ifdef CONFIG_SMP
 	CURRENT_THREAD_INFO(r22, r1)
 	stw	r24, TI_CPU(r22)
+#endif
 
 	bl	early_init
 
@@ -1074,7 +1076,7 @@ __secondary_start:
 	mr	r4,r24		/* Why? */
 	bl	call_setup_cpu
 
-	/* get current_thread_info and current */
+	/* get current's stack and current */
 	lis	r1,secondary_ti@ha
 	lwz	r1,secondary_ti@l(r1)
 	lwz	r2,TI_TASK(r1)
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 695b24a2d954..24a7f18ea10c 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -60,7 +60,7 @@ _GLOBAL(call_do_softirq)
 	blr
 
 /*
- * void call_do_irq(struct pt_regs *regs, struct thread_info *irqtp);
+ * void call_do_irq(struct pt_regs *regs, void *irqtp);
  */
 _GLOBAL(call_do_irq)
 	mflr	r0
@@ -183,10 +183,14 @@ _GLOBAL(low_choose_750fx_pll)
 	or	r4,r4,r5
 	mtspr	SPRN_HID1,r4
 
+#ifdef CONFIG_SMP
 	/* Store new HID1 image */
 	CURRENT_THREAD_INFO(r6, r1)
 	lwz	r6,TI_CPU(r6)
 	slwi	r6,r6,2
+#else
+	li	r6, 0
+#endif
 	addis	r6,r6,nap_save_hid1@ha
 	stw	r4,nap_save_hid1@l(r6)
 
@@ -599,7 +603,7 @@ EXPORT_SYMBOL(__bswapdi2)
 #ifdef CONFIG_SMP
 _GLOBAL(start_secondary_resume)
 	/* Reset stack */
-	CURRENT_THREAD_INFO(r1, r1)
+	rlwinm	r1, r1, 0, 0, 31 - THREAD_SHIFT
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
 	li	r3,0
 	stw	r3,0(r1)		/* Zero the stack frame pointer	*/
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 03c2e1f134bc..111abb4df2ec 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1240,8 +1240,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		batch->active = 1;
 	}
 
-	if (current_thread_info()->task->thread.regs) {
-		restore_math(current_thread_info()->task->thread.regs);
+	if (current->thread.regs) {
+		restore_math(current->thread.regs);
 
 		/*
 		 * The copy-paste buffer can only store into foreign real
@@ -1251,7 +1251,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		 * mappings, we must issue a cp_abort to clear any state and
 		 * prevent snooping, corruption or a covert channel.
 		 */
-		if (current_thread_info()->task->thread.used_vas)
+		if (current->thread.used_vas)
 			asm volatile(PPC_CP_ABORT);
 	}
 #endif /* CONFIG_PPC_BOOK3S_64 */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 8c507be12c3c..81ebf7d6f526 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -205,10 +205,8 @@ void __init irqstack_early_init(void)
 	/* interrupt stacks must be in lowmem, we get that for free on ppc32
 	 * as the memblock is limited to lowmem by default */
 	for_each_possible_cpu(i) {
-		softirq_ctx[i] = (struct thread_info *)
-			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
-		hardirq_ctx[i] = (struct thread_info *)
-			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
+		softirq_ctx[i] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
+		hardirq_ctx[i] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
 	}
 }
 
@@ -226,13 +224,10 @@ void __init exc_lvl_early_init(void)
 		hw_cpu = 0;
 #endif
 
-		critirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
+		critirq_ctx[hw_cpu] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
 #ifdef CONFIG_BOOKE
-		dbgirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
-		mcheckirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
+		dbgirq_ctx[hw_cpu] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
+		mcheckirq_ctx[hw_cpu] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
 #endif
 	}
 }
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 61c1fadbc644..19dd0ea55714 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/task_stack.h>
 #include <linux/sched/topology.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
@@ -812,7 +813,8 @@ static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
 
 #ifdef CONFIG_PPC64
 	paca_ptrs[cpu]->__current = idle;
-	paca_ptrs[cpu]->kstack = (unsigned long)ti + THREAD_SIZE - STACK_FRAME_OVERHEAD;
+	paca_ptrs[cpu]->kstack = (unsigned long)task_stack_page(idle) +
+				  THREAD_SIZE - STACK_FRAME_OVERHEAD;
 #endif
 	ti->cpu = cpu;
 	secondary_ti = current_set[cpu] = ti;
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 694c1d92e796..0d8d6fee892a 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2988,7 +2988,7 @@ static void show_task(struct task_struct *tsk)
 	printf("%px %016lx %6d %6d %c %2d %s\n", tsk,
 		tsk->thread.ksp,
 		tsk->pid, tsk->parent->pid,
-		state, task_thread_info(tsk)->cpu,
+		state, task_cpu(tsk),
 		tsk->comm);
 }
 
-- 
2.13.3

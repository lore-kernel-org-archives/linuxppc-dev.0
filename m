Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 91D7B2C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 15:43:19 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r8O5hEwt004948
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 00:43:15 -0500
Message-ID: <1380001393.5443.29.camel@pasglop>
Subject: [PATCH] powerpc: Remove ksp_limit on ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 24 Sep 2013 15:43:13 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We've been keeping that field in thread_struct for a while, it contains
the "limit" of the current stack pointer and is meant to be used for
detecting stack overflows.

It has a few problems however:

 - First, it was never actually *used* on 64-bit. Set and updated but
not actually exploited

 - When switching stack to/from irq and softirq stacks, it's update
is racy unless we hard disable interrupts, which is costly. This
is fine on 32-bit as we don't soft-disable there but not on 64-bit.

Thus rather than fixing 2 in order to implement 1 in some hypothetical
future, let's remove the code completely from 64-bit. In order to avoid
a clutter of ifdef's, we remove the updates from C code completely
during interrupt stack switching, and instead maintain it from the
asm helper that is used to do the stack switching in the first place.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Applies on top of "powerpc/irq: Run softirqs off the top of the irq stack"

 arch/powerpc/include/asm/processor.h |  4 +---
 arch/powerpc/kernel/asm-offsets.c    |  3 ++-
 arch/powerpc/kernel/irq.c            | 12 ------------
 arch/powerpc/kernel/misc_32.S        | 16 ++++++++++++++++
 arch/powerpc/kernel/process.c        |  3 ++-
 arch/powerpc/lib/sstep.c             |  3 ++-
 6 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index e378ccc..ce4de5a 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -149,8 +149,6 @@ typedef struct {
 
 struct thread_struct {
 	unsigned long	ksp;		/* Kernel stack pointer */
-	unsigned long	ksp_limit;	/* if ksp <= ksp_limit stack overflow */
-
 #ifdef CONFIG_PPC64
 	unsigned long	ksp_vsid;
 #endif
@@ -162,6 +160,7 @@ struct thread_struct {
 #endif
 #ifdef CONFIG_PPC32
 	void		*pgdir;		/* root of page-table tree */
+	unsigned long	ksp_limit;	/* if ksp <= ksp_limit stack overflow */
 #endif
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	/*
@@ -321,7 +320,6 @@ struct thread_struct {
 #else
 #define INIT_THREAD  { \
 	.ksp = INIT_SP, \
-	.ksp_limit = INIT_SP_LIMIT, \
 	.regs = (struct pt_regs *)INIT_SP - 1, /* XXX bogus, I think */ \
 	.fs = KERNEL_DS, \
 	.fpr = {{0}}, \
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index d8958be..502c7a4 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -80,10 +80,11 @@ int main(void)
 	DEFINE(TASKTHREADPPR, offsetof(struct task_struct, thread.ppr));
 #else
 	DEFINE(THREAD_INFO, offsetof(struct task_struct, stack));
+	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
+	DEFINE(KSP_LIMIT, offsetof(struct thread_struct, ksp_limit));
 #endif /* CONFIG_PPC64 */
 
 	DEFINE(KSP, offsetof(struct thread_struct, ksp));
-	DEFINE(KSP_LIMIT, offsetof(struct thread_struct, ksp_limit));
 	DEFINE(PT_REGS, offsetof(struct thread_struct, regs));
 #ifdef CONFIG_BOOKE
 	DEFINE(THREAD_NORMSAVES, offsetof(struct thread_struct, normsave[0]));
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2234a12..57d286a 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -496,7 +496,6 @@ void do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct thread_info *curtp, *irqtp;
-	unsigned long saved_sp_limit;
 
 	/* Switch to the irq stack to handle this */
 	curtp = current_thread_info();
@@ -509,12 +508,6 @@ void do_IRQ(struct pt_regs *regs)
 		return;
 	}
 
-	/* Adjust the stack limit */
-	saved_sp_limit = current->thread.ksp_limit;
-	current->thread.ksp_limit = (unsigned long)irqtp +
-		_ALIGN_UP(sizeof(struct thread_info), 16);
-
-
 	/* Prepare the thread_info in the irq stack */
 	irqtp->task = curtp->task;
 	irqtp->flags = 0;
@@ -526,7 +519,6 @@ void do_IRQ(struct pt_regs *regs)
 	call_do_irq(regs, irqtp);
 
 	/* Restore stack limit */
-	current->thread.ksp_limit = saved_sp_limit;
 	irqtp->task = NULL;
 
 	/* Copy back updates to the thread_info */
@@ -604,16 +596,12 @@ void irq_ctx_init(void)
 static inline void do_softirq_onstack(void)
 {
 	struct thread_info *curtp, *irqtp;
-	unsigned long saved_sp_limit = current->thread.ksp_limit;
 
 	curtp = current_thread_info();
 	irqtp = softirq_ctx[smp_processor_id()];
 	irqtp->task = curtp->task;
 	irqtp->flags = 0;
-	current->thread.ksp_limit = (unsigned long)irqtp +
-				    _ALIGN_UP(sizeof(struct thread_info), 16);
 	call_do_softirq(irqtp);
-	current->thread.ksp_limit = saved_sp_limit;
 	irqtp->task = NULL;
 
 	/* Set any flag that may have been set on the
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 7da3882..2b0ad98 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -36,25 +36,41 @@
 
 	.text
 
+/*
+ * We store the saved ksp_limit in the unused part
+ * of the STACK_FRAME_OVERHEAD
+ */
 _GLOBAL(call_do_softirq)
 	mflr	r0
 	stw	r0,4(r1)
+	lwz	r10,THREAD+KSP_LIMIT(r2)
+	addi	r11,r3,THREAD_INFO_GAP
 	stwu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r3)
 	mr	r1,r3
+	stw	r10,8(r1)
+	stw	r11,THREAD+KSP_LIMIT(r2)
 	bl	__do_softirq
+	lwz	r10,8(r1)
 	lwz	r1,0(r1)
 	lwz	r0,4(r1)
+	stw	r10,THREAD+KSP_LIMIT(r2)
 	mtlr	r0
 	blr
 
 _GLOBAL(call_do_irq)
 	mflr	r0
 	stw	r0,4(r1)
+	lwz	r10,THREAD+KSP_LIMIT(r2)
+	addi	r11,r3,THREAD_INFO_GAP
 	stwu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r4)
 	mr	r1,r4
+	stw	r10,8(r1)
+	stw	r11,THREAD+KSP_LIMIT(r2)
 	bl	__do_irq
+	lwz	r10,8(r1)
 	lwz	r1,0(r1)
 	lwz	r0,4(r1)
+	stw	r10,THREAD+KSP_LIMIT(r2)
 	mtlr	r0
 	blr
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 6f428da..96d2fdf 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1000,9 +1000,10 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	kregs = (struct pt_regs *) sp;
 	sp -= STACK_FRAME_OVERHEAD;
 	p->thread.ksp = sp;
+#ifdef CONFIG_PPC32
 	p->thread.ksp_limit = (unsigned long)task_stack_page(p) +
 				_ALIGN_UP(sizeof(struct thread_info), 16);
-
+#endif
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	p->thread.ptrace_bps[0] = NULL;
 #endif
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index a7ee978..b1faa15 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1505,6 +1505,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		 */
 		if ((ra == 1) && !(regs->msr & MSR_PR) \
 			&& (val3 >= (regs->gpr[1] - STACK_INT_FRAME_SIZE))) {
+#ifdef CONFIG_PPC32
 			/*
 			 * Check if we will touch kernel sack overflow
 			 */
@@ -1513,7 +1514,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 				err = -EINVAL;
 				break;
 			}
-
+#endif /* CONFIG_PPC32 */
 			/*
 			 * Check if we already set since that means we'll
 			 * lose the previous value.

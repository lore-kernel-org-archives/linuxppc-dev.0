Return-Path: <mikey@neuling.org>
Message-Id: <20101206234051.087929475@neuling.org>
Date: Tue, 07 Dec 2010 10:40:50 +1100
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC/PATCH 7/7] powerpc: Enable lazy save VSX for SMP
References: <20101206234043.083045003@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables lazy save of VSX state for SMP configurations.

Most of the logic for this is in the FP and VMX code, since VSX has no
additional state over these.  

When context switching to a new process:
 - if both VMX and FP state are on the CPU we are switch to, turn VSX
   on also.
 - if either FP or VMX are not on the CPU we are switch on, do not
   turn VSX on in the MSR.
We always start the new process at this point, irrespective of if we
have the FP and/or VMX state in the thread struct or current CPU.

When we take the vsx_unavailable exception, we first run load_up_fpu
and load_up_altivec to enable our state.  If either of these fail to
enable their respective MSR bits, the state has not arrived from the
IPI and hence we should bail to userspace with VSX off.  This will
enable IRQs, while we are waiting for the FP and VMX state. 

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/system.h |    4 +-
 arch/powerpc/kernel/process.c     |   72 ++++++++++++++++++++------------------
 arch/powerpc/kernel/signal_32.c   |    2 -
 arch/powerpc/kernel/signal_64.c   |    2 -
 arch/powerpc/kernel/vector.S      |   48 +++----------------------
 5 files changed, 49 insertions(+), 79 deletions(-)

Index: linux-lazy/arch/powerpc/include/asm/system.h
===================================================================
--- linux-lazy.orig/arch/powerpc/include/asm/system.h
+++ linux-lazy/arch/powerpc/include/asm/system.h
@@ -150,8 +150,8 @@
 extern void giveup_altivec_ipi(void *);
 extern void load_up_altivec(struct task_struct *);
 extern int emulate_altivec(struct pt_regs *);
-extern void __giveup_vsx(struct task_struct *);
-extern void giveup_vsx(struct task_struct *);
+extern void __giveup_vsx(void);
+extern void giveup_vsx(void);
 extern void enable_kernel_spe(void);
 extern void giveup_spe(struct task_struct *);
 extern void load_up_spe(struct task_struct *);
Index: linux-lazy/arch/powerpc/kernel/process.c
===================================================================
--- linux-lazy.orig/arch/powerpc/kernel/process.c
+++ linux-lazy/arch/powerpc/kernel/process.c
@@ -58,7 +58,6 @@
 extern unsigned long _get_SP(void);
 
 #ifndef CONFIG_SMP
-struct task_struct *last_task_used_vsx = NULL;
 struct task_struct *last_task_used_spe = NULL;
 #endif
 
@@ -105,37 +104,21 @@
 {
 	WARN_ON(preemptible());
 
-#ifdef CONFIG_SMP
-	if (current->thread.regs && (current->thread.regs->msr & MSR_VSX))
-		giveup_vsx(current);
-	else
-		giveup_vsx(NULL);	/* just enable vsx for kernel - force */
-#else
-	giveup_vsx(last_task_used_vsx);
-#endif /* CONFIG_SMP */
+	giveup_vsx();
 }
 EXPORT_SYMBOL(enable_kernel_vsx);
 #endif
 
-void giveup_vsx(struct task_struct *tsk)
+void giveup_vsx(void)
 {
 	giveup_fpu(0);
 	giveup_altivec(0);
-	__giveup_vsx(tsk);
+	__giveup_vsx();
 }
 
 void flush_vsx_to_thread(struct task_struct *tsk)
 {
-	if (tsk->thread.regs) {
-		preempt_disable();
-		if (tsk->thread.regs->msr & MSR_VSX) {
-#ifdef CONFIG_SMP
-			BUG_ON(tsk != current);
-#endif
-			giveup_vsx(tsk);
-		}
-		preempt_enable();
-	}
+	giveup_vsx();
 }
 #endif /* CONFIG_VSX */
 
@@ -182,11 +165,11 @@
 #ifdef CONFIG_ALTIVEC
 	giveup_altivec(0);
 #endif /* CONFIG_ALTIVEC */
-#ifndef CONFIG_SMP
 #ifdef CONFIG_VSX
-	if (last_task_used_vsx == current)
-		last_task_used_vsx = NULL;
+	/* use __ version since fpu and altivec have been called already */
+	__giveup_vsx();
 #endif /* CONFIG_VSX */
+#ifndef CONFIG_SMP
 #ifdef CONFIG_SPE
 	if (last_task_used_spe == current)
 		last_task_used_spe = NULL;
@@ -462,26 +445,51 @@
 }
 #endif /* CONFIG_ALTIVEC */
 
+#ifdef CONFIG_VSX
+/* Return value indicates if it was lazy or not */
+static bool switch_to_vsx_lazy(struct task_struct *prev,
+			      struct task_struct *new,
+			      bool lazy)
+{
+	/* Is the state here? */
+	if (lazy) {
+		/* It's here! Excellent, simply turn VSX on */
+		new->thread.regs->msr |= MSR_VSX;
+		return true;
+	}
+	/*
+	 * If we have used VSX in the past, but don't have lazy state,
+	 * then make sure we turn off VSX.  load_up_vsx will deal
+	 * with saving the lazy state if we run a VSX instruction
+	 */
+	new->thread.regs->msr &= ~MSR_VSX;
+	return false;
+}
+#else /* CONFIG_VSX */
+static bool switch_to_vsx_lazy(struct task_struct *prev,
+			      struct task_struct *new,
+			      int lazy)
+{
+	return 1;
+}
+#endif /* CONFIG_VSX */
+
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
 {
 	struct thread_struct *new_thread, *old_thread;
 	unsigned long flags;
 	struct task_struct *last;
-	int lazy = 1;
+	bool lazy = true;
 
 	/* Does next have lazy state somewhere? */
 	if (new->thread.regs) {
 		lazy &= switch_to_fp_lazy(prev, new);
 		lazy &= switch_to_altivec_lazy(prev, new);
+		switch_to_vsx_lazy(prev, new, lazy);
 	}
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_VSX
-	if (prev->thread.regs && (prev->thread.regs->msr & MSR_VSX))
-		/* VMX and FPU registers are already save here */
-		__giveup_vsx(prev);
-#endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	/*
 	 * If the previous thread used spe in the last quantum
@@ -495,10 +503,6 @@
 #endif /* CONFIG_SPE */
 
 #else  /* CONFIG_SMP */
-#ifdef CONFIG_VSX
-	if (new->thread.regs && last_task_used_vsx == new)
-		new->thread.regs->msr |= MSR_VSX;
-#endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	/* Avoid the trap.  On smp this this never happens since
 	 * we don't set last_task_used_spe
Index: linux-lazy/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-lazy.orig/arch/powerpc/kernel/signal_32.c
+++ linux-lazy/arch/powerpc/kernel/signal_32.c
@@ -452,7 +452,7 @@
 	 * contains valid data
 	 */
 	if (current->thread.used_vsr && ctx_has_vsx_region) {
-		__giveup_vsx(current);
+		__giveup_vsx();
 		if (copy_vsx_to_user(&frame->mc_vsregs, current))
 			return 1;
 		msr |= MSR_VSX;
Index: linux-lazy/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-lazy.orig/arch/powerpc/kernel/signal_64.c
+++ linux-lazy/arch/powerpc/kernel/signal_64.c
@@ -123,7 +123,7 @@
 	 * VMX data.
 	 */
 	if (current->thread.used_vsr && ctx_has_vsx_region) {
-		__giveup_vsx(current);
+		__giveup_vsx();
 		v_regs += ELF_NVRREG;
 		err |= copy_vsx_to_user(v_regs, current);
 		/* set MSR_VSX in the MSR value in the frame to
Index: linux-lazy/arch/powerpc/kernel/vector.S
===================================================================
--- linux-lazy.orig/arch/powerpc/kernel/vector.S
+++ linux-lazy/arch/powerpc/kernel/vector.S
@@ -257,50 +257,23 @@
 	beql+	load_up_fpu		/* skip if already loaded */
 	andis.	r5,r12,MSR_VEC@h
 	beql+	load_up_altivec		/* skip if already loaded */
-
-#ifndef CONFIG_SMP
-	ld	r3,last_task_used_vsx@got(r2)
-	ld	r4,0(r3)
-	cmpdi	0,r4,0
-	beq	1f
-	/* Disable VSX for last_task_used_vsx */
-	addi	r4,r4,THREAD
-	ld	r5,PT_REGS(r4)
-	ld	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	lis	r6,MSR_VSX@h
-	andc	r6,r4,r6
-	std	r6,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
-#endif /* CONFIG_SMP */
-	ld	r4,PACACURRENT(r13)
-	addi	r4,r4,THREAD		/* Get THREAD */
+/* state is all local now */
+	GET_CURRENT_THREAD(r5)
 	li	r6,1
-	stw	r6,THREAD_USED_VSR(r4) /* ... also set thread used vsr */
+	stw	r6,THREAD_USED_VSR(r5)
 	/* enable use of VSX after return */
 	oris	r12,r12,MSR_VSX@h
 	std	r12,_MSR(r1)
-#ifndef CONFIG_SMP
-	/* Update last_task_used_vsx to 'current' */
-	ld	r4,PACACURRENT(r13)
-	std	r4,0(r3)
-#endif /* CONFIG_SMP */
 	b	fast_exception_return
 
 /*
- * __giveup_vsx(tsk)
- * Disable VSX for the task given as the argument.
+ * __giveup_vsx()
+ * Disable VSX for current task
  * Does NOT save vsx registers.
- * Enables the VSX for use in the kernel on return.
+ * Doesn't enable kernel VSX on return (we could if need later)
  */
 _GLOBAL(__giveup_vsx)
-	mfmsr	r5
-	oris	r5,r5,MSR_VSX@h
-	mtmsrd	r5			/* enable use of VSX now */
-	isync
-
-	cmpdi	0,r3,0
-	beqlr-				/* if no previous owner, done */
-	addi	r3,r3,THREAD		/* want THREAD of task */
+	GET_CURRENT_THREAD(r3)
 	ld	r5,PT_REGS(r3)
 	cmpdi	0,r5,0
 	beq	1f
@@ -309,16 +282,9 @@
 	andc	r4,r4,r3		/* disable VSX for previous task */
 	std	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 1:
-#ifndef CONFIG_SMP
-	li	r5,0
-	ld	r4,last_task_used_vsx@got(r2)
-	std	r5,0(r4)
-#endif /* CONFIG_SMP */
 	blr
-
 #endif /* CONFIG_VSX */
 
-
 /*
  * The routines below are in assembler so we can closely control the
  * usage of floating-point registers.  These routines must be called

Return-Path: <mikey@neuling.org>
Message-Id: <20101206234050.852344595@neuling.org>
Date: Tue, 07 Dec 2010 10:40:49 +1100
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC/PATCH 6/7] powerpc: Enable lazy save FP registers for SMP
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

This enables lazy save of FP registers for SMP configurations.

This adds a pointer to the thread struct to say which CPU holds this
processes FP register state.  On 64 bit, this points to the paca of
the CPU holding the state or NULL if it's in the thread_struct.  On 32
bit, this is the CPU number of the CPU holding the state or -1 if it's
in the thread_struct.

It also adds a per cpu pointer (paca on 64bit), which points to the
thread_struct of the process who's state we currently own. 

On a context switch we do the following:
 - if we are switching to a CPU that currently holds the new processes
   state, just turn on FP in the MSR (this is the lazy/quick case)
 - if the new processes state is in the thread_struct, turn FP off.
 - if the new processes state is in someone else's CPU, IPI that CPU
   to giveup it's state and turn FP off.
We always start the new process at this point, irrespective of if we
have the state or not in the thread struct or current CPU.

When we take the FP unavailable, load_up_altivec checks to see if the
state is now in the thread_struct.  If it is, we restore the FP
registers and start the process.  If it's not, we need to wait for the
IPI to finish.  Unfortunately, IRQs are off on the current CPU at this
point, so we must turn IRQs on (to avoid a deadlock) before we block
waiting for the IPI to finished on the other CPU.

We also change load_up_fpu to call giveup_fpu to save it's state
rather than duplicating this code.  This means that giveup_altivec can
now be called with the MMU on or off, hence we pass in an offset,
which gets subtracted on 32 bit systems on loads and stores.

For 32bit it's be nice to have last_used_fp cacheline aligned or as
per_cpu variables but we can't access per_cpu vars in asm.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/paca.h      |    1 
 arch/powerpc/include/asm/processor.h |    8 +
 arch/powerpc/include/asm/system.h    |    3 
 arch/powerpc/kernel/asm-offsets.c    |    3 
 arch/powerpc/kernel/fpu.S            |  198 +++++++++++++++++++++++++++--------
 arch/powerpc/kernel/paca.c           |    1 
 arch/powerpc/kernel/process.c        |  114 +++++++++++---------
 7 files changed, 237 insertions(+), 91 deletions(-)

Index: linux-lazy/arch/powerpc/include/asm/paca.h
===================================================================
--- linux-lazy.orig/arch/powerpc/include/asm/paca.h
+++ linux-lazy/arch/powerpc/include/asm/paca.h
@@ -145,6 +145,7 @@
 	u64 dtl_ridx;			/* read index in dispatch log */
 	struct dtl_entry *dtl_curr;	/* pointer corresponding to dtl_ridx */
 
+	struct task_struct *last_used_fp;
 #ifdef CONFIG_ALTIVEC
 	/* lazy save pointers */
 	struct task_struct *last_used_altivec;
Index: linux-lazy/arch/powerpc/include/asm/processor.h
===================================================================
--- linux-lazy.orig/arch/powerpc/include/asm/processor.h
+++ linux-lazy/arch/powerpc/include/asm/processor.h
@@ -120,7 +120,6 @@
 extern long kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 
 /* Lazy FPU handling on uni-processor */
-extern struct task_struct *last_task_used_math;
 extern struct task_struct *last_task_used_vsx;
 extern struct task_struct *last_task_used_spe;
 
@@ -253,6 +252,13 @@
 	} fpscr;
 	int		fpexc_mode;	/* floating-point exception mode */
 	unsigned int	align_ctl;	/* alignment handling control */
+	int		used_fp;	/* set if process has used fp */
+#ifdef CONFIG_PPC64
+	struct paca_struct *fp_state;	/* paca where my fp state could be? */
+#else
+	unsigned long	fp_state;	/* paca where my fp state could be? */
+#endif
+	struct call_single_data fp_csd;	/* IPI data structure */
 #ifdef CONFIG_PPC64
 	unsigned long	start_tb;	/* Start purr when proc switched in */
 	unsigned long	accum_tb;	/* Total accumilated purr for process */
Index: linux-lazy/arch/powerpc/include/asm/system.h
===================================================================
--- linux-lazy.orig/arch/powerpc/include/asm/system.h
+++ linux-lazy/arch/powerpc/include/asm/system.h
@@ -140,7 +140,8 @@
 extern void via_cuda_init(void);
 extern void read_rtc_time(void);
 extern void pmac_find_display(void);
-extern void giveup_fpu(struct task_struct *);
+extern void giveup_fpu(unsigned long offset);
+extern void giveup_fpu_ipi(void *);
 extern void disable_kernel_fp(void);
 extern void enable_kernel_fp(void);
 extern void flush_fp_to_thread(struct task_struct *);
Index: linux-lazy/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-lazy.orig/arch/powerpc/kernel/asm-offsets.c
+++ linux-lazy/arch/powerpc/kernel/asm-offsets.c
@@ -84,6 +84,8 @@
 	DEFINE(THREAD_FPEXC_MODE, offsetof(struct thread_struct, fpexc_mode));
 	DEFINE(THREAD_FPR0, offsetof(struct thread_struct, fpr[0]));
 	DEFINE(THREAD_FPSCR, offsetof(struct thread_struct, fpscr));
+	DEFINE(THREAD_FP_STATE, offsetof(struct thread_struct, fp_state));
+	DEFINE(THREAD_USED_FP, offsetof(struct thread_struct, used_fp));
 #ifdef CONFIG_ALTIVEC
 	DEFINE(THREAD_VR0, offsetof(struct thread_struct, vr[0]));
 	DEFINE(THREAD_VRSAVE, offsetof(struct thread_struct, vrsave));
@@ -198,6 +200,7 @@
 	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
 	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
 	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
+	DEFINE(PACA_LAST_USED_FP, offsetof(struct paca_struct, last_used_fp));
 #ifdef CONFIG_ALTIVEC
 	DEFINE(PACA_LAST_USED_ALTIVEC, offsetof(struct paca_struct, last_used_altivec));
 #endif
Index: linux-lazy/arch/powerpc/kernel/fpu.S
===================================================================
--- linux-lazy.orig/arch/powerpc/kernel/fpu.S
+++ linux-lazy/arch/powerpc/kernel/fpu.S
@@ -23,6 +23,8 @@
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/exception-64s.h>
+#include <linux/threads.h>
 
 #ifdef CONFIG_VSX
 #define REST_32FPVSRS(n,c,base)						\
@@ -47,6 +49,26 @@
 #define SAVE_32FPVSRS(n,b,base)	SAVE_32FPRS(n, base)
 #endif
 
+#ifdef CONFIG_PPC32
+       .section .bss
+       .align  4
+last_used_fp:
+       .space  4*NR_CPUS
+       .previous
+/*
+ * Get the last_used_fp pointer for this cpu.
+ * Pointer ends up in register n.  offset in a, volotile scratch in b
+ */
+#define LAST_USED_FP_PTR(n, a, b)		\
+       rlwinm  b,r1,0,0,(31-THREAD_SHIFT) ;	\
+       sub     b,b,a	;			\
+       lwz     b,TI_CPU(b) ;			\
+       slwi    b,b,2       ;			\
+       lis     n,last_used_fp@ha ;		\
+       addi    n,n,last_used_fp@l ;		\
+       sub     n,n,a	;			\
+       add     n,n,b
+#endif
 /*
  * This task wants to use the FPU now.
  * On UP, disable FP for the task which had the FPU previously,
@@ -65,52 +87,113 @@
 	SYNC
 	MTMSRD(r5)			/* enable use of fpu now */
 	isync
+
+	mflr    r10
+#ifdef CONFIG_PPC32
+	lis	r3, PAGE_OFFSET@h
+#endif
+	bl      giveup_fpu_msr_done
 /*
- * For SMP, we don't do lazy FPU switching because it just gets too
- * horrendously complex, especially when a task switches from one CPU
- * to another.  Instead we call giveup_fpu in switch_to.
+ * lazy restore:
+ * 	If we are doing lazy restore we enter here either:
+ * 	1. never done fp before
+ * 	2. done fp and state is in our thread_struct
+ * 	3. done fp and but state is being flushed via an IPI
  */
-#ifndef CONFIG_SMP
-	LOAD_REG_ADDRBASE(r3, last_task_used_math)
-	toreal(r3)
-	PPC_LL	r4,ADDROFF(last_task_used_math)(r3)
-	PPC_LCMPI	0,r4,0
-	beq	1f
-	toreal(r4)
-	addi	r4,r4,THREAD		/* want last_task_used_math->thread */
-	SAVE_32FPVSRS(0, r5, r4)
-	mffs	fr0
-	stfd	fr0,THREAD_FPSCR(r4)
-	PPC_LL	r5,PT_REGS(r4)
-	toreal(r5)
-	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	li	r10,MSR_FP|MSR_FE0|MSR_FE1
-	andc	r4,r4,r10		/* disable FP for previous task */
-	PPC_STL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
-#endif /* CONFIG_SMP */
+	GET_CURRENT_THREAD(r5)
+	lwz 	r4,THREAD_USED_FP(r5)
+	PPC_LCMPI	cr0,r4,0 /* we've not used fp before */
+	beq	4f
+
+	/*
+         * Spin here waiting for IPI to finish.  Once the data is in
+	 * our thread_struct, cp_state will be null:
+	 *
+	 * First quickly check to see if data has been flushed from
+	 * another CPU yet (as it's likely the IPI has completed)
+	 */
+5:
+	PPC_LL	r4,THREAD_FP_STATE(r5)
+	PPC_LCMPI	0,r4,TS_LAZY_STATE_INVALID
+	beq+	3f /* it's likely the data is already here */
+	/*
+	 * Bugger, the IPI has not completed.  Let's spin here waiting
+	 * for it, but we should turn on IRQ incase someone is wait for
+	 * us for something.
+	 */
+
+	/* Enable IRQs */
+#ifdef CONFIG_PPC32
+	mfmsr	r4
+	rlwimi	r4,r9,0,MSR_EE
+	MTMSRD(r4)
+#else
+	ENABLE_INTS
+#endif
+2:
+	/* Wait for lazy state to appear */
+	PPC_LL	r4,THREAD_FP_STATE(r5)
+	PPC_LCMPI	0,r4,TS_LAZY_STATE_INVALID
+	bne	2b
+
+	/* disable irqs and enable fp again */
+#ifdef CONFIG_PPC32
+	mfmsr	r4
+	ori	r4,r4,MSR_FP
+	xori	r4,r4,MSR_EE
+	MTMSRD(r4)
+#else
+	mfmsr	r11
+	ori	r11,r11,MSR_FP
+	xori	r11,r11,MSR_EE
+	MTMSRD(r11)
+#endif
+	/*
+	 * make sure we didn't pickup someones state while we had IRQs
+	 * on
+	 */
+#ifdef CONFIG_PPC32
+	lis	r3, PAGE_OFFSET@h
+#endif
+	bl	giveup_fpu_msr_done
+3:
+	LWSYNC /* make sure fp registers are in memory */
+4:
+	mtlr	r10
+
+	/* setup lazy pointers */
+	GET_CURRENT_THREAD(r5)
+#ifdef CONFIG_PPC64
+	PPC_STL	r13,THREAD_FP_STATE(r5)
+#else
+	/* get the cpuid */
+	lis	r6,PAGE_OFFSET@h
+	rlwinm  r7,r1,0,0,(31-THREAD_SHIFT)
+	sub     r7,r7,r6
+	lwz     r7,TI_CPU(r7)
+	PPC_STL	r7,THREAD_FP_STATE(r5) /* write the cpuid */
+#endif
+	subi	r4, r5, THREAD
+#ifdef CONFIG_PPC64
+	PPC_STL	r4,PACA_LAST_USED_FP(r13)
+#else
+/*	lis	r6, PAGE_OFFSET@h */
+	LAST_USED_FP_PTR(r3, r6, r7)
+	PPC_STL	r4,0(r3)
+#endif
 	/* enable use of FP after return */
 #ifdef CONFIG_PPC32
-	mfspr	r5,SPRN_SPRG_THREAD		/* current task's THREAD (phys) */
-	lwz	r4,THREAD_FPEXC_MODE(r5)
-	ori	r9,r9,MSR_FP		/* enable FP for current */
-	or	r9,r9,r4
-#else
-	ld	r4,PACACURRENT(r13)
-	addi	r5,r4,THREAD		/* Get THREAD */
-	lwz	r4,THREAD_FPEXC_MODE(r5)
+	ori	r9,r9,MSR_FP
+#else
 	ori	r12,r12,MSR_FP
-	or	r12,r12,r4
 	std	r12,_MSR(r1)
 #endif
+	li	r4,1
+	stw	r4,THREAD_USED_FP(r5)
+	LWSYNC
 	lfd	fr0,THREAD_FPSCR(r5)
 	MTFSF_L(fr0)
 	REST_32FPVSRS(0, r4, r5)
-#ifndef CONFIG_SMP
-	subi	r4,r5,THREAD
-	fromreal(r4)
-	PPC_STL	r4,ADDROFF(last_task_used_math)(r3)
-#endif /* CONFIG_SMP */
 	/* restore registers and return */
 	/* we haven't used ctr or xer or lr */
 	blr
@@ -122,6 +205,7 @@
  * Enables the FPU for use in the kernel on return.
  */
 _GLOBAL(giveup_fpu)
+_GLOBAL(giveup_fpu_ipi)
 	mfmsr	r5
 	ori	r5,r5,MSR_FP
 #ifdef CONFIG_VSX
@@ -134,8 +218,26 @@
 	MTMSRD(r5)			/* enable use of fpu now */
 	SYNC_601
 	isync
+
+giveup_fpu_msr_done:
+#ifdef CONFIG_PPC64
+	PPC_LL	r3,PACA_LAST_USED_FP(r13)
+#else
+	mr	r7, r3
+	LAST_USED_FP_PTR(r4, r7, r5)
+	PPC_LL	r3,0(r4)		/* phys address */
+#endif
 	PPC_LCMPI	0,r3,0
-	beqlr-				/* if no previous owner, done */
+	beqlr				/* if no previous owner, done */
+#ifdef CONFIG_PPC32
+	/* turn phys address into phys or virt based on offset */
+	lis	r6,PAGE_OFFSET@h
+	sub	r6, r6, r7
+	add	r3, r3, r6
+#endif
+2:
+	/* Save state to the thread struct */
+	mr	r6,r3
 	addi	r3,r3,THREAD	        /* want THREAD of task */
 	PPC_LL	r5,PT_REGS(r3)
 	PPC_LCMPI	0,r5,0
@@ -143,6 +245,9 @@
 	mffs	fr0
 	stfd	fr0,THREAD_FPSCR(r3)
 	beq	1f
+#ifdef CONFIG_PPC32
+	sub	r5, r5, r7
+#endif
 	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 	li	r3,MSR_FP|MSR_FE0|MSR_FE1
 #ifdef CONFIG_VSX
@@ -153,11 +258,22 @@
 	andc	r4,r4,r3		/* disable FP for previous task */
 	PPC_STL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 1:
-#ifndef CONFIG_SMP
+	/*
+	 * If this is an ipi, make sure state is is commited before we
+	 * clear the lazy state pointers and return.  If a CPU is waiting on
+	 * this data (IPI case) then it won't start until FP_STATE is cleared
+	 */
+	LWSYNC /* make sure registers are in mem before say they are */
+	li	r5,TS_LAZY_STATE_INVALID
+	PPC_STL	r5,THREAD+THREAD_FP_STATE(r6)
 	li	r5,0
-	LOAD_REG_ADDRBASE(r4,last_task_used_math)
-	PPC_STL	r5,ADDROFF(last_task_used_math)(r4)
-#endif /* CONFIG_SMP */
+#ifdef CONFIG_PPC64
+	PPC_STL	r5,PACA_LAST_USED_FP(r13)
+#else
+	LAST_USED_FP_PTR(r3, r7, r4)
+	PPC_STL	r5,0(r3)
+#endif
+	LWSYNC
 	blr
 
 /*
Index: linux-lazy/arch/powerpc/kernel/paca.c
===================================================================
--- linux-lazy.orig/arch/powerpc/kernel/paca.c
+++ linux-lazy/arch/powerpc/kernel/paca.c
@@ -162,6 +162,7 @@
 	new_paca->hw_cpu_id = 0xffff;
 	new_paca->kexec_state = KEXEC_STATE_NONE;
 	new_paca->__current = &init_task;
+	new_paca->last_used_fp = NULL;
 #ifdef CONFIG_ALTIVEC
 	new_paca->last_used_altivec = NULL;
 #endif
Index: linux-lazy/arch/powerpc/kernel/process.c
===================================================================
--- linux-lazy.orig/arch/powerpc/kernel/process.c
+++ linux-lazy/arch/powerpc/kernel/process.c
@@ -58,7 +58,6 @@
 extern unsigned long _get_SP(void);
 
 #ifndef CONFIG_SMP
-struct task_struct *last_task_used_math = NULL;
 struct task_struct *last_task_used_vsx = NULL;
 struct task_struct *last_task_used_spe = NULL;
 #endif
@@ -69,45 +68,14 @@
  */
 void flush_fp_to_thread(struct task_struct *tsk)
 {
-	if (tsk->thread.regs) {
-		/*
-		 * We need to disable preemption here because if we didn't,
-		 * another process could get scheduled after the regs->msr
-		 * test but before we have finished saving the FP registers
-		 * to the thread_struct.  That process could take over the
-		 * FPU, and then when we get scheduled again we would store
-		 * bogus values for the remaining FP registers.
-		 */
-		preempt_disable();
-		if (tsk->thread.regs->msr & MSR_FP) {
-#ifdef CONFIG_SMP
-			/*
-			 * This should only ever be called for current or
-			 * for a stopped child process.  Since we save away
-			 * the FP register state on context switch on SMP,
-			 * there is something wrong if a stopped child appears
-			 * to still have its FP state in the CPU registers.
-			 */
-			BUG_ON(tsk != current);
-#endif
-			giveup_fpu(tsk);
-		}
-		preempt_enable();
-	}
+	giveup_fpu(0);
 }
 
 void enable_kernel_fp(void)
 {
 	WARN_ON(preemptible());
 
-#ifdef CONFIG_SMP
-	if (current->thread.regs && (current->thread.regs->msr & MSR_FP))
-		giveup_fpu(current);
-	else
-		giveup_fpu(NULL);	/* just enables FP for kernel */
-#else
-	giveup_fpu(last_task_used_math);
-#endif /* CONFIG_SMP */
+	giveup_fpu(0);
 }
 EXPORT_SYMBOL(enable_kernel_fp);
 
@@ -151,7 +119,7 @@
 
 void giveup_vsx(struct task_struct *tsk)
 {
-	giveup_fpu(tsk);
+	giveup_fpu(0);
 	giveup_altivec(0);
 	__giveup_vsx(tsk);
 }
@@ -210,12 +178,11 @@
 void discard_lazy_cpu_state(void)
 {
 	preempt_disable();
+	giveup_fpu(0);
 #ifdef CONFIG_ALTIVEC
 	giveup_altivec(0);
 #endif /* CONFIG_ALTIVEC */
 #ifndef CONFIG_SMP
-	if (last_task_used_math == current)
-		last_task_used_math = NULL;
 #ifdef CONFIG_VSX
 	if (last_task_used_vsx == current)
 		last_task_used_vsx = NULL;
@@ -378,6 +345,60 @@
 
 extern int csd_locked(struct call_single_data *data);
 
+/* Return value indicates if it was lazy or not */
+static bool switch_to_fp_lazy(struct task_struct *prev,
+			      struct task_struct *new)
+{
+	/*
+	 * At this point the FP reg state can be in 1 of 3 places
+	 * 1) cached on _this_ CPU.   Lazy/fast  :-)
+	 * 2) in the thread_struct.   Normal     :-|
+	 * 3) cached on another CPU.  Slow IPI   :-(
+         * .... lets go workout what happened....
+	 */
+
+	/* Cache the state pointer here incase it changes */
+	TS_LAZY_STATE_TYPE state = new->thread.fp_state;
+
+	/* Is the state here? */
+	if (state == LAZY_STATE_HERE) {
+		/* It's here! Excellent, simply turn FP on */
+		new->thread.regs->msr |= MSR_FP;
+		return true;
+	}
+	/*
+	 * If we have used FP in the past, but don't have lazy state,
+	 * then make sure we turn off FP.  load_up_fpu will deal
+	 * with saving the lazy state if we run an fp instruction
+	 */
+	new->thread.regs->msr &= ~MSR_FP;
+
+	if (state != TS_LAZY_STATE_INVALID) {
+#ifdef CONFIG_SMP
+		/*
+		 * To avoid a deadlock, make sure we don't
+		 * have someone else state here
+		 */
+		discard_lazy_cpu_state();
+
+		/*
+		 * Get the other CPU to flush it's state
+		 * synchronously.  It's possible this may may get run
+		 * multiple times, but giveup_fpu can handle this.
+		 */
+		if (!csd_locked(&(new->thread.fp_csd)))
+			__smp_call_function_single(
+				LAZY_STATE_CPU_ID,
+				&(new->thread.fp_csd),
+				0);
+#else /* CONFIG_SMP */
+		/* UP can't have state on another CPU */
+		BUG();
+#endif
+	}
+	return false;
+}
+
 #ifdef CONFIG_ALTIVEC
 /* Return value indicates if it was lazy or not */
 static bool switch_to_altivec_lazy(struct task_struct *prev,
@@ -451,21 +472,11 @@
 
 	/* Does next have lazy state somewhere? */
 	if (new->thread.regs) {
+		lazy &= switch_to_fp_lazy(prev, new);
 		lazy &= switch_to_altivec_lazy(prev, new);
 	}
 
 #ifdef CONFIG_SMP
-	/* avoid complexity of lazy save/restore of fpu
-	 * by just saving it every time we switch out if
-	 * this task used the fpu during the last quantum.
-	 *
-	 * If it tries to use the fpu again, it'll trap and
-	 * reload its fp regs.  So we don't have to do a restore
-	 * every switch, just a save.
-	 *  -- Cort
-	 */
-	if (prev->thread.regs && (prev->thread.regs->msr & MSR_FP))
-		giveup_fpu(prev);
 #ifdef CONFIG_VSX
 	if (prev->thread.regs && (prev->thread.regs->msr & MSR_VSX))
 		/* VMX and FPU registers are already save here */
@@ -892,8 +903,15 @@
 #ifdef CONFIG_VSX
 	current->thread.used_vsr = 0;
 #endif
+#ifdef CONFIG_PPC_FPU
 	memset(current->thread.fpr, 0, sizeof(current->thread.fpr));
 	current->thread.fpscr.val = 0;
+	current->thread.used_fp = 0;
+	current->thread.fp_state = TS_LAZY_STATE_INVALID;
+	current->thread.fp_csd.func = giveup_fpu_ipi;
+	current->thread.fp_csd.info = 0;
+	current->thread.fp_csd.flags = 0;
+#endif /* CONFIG_PPC_FPU */
 #ifdef CONFIG_ALTIVEC
 	memset(current->thread.vr, 0, sizeof(current->thread.vr));
 	memset(&current->thread.vscr, 0, sizeof(current->thread.vscr));

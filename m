Return-Path: <mikey@neuling.org>
Message-Id: <20101206234050.620201382@neuling.org>
Date: Tue, 07 Dec 2010 10:40:48 +1100
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC/PATCH 5/7] powerpc: Enable lazy save VMX registers for SMP
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

This enables lazy save of VMX registers for SMP configurations.

This adds a pointer to the thread struct to say which CPU holds this
processes VMX register state.  On 64 bit, this points to the paca of
the CPU holding the state or NULL if it's in the thread_struct.  On 32
bit, this is the CPU number of the CPU holding the state or -1 if it's
in the thread_struct.

It also adds a per cpu pointer (paca on 64bit), which points to the
thread_struct of the process who's state we currently own. 

On a context switch we do the following:
 - if we are switching to a CPU that currently holds the new processes
   state, just turn on VMX in the MSR (this is the lazy/quick case)
 - if the new processes state is in the thread_struct, turn VMX off.
 - if the new processes state is in someone else's CPU, IPI that CPU
   to giveup it's state and turn VMX off.
We always start the new process at this point, irrespective of if we
have the state or not in the thread struct or current CPU.

When we take the VMX unavailable, load_up_altivec checks to see if the
state is now in the thread_struct.  If it is, we restore the VMX
registers and start the process.  If it's not, we need to wait for the
IPI to finish.  Unfortunately, IRQs are off on the current CPU at this
point, so we must turn IRQs on (to avoid a deadlock) before we block
waiting for the IPI to finished on the other CPU.

We also change load_up_altivec to call giveup_altivec to save it's
state rather than duplicating this code.  This means that
giveup_altivec can now be called with the MMU on or off, hence we pass
in an offset, which gets subtracted on 32 bit systems on loads and
stores. 

For 32bit it's be nice to have last_used_altivec cacheline aligned or
as per_cpu variables but we can't access per_cpu vars in asm

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/paca.h              |    5 
 arch/powerpc/include/asm/processor.h         |   22 ++
 arch/powerpc/include/asm/reg.h               |    9 +
 arch/powerpc/include/asm/system.h            |   10 -
 arch/powerpc/kernel/asm-offsets.c            |    4 
 arch/powerpc/kernel/paca.c                   |    3 
 arch/powerpc/kernel/process.c                |  138 ++++++++++++------
 arch/powerpc/kernel/vector.S                 |  199 ++++++++++++++++++++-------
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    1 
 9 files changed, 288 insertions(+), 103 deletions(-)

Index: linux-lazy/arch/powerpc/include/asm/paca.h
===================================================================
--- linux-lazy.orig/arch/powerpc/include/asm/paca.h
+++ linux-lazy/arch/powerpc/include/asm/paca.h
@@ -145,6 +145,11 @@
 	u64 dtl_ridx;			/* read index in dispatch log */
 	struct dtl_entry *dtl_curr;	/* pointer corresponding to dtl_ridx */
 
+#ifdef CONFIG_ALTIVEC
+	/* lazy save pointers */
+	struct task_struct *last_used_altivec;
+#endif
+
 #ifdef CONFIG_KVM_BOOK3S_HANDLER
 	/* We use this to store guest state in */
 	struct kvmppc_book3s_shadow_vcpu shadow_vcpu;
Index: linux-lazy/arch/powerpc/include/asm/processor.h
===================================================================
--- linux-lazy.orig/arch/powerpc/include/asm/processor.h
+++ linux-lazy/arch/powerpc/include/asm/processor.h
@@ -18,6 +18,16 @@
 #define TS_FPRWIDTH 1
 #endif
 
+#ifdef CONFIG_PPC64
+#ifdef __ASSEMBLY__
+#define TS_LAZY_STATE_INVALID 0
+#else
+#define TS_LAZY_STATE_INVALID NULL
+#endif
+#else
+#define TS_LAZY_STATE_INVALID -1
+#endif
+
 #ifndef __ASSEMBLY__
 #include <linux/compiler.h>
 
@@ -48,6 +58,7 @@
 
 #define spin_lock_prefetch(x)	prefetchw(x)
 
+#include <linux/call_single_data.h>
 #include <asm/ptrace.h>
 #include <asm/types.h>
 
@@ -109,7 +120,6 @@
 
 /* Lazy FPU handling on uni-processor */
 extern struct task_struct *last_task_used_math;
-extern struct task_struct *last_task_used_altivec;
 extern struct task_struct *last_task_used_vsx;
 extern struct task_struct *last_task_used_spe;
 
@@ -177,6 +187,14 @@
 #define TS_VSRLOWOFFSET 1
 #define TS_FPR(i) fpr[i][TS_FPROFFSET]
 
+#ifdef CONFIG_PPC64
+#define TS_LAZY_STATE_TYPE struct paca_struct *
+#define TS_LAZY_STATE_INVALID NULL
+#else
+#define TS_LAZY_STATE_TYPE unsigned long
+#define TS_LAZY_STATE_INVALID -1
+#endif
+
 struct thread_struct {
 	unsigned long	ksp;		/* Kernel stack pointer */
 	unsigned long	ksp_limit;	/* if ksp <= ksp_limit stack overflow */
@@ -253,6 +271,8 @@
 	/* AltiVec status */
 	vector128	vscr __attribute__((aligned(16)));
 	unsigned long	vrsave;
+	TS_LAZY_STATE_TYPE vr_state;	/* where my vr state is */
+	struct call_single_data vr_csd;	/* IPI data structure */
 	int		used_vr;	/* set if process has used altivec */
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
Index: linux-lazy/arch/powerpc/include/asm/reg.h
===================================================================
--- linux-lazy.orig/arch/powerpc/include/asm/reg.h
+++ linux-lazy/arch/powerpc/include/asm/reg.h
@@ -808,6 +808,15 @@
 
 #define __is_processor(pv)	(PVR_VER(mfspr(SPRN_PVR)) == (pv))
 
+#ifdef CONFIG_PPC64
+#define GET_CURRENT_THREAD(reg)			\
+	ld	(reg),PACACURRENT(r13) ;	\
+	addi    (reg),(reg),THREAD
+#else
+#define GET_CURRENT_THREAD(reg)			\
+	mfspr	(reg),SPRN_SPRG_THREAD
+#endif
+
 /*
  * IBM has further subdivided the standard PowerPC 16-bit version and
  * revision subfields of the PVR for the PowerPC 403s into the following:
Index: linux-lazy/arch/powerpc/include/asm/system.h
===================================================================
--- linux-lazy.orig/arch/powerpc/include/asm/system.h
+++ linux-lazy/arch/powerpc/include/asm/system.h
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/irqflags.h>
 
+#include <asm/irqflags.h>
 #include <asm/hw_irq.h>
 
 /*
@@ -145,7 +146,8 @@
 extern void enable_kernel_fp(void);
 extern void flush_fp_to_thread(struct task_struct *);
 extern void enable_kernel_altivec(void);
-extern void giveup_altivec(struct task_struct *);
+extern void giveup_altivec(unsigned long offset);
+extern void giveup_altivec_ipi(void *);
 extern void load_up_altivec(struct task_struct *);
 extern int emulate_altivec(struct pt_regs *);
 extern void __giveup_vsx(struct task_struct *);
@@ -157,13 +159,7 @@
 extern void cvt_fd(float *from, double *to);
 extern void cvt_df(double *from, float *to);
 
-#ifndef CONFIG_SMP
 extern void discard_lazy_cpu_state(void);
-#else
-static inline void discard_lazy_cpu_state(void)
-{
-}
-#endif
 
 #ifdef CONFIG_ALTIVEC
 extern void flush_altivec_to_thread(struct task_struct *);
Index: linux-lazy/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-lazy.orig/arch/powerpc/kernel/asm-offsets.c
+++ linux-lazy/arch/powerpc/kernel/asm-offsets.c
@@ -89,6 +89,7 @@
 	DEFINE(THREAD_VRSAVE, offsetof(struct thread_struct, vrsave));
 	DEFINE(THREAD_VSCR, offsetof(struct thread_struct, vscr));
 	DEFINE(THREAD_USED_VR, offsetof(struct thread_struct, used_vr));
+	DEFINE(THREAD_VR_STATE, offsetof(struct thread_struct, vr_state));
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
 	DEFINE(THREAD_VSR0, offsetof(struct thread_struct, fpr));
@@ -197,6 +198,9 @@
 	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
 	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
 	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
+#ifdef CONFIG_ALTIVEC
+	DEFINE(PACA_LAST_USED_ALTIVEC, offsetof(struct paca_struct, last_used_altivec));
+#endif
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 	DEFINE(PACA_KVM_SVCPU, offsetof(struct paca_struct, shadow_vcpu));
 	DEFINE(SVCPU_SLB, offsetof(struct kvmppc_book3s_shadow_vcpu, slb));
Index: linux-lazy/arch/powerpc/kernel/paca.c
===================================================================
--- linux-lazy.orig/arch/powerpc/kernel/paca.c
+++ linux-lazy/arch/powerpc/kernel/paca.c
@@ -162,6 +162,9 @@
 	new_paca->hw_cpu_id = 0xffff;
 	new_paca->kexec_state = KEXEC_STATE_NONE;
 	new_paca->__current = &init_task;
+#ifdef CONFIG_ALTIVEC
+	new_paca->last_used_altivec = NULL;
+#endif
 #ifdef CONFIG_PPC_STD_MMU_64
 	new_paca->slb_shadow_ptr = &slb_shadow[cpu];
 #endif /* CONFIG_PPC_STD_MMU_64 */
Index: linux-lazy/arch/powerpc/kernel/process.c
===================================================================
--- linux-lazy.orig/arch/powerpc/kernel/process.c
+++ linux-lazy/arch/powerpc/kernel/process.c
@@ -59,7 +59,6 @@
 
 #ifndef CONFIG_SMP
 struct task_struct *last_task_used_math = NULL;
-struct task_struct *last_task_used_altivec = NULL;
 struct task_struct *last_task_used_vsx = NULL;
 struct task_struct *last_task_used_spe = NULL;
 #endif
@@ -117,14 +116,7 @@
 {
 	WARN_ON(preemptible());
 
-#ifdef CONFIG_SMP
-	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC))
-		giveup_altivec(current);
-	else
-		giveup_altivec(NULL);	/* just enable AltiVec for kernel - force */
-#else
-	giveup_altivec(last_task_used_altivec);
-#endif /* CONFIG_SMP */
+	giveup_altivec(0);
 }
 EXPORT_SYMBOL(enable_kernel_altivec);
 
@@ -134,16 +126,7 @@
  */
 void flush_altivec_to_thread(struct task_struct *tsk)
 {
-	if (tsk->thread.regs) {
-		preempt_disable();
-		if (tsk->thread.regs->msr & MSR_VEC) {
-#ifdef CONFIG_SMP
-			BUG_ON(tsk != current);
-#endif
-			giveup_altivec(tsk);
-		}
-		preempt_enable();
-	}
+	giveup_altivec(0);
 }
 #endif /* CONFIG_ALTIVEC */
 
@@ -169,7 +152,7 @@
 void giveup_vsx(struct task_struct *tsk)
 {
 	giveup_fpu(tsk);
-	giveup_altivec(tsk);
+	giveup_altivec(0);
 	__giveup_vsx(tsk);
 }
 
@@ -220,7 +203,6 @@
 }
 #endif /* CONFIG_SPE */
 
-#ifndef CONFIG_SMP
 /*
  * If we are doing lazy switching of CPU state (FP, altivec or SPE),
  * and the current task has some state, discard it.
@@ -228,12 +210,12 @@
 void discard_lazy_cpu_state(void)
 {
 	preempt_disable();
-	if (last_task_used_math == current)
-		last_task_used_math = NULL;
 #ifdef CONFIG_ALTIVEC
-	if (last_task_used_altivec == current)
-		last_task_used_altivec = NULL;
+	giveup_altivec(0);
 #endif /* CONFIG_ALTIVEC */
+#ifndef CONFIG_SMP
+	if (last_task_used_math == current)
+		last_task_used_math = NULL;
 #ifdef CONFIG_VSX
 	if (last_task_used_vsx == current)
 		last_task_used_vsx = NULL;
@@ -242,9 +224,9 @@
 	if (last_task_used_spe == current)
 		last_task_used_spe = NULL;
 #endif
+#endif /* CONFIG_SMP */
 	preempt_enable();
 }
-#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 void do_send_trap(struct pt_regs *regs, unsigned long address,
@@ -386,6 +368,78 @@
 #ifdef CONFIG_PPC64
 DEFINE_PER_CPU(struct cpu_usage, cpu_usage_array);
 #endif
+#ifdef CONFIG_PPC64
+#define LAZY_STATE_HERE (get_paca())
+#define LAZY_STATE_CPU_ID (state->hw_cpu_id)
+#else
+#define LAZY_STATE_HERE (smp_processor_id())
+#define LAZY_STATE_CPU_ID (state)
+#endif
+
+extern int csd_locked(struct call_single_data *data);
+
+#ifdef CONFIG_ALTIVEC
+/* Return value indicates if it was lazy or not */
+static bool switch_to_altivec_lazy(struct task_struct *prev,
+				   struct task_struct *new)
+{
+	/*
+	 * At this point the Altivec reg state can be in 1 of 3 places
+	 * 1) cached on _this_ CPU.   Lazy/fast  :-)
+	 * 2) in the thread_struct.   Normal     :-|
+	 * 3) cached on another CPU.  Slow IPI   :-(
+         * .... lets go workout what happened....
+	 */
+
+	/* Cache the state pointer here incase it changes */
+	TS_LAZY_STATE_TYPE state = new->thread.vr_state;
+
+	/* Is the state here? */
+	if (state == LAZY_STATE_HERE) {
+		/* It's here! Excellent, simply turn VMX on */
+		new->thread.regs->msr |= MSR_VEC;
+		return true;
+	}
+	/*
+	 * If we have used VMX in the past, but don't have lazy state,
+	 * then make sure we turn off VMX.  load_up_altivec will deal
+	 * with saving the lazy state if we run a VMX instruction
+	 */
+	new->thread.regs->msr &= ~MSR_VEC;
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
+		 * multiple times, but giveup_altivec can handle this.
+		 */
+		if (!csd_locked(&(new->thread.vr_csd)))
+			__smp_call_function_single(
+				LAZY_STATE_CPU_ID,
+				&(new->thread.vr_csd),
+				0);
+#else /* CONFIG_SMP */
+		/* UP can't have state on another CPU */
+		BUG();
+#endif
+
+	}
+	return false;
+}
+#else /* CONFIG_ALTIVEC */
+static bool switch_to_altivec_lazy(struct task_struct *prev,
+				  struct task_struct *new)
+{
+	return true;
+}
+#endif /* CONFIG_ALTIVEC */
 
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
@@ -393,6 +447,12 @@
 	struct thread_struct *new_thread, *old_thread;
 	unsigned long flags;
 	struct task_struct *last;
+	int lazy = 1;
+
+	/* Does next have lazy state somewhere? */
+	if (new->thread.regs) {
+		lazy &= switch_to_altivec_lazy(prev, new);
+	}
 
 #ifdef CONFIG_SMP
 	/* avoid complexity of lazy save/restore of fpu
@@ -406,21 +466,6 @@
 	 */
 	if (prev->thread.regs && (prev->thread.regs->msr & MSR_FP))
 		giveup_fpu(prev);
-#ifdef CONFIG_ALTIVEC
-	/*
-	 * If the previous thread used altivec in the last quantum
-	 * (thus changing altivec regs) then save them.
-	 * We used to check the VRSAVE register but not all apps
-	 * set it, so we don't rely on it now (and in fact we need
-	 * to save & restore VSCR even if VRSAVE == 0).  -- paulus
-	 *
-	 * On SMP we always save/restore altivec regs just to avoid the
-	 * complexity of changing processors.
-	 *  -- Cort
-	 */
-	if (prev->thread.regs && (prev->thread.regs->msr & MSR_VEC))
-		giveup_altivec(prev);
-#endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
 	if (prev->thread.regs && (prev->thread.regs->msr & MSR_VSX))
 		/* VMX and FPU registers are already save here */
@@ -439,13 +484,6 @@
 #endif /* CONFIG_SPE */
 
 #else  /* CONFIG_SMP */
-#ifdef CONFIG_ALTIVEC
-	/* Avoid the trap.  On smp this this never happens since
-	 * we don't set last_task_used_altivec -- Cort
-	 */
-	if (new->thread.regs && last_task_used_altivec == new)
-		new->thread.regs->msr |= MSR_VEC;
-#endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
 	if (new->thread.regs && last_task_used_vsx == new)
 		new->thread.regs->msr |= MSR_VSX;
@@ -862,6 +900,10 @@
 	current->thread.vscr.u[3] = 0x00010000; /* Java mode disabled */
 	current->thread.vrsave = 0;
 	current->thread.used_vr = 0;
+	current->thread.vr_state = TS_LAZY_STATE_INVALID;
+	current->thread.vr_csd.func = giveup_altivec_ipi;
+	current->thread.vr_csd.info = 0;
+	current->thread.vr_csd.flags = 0;
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_SPE
 	memset(current->thread.evr, 0, sizeof(current->thread.evr));
Index: linux-lazy/arch/powerpc/kernel/vector.S
===================================================================
--- linux-lazy.orig/arch/powerpc/kernel/vector.S
+++ linux-lazy/arch/powerpc/kernel/vector.S
@@ -5,7 +5,29 @@
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
+#include <asm/exception-64s.h>
+#include <linux/threads.h>
 
+#ifdef CONFIG_PPC32
+	.section .bss
+	.align	4
+last_used_altivec:
+	.space	4*NR_CPUS
+	.previous
+/*
+ * Get the last_used_altivec pointer for this cpu.
+ * Pointer ends up in register n.  offset in a, volotile scratch in b
+ */
+#define LAST_USED_ALTIVEC_PTR(n, a, b)		\
+	rlwinm	b,r1,0,0,(31-THREAD_SHIFT) ;	\
+        sub     b,b,a	;			\
+	lwz	b,TI_CPU(b) ;			\
+	slwi	b,b,2	    ;			\
+	lis	n,last_used_altivec@ha ;	\
+	addi	n,n,last_used_altivec@l	;	\
+	sub	n,n,b			;	\
+	add	n,n,b
+#endif
 /*
  * load_up_altivec(unused, unused, tsk)
  * Disable VMX for the task which had it previously,
@@ -20,38 +42,98 @@
 	MTMSRD(r5)			/* enable use of AltiVec now */
 	isync
 
+	mflr	r10
+#ifdef CONFIG_PPC32
+	lis	r3, PAGE_OFFSET@h
+#endif
+	bl	giveup_altivec_msr_done
 /*
- * For SMP, we don't do lazy VMX switching because it just gets too
- * horrendously complex, especially when a task switches from one CPU
- * to another.  Instead we call giveup_altvec in switch_to.
- * VRSAVE isn't dealt with here, that is done in the normal context
- * switch code. Note that we could rely on vrsave value to eventually
- * avoid saving all of the VREGs here...
+ * lazy restore:
+ * 	If we are doing lazy restore we enter here either:
+ * 	1. never done vmx before
+ * 	2. done vmx and state is in our thread_struct
+ * 	3. done vmx and but state is being flushed via an IPI
  */
-#ifndef CONFIG_SMP
-	LOAD_REG_ADDRBASE(r3, last_task_used_altivec)
-	toreal(r3)
-	PPC_LL	r4,ADDROFF(last_task_used_altivec)(r3)
-	PPC_LCMPI	0,r4,0
-	beq	1f
+	GET_CURRENT_THREAD(r5)
+	lwz 	r4,THREAD_USED_VR(r5)
+	PPC_LCMPI	cr0,r4,0 /* we've not used vmx before */
+	beq	4f
+
+	/*
+         * Spin here waiting for IPI to finish.  Once the data is in
+	 * our thread_struct, vr_state will be null:
+	 *
+	 * First quickly check to see if data has been flushed from
+	 * another CPU yet (as it's likely the IPI has completed)
+	 */
+5:
+	PPC_LL	r4,THREAD_VR_STATE(r5)
+	PPC_LCMPI	0,r4,TS_LAZY_STATE_INVALID
+	beq+	3f /* it's likely the data is already here */
+	/*
+	* Bugger, the IPI has not completed.  Let's spin here waiting
+	* for it, but we should turn on IRQ incase someone is wait for
+	* us for something.
+	 */
 
-	/* Save VMX state to last_task_used_altivec's THREAD struct */
-	toreal(r4)
-	addi	r4,r4,THREAD
-	SAVE_32VRS(0,r5,r4)
-	mfvscr	vr0
-	li	r10,THREAD_VSCR
-	stvx	vr0,r10,r4
-	/* Disable VMX for last_task_used_altivec */
-	PPC_LL	r5,PT_REGS(r4)
-	toreal(r5)
-	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	lis	r10,MSR_VEC@h
-	andc	r4,r4,r10
-	PPC_STL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
-#endif /* CONFIG_SMP */
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
+	PPC_LL  r4,THREAD_VR_STATE(r5)
+	PPC_LCMPI	0,r4,TS_LAZY_STATE_INVALID
+	bne     2b
 
+	/* disable irqs and enable vec again */
+#ifdef CONFIG_PPC32
+	mfmsr	r4
+	oris	r4,r4,MSR_VEC@h
+	xori	r4,r4,MSR_EE
+	MTMSRD(r4)
+#else
+	mfmsr   r11
+	oris    r11,r11,MSR_VEC@h
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
+        bl      giveup_altivec_msr_done
+3:
+	LWSYNC /* make sure VMX registers are in memory */
+4:
+	mtlr	r10
+	/* setup lazy pointers */
+	GET_CURRENT_THREAD(r5)
+#ifdef CONFIG_PPC64
+	PPC_STL	r13,THREAD_VR_STATE(r5)
+#else
+	/* get the cpuid */
+	lis	r6,PAGE_OFFSET@h
+	rlwinm  r7,r1,0,0,(31-THREAD_SHIFT)
+	sub     r7,r7,r6
+	lwz     r7,TI_CPU(r7)
+	PPC_STL	r7,THREAD_VR_STATE(r5) /* write the cpuid */
+#endif
+	subi	r4, r5, THREAD
+#ifdef CONFIG_PPC64
+	PPC_STL	r4,PACA_LAST_USED_ALTIVEC(r13)
+#else
+/*	lis	r6,PAGE_OFFSET@h */
+	LAST_USED_ALTIVEC_PTR(r3, r6, r7)
+	PPC_STL	r4,0(r3)
+#endif
 	/* Hack: if we get an altivec unavailable trap with VRSAVE
 	 * set to all zeros, we assume this is a broken application
 	 * that fails to set it properly, and thus we switch it to
@@ -65,11 +147,8 @@
 1:
 	/* enable use of VMX after return */
 #ifdef CONFIG_PPC32
-	mfspr	r5,SPRN_SPRG_THREAD		/* current task's THREAD (phys) */
 	oris	r9,r9,MSR_VEC@h
 #else
-	ld	r4,PACACURRENT(r13)
-	addi	r5,r4,THREAD		/* Get THREAD */
 	oris	r12,r12,MSR_VEC@h
 	std	r12,_MSR(r1)
 #endif
@@ -79,29 +158,41 @@
 	lvx	vr0,r10,r5
 	mtvscr	vr0
 	REST_32VRS(0,r4,r5)
-#ifndef CONFIG_SMP
-	/* Update last_task_used_altivec to 'current' */
-	subi	r4,r5,THREAD		/* Back to 'current' */
-	fromreal(r4)
-	PPC_STL	r4,ADDROFF(last_task_used_altivec)(r3)
-#endif /* CONFIG_SMP */
 	/* restore registers and return */
 	blr
-
 /*
- * giveup_altivec(tsk)
- * Disable VMX for the task given as the argument,
- * and save the vector registers in its thread_struct.
+ * giveup_altivec(offset)
+ * Disable VMX for the task currently using vmx and and save the
+ * vector registers in its thread_struct.
  * Enables the VMX for use in the kernel on return.
  */
+_GLOBAL(giveup_altivec_ipi)
 _GLOBAL(giveup_altivec)
 	mfmsr	r5
 	oris	r5,r5,MSR_VEC@h
 	SYNC
 	MTMSRD(r5)			/* enable use of VMX now */
 	isync
+
+giveup_altivec_msr_done:
+#ifdef CONFIG_PPC64
+	PPC_LL	r3,PACA_LAST_USED_ALTIVEC(r13)
+#else
+	mr	r7, r3
+	LAST_USED_ALTIVEC_PTR(r4, r7, r5)
+	PPC_LL	r3,0(r4) /* phys address */
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
 	addi	r3,r3,THREAD		/* want THREAD of task */
 	PPC_LL	r5,PT_REGS(r3)
 	PPC_LCMPI	0,r5,0
@@ -110,6 +201,9 @@
 	li	r4,THREAD_VSCR
 	stvx	vr0,r4,r3
 	beq	1f
+#ifdef CONFIG_PPC32
+	sub	r5, r5, r7
+#endif
 	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 #ifdef CONFIG_VSX
 BEGIN_FTR_SECTION
@@ -120,14 +214,25 @@
 #else
 	lis	r3,MSR_VEC@h
 #endif
-	andc	r4,r4,r3		/* disable FP for previous task */
+	andc	r4,r4,r3		/* disable vmx for previous task */
 	PPC_STL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 1:
-#ifndef CONFIG_SMP
+	/*
+	 * If this is an ipi, make sure state is is commited before we
+	 * clear the lazy state pointers and return.  If a CPU is waiting on
+	 * this data (IPI case) then it won't start until VR_STATE is cleared
+	 */
+	LWSYNC /* make sure registers are in mem before say they are */
+	li	r5,TS_LAZY_STATE_INVALID
+	PPC_STL	r5,THREAD+THREAD_VR_STATE(r6)
 	li	r5,0
-	LOAD_REG_ADDRBASE(r4,last_task_used_altivec)
-	PPC_STL	r5,ADDROFF(last_task_used_altivec)(r4)
-#endif /* CONFIG_SMP */
+#ifdef CONFIG_PPC64
+	PPC_STL	r5,PACA_LAST_USED_ALTIVEC(r13)
+#else
+	LAST_USED_ALTIVEC_PTR(r3, r7, r4)
+	PPC_STL	r5,0(r3)
+#endif
+	LWSYNC
 	blr
 
 #ifdef CONFIG_VSX
Index: linux-lazy/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- linux-lazy.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ linux-lazy/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -112,6 +112,7 @@
 
 	local_irq_disable();
 	idle_task_exit();
+	discard_lazy_cpu_state();
 	xics_teardown_cpu();
 
 	if (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {

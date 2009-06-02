Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 02 Jun 2009 17:50:03 +1000
Subject: [PATCH 1/5] powerpc: Move VMX and VSX asm code to vector.S
In-Reply-To: <1243929002.876045.46197476176.qpush@grosgo>
Message-Id: <20090602075017.1E159DDDF4@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, load_up_altivec and give_up_altivec are duplicated
in 32-bit and 64-bit. This creates a common implementation that
is moved away from head_32.S, head_64.S and misc_64.S and into
vector.S, using the same macros we already use for our common
implementation of load_up_fpu.

I also moved the VSX code over to vector.S though in that case
I didn't make it build on 32-bit (yet).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/Makefile         |    1 
 arch/powerpc/kernel/Makefile  |    3 
 arch/powerpc/kernel/head_32.S |   95 -------------------
 arch/powerpc/kernel/head_64.S |  118 -----------------------
 arch/powerpc/kernel/misc_64.S |   92 ------------------
 arch/powerpc/kernel/vector.S  |  210 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 213 insertions(+), 306 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/vector.S	2009-06-02 15:37:39.000000000 +1000
+++ linux-work/arch/powerpc/kernel/vector.S	2009-06-02 16:22:03.000000000 +1000
@@ -1,5 +1,215 @@
+#include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/reg.h>
+#include <asm/asm-offsets.h>
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/page.h>
+
+/*
+ * load_up_altivec(unused, unused, tsk)
+ * Disable VMX for the task which had it previously,
+ * and save its vector registers in its thread_struct.
+ * Enables the VMX for use in the kernel on return.
+ * On SMP we know the VMX is free, since we give it up every
+ * switch (ie, no lazy save of the vector registers).
+ */
+_GLOBAL(load_up_altivec)
+	mfmsr	r5			/* grab the current MSR */
+	oris	r5,r5,MSR_VEC@h
+	MTMSRD(r5)			/* enable use of AltiVec now */
+	isync
+
+/*
+ * For SMP, we don't do lazy VMX switching because it just gets too
+ * horrendously complex, especially when a task switches from one CPU
+ * to another.  Instead we call giveup_altvec in switch_to.
+ * VRSAVE isn't dealt with here, that is done in the normal context
+ * switch code. Note that we could rely on vrsave value to eventually
+ * avoid saving all of the VREGs here...
+ */
+#ifndef CONFIG_SMP
+	LOAD_REG_ADDRBASE(r3, last_task_used_altivec)
+	toreal(r3)
+	PPC_LL	r4,ADDROFF(last_task_used_altivec)(r3)
+	PPC_LCMPI	0,r4,0
+	beq	1f
+
+	/* Save VMX state to last_task_used_altivec's THREAD struct */
+	toreal(r4)
+	addi	r4,r4,THREAD
+	SAVE_32VRS(0,r5,r4)
+	mfvscr	vr0
+	li	r10,THREAD_VSCR
+	stvx	vr0,r10,r4
+	/* Disable VMX for last_task_used_altivec */
+	PPC_LL	r5,PT_REGS(r4)
+	toreal(r5)
+	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+	lis	r10,MSR_VEC@h
+	andc	r4,r4,r10
+	PPC_STL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+1:
+#endif /* CONFIG_SMP */
+
+	/* Hack: if we get an altivec unavailable trap with VRSAVE
+	 * set to all zeros, we assume this is a broken application
+	 * that fails to set it properly, and thus we switch it to
+	 * all 1's
+	 */
+	mfspr	r4,SPRN_VRSAVE
+	cmpdi	0,r4,0
+	bne+	1f
+	li	r4,-1
+	mtspr	SPRN_VRSAVE,r4
+1:
+	/* enable use of VMX after return */
+#ifdef CONFIG_PPC32
+	mfspr	r5,SPRN_SPRG3		/* current task's THREAD (phys) */
+	oris	r9,r9,MSR_VEC@h
+#else
+	ld	r4,PACACURRENT(r13)
+	addi	r5,r4,THREAD		/* Get THREAD */
+	oris	r12,r12,MSR_VEC@h
+	std	r12,_MSR(r1)
+#endif
+	li	r4,1
+	li	r10,THREAD_VSCR
+	stw	r4,THREAD_USED_VR(r5)
+	lvx	vr0,r10,r5
+	mtvscr	vr0
+	REST_32VRS(0,r4,r5)
+#ifndef CONFIG_SMP
+	/* Update last_task_used_math to 'current' */
+	subi	r4,r5,THREAD		/* Back to 'current' */
+	fromreal(r4)
+	PPC_STL	r4,ADDROFF(last_task_used_math)(r3)
+#endif /* CONFIG_SMP */
+	/* restore registers and return */
+	blr
+
+/*
+ * giveup_altivec(tsk)
+ * Disable VMX for the task given as the argument,
+ * and save the vector registers in its thread_struct.
+ * Enables the VMX for use in the kernel on return.
+ */
+_GLOBAL(giveup_altivec)
+	mfmsr	r5
+	oris	r5,r5,MSR_VEC@h
+	SYNC
+	MTMSRD(r5)			/* enable use of VMX now */
+	isync
+	PPC_LCMPI	0,r3,0
+	beqlr-				/* if no previous owner, done */
+	addi	r3,r3,THREAD		/* want THREAD of task */
+	PPC_LL	r5,PT_REGS(r3)
+	PPC_LCMPI	0,r5,0
+	SAVE_32VRS(0,r4,r3)
+	mfvscr	vr0
+	li	r4,THREAD_VSCR
+	stvx	vr0,r4,r3
+	beq	1f
+	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+#ifdef CONFIG_VSX
+BEGIN_FTR_SECTION
+	lis	r3,(MSR_VEC|MSR_VSX)@h
+FTR_SECTION_ELSE
+	lis	r3,MSR_VEC@h
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_VSX)
+#else
+ 	lis	r3,MSR_VEC@h
+#endif
+	andc	r4,r4,r3		/* disable FP for previous task */
+	PPC_STL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+1:
+#ifndef CONFIG_SMP
+	li	r5,0
+	LOAD_REG_ADDRBASE(r4,last_task_used_altivec)
+	PPC_STL	r5,ADDROFF(last_task_used_altivec)(r4)
+#endif /* CONFIG_SMP */
+	blr
+
+#ifdef CONFIG_VSX
+
+#ifdef CONFIG_PPC32
+#error This asm code isn't ready for 32-bit kernels
+#endif
+
+/*
+ * load_up_vsx(unused, unused, tsk)
+ * Disable VSX for the task which had it previously,
+ * and save its vector registers in its thread_struct.
+ * Reuse the fp and vsx saves, but first check to see if they have
+ * been saved already.
+ */
+_GLOBAL(load_up_vsx)
+/* Load FP and VSX registers if they haven't been done yet */
+	andi.	r5,r12,MSR_FP
+	beql+	load_up_fpu		/* skip if already loaded */
+	andis.	r5,r12,MSR_VEC@h
+	beql+	load_up_altivec		/* skip if already loaded */
+
+#ifndef CONFIG_SMP
+	ld	r3,last_task_used_vsx@got(r2)
+	ld	r4,0(r3)
+	cmpdi	0,r4,0
+	beq	1f
+	/* Disable VSX for last_task_used_vsx */
+	addi	r4,r4,THREAD
+	ld	r5,PT_REGS(r4)
+	ld	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+	lis	r6,MSR_VSX@h
+	andc	r6,r4,r6
+	std	r6,_MSR-STACK_FRAME_OVERHEAD(r5)
+1:
+#endif /* CONFIG_SMP */
+	ld	r4,PACACURRENT(r13)
+	addi	r4,r4,THREAD		/* Get THREAD */
+	li	r6,1
+	stw	r6,THREAD_USED_VSR(r4) /* ... also set thread used vsr */
+	/* enable use of VSX after return */
+	oris	r12,r12,MSR_VSX@h
+	std	r12,_MSR(r1)
+#ifndef CONFIG_SMP
+	/* Update last_task_used_math to 'current' */
+	ld	r4,PACACURRENT(r13)
+	std	r4,0(r3)
+#endif /* CONFIG_SMP */
+	b	fast_exception_return
+
+/*
+ * __giveup_vsx(tsk)
+ * Disable VSX for the task given as the argument.
+ * Does NOT save vsx registers.
+ * Enables the VSX for use in the kernel on return.
+ */
+_GLOBAL(__giveup_vsx)
+	mfmsr	r5
+	oris	r5,r5,MSR_VSX@h
+	mtmsrd	r5			/* enable use of VSX now */
+	isync
+
+	cmpdi	0,r3,0
+	beqlr-				/* if no previous owner, done */
+	addi	r3,r3,THREAD		/* want THREAD of task */
+	ld	r5,PT_REGS(r3)
+	cmpdi	0,r5,0
+	beq	1f
+	ld	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+	lis	r3,MSR_VSX@h
+	andc	r4,r4,r3		/* disable VSX for previous task */
+	std	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+1:
+#ifndef CONFIG_SMP
+	li	r5,0
+	ld	r4,last_task_used_vsx@got(r2)
+	std	r5,0(r4)
+#endif /* CONFIG_SMP */
+	blr
+
+#endif /* CONFIG_VSX */
+
 
 /*
  * The routines below are in assembler so we can closely control the
Index: linux-work/arch/powerpc/kernel/head_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_32.S	2009-06-02 15:37:39.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_32.S	2009-06-02 15:38:31.000000000 +1000
@@ -743,101 +743,6 @@ PerformanceMonitor:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_STD(0xf00, performance_monitor_exception)
 
-#ifdef CONFIG_ALTIVEC
-/* Note that the AltiVec support is closely modeled after the FP
- * support.  Changes to one are likely to be applicable to the
- * other!  */
-load_up_altivec:
-/*
- * Disable AltiVec for the task which had AltiVec previously,
- * and save its AltiVec registers in its thread_struct.
- * Enables AltiVec for use in the kernel on return.
- * On SMP we know the AltiVec units are free, since we give it up every
- * switch.  -- Kumar
- */
-	mfmsr	r5
-	oris	r5,r5,MSR_VEC@h
-	MTMSRD(r5)			/* enable use of AltiVec now */
-	isync
-/*
- * For SMP, we don't do lazy AltiVec switching because it just gets too
- * horrendously complex, especially when a task switches from one CPU
- * to another.  Instead we call giveup_altivec in switch_to.
- */
-#ifndef CONFIG_SMP
-	tophys(r6,0)
-	addis	r3,r6,last_task_used_altivec@ha
-	lwz	r4,last_task_used_altivec@l(r3)
-	cmpwi	0,r4,0
-	beq	1f
-	add	r4,r4,r6
-	addi	r4,r4,THREAD	/* want THREAD of last_task_used_altivec */
-	SAVE_32VRS(0,r10,r4)
-	mfvscr	vr0
-	li	r10,THREAD_VSCR
-	stvx	vr0,r10,r4
-	lwz	r5,PT_REGS(r4)
-	add	r5,r5,r6
-	lwz	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	lis	r10,MSR_VEC@h
-	andc	r4,r4,r10	/* disable altivec for previous task */
-	stw	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
-#endif /* CONFIG_SMP */
-	/* enable use of AltiVec after return */
-	oris	r9,r9,MSR_VEC@h
-	mfspr	r5,SPRN_SPRG3		/* current task's THREAD (phys) */
-	li	r4,1
-	li	r10,THREAD_VSCR
-	stw	r4,THREAD_USED_VR(r5)
-	lvx	vr0,r10,r5
-	mtvscr	vr0
-	REST_32VRS(0,r10,r5)
-#ifndef CONFIG_SMP
-	subi	r4,r5,THREAD
-	sub	r4,r4,r6
-	stw	r4,last_task_used_altivec@l(r3)
-#endif /* CONFIG_SMP */
-	/* restore registers and return */
-	/* we haven't used ctr or xer or lr */
-	b	fast_exception_return
-
-/*
- * giveup_altivec(tsk)
- * Disable AltiVec for the task given as the argument,
- * and save the AltiVec registers in its thread_struct.
- * Enables AltiVec for use in the kernel on return.
- */
-
-	.globl	giveup_altivec
-giveup_altivec:
-	mfmsr	r5
-	oris	r5,r5,MSR_VEC@h
-	SYNC
-	MTMSRD(r5)			/* enable use of AltiVec now */
-	isync
-	cmpwi	0,r3,0
-	beqlr-				/* if no previous owner, done */
-	addi	r3,r3,THREAD		/* want THREAD of task */
-	lwz	r5,PT_REGS(r3)
-	cmpwi	0,r5,0
-	SAVE_32VRS(0, r4, r3)
-	mfvscr	vr0
-	li	r4,THREAD_VSCR
-	stvx	vr0,r4,r3
-	beq	1f
-	lwz	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	lis	r3,MSR_VEC@h
-	andc	r4,r4,r3		/* disable AltiVec for previous task */
-	stw	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
-#ifndef CONFIG_SMP
-	li	r5,0
-	lis	r4,last_task_used_altivec@ha
-	stw	r5,last_task_used_altivec@l(r4)
-#endif /* CONFIG_SMP */
-	blr
-#endif /* CONFIG_ALTIVEC */
 
 /*
  * This code is jumped to from the startup code to copy
Index: linux-work/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_64.S	2009-06-02 15:37:39.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_64.S	2009-06-02 17:13:42.000000000 +1000
@@ -844,124 +844,6 @@ unrecov_fer:
 	bl	.unrecoverable_exception
 	b	1b
 
-#ifdef CONFIG_ALTIVEC
-/*
- * load_up_altivec(unused, unused, tsk)
- * Disable VMX for the task which had it previously,
- * and save its vector registers in its thread_struct.
- * Enables the VMX for use in the kernel on return.
- * On SMP we know the VMX is free, since we give it up every
- * switch (ie, no lazy save of the vector registers).
- * On entry: r13 == 'current' && last_task_used_altivec != 'current'
- */
-_STATIC(load_up_altivec)
-	mfmsr	r5			/* grab the current MSR */
-	oris	r5,r5,MSR_VEC@h
-	mtmsrd	r5			/* enable use of VMX now */
-	isync
-
-/*
- * For SMP, we don't do lazy VMX switching because it just gets too
- * horrendously complex, especially when a task switches from one CPU
- * to another.  Instead we call giveup_altvec in switch_to.
- * VRSAVE isn't dealt with here, that is done in the normal context
- * switch code. Note that we could rely on vrsave value to eventually
- * avoid saving all of the VREGs here...
- */
-#ifndef CONFIG_SMP
-	ld	r3,last_task_used_altivec@got(r2)
-	ld	r4,0(r3)
-	cmpdi	0,r4,0
-	beq	1f
-	/* Save VMX state to last_task_used_altivec's THREAD struct */
-	addi	r4,r4,THREAD
-	SAVE_32VRS(0,r5,r4)
-	mfvscr	vr0
-	li	r10,THREAD_VSCR
-	stvx	vr0,r10,r4
-	/* Disable VMX for last_task_used_altivec */
-	ld	r5,PT_REGS(r4)
-	ld	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	lis	r6,MSR_VEC@h
-	andc	r4,r4,r6
-	std	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
-#endif /* CONFIG_SMP */
-	/* Hack: if we get an altivec unavailable trap with VRSAVE
-	 * set to all zeros, we assume this is a broken application
-	 * that fails to set it properly, and thus we switch it to
-	 * all 1's
-	 */
-	mfspr	r4,SPRN_VRSAVE
-	cmpdi	0,r4,0
-	bne+	1f
-	li	r4,-1
-	mtspr	SPRN_VRSAVE,r4
-1:
-	/* enable use of VMX after return */
-	ld	r4,PACACURRENT(r13)
-	addi	r5,r4,THREAD		/* Get THREAD */
-	oris	r12,r12,MSR_VEC@h
-	std	r12,_MSR(r1)
-	li	r4,1
-	li	r10,THREAD_VSCR
-	stw	r4,THREAD_USED_VR(r5)
-	lvx	vr0,r10,r5
-	mtvscr	vr0
-	REST_32VRS(0,r4,r5)
-#ifndef CONFIG_SMP
-	/* Update last_task_used_math to 'current' */
-	subi	r4,r5,THREAD		/* Back to 'current' */
-	std	r4,0(r3)
-#endif /* CONFIG_SMP */
-	/* restore registers and return */
-	blr
-#endif /* CONFIG_ALTIVEC */
-
-#ifdef CONFIG_VSX
-/*
- * load_up_vsx(unused, unused, tsk)
- * Disable VSX for the task which had it previously,
- * and save its vector registers in its thread_struct.
- * Reuse the fp and vsx saves, but first check to see if they have
- * been saved already.
- * On entry: r13 == 'current' && last_task_used_vsx != 'current'
- */
-_STATIC(load_up_vsx)
-/* Load FP and VSX registers if they haven't been done yet */
-	andi.	r5,r12,MSR_FP
-	beql+	load_up_fpu		/* skip if already loaded */
-	andis.	r5,r12,MSR_VEC@h
-	beql+	load_up_altivec		/* skip if already loaded */
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
-	li	r6,1
-	stw	r6,THREAD_USED_VSR(r4) /* ... also set thread used vsr */
-	/* enable use of VSX after return */
-	oris	r12,r12,MSR_VSX@h
-	std	r12,_MSR(r1)
-#ifndef CONFIG_SMP
-	/* Update last_task_used_math to 'current' */
-	ld	r4,PACACURRENT(r13)
-	std	r4,0(r3)
-#endif /* CONFIG_SMP */
-	b	fast_exception_return
-#endif /* CONFIG_VSX */
 
 /*
  * Hash table stuff
Index: linux-work/arch/powerpc/kernel/misc_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/misc_64.S	2009-06-02 15:37:39.000000000 +1000
+++ linux-work/arch/powerpc/kernel/misc_64.S	2009-06-02 15:38:31.000000000 +1000
@@ -457,98 +457,6 @@ _GLOBAL(disable_kernel_fp)
 	isync
 	blr
 
-#ifdef CONFIG_ALTIVEC
-
-#if 0 /* this has no callers for now */
-/*
- * disable_kernel_altivec()
- * Disable the VMX.
- */
-_GLOBAL(disable_kernel_altivec)
-	mfmsr	r3
-	rldicl	r0,r3,(63-MSR_VEC_LG),1
-	rldicl	r3,r0,(MSR_VEC_LG+1),0
-	mtmsrd	r3			/* disable use of VMX now */
-	isync
-	blr
-#endif /* 0 */
-
-/*
- * giveup_altivec(tsk)
- * Disable VMX for the task given as the argument,
- * and save the vector registers in its thread_struct.
- * Enables the VMX for use in the kernel on return.
- */
-_GLOBAL(giveup_altivec)
-	mfmsr	r5
-	oris	r5,r5,MSR_VEC@h
-	mtmsrd	r5			/* enable use of VMX now */
-	isync
-	cmpdi	0,r3,0
-	beqlr-				/* if no previous owner, done */
-	addi	r3,r3,THREAD		/* want THREAD of task */
-	ld	r5,PT_REGS(r3)
-	cmpdi	0,r5,0
-	SAVE_32VRS(0,r4,r3)
-	mfvscr	vr0
-	li	r4,THREAD_VSCR
-	stvx	vr0,r4,r3
-	beq	1f
-	ld	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-#ifdef CONFIG_VSX
-BEGIN_FTR_SECTION
-	lis	r3,(MSR_VEC|MSR_VSX)@h
-FTR_SECTION_ELSE
-	lis	r3,MSR_VEC@h
-ALT_FTR_SECTION_END_IFSET(CPU_FTR_VSX)
-#else
-	lis	r3,MSR_VEC@h
-#endif
-	andc	r4,r4,r3		/* disable FP for previous task */
-	std	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
-#ifndef CONFIG_SMP
-	li	r5,0
-	ld	r4,last_task_used_altivec@got(r2)
-	std	r5,0(r4)
-#endif /* CONFIG_SMP */
-	blr
-
-#endif /* CONFIG_ALTIVEC */
-
-#ifdef CONFIG_VSX
-/*
- * __giveup_vsx(tsk)
- * Disable VSX for the task given as the argument.
- * Does NOT save vsx registers.
- * Enables the VSX for use in the kernel on return.
- */
-_GLOBAL(__giveup_vsx)
-	mfmsr	r5
-	oris	r5,r5,MSR_VSX@h
-	mtmsrd	r5			/* enable use of VSX now */
-	isync
-
-	cmpdi	0,r3,0
-	beqlr-				/* if no previous owner, done */
-	addi	r3,r3,THREAD		/* want THREAD of task */
-	ld	r5,PT_REGS(r3)
-	cmpdi	0,r5,0
-	beq	1f
-	ld	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	lis	r3,MSR_VSX@h
-	andc	r4,r4,r3		/* disable VSX for previous task */
-	std	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
-#ifndef CONFIG_SMP
-	li	r5,0
-	ld	r4,last_task_used_vsx@got(r2)
-	std	r5,0(r4)
-#endif /* CONFIG_SMP */
-	blr
-
-#endif /* CONFIG_VSX */
-
 /* kexec_wait(phys_cpu)
  *
  * wait for the flag to change, indicating this kernel is going away but
Index: linux-work/arch/powerpc/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/Makefile	2009-06-02 17:17:26.000000000 +1000
+++ linux-work/arch/powerpc/Makefile	2009-06-02 17:17:36.000000000 +1000
@@ -142,6 +142,7 @@ head-$(CONFIG_FSL_BOOKE)	:= arch/powerpc
 
 head-$(CONFIG_PPC64)		+= arch/powerpc/kernel/entry_64.o
 head-$(CONFIG_PPC_FPU)		+= arch/powerpc/kernel/fpu.o
+head-$(CONFIG_ALTIVEC)		+= arch/powerpc/kernel/vector.o
 
 core-y				+= arch/powerpc/kernel/ \
 				   arch/powerpc/mm/ \
Index: linux-work/arch/powerpc/kernel/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/kernel/Makefile	2009-06-02 17:16:14.000000000 +1000
+++ linux-work/arch/powerpc/kernel/Makefile	2009-06-02 17:16:30.000000000 +1000
@@ -36,7 +36,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_p
 				   firmware.o nvram_64.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC64)		+= vdso64/
-obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
+obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
 obj-$(CONFIG_PPC_OF)		+= of_device.o of_platform.o prom_parse.o
 obj-$(CONFIG_PPC_CLOCK)		+= clock.o
@@ -108,6 +108,7 @@ obj-y				+= ppc_save_regs.o
 endif
 
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
+extra-$(CONFIG_ALTIVEC)		+= vector.o
 extra-$(CONFIG_PPC64)		+= entry_64.o
 
 extra-y				+= systbl_chk.i

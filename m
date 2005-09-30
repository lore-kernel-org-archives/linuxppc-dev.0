Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 30 Sep 2005 23:55:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050930235517.47c497fb.sfr@canb.auug.org.au>
In-Reply-To: <20050930233602.138b6e27.sfr@canb.auug.org.au>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/9] powerpc: more cleanup of powerpc/kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update head_64.S from arch/ppc64
Remove arch/ppc/kernel/fpu.S

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/head_64.S |    9 ++-
 arch/ppc/kernel/Makefile      |    1 
 arch/ppc/kernel/fpu.S         |  133 -----------------------------------------
 3 files changed, 7 insertions(+), 136 deletions(-)
 delete mode 100644 arch/ppc/kernel/fpu.S

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

ee400b63f37120987bd12a2fada850c6212d7563
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1253,7 +1253,7 @@ unrecov_slb:
  *
  * On iSeries, the hypervisor must fill in at least one entry before
  * we get control (with relocate on).  The address is give to the hv
- * as a page number (see xLparMap in LparData.c), so this must be at a
+ * as a page number (see xLparMap in lpardata.c), so this must be at a
  * fixed address (the linker can't compute (u64)&initial_stab >>
  * PAGE_SHIFT).
  */
@@ -1364,6 +1364,7 @@ _STATIC(__start_initialization_iSeries)
 	addi	r2,r2,0x4000
 
 	bl	.iSeries_early_setup
+	bl	.early_setup
 
 	/* relocation is on at this point */
 
@@ -1970,20 +1971,22 @@ _GLOBAL(hmt_start_secondary)
 	blr
 #endif
 
-#if defined(CONFIG_KEXEC) || (defined(CONFIG_SMP) && !defined(CONFIG_PPC_ISERIES))
+#if defined(CONFIG_KEXEC) || defined(CONFIG_SMP)
 _GLOBAL(smp_release_cpus)
 	/* All secondary cpus are spinning on a common
 	 * spinloop, release them all now so they can start
 	 * to spin on their individual paca spinloops.
 	 * For non SMP kernels, the secondary cpus never
 	 * get out of the common spinloop.
+	 * XXX This does nothing useful on iSeries, secondaries are
+	 * already waiting on their paca.
 	 */
 	li	r3,1
 	LOADADDR(r5,__secondary_hold_spinloop)
 	std	r3,0(r5)
 	sync
 	blr
-#endif /* CONFIG_SMP && !CONFIG_PPC_ISERIES */
+#endif /* CONFIG_SMP */
 
 
 /*
diff --git a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile
+++ b/arch/ppc/kernel/Makefile
@@ -39,6 +39,7 @@ endif
 # These are here while we do the architecture merge
 vecemu-y			+= ../../powerpc/kernel/vecemu.o
 vector-y			+= ../../powerpc/kernel/vector.o
+fpu-y				+= ../../powerpc/kernel/fpu.o
 
 else
 obj-y				:= entry.o irq.o idle.o time.o misc.o \
diff --git a/arch/ppc/kernel/fpu.S b/arch/ppc/kernel/fpu.S
deleted file mode 100644
--- a/arch/ppc/kernel/fpu.S
+++ /dev/null
@@ -1,133 +0,0 @@
-/*
- *  FPU support code, moved here from head.S so that it can be used
- *  by chips which use other head-whatever.S files.
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- *
- */
-
-#include <linux/config.h>
-#include <asm/processor.h>
-#include <asm/page.h>
-#include <asm/mmu.h>
-#include <asm/pgtable.h>
-#include <asm/cputable.h>
-#include <asm/cache.h>
-#include <asm/thread_info.h>
-#include <asm/ppc_asm.h>
-#include <asm/asm-offsets.h>
-
-/*
- * This task wants to use the FPU now.
- * On UP, disable FP for the task which had the FPU previously,
- * and save its floating-point registers in its thread_struct.
- * Load up this task's FP registers from its thread_struct,
- * enable the FPU for the current task and return to the task.
- */
-	.globl	load_up_fpu
-load_up_fpu:
-	mfmsr	r5
-	ori	r5,r5,MSR_FP
-#ifdef CONFIG_PPC64BRIDGE
-	clrldi	r5,r5,1			/* turn off 64-bit mode */
-#endif /* CONFIG_PPC64BRIDGE */
-	SYNC
-	MTMSRD(r5)			/* enable use of fpu now */
-	isync
-/*
- * For SMP, we don't do lazy FPU switching because it just gets too
- * horrendously complex, especially when a task switches from one CPU
- * to another.  Instead we call giveup_fpu in switch_to.
- */
-#ifndef CONFIG_SMP
-	tophys(r6,0)			/* get __pa constant */
-	addis	r3,r6,last_task_used_math@ha
-	lwz	r4,last_task_used_math@l(r3)
-	cmpwi	0,r4,0
-	beq	1f
-	add	r4,r4,r6
-	addi	r4,r4,THREAD		/* want last_task_used_math->thread */
-	SAVE_32FPRS(0, r4)
-	mffs	fr0
-	stfd	fr0,THREAD_FPSCR-4(r4)
-	lwz	r5,PT_REGS(r4)
-	add	r5,r5,r6
-	lwz	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	li	r10,MSR_FP|MSR_FE0|MSR_FE1
-	andc	r4,r4,r10		/* disable FP for previous task */
-	stw	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
-#endif /* CONFIG_SMP */
-	/* enable use of FP after return */
-	mfspr	r5,SPRN_SPRG3		/* current task's THREAD (phys) */
-	lwz	r4,THREAD_FPEXC_MODE(r5)
-	ori	r9,r9,MSR_FP		/* enable FP for current */
-	or	r9,r9,r4
-	lfd	fr0,THREAD_FPSCR-4(r5)
-	mtfsf	0xff,fr0
-	REST_32FPRS(0, r5)
-#ifndef CONFIG_SMP
-	subi	r4,r5,THREAD
-	sub	r4,r4,r6
-	stw	r4,last_task_used_math@l(r3)
-#endif /* CONFIG_SMP */
-	/* restore registers and return */
-	/* we haven't used ctr or xer or lr */
-	b	fast_exception_return
-
-/*
- * FP unavailable trap from kernel - print a message, but let
- * the task use FP in the kernel until it returns to user mode.
- */
- 	.globl	KernelFP
-KernelFP:
-	lwz	r3,_MSR(r1)
-	ori	r3,r3,MSR_FP
-	stw	r3,_MSR(r1)		/* enable use of FP after return */
-	lis	r3,86f@h
-	ori	r3,r3,86f@l
-	mr	r4,r2			/* current */
-	lwz	r5,_NIP(r1)
-	bl	printk
-	b	ret_from_except
-86:	.string	"floating point used in kernel (task=%p, pc=%x)\n"
-	.align	4,0
-
-/*
- * giveup_fpu(tsk)
- * Disable FP for the task given as the argument,
- * and save the floating-point registers in its thread_struct.
- * Enables the FPU for use in the kernel on return.
- */
-	.globl	giveup_fpu
-giveup_fpu:
-	mfmsr	r5
-	ori	r5,r5,MSR_FP
-	SYNC_601
-	ISYNC_601
-	MTMSRD(r5)			/* enable use of fpu now */
-	SYNC_601
-	isync
-	cmpwi	0,r3,0
-	beqlr-				/* if no previous owner, done */
-	addi	r3,r3,THREAD	        /* want THREAD of task */
-	lwz	r5,PT_REGS(r3)
-	cmpwi	0,r5,0
-	SAVE_32FPRS(0, r3)
-	mffs	fr0
-	stfd	fr0,THREAD_FPSCR-4(r3)
-	beq	1f
-	lwz	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	li	r3,MSR_FP|MSR_FE0|MSR_FE1
-	andc	r4,r4,r3		/* disable FP for previous task */
-	stw	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
-#ifndef CONFIG_SMP
-	li	r5,0
-	lis	r4,last_task_used_math@ha
-	stw	r5,last_task_used_math@l(r4)
-#endif /* CONFIG_SMP */
-	blr

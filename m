Return-Path: <anton@ozlabs.org>
Date: Wed, 7 Mar 2007 15:29:10 -0600
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: speed up kernel_thread
Message-ID: <20070307212910.GA3648@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


When looking through Ingo's syslet code, I noticed our kernel_thread
implementation executed two syscalls. The patch below avoids these by
calling do_fork directly.

Of course after doing this I had to create kthreadbench to test the
change. Good news, its over 3% faster to create 1000 kernel threads!

Tested on ppc64 only.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/process.c	2007-03-07 14:27:57.000000000 -0600
+++ linux-2.6/arch/powerpc/kernel/process.c	2007-03-07 15:15:16.000000000 -0600
@@ -522,6 +522,7 @@
 		p->thread.regs = NULL;	/* no user register state */
 	} else {
 		childregs->gpr[1] = usp;
+		childregs->gpr[3] = 0;  /* Result from fork() */
 		p->thread.regs = childregs;
 		if (clone_flags & CLONE_SETTLS) {
 #ifdef CONFIG_PPC64
@@ -532,7 +533,6 @@
 				childregs->gpr[2] = childregs->gpr[6];
 		}
 	}
-	childregs->gpr[3] = 0;  /* Result from fork() */
 	sp -= STACK_FRAME_OVERHEAD;
 
 	/*
@@ -650,6 +650,30 @@
 #endif /* CONFIG_SPE */
 }
 
+long kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
+{
+	extern void kernel_thread_helper(void);
+	struct pt_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+
+	/* use non volatile GPRs so they get restored in _switch */
+	regs.gpr[14] = (unsigned long)arg;
+	regs.msr = mfmsr();
+
+#ifdef CONFIG_PPC64
+	regs.gpr[15] = *((unsigned long *)fn);
+	regs.gpr[2] = *((unsigned long *)fn + 1);
+	regs.nip = *((unsigned long *)kernel_thread_helper);
+#else
+	regs.gpr[15] = (unsigned long)fn;
+	regs.nip = (unsigned long)kernel_thread_helper;
+#endif
+
+	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0,
+		       NULL, NULL);
+}
+
 #define PR_FP_ALL_EXCEPT (PR_FP_EXC_DIV | PR_FP_EXC_OVF | PR_FP_EXC_UND \
 		| PR_FP_EXC_RES | PR_FP_EXC_INV)
 
Index: linux-2.6/arch/powerpc/kernel/misc_64.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/misc_64.S	2007-03-07 14:27:57.000000000 -0600
+++ linux-2.6/arch/powerpc/kernel/misc_64.S	2007-03-07 15:15:16.000000000 -0600
@@ -422,38 +422,14 @@
 	blr
 #endif /* CONFIG_CPU_FREQ_PMAC64 */
 
-
-/*
- * Create a kernel thread
- *   kernel_thread(fn, arg, flags)
- */
-_GLOBAL(kernel_thread)
-	std	r29,-24(r1)
-	std	r30,-16(r1)
-	stdu	r1,-STACK_FRAME_OVERHEAD(r1)
-	mr	r29,r3
-	mr	r30,r4
-	ori	r3,r5,CLONE_VM	/* flags */
-	oris	r3,r3,(CLONE_UNTRACED>>16)
-	li	r4,0		/* new sp (unused) */
-	li	r0,__NR_clone
-	sc
-	cmpdi	0,r3,0		/* parent or child? */
-	bne	1f		/* return if parent */
+_GLOBAL(kernel_thread_helper)
 	li	r0,0
+	mtctr	r15
 	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
-	ld	r2,8(r29)
-	ld	r29,0(r29)
-	mtlr	r29              /* fn addr in lr */
-	mr	r3,r30	        /* load arg and call fn */
-	blrl
-	li	r0,__NR_exit	/* exit after child exits */
-        li	r3,0
-	sc
-1:	addi	r1,r1,STACK_FRAME_OVERHEAD	
-	ld	r29,-24(r1)
-	ld	r30,-16(r1)
-	blr
+	mr	r3,r14
+	bctrl
+	li	r3,0
+	bl	.do_exit
 
 /*
  * disable_kernel_fp()
Index: linux-2.6/arch/powerpc/kernel/misc_32.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/misc_32.S	2007-03-07 14:27:57.000000000 -0600
+++ linux-2.6/arch/powerpc/kernel/misc_32.S	2007-03-07 15:15:16.000000000 -0600
@@ -738,36 +738,15 @@
 	mr	r3,r1		/* Close enough */
 	blr
 
-/*
- * Create a kernel thread
- *   kernel_thread(fn, arg, flags)
- */
-_GLOBAL(kernel_thread)
-	stwu	r1,-16(r1)
-	stw	r30,8(r1)
-	stw	r31,12(r1)
-	mr	r30,r3		/* function */
-	mr	r31,r4		/* argument */
-	ori	r3,r5,CLONE_VM	/* flags */
-	oris	r3,r3,CLONE_UNTRACED>>16
-	li	r4,0		/* new sp (unused) */
-	li	r0,__NR_clone
-	sc
-	cmpwi	0,r3,0		/* parent or child? */
-	bne	1f		/* return if parent */
-	li	r0,0		/* make top-level stack frame */
-	stwu	r0,-16(r1)
-	mtlr	r30		/* fn addr in lr */
-	mr	r3,r31		/* load arg and call fn */
-	PPC440EP_ERR42
-	blrl
-	li	r0,__NR_exit	/* exit if function returns */
-	li	r3,0
-	sc
-1:	lwz	r30,8(r1)
-	lwz	r31,12(r1)
-	addi	r1,r1,16
-	blr
+_GLOBAL(kernel_thread_helper)
+	li	r0,0
+	mtctr	r15
+	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
+	mr	r3,r14
+	PPC440EP_ERR42 /* XXX required? */
+	bctrl
+	li	r3,0
+	bl	do_exit
 
 _GLOBAL(kernel_execve)
 	li	r0,__NR_execve

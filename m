Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Mon, 23 Jun 2008 15:31:29 +1000
Subject: [PATCH 5/9] powerpc: Introduce VSX thread_struct and CONFIG_VSX
In-Reply-To: <1214199088.328454.246197670684.qpush@coopers>
Message-Id: <20080623053129.3627D70298@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The layout of the new VSR registers and how they overlap on top of the
legacy FPR and VR registers is:

                   VSR doubleword 0               VSR doubleword 1
          ----------------------------------------------------------------
  VSR[0]  |             FPR[0]            |                              |
          ----------------------------------------------------------------
  VSR[1]  |             FPR[1]            |                              |
          ----------------------------------------------------------------
          |              ...              |                              |
          |              ...              |                              |
          ----------------------------------------------------------------
  VSR[30] |             FPR[30]           |                              |
          ----------------------------------------------------------------
  VSR[31] |             FPR[31]           |                              |
          ----------------------------------------------------------------
  VSR[32] |                             VR[0]                            |
          ----------------------------------------------------------------
  VSR[33] |                             VR[1]                            |
          ----------------------------------------------------------------
          |                              ...                             |
          |                              ...                             |
          ----------------------------------------------------------------
  VSR[62] |                             VR[30]                           |
          ----------------------------------------------------------------
  VSR[63] |                             VR[31]                           |
          ----------------------------------------------------------------

VSX has 64 128bit registers.  The first 32 regs overlap with the FP
registers and hence extend them with and additional 64 bits.  The
second 32 regs overlap with the VMX registers.

This patch introduces the thread_struct changes required to reflect
this register layout.  Ptrace and signals code is updated so that the
floating point registers are correctly accessed from the thread_struct
when CONFIG_VSX is enabled.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/asm-offsets.c |    4 ++
 arch/powerpc/kernel/ptrace.c      |   28 ++++++++++++++++++
 arch/powerpc/kernel/signal_32.c   |   59 ++++++++++++++++++++++++++++----------
 arch/powerpc/kernel/signal_64.c   |   32 ++++++++++++++++++--
 include/asm-powerpc/processor.h   |   21 ++++++++++++-
 5 files changed, 126 insertions(+), 18 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/asm-offsets.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/asm-offsets.c
@@ -74,6 +74,10 @@ int main(void)
 	DEFINE(THREAD_VSCR, offsetof(struct thread_struct, vscr));
 	DEFINE(THREAD_USED_VR, offsetof(struct thread_struct, used_vr));
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_VSX
+	DEFINE(THREAD_VSR0, offsetof(struct thread_struct, fpr));
+	DEFINE(THREAD_USED_VSR, offsetof(struct thread_struct, used_vsr));
+#endif /* CONFIG_VSX */
 #ifdef CONFIG_PPC64
 	DEFINE(KSP_VSID, offsetof(struct thread_struct, ksp_vsid));
 #else /* CONFIG_PPC64 */
Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
@@ -215,26 +215,54 @@ static int fpr_get(struct task_struct *t
 		   unsigned int pos, unsigned int count,
 		   void *kbuf, void __user *ubuf)
 {
+#ifdef CONFIG_VSX
+	double buf[33];
+	int i;
+#endif
 	flush_fp_to_thread(target);
 
+#ifdef CONFIG_VSX
+	/* copy to local buffer then write that out */
+	for (i = 0; i < 32 ; i++)
+		buf[i] = target->thread.TS_FPR(i);
+	memcpy(&buf[32], &target->thread.fpscr, sizeof(double));
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
+
+#else
 	BUILD_BUG_ON(offsetof(struct thread_struct, fpscr) !=
 		     offsetof(struct thread_struct, TS_FPR(32)));
 
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				   target->thread.fpr, 0, -1);
+#endif
 }
 
 static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
 		   const void *kbuf, const void __user *ubuf)
 {
+#ifdef CONFIG_VSX
+	double buf[33];
+	int i;
+#endif
 	flush_fp_to_thread(target);
 
+#ifdef CONFIG_VSX
+	/* copy to local buffer then write that out */
+	i = user_regset_copyin(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
+	if (i)
+		return i;
+	for (i = 0; i < 32 ; i++)
+		target->thread.TS_FPR(i) = buf[i];
+	memcpy(&target->thread.fpscr, &buf[32], sizeof(double));
+	return 0;
+#else
 	BUILD_BUG_ON(offsetof(struct thread_struct, fpscr) !=
 		     offsetof(struct thread_struct, TS_FPR(32)));
 
 	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				  target->thread.fpr, 0, -1);
+#endif
 }
 
 
Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_32.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
@@ -337,14 +337,16 @@ static int save_user_regs(struct pt_regs
 		int sigret)
 {
 	unsigned long msr = regs->msr;
+#ifdef CONFIG_VSX
+	double buf[32];
+	int i;
+#endif
 
 	/* Make sure floating point registers are stored in regs */
 	flush_fp_to_thread(current);
 
-	/* save general and floating-point registers */
-	if (save_general_regs(regs, frame) ||
-	    __copy_to_user(&frame->mc_fregs, current->thread.fpr,
-		    ELF_NFPREG * sizeof(double)))
+	/* save general registers */
+	if (save_general_regs(regs, frame))
 		return 1;
 
 #ifdef CONFIG_ALTIVEC
@@ -368,7 +370,20 @@ static int save_user_regs(struct pt_regs
 	if (__put_user(current->thread.vrsave, (u32 __user *)&frame->mc_vregs[32]))
 		return 1;
 #endif /* CONFIG_ALTIVEC */
-
+#ifdef CONFIG_VSX
+	/* save FPR copy to local buffer then write to the thread_struct */
+	flush_fp_to_thread(current);
+	for (i = 0; i < 32 ; i++)
+		buf[i] = current->thread.TS_FPR(i);
+	memcpy(&buf[i], &current->thread.fpscr, sizeof(double));
+	if (__copy_to_user(&frame->mc_fregs, buf, ELF_NFPREG * sizeof(double)))
+		return 1;
+#else
+	/* save floating-point registers */
+	if (__copy_to_user(&frame->mc_fregs, current->thread.fpr,
+		    ELF_NFPREG * sizeof(double)))
+		return 1;
+#endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	/* save spe registers */
 	if (current->thread.used_spe) {
@@ -411,6 +426,10 @@ static long restore_user_regs(struct pt_
 	long err;
 	unsigned int save_r2 = 0;
 	unsigned long msr;
+#ifdef CONFIG_VSX
+	double buf[32];
+	int i;
+#endif
 
 	/*
 	 * restore general registers but not including MSR or SOFTE. Also
@@ -438,16 +457,11 @@ static long restore_user_regs(struct pt_
 	 */
 	discard_lazy_cpu_state();
 
-	/* force the process to reload the FP registers from
-	   current->thread when it next does FP instructions */
-	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
-	if (__copy_from_user(current->thread.fpr, &sr->mc_fregs,
-			     sizeof(sr->mc_fregs)))
-		return 1;
-
 #ifdef CONFIG_ALTIVEC
-	/* force the process to reload the altivec registers from
-	   current->thread when it next does altivec instructions */
+	/*
+	 * Force the process to reload the altivec registers from
+	 * current->thread when it next does altivec instructions
+	 */
 	regs->msr &= ~MSR_VEC;
 	if (msr & MSR_VEC) {
 		/* restore altivec registers from the stack */
@@ -462,6 +476,23 @@ static long restore_user_regs(struct pt_
 		return 1;
 #endif /* CONFIG_ALTIVEC */
 
+#ifdef CONFIG_VSX
+	if (__copy_from_user(buf, &sr->mc_fregs,sizeof(sr->mc_fregs)))
+		return 1;
+	for (i = 0; i < 32 ; i++)
+		current->thread.TS_FPR(i) = buf[i];
+	memcpy(&current->thread.fpscr, &buf[i], sizeof(double));
+#else
+	if (__copy_from_user(current->thread.fpr, &sr->mc_fregs,
+			     sizeof(sr->mc_fregs)))
+		return 1;
+#endif /* CONFIG_VSX */
+	/*
+	 * force the process to reload the FP registers from
+	 * current->thread when it next does FP instructions
+	 */
+	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
+
 #ifdef CONFIG_SPE
 	/* force the process to reload the spe registers from
 	   current->thread when it next does spe instructions */
Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_64.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
@@ -89,6 +89,10 @@ static long setup_sigcontext(struct sigc
 #endif
 	unsigned long msr = regs->msr;
 	long err = 0;
+#ifdef CONFIG_VSX
+	double buf[FP_REGS_SIZE];
+	int i;
+#endif
 
 	flush_fp_to_thread(current);
 
@@ -112,11 +116,21 @@ static long setup_sigcontext(struct sigc
 #else /* CONFIG_ALTIVEC */
 	err |= __put_user(0, &sc->v_regs);
 #endif /* CONFIG_ALTIVEC */
+	flush_fp_to_thread(current);
+#ifdef CONFIG_VSX
+	/* Copy FP to local buffer then write that out */
+	for (i = 0; i < 32 ; i++)
+		buf[i] = current->thread.TS_FPR(i);
+	memcpy(&buf[i], &current->thread.fpscr, sizeof(double));
+	err |= __copy_to_user(&sc->fp_regs, buf, FP_REGS_SIZE);
+#else /* CONFIG_VSX */
+	/* copy fpr regs and fpscr */
+	err |= __copy_to_user(&sc->fp_regs, &current->thread.fpr, FP_REGS_SIZE);
+#endif /* CONFIG_VSX */
 	err |= __put_user(&sc->gp_regs, &sc->regs);
 	WARN_ON(!FULL_REGS(regs));
 	err |= __copy_to_user(&sc->gp_regs, regs, GP_REGS_SIZE);
 	err |= __put_user(msr, &sc->gp_regs[PT_MSR]);
-	err |= __copy_to_user(&sc->fp_regs, &current->thread.fpr, FP_REGS_SIZE);
 	err |= __put_user(signr, &sc->signal);
 	err |= __put_user(handler, &sc->handler);
 	if (set != NULL)
@@ -135,6 +149,9 @@ static long restore_sigcontext(struct pt
 #ifdef CONFIG_ALTIVEC
 	elf_vrreg_t __user *v_regs;
 #endif
+#ifdef CONFIG_VSX
+	double buf[FP_REGS_SIZE];
+#endif
 	unsigned long err = 0;
 	unsigned long save_r13 = 0;
 	elf_greg_t *gregs = (elf_greg_t *)regs;
@@ -182,8 +199,6 @@ static long restore_sigcontext(struct pt
 	 */
 	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1 | MSR_VEC);
 
-	err |= __copy_from_user(&current->thread.fpr, &sc->fp_regs, FP_REGS_SIZE);
-
 #ifdef CONFIG_ALTIVEC
 	err |= __get_user(v_regs, &sc->v_regs);
 	if (err)
@@ -202,7 +217,18 @@ static long restore_sigcontext(struct pt
 	else
 		current->thread.vrsave = 0;
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_VSX
+	/* restore floating point */
+	err |= __copy_from_user(buf, &sc->fp_regs, FP_REGS_SIZE);
+	if (err)
+		return err;
+	for (i = 0; i < 32 ; i++)
+		current->thread.TS_FPR(i) = buf[i];
+	memcpy(&current->thread.fpscr, &buf[i], sizeof(double));
 
+#else
+	err |= __copy_from_user(&current->thread.fpr, &sc->fp_regs, FP_REGS_SIZE);
+#endif
 	return err;
 }
 
Index: linux-2.6-ozlabs/include/asm-powerpc/processor.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/processor.h
+++ linux-2.6-ozlabs/include/asm-powerpc/processor.h
@@ -78,6 +78,7 @@ extern long kernel_thread(int (*fn)(void
 /* Lazy FPU handling on uni-processor */
 extern struct task_struct *last_task_used_math;
 extern struct task_struct *last_task_used_altivec;
+extern struct task_struct *last_task_used_vsx;
 extern struct task_struct *last_task_used_spe;
 
 #ifdef CONFIG_PPC32
@@ -136,7 +137,13 @@ typedef struct {
 	unsigned long seg;
 } mm_segment_t;
 
+#define TS_FPROFFSET 0
+#define TS_VSRLOWOFFSET 1
+#ifdef CONFIG_VSX
+#define TS_FPR(i) fpr[i][TS_FPROFFSET]
+#else
 #define TS_FPR(i) fpr[i]
+#endif
 
 struct thread_struct {
 	unsigned long	ksp;		/* Kernel stack pointer */
@@ -154,8 +161,12 @@ struct thread_struct {
 	unsigned long	dbcr0;		/* debug control register values */
 	unsigned long	dbcr1;
 #endif
+#ifdef CONFIG_VSX
+	double		fpr[32][2];	/* Complete floating point set */
+#else
 	double		fpr[32];	/* Complete floating point set */
-	struct {			/* fpr ... fpscr must be contiguous */
+#endif
+	struct {
 
 		unsigned int pad;
 		unsigned int val;	/* Floating point status */
@@ -175,6 +186,10 @@ struct thread_struct {
 	unsigned long	vrsave;
 	int		used_vr;	/* set if process has used altivec */
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_VSX
+	/* VSR status */
+	int		used_vsr;	/* set if process has used altivec */
+#endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	unsigned long	evr[32];	/* upper 32-bits of SPE regs */
 	u64		acc;		/* Accumulator */
@@ -291,5 +306,9 @@ static inline void prefetchw(const void 
 
 #endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
+#ifdef CONFIG_VSX
+#define TS_FPRSPACING 2
+#else
 #define TS_FPRSPACING 1
+#endif
 #endif /* _ASM_POWERPC_PROCESSOR_H */

Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17348.59371.543311.793437@cargo.ozlabs.ibm.com>
Date: Wed, 11 Jan 2006 22:11:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Heikki Lindholm <holindho@cs.helsinki.fi>
In-Reply-To: <43BC15A9.7010009@cs.helsinki.fi>
References: <43BC15A9.7010009@cs.helsinki.fi>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: restore_user_regs and fpu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Heikki Lindholm writes:

> I haven't really confirmed this can happen, but I was wondering whether 
> the following would be possible. Looking at restore_user_regs in 
> ppc/kernel/signal_32.c and assuming:
> * last_task_used_math == current, eg. a signal handler used fpu
> * fpu state is still what the sig handler left there
> If after the fpu state is restored to current->thread.fpr (copy_user) 
> somebody preempts this task and uses fpu, wouldn't it cause the fpu 
> state (of the sig handler) to be saved to 
> last_task_used_math->thread.fpr overwriting the just restored state. 
> Should the last_task_used_math nullifying, etc. be moved to the front of 
> the function instead, or am I overlooking something?

I think you are correct, and that the same problem exists for 64-bit
processes.  This patch should fix it.  Can anyone see any problem with
this patch?

Paul.

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 105d560..913f906 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -201,13 +201,13 @@ int dump_spe(struct pt_regs *regs, elf_v
 }
 #endif /* CONFIG_SPE */
 
+#ifndef CONFIG_SMP
 /*
  * If we are doing lazy switching of CPU state (FP, altivec or SPE),
  * and the current task has some state, discard it.
  */
-static inline void discard_lazy_cpu_state(void)
+void discard_lazy_cpu_state(void)
 {
-#ifndef CONFIG_SMP
 	preempt_disable();
 	if (last_task_used_math == current)
 		last_task_used_math = NULL;
@@ -220,8 +220,8 @@ static inline void discard_lazy_cpu_stat
 		last_task_used_spe = NULL;
 #endif
 	preempt_enable();
-#endif /* CONFIG_SMP */
 }
+#endif /* CONFIG_SMP */
 
 int set_dabr(unsigned long dabr)
 {
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index d3f0b6d..177bba7 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -497,6 +497,15 @@ static long restore_user_regs(struct pt_
 	if (err)
 		return 1;
 
+	/*
+	 * Do this before updating the thread state in
+	 * current->thread.fpr/vr/evr.  That way, if we get preempted
+	 * and another task grabs the FPU/Altivec/SPE, it won't be
+	 * tempted to save the current CPU state into the thread_struct
+	 * and corrupt what we are writing there.
+	 */
+	discard_lazy_cpu_state();
+
 	/* force the process to reload the FP registers from
 	   current->thread when it next does FP instructions */
 	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
@@ -538,18 +547,6 @@ static long restore_user_regs(struct pt_
 		return 1;
 #endif /* CONFIG_SPE */
 
-#ifndef CONFIG_SMP
-	preempt_disable();
-	if (last_task_used_math == current)
-		last_task_used_math = NULL;
-	if (last_task_used_altivec == current)
-		last_task_used_altivec = NULL;
-#ifdef CONFIG_SPE
-	if (last_task_used_spe == current)
-		last_task_used_spe = NULL;
-#endif
-	preempt_enable();
-#endif
 	return 0;
 }
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 5462bef..7b9d999 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -207,10 +207,20 @@ static long restore_sigcontext(struct pt
 
 	if (!sig)
 		regs->gpr[13] = save_r13;
-	err |= __copy_from_user(&current->thread.fpr, &sc->fp_regs, FP_REGS_SIZE);
 	if (set != NULL)
 		err |=  __get_user(set->sig[0], &sc->oldmask);
 
+	/*
+	 * Do this before updating the thread state in
+	 * current->thread.fpr/vr.  That way, if we get preempted
+	 * and another task grabs the FPU/Altivec, it won't be
+	 * tempted to save the current CPU state into the thread_struct
+	 * and corrupt what we are writing there.
+	 */
+	discard_lazy_cpu_state();
+
+	err |= __copy_from_user(&current->thread.fpr, &sc->fp_regs, FP_REGS_SIZE);
+
 #ifdef CONFIG_ALTIVEC
 	err |= __get_user(v_regs, &sc->v_regs);
 	err |= __get_user(msr, &sc->gp_regs[PT_MSR]);
@@ -229,14 +239,6 @@ static long restore_sigcontext(struct pt
 		current->thread.vrsave = 0;
 #endif /* CONFIG_ALTIVEC */
 
-#ifndef CONFIG_SMP
-	preempt_disable();
-	if (last_task_used_math == current)
-		last_task_used_math = NULL;
-	if (last_task_used_altivec == current)
-		last_task_used_altivec = NULL;
-	preempt_enable();
-#endif
 	/* Force reload of FP/VEC */
 	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1 | MSR_VEC);
 
diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
index 0c58e32..4c88830 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -133,6 +133,14 @@ extern int fix_alignment(struct pt_regs 
 extern void cvt_fd(float *from, double *to, struct thread_struct *thread);
 extern void cvt_df(double *from, float *to, struct thread_struct *thread);
 
+#ifndef CONFIG_SMP
+extern void discard_lazy_cpu_state(void);
+#else
+static inline void discard_lazy_cpu_state(void)
+{
+}
+#endif
+
 #ifdef CONFIG_ALTIVEC
 extern void flush_altivec_to_thread(struct task_struct *);
 #else

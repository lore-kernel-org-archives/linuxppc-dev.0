Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Wed, 02 Jul 2008 11:56:42 +1000
Subject: [PATCH] powerpc: cleanup copy_to/from_user for vsx and fpr
In-Reply-To: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
Message-Id: <1214963802.6328.185630097155.qpush@coopers>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This merges and cleans up some of the ugly copy/to from user code
which is required for the new fpr and vsx layout in the thread_struct.

Also fixes some hard coded buffer sizes and removes a redundant
fpr_flush_to_thread.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/signal.h    |   10 +++
 arch/powerpc/kernel/signal_32.c |   40 ++------------
 arch/powerpc/kernel/signal_64.c |  112 ++++++++++++++++++++++++++++------------
 3 files changed, 96 insertions(+), 66 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal.h
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal.h
@@ -24,6 +24,16 @@ extern int handle_rt_signal32(unsigned l
 			      siginfo_t *info, sigset_t *oldset,
 			      struct pt_regs *regs);
 
+extern unsigned long copy_fpr_to_user(void __user *to,
+				      struct task_struct *task);
+extern unsigned long copy_fpr_from_user(struct task_struct *task,
+					void __user *from);
+#ifdef CONFIG_VSX
+extern unsigned long copy_vsx_to_user(void __user *to,
+				      struct task_struct *task);
+extern unsigned long copy_vsx_from_user(struct task_struct *task,
+					void __user *from);
+#endif
 
 #ifdef CONFIG_PPC64
 
Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_32.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
@@ -337,10 +337,6 @@ static int save_user_regs(struct pt_regs
 		int sigret)
 {
 	unsigned long msr = regs->msr;
-#ifdef CONFIG_VSX
-	double buf[32];
-	int i;
-#endif
 
 	/* Make sure floating point registers are stored in regs */
 	flush_fp_to_thread(current);
@@ -370,14 +366,9 @@ static int save_user_regs(struct pt_regs
 	if (__put_user(current->thread.vrsave, (u32 __user *)&frame->mc_vregs[32]))
 		return 1;
 #endif /* CONFIG_ALTIVEC */
-#ifdef CONFIG_VSX
-	/* save FPR copy to local buffer then write to the thread_struct */
-	flush_fp_to_thread(current);
-	for (i = 0; i < 32 ; i++)
-		buf[i] = current->thread.TS_FPR(i);
-	memcpy(&buf[i], &current->thread.fpscr, sizeof(double));
-	if (__copy_to_user(&frame->mc_fregs, buf, ELF_NFPREG * sizeof(double)))
+	if (copy_fpr_to_user(&frame->mc_fregs, current))
 		return 1;
+#ifdef CONFIG_VSX
 	/*
 	 * Copy VSR 0-31 upper half from thread_struct to local
 	 * buffer, then write that to userspace.  Also set MSR_VSX in
@@ -386,18 +377,10 @@ static int save_user_regs(struct pt_regs
 	 */
 	if (current->thread.used_vsr) {
 		flush_vsx_to_thread(current);
-		for (i = 0; i < 32 ; i++)
-			buf[i] = current->thread.fpr[i][TS_VSRLOWOFFSET];
-		if (__copy_to_user(&frame->mc_vsregs, buf,
-				   ELF_NVSRHALFREG  * sizeof(double)))
+		if (copy_vsx_to_user(&frame->mc_vsregs, current))
 			return 1;
 		msr |= MSR_VSX;
 	}
-#else
-	/* save floating-point registers */
-	if (__copy_to_user(&frame->mc_fregs, current->thread.fpr,
-		    ELF_NFPREG * sizeof(double)))
-		return 1;
 #endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	/* save spe registers */
@@ -442,7 +425,6 @@ static long restore_user_regs(struct pt_
 	unsigned int save_r2 = 0;
 	unsigned long msr;
 #ifdef CONFIG_VSX
-	double buf[32];
 	int i;
 #endif
 
@@ -490,13 +472,10 @@ static long restore_user_regs(struct pt_
 	if (__get_user(current->thread.vrsave, (u32 __user *)&sr->mc_vregs[32]))
 		return 1;
 #endif /* CONFIG_ALTIVEC */
+	if (copy_fpr_from_user(current, &sr->mc_fregs))
+		return 1;
 
 #ifdef CONFIG_VSX
-	if (__copy_from_user(buf, &sr->mc_fregs,sizeof(sr->mc_fregs)))
-		return 1;
-	for (i = 0; i < 32 ; i++)
-		current->thread.TS_FPR(i) = buf[i];
-	memcpy(&current->thread.fpscr, &buf[i], sizeof(double));
 	/*
 	 * Force the process to reload the VSX registers from
 	 * current->thread when it next does VSX instruction.
@@ -507,18 +486,11 @@ static long restore_user_regs(struct pt_
 		 * Restore altivec registers from the stack to a local
 		 * buffer, then write this out to the thread_struct
 		 */
-		if (__copy_from_user(buf, &sr->mc_vsregs,
-				     sizeof(sr->mc_vsregs)))
+		if (copy_vsx_from_user(current, &sr->mc_vsregs))
 			return 1;
-		for (i = 0; i < 32 ; i++)
-			current->thread.fpr[i][TS_VSRLOWOFFSET] = buf[i];
 	} else if (current->thread.used_vsr)
 		for (i = 0; i < 32 ; i++)
 			current->thread.fpr[i][TS_VSRLOWOFFSET] = 0;
-#else
-	if (__copy_from_user(current->thread.fpr, &sr->mc_fregs,
-			     sizeof(sr->mc_fregs)))
-		return 1;
 #endif /* CONFIG_VSX */
 	/*
 	 * force the process to reload the FP registers from
Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_64.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
@@ -69,6 +69,75 @@ static const char fmt32[] = KERN_INFO \
 static const char fmt64[] = KERN_INFO \
 	"%s[%d]: bad frame in %s: %016lx nip %016lx lr %016lx\n";
 
+#ifdef CONFIG_VSX
+unsigned long copy_fpr_to_user(void __user *to,
+			       struct task_struct *task)
+{
+	double buf[ELF_NFPREG];
+	int i;
+
+	/* save FPR copy to local buffer then write to the thread_struct */
+	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
+		buf[i] = task->thread.TS_FPR(i);
+	memcpy(&buf[i], &task->thread.fpscr, sizeof(double));
+	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
+}
+
+unsigned long copy_fpr_from_user(struct task_struct *task,
+				 void __user *from)
+{
+	double buf[ELF_NFPREG];
+	int i;
+
+	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
+		return 1;
+	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
+		task->thread.TS_FPR(i) = buf[i];
+	memcpy(&task->thread.fpscr, &buf[i], sizeof(double));
+
+	return 0;
+}
+
+unsigned long copy_vsx_to_user(void __user *to,
+			       struct task_struct *task)
+{
+	double buf[ELF_NVSRHALFREG];
+	int i;
+
+	/* save FPR copy to local buffer then write to the thread_struct */
+	for (i = 0; i < ELF_NVSRHALFREG; i++)
+		buf[i] = task->thread.fpr[i][TS_VSRLOWOFFSET];
+	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
+}
+
+unsigned long copy_vsx_from_user(struct task_struct *task,
+				 void __user *from)
+{
+	double buf[ELF_NVSRHALFREG];
+	int i;
+
+	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
+		return 1;
+	for (i = 0; i < ELF_NVSRHALFREG ; i++)
+		task->thread.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+	return 0;
+}
+#else
+inline unsigned long copy_fpr_to_user(void __user *to,
+				      struct task_struct *task)
+{
+	return __copy_to_user(to, task->thread.fpr,
+			      ELF_NFPREG * sizeof(double));
+}
+
+inline unsigned long copy_fpr_from_user(struct task_struct *task,
+					void __user *from)
+{
+	return __copy_from_user(task->thread.fpr, from,
+			      ELF_NFPREG * sizeof(double));
+}
+#endif
+
 /*
  * Set up the sigcontext for the signal frame.
  */
@@ -89,10 +158,6 @@ static long setup_sigcontext(struct sigc
 #endif
 	unsigned long msr = regs->msr;
 	long err = 0;
-#ifdef CONFIG_VSX
-	double buf[FP_REGS_SIZE];
-	int i;
-#endif
 
 	flush_fp_to_thread(current);
 
@@ -117,12 +182,9 @@ static long setup_sigcontext(struct sigc
 	err |= __put_user(0, &sc->v_regs);
 #endif /* CONFIG_ALTIVEC */
 	flush_fp_to_thread(current);
+	/* copy fpr regs and fpscr */
+	err |= copy_fpr_to_user(&sc->fp_regs, current);
 #ifdef CONFIG_VSX
-	/* Copy FP to local buffer then write that out */
-	for (i = 0; i < 32 ; i++)
-		buf[i] = current->thread.TS_FPR(i);
-	memcpy(&buf[i], &current->thread.fpscr, sizeof(double));
-	err |= __copy_to_user(&sc->fp_regs, buf, FP_REGS_SIZE);
 	/*
 	 * Copy VSX low doubleword to local buffer for formatting,
 	 * then out to userspace.  Update v_regs to point after the
@@ -131,17 +193,12 @@ static long setup_sigcontext(struct sigc
 	if (current->thread.used_vsr) {
 		flush_vsx_to_thread(current);
 		v_regs += ELF_NVRREG;
-		for (i = 0; i < 32 ; i++)
-			buf[i] = current->thread.fpr[i][TS_VSRLOWOFFSET];
-		err |= __copy_to_user(v_regs, buf, 32 * sizeof(double));
+		err |= copy_vsx_to_user(v_regs, current);
 		/* set MSR_VSX in the MSR value in the frame to
 		 * indicate that sc->vs_reg) contains valid data.
 		 */
 		msr |= MSR_VSX;
 	}
-#else /* CONFIG_VSX */
-	/* copy fpr regs and fpscr */
-	err |= __copy_to_user(&sc->fp_regs, &current->thread.fpr, FP_REGS_SIZE);
 #endif /* CONFIG_VSX */
 	err |= __put_user(&sc->gp_regs, &sc->regs);
 	WARN_ON(!FULL_REGS(regs));
@@ -165,13 +222,12 @@ static long restore_sigcontext(struct pt
 #ifdef CONFIG_ALTIVEC
 	elf_vrreg_t __user *v_regs;
 #endif
-#ifdef CONFIG_VSX
-	double buf[FP_REGS_SIZE];
-	int i;
-#endif
 	unsigned long err = 0;
 	unsigned long save_r13 = 0;
 	unsigned long msr;
+#ifdef CONFIG_VSX
+	int i;
+#endif
 
 	/* If this is not a signal return, we preserve the TLS in r13 */
 	if (!sig)
@@ -234,15 +290,9 @@ static long restore_sigcontext(struct pt
 	else
 		current->thread.vrsave = 0;
 #endif /* CONFIG_ALTIVEC */
-#ifdef CONFIG_VSX
 	/* restore floating point */
-	err |= __copy_from_user(buf, &sc->fp_regs, FP_REGS_SIZE);
-	if (err)
-		return err;
-	for (i = 0; i < 32 ; i++)
-		current->thread.TS_FPR(i) = buf[i];
-	memcpy(&current->thread.fpscr, &buf[i], sizeof(double));
-
+	err |= copy_fpr_from_user(current, &sc->fp_regs);
+#ifdef CONFIG_VSX
 	/*
 	 * Get additional VSX data. Update v_regs to point after the
 	 * VMX data.  Copy VSX low doubleword from userspace to local
@@ -250,14 +300,12 @@ static long restore_sigcontext(struct pt
 	 */
 	v_regs += ELF_NVRREG;
 	if ((msr & MSR_VSX) != 0)
-		err |= __copy_from_user(buf, v_regs, 32 * sizeof(double));
+		err |= copy_vsx_from_user(current, v_regs);
 	else
-		memset(buf, 0, 32 * sizeof(double));
+		for (i = 0; i < 32 ; i++)
+			current->thread.fpr[i][TS_VSRLOWOFFSET] = 0;
 
-	for (i = 0; i < 32 ; i++)
-		current->thread.fpr[i][TS_VSRLOWOFFSET] = buf[i];
 #else
-	err |= __copy_from_user(&current->thread.fpr, &sc->fp_regs, FP_REGS_SIZE);
 #endif
 	return err;
 }

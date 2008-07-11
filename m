Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: fix giveup_vsx to save registers correctly
Date: Fri, 11 Jul 2008 16:29:12 +1000
Message-ID: <18384.1215757752@neuling.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

giveup_vsx didn't save the FPU and VMX regsiters.  Change it to be
like giveup_fpr/altivec which save these registers.

Also update call sites where FPU and VMX are already saved to use the
original giveup_vsx (renamed to __giveup_vsx).

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
benh: for your 2.6.27 tree.

 arch/powerpc/kernel/misc_64.S   |    8 ++++----
 arch/powerpc/kernel/process.c   |   10 +++++++++-
 arch/powerpc/kernel/signal_32.c |    2 +-
 arch/powerpc/kernel/signal_64.c |    2 +-
 include/asm-powerpc/system.h    |    1 +
 5 files changed, 16 insertions(+), 7 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/misc_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/misc_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/misc_64.S
@@ -508,12 +508,12 @@ _GLOBAL(giveup_altivec)
 
 #ifdef CONFIG_VSX
 /*
- * giveup_vsx(tsk)
- * Disable VSX for the task given as the argument,
- * and save the vector registers in its thread_struct.
+ * __giveup_vsx(tsk)
+ * Disable VSX for the task given as the argument.
+ * Does NOT save vsx registers.
  * Enables the VSX for use in the kernel on return.
  */
-_GLOBAL(giveup_vsx)
+_GLOBAL(__giveup_vsx)
 	mfmsr	r5
 	oris	r5,r5,MSR_VSX@h
 	mtmsrd	r5			/* enable use of VSX now */
Index: linux-2.6-ozlabs/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/process.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/process.c
@@ -159,6 +159,13 @@ void enable_kernel_vsx(void)
 EXPORT_SYMBOL(enable_kernel_vsx);
 #endif
 
+void giveup_vsx(struct task_struct *tsk)
+{
+	giveup_fpu(tsk);
+	giveup_altivec(tsk);
+	__giveup_vsx(tsk);
+}
+
 void flush_vsx_to_thread(struct task_struct *tsk)
 {
 	if (tsk->thread.regs) {
@@ -290,7 +297,8 @@ struct task_struct *__switch_to(struct t
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
 	if (prev->thread.regs && (prev->thread.regs->msr & MSR_VSX))
-		giveup_vsx(prev);
+		/* VMX and FPU registers are already save here */
+		__giveup_vsx(prev);
 #endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	/*
Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_32.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
@@ -452,7 +452,7 @@ static int save_user_regs(struct pt_regs
 	 * contains valid data
 	 */
 	if (current->thread.used_vsr) {
-		flush_vsx_to_thread(current);
+		__giveup_vsx(current);
 		if (copy_vsx_to_user(&frame->mc_vsregs, current))
 			return 1;
 		msr |= MSR_VSX;
Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_64.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
@@ -122,7 +122,7 @@ static long setup_sigcontext(struct sigc
 	 * VMX data.
 	 */
 	if (current->thread.used_vsr) {
-		flush_vsx_to_thread(current);
+		__giveup_vsx(current);
 		v_regs += ELF_NVRREG;
 		err |= copy_vsx_to_user(v_regs, current);
 		/* set MSR_VSX in the MSR value in the frame to
Index: linux-2.6-ozlabs/include/asm-powerpc/system.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/system.h
+++ linux-2.6-ozlabs/include/asm-powerpc/system.h
@@ -139,6 +139,7 @@ extern void enable_kernel_altivec(void);
 extern void giveup_altivec(struct task_struct *);
 extern void load_up_altivec(struct task_struct *);
 extern int emulate_altivec(struct pt_regs *);
+extern void __giveup_vsx(struct task_struct *);
 extern void giveup_vsx(struct task_struct *);
 extern void enable_kernel_spe(void);
 extern void giveup_spe(struct task_struct *);

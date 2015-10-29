Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 113131A0C87
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 12:05:45 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com, scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/19] powerpc: Move part of giveup_vsx into c
Date: Thu, 29 Oct 2015 11:44:02 +1100
Message-Id: <1446079451-8774-11-git-send-email-anton@samba.org>
In-Reply-To: <1446079451-8774-1-git-send-email-anton@samba.org>
References: <1446079451-8774-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the MSR modification into c. Removing it from the assembly
function will allow us to avoid costly MSR writes by batching them
up.

Check the FP and VMX bits before calling the relevant giveup_*()
function. This makes giveup_vsx() and flush_vsx_to_thread() perform
more like their sister functions, and allows us to use
flush_vsx_to_thread() in the signal code.

Move the check_if_tm_restore_required() check in.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/process.c   | 28 +++++++++++++++++++---------
 arch/powerpc/kernel/signal_32.c |  4 ++--
 arch/powerpc/kernel/signal_64.c |  4 ++--
 arch/powerpc/kernel/vector.S    |  6 ------
 4 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 6bcf82b..0cb6276 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -205,6 +205,25 @@ EXPORT_SYMBOL_GPL(flush_altivec_to_thread);
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef CONFIG_VSX
+void giveup_vsx(struct task_struct *tsk)
+{
+	u64 oldmsr = mfmsr();
+	u64 newmsr;
+
+	check_if_tm_restore_required(tsk);
+
+	newmsr = oldmsr | (MSR_FP|MSR_VEC|MSR_VSX);
+	if (oldmsr != newmsr)
+		mtmsr_isync(newmsr);
+
+	if (tsk->thread.regs->msr & MSR_FP)
+		__giveup_fpu(tsk);
+	if (tsk->thread.regs->msr & MSR_VEC)
+		__giveup_altivec(tsk);
+	__giveup_vsx(tsk);
+}
+EXPORT_SYMBOL(giveup_vsx);
+
 void enable_kernel_vsx(void)
 {
 	WARN_ON(preemptible());
@@ -220,15 +239,6 @@ void enable_kernel_vsx(void)
 }
 EXPORT_SYMBOL(enable_kernel_vsx);
 
-void giveup_vsx(struct task_struct *tsk)
-{
-	check_if_tm_restore_required(tsk);
-	giveup_fpu(tsk);
-	giveup_altivec(tsk);
-	__giveup_vsx(tsk);
-}
-EXPORT_SYMBOL(giveup_vsx);
-
 void flush_vsx_to_thread(struct task_struct *tsk)
 {
 	if (tsk->thread.regs) {
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 3cd7a32..4022cbb 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -458,7 +458,7 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 	 * contains valid data
 	 */
 	if (current->thread.used_vsr && ctx_has_vsx_region) {
-		__giveup_vsx(current);
+		flush_vsx_to_thread(current);
 		if (copy_vsx_to_user(&frame->mc_vsregs, current))
 			return 1;
 		msr |= MSR_VSX;
@@ -606,7 +606,7 @@ static int save_tm_user_regs(struct pt_regs *regs,
 	 * contains valid data
 	 */
 	if (current->thread.used_vsr) {
-		__giveup_vsx(current);
+		flush_vsx_to_thread(current);
 		if (copy_vsx_to_user(&frame->mc_vsregs, current))
 			return 1;
 		if (msr & MSR_VSX) {
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 6f2b555..3b23399 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -147,7 +147,7 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	 * VMX data.
 	 */
 	if (current->thread.used_vsr && ctx_has_vsx_region) {
-		__giveup_vsx(current);
+		flush_vsx_to_thread(current);
 		v_regs += ELF_NVRREG;
 		err |= copy_vsx_to_user(v_regs, current);
 		/* set MSR_VSX in the MSR value in the frame to
@@ -270,7 +270,7 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	 * VMX data.
 	 */
 	if (current->thread.used_vsr) {
-		__giveup_vsx(current);
+		flush_vsx_to_thread(current);
 		v_regs += ELF_NVRREG;
 		tm_v_regs += ELF_NVRREG;
 
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 6e925b4..98675b0 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -177,14 +177,8 @@ _GLOBAL(load_up_vsx)
  * __giveup_vsx(tsk)
  * Disable VSX for the task given as the argument.
  * Does NOT save vsx registers.
- * Enables the VSX for use in the kernel on return.
  */
 _GLOBAL(__giveup_vsx)
-	mfmsr	r5
-	oris	r5,r5,MSR_VSX@h
-	mtmsrd	r5			/* enable use of VSX now */
-	isync
-
 	addi	r3,r3,THREAD		/* want THREAD of task */
 	ld	r5,PT_REGS(r3)
 	cmpdi	0,r5,0
-- 
2.5.0

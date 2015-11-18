Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BFD81A072C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 14:28:59 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 123B414145F
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:58 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 18 Nov 2015 13:28:58 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 09C833578057
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:56 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAI3Sf8026870012
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:49 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAI3SNF9002276
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:23 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, anton@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 6/8] powerpc: Add the ability to save FPU without giving it up
Date: Wed, 18 Nov 2015 14:26:53 +1100
Message-Id: <1447817215-15804-7-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
References: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the ability to be able to save the FPU registers to the
thread struct without giving up (disabling the facility) next time the
process returns to userspace.

This patch optimises the thread copy path (as a result of a fork() or
clone()) so that the parent thread can return to userspace with hot
registers avoiding a possibly pointless reload of FPU register state.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/switch_to.h |  2 +-
 arch/powerpc/kernel/fpu.S            | 21 ++++------------
 arch/powerpc/kernel/process.c        | 46 +++++++++++++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 171ce13..8cf7fd6 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -28,7 +28,7 @@ extern void giveup_all(struct task_struct *);
 extern void enable_kernel_fp(void);
 extern void flush_fp_to_thread(struct task_struct *);
 extern void giveup_fpu(struct task_struct *);
-extern void __giveup_fpu(struct task_struct *);
+extern void save_fpu(struct task_struct *);
 static inline void disable_kernel_fp(void)
 {
 	msr_check_and_clear(MSR_FP);
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index b063524..15da2b5 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -143,33 +143,20 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	blr
 
 /*
- * __giveup_fpu(tsk)
- * Disable FP for the task given as the argument,
- * and save the floating-point registers in its thread_struct.
+ * save_fpu(tsk)
+ * Save the floating-point registers in its thread_struct.
  * Enables the FPU for use in the kernel on return.
  */
-_GLOBAL(__giveup_fpu)
+_GLOBAL(save_fpu)
 	addi	r3,r3,THREAD	        /* want THREAD of task */
 	PPC_LL	r6,THREAD_FPSAVEAREA(r3)
 	PPC_LL	r5,PT_REGS(r3)
 	PPC_LCMPI	0,r6,0
 	bne	2f
 	addi	r6,r3,THREAD_FPSTATE
-2:	PPC_LCMPI	0,r5,0
-	SAVE_32FPVSRS(0, R4, R6)
+2:	SAVE_32FPVSRS(0, R4, R6)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r6)
-	beq	1f
-	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	li	r3,MSR_FP|MSR_FE0|MSR_FE1
-#ifdef CONFIG_VSX
-BEGIN_FTR_SECTION
-	oris	r3,r3,MSR_VSX@h
-END_FTR_SECTION_IFSET(CPU_FTR_VSX)
-#endif
-	andc	r4,r4,r3		/* disable FP for previous task */
-	PPC_STL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
 	blr
 
 /*
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index c602b67..51e246a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -133,6 +133,16 @@ void __msr_check_and_clear(unsigned long bits)
 EXPORT_SYMBOL(__msr_check_and_clear);
 
 #ifdef CONFIG_PPC_FPU
+void __giveup_fpu(struct task_struct *tsk)
+{
+	save_fpu(tsk);
+	tsk->thread.regs->msr &= ~MSR_FP;
+#ifdef CONFIG_VSX
+	if (cpu_has_feature(CPU_FTR_VSX))
+		tsk->thread.regs->msr &= ~MSR_VSX;
+#endif
+}
+
 void giveup_fpu(struct task_struct *tsk)
 {
 	check_if_tm_restore_required(tsk);
@@ -413,12 +423,46 @@ void restore_math(struct pt_regs *regs)
 	regs->msr = msr;
 }
 
+void save_all(struct task_struct *tsk)
+{
+	unsigned long usermsr;
+
+	if (!tsk->thread.regs)
+		return;
+
+	usermsr = tsk->thread.regs->msr;
+
+	if ((usermsr & msr_all_available) == 0)
+		return;
+
+	msr_check_and_set(msr_all_available);
+
+#ifdef CONFIG_PPC_FPU
+	if (usermsr & MSR_FP)
+		save_fpu(tsk);
+#endif
+#ifdef CONFIG_ALTIVEC
+	if (usermsr & MSR_VEC)
+		__giveup_altivec(tsk);
+#endif
+#ifdef CONFIG_VSX
+	if (usermsr & MSR_VSX)
+		__giveup_vsx(tsk);
+#endif
+#ifdef CONFIG_SPE
+	if (usermsr & MSR_SPE)
+		__giveup_spe(tsk);
+#endif
+
+	msr_check_and_clear(msr_all_available);
+}
+
 void flush_all_to_thread(struct task_struct *tsk)
 {
 	if (tsk->thread.regs) {
 		preempt_disable();
 		BUG_ON(tsk != current);
-		giveup_all(tsk);
+		save_all(tsk);
 
 #ifdef CONFIG_SPE
 		if (tsk->thread.regs->msr & MSR_SPE)
-- 
2.6.2

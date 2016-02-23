Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6047F1A0764
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 14:40:22 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 197D2140B9C
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:40:22 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 23 Feb 2016 13:40:21 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 43E2C2BB0057
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:40:18 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N3eAx248365818
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:40:18 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N3djq3016509
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:45 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH v5 7/9] powerpc: Add the ability to save FPU without giving it
 up
Date: Tue, 23 Feb 2016 14:38:20 +1100
Message-Id: <1456198702-29657-8-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1456198702-29657-1-git-send-email-cyrilbur@gmail.com>
References: <1456198702-29657-1-git-send-email-cyrilbur@gmail.com>
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
 arch/powerpc/include/asm/switch_to.h |  3 ++-
 arch/powerpc/kernel/fpu.S            | 21 ++++-----------------
 arch/powerpc/kernel/process.c        | 12 +++++++++++-
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 3690041..6a201e8 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -28,13 +28,14 @@ extern void giveup_all(struct task_struct *);
 extern void enable_kernel_fp(void);
 extern void flush_fp_to_thread(struct task_struct *);
 extern void giveup_fpu(struct task_struct *);
-extern void __giveup_fpu(struct task_struct *);
+extern void save_fpu(struct task_struct *);
 static inline void disable_kernel_fp(void)
 {
 	msr_check_and_clear(MSR_FP);
 }
 #else
 static inline void __giveup_fpu(struct task_struct *t) { }
+static inline void save_fpu(struct task_struct *t) { }
 static inline void flush_fp_to_thread(struct task_struct *t) { }
 #endif
 
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
index 29da07f..a7e5061 100644
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
@@ -459,7 +469,7 @@ void save_all(struct task_struct *tsk)
 	msr_check_and_set(msr_all_available);
 
 	if (usermsr & MSR_FP)
-		__giveup_fpu(tsk);
+		save_fpu(tsk);
 
 	if (usermsr & MSR_VEC)
 		__giveup_altivec(tsk);
-- 
2.7.1

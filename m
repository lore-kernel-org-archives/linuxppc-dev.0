Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 046FF1A05F4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 14:40:22 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B2DEA140B9C
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:40:21 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 23 Feb 2016 13:40:20 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4E3B73578056
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:40:18 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N3eA4065929448
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:40:18 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N3djS6016504
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:45 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH v5 8/9] powerpc: Add the ability to save Altivec without
 giving it up
Date: Tue, 23 Feb 2016 14:38:21 +1100
Message-Id: <1456198702-29657-9-git-send-email-cyrilbur@gmail.com>
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

This patch adds the ability to be able to save the VEC registers to the
thread struct without giving up (disabling the facility) next time the
process returns to userspace.

This patch builds on a previous optimisation for the FPU registers in the
thread copy path to avoid a possibly pointless reload of VEC state.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/switch_to.h |  3 ++-
 arch/powerpc/kernel/process.c        | 12 +++++++++++-
 arch/powerpc/kernel/vector.S         | 24 ++++--------------------
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 6a201e8..9028822 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -43,12 +43,13 @@ static inline void flush_fp_to_thread(struct task_struct *t) { }
 extern void enable_kernel_altivec(void);
 extern void flush_altivec_to_thread(struct task_struct *);
 extern void giveup_altivec(struct task_struct *);
-extern void __giveup_altivec(struct task_struct *);
+extern void save_altivec(struct task_struct *);
 static inline void disable_kernel_altivec(void)
 {
 	msr_check_and_clear(MSR_VEC);
 }
 #else
+static inline void save_altivec(struct task_struct *t) { }
 static inline void __giveup_altivec(struct task_struct *t) { }
 #endif
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a7e5061..14c09d2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -213,6 +213,16 @@ static int restore_fp(struct task_struct *tsk) { return 0; }
 #ifdef CONFIG_ALTIVEC
 #define loadvec(thr) ((thr).load_vec)
 
+static void __giveup_altivec(struct task_struct *tsk)
+{
+	save_altivec(tsk);
+	tsk->thread.regs->msr &= ~MSR_VEC;
+#ifdef CONFIG_VSX
+	if (cpu_has_feature(CPU_FTR_VSX))
+		tsk->thread.regs->msr &= ~MSR_VSX;
+#endif
+}
+
 void giveup_altivec(struct task_struct *tsk)
 {
 	check_if_tm_restore_required(tsk);
@@ -472,7 +482,7 @@ void save_all(struct task_struct *tsk)
 		save_fpu(tsk);
 
 	if (usermsr & MSR_VEC)
-		__giveup_altivec(tsk);
+		save_altivec(tsk);
 
 	if (usermsr & MSR_VSX)
 		__giveup_vsx(tsk);
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 038cff8..51b0c17 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -106,36 +106,20 @@ _GLOBAL(load_up_altivec)
 	blr
 
 /*
- * __giveup_altivec(tsk)
- * Disable VMX for the task given as the argument,
- * and save the vector registers in its thread_struct.
+ * save_altivec(tsk)
+ * Save the vector registers to its thread_struct
  */
-_GLOBAL(__giveup_altivec)
+_GLOBAL(save_altivec)
 	addi	r3,r3,THREAD		/* want THREAD of task */
 	PPC_LL	r7,THREAD_VRSAVEAREA(r3)
 	PPC_LL	r5,PT_REGS(r3)
 	PPC_LCMPI	0,r7,0
 	bne	2f
 	addi	r7,r3,THREAD_VRSTATE
-2:	PPC_LCMPI	0,r5,0
-	SAVE_32VRS(0,r4,r7)
+2:	SAVE_32VRS(0,r4,r7)
 	mfvscr	v0
 	li	r4,VRSTATE_VSCR
 	stvx	v0,r4,r7
-	beq	1f
-	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
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
-	PPC_STL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
 	blr
 
 #ifdef CONFIG_VSX
-- 
2.7.1

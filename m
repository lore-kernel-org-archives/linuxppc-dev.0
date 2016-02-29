Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 92FE01A0BA9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 17:55:53 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 689781402BC
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:55:53 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Mon, 29 Feb 2016 16:55:50 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C7E892CE8054
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:55:47 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1T6td2Q64159958
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:55:47 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1T6tFDs000961
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:55:15 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1T6tF2O032194
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:55:15 +1100
Received: from camb691.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 013D3A03B4
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:54:27 +1100 (AEDT)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 9/9] powerpc: Add the ability to save VSX without giving it up
Date: Mon, 29 Feb 2016 17:53:51 +1100
Message-Id: <1456728831-31862-10-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1456728831-31862-1-git-send-email-cyrilbur@gmail.com>
References: <1456728831-31862-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the ability to be able to save the VSX registers to the
thread struct without giving up (disabling the facility) next time the
process returns to userspace.

This patch builds on a previous optimisation for the FPU and VEC registers
in the thread copy path to avoid a possibly pointless reload of VSX state.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/switch_to.h |  4 ----
 arch/powerpc/kernel/ppc_ksyms.c      |  4 ----
 arch/powerpc/kernel/process.c        | 42 +++++++++++++++++++++++++-----------
 arch/powerpc/kernel/vector.S         | 17 ---------------
 4 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 9028822..17c8380 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -56,14 +56,10 @@ static inline void __giveup_altivec(struct task_struct *t) { }
 #ifdef CONFIG_VSX
 extern void enable_kernel_vsx(void);
 extern void flush_vsx_to_thread(struct task_struct *);
-extern void giveup_vsx(struct task_struct *);
-extern void __giveup_vsx(struct task_struct *);
 static inline void disable_kernel_vsx(void)
 {
 	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
 }
-#else
-static inline void __giveup_vsx(struct task_struct *t) { }
 #endif
 
 #ifdef CONFIG_SPE
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 41e1607..ef7024da 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -28,10 +28,6 @@ EXPORT_SYMBOL(load_vr_state);
 EXPORT_SYMBOL(store_vr_state);
 #endif
 
-#ifdef CONFIG_VSX
-EXPORT_SYMBOL_GPL(__giveup_vsx);
-#endif
-
 #ifdef CONFIG_EPAPR_PARAVIRT
 EXPORT_SYMBOL(epapr_hypercall_start);
 #endif
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 14c09d2..d7a9df5 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -280,19 +280,31 @@ static inline int restore_altivec(struct task_struct *tsk) { return 0; }
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef CONFIG_VSX
-void giveup_vsx(struct task_struct *tsk)
+static void __giveup_vsx(struct task_struct *tsk)
 {
-	check_if_tm_restore_required(tsk);
-
-	msr_check_and_set(MSR_FP|MSR_VEC|MSR_VSX);
 	if (tsk->thread.regs->msr & MSR_FP)
 		__giveup_fpu(tsk);
 	if (tsk->thread.regs->msr & MSR_VEC)
 		__giveup_altivec(tsk);
+	tsk->thread.regs->msr &= ~MSR_VSX;
+}
+
+static void giveup_vsx(struct task_struct *tsk)
+{
+	check_if_tm_restore_required(tsk);
+
+	msr_check_and_set(MSR_FP|MSR_VEC|MSR_VSX);
 	__giveup_vsx(tsk);
 	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
 }
-EXPORT_SYMBOL(giveup_vsx);
+
+static void save_vsx(struct task_struct *tsk)
+{
+	if (tsk->thread.regs->msr & MSR_FP)
+		save_fpu(tsk);
+	if (tsk->thread.regs->msr & MSR_VEC)
+		save_altivec(tsk);
+}
 
 void enable_kernel_vsx(void)
 {
@@ -335,6 +347,7 @@ static int restore_vsx(struct task_struct *tsk)
 }
 #else
 static inline int restore_vsx(struct task_struct *tsk) { return 0; }
+static inline void save_vsx(struct task_struct *tsk) { }
 #endif /* CONFIG_VSX */
 
 #ifdef CONFIG_SPE
@@ -478,14 +491,19 @@ void save_all(struct task_struct *tsk)
 
 	msr_check_and_set(msr_all_available);
 
-	if (usermsr & MSR_FP)
-		save_fpu(tsk);
-
-	if (usermsr & MSR_VEC)
-		save_altivec(tsk);
+	/*
+	 * Saving the way the register space is in hardware, save_vsx boils
+	 * down to a save_fpu() and save_altivec()
+	 */
+	if (usermsr & MSR_VSX) {
+		save_vsx(tsk);
+	} else {
+		if (usermsr & MSR_FP)
+			save_fpu(tsk);
 
-	if (usermsr & MSR_VSX)
-		__giveup_vsx(tsk);
+		if (usermsr & MSR_VEC)
+			save_altivec(tsk);
+	}
 
 	if (usermsr & MSR_SPE)
 		__giveup_spe(tsk);
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 51b0c17..1c2e7a3 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -151,23 +151,6 @@ _GLOBAL(load_up_vsx)
 	std	r12,_MSR(r1)
 	b	fast_exception_return
 
-/*
- * __giveup_vsx(tsk)
- * Disable VSX for the task given as the argument.
- * Does NOT save vsx registers.
- */
-_GLOBAL(__giveup_vsx)
-	addi	r3,r3,THREAD		/* want THREAD of task */
-	ld	r5,PT_REGS(r3)
-	cmpdi	0,r5,0
-	beq	1f
-	ld	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	lis	r3,MSR_VSX@h
-	andc	r4,r4,r3		/* disable VSX for previous task */
-	std	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
-	blr
-
 #endif /* CONFIG_VSX */
 
 
-- 
2.7.2

Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D26011A0963
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 14:29:09 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8EBAE141468
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:29:09 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 18 Nov 2015 13:29:08 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BDCD32BB0054
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:29:05 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAI3Sf6q35193078
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:49 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAI3SXAn028020
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:33 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, anton@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 8/8] powerpc: Add the ability to save VSX without giving it up
Date: Wed, 18 Nov 2015 14:26:55 +1100
Message-Id: <1447817215-15804-9-git-send-email-cyrilbur@gmail.com>
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

This patch adds the ability to be able to save the VSX registers to the
thread struct without giving up (disabling the facility) next time the
process returns to userspace.

This patch builds on a previous optimisation for the FPU and VEC registers
in the thread copy path to avoid a possibly pointless reload of VSX state.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/switch_to.h |  1 -
 arch/powerpc/kernel/ppc_ksyms.c      |  4 ----
 arch/powerpc/kernel/process.c        | 23 ++++++++++++++++++-----
 arch/powerpc/kernel/vector.S         | 17 -----------------
 4 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 372f297..15843d3 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -50,7 +50,6 @@ static inline void disable_kernel_altivec(void)
 extern void enable_kernel_vsx(void);
 extern void flush_vsx_to_thread(struct task_struct *);
 extern void giveup_vsx(struct task_struct *);
-extern void __giveup_vsx(struct task_struct *);
 static inline void disable_kernel_vsx(void)
 {
 	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
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
index 19e803a..e0bb3d7 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -248,20 +248,33 @@ EXPORT_SYMBOL_GPL(flush_altivec_to_thread);
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef CONFIG_VSX
-void giveup_vsx(struct task_struct *tsk)
+void __giveup_vsx(struct task_struct *tsk)
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
+void giveup_vsx(struct task_struct *tsk)
+{
+	check_if_tm_restore_required(tsk);
+
+	msr_check_and_set(MSR_FP|MSR_VEC|MSR_VSX);
 	__giveup_vsx(tsk);
 	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
 }
 EXPORT_SYMBOL(giveup_vsx);
 
+void save_vsx(struct task_struct *tsk)
+{
+	if (tsk->thread.regs->msr & MSR_FP)
+		save_fpu(tsk);
+	if (tsk->thread.regs->msr & MSR_VEC)
+		save_altivec(tsk);
+}
+
 void enable_kernel_vsx(void)
 {
 	WARN_ON(preemptible());
@@ -457,7 +470,7 @@ void save_all(struct task_struct *tsk)
 #endif
 #ifdef CONFIG_VSX
 	if (usermsr & MSR_VSX)
-		__giveup_vsx(tsk);
+		save_vsx(tsk);
 #endif
 #ifdef CONFIG_SPE
 	if (usermsr & MSR_SPE)
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
2.6.2

Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C013A1A074A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 14:29:09 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 72A6214145F
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:29:09 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 18 Nov 2015 13:29:08 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6FBFE2BB0052
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:29:05 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAI3SvPa53674024
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:29:05 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAI3SXFC002540
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:33 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, anton@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 7/8] powerpc: Add the ability to save Altivec without giving
 it up
Date: Wed, 18 Nov 2015 14:26:54 +1100
Message-Id: <1447817215-15804-8-git-send-email-cyrilbur@gmail.com>
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

This patch adds the ability to be able to save the VEC registers to the
thread struct without giving up (disabling the facility) next time the
process returns to userspace.

This patch builds on a previous optimisation for the FPU registers in the
thread copy path to avoid a possibly pointless reload of VEC state.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/switch_to.h |  2 +-
 arch/powerpc/kernel/process.c        | 12 +++++++++++-
 arch/powerpc/kernel/vector.S         | 24 ++++--------------------
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 8cf7fd6..372f297 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -39,7 +39,7 @@ static inline void disable_kernel_fp(void)
 extern void enable_kernel_altivec(void);
 extern void flush_altivec_to_thread(struct task_struct *);
 extern void giveup_altivec(struct task_struct *);
-extern void __giveup_altivec(struct task_struct *);
+extern void save_altivec(struct task_struct *);
 static inline void disable_kernel_altivec(void)
 {
 	msr_check_and_clear(MSR_VEC);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 51e246a..19e803a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -198,6 +198,16 @@ void enable_kernel_fp(void)
 EXPORT_SYMBOL(enable_kernel_fp);
 
 #ifdef CONFIG_ALTIVEC
+void __giveup_altivec(struct task_struct *tsk)
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
@@ -443,7 +453,7 @@ void save_all(struct task_struct *tsk)
 #endif
 #ifdef CONFIG_ALTIVEC
 	if (usermsr & MSR_VEC)
-		__giveup_altivec(tsk);
+		save_altivec(tsk);
 #endif
 #ifdef CONFIG_VSX
 	if (usermsr & MSR_VSX)
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
2.6.2

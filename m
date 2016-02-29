Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BDF51A09E7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 17:55:50 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EC8361402BC
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:55:49 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Mon, 29 Feb 2016 16:55:49 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 914DD2BB005A
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:55:47 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1T6tdYf17367110
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:55:47 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1T6tFxs000950
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:55:15 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1T6tFcN032186
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:55:15 +1100
Received: from camb691.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id CD2DAA03B0
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:54:26 +1100 (AEDT)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/9] powerpc: Prepare for splitting giveup_{fpu, altivec,
 vsx} in two
Date: Mon, 29 Feb 2016 17:53:48 +1100
Message-Id: <1456728831-31862-7-git-send-email-cyrilbur@gmail.com>
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

This prepares for the decoupling of saving {fpu,altivec,vsx} registers and
marking {fpu,altivec,vsx} as being unused by a thread.

Currently giveup_{fpu,altivec,vsx}() does both however optimisations to
task switching can be made if these two operations are decoupled.
save_all() will permit the saving of registers to thread structs and leave
threads MSR with bits enabled.

This patch introduces no functional change.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/reg.h       |  8 ++++++++
 arch/powerpc/include/asm/switch_to.h |  7 +++++++
 arch/powerpc/kernel/process.c        | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c4cb2ff..d07b110 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -75,6 +75,14 @@
 #define MSR_HV		0
 #endif
 
+/*
+ * To be used in shared book E/book S, this avoids needing to worry about
+ * book S/book E in shared code
+ */
+#ifndef MSR_SPE
+#define MSR_SPE 	0
+#endif
+
 #define MSR_VEC		__MASK(MSR_VEC_LG)	/* Enable AltiVec */
 #define MSR_VSX		__MASK(MSR_VSX_LG)	/* Enable VSX */
 #define MSR_POW		__MASK(MSR_POW_LG)	/* Enable Power Management */
diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 5b268b6..3690041 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -34,6 +34,7 @@ static inline void disable_kernel_fp(void)
 	msr_check_and_clear(MSR_FP);
 }
 #else
+static inline void __giveup_fpu(struct task_struct *t) { }
 static inline void flush_fp_to_thread(struct task_struct *t) { }
 #endif
 
@@ -46,6 +47,8 @@ static inline void disable_kernel_altivec(void)
 {
 	msr_check_and_clear(MSR_VEC);
 }
+#else
+static inline void __giveup_altivec(struct task_struct *t) { }
 #endif
 
 #ifdef CONFIG_VSX
@@ -57,6 +60,8 @@ static inline void disable_kernel_vsx(void)
 {
 	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
 }
+#else
+static inline void __giveup_vsx(struct task_struct *t) { }
 #endif
 
 #ifdef CONFIG_SPE
@@ -68,6 +73,8 @@ static inline void disable_kernel_spe(void)
 {
 	msr_check_and_clear(MSR_SPE);
 }
+#else
+static inline void __giveup_spe(struct task_struct *t) { }
 #endif
 
 static inline void clear_task_ebb(struct task_struct *t)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 55c1eb0..29da07f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -444,12 +444,41 @@ void restore_math(struct pt_regs *regs)
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
+	if (usermsr & MSR_FP)
+		__giveup_fpu(tsk);
+
+	if (usermsr & MSR_VEC)
+		__giveup_altivec(tsk);
+
+	if (usermsr & MSR_VSX)
+		__giveup_vsx(tsk);
+
+	if (usermsr & MSR_SPE)
+		__giveup_spe(tsk);
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
2.7.2

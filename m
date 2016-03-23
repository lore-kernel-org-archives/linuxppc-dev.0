Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVJXH2VvNzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 16:48:47 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qVJXG5n3Qz9t3c
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 16:48:46 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 23 Mar 2016 15:48:46 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 716E92CE8054
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 16:48:40 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2N5mWUU66912506
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 16:48:40 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2N5m7kD006567
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 16:48:07 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org
Subject: [PATCH 4/5] powerpc: Move flush_all_to_thread() below save_sprs()
Date: Wed, 23 Mar 2016 16:47:04 +1100
Message-Id: <1458712025-3525-4-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1458712025-3525-1-git-send-email-cyrilbur@gmail.com>
References: <1458712025-3525-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 56444a6..7625976 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -511,23 +511,6 @@ void save_all(struct task_struct *tsk)
 	msr_check_and_clear(msr_all_available);
 }
 
-void flush_all_to_thread(struct task_struct *tsk)
-{
-	if (tsk->thread.regs) {
-		preempt_disable();
-		BUG_ON(tsk != current);
-		save_all(tsk);
-
-#ifdef CONFIG_SPE
-		if (tsk->thread.regs->msr & MSR_SPE)
-			tsk->thread.spefscr = mfspr(SPRN_SPEFSCR);
-#endif
-
-		preempt_enable();
-	}
-}
-EXPORT_SYMBOL(flush_all_to_thread);
-
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 void do_send_trap(struct pt_regs *regs, unsigned long address,
 		  unsigned long error_code, int signal_code, int breakpt)
@@ -1047,6 +1030,23 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 #endif
 }
 
+void flush_all_to_thread(struct task_struct *tsk)
+{
+	if (tsk->thread.regs) {
+		preempt_disable();
+		BUG_ON(tsk != current);
+		save_all(tsk);
+
+#ifdef CONFIG_SPE
+		if (tsk->thread.regs->msr & MSR_SPE)
+			tsk->thread.spefscr = mfspr(SPRN_SPEFSCR);
+#endif
+
+		preempt_enable();
+	}
+}
+EXPORT_SYMBOL(flush_all_to_thread);
+
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
 {
-- 
2.7.4

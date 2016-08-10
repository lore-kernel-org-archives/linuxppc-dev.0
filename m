Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8Kqc4LYJzDqRR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 15:45:16 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7A5cmDX020035
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 01:45:14 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9scrhj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 01:45:14 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 10 Aug 2016 15:45:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 80C0C2BB005D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 15:45:09 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7A5j9w428770460
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 15:45:09 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7A5j9Jh013807
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 15:45:09 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: ptrace: tm_reclaim_current() in
 flush_tmregs_to_thread()
Date: Wed, 10 Aug 2016 15:44:46 +1000
Message-Id: <20160810054446.5624-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There was an assumption that flush_tmregs_to_thread() would only be
called for a task which is not current. And a warning could be shown
to indicate that current is being ptraced.

In the event of a core dump the current threads state is needed. This
means that flush_tmregs_to_thread() must do its best to flush even for
current.

This patch also moves flush_tmregs_to_thread() into ptrace.c as it is
only called from that file.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/switch_to.h |  8 --------
 arch/powerpc/kernel/process.c        | 20 --------------------
 arch/powerpc/kernel/ptrace.c         | 19 +++++++++++++++++++
 3 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 0a74ebe..17c8380 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -75,14 +75,6 @@ static inline void disable_kernel_spe(void)
 static inline void __giveup_spe(struct task_struct *t) { }
 #endif
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-extern void flush_tmregs_to_thread(struct task_struct *);
-#else
-static inline void flush_tmregs_to_thread(struct task_struct *t)
-{
-}
-#endif
-
 static inline void clear_task_ebb(struct task_struct *t)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 58ccf86..9ee2623 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1074,26 +1074,6 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 #endif
 }
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-void flush_tmregs_to_thread(struct task_struct *tsk)
-{
-	/*
-	 * Process self tracing is not yet supported through
-	 * ptrace interface. Ptrace generic code should have
-	 * prevented this from happening in the first place.
-	 * Warn once here with the message, if some how it
-	 * is attempted.
-	 */
-	WARN_ONCE(tsk == current,
-		"Not expecting ptrace on self: TM regs may be incorrect\n");
-
-	/*
-	 * If task is not current, it should have been flushed
-	 * already to it's thread_struct during __switch_to().
-	 */
-}
-#endif
-
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
 {
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 4f3c575..bf91658 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -38,6 +38,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/switch_to.h>
+#include <asm/tm.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -118,6 +119,24 @@ static const struct pt_regs_offset regoffset_table[] = {
 	REG_OFFSET_END,
 };
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+static void flush_tmregs_to_thread(struct task_struct *tsk)
+{
+	/*
+	 * If task is not current, it will have been flushed already to
+	 * it's thread_struct during __switch_to().
+	 *
+	 * A reclaim flushes ALL the state.
+	 */
+
+	if (tsk == current && MSR_TM_SUSPENDED(mfmsr()))
+		tm_reclaim_current(TM_CAUSE_SIGNAL);
+
+}
+#else
+static inline void flush_tmregs_to_thread(struct task_struct *tsk) { }
+#endif
+
 /**
  * regs_query_register_offset() - query register offset from its name
  * @name:	the name of a register
-- 
2.9.2

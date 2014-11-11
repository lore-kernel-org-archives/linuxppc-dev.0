Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 042381A0243
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 16:33:46 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CEA9D1400F1
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 16:33:45 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 11 Nov 2014 15:33:45 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 302BD3578066
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 16:27:04 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAB5QoO533947662
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 16:26:50 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAB5R1ZG030376
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 16:27:03 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V4 3/8] powerpc,
 process: Merge functions __switch_to_tm and tm_reclaim_task
Date: Tue, 11 Nov 2014 10:56:32 +0530
Message-Id: <1415683597-22819-4-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1415683597-22819-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1415683597-22819-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, peterz@infradead.org, palves@redhat.com,
 oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, tglx@linutronix.de,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function tm_reclaim_task is only called from the function
 __switch_to_tm. This patch merges these two functions to make
it more readable without changing the functionality in any way.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/process.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index c36477b..99b41ed 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -585,6 +585,10 @@ static inline void tm_reclaim_task(struct task_struct *tsk)
 	 */
 	struct thread_struct *thr = &tsk->thread;
 
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return;
+	tm_enable();
+
 	if (!thr->regs)
 		return;
 
@@ -696,14 +700,6 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
 		 new->pid, mfmsr());
 }
 
-static inline void __switch_to_tm(struct task_struct *prev)
-{
-	if (cpu_has_feature(CPU_FTR_TM)) {
-		tm_enable();
-		tm_reclaim_task(prev);
-	}
-}
-
 /*
  * This is called if we are on the way out to userspace and the
  * TIF_RESTORE_TM flag is set.  It checks if we need to reload
@@ -742,13 +738,13 @@ void restore_tm_state(struct pt_regs *regs)
 
 #else
 #define tm_recheckpoint_new_task(new)
-#define __switch_to_tm(prev)
+#define tm_reclaim_task(prev)
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 /*
  * flush_tm_state
  *
- * Flush TM state out so we can copy it.  __switch_to_tm() does this
+ * Flush TM state out so we can copy it.  tm_reclaim_task() does this
  * flush but it removes the checkpointed state from the current CPU and
  * transitions the CPU out of TM mode.  Hence we need to call
  * tm_recheckpoint_new_task() (on the same task) to restore the
@@ -756,7 +752,7 @@ void restore_tm_state(struct pt_regs *regs)
  */
 static void flush_tm_state(struct task_struct *src)
 {
-	__switch_to_tm(src);
+	tm_reclaim_task(src);
 	tm_recheckpoint_new_task(src);
 }
 
@@ -805,7 +801,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	 */
 	save_early_sprs(&prev->thread);
 
-	__switch_to_tm(prev);
+	tm_reclaim_task(prev);
 
 #ifdef CONFIG_SMP
 	/* avoid complexity of lazy save/restore of fpu
-- 
1.9.3

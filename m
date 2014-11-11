Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21F921A1E6E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 16:27:07 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9C1CC14017A
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 16:27:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 11 Nov 2014 15:27:05 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E8B8B2BB0054
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 16:26:59 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAB5QktT36962494
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 16:26:46 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAB5QvDn030231
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 16:26:59 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V4 2/8] powerpc, process: Add functions flush_tm_state,
 flush_tmregs_to_thread
Date: Tue, 11 Nov 2014 10:56:31 +0530
Message-Id: <1415683597-22819-3-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch creates a new function called flush_tm_state to flush
the existing transactional memory state from the thread. It also
creates a function called flush_tmregs_to_thread which will then
be used on subsequent patches in this series.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/switch_to.h |  8 ++++++
 arch/powerpc/kernel/process.c        | 49 +++++++++++++++++++++++++++++-------
 2 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 58abeda..23752a9 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -82,6 +82,14 @@ static inline void flush_spe_to_thread(struct task_struct *t)
 }
 #endif
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+extern void flush_tmregs_to_thread(struct task_struct *);
+#else
+static inline void flush_tmregs_to_thread(struct task_struct *t)
+{
+}
+#endif
+
 static inline void clear_task_ebb(struct task_struct *t)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index aa1df89..c36477b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -745,6 +745,45 @@ void restore_tm_state(struct pt_regs *regs)
 #define __switch_to_tm(prev)
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
+/*
+ * flush_tm_state
+ *
+ * Flush TM state out so we can copy it.  __switch_to_tm() does this
+ * flush but it removes the checkpointed state from the current CPU and
+ * transitions the CPU out of TM mode.  Hence we need to call
+ * tm_recheckpoint_new_task() (on the same task) to restore the
+ * checkpointed state back and the TM mode.
+ */
+static void flush_tm_state(struct task_struct *src)
+{
+	__switch_to_tm(src);
+	tm_recheckpoint_new_task(src);
+}
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+void flush_tmregs_to_thread(struct task_struct *tsk)
+{
+	/*
+	 * If task is not current, it should have been flushed
+	 * already to it's thread_struct during __switch_to().
+	 */
+	if (tsk != current)
+		return;
+
+	preempt_disable();
+	if (tsk->thread.regs) {
+		/*
+		 * If we are still current, the TM state need to
+		 * be flushed to thread_struct as it will be still
+		 * present in the current cpu.
+		 */
+		if (MSR_TM_ACTIVE(tsk->thread.regs->msr))
+			flush_tm_state(tsk);
+	}
+	preempt_enable();
+}
+#endif
+
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
 {
@@ -1079,15 +1118,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	flush_altivec_to_thread(src);
 	flush_vsx_to_thread(src);
 	flush_spe_to_thread(src);
-	/*
-	 * Flush TM state out so we can copy it.  __switch_to_tm() does this
-	 * flush but it removes the checkpointed state from the current CPU and
-	 * transitions the CPU out of TM mode.  Hence we need to call
-	 * tm_recheckpoint_new_task() (on the same task) to restore the
-	 * checkpointed state back and the TM mode.
-	 */
-	__switch_to_tm(src);
-	tm_recheckpoint_new_task(src);
+	flush_tm_state(src);
 
 	*dst = *src;
 
-- 
1.9.3

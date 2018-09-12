Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429XFY0mwpzF3Cq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 05:40:48 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CJYZZW105689
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:46 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mf7btmhnn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:46 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 12 Sep 2018 13:40:45 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, paulus@ozlabs.org, gromero@linux.vnet.ibm.com,
 mpe@ellerman.id.au, ldufour@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH 05/11] powerpc/tm: Function that updates the failure code
Date: Wed, 12 Sep 2018 16:40:13 -0300
In-Reply-To: <1536781219-13938-1-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
Message-Id: <1536781219-13938-6-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now the transaction reclaims happens very earlier in the trap handler, and
it is impossible to know precisely, at that early time, what should be set
as the failure cause for some specific cases, as, if the task will be
rescheduled, thus, the transaction abort case should be updated from
TM_CAUSE_MISC to TM_CAUSE_RESCHED, for example.

This patch creates a function that will update TEXASR special purpose
register in the task thread and set the failure code which will be
moved to the live register afterward.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/process.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 54fddf03b97a..fe063c0142e3 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -85,6 +85,7 @@ extern unsigned long _get_SP(void);
  * other paths that we should never reach with suspend disabled.
  */
 bool tm_suspend_disabled __ro_after_init = false;
+static void tm_fix_failure_cause(struct task_struct *task, uint8_t cause);
 
 static void check_if_tm_restore_required(struct task_struct *tsk)
 {
@@ -988,6 +989,14 @@ void tm_recheckpoint(struct thread_struct *thread)
 	local_irq_restore(flags);
 }
 
+/* Change thread->tm.texasr failure code */
+static void tm_fix_failure_cause(struct task_struct *task, uint8_t cause)
+{
+	/* Clear the cause first */
+	task->thread.tm_texasr &= ~TEXASR_FC;
+	task->thread.tm_texasr |= (unsigned long) cause << 56;
+}
+
 static inline void tm_recheckpoint_new_task(struct task_struct *new)
 {
 	if (!cpu_has_feature(CPU_FTR_TM))
-- 
2.19.0

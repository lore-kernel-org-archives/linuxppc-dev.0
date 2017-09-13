Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xslV95vq2zDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 01:10:56 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8DFA3gx101342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 11:10:54 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cy5d9dt84-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 11:10:53 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Wed, 13 Sep 2017 09:10:52 -0600
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: cyrilbur@gmail.com, mikey@neuling.org, sam.bobroff@au1.ibm.com,
 stable@vger.kernel.org
Subject: [PATCH] powerpc/tm: Flush TM only if CPU has TM feature
Date: Wed, 13 Sep 2017 11:10:21 -0400
Message-Id: <1505315421-13266-1-git-send-email-gromero@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit cd63f3cf1d59 ("powerpc/tm: Fix saving of TM SPRs in core dump")
added code to access TM SPRs in flush_tmregs_to_thread(). However
flush_tmregs_to_thread() does not check if TM feature is available on
CPU before trying to access TM SPRs in order to copy live state to
thread structures. flush_tmregs_to_thread() is indeed guarded by
CONFIG_PPC_TRANSACTIONAL_MEM but it might be the case that kernel
was compiled with CONFIG_PPC_TRANSACTIONAL_MEM enabled and ran on
a CPU without TM feature available, thus rendering the execution
of TM instructions that are treated by the CPU as illegal instructions.

The fix is just to add proper checking in flush_tmregs_to_thread()
if CPU has the TM feature before accessing any TM-specific resource,
returning immediately if TM is no available on the CPU. Adding
that checking in flush_tmregs_to_thread() instead of in places
where it is called, like in vsr_get() and vsr_set(), is better because
avoids the same problem cropping up elsewhere.

Cc: stable@vger.kernel.org # v4.13+
Fixes: cd63f3c ("powerpc/tm: Fix saving of TM SPRs in core dump")
Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 07cd22e..18f547f 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -124,6 +124,8 @@ static const struct pt_regs_offset regoffset_table[] = {
 static void flush_tmregs_to_thread(struct task_struct *tsk)
 {
 	/*
+	 * If CPU has no TM support, return.
+	 *
 	 * If task is not current, it will have been flushed already to
 	 * it's thread_struct during __switch_to().
 	 *
@@ -131,7 +133,7 @@ static void flush_tmregs_to_thread(struct task_struct *tsk)
 	 * in the appropriate thread structures from live.
 	 */
 
-	if (tsk != current)
+	if (!cpu_has_feature(CPU_FTR_TM) || tsk != current)
 		return;
 
 	if (MSR_TM_SUSPENDED(mfmsr())) {
-- 
2.7.4

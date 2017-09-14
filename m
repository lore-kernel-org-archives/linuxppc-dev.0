Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt2DJ6T3FzDqp4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 12:14:56 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8E2E2QU141407
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 22:14:54 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cye33x64d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 22:14:54 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Wed, 13 Sep 2017 22:14:53 -0400
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: cyrilbur@gmail.com, mikey@neuling.org, sam.bobroff@au1.ibm.com,
 stable@vger.kernel.org
Subject: [PATCH v2] powerpc/tm: Flush TM only if CPU has TM feature
Date: Wed, 13 Sep 2017 22:13:48 -0400
In-Reply-To: <1505315421-13266-1-git-send-email-gromero@linux.vnet.ibm.com>
References: <1505315421-13266-1-git-send-email-gromero@linux.vnet.ibm.com>
Message-Id: <1505355228-15039-1-git-send-email-gromero@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit cd63f3c ("powerpc/tm: Fix saving of TM SPRs in core dump")
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
 arch/powerpc/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 07cd22e..f52ad5b 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -131,7 +131,7 @@ static void flush_tmregs_to_thread(struct task_struct *tsk)
 	 * in the appropriate thread structures from live.
 	 */
 
-	if (tsk != current)
+	if ((!cpu_has_feature(CPU_FTR_TM)) || (tsk != current))
 		return;
 
 	if (MSR_TM_SUSPENDED(mfmsr())) {
-- 
2.7.4

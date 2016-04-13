Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlGt14pk8zDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 18:19:05 +1000 (AEST)
Date: Wed, 13 Apr 2016 18:17:38 +1000
From: Anton Blanchard <anton@samba.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, tglx@linutronix.de,
 efault@gmx.de, htejun@gmail.com, tj@kernel.org,
 torvalds@linux-foundation.org, zhaolei@cn.fujitsu.com,
 yangds.fnst@cn.fujitsu.com, hpa@zytor.com, Stephen Rothwell
 <sfr@canb.auug.org.au>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/cpuacct: Check for NULL when using task_pt_regs()
Message-ID: <20160413181738.5936e98a@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

task_pt_regs() can return NULL for kernel threads, so add a check.
This fixes an oops at boot on ppc64.

Fixes: d740037fac70 ("sched/cpuacct: Split usage accounting into user_usage and sys_usage")
Signed-off-by: Anton Blanchard <anton@samba.org>
Reported-and-Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index df947e0..41f85c4 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -316,12 +316,11 @@ static struct cftype files[] = {
 void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 {
 	struct cpuacct *ca;
-	int index;
+	int index = CPUACCT_USAGE_SYSTEM;
+	struct pt_regs *regs = task_pt_regs(tsk);
 
-	if (user_mode(task_pt_regs(tsk)))
+	if (regs && user_mode(regs))
 		index = CPUACCT_USAGE_USER;
-	else
-		index = CPUACCT_USAGE_SYSTEM;
 
 	rcu_read_lock();
 

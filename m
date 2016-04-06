Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qg47905zxzDq6S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 22:00:53 +1000 (AEST)
Date: Wed, 6 Apr 2016 21:59:50 +1000
From: Anton Blanchard <anton@samba.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Srikar Dronamraju
 <srikar@linux.vnet.ibm.com>, tglx@linutronix.de, efault@gmx.de,
 htejun@gmail.com, linux-kernel@vger.kernel.org, tj@kernel.org,
 torvalds@linux-foundation.org, zhaolei@cn.fujitsu.com,
 yangds.fnst@cn.fujitsu.com, hpa@zytor.com, Stephen Rothwell
 <sfr@canb.auug.org.au>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] sched/cpuacct: Check for NULL when using task_pt_regs()
Message-ID: <20160406215950.04bc3f0b@kryten>
In-Reply-To: <20160406110803.GI2906@worktop>
References: <aa171da036b520b51c79549e9b3215d29473f19d.1458635566.git.zhaolei@cn.fujitsu.com>
 <tip-d740037fac7052e49450f6fa1454f1144a103b55@git.kernel.org>
 <20160404140312.GA28495@linux.vnet.ibm.com>
 <20160406065436.GB3078@gmail.com> <20160406203219.788ae7cf@kryten>
 <20160406110803.GI2906@worktop>
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

Hi Peter,

> Ah, so sometihng like:
> 
> 	struct pt_regs *regs = task_pt_regs();
> 	int index = CPUACCT_USAGE_SYSTEM;
> 
> 	if (regs && user_mode(regs))
> 		index = CPUACCT_USAGE_USER;
> 
> should work, right?

Looks good, and the patch below does fix the oops for me.

Anton
--

task_pt_regs() can return NULL for kernel threads, so add a check.
This fixes an oops at boot on ppc64.

Signed-off-by: Anton Blanchard <anton@samba.org>
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
 

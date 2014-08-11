Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 239321A07EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 09:42:25 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 11 Aug 2014 17:42:22 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id AE44819D8039
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 17:42:09 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7BNgLZX20906076
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 01:42:21 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s7BNkaVf019818
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 17:46:37 -0600
Date: Mon, 11 Aug 2014 16:42:19 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 2/2] powerpc: Add ppc64 hard lockup detector support
Message-ID: <20140811234219.GH5821@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20140805145500.773004e9@kryten> <20140805145621.2fa2a372@kryten>
 <20140812093137.404e8930@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140812093137.404e8930@kryten>
Cc: mikey@neuling.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 12, 2014 at 09:31:37AM +1000, Anton Blanchard wrote:
> The hard lockup detector uses a PMU event as a periodic NMI to
> detect if we are stuck (where stuck means no timer interrupts have
> occurred).
> 
> Ben's rework of the ppc64 soft disable code has made ppc64 PMU
> exceptions a partial NMI. They can get disabled if an external interrupt
> comes in, but otherwise PMU interrupts will fire in interrupt disabled
> regions.
> 
> I wrote a kernel module to test this patch and noticed we sometimes
> missed hard lockup warnings. The RCU code detected the stall first and
> issued an IPI to backtrace all CPUs. Unfortunately an IPI is an external
> interrupt and that will hard disable interrupts, preventing the hard
> lockup detector from going off.

If it helps, commit bc1dce514e9b (rcu: Don't use NMIs to dump other
CPUs' stacks) makes RCU avoid this behavior.  It instead reads the
stacks out remotely when this commit is applied.  It is in -tip, and
should make mainline this merge window.  Corresponding patch below.

						Thanx, Paul

------------------------------------------------------------------------

rcu: Don't use NMIs to dump other CPUs' stacks

Although NMI-based stack dumps are in principle more accurate, they are
also more likely to trigger deadlocks.  This commit therefore replaces
all uses of trigger_all_cpu_backtrace() with rcu_dump_cpu_stacks(), so
that the CPU detecting an RCU CPU stall does the stack dumping.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Lai Jiangshan <laijs@cn.fujitsu.com>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3f93033d3c61..8f3e4d43d736 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1013,10 +1013,7 @@ static void record_gp_stall_check_time(struct rcu_state *rsp)
 }
 
 /*
- * Dump stacks of all tasks running on stalled CPUs.  This is a fallback
- * for architectures that do not implement trigger_all_cpu_backtrace().
- * The NMI-triggered stack traces are more accurate because they are
- * printed by the target CPU.
+ * Dump stacks of all tasks running on stalled CPUs.
  */
 static void rcu_dump_cpu_stacks(struct rcu_state *rsp)
 {
@@ -1094,7 +1091,7 @@ static void print_other_cpu_stall(struct rcu_state *rsp)
 	       (long)rsp->gpnum, (long)rsp->completed, totqlen);
 	if (ndetected == 0)
 		pr_err("INFO: Stall ended before state dump start\n");
-	else if (!trigger_all_cpu_backtrace())
+	else
 		rcu_dump_cpu_stacks(rsp);
 
 	/* Complain about tasks blocking the grace period. */
@@ -1125,8 +1122,7 @@ static void print_cpu_stall(struct rcu_state *rsp)
 	pr_cont(" (t=%lu jiffies g=%ld c=%ld q=%lu)\n",
 		jiffies - rsp->gp_start,
 		(long)rsp->gpnum, (long)rsp->completed, totqlen);
-	if (!trigger_all_cpu_backtrace())
-		dump_stack();
+	rcu_dump_cpu_stacks(rsp);
 
 	raw_spin_lock_irqsave(&rnp->lock, flags);
 	if (ULONG_CMP_GE(jiffies, ACCESS_ONCE(rsp->jiffies_stall)))

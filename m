Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 500A267E82
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 05:32:10 +1100 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: mingo@elte.hu
Subject: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in
	latency_trace.c (take 2)
Date: Mon, 13 Nov 2006 21:33:40 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611132133.40091.sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, khilman@mvista.com, linux-kernel@vger.kernel.org,
	dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In addition to the clock jump-back check being falsely triggered by clock wrap
with 32-bit cycles_t, as noticed by Kevin Hilman, there's another issue: using
%Lx format to print 32-bit values warrants erroneous values on 32-bit machines
like ARM and PPC32...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
PPC32 actually has 64-bit timebase counter, so could provide for 64-bit
cycles_t -- maybe it's worth to rewrite get_cycles() to read both lower and
upper registers?

 kernel/latency_trace.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/kernel/latency_trace.c
===================================================================
--- linux-2.6.orig/kernel/latency_trace.c
+++ linux-2.6/kernel/latency_trace.c
@@ -1623,8 +1623,8 @@ check_critical_timing(int cpu, struct cp
 #ifndef CONFIG_CRITICAL_LATENCY_HIST
 	if (!preempt_thresh && preempt_max_latency > delta) {
 		printk("bug: updating %016Lx > %016Lx?\n",
-			preempt_max_latency, delta);
-		printk("  [%016Lx %016Lx %016Lx]\n", T0, T1, T2);
+			(u64)preempt_max_latency, (u64)delta);
+		printk("  [%016Lx %016Lx %016Lx]\n", (u64)T0, (u64)T1, (u64)T2);
 	}
 #endif
 
@@ -2006,7 +2006,7 @@ check_wakeup_timing(struct cpu_trace *tr
 	____trace(smp_processor_id(), TRACE_FN, tr, CALLER_ADDR0, parent_eip, 0, 0, 0, *flags);
 	T2 = get_cycles();
 	if (T2 < T1)
-		printk("bug2: %016Lx < %016Lx!\n", T2, T1);
+		printk("bug2: %016Lx < %016Lx!\n", (u64)T2, (u64)T1);
 	delta = T2-T0;
 
 	latency = cycles_to_usecs(delta);
@@ -2023,8 +2023,8 @@ check_wakeup_timing(struct cpu_trace *tr
 #ifndef CONFIG_WAKEUP_LATENCY_HIST
 	if (!preempt_thresh && preempt_max_latency > delta) {
 		printk("bug2: updating %016Lx > %016Lx?\n",
-			preempt_max_latency, delta);
-		printk("  [%016Lx %016Lx %016Lx]\n", T0, T1, T2);
+			(u64)preempt_max_latency, (u64)delta);
+		printk("  [%016Lx %016Lx %016Lx]\n", (u64)T0, (u64)T1, (u64)T2);
 	}
 #endif
 

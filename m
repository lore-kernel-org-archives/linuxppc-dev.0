Return-Path: <anton@samba.org>
Date: Mon, 21 Mar 2011 12:28:03 +1100
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix accounting of softirq time when idle
Message-ID: <20110321122803.114d50c4@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


commit cf9efce0ce31 (powerpc: Account time using timebase rather
than PURR) used in_irq() to detect if the time was spent in
interrupt processing. This only catches hardirq context so if we
are in softirq context and in the idle loop we end up accounting it
as idle time. If we instead use in_interrupt() we catch both softirq
and hardirq time.

The issue was found when running a network intensive workload. top
showed the following:

0.0%us,  1.1%sy,  0.0%ni, 85.7%id,  0.0%wa,  9.9%hi,  3.3%si,  0.0%st

85.7% idle. But this was wildly different to the perf events data.
To confirm the suspicion I ran something to keep the core busy:

# yes > /dev/null &

8.2%us,  0.0%sy,  0.0%ni,  0.0%id,  0.0%wa, 10.3%hi, 81.4%si,  0.0%st

We only got 8.2% of the CPU for the userspace task and softirq has
shot up to 81.4%.

With the patch below top shows the correct stats:

0.0%us,  0.0%sy,  0.0%ni,  5.3%id,  0.0%wa, 13.3%hi, 81.3%si,  0.0%st

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@kernel.org
---

Index: linux-2.6/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/time.c	2011-03-21 12:05:12.056482258 +1100
+++ linux-2.6/arch/powerpc/kernel/time.c	2011-03-21 12:05:18.516721851 +1100
@@ -356,7 +356,7 @@ void account_system_vtime(struct task_st
 	}
 	get_paca()->user_time_scaled += user_scaled;
 
-	if (in_irq() || idle_task(smp_processor_id()) != tsk) {
+	if (in_interrupt() || idle_task(smp_processor_id()) != tsk) {
 		account_system_time(tsk, 0, delta, sys_scaled);
 		if (stolen)
 			account_steal_time(stolen);

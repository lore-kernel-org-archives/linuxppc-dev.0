Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 041441A0CFA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 16:28:11 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 19 Jan 2015 00:28:09 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id DA9186E8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 00:19:59 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0J5S73026149068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 05:28:07 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0J5S6X1001224
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 00:28:06 -0500
Subject: [PATCH] idle/tick-broadcast: Exit cpu idle poll loop when cleared
 from tick_broadcast_force_mask
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: tglx@linutronix.de
Date: Mon, 19 Jan 2015 10:57:54 +0530
Message-ID: <20150119052754.20256.54721.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An idle cpu enters cpu_idle_poll() if it is set in the tick_broadcast_force_mask.
This is so that it does not incur the overhead of entering idle states when it is expected
to be woken up anytime then through a broadcast IPI. The condition that forces an exit out
of the idle polling is the check on setting of the TIF_NEED_RESCHED flag for the idle thread.

When the broadcast IPI does arrive, it is not guarenteed that the handler sets the
TIF_NEED_RESCHED flag. Hence although the cpu is cleared in the tick_broadcast_force_mask,
it continues to loop in cpu_idle_poll unnecessarily wasting power. Hence exit the idle
poll loop if the tick_broadcast_force_mask gets cleared and enter idle states.

Of course if the cpu has entered cpu_idle_poll() on being asked to poll explicitly,
it continues to poll till it is asked to reschedule.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 kernel/sched/idle.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c47fce7..aaf1c1d 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -47,7 +47,8 @@ static inline int cpu_idle_poll(void)
 	rcu_idle_enter();
 	trace_cpu_idle_rcuidle(0, smp_processor_id());
 	local_irq_enable();
-	while (!tif_need_resched())
+	while (!tif_need_resched() &&
+		(cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 	rcu_idle_exit();

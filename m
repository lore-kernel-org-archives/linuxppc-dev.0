Return-Path: <sasha.levin@oracle.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2E861A0696
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2015 13:51:33 +1000 (AEST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 481AE1400B7
 for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2015 13:51:33 +1000 (AEST)
From: Sasha Levin <sasha.levin@oracle.com>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Subject: [added to the 3.18 stable tree] timers/tick/broadcast-hrtimer: Fix
 suspicious RCU usage in idle loop
Date: Sat, 25 Apr 2015 23:49:51 -0400
Message-Id: <1430020223-32000-8-git-send-email-sasha.levin@oracle.com>
In-Reply-To: <1430020223-32000-1-git-send-email-sasha.levin@oracle.com>
References: <1430020223-32000-1-git-send-email-sasha.levin@oracle.com>
Cc: "Peter Zijlstra \(Intel\)" <peterz@infradead.org>, linuxppc-dev@ozlabs.org,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Sasha Levin <sasha.levin@oracle.com>, tglx@linutronix.de,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Preeti U Murthy <preeti@linux.vnet.ibm.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit a127d2bcf1fbc8c8e0b5cf0dab54f7d3ff50ce47 ]

The hrtimer mode of broadcast queues hrtimers in the idle entry
path so as to wakeup cpus in deep idle states. The associated
call graph is :

	cpuidle_idle_call()
	|____ clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, ....))
	     |_____tick_broadcast_set_event()
		   |____clockevents_program_event()
			|____bc_set_next()

The hrtimer_{start/cancel} functions call into tracing which uses RCU.
But it is not legal to call into RCU in cpuidle because it is one of the
quiescent states. Hence protect this region with RCU_NONIDLE which informs
RCU that the cpu is momentarily non-idle.

As an aside it is helpful to point out that the clock event device that is
programmed here is not a per-cpu clock device; it is a
pseudo clock device, used by the broadcast framework alone.
The per-cpu clock device programming never goes through bc_set_next().

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au
Cc: tglx@linutronix.de
Link: http://lkml.kernel.org/r/20150318104705.17763.56668.stgit@preeti.in.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 kernel/time/tick-broadcast-hrtimer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index eb682d5..6aac4be 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -49,6 +49,7 @@ static void bc_set_mode(enum clock_event_mode mode,
  */
 static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 {
+	int bc_moved;
 	/*
 	 * We try to cancel the timer first. If the callback is on
 	 * flight on some other cpu then we let it handle it. If we
@@ -60,9 +61,15 @@ static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 	 * restart the timer because we are in the callback, but we
 	 * can set the expiry time and let the callback return
 	 * HRTIMER_RESTART.
+	 *
+	 * Since we are in the idle loop at this point and because
+	 * hrtimer_{start/cancel} functions call into tracing,
+	 * calls to these functions must be bound within RCU_NONIDLE.
 	 */
-	if (hrtimer_try_to_cancel(&bctimer) >= 0) {
-		hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED);
+	RCU_NONIDLE(bc_moved = (hrtimer_try_to_cancel(&bctimer) >= 0) ?
+		!hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED) :
+			0);
+	if (bc_moved) {
 		/* Bind the "device" to the cpu */
 		bc->bound_on = smp_processor_id();
 	} else if (bc->bound_on == smp_processor_id()) {
-- 
2.1.0

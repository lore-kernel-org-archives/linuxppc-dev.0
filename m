Return-Path: <luis.henriques@canonical.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A37131A0AA1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 00:02:12 +1100 (AEDT)
From: Luis Henriques <luis.henriques@canonical.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: [3.16.y-ckt stable] Patch "timers/tick/broadcast-hrtimer: Fix
 suspicious RCU usage in idle loop" has been added to staging queue
Date: Mon, 30 Mar 2015 14:02:06 +0100
Message-Id: <1427720526-3585-1-git-send-email-luis.henriques@canonical.com>
Cc: "Peter Zijlstra \(Intel\)" <peterz@infradead.org>, linuxppc-dev@ozlabs.org,
 kernel-team@lists.ubuntu.com, tglx@linutronix.de,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Luis Henriques <luis.henriques@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a note to let you know that I have just added a patch titled

    timers/tick/broadcast-hrtimer: Fix suspicious RCU usage in idle loop

to the linux-3.16.y-queue branch of the 3.16.y-ckt extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.16.y-queue

This patch is scheduled to be released in version 3.16.7-ckt10.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.16.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From 6cbc6fd5f987aea28ede4c2774830f0c48b885e6 Mon Sep 17 00:00:00 2001
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 18 Mar 2015 16:19:27 +0530
Subject: timers/tick/broadcast-hrtimer: Fix suspicious RCU usage in idle loop

commit a127d2bcf1fbc8c8e0b5cf0dab54f7d3ff50ce47 upstream.

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
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 kernel/time/tick-broadcast-hrtimer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index eb682d5c697c..6aac4beedbbe 100644
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

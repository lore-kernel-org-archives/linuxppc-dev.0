Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426361A0010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 21:50:02 +1100 (AEDT)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 897601400EA
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2015 21:50:01 +1100 (AEDT)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 18 Mar 2015 04:49:59 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 1C5D9C40003
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2015 04:41:07 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t2IAo43i45940742
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2015 03:50:04 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2IAntis029056
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2015 04:49:55 -0600
Subject: [PATCH V2] tick/broadcast-hrtimer : Fix suspicious RCU usage in
 idle loop
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: peterz@infradead.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
 mingo@kernel.org
Date: Wed, 18 Mar 2015 16:19:27 +0530
Message-ID: <20150318104705.17763.56668.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
Changes from V1: http://www.gossamer-threads.com/lists/linux/kernel/2128872
Modified the changelog

 kernel/time/tick-broadcast-hrtimer.c |   11 +++++++++--
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

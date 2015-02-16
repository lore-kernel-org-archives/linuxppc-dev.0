Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51E2C1A012E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 17:25:47 +1100 (AEDT)
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 93E2514021A
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 17:25:46 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sun, 15 Feb 2015 23:25:44 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BF2E53E40030
 for <linuxppc-dev@ozlabs.org>; Sun, 15 Feb 2015 23:21:18 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1G6Pb0G18874494
 for <linuxppc-dev@ozlabs.org>; Sun, 15 Feb 2015 23:25:45 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1G6P9f8006013
 for <linuxppc-dev@ozlabs.org>; Sun, 15 Feb 2015 23:25:10 -0700
Subject: [PATCH] tick/broadcast-hrtimer : Fix suspicious RCU usage in idle loop
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: tglx@linutronix.de, paulmck@linux.vnet.ibm.com, sam.bobroff@au1.ibm.com
Date: Mon, 16 Feb 2015 11:54:50 +0530
Message-ID: <20150216062450.29360.92719.stgit@preeti.in.ibm.com>
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
path so as to wakeup cpus in deep idle states. hrtimer_{start/cancel}
functions call into tracing which uses RCU. But it is not legal to call
into RCU in cpuidle because it is one of the quiescent states. Hence
protect this region with RCU_NONIDLE which informs RCU that the cpu
is momentarily non-idle.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

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

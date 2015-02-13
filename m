Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFC3B1A0C38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 18:23:01 +1100 (AEDT)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C82761402BB
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2015 18:23:00 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 13 Feb 2015 00:22:58 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id BE3EC1FF0043
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2015 00:14:07 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1D7Mvxf25886936
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2015 00:22:57 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1D7MtDQ031220
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2015 00:22:55 -0700
Message-ID: <54DDA645.6080600@linux.vnet.ibm.com>
Date: Fri, 13 Feb 2015 12:52:45 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sam Bobroff <sam.bobroff@au1.ibm.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>,
 "mpe >> Michael Ellerman" <mpe@ellerman.id.au>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: suspicious RCU usage clockevents_lock, tick_broadcast_lock,
 hrtimer_bases.lock
References: <54DD4BF6.1070503@au1.ibm.com>
 <54DD8B37.2040903@linux.vnet.ibm.com>
In-Reply-To: <54DD8B37.2040903@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/13/2015 10:57 AM, Preeti U Murthy wrote:
> On 02/13/2015 06:27 AM, Sam Bobroff wrote:
>> Hello,
>>
>> I'm receiving this while booting a vanilla 3.19 kernel on a Power 8 machine:
> 
> Does the below patch fix the issue ?
> 
> From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> 
> [PATCH] tick/hrtimer-broadcast: Fix a suspicious RCU usage in the tick broadcast path
> 
> ---
>  kernel/time/tick-broadcast-hrtimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
> index eb682d5..57b8e32 100644
> --- a/kernel/time/tick-broadcast-hrtimer.c
> +++ b/kernel/time/tick-broadcast-hrtimer.c
> @@ -62,7 +62,7 @@ static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
>          * HRTIMER_RESTART.
>          */
>         if (hrtimer_try_to_cancel(&bctimer) >= 0) {
> -               hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED);
> +               RCU_NONIDLE(hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED));
>                 /* Bind the "device" to the cpu */
>                 bc->bound_on = smp_processor_id();
>         } else if (bc->bound_on == smp_processor_id()) {
> 
Actually the below patch is the complete fix. Paul can you please
review this ?  As an alternate solution I checked to see if its
possible to move rcu_idle_enter()/exit() closer to the
cpuidle_enter() call, but that won't work as you may have already
tried earlier.

-----------------------------------------------------------------

tick/broadcast-hrtimer : Fix suspicious RCU usage in idle loop

From: Preeti U Murthy <preeti@linux.vnet.ibm.com>

The hrtimer mode of broadcast queues hrtimers in the idle entry
path so as to wakeup cpus in deep idle states. hrtimer_{start/cancel}
functions call into tracing which uses RCU. But it is not legal to call
into RCU in cpuidle because it is one of the quiescent states. Hence
protect this region with RCU_NONIDLE which informs RCU that the cpu
is momentarily non-idle.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 kernel/time/tick-broadcast-hrtimer.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index eb682d5..d3dd564 100644
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
+                !hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED) :
+                        0);
+	if (bc_moved) {
 		/* Bind the "device" to the cpu */
 		bc->bound_on = smp_processor_id();
 	} else if (bc->bound_on == smp_processor_id()) {


Thanks

Regards
Preeti U Murthy

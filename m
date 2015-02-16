Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFF2F1A0194
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 16:50:27 +1100 (AEDT)
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 059591401F0
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 16:50:26 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sun, 15 Feb 2015 22:50:25 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 47A3D3E4003F
 for <linuxppc-dev@ozlabs.org>; Sun, 15 Feb 2015 22:45:56 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1G5ofnA42991782
 for <linuxppc-dev@ozlabs.org>; Sun, 15 Feb 2015 22:50:41 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1G5oMpp004267
 for <linuxppc-dev@ozlabs.org>; Sun, 15 Feb 2015 22:50:22 -0700
Date: Sun, 15 Feb 2015 21:50:17 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: suspicious RCU usage clockevents_lock, tick_broadcast_lock,
 hrtimer_bases.lock
Message-ID: <20150216055017.GE4166@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <54DD4BF6.1070503@au1.ibm.com>
 <54DD8B37.2040903@linux.vnet.ibm.com>
 <54DDA645.6080600@linux.vnet.ibm.com>
 <20150213142603.GV4166@linux.vnet.ibm.com>
 <54E161B0.5020105@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54E161B0.5020105@linux.vnet.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Sam Bobroff <sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 16, 2015 at 08:49:12AM +0530, Preeti U Murthy wrote:
> On 02/13/2015 07:56 PM, Paul E. McKenney wrote:
> > On Fri, Feb 13, 2015 at 12:52:45PM +0530, Preeti U Murthy wrote:
> >> On 02/13/2015 10:57 AM, Preeti U Murthy wrote:
> >>> On 02/13/2015 06:27 AM, Sam Bobroff wrote:
> >>>> Hello,
> >>>>
> >>>> I'm receiving this while booting a vanilla 3.19 kernel on a Power 8 machine:
> >>>
> >>> Does the below patch fix the issue ?
> >>>
> >>> From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> >>>
> >>> [PATCH] tick/hrtimer-broadcast: Fix a suspicious RCU usage in the tick broadcast path
> >>>
> >>> ---
> >>>  kernel/time/tick-broadcast-hrtimer.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
> >>> index eb682d5..57b8e32 100644
> >>> --- a/kernel/time/tick-broadcast-hrtimer.c
> >>> +++ b/kernel/time/tick-broadcast-hrtimer.c
> >>> @@ -62,7 +62,7 @@ static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
> >>>          * HRTIMER_RESTART.
> >>>          */
> >>>         if (hrtimer_try_to_cancel(&bctimer) >= 0) {
> >>> -               hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED);
> >>> +               RCU_NONIDLE(hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED));
> >>>                 /* Bind the "device" to the cpu */
> >>>                 bc->bound_on = smp_processor_id();
> >>>         } else if (bc->bound_on == smp_processor_id()) {
> >>>
> >> Actually the below patch is the complete fix. Paul can you please
> >> review this ?  As an alternate solution I checked to see if its
> >> possible to move rcu_idle_enter()/exit() closer to the
> >> cpuidle_enter() call, but that won't work as you may have already
> >> tried earlier.
> >>
> >> -----------------------------------------------------------------
> >>
> >> tick/broadcast-hrtimer : Fix suspicious RCU usage in idle loop
> >>
> >> From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> >>
> >> The hrtimer mode of broadcast queues hrtimers in the idle entry
> >> path so as to wakeup cpus in deep idle states. hrtimer_{start/cancel}
> >> functions call into tracing which uses RCU. But it is not legal to call
> >> into RCU in cpuidle because it is one of the quiescent states. Hence
> >> protect this region with RCU_NONIDLE which informs RCU that the cpu
> >> is momentarily non-idle.
> >>
> >> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > Another alternative would be to change the hrtimer_{start/cancel}()
> > functions' tracepoints to the _rcuidle form.  The advantage of this
> > approach is less RCU-notification overhead when tracing is enabled.
> 
> But since the hrtimer_{start/cancel} functions' tracepoints are more
> often called from paths which are in the non-quiescent states, wouldn't
> we be doing an rcu_irq_enter/exit() redundantly far too often in that case ?

And the other advantage of doing it the way you did (and I -did- give
you a Reviewed-by!) is that you are incurring the extra overhead from
the idle loop, where that extra overhead is less likely to be holding
something else up.  So, yes, I do agree with your patch.

							Thanx, Paul

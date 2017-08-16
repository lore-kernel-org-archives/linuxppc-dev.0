Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXZWc125JzDrHx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:27:39 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7GGONoK133595
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 12:27:37 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ccr3dng7e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 12:27:37 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 16 Aug 2017 12:27:36 -0400
Date: Wed, 16 Aug 2017 09:27:31 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dzickus@redhat.com,
 sfr@canb.auug.org.au, linuxarm@huawei.com,
 Nicholas Piggin <npiggin@gmail.com>, abdhalee@linux.vnet.ibm.com,
 tglx@linutronix.de, sparclinux@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, john.stultz@linaro.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170728182053.000072aa@huawei.com>
 <20170728190349.GM3730@linux.vnet.ibm.com>
 <20170731120847.00003d5c@huawei.com>
 <20170731150411.GA3730@linux.vnet.ibm.com>
 <20170731162757.000058ba@huawei.com>
 <20170801184646.GE3730@linux.vnet.ibm.com>
 <20170802172555.0000468a@huawei.com>
 <20170815154743.GK7017@linux.vnet.ibm.com>
 <87wp63smwn.fsf@concordia.ellerman.id.au>
 <20170816125617.GY7017@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170816125617.GY7017@linux.vnet.ibm.com>
Message-Id: <20170816162731.GA22978@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 16, 2017 at 05:56:17AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 16, 2017 at 10:43:52PM +1000, Michael Ellerman wrote:
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> > ...
> > >
> > > commit 33103e7b1f89ef432dfe3337d2a6932cdf5c1312
> > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Date:   Mon Aug 14 08:54:39 2017 -0700
> > >
> > >     EXP: Trace tick return from tick_nohz_stop_sched_tick
> > >     
> > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > >
> > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > index c7a899c5ce64..7358a5073dfb 100644
> > > --- a/kernel/time/tick-sched.c
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -817,6 +817,7 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
> > >  	 * (not only the tick).
> > >  	 */
> > >  	ts->sleep_length = ktime_sub(dev->next_event, now);
> > > +	trace_printk("tick_nohz_stop_sched_tick: %lld\n", (tick - ktime_get()) / 1000);
> > >  	return tick;
> > >  }
> > 
> > Should I be seeing negative values? A small sample:
> 
> Maybe due to hypervisor preemption delays, but I confess that I am
> surprised to see them this large.  1,602,250,019 microseconds is something
> like a half hour, which could result in stall warnings all by itself.
> 
> >           <idle>-0     [015] d...  1602.039695: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250019
> >           <idle>-0     [009] d...  1602.039701: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250025
> >           <idle>-0     [007] d...  1602.039702: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250025
> >           <idle>-0     [048] d...  1602.039703: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: 9973
> >           <idle>-0     [006] d...  1602.039704: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250027
> >           <idle>-0     [001] d...  1602.039730: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250053
> >           <idle>-0     [008] d...  1602.039732: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250055
> >           <idle>-0     [006] d...  1602.049695: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602260018
> >           <idle>-0     [009] d...  1602.049695: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602260018
> >           <idle>-0     [001] d...  1602.049695: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602260018
> > 
> > 
> > I have a full trace, I'll send it to you off-list.
> 
> I will take a look!

And from your ps output, PID 9 is rcu_sched, which is the RCU grace-period
kthread that stalled.  This kthread was starved, based on this from your
dmesg:

[ 1602.067008] rcu_sched kthread starved for 2603 jiffies! g7275 c7274 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1

The RCU_GP_WAIT_FQS says that this kthread is periodically scanning for
idle-CPU and offline-CPU quiescent states, which means that its waits
will be accompanied by short timeouts.  The "starved for 2603 jiffies"
says that it has not run for one good long time.  The ->state is its
task_struct ->state field.

The immediately preceding dmesg line is as follows:

[ 1602.063851]  (detected by 53, t=2603 jiffies, g=7275, c=7274, q=608)

In other words, the rcu_sched grace-period kthread has been starved
for the entire duration of the current grace period, as shown by the
t=2603.

Lets turn now to the trace output, looking for the last bit of the
rcu_sched task's activity:

       rcu_sched-9     [054] d...  1576.030096: timer_start: timer=c0000007fae1bc20 function=process_timeout expires=4295094922 [timeout=1] cpu=54 idx=0 flags=
    ksoftirqd/53-276   [053] ..s.  1576.030097: rcu_invoke_callback: rcu_sched rhp=c000000fcf8c4eb0 func=__d_free
       rcu_sched-9     [054] d...  1576.030097: rcu_utilization: Start context switch
    ksoftirqd/53-276   [053] ..s.  1576.030098: rcu_invoke_callback: rcu_sched rhp=c000000fcff74ee0 func=proc_i_callback
       rcu_sched-9     [054] d...  1576.030098: rcu_grace_period: rcu_sched 7275 cpuqs
       rcu_sched-9     [054] d...  1576.030099: rcu_utilization: End context switch

So this task set up a timer ("timer_start:") for one jiffy ("[timeout=1]",
but what is with "expires=4295094922"?)  and blocked ("rcu_utilization:
Start context switch" and "rcu_utilization: End context switch"),
recording its CPU's quiescent state in the process ("rcu_grace_period:
rcu_sched 7275 cpuqs").

Of course, the timer will have expired in the context of some other task,
but a search for "c0000007fae1bc20" (see the "timer=" in the first trace
line above) shows nothing (to be painfully accurate, the search wraps back
to earlier uses of this timer by rcu_sched).  So the timer never did fire.

The next question is "what did CPU 054 do next?"  We find it entering idle:

          <idle>-0     [054] d...  1576.030167: tick_stop: success=1 dependency=NONE
          <idle>-0     [054] d...  1576.030167: hrtimer_cancel: hrtimer=c000000fff88c680
          <idle>-0     [054] d...  1576.030168: hrtimer_start: hrtimer=c000000fff88c680 function=tick_sched_timer expires=1610710000000 softexpires=1610710000000
          <idle>-0     [054] d...  1576.030170: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: 34469831
          <idle>-0     [054] d...  1576.030171: rcu_dyntick: Start 140000000000000 0

So we have an hrtimer set for 1610710000000, whatever time that might
happen to map to.  And that is the last we hear from CPU 054, so it
apparently maps to something a bit too far into the future.  Let's
assume that this value is nanoseconds since boot, in which case we have
1,610.710000000 seconds, which is eight seconds after the stall-warning
message.  And -way- longer than the one-jiffy timeout requested!

Thomas, John, am I misinterpreting the timer trace event messages?

							Thanx, Paul

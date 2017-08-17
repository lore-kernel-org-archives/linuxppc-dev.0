Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY7611Q1NzDqYf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 23:55:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: paulmck@linux.vnet.ibm.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dzickus@redhat.com,
 sfr@canb.auug.org.au, linuxarm@huawei.com, Nicholas Piggin <npiggin@gmail.com>,
 abdhalee@linux.vnet.ibm.com, tglx@linutronix.de, sparclinux@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 john.stultz@linaro.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
In-Reply-To: <20170816162731.GA22978@linux.vnet.ibm.com>
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
 <20170816162731.GA22978@linux.vnet.ibm.com>
Date: Thu, 17 Aug 2017 23:55:51 +1000
Message-ID: <877ey2b8ns.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:

> On Wed, Aug 16, 2017 at 05:56:17AM -0700, Paul E. McKenney wrote:
>> On Wed, Aug 16, 2017 at 10:43:52PM +1000, Michael Ellerman wrote:
>> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
>> > ...
>> > >
>> > > commit 33103e7b1f89ef432dfe3337d2a6932cdf5c1312
>> > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> > > Date:   Mon Aug 14 08:54:39 2017 -0700
>> > >
>> > >     EXP: Trace tick return from tick_nohz_stop_sched_tick
>> > >     
>> > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> > >
>> > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> > > index c7a899c5ce64..7358a5073dfb 100644
>> > > --- a/kernel/time/tick-sched.c
>> > > +++ b/kernel/time/tick-sched.c
>> > > @@ -817,6 +817,7 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
>> > >  	 * (not only the tick).
>> > >  	 */
>> > >  	ts->sleep_length = ktime_sub(dev->next_event, now);
>> > > +	trace_printk("tick_nohz_stop_sched_tick: %lld\n", (tick - ktime_get()) / 1000);
>> > >  	return tick;
>> > >  }
>> > 
>> > Should I be seeing negative values? A small sample:
>> 
>> Maybe due to hypervisor preemption delays, but I confess that I am
>> surprised to see them this large.  1,602,250,019 microseconds is something
>> like a half hour, which could result in stall warnings all by itself.

Hmm. This is a bare metal machine. So no hypervisor.

>> I will take a look!
>
> And from your ps output, PID 9 is rcu_sched, which is the RCU grace-period
> kthread that stalled.  This kthread was starved, based on this from your
> dmesg:
>
> [ 1602.067008] rcu_sched kthread starved for 2603 jiffies! g7275 c7274 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
>
> The RCU_GP_WAIT_FQS says that this kthread is periodically scanning for
> idle-CPU and offline-CPU quiescent states, which means that its waits
> will be accompanied by short timeouts.  The "starved for 2603 jiffies"
> says that it has not run for one good long time.  The ->state is its
> task_struct ->state field.
>
> The immediately preceding dmesg line is as follows:
>
> [ 1602.063851]  (detected by 53, t=2603 jiffies, g=7275, c=7274, q=608)
>
> In other words, the rcu_sched grace-period kthread has been starved
> for the entire duration of the current grace period, as shown by the
> t=2603.
>
> Lets turn now to the trace output, looking for the last bit of the
> rcu_sched task's activity:
>
>        rcu_sched-9     [054] d...  1576.030096: timer_start: timer=c0000007fae1bc20 function=process_timeout expires=4295094922 [timeout=1] cpu=54 idx=0 flags=
>     ksoftirqd/53-276   [053] ..s.  1576.030097: rcu_invoke_callback: rcu_sched rhp=c000000fcf8c4eb0 func=__d_free
>        rcu_sched-9     [054] d...  1576.030097: rcu_utilization: Start context switch
>     ksoftirqd/53-276   [053] ..s.  1576.030098: rcu_invoke_callback: rcu_sched rhp=c000000fcff74ee0 func=proc_i_callback
>        rcu_sched-9     [054] d...  1576.030098: rcu_grace_period: rcu_sched 7275 cpuqs
>        rcu_sched-9     [054] d...  1576.030099: rcu_utilization: End context switch
>
> So this task set up a timer ("timer_start:") for one jiffy ("[timeout=1]",
> but what is with "expires=4295094922"?)

That's a good one.

I have HZ=100, and therefore:

INITIAL_JIFFIES = (1 << 32) - (300 * 100) = 4294937296

So the expires value of 4295094922 is:

4295094922 - 4294937296 = 157626

Jiffies since boot.

Or 1576,260,000,000 ns == 1576.26 s.

> Of course, the timer will have expired in the context of some other task,
> but a search for "c0000007fae1bc20" (see the "timer=" in the first trace
> line above) shows nothing (to be painfully accurate, the search wraps back
> to earlier uses of this timer by rcu_sched).  So the timer never did fire.

Or it just wasn't in the trace ?

I'll try and get it to trace a bit longer and see if that is helpful.

cheers

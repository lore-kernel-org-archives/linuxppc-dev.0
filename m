Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXYHW0gkFzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 01:32:07 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id t83so1649461pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 08:32:07 -0700 (PDT)
Date: Thu, 17 Aug 2017 01:31:47 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, dzickus@redhat.com, sfr@canb.auug.org.au,
 linuxarm@huawei.com, abdhalee@linux.vnet.ibm.com, tglx@linutronix.de,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Message-ID: <20170817013147.586e0eff@roar.ozlabs.ibm.com>
In-Reply-To: <20170816125617.GY7017@linux.vnet.ibm.com>
References: <20170728165529.GF3730@linux.vnet.ibm.com>
 <20170728182053.000072aa@huawei.com>
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
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 16 Aug 2017 05:56:17 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

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

I found this, I can't see that it would cause our symptoms, but it's
worth someone who knows the code taking a look at it.

--
cpuidle: fix broadcast control when broadcast can not be entered

When failing to enter broadcast timer mode for an idle state that
requires it, a new state is selected that does not require broadcast,
but the broadcast variable remains set. This causes
tick_broadcast_exit to be called despite not having entered broadcast
mode.

This causes the WARN_ON_ONCE(!irqs_disabled()) to trigger in some
cases, but otherwise does not appear to cause problems.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/cpuidle/cpuidle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 60bb64f4329d..4453e27f855e 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -208,6 +208,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 			return -EBUSY;
 		}
 		target_state = &drv->states[index];
+		broadcast = false;
 	}
 
 	/* Take note of the planned idle state. */
-- 
2.13.3

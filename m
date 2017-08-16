Return-Path: <jonathan.cameron@huawei.com>
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXBV94kbPzDqwJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 11:25:05 +1000 (AEST)
Date: Wed, 16 Aug 2017 02:24:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: <dzickus@redhat.com>, <sfr@canb.auug.org.au>, <linuxarm@huawei.com>,
 Nicholas Piggin <npiggin@gmail.com>, <abdhalee@linux.vnet.ibm.com>,
 <sparclinux@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, David Miller <davem@davemloft.net>,
 <linux-arm-kernel@lists.infradead.org>, <tglx@linutronix.de>
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Message-ID: <20170816022434.00006d11@huawei.com>
In-Reply-To: <20170815154743.GK7017@linux.vnet.ibm.com>
References: <20170728084411.00001ddb@huawei.com>
 <20170728142403.0000122b@huawei.com>
 <20170728165529.GF3730@linux.vnet.ibm.com>
 <20170728182053.000072aa@huawei.com>
 <20170728190349.GM3730@linux.vnet.ibm.com>
 <20170731120847.00003d5c@huawei.com>
 <20170731150411.GA3730@linux.vnet.ibm.com>
 <20170731162757.000058ba@huawei.com>
 <20170801184646.GE3730@linux.vnet.ibm.com>
 <20170802172555.0000468a@huawei.com>
 <20170815154743.GK7017@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 15 Aug 2017 08:47:43 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Wed, Aug 02, 2017 at 05:25:55PM +0100, Jonathan Cameron wrote:
> > On Tue, 1 Aug 2017 11:46:46 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> >   
> > > On Mon, Jul 31, 2017 at 04:27:57PM +0100, Jonathan Cameron wrote:  
> > > > On Mon, 31 Jul 2017 08:04:11 -0700
> > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > >     
> > > > > On Mon, Jul 31, 2017 at 12:08:47PM +0100, Jonathan Cameron wrote:    
> > > > > > On Fri, 28 Jul 2017 12:03:50 -0700
> > > > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > > >       
> > > > > > > On Fri, Jul 28, 2017 at 06:27:05PM +0100, Jonathan Cameron wrote:      
> > > > > > > > On Fri, 28 Jul 2017 09:55:29 -0700
> > > > > > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > > > > >         
> > > > > > > > > On Fri, Jul 28, 2017 at 02:24:03PM +0100, Jonathan Cameron wrote:        
> > > > > > > > > > On Fri, 28 Jul 2017 08:44:11 +0100
> > > > > > > > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:          
> > > > > > > > > 
> > > > > > > > > [ . . . ]
> > > > > > > > >         
> > > > > > > > > > Ok.  Some info.  I disabled a few driver (usb and SAS) in the interest of having
> > > > > > > > > > fewer timer events.  Issue became much easier to trigger (on some runs before
> > > > > > > > > > I could get tracing up and running)
> > > > > > > > > >e
> > > > > > > > > > So logs are large enough that pastebin doesn't like them - please shoet if          
> > > > > > > > > >>e another timer period is of interest.          
> > > > > > > > > > 
> > > > > > > > > > https://pastebin.com/iUZDfQGM for the timer trace.
> > > > > > > > > > https://pastebin.com/3w1F7amH for dmesg.  
> > > > > > > > > > 
> > > > > > > > > > The relevant timeout on the RCU stall detector was 8 seconds.  Event is
> > > > > > > > > > detected around 835.
> > > > > > > > > > 
> > > > > > > > > > It's a lot of logs, so I haven't identified a smoking gun yet but there
> > > > > > > > > > may well be one in there.          
> > > > > > > > > 
> > > > > > > > > The dmesg says:
> > > > > > > > > 
> > > > > > > > > rcu_preempt kthread starved for 2508 jiffies! g112 c111 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
> > > > > > > > > 
> > > > > > > > > So I look for "rcu_preempt" timer events and find these:
> > > > > > > > > 
> > > > > > > > > rcu_preempt-9     [019] ....   827.579114: timer_init: timer=ffff8017d5fc7da0
> > > > > > > > > rcu_preempt-9     [019] d..1   827.579115: timer_start: timer=ffff8017d5fc7da0 function=process_timeout 
> > > > > > > > > 
> > > > > > > > > Next look for "ffff8017d5fc7da0" and I don't find anything else.        
> > > > > > > > It does show up off the bottom of what would fit in pastebin...
> > > > > > > > 
> > > > > > > >      rcu_preempt-9     [001] d..1   837.681077: timer_cancel: timer=ffff8017d5fc7da0
> > > > > > > >      rcu_preempt-9     [001] ....   837.681086: timer_init: timer=ffff8017d5fc7da0
> > > > > > > >      rcu_preempt-9     [001] d..1   837.681087: timer_start: timer=ffff8017d5fc7da0 function=process_timeout expires=4295101298 [timeout=1] cpu=1 idx=0 flags=        
> > > > > > > 
> > > > > > > Odd.  I would expect an expiration...  And ten seconds is way longer
> > > > > > > than the requested one jiffy!
> > > > > > >       
> > > > > > > > > The timeout was one jiffy, and more than a second later, no expiration.
> > > > > > > > > Is it possible that this event was lost?  I am not seeing any sign of
> > > > > > > > > this is the trace.
> > > > > > > > > 
> > > > > > > > > I don't see any sign of CPU hotplug (and I test with lots of that in
> > > > > > > > > any case).
> > > > > > > > > 
> > > > > > > > > The last time we saw something like this it was a timer HW/driver problem,
> > > > > > > > > but it is a bit hard to imagine such a problem affecting both ARM64
> > > > > > > > > and SPARC.  ;-)        
> > > > > > > > Could be different issues, both of which were hidden by that lockup detector.
> > > > > > > > 
> > > > > > > > There is an errata work around for the timers on this particular board.
> > > > > > > > I'm only vaguely aware of it, so may be unconnected.
> > > > > > > > 
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/clocksource/arm_arch_timer.c?h=v4.13-rc2&id=bb42ca47401010fc02901b5e8f79e40a26f208cb
> > > > > > > > 
> > > > > > > > Seems unlikely though! + we've not yet seen it on the other chips that
> > > > > > > > errata effects (not that that means much).        
> > > > > > > 
> > > > > > > If you can reproduce quickly, might be worth trying anyway...
> > > > > > > 
> > > > > > > 							Thanx, Paul      
> > > > > > Errata fix is running already and was for all those tests.      
> > > > > 
> > > > > I was afraid of that...  ;-)    
> > > > It's a pretty rare errata it seems.  Not actually managed to catch
> > > > one yet.     
> > > > >     
> > > > > > I'll have a dig into the timers today and see where I get to.      
> > > > > 
> > > > > Look forward to seeing what you find!    
> > > > Nothing obvious turning up other than we don't seem to have issue
> > > > when we aren't running hrtimers.
> > > > 
> > > > On a plus side I just got a report that it is effecting our d03
> > > > boards which is good on the basis I couldn't tell what the difference
> > > > could be wrt to this issue!
> > > > 
> > > > It indeed looks like we are consistently missing a timer before
> > > > the rcu splat occurs.    
> > > 
> > > And for my part, my tests with CONFIG_HZ_PERIODIC=y and
> > > CONFIG_RCU_FAST_NO_HZ=n showed roughly the same failure rate
> > > as other runs.
> > > 
> > > Missing a timer can most certainly give RCU severe heartburn!  ;-)
> > > Do you have what you need to track down the missing timer?    
> > 
> > Not managed to make much progress yet.  Turning on any additional tracing
> > in that area seems to make the issue stop happening or at least
> > occur very infrequently. Which certainly makes it 'fun' to find.
> > 
> > As a long shot I applied a locking fix from another reported issue that
> > was causing rcu stalls and it seemed good for much longer, but
> > eventually still occurred.
> > 
> > (from the thread rcu_sched stall while waiting in csd_lock_wait())  
> 
> On the perhaps unlikely off-chance that it helps locate something,
> here is a patch that adds a trace_printk() to check how long a CPU
> believes that it can sleep when going idle.  The thought is to check
> to see if a CPU with a timer set to expire in one jiffy thinks that
> can sleep for (say) 30 seconds.
> 
> Didn't find anything for my problem, but I believe that yours is
> different, so...
> 
> 							Thanx, Paul

Hi Paul,

Thanks for the suggestion.  I hadn't thought to look at the
expected time being wrong.

I have noted that adding other tracepoints (and turning them on)
in that function cause the problem to 'disappear' though so it
would seem very timing sensitive.  Fingers crossed this doesn't
have the same effect!

Our progress on this has been a bit limited partly as I have been
traveling and haven't sorted out remote hardware access.
May be the start of next week before I can try this out.

Agreed, the problems look to be different.

Interesting question is whether the other known cases fall
into one or the other category?

Thanks for the help and good luck with your variant!

Jonathan
> 
> ------------------------------------------------------------------------
> 
> commit 33103e7b1f89ef432dfe3337d2a6932cdf5c1312
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Mon Aug 14 08:54:39 2017 -0700
> 
>     EXP: Trace tick return from tick_nohz_stop_sched_tick
>     
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index c7a899c5ce64..7358a5073dfb 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -817,6 +817,7 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
>  	 * (not only the tick).
>  	 */
>  	ts->sleep_length = ktime_sub(dev->next_event, now);
> +	trace_printk("tick_nohz_stop_sched_tick: %lld\n", (tick - ktime_get()) / 1000);
>  	return tick;
>  }
>  
> 

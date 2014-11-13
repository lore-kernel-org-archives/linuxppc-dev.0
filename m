Return-Path: <pc@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E3761A010D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 06:34:05 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Thu, 13 Nov 2014 12:34:02 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8A7BB19D803D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 12:22:41 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sADJY0YE50987254
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 20:34:00 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sADJXxOV016134
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 12:33:59 -0700
Message-ID: <546507A6.9040800@us.ibm.com>
Date: Thu, 13 Nov 2014 13:33:58 -0600
From: Paul Clarke <pc@us.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: mitigate impact of decrementer reset
References: <20141008025210.AF949140144@ozlabs.org>
 <545A591F.3080400@us.ibm.com> <1415846346.28703.1.camel@concordia>
In-Reply-To: <1415846346.28703.1.camel@concordia>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/12/2014 08:39 PM, Michael Ellerman wrote:
> On Wed, 2014-11-05 at 11:06 -0600, Paul Clarke wrote:
>> On 10/07/2014 09:52 PM, Michael Ellerman wrote:
>>> On Tue, 2014-07-10 at 19:13:24 UTC, Paul Clarke wrote:
>>>> This patch short-circuits the reset of the decrementer, exiting after
>>>> the decrementer reset, but before the housekeeping tasks if the only
>>>> need for the interrupt is simply to reset it.  After this patch,
>>>> the latency spike was measured at about 150 nanoseconds.
>>
>>> Thanks for the excellent changelog. But this patch makes me a bit nervous :)
>>>
>>> Do you know where the latency is coming from? Is it primarily the irq work?
>>
>> Yes, it is all under irq_enter (measured at ~10us) and irq_exit (~12us).
>
> Hmm, OK. I actually meant irq_work_run().
>
> AIUI irq_enter/exit() are just state tracking, they shouldn't be actually
> running work.
>
> How are you measuring it?

ftrace function_graph tracer:
--
   127.425212 |                |  .irq_enter() {
   127.425213 |                |    .rcu_irq_enter() {
   127.425213 |  + 12.206 us   |      .rcu_eqs_exit_common.isra.41();
   127.425226 |  + 12.750 us   |    }
... RCU is a big hitter
   127.425226 |                |    .vtime_common_account_irq_enter() {
   127.425226 |                |      .vtime_account_user() {
   127.425226 |    0.032 us    |        ._raw_spin_lock();
   127.425227 |    0.034 us    |        .get_vtime_delta();
   127.425227 |                |        .account_user_time() {
   127.425228 |    0.030 us    |          .cpuacct_account_field();
   127.425228 |                |          .acct_account_cputime() {
   127.425228 |    0.082 us    |            .__acct_update_integrals();
   127.425229 |    0.562 us    |          }
   127.425229 |    1.500 us    |        }
   127.425229 |    2.954 us    |      }
   127.425230 |    3.434 us    |    }
... but even accounting is not insignificant
   127.425230 |  + 17.218 us   |  }
   127.425230 |                |  /* timer_interrupt_entry: [...] */
... nothing to see here, because there's nothing to do except reset the 
decrementer
   127.425230 |                |  /* timer_interrupt_exit: [...] */
... (less than 1 us spent doing the "required" work)
   127.425231 |                |  .irq_exit() {
   127.425231 |                |    .vtime_gen_account_irq_exit() {
   127.425231 |    0.036 us    |      ._raw_spin_lock();
   127.425232 |                |      .__vtime_account_system() {
   127.425232 |    0.030 us    |        .get_vtime_delta();
   127.425232 |                |        .account_system_time() {
   127.425233 |    0.030 us    |          .cpuacct_account_field();
   127.425233 |                |          .acct_account_cputime() {
   127.425233 |    0.072 us    |            .__acct_update_integrals();
   127.425234 |    0.564 us    |          }
   127.425234 |    1.546 us    |        }
   127.425234 |    2.528 us    |      }
   127.425235 |    3.700 us    |    }
... significant accounting time
   127.425235 |    0.032 us    |    .idle_cpu();
   127.425235 |                |    .tick_nohz_irq_exit() {
   127.425236 |                |      .can_stop_full_tick() {
   127.425236 |    0.022 us    |        .sched_can_stop_tick();
   127.425236 |    0.020 us    |        .posix_cpu_timers_can_stop_tick()
   127.425237 |    0.970 us    |      }
   127.425237 |    0.082 us    |      .ktime_get();
   127.425238 |                |      .tick_nohz_stop_sched_tick() {
   127.425238 |    0.032 us    |        .timekeeping_max_deferment();
   127.425238 |                |        .get_next_timer_interrupt() {
   127.425239 |    0.038 us    |          ._raw_spin_lock();
   127.425239 |                |          .hrtimer_get_next_event() {
   127.425239 |    0.030 us    |            ._raw_spin_lock_irqsave();
   127.425240 |    0.028 us    |            ._raw_spin_unlock_irqrestore
   127.425240 |    0.984 us    |          }
   127.425241 |    1.936 us    |        }
   127.425241 |    0.032 us    |        .scheduler_tick_max_deferment();
   127.425241 |    3.438 us    |      }
   127.425242 |    5.880 us    |    }
   127.425242 |                |    .rcu_irq_exit() {
   127.425242 |    0.102 us    |      .rcu_eqs_enter_common.isra.40();
   127.425243 |    0.576 us    |    }
   127.425243 |  + 12.156 us   |  }

This one was almost 30 us total (17.218 + 12.156 = 29.374 us), just to 
reset the decrementer.

>>> If so I'd prefer if we could move the short circuit into __timer_interrupt()
>>> itself. That way we'd still have the trace points usable, and it would
>>> hopefully result in less duplicated logic.
>>
>> But irq_enter and irq_exit are called in timer_interrupt, before
>> __timer_interrupt is called.  I don't see how that helps.  The time
>> spent in __timer_interrupt is minuscule by comparison.
>
> Right, it won't help if it's irq_enter() that is causing the delay. But I was
> assuming it was irq_work_run().
>
>> Are you suggesting that irq_enter/exit be moved into __timer_interrupt
>> as well?  (I'm not sure how that would impact the existing call to
>> __timer_interrupt from tick_broadcast_ipi_handler?  And if there is no
>> impact, what's the point of separating timer_interrupt and
>> __timer_interrupt?)
>
> The point is __timer_interrupt() is called from tick_broadcast_ipi_handler(),
> which is called from smp_ipi_demux(), from icp_hv_ipi_action(), from
> __do_irq(), which has already done irq_enter() (and will do irq_exit()).

If that's the only impact, maybe an "IRQ entered" flag would suffice to 
either prevent a 2nd call to irq_enter(), or allow irq_enter to be 
"reentrant" (where it just returns if it was called and the last call 
was not paired with an irq_exit yet?  Alternatively, a new parameter to 
__timer_interrupt() which indicates the same.

PC

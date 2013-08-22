Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 249602C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 15:52:17 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 22 Aug 2013 11:14:33 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8EC873940053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 11:22:02 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7M5rgZV46006388
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 11:23:42 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7M5qAeU002953
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 11:22:12 +0530
Message-ID: <5215A676.6040504@linux.vnet.ibm.com>
Date: Thu, 22 Aug 2013 11:19:42 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC V2 PATCH 2/6] powerpc: Implement broadcast timer interrupt
 as an IPI message
References: <20130814115311.5193.32212.stgit@preeti.in.ibm.com>
 <20130814115602.5193.60835.stgit@preeti.in.ibm.com>
 <1377141057.25016.265.camel@pasglop>
In-Reply-To: <1377141057.25016.265.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: fweisbec@gmail.com, paul.gortmaker@windriver.com, paulus@samba.org,
 shangw@linux.vnet.ibm.com, rjw@sisk.pl, paulmck@linux.vnet.ibm.com,
 arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org,
 john.stultz@linaro.org, tglx@linutronix.de, chenhui.zhao@freescale.com,
 deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben

On 08/22/2013 08:40 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2013-08-14 at 17:26 +0530, Preeti U Murthy wrote:
>> -static irqreturn_t unused_action(int irq, void *data)
>> +static irqreturn_t timer_action(int irq, void *data)
>>  {
>> -       /* This slot is unused and hence available for use, if needed
>> */
>> +       timer_interrupt();
>>         return IRQ_HANDLED;
>>  }
>>  
> 
> That means we'll do irq_enter/irq_exit twice no ? And things like
> may_hard_irq_enable() are also already done by do_IRQ so you
> don't need timer_interrupt() to do it again.
> 
> We probably are better off breaking timer_interrupt in two:
> 
> void __timer_interrupt(struct pt_regs * regs)
> 
> Does the current stuff between irq_enter and irq_exit, timer_interrupt
> does the remaining around it and calls __timer_interrupt.
> 
> Then from timer_action, you call __timer_interrupt()

We actually tried out this approach. The implementation was have a
set_dec(0) in the timer_action(). This would ensure that we actually do
get a timer interrupt.

But the problem with either this approach or the one that you
suggest,i.e. calling __timer_interrupt is in the following flow.

do_IRQ() -> irq_exit() -> tick_irq_exit() -> tick_nohz_irq_exit()
-> tick_nohz_stop_sched_tick()

The problem lies in the function tick_nohz_stop_sched_tick(). This
function checks for the next timer interrupt pending on this cpu, and
programs the decrementer_next_event to the time of the next event, which
is of course > now.

As a result when in the timer_action() above, we do call
__timer_interrupt() or try to trigger a timer interrupt through
set_dec(0), the condition  if(now >= *next_tb) in timer_interrupt() or
__timer_interrupt() will fail, and will not call the timer interrupt
event handler.

---> if (now >= *next_tb) {
             *next_tb = ~(u64)0;
             if (evt->event_handler)
                evt->event_handler(evt);
      } else {

The broadcast IPI , is meant to make the target CPU of this IPI believe
that it woke up from a timer interrupt, and not from an IPI. (The reason
for this I will explain in the reply to the next patch). The target CPU
should then ideally do what it would have done had it received a real
timer interrupt, call the timer interrupt event handler.

But due to the above code flow this does  not happen.
Hence as the next patch PATCH 3/6 shows, we simply call the event
handler of a timer interrupt without this explicit now >= *next_tb check.

This problem arises only in the implementation of this patchset, because
a timer interrupt is pseudo triggered from an IPI. So the effects of the
IPI handler will be felt on the timer interrupt handler triggered from
this IPI, like above.

Regards
Preeti U Murthy

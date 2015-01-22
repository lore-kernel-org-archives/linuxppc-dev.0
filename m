Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7103A1A06DD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 17:07:34 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 22 Jan 2015 01:07:31 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2B0E438C8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 01:07:30 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0M67TPY23462126
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 06:07:30 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0M67SP7017840
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 01:07:29 -0500
Message-ID: <54C09391.9080202@linux.vnet.ibm.com>
Date: Thu, 22 Jan 2015 11:37:13 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3] tick/broadcast: Make movement of broadcast hrtimer
 robust against hotplug
References: <20150120103559.8430.50933.stgit@preeti.in.ibm.com>
 <alpine.DEB.2.11.1501211243270.5526@nanos>
In-Reply-To: <alpine.DEB.2.11.1501211243270.5526@nanos>
Content-Type: text/plain; charset=ISO-8859-1
Cc: aik@ozlabs.ru, shreyas@linux.vnet.ibm.com,
 LKML <linux-kernel@vger.kernel.org>, michael@ellerman.id.au,
 Peter Zijlstra <peterz@infradead.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/21/2015 05:16 PM, Thomas Gleixner wrote:
> On Tue, 20 Jan 2015, Preeti U Murthy wrote:
>> diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
>> index 5544990..f3907c9 100644
>> --- a/kernel/time/clockevents.c
>> +++ b/kernel/time/clockevents.c
>> @@ -568,6 +568,7 @@ int clockevents_notify(unsigned long reason, void *arg)
>>  
>>  	case CLOCK_EVT_NOTIFY_CPU_DYING:
>>  		tick_handover_do_timer(arg);
>> +		tick_shutdown_broadcast_oneshot(arg);
>>  		break;
>>  
>>  	case CLOCK_EVT_NOTIFY_SUSPEND:
>> @@ -580,7 +581,6 @@ int clockevents_notify(unsigned long reason, void *arg)
>>  		break;
>>  
>>  	case CLOCK_EVT_NOTIFY_CPU_DEAD:
>> -		tick_shutdown_broadcast_oneshot(arg);
>>  		tick_shutdown_broadcast(arg);
>>  		tick_shutdown(arg);
>>  		/*
>> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
>> index 066f0ec..f983983 100644
>> --- a/kernel/time/tick-broadcast.c
>> +++ b/kernel/time/tick-broadcast.c
>> @@ -675,8 +675,11 @@ static void broadcast_move_bc(int deadcpu)
>>  
>>  	if (!bc || !broadcast_needs_cpu(bc, deadcpu))
>>  		return;
>> -	/* This moves the broadcast assignment to this cpu */
>> -	clockevents_program_event(bc, bc->next_event, 1);
>> +	/* Since a cpu with the earliest wakeup is nominated as the 
>> +	 * standby cpu, the next cpu to invoke BROADCAST_ENTER
>> +	 * will now automatically take up the duty of broadcasting.
>> +	 */
>> +	bc->next_event.tv64 = KTIME_MAX;
> 
> So that relies on the fact, that cpu_down() currently forces ALL cpus
> into stop_machine(). Of course this is not in any way obvious and any
> change to this will cause even more hard to debug issues.

Hmm.. true this is a concern.
> 
> And to be honest, the clever 'set next_event to KTIME_MAX' is even
> more nonobvious because it's only relevant for your hrtimer based
> broadcasting magic. Any real broadcast device does not care about this
> at all.

bc->next_event is set to max only if CLOCK_EVT_FEATURE_HRTIMER is true.
It does not affect the usual broadcast logic.

> 
> This whole random notifier driven hotplug business is just a
> trainwreck. I'm still trying to convert this to a well documented
> state machine, so I rather prefer to make this an explicit take over
> rather than a completely undocumented 'works today' mechanism.
> 
> What about the patch below?
> 
> Thanks,
> 
> 	tglx
> ----
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 5d220234b3ca..7a9b1ae4a945 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -16,6 +16,7 @@
>  #include <linux/bug.h>
>  #include <linux/kthread.h>
>  #include <linux/stop_machine.h>
> +#include <linux/clockchips.h>
>  #include <linux/mutex.h>
>  #include <linux/gfp.h>
>  #include <linux/suspend.h>
> @@ -421,6 +422,12 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
>  	while (!idle_cpu(cpu))
>  		cpu_relax();
> 
> +	/*
> +	 * Before waiting for the cpu to enter DEAD state, take over
> +	 * any tick related duties
> +	 */
> +	clockevents_notify(CLOCK_EVT_NOTIFY_CPU_DEAD, &cpu);
> +
>  	/* This actually kills the CPU. */
>  	__cpu_die(cpu);
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 37e50aadd471..3c1bfd0f7074 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1721,11 +1721,8 @@ static int hrtimer_cpu_notify(struct notifier_block *self,
>  		break;
>  	case CPU_DEAD:
>  	case CPU_DEAD_FROZEN:
> -	{
> -		clockevents_notify(CLOCK_EVT_NOTIFY_CPU_DEAD, &scpu);
>  		migrate_hrtimers(scpu);
>  		break;
> -	}
>  #endif
> 
>  	default:
> 


How about when the cpu that is going offline receives a timer interrupt
just before setting its state to CPU_DEAD ? That is still possible right
given that its clock devices may not have been shutdown and it is
capable of receiving interrupts for a short duration. Even with the
above patch, is the following scenario possible ?

                CPU0                                  CPU1
t0         Receives timer interrupt

t1         Sees that there are hrtimers
           to be serviced (hrtimers are not yet migrated)

t2         calls hrtimer_interrupt()

t3         tick_program_event()                   CPU_DEAD notifiers
                                                CPU0's td->evtdev = NULL

t4         clockevent_program_event()
           references NULL tick device pointer

So my concern is that since the CLOCK_EVT_NOTIFY_CPU_DEAD callback
handles shutting down of devices besides moving tick related duties.
it's functions may race with the hotplug cpu still handling tick events.

We do check on powerpc if the timer interrupt has arrived on an offline
cpu, but that is to avoid an entirely different scenario and not one
like the above. I would not expect the arch to check if a timer
interrupt arrived on an offline cpu. A timer interrupt may be serviced
as long as the tick device is alive.

Regards
Preeti U Murthy

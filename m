Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E176B2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 04:13:26 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 5 Feb 2014 03:13:24 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 84D542CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 04:13:20 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s14HD6G352953298
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Feb 2014 04:13:07 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s14HDH3t013679
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Feb 2014 04:13:19 +1100
Message-ID: <52F11ECE.605@linux.vnet.ibm.com>
Date: Tue, 04 Feb 2014 22:39:34 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 2/2] tick/cpuidle: Initialize hrtimer mode of broadcast
References: <20140124065501.17564.39363.stgit@preeti.in.ibm.com>
 <20140124065820.17564.83076.stgit@preeti>
 <alpine.DEB.2.02.1402041101330.24986@ionos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.02.1402041101330.24986@ionos.tec.linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: daniel.lezcano@linaro.org, peterz@infradead.org, fweisbec@gmail.com,
 paul.gortmaker@windriver.com, paulus@samba.org, mingo@kernel.org,
 mikey@neuling.org, shangw@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
 agraf@suse.de, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au,
 john.stultz@linaro.org, anton@samba.org, chenhui.zhao@freescale.com,
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

Hi Thomas,

On 02/04/2014 03:48 PM, Thomas Gleixner wrote:
>> +++ b/kernel/time/tick-broadcast-hrtimer.c
>> +/*
>> + * This is called from the guts of the broadcast code when the cpu
>> + * which is about to enter idle has the earliest broadcast timer event.
>> + */
>> +static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
>> +{
>> +	ktime_t now, interval;
>> +	/*
>> +	 * We try to cancel the timer first. If the callback is on
>> +	 * flight on some other cpu then we let it handle it. If we
>> +	 * were able to cancel the timer nothing can rearm it as we
>> +	 * own broadcast_lock.
>> +	 *
>> +	 * However if we are called from the hrtimer interrupt handler
>> +	 * itself, reprogram it.
>> +	 */
>> +	if (hrtimer_try_to_cancel(&bctimer) >= 0) {
>> +		hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED);
>> +		/* Bind the "device" to the cpu */
>> +		bc->bound_on = smp_processor_id();
>> +	} else if (bc->bound_on == smp_processor_id()) {
> 
> This part really wants a proper comment. It took me a while to figure
> out why this is correct and what the call chain is.

How about:

"However we can also be called from the event handler of
ce_broadcast_hrtimer when bctimer expires. We cannot therefore restart
the timer since it is on flight on the same CPU. But due to the same
reason we can reset it."
?

> 
> 
>> +		now = ktime_get();
>> +		interval = ktime_sub(expires, now);
>> +		hrtimer_forward_now(&bctimer, interval);
> 
> We are in the event handler called from bc_handler() and expires is
> absolute time. So what's wrong with calling
> hrtimer_set_expires(&bctimer, expires)?

You are right. There are so many interfaces doing nearly the same thing
:( I overlooked that hrtimer_forward() and its variants were being used
when the interval was pre-calculated and stored away. And
hrtimer_set_expires() would be used when we knew the absolute expiry.
And it looks safe to call it here too.

> 
>> +static enum hrtimer_restart bc_handler(struct hrtimer *t)
>> +{
>> +	ce_broadcast_hrtimer.event_handler(&ce_broadcast_hrtimer);
>> +	return HRTIMER_RESTART;
> 
> We probably want to check whether the timer needs to be restarted at
> all.
> 
> 	if (ce_broadcast_timer.next_event.tv64 == KTIME_MAX)
> 	   return HRTIMER_NORESTART;
> 
> 	return HRTIMER_RESTART;

True this additional check would be useful.

Do you want me to send out the next version with the above corrections
including the patch added to this thread where we handle archs setting
the CPUIDLE_FLAG_TIMER_STOP flag?

> 
> Hmm?
> 
> Thanks,
> 
> 	tglx

Thanks

Regards
Preeti U Murthy
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

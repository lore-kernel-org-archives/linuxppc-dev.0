Return-Path: <pc@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A2261A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 07:58:12 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Mon, 10 Nov 2014 15:58:09 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 53DD238C8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 15:58:06 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAAKw6pH24248380
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 20:58:06 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAAKw59h028840
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 15:58:05 -0500
Message-ID: <546126DC.6090909@us.ibm.com>
Date: Mon, 10 Nov 2014 14:58:04 -0600
From: Paul Clarke <pc@us.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: mitigate impact of decrementer reset
References: <1412708517-84726-1-git-send-email-pc@us.ibm.com>
 <54343B54.4060500@us.ibm.com> <1415614083.5769.18.camel@kernel.crashing.org>
In-Reply-To: <1415614083.5769.18.camel@kernel.crashing.org>
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

On 11/10/2014 04:08 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2014-10-07 at 14:13 -0500, Paul Clarke wrote:
>> The POWER ISA defines an always-running decrementer which can be used
>> to schedule interrupts after a certain time interval has elapsed.
>> The decrementer counts down at the same frequency as the Time Base,
>> which is 512 MHz.  The maximum value of the decrementer is 0x7fffffff.
>> This works out to a maximum interval of about 4.19 seconds.
>>
>> If a larger interval is desired, the kernel will set the decrementer
>> to its maximum value and reset it after it expires (underflows)
>> a sufficient number of times until the desired interval has elapsed.
>>
>> The negative effect of this is that an unwanted latency spike will
>> impact normal processing at most every 4.19 seconds.  On an IBM
>> POWER8-based system, this spike was measured at about 25-30
>> microseconds, much of which was basic, opportunistic housekeeping
>> tasks that could otherwise have waited.
>>
>> This patch short-circuits the reset of the decrementer, exiting after
>> the decrementer reset, but before the housekeeping tasks if the only
>> need for the interrupt is simply to reset it.  After this patch,
>> the latency spike was measured at about 150 nanoseconds.
>
> Doesn't this break the irq_work stuff ? We trigger it with a set_dec(1);
> and your patch will probably cause it to be skipped...

You're right.

I'm confused by the division between timer_interrupt() and 
__timer_interrupt().  The former is called with interrupts disabled (and 
enables them), but also calls irq_enter()/irq_exit().  Why are those 
calls not in __timer_interrupt()?  (If they were, the short-circuit 
logic might be a bit easier to put directly in __timer_interrupt(), 
which would eliminate any duplicate code.)

It looks like __timer_interrupt is only called directly by the broadcast 
timer IPI handler.  (Why is __timer_interrupt not static?)  Does this 
path not need irq_enter/irq_exit?
	
>> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
>> ---
>>    arch/powerpc/kernel/time.c | 13 +++++++++++++
>>    1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>> index 368ab37..962a06b 100644
>> --- a/arch/powerpc/kernel/time.c
>> +++ b/arch/powerpc/kernel/time.c
>> @@ -528,6 +528,7 @@ void timer_interrupt(struct pt_regs * regs)
>>    {
>>    	struct pt_regs *old_regs;
>>    	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
>> +	u64 now;
>>
>>    	/* Ensure a positive value is written to the decrementer, or else
>>    	 * some CPUs will continue to take decrementer exceptions.
>> @@ -550,6 +551,18 @@ void timer_interrupt(struct pt_regs * regs)
>>    	 */
>>    	may_hard_irq_enable();
>>
>> +	/* If this is simply the decrementer expiring (underflow) due to
>> +	 * the limited size of the decrementer, and not a set timer,
>> +	 * reset (if needed) and return
>> +	 */
>> +	now = get_tb_or_rtc();
>> +	if (now < *next_tb) {
>> +		now = *next_tb - now;
>> +		if (now <= DECREMENTER_MAX)
>> +			set_dec((int)now);
>> +		__get_cpu_var(irq_stat).timer_irqs_others++;
>> +		return;
>> +	}
>>
>>    #if defined(CONFIG_PPC32) && defined(CONFIG_PPC_PMAC)
>>    	if (atomic_read(&ppc_n_lost_interrupts) != 0)

Regards,
PC

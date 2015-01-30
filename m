Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9759C1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 16:41:26 +1100 (AEDT)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 29 Jan 2015 22:41:24 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id EA1F219D8042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 22:32:32 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0U5fkWH43712748
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 22:41:46 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0U5fLBR020751
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 22:41:22 -0700
Message-ID: <54CB197D.2040809@linux.vnet.ibm.com>
Date: Fri, 30 Jan 2015 11:11:17 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cpuidle/powernv: Enter fastsleep on checking if deep
 idle states are allowed
References: <20140912110131.7311.86417.stgit@preeti.in.ibm.com>
 <1410764352.32643.2.camel@concordia> <5416A8B0.8040603@linux.vnet.ibm.com>
In-Reply-To: <5416A8B0.8040603@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/15/2014 02:22 PM, Preeti U Murthy wrote:
> On 09/15/2014 12:29 PM, Michael Ellerman wrote:
>> On Fri, 2014-09-12 at 16:31 +0530, Preeti U Murthy wrote:
>>> Today the procfs interface /proc/sys/kernel/powersave-nap is used to control
>>> entry into deep idle states beyond snooze. Check for the value of this
>>> parameter before entering fastsleep. We already do this check for nap in
>>> power7_idle().
>>>
>>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>>> ---
>>>
>>>  drivers/cpuidle/cpuidle-powernv.c |    6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
>>> index a64be57..b8ba52e 100644
>>> --- a/drivers/cpuidle/cpuidle-powernv.c
>>> +++ b/drivers/cpuidle/cpuidle-powernv.c
>>> @@ -69,6 +69,12 @@ static int fastsleep_loop(struct cpuidle_device *dev,
>>>  	unsigned long old_lpcr = mfspr(SPRN_LPCR);
>>>  	unsigned long new_lpcr;
>>>  
>>> +	/*
>>> +	 * Verify if snooze is the only valid cpuidle state
>>> +	 */
>>> +	if (!(powersave_nap > 0))
>>> +		return index;
>>> +
>>>  	if (unlikely(system_state < SYSTEM_RUNNING))
>>>  		return index;
>>
>> Doesn't the above mean we are just going to keep trying to go into fastsleep
>> again and again? Or does the idle code work out that it didn't work based on
>> the fact that we didn't sleep for the right period?
> 
> Thats right. The idle code figures that its judgment to enter fastsleep
> was not correct and applies a correction factor to its future decisions
> . This correction factor is intended to influence the cpuidle governor's
> decision on choosing an idle state for the cpu based on the history of
> wakeups. Hence a shallower idle state will be chosen here on in the
> above circumstance.

On second thoughts, I feel that this is not the best way to disable deep
idle states. Going down this path means the governor should identify
that fastsleep is not being entered into and take corrective action from
then on. If the governor is buggy, we pointlessly enter and exit
fastsleep_loop() during long idle periods.

So a better way to disable fastsleep during runtime is through the
disable flag in sysfs. To disable deep idle states at bootup one could
use powersave=off kernel cmd line parameter.

The functionality provided by powersave_nap and smt_snooze_delay (to
quote another example) carried value during the days that powernv did
not have a cpuidle driver. We retain them so as to not break userspace,
although they do not carry value today. Any future users of these
parameters should be avoided IMO. Hence I retract this patch.

Regards
Preeti U Murthy

> 
>>
>> We were talking about getting rid of powersave_nap altogether, but I think we
>> decided we couldn't, I forget.
> 
> Isn't this a helpful knob to disable cpuidle at runtime? Currently we
> check the value of powersave_nap before entering both nap and fastsleep.
> 
> Regards
> Preeti U Murthy
>>
>> cheers
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

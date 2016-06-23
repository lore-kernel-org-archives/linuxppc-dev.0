Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZxM05dPSzDqlG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 19:42:04 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5N9YaRs145313
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 05:42:02 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q9nckg4u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 05:42:02 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 19:41:58 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8A3762BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 19:41:57 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5N9fvil4325704
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 19:41:57 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5N9fvYm004695
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 19:41:57 +1000
Date: Thu, 23 Jun 2016 15:11:54 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>, rjw@rjwysocki.net
CC: linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cpuidle/powernv: Fix snooze timeout
References: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <576B23EB.7080903@gmail.com> <576B6C64.6060206@linux.vnet.ibm.com>
 <576BABC5.7020600@gmail.com>
In-Reply-To: <576BABC5.7020600@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <576BAEE2.4060202@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/23/2016 02:58 PM, Balbir Singh wrote:
> 
> 
> On 23/06/16 14:58, Shreyas B Prabhu wrote:
>>
>>
>> On 06/23/2016 05:18 AM, Balbir Singh wrote:
>>>
>>>
>>> On 23/06/16 05:36, Shreyas B. Prabhu wrote:
>>>> Snooze is a poll idle state in powernv and pseries platforms. Snooze
>>>> has a timeout so that if a cpu stays in snooze for more than target
>>>> residency of the next available idle state, then it would exit thereby
>>>> giving chance to the cpuidle governor to re-evaluate and
>>>> promote the cpu to a deeper idle state. Therefore whenever snooze exits
>>>> due to this timeout, its last_residency will be target_residency of next
>>>> deeper state.
>>>>
>>>> commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()")
>>>> changed the math around last_residency calculation. Specifically, while
>>>> converting last_residency value from nanoseconds to microseconds it does
>>>> right shift by 10. Due to this, in snooze timeout exit scenarios
>>>> last_residency calculated is roughly 2.3% less than target_residency of
>>>> next available state. This pattern is picked up get_typical_interval()
>>>> in the menu governor and therefore expected_interval in menu_select() is
>>>> frequently less than the target_residency of any state but snooze.
>>>>
>>>> Due to this we are entering snooze at a higher rate, thereby affecting
>>>> the single thread performance.
>>>> Since the math around last_residency is not meant to be precise, fix this
>>>> issue setting snooze timeout to 105% of target_residency of next
>>>> available idle state.
>>>>
>>>> This also adds comment around why snooze timeout is necessary.
>>>>
>>>> Reported-by: Anton Blanchard <anton@samba.org>
>>>> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>>>> ---
>>>>  drivers/cpuidle/cpuidle-powernv.c | 14 ++++++++++++++
>>>>  drivers/cpuidle/cpuidle-pseries.c | 13 +++++++++++++
>>>>  2 files changed, 27 insertions(+)
>>>>
>>>> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
>>>> index e12dc30..5835491 100644
>>>> --- a/drivers/cpuidle/cpuidle-powernv.c
>>>> +++ b/drivers/cpuidle/cpuidle-powernv.c
>>>> @@ -268,10 +268,24 @@ static int powernv_idle_probe(void)
>>>>  		cpuidle_state_table = powernv_states;
>>>>  		/* Device tree can indicate more idle states */
>>>>  		max_idle_state = powernv_add_idle_states();
>>>> +
>>>> +		/*
>>>> +		 * Staying in snooze for a long period can degrade the
>>>> +		 * perfomance of the sibling cpus. Set timeout for snooze such
>>>> +		 * that if the cpu stays in snooze longer than target residency
>>>> +		 * of the next available idle state then exit from snooze. This
>>>> +		 * gives a chance to the cpuidle governor to re-evaluate and
>>>> +		 * promote it to deeper idle states.
>>>> +		 */
>>>>  		if (max_idle_state > 1) {
>>>>  			snooze_timeout_en = true;
>>>>  			snooze_timeout = powernv_states[1].target_residency *
>>>>  					 tb_ticks_per_usec;
>>>> +			/*
>>>> +			 * Give a 5% margin since target residency related math
>>>> +			 * is not precise in cpuidle core.
>>>> +			 */
>>>
>>> Is this due to the microsecond conversion mentioned above? It would be nice to
>>> have it in the comment. Does
>>>
>>> (powernv_states[1].target_residency + tb_ticks_per_usec) / tb_ticks_per_usec solve
>>> your rounding issues, assuming the issue is really rounding or maybe it is due
>>> to the shift by 10, could you please elaborate on what related math is not
>>> precise? That would explain to me why I missed understanding your changes.
>>>
>>>> +			snooze_timeout += snooze_timeout / 20;
>>>
>>> For now 5% is sufficient, but do you want to check to assert to check if
>>>
>>> snooze_timeout (in microseconds) / tb_ticks_per_usec > powernv_states[i].target_residency?
>>>
>>
>> This is not a rounding issue. As I mentioned in the commit message, this
>> is because of the last_residency calculation in cpuidle.c.
>> To elaborate, last residency calculation is done in the following way
>> after commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with
>> local_clock()") -
>>
>> cpuidle_enter_state()
>> {
>> 	[...]
>> 	time_start = local_clock();
>> 	[enter idle state]
>> 	time_end = local_clock();
>> 	/*
>>          * local_clock() returns the time in nanosecond, let's shift
>>          * by 10 (divide by 1024) to have microsecond based time.
>>          */
>>         diff = (time_end - time_start) >> 10;
>> 	[...]
>> 	dev->last_residency = (int) diff;
>> }
>>
>> Because of >>10 as opposed to /1000, last_residency is lesser by 2.3%
> 
> 
> This is still a rounding error but at a different site. I see we saved
> a division by doing a >> 10, but we added it right back by doing a /20
> later in the platform code. 

While a >> 10 is done at every idle exit, div by 20 is done once during
boot, so this doesn't negate the previous optimization.

> Shouldn't the rounding affect other
> platforms as well? Can't we fix it in cpuidle_enter_state(). 

This does affect all platforms, but I'm guessing no other place relied
on the precision of last_residency calculations.
Daniel can perhaps comment on this.


> Division
> by 1000 can be optimized if required (but rather not add that complexity).
> Thanks for patiently explaining this
> 
> Balbir
> 

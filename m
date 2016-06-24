Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com
 [IPv6:2a00:1450:400c:c09::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbYqn017qzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 20:05:40 +1000 (AEST)
Received: by mail-wm0-x22c.google.com with SMTP id a66so18553572wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 03:05:40 -0700 (PDT)
Subject: Re: [PATCH v2] cpuidle: Fix last_residency division
To: David Laight <David.Laight@ACULAB.COM>,
 "'Shreyas B. Prabhu'" <shreyas@linux.vnet.ibm.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>
References: <1466756638-2362-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4E3E66@AcuExch.aculab.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "anton@samba.org" <anton@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <576D05F0.6060900@linaro.org>
Date: Fri, 24 Jun 2016 12:05:36 +0200
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4E3E66@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/24/2016 11:00 AM, David Laight wrote:
> From: Shreyas B. Prabhu
>> Sent: 24 June 2016 09:24
>>
>> Snooze is a poll idle state in powernv and pseries platforms. Snooze
>> has a timeout so that if a cpu stays in snooze for more than target
>> residency of the next available idle state, then it would exit thereby
>> giving chance to the cpuidle governor to re-evaluate and
>> promote the cpu to a deeper idle state. Therefore whenever snooze exits
>> due to this timeout, its last_residency will be target_residency of next
>> deeper state.
>>
>> commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()")
>> changed the math around last_residency calculation. Specifically, while
>> converting last_residency value from nanoseconds to microseconds it does
>> right shift by 10. Due to this, in snooze timeout exit scenarios
>> last_residency calculated is roughly 2.3% less than target_residency of
>> next available state. This pattern is picked up get_typical_interval()
>> in the menu governor and therefore expected_interval in menu_select() is
>> frequently less than the target_residency of any state but snooze.
>>
>> Due to this we are entering snooze at a higher rate, thereby affecting
>> the single thread performance.
>>
>> Fix this by replacing right shift by 10 with /1000 while calculating
>> last_residency.
>>
>> Reported-by: Anton Blanchard <anton@samba.org>
>> Bisected-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>> ---
>> Changes in v2
>> =============
>>   - Fixing it in the cpuidle core code instead of driver code.
>>
>>   drivers/cpuidle/cpuidle.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index a4d0059..30d67a8 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -218,10 +218,10 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>>   		local_irq_enable();
>>
>>   	/*
>> -	 * local_clock() returns the time in nanosecond, let's shift
>> -	 * by 10 (divide by 1024) to have microsecond based time.
>> +	 * local_clock() returns the time in nanosecond, let's
>> +	 * divide by 1000 to have microsecond based time.
>>   	 */
>> -	diff = (time_end - time_start) >> 10;
>> +	diff = (time_end - time_start) / 1000;

do_div ?

>>   	if (diff > INT_MAX)
>>   		diff = INT_MAX;
>
> The intent of the >> 10 was probably to avoid an expensive 64bit divide.
> So maybe something like:
> 	diff = time_end - time_start;
> 	if (diff >= INT_MAX/2)
> 		diff_32 = INT_MAX/2/1000;
> 	else
> 		diff_32 = diff;
> 		diff_32 += diff_32 >> 6;
> 		diff_32 >>= 10;
> 	}
>
> Adding an extra 1/32 makes the division by be something slightly below 1000.



-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

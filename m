Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5DE942C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 22:04:26 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 7 Feb 2014 16:34:17 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 53C041258059
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 16:36:06 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s17B4FFe55509076
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 16:34:15 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s17B4DA3028530
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 16:34:14 +0530
Message-ID: <52F4BCDC.2080005@linux.vnet.ibm.com>
Date: Fri, 07 Feb 2014 16:30:44 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] PPC: powernv: remove redundant cpuidle_idle_call()
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
 <CAKnoXLxCAqKaniGOwegNcOarS4FpoNKDY5PxOhe6j4wdtUAkLQ@mail.gmail.com>
 <52F3BCFE.3010703@linux.vnet.ibm.com>
 <alpine.LFD.2.11.1402070105170.1906@knanqh.ubzr>
 <52F484D9.6020604@linux.vnet.ibm.com> <52F4AB54.801@linux.vnet.ibm.com>
In-Reply-To: <52F4AB54.801@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org,
 Linux ARM Kernel ML <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Deepthi,

On 02/07/2014 03:15 PM, Deepthi Dharwar wrote:
> Hi Preeti,
> 
> Thanks for the patch.
> 
> On 02/07/2014 12:31 PM, Preeti U Murthy wrote:
>> Hi Nicolas,
>>
>> Find below the patch that will need to be squashed with this one.
>> This patch is based on the mainline.Adding Deepthi, the author of
>> the patch which introduced the powernv cpuidle driver. Deepthi,
>> do you think the below patch looks right? We do not need to do an
>> explicit local_irq_enable() since we are in the call path of
>> cpuidle driver and that explicitly enables irqs on exit from
>> idle states.
> 
> Yes, We enable irqs explicitly while entering snooze loop and we always
> have interrupts enabled in the snooze state.
> For NAP state, we exit out of this state with interrupts enabled so we
> do not need an explicit enable of irqs.
> 
>> On 02/07/2014 06:47 AM, Nicolas Pitre wrote:
>>> On Thu, 6 Feb 2014, Preeti U Murthy wrote:
>>>
>>>> Hi Daniel,
>>>>
>>>> On 02/06/2014 09:55 PM, Daniel Lezcano wrote:
>>>>> Hi Nico,
>>>>>
>>>>>
>>>>> On 6 February 2014 14:16, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>>>>>
>>>>>> The core idle loop now takes care of it.
>>>>>>
>>>>>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>>>>>> ---
>>>>>>  arch/powerpc/platforms/powernv/setup.c | 13 +------------
>>>>>>  1 file changed, 1 insertion(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/powerpc/platforms/powernv/setup.c
>>>>>> b/arch/powerpc/platforms/powernv/setup.c
>>>>>> index 21166f65c9..a932feb290 100644
>>>>>> --- a/arch/powerpc/platforms/powernv/setup.c
>>>>>> +++ b/arch/powerpc/platforms/powernv/setup.c
>>>>>> @@ -26,7 +26,6 @@
>>>>>>  #include <linux/of_fdt.h>
>>>>>>  #include <linux/interrupt.h>
>>>>>>  #include <linux/bug.h>
>>>>>> -#include <linux/cpuidle.h>
>>>>>>
>>>>>>  #include <asm/machdep.h>
>>>>>>  #include <asm/firmware.h>
>>>>>> @@ -217,16 +216,6 @@ static int __init pnv_probe(void)
>>>>>>         return 1;
>>>>>>  }
>>>>>>
>>>>>> -void powernv_idle(void)
>>>>>> -{
>>>>>> -       /* Hook to cpuidle framework if available, else
>>>>>> -        * call on default platform idle code
>>>>>> -        */
>>>>>> -       if (cpuidle_idle_call()) {
>>>>>> -               power7_idle();
>>>>>> -       }
>>>>>>
>>
>>  drivers/cpuidle/cpuidle-powernv.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
>> index 78fd174..130f081 100644
>> --- a/drivers/cpuidle/cpuidle-powernv.c
>> +++ b/drivers/cpuidle/cpuidle-powernv.c
>> @@ -31,11 +31,13 @@ static int snooze_loop(struct cpuidle_device *dev,
>>  	set_thread_flag(TIF_POLLING_NRFLAG);
>>
>>  	while (!need_resched()) {
>> +		ppc64_runlatch_off();
>                 ^^^^^^^^^^^^^^^
> We could move this before the while() loop.
> It would ideal to turn off latch when we enter snooze and
> turn it on when we are about to exit, rather than doing
> it over and over in the while loop.

You are right, this can be moved out of the loop.

Thanks

Regards
Preeti U Murthy

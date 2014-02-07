Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E012F2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 16:31:12 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 7 Feb 2014 11:01:06 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 97D1B394004E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 11:01:04 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s175UakH15073364
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 11:00:37 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s175UiTA001918
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 11:00:45 +0530
Message-ID: <52F46EB3.5080403@linux.vnet.ibm.com>
Date: Fri, 07 Feb 2014 10:57:15 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 1/2] PPC: powernv: remove redundant cpuidle_idle_call()
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
 <CAKnoXLxCAqKaniGOwegNcOarS4FpoNKDY5PxOhe6j4wdtUAkLQ@mail.gmail.com>
 <52F3BCFE.3010703@linux.vnet.ibm.com>
 <alpine.LFD.2.11.1402070105170.1906@knanqh.ubzr>
In-Reply-To: <alpine.LFD.2.11.1402070105170.1906@knanqh.ubzr>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
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

Hi Nicolas,

On 02/07/2014 06:47 AM, Nicolas Pitre wrote:
> On Thu, 6 Feb 2014, Preeti U Murthy wrote:
> 
>> Hi Daniel,
>>
>> On 02/06/2014 09:55 PM, Daniel Lezcano wrote:
>>> Hi Nico,
>>>
>>>
>>> On 6 February 2014 14:16, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>>>
>>>> The core idle loop now takes care of it.
>>>>
>>>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>>>> ---
>>>>  arch/powerpc/platforms/powernv/setup.c | 13 +------------
>>>>  1 file changed, 1 insertion(+), 12 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/platforms/powernv/setup.c
>>>> b/arch/powerpc/platforms/powernv/setup.c
>>>> index 21166f65c9..a932feb290 100644
>>>> --- a/arch/powerpc/platforms/powernv/setup.c
>>>> +++ b/arch/powerpc/platforms/powernv/setup.c
>>>> @@ -26,7 +26,6 @@
>>>>  #include <linux/of_fdt.h>
>>>>  #include <linux/interrupt.h>
>>>>  #include <linux/bug.h>
>>>> -#include <linux/cpuidle.h>
>>>>
>>>>  #include <asm/machdep.h>
>>>>  #include <asm/firmware.h>
>>>> @@ -217,16 +216,6 @@ static int __init pnv_probe(void)
>>>>         return 1;
>>>>  }
>>>>
>>>> -void powernv_idle(void)
>>>> -{
>>>> -       /* Hook to cpuidle framework if available, else
>>>> -        * call on default platform idle code
>>>> -        */
>>>> -       if (cpuidle_idle_call()) {
>>>> -               power7_idle();
>>>> -       }
>>>>
>>>
>>> The cpuidle_idle_call is called from arch_cpu_idle in
>>> arch/powerpc/kernel/idle.c between a ppc64_runlatch_off|on section.
>>> Shouldn't the cpuidle-powernv driver call these functions when entering
>>> idle ?
>>
>> Yes they should, I will send out a patch that does that ontop of this.
>> There have been cpuidle driver cleanups for powernv and pseries in this
>> merge window. While no change would be required in the pseries cpuidle
>> driver as a result of Nicolas's cleanup, we would need to add the
>> ppc64_runlatch_on and off functions before and after the entry into the
>> powernv idle states.
> 
> What about creating arch_cpu_idle_enter() and arch_cpu_idle_exit() in 
> arch/powerpc/kernel/idle.c and calling ppc64_runlatch_off() and 
> ppc64_runlatch_on() respectively from there instead?  Would that work?  
> That would make the idle consolidation much easier afterwards.

I would not suggest doing this. The ppc64_runlatch_*() routines need to
be called when we are sure that the cpu is about to enter or has exit an
idle state. Moving the ppc64_runlatch_on() routine to
arch_cpu_idle_enter() for instance is not a good idea because there are
places where the cpu can decide not to enter any idle state before the
call to cpuidle_idle_call() itself. In that case communicating
prematurely that we are in an idle state would not be a good idea.

So its best to add the ppc64_runlatch_* calls in the powernv cpuidle
driver IMO. We could however create idle_loop_prologue/epilogue()
variants inside it so that in addition to the runlatch routines we could
potentially add more such similar routines that are powernv specific.
  If there are cases where there is work to be done prior to and post an
entry into an idle state common to both pseries and powernv, we will
probably put them in arch_cpu_idle_enter/exit(). But the runlatch
routines are not suitable to be moved there as far as I can see.

Thank you

Regards
Preeti U Murthy
> 
> 
> Nicolas
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

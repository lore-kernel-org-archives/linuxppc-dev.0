Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 02D232C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 03:52:41 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 7 Feb 2014 02:52:41 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3848A2BB0056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 03:52:38 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s16GX7jn28442810
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 03:33:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s16Gqam2010146
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 03:52:37 +1100
Message-ID: <52F3BCFE.3010703@linux.vnet.ibm.com>
Date: Thu, 06 Feb 2014 22:19:02 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] PPC: powernv: remove redundant cpuidle_idle_call()
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
 <CAKnoXLxCAqKaniGOwegNcOarS4FpoNKDY5PxOhe6j4wdtUAkLQ@mail.gmail.com>
In-Reply-To: <CAKnoXLxCAqKaniGOwegNcOarS4FpoNKDY5PxOhe6j4wdtUAkLQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Linux ARM Kernel ML <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Daniel,

On 02/06/2014 09:55 PM, Daniel Lezcano wrote:
> Hi Nico,
> 
> 
> On 6 February 2014 14:16, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> 
>> The core idle loop now takes care of it.
>>
>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>> ---
>>  arch/powerpc/platforms/powernv/setup.c | 13 +------------
>>  1 file changed, 1 insertion(+), 12 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/setup.c
>> b/arch/powerpc/platforms/powernv/setup.c
>> index 21166f65c9..a932feb290 100644
>> --- a/arch/powerpc/platforms/powernv/setup.c
>> +++ b/arch/powerpc/platforms/powernv/setup.c
>> @@ -26,7 +26,6 @@
>>  #include <linux/of_fdt.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/bug.h>
>> -#include <linux/cpuidle.h>
>>
>>  #include <asm/machdep.h>
>>  #include <asm/firmware.h>
>> @@ -217,16 +216,6 @@ static int __init pnv_probe(void)
>>         return 1;
>>  }
>>
>> -void powernv_idle(void)
>> -{
>> -       /* Hook to cpuidle framework if available, else
>> -        * call on default platform idle code
>> -        */
>> -       if (cpuidle_idle_call()) {
>> -               power7_idle();
>> -       }
>>
> 
> The cpuidle_idle_call is called from arch_cpu_idle in
> arch/powerpc/kernel/idle.c between a ppc64_runlatch_off|on section.
> Shouldn't the cpuidle-powernv driver call these functions when entering
> idle ?

Yes they should, I will send out a patch that does that ontop of this.
There have been cpuidle driver cleanups for powernv and pseries in this
merge window. While no change would be required in the pseries cpuidle
driver as a result of Nicolas's cleanup, we would need to add the
ppc64_runlatch_on and off functions before and after the entry into the
powernv idle states.

Thanks

Regards
Preeti U Murthy
> 
>   -- Daniel
> 
> 
>> -}
>> -
>>  define_machine(powernv) {
>>         .name                   = "PowerNV",
>>         .probe                  = pnv_probe,
>> @@ -236,7 +225,7 @@ define_machine(powernv) {
>>         .show_cpuinfo           = pnv_show_cpuinfo,
>>         .progress               = pnv_progress,
>>         .machine_shutdown       = pnv_shutdown,
>> -       .power_save             = powernv_idle,
>> +       .power_save             = power7_idle,
>>         .calibrate_decr         = generic_calibrate_decr,
>>  #ifdef CONFIG_KEXEC
>>         .kexec_cpu_down         = pnv_kexec_cpu_down,
>> --
>> 1.8.4.108.g55ea5f6
>>
>>
> 

Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A99F1A06B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 18:38:41 +1000 (AEST)
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8489D140789
 for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2015 18:38:40 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 5 May 2015 04:38:37 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 8B5266E803C
 for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2015 04:30:24 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t458cZtL60030988
 for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2015 08:38:36 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t458cZVx002986
 for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2015 04:38:35 -0400
Message-ID: <55488188.9070908@linux.vnet.ibm.com>
Date: Tue, 05 May 2015 14:08:32 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] cpufreq: poowernv: Handle throttling due to Pmax
 capping at chip level
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1430729652-14813-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <55483E4B.4080405@linux.vnet.ibm.com> <55485DE9.4070609@linux.vnet.ibm.com>
In-Reply-To: <55485DE9.4070609@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/05/2015 11:36 AM, Shilpasri G Bhat wrote:
> Hi Preeti,
> 
> On 05/05/2015 09:21 AM, Preeti U Murthy wrote:
>> Hi Shilpa,
>>
>> On 05/04/2015 02:24 PM, Shilpasri G Bhat wrote:
>>> The On-Chip-Controller(OCC) can throttle cpu frequency by reducing the
>>> max allowed frequency for that chip if the chip exceeds its power or
>>> temperature limits. As Pmax capping is a chip level condition report
>>> this throttling behavior at chip level and also do not set the global
>>> 'throttled' on Pmax capping instead set the per-chip throttled
>>> variable. Report unthrottling if Pmax is restored after throttling.
>>>
>>> This patch adds a structure to store chip id and throttled state of
>>> the chip.
>>>
>>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>>> ---
>>>  drivers/cpufreq/powernv-cpufreq.c | 59 ++++++++++++++++++++++++++++++++++++---
>>>  1 file changed, 55 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>>> index ebef0d8..d0c18c9 100644
>>> --- a/drivers/cpufreq/powernv-cpufreq.c
>>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>>> @@ -27,6 +27,7 @@
>>>  #include <linux/smp.h>
>>>  #include <linux/of.h>
>>>  #include <linux/reboot.h>
>>> +#include <linux/slab.h>
>>>
>>>  #include <asm/cputhreads.h>
>>>  #include <asm/firmware.h>
>>> @@ -42,6 +43,13 @@
>>>  static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
>>>  static bool rebooting, throttled;
>>>
>>> +static struct chip {
>>> +	unsigned int id;
>>> +	bool throttled;
>>> +} *chips;
>>> +
>>> +static int nr_chips;
>>> +
>>>  /*
>>>   * Note: The set of pstates consists of contiguous integers, the
>>>   * smallest of which is indicated by powernv_pstate_info.min, the
>>> @@ -301,22 +309,33 @@ static inline unsigned int get_nominal_index(void)
>>>  static void powernv_cpufreq_throttle_check(unsigned int cpu)
>>>  {
>>>  	unsigned long pmsr;
>>> -	int pmsr_pmax, pmsr_lp;
>>> +	int pmsr_pmax, pmsr_lp, i;
>>>
>>>  	pmsr = get_pmspr(SPRN_PMSR);
>>>
>>> +	for (i = 0; i < nr_chips; i++)
>>> +		if (chips[i].id == cpu_to_chip_id(cpu))
>>> +			break;
>>> +
>>>  	/* Check for Pmax Capping */
>>>  	pmsr_pmax = (s8)PMSR_MAX(pmsr);
>>>  	if (pmsr_pmax != powernv_pstate_info.max) {
>>> -		throttled = true;
>>> -		pr_info("CPU %d Pmax is reduced to %d\n", cpu, pmsr_pmax);
>>> -		pr_info("Max allowed Pstate is capped\n");
>>> +		if (chips[i].throttled)
>>> +			goto next;
>>> +		chips[i].throttled = true;
>>> +		pr_info("CPU %d on Chip %u has Pmax reduced to %d\n", cpu,
>>> +			chips[i].id, pmsr_pmax);
>>> +	} else if (chips[i].throttled) {
>>> +		chips[i].throttled = false;
>>
>> Is this check on pmax sufficient to indicate that the chip is unthrottled ?
> 
> Unthrottling due to Pmax uncapping here is specific to a chip. So it is
> sufficient to decide throttling/unthrottling when OCC is active for that chip.

Ok then we can perhaps exit after detecting unthrottling here.
> 
>>
>>> +		pr_info("CPU %d on Chip %u has Pmax restored to %d\n", cpu,
>>> +			chips[i].id, pmsr_pmax);
>>>  	}
>>>
>>>  	/*
>>>  	 * Check for Psafe by reading LocalPstate
>>>  	 * or check if Psafe_mode_active is set in PMSR.
>>>  	 */
>>> +next:
>>>  	pmsr_lp = (s8)PMSR_LP(pmsr);
>>>  	if ((pmsr_lp < powernv_pstate_info.min) ||
>>>  				(pmsr & PMSR_PSAFE_ENABLE)) {
>>> @@ -414,6 +433,33 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
>>>  	.attr		= powernv_cpu_freq_attr,
>>
>> What about the situation where although occ is active, this particular
>> chip has been throttled and we end up repeatedly reporting "pstate set
>> to safe" and "frequency control disabled from OS" ? Should we not have a
>> check on (chips[i].throttled) before reporting an anomaly for these two
>> scenarios as well just like you have for pmsr_pmax ?
> 
> We will not have "Psafe" and "frequency control disabled" repeatedly printed
> because of global variable 'throttled', which is set to true on passing any of
> these two conditions.
> 
> It is quite unlikely behavior to have only one chip in "Psafe" or "frequency
> control disabled" state. These two conditions are most likely to happen during
> an OCC reset cycle which will occur across all chips.

Let us then add a comment to indicate that Psafe and frequency control
disabled conditions will fail *only if OCC is inactive* and not
otherwise and that this is a system wide phenomenon.

Regards
Preeti U Murthy

> 
> Thanks and Regards,
> Shilpa
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

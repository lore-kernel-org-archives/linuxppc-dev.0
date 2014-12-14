Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A08781A02F4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Dec 2014 22:50:07 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Sun, 14 Dec 2014 17:20:04 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CC86D3940045
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Dec 2014 17:20:01 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBEBq8aE2687468
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Dec 2014 17:22:08 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBEBo030010311
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Dec 2014 17:20:00 +0530
Message-ID: <548D7967.2060403@linux.vnet.ibm.com>
Date: Sun, 14 Dec 2014 17:19:59 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [v3, 2/4] powerpc/powernv: Enable Offline CPUs to enter deep
 idle states
References: <20141214100558.B40551400B7@ozlabs.org>
In-Reply-To: <20141214100558.B40551400B7@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
Cc: "Preeti U. Murthy" <preeti@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Sunday 14 December 2014 03:35 PM, Michael Ellerman wrote:
> On Thu, 2014-04-12 at 07:28:21 UTC, "Shreyas B. Prabhu" wrote:
>> From: "Preeti U. Murthy" <preeti@linux.vnet.ibm.com>
>>
>> The secondary threads should enter deep idle states so as to gain maximum
>> powersavings when the entire core is offline. To do so the offline path
>> must be made aware of the available deepest idle state. Hence probe the
>> device tree for the possible idle states in powernv core code and
>> expose the deepest idle state through flags.
>>
>> Since the  device tree is probed by the cpuidle driver as well, move
>> the parameters required to discover the idle states into an appropriate
>> common place to both the driver and the powernv core code.
>>
>> Another point is that fastsleep idle state may require workarounds in
>> the kernel to function properly. This workaround is introduced in the
>> subsequent patches. However neither the cpuidle driver or the hotplug
>> path need be bothered about this workaround.
>>
>> They will be taken care of by the core powernv code.
> 
>  ...
> 
>> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
>> index 4753958..3dc4cec 100644
>> --- a/arch/powerpc/platforms/powernv/smp.c
>> +++ b/arch/powerpc/platforms/powernv/smp.c
>> @@ -159,13 +160,17 @@ static void pnv_smp_cpu_kill_self(void)
>>  	generic_set_cpu_dead(cpu);
>>  	smp_wmb();
>>  
>> +	idle_states = pnv_get_supported_cpuidle_states();
>>  	/* We don't want to take decrementer interrupts while we are offline,
>>  	 * so clear LPCR:PECE1. We keep PECE2 enabled.
>>  	 */
>>  	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
>>  	while (!generic_check_cpu_restart(cpu)) {
>>  		ppc64_runlatch_off();
>> -		power7_nap(1);
>> +		if (idle_states & OPAL_PM_SLEEP_ENABLED)
>> +			power7_sleep();
>> +		else
>> +			power7_nap(1);
> 
> So I might be missing something subtle here, but aren't we potentially enabling
> sleep here, prior to your next patch which makes it safe to actually use sleep?
> 
> Shouldn't we only allow sleep after patch 3? Or in other words shouldn't this
> be patch 3 (or 4)?
> 

A point to note here, when sleep is exposed in device tree under ibm,cpu-idle-state-flags,
we use 2 bits, OPAL_PM_SLEEP_ENABLED and OPAL_PM_SLEEP_ENABLED_ER1. This patch only enables
sleep in OPAL_PM_SLEEP_ENABLED case. In current POWER8 chips, sleep is exposed as 
OPAL_PM_SLEEP_ENABLED_ER1, indicating the hardware bug and the need for fastsleep
workaround. And bulk of the redesign introduced in next patch helps fastsleep workaround
and winkle. 

That said, using sleep without "powernv: cpuidle: Redesign idle states management"
does expose us to a bug with performing VM migration onto subcores. But not enabling
here (i.e offline case) until next patch doesn't make much difference as the cpuidle 
framework has already enabled sleep.

In other words, OPAL_PM_SLEEP_ENABLED case will come into picture when the hardware
bug around fastsleep is fixed. And in this case running any kernel without "powernv: 
cpuidle: Redesign idle states management" does expose us to a bug with sleep + VM 
migration onto subcores, because cpuidle enables sleep based on OPAL_PM_SLEEP_ENABLED 
bit. IMO delaying enabling of sleep in OPAL_PM_SLEEP_ENABLED case until next patch, 
only for offline cpus should not gain us much. But I'll be happy to resend the patches
with the change if you think it is required.


Thanks,
Shreyas

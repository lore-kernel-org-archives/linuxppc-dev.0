Return-Path: <trinabh@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28BA0B6F87
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2011 16:00:47 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id p5L60Ww8015682
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2011 11:30:32 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5L60WYk3391572
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2011 11:30:32 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p5L60Vui007934
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2011 16:00:32 +1000
Message-ID: <4E003369.3000006@linux.vnet.ibm.com>
Date: Tue, 21 Jun 2011 11:30:09 +0530
From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH V1 4/7] cpuidle: (powerpc) Add cpu_idle_wait() to
	allow switching idle routines
References: <20110607162847.6848.44707.stgit@tringupt.in.ibm.com>
	<20110607162959.6848.26918.stgit@tringupt.in.ibm.com>
	<1308285128.32158.8.camel@pasglop>
In-Reply-To: <1308285128.32158.8.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/17/2011 10:02 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2011-06-07 at 22:00 +0530, Trinabh Gupta wrote:
>
>> diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
>> index 39a2baa..932392b 100644
>> --- a/arch/powerpc/kernel/idle.c
>> +++ b/arch/powerpc/kernel/idle.c
>> @@ -102,6 +102,24 @@ void cpu_idle(void)
>>   	}
>>   }
>>
>> +static void do_nothing(void *unused)
>> +{
>> +}
>> +
>> +/*
>> + * cpu_idle_wait - Used to ensure that all the CPUs come out of the old
>> + * idle loop and start using the new idle loop.
>> + * Required while changing idle handler on SMP systems.
>> + * Caller must have changed idle handler to the new value before the call.
>> + */
>> +void cpu_idle_wait(void)
>> +{
>> +	smp_mb();
>> +	/* kick all the CPUs so that they exit out of old idle routine */
>> +	smp_call_function(do_nothing, NULL, 1);
>> +}
>> +EXPORT_SYMBOL_GPL(cpu_idle_wait);
>> +
>>   int powersave_nap;
>>
>>   #ifdef CONFIG_SYSCTL
>
> This is gross :-)

Well this is what exists today for x86; so didn't think too
much into this. Maybe there is cleaner way. The requirement
is to completely exit the idle loop and call cpuidle_idle_call()
again. I think sending reschedule may be enough.

With respect to current implementation the arch-independent cpuidle
code needs a cpu_idle_wait() function for any architecture where
CONFIG_SMP is defined. This cpu_idle_wait function is called
whenever we have to pause usage of cpuidle; to switch driver
or governor etc. So maybe there is a cleaner implementation of
cpu_idle_wait instead of smp_call_function(do_nothing...); sending
reschedule may work.

Thanks
-Trinabh

>
> Do you need to absolutely ensure the idle task has changed or just
> kicking it with a send reschedule is enough ?


>
> Cheers,
> Ben.
>
>

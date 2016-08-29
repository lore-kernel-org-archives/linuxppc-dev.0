Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sN1DP5LqqzDrfT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 15:58:45 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7T5rba8015740
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 01:58:43 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0b-001b2d01.pphosted.com with ESMTP id 253r8s3s1g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 01:58:42 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 11:28:39 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 59A61394005C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 11:28:36 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7T5waoe38076446
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 11:28:36 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7T5wYdn001350
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 11:28:35 +0530
Subject: Re: [RFC PATCH v4 11/12] powerpc: Add a Kconfig and a function to set
 new soft_enabled mask
To: Nicholas Piggin <npiggin@gmail.com>
References: <1472409448-18172-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472409448-18172-12-git-send-email-maddy@linux.vnet.ibm.com>
 <20160829114129.7e68c805@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 29 Aug 2016 11:28:33 +0530
MIME-Version: 1.0
In-Reply-To: <20160829114129.7e68c805@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <afd3af21-a333-76f9-5072-b35d567f4d19@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 29 August 2016 07:11 AM, Nicholas Piggin wrote:
> On Mon, 29 Aug 2016 00:07:27 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> New Kconfig is added "CONFIG_IRQ_DEBUG_SUPPORT" to add a warn_on
>> to alert the usage of soft_irq_set_mask() for disabling lower
>> bitmask interrupts.
>>
>> Have also moved the code under the CONFIG_TRACE_IRQFLAGS in
>> arch_local_irq_restore() to new Kconfig as suggested.
>>
>> Patch also adds a new soft_irq_set_mask() to update paca->soft_enabled.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/Kconfig              |  4 ++++
>>   arch/powerpc/include/asm/hw_irq.h | 17 +++++++++++++++++
>>   arch/powerpc/kernel/irq.c         |  4 ++--
>>   3 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 927d2ab2ce08..878f05925340 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -51,6 +51,10 @@ config TRACE_IRQFLAGS_SUPPORT
>>   	bool
>>   	default y
>>   
>> +config IRQ_DEBUG_SUPPORT
>> +	bool
>> +	default n
>> +
>>   config LOCKDEP_SUPPORT
>>   	bool
>>   	default y
>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
>> index 415734c07cfa..9f71559ce868 100644
>> --- a/arch/powerpc/include/asm/hw_irq.h
>> +++ b/arch/powerpc/include/asm/hw_irq.h
>> @@ -81,6 +81,23 @@ static inline unsigned long arch_local_irq_disable(void)
>>   	return flags;
>>   }
>>   
>> +static inline unsigned long soft_irq_set_mask(int value)
>> +{
>> +	unsigned long flags, zero;
>> +
>> +#ifdef CONFIG_IRQ_DEBUG_SUPPORT
>> +	WARN_ON(value <= IRQ_DISABLE_MASK_LINUX);
>> +#endif
>> +	asm volatile(
>> +		"li %1,%3; lbz %0,%2(13); stb %1,%2(13)"
>> +		: "=r" (flags), "=&r" (zero)
>> +		: "i" (offsetof(struct paca_struct, soft_enabled)),\
>> +		 "i" (value)
>> +		: "memory");
>> +
>> +	return flags;
>> +}
> One other thing, if we have:
>
> local_irq_save(flags);              // disable LINUX mask -> LINUX
> local_irq_and_pmu_save(flags);      // disable PMU   mask -> LINUX|PMU
> local_irq_and_pmu_restore(flags);   // enable  PMU   mask -> LINUX
> local_irq_restore(flags);           // enable  LINUX mask -> NONE
>
> Then the nested code that re-enables PMUs will not replay PMU interrupt
> until the outer irq is re-enabled. I don't *think* this is a problem,
> but it probably should be commented.

Yes. That is right. Will comment.

>
> Which brings us to arch_local_irq_restore() (from another patch):
>
>
> @@ -208,7 +209,7 @@ notrace void arch_local_irq_restore(unsigned long en)
>
>   	/* Write the new soft-enabled value */
>   	set_soft_enabled(en);
> -	if (!en)
> +	if (en == IRQ_DISABLE_MASK_LINUX)
>   		return;
>   	/*
>   	 * From this point onward, we can take interrupts, preempt,
>
> I think this is a bit buggy for some cases of nested disables. For the
> above it is okay, but if we have:
>
> local_irq_and_pmu_save(flags);
> local_irq_and_pmu_save(flags);
> local_irq_and_pmu_restore(flags);
> local_irq_and_pmu_restore(flags);
>
>
> The first restore will restore LINUX|PMU mask, which will not be caught
> by this check.

Nice catch :). Yes, this should be non-zero check.

Also looking more closing, another possible issue is with this seq,

local_irq_and_pmu_save(flags);
local_irq_save(flags);

Currently we do just store in the set_soft_enabled(), which will
reset the PMI bit in the above seq. So need to rework on the 
set_soft_enabled().

Maddy
> Testing instead for non-zero (any IRQ bits masked) should work. We should
> probably also add an IRQ_DEBUG_SUPPORT check to ensure LINUX bit is always
> one of the outer-most bits to be cleared (theoretically we could support
> masking other bits without masking LINUX, but let's disallow that until a
> compelling use case shows up).
>
> Thanks,
> Nick
>

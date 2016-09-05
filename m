Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSbzB5gbhzDrqP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 03:18:14 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85HD3j1135885
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 13:18:12 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 258bv059cf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 13:18:12 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 6 Sep 2016 03:18:09 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 73E272BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 03:18:06 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85HI6v861276412
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 03:18:06 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85HI5Fh007286
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 03:18:06 +1000
Subject: Re: [RFC PATCH v4 11/12] powerpc: Add a Kconfig and a function to set
 new soft_enabled mask
To: Nicholas Piggin <npiggin@gmail.com>
References: <1472409448-18172-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472409448-18172-12-git-send-email-maddy@linux.vnet.ibm.com>
 <20160829114129.7e68c805@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 5 Sep 2016 22:48:00 +0530
MIME-Version: 1.0
In-Reply-To: <20160829114129.7e68c805@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9fbb7a10-13a2-8542-2050-d73a958167d7@linux.vnet.ibm.com>
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
>
> Testing instead for non-zero (any IRQ bits masked) should work. We should
> probably also add an IRQ_DEBUG_SUPPORT check to ensure LINUX bit is always
> one of the outer-most bits to be cleared (theoretically we could support

Just sent out the newer version of the patchset with most of the 
comments addressed.
But I am not sure about this comment. IIUC, will something like this 
will do?

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a02c6a3bc6fa..af0c08aefbcf 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -209,6 +209,11 @@ notrace void arch_local_irq_restore(unsigned long en)
         unsigned char irq_happened;
         unsigned int replay;

+#ifdef CONFIG_IRQ_DEBUG_SUPPORT
+       WARN_ONCE (en & (en & local_paca->soft_enabled),
+                  "soft_enabled transition to Unsupported state\n");
+#endif
+
         /* Write the new soft-enabled value */
         set_soft_enabled(en);

Maddy

> masking other bits without masking LINUX, but let's disallow that until a
> compelling use case shows up).
>
> Thanks,
> Nick
>

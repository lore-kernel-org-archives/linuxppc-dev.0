Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz7mj2JC4zDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:40:53 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6Q6Xjpb103362
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 02:40:51 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24dsrmye2u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 02:40:51 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 12:10:47 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id BA29BE0068
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 12:14:58 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6Q6dGra13500806
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 12:09:16 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6Q6egfr009120
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 12:10:44 +0530
Subject: Re: [RFC PATCH 8/9] powerpc: Support to replay PMIs
To: Nicholas Piggin <npiggin@gmail.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-9-git-send-email-maddy@linux.vnet.ibm.com>
 <20160726155058.13651136@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 26 Jul 2016 12:10:38 +0530
MIME-Version: 1.0
In-Reply-To: <20160726155058.13651136@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <e0ed67f5-100f-f58f-5c12-5e8cb5700569@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 26 July 2016 11:20 AM, Nicholas Piggin wrote:
> On Mon, 25 Jul 2016 20:22:21 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> Code to replay the Performance Monitoring Interrupts(PMI).
>> In the masked_interrupt handler, for PMIs we reset the MSR[EE]
>> and return. This is due the fact that PMIs are level triggered.
>> In the __check_irq_replay(), we enabled the MSR[EE] which will
>> fire the interrupt for us.
>>
>> Patch also adds a new arch_local_irq_disable_var() variant. New
>> variant takes an input value to write to the paca->soft_enabled.
>> This will be used in following patch to implement the tri-state
>> value for soft-enabled.
> Same comment also applies about patches being standalone
> transformations that work before and after. Some of these
> can be squashed together I think.
Sure.

>
>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/hw_irq.h | 14 ++++++++++++++
>>   arch/powerpc/kernel/irq.c         |  9 ++++++++-
>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/hw_irq.h
>> b/arch/powerpc/include/asm/hw_irq.h index cc69dde6eb84..863179654452
>> 100644 --- a/arch/powerpc/include/asm/hw_irq.h
>> +++ b/arch/powerpc/include/asm/hw_irq.h
>> @@ -81,6 +81,20 @@ static inline unsigned long
>> arch_local_irq_disable(void) return flags;
>>   }
>>   
>> +static inline unsigned long arch_local_irq_disable_var(int value)
>> +{
>> +	unsigned long flags, zero;
>> +
>> +	asm volatile(
>> +		"li %1,%3; lbz %0,%2(13); stb %1,%2(13)"
>> +		: "=r" (flags), "=&r" (zero)
>> +		: "i" (offsetof(struct paca_struct, soft_enabled)),\
>> +		  "i" (value)
>> +		: "memory");
>> +
>> +	return flags;
>> +}
> arch_ function suggests it is arch implementation of a generic
> kernel function or something. I think our soft interrupt levels
> are just used in powerpc specific code.
>
> The name could also be a little more descriptive.
>
> I would have our internal function be something like
>
> soft_irq_set_level(), and then the arch disable just sets to
> the appropriate level as it does today.
>
> The PMU disable level could be implemented in powerpc specific
> header with local_irq_and_pmu_disable() or something like that.

Yes. will do.

>
> Thanks,
> Nick
>

Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2pnq1mMLzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 16:09:35 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7169Bhq078469
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 02:09:32 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24gpcv87u5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 02:09:32 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 11:39:28 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 97787E005B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 11:43:44 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7169PTD19267644
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 11:39:25 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7169KYZ012002
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 11:39:25 +0530
Subject: Re: [RFC PATCH v2 09/11] powerpc: Add support to mask perf interrupts
To: Nicholas Piggin <npiggin@gmail.com>
References: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469991989-28409-10-git-send-email-maddy@linux.vnet.ibm.com>
 <20160801152941.6a225a01@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 1 Aug 2016 11:39:18 +0530
MIME-Version: 1.0
In-Reply-To: <20160801152941.6a225a01@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <7f7cf8cd-55cd-18ba-b071-95ec44ac18aa@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 01 August 2016 10:59 AM, Nicholas Piggin wrote:
> On Mon,  1 Aug 2016 00:36:27 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>>   /*
>>    * flags for paca->soft_enabled
>>    */
>>   #define IRQ_DISABLE_LEVEL_NONE		0
>>   #define IRQ_DISABLE_LEVEL_LINUX		1
>> +#define IRQ_DISABLE_LEVEL_PMU		2
>> +
>> +#define MASK_IRQ_LEVEL		IRQ_DISABLE_LEVEL_LINUX | IRQ_DISABLE_LEVEL_PMU
>>   
>>   
>>   #endif /* CONFIG_PPC64 */
>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>> index 2c87e82ecbe4..56dc71b82824 100644
>> --- a/arch/powerpc/kernel/exceptions-64s.S
>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>> @@ -256,11 +256,11 @@ hardware_interrupt_pSeries:
>>   hardware_interrupt_hv:
>>   	BEGIN_FTR_SECTION
>>   		_MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt,
>> -					    EXC_HV, SOFTEN_TEST_HV, IRQ_DISABLE_LEVEL_LINUX)
>> +					    EXC_HV, SOFTEN_TEST_HV, MASK_IRQ_LEVEL)
> So what I was expecting is that each exception handler would specify the
> level (or bit, if we use bitmask) at which it gets disabled. The test code
> will then test the exception level with the enable level (or s/level/mask).
>
> The way you have now is each exception handler specifying the bits which
> cause it to be disabled, but I think that's kind of backwards -- the
> disabler knows which interrupts it wants to disable, the exception handler
> does not know what disablers want to disable it :)

Yep. My bad. Implemented backwards.

>
> So to disable PMU and "linux" interrupts for local_t operations, you would
> have:
>
> local_irq_set_mask(IRQ_DISABLE_LEVEL_LINUX|IRQ_DISABLE_LEVEL_PMU)

Yep. Right now I made the exception handler to specify this and
  soft_irq_set_level() set the level. But this a minor change.

>
> And that would disable both handlers that test with IRQ_DISABLE_LEVEL_LINUX
> and IRQ_DISABLE_LEVEL_PMU
>
> Does that make sense? What do you think?

Yes. it make sense.
But would like to get comments for the SOFTEN_TEST changes.

Maddy

>
> Thanks,
> Nick
>

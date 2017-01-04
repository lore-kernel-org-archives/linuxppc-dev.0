Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttxfM24MRzDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 03:51:22 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v04GnAZB124520
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 11:51:20 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27s340vuvy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 11:51:20 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 4 Jan 2017 22:21:14 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1B131125805C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 22:22:41 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v04GoR1C26673216
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 22:20:27 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v04GpBC4023176
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 22:21:12 +0530
Subject: Re: [PATCH v5 08/12] powerpc: Add support to mask perf interrupts and
 replay them
To: Nicholas Piggin <npiggin@gmail.com>
References: <1483530590-30274-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1483530590-30274-9-git-send-email-maddy@linux.vnet.ibm.com>
 <20170104223801.739a09a7@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 4 Jan 2017 22:21:05 +0530
MIME-Version: 1.0
In-Reply-To: <20170104223801.739a09a7@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <fff30cf9-a589-2a6d-ec87-40a92fb084a2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 04 January 2017 06:08 PM, Nicholas Piggin wrote:
> On Wed,  4 Jan 2017 17:19:46 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> @@ -134,7 +137,7 @@ static inline bool arch_irqs_disabled(void)
>>   	_was_enabled = local_paca->soft_enabled;	\
>>   	local_paca->soft_enabled = IRQ_DISABLE_MASK_LINUX;\
>>   	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
>> -	if (!(_was_enabled & IRQ_DISABLE_MASK_LINUX))	\
>> +	if (!(_was_enabled & IRQ_DISABLE_MASK_ALL))	\
>>   		trace_hardirqs_off();			\
>>   } while(0)
> Hang on, maybe there's some confusion about this. trace_hardirqs_off() is
> for Linux irqs (i.e., local_irq_disable()), so that should continue to
> test just the LINUX mask I think. Otherwise this
>
>      powerpc_local_pmu_disable();
>      hard_irq_disable();

Currently we set both bits for pmu soft disable

                 flags = 
soft_disabled_mask_or_return(IRQ_DISABLE_MASK_LINUX | \
IRQ_DISABLE_MASK_PMU);                  \

So yes in the above seq, we will miss the pmu bit. But since 
trace_hardirqs_off()
is for _LINUX, instead will it not be safer to OR it?

         local_paca->soft_disabled_mask |= IRQ_DISABLE_MASK_LINUX;\

Maddy

> Will miss calling trace_hardirqs_off(). You don't have a function that
> disables PMU irqs without Linux irqs, but one might exist.
>
> What I was concerned about is actually setting the disable mask to ALL
>
>    	local_paca->soft_enabled = IRQ_DISABLE_MASK_ALL;
>
> No? Otherwise if you did
>
>      powerpc_local_irq_pmu_disable();
>      hard_irq_disable();
>
> Then you would lose the PMU bit out of the mask.
>
> Thanks,
> Nick
>

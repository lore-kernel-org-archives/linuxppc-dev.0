Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scwLD167SzDsd8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 16:03:31 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8J630hF010328
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 02:03:29 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25h2138a42-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 02:03:29 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 16:03:26 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 679A62BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 16:03:24 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8J63O9e40697956
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 16:03:24 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8J63NRP025848
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 16:03:24 +1000
Subject: Re: [PATCH 12/13] powerpc: Add a Kconfig and a functions to set new
 soft_enabled mask
To: Nicholas Piggin <npiggin@gmail.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-13-git-send-email-maddy@linux.vnet.ibm.com>
 <20160916205644.0663db70@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 19 Sep 2016 11:33:21 +0530
MIME-Version: 1.0
In-Reply-To: <20160916205644.0663db70@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4174dbc6-cbe4-9971-6dee-7d6d89252c82@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 16 September 2016 04:26 PM, Nicholas Piggin wrote:
> On Thu, 15 Sep 2016 18:32:02 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>
>> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
>> index 9e5e9a6d4147..ae31b1e85fdb 100644
>> --- a/arch/powerpc/kernel/irq.c
>> +++ b/arch/powerpc/kernel/irq.c
>> @@ -209,6 +209,10 @@ notrace void arch_local_irq_restore(unsigned long en)
>>   	unsigned char irq_happened;
>>   	unsigned int replay;
>>   
>> +#ifdef CONFIG_IRQ_DEBUG_SUPPORT
>> +	WARN_ON(en & local_paca->soft_enabled & ~IRQ_DISABLE_MASK_LINUX);
>> +#endif
>> +
>>   	/* Write the new soft-enabled value */
>>   	soft_enabled_set(en);
>>   
> Oh one other quick thing I just noticed: you could put this debug
> check into your soft_enabled accessors.

OK. Will move it.

> We did decide it's okay for your masking level to go both ways,
> didn't we? I.e.,
>
> local_irq_disable();
> local_irq_pmu_save(flags);
> local_irq_pmu_restore(flags);
> local_irq_enable();
>
> -> LINUX -> LINUX|PMU -> LINUX ->
>
> This means PMU interrupts would not get replayed despite being
> enabled here. In practice I think that doesn't matter/can't happen
> because a PMU interrupt while masked would hard disable anyway. A
> comment explaining it might be nice though.

Yes. I though i did the comment. Apologies. Will respin
with the comment.

Maddy

> Thanks,
> Nick
>

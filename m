Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scss15dvnzDscr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 14:11:33 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8J48udM092954
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 00:11:31 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25h21356u5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 00:11:31 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 14:11:28 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EF617357805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 14:11:24 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8J4BOk263176824
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 14:11:24 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8J4BOpA026191
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 14:11:24 +1000
Subject: Re: [PATCH 04/13] powerpc: Use soft_enabled_set api to update
 paca->soft_enabled
To: Nicholas Piggin <npiggin@gmail.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-5-git-send-email-maddy@linux.vnet.ibm.com>
 <20160916195302.6b2f3320@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 19 Sep 2016 09:41:22 +0530
MIME-Version: 1.0
In-Reply-To: <20160916195302.6b2f3320@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <10c5d1b2-e62a-2ccb-d200-ea0c293637f9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 16 September 2016 03:23 PM, Nicholas Piggin wrote:
> On Thu, 15 Sep 2016 18:31:54 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> Force use of soft_enabled_set() wrapper to update paca-soft_enabled
>> wherever possisble. Also add a new wrapper function, soft_enabled_set_return(),
>> added to force the paca->soft_enabled updates.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/hw_irq.h  | 14 ++++++++++++++
>>   arch/powerpc/include/asm/kvm_ppc.h |  2 +-
>>   arch/powerpc/kernel/irq.c          |  2 +-
>>   arch/powerpc/kernel/setup_64.c     |  4 ++--
>>   arch/powerpc/kernel/time.c         |  6 +++---
>>   5 files changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
>> index 8fad8c24760b..f828b8f8df02 100644
>> --- a/arch/powerpc/include/asm/hw_irq.h
>> +++ b/arch/powerpc/include/asm/hw_irq.h
>> @@ -53,6 +53,20 @@ static inline notrace void soft_enabled_set(unsigned long enable)
>>   	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
>>   }
>>   
>> +static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
>> +{
>> +	unsigned long flags;
>> +
>> +	asm volatile(
>> +		"lbz %0,%1(13); stb %2,%1(13)"
>> +		: "=r" (flags)
>> +		: "i" (offsetof(struct paca_struct, soft_enabled)),\
>> +		  "r" (enable)
>> +		: "memory");
>> +
>> +	return flags;
>> +}
> Why do you have the "memory" clobber here while soft_enabled_set() does not?

I did change to function to include a local variable
and update the soft_enabled. But, my bad. It was in the next patch.
I should make the change here. Yes. we dont a "memory" clobber here
which is right. But, this change is not complete and I will correct it.

Maddy

>
> Thanks,
> Nick
>

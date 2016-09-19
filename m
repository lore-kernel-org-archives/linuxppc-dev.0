Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scvsT72HNzDsd8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:42:05 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8J5biII034226
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:42:04 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25hr4hkch2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:42:03 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 15:42:01 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3D50F2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:41:59 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8J5fx6s6357304
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:41:59 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8J5fwZn032261
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:41:59 +1000
Subject: Re: [PATCH 05/13] powerpc: Add soft_enabled manipulation functions
To: Nicholas Piggin <npiggin@gmail.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-6-git-send-email-maddy@linux.vnet.ibm.com>
 <20160916195754.47de292e@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 19 Sep 2016 11:11:56 +0530
MIME-Version: 1.0
In-Reply-To: <20160916195754.47de292e@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3bc73f70-d62c-ca43-e302-eaf396026bee@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 16 September 2016 03:27 PM, Nicholas Piggin wrote:
> On Thu, 15 Sep 2016 18:31:55 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> Add new soft_enabled_* manipulation function and implement
>> arch_local_* using the soft_enabled_* wrappers.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/hw_irq.h | 32 ++++++++++++++------------------
>>   1 file changed, 14 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
>> index f828b8f8df02..dc3c248f9244 100644
>> --- a/arch/powerpc/include/asm/hw_irq.h
>> +++ b/arch/powerpc/include/asm/hw_irq.h
>> @@ -53,21 +53,7 @@ static inline notrace void soft_enabled_set(unsigned long enable)
>>   	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
>>   }
>>   
>> -static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
>> -{
>> -	unsigned long flags;
>> -
>> -	asm volatile(
>> -		"lbz %0,%1(13); stb %2,%1(13)"
>> -		: "=r" (flags)
>> -		: "i" (offsetof(struct paca_struct, soft_enabled)),\
>> -		  "r" (enable)
>> -		: "memory");
>> -
>> -	return flags;
>> -}
>> -
>> -static inline unsigned long arch_local_save_flags(void)
>> +static inline notrace unsigned long soft_enabled_return(void)
>>   {
>>   	unsigned long flags;
>>   
>> @@ -79,20 +65,30 @@ static inline unsigned long arch_local_save_flags(void)
>>   	return flags;
>>   }
>>   
>> -static inline unsigned long arch_local_irq_disable(void)
>> +static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
>>   {
>>   	unsigned long flags, zero;
>>   
>>   	asm volatile(
>> -		"li %1,%3; lbz %0,%2(13); stb %1,%2(13)"
>> +		"mr %1,%3; lbz %0,%2(13); stb %1,%2(13)"
>>   		: "=r" (flags), "=&r" (zero)
>>   		: "i" (offsetof(struct paca_struct, soft_enabled)),\
>> -		  "i" (IRQ_DISABLE_MASK_LINUX)
>> +		  "r" (enable)
>>   		: "memory");
>>   
>>   	return flags;
>>   }
> As we talked about earlier, it would be nice to add builtin_constant
> variants to avoid the extra instruction. If you prefer to do that
> after this series, that's fine.

True. my bad. Will look into this.

Maddy

>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>

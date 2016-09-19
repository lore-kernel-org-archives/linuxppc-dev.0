Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scv314wWBzDsd8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:05:17 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8J52nVD045654
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:05:15 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25h059tfk6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:05:14 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 15:05:12 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 629952CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:05:09 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8J5598o1179958
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:05:09 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8J5590G009111
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:05:09 +1000
Subject: Re: [PATCH 04/13] powerpc: Use soft_enabled_set api to update
 paca->soft_enabled
To: David Laight <David.Laight@ACULAB.COM>,
 "'Nicholas Piggin'" <npiggin@gmail.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-5-git-send-email-maddy@linux.vnet.ibm.com>
 <20160916195302.6b2f3320@roar.ozlabs.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DB00FF817@AcuExch.aculab.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>, "anton@samba.org" <anton@samba.org>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 19 Sep 2016 10:35:07 +0530
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB00FF817@AcuExch.aculab.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <06007218-b267-3c42-eba0-481597d488cb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 16 September 2016 05:13 PM, David Laight wrote:
> From: Nicholas Piggin
>> Sent: 16 September 2016 10:53
>> On Thu, 15 Sep 2016 18:31:54 +0530
>> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>>
>>> Force use of soft_enabled_set() wrapper to update paca-soft_enabled
>>> wherever possisble. Also add a new wrapper function, soft_enabled_set_return(),
>>> added to force the paca->soft_enabled updates.
> ...
>>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
>>> index 8fad8c24760b..f828b8f8df02 100644
>>> --- a/arch/powerpc/include/asm/hw_irq.h
>>> +++ b/arch/powerpc/include/asm/hw_irq.h
>>> @@ -53,6 +53,20 @@ static inline notrace void soft_enabled_set(unsigned long enable)
>>>   	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
>>>   }
>>>
>>> +static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
>>> +{
>>> +	unsigned long flags;
>>> +
>>> +	asm volatile(
>>> +		"lbz %0,%1(13); stb %2,%1(13)"
>>> +		: "=r" (flags)
>>> +		: "i" (offsetof(struct paca_struct, soft_enabled)),\
>>> +		  "r" (enable)
>>> +		: "memory");
>>> +
>>> +	return flags;
>>> +}
>> Why do you have the "memory" clobber here while soft_enabled_set() does not?
> I wondered about the missing memory clobber earlier.
>
> Any 'clobber' ought to be restricted to the referenced memory area.
> If the structure is only referenced by r13 through 'asm volatile' it isn't needed.
> OTOH why not allocate a global register variable to r13 and access through that?

I do see this in asm/paca.h "register struct paca_struct *local_paca 
asm("r13"); "
and __check_irq_replay() in kernel/irq.c do updates the "irq_happened" as
mentioned. But existing helpers in hw_irq update the soft_enabled via
asm volatile and i did the same.

Maddy

> 	David
>

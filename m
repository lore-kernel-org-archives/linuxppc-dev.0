Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scvf140HJzDsjB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:32:09 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8J5Rv6O146764
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:32:07 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25hxp099fg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:32:07 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 15:32:05 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 592CB2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:32:02 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8J5W2C04587826
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:32:02 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8J5W1Xv010085
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:32:02 +1000
Subject: Re: [PATCH 04/13] powerpc: Use soft_enabled_set api to update
 paca->soft_enabled
To: Nicholas Piggin <npiggin@gmail.com>, David Laight <David.Laight@ACULAB.COM>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-5-git-send-email-maddy@linux.vnet.ibm.com>
 <20160916195302.6b2f3320@roar.ozlabs.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DB00FF817@AcuExch.aculab.com>
 <20160916215923.08c6aa2a@roar.ozlabs.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DB00FF847@AcuExch.aculab.com>
 <20160919125247.378b7f31@roar.ozlabs.ibm.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>, "anton@samba.org" <anton@samba.org>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 19 Sep 2016 11:02:00 +0530
MIME-Version: 1.0
In-Reply-To: <20160919125247.378b7f31@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9effd206-88a3-c70c-cd12-f84d3ec0fca3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 19 September 2016 08:22 AM, Nicholas Piggin wrote:
> On Fri, 16 Sep 2016 13:22:24 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
>
>> From: Nicholas Piggin
>>> Sent: 16 September 2016 12:59
>>> On Fri, 16 Sep 2016 11:43:13 +0000
>>> David Laight <David.Laight@ACULAB.COM> wrote:
>>>    
>>>> From: Nicholas Piggin
>>>>> Sent: 16 September 2016 10:53
>>>>> On Thu, 15 Sep 2016 18:31:54 +0530
>>>>> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>>>>>   
>>>>>> Force use of soft_enabled_set() wrapper to update paca-soft_enabled
>>>>>> wherever possisble. Also add a new wrapper function, soft_enabled_set_return(),
>>>>>> added to force the paca->soft_enabled updates.
>>>> ...
>>>>>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
>>>>>> index 8fad8c24760b..f828b8f8df02 100644
>>>>>> --- a/arch/powerpc/include/asm/hw_irq.h
>>>>>> +++ b/arch/powerpc/include/asm/hw_irq.h
>>>>>> @@ -53,6 +53,20 @@ static inline notrace void soft_enabled_set(unsigned long enable)
>>>>>>   	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
>>>>>>   }
>>>>>>
>>>>>> +static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
>>>>>> +{
>>>>>> +	unsigned long flags;
>>>>>> +
>>>>>> +	asm volatile(
>>>>>> +		"lbz %0,%1(13); stb %2,%1(13)"
>>>>>> +		: "=r" (flags)
>>>>>> +		: "i" (offsetof(struct paca_struct, soft_enabled)),\
>>>>>> +		  "r" (enable)
>>>>>> +		: "memory");
>>>>>> +
>>>>>> +	return flags;
>>>>>> +}
>>>>> Why do you have the "memory" clobber here while soft_enabled_set() does not?
>>>> I wondered about the missing memory clobber earlier.
>>>>
>>>> Any 'clobber' ought to be restricted to the referenced memory area.
>>>> If the structure is only referenced by r13 through 'asm volatile' it isn't needed.
>>> Well a clobber (compiler barrier) at some point is needed in irq_disable and
>>> irq_enable paths, so we correctly open and close the critical section vs interrupts.
>>> I just wonder about these helpers. It might be better to take the clobbers out of
>>> there and add barrier(); in callers, which would make it more obvious.
>> If the memory clobber is needed to synchronise with the rest of the code
>> rather than just ensuring the compiler doesn't reorder accesses via r13
>> then I'd add an explicit barrier() somewhere - even if in these helpers.
>>
>> Potentially the helper wants a memory clobber for the (r13) area
>> and a separate barrier() to ensure the interrupts are masked for the
>> right code.
>> Even if both are together in the same helper.
> Good point. Some of the existing modification helpers don't seem to have
> clobbers for modifying the r13->soft_enabled memory itself, but they do
> have the memory clobber where a critical section barrier is required.
>
> The former may not be a problem if the helpers are used very carefully,
> but probably should be commented at best, if not fixed.

Yes. Agreed. Will add comments

>   So after Madhi's
> patches, we should make all accesses go via the helper functions, so a
> clobber for the soft_enabled modification may not be required (this should
> be commented). I think it may be cleaner to specify the location in the
> constraints, but maybe that doesn't generate the best code -- something to
> investigate.
>
> Then, I'd like to see barrier()s for interrupt critical sections placed in
> the callers of these helpers, which will make the code more obvious.

Ok will look into this.

>
> Thanks,
> Nick
>

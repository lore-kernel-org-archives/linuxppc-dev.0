Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429gqM0GTSzF3R8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 11:22:06 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8D1IsRK138251
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 21:22:04 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mfce2bg33-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 21:22:04 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 12 Sep 2018 21:22:03 -0400
Subject: Re: [PATCH v2] powerpc: Avoid code patching freed init sections
To: Michael Neuling <mikey@neuling.org>,
 Christophe LEROY <christophe.leroy@c-s.fr>, mpe@ellerman.id.au
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20180912052058.10062-1-mikey@neuling.org>
 <0922624b-6c6f-1afd-a9e2-cde5a9a8a1e4@c-s.fr>
 <29d3467a9314f5b80f93d241ae2566c48b546bfe.camel@neuling.org>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Wed, 12 Sep 2018 18:21:58 -0700
MIME-Version: 1.0
In-Reply-To: <29d3467a9314f5b80f93d241ae2566c48b546bfe.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <e8a68da4-1c58-b30b-ccd0-f37a9e7c330c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/12/2018 05:36 PM, Michael Neuling wrote:
> 
>>> --- a/arch/powerpc/lib/code-patching.c
>>> +++ b/arch/powerpc/lib/code-patching.c
>>> @@ -23,11 +23,33 @@
>>>   #include <asm/code-patching.h>
>>>   #include <asm/setup.h>
>>>   
>>> +
>>
>> This blank line is not needed
> 
> Ack
> 
>>
>>> +static inline bool in_init_section(unsigned int *patch_addr)
>>> +{
>>> +	if (patch_addr < (unsigned int *)__init_begin)
>>> +		return false;
>>> +	if (patch_addr >= (unsigned int *)__init_end)
>>> +		return false;
>>> +	return true;
>>> +}
>>
>> Can we use the existing function init_section_contains() instead of this 
>> new function ?
> 
> Nice, I was looking for something like that... 
> 
>>> +
>>> +static inline bool init_freed(void)
>>> +{
>>> +	return (system_state >= SYSTEM_RUNNING);
>>> +}
>>> +
>>
>> I would call this function differently, for instance init_is_finished(), 
>> because as you mentionned it doesn't exactly mean that init memory is freed.
> 
> Talking to Nick and mpe offline I think we are going to have to add a flag when
> we free init mem rather than doing what we have now since what we have now has a
> potential race. That change will eliminate the function entirely.
> 
>>>   static int __patch_instruction(unsigned int *exec_addr, unsigned int
>>> instr,
>>>   			       unsigned int *patch_addr)
>>>   {
>>>   	int err;
>>>   
>>> +	/* Make sure we aren't patching a freed init section */
>>> +	if (in_init_section(patch_addr) && init_freed()) {
>>
>> The test must be done on exec_addr, not on patch_addr, as patch_addr is 
>> the address where the instruction as been remapped RW for allowing its 
>> modification.
> 
> Thanks for the catch
> 
>> Also I think it should be tested the other way round, because the 
>> init_freed() is a simpler test which will be false most of the time once 
>> the system is running so it should be checked first.
> 
> ok, I'll change.
> 
>>> +		printk(KERN_DEBUG "Skipping init section patching addr:
>>> 0x%lx\n",
>>
>> Maybe use pr_debug() instead.
> 
> Sure.
> 
>>
>>> +			(unsigned long)patch_addr);
>>
>> Please align second line as per Codying style.
> 
> Sorry I can't see what's wrong. You're (or Cody :-P) going to have to spell it
> this out for me...

I suspect that the suggestion is the opening parenthesis of "(unsigned long)" should sit directly under the "K" of "KERN_DEBUG". I'm pretty sure Documentation/process/coding-style.rst is very adamant that all identation is always 8 characters and spaces should never be used, but there still seems to be a lot of places/suggestions that argument lists that spill over multiple lines should be space indented to align with the very first argument at the top level. So, I guess I'm not sure what the desire is here. Although moving to pr_debug might fit it to a single line anyways. ;)

-Tyrel

> 
>>
>>> +		return 0;
>>> +	}
>>> +
>>>   	__put_user_size(instr, patch_addr, 4, err);
>>>   	if (err)
>>>   		return err;
>>>
>>
>> I think it would be better to put this verification in 
>> patch_instruction() instead, to avoid RW mapping/unmapping the 
>> instruction to patch when we are not going to do the patching.
> 
> If we do it there then we miss the raw_patch_intruction case.
> 
> IMHO I don't think we need to optimise this rare and non-critical path. 
> 
> Mikey
> 

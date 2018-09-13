Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429ngc5YXZzF3Rb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 15:45:48 +1000 (AEST)
Subject: Re: [PATCH v2] powerpc: Avoid code patching freed init sections
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 paulus@ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <20180912052058.10062-1-mikey@neuling.org>
 <0922624b-6c6f-1afd-a9e2-cde5a9a8a1e4@c-s.fr>
 <29d3467a9314f5b80f93d241ae2566c48b546bfe.camel@neuling.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <3cc9302c-4399-50cc-0ec2-87552eb2080c@c-s.fr>
Date: Thu, 13 Sep 2018 07:45:44 +0200
MIME-Version: 1.0
In-Reply-To: <29d3467a9314f5b80f93d241ae2566c48b546bfe.camel@neuling.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 13/09/2018 à 02:36, Michael Neuling a écrit :
> 
>>> --- a/arch/powerpc/lib/code-patching.c
>>> +++ b/arch/powerpc/lib/code-patching.c
>>> @@ -23,11 +23,33 @@
>>>    #include <asm/code-patching.h>
>>>    #include <asm/setup.h>
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
>>>    static int __patch_instruction(unsigned int *exec_addr, unsigned int
>>> instr,
>>>    			       unsigned int *patch_addr)
>>>    {
>>>    	int err;
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
> 
>>
>>> +		return 0;
>>> +	}
>>> +
>>>    	__put_user_size(instr, patch_addr, 4, err);
>>>    	if (err)
>>>    		return err;
>>>
>>
>> I think it would be better to put this verification in
>> patch_instruction() instead, to avoid RW mapping/unmapping the
>> instruction to patch when we are not going to do the patching.
> 
> If we do it there then we miss the raw_patch_intruction case.

raw_patch_instruction() can only be used during init. Once kernel memory 
has been marked readonly, raw_patch_instruction() cannot be used 
anymore. And mark_readonly() is called immediately after free_initmem()

Christophe


> 
> IMHO I don't think we need to optimise this rare and non-critical path.
> 
> Mikey
> 

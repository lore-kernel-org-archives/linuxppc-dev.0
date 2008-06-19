Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E19CFDDEE7
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 16:10:42 +1000 (EST)
Message-Id: <4D6D9E9A-EE1C-45E5-B493-0249C256B02B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <29411.1213855280@neuling.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 5/9] powerpc: Introduce VSX thread_struct and CONFIG_VSX 
Date: Thu, 19 Jun 2008 01:10:32 -0500
References: <20080618004734.0B72E70296@localhost.localdomain>
	<5AEB0769-1394-4924-803D-C40CAF685519@kernel.crashing.org>
	<14228.1213850120@neuling.org>
	<A62DFD0C-387A-4833-B266-99DB1B09E101@kernel.crashing.org>
	<26165.1213853871@neuling.org>
	<B0E87874-BC65-4037-A43D-91C4142475E7@kernel.crashing.org>
	<29411.1213855280@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 19, 2008, at 1:01 AM, Michael Neuling wrote:

> In message <B0E87874-BC65-4037- 
> A43D-91C4142475E7@kernel.crashing.org> you wrote
> :
>>>>>>> +	} fpvsr __attribute__((aligned(16)));
>>>>>>
>>>>>> Do we really need a union here?  what would happen if you just
>>>>>> changed
>>>>>> the type of fpr[32] from double to vector if #CONFIG_VSX?
>>>>>>
>>>>>> I really dont like the union and think we can just make the  
>>>>>> storage
>>>>>> look opaque which is the key.  I doubt we every really care about
>>>>>> using fpr[] as a double in the kernel.
>>>>>
>>>>> I did something similar to this for the first cut of this patch,  
>>>>> but
>>>>> it
>>>>> made the code accessing this structure much less readable.
>>>>
>>>> really, what code is that?
>>>
>>> Any code that has to read/write the top or bottom 64 bits _only_ of
>>> the
>>> 128 bit vector.
>>>
>>> The signals code is a good example where, for backwards  
>>> compatibility,
>>> we need to read/write the old 64 bit FP regs, from the 128 bit value
>>> in
>>> the struct.
>>>
>>> Similarly, the way we've extended the signals interface for VSX, you
>>> need to read/write out the bottom 64 bits (vsrlow) of a 128 bit  
>>> value.
>>>
>>> eg. the simple:
>>>    current->thread.fpvsr.fp[i].vsrlow = buf[i]
>>> would turn into some abomination/macro.
>>
>> it would turn into something like:
>>
>> current->thread.fpr[i][2] = buf[i];
>> current->thread.fpr[i][3] = buf[i+1];
>
> Maybe abomination was going too far :-)
>
> I still think using the union makes it is easier to read than what you
> have here.  Also, it better reflects the structure of what's being
> stored there.

I don't think that holds much weight with me.  We don't union the  
vector128 type to show it also supports float, u16, and u8 types.

I stick by the fact that the ONLY place it looks like you access the  
union via the .vsr member is for memset or memcpy so you clearly know  
if the size should be sizeof(double) or sizeof(vector).

Also, I can see the case in the future that 'fpr's become 128-bits  
wide' and allow for native long double support.

- k

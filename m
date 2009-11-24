Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF44D1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 08:06:26 +1100 (EST)
In-Reply-To: <4B0C1E61.6010101@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<90646C9F-F27D-47AD-9985-83DB7381D6BF@kernel.crashing.org>
	<4B0C1E61.6010101@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AD8F343B-C6F3-403C-B26F-C522775DF8E5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 05/19] powerpc: wii: bootwrapper bits
Date: Tue, 24 Nov 2009 22:13:09 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> + * We enter with an unknown cache, high BATs and MMU status.
>>
>> What does this mean?  You know the low four BATs on entry and
>> nothing else?
>>
>
> That means that we do not make assumptions regarding:
> - the state of the cache (enabled vs disabled)
> - if the high BATs are enabled or not
> - if the MMU is enabled or not
>
> Is this clearer?

Yeah it is.

>>> +    mfmsr    9\n\
>>> +    andi.    0, 9, (1<<4)|(1<<5) /* MSR_DR|MSR_IR */\n\
>>
>>> +    andc    9, 9, 0\n\
>>
>> mfmsr 9 ; rlwinm 9,9,0,~0x30 ?
>>
>
> Yes. Maybe
>
> mfmsr 9 ; rlwinm 9,9,0,~((1<<4)|(1<<5)) /* MSR_DR|MSR_IR */

Sure, or ~0x30 with that comment.  You can save an insn and make
the code clearer at the same time, how exactly you write it, I don't
care :-)

>>> +    mtspr    0x210, 8    /* IBAT0U */\n\
>>> +    mtspr    0x211, 8    /* IBAT0L */\n\
>>
>> You only need to set the upper BAT to zero, saves some code.
>
> Great. Is this documented somewhere?

Sure, it's all in the PEM.

>>> +    isync\n\
>>
>> isync here is cargo cult
>
> I'll offer a dead chicken to compensate for this.

Thanks, I needed some more of those :-)

>> Also, you should normally write the lower BAT first.  Doesn't matter
>> here because IR=DR=0 of course.
>
> I can change that too if it's the general way to go.

Please do.

>>> +    lis    8, 0xcc00    /* I/O mem */\n\
>>> +    ori    8, 8, 0x3ff    /* 32MiB */\n\
>>> +    lis    9, 0x0c00\n\
>>> +    ori    9, 9, 0x002a    /* uncached, guarded, rw */\n\
>>> +    mtspr    0x21a, 8    /* DBAT1U */\n\
>>> +    mtspr    0x21b, 9    /* DBAT1L */\n\
>>
>> Is there any real reason you don't identity map this?

> No. There's a bit of nostalgia there.
> (On the other hand there's no real reason to identity map it).

It's a tiny bit cleaner and stops people from wondering why :-)

>>> +    /* enable high BATs */\n\
>>> +    lis    8, 0x8200\n\
>>> +    mtspr    0x3f3, 8    /* HID4 */\n\
>>
>> You need to use read-modify-write here.  Also, shouldn't you
>> enable the extra BATs before setting them?
>>
>
> No. You should first set them up and then enable them.
> The content of the HIGH BATs is undefined on boot, AFAIK.

All BATs are undefined at boot; you need to clear them / set them
before enabling them (DR=1 or IR=1), so there is nothing special
about the high BATs.

What I am getting at is if the mfspr/mtspr to the high BATs does
work when the HID bit for them is off.

Please address the RMW thing (don't clear bits in HID4).

>>> +    /* enable caches */\n\
>>> +    mfspr    8, 0x3f0\n\
>>> +    ori    8, 8, 0xc000\n\
>>> +    mtspr    0x3f0, 8    /* HID0 */\n\
>>> +    isync\n\
>>
>> You need to invalidate the L1 caches at the same time as you enable
>> them.
>>
>
> Ok. I'll check if the caches are enabled. If they aren't I'll  
> invalidate and enable them.

Yeah, good point.

> If the "!" is ugly I can use the following idiom, introducing an  
> error variable.
>
>   error = ug_grab_io_base();
>   if (!error && ug_is_adapter_present())
>      /* blah */

Much clearer, thanks.


Segher

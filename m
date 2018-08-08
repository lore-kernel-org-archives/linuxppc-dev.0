Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltmJ38TfzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:18:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org, paulus@samba.org
Subject: Re: [PATCH] powerpc/64s: Make unrecoverable SLB miss less confusing
In-Reply-To: <20180801121111.308ff705@roar.ozlabs.ibm.com>
References: <20180726130151.16410-1-mpe@ellerman.id.au>
 <20180801121111.308ff705@roar.ozlabs.ibm.com>
Date: Thu, 09 Aug 2018 00:18:54 +1000
Message-ID: <87tvo59c1d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> On Thu, 26 Jul 2018 23:01:51 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> If we take an SLB miss while MSR[RI]=0 we can't recover and have to
>> oops. Currently this is reported by faking up a 0x4100 exception, eg:
>> 
>>   Unrecoverable exception 4100 at 0
>>   Oops: Unrecoverable exception, sig: 6 [#1]
>>   ...
>>   CPU: 0 PID: 1262 Comm: sh Not tainted 4.18.0-rc3-gcc-7.3.1-00098-g7fc2229fb2ab-dirty #9
>>   NIP:  0000000000000000 LR: c00000000000b9e4 CTR: 00007fff8bb971b0
>>   REGS: c0000000ee02bbb0 TRAP: 4100
>>   ...
>>   LR [c00000000000b9e4] system_call+0x5c/0x70
>> 
>> The 0x4100 value was chosen back in 2004 as part of the fix for the
>> "mega bug" - "ppc64: Fix SLB reload bug". Back then it was obvious
>> that 0x4100 was not a real trap value, as the highest actual trap was
>> less than 0x2000.
>> 
>> Since then however the architecture has changed and now we have
>> "virtual mode" or "relon" exceptions, in which exceptions can be
>> delivered with the MMU on starting at 0x4000.
>> 
>> At a glance 0x4100 looks like a virtual mode 0x100 exception, aka
>> system reset exception. A close reading of the architecture will show
>> that system reset exceptions can't be delivered in virtual mode, and
>> so 0x4100 is not a valid trap number. But that's not immediately
>> obvious. There's also nothing about 0x4100 that suggests SLB miss.
>> 
>> So to make things a bit less confusing switch to a fake but unique and
>> hopefully more helpful numbering. For data SLB misses we report a
>> 0x390 trap and for instruction we report 0x490. Compared to 0x380 and
>> 0x480 for the actual data & instruction SLB exceptions.
>> 
>> Also add a C handler that prints a more explicit message. The end
>> result is something like:
>> 
>>   Oops: Unrecoverable SLB miss (MSR[RI]=0), sig: 6 [#3]
>
> This is all good, but allow me to nitpick. Our unrecoverable
> exception messages (and other messages, but those) are becoming a bit
> ad-hoc and messy.
>
> It would be nice to go the other way eventually and consolidate them
> into one. Would be nice to have a common function that takes regs and
> returns the string of the corresponding exception name that makes
> these more readable.

Yeah that's true, though some of them aren't simply a mapping from the
trap number, eg. the kernel bad stack one.

But in general our whole oops output, regs, stack trace etc. could use a
revamp.

I've been thinking of making the trap number more prominent and
providing a text description, because apparently not everyone knows the
trap numbers by heart :)

>>   ...
>>   CPU: 0 PID: 1262 Comm: sh Not tainted 4.18.0-rc3-gcc-7.3.1-00098-g7fc2229fb2ab-dirty #9
>>   NIP:  0000000000000000 LR: c00000000000b9e4 CTR: 0000000000000000
>>   REGS: c0000000f19a3bb0 TRAP: 0490
>
> Unless I'm mistaken, the fake trap number was only because the code
> couldn't distinguish between 380 and 480. Now that you do, I think you
> can just use them directly rather than 390/490.

Hmm. I always thought it was there so that you could differentiate the
unrecoverable miss vs a normal miss using the trap number.

But maybe that's a bit superfluous given we're printing "unrecoverable
slb miss".

cheers

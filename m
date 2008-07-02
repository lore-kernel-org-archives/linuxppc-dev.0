Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E661CDDF64
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 01:57:24 +1000 (EST)
Message-Id: <46F3C08B-4F8E-42A2-BDE8-6849D33CA4A0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1214991248.7436.5.camel@localhost>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc: fixup lwsync at runtime
Date: Wed, 2 Jul 2008 10:57:11 -0500
References: <Pine.LNX.4.64.0807010031241.23830@blarg.am.freescale.net>
	<1214893753.8055.13.camel@localhost>
	<DBD7C7F7-1EBB-4D73-88A0-72D079E800DB@kernel.crashing.org>
	<1214991248.7436.5.camel@localhost>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 2, 2008, at 4:34 AM, Michael Ellerman wrote:

> On Tue, 2008-07-01 at 09:48 -0500, Kumar Gala wrote:
>> On Jul 1, 2008, at 1:29 AM, Michael Ellerman wrote:
>
>>>> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/
>>>> setup_32.c
>>>> index 9e83add..0109e7f 100644
>>>> --- a/arch/powerpc/kernel/setup_32.c
>>>> +++ b/arch/powerpc/kernel/setup_32.c
>>>> @@ -101,6 +101,10 @@ unsigned long __init early_init(unsigned long
>>>> dt_ptr)
>>>> 			  PTRRELOC(&__start___ftr_fixup),
>>>> 			  PTRRELOC(&__stop___ftr_fixup));
>>>>
>>>> +	do_lwsync_fixups(spec->cpu_features,
>>>> +			 PTRRELOC(&__start___lwsync_fixup),
>>>> +			 PTRRELOC(&__stop___lwsync_fixup));
>>>> +
>>>
>>> This could be changed to use cur_cpu_spec->cpu_features, and then  
>>> all
>>> the call sites would be passing that, which would mean
>>> do_lwsync_fixups() could just check cur_cpu_spec->cpu_features
>>> directly.
>>
>> cur_cpu_spec and spec at this point arent the same thing.
>
> Aren't they? I must be missing something:

There is an issue with how ppc32 classic gets here and relocation.  If  
I change the call to:

         do_lwsync_fixups(cur_cpu_spec->cpu_features,
                          PTRRELOC(&__start___lwsync_fixup),
                          PTRRELOC(&__stop___lwsync_fixup));

I can't boot on a 6xx based machine anymore.

- k

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9EA98DDE3E
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 02:35:34 +1100 (EST)
Message-Id: <2121AB2B-5677-4FDE-AFE7-40604C326B76@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0711211524370.12720@pademelon.sonytel.be>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
Date: Wed, 21 Nov 2007 09:34:36 -0600
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
	<20071120175416.GA4389@loki.buserror.net>
	<B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>
	<Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
	<7D40FA9E-A972-4995-85AE-3CE2551BB195@kernel.crashing.org>
	<Pine.LNX.4.62.0711211524370.12720@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 21, 2007, at 8:33 AM, Geert Uytterhoeven wrote:

> On Wed, 21 Nov 2007, Kumar Gala wrote:
>> On Nov 21, 2007, at 7:09 AM, Geert Uytterhoeven wrote:
>>> On Tue, 20 Nov 2007, Kumar Gala wrote:
>>>> On Nov 20, 2007, at 11:54 AM, Scott Wood wrote:
>>>>> On Mon, Nov 19, 2007 at 09:36:57PM -0600, Kumar Gala wrote:
>>>>>> isel (Integer Select) is a new user space instruction in the
>>>>>> PowerISA 2.04 spec.  Not all processors implement it so lets  
>>>>>> emulate
>>>>>> to ensure code built with isel will run everywhere.
>>>>>
>>>>> Given that the instruction is meant to be a performance  
>>>>> enhancement,
>>>>> we should probably warn the first few times it's emulated, so  
>>>>> the user
>>>>> knows they should change their toolchain setup if possible.
>>>>
>>>> The same is true of mcrxr, popcntb, and possibly string ld/st.
>>>>
>>>> Feel free to submit a patch that warns about their usage.
>>>
>>> Something like this?
>>>
>>> Probably we also want it for:
>>>
>>> - arch/powerpc/kernel/align.c
>>>     o emulate_dcbz()
>>>     o emulate_multiple()
>>>     o emulate_fp_pair()
>>>     o emulate_spe()
>>>
>>> - arch/powerpc/kernel/softemu8xx.c
>>>     o Soft_emulate_8xx()
>>>
>>> - arch/powerpc/kernel/traps.c
>>>     o SoftwareEmulation()
>>
>> You missed math_emu.
>>
>>>  - arch/powerpc/kernel/vecemu.c
>>>     o emulate_altivec()
>>
>> I'm not sure I would concern this one emulation, there isn't much  
>> you can do
>> about the denorm fixup.
>>
>> How about some per processor counters in sysfs under the processor.
>
> Good idea!
>
>>> Question: do we want it for emulate_single_step(), too?
>>
>> What do you mean, we should could the emulation, the emulate single  
>> step just
>> is for handling if you are doing debug while hitting an emulated  
>> insn.
>
> I mean: should these be counted?

the number of emulated single steps insn?  not sure I follow.  I think  
we should count regardless if we go through emulate_single_step().

- k

Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4EC8DDE3B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 01:37:49 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E816B9C@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816B9C@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=GB2312; delsp=yes; format=flowed
Message-Id: <2C8EB4AF-97B2-40F5-8112-0CEE6E3D4D42@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Mon, 15 Jan 2007 08:37:09 -0600
To: Zhu Ebony-r57400 <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 15, 2007, at 12:37 AM, Zhu Ebony-r57400 wrote:

>
>
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: 2007=C4=EA1=D4=C213=C8=D5 02:36
>> To: Zhu Ebony-r57400
>> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
>> Subject: Re: [patch][0/5] powerpc: Add support to fully
>> comply with IEEE-754 standard
>>
>>
>> On Jan 12, 2007, at 2:09 AM, Zhu Ebony-r57400 wrote:
>>
>>>  Hi Kumar,
>>>
>>>> -----Original Message-----
>>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>>>> Sent: 2007=C4=EA1=D4=C212=C8=D5 14:42
>>>> To: Zhu Ebony-r57400
>>>> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
>>>> Subject: Re: [patch][0/5] powerpc: Add support to fully
>> comply with
>>>> IEEE-754 standard
>>>>
>>>>
>>>> On Jan 11, 2007, at 11:19 PM, Zhu Ebony-r57400 wrote:
>>>>
>>>>> Hi Paul,
>>>>>
>>>>> This series of patch add support to fully comply with IEEE-754
>>>>> standard for E500/E500v2 core when hardware floating point
>>>> compiling
>>>>> is used.
>>>>>
>>>>> Ebony
>>>>
>>>> Here are some general comments:
>>>> * We should be able to support math-emu (as it stands) and
>> the fixup
>>>> handling [you break math-emu]
>>>
>>> I don't think I break the math-emu. I think the codes I
>> added have no
>>> impact to the existing math-emu.
>>
>> This snippet of code breaks it from math-emu/sfp-machine.h
>>
>>>> +#ifdef CONFIG_SPE
>>>> +#define __FPU_FPSCR	(current->thread.spefscr)
>>>> +#else
>>>>  #define __FPU_FPSCR	(current->thread.fpscr.val)
>>>> +#endif
>>
>> By doing this if I want 'classic FP' emulation as well as the
>> IEEE fixup my fpscr for classic emu will not be updated properly.
>
> Logically, user can choose "SPE Support" and "Math emulation" at the
> same time on menuconfig. But from my understanding, it is not =20
> necessary
> to select math-emu on a SPE available system, since SPE can do math =20=

> operation.

This is not true.  If I want to run a "classic" PPC binary with FP I =20
need "Math emulation" and if I want to run an SPE one I enable "SPE =20
Support".  I could want to run both of these types of binaries on the =20=

same system at the same time.

>>>> * Copyrights / header comments should give credit to the orig
>>>> math- emu code
>>> I'd like to do this, but in most handler codes, I can't find
>>> copyright information
>>> of the orig authors. I think the math-emu code comes from
>> glibc. In
>>> the
>>> sigfpe_handler.c, I gave credit to the orig author.
>>
>> I think a comment is sufficient stating this is take from the math-
>> emu code.
>>
>>>> * Why isn't there any handling of SPEFloatingPointRound exceptions?
>>>
>>> I think the SPEFloatingPointRound exception is not necessary to
>>> handle if we
>>> handle floating point exception this way.
>>
>> I dont believe this, you'll have to explain if this is really true.
>> But, I'm almost sure that if the RND mode is set to +/-inf and we do
>> an operation that is within the normal bounds that should round we
>> will NOT get one of the other exceptions.
>>
>> - k
>>
>>
>
> I looked into the manual again, and found what you are saying is =20
> correct. The reason
> for developing IEEE-754 fixup came from customer's complain, which =20
> is about denormalized
> computation can't generate the correct result as the same as on =20
> x86. So what I was
> concentrating on is floating-point data interrupt. The truth is, FP =20=

> round interrupt may
> be taken on some circumstance that FP data interrupt doesn't take =20
> place.
>
> As you said, if RND mode is set to +/- inf, FP round interrupt will =20=

> generate if we
> do an operation within the normal bounds. Do you think we use the =20
> same way to
> handle FP round interrupt as FP data interrupt is reasonable? How =20
> would you suggest?

No, I think the round handler should try to do the rounding by hand.  =20=

Since you have the non rounded information provided by HW, its much =20
simpler to just do the rounding step.

- k

>
> Thanks.
>
> Ebony
>
>
>
>

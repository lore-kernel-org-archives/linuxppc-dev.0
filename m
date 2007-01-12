Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0931EDDF95
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 05:37:11 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E816A58@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816A58@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=GB2312; delsp=yes; format=flowed
Message-Id: <567FCA2A-22B1-4644-98D3-2E7431423307@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Fri, 12 Jan 2007 12:36:19 -0600
To: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 12, 2007, at 2:09 AM, Zhu Ebony-r57400 wrote:

>  Hi Kumar,
>
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: 2007=C4=EA1=D4=C212=C8=D5 14:42
>> To: Zhu Ebony-r57400
>> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
>> Subject: Re: [patch][0/5] powerpc: Add support to fully
>> comply with IEEE-754 standard
>>
>>
>> On Jan 11, 2007, at 11:19 PM, Zhu Ebony-r57400 wrote:
>>
>>> Hi Paul,
>>>
>>> This series of patch add support to fully comply with IEEE-754
>>> standard for E500/E500v2 core when hardware floating point
>> compiling
>>> is used.
>>>
>>> Ebony
>>
>> Here are some general comments:
>> * We should be able to support math-emu (as it stands) and
>> the fixup handling [you break math-emu]
>
> I don't think I break the math-emu. I think the codes I added have
> no impact to the existing math-emu.

This snippet of code breaks it from math-emu/sfp-machine.h

>> +#ifdef CONFIG_SPE
>> +#define __FPU_FPSCR	(current->thread.spefscr)
>> +#else
>>  #define __FPU_FPSCR	(current->thread.fpscr.val)
>> +#endif

By doing this if I want 'classic FP' emulation as well as the IEEE =20
fixup my fpscr for classic emu will not be updated properly.

>
>> * Copyrights / header comments should give credit to the orig
>> math- emu code
> I'd like to do this, but in most handler codes, I can't find =20
> copyright information
> of the orig authors. I think the math-emu code comes from glibc. In =20=

> the
> sigfpe_handler.c, I gave credit to the orig author.

I think a comment is sufficient stating this is take from the math-=20
emu code.

>> * Why isn't there any handling of SPEFloatingPointRound exceptions?
>
> I think the SPEFloatingPointRound exception is not necessary to =20
> handle if we
> handle floating point exception this way.

I dont believe this, you'll have to explain if this is really true.  =20
But, I'm almost sure that if the RND mode is set to +/-inf and we do =20
an operation that is within the normal bounds that should round we =20
will NOT get one of the other exceptions.

- k

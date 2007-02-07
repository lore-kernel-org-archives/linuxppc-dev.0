Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE8AEDDDE9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 18:12:36 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E8B7CC3@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E8B7CC3@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F9E9609E-D705-4FE6-8494-FEF94C294622@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Wed, 7 Feb 2007 01:11:36 -0600
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


On Feb 6, 2007, at 11:52 PM, Zhu Ebony-r57400 wrote:

>>>> This snippet of code breaks it from math-emu/sfp-machine.h
>>>>
>>>>>> +#ifdef CONFIG_SPE
>>>>>> +#define __FPU_FPSCR	(current->thread.spefscr)
>>>>>> +#else
>>>>>>  #define __FPU_FPSCR	(current->thread.fpscr.val)
>>>>>> +#endif
>>>>
>>>> By doing this if I want 'classic FP' emulation as well as the IEEE
>>>> fixup my fpscr for classic emu will not be updated properly.
>>>
>>> Logically, user can choose "SPE Support" and "Math
>> emulation" at the
>>> same time on menuconfig. But from my understanding, it is not
>>> necessary to select math-emu on a SPE available system,
>> since SPE can
>>> do math operation.
>>
>> This is not true.  If I want to run a "classic" PPC binary
>> with FP I need "Math emulation" and if I want to run an SPE
>> one I enable "SPE Support".  I could want to run both of
>> these types of binaries on the same system at the same time.
>
> If this is the case, maybe we need a separate macro like
> #define __SPE_SPEFSCR	(current->thread.spefscr)
> But if we do this, how does the kernel know if the emulation is for
> "classic" PPC binary with FP or an SPE one, thus corresponding
> registers(fpscr or spefscr) being updated?

It's based on what instruction you are trying to emulate.

- k

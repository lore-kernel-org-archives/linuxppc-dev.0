Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97CEFDDE4A
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 17:50:02 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E816A18@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816A18@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=GBK; delsp=yes; format=flowed
Message-Id: <9F0F019E-930B-49B5-920A-EB4977BED803@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with
	IEEE-754standard
Date: Fri, 12 Jan 2007 00:49:16 -0600
To: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 12, 2007, at 12:38 AM, Zhu Ebony-r57400 wrote:

> Hi Paul,
>
> On SPE implemented E500/E500v2 core, the embedded floating-point
> APU implements a floating-point system as defined in ANSI/IEEE
> standard754-1985 but rely on software support in order to conform =20
> fully
> with the standard. Thus, whenever an input operand of a floating-point
> instruction has data values that are +infinity, =A8Cinfinity, denorm, =20=

> or NaN,
> or when the result of an operation produces an overflow or an =20
> underflow,
> an interrupt may be taken and the interrupt handler is responsible =20
> for delivering
> IEEE 754-compliant behavior if desired.

In addition to some other corner cases the HW punts on.

[snip]

> The approach I've taken to solve this issue is:
> 1. Enable SPEFSCR[FINVE|FDBZE|FUNFE|FOVFE] to make sure exceptions
> can take place
> 2. Use exceptions handlers to handle the exceptions.
> 3. Restore registers and exit from exception.
>
> In arch/powerpc/math, there are some files to emulate floating =20
> point instructions
> on non-FPU systems, which may come from glibc. Some macros are =20
> provided to
> emulate plus, minus, multiply, divide, etc. Therefore, I re-used =20
> some of the codes there
> and add some new routines to emulated SPE instruction that may =20
> cause exception,
> including SPFP instructions, DPFP instructions and Vector SPFP =20
> instructions.
>
> Writing some independent codes to handle the exceptions my be an =20
> alternative way,
> but I think re-use the existing interfaces in kernel is the best =20
> approach.

I don't believe there is any other way to solve this problem.  On =20
these particular exceptions, the HW doesn't provide any real assist =20
and we have to recompute the result from scratch.

Once, we agree the approach is reasonable I'll make comments on the =20
actual handlers.

- k

> Ebony
>
>
>
>> -----Original Message-----
>> From: Paul Mackerras [mailto:paulus@samba.org]
>> Sent: 2007=C4=EA1=D4=C212=C8=D5 13:30
>> To: Zhu Ebony-r57400
>> Cc: linuxppc-dev@ozlabs.org
>> Subject: Re: [patch][0/5] powerpc: Add support to fully
>> comply with IEEE-754standard
>>
>> Zhu Ebony-r57400 writes:
>>
>>> This series of patch add support to fully comply with IEEE-754
>>> standard for E500/E500v2 core when hardware floating point
>> compiling is used.
>>
>> Your patch descriptions need to explain in detail in what way
>> the current code doesn't comply with the IEEE-754 standard,
>> and what approach you have taken to make it comply.  If there
>> are alternative approaches, explain why the approach you have
>> taken is the best.
>>
>> Thanks,
>> Paul.
>>

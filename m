Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 5D39767A79
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 20:21:49 +1100 (EST)
In-Reply-To: <42231C26.7020508@jp.fujitsu.com>
References: <42231C26.7020508@jp.fujitsu.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <fb51aa4f2ef8274e05a26ed098918ffc@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 3 Mar 2005 01:14:51 -0600
To: "Takeharu KATO" <kato.takeharu@jp.fujitsu.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 3/3] PowerPC4xx/E500 WatchDogTimerDriver(exception
	handler part)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've sent the part of this that was a bug fix to head_booke.h up stream=20=

to andrew.

- kumar

On Feb 28, 2005, at 7:27 AM, Takeharu KATO wrote:

> Dear Matt and all:
>
> This is PowerPC405 exception handling part.
>  This patch consist of two parts.
>
> I create this just in case, if you think that this is not needed,
>  please ignore them.
>
> 1) WatchDogException vector routine for ppc4xx.
>  =A0=A0=A0 It cause Oops with MachineCheckException as other PPC4xx =
do.
>  2) Trivial bug fix in head_booke.h
> =A0=A0=A0 Trivial bug fix of CRITICAL_EXCEPTION macro.
>
> Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
>
>
>
> diff -uprN linux-2.6.11-rc5.orig/arch/ppc/kernel/head_4xx.S
>  linux-2.6.11-rc5-ppc4xx/arch/ppc/kernel/head_4xx.S
> --- linux-2.6.11-rc5.orig/arch/ppc/kernel/head_4xx.S=A0=A0=A0 =
2005-02-27=20
> 15:30:39.000000000 +0900
>  +++ linux-2.6.11-rc5-ppc4xx/arch/ppc/kernel/head_4xx.S=A0 2005-02-28=20=

> 21:47:42.531317912 +0900
>  @@ -484,11 +484,11 @@ label:
>  =A0 */
>  =A0 =A0=A0=A0=A0=A0 STND_EXCEPTION(0x1010,=A0 FITException,=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0=20
> UnknownException)
>
> +#endif
>  =A0 /* 0x1020 - Watchdog Timer (WDT) Exception
>  =A0 */
>
> =A0 =A0=A0=A0=A0=A0 CRITICAL_EXCEPTION(0x1020, WDTException, =
UnknownException)
> -#endif
>
> =A0 /* 0x1100 - Data TLB Miss Exception
>  =A0=A0 * As the name implies, translation is not in the MMU, so =
search the
>  diff -uprN linux-2.6.11-rc5.orig/arch/ppc/kernel/head_booke.h
>  linux-2.6.11-rc5-ppc4xx/arch/ppc/kernel/head_booke.h
> --- linux-2.6.11-rc5.orig/arch/ppc/kernel/head_booke.h=A0 2005-02-27=20=

> 15:27:12.000000000 +0900
>  +++ linux-2.6.11-rc5-ppc4xx/arch/ppc/kernel/head_booke.h=A0=A0=A0=A0=A0=
=A0=A0=20
> 2005-02-28 21:50:05.060650160 +0900
>  @@ -194,8 +194,8 @@ label:
>  =A0 =A0=A0=A0=A0=A0 CRITICAL_EXCEPTION_PROLOG;=A0=A0=A0=A0=A0 =A0=A0=A0=
=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 \
>  =A0 =A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r1,STACK_FRAME_OVERHEAD;=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 \
>  =A0 =A0=A0=A0=A0=A0 EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL &=20
> ~(MSR_ME|MSR_DE|MSR_CE)), \
>  -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 =
NOCOPY, transfer_to_handler_full, \
>  -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 =
ret_from_except_full)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 =
NOCOPY, crit_transfer_to_handler, \
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 =
ret_from_crit_exc)
>
> =A0 #define MCHECK_EXCEPTION(n, label, hdlr)=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 \
>  =A0 =A0=A0=A0=A0=A0 START_EXCEPTION(label); =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 \
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

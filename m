Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 39D6867A3E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 May 2005 01:37:59 +1000 (EST)
In-Reply-To: <427BDBCF.8030908@ybb.ne.jp>
References: <427BDBCF.8030908@ybb.ne.jp>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <b8b42fd26b024d5e26060a508600f631@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 12 May 2005 10:37:38 -0500
To: "Takeharu KATO" <takeharu1219@ybb.ne.jp>
Cc: Glenn Burkhardt <glenn@aoi-industries.com>,
	"Gala Kumar K.-galak" <galak@freescale.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] BOOKE_WDT Part 1/2 (Re: PPC 44x Watchdog timer)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> diff -Nupr linux-2.6.orig/arch/ppc/kernel/head_4xx.S
>  linux-2.6/arch/ppc/kernel/head_4xx.S
> --- linux-2.6.orig/arch/ppc/kernel/head_4xx.S=A0=A0 2005-05-06
> 05:03:55.000000000 +0900
>  +++ linux-2.6/arch/ppc/kernel/head_4xx.S=A0=A0=A0=A0=A0=A0=A0 =
2005-05-07=20
> 05:03:24.000000000 +0900
>  @@ -430,27 +430,24 @@ label:
>

Any reason you moved this code into DecrementerHandler?

> =A0 /* 0x1000 - Programmable Interval Timer (PIT) Exception */
>  =A0 =A0=A0=A0=A0=A0 START_EXCEPTION(0x1000, Decrementer)
>  -=A0=A0=A0=A0=A0=A0 NORMAL_EXCEPTION_PROLOG
> -=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r0,TSR_PIS@h
> -=A0=A0=A0=A0=A0=A0 mtspr=A0=A0 SPRN_TSR,r0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 /* Clear the PIT exception */
>  -=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r1,STACK_FRAME_OVERHEAD
> -=A0=A0=A0=A0=A0=A0 EXC_XFER_LITE(0x1000, timer_interrupt)
> +=A0=A0=A0=A0=A0=A0 b=A0=A0=A0 DecrementerHandler
>
> =A0 #if 0
>  =A0 /* NOTE:
>  - * FIT and WDT handlers are not implemented yet.
>  + * FIT handler is not implemented yet.
>  =A0=A0 */
>
> =A0 /* 0x1010 - Fixed Interval Timer (FIT) Exception
>  =A0 */
>  =A0 =A0=A0=A0=A0=A0 STND_EXCEPTION(0x1010,=A0 FITException,=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0=20
> UnknownException)
>
> -/* 0x1020 - Watchdog Timer (WDT) Exception
>  -*/
>  -
>  -=A0=A0=A0=A0=A0=A0 CRITICAL_EXCEPTION(0x1020, WDTException, =
UnknownException)
> =A0 #endif
>
> +/* 0x1020 - Watchdog Timer (WDT) Exception
>  + */
>  +=A0=A0=A0=A0=A0=A0 START_EXCEPTION(0x1020, WDTException)
> +=A0=A0=A0=A0=A0=A0 b=A0=A0=A0 WatchDogHandler
> +
>  =A0 /* 0x1100 - Data TLB Miss Exception
>  =A0=A0 * As the name implies, translation is not in the MMU, so =
search the
>  =A0=A0 * page tables and fix it.=A0 The only purpose of this function =
is to
>  @@ -732,6 +729,13 @@ label:
>  =A0 =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 (MSR_KERNEL & =
~(MSR_ME|MSR_DE|MSR_CE)), \
>  =A0 =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 NOCOPY, =
crit_transfer_to_handler, ret_from_crit_exc)
>
> +DecrementerHandler:
> +=A0=A0=A0=A0=A0=A0 NORMAL_EXCEPTION_PROLOG
> +=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0 r0,TSR_PIS@h
> +=A0=A0=A0=A0=A0=A0 mtspr=A0=A0=A0 SPRN_TSR,r0=A0=A0=A0=A0=A0=A0=A0 /* =
Clear the PIT exception */
>  +=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r1,STACK_FRAME_OVERHEAD
> +=A0=A0=A0=A0=A0=A0 EXC_XFER_LITE(0x1000, timer_interrupt)
> +
>  =A0 /*
>  =A0=A0 * The other Data TLB exceptions bail out to this point
>  =A0=A0 * if they can't resolve the lightweight TLB fault.
>  @@ -804,6 +808,19 @@ finish_tlb_load:
> =A0 =A0=A0=A0=A0=A0 PPC405_ERR77_SYNC
> =A0 =A0=A0=A0=A0=A0 rfi=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 /* Should sync shadow TLBs */
>  =A0 =A0=A0=A0=A0=A0 b=A0=A0=A0=A0=A0=A0 .=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 /* prevent prefetch past rfi */
>  +/*
>  + * WatchDog Exception
>  + */
>  +WatchDogHandler:
> +=A0=A0=A0=A0=A0=A0 CRITICAL_EXCEPTION_PROLOG;
> +=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r1,STACK_FRAME_OVERHEAD;
> +#if defined(CONFIG_BOOKE_WDT)
> +=A0=A0=A0=A0=A0=A0 EXC_XFER_TEMPLATE(booke_wdt_exception, 0x1022, =
(MSR_KERNEL &
> ~(MSR_ME|MSR_DE|MSR_CE)),NOCOPY, crit_transfer_to_handler,
>  ret_from_crit_exc)
> +
>  +#else
>  +=A0=A0=A0=A0=A0=A0 EXC_XFER_TEMPLATE(UnknownException, 0x1022, =
(MSR_KERNEL &
> ~(MSR_ME|MSR_DE|MSR_CE)),NOCOPY, crit_transfer_to_handler,
>  ret_from_crit_exc)
> +#endif=A0 /*=A0 CONFIG_BOOKE_WDT=A0 */
>  +
>
> =A0 /* extern void giveup_fpu(struct task_struct *prev)
>  =A0=A0 *

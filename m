Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9D5EA67A6F
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2005 20:04:44 +1000 (EST)
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0D23@rennsmail02.eu.thmulti.com>
References: <1CFEB358338412458B21FAA0D78FE86D4F0D23@rennsmail02.eu.thmulti.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <3564f98e15f831085f459002d1607acf@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 1 Apr 2005 04:04:40 -0600
To: "Fillod Stephane" <stephane.fillod@thomson.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What is the crash01 test doing that causes this code to get invoked? =20
is the kernel you are using using build with math emulation on or off?

- kumar

On Mar 31, 2005, at 11:47 AM, Fillod Stephane wrote:

> Hi,
>
> When CPU has no (classic) FPU, and math emulation is disabled,
>  fp instructions are not allowed in kernel mode.
>  This bug has been found with crashme (crash01) of LTP, on a e500=20
> system.
>
> The patch was made against linux 2.6.11.6.
>  A trivial typo fix has been appended.
>
> Rem: a CONFIG_PPCFPU define could make life easier.
>
>
>
> Signed-off-by: Stephane Fillod <fillods@gmail.com>
>
> --- linux/arch/ppc/kernel/align.c=A0=A0=A0=A0=A0=A0 6 Dec 2004 =
16:18:11 -0000
>  1.1.1.1
>  +++ linux/arch/ppc/kernel/align.c=A0=A0=A0=A0=A0=A0 31 Mar 2005 =
16:33:25 -0000
>  @@ -333,10 +333,14 @@
>  =A0=A0=A0=A0=A0=A0=A0 }
>  =A0
>  =A0=A0=A0=A0=A0=A0=A0 if (flags & F) {
>  +#if !(defined(CONFIG_4xx) || defined(CONFIG_8xx) ||
>  defined(CONFIG_E500)) || defined(CONFIG_MATH_EMULATION)
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 preempt_disable();
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (regs->msr & MSR_FP)
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
giveup_fpu(current);
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 preempt_enable();
> +#else
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return 0;
>  +#endif
>  =A0=A0=A0=A0=A0=A0=A0 }
>  =A0
>  =A0=A0=A0=A0=A0=A0=A0 /* If we read the operand, copy it in, else get =
register=20
> values
> */
>  @@ -366,6 +370,8 @@
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 break;
>  =A0
>  +#if !(defined(CONFIG_4xx) || defined(CONFIG_8xx) ||
>  defined(CONFIG_E500)) || defined(CONFIG_MATH_EMULATION)
> +
>  =A0=A0=A0=A0=A0=A0=A0 /* Single-precision FP load and store require =
conversions...=20
> */
>  =A0=A0=A0=A0=A0=A0=A0 case LD+F+S:
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 preempt_disable();
> @@ -379,6 +385,7 @@
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 cvt_df(&data.d, &data.f, =
&current->thread.fpscr);
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 preempt_enable();
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 break;
>  +#endif
>  =A0=A0=A0=A0=A0=A0=A0 }
>  =A0
>  =A0=A0=A0=A0=A0=A0=A0 if (flags & ST) {
>  --- linux/arch/ppc/kernel/misc.S=A0=A0=A0=A0=A0=A0=A0 26 Mar 2005 =
03:28:36 -0000
>  1.1.1.2
>  +++ linux/arch/ppc/kernel/misc.S=A0=A0=A0=A0=A0=A0=A0 31 Mar 2005 =
16:33:25 -0000
>  @@ -1096,7 +1096,8 @@
>  =A0 * and exceptions as if the cpu had performed the load or store.
>  =A0 */
>  =A0
>  -#if defined(CONFIG_4xx) || defined(CONFIG_E500)
> +#if !(defined(CONFIG_4xx) || defined(CONFIG_E500) ||
>  defined(CONFIG_8xx)) ||=A0 defined(CONFIG_MATH_EMULATION)
> +#if defined(CONFIG_4xx) || defined(CONFIG_E500)
> =A0_GLOBAL(cvt_fd)
> =A0=A0=A0=A0=A0=A0=A0 lfs=A0=A0=A0=A0 0,0(r3)
>  =A0=A0=A0=A0=A0=A0=A0 stfd=A0=A0=A0 0,0(r4)
>  @@ -1125,6 +1126,7 @@
>  =A0=A0=A0=A0=A0=A0=A0 stfd=A0=A0=A0 0,-4(r5)
>  =A0=A0=A0=A0=A0=A0=A0 blr
>  =A0#endif
>  +#endif
>  =A0
>  =A0/*
>  =A0 * Create a kernel thread
>  --- linux/arch/ppc/kernel/process.c=A0=A0=A0=A0 26 Mar 2005 03:28:20 =
-0000
>  1.1.1.2
>  +++ linux/arch/ppc/kernel/process.c=A0=A0=A0=A0 31 Mar 2005 16:33:25 =
-0000
>  @@ -342,7 +342,7 @@
>  =A0=A0=A0=A0=A0=A0=A0 printk("\n");
>  =A0#ifdef CONFIG_KALLSYMS
> =A0=A0=A0=A0=A0=A0=A0 /*
>  -=A0=A0=A0=A0=A0=A0=A0 * Lookup NIP late so we have the best change =
of getting the
>  +=A0=A0=A0=A0=A0=A0=A0 * Lookup NIP late so we have the best chance =
of getting the
>  =A0=A0=A0=A0=A0=A0=A0=A0 * above info out without failing
>  =A0=A0=A0=A0=A0=A0=A0=A0 */
>  =A0=A0=A0=A0=A0=A0=A0 printk("NIP [%08lx] ", regs->nip);
>
>
>
> Best Regards,
>
> --=20
> Stephane

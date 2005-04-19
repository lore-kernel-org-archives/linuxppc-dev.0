Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4235167A64
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2005 00:49:39 +1000 (EST)
In-Reply-To: <Pine.LNX.4.61.0504120957180.12787@blarg.somerset.sps.mot.com>
References: <Pine.LNX.4.61.0504120957180.12787@blarg.somerset.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <fd32aa7b6cff252fcc11bd3e37c8c6c5@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 19 Apr 2005 09:49:30 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Jason McMullan <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] ppc32: refactor FPU exception handling
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

What is the state of this patch?

- kumar

On Apr 12, 2005, at 9:59 AM, Kumar Gala wrote:

> Here is an updated version of the patch which moves the fast exception
> return code into entry.S.=A0 Not sure if I see any reason we can't =
have=20
> akpm
> merge this into -mm so people test it there.
>
>
>
> Moved common FPU exception handling code out of head.S so it can be=20
> used
> by several of the sub-architectures that might of a full PowerPC FPU.=A0=

>
>  Also, uses new CONFIG_PPC_FPU define to fix alignment exception
> handling for floating point load/store instructions to only occur if =
we
> have a hardware FPU.
>
> Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
>
> ---
>
> diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
> --- a/arch/ppc/Kconfig=A0 2005-04-12 09:54:36 -05:00
>  +++ b/arch/ppc/Kconfig=A0 2005-04-12 09:54:36 -05:00
>  @@ -53,6 +53,7 @@
>  =A0
>  =A0config 6xx
>  =A0=A0=A0=A0=A0=A0=A0 bool "6xx/7xx/74xx/52xx/82xx/83xx"
> +=A0=A0=A0=A0=A0=A0 select PPC_FPU
>  =A0=A0=A0=A0=A0=A0=A0 help
>  =A0=A0=A0=A0=A0=A0=A0 =A0 There are four types of PowerPC chips =
supported.=A0 The more=20
> common
>  =A0=A0=A0=A0=A0=A0=A0 =A0 types (601, 603, 604, 740, 750, 7400), the =
Motorola embedded
>  @@ -85,6 +86,9 @@
>  =A0=A0=A0=A0=A0=A0=A0 bool "e500"
>  =A0
>  =A0endchoice
>  +
>  +config PPC_FPU
>  +=A0=A0=A0=A0=A0=A0 bool
>  =A0
>  =A0config BOOKE
>  =A0=A0=A0=A0=A0=A0=A0 bool
>  diff -Nru a/arch/ppc/Makefile b/arch/ppc/Makefile
> --- a/arch/ppc/Makefile 2005-04-12 09:54:36 -05:00
>  +++ b/arch/ppc/Makefile 2005-04-12 09:54:36 -05:00
>  @@ -53,6 +53,7 @@
>  =A0
>  =A0head-$(CONFIG_6xx)=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 +=3D =
arch/ppc/kernel/idle_6xx.o
> =A0head-$(CONFIG_POWER4)=A0 =A0=A0=A0=A0=A0=A0=A0 +=3D =
arch/ppc/kernel/idle_power4.o
> +head-$(CONFIG_PPC_FPU) =A0=A0=A0=A0=A0=A0=A0 +=3D =
arch/ppc/kernel/fpu.o
> =A0
>  =A0core-y =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 +=3D arch/ppc/kernel/=20
> arch/ppc/platforms/ \
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0 arch/ppc/mm/ arch/ppc/lib/=20
> arch/ppc/syslib/
> diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
> --- a/arch/ppc/kernel/Makefile=A0 2005-04-12 09:54:36 -05:00
>  +++ b/arch/ppc/kernel/Makefile=A0 2005-04-12 09:54:36 -05:00
>  @@ -9,6 +9,7 @@
>  =A0extra-$(CONFIG_8xx)=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 :=3D head_8xx.o
>  =A0extra-$(CONFIG_6xx)=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 +=3D idle_6xx.o
>  =A0extra-$(CONFIG_POWER4) =A0=A0=A0=A0=A0=A0=A0 +=3D idle_power4.o
>  +extra-$(CONFIG_PPC_FPU)=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
+=3D fpu.o
>  =A0extra-y=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0 +=3D vmlinux.lds
>  =A0
>  =A0obj-y=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 :=3D entry.o traps.o irq.o idle.o=20
> time.o misc.o \
>  diff -Nru a/arch/ppc/kernel/align.c b/arch/ppc/kernel/align.c
> --- a/arch/ppc/kernel/align.c=A0=A0 2005-04-12 09:54:36 -05:00
>  +++ b/arch/ppc/kernel/align.c=A0=A0 2005-04-12 09:54:36 -05:00
>  @@ -368,16 +368,24 @@
>  =A0
>  =A0=A0=A0=A0=A0=A0=A0 /* Single-precision FP load and store require =
conversions...=20
> */
>  =A0=A0=A0=A0=A0=A0=A0 case LD+F+S:
>  +#ifdef CONFIG_PPC_FPU
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 preempt_disable();
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 enable_kernel_fp();
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 cvt_fd(&data.f, &data.d, =
&current->thread.fpscr);
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 preempt_enable();
> +#else
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return 0;
>  +#endif
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 break;
>  =A0=A0=A0=A0=A0=A0=A0 case ST+F+S:
>  +#ifdef CONFIG_PPC_FPU
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 preempt_disable();
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 enable_kernel_fp();
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 cvt_df(&data.d, &data.f, =
&current->thread.fpscr);
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 preempt_enable();
> +#else
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return 0;
>  +#endif
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 break;
>  =A0=A0=A0=A0=A0=A0=A0 }
>  =A0
>  diff -Nru a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
> --- a/arch/ppc/kernel/entry.S=A0=A0 2005-04-12 09:54:36 -05:00
>  +++ b/arch/ppc/kernel/entry.S=A0=A0 2005-04-12 09:54:36 -05:00
>  @@ -563,6 +563,65 @@
>  =A0=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r1,r1,INT_FRAME_SIZE
> =A0=A0=A0=A0=A0=A0=A0 blr
>  =A0
>  +=A0=A0=A0=A0=A0=A0 .globl=A0 fast_exception_return
> +fast_exception_return:
> +#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> +=A0=A0=A0=A0=A0=A0 andi.=A0=A0 r10,r9,MSR_RI=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 /* check for recoverable=20
> interrupt */
>  +=A0=A0=A0=A0=A0=A0 beq=A0=A0=A0=A0 1f=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0 /* if not, we've got problems=20
> */
>  +#endif
>  +
>  +2:=A0=A0=A0=A0 REST_4GPRS(3, r11)
>  +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r10,_CCR(r11)
>  +=A0=A0=A0=A0=A0=A0 REST_GPR(1, r11)
>  +=A0=A0=A0=A0=A0=A0 mtcr=A0=A0=A0 r10
>  +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r10,_LINK(r11)
> +=A0=A0=A0=A0=A0=A0 mtlr=A0=A0=A0 r10
> +=A0=A0=A0=A0=A0=A0 REST_GPR(10, r11)
>  +=A0=A0=A0=A0=A0=A0 mtspr=A0=A0 SPRN_SRR1,r9
> +=A0=A0=A0=A0=A0=A0 mtspr=A0=A0 SPRN_SRR0,r12
> +=A0=A0=A0=A0=A0=A0 REST_GPR(9, r11)
>  +=A0=A0=A0=A0=A0=A0 REST_GPR(12, r11)
>  +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r11,GPR11(r11)
> +=A0=A0=A0=A0=A0=A0 SYNC
>  +=A0=A0=A0=A0=A0=A0 RFI
>  +
>  +#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> +/* check if the exception happened in a restartable section */
>  +1:=A0=A0=A0=A0 lis=A0=A0=A0=A0 r3,exc_exit_restart_end@ha
> +=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r3,exc_exit_restart_end@l
> +=A0=A0=A0=A0=A0=A0 cmplw=A0=A0 r12,r3
>  +=A0=A0=A0=A0=A0=A0 bge=A0=A0=A0=A0 3f
> +=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r4,exc_exit_restart@ha
> +=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r4,r4,exc_exit_restart@l
> +=A0=A0=A0=A0=A0=A0 cmplw=A0=A0 r12,r4
>  +=A0=A0=A0=A0=A0=A0 blt=A0=A0=A0=A0 3f
>  +=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r3,fee_restarts@ha
> +=A0=A0=A0=A0=A0=A0 tophys(r3,r3)
>  +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r5,fee_restarts@l(r3)
> +=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r5,r5,1
>  +=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r5,fee_restarts@l(r3)
> +=A0=A0=A0=A0=A0=A0 mr=A0=A0=A0=A0=A0 r12,r4=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* restart at exc_exit_restart */
>  +=A0=A0=A0=A0=A0=A0 b=A0=A0=A0=A0=A0=A0 2b
>  +
>  +=A0=A0=A0=A0=A0=A0 .comm=A0=A0 fee_restarts,4
>  +
>  +/* aargh, a nonrecoverable interrupt, panic */
>  +/* aargh, we don't know which trap this is */
>  +/* but the 601 doesn't implement the RI bit, so assume it's OK */
>  +3:
>  +BEGIN_FTR_SECTION
> +=A0=A0=A0=A0=A0=A0 b=A0=A0=A0=A0=A0=A0 2b
>  +END_FTR_SECTION_IFSET(CPU_FTR_601)
> +=A0=A0=A0=A0=A0=A0 li=A0=A0=A0=A0=A0 r10,-1
>  +=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r10,TRAP(r11)
>  +=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r1,STACK_FRAME_OVERHEAD
> +=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r10,MSR_KERNEL@h
> +=A0=A0=A0=A0=A0=A0 ori=A0=A0=A0=A0 r10,r10,MSR_KERNEL@l
> +=A0=A0=A0=A0=A0=A0 bl=A0=A0=A0=A0=A0 transfer_to_handler_full
> +=A0=A0=A0=A0=A0=A0 .long=A0=A0 nonrecoverable_exception
> +=A0=A0=A0=A0=A0=A0 .long=A0=A0 ret_from_except
> +#endif
>  +
>  =A0=A0=A0=A0=A0=A0=A0 .globl=A0 sigreturn_exit
>  =A0sigreturn_exit:
> =A0=A0=A0=A0=A0=A0=A0 subi=A0=A0=A0 r1,r3,STACK_FRAME_OVERHEAD
> diff -Nru a/arch/ppc/kernel/fpu.S b/arch/ppc/kernel/fpu.S
> --- /dev/null=A0=A0 Wed Dec 31 16:00:00 196900
>  +++ b/arch/ppc/kernel/fpu.S=A0=A0=A0=A0 2005-04-12 09:54:36 -05:00
>  @@ -0,0 +1,133 @@
>  +/*
>  + *=A0 FPU support code, moved here from head.S so that it can be =
used
>  + *=A0 by chips which use other head-whatever.S files.
>  + *
>  + *=A0 This program is free software; you can redistribute it and/or
>  + *=A0 modify it under the terms of the GNU General Public License
> + *=A0 as published by the Free Software Foundation; either version
>  + *=A0 2 of the License, or (at your option) any later version.
>  + *
>  + */
>  +
>  +#include <linux/config.h>
> +#include <asm/processor.h>
> +#include <asm/page.h>
> +#include <asm/mmu.h>
>  +#include <asm/pgtable.h>
> +#include <asm/cputable.h>
> +#include <asm/cache.h>
> +#include <asm/thread_info.h>
> +#include <asm/ppc_asm.h>
> +#include <asm/offsets.h>
> +
>  +/*
>  + * This task wants to use the FPU now.
>  + * On UP, disable FP for the task which had the FPU previously,
>  + * and save its floating-point registers in its thread_struct.
>  + * Load up this task's FP registers from its thread_struct,
>  + * enable the FPU for the current task and return to the task.
>  + */
>  +=A0=A0=A0=A0=A0=A0 .globl=A0 load_up_fpu
>  +load_up_fpu:
> +=A0=A0=A0=A0=A0=A0 mfmsr=A0=A0 r5
>  +=A0=A0=A0=A0=A0=A0 ori=A0=A0=A0=A0 r5,r5,MSR_FP
>  +#ifdef CONFIG_PPC64BRIDGE
> +=A0=A0=A0=A0=A0=A0 clrldi=A0 r5,r5,1 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 /* turn off 64-bit mode */
>  +#endif /* CONFIG_PPC64BRIDGE */
>  +=A0=A0=A0=A0=A0=A0 SYNC
>  +=A0=A0=A0=A0=A0=A0 MTMSRD(r5)=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 /* enable use of fpu now */
>  +=A0=A0=A0=A0=A0=A0 isync
>  +/*
>  + * For SMP, we don't do lazy FPU switching because it just gets too
>  + * horrendously complex, especially when a task switches from one =
CPU
>  + * to another.=A0 Instead we call giveup_fpu in switch_to.
>  + */
>  +#ifndef CONFIG_SMP
> +=A0=A0=A0=A0=A0=A0 tophys(r6,0)=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 /* get __pa constant */
>  +=A0=A0=A0=A0=A0=A0 addis=A0=A0 r3,r6,last_task_used_math@ha
> +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r4,last_task_used_math@l(r3)
> +=A0=A0=A0=A0=A0=A0 cmpwi=A0=A0 0,r4,0
>  +=A0=A0=A0=A0=A0=A0 beq=A0=A0=A0=A0 1f
> +=A0=A0=A0=A0=A0=A0 add=A0=A0=A0=A0 r4,r4,r6
>  +=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r4,r4,THREAD=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 /* want=20
> last_task_used_math->thread */
>  +=A0=A0=A0=A0=A0=A0 SAVE_32FPRS(0, r4)
>  +=A0=A0=A0=A0=A0=A0 mffs=A0=A0=A0 fr0
> +=A0=A0=A0=A0=A0=A0 stfd=A0=A0=A0 fr0,THREAD_FPSCR-4(r4)
>  +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r5,PT_REGS(r4)
> +=A0=A0=A0=A0=A0=A0 add=A0=A0=A0=A0 r5,r5,r6
>  +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> +=A0=A0=A0=A0=A0=A0 li=A0=A0=A0=A0=A0 r10,MSR_FP|MSR_FE0|MSR_FE1
> +=A0=A0=A0=A0=A0=A0 andc=A0=A0=A0 r4,r4,r10=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 /* disable FP for previous=20
> task */
>  +=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> +1:
>  +#endif /* CONFIG_SMP */
>  +=A0=A0=A0=A0=A0=A0 /* enable use of FP after return */
>  +=A0=A0=A0=A0=A0=A0 mfspr=A0=A0 r5,SPRN_SPRG3=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 /* current task's THREAD=20
> (phys) */
>  +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r4,THREAD_FPEXC_MODE(r5)
> +=A0=A0=A0=A0=A0=A0 ori=A0=A0=A0=A0 r9,r9,MSR_FP=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 /* enable FP for current */
>  +=A0=A0=A0=A0=A0=A0 or=A0=A0=A0=A0=A0 r9,r9,r4
>  +=A0=A0=A0=A0=A0=A0 lfd=A0=A0=A0=A0 fr0,THREAD_FPSCR-4(r5)
>  +=A0=A0=A0=A0=A0=A0 mtfsf=A0=A0 0xff,fr0
>  +=A0=A0=A0=A0=A0=A0 REST_32FPRS(0, r5)
>  +#ifndef CONFIG_SMP
> +=A0=A0=A0=A0=A0=A0 subi=A0=A0=A0 r4,r5,THREAD
>  +=A0=A0=A0=A0=A0=A0 sub=A0=A0=A0=A0 r4,r4,r6
>  +=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r4,last_task_used_math@l(r3)
> +#endif /* CONFIG_SMP */
>  +=A0=A0=A0=A0=A0=A0 /* restore registers and return */
>  +=A0=A0=A0=A0=A0=A0 /* we haven't used ctr or xer or lr */
> +=A0=A0=A0=A0=A0=A0 b=A0=A0=A0=A0=A0=A0 fast_exception_return
> +
>  +/*
>  + * FP unavailable trap from kernel - print a message, but let
>  + * the task use FP in the kernel until it returns to user mode.
>  + */
>  + =A0=A0=A0=A0=A0 .globl=A0 KernelFP
>  +KernelFP:
>  +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r3,_MSR(r1)
>  +=A0=A0=A0=A0=A0=A0 ori=A0=A0=A0=A0 r3,r3,MSR_FP
>  +=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r3,_MSR(r1)=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 /* enable use of FP after=20
> return */
>  +=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r3,86f@h
>  +=A0=A0=A0=A0=A0=A0 ori=A0=A0=A0=A0 r3,r3,86f@l
>  +=A0=A0=A0=A0=A0=A0 mr=A0=A0=A0=A0=A0 r4,r2=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 /* current */
>  +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r5,_NIP(r1)
>  +=A0=A0=A0=A0=A0=A0 bl=A0=A0=A0=A0=A0 printk
>  +=A0=A0=A0=A0=A0=A0 b=A0=A0=A0=A0=A0=A0 ret_from_except
> +86:=A0=A0=A0 .string "floating point used in kernel (task=3D%p, =
pc=3D%x)\n"
>  +=A0=A0=A0=A0=A0=A0 .align=A0 4,0
>  +
>  +/*
>  + * giveup_fpu(tsk)
> + * Disable FP for the task given as the argument,
>  + * and save the floating-point registers in its thread_struct.
>  + * Enables the FPU for use in the kernel on return.
>  + */
>  +=A0=A0=A0=A0=A0=A0 .globl=A0 giveup_fpu
>  +giveup_fpu:
>  +=A0=A0=A0=A0=A0=A0 mfmsr=A0=A0 r5
>  +=A0=A0=A0=A0=A0=A0 ori=A0=A0=A0=A0 r5,r5,MSR_FP
>  +=A0=A0=A0=A0=A0=A0 SYNC_601
>  +=A0=A0=A0=A0=A0=A0 ISYNC_601
>  +=A0=A0=A0=A0=A0=A0 MTMSRD(r5)=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 /* enable use of fpu now */
>  +=A0=A0=A0=A0=A0=A0 SYNC_601
>  +=A0=A0=A0=A0=A0=A0 isync
>  +=A0=A0=A0=A0=A0=A0 cmpwi=A0=A0 0,r3,0
>  +=A0=A0=A0=A0=A0=A0 beqlr-=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 /* if no previous owner, done=20
> */
> +=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r3,THREAD=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 /* want THREAD of task */
>  +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r5,PT_REGS(r3)
> +=A0=A0=A0=A0=A0=A0 cmpwi=A0=A0 0,r5,0
>  +=A0=A0=A0=A0=A0=A0 SAVE_32FPRS(0, r3)
>  +=A0=A0=A0=A0=A0=A0 mffs=A0=A0=A0 fr0
> +=A0=A0=A0=A0=A0=A0 stfd=A0=A0=A0 fr0,THREAD_FPSCR-4(r3)
>  +=A0=A0=A0=A0=A0=A0 beq=A0=A0=A0=A0 1f
> +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> +=A0=A0=A0=A0=A0=A0 li=A0=A0=A0=A0=A0 r3,MSR_FP|MSR_FE0|MSR_FE1
> +=A0=A0=A0=A0=A0=A0 andc=A0=A0=A0 r4,r4,r3=A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 /* disable FP for previous=20
> task */
>  +=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> +1:
>  +#ifndef CONFIG_SMP
> +=A0=A0=A0=A0=A0=A0 li=A0=A0=A0=A0=A0 r5,0
> +=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r4,last_task_used_math@ha
> +=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r5,last_task_used_math@l(r4)
> +#endif /* CONFIG_SMP */
>  +=A0=A0=A0=A0=A0=A0 blr
>  diff -Nru a/arch/ppc/kernel/head.S b/arch/ppc/kernel/head.S
> --- a/arch/ppc/kernel/head.S=A0=A0=A0 2005-04-12 09:54:36 -05:00
>  +++ b/arch/ppc/kernel/head.S=A0=A0=A0 2005-04-12 09:54:36 -05:00
>  @@ -775,133 +775,6 @@
>  =A0=A0=A0=A0=A0=A0=A0 EXC_XFER_STD(0x480, UnknownException)
> =A0#endif /* CONFIG_PPC64BRIDGE */
>  =A0
>  -/*
>  - * This task wants to use the FPU now.
>  - * On UP, disable FP for the task which had the FPU previously,
>  - * and save its floating-point registers in its thread_struct.
>  - * Load up this task's FP registers from its thread_struct,
>  - * enable the FPU for the current task and return to the task.
>  - */
>  -load_up_fpu:
>  -=A0=A0=A0=A0=A0=A0 mfmsr=A0=A0 r5
> -=A0=A0=A0=A0=A0=A0 ori=A0=A0=A0=A0 r5,r5,MSR_FP
>  -#ifdef CONFIG_PPC64BRIDGE
> -=A0=A0=A0=A0=A0=A0 clrldi=A0 r5,r5,1 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 /* turn off 64-bit mode */
>  -#endif /* CONFIG_PPC64BRIDGE */
>  -=A0=A0=A0=A0=A0=A0 SYNC
>  -=A0=A0=A0=A0=A0=A0 MTMSRD(r5)=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 /* enable use of fpu now */
>  -=A0=A0=A0=A0=A0=A0 isync
>  -/*
>  - * For SMP, we don't do lazy FPU switching because it just gets too
>  - * horrendously complex, especially when a task switches from one =
CPU
>  - * to another.=A0 Instead we call giveup_fpu in switch_to.
>  - */
>  -#ifndef CONFIG_SMP
> -=A0=A0=A0=A0=A0=A0 tophys(r6,0)=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 /* get __pa constant */
>  -=A0=A0=A0=A0=A0=A0 addis=A0=A0 r3,r6,last_task_used_math@ha
> -=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r4,last_task_used_math@l(r3)
> -=A0=A0=A0=A0=A0=A0 cmpwi=A0=A0 0,r4,0
>  -=A0=A0=A0=A0=A0=A0 beq=A0=A0=A0=A0 1f
>  -=A0=A0=A0=A0=A0=A0 add=A0=A0=A0=A0 r4,r4,r6
>  -=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r4,r4,THREAD=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 /* want=20
> last_task_used_math->thread */
>  -=A0=A0=A0=A0=A0=A0 SAVE_32FPRS(0, r4)
>  -=A0=A0=A0=A0=A0=A0 mffs=A0=A0=A0 fr0
> -=A0=A0=A0=A0=A0=A0 stfd=A0=A0=A0 fr0,THREAD_FPSCR-4(r4)
>  -=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r5,PT_REGS(r4)
> -=A0=A0=A0=A0=A0=A0 add=A0=A0=A0=A0 r5,r5,r6
>  -=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> -=A0=A0=A0=A0=A0=A0 li=A0=A0=A0=A0=A0 r10,MSR_FP|MSR_FE0|MSR_FE1
> -=A0=A0=A0=A0=A0=A0 andc=A0=A0=A0 r4,r4,r10=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 /* disable FP for previous=20
> task */
>  -=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> -1:
>  -#endif /* CONFIG_SMP */
>  -=A0=A0=A0=A0=A0=A0 /* enable use of FP after return */
>  -=A0=A0=A0=A0=A0=A0 mfspr=A0=A0 r5,SPRN_SPRG3=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 /* current task's THREAD=20
> (phys) */
>  -=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r4,THREAD_FPEXC_MODE(r5)
> -=A0=A0=A0=A0=A0=A0 ori=A0=A0=A0=A0 r9,r9,MSR_FP=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 /* enable FP for current */
>  -=A0=A0=A0=A0=A0=A0 or=A0=A0=A0=A0=A0 r9,r9,r4
>  -=A0=A0=A0=A0=A0=A0 lfd=A0=A0=A0=A0 fr0,THREAD_FPSCR-4(r5)
>  -=A0=A0=A0=A0=A0=A0 mtfsf=A0=A0 0xff,fr0
>  -=A0=A0=A0=A0=A0=A0 REST_32FPRS(0, r5)
>  -#ifndef CONFIG_SMP
> -=A0=A0=A0=A0=A0=A0 subi=A0=A0=A0 r4,r5,THREAD
>  -=A0=A0=A0=A0=A0=A0 sub=A0=A0=A0=A0 r4,r4,r6
>  -=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r4,last_task_used_math@l(r3)
> -#endif /* CONFIG_SMP */
>  -=A0=A0=A0=A0=A0=A0 /* restore registers and return */
>  -=A0=A0=A0=A0=A0=A0 /* we haven't used ctr or xer or lr */
> -=A0=A0=A0=A0=A0=A0 /* fall through to fast_exception_return */
>  -
>  -=A0=A0=A0=A0=A0=A0 .globl=A0 fast_exception_return
> -fast_exception_return:
> -=A0=A0=A0=A0=A0=A0 andi.=A0=A0 r10,r9,MSR_RI=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 /* check for recoverable=20
> interrupt */
>  -=A0=A0=A0=A0=A0=A0 beq=A0=A0=A0=A0 1f=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0 /* if not, we've got problems=20
> */
>  -2:=A0=A0=A0=A0 REST_4GPRS(3, r11)
>  -=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r10,_CCR(r11)
>  -=A0=A0=A0=A0=A0=A0 REST_GPR(1, r11)
>  -=A0=A0=A0=A0=A0=A0 mtcr=A0=A0=A0 r10
> -=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r10,_LINK(r11)
> -=A0=A0=A0=A0=A0=A0 mtlr=A0=A0=A0 r10
> -=A0=A0=A0=A0=A0=A0 REST_GPR(10, r11)
>  -=A0=A0=A0=A0=A0=A0 mtspr=A0=A0 SPRN_SRR1,r9
> -=A0=A0=A0=A0=A0=A0 mtspr=A0=A0 SPRN_SRR0,r12
> -=A0=A0=A0=A0=A0=A0 REST_GPR(9, r11)
>  -=A0=A0=A0=A0=A0=A0 REST_GPR(12, r11)
>  -=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r11,GPR11(r11)
> -=A0=A0=A0=A0=A0=A0 SYNC
>  -=A0=A0=A0=A0=A0=A0 RFI
>  -
>  -/* check if the exception happened in a restartable section */
>  -1:=A0=A0=A0=A0 lis=A0=A0=A0=A0 r3,exc_exit_restart_end@ha
> -=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r3,exc_exit_restart_end@l
> -=A0=A0=A0=A0=A0=A0 cmplw=A0=A0 r12,r3
>  -=A0=A0=A0=A0=A0=A0 bge=A0=A0=A0=A0 3f
>  -=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r4,exc_exit_restart@ha
> -=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r4,r4,exc_exit_restart@l
> -=A0=A0=A0=A0=A0=A0 cmplw=A0=A0 r12,r4
>  -=A0=A0=A0=A0=A0=A0 blt=A0=A0=A0=A0 3f
>  -=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r3,fee_restarts@ha
> -=A0=A0=A0=A0=A0=A0 tophys(r3,r3)
>  -=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r5,fee_restarts@l(r3)
> -=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r5,r5,1
>  -=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r5,fee_restarts@l(r3)
> -=A0=A0=A0=A0=A0=A0 mr=A0=A0=A0=A0=A0 r12,r4=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* restart at exc_exit_restart */
>  -=A0=A0=A0=A0=A0=A0 b=A0=A0=A0=A0=A0=A0 2b
>  -
>  -=A0=A0=A0=A0=A0=A0 .comm=A0=A0 fee_restarts,4
>  -
>  -/* aargh, a nonrecoverable interrupt, panic */
>  -/* aargh, we don't know which trap this is */
>  -/* but the 601 doesn't implement the RI bit, so assume it's OK */
>  -3:
>  -BEGIN_FTR_SECTION
> -=A0=A0=A0=A0=A0=A0 b=A0=A0=A0=A0=A0=A0 2b
>  -END_FTR_SECTION_IFSET(CPU_FTR_601)
> -=A0=A0=A0=A0=A0=A0 li=A0=A0=A0=A0=A0 r10,-1
>  -=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r10,TRAP(r11)
>  -=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r1,STACK_FRAME_OVERHEAD
> -=A0=A0=A0=A0=A0=A0 li=A0=A0=A0=A0=A0 r10,MSR_KERNEL
> -=A0=A0=A0=A0=A0=A0 bl=A0=A0=A0=A0=A0 transfer_to_handler_full
> -=A0=A0=A0=A0=A0=A0 .long=A0=A0 nonrecoverable_exception
> -=A0=A0=A0=A0=A0=A0 .long=A0=A0 ret_from_except
> -
>  -/*
>  - * FP unavailable trap from kernel - print a message, but let
>  - * the task use FP in the kernel until it returns to user mode.
>  - */
>  -KernelFP:
>  -=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r3,_MSR(r1)
>  -=A0=A0=A0=A0=A0=A0 ori=A0=A0=A0=A0 r3,r3,MSR_FP
>  -=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r3,_MSR(r1)=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 /* enable use of FP after=20
> return */
>  -=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r3,86f@h
>  -=A0=A0=A0=A0=A0=A0 ori=A0=A0=A0=A0 r3,r3,86f@l
>  -=A0=A0=A0=A0=A0=A0 mr=A0=A0=A0=A0=A0 r4,r2=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 /* current */
>  -=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r5,_NIP(r1)
>  -=A0=A0=A0=A0=A0=A0 bl=A0=A0=A0=A0=A0 printk
>  -=A0=A0=A0=A0=A0=A0 b=A0=A0=A0=A0=A0=A0 ret_from_except
> -86:=A0=A0=A0 .string "floating point used in kernel (task=3D%p, =
pc=3D%x)\n"
>  -=A0=A0=A0=A0=A0=A0 .align=A0 4,0
> -
>  =A0#ifdef CONFIG_ALTIVEC
> =A0/* Note that the AltiVec support is closely modeled after the FP
>  =A0 * support.=A0 Changes to one are likely to be applicable to the
>  @@ -1014,42 +887,6 @@
>  =A0#endif /* CONFIG_SMP */
>  =A0=A0=A0=A0=A0=A0=A0 blr
>  =A0#endif /* CONFIG_ALTIVEC */
>  -
>  -/*
>  - * giveup_fpu(tsk)
> - * Disable FP for the task given as the argument,
>  - * and save the floating-point registers in its thread_struct.
>  - * Enables the FPU for use in the kernel on return.
>  - */
>  -=A0=A0=A0=A0=A0=A0 .globl=A0 giveup_fpu
>  -giveup_fpu:
>  -=A0=A0=A0=A0=A0=A0 mfmsr=A0=A0 r5
> -=A0=A0=A0=A0=A0=A0 ori=A0=A0=A0=A0 r5,r5,MSR_FP
>  -=A0=A0=A0=A0=A0=A0 SYNC_601
>  -=A0=A0=A0=A0=A0=A0 ISYNC_601
>  -=A0=A0=A0=A0=A0=A0 MTMSRD(r5)=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 /* enable use of fpu now */
>  -=A0=A0=A0=A0=A0=A0 SYNC_601
>  -=A0=A0=A0=A0=A0=A0 isync
>  -=A0=A0=A0=A0=A0=A0 cmpwi=A0=A0 0,r3,0
>  -=A0=A0=A0=A0=A0=A0 beqlr-=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 /* if no previous owner, done=20
> */
> -=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r3,THREAD=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 /* want THREAD of task */
>  -=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r5,PT_REGS(r3)
> -=A0=A0=A0=A0=A0=A0 cmpwi=A0=A0 0,r5,0
>  -=A0=A0=A0=A0=A0=A0 SAVE_32FPRS(0, r3)
>  -=A0=A0=A0=A0=A0=A0 mffs=A0=A0=A0 fr0
> -=A0=A0=A0=A0=A0=A0 stfd=A0=A0=A0 fr0,THREAD_FPSCR-4(r3)
>  -=A0=A0=A0=A0=A0=A0 beq=A0=A0=A0=A0 1f
>  -=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> -=A0=A0=A0=A0=A0=A0 li=A0=A0=A0=A0=A0 r3,MSR_FP|MSR_FE0|MSR_FE1
> -=A0=A0=A0=A0=A0=A0 andc=A0=A0=A0 r4,r4,r3=A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 /* disable FP for previous=20
> task */
>  -=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> -1:
>  -#ifndef CONFIG_SMP
> -=A0=A0=A0=A0=A0=A0 li=A0=A0=A0=A0=A0 r5,0
>  -=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r4,last_task_used_math@ha
> -=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r5,last_task_used_math@l(r4)
> -#endif /* CONFIG_SMP */
>  -=A0=A0=A0=A0=A0=A0 blr
>  =A0
>  =A0/*
>  =A0 * This code is jumped to from the startup code to copy
>  diff -Nru a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
> --- a/arch/ppc/kernel/head_44x.S=A0=A0=A0=A0=A0=A0=A0 2005-04-12 =
09:54:36 -05:00
>  +++ b/arch/ppc/kernel/head_44x.S=A0=A0=A0=A0=A0=A0=A0 2005-04-12 =
09:54:36 -05:00
>  @@ -426,7 +426,11 @@
>  =A0=A0=A0=A0=A0=A0=A0 PROGRAM_EXCEPTION
> =A0
>  =A0=A0=A0=A0=A0=A0=A0 /* Floating Point Unavailable Interrupt */
>  +#ifdef CONFIG_PPC_FPU
> +=A0=A0=A0=A0=A0=A0 FP_UNAVAILABLE_EXCEPTION
> +#else
>  =A0=A0=A0=A0=A0=A0=A0 EXCEPTION(0x2010, FloatingPointUnavailable, =
UnknownException,=20
> EXC_XFER_EE)
> +#endif
>  =A0
>  =A0=A0=A0=A0=A0=A0=A0 /* System Call Interrupt */
> =A0=A0=A0=A0=A0=A0=A0 START_EXCEPTION(SystemCall)
> @@ -686,9 +690,11 @@
>  =A0 *
>  =A0 * The 44x core does not have an FPU.
>  =A0 */
>  +#ifndef CONFIG_PPC_FPU
> =A0_GLOBAL(giveup_fpu)
> =A0=A0=A0=A0=A0=A0=A0 blr
>  -
>  +#endif
>  +
> =A0/*
>  =A0 * extern void abort(void)
>  =A0 *
>  diff -Nru a/arch/ppc/kernel/head_booke.h=20
> b/arch/ppc/kernel/head_booke.h
> --- a/arch/ppc/kernel/head_booke.h=A0=A0=A0=A0=A0 2005-04-12 09:54:36 =
-05:00
>  +++ b/arch/ppc/kernel/head_booke.h=A0=A0=A0=A0=A0 2005-04-12 09:54:36 =
-05:00
>  @@ -337,4 +337,11 @@
>  =A0=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r1,STACK_FRAME_OVERHEAD;=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=20
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0 \
>  =A0=A0=A0=A0=A0=A0=A0 EXC_XFER_LITE(0x0900, timer_interrupt)
> =A0
>  +#define FP_UNAVAILABLE_EXCEPTION=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=20
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0 \
>  +=A0=A0=A0=A0=A0=A0 START_EXCEPTION(FloatingPointUnavailable)=A0=A0=A0=A0=
=A0=A0 =A0=A0=A0=A0=A0=A0=A0=20
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0 \
> +=A0=A0=A0=A0=A0=A0 NORMAL_EXCEPTION_PROLOG;=A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=20
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0 \
>  +=A0=A0=A0=A0=A0=A0 bne=A0=A0=A0=A0 load_up_fpu;=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 /* if from user, just load it=20
> up */=A0=A0 \
>  +=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r1,STACK_FRAME_OVERHEAD;=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=20
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0 \
>  +=A0=A0=A0=A0=A0=A0 EXC_XFER_EE_LITE(0x800, KernelFP)
>  +
>  =A0#endif /* __HEAD_BOOKE_H__ */
>  diff -Nru a/arch/ppc/kernel/head_fsl_booke.S=20
> b/arch/ppc/kernel/head_fsl_booke.S
> --- a/arch/ppc/kernel/head_fsl_booke.S=A0 2005-04-12 09:54:36 -05:00
>  +++ b/arch/ppc/kernel/head_fsl_booke.S=A0 2005-04-12 09:54:36 -05:00
>  @@ -477,7 +477,11 @@
>  =A0=A0=A0=A0=A0=A0=A0 PROGRAM_EXCEPTION
> =A0
>  =A0=A0=A0=A0=A0=A0=A0 /* Floating Point Unavailable Interrupt */
>  +#ifdef CONFIG_PPC_FPU
> +=A0=A0=A0=A0=A0=A0 FP_UNAVAILABLE_EXCEPTION
> +#else
>  =A0=A0=A0=A0=A0=A0=A0 EXCEPTION(0x0800, FloatingPointUnavailable, =
UnknownException,=20
> EXC_XFER_EE)
> +#endif
>  =A0
>  =A0=A0=A0=A0=A0=A0=A0 /* System Call Interrupt */
> =A0=A0=A0=A0=A0=A0=A0 START_EXCEPTION(SystemCall)
> @@ -883,10 +887,12 @@
>  =A0/*
>  =A0 * extern void giveup_fpu(struct task_struct *prev)
>  =A0 *
>  - * The e500 core does not have an FPU.
>  + * Not all FSL Book-E cores have an FPU
>  =A0 */
>  +#ifndef CONFIG_PPC_FPU
> =A0_GLOBAL(giveup_fpu)
> =A0=A0=A0=A0=A0=A0=A0 blr
>  +#endif
>  =A0
>  =A0/*
>  =A0 * extern void abort(void)
>  diff -Nru a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
> --- a/arch/ppc/kernel/misc.S=A0=A0=A0 2005-04-12 09:54:36 -05:00
>  +++ b/arch/ppc/kernel/misc.S=A0=A0=A0 2005-04-12 09:54:36 -05:00
>  @@ -1096,17 +1096,7 @@
>  =A0 * and exceptions as if the cpu had performed the load or store.
>  =A0 */
>  =A0
>  -#if defined(CONFIG_4xx) || defined(CONFIG_E500)
> -_GLOBAL(cvt_fd)
> -=A0=A0=A0=A0=A0=A0 lfs=A0=A0=A0=A0 0,0(r3)
>  -=A0=A0=A0=A0=A0=A0 stfd=A0=A0=A0 0,0(r4)
>  -=A0=A0=A0=A0=A0=A0 blr
>  -
>  -_GLOBAL(cvt_df)
> -=A0=A0=A0=A0=A0=A0 lfd=A0=A0=A0=A0 0,0(r3)
>  -=A0=A0=A0=A0=A0=A0 stfs=A0=A0=A0 0,0(r4)
>  -=A0=A0=A0=A0=A0=A0 blr
>  -#else
>  +#ifdef CONFIG_PPC_FPU
> =A0_GLOBAL(cvt_fd)
> =A0=A0=A0=A0=A0=A0=A0 lfd=A0=A0=A0=A0 0,-4(r5)=A0=A0=A0=A0=A0=A0=A0 /* =
load up fpscr value */
>  =A0=A0=A0=A0=A0=A0=A0 mtfsf=A0=A0 0xff,0
>  diff -Nru a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
> --- a/arch/ppc/kernel/traps.c=A0=A0 2005-04-12 09:54:36 -05:00
>  +++ b/arch/ppc/kernel/traps.c=A0=A0 2005-04-12 09:54:36 -05:00
>  @@ -176,7 +176,7 @@
>  =A0#else
>  =A0#define get_mc_reason(regs)=A0=A0=A0 (mfspr(SPRN_MCSR))
> =A0#endif
>  -#define REASON_FP=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 0
>  +#define REASON_FP=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ESR_FP
>  =A0#define REASON_ILLEGAL =A0=A0=A0=A0=A0=A0=A0 ESR_PIL
> =A0#define REASON_PRIVILEGED=A0=A0=A0=A0=A0 ESR_PPR
>  =A0#define REASON_TRAP=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ESR_PTR
>  diff -Nru a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
> --- a/include/asm-ppc/reg_booke.h=A0=A0=A0=A0=A0=A0 2005-04-12 =
09:54:36 -05:00
>  +++ b/include/asm-ppc/reg_booke.h=A0=A0=A0=A0=A0=A0 2005-04-12 =
09:54:36 -05:00
>  @@ -304,6 +304,7 @@
>  =A0#define ESR_PIL=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
0x08000000=A0=A0=A0=A0=A0 /* Program Exception=20
> - Illegal */
>  =A0#define ESR_PPR=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
0x04000000=A0=A0=A0=A0=A0 /* Program Exception=20
> - Priveleged */
>  =A0#define ESR_PTR=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
0x02000000=A0=A0=A0=A0=A0 /* Program Exception=20
> - Trap */
>  +#define ESR_FP =A0=A0=A0=A0=A0=A0=A0 0x01000000=A0=A0=A0=A0=A0 /* =
Floating Point Operation */
>  =A0#define ESR_DST=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
0x00800000=A0=A0=A0=A0=A0 /* Storage Exception=20
> - Data miss */
>  =A0#define ESR_DIZ=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
0x00400000=A0=A0=A0=A0=A0 /* Storage Exception=20
> - Zone fault */
>  =A0#define ESR_ST =A0=A0=A0=A0=A0=A0=A0 0x00800000=A0=A0=A0=A0=A0 /* =
Store Operation */
>  _______________________________________________
> Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

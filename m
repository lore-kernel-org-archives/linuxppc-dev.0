Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 29C1BDDFB0
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 13:47:20 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4T3lGN2012511
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 13:47:16 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4T3lGHo589958
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 13:47:16 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4T3lFoZ015396
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 13:47:16 +1000
Date: Fri, 29 May 2009 13:20:48 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 1/6] Prepare the PowerPC platform for HW Breakpoint
	infrastructure
Message-ID: <20090529032048.GB8621@yookeroo.seuss>
References: <20090525004730.944465878@prasadkr_t60p.in.ibm.com>
	<20090525011423.GB11078@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090525011423.GB11078@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, Alan Stern <stern@rowland.harvard.edu>,
	paulus@samba.org, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 06:44:23AM +0530, K.Prasad wrote:
> Prepare the PowerPC code for HW Breakpoint infrastructure patches by including
> relevant constant definitions and function declarations.
> 
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/hw_breakpoint.h |   57 +++++++++++++++++++++++++++++++
>  arch/powerpc/include/asm/processor.h     |    1 
>  arch/powerpc/include/asm/reg.h           |    3 +
>  3 files changed, 61 insertions(+)
> 
> Index: linux-2.6-tip.hbkpt/arch/powerpc/include/asm/hw_breakpoint.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6-tip.hbkpt/arch/powerpc/include/asm/hw_breakpoint.h
> @@ -0,0 +1,57 @@
> +#ifndef	_PPC64_HW_BREAKPOINT_H
> +#define	_PPC64_HW_BREAKPOINT_H
> +
> +#ifdef	__KERNEL__
> +#define	__ARCH_HW_BREAKPOINT_H
> +#ifdef CONFIG_PPC64
> +
> +struct arch_hw_breakpoint {
> +	char		*name; /* Contains name of the symbol to set bkpt */
> +	unsigned long	address;
> +	u8		type;

You might as well make this an int, it will get padded out to 4 bytes
long anyway.

> +};
> +
> +#include <linux/kdebug.h>
> +#include <asm/reg.h>
> +#include <asm-generic/hw_breakpoint.h>
> +
> +#define HW_BREAKPOINT_READ DABR_DATA_READ
> +#define HW_BREAKPOINT_WRITE DABR_DATA_WRITE
> +#define HW_BREAKPOINT_RW (DABR_DATA_READ | DABR_DATA_WRITE)
> +
> +#define HW_BREAKPOINT_ALIGN 0x7
> +#define HW_BREAKPOINT_LEN INSTRUCTION_LEN
> +
> +extern struct hw_breakpoint *hbp_kernel[HBP_NUM];
> +DECLARE_PER_CPU(struct hw_breakpoint*, this_hbp_kernel[HBP_NUM]);
> +extern unsigned int hbp_user_refcount[HBP_NUM];
> +
> +extern void arch_install_thread_hw_breakpoint(struct task_struct *tsk);
> +extern void arch_uninstall_thread_hw_breakpoint(void);
> +extern int arch_validate_hwbkpt_settings(struct hw_breakpoint *bp,
> +						struct task_struct *tsk);
> +extern void arch_update_user_hw_breakpoint(int pos, struct task_struct *tsk);
> +extern void arch_flush_thread_hw_breakpoint(struct task_struct *tsk);
> +extern void arch_update_kernel_hw_breakpoint(void *);
> +extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
> +				     unsigned long val, void *data);
> +
> +extern void flush_thread_hw_breakpoint(struct task_struct *tsk);
> +extern int copy_thread_hw_breakpoint(struct task_struct *tsk,
> +		struct task_struct *child, unsigned long clone_flags);
> +extern void load_debug_registers(void );

It looks as though a lot of these arch hooks ought to have prototypes
in the generic part of the infrastructure.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

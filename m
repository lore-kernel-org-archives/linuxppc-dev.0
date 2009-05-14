Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [59.145.155.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B12A6DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 05:50:58 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp07.in.ibm.com (8.13.1/8.13.1) with ESMTP id n4EJonpD005072
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 01:20:49 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4EJomV11294442
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 01:20:49 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n4EJomnG023209
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 01:20:48 +0530
Date: Fri, 15 May 2009 01:20:44 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC Patch 2/6] Introduce PPC64 specific Hardware
	Breakpointinterfaces
Message-ID: <20090514195044.GD30963@in.ibm.com>
References: <20090514133312.360702378@prasadkr_t60p.in.ibm.com>
	<20090514134439.GC14229@in.ibm.com>
	<1242312611.8608.32.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1242312611.8608.32.camel@concordia>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, Alan Stern <stern@rowland.harvard.edu>,
	paulus@samba.org, Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 15, 2009 at 12:50:11AM +1000, Michael Ellerman wrote:
> On Thu, 2009-05-14 at 19:14 +0530, K.Prasad wrote:
> > plain text document attachment (ppc64_arch_hwbkpt_implementation_02)
> > Introduce PPC64 implementation for the generic hardware breakpoint interfaces
> > defined in kernel/hw_breakpoint.c. Enable the HAVE_HW_BREAKPOINT flag and the
> > Makefile.
> 
> Hi, some comments inline ...
> 
>

Thanks for reviewing the code.
 
> > Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/hw_breakpoint.c
> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/hw_breakpoint.c
> > @@ -0,0 +1,281 @@
> > +/*
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> > + *
> > + * Copyright (C) 2009 IBM Corporation
> > + */
> 
> Don't use (C), either use a proper ©, or just skip it. I don't know
> why :)
> 

Ok.

> > +/*
> > + * HW_breakpoint: a unified kernel/user-space hardware breakpoint facility,
> > + * using the CPU's debug registers.
> > + */
> 
> This comment would normally go at the top of the file.
> 

Ok.

> > +
> > +#include <linux/notifier.h>
> > +#include <linux/kallsyms.h>
> > +#include <linux/kprobes.h>
> > +#include <linux/percpu.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/sched.h>
> > +#include <linux/init.h>
> > +#include <linux/smp.h>
> > +
> > +#include <asm/hw_breakpoint.h>
> > +#include <asm/processor.h>
> > +#include <asm/sstep.h>
> > +
> > +/* Store the kernel-space breakpoint address value */
> > +static unsigned long kdabr;
> > +
> > +/*
> > + * Temporarily stores address for DABR before it is written by the
> > + * single-step handler routine
> > + */
> > +static DEFINE_PER_CPU(unsigned long, dabr_data);
> 
> How does this relate to the existing current_dabr per-cpu variable?
> 

The present infrastructure assumes that kernel-space (through xmon and
KGDB) and user-space requests happen at mutually exclusive times.

current_dabr in arch/powerpc/kernel/process.c stores the value of DABR
as requested by the current process and helps initiate a set_dabr() call
if the new incoming process's DABR value is different (when neither of
them use DABR, the values are 0, hence no set_dabr() call).

The per-cpu 'dabr_data' seen above is used to store the value of DABR
temporarily between a HW Breakpoint exception handler
hw_breakpoint_handler() (where the breakpoint exception might be
temporarily disabled if emulate_step() failed) and a single-step
exception handler single_step_dabr_instruction() in which the DABR value
is restored from per-cpu 'dabr_data'.

This is required because PowerPC triggers DABR match exception before
execution of the causative instruction (such as load/store) and if the
DABR value remains enabled, the system will enter into an infinite loop.

> > +void arch_update_kernel_hw_breakpoint(void *unused)
> > +{
> > +	struct hw_breakpoint *bp;
> > +
> > +	/* Check if there is nothing to update */
> > +	if (hbp_kernel_pos == HBP_NUM)
> > +		return;
> 
> Should that be hbp_kernel_pos >= HBP_NUM, you're checking array bounds
> right?
> 

In short, no. If hbp_kernel_pos > HBP_NUM it is only indicative of erroneous
code and not a condition that the system could enter.

To explain 'hbp_kernel_pos' further, it is that variable which points to
the last numbered debug register occupied by the kernel (which is more
meaningful on a processor having more than one debug register). 

In the above code, in arch_update_kernel_hw_breakpoint()
"hbp_kernel_pos == HBP_NUM" condition would be satisfied when
invoked from load_debug_registers() at initialisation time (kernel
requests are serviced starting from highest numbered register).

Having said that, I find that I've missed invoking
load_debug_registers() [a part of kernel/hw_breakpoint.c] in
start_secondary(). Thanks for raising this question which helped me
identify the missing invocation, I will add the same.

> > +	bp = hbp_kernel[hbp_kernel_pos];
> > +	if (bp == NULL)
> > +		kdabr = 0;
> > +	else
> > +		kdabr = bp->info.address | bp->info.type | DABR_TRANSLATION;
> > +	set_dabr(kdabr);
> > +}
> > +
> > +/*
> > + * Install the thread breakpoints in their debug registers.
> > + */
> > +void arch_install_thread_hw_breakpoint(struct task_struct *tsk)
> > +{
> > +	set_dabr(tsk->thread.dabr);
> 
> Can we avoid setting this value if it's not necessary? It might require
> an hcall. See for example what we do in __switch_to().
> 

I see that you're referring to this code in __switch_to() :
        if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
                set_dabr(new->thread.dabr);

arch_install_thread_hw_breakpoint()<--switch_to_thread_hw_breakpoint()
<--__switch_to() implementation is also similar.

In __switch_to(),
                if (unlikely(test_tsk_thread_flag(new, TIF_DEBUG)))
                        switch_to_thread_hw_breakpoint(new);

happens only when TIF_DEBUG flag is set. This flag is cleared when the
process unregisters any breakpoints it had requested earlier. So, the
set_dabr() call is avoided for processes not using the debug register.

> > +/*
> > + * Check for virtual address in user space.
> > + */
> > +static int arch_check_va_in_userspace(unsigned long va)
> > +{
> > +	return (!(is_kernel_addr(va)));
> > +}
> > +
> > +/*
> > + * Check for virtual address in kernel space.
> > + */
> > +static int arch_check_va_in_kernelspace(unsigned long va)
> > +{
> > +	return is_kernel_addr(va);
> > +}
> 
> You don't need these two routines. Just use is_kernel_addr() directly,
> that way people will know what the code is doing without having to
> lookup these new functions.
> 

These functions are here due to 'legacy' reasons (from x86 code) , but I
see that it can be made a lot simpler by using is_kernel() for PPC64. I
will change the code on the lines of what you've suggested below.

But on processors supporting variable range of addresses, the above
functions may be required. Well, it can be added when required!

> > +/*
> > + * Store a breakpoint's encoded address, length, and type.
> > + */
> 
> This doesn't "store" in the sense I was thinking, it actually does a
> lookup and returns info in the arg.
> 
> > +int arch_store_info(struct hw_breakpoint *bp)
> > +{
> > +	/*
> > +	 * User-space requests will always have the address field populated
> > +	 * For kernel-addresses, either the address or symbol name can be
> > +	 * specified.
> > +	 */
> 
> Do user-space requests never have the name populated? Otherwise aren't
> you overwriting the supplied address with the one from kallsyms?
> 

I see that I should also check for an empty bp->info.name when "if (tsk)"
is TRUE. I will add the same.

> > +	if (bp->info.name)
> > +		bp->info.address = (unsigned long)
> > +					kallsyms_lookup_name(bp->info.name);
> > +	if (bp->info.address)
> > +		return 0;
> > +	return -EINVAL;
> > +}
> > +
> > +/*
> > + * Validate the arch-specific HW Breakpoint register settings
> > + */
> > +int arch_validate_hwbkpt_settings(struct hw_breakpoint *bp,
> > +						struct task_struct *tsk)
> > +{
> > +	int ret = -EINVAL;
> > +
> > +	if (!bp)
> > +		return ret;
> > +
> > +	switch (bp->info.type) {
> > +	case DABR_DATA_READ:
> > +		break;
> > +	case DABR_DATA_WRITE:
> > +		break;
> > +	case DABR_DATA_RW:
> > +		break;
> 
> You only need the final break here.
> 

Yes, will change.

> > +	default:
> > +		return ret;
> > +	}
> > +
> > +	if (bp->triggered)
> > +		ret = arch_store_info(bp);
> 
> Shouldn't you check ret here, bp->info.address might be bogus.

Only when bp->info.name is set for user-space. The additional check I
described above should help.

> > +
> > +	/* Check for double word alignment - 8 bytes */
> > +	if (bp->info.address & HW_BREAKPOINT_ALIGN)
> > +		return -EINVAL;
> > +
> > +	/* Check that the virtual address is in the proper range */
> > +	if (tsk) {
> > +		if (!arch_check_va_in_userspace(bp->info.address))
> > +			return -EFAULT;
> > +	} else {
> > +		if (!arch_check_va_in_kernelspace(bp->info.address))
> > +			return -EFAULT;
> > +	}
> 
> Which becomes:
> 
> is_kernel = is_kernel_addr(bp->info.address);
> if (tsk && is_kernel || !tsk && !is_kernel)
> 	return -EFAULT;
> 

Ok. I will change them.

> > +void arch_update_user_hw_breakpoint(int pos, struct task_struct *tsk)
> > +{
> > +	struct thread_struct *thread = &(tsk->thread);
> > +	struct hw_breakpoint *bp = thread->hbp[0];
> > +
> > +	if (bp)
> > +		thread->dabr = bp->info.address	| bp->info.type |
> > +				DABR_TRANSLATION;
> 
> 2nd place I've seen that pattern.
> 

I don't recognise what issue you're referring to. Can you elaborate?

> > +	else
> > +		thread->dabr = 0;
> > +}
> > +
> > +void arch_flush_thread_hw_breakpoint(struct task_struct *tsk)
> > +{
> > +	struct thread_struct *thread = &(tsk->thread);
> > +
> > +	thread->dabr = 0;
> > +}
> > +
> > +/*
> > + * Handle debug exception notifications.
> > + */
> > +int __kprobes hw_breakpoint_handler(struct die_args *args)
> > +{
> > +	int rc = NOTIFY_STOP;
> > +	struct hw_breakpoint *bp;
> > +	struct pt_regs *regs = args->regs;
> > +	unsigned long dar;
> > +	int cpu, stepped, is_kernel;
> > +
> > +	/* Disable breakpoints during exception handling */
> > +	set_dabr(0);
> > +
> > +	dar = regs->dar & (~HW_BREAKPOINT_ALIGN);
> > +	is_kernel = (dar >= TASK_SIZE) ? 1 : 0;
> 
> is_kernel_addr() ?
> 

Ok.

> > +	if (is_kernel)
> > +		bp = hbp_kernel[0];
> > +	else {
> > +		bp = current->thread.hbp[0];
> > +		/* Lazy debug register switching */
> > +		if (!bp)
> > +			return rc;
> 
> What if we keep hitting this case?
> 

In short - no, they will not recur because we are returning after a
set_dabr(0).

The reason a breakpoint exception can trigger because of lazy debug
register switching is because the DABR value is not cleared when the
incoming process does not have TIF_DEBUG set i.e. does not use
breakpoint register. If the outgoing process used DABR while the
incoming process did not, and happened to read/write on the same address
such an exception can arise. It is only then that the DABR value is
cleared.

> > +		rc = NOTIFY_DONE;
> > +	}
> > +
> > +	(bp->triggered)(bp, regs);
> > +
> > +	cpu = get_cpu();
> > +	if (is_kernel)
> > +		per_cpu(dabr_data, cpu) = kdabr;
> > +	else
> > +		per_cpu(dabr_data, cpu) = current->thread.dabr;
> > +
> > +	stepped = emulate_step(regs, regs->nip);
> > +	/*
> > +	 * Single-step the causative instruction manually if
> > +	 * emulate_step() could not execute it
> > +	 */
> > +	if (stepped == 0) {
> > +		regs->msr |= MSR_SE;
> > +		goto out;
> > +	}
> > +
> > +	set_dabr(per_cpu(dabr_data, cpu));
> > +out:
> > +	/* Enable pre-emption only if single-stepping is finished */
> > +	if (stepped)
> > +		put_cpu_no_resched();
> > +	return rc;
> > +}
> 
> Gotta run, laptop battery running out! :)
> 
> cheers
> 

Thanks again for your reviews. I will post another patchset with the
changes I've agreed above.

Thanks,
K.Prasad

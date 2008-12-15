Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59C79DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 07:20:15 +1100 (EST)
Message-Id: <B3FDD472-0720-4454-9329-5A1C8A9BF84A@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20081215054554.E883EDDF9D@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 11/16] powerpc/mm: Add SMP support to no-hash TLB handling
	v3
Date: Mon, 15 Dec 2008 14:19:48 -0600
References: <20081215054554.E883EDDF9D@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 14, 2008, at 11:44 PM, Benjamin Herrenschmidt wrote:

> This patch moves the whole no-hash TLB handling out of line into a
> new tlb_nohash.c file, and implements some basic SMP support using
> IPIs and/or broadcast tlbivax instructions.
>
> Note that I'm using local invalidations for D->I cache coherency.
>
> At worst, if another processor is trying to execute the same and
> has the old entry in its TLB, it will just take a fault and re-do
> the TLB flush locally (it won't re-do the cache flush in any case).
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> v2. This variant fixes usage of linux/spinlock.h instead of asm/ 
> spinlock.h
> v3. Invadvertently un-EXPORT_SYMBOL'ed some cache flush calls on ppc64
> v4. Fix differences in local_* flush variants between CPU types and
>    corresponding clash with highmem code. Remove remaining _tlbie  
> calls
>    from nohash code.
>
> arch/powerpc/include/asm/highmem.h  |    4
> arch/powerpc/include/asm/mmu.h      |    3
> arch/powerpc/include/asm/tlbflush.h |   84 ++++++--------
> arch/powerpc/kernel/misc_32.S       |    9 +
> arch/powerpc/kernel/ppc_ksyms.c     |    6 -
> arch/powerpc/mm/Makefile            |    2
> arch/powerpc/mm/fault.c             |    2
> arch/powerpc/mm/mem.c               |    2
> arch/powerpc/mm/tlb_hash32.c        |    4
> arch/powerpc/mm/tlb_nohash.c        |  209 ++++++++++++++++++++++++++ 
> ++++++++++
> 10 files changed, 268 insertions(+), 57 deletions(-)
>

> Index: linux-work/arch/powerpc/mm/tlb_nohash.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/arch/powerpc/mm/tlb_nohash.c	2008-12-15  
> 14:36:20.000000000 +1100
> @@ -0,0 +1,209 @@
> +/*
> + * This file contains the routines for TLB flushing.
> + * On machines where the MMU does not use a hash table to store  
> virtual to
> + * physical translations (ie, SW loaded TLBs or Book3E compilant  
> processors,
> + * this does -not- include 603 however which shares the  
> implementation with
> + * hash based processors)
> + *
> + *  -- BenH
> + *
> + * Copyright 2008 Ben Herrenschmidt <benh@kernel.crashing.org>
> + *                IBM Corp.
> + *
> + *  Derived from arch/ppc/mm/init.c:
> + *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
> + *
> + *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
> + *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
> + *    Copyright (C) 1996 Paul Mackerras
> + *
> + *  Derived from "arch/i386/mm/init.c"
> + *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
> + *
> + *  This program is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU General Public License
> + *  as published by the Free Software Foundation; either version
> + *  2 of the License, or (at your option) any later version.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/init.h>
> +#include <linux/highmem.h>
> +#include <linux/pagemap.h>
> +#include <linux/preempt.h>
> +#include <linux/spinlock.h>
> +
> +#include <asm/tlbflush.h>
> +#include <asm/tlb.h>
> +
> +#include "mmu_decl.h"
> +
> +/*
> + * Basse TLB flushing operations:

One 's'

>
> + *
> + *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
> + *  - flush_tlb_page(vma, vmaddr) flushes one page
> + *  - flush_tlb_range(vma, start, end) flushes a range of pages
> + *  - flush_tlb_kernel_range(start, end) flushes kernel pages
> + *
> + *  - local_* variants of page and mm only apply to the current
> + *    processor
> + */
> +
> +/*
> + * These are the base non-SMP variants of page and mm flushing
> + */
> +void local_flush_tlb_mm(struct mm_struct *mm)
> +{
> +	unsigned int pid;
> +
> +	preempt_disable();
> +	pid = mm->context.id;
> +	if (pid != MMU_NO_CONTEXT)
> +		_tlbil_pid(pid);
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(local_flush_tlb_mm);

Do these really get called w/MMU_NO_CONTEXT?  What is the calling code  
trying to flush under those situations?

> +
> +void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long  
> vmaddr)
> +{
> +	unsigned int pid;
> +
> +	preempt_disable();
> +	pid = vma ? vma->vm_mm->context.id : 0;
> +	if (pid != MMU_NO_CONTEXT)
> +		_tlbil_va(vmaddr, pid);
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(local_flush_tlb_page);
> +
> +
> +/*
> + * And here are the SMP non-local implementations
> + */
> +#ifdef CONFIG_SMP
> +
> +static DEFINE_SPINLOCK(tlbivax_lock);
> +
> +struct tlb_flush_param {
> +	unsigned long addr;
> +	unsigned int pid;
> +};
> +
> +static void do_flush_tlb_mm_ipi(void *param)
> +{
> +	struct tlb_flush_param *p = param;
> +
> +	_tlbil_pid(p ? p->pid : 0);
> +}
> +
> +static void do_flush_tlb_page_ipi(void *param)
> +{
> +	struct tlb_flush_param *p = param;
> +
> +	_tlbil_va(p->addr, p->pid);
> +}
> +
> +
> +/* Note on invalidations and PID:
> + *
> + * We snapshot the PID with preempt disabled. At this point, it can  
> still
> + * change either because:
> + * - our context is being stolen (PID -> NO_CONTEXT) on another CPU
> + * - we are invaliating some target that isn't currently running here
> + *   and is concurrently acquiring a new PID on another CPU
> + * - some other CPU is re-acquiring a lost PID for this mm
> + * etc...
> + *
> + * However, this shouldn't be a problem as we only guarantee
> + * invalidation of TLB entries present prior to this call, so we
> + * don't care about the PID changing, and invalidating a stale PID
> + * is generally harmless.
> + */
> +
> +void flush_tlb_mm(struct mm_struct *mm)
> +{
> +	cpumask_t cpu_mask;
> +	unsigned int pid;
> +
> +	preempt_disable();
> +	pid = mm->context.id;
> +	if (unlikely(pid == MMU_NO_CONTEXT))
> +		goto no_context;
> +	cpu_mask = mm->cpu_vm_mask;
> +	cpu_clear(smp_processor_id(), cpu_mask);
> +	if (!cpus_empty(cpu_mask)) {
> +		struct tlb_flush_param p = { .pid = pid };
> +		smp_call_function_mask(cpu_mask, do_flush_tlb_mm_ipi, &p, 1);
> +	}
> +	_tlbil_pid(pid);
> + no_context:
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(flush_tlb_mm);
> +
> +void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
> +{
> +	cpumask_t cpu_mask;
> +	unsigned int pid;
> +
> +	preempt_disable();
> +	pid = vma ? vma->vm_mm->context.id : 0;
> +	if (unlikely(pid == MMU_NO_CONTEXT))
> +		goto bail;
> +	cpu_mask = vma->vm_mm->cpu_vm_mask;
> +	cpu_clear(smp_processor_id(), cpu_mask);
> +	if (!cpus_empty(cpu_mask)) {
> +		/* If broadcast tlbivax is supported, use it */
> +		if (mmu_has_feature(MMU_FTR_HAS_TLBIVAX_BCAST)) {
> +			int lock = mmu_has_feature(MMU_FTR_TLBIVAX_NEED_LOCK);
> +			if (lock)
> +				spin_lock(&tlbivax_lock);
> +			_tlbivax_bcast(vmaddr, pid);
> +			if (lock)
> +				spin_unlock(&tlbivax_lock);
> +			goto bail;
> +		} else {
> +			struct tlb_flush_param p = { .pid = pid, .addr = vmaddr };
> +			smp_call_function_mask(cpu_mask,
> +					       do_flush_tlb_page_ipi, &p, 1);
> +		}
> +	}
> +	_tlbil_va(vmaddr, pid);
> + bail:
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(flush_tlb_page);
> +
> +#endif /* CONFIG_SMP */
> +
> +/*
> + * Flush kernel TLB entries in the given range
> + */
> +void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> +{
> +#ifdef CONFIG_SMP
> +	preempt_disable();
> +	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);
> +	_tlbil_pid(0);
> +	preempt_enable();
> +#endif
> +	_tlbil_pid(0);
> +}
> +EXPORT_SYMBOL(flush_tlb_kernel_range);
> +
> +/*
> + * Currently, for range flushing, we just do a full mm flush. This  
> should
> + * be optimized based on a threshold on the size of the range, since
> + * some implementation can stack multiple tlbivax before a tlbsync  
> but
> + * for now, we keep it that way
> + */
> +void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> +		     unsigned long end)
> +
> +{
> +	flush_tlb_mm(vma->vm_mm);
> +}
> +EXPORT_SYMBOL(flush_tlb_range);

[snip]

> Index: linux-work/arch/powerpc/include/asm/mmu.h
> ===================================================================
> --- linux-work.orig/arch/powerpc/include/asm/mmu.h	2008-12-15  
> 14:36:20.000000000 +1100
> +++ linux-work/arch/powerpc/include/asm/mmu.h	2008-12-15  
> 14:36:20.000000000 +1100
> @@ -15,6 +15,9 @@
> #define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
> #define MMU_FTR_HAS_HIGH_BATS		ASM_CONST(0x00010000)
> #define MMU_FTR_BIG_PHYS		ASM_CONST(0x00020000)
> +#define MMU_FTR_HAS_TLBIVAX_BCAST	ASM_CONST(0x00040000)
> +#define MMU_FTR_HAS_TLBILX_PID		ASM_CONST(0x00080000)

Can we make these FTR_USE_ instead of FTR_HAS_.  On e500 we have  
TLBIVAX_BCAST but dont plan to use it.  I'd prefer not to have to  
answer questions about that.

> +#define MMU_FTR_TLBIVAX_NEED_LOCK	ASM_CONST(0x00100000)

Is this really ivax lock or sync lock?

- k

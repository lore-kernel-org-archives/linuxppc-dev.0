Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00394DDECF
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 07:48:25 +1100 (EST)
Subject: Re: [PATCH 11/16] powerpc/mm: Add SMP support to no-hash TLB
	handling v3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <B3FDD472-0720-4454-9329-5A1C8A9BF84A@freescale.com>
References: <20081215054554.E883EDDF9D@ozlabs.org>
	<B3FDD472-0720-4454-9329-5A1C8A9BF84A@freescale.com>
Content-Type: text/plain
Date: Tue, 16 Dec 2008 07:46:18 +1100
Message-Id: <1229373978.26324.120.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +void local_flush_tlb_mm(struct mm_struct *mm)
> > +{
> > +	unsigned int pid;
> > +
> > +	preempt_disable();
> > +	pid = mm->context.id;
> > +	if (pid != MMU_NO_CONTEXT)
> > +		_tlbil_pid(pid);
> > +	preempt_enable();
> > +}
> > +EXPORT_SYMBOL(local_flush_tlb_mm);
> 
> Do these really get called w/MMU_NO_CONTEXT?  What is the calling code  
> trying to flush under those situations?

A bit of paranoia but yes, I think they can. flush_* can be called on a
non-current mm, thus an mm without a context (because it's been stolen
mostly) due to calls to unmap_mapping_range() or something like that,
which can be called by some filesystems (especially network filesystems
trying to reflect remote changes on mmap'ed regions I think). Under some
circumstances, ptrace can also cause flushes of non-current mm's.
 
> 
> > Index: linux-work/arch/powerpc/include/asm/mmu.h
> > ===================================================================
> > --- linux-work.orig/arch/powerpc/include/asm/mmu.h	2008-12-15  
> > 14:36:20.000000000 +1100
> > +++ linux-work/arch/powerpc/include/asm/mmu.h	2008-12-15  
> > 14:36:20.000000000 +1100
> > @@ -15,6 +15,9 @@
> > #define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
> > #define MMU_FTR_HAS_HIGH_BATS		ASM_CONST(0x00010000)
> > #define MMU_FTR_BIG_PHYS		ASM_CONST(0x00020000)
> > +#define MMU_FTR_HAS_TLBIVAX_BCAST	ASM_CONST(0x00040000)
> > +#define MMU_FTR_HAS_TLBILX_PID		ASM_CONST(0x00080000)
> 
> Can we make these FTR_USE_ instead of FTR_HAS_.  On e500 we have  
> TLBIVAX_BCAST but dont plan to use it.  I'd prefer not to have to  
> answer questions about that.

Hehehe :-) I can change that easily yes.

> > +#define MMU_FTR_TLBIVAX_NEED_LOCK	ASM_CONST(0x00100000)
> 
> Is this really ivax lock or sync lock?

The whole thing. Not totally clear, you have a better name ? Some CPUs
want a lock on sync and some on ivax, I plan to lock the whole sequence.

Cheers,
Ben.

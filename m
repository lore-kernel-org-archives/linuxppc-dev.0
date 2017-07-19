Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC37P1kbXzDrKm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 13:54:24 +1000 (AEST)
Message-ID: <1500436453.3350.7.camel@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc/mm/radix: Workaround prefetch issue with KVM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Date: Wed, 19 Jul 2017 13:54:13 +1000
In-Reply-To: <1500431389.8256.18.camel@gmail.com>
References: <20170714015258.7933-1-benh@kernel.crashing.org>
 <20170714015258.7933-4-benh@kernel.crashing.org>
 <1500431389.8256.18.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-19 at 12:29 +1000, Balbir Singh wrote:
> 
> > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > index 6ea4b53..4fb3581b 100644
> > --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > @@ -1522,6 +1522,18 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
> >  	std	r6, VCPU_BESCR(r9)
> >  	stw	r7, VCPU_GUEST_PID(r9)
> >  	std	r8, VCPU_WORT(r9)
> > +
> > +	/* Handle the case where the guest used an illegal PID */
> > +	LOAD_REG_ADDR(r4, mmu_base_pid)
> > +	lwz	r3, 0(r4)
> > +	cmpw	cr0,r7,r3
> > +	blt	1f
> 
> So the boundary is [1..(1<<mmu_pid_bits-1)]? Do we flush the tlb
> for pid 0 always?

What do you mean ? mmu_base_pid is going to be 1 << (mmu_pid_bits-1),
we flush the TLB if the guest PID r7 is not lower than the boundary.

Ntoe: this is patch v1, look at v2.

> > +
> > +	/* Illegal PID, flush the TLB */
> > +	bl	radix_flush_pid
> > +	ld	r9, HSTATE_KVM_VCPU(r13)
> > +1:
> > +
> >  BEGIN_FTR_SECTION
> >  	mfspr	r5, SPRN_TCSCR
> >  	mfspr	r6, SPRN_ACOP
> > diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> > index abed1fe..183a67b 100644
> > --- a/arch/powerpc/mm/mmu_context_book3s64.c
> > +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> > @@ -25,6 +25,10 @@
> >  #include <asm/mmu_context.h>
> >  #include <asm/pgalloc.h>
> >  
> > +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> > +#include <asm/kvm_book3s_asm.h>
> > +#endif
> > +
> >  #include "icswx.h"
> >  
> >  static DEFINE_SPINLOCK(mmu_context_lock);
> > @@ -126,9 +130,10 @@ static int hash__init_new_context(struct mm_struct *mm)
> >  static int radix__init_new_context(struct mm_struct *mm)
> >  {
> >  	unsigned long rts_field;
> > -	int index;
> > +	int index, max_id;
> >  
> > -	index = alloc_context_id(1, PRTB_ENTRIES - 1);
> > +	max_id = (1 << mmu_pid_bits) - 1;
> > +	index = alloc_context_id(mmu_base_pid, max_id);
> >  	if (index < 0)
> >  		return index;
> >  
> > @@ -247,8 +252,40 @@ void destroy_context(struct mm_struct *mm)
> >  }
> >  
> >  #ifdef CONFIG_PPC_RADIX_MMU
> > -void radix__switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
> > +void radix__switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
> > +			       bool new_on_cpu)
> >  {
> > +	/*
> > +	 * If this context hasn't run on that CPU before and KVM is
> > +	 * around, there's a slim chance that the guest on another
> > +	 * CPU just brought in obsolete translation into the TLB of
> > +	 * this CPU due to a bad prefetch using the guest PID on
> > +	 * the way into the hypervisor.
> > +	 *
> > +	 * We work around this here. If KVM is possible, we check if
> > +	 * any sibling thread is in KVM. If it is, the window may exist
> > +	 * and thus we flush that PID from the core.
> > +	 *
> > +	 * A potential future improvement would be to mark which PIDs
> > +	 * have never been used on the system and avoid it if the PID
> > +	 * is new and the process has no other cpumask bit set.
> 
> Also due to the pid split, the chances of the context bringing in
> TLB entries is low, but a bad guest could bring in stale entries
> 
> > +	 */
> > +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> > +	if (cpu_has_feature(CPU_FTR_HVMODE) && new_on_cpu) {
> > +		int cpu = smp_processor_id();
> > +		int sib = cpu_first_thread_sibling(cpu);
> > +		bool flush = false;
> > +
> > +		for (; sib <= cpu_last_thread_sibling(cpu) && !flush; sib++) {
> > +			if (sib == cpu)
> > +				continue;
> > +			if (paca[sib].kvm_hstate.kvm_vcpu)
> > +				flush = true;
> > +		}
> > +		if (flush)
> > +			radix__local_flush_all_mm(next);
> > +	}
> > +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
> >  

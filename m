Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BFF71A0009
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 11:53:41 +1000 (EST)
Message-ID: <1404784408.21434.230.camel@snotra.buserror.net>
Subject: Re: [RFC PATCH 2/4] KVM: PPC: Book3E: Handle LRAT error exception
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Date: Mon, 7 Jul 2014 20:53:28 -0500
In-Reply-To: <53B6628B.6020001@suse.de>
References: <1404398727-12844-1-git-send-email-mihai.caraman@freescale.com>
 <1404398727-12844-3-git-send-email-mihai.caraman@freescale.com>
 <53B6628B.6020001@suse.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-07-04 at 10:15 +0200, Alexander Graf wrote:
> On 03.07.14 16:45, Mihai Caraman wrote:
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > index a192975..ab1077f 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -1286,6 +1286,46 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
> >   		break;
> >   	}
> >   
> > +#ifdef CONFIG_KVM_BOOKE_HV
> > +	case BOOKE_INTERRUPT_LRAT_ERROR:
> > +	{
> > +		gfn_t gfn;
> > +
> > +		/*
> > +		 * Guest TLB management instructions (EPCR.DGTMI == 0) is not
> > +		 * supported for now
> > +		 */
> > +		if (!(vcpu->arch.fault_esr & ESR_PT)) {
> > +			WARN(1, "%s: Guest TLB management instructions not supported!\n", __func__);
> 
> Wouldn't this allow a guest to flood the host's kernel log?

It shouldn't be possible for this to happen, since the host will never
set EPCR[DGTMI] -- but yes, it should be WARN_ONCE or ratelimited.

> > +{
> > +	int this, next;
> > +
> > +	this = local_paca->tcd.lrat_next;
> > +	next = (this + 1) % local_paca->tcd.lrat_max;
> 
> Can we assume that lrat_max is always a power of 2? IIRC modulo 
> functions with variables can be quite expensive. So if we can instead do
> 
>    next = (this + 1) & local_paca->tcd.lrat_mask;
> 
> we should be faster and not rely on division helpers.

Architecturally we can't assume that, though it's true on the only
existing implementation.

Why not do something similar to what is done for tlb1:

        unsigned int sesel = vcpu_e500->host_tlb1_nv++;

        if (unlikely(vcpu_e500->host_tlb1_nv >= tlb1_max_shadow_size()))
                vcpu_e500->host_tlb1_nv = 0;

...and while we're at it, use local_paca->tcd for tlb1 as well (except
on 32-bit).

Also, please use get_paca() rather than local_paca so that the
preemption-disabled check is retained.

> > +void write_host_lrate(int tsize, gfn_t gfn, unsigned long pfn, uint32_t lpid,
> > +		      int valid, int lrat_entry)
> > +{
> > +	struct kvm_book3e_206_tlb_entry stlbe;
> > +	int esel = lrat_entry;
> > +	unsigned long flags;
> > +
> > +	stlbe.mas1 = (valid ? MAS1_VALID : 0) | MAS1_TSIZE(tsize);
> > +	stlbe.mas2 = ((u64)gfn << PAGE_SHIFT);
> > +	stlbe.mas7_3 = ((u64)pfn << PAGE_SHIFT);
> > +	stlbe.mas8 = MAS8_TGS | lpid;
> > +
> > +	local_irq_save(flags);
> > +	/* book3e_tlb_lock(); */
> 
> Hm?

Indeed.

> > +
> > +	if (esel == -1)
> > +		esel = lrat_next();
> > +	__write_host_tlbe(&stlbe, MAS0_ATSEL | MAS0_ESEL(esel));

Where do you call this function with lrat_entry != -1?  Why rename it to
esel at function entry?

> > +	down_read(&current->mm->mmap_sem);
> > +	vma = find_vma(current->mm, hva);
> > +	if (vma && (hva >= vma->vm_start)) {
> > +		psize = vma_kernel_pagesize(vma);
> > +	} else {
> > +		pr_err_ratelimited("%s: couldn't find virtual memory address for gfn %lx!\n", __func__, (long)gfn);

While output strings should not be linewrapped, the arguments that come
after the long string should be.

-Scott

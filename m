Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 30E182C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 09:35:07 +1000 (EST)
Date: Fri, 2 Aug 2013 18:34:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Subject: Re: [PATCH 6/6 v2] kvm: powerpc: use caching attributes as per linux
 pte
Message-ID: <20130802233452.GA27636@home.buserror.net>
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375355558-19187-7-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1375355558-19187-7-git-send-email-Bharat.Bhushan@freescale.com>
Cc: kvm@vger.kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 01, 2013 at 04:42:38PM +0530, Bharat Bhushan wrote:
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 17722d8..ebcccc2 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -697,7 +697,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
>  #endif
>  
>  	kvmppc_fix_ee_before_entry();
> -
> +	vcpu->arch.pgdir = current->mm->pgd;
>  	ret = __kvmppc_vcpu_run(kvm_run, vcpu);

kvmppc_fix_ee_before_entry() is supposed to be the last thing that
happens before __kvmppc_vcpu_run().

> @@ -332,6 +324,8 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>  	unsigned long hva;
>  	int pfnmap = 0;
>  	int tsize = BOOK3E_PAGESZ_4K;
> +	pte_t pte;
> +	int wimg = 0;
>  
>  	/*
>  	 * Translate guest physical to true physical, acquiring
> @@ -437,6 +431,8 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>  
>  	if (likely(!pfnmap)) {
>  		unsigned long tsize_pages = 1 << (tsize + 10 - PAGE_SHIFT);
> +		pgd_t *pgdir;
> +
>  		pfn = gfn_to_pfn_memslot(slot, gfn);
>  		if (is_error_noslot_pfn(pfn)) {
>  			printk(KERN_ERR "Couldn't get real page for gfn %lx!\n",
> @@ -447,9 +443,18 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>  		/* Align guest and physical address to page map boundaries */
>  		pfn &= ~(tsize_pages - 1);
>  		gvaddr &= ~((tsize_pages << PAGE_SHIFT) - 1);
> +		pgdir = vcpu_e500->vcpu.arch.pgdir;
> +		pte = lookup_linux_pte(pgdir, hva, 1, &tsize_pages);
> +		if (pte_present(pte)) {
> +			wimg = (pte >> PTE_WIMGE_SHIFT) & MAS2_WIMGE_MASK;
> +		} else {
> +			printk(KERN_ERR "pte not present: gfn %lx, pfn %lx\n",
> +					(long)gfn, pfn);
> +			return -EINVAL;
> +		}
>  	}

How does wimg get set in the pfnmap case?

Could you explain why we need to set dirty/referenced on the PTE, when we
didn't need to do that before?  All we're getting from the PTE is wimg. 
We have MMU notifiers to take care of the page being unmapped, and we've
already marked the page itself as dirty if the TLB entry is writeable.

-Scott

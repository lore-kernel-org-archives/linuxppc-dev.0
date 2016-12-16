Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg8261VFNzDwBd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 22:57:34 +1100 (AEDT)
Subject: Re: [PATCH 05/11] powerpc/kvm: Split HPT allocation from activation
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-6-david@gibson.dropbear.id.au>
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e2b1693f-494f-a6d8-3c66-6591566a303b@redhat.com>
Date: Fri, 16 Dec 2016 12:57:26 +0100
MIME-Version: 1.0
In-Reply-To: <20161215055404.29351-6-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15.12.2016 06:53, David Gibson wrote:
> Currently, kvmppc_alloc_hpt() both allocates a new hashed page table (HPT)
> and sets it up as the active page table for a VM.  For the upcoming HPT
> resize implementation we're going to want to allocate HPTs separately from
> activating them.
> 
> So, split the allocation itself out into kvmppc_allocate_hpt() and perform
> the activation with a new kvmppc_set_hpt() function.  Likewise we split
> kvmppc_free_hpt(), which just frees the HPT, from kvmppc_release_hpt()
> which unsets it as an active HPT, then frees it.
> 
> We also move the logic to fall back to smaller HPT sizes if the first try
> fails into the single caller which used that behaviour,
> kvmppc_hv_setup_htab_rma().  This introduces a slight semantic change, in
> that previously if the initial attempt at CMA allocation failed, we would
> fall back to attempting smaller sizes with the page allocator.  Now, we
> try first CMA, then the page allocator at each size.  As far as I can tell
> this change should be harmless.
> 
> To match, we make kvmppc_free_hpt() just free the actual HPT itself.  The
> call to kvmppc_free_lpid() that was there, we move to the single caller.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/include/asm/kvm_book3s_64.h |  3 ++
>  arch/powerpc/include/asm/kvm_ppc.h       |  5 +-
>  arch/powerpc/kvm/book3s_64_mmu_hv.c      | 90 ++++++++++++++++----------------
>  arch/powerpc/kvm/book3s_hv.c             | 18 +++++--
>  4 files changed, 65 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
> index 8810327..6dc4004 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -22,6 +22,9 @@
>  
>  #include <asm/book3s/64/mmu-hash.h>
>  
> +/* Power architecture requires HPT is at least 256kB */
> +#define PPC_MIN_HPT_ORDER	18
> +
>  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
>  static inline struct kvmppc_book3s_shadow_vcpu *svcpu_get(struct kvm_vcpu *vcpu)
>  {
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 3db6be9..41575b8 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -155,9 +155,10 @@ extern void kvmppc_core_destroy_mmu(struct kvm_vcpu *vcpu);
>  extern int kvmppc_kvm_pv(struct kvm_vcpu *vcpu);
>  extern void kvmppc_map_magic(struct kvm_vcpu *vcpu);
>  
> -extern long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp);
> +extern int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order);
> +extern void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info);
>  extern long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp);
> -extern void kvmppc_free_hpt(struct kvm *kvm);
> +extern void kvmppc_free_hpt(struct kvm_hpt_info *info);
>  extern long kvmppc_prepare_vrma(struct kvm *kvm,
>  				struct kvm_userspace_memory_region *mem);
>  extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index fe88132..68bb228 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -40,76 +40,70 @@
>  
>  #include "trace_hv.h"
>  
> -/* Power architecture requires HPT is at least 256kB */
> -#define PPC_MIN_HPT_ORDER	18
> -
>  static long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
>  				long pte_index, unsigned long pteh,
>  				unsigned long ptel, unsigned long *pte_idx_ret);
>  static void kvmppc_rmap_reset(struct kvm *kvm);
>  
> -long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
> +int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order)
>  {
>  	unsigned long hpt = 0;
> -	struct revmap_entry *rev;
> +	int cma = 0;
>  	struct page *page = NULL;
> -	long order = KVM_DEFAULT_HPT_ORDER;
> -
> -	if (htab_orderp) {
> -		order = *htab_orderp;
> -		if (order < PPC_MIN_HPT_ORDER)
> -			order = PPC_MIN_HPT_ORDER;
> -	}

Not sure, but as far as I can see, *htab_orderp could still be provided
from userspace via kvm_arch_vm_ioctl_hv() -> kvmppc_alloc_reset_hpt() ?
In that case, I think you should still check that the order is bigger
than PPC_MIN_HPT_ORDER, and return an error code otherwise?
Or if you feel confident that this value can never be supplied by
userspace anymore, add at least a BUG_ON(order < PPC_MIN_HPT_ORDER) here?

> +	struct revmap_entry *rev;
> +	unsigned long npte;
>  
> -	kvm->arch.hpt.cma = 0;
> +	hpt = 0;
> +	cma = 0;

Both hpt and cma are initialized to zero in the variable declarations
already, so the above two lines are redundant.

>  	page = kvm_alloc_hpt_cma(1ul << (order - PAGE_SHIFT));
>  	if (page) {
>  		hpt = (unsigned long)pfn_to_kaddr(page_to_pfn(page));
>  		memset((void *)hpt, 0, (1ul << order));
> -		kvm->arch.hpt.cma = 1;
> +		cma = 1;
>  	}
>  
> -	/* Lastly try successively smaller sizes from the page allocator */
> -	/* Only do this if userspace didn't specify a size via ioctl */
> -	while (!hpt && order > PPC_MIN_HPT_ORDER && !htab_orderp) {
> -		hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|
> -				       __GFP_NOWARN, order - PAGE_SHIFT);
> -		if (!hpt)
> -			--order;
> -	}
> +	if (!hpt)
> +		hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT
> +				       |__GFP_NOWARN, order - PAGE_SHIFT);
>  
>  	if (!hpt)
>  		return -ENOMEM;
>  
> -	kvm->arch.hpt.virt = hpt;
> -	kvm->arch.hpt.order = order;
> -
> -	atomic64_set(&kvm->arch.mmio_update, 0);
> +	/* HPTEs are 2**4 bytes long */
> +	npte = 1ul << (order - 4);
>  
>  	/* Allocate reverse map array */
> -	rev = vmalloc(sizeof(struct revmap_entry) * kvmppc_hpt_npte(&kvm->arch.hpt));
> +	rev = vmalloc(sizeof(struct revmap_entry) * npte);
>  	if (!rev) {
> -		pr_err("kvmppc_alloc_hpt: Couldn't alloc reverse map array\n");
> +		pr_err("kvmppc_allocate_hpt: Couldn't alloc reverse map array\n");
>  		goto out_freehpt;

So here you jump to out_freehpt before setting info->virt ...

>  	}
> -	kvm->arch.hpt.rev = rev;
> -	kvm->arch.sdr1 = __pa(hpt) | (order - 18);
>  
> -	pr_info("KVM guest htab at %lx (order %ld), LPID %x\n",
> -		hpt, order, kvm->arch.lpid);
> +	info->order = order;
> +	info->virt = hpt;
> +	info->cma = cma;
> +	info->rev = rev;
>  
> -	if (htab_orderp)
> -		*htab_orderp = order;
>  	return 0;
>  
>   out_freehpt:
> -	if (kvm->arch.hpt.cma)
> +	if (cma)
>  		kvm_free_hpt_cma(page, 1 << (order - PAGE_SHIFT));
>  	else
> -		free_pages(hpt, order - PAGE_SHIFT);
> +		free_pages(info->virt, order - PAGE_SHIFT);

... but here you free info->virt which has not been set in case of the
"goto" above. That's clearly wrong.

>  	return -ENOMEM;
>  }
>  
> +void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info)
> +{
> +	atomic64_set(&kvm->arch.mmio_update, 0);
> +	kvm->arch.hpt = *info;
> +	kvm->arch.sdr1 = __pa(info->virt) | (info->order - 18);
> +
> +	pr_info("KVM guest htab at %lx (order %ld), LPID %x\n",
> +		info->virt, (long)info->order, kvm->arch.lpid);

Not directly related to your patch, but these messages pop up in the
dmesg each time I start a guest ... for the normal user who does not
have a clue what "htab" means, this can be pretty much annoying. Could
you maybe turn this into a pr_debug() instead?

> +}
> +
>  long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
>  {
>  	long err = -EBUSY;
> @@ -138,24 +132,28 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
>  		*htab_orderp = order;
>  		err = 0;
>  	} else {
> -		err = kvmppc_alloc_hpt(kvm, htab_orderp);
> -		order = *htab_orderp;
> +		struct kvm_hpt_info info;
> +
> +		err = kvmppc_allocate_hpt(&info, *htab_orderp);
> +		if (err < 0)
> +			goto out;
> +		kvmppc_set_hpt(kvm, &info);

Just a matter of taste (I dislike gotos if avoidable), but you could
also do:

	err = kvmppc_allocate_hpt(&info, *htab_orderp);
	if (!err)
		kvmppc_set_hpt(kvm, &info);

... and that's even one line shorter ;-)

>  	}
>   out:
>  	mutex_unlock(&kvm->lock);
>  	return err;
>  }
>  
> -void kvmppc_free_hpt(struct kvm *kvm)
> +void kvmppc_free_hpt(struct kvm_hpt_info *info)
>  {
> -	kvmppc_free_lpid(kvm->arch.lpid);
> -	vfree(kvm->arch.hpt.rev);
> -	if (kvm->arch.hpt.cma)
> -		kvm_free_hpt_cma(virt_to_page(kvm->arch.hpt.virt),
> -				 1 << (kvm->arch.hpt.order - PAGE_SHIFT));
> +	vfree(info->rev);
> +	if (info->cma)
> +		kvm_free_hpt_cma(virt_to_page(info->virt),
> +				 1 << (info->order - PAGE_SHIFT));
>  	else
> -		free_pages(kvm->arch.hpt.virt,
> -			   kvm->arch.hpt.order - PAGE_SHIFT);
> +		free_pages(info->virt, info->order - PAGE_SHIFT);
> +	info->virt = 0;
> +	info->order = 0;
>  }
>  
>  /* Bits in first HPTE dword for pagesize 4k, 64k or 16M */
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 78baa2b..71c5adb 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3115,11 +3115,22 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
>  
>  	/* Allocate hashed page table (if not done already) and reset it */
>  	if (!kvm->arch.hpt.virt) {
> -		err = kvmppc_alloc_hpt(kvm, NULL);
> -		if (err) {
> +		int order = KVM_DEFAULT_HPT_ORDER;
> +		struct kvm_hpt_info info;
> +
> +		err = kvmppc_allocate_hpt(&info, order);
> +		/* If we get here, it means userspace didn't specify a
> +		 * size explicitly.  So, try successively smaller
> +		 * sizes if the default failed. */
> +		while (err < 0 && --order >= PPC_MIN_HPT_ORDER)
> +			err  = kvmppc_allocate_hpt(&info, order);

Not sure, but maybe replace "err < 0" with "err == -ENOMEM" in the while
condition? Or should it also loop on other future possible errors types?

> +		if (err < 0) {
>  			pr_err("KVM: Couldn't alloc HPT\n");
>  			goto out;
>  		}
> +
> +		kvmppc_set_hpt(kvm, &info);
>  	}
>  
>  	/* Look up the memslot for guest physical address 0 */
> @@ -3357,7 +3368,8 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
>  
>  	kvmppc_free_vcores(kvm);
>  
> -	kvmppc_free_hpt(kvm);
> +	kvmppc_free_lpid(kvm->arch.lpid);
> +	kvmppc_free_hpt(&kvm->arch.hpt);
>  
>  	kvmppc_free_pimap(kvm);
>  }
> 

 Thomas

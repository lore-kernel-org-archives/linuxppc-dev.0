Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg49p17ZxzDwBC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 20:03:58 +1100 (AEDT)
Subject: Re: [PATCH 02/11] powerpc/kvm: Rename kvm_alloc_hpt() for clarity
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-3-david@gibson.dropbear.id.au>
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d1cc8dd3-4d17-7d9f-6df6-803ee530b1c8@redhat.com>
Date: Fri, 16 Dec 2016 10:03:50 +0100
MIME-Version: 1.0
In-Reply-To: <20161215055404.29351-3-david@gibson.dropbear.id.au>
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
> The difference between kvm_alloc_hpt() and kvmppc_alloc_hpt() is not at
> all obvious from the name.  In practice kvmppc_alloc_hpt() allocates an HPT
> by whatever means, and calls kvm_alloc_hpt() which will attempt to allocate
> it with CMA only.
> 
> To make this less confusing, rename kvm_alloc_hpt() to kvm_alloc_hpt_cma().
> Similarly, kvm_release_hpt() is renamed kvm_free_hpt_cma().
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/include/asm/kvm_ppc.h   | 4 ++--
>  arch/powerpc/kvm/book3s_64_mmu_hv.c  | 8 ++++----
>  arch/powerpc/kvm/book3s_hv_builtin.c | 8 ++++----
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 2da67bf..3db6be9 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -186,8 +186,8 @@ extern long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>  		unsigned long tce_value, unsigned long npages);
>  extern long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  			     unsigned long ioba);
> -extern struct page *kvm_alloc_hpt(unsigned long nr_pages);
> -extern void kvm_release_hpt(struct page *page, unsigned long nr_pages);
> +extern struct page *kvm_alloc_hpt_cma(unsigned long nr_pages);
> +extern void kvm_free_hpt_cma(struct page *page, unsigned long nr_pages);
>  extern int kvmppc_core_init_vm(struct kvm *kvm);
>  extern void kvmppc_core_destroy_vm(struct kvm *kvm);
>  extern void kvmppc_core_free_memslot(struct kvm *kvm,
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index b795dd1..ae17cdd 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -62,7 +62,7 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
>  	}
>  
>  	kvm->arch.hpt_cma_alloc = 0;
> -	page = kvm_alloc_hpt(1ul << (order - PAGE_SHIFT));
> +	page = kvm_alloc_hpt_cma(1ul << (order - PAGE_SHIFT));
>  	if (page) {
>  		hpt = (unsigned long)pfn_to_kaddr(page_to_pfn(page));
>  		memset((void *)hpt, 0, (1ul << order));
> @@ -108,7 +108,7 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
>  
>   out_freehpt:
>  	if (kvm->arch.hpt_cma_alloc)
> -		kvm_release_hpt(page, 1 << (order - PAGE_SHIFT));
> +		kvm_free_hpt_cma(page, 1 << (order - PAGE_SHIFT));
>  	else
>  		free_pages(hpt, order - PAGE_SHIFT);
>  	return -ENOMEM;
> @@ -155,8 +155,8 @@ void kvmppc_free_hpt(struct kvm *kvm)
>  	kvmppc_free_lpid(kvm->arch.lpid);
>  	vfree(kvm->arch.revmap);
>  	if (kvm->arch.hpt_cma_alloc)
> -		kvm_release_hpt(virt_to_page(kvm->arch.hpt_virt),
> -				1 << (kvm->arch.hpt_order - PAGE_SHIFT));
> +		kvm_free_hpt_cma(virt_to_page(kvm->arch.hpt_virt),
> +				 1 << (kvm->arch.hpt_order - PAGE_SHIFT));
>  	else
>  		free_pages(kvm->arch.hpt_virt,
>  			   kvm->arch.hpt_order - PAGE_SHIFT);
> diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
> index 5bb24be..4c4aa47 100644
> --- a/arch/powerpc/kvm/book3s_hv_builtin.c
> +++ b/arch/powerpc/kvm/book3s_hv_builtin.c
> @@ -52,19 +52,19 @@ static int __init early_parse_kvm_cma_resv(char *p)
>  }
>  early_param("kvm_cma_resv_ratio", early_parse_kvm_cma_resv);
>  
> -struct page *kvm_alloc_hpt(unsigned long nr_pages)
> +struct page *kvm_alloc_hpt_cma(unsigned long nr_pages)
>  {
>  	VM_BUG_ON(order_base_2(nr_pages) < KVM_CMA_CHUNK_ORDER - PAGE_SHIFT);
>  
>  	return cma_alloc(kvm_cma, nr_pages, order_base_2(HPT_ALIGN_PAGES));
>  }
> -EXPORT_SYMBOL_GPL(kvm_alloc_hpt);
> +EXPORT_SYMBOL_GPL(kvm_alloc_hpt_cma);
>  
> -void kvm_release_hpt(struct page *page, unsigned long nr_pages)
> +void kvm_free_hpt_cma(struct page *page, unsigned long nr_pages)
>  {
>  	cma_release(kvm_cma, page, nr_pages);
>  }
> -EXPORT_SYMBOL_GPL(kvm_release_hpt);
> +EXPORT_SYMBOL_GPL(kvm_free_hpt_cma);
>  
>  /**
>   * kvm_cma_reserve() - reserve area for kvm hash pagetable

Reviewed-by: Thomas Huth <thuth@redhat.com>

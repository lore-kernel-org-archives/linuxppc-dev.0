Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B48BC140314
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 21:26:19 +1000 (EST)
Message-ID: <53677558.50900@suse.de>
Date: Mon, 05 May 2014 13:26:16 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: Don't try to allocate from kernel
 page allocator for hash page table.
References: <1399224322-22028-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1399224322-22028-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2014 07:25 PM, Aneesh Kumar K.V wrote:
> We reserve 5% of total ram for CMA allocation and not using that can
> result in us running out of numa node memory with specific
> configuration. One caveat is we may not have node local hpt with pinned
> vcpu configuration. But currently libvirt also pins the vcpu to cpuset
> after creating hash page table.

I don't understand the problem. Can you please elaborate?


Alex

>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kvm/book3s_64_mmu_hv.c | 23 ++++++-----------------
>   1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index fb25ebc0af0c..f32896ffd784 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -52,7 +52,7 @@ static void kvmppc_rmap_reset(struct kvm *kvm);
>   
>   long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
>   {
> -	unsigned long hpt;
> +	unsigned long hpt = 0;
>   	struct revmap_entry *rev;
>   	struct page *page = NULL;
>   	long order = KVM_DEFAULT_HPT_ORDER;
> @@ -64,22 +64,11 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
>   	}
>   
>   	kvm->arch.hpt_cma_alloc = 0;
> -	/*
> -	 * try first to allocate it from the kernel page allocator.
> -	 * We keep the CMA reserved for failed allocation.
> -	 */
> -	hpt = __get_free_pages(GFP_KERNEL | __GFP_ZERO | __GFP_REPEAT |
> -			       __GFP_NOWARN, order - PAGE_SHIFT);
> -
> -	/* Next try to allocate from the preallocated pool */
> -	if (!hpt) {
> -		VM_BUG_ON(order < KVM_CMA_CHUNK_ORDER);
> -		page = kvm_alloc_hpt(1 << (order - PAGE_SHIFT));
> -		if (page) {
> -			hpt = (unsigned long)pfn_to_kaddr(page_to_pfn(page));
> -			kvm->arch.hpt_cma_alloc = 1;
> -		} else
> -			--order;
> +	VM_BUG_ON(order < KVM_CMA_CHUNK_ORDER);
> +	page = kvm_alloc_hpt(1 << (order - PAGE_SHIFT));
> +	if (page) {
> +		hpt = (unsigned long)pfn_to_kaddr(page_to_pfn(page));
> +		kvm->arch.hpt_cma_alloc = 1;
>   	}
>   
>   	/* Lastly try successively smaller sizes from the page allocator */

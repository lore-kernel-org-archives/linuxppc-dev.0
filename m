Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg6J4647SzDwDm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 21:39:32 +1100 (AEDT)
Subject: Re: [PATCH 04/11] powerpc/kvm: Don't store values derivable from HPT
 order
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-5-david@gibson.dropbear.id.au>
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <db1ccf7b-7355-e0d4-ac36-26cc9c833105@redhat.com>
Date: Fri, 16 Dec 2016 11:39:26 +0100
MIME-Version: 1.0
In-Reply-To: <20161215055404.29351-5-david@gibson.dropbear.id.au>
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
> Currently the kvm_hpt_info structure stores the hashed page table's order,
> and also the number of HPTEs it contains and a mask for its size.  The
> last two can be easily derived from the order, so remove them and just
> calculate them as necessary with a couple of helper inlines.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
[...]
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index b5799d1..fe88132 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -83,15 +83,11 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
>  
>  	kvm->arch.hpt.virt = hpt;
>  	kvm->arch.hpt.order = order;
> -	/* HPTEs are 2**4 bytes long */
> -	kvm->arch.hpt.npte = 1ul << (order - 4);
> -	/* 128 (2**7) bytes in each HPTEG */
> -	kvm->arch.hpt.mask = (1ul << (order - 7)) - 1;
>  
>  	atomic64_set(&kvm->arch.mmio_update, 0);
>  
>  	/* Allocate reverse map array */
> -	rev = vmalloc(sizeof(struct revmap_entry) * kvm->arch.hpt.npte);
> +	rev = vmalloc(sizeof(struct revmap_entry) * kvmppc_hpt_npte(&kvm->arch.hpt));
>  	if (!rev) {
>  		pr_err("kvmppc_alloc_hpt: Couldn't alloc reverse map array\n");
>  		goto out_freehpt;
> @@ -194,8 +190,8 @@ void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
>  	if (npages > 1ul << (40 - porder))
>  		npages = 1ul << (40 - porder);
>  	/* Can't use more than 1 HPTE per HPTEG */
> -	if (npages > kvm->arch.hpt.mask + 1)
> -		npages = kvm->arch.hpt.mask + 1;
> +	if (npages > kvmppc_hpt_mask(&kvm->arch.hpt) + 1)
> +		npages = kvmppc_hpt_mask(&kvm->arch.hpt) + 1;
>  
>  	hp0 = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
>  		HPTE_V_BOLTED | hpte0_pgsize_encoding(psize);
> @@ -205,7 +201,8 @@ void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
>  	for (i = 0; i < npages; ++i) {
>  		addr = i << porder;
>  		/* can't use hpt_hash since va > 64 bits */
> -		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & kvm->arch.hpt.mask;
> +		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25)))
> +			& kvmppc_hpt_mask(&kvm->arch.hpt);
>  		/*
>  		 * We assume that the hash table is empty and no
>  		 * vcpus are using it at this stage.  Since we create

kvmppc_hpt_mask() is now called three times in kvmppc_map_vrma() ... you
could use a local variable to store the value so that the calculation
has only be done once here.

> @@ -1306,7 +1303,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
>  
>  		/* Skip uninteresting entries, i.e. clean on not-first pass */
>  		if (!first_pass) {
> -			while (i < kvm->arch.hpt.npte &&
> +			while (i < kvmppc_hpt_npte(&kvm->arch.hpt) &&
>  			       !hpte_dirty(revp, hptp)) {
>  				++i;
>  				hptp += 2;
> @@ -1316,7 +1313,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
>  		hdr.index = i;
>  
>  		/* Grab a series of valid entries */
> -		while (i < kvm->arch.hpt.npte &&
> +		while (i < kvmppc_hpt_npte(&kvm->arch.hpt) &&
>  		       hdr.n_valid < 0xffff &&
>  		       nb + HPTE_SIZE < count &&
>  		       record_hpte(flags, hptp, hpte, revp, 1, first_pass)) {
> @@ -1332,7 +1329,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
>  			++revp;
>  		}
>  		/* Now skip invalid entries while we can */
> -		while (i < kvm->arch.hpt.npte &&
> +		while (i < kvmppc_hpt_npte(&kvm->arch.hpt) &&
>  		       hdr.n_invalid < 0xffff &&
>  		       record_hpte(flags, hptp, hpte, revp, 0, first_pass)) {
>  			/* found an invalid entry */

Dito, you could use a local variable to store the value from
kvmppc_hpt_npte()

Anyway, apart from these nits, patch looks fine to me, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>

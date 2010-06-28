Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id BC242B6F1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 18:28:15 +1000 (EST)
Message-ID: <4C285D1C.5060508@redhat.com>
Date: Mon, 28 Jun 2010 11:28:12 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: Add generic hpte management functions
References: <1277507817-626-1-git-send-email-agraf@suse.de>
	<1277507817-626-2-git-send-email-agraf@suse.de>
In-Reply-To: <1277507817-626-2-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2010 02:16 AM, Alexander Graf wrote:
> Currently the shadow paging code keeps an array of entries it knows about.
> Whenever the guest invalidates an entry, we loop through that entry,
> trying to invalidate matching parts.
>
> While this is a really simple implementation, it is probably the most
> ineffective one possible. So instead, let's keep an array of lists around
> that are indexed by a hash. This way each PTE can be added by 4 list_add,
> removed by 4 list_del invocations and the search only needs to loop through
> entries that share the same hash.
>
> This patch implements said lookup and exports generic functions that both
> the 32-bit and 64-bit backend can use.
>
>
> +
> +static inline u64 kvmppc_mmu_hash_pte(u64 eaddr) {
> +	return hash_64(eaddr>>  PTE_SIZE, HPTEG_HASH_BITS_PTE);
> +}
> +
> +static inline u64 kvmppc_mmu_hash_vpte(u64 vpage) {
> +	return hash_64(vpage&  0xfffffffffULL, HPTEG_HASH_BITS_VPTE);
> +}
> +
> +static inline u64 kvmppc_mmu_hash_vpte_long(u64 vpage) {
> +	return hash_64((vpage&  0xffffff000ULL)>>  12,
> +		       HPTEG_HASH_BITS_VPTE_LONG);
> +}
>    

Still with the wierd coding style?

> +static void kvmppc_mmu_pte_flush_all(struct kvm_vcpu *vcpu)
> +{
> +	struct hpte_cache *pte, *tmp;
> +	int i;
> +
> +	for (i = 0; i<  HPTEG_HASH_NUM_VPTE_LONG; i++) {
> +		struct list_head *list =&vcpu->arch.hpte_hash_vpte_long[i];
> +
> +		list_for_each_entry_safe(pte, tmp, list, list_vpte_long) {
> +			/* Jump over the helper entry */
> +			if (&pte->list_vpte_long == list)
> +				continue;
>    

I don't think l_f_e_e_s() will ever give you the head back.

> +
> +			invalidate_pte(vcpu, pte);
> +		}
>    

Does invalidate_pte() remove the pte?  doesn't seem so, so you can drop 
the _safe iteration.

> +	}
> +}
> +
> +void kvmppc_mmu_pte_flush(struct kvm_vcpu *vcpu, ulong guest_ea, ulong ea_mask)
> +{
> +	u64 i;
> +
> +	dprintk_mmu("KVM: Flushing %d Shadow PTEs: 0x%lx&  0x%lx\n",
> +		    vcpu->arch.hpte_cache_count, guest_ea, ea_mask);
> +
> +	guest_ea&= ea_mask;
> +
> +	switch (ea_mask) {
> +	case ~0xfffUL:
> +	{
> +		struct list_head *list;
> +		struct hpte_cache *pte, *tmp;
> +
> +		/* Find the list of entries in the map */
> +		list =&vcpu->arch.hpte_hash_pte[kvmppc_mmu_hash_pte(guest_ea)];
> +
> +		/* Check the list for matching entries */
> +		list_for_each_entry_safe(pte, tmp, list, list_pte) {
> +			/* Jump over the helper entry */
> +			if (&pte->list_pte == list)
> +				continue;
>    

Same here.

> +
> +			/* Invalidate matching PTE */
> +			if ((pte->pte.eaddr&  ~0xfffUL) == guest_ea)
> +				invalidate_pte(vcpu, pte);
> +		}
> +		break;
> +	}
>    

Would be nice to put this block into a function.

> +	case 0x0ffff000:
> +		/* 32-bit flush w/o segment, go through all possible segments */
> +		for (i = 0; i<  0x100000000ULL; i += 0x10000000ULL)
> +			kvmppc_mmu_pte_flush(vcpu, guest_ea | i, ~0xfffUL);
> +		break;
> +	case 0:
> +		/* Doing a complete flush ->  start from scratch */
> +		kvmppc_mmu_pte_flush_all(vcpu);
> +		break;
> +	default:
> +		WARN_ON(1);
> +		break;
> +	}
> +}
> +
> +/* Flush with mask 0xfffffffff */
> +static void kvmppc_mmu_pte_vflush_short(struct kvm_vcpu *vcpu, u64 guest_vp)
> +{
> +	struct list_head *list;
> +	struct hpte_cache *pte, *tmp;
> +	u64 vp_mask = 0xfffffffffULL;
> +
> +	list =&vcpu->arch.hpte_hash_vpte[kvmppc_mmu_hash_vpte(guest_vp)];
> +
> +	/* Check the list for matching entries */
> +	list_for_each_entry_safe(pte, tmp, list, list_vpte) {
> +		/* Jump over the helper entry */
> +		if (&pte->list_vpte == list)
> +			continue;
>    

list cannot contain list.  Or maybe I don't understand the data 
structure.  Isn't it multiple hash tables with lists holding matching ptes?

> +
> +		/* Invalidate matching PTEs */
> +		if ((pte->pte.vpage&  vp_mask) == guest_vp)
> +			invalidate_pte(vcpu, pte);
> +	}
> +}
> +
>
> +
> +void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, ulong pa_end)
> +{
> +	struct hpte_cache *pte, *tmp;
> +	int i;
> +
> +	dprintk_mmu("KVM: Flushing %d Shadow pPTEs: 0x%lx - 0x%lx\n",
> +		    vcpu->arch.hpte_cache_count, pa_start, pa_end);
> +
> +	for (i = 0; i<  HPTEG_HASH_NUM_VPTE_LONG; i++) {
> +		struct list_head *list =&vcpu->arch.hpte_hash_vpte_long[i];
> +
> +		list_for_each_entry_safe(pte, tmp, list, list_vpte_long) {
> +			/* Jump over the helper entry */
> +			if (&pte->list_vpte_long == list)
> +				continue;
> +
> +			if ((pte->pte.raddr>= pa_start)&&
> +			    (pte->pte.raddr<  pa_end)) {
> +				invalidate_pte(vcpu, pte);
> +			}
>    

Extra braces.

> +		}
> +	}
> +}
> +
>
> +
> +static void kvmppc_mmu_hpte_init_hash(struct list_head *hash_list, int len)
> +{
> +	int i;
> +
> +	for (i = 0; i<  len; i++) {
> +		INIT_LIST_HEAD(&hash_list[i]);
> +	}
> +}
>    

Extra braces.

> +
> +int kvmppc_mmu_hpte_init(struct kvm_vcpu *vcpu)
> +{
> +	char kmem_name[128];
> +
> +	/* init hpte slab cache */
> +	snprintf(kmem_name, 128, "kvm-spt-%p", vcpu);
> +	vcpu->arch.hpte_cache = kmem_cache_create(kmem_name,
> +		sizeof(struct hpte_cache), sizeof(struct hpte_cache), 0, NULL);
>    

Why not one global cache?

> +
> +	/* init hpte lookup hashes */
> +	kvmppc_mmu_hpte_init_hash(vcpu->arch.hpte_hash_pte,
> +				  ARRAY_SIZE(vcpu->arch.hpte_hash_pte));
> +	kvmppc_mmu_hpte_init_hash(vcpu->arch.hpte_hash_vpte,
> +				  ARRAY_SIZE(vcpu->arch.hpte_hash_vpte));
> +	kvmppc_mmu_hpte_init_hash(vcpu->arch.hpte_hash_vpte_long,
> +				  ARRAY_SIZE(vcpu->arch.hpte_hash_vpte_long));
> +
> +	return 0;
> +}
>    


-- 
error compiling committee.c: too many arguments to function

Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 60267B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 22:02:26 +1000 (EST)
Message-ID: <4C20A64D.2070805@redhat.com>
Date: Tue, 22 Jun 2010 15:02:21 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/2] KVM: PPC: Add generic hpte management functions
References: <1277127841-32704-1-git-send-email-agraf@suse.de>
In-Reply-To: <1277127841-32704-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/21/2010 04:44 PM, Alexander Graf wrote:
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

Mind explaining the all list in there?

>
> +
> +static inline u64 kvmppc_mmu_hash_pte(u64 eaddr) {
> +	return hash_64(eaddr>>  PTE_SIZE, HPTEG_HASH_BITS);
> +}
> +
> +static inline u64 kvmppc_mmu_hash_vpte(u64 vpage) {
> +	return hash_64(vpage&  0xfffffffffULL, HPTEG_HASH_BITS);
> +}
> +
> +static inline u64 kvmppc_mmu_hash_vpte_long(u64 vpage) {
> +	return hash_64((vpage&  0xffffff000ULL)>>  12, HPTEG_HASH_BITS);
> +}
>    

Please use ordinary formatting for the functions above.

> +/* Flush with mask 0xffffff000 */
> +static void kvmppc_mmu_pte_vflush_long(struct kvm_vcpu *vcpu, u64 guest_vp)
> +{
> +	struct list_head *list;
> +	struct hpte_cache *pte, *tmp;
> +	u64 vp_mask = 0xffffff000ULL;
> +
> +	list =&vcpu->arch.hpte_hash_vpte_long[kvmppc_mmu_hash_vpte_long(guest_vp)];
> +
> +	/* No entries to flush */
> +	if (!list)
> +		return;
> +
> +	/* Check the list for matching entries */
> +	list_for_each_entry_safe(pte, tmp, list, list_vpte_long)
> +		/* Jump over the helper entry */
> +		if (&pte->list_vpte_long == list)
> +			continue;
> +
> +		if ((pte->pte.vpage&  vp_mask) == guest_vp)
> +			invalidate_pte(vcpu, pte);
> +}
>    

C wants brackets around blocks.

-- 
error compiling committee.c: too many arguments to function

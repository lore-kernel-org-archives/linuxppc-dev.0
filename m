Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHZ7w0ZW2zDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 14:25:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: Re: [PATCH 3/7] powerpc: Free up four 64K PTE bits in 4K backed HPTE
 pages
In-Reply-To: <1504910713-7094-4-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-4-git-send-email-linuxram@us.ibm.com>
Date: Thu, 19 Oct 2017 14:25:47 +1100
Message-ID: <87o9p3kedg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> index 1a68cb1..c6c5559 100644
> --- a/arch/powerpc/mm/hash64_64k.c
> +++ b/arch/powerpc/mm/hash64_64k.c
> @@ -126,18 +113,13 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  	if (__rpte_sub_valid(rpte, subpg_index)) {
>  		int ret;
>  
> -		hash = hpt_hash(vpn, shift, ssize);
> -		hidx = __rpte_to_hidx(rpte, subpg_index);
> -		if (hidx & _PTEIDX_SECONDARY)
> -			hash = ~hash;
> -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> -		slot += hidx & _PTEIDX_GROUP_IX;
> +		gslot = pte_get_hash_gslot(vpn, shift, ssize, rpte,
> +					subpg_index);
> +		ret = mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn,
> +			MMU_PAGE_4K, MMU_PAGE_4K, ssize, flags);

This was formatted correctly before:
  
> -		ret = mmu_hash_ops.hpte_updatepp(slot, rflags, vpn,
> -						 MMU_PAGE_4K, MMU_PAGE_4K,
> -						 ssize, flags);
>  		/*
> -		 *if we failed because typically the HPTE wasn't really here
> +		 * if we failed because typically the HPTE wasn't really here

If you're fixing it up please make it "If ...".

>  		 * we try an insertion.
>  		 */
>  		if (ret == -1)
> @@ -148,6 +130,15 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  	}
>  
>  htab_insert_hpte:
> +
> +	/*
> +	 * initialize all hidx entries to invalid value,
> +	 * the first time the PTE is about to allocate
> +	 * a 4K hpte
> +	 */

Should be:
	/*
	 * Initialize all hidx entries to invalid value, the first time
         * the PTE is about to allocate a 4K HPTE.
	 */

> +	if (!(old_pte & H_PAGE_COMBO))
> +		rpte.hidx = ~0x0UL;
> +

Paul had the idea that if we biased the slot number by 1, we could make
the "invalid" value be == 0.

That would avoid needing to that above, and also mean the value is
correctly invalid from the get-go, which would be good IMO.

I think now that you've added the slot accessors it would be pretty easy
to do.


>  	/*
>  	 * handle H_PAGE_4K_PFN case
>  	 */
> @@ -172,15 +163,41 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  	 * Primary is full, try the secondary
>  	 */
>  	if (unlikely(slot == -1)) {
> +		bool soft_invalid;
> +
>  		hpte_group = ((~hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
>  		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa,
>  						rflags, HPTE_V_SECONDARY,
>  						MMU_PAGE_4K, MMU_PAGE_4K,
>  						ssize);
> -		if (slot == -1) {
> -			if (mftb() & 0x1)
> +
> +		soft_invalid = hpte_soft_invalid(slot);
> +		if (unlikely(soft_invalid)) {


> +			/*
> +			 * we got a valid slot from a hardware point of view.
> +			 * but we cannot use it, because we use this special
> +			 * value; as     defined   by    hpte_soft_invalid(),
> +			 * to  track    invalid  slots.  We  cannot  use  it.
> +			 * So invalidate it.
> +			 */
> +			gslot = slot & _PTEIDX_GROUP_IX;
> +			mmu_hash_ops.hpte_invalidate(hpte_group+gslot, vpn,
> +				MMU_PAGE_4K, MMU_PAGE_4K,
> +				ssize, 0);

Please:
			mmu_hash_ops.hpte_invalidate(hpte_group+gslot, vpn,
                        			     MMU_PAGE_4K, MMU_PAGE_4K,
						     ssize, 0);

> +		}
> +
> +		if (unlikely(slot == -1 || soft_invalid)) {
> +			/*
> +			 * for soft invalid slot, lets   ensure that we

For .. let's


cheers

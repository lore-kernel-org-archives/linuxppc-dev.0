Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26B531A0514
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 17:49:29 +1100 (AEDT)
Date: Tue, 23 Feb 2016 16:38:47 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 03/18] powerpc/mm: add _PAGE_HASHPTE similar to 4K hash
Message-ID: <20160223053847.GA14286@fergus.ozlabs.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456202900-5454-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456202900-5454-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 23, 2016 at 10:18:05AM +0530, Aneesh Kumar K.V wrote:
> The difference between 64K and 4K hash fault handling is confusing
> with respect to when we set _PAGE_HASHPTE in the linux pte.
> I was trying to find out whether we miss a hpte flush in any
> scenario because of this. ie, a pte update on a linux pte, for which we
> are doing a parallel hash pte insert. After looking at it closer my
> understanding is this won't happen because pte update also look at
> _PAGE_BUSY and we will wait for hash pte insert to finish before going
> ahead with the pte update. But to avoid further confusion keep the
> hash fault handler for all the page size similar to  __hash_page_4k.
> 
> This partially reverts commit 41743a4e34f0 ("powerpc: Free a PTE bit on ppc64 with 64K pages"

In each of the functions you are modifying below, there is already an
explicit setting of _PAGE_HASHPTE in new_pte.  So I don't think this
is necessary, or if we do this, we can eliminate the separate setting
of _PAGE_HASHPTE later on.

In general I think it's better to leave the setting of _PAGE_HASHPTE
until we know what slot the HPTE is going to go into.  That way we
have less chance of ending up with _PAGE_HASHPTE set but bogus
information in _PAGE_F_GIX and _PAGE_F_SECOND.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash64_64k.c         | 4 ++--
>  arch/powerpc/mm/hugepage-hash64.c    | 2 +-
>  arch/powerpc/mm/hugetlbpage-hash64.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> index b2d659cf51c6..507c1e55a424 100644
> --- a/arch/powerpc/mm/hash64_64k.c
> +++ b/arch/powerpc/mm/hash64_64k.c
> @@ -76,7 +76,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  		 * a write access. Since this is 4K insert of 64K page size
>  		 * also add _PAGE_COMBO
>  		 */
> -		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_COMBO;
> +		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_COMBO | _PAGE_HASHPTE;
>  		if (access & _PAGE_RW)
>  			new_pte |= _PAGE_DIRTY;
>  	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,

Later on in the same function:

	/*
	 * Insert slot number & secondary bit in PTE second half,
	 * clear _PAGE_BUSY and set appropriate HPTE slot bit
	 * Since we have _PAGE_BUSY set on ptep, we can be sure
	 * nobody is undating hidx.
	 */
	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
	new_pte = mark_subptegroup_valid(new_pte, subpg_index);
	new_pte |=  _PAGE_HASHPTE;

> @@ -251,7 +251,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
>  		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
>  		 * a write access.
>  		 */
> -		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
> +		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE;
>  		if (access & _PAGE_RW)
>  			new_pte |= _PAGE_DIRTY;
>  	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,

later on:

		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
		new_pte |= (slot << _PAGE_F_GIX_SHIFT) & (_PAGE_F_SECOND | _PAGE_F_GIX);

> diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
> index eb2accdd76fd..56d677b7972c 100644
> --- a/arch/powerpc/mm/hugepage-hash64.c
> +++ b/arch/powerpc/mm/hugepage-hash64.c
> @@ -46,7 +46,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
>  		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
>  		 * a write access
>  		 */
> -		new_pmd = old_pmd | _PAGE_BUSY | _PAGE_ACCESSED;
> +		new_pmd = old_pmd | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE;
>  		if (access & _PAGE_RW)
>  			new_pmd |= _PAGE_DIRTY;
>  	} while (old_pmd != __cmpxchg_u64((unsigned long *)pmdp,

later:

		hash = hpt_hash(vpn, shift, ssize);
		/* insert new entry */
		pa = pmd_pfn(__pmd(old_pmd)) << PAGE_SHIFT;
		new_pmd |= _PAGE_HASHPTE;

> diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> index 8555fce902fe..08efcad7cae0 100644
> --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> @@ -54,7 +54,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  			return 1;
>  		/* Try to lock the PTE, add ACCESSED and DIRTY if it was
>  		 * a write access */
> -		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
> +		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE;
>  		if (access & _PAGE_RW)
>  			new_pte |= _PAGE_DIRTY;
>  	} while(old_pte != __cmpxchg_u64((unsigned long *)ptep,

later:

		/* clear HPTE slot informations in new PTE */
		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;

		slot = hpte_insert_repeating(hash, vpn, pa, rflags, 0,
					     mmu_psize, ssize);

...
		new_pte |= (slot << _PAGE_F_GIX_SHIFT) &
			(_PAGE_F_SECOND | _PAGE_F_GIX);

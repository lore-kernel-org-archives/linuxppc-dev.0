Return-Path: <michael@ellerman.id.au>
Date: Mon, 15 Apr 2013 16:32:58 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 1/4] powerpc: Move the setting of rflags out of
 loop in __hash_page_huge
Message-ID: <20130415063258.GE21147@concordia>
References: <1365733021-28912-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1365733021-28912-2-git-send-email-zhong@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365733021-28912-2-git-send-email-zhong@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 12, 2013 at 10:16:57AM +0800, Li Zhong wrote:
> It seems that rflags don't get changed in  the repeating loop, so move
> it out of the loop.

You've also changed the way new_pte is handled on repeat, but I think
that's OK too.

cheers

> diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> index cecad34..edb4129 100644
> --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> @@ -87,10 +87,6 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  
>  		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
>  
> -repeat:
> -		hpte_group = ((hash & htab_hash_mask) *
> -			      HPTES_PER_GROUP) & ~0x7UL;
> -
>  		/* clear HPTE slot informations in new PTE */
>  #ifdef CONFIG_PPC_64K_PAGES
>  		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HPTE_SUB0;

ie. here new_pte was updated on repeat, but now it's not.

> @@ -101,6 +97,10 @@ repeat:
>  		rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
>  				      _PAGE_COHERENT | _PAGE_GUARDED));
>  
> +repeat:
> +		hpte_group = ((hash & htab_hash_mask) *
> +			      HPTES_PER_GROUP) & ~0x7UL;
> +
>  		/* Insert into the hash table, primary slot */
>  		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
>  					  mmu_psize, ssize);

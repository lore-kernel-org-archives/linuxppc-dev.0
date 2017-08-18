Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYhvD0CsQzDrLY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 22:18:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: Re: [PATCH 7/7] powerpc: use helper functions to get and set hash
 slots
In-Reply-To: <1501459876-11357-8-git-send-email-linuxram@us.ibm.com>
References: <1501459876-11357-1-git-send-email-linuxram@us.ibm.com>
 <1501459876-11357-8-git-send-email-linuxram@us.ibm.com>
Date: Fri, 18 Aug 2017 22:18:31 +1000
Message-ID: <87tw15oyqw.fsf@concordia.ellerman.id.au>
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

> replace redundant code in __hash_page_64K(), __hash_page_huge(),
> __hash_page_4K(), __hash_page_4K() and flush_hash_page()   with
> helper functions pte_get_hash_gslot() and   pte_set_hash_slot()

This seems out of order.

At lease some of these are patching or even entirely replacing code you
just added.

> diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> index 5964b6d..e6dcd50 100644
> --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> @@ -112,18 +103,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  			return -1;
>  		}
>  
> -#ifdef CONFIG_PPC_64K_PAGES
> -		/*
> -		 * Insert slot number & secondary bit in PTE second half.
> -		 */
> -		hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> -		rpte.hidx &= ~(0xfUL);
> -		*hidxp = rpte.hidx  | (slot & 0xfUL);
> -		/*
> -		 * check __real_pte for details on matching smp_rmb()
> -		 */
> -		smp_wmb();
> -#endif /* CONFIG_PPC_64K_PAGES */
> +		new_pte |= pte_set_hash_slot(ptep, rpte, 0, slot);
>  	}

Here for example. That entire chunk was just added in patch in 2.

cheers

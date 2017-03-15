Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjlym73DrzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 20:04:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/mm: Refactor page table allocation
In-Reply-To: <20170220021257.26959-1-bsingharora@gmail.com>
References: <20170220021257.26959-1-bsingharora@gmail.com>
Date: Wed, 15 Mar 2017 20:03:56 +1100
Message-ID: <87fuielxmr.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> Introduce a helper pgtable_get_gfp_flags() which

Can we just call it pgtable_gfp_flags() ?

> just returns the current gfp flags. In a future
> patch, we can enable __GFP_ACCOUNT based on the
> calling context.
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgalloc.h | 22 ++++++++++++++++------
>  arch/powerpc/mm/pgtable_64.c                 |  3 ++-

It looks like you've only updated the 64-bit Book3S sites. Can you
please do all of them.

I think this is the full list:

  arch/powerpc/include/asm/book3s/32/pgalloc.h:static inline pgd_t *pgd_alloc(struct mm_struct *mm)
  arch/powerpc/include/asm/book3s/64/pgalloc.h:static inline pgd_t *radix__pgd_alloc(struct mm_struct *mm)
  arch/powerpc/include/asm/book3s/64/pgalloc.h:static inline pgd_t *pgd_alloc(struct mm_struct *mm)
  arch/powerpc/include/asm/nohash/32/pgalloc.h:static inline pgd_t *pgd_alloc(struct mm_struct *mm)
  arch/powerpc/include/asm/nohash/64/pgalloc.h:static inline pgd_t *pgd_alloc(struct mm_struct *mm)
  
  arch/powerpc/include/asm/book3s/64/pgalloc.h:static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
  arch/powerpc/include/asm/nohash/64/pgalloc.h:static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
  
  arch/powerpc/include/asm/book3s/64/pgalloc.h:static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
  arch/powerpc/include/asm/nohash/64/pgalloc.h:static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
  
  arch/powerpc/include/asm/book3s/64/pgalloc.h:static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
  arch/powerpc/include/asm/book3s/64/pgalloc.h:static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
  arch/powerpc/include/asm/nohash/64/pgalloc.h:static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
  arch/powerpc/include/asm/nohash/64/pgalloc.h:static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
  arch/powerpc/mm/pgtable_32.c:pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
  
  arch/powerpc/mm/hugetlbpage.c:pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)

> diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> index cd5e7aa..d0a9ca6 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> @@ -159,7 +168,8 @@ static inline pgtable_t pmd_pgtable(pmd_t pmd)
>  static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
>  					  unsigned long address)
>  {
> -	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	return (pte_t *)__get_free_page(
> +		pgtable_get_gfp_flags(mm, PGALLOC_GFP));
>  }

There's no point doing pte_alloc_one_kernel(), it's explicitly for
kernel allocations IIUI.

cheers

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406Q8257K5zF1wq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 22:54:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 4/4] powerpc/mm/hash: Don't memset pgd table if not
 needed
In-Reply-To: <20180318110558.30493-5-aneesh.kumar@linux.vnet.ibm.com>
References: <20180318110558.30493-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180318110558.30493-5-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 22:54:36 +1100
Message-ID: <87h8p8fhqb.fsf@concordia.ellerman.id.au>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> We need to zero-out pgd table only if we share the slab cache with pud/pmd
> level caches. With the support of 4PB, we don't share the slab cache anymore.
> Instead of removing the code completely hide it within an #ifdef. We don't need
> to do this with any other page table level, because they all allocate table
> of double the size and we take of initializing the first half corrrectly during
> page table zap.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgalloc.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> index 4746bc68d446..07f0dbac479f 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> @@ -80,8 +80,19 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  
>  	pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
>  			       pgtable_gfp_flags(mm, GFP_KERNEL));
> +	/*
> +	 * With hugetlb, we don't clear the second half of the page table.
> +	 * If we share the same slab cache with the pmd or pud level table,
> +	 * we need to make sure we zero out the full table on alloc.
> +	 * With 4K we don't store slot in the second half. Hence we don't
> +	 * need to do this for 4k.
> +	 */
> +#if (H_PGD_INDEX_SIZE == H_PUD_CACHE_INDEX) || \
> +		(H_PGD_INDEX_SIZE == H_PMD_CACHE_INDEX)
> +#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_PPC_64K_PAGES)
>  	memset(pgd, 0, PGD_TABLE_SIZE);
> -
> +#endif
> +#endif

As discussed I changed this to:

#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_PPC_64K_PAGES) && \
	((H_PGD_INDEX_SIZE == H_PUD_CACHE_INDEX) ||		     \
	 (H_PGD_INDEX_SIZE == H_PMD_CACHE_INDEX))
	memset(pgd, 0, PGD_TABLE_SIZE);
#endif

cheers

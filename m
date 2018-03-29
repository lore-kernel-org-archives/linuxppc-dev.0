Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Bn6h2FcqzDr4t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 01:23:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] powerpc/mm/hugetlb: initialize the pagetable cache
 correctly for hugetlb
In-Reply-To: <20180307140925.5755-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180307140925.5755-1-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 30 Mar 2018 01:23:36 +1100
Message-ID: <87k1tvyn87.fsf@concordia.ellerman.id.au>
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
> With 64k page size, we have hugetlb pte entries at the pmd and pud level for
> book3s64. We don't need to create a separate page table cache for that. With 4k
> we need to make sure hugepd page table cache for 16M is placed at PUD level
> and 16G at the PGD level.
>
> Simplify all these by not using HUGEPD_PD_SHIFT which is confusing for book3s64.
>
> Without this patch, with 64k page size we create pagetable caches with shift
> value 10 and 7 which are not used at all.
>
> Fixes:419df06eea5bfa81("powerpc: Reduce the PTE_INDEX_SIZE")

That's:

  Fixes: 419df06eea5b ("powerpc: Reduce the PTE_INDEX_SIZE")

In ~/.gitconfig:

[pretty]
	fixes = Fixes: %h (\"%s\")


> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 876da2bc1796..3b509b268030 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -669,12 +666,24 @@ static int __init hugetlbpage_init(void)
>  		if (add_huge_page_size(1ULL << shift) < 0)
>  			continue;
>  
> +
> +#ifdef CONFIG_PPC_BOOK3S_64
> +		if (shift > PGDIR_SHIFT)
> +			BUG();

Can we not add BUG()s for things that aren't utterly fatal.

In this case I think we could move this whole block above
add_huge_page_size() above, and then instead of BUG() we could just
WARN() and continue?

> +		else if (shift > PUD_SHIFT)
> +			pdshift = PGDIR_SHIFT;
> +		else if (shift > PMD_SHIFT)
> +			pdshift = PUD_SHIFT;
> +		else
> +			pdshift = PMD_SHIFT;
> +#else
>  		if (shift < HUGEPD_PUD_SHIFT)
>  			pdshift = PMD_SHIFT;
>  		else if (shift < HUGEPD_PGD_SHIFT)
>  			pdshift = PUD_SHIFT;
>  		else
>  			pdshift = PGDIR_SHIFT;
> +#endif
>  		/*
>  		 * if we have pdshift and shift value same, we don't
>  		 * use pgt cache for hugepd.

cheers

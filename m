Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41955x0MhwzF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 21:17:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/mm/hash/4k: Free hugetlb page table caches
 correctly.
In-Reply-To: <20180614103152.7344-1-aneesh.kumar@linux.ibm.com>
References: <20180614103152.7344-1-aneesh.kumar@linux.ibm.com>
Date: Tue, 19 Jun 2018 21:17:20 +1000
Message-ID: <87o9g7xby7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> With 4k page size for hugetlb we allocate hugepage directories from its o=
n slab
> cache. With patch 0c4d26802 ("powerpc/book3s64/mm: Simplify the rcu callb=
ack for page table free")
> we missed to free these allocated hugepd tables.
>
> Update pgtable_free to handle hugetlb hugepd directory table.
>
> Fixes:  0c4d26802 ("powerpc/book3s64/mm: Simplify the rcu callback for pa=
ge table free")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/32/pgalloc.h  |  1 +
>  .../include/asm/book3s/64/pgtable-4k.h        | 21 +++++++++++++++++++
>  .../include/asm/book3s/64/pgtable-64k.h       |  9 ++++++++
>  arch/powerpc/include/asm/book3s/64/pgtable.h  |  5 +++++
>  arch/powerpc/include/asm/nohash/32/pgalloc.h  |  1 +
>  arch/powerpc/include/asm/nohash/64/pgalloc.h  |  1 +
>  arch/powerpc/mm/hugetlbpage.c                 |  3 ++-
>  arch/powerpc/mm/pgtable-book3s64.c            | 12 +++++++++++

Fails with 4K=3Dy HUGETLBFS=3Dn:

  arch/powerpc/mm/pgtable-book3s64.c:415:16: error: =E2=80=98H_16M_CACHE_IN=
DEX=E2=80=99 undeclared (first use in this function); did you mean =E2=80=
=98H_PUD_CACHE_INDEX=E2=80=99?

...

> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable=
-book3s64.c
> index c1f4ca45c93a..468c3d83a2aa 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -409,6 +409,18 @@ static inline void pgtable_free(void *table, int ind=
ex)
>  	case PUD_INDEX:
>  		kmem_cache_free(PGT_CACHE(PUD_CACHE_INDEX), table);
>  		break;
> +#ifdef CONFIG_PPC_4K_PAGES
> +		/* 16M hugepd directory at pud level */
> +	case HTLB_16M_INDEX:
> +		BUILD_BUG_ON(H_16M_CACHE_INDEX <=3D 0);
> +		kmem_cache_free(PGT_CACHE(H_16M_CACHE_INDEX), table);
> +		break;
> +		/* 16G hugepd directory at the pgd level */
> +	case HTLB_16G_INDEX:
> +		BUILD_BUG_ON(H_16G_CACHE_INDEX <=3D 0);
> +		kmem_cache_free(PGT_CACHE(H_16G_CACHE_INDEX), table);
> +		break;
> +#endif

Because this isn't protected by CONFIG_HUGETLBFS.

I assume this is correct?

diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-b=
ook3s64.c
index 468c3d83a2aa..9b7007fd075e 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -409,7 +409,7 @@ static inline void pgtable_free(void *table, int index)
 	case PUD_INDEX:
 		kmem_cache_free(PGT_CACHE(PUD_CACHE_INDEX), table);
 		break;
-#ifdef CONFIG_PPC_4K_PAGES
+#if defined(CONFIG_PPC_4K_PAGES) && defined (CONFIG_HUGETLBFS)
 		/* 16M hugepd directory at pud level */
 	case HTLB_16M_INDEX:
 		BUILD_BUG_ON(H_16M_CACHE_INDEX <=3D 0);


cheers

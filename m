Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Drvh2JQqzF0RH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 15:21:52 +1000 (AEST)
Date: Tue, 18 Sep 2018 13:51:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 3/3] powerpc/mm/iommu: Allow migration of cma
 allocated pages during mm_iommu_get
Message-ID: <20180918035116.GA30868@umbus.fritz.box>
References: <20180903163733.27965-1-aneesh.kumar@linux.ibm.com>
 <20180903163733.27965-4-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
In-Reply-To: <20180903163733.27965-4-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 10:07:33PM +0530, Aneesh Kumar K.V wrote:
> Current code doesn't do page migration if the page allocated is a compoun=
d page.
> With HugeTLB migration support, we can end up allocating hugetlb pages fr=
om
> CMA region. Also THP pages can be allocated from CMA region. This patch u=
pdates
> the code to handle compound pages correctly.
>=20
> This add a new helper get_user_pages_cma_migrate. It does one get_user_pa=
ges
> with right count, instead of doing one get_user_pages per page. That avoi=
ds
> reading page table multiple times. The helper could possibly used by other
> subystem if we have more users.
>=20
> The patch also convert the hpas member of mm_iommu_table_group_mem_t to a=
 union.
> We use the same storage location to store pointers to struct page. We can=
not
> update alll the code path use struct page *, because we access hpas in re=
al mode
> and we can't do that struct page * to pfn conversion in real mode.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

This approach doesn't seem quite right to me.  It's specific to pages
mapped into the IOMMU.  It's true that will address the obvious case
we have, of vfio-using guests fragmenting the CMA for other guests.

But AFAICT, fragmenting the CMA coud happen with *any* locked memory,
not just things that are IOMMU mapped for VFIO.  So, for example a
guest not using vfio, but using -realtime mlock=3Don, or an unrelated
program using locked memory (e.g. gpg or something else that locks
memory for security reasons).

AFAICT this approach won't fix the problem for that case.

> ---
>  arch/powerpc/mm/mmu_context_iommu.c | 195 ++++++++++++++++++----------
>  1 file changed, 123 insertions(+), 72 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index f472965f7638..597b88a0abce 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -20,6 +20,7 @@
>  #include <linux/swap.h>
>  #include <asm/mmu_context.h>
>  #include <asm/pte-walk.h>
> +#include <linux/mm_inline.h>
> =20
>  static DEFINE_MUTEX(mem_list_mutex);
> =20
> @@ -30,8 +31,18 @@ struct mm_iommu_table_group_mem_t {
>  	atomic64_t mapped;
>  	unsigned int pageshift;
>  	u64 ua;			/* userspace address */
> -	u64 entries;		/* number of entries in hpas[] */
> -	u64 *hpas;		/* vmalloc'ed */
> +	u64 entries;		/* number of entries in hpages[] */
> +	/*
> +	 * in mm_iommu_get we temporarily use this to store
> +	 * struct page address.
> +	 *
> +	 * We need to convert ua to hpa in real mode. Make it
> +	 * simpler by storing physicall address.
> +	 */
> +	union {
> +		struct page **hpages;	/* vmalloc'ed */
> +		phys_addr_t *hpas;
> +	};
>  };
> =20
>  static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
> @@ -75,62 +86,112 @@ bool mm_iommu_preregistered(struct mm_struct *mm)
>  EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
> =20
>  /*
> - * Taken from alloc_migrate_target with changes to remove CMA allocations
> + * Taken from alloc_migrate_target/alloc_migrate_huge_page with changes =
to remove
> + * CMA allocations
> + * Is this the right allocator for hugetlb?
>   */
>  struct page *new_iommu_non_cma_page(struct page *page, unsigned long pri=
vate)
>  {
> -	gfp_t gfp_mask =3D GFP_USER;
> -	struct page *new_page;
> +	/* is this the right nid? */
> +	int nid =3D numa_mem_id();
> +	gfp_t gfp_mask =3D GFP_HIGHUSER;
> =20
> -	if (PageCompound(page))
> -		return NULL;
> +	if (PageHuge(page)) {
> =20
> -	if (PageHighMem(page))
> -		gfp_mask |=3D __GFP_HIGHMEM;
> +		struct hstate *h =3D page_hstate(page);
> +		/*
> +		 * We don't want to dequeue from the pool because pool pages will
> +		 * mostly be from the CMA region.
> +		 */
> +		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
> =20
> -	/*
> -	 * We don't want the allocation to force an OOM if possibe
> -	 */
> -	new_page =3D alloc_page(gfp_mask | __GFP_NORETRY | __GFP_NOWARN);
> -	return new_page;
> +	} else if (PageTransHuge(page)) {
> +		struct page *thp;
> +		gfp_t thp_gfpmask =3D GFP_TRANSHUGE & ~__GFP_MOVABLE;
> +
> +		thp =3D __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
> +		if (!thp)
> +			return NULL;
> +		prep_transhuge_page(thp);
> +		return thp;
> +	}
> +	return __alloc_pages_node(nid, gfp_mask, 0);
>  }
> =20
> -static int mm_iommu_move_page_from_cma(struct page *page)
> +int get_user_pages_cma_migrate(unsigned long start, int nr_pages, int wr=
ite,
> +			       struct page **pages)
>  {
> -	int ret =3D 0;
> -	LIST_HEAD(cma_migrate_pages);
> -
> -	/* Ignore huge pages for now */
> -	if (PageCompound(page))
> -		return -EBUSY;
> -
> -	lru_add_drain();
> -	ret =3D isolate_lru_page(page);
> -	if (ret)
> +	int i, ret;
> +	bool drain_allow =3D true;
> +	bool migrate_allow =3D true;
> +	LIST_HEAD(cma_page_list);
> +
> +get_user_again:
> +	ret =3D get_user_pages_fast(start, nr_pages, write, pages);
> +	if (ret <=3D 0)
>  		return ret;
> =20
> -	list_add(&page->lru, &cma_migrate_pages);
> -	put_page(page); /* Drop the gup reference */
> -
> -	ret =3D migrate_pages(&cma_migrate_pages, new_iommu_non_cma_page,
> -				NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE);
> -	if (ret) {
> -		if (!list_empty(&cma_migrate_pages))
> -			putback_movable_pages(&cma_migrate_pages);
> +	for (i =3D 0; i < ret; ++i) {
> +		/*
> +		 * If we get a page from the CMA zone, since we are going to
> +		 * be pinning these entries, we might as well move them out
> +		 * of the CMA zone if possible.
> +		 */
> +		if (is_migrate_cma_page(pages[i]) && migrate_allow) {
> +			if (PageHuge(pages[i]))
> +				isolate_huge_page(pages[i], &cma_page_list);
> +			else {
> +				struct page *head =3D compound_head(pages[i]);
> +
> +				if (!PageLRU(head) && drain_allow) {
> +					lru_add_drain_all();
> +					drain_allow =3D false;
> +				}
> +
> +				if (!isolate_lru_page(head)) {
> +					list_add_tail(&head->lru, &cma_page_list);
> +					mod_node_page_state(page_pgdat(head),
> +							    NR_ISOLATED_ANON +
> +							    page_is_file_cache(head),
> +							    hpage_nr_pages(head));
> +				}
> +			}
> +		}
>  	}
> -
> -	return 0;
> +	if (!list_empty(&cma_page_list)) {
> +		/*
> +		 * drop the above get_user_pages reference.
> +		 */
> +		for (i =3D 0; i < ret; ++i)
> +			put_page(pages[i]);
> +
> +		if (migrate_pages(&cma_page_list, new_iommu_non_cma_page,
> +				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
> +			/*
> +			 * some of the pages failed migration. Do get_user_pages
> +			 * without migration.
> +			 */
> +			migrate_allow =3D false;
> +
> +			if (!list_empty(&cma_page_list))
> +				putback_movable_pages(&cma_page_list);
> +		}
> +		/*
> +		 * We did migrate all the pages, Try to get the page references again
> +		 * migrating any new CMA pages which we failed to isolate earlier.
> +		 */
> +		drain_allow =3D true;
> +		goto get_user_again;
> +	}
> +	return ret;
>  }
> =20
>  long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long =
entries,
>  		struct mm_iommu_table_group_mem_t **pmem)
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
> -	long i, j, ret =3D 0, locked_entries =3D 0;
> +	long i, ret =3D 0, locked_entries =3D 0;
>  	unsigned int pageshift;
> -	unsigned long flags;
> -	unsigned long cur_ua;
> -	struct page *page =3D NULL;
> =20
>  	mutex_lock(&mem_list_mutex);
> =20
> @@ -177,47 +238,37 @@ long mm_iommu_get(struct mm_struct *mm, unsigned lo=
ng ua, unsigned long entries,
>  		goto unlock_exit;
>  	}
> =20
> +	ret =3D get_user_pages_cma_migrate(ua, entries, 1, mem->hpages);
> +	if (ret !=3D entries) {
> +		/* free the reference taken */
> +		for (i =3D 0; i < ret; i++)
> +			put_page(mem->hpages[i]);
> +
> +		vfree(mem->hpas);
> +		kfree(mem);
> +		ret =3D -EFAULT;
> +		goto unlock_exit;
> +	} else
> +		ret =3D 0;
> +
> +	pageshift =3D PAGE_SHIFT;
>  	for (i =3D 0; i < entries; ++i) {
> -		cur_ua =3D ua + (i << PAGE_SHIFT);
> -		if (1 !=3D get_user_pages_fast(cur_ua,
> -					1/* pages */, 1/* iswrite */, &page)) {
> -			ret =3D -EFAULT;
> -			for (j =3D 0; j < i; ++j)
> -				put_page(pfn_to_page(mem->hpas[j] >>
> -						PAGE_SHIFT));
> -			vfree(mem->hpas);
> -			kfree(mem);
> -			goto unlock_exit;
> -		}
> +		struct page *page =3D mem->hpages[i];
>  		/*
> -		 * If we get a page from the CMA zone, since we are going to
> -		 * be pinning these entries, we might as well move them out
> -		 * of the CMA zone if possible. NOTE: faulting in + migration
> -		 * can be expensive. Batching can be considered later
> +		 * Allow to use larger than 64k IOMMU pages. Only do that
> +		 * if we are backed by hugetlb.
>  		 */
> -		if (is_migrate_cma_page(page)) {
> -			if (mm_iommu_move_page_from_cma(page))
> -				goto populate;
> -			if (1 !=3D get_user_pages_fast(cur_ua,
> -						1/* pages */, 1/* iswrite */,
> -						&page)) {
> -				ret =3D -EFAULT;
> -				for (j =3D 0; j < i; ++j)
> -					put_page(pfn_to_page(mem->hpas[j] >>
> -								PAGE_SHIFT));
> -				vfree(mem->hpas);
> -				kfree(mem);
> -				goto unlock_exit;
> -			}
> -		}
> -populate:
> -		pageshift =3D PAGE_SHIFT;
> -		if (mem->pageshift > PAGE_SHIFT && PageHuge(page)) {
> +		if ((mem->pageshift > PAGE_SHIFT) && PageHuge(page)) {
>  			struct page *head =3D compound_head(page);
>  			pageshift =3D compound_order(head) + PAGE_SHIFT;
>  		}
>  		mem->pageshift =3D min(mem->pageshift, pageshift);
> +		/*
> +		 * We don't need struct page reference any more, switch
> +		 * physicall address.
> +		 */
>  		mem->hpas[i] =3D page_to_pfn(page) << PAGE_SHIFT;
> +
>  	}
> =20
>  	atomic64_set(&mem->mapped, 1);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlugdjIACgkQbDjKyiDZ
s5LwHxAAybGdP/B0/Lroq6iaFR6CbH+7N16uzOetTnXBZk4TD9pFgyRnG0ndmGrp
CDIflySudsIbRXCs0HYF76daeWITIEMBEVwUg+3+HvYYVcziXYU+Kc5zTbWdsd3k
4+a8A3x2P8TOdi2NKXJeiVquVzIOMHi7Q1DdcoIcZVuZ35EV1WHo2/SOiSOkTlBR
4Q2ELiLSgoOY+Cn+rAAB1ArZIb5yWLw2AjQFCBtn3yfNo9rpx16fQg8D1chUV0U5
+ofDykQDmMzXCLYLAN34y3K4igtRJ0B0LxKrPfFniE/KGcgRYnbQkbMD+atx8brw
h5mXJTxKYHtqbF0B4L65xi9YkJ+wyTbRQzDYPDFkMKUmrMc0zOmEZSxB4GpD6H5q
xpUoAwAmGI8RL8FVioD5rrtiPkG0Ss5+z9qNAQq/TnsmQSvThMQJXjWED550Pzyp
6W9DcGG1KcflwIAMMWElIWebfbntlbA8ces0qJLRYS4y4BZsVp46hcZT8BGlXOXa
BNJM1f6w1wiygnOZMDYuQ/mmIqyqaFTnMKRf28Qa9O3APuYuYGp3kTOHmYTDfW9q
IntZ5bvnd0XLgX6Q669e799j11vTUxo+OM8r9YBqc/dnMQnDxPH3eM4GLW6PeYa7
67bynZOjjbfEbN4Evx1tFkGeZE6qZxhoZdI/IBuciIB29AAh5q0=
=RhMO
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

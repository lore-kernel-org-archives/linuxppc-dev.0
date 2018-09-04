Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424Cwb0PF8zF3CC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 14:07:43 +1000 (AEST)
Date: Tue, 4 Sep 2018 14:06:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 2/3] powerpc/mm/iommu: Allow large IOMMU page size
 only for hugetlb backing
Message-ID: <20180904040643.GG2679@umbus.fritz.box>
References: <20180903163733.27965-1-aneesh.kumar@linux.ibm.com>
 <20180903163733.27965-3-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O8XZ+2Hy8Kj8wLPZ"
In-Reply-To: <20180903163733.27965-3-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--O8XZ+2Hy8Kj8wLPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 10:07:32PM +0530, Aneesh Kumar K.V wrote:
> THP pages can get split during different code paths. An incremented refer=
ence
> count do imply we will not split the compound page. But the pmd entry can=
 be
> converted to level 4 pte entries. Keep the code simpler by allowing large
> IOMMU page size only if the guest ram is backed by hugetlb pages.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

So, I oked this in earlier discussion, but I had another thought and
now I'm not so sure.


> ---
>  arch/powerpc/mm/mmu_context_iommu.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index c9ee9e23845f..f472965f7638 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -212,21 +212,9 @@ long mm_iommu_get(struct mm_struct *mm, unsigned lon=
g ua, unsigned long entries,
>  		}
>  populate:
>  		pageshift =3D PAGE_SHIFT;
> -		if (mem->pageshift > PAGE_SHIFT && PageCompound(page)) {
> -			pte_t *pte;
> +		if (mem->pageshift > PAGE_SHIFT && PageHuge(page)) {

We can definitely only support large IOMMU pages with static
hugepages, not THPs, so the change from PageCompound to PageHuge is
definitely correct and a good idea.

>  			struct page *head =3D compound_head(page);
> -			unsigned int compshift =3D compound_order(head);
> -			unsigned int pteshift;
> -
> -			local_irq_save(flags); /* disables as well */
> -			pte =3D find_linux_pte(mm->pgd, cur_ua, NULL, &pteshift);
> -
> -			/* Double check it is still the same pinned page */
> -			if (pte && pte_page(*pte) =3D=3D head &&
> -			    pteshift =3D=3D compshift + PAGE_SHIFT)
> -				pageshift =3D max_t(unsigned int, pteshift,
> -						PAGE_SHIFT);
> -			local_irq_restore(flags);
> +			pageshift =3D compound_order(head) + PAGE_SHIFT;

But, my concern with this part is: are we totally certain there's no
way to get part of a hugetlbfs page mapped with regular sized PTEs
(probably in addition to the expected hugetlb mapping).

I'm thinking weirdness like mremap(), mapping another hugetlb using
process's address space via /proc/*/mem or maybe something even more
exotic.

Now, it's possible that we don't really care here - even if it's not
technically right for this mapping, we could argue that as long as the
process has access to part of the hugepage, the whole thing is fair
game for a DMA mapping.  In that case merely double checking that this
mapping is properly aligned would suffice (i.e. that:
    (ua >> PAGE_SHIFT) =3D=3D (page's index within the compound page)

>  		}
>  		mem->pageshift =3D min(mem->pageshift, pageshift);
>  		mem->hpas[i] =3D page_to_pfn(page) << PAGE_SHIFT;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--O8XZ+2Hy8Kj8wLPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluOBNMACgkQbDjKyiDZ
s5L7xw/5AdpUDMEV+Ye2WRtOXly+Z3rgFjfphAxwTIQMnnMW7QKyX85pM2LWAAnU
7d80GW7bNrYGpxrL6uJ5ZbrBd4MShZ2uD1CpxOeTO+ajmetll1cyQIycBpDjm0jm
MkGK5AsfItAj66C/HO4RzYf3NqmgKqylQ3zdYaNeNKc91Mbe9NS/JLZl0glZAH2H
qJ4WnZqmtdiDJ5m3X0kfDyvKscVmVfzZGTg3FsUgP9n9kP6w3V/vcE70TczST0Cf
hETxa5pStn1fxhO0Twqa9bcn+S0svUgii6S4WNetfKzU0aluoYtsepQ70RLFes4a
cdqkYctqIDdZthNUIYPi5bKxBmI7ZBaUTuuMnQZYGi9Kcd5mAwscaJXc1mAHehhM
ubwjRwN4XHzAVUALlELPbBC2cp4htTFZJ8oq2dSNcRrOIhcH665tBUo0tyH3O4Dn
P27GkoGdIzGvWKquTKGVEcgOdDuEncMJFsS8IoBRWQF2oaz9H1A0K91cHofyvOKS
/6ajAFEQBG5WJRLEnE0qzPI2Ugy5SAzIsC4rZI9o+qn828YG9BsIZCy0AmdMjR97
SpHKhup3YVz4Ic7CeCQ2v2QmbKeP0rv7YRsMg0xNmp4N5V3J3xsARWAWO7+XNgXU
CN2rSo7N53K8pG6uVm7WW+UJWHbuLjv5fi6xxBiFkgngRl66Sns=
=IIJR
-----END PGP SIGNATURE-----

--O8XZ+2Hy8Kj8wLPZ--

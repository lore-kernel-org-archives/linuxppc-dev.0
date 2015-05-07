Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3A8B1A0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 09:45:44 +1000 (AEST)
Date: Fri, 8 May 2015 09:44:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] powerpc/mm: Return NULL for not present hugetlb page
Message-ID: <20150507234434.GD29713@voom.redhat.com>
References: <1430982981-23700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
In-Reply-To: <1430982981-23700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2015 at 12:46:21PM +0530, Aneesh Kumar K.V wrote:
> We need to check whether pte is present in follow_huge_addr and
> properly return NULL if mapping is not present. Also use READ_ONCE
> when dereferencing pte_t address.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Looks sane.  It's a long time since I worked with this so I don't
really remember, but I have a suspicion that at the time hugepage PTEs
could never exist but be non-present.

> ---
>  arch/powerpc/mm/hugetlbpage.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 0ce968b00b7c..f5688423bc69 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -689,27 +689,34 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>  struct page *
>  follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
>  {
> -	pte_t *ptep;
> -	struct page *page;
> +	pte_t *ptep, pte;
>  	unsigned shift;
>  	unsigned long mask, flags;
> +	struct page *page =3D ERR_PTR(-EINVAL);
> +
> +	local_irq_save(flags);
> +	ptep =3D find_linux_pte_or_hugepte(mm->pgd, address, &shift);
> +	if (!ptep)
> +		goto no_page;
> +	pte =3D READ_ONCE(*ptep);
>  	/*
> +	 * Verify it is a huge page else bail.
>  	 * Transparent hugepages are handled by generic code. We can skip them
>  	 * here.
>  	 */
> -	local_irq_save(flags);
> -	ptep =3D find_linux_pte_or_hugepte(mm->pgd, address, &shift);
> +	if (!shift || pmd_trans_huge((pmd_t)pte))
> +		goto no_page;
> =20
> -	/* Verify it is a huge page else bail. */
> -	if (!ptep || !shift || pmd_trans_huge(*(pmd_t *)ptep)) {
> -		local_irq_restore(flags);
> -		return ERR_PTR(-EINVAL);
> +	if (!pte_present(pte)) {
> +		page =3D NULL;
> +		goto no_page;
>  	}
>  	mask =3D (1UL << shift) - 1;
> -	page =3D pte_page(*ptep);
> +	page =3D pte_page(pte);
>  	if (page)
>  		page +=3D (address & mask) / PAGE_SIZE;
> =20
> +no_page:
>  	local_irq_restore(flags);
>  	return page;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVS/jiAAoJEGw4ysog2bOSTAoP/1QMN1qcg/cz03iKA2wwESSf
UPjir7gPIzTiVIR3URzksfP0J1hjZmBWIzoaHjgl2VkDWJVjwz+7BikAPfljbxQJ
ry890FuYBPojtn16LgivErkZ3RNBKpg6RVHU6RC4L+FqtSEjbpJWgPDVwdcSjc8x
tGCLlNYlTKTF5uQbFtqJfpzheuAZxB5z4ji6i5WIgb7SnsLF5QS7rPaiIPGCylEi
r4HqOmJIi4FiKD8h0/cdsMElcUeg7Z+qROXdk3sxiFB/XBOnUbyyOmZtthdRIg/J
MdHFsIj0MAKTGAqYu/ERKMYhmzqcYNOaHBjmJHNvl9e5A5dSO4TQidoJUkRuDAwP
dbTNXW2simHs2D1lmqXO2xDN1zUrtHoKkzjnJkb2sIFuc/XT6AhYa839mlGwhYYW
SyoMc3KYMqqMJj40Ja/7tqiMXqtl6PHWsi2ZDFKAvkHzK+ZVXtYrnRhVTItSEQnZ
Kng2k7xXkffo4ZuQuQcHcZ48TX/m5qTBYJCvSuvwrrvxr+JNwoV1RPKS2KjZ9c77
GEfk31tLFa2GNmv3/4+fmdLMtu4zSrXjoed2YS2npBugoDwlXU9VYqI505QfK9up
+atLDEbCgz7+p3+0WwIVuP5N4SC41wIhVXONmwcEEbr626HdqiAbwuXYa3ciKrqz
6dTGRYDshmkVMaxbqI2t
=bKnI
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--

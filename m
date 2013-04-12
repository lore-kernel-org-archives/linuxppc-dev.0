Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2D8C2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 11:42:13 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
 Fri, 12 Apr 2013 11:30:45 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0029D3578050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 11:42:02 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3C1S35L54329500
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 11:28:03 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3C1fWEt014460
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 11:41:32 +1000
Date: Fri, 12 Apr 2013 11:34:49 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V5 21/25] powerpc: Handle hugepage in perf callchain
Message-ID: <20130412013449.GD5065@truffula.fritz.box>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-22-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
In-Reply-To: <1365055083-31956-22-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2013 at 11:27:59AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/callchain.c |   32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> index 578cac7..99262ce 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -115,7 +115,7 @@ static int read_user_stack_slow(void __user *ptr, voi=
d *ret, int nb)
>  {
>  	pgd_t *pgdir;
>  	pte_t *ptep, pte;
> -	unsigned shift;
> +	unsigned shift, hugepage;
>  	unsigned long addr =3D (unsigned long) ptr;
>  	unsigned long offset;
>  	unsigned long pfn;
> @@ -125,20 +125,30 @@ static int read_user_stack_slow(void __user *ptr, v=
oid *ret, int nb)
>  	if (!pgdir)
>  		return -EFAULT;
> =20
> -	ptep =3D find_linux_pte_or_hugepte(pgdir, addr, &shift, NULL);
> +	ptep =3D find_linux_pte_or_hugepte(pgdir, addr, &shift, &hugepage);

So, this patch pretty much demonstrates that your earlier patch adding
the optional hugepage argument and making the existing callers pass
NULL was broken.

Any code which calls this function and doesn't use and handle the
hugepage return value is horribly broken, so permitting the hugepage
parameter to be optional is itself broken.

I think instead you need to have an early patch that replaces
find_linux_pte_or_hugepte with a new, more abstracted interface, so
that code using it will remain correct when hugepage PMDs become
possible.

>  	if (!shift)
>  		shift =3D PAGE_SHIFT;
> =20
> -	/* align address to page boundary */
> -	offset =3D addr & ((1UL << shift) - 1);
> -	addr -=3D offset;
> -
> -	if (ptep =3D=3D NULL)
> -		return -EFAULT;
> -	pte =3D *ptep;
> -	if (!pte_present(pte) || !(pte_val(pte) & _PAGE_USER))
> +	if (!ptep)
>  		return -EFAULT;
> -	pfn =3D pte_pfn(pte);
> +
> +	if (hugepage) {
> +		pmd_t pmd =3D *(pmd_t *)ptep;
> +		shift =3D mmu_psize_defs[MMU_PAGE_16M].shift;
> +		offset =3D addr & ((1UL << shift) - 1);
> +
> +		if (!pmd_large(pmd) || !(pmd_val(pmd) & PMD_HUGE_USER))
> +			return -EFAULT;
> +		pfn =3D pmd_pfn(pmd);
> +	} else {
> +		offset =3D addr & ((1UL << shift) - 1);
> +
> +		pte =3D *ptep;
> +		if (!pte_present(pte) || !(pte_val(pte) & _PAGE_USER))
> +			return -EFAULT;
> +		pfn =3D pte_pfn(pte);
> +	}
> +
>  	if (!page_is_ram(pfn))
>  		return -EFAULT;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlFnZLkACgkQaILKxv3ab8abqgCfdGprCjTIMD80/hgwnlly1cDm
7tcAn1mHgSnU7gUDibcsloSk8MTqtbze
=MG90
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--

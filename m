Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4128P03BrKzF0sk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 14:21:24 +1000 (AEST)
Date: Fri, 8 Jun 2018 13:32:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ram Pai <linuxram@us.ibm.com>, kvm@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>
Subject: Re: [RFC PATCH kernel 1/5] vfio/spapr_tce: Simplify page contained
 test
Message-ID: <20180608033236.GN3344@umbus.fritz.box>
References: <20180607084420.29513-1-aik@ozlabs.ru>
 <20180607084420.29513-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="20XocjIeMTCm4X0r"
In-Reply-To: <20180607084420.29513-2-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--20XocjIeMTCm4X0r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 06:44:16PM +1000, Alexey Kardashevskiy wrote:
> The test function takes a page struct pointer which is not used by
> either of two callers in any other way, make it simple and just pass
> a physical address there.
>=20
> This should cause no behavioral change now but later we may start
> supporting host addresses for memory devices which are not backed
> with page structs.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 759a5bd..2c4a048 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -249,8 +249,9 @@ static void tce_iommu_userspace_view_free(struct iomm=
u_table *tbl,
>  	decrement_locked_vm(mm, cb >> PAGE_SHIFT);
>  }
> =20
> -static bool tce_page_is_contained(struct page *page, unsigned page_shift)
> +static bool tce_page_is_contained(unsigned long hpa, unsigned page_shift)
>  {
> +	struct page *page =3D pfn_to_page(hpa >> PAGE_SHIFT);
>  	/*
>  	 * Check that the TCE table granularity is not bigger than the size of
>  	 * a page we just found. Otherwise the hardware can get access to
> @@ -549,7 +550,6 @@ static long tce_iommu_build(struct tce_container *con=
tainer,
>  		enum dma_data_direction direction)
>  {
>  	long i, ret =3D 0;
> -	struct page *page;
>  	unsigned long hpa;
>  	enum dma_data_direction dirtmp;
> =20
> @@ -560,8 +560,7 @@ static long tce_iommu_build(struct tce_container *con=
tainer,
>  		if (ret)
>  			break;
> =20
> -		page =3D pfn_to_page(hpa >> PAGE_SHIFT);
> -		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
> +		if (!tce_page_is_contained(hpa, tbl->it_page_shift)) {
>  			ret =3D -EPERM;
>  			break;
>  		}
> @@ -595,7 +594,6 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		enum dma_data_direction direction)
>  {
>  	long i, ret =3D 0;
> -	struct page *page;
>  	unsigned long hpa;
>  	enum dma_data_direction dirtmp;
> =20
> @@ -615,8 +613,7 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		if (ret)
>  			break;
> =20
> -		page =3D pfn_to_page(hpa >> PAGE_SHIFT);
> -		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
> +		if (!tce_page_is_contained(hpa, tbl->it_page_shift)) {
>  			ret =3D -EPERM;
>  			break;
>  		}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--20XocjIeMTCm4X0r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsZ+NQACgkQbDjKyiDZ
s5ImDA//UvobddFnWiCH6HN7UEFKsnd8Tu+B0E44P42Iuv5Cbp2pNxAjAWnlhQxo
nCio9yrhpX6IrAbjVu0jNiZvXb02iZfmvo9adU7wEtndDqU5BSjmVg9bvbhAG9jh
P4/kAIFqYSqZEVlmWEfCwvjAePREMggUTPDJKHD8fkj7Kxc/T4cMi5yrGyc47yAv
UXFIBUEMYd+qcjPEQug3/yHuWMGM1Yc6IhzRtDD+0iG6ybTh8wefsdfzvDB0z1lk
tmfFG5vUy+Jmt450L3SrfIG8gWqa0mI0H6RCffsRi8OSO0qyU2ou1lrSQnIhQFZH
jSvFT812olbMwp7Tkm9N1BMWlmOwQzVKwRY1gYVhDS0gB6lsEeCCUYJXsg9TWu1L
15JbNXl+D5STO5iLMXwo+e6T2Yz9ZpSTpjWf+VY78+QFOvCAhNCWhWv04eyzC3nA
nOlo7ptUzW2f3T3Y2f3/XyxFYRhUs/vxrYPSUfRns0uNwmKhkb66iIbVg0dsKnro
uFgJQOanvjeOt2+8D98BJ5L7R8PThUoKsjCOXpw2EzTJf92vfId/NExH9wNa4ppZ
X6TcLBzZd/cBw3A77ChKtSz2Rrlh8hGGkIskYlvMm+F2pFNuCVITc6j/g4COEglk
FppwlOD/9Q9NjnRTsQV/UBJka745FeLW39F0hh8HTxVjIp4NtM8=
=+159
-----END PGP SIGNATURE-----

--20XocjIeMTCm4X0r--

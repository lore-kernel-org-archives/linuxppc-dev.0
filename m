Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419R5V3kwJzF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 10:48:14 +1000 (AEST)
Date: Wed, 20 Jun 2018 10:42:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel 1/2] vfio/spapr: Use IOMMU pageshift rather than
 pagesize
Message-ID: <20180620004220.GF3546@umbus.fritz.box>
References: <20180619084414.808-1-aik@ozlabs.ru>
 <20180619084414.808-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
In-Reply-To: <20180619084414.808-2-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 06:44:13PM +1000, Alexey Kardashevskiy wrote:
> The size is always equal to 1 page so let's use this. Later on this will
> be used for other checks which use page shifts to check the granularity
> of access.
>=20
> This should cause no behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 759a5bd..2da5f05 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -457,13 +457,13 @@ static void tce_iommu_unuse_page(struct tce_contain=
er *container,
>  }
> =20
>  static int tce_iommu_prereg_ua_to_hpa(struct tce_container *container,
> -		unsigned long tce, unsigned long size,
> +		unsigned long tce, unsigned long shift,
>  		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
>  {
>  	long ret =3D 0;
>  	struct mm_iommu_table_group_mem_t *mem;
> =20
> -	mem =3D mm_iommu_lookup(container->mm, tce, size);
> +	mem =3D mm_iommu_lookup(container->mm, tce, 1ULL << shift);
>  	if (!mem)
>  		return -EINVAL;
> =20
> @@ -487,7 +487,7 @@ static void tce_iommu_unuse_page_v2(struct tce_contai=
ner *container,
>  	if (!pua)
>  		return;
> =20
> -	ret =3D tce_iommu_prereg_ua_to_hpa(container, *pua, IOMMU_PAGE_SIZE(tbl=
),
> +	ret =3D tce_iommu_prereg_ua_to_hpa(container, *pua, tbl->it_page_shift,
>  			&hpa, &mem);
>  	if (ret)
>  		pr_debug("%s: tce %lx at #%lx was not cached, ret=3D%d\n",
> @@ -611,7 +611,7 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  				entry + i);
> =20
>  		ret =3D tce_iommu_prereg_ua_to_hpa(container,
> -				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
> +				tce, tbl->it_page_shift, &hpa, &mem);
>  		if (ret)
>  			break;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlspouoACgkQbDjKyiDZ
s5L5/RAAs00ywsrdFkfGSZAjNzj/GtSLnODR96CGrsgQxaNPt+nNPMVWcZ/B4vts
l+QkYi+TS2G3iRWKznWYdlgoJimm95WJQr0gy3kvOZdaIeK7BgyNqttZpwJgMIWc
8yWCmng3Z7z3Jlh4Vwffjd9qMCFOcZvUib93q9HJfz9rBZk1NAXRNNGi6VtAH4+N
tH3no4yIODIpGR2ueG2WPDd7q834+dRTLxdxR1vBFad37VCKdnl4Mah6x9gzjZYV
SNBb57WEXCyUNby2gke20VoyVUztLgEkYhgJ3heKj2Uwl9kQ0DN3CDsgPtKw3lxT
FYNIfG7ILiyfuRXGLY5+bHqDF0PwuJq8AwvO/szSZn59vOLkYw2rEIeixFLGqSaI
Yp+W8oe48Qch7hhV5F9fzrpYI4HIYZCFlYljdTgO6HXwy4dRYx6AdyV2dbpUXK3g
+U28syhEK5UeAqyO5vKvm3mwNeVoVCiDhQ+p1paAg70vPiRB4yhFtoiT/FeJv6yZ
9K0+y+PTaqva9wRFYVwhk71CpmeolT9uoc3F/RROUyhbrejhOn0ZQmAJIG6t8aki
cfKWMDlUAIA/MLhmg3cpitlk6oHMV5wnUpp4QC6zDcfRJVrjh6UkoB6Vo1dxTA3O
BJyOYbeHESfNjuajLfalySDDhDXNn3lkq1/qlq6hFW9i8cX5iOQ=
=jxrq
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--

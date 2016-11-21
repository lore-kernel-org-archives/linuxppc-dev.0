Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN5KP63GLzDvkS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:03:37 +1100 (AEDT)
Date: Tue, 22 Nov 2016 10:27:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v5 3/6] vfio/spapr: Postpone allocation of
 userspace version of TCE table
Message-ID: <20161121232757.GG8681@umbus.fritz.box>
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-4-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
In-Reply-To: <1478867537-27893-4-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 11, 2016 at 11:32:14PM +1100, Alexey Kardashevskiy wrote:
> The iommu_table struct manages a hardware TCE table and a vmalloc'd
> table with corresponding userspace addresses. Both are allocated when
> the default DMA window is created and this happens when the very first
> group is attached to a container.
>=20
> As we are going to allow the userspace to configure container in one
> memory context and pas container fd to another, we have to postpones
> such allocations till a container fd is passed to the destination
> user process so we would account locked memory limit against the actual
> container user constrainsts.
>=20
> This postpones the it_userspace array allocation till it is used first
> time for mapping. The unmapping patch already checks if the array is
> allocated.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index d0c38b2..442baac 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -515,6 +515,12 @@ static long tce_iommu_build_v2(struct tce_container =
*container,
>  	unsigned long hpa;
>  	enum dma_data_direction dirtmp;
> =20
> +	if (!tbl->it_userspace) {
> +		ret =3D tce_iommu_userspace_view_alloc(tbl);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	for (i =3D 0; i < pages; ++i) {
>  		struct mm_iommu_table_group_mem_t *mem =3D NULL;
>  		unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl,
> @@ -1068,10 +1074,7 @@ static int tce_iommu_take_ownership(struct tce_con=
tainer *container,
>  		if (!tbl || !tbl->it_map)
>  			continue;
> =20
> -		rc =3D tce_iommu_userspace_view_alloc(tbl);
> -		if (!rc)
> -			rc =3D iommu_take_ownership(tbl);
> -
> +		rc =3D iommu_take_ownership(tbl);
>  		if (rc) {
>  			for (j =3D 0; j < i; ++j)
>  				iommu_release_ownership(

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYM4L9AAoJEGw4ysog2bOStV8QANEthykAmjyhkUA0Ehr1wmmj
YkKDniKhlC4TQxUuA9QllLiFkmPvtkU9ElrCIsniFoB76+sUYShUfOz8nQGiYFNq
NpMa8Ds8FSFkKo3IB/NfMH/BkWMsYgbp/fOsZrT19qBPKAs0eC9SEbRqBxsnSdP7
K3ZYQVbDSte0OzY6tOJ97ZMq2mV2GeiDve09uB0/A8MfxsTP3p2i3POgWCKMfnfZ
MJHLs+Pzf0vPoPaH2b1FvgOUAB02/baDbeq3uxaA9H6JiwTDARrYlVxpNUqAnL/1
qWbTMRTqIxRrZfoPwx0bswuYnfbUzvAenlIvVg93hmgHG7ARDnNUOwvQmRqFx5W0
LAK5BvlU6134BZF13uQ9S5oTktucONkk0Xv1bdkHMgAd7qr+8S6sRN7mZLPbDaVN
R+4qb+agFV/DV8FiCrept+NGzMTvCmGypKBNyT5Oc93RiiYbozYK1Fa7pTy8lx9h
H58829esWwZnl1BEZCC/I99xzlCy0/qhImePjAZ15yKULgX8NfbLl3f77qAcSwk5
2eiumXrUpwFlBXdlwR97wpb1ApsofFSFqXMoYD46zcDJoFJVcn/95HbAIFqyAMGs
cuCB2n+DkWqF1APakmVwig3K165MqJxXl2jKrmiysE1v9pc7tS6ljK/o/9Fta7VQ
jXFPtMLZMXp6D2qrz9ZM
=iNpO
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--

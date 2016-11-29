Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSWCr56lQzDwR4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:44:08 +1100 (AEDT)
Date: Tue, 29 Nov 2016 15:31:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v6 3/7] vfio/spapr: Postpone allocation of
 userspace version of TCE table
Message-ID: <20161129043134.GJ13307@umbus.fritz.box>
References: <1479966490-8739-1-git-send-email-aik@ozlabs.ru>
 <1479966490-8739-4-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Z8yxTSU1mh2gsre7"
In-Reply-To: <1479966490-8739-4-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Z8yxTSU1mh2gsre7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2016 at 04:48:06PM +1100, Alexey Kardashevskiy wrote:
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
> Changes:
> v6:
> * moved missing hunk from the next patch: tce_iommu_create_table()
> would decrement locked_vm while new caller - tce_iommu_build_v2() -
> will not; this adds a new return code to the DMA mapping path but
> this seems to be a minor change.
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index d0c38b2..4efd2b2 100644
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
> @@ -588,15 +594,6 @@ static long tce_iommu_create_table(struct tce_contai=
ner *container,
>  	WARN_ON(!ret && !(*ptbl)->it_ops->free);
>  	WARN_ON(!ret && ((*ptbl)->it_allocated_size !=3D table_size));
> =20
> -	if (!ret && container->v2) {
> -		ret =3D tce_iommu_userspace_view_alloc(*ptbl);
> -		if (ret)
> -			(*ptbl)->it_ops->free(*ptbl);
> -	}
> -
> -	if (ret)
> -		decrement_locked_vm(table_size >> PAGE_SHIFT);
> -
>  	return ret;
>  }
> =20
> @@ -1068,10 +1065,7 @@ static int tce_iommu_take_ownership(struct tce_con=
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

--Z8yxTSU1mh2gsre7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYPQSjAAoJEGw4ysog2bOSQC0QAKj8tg8apWd4rkO0oknEtEj4
LCmIF4gSoditscsdujMA6U2gRmsJ77i8wswHfc/f9ltWMmapEgXUWZZMV6fbBc29
6SG1H5Wk1lzfirYCLGnyiHnP3axdQyY6Rcvab4xnUjABfiU8u+svlpDbRYa0D2Dn
S2tn/VBXcoeEwCK2i/ZbugvFSGAZ3SJ1IFZu8sNAyHQDOgrmGyX7ADlVbUS8imyN
RZuTspXpv7usyWhfY8k4I77DuadQEw2bKsI5VNoxDzVZ8k0AC5IkUBAirtYJW/r+
+CqsWiQYKtrwmU9hYY4OrppiQ+wJ7Mz/u63yDyKE/b6s1kDdbKl53kZ2n622Ntuo
Gb24Es/nA4WwbmamCVPOqd+STBxdj8RVHIyypCsfWB0NxLekfvQHPuVn7nmU467t
okdF0ud8umManO4kT5/khzbppm9XYEH0fL6TlfVEPhfuqJK07djmQpIY5jw882Ak
u2q3F/ItRbmlXQV3AfPdfMVKpJapcB+REvntxT1lQ5IPPXxR++YhDqQ4Ydy31FxN
fKdbqCwABGTyFLzA2C0ab9D4C4mIQML0KrSZgsomlHOv/amntaJll6qYowQncNG3
la3Amzc6URssxjhQSUOz/dslwGBl26P5MW9c4lfU5JiGzC/8eGi+L8ZR9uSE3N3t
cTdFHExgnctQOS52amjz
=wrmR
-----END PGP SIGNATURE-----

--Z8yxTSU1mh2gsre7--

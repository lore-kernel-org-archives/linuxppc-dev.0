Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41F931A0CCA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 13:26:05 +1000 (AEST)
Date: Wed, 29 Apr 2015 12:16:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 09/32] vfio: powerpc/spapr: Rework groups
 attaching
Message-ID: <20150429021618.GH32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-10-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
In-Reply-To: <1429964096-11524-10-git-send-email-aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:33PM +1000, Alexey Kardashevskiy wrote:
> This is to make extended ownership and multiple groups support patches
> simpler for review.
>=20
> This should cause no behavioural change.

Um.. this doesn't appear to be true.  Previously removing a group from
an enabled container would fail with EBUSY, now it forces a disable.

>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 40 ++++++++++++++++++++++---------=
------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 115d5e6..0fbe03e 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -460,16 +460,21 @@ static int tce_iommu_attach_group(void *iommu_data,
>  				iommu_group_id(container->tbl->it_group),
>  				iommu_group_id(iommu_group));
>  		ret =3D -EBUSY;
> -	} else if (container->enabled) {
> +		goto unlock_exit;
> +	}
> +
> +	if (container->enabled) {
>  		pr_err("tce_vfio: attaching group #%u to enabled container\n",
>  				iommu_group_id(iommu_group));
>  		ret =3D -EBUSY;
> -	} else {
> -		ret =3D iommu_take_ownership(tbl);
> -		if (!ret)
> -			container->tbl =3D tbl;
> +		goto unlock_exit;
>  	}
> =20
> +	ret =3D iommu_take_ownership(tbl);
> +	if (!ret)
> +		container->tbl =3D tbl;
> +
> +unlock_exit:
>  	mutex_unlock(&container->lock);
> =20
>  	return ret;
> @@ -487,19 +492,22 @@ static void tce_iommu_detach_group(void *iommu_data,
>  		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
>  				iommu_group_id(iommu_group),
>  				iommu_group_id(tbl->it_group));
> -	} else {
> -		if (container->enabled) {
> -			pr_warn("tce_vfio: detaching group #%u from enabled container, forcin=
g disable\n",
> -					iommu_group_id(tbl->it_group));
> -			tce_iommu_disable(container);
> -		}
> +		goto unlock_exit;
> +	}
> =20
> -		/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
> -				iommu_group_id(iommu_group), iommu_group); */
> -		container->tbl =3D NULL;
> -		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> -		iommu_release_ownership(tbl);
> +	if (container->enabled) {
> +		pr_warn("tce_vfio: detaching group #%u from enabled container, forcing=
 disable\n",
> +				iommu_group_id(tbl->it_group));
> +		tce_iommu_disable(container);
>  	}
> +
> +	/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
> +	   iommu_group_id(iommu_group), iommu_group); */
> +	container->tbl =3D NULL;
> +	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> +	iommu_release_ownership(tbl);
> +
> +unlock_exit:
>  	mutex_unlock(&container->lock);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQD7yAAoJEGw4ysog2bOSOEoP/jR3J+cXExvY7O8UjzG21M6u
LY2u4J0VA7DrmaYEEwIeu5jZC6JvLKjWTljK6xZgtEu80aWfWh+fHfhomY6TVWR7
EkY1MnjFWyum4p9a1ih+ilnOJmhz/9/qzt/avc6iGTesQHGclovVt/MW0XzyTc4Y
8H6lL5pH65pJgurIkHaTX9xTrbJOYRpsbmBnJmGMtRG9+6JjP/1E05A0LoQI6+Th
sSiIVFtUot5q4xVkDAzHUgWmaqpn9u63fKNVHqiG6/4gryJsdc+Num2X41y1RyKU
LhlpJElr63mHZw7LSbYI9srQn0hcB6ssRvRtzx2ftfGx8wbTBkaPixOmCW3WvKaP
DM0v9U3+vw1aahrcH+jrpyZoipwl1aB7vwhZLo4PkTZV6js0D2zhccRL3KYDqxW9
RJE9jLllprg1SinHTt2s2aF1YCwU68V43atPJyC3JpK0s/jeg8szeDXSw88o1lVQ
EpGTsYBLY/RnH1S1hI/AvrA9id8eE3b1k91v21N23nFC/WrgC3ERF5MOtPLpyB/9
m0taSYQoyeUej/WF9PHrjstatPmjdgTz2sYLGisA538hzJ/hPUgsTUYs5j/d+yfA
SXXt0XwkR6GLPaO0teL1xQnTiN97crmxaFpgK2St+7XrGx5qbRUuyOwvPfbffH9Y
hAoeugsIZ5cUP2JNwJBD
=AyK1
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--

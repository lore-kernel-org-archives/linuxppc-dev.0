Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9YjJ0GymzDr5C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 15:44:04 +1000 (AEST)
Date: Fri, 12 Aug 2016 15:25:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 14/15] vfio/spapr_tce: Export container API for
 external users
Message-ID: <20160812052550.GR16493@voom.fritz.box>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-15-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YttKMwf6abDJOSyE"
In-Reply-To: <1470213656-1042-15-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--YttKMwf6abDJOSyE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 06:40:55PM +1000, Alexey Kardashevskiy wrote:
> This exports helpers which are needed to keep a VFIO container in
> memory while there are external users such as KVM.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

I'll address Alex W's broader concerns in a  different mail.  But
there are some more superficial problems with this as well.

> ---
>  drivers/vfio/vfio.c                 | 30 ++++++++++++++++++++++++++++++
>  drivers/vfio/vfio_iommu_spapr_tce.c | 16 +++++++++++++++-
>  include/linux/vfio.h                |  6 ++++++
>  3 files changed, 51 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index d1d70e0..baf6a9c 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -1729,6 +1729,36 @@ long vfio_external_check_extension(struct vfio_gro=
up *group, unsigned long arg)
>  EXPORT_SYMBOL_GPL(vfio_external_check_extension);
> =20
>  /**
> + * External user API for containers, exported by symbols to be linked
> + * dynamically.
> + *
> + */
> +struct vfio_container *vfio_container_get_ext(struct file *filep)
> +{
> +	struct vfio_container *container =3D filep->private_data;
> +
> +	if (filep->f_op !=3D &vfio_fops)
> +		return ERR_PTR(-EINVAL);
> +
> +	vfio_container_get(container);
> +
> +	return container;
> +}
> +EXPORT_SYMBOL_GPL(vfio_container_get_ext);
> +
> +void vfio_container_put_ext(struct vfio_container *container)
> +{
> +	vfio_container_put(container);
> +}
> +EXPORT_SYMBOL_GPL(vfio_container_put_ext);
> +
> +void *vfio_container_get_iommu_data_ext(struct vfio_container *container)
> +{
> +	return container->iommu_data;
> +}
> +EXPORT_SYMBOL_GPL(vfio_container_get_iommu_data_ext);
> +
> +/**
>   * Sub-module support
>   */
>  /*
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 3594ad3..fceea3d 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -1331,6 +1331,21 @@ const struct vfio_iommu_driver_ops tce_iommu_drive=
r_ops =3D {
>  	.detach_group	=3D tce_iommu_detach_group,
>  };
> =20
> +struct iommu_table *vfio_container_spapr_tce_table_get_ext(void *iommu_d=
ata,
> +		u64 offset)

I really dislike this name.  I was confused for a while why this
existed on top of vfio_container_get_ext(), the names are so similar.


Making it take a void * is also really nasty since that void * has to
be something specific.  It would be better to have this take a
vfio_container *, verify that the container really does have an
spapr_tce backend, then lookup the tce_container and the actual IOMMU
tables within.

That might also let you drop vfio_container_get_iommu_data_ext()
entirely.

> +{
> +	struct tce_container *container =3D iommu_data;
> +	struct iommu_table *tbl =3D NULL;
> +
> +	if (tce_iommu_find_table(container, offset, &tbl) < 0)
> +		return NULL;
> +
> +	iommu_table_get(tbl);
> +
> +	return tbl;
> +}
> +EXPORT_SYMBOL_GPL(vfio_container_spapr_tce_table_get_ext);
> +
>  static int __init tce_iommu_init(void)
>  {
>  	return vfio_register_iommu_driver(&tce_iommu_driver_ops);
> @@ -1348,4 +1363,3 @@ MODULE_VERSION(DRIVER_VERSION);
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR(DRIVER_AUTHOR);
>  MODULE_DESCRIPTION(DRIVER_DESC);
> -
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 0ecae0b..1c2138a 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -91,6 +91,12 @@ extern void vfio_group_put_external_user(struct vfio_g=
roup *group);
>  extern int vfio_external_user_iommu_id(struct vfio_group *group);
>  extern long vfio_external_check_extension(struct vfio_group *group,
>  					  unsigned long arg);
> +extern struct vfio_container *vfio_container_get_ext(struct file *filep);
> +extern void vfio_container_put_ext(struct vfio_container *container);
> +extern void *vfio_container_get_iommu_data_ext(
> +		struct vfio_container *container);
> +extern struct iommu_table *vfio_container_spapr_tce_table_get_ext(
> +		void *iommu_data, u64 offset);
> =20
>  /*
>   * Sub-module helpers

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YttKMwf6abDJOSyE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrV3eAAoJEGw4ysog2bOSn5gP/R8B02IgP6bEuuJ5lkS6GYSw
WqcIvDHA4237mhx6ECUt3sjUeHxSfKgEUxkPoPMCVxbB0wQF6vtOH6ypM04+80TW
QuCZWBpRnvj6GmgGGBqc4xhVPAxOz+nWOQl9ZT9wWkgGHTIMjIWPRuiMuJVvVNxf
sSLFJA/PWrMKGUTsWngfB6em4GGiqRFIz41tEC2Rt0S4fOXL6w9yPHJr7ijKxgg0
W5e+GUopgZe+mRVvatRCgnrLkv8LR5FYaPb4mTAsx2W5yRV9WFmlDKBrKlBLOHVr
vtjxFT0zIBEVjqq3vR8/KTaHlQh2DbdCuuV/RlfTX2dn3V81vT2lAZzGLFcxejEs
lup5V3FixJWb5XMsIzzOKd9Se2zWo7zxERmnbrZCqrt1Yp/WHWkG0oe1pNRlbR3o
wQG1cJCtkD/Zf/XJMW8Fo/2xVQ1pEFRVmIz2m/57XHGBUIk3Qg4dN5N0hpVBBwYC
ohfKLwxadOPUWTt5Gp/BsaGsKzSZjkBQuXj8XWLp43UG2TygyLbMaUup2n2Uh9GV
wpEuIODJdDImwxF15pl1Mlwpq5tfagV/XQ9f8NniGoqe0JJYxbPs9OC5qqg3cA7j
QBsdrTpApuX7kucbbDi89tKKW8TOq72kp958GKxhUdluhsDwR+O8jfOODEHw8FF6
JYQJuEqjlpqjeIeafKIJ
=/xE3
-----END PGP SIGNATURE-----

--YttKMwf6abDJOSyE--

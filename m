Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJjJp2yMJzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 13:51:38 +1100 (AEDT)
Date: Thu, 9 Feb 2017 12:05:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel] vfio/spapr_tce: Set window when adding additional
 groups to container
Message-ID: <20170209010529.GL17644@umbus.fritz.box>
References: <20170207062657.21606-1-aik@ozlabs.ru>
 <20170207123559.2b878948@t450s.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ai3I8gwHc37+ASRI"
In-Reply-To: <20170207123559.2b878948@t450s.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ai3I8gwHc37+ASRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 12:35:59PM -0700, Alex Williamson wrote:
> On Tue,  7 Feb 2017 17:26:57 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > If a container already has a group attached, attaching a new group
> > should just program already created IOMMU tables to the hardware via
> > the iommu_table_group_ops::set_window() callback.
> >=20
> > However 6f01cc692 "vfio/spapr: Add a helper to create default DMA windo=
w"
> > did not just simplify the code but also removed the set_window() calls
> > in the case of attaching groups to a container which already has tables
> > so it broke VFIO PCI hotplug.
> >=20
> > This reverts set_window() bits in tce_iommu_take_ownership_ddw().
> >=20
> > Fixes: 6f01cc692
>=20
> See Documentation/process/submitting-patches.rst for the expected
> format here, 12 char SHA-1 + --oneline summary.
>=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  drivers/vfio/vfio_iommu_spapr_tce.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >=20
> > diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_io=
mmu_spapr_tce.c
> > index 7690e5bf3cf1..14c62a8495a2 100644
> > --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> > +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> > @@ -1245,6 +1245,8 @@ static void tce_iommu_release_ownership_ddw(struc=
t tce_container *container,
> >  static long tce_iommu_take_ownership_ddw(struct tce_container *contain=
er,
> >  		struct iommu_table_group *table_group)
> >  {
> > +	long i, ret =3D 0;
> > +
> >  	if (!table_group->ops->create_table || !table_group->ops->set_window =
||
> >  			!table_group->ops->release_ownership) {
> >  		WARN_ON_ONCE(1);
> > @@ -1253,7 +1255,26 @@ static long tce_iommu_take_ownership_ddw(struct =
tce_container *container,
> > =20
> >  	table_group->ops->take_ownership(table_group);
> > =20
> > +	/* Set all windows to the new group */
> > +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> > +		struct iommu_table *tbl =3D container->tables[i];
>=20
> checkpatch wants a blank line here.
>=20
> > +		if (!tbl)
> > +			continue;
> > +
> > +		ret =3D table_group->ops->set_window(table_group, i, tbl);
> > +		if (ret)
> > +			goto release_exit;
> > +	}
> > +
> >  	return 0;
> > +
> > +release_exit:
> > +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
> > +		table_group->ops->unset_window(table_group, i);
> > +
> > +	table_group->ops->release_ownership(table_group);
> > +
> > +	return ret;
> >  }
> > =20
> >  static int tce_iommu_attach_group(void *iommu_data,
>=20
>=20
> I've fixed these as shown below.  David, please review/ack as well and
> I'll send a pull for v4.10.  Thanks,
>=20
> Alex

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

>=20
>=20
> commit c019167838156a2efcc60a15fa4207710bac6e82
> Author: Alexey Kardashevskiy <aik@ozlabs.ru>
> Date:   Tue Feb 7 17:26:57 2017 +1100
>=20
>     vfio/spapr_tce: Set window when adding additional groups to container
>    =20
>     If a container already has a group attached, attaching a new group
>     should just program already created IOMMU tables to the hardware via
>     the iommu_table_group_ops::set_window() callback.
>    =20
>     However commit 6f01cc692a16 ("vfio/spapr: Add a helper to create
>     default DMA window") did not just simplify the code but also removed
>     the set_window() calls in the case of attaching groups to a container
>     which already has tables so it broke VFIO PCI hotplug.
>    =20
>     This reverts set_window() bits in tce_iommu_take_ownership_ddw().
>    =20
>     Fixes: 6f01cc692a16 ("vfio/spapr: Add a helper to create default DMA =
window")
>     Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>     Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 7690e5bf3cf1..59b3f62a2d64 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -1245,6 +1245,8 @@ static void tce_iommu_release_ownership_ddw(struct =
tce_container *container,
>  static long tce_iommu_take_ownership_ddw(struct tce_container *container,
>  		struct iommu_table_group *table_group)
>  {
> +	long i, ret =3D 0;
> +
>  	if (!table_group->ops->create_table || !table_group->ops->set_window ||
>  			!table_group->ops->release_ownership) {
>  		WARN_ON_ONCE(1);
> @@ -1253,7 +1255,27 @@ static long tce_iommu_take_ownership_ddw(struct tc=
e_container *container,
> =20
>  	table_group->ops->take_ownership(table_group);
> =20
> +	/* Set all windows to the new group */
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbl =3D container->tables[i];
> +
> +		if (!tbl)
> +			continue;
> +
> +		ret =3D table_group->ops->set_window(table_group, i, tbl);
> +		if (ret)
> +			goto release_exit;
> +	}
> +
>  	return 0;
> +
> +release_exit:
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
> +		table_group->ops->unset_window(table_group, i);
> +
> +	table_group->ops->release_ownership(table_group);
> +
> +	return ret;
>  }
> =20
>  static int tce_iommu_attach_group(void *iommu_data,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ai3I8gwHc37+ASRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm8BZAAoJEGw4ysog2bOS8hMP/3e9OX5xR2ckwPZtdIMwiEAR
f7G7GpdX9E+Ezg726bJKTo0UAAByiZdRiIjahOioBbCXvlao7yn1gtiCUUP/PJrY
XflP7PYnEdDijZsfq7WHI75rLvr2jc14g6u2ZO8tCLPgyI+iYSsx1GwyYNqtjdVj
vxBmo2n8BafpHrjE3Oydoari9mVJqVLVdGq1w0wwStMv4/HK1+hXBQugEhwvw22a
O9KgFPi0V+cD5A0BozXgXAYcOCmkyruVhSnFeyx2tZaupukBvF9uMWLUcfJ5YLZE
NQkjbDLtQ9oNM+NKjFJCOxUk7QPRpdP05r9rLmKPaeSxL8zaZQsld+38tDsLPCUU
s9zl4sLa7sRNXpFHMyL7Phm2q1eYvpVeQIx4lgk4LitO+y7wO/RLt1yXSUiGX+dr
td94rQrlXqv/0T5JIZyPnrHEi9XdWA/SJIrfADqtkfBywas/n4xRdhMUomvx4tKe
5/cyHHPGuKo57FFSi0IuP60CH3XP1FsbfpjTuGTmvbKn8aFZriftdrIvlgtJcIEW
2EMaqyx4KYWIphakEs00OYrKXaR6YyJRb/q34z3oBv4Jd2Gocre7pKtZBw/RJrSU
BYnm+bk4qFxMNvV0JhL20TraADdTCkRFyDQDlvtU/rviHkwzu3sPEj4VkKjkVgf+
kRVPHkSoVzwho2UGrJdN
=iGzQ
-----END PGP SIGNATURE-----

--ai3I8gwHc37+ASRI--

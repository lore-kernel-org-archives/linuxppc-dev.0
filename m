Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5876F1A01F2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 15:50:04 +1000 (AEST)
Date: Wed, 29 Apr 2015 15:39:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 25/32] vfio: powerpc/spapr:
 powerpc/powernv/ioda2: Rework ownership
Message-ID: <20150429053928.GU32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-26-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Sx3M3By4KbPIrykT"
In-Reply-To: <1429964096-11524-26-git-send-email-aik@ozlabs.ru>
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


--Sx3M3By4KbPIrykT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:49PM +1000, Alexey Kardashevskiy wrote:
> Before the IOMMU user (VFIO) would take control over the IOMMU table
> belonging to a specific IOMMU group. This approach did not allow sharing
> tables between IOMMU groups attached to the same container.
>=20
> This introduces a new IOMMU ownership flavour when the user can not
> just control the existing IOMMU table but remove/create tables on demand.
> If an IOMMU implements take/release_ownership() callbacks, this lets
> the user have full control over the IOMMU group. When the ownership is ta=
ken,
> the platform code removes all the windows so the caller must create them.
> Before returning the ownership back to the platform code, VFIO
> unprograms and removes all the tables it created.
>=20
> This changes IODA2's onwership handler to remove the existing table

"onwership"

> rather than manipulating with the existing one. From now on,
> iommu_take_ownership() and iommu_release_ownership() are only called
> from the vfio_iommu_spapr_tce driver.
>=20
> In tce_iommu_detach_group(), this copies a iommu_table descriptor on stack
> as IODA2's unset_window() will clear the descriptor embedded into PE
> and we will not be able to free the table afterwards.
> This is a transitional hack and following patches will replace this code
> anyway.
>=20
> Old-style ownership is still supported allowing VFIO to run on older
> P5IOC2 and IODA IO controllers.
>=20
> No change in userspace-visible behaviour is expected. Since it recreates
> TCE tables on each ownership change, related kernel traces will appear
> more often.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> Changes:
> v9:
> * fixed crash in tce_iommu_detach_group() on tbl->it_ops->free as
> tce_iommu_attach_group() used to initialize the table from a descriptor
> on stack (it does not matter for the series as this bit is changed later =
anyway
> but it ruing bisectability)
>=20
> v6:
> * fixed commit log that VFIO removes tables before passing ownership
> back to the platform code, not userspace
>=20
> 1
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 27 +++++++++++++++++++++++--
>  drivers/vfio/vfio_iommu_spapr_tce.c       | 33 +++++++++++++++++++++++++=
++++--
>  2 files changed, 56 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 2a4b2b2..45bc131 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2105,16 +2105,39 @@ static void pnv_ioda2_take_ownership(struct iommu=
_table_group *table_group)
>  	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_pe,
>  						table_group);
> =20
> -	iommu_take_ownership(&table_group->tables[0]);
>  	pnv_pci_ioda2_set_bypass(pe, false);
> +	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
> +	pnv_pci_free_table(&pe->table_group.tables[0]);
>  }
> =20
>  static void pnv_ioda2_release_ownership(struct iommu_table_group *table_=
group)
>  {
>  	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_pe,
>  						table_group);
> +	struct iommu_table *tbl =3D &pe->table_group.tables[0];
> +	int64_t rc;
> +
> +	rc =3D pnv_pci_ioda2_create_table(&pe->table_group, 0,
> +			IOMMU_PAGE_SHIFT_4K,
> +			pe->phb->ioda.m32_pci_base,
> +			POWERNV_IOMMU_DEFAULT_LEVELS, tbl);
> +	if (rc) {
> +		pe_err(pe, "Failed to create 32-bit TCE table, err %ld",
> +				rc);
> +		return;
> +	}
> +
> +	tbl->it_table_group =3D &pe->table_group;
> +	iommu_init_table(tbl, pe->phb->hose->node);
> +
> +	rc =3D pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
> +	if (rc) {
> +		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
> +				rc);
> +		pnv_pci_free_table(tbl);
> +		return;
> +	}

It seems like you want a helper function called both here and in the
initial PE setup.  Otherwise you encourage future bugs where the
initial PE setup changes, but taking and releasing IOMMU ownership
=66rom VFIO no longer sets up exactly the same thing again.

> -	iommu_release_ownership(&table_group->tables[0]);
>  	pnv_pci_ioda2_set_bypass(pe, true);
>  }
> =20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 2d51bbf..892a584 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -569,6 +569,10 @@ static int tce_iommu_attach_group(void *iommu_data,
>  	if (!table_group->ops || !table_group->ops->take_ownership ||
>  			!table_group->ops->release_ownership) {
>  		ret =3D tce_iommu_take_ownership(table_group);
> +	} else if (!table_group->ops->create_table ||
> +			!table_group->ops->set_window) {
> +		WARN_ON_ONCE(1);
> +		ret =3D -EFAULT;
>  	} else {
>  		/*
>  		 * Disable iommu bypass, otherwise the user can DMA to all of
> @@ -576,7 +580,15 @@ static int tce_iommu_attach_group(void *iommu_data,
>  		 * the pages that has been explicitly mapped into the iommu
>  		 */
>  		table_group->ops->take_ownership(table_group);
> -		ret =3D 0;
> +		ret =3D table_group->ops->create_table(table_group,
> +				0, /* window number */
> +				IOMMU_PAGE_SHIFT_4K,
> +				table_group->tce32_size,
> +				1, /* default levels */
> +				&table_group->tables[0]);
> +		if (!ret)
> +			ret =3D table_group->ops->set_window(table_group, 0,
> +					&table_group->tables[0]);
>  	}
> =20
>  	if (ret)
> @@ -595,6 +607,7 @@ static void tce_iommu_detach_group(void *iommu_data,
>  {
>  	struct tce_container *container =3D iommu_data;
>  	struct iommu_table_group *table_group;
> +	long i;
> =20
>  	mutex_lock(&container->lock);
>  	if (iommu_group !=3D container->grp) {
> @@ -620,8 +633,24 @@ static void tce_iommu_detach_group(void *iommu_data,
>  	/* Kernel owns the device now, we can restore bypass */
>  	if (!table_group->ops || !table_group->ops->release_ownership)
>  		tce_iommu_release_ownership(container, table_group);
> -	else
> +	else if (!table_group->ops->unset_window)
> +		WARN_ON_ONCE(1);
> +	else {
> +		for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +			struct iommu_table tbl =3D table_group->tables[i];
> +
> +			if (!tbl.it_size)
> +				continue;
> +
> +			table_group->ops->unset_window(table_group, i);
> +			tce_iommu_clear(container, &tbl,
> +					tbl.it_offset, tbl.it_size);
> +			if (tbl.it_ops->free)
> +				tbl.it_ops->free(&tbl);
> +		}
> +
>  		table_group->ops->release_ownership(table_group);
> +	}
> =20
>  unlock_exit:
>  	mutex_unlock(&container->lock);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Sx3M3By4KbPIrykT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQG6QAAoJEGw4ysog2bOSFBcP/1vbjNyTRzzdR1evsjyoDQCD
OFhodqy2SeqbYqpuLx/QzfmV5n+v3OTUF/TyB5llW0g9FL0yYqlaMoHZsKxkPMtf
GV7XLu3BMHkGEj9pnUtjdq1mgEYAZTPu2ll6Tjwo7VHT3an5t30PFQP4emnadafC
2LiwRjif6aKcJahi+aNQmpkMkyo/g+Sm8+0PZVRZMtmwQl8nE4Kw9KMWnaU1R74D
MUvaNNPbGeZVjUQa/cE272Uwu1HUoNDCqjj1QGzVqNwVszcdvU4b1fVJ3brJOyzQ
tew57qGO1drzC3QJV85yneX8L9QMtoPQGuweS2fW1U8WSmaqtiaI/QeK2DMTV28r
gQsV0KmsFvOH3JO4z1khDbbSDl5EN0hlLxgExFJtSE7PSm5uJO/cuN5gf6IJh1O0
/WVnis3KmGEC2ivbRymRwukN+wlkfsXupj8o00xo2NSVIV1vQt4VlfoLO6am+wA/
ZtNWhtZ60hn/NWGJhroY3T0lSi47QZlSDk0/VXrzNOBtGJsmMMKCxiuVkJ6KnSY9
Fb+F/TpV3EPwwCttUzFbjD8p9mFVWhnvaKqN3mS/Nys9iK/rXVF7Zk1x9RTgRHvp
+7kwpgar4aCKVeTezZKFFdHTF3BD4ia+WGSh18D72R79VLrXzK2ePXxslZGghJpv
NBGIGhKgTGCh5i39HYg2
=Cm6s
-----END PGP SIGNATURE-----

--Sx3M3By4KbPIrykT--

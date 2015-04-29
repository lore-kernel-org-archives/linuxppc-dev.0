Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26AC41A0CBE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 13:26:05 +1000 (AEST)
Date: Wed, 29 Apr 2015 13:02:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 13/32] vfio: powerpc/spapr/iommu/powernv/ioda2:
 Rework IOMMU ownership control
Message-ID: <20150429030250.GJ32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-14-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/0U0QBNx7JIUZLHm"
In-Reply-To: <1429964096-11524-14-git-send-email-aik@ozlabs.ru>
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


--/0U0QBNx7JIUZLHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:37PM +1000, Alexey Kardashevskiy wrote:
> This adds tce_iommu_take_ownership() and tce_iommu_release_ownership
> which call in a loop iommu_take_ownership()/iommu_release_ownership()
> for every table on the group. As there is just one now, no change in
> behaviour is expected.
>=20
> At the moment the iommu_table struct has a set_bypass() which enables/
> disables DMA bypass on IODA2 PHB. This is exposed to POWERPC IOMMU code
> which calls this callback when external IOMMU users such as VFIO are
> about to get over a PHB.
>=20
> The set_bypass() callback is not really an iommu_table function but
> IOMMU/PE function. This introduces a iommu_table_group_ops struct and
> adds take_ownership()/release_ownership() callbacks to it which are
> called when an external user takes/releases control over the IOMMU.
>=20
> This replaces set_bypass() with ownership callbacks as it is not
> necessarily just bypass enabling, it can be something else/more
> so let's give it more generic name.
>=20
> The callbacks is implemented for IODA2 only. Other platforms (P5IOC2,
> IODA1) will use the old iommu_take_ownership/iommu_release_ownership API.
> The following patches will replace iommu_take_ownership/
> iommu_release_ownership calls in IODA2 with full IOMMU table release/
> create.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> Changes:
> v9:
> * squashed "vfio: powerpc/spapr: powerpc/iommu: Rework IOMMU ownership co=
ntrol"
> and "vfio: powerpc/spapr: powerpc/powernv/ioda2: Rework IOMMU ownership c=
ontrol"
> into a single patch
> * moved helpers with a loop through tables in a group
> to vfio_iommu_spapr_tce.c to keep the platform code free of IOMMU table
> groups as much as possible
> * added missing tce_iommu_clear() to tce_iommu_release_ownership()
> * replaced the set_ownership(enable) callback with take_ownership() and
> release_ownership()
> ---
>  arch/powerpc/include/asm/iommu.h          | 13 +++++-
>  arch/powerpc/kernel/iommu.c               | 11 ------
>  arch/powerpc/platforms/powernv/pci-ioda.c | 40 +++++++++++++++----
>  drivers/vfio/vfio_iommu_spapr_tce.c       | 66 +++++++++++++++++++++++++=
++----
>  4 files changed, 103 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index fa37519..e63419e 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -93,7 +93,6 @@ struct iommu_table {
>  	unsigned long  it_page_shift;/* table iommu page size */
>  	struct iommu_table_group *it_table_group;
>  	struct iommu_table_ops *it_ops;
> -	void (*set_bypass)(struct iommu_table *tbl, bool enable);
>  };
> =20
>  /* Pure 2^n version of get_order */
> @@ -128,11 +127,23 @@ extern struct iommu_table *iommu_init_table(struct =
iommu_table * tbl,
> =20
>  #define IOMMU_TABLE_GROUP_MAX_TABLES	1
> =20
> +struct iommu_table_group;
> +
> +struct iommu_table_group_ops {
> +	/*
> +	 * Switches ownership from the kernel itself to an external
> +	 * user. While onwership is taken, the kernel cannot use IOMMU itself.

Typo in "onwership".  I'd also like to see this be even more explicit
that "take" is the "core kernel -> vfio/whatever" transition and
release is the reverse. =20

> +	 */
> +	void (*take_ownership)(struct iommu_table_group *table_group);
> +	void (*release_ownership)(struct iommu_table_group *table_group);
> +};
> +
>  struct iommu_table_group {
>  #ifdef CONFIG_IOMMU_API
>  	struct iommu_group *group;
>  #endif
>  	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> +	struct iommu_table_group_ops *ops;
>  };
> =20
>  #ifdef CONFIG_IOMMU_API
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 005146b..2856d27 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1057,13 +1057,6 @@ int iommu_take_ownership(struct iommu_table *tbl)
> =20
>  	memset(tbl->it_map, 0xff, sz);
> =20
> -	/*
> -	 * Disable iommu bypass, otherwise the user can DMA to all of
> -	 * our physical memory via the bypass window instead of just
> -	 * the pages that has been explicitly mapped into the iommu
> -	 */
> -	if (tbl->set_bypass)
> -		tbl->set_bypass(tbl, false);
> =20
>  	return 0;
>  }
> @@ -1078,10 +1071,6 @@ void iommu_release_ownership(struct iommu_table *t=
bl)
>  	/* Restore bit#0 set by iommu_init_table() */
>  	if (tbl->it_offset =3D=3D 0)
>  		set_bit(0, tbl->it_map);
> -
> -	/* The kernel owns the device now, we can restore the iommu bypass */
> -	if (tbl->set_bypass)
> -		tbl->set_bypass(tbl, true);
>  }
>  EXPORT_SYMBOL_GPL(iommu_release_ownership);
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 88472cb..718d5cc 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1870,10 +1870,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_p=
hb *phb,
>  		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
>  }
> =20
> -static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enabl=
e)
> +static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
>  {
> -	struct pnv_ioda_pe *pe =3D container_of(tbl->it_table_group,
> -			struct pnv_ioda_pe, table_group);
>  	uint16_t window_id =3D (pe->pe_number << 1 ) + 1;
>  	int64_t rc;
> =20
> @@ -1901,7 +1899,8 @@ static void pnv_pci_ioda2_set_bypass(struct iommu_t=
able *tbl, bool enable)
>  		 * host side.
>  		 */
>  		if (pe->pdev)
> -			set_iommu_table_base(&pe->pdev->dev, tbl);
> +			set_iommu_table_base(&pe->pdev->dev,
> +					&pe->table_group.tables[0]);
>  		else
>  			pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
>  	}
> @@ -1917,13 +1916,35 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct =
pnv_phb *phb,
>  	/* TVE #1 is selected by PCI address bit 59 */
>  	pe->tce_bypass_base =3D 1ull << 59;
> =20
> -	/* Install set_bypass callback for VFIO */
> -	pe->table_group.tables[0].set_bypass =3D pnv_pci_ioda2_set_bypass;
> -
>  	/* Enable bypass by default */
> -	pnv_pci_ioda2_set_bypass(&pe->table_group.tables[0], true);
> +	pnv_pci_ioda2_set_bypass(pe, true);
>  }
> =20
> +#ifdef CONFIG_IOMMU_API
> +static void pnv_ioda2_take_ownership(struct iommu_table_group *table_gro=
up)
> +{
> +	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_pe,
> +						table_group);
> +
> +	iommu_take_ownership(&table_group->tables[0]);
> +	pnv_pci_ioda2_set_bypass(pe, false);
> +}
> +
> +static void pnv_ioda2_release_ownership(struct iommu_table_group *table_=
group)
> +{
> +	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_pe,
> +						table_group);
> +
> +	iommu_release_ownership(&table_group->tables[0]);
> +	pnv_pci_ioda2_set_bypass(pe, true);
> +}
> +
> +static struct iommu_table_group_ops pnv_pci_ioda2_ops =3D {
> +	.take_ownership =3D pnv_ioda2_take_ownership,
> +	.release_ownership =3D pnv_ioda2_release_ownership,
> +};
> +#endif
> +
>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>  				       struct pnv_ioda_pe *pe)
>  {
> @@ -1991,6 +2012,9 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  	}
>  	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
>  	iommu_init_table(tbl, phb->hose->node);
> +#ifdef CONFIG_IOMMU_API
> +	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
> +#endif
> =20
>  	if (pe->flags & PNV_IODA_PE_DEV) {
>  		iommu_register_group(&pe->table_group, phb->hose->global_number,
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 17e884a..dacc738 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -483,6 +483,43 @@ static long tce_iommu_ioctl(void *iommu_data,
>  	return -ENOTTY;
>  }
> =20
> +static void tce_iommu_release_ownership(struct tce_container *container,
> +		struct iommu_table_group *table_group)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbl =3D &table_group->tables[i];
> +
> +		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> +		if (tbl->it_map)
> +			iommu_release_ownership(tbl);
> +	}
> +}
> +
> +static int tce_iommu_take_ownership(struct iommu_table_group *table_grou=
p)
> +{
> +	int i, j, rc =3D 0;
> +
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbl =3D &table_group->tables[i];
> +
> +		if (!tbl->it_map)
> +			continue;
> +
> +		rc =3D iommu_take_ownership(tbl);
> +		if (rc) {
> +			for (j =3D 0; j < i; ++j)
> +				iommu_release_ownership(
> +						&table_group->tables[j]);
> +
> +			return rc;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int tce_iommu_attach_group(void *iommu_data,
>  		struct iommu_group *iommu_group)
>  {
> @@ -515,9 +552,23 @@ static int tce_iommu_attach_group(void *iommu_data,
>  		goto unlock_exit;
>  	}
> =20
> -	ret =3D iommu_take_ownership(&table_group->tables[0]);
> -	if (!ret)
> -		container->grp =3D iommu_group;
> +	if (!table_group->ops || !table_group->ops->take_ownership ||
> +			!table_group->ops->release_ownership) {
> +		ret =3D tce_iommu_take_ownership(table_group);

Haven't looked at the rest of the series.  I'm hoping that you're
eventually planning to replace this fallback with setting the
take_ownership call for p5ioc etc. to point to
tce_iommu_take_ownership.

> +	} else {
> +		/*
> +		 * Disable iommu bypass, otherwise the user can DMA to all of
> +		 * our physical memory via the bypass window instead of just
> +		 * the pages that has been explicitly mapped into the iommu
> +		 */
> +		table_group->ops->take_ownership(table_group);
> +		ret =3D 0;
> +	}
> +
> +	if (ret)
> +		goto unlock_exit;
> +
> +	container->grp =3D iommu_group;
> =20
>  unlock_exit:
>  	mutex_unlock(&container->lock);
> @@ -530,7 +581,6 @@ static void tce_iommu_detach_group(void *iommu_data,
>  {
>  	struct tce_container *container =3D iommu_data;
>  	struct iommu_table_group *table_group;
> -	struct iommu_table *tbl;
> =20
>  	mutex_lock(&container->lock);
>  	if (iommu_group !=3D container->grp) {
> @@ -553,9 +603,11 @@ static void tce_iommu_detach_group(void *iommu_data,
>  	table_group =3D iommu_group_get_iommudata(iommu_group);
>  	BUG_ON(!table_group);
> =20
> -	tbl =3D &table_group->tables[0];
> -	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> -	iommu_release_ownership(tbl);
> +	/* Kernel owns the device now, we can restore bypass */
> +	if (!table_group->ops || !table_group->ops->release_ownership)
> +		tce_iommu_release_ownership(container, table_group);
> +	else
> +		table_group->ops->release_ownership(table_group);
> =20
>  unlock_exit:
>  	mutex_unlock(&container->lock);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/0U0QBNx7JIUZLHm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQEnaAAoJEGw4ysog2bOSfkgQAMhtY42GPHWKpEl9hRP42SO5
IYf4KmpcfnGJ/A0OVTOU7cJihFjiFAxodexdJANpQPMLQPKJzaveokoyFIDF6KEQ
xn96NHiGse2TOfZf+IObujFEOKZzy4Naeajj8jziT6lfl5SOKzdoxTEydPEPUOOT
0f/ViSIVw1gwUHmR0r4SWmM64scRQSo8rTHjkQ6ZAJhQtMMHsUqK8VGWKLTAEIV+
8yH3QquUHvNQpEFBfToxPe9ZaKITVa6cfBNZIP9ODjaP/spMC0BiKUkmepN7s2I0
KjN/+Pg3zklc+kEEcix5OdUYlWTSaF7wTmkyxexKFtONtYq4kS1KQ1HPIiOkRmSG
qfNJLcPtMFqr1dZ1yWMV7Bknw8LX48AZqWH/klXnWYZbrhazY3rSeNUYoVCSxgJS
rKc8lJeTEsqkWjdo4xnRiuQAk35o4S00u2rxVh9RH6ya66g41lv5uLqArgZKhJjg
fVUZCBDKL17haZR4QI9TcajlwIKRhHaRCE/ofQ/388IvPvJcSkLbo1JvhBJqqJw1
oEdbkPxbWZIk+1Ki+Q47hiJJTqZW2koPgYB3n00vwaqYSZK6337pdPJveA74ONOY
8InQE66lhme4q5BxF0PBgT6NCOMswsfQFJqSWpsH0xSvwVNzNvwcOzjV4C1iAt4G
qoSkytBmQIGC5Nn16xON
=GBeX
-----END PGP SIGNATURE-----

--/0U0QBNx7JIUZLHm--

Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vrv2Z6B6szDq95
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 10:47:02 +1100 (AEDT)
Date: Mon, 27 Mar 2017 09:41:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH guest kernel] powerpc/pseries: Enable VFIO
Message-ID: <20170326224121.GP19078@umbus.fritz.box>
References: <20170324063721.16887-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SlnaBQtdWG0gYnqZ"
In-Reply-To: <20170324063721.16887-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--SlnaBQtdWG0gYnqZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2017 at 05:37:21PM +1100, Alexey Kardashevskiy wrote:
> This enables VFIO on pseries host in order to allow VFIO in nested guest
> under PR KVM or DPDK in a HV guest. This adds support of
> the VFIO_SPAPR_TCE_IOMMU type.
>=20
> This adds exchange() callback to allow TCE updates by the SPAPR TCE IOMMU
> driver in VFIO.
>=20
> This initializes DMA32 window parameters in iommu_table_group as
> as this does not implement VFIO_SPAPR_TCE_v2_IOMMU and
> VFIO_SPAPR_TCE_IOMMU just reuses the existing DMA32 window.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/pseries/iommu.c | 40 ++++++++++++++++++++++++++++=
++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platfo=
rms/pseries/iommu.c
> index 4d757eaa46bf..7c8ed68d727e 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -550,6 +550,7 @@ static void iommu_table_setparms(struct pci_controlle=
r *phb,
>  static void iommu_table_setparms_lpar(struct pci_controller *phb,
>  				      struct device_node *dn,
>  				      struct iommu_table *tbl,
> +				      struct iommu_table_group *table_group,
>  				      const __be32 *dma_window)
>  {
>  	unsigned long offset, size;
> @@ -563,6 +564,9 @@ static void iommu_table_setparms_lpar(struct pci_cont=
roller *phb,
>  	tbl->it_type =3D TCE_PCI;
>  	tbl->it_offset =3D offset >> tbl->it_page_shift;
>  	tbl->it_size =3D size >> tbl->it_page_shift;
> +
> +	table_group->tce32_start =3D offset;
> +	table_group->tce32_size =3D size;
>  }
> =20
>  struct iommu_table_ops iommu_table_pseries_ops =3D {
> @@ -651,8 +655,38 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus=
 *bus)
>  	pr_debug("ISA/IDE, window size is 0x%llx\n", pci->phb->dma_window_size);
>  }
> =20
> +#ifdef CONFIG_IOMMU_API
> +static int tce_exchange_pSeries(struct iommu_table *tbl, long index,
> +		unsigned long *tce, enum dma_data_direction *direction)
> +{
> +	long rc;
> +	unsigned long ioba =3D (unsigned long) index << tbl->it_page_shift;
> +	unsigned long flags, oldtce =3D 0;
> +	u64 proto_tce =3D iommu_direction_to_tce_perm(*direction);
> +	unsigned long newtce =3D *tce | proto_tce;
> +
> +	spin_lock_irqsave(&tbl->large_pool.lock, flags);
> +
> +	rc =3D plpar_tce_get((u64)tbl->it_index, ioba, &oldtce);
> +	if (!rc)
> +		rc =3D plpar_tce_put((u64)tbl->it_index, ioba, newtce);
> +
> +	if (!rc) {
> +		*direction =3D iommu_tce_direction(oldtce);
> +		*tce =3D oldtce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +	}
> +
> +	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
> +
> +	return rc;
> +}
> +#endif
> +
>  struct iommu_table_ops iommu_table_lpar_multi_ops =3D {
>  	.set =3D tce_buildmulti_pSeriesLP,
> +#ifdef CONFIG_IOMMU_API
> +	.exchange =3D tce_exchange_pSeries,
> +#endif
>  	.clear =3D tce_freemulti_pSeriesLP,
>  	.get =3D tce_get_pSeriesLP
>  };
> @@ -689,7 +723,8 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bu=
s *bus)
>  	if (!ppci->table_group) {
>  		ppci->table_group =3D iommu_pseries_alloc_group(ppci->phb->node);
>  		tbl =3D ppci->table_group->tables[0];
> -		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
> +		iommu_table_setparms_lpar(ppci->phb, pdn, tbl,
> +				ppci->table_group, dma_window);
>  		tbl->it_ops =3D &iommu_table_lpar_multi_ops;
>  		iommu_init_table(tbl, ppci->phb->node);
>  		iommu_register_group(ppci->table_group,
> @@ -1143,7 +1178,8 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_=
dev *dev)
>  	if (!pci->table_group) {
>  		pci->table_group =3D iommu_pseries_alloc_group(pci->phb->node);
>  		tbl =3D pci->table_group->tables[0];
> -		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
> +		iommu_table_setparms_lpar(pci->phb, pdn, tbl,
> +				pci->table_group, dma_window);
>  		tbl->it_ops =3D &iommu_table_lpar_multi_ops;
>  		iommu_init_table(tbl, pci->phb->node);
>  		iommu_register_group(pci->table_group,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SlnaBQtdWG0gYnqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2EOOAAoJEGw4ysog2bOS/5sP/0X/fZwJqt5CbyDIURnddEsn
ItsvNhVe2vv4gMB6l3N/dgWjobUV+NFgZjI11t2Rcia0yqLVA0d3hKBcueBisL6i
xTbk9/kn84MngT6c23aW0w/M1p//NSWqn7IO7gqDVx8QFTOvIGFUc3mnZ6z0OiR1
m5BbepHL2YQwT7JlQIzDbYdmKRR5BgK3Is3pMk3VDOPA27oEwmQpqtVbFrs2GDkH
cRKFjugCXkuqDOxb8qtzm+RgBz/D6aB25QNCEWfCBXDuJ2OUMmjjSwPUJEVrv41m
cLKNZFCaowO7owFYplPcScDKhRdbd7mcyqefzewrSUv5s2aQ0p9JV3y0s/8c4aJf
JfPQzYoNgdQCI+IT1F4NYvTdb/lz5PYghYDiGNVjPmEBINA7tu8nFO1BiJG00mt3
L7fyT40FZfzNtwmnLf7yF0C5i1JvlbBAr+g7W/YZAv5j4NZOpBjn5ehfEwambkxK
X4AbdrLb1Y8SeE5rrwGcMX6BvskF2J/fSh1NZ7H53rxnzPm8US5u+dk8P6e4AaCE
VrN6csX0kujoxqOiB/rRDy777bec8aLZ7F8n49mgahPZWJmnz9kaqVFSfhtGQhaj
MGO+e9OnnSlDyohOwvw6ycL5w/U3pEuC6RggwGHOkh6dGFn3rX/EA1PiW3Y3dA5U
vU1HZoACU5Hx195XVhlk
=kxUr
-----END PGP SIGNATURE-----

--SlnaBQtdWG0gYnqZ--

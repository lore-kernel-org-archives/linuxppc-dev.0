Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSj704dYYzDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 14:10:52 +1100 (AEDT)
Date: Wed, 22 Feb 2017 13:23:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Update iommu table base on
 ownership change
Message-ID: <20170222022328.GG12577@umbus.fritz.box>
References: <20170221024131.47753-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vJguvTgX93MxBIIe"
In-Reply-To: <20170221024131.47753-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vJguvTgX93MxBIIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2017 at 01:41:31PM +1100, Alexey Kardashevskiy wrote:
> On POWERNV platform, in order to do DMA via IOMMU (i.e. 32bit DMA in
> our case), a device needs an iommu_table pointer set via
> set_iommu_table_base().
>=20
> The codeflow is:
> - pnv_pci_ioda2_setup_dma_pe()
> 	- pnv_pci_ioda2_setup_default_config()
> 	- pnv_ioda_setup_bus_dma() [1]
>=20
> pnv_pci_ioda2_setup_dma_pe() creates IOMMU groups,
> pnv_pci_ioda2_setup_default_config() does default DMA setup,
> pnv_ioda_setup_bus_dma() takes a bus PE (on IODA2, all physical function
> PEs as bus PEs except NPU), walks through all underlying buses and
> devices, adds all devices to an IOMMU group and sets iommu_table.
>=20
> On IODA2, when VFIO is used, it takes ownership over a PE which means it
> removes all tables and creates new ones (with a possibility of sharing
> them among PEs). So when the ownership is returned from VFIO to
> the kernel, the iommu_table pointer written to a device at [1] is
> stale and needs an update.
>=20
> This adds an "add_to_group" parameter to pnv_ioda_setup_bus_dma()
> (in fact re-adds as it used to be there a while ago for different
> reasons) to tell the helper if a device needs to be added to
> an IOMMU group with an iommu_table update or just the latter.
>=20
> This calls pnv_ioda_setup_bus_dma(..., false) from
> pnv_ioda2_release_ownership() so when the ownership is restored,
> 32bit DMA can work again for a device. This does the same thing
> on obtaining ownership as the iommu_table point is stale at this point
> anyway and it is safer to have NULL there.
>=20
> We did not hit this earlier as all tested devices in recent years were
> only using 64bit DMA; the rare exception for this is MPT3 SAS adapter
> which uses both 32bit and 64bit DMA access and it has not been tested
> with VFIO much.
>=20
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> If this is applied before "powerpc/powernv/npu: Remove dead iommu code",
> there will be a minor conflict.
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 51ec0dc1dfde..f5a2421bf164 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1774,17 +1774,20 @@ static u64 pnv_pci_ioda_dma_get_required_mask(str=
uct pci_dev *pdev)
>  }
> =20
>  static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
> -				   struct pci_bus *bus)
> +				   struct pci_bus *bus,
> +				   bool add_to_group)
>  {
>  	struct pci_dev *dev;
> =20
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
>  		set_dma_offset(&dev->dev, pe->tce_bypass_base);
> -		iommu_add_device(&dev->dev);
> +		if (add_to_group)
> +			iommu_add_device(&dev->dev);
> =20
>  		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
> -			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
> +			pnv_ioda_setup_bus_dma(pe, dev->subordinate,
> +					add_to_group);
>  	}
>  }
> =20
> @@ -2190,7 +2193,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_p=
hb *phb,
>  		set_iommu_table_base(&pe->pdev->dev, tbl);
>  		iommu_add_device(&pe->pdev->dev);
>  	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
> -		pnv_ioda_setup_bus_dma(pe, pe->pbus);
> +		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
> =20
>  	return;
>   fail:
> @@ -2425,6 +2428,8 @@ static void pnv_ioda2_take_ownership(struct iommu_t=
able_group *table_group)
> =20
>  	pnv_pci_ioda2_set_bypass(pe, false);
>  	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
> +	if (pe->pbus)
> +		pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
>  	pnv_ioda2_table_free(tbl);
>  }
> =20
> @@ -2434,6 +2439,8 @@ static void pnv_ioda2_release_ownership(struct iomm=
u_table_group *table_group)
>  						table_group);
> =20
>  	pnv_pci_ioda2_setup_default_config(pe);
> +	if (pe->pbus)
> +		pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
>  }
> =20
>  static struct iommu_table_group_ops pnv_pci_ioda2_ops =3D {
> @@ -2725,7 +2732,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  		return;
> =20
>  	if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
> -		pnv_ioda_setup_bus_dma(pe, pe->pbus);
> +		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
>  }
> =20
>  #ifdef CONFIG_PCI_MSI

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vJguvTgX93MxBIIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrPYdAAoJEGw4ysog2bOSm40P/2TapgSiTnEp+QrWcZ1zPQsi
eA8yBpRZ1HP2c+d1qXFg9ATgAZJ7nx45XKnUPNqVwFmk+3GvoA27XWCIbd4q1jKY
BcDFMyL08D2T/u2jS3Rw9f4RA2Afdz6eWxMS468+Sb4GkfkPa4T6Qwd6C+HevS5S
o4OBSIDQnmkucnu177BVbyXo8QjO7+gb/RSNzcV07JiYpVKgO6qvHCwBWP1EA9Jy
Fcyp1fODCxQWuzIjYcAaNhKrLuP1WgdnobeqQJ4m0v5UMjlLYBzkiLVNdCyCKn2P
/4BBatsRKEy4nuYmtUBr36xjfdYFbOUNjLJJG9hwQvXR186tHCX508iIBPabColX
vQ7E71bxdT5dsdo39pC31p0QfIJiEdHufhoUFXGQd8BQn8Fa5Es+SLdmo1G5Vgz/
FR62WFuHtDiqPigqjimZvkSI9Q4fbzHKZG4qN/OumZYWzpEAj5pICWJMrvSk9yP5
qhmN/NBSymxgcYLHvMLtT83YmUg5ryWaXirFhgGUz+bQ4RFib5Sdw3Qf0Bfawmxk
hPsPxrLnf6gLcnO1pgbvDKnInff1UaNQJxWqLfnj/cAxUoU+yIYYGv4SZrPuIz65
4OLvATlklcqsoeFifrHsezbYgDFo9yBbE2GX24P97LSZUObRygE2aenHmLvLeOuZ
yCw3N3y5QVvekPyHr3LD
=C5E9
-----END PGP SIGNATURE-----

--vJguvTgX93MxBIIe--

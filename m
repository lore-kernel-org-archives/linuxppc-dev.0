Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT3HQ27pNzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 15:48:18 +1100 (AEDT)
Date: Mon, 21 Mar 2016 15:48:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel 08/10] powerpc/powernv/npu: Add NPU devices to
 IOMMU group
Message-ID: <20160321044810.GG23586@voom.redhat.com>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
 <1457504946-40649-9-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zGQnqpIoxlsbsOfg"
In-Reply-To: <1457504946-40649-9-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--zGQnqpIoxlsbsOfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 05:29:04PM +1100, Alexey Kardashevskiy wrote:
> NPU devices have their own TVT which means they are isolated and can be
> passed to the userspace via VFIO. The first step is to create an IOMMU
> group and attach devices there so does the patch.
>=20
> This adds a helper to npu-dma.c which gets GPU from the NPU's pdev and
> then walks through all devices on the same bus to determine which NPUs
> belong to the same GPU.
>=20
> This adds an additional loop over PEs in pnv_ioda_setup_dma() as the main
> loop skips NPU PEs as they do not have 32bit DMA segments.
>=20
> This uses get_gpu_pci_dev_and_pe() to get @gpdev rather than
> pnv_pci_get_gpu_dev() as the following patch will use @gpe as well.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

I'm not entirely clear on how these devices are assigned to groups.
Do they each get their own groups, or is the NPU device in the same
group as its corresponding GPU (I would have thought the latter makes
sense).

> ---
>  arch/powerpc/platforms/powernv/npu-dma.c  | 40 +++++++++++++++++++++++++=
++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c |  8 +++++++
>  arch/powerpc/platforms/powernv/pci.h      |  1 +
>  3 files changed, 49 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/plat=
forms/powernv/npu-dma.c
> index 866d3d3..e5a5feb 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -263,3 +263,43 @@ void pnv_npu_try_dma_set_bypass(struct pci_dev *gpde=
v, bool bypass)
>  		}
>  	}
>  }
> +
> +void pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
> +{
> +	struct iommu_table *tbl;
> +	struct pnv_phb *phb =3D npe->phb;
> +	struct pci_bus *pbus =3D phb->hose->bus;
> +	struct pci_dev *npdev, *gpdev =3D NULL, *gptmp;
> +	struct pnv_ioda_pe *gpe =3D get_gpu_pci_dev_and_pe(npe, &gpdev);
> +
> +	if (!gpe || !gpdev)
> +		return;
> +
> +	iommu_register_group(&npe->table_group, phb->hose->global_number,
> +			npe->pe_number);
> +
> +	tbl =3D pnv_pci_table_alloc(phb->hose->node);
> +
> +	list_for_each_entry(npdev, &pbus->devices, bus_list) {
> +		gptmp =3D pnv_pci_get_gpu_dev(npdev);
> +
> +		if (gptmp !=3D gpdev)
> +			continue;
> +
> +		/*
> +		 * The iommu_add_device() picks an IOMMU group from
> +		 * the first IOMMU group attached to the iommu_table
> +		 * so we need to pretend that there is a table so
> +		 * iommu_add_device() can complete the job.
> +		 * We unlink the tempopary table from the group afterwards.
> +		 */
> +		pnv_pci_link_table_and_group(phb->hose->node, 0,
> +				tbl, &npe->table_group);
> +		set_iommu_table_base(&npdev->dev, tbl);
> +		iommu_add_device(&npdev->dev);
> +		set_iommu_table_base(&npdev->dev, NULL);
> +		pnv_pci_unlink_table_and_group(tbl, &npe->table_group);
> +	}
> +
> +	iommu_free_table(tbl, "");
> +}
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 5a6cf2e..becd168 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2570,6 +2570,14 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>  		remaining -=3D segs;
>  		base +=3D segs;
>  	}
> +	/*
> +	 * Create an IOMMU group and add devices to it.
> +	 * DMA setup is to be done via GPU's dma_set_mask().
> +	 */
> +	if (phb->type =3D=3D PNV_PHB_NPU) {
> +		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link)
> +			pnv_pci_npu_setup_iommu(pe);
> +	}
>  }
> =20
>  #ifdef CONFIG_PCI_MSI
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 06405fd..0c0083a 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -235,5 +235,6 @@ extern void pnv_teardown_msi_irqs(struct pci_dev *pde=
v);
>  /* Nvlink functions */
>  extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypas=
s);
>  extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, boo=
l rm);
> +extern void pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
> =20
>  #endif /* __POWERNV_PCI_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zGQnqpIoxlsbsOfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW730KAAoJEGw4ysog2bOSwb0QANSx6Jhs6Kx7c0bNqG+Xooqu
w3dG53n+ZEOAIVr56573tyxgTKxhb2ht30JslGV0sB/6EzGr+e60UCmmlYLQAx+Z
uYUPEZ9U9nCYIU5D89LjnIIktIdhKP52DuhANiXfa9i/DoWPxPYHCRgqquboRbxR
ReVC2PHhpDTe6DMW+eAaDgDZ/COQVbR8BJogBug/8Cz+GudXtoQBANg8JCWQqmfD
l1dsOb3pes18Ywa8VQibR+S5Mf5NHYftVvLIBhj/6RHyqq5PcIH/VL715ti8zS5W
XoEx7LYZdVTZhoQC9mmA8tIym/2XLzX4dw57lAWtQbDcyT9tmNxZqIzohkTjmAez
re1U7jHibCeQOvMHMf/KcPIqKught8n4niWwAJJHk+N8TNOBIYQJzS5+zH1m9yTe
WSWCw7KOjlpZ37PX0Pqkspu0fotfXz/G4Za7IuBVUCb6BDD63/COxXoYXITaYlcE
GDiNYXrfPVDGg8cjiLRJm3nTErNfiTqcDPwHuPMVKG5fX6DZOzWkofYBnI7aANmV
Gdke+hhk6ce0eP4XjTQHf2HLH49EcPuuzfL+eyDKC3Ipj9kgeXHjo/t43ol3rDrc
YRn5Cj7FD9D/bkSH4mEkq4W02SMi+/s4fUCR+f6IkpTV50c/wuD2Uxs34CXSkcwf
tELrpOt2hfMnkcaIrEpA
=H2Hr
-----END PGP SIGNATURE-----

--zGQnqpIoxlsbsOfg--

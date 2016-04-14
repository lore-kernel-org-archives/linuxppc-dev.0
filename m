Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlkCN5y8MzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 11:50:40 +1000 (AEST)
Date: Thu, 14 Apr 2016 11:40:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel 2/2] powerpc/powernv/ioda2: Delay PE disposal
Message-ID: <20160414014033.GD18218@voom.redhat.com>
References: <1460097404-35422-1-git-send-email-aik@ozlabs.ru>
 <1460097404-35422-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
In-Reply-To: <1460097404-35422-3-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2016 at 04:36:44PM +1000, Alexey Kardashevskiy wrote:
> When SRIOV is disabled, the existing code presumes there is no
> virtual function (VF) in use and destroys all associated PEs.
> However it is possible to get into the situation when the user
> activated SRIOV disabling while a VF is still in use via VFIO.
> For example, unbinding a physical function (PF) while there is a guest
> running with a VF passed throuhgh via VFIO will trigger the bug.
>=20
> This defines an IODA2-specific IOMMU group release() callback.
> This moves all the disposal code from pnv_ioda_release_vf_PE() to this
> new callback so the cleanup happens when the last user of an IOMMU
> group released the reference.
>=20
> As pnv_pci_ioda2_release_dma_pe() was reduced to just calling
> iommu_group_put(), this merges pnv_pci_ioda2_release_dma_pe()
> into pnv_ioda_release_vf_PE().
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 33 +++++++++++++------------=
------
>  1 file changed, 14 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index ce9f2bf..8108c54 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1333,27 +1333,25 @@ static void pnv_pci_ioda2_set_bypass(struct pnv_i=
oda_pe *pe, bool enable);
>  static void pnv_pci_ioda2_group_release(void *iommu_data)
>  {
>  	struct iommu_table_group *table_group =3D iommu_data;
> +	struct pnv_ioda_pe *pe =3D container_of(table_group,
> +			struct pnv_ioda_pe, table_group);
> +	struct pci_controller *hose =3D pci_bus_to_host(pe->parent_dev->bus);
> +	struct pnv_phb *phb =3D hose->private_data;
> +	struct iommu_table *tbl =3D pe->table_group.tables[0];
> +	int64_t rc;
> =20
> -	table_group->group =3D NULL;
> -}
> -
> -static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv=
_ioda_pe *pe)
> -{
> -	struct iommu_table    *tbl;
> -	int64_t               rc;
> -
> -	tbl =3D pe->table_group.tables[0];
>  	rc =3D pnv_pci_ioda2_unset_window(&pe->table_group, 0);

Is it safe to go manipulating the PE windows, etc. after SR-IOV is
disabled?

When SR-IOV is disabled, you need to immediately disable the VF (I'm
guessing that happens somewhere) and stop all access to the VF
"hardware".  Only the iommu group structure *has* to stick around
until the reference count drops to zero.  I think other structures and
hardware reconfiguration can be deferred or done immediately,
whichever is more convenient.

>  	if (rc)
>  		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
> =20
>  	pnv_pci_ioda2_set_bypass(pe, false);
> -	if (pe->table_group.group) {
> -		iommu_group_put(pe->table_group.group);
> -		BUG_ON(pe->table_group.group);
> -	}
> +
> +	BUG_ON(!tbl);
>  	pnv_pci_ioda2_table_free_pages(tbl);
> -	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
> +	iommu_free_table(tbl, of_node_full_name(pe->parent_dev->dev.of_node));
> +
> +	pnv_ioda_deconfigure_pe(phb, pe);
> +	pnv_ioda_free_pe(phb, pe->pe_number);
>  }
> =20
>  static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
> @@ -1376,16 +1374,13 @@ static void pnv_ioda_release_vf_PE(struct pci_dev=
 *pdev)
>  		if (pe->parent_dev !=3D pdev)
>  			continue;
> =20
> -		pnv_pci_ioda2_release_dma_pe(pdev, pe);
> -
>  		/* Remove from list */
>  		mutex_lock(&phb->ioda.pe_list_mutex);
>  		list_del(&pe->list);
>  		mutex_unlock(&phb->ioda.pe_list_mutex);
> =20
> -		pnv_ioda_deconfigure_pe(phb, pe);
> -
> -		pnv_ioda_free_pe(phb, pe->pe_number);
> +		if (pe->table_group.group)
> +			iommu_group_put(pe->table_group.group);
>  	}
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDvURAAoJEGw4ysog2bOSPpwQAObqgEYaHdI5ffR5/W6XCRbx
3+OivrAIAKN7tnH0nYNko8tE2mkCFpTg9rjEA6pXKS+KCi0gVoC6KU/PuKI7GcEk
9QRO9rmuAT/9lN4BZJ4J+DRU6p0Dh63//O0Unaw3SIP9EaOEhWe1BrIBnOnHfjLo
18h/nmfB1/ZprAukjt4kt0wPGzOmaff8yb1mp+AVsIcdMOv7BzeUFCFuCxHV77LZ
2rnzz0ZPY5Fc7pAv3jr3NG9Wx9r9XnCwjZf2XUoU+so31KNRKiLCvTBmLF3QPsb+
zbWeTZgVyoH/ClOkVEJZ2IoM9mQN+RNPAxRCUO6QttdBGCrqWEpNRSnD1KDtru72
92FoZG04QEUXaL9vKQHaegGe6md5lyD5+eotu16vPXnMMeVJAjhjyP4RxnhjQLyV
V3p3lD+AHLH3tm5cPKZtyhXjHPi96MfL/IJqGk7qN2Q2tWVXpv5wG2kAeABWYmo5
hvPtmnlIvJDFDV9Xh92f7l0O3zKEV7gOfI53PsysRFxl+Gz3kQtggHe2eMMLDkdt
XfXwMeA+rtpzQkHXHvxPaZePSAHIqhxx1dZ9Jz7vdSH97w4cRSJ/NfZJSm3/PNq3
T1zuqELKAf9dEndx5cURypsqrf/vrHwnlnD69JqoMk3AhjAw5btpJh57mmABId/t
0X21GDoAZV/EKzvh7LsK
=X+UA
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--

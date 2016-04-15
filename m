Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmMVs12h9zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 12:51:17 +1000 (AEST)
Date: Fri, 15 Apr 2016 12:26:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel 2/2] powerpc/powernv/ioda2: Delay PE disposal
Message-ID: <20160415022643.GF18218@voom.redhat.com>
References: <1460097404-35422-1-git-send-email-aik@ozlabs.ru>
 <1460097404-35422-3-git-send-email-aik@ozlabs.ru>
 <20160414014033.GD18218@voom.redhat.com>
 <571043FC.8040509@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
In-Reply-To: <571043FC.8040509@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2016 at 11:29:32AM +1000, Alexey Kardashevskiy wrote:
> On 04/14/2016 11:40 AM, David Gibson wrote:
> >On Fri, Apr 08, 2016 at 04:36:44PM +1000, Alexey Kardashevskiy wrote:
> >>When SRIOV is disabled, the existing code presumes there is no
> >>virtual function (VF) in use and destroys all associated PEs.
> >>However it is possible to get into the situation when the user
> >>activated SRIOV disabling while a VF is still in use via VFIO.
> >>For example, unbinding a physical function (PF) while there is a guest
> >>running with a VF passed throuhgh via VFIO will trigger the bug.
> >>
> >>This defines an IODA2-specific IOMMU group release() callback.
> >>This moves all the disposal code from pnv_ioda_release_vf_PE() to this
> >>new callback so the cleanup happens when the last user of an IOMMU
> >>group released the reference.
> >>
> >>As pnv_pci_ioda2_release_dma_pe() was reduced to just calling
> >>iommu_group_put(), this merges pnv_pci_ioda2_release_dma_pe()
> >>into pnv_ioda_release_vf_PE().
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>  arch/powerpc/platforms/powernv/pci-ioda.c | 33 +++++++++++++---------=
---------
> >>  1 file changed, 14 insertions(+), 19 deletions(-)
> >>
> >>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> >>index ce9f2bf..8108c54 100644
> >>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>@@ -1333,27 +1333,25 @@ static void pnv_pci_ioda2_set_bypass(struct pnv=
_ioda_pe *pe, bool enable);
> >>  static void pnv_pci_ioda2_group_release(void *iommu_data)
> >>  {
> >>  	struct iommu_table_group *table_group =3D iommu_data;
> >>+	struct pnv_ioda_pe *pe =3D container_of(table_group,
> >>+			struct pnv_ioda_pe, table_group);
> >>+	struct pci_controller *hose =3D pci_bus_to_host(pe->parent_dev->bus);
> >>+	struct pnv_phb *phb =3D hose->private_data;
> >>+	struct iommu_table *tbl =3D pe->table_group.tables[0];
> >>+	int64_t rc;
> >>
> >>-	table_group->group =3D NULL;
> >>-}
> >>-
> >>-static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct p=
nv_ioda_pe *pe)
> >>-{
> >>-	struct iommu_table    *tbl;
> >>-	int64_t               rc;
> >>-
> >>-	tbl =3D pe->table_group.tables[0];
> >>  	rc =3D pnv_pci_ioda2_unset_window(&pe->table_group, 0);
> >
> >Is it safe to go manipulating the PE windows, etc. after SR-IOV is
> >disabled?
>=20
> Manipulating windows in this case is just updating 8 bytes in the TVT. At
> this point a VF is expected to be destroyed but PE is expected to remain =
not
> free so pnv_ioda2_pick_m64_pe() (or pnv_ioda2_reserve_m64_pe()?) won't use
> it.

Ok.

> >When SR-IOV is disabled, you need to immediately disable the VF (I'm
> >guessing that happens somewhere) and stop all access to the VF
> >"hardware".
>=20
> drivers/pci/iov.c
> =3D=3D=3D
> static void sriov_disable(struct pci_dev *dev)
> {
> ...
> for (i =3D 0; i < iov->num_VFs; i++)
>         pci_iov_remove_virtfn(dev, i, 0);
> ...
> pcibios_sriov_disable(dev);
> =3D=3D=3D
>=20
> pcibios_sriov_disable() is where pnv_pci_ioda2_release_dma_pe() is called=
 from.
>=20
> >Only the iommu group structure *has* to stick around
> >until the reference count drops to zero.  I think other structures and
> >hardware reconfiguration can be deferred or done immediately,
> >whichever is more convenient.
>=20
> I deferred everything because of convenience as iommu_table_group is
> embedded into pnv_ioda struct, not a pointer.

Ok.


With those queries answered,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> >>  	if (rc)
> >>  		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
> >>
> >>  	pnv_pci_ioda2_set_bypass(pe, false);
> >>-	if (pe->table_group.group) {
> >>-		iommu_group_put(pe->table_group.group);
> >>-		BUG_ON(pe->table_group.group);
> >>-	}
> >>+
> >>+	BUG_ON(!tbl);
> >>  	pnv_pci_ioda2_table_free_pages(tbl);
> >>-	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
> >>+	iommu_free_table(tbl, of_node_full_name(pe->parent_dev->dev.of_node));
> >>+
> >>+	pnv_ioda_deconfigure_pe(phb, pe);
> >>+	pnv_ioda_free_pe(phb, pe->pe_number);
> >>  }
> >>
> >>  static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
> >>@@ -1376,16 +1374,13 @@ static void pnv_ioda_release_vf_PE(struct pci_d=
ev *pdev)
> >>  		if (pe->parent_dev !=3D pdev)
> >>  			continue;
> >>
> >>-		pnv_pci_ioda2_release_dma_pe(pdev, pe);
> >>-
> >>  		/* Remove from list */
> >>  		mutex_lock(&phb->ioda.pe_list_mutex);
> >>  		list_del(&pe->list);
> >>  		mutex_unlock(&phb->ioda.pe_list_mutex);
> >>
> >>-		pnv_ioda_deconfigure_pe(phb, pe);
> >>-
> >>-		pnv_ioda_free_pe(phb, pe->pe_number);
> >>+		if (pe->table_group.group)
> >>+			iommu_group_put(pe->table_group.group);
> >>  	}
> >>  }
> >>
> >
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXEFFjAAoJEGw4ysog2bOSMeoQAN1TMXAL16PO8Gc4yUHjpMFo
hNw+Gxdtx2Z8mskhRoZZfl1y5wFB0lDVdSuO+CUi07QTL857VQlPxkF9muz84Cv2
sEemuoBfk9KsR5W3vRObfwZAn3iyrTeGkZLuJiVKnbr9qr6GsE+LOFdjL8JhPrdM
qhInW0XxsNrH88Vxi85PcegbFVuK4uXAVdGOSMXYRCOe6gUKXiMO95+d8mYg2Fxd
LB8rBKOistOW0l/qIatHGjDs+fFZF3thFRegUOg7P6PIj68v5xAS7zPn2sn9IUBu
HpltmK5OeRjAWDbK9ElT8KWJZXCIYxOC1DfL5R2BfIW5hkg7nBlXck1yhHke61kL
EGwXHNLAnCAhX1Ifp+ePfhYU7Emi/ONdiwjO9G3xFgSN4xFi/TpFBGKz6GvSCdyB
SwDDUAo5wywDoEjQNLxNFnVdWA/DwBl1TxCEzvGQMDAQtnICksm8kbwLqYTBtMvb
k1t9f8VCufcuQ/MBEzQck0SZaVgfLT/9rLpA9lbZ3JdTJFXpukfqK9jpBel1HJMu
FNkPHKu7N1hyqe+o6SPIUzyH9zSwfBUlDALhfYzBThffQyb/F+IfIhzciUeF2CbM
p3kiVrXDCrJjoqU9Yl3IQ6rQPNo0fxKO63XFgtYpnAsc/r4FAU4zj5ZOJW30CWeZ
yiAVBBbjEgygTkfBKKwA
=hk/H
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--

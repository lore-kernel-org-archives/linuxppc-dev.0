Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTYNm43JvzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 11:24:40 +1100 (AEDT)
Date: Tue, 22 Mar 2016 11:25:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel 08/10] powerpc/powernv/npu: Add NPU devices to
 IOMMU group
Message-ID: <20160322002550.GR23586@voom.redhat.com>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
 <1457504946-40649-9-git-send-email-aik@ozlabs.ru>
 <20160321044810.GG23586@voom.redhat.com>
 <56EFAFF3.5090404@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dO6Thh8T/cwyDjv9"
In-Reply-To: <56EFAFF3.5090404@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dO6Thh8T/cwyDjv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 21, 2016 at 07:25:23PM +1100, Alexey Kardashevskiy wrote:
> On 03/21/2016 03:48 PM, David Gibson wrote:
> >On Wed, Mar 09, 2016 at 05:29:04PM +1100, Alexey Kardashevskiy wrote:
> >>NPU devices have their own TVT which means they are isolated and can be
> >>passed to the userspace via VFIO. The first step is to create an IOMMU
> >>group and attach devices there so does the patch.
> >>
> >>This adds a helper to npu-dma.c which gets GPU from the NPU's pdev and
> >>then walks through all devices on the same bus to determine which NPUs
> >>belong to the same GPU.
> >>
> >>This adds an additional loop over PEs in pnv_ioda_setup_dma() as the ma=
in
> >>loop skips NPU PEs as they do not have 32bit DMA segments.
> >>
> >>This uses get_gpu_pci_dev_and_pe() to get @gpdev rather than
> >>pnv_pci_get_gpu_dev() as the following patch will use @gpe as well.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >
> >I'm not entirely clear on how these devices are assigned to groups.
> >Do they each get their own groups, or is the NPU device in the same
> >group as its corresponding GPU (I would have thought the latter makes
> >sense).
>=20
>=20
> I am putting them to a separate group as they have their own TCE table
> pointer even though they are expected to share it with GPU.

Hmm.. is this safe?  If the GPU and NPU got assigned to different
owners, what would happen?  Could the interfere with each other?

> If I put them to the same group as GPUs, I would have to have
> IODA2-linked-to-NPU bridge type with different iommu_table_group_ops  or
> have multiple hacks everywhere in IODA2 to enable/disable bypass,
> etc.

Well.. I suspect it would mean no longer having a 1:1 correspondance
between user-visible IOMMU groups and the internal iommu_table.

> >>---
> >>  arch/powerpc/platforms/powernv/npu-dma.c  | 40 ++++++++++++++++++++++=
+++++++++
> >>  arch/powerpc/platforms/powernv/pci-ioda.c |  8 +++++++
> >>  arch/powerpc/platforms/powernv/pci.h      |  1 +
> >>  3 files changed, 49 insertions(+)
> >>
> >>diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/pl=
atforms/powernv/npu-dma.c
> >>index 866d3d3..e5a5feb 100644
> >>--- a/arch/powerpc/platforms/powernv/npu-dma.c
> >>+++ b/arch/powerpc/platforms/powernv/npu-dma.c
> >>@@ -263,3 +263,43 @@ void pnv_npu_try_dma_set_bypass(struct pci_dev *gp=
dev, bool bypass)
> >>  		}
> >>  	}
> >>  }
> >>+
> >>+void pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
> >>+{
> >>+	struct iommu_table *tbl;
> >>+	struct pnv_phb *phb =3D npe->phb;
> >>+	struct pci_bus *pbus =3D phb->hose->bus;
> >>+	struct pci_dev *npdev, *gpdev =3D NULL, *gptmp;
> >>+	struct pnv_ioda_pe *gpe =3D get_gpu_pci_dev_and_pe(npe, &gpdev);
> >>+
> >>+	if (!gpe || !gpdev)
> >>+		return;
> >>+
> >>+	iommu_register_group(&npe->table_group, phb->hose->global_number,
> >>+			npe->pe_number);
> >>+
> >>+	tbl =3D pnv_pci_table_alloc(phb->hose->node);
> >>+
> >>+	list_for_each_entry(npdev, &pbus->devices, bus_list) {
> >>+		gptmp =3D pnv_pci_get_gpu_dev(npdev);
> >>+
> >>+		if (gptmp !=3D gpdev)
> >>+			continue;
> >>+
> >>+		/*
> >>+		 * The iommu_add_device() picks an IOMMU group from
> >>+		 * the first IOMMU group attached to the iommu_table
> >>+		 * so we need to pretend that there is a table so
> >>+		 * iommu_add_device() can complete the job.
> >>+		 * We unlink the tempopary table from the group afterwards.
> >>+		 */
> >>+		pnv_pci_link_table_and_group(phb->hose->node, 0,
> >>+				tbl, &npe->table_group);
> >>+		set_iommu_table_base(&npdev->dev, tbl);
> >>+		iommu_add_device(&npdev->dev);
> >>+		set_iommu_table_base(&npdev->dev, NULL);
> >>+		pnv_pci_unlink_table_and_group(tbl, &npe->table_group);
> >>+	}
> >>+
> >>+	iommu_free_table(tbl, "");
> >>+}
> >>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> >>index 5a6cf2e..becd168 100644
> >>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>@@ -2570,6 +2570,14 @@ static void pnv_ioda_setup_dma(struct pnv_phb *p=
hb)
> >>  		remaining -=3D segs;
> >>  		base +=3D segs;
> >>  	}
> >>+	/*
> >>+	 * Create an IOMMU group and add devices to it.
> >>+	 * DMA setup is to be done via GPU's dma_set_mask().
> >>+	 */
> >>+	if (phb->type =3D=3D PNV_PHB_NPU) {
> >>+		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link)
> >>+			pnv_pci_npu_setup_iommu(pe);
> >>+	}
> >>  }
> >>
> >>  #ifdef CONFIG_PCI_MSI
> >>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platfo=
rms/powernv/pci.h
> >>index 06405fd..0c0083a 100644
> >>--- a/arch/powerpc/platforms/powernv/pci.h
> >>+++ b/arch/powerpc/platforms/powernv/pci.h
> >>@@ -235,5 +235,6 @@ extern void pnv_teardown_msi_irqs(struct pci_dev *p=
dev);
> >>  /* Nvlink functions */
> >>  extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool by=
pass);
> >>  extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, =
bool rm);
> >>+extern void pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
> >>
> >>  #endif /* __POWERNV_PCI_H */
> >
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dO6Thh8T/cwyDjv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW8JEOAAoJEGw4ysog2bOSru4QAOAbaEmKif2IcLhIj4BgvDCj
WSwCoVT2q8W4PzQSFsqM0RiHDi1Jn/NmfTcka7haZBv39jiuyU6q3XSE6ZOD4rLy
6PBszMXZQK8CGmeINb9O9hHwTrLRLwLFl4nGWllFGhOZ1AocD0+ab+TFJakmiYCC
vG3kTBJVFeeewlZ+7bTR4BfXyt52JR9F3Zk1RQssj+vAgWd4TgCIIa4/pFoCfNgN
ec9SfJPDL0nm3PQIzzdTeCKj4UJG2GW//fo94Cm+8TDfrVJQHO45q63oNmXYV8I/
fc1rqs6rJhKIVPOyU+HyQYedA+evUnGaIpo3EZnGGoPUGBl6eQy5zPYLtjyK2a1x
z3oN2Cet5rgASNJb24lwFADuhHr20XicMF1QcK/GcMCACZBByuO4W5VX5Th1AhyY
44iln6izalx9k8lzTLHMgzoqlqcaPBCn1SRkXub4IqLDLJBNXXvgyYRjX8ThIbmI
8/K2rhyBRusR1VEXk1cm8b96P0b6Vu7tuWavtlIs4iyChyXC32hSiMtotsCswS8o
1tyNbWH9VIOIntoeay6cbvLFLNZZr6PD72cWHUNbubAUMLutPMxcTjabJJGf6g74
WnDLHZ0c023O3jLKm8UxmlyJXc+4EgOT4YYMVSTyQnJm3Xof17LNNe7GbnHnWzAU
W6oEppd12tmxxYMNJgOz
=Y069
-----END PGP SIGNATURE-----

--dO6Thh8T/cwyDjv9--

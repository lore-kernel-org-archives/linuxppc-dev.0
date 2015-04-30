Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B63341A04B2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 14:37:59 +1000 (AEST)
Date: Thu, 30 Apr 2015 14:08:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 13/32] vfio: powerpc/spapr/iommu/powernv/ioda2:
 Rework IOMMU ownership control
Message-ID: <20150430040828.GB15238@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-14-git-send-email-aik@ozlabs.ru>
 <20150429030250.GJ32589@voom.redhat.com>
 <5540A237.6070007@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
In-Reply-To: <5540A237.6070007@ozlabs.ru>
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


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2015 at 07:19:51PM +1000, Alexey Kardashevskiy wrote:
> On 04/29/2015 01:02 PM, David Gibson wrote:
> >On Sat, Apr 25, 2015 at 10:14:37PM +1000, Alexey Kardashevskiy wrote:
> >>This adds tce_iommu_take_ownership() and tce_iommu_release_ownership
> >>which call in a loop iommu_take_ownership()/iommu_release_ownership()
> >>for every table on the group. As there is just one now, no change in
> >>behaviour is expected.
> >>
> >>At the moment the iommu_table struct has a set_bypass() which enables/
> >>disables DMA bypass on IODA2 PHB. This is exposed to POWERPC IOMMU code
> >>which calls this callback when external IOMMU users such as VFIO are
> >>about to get over a PHB.
> >>
> >>The set_bypass() callback is not really an iommu_table function but
> >>IOMMU/PE function. This introduces a iommu_table_group_ops struct and
> >>adds take_ownership()/release_ownership() callbacks to it which are
> >>called when an external user takes/releases control over the IOMMU.
> >>
> >>This replaces set_bypass() with ownership callbacks as it is not
> >>necessarily just bypass enabling, it can be something else/more
> >>so let's give it more generic name.
> >>
> >>The callbacks is implemented for IODA2 only. Other platforms (P5IOC2,
> >>IODA1) will use the old iommu_take_ownership/iommu_release_ownership AP=
I.
> >>The following patches will replace iommu_take_ownership/
> >>iommu_release_ownership calls in IODA2 with full IOMMU table release/
> >>create.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>[aw: for the vfio related changes]
> >>Acked-by: Alex Williamson <alex.williamson@redhat.com>
> >>---
> >>Changes:
> >>v9:
> >>* squashed "vfio: powerpc/spapr: powerpc/iommu: Rework IOMMU ownership =
control"
> >>and "vfio: powerpc/spapr: powerpc/powernv/ioda2: Rework IOMMU ownership=
 control"
> >>into a single patch
> >>* moved helpers with a loop through tables in a group
> >>to vfio_iommu_spapr_tce.c to keep the platform code free of IOMMU table
> >>groups as much as possible
> >>* added missing tce_iommu_clear() to tce_iommu_release_ownership()
> >>* replaced the set_ownership(enable) callback with take_ownership() and
> >>release_ownership()
> >>---
> >>  arch/powerpc/include/asm/iommu.h          | 13 +++++-
> >>  arch/powerpc/kernel/iommu.c               | 11 ------
> >>  arch/powerpc/platforms/powernv/pci-ioda.c | 40 +++++++++++++++----
> >>  drivers/vfio/vfio_iommu_spapr_tce.c       | 66 ++++++++++++++++++++++=
+++++----
> >>  4 files changed, 103 insertions(+), 27 deletions(-)
> >>
> >>diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/as=
m/iommu.h
> >>index fa37519..e63419e 100644
> >>--- a/arch/powerpc/include/asm/iommu.h
> >>+++ b/arch/powerpc/include/asm/iommu.h
> >>@@ -93,7 +93,6 @@ struct iommu_table {
> >>  	unsigned long  it_page_shift;/* table iommu page size */
> >>  	struct iommu_table_group *it_table_group;
> >>  	struct iommu_table_ops *it_ops;
> >>-	void (*set_bypass)(struct iommu_table *tbl, bool enable);
> >>  };
> >>
> >>  /* Pure 2^n version of get_order */
> >>@@ -128,11 +127,23 @@ extern struct iommu_table *iommu_init_table(struc=
t iommu_table * tbl,
> >>
> >>  #define IOMMU_TABLE_GROUP_MAX_TABLES	1
> >>
> >>+struct iommu_table_group;
> >>+
> >>+struct iommu_table_group_ops {
> >>+	/*
> >>+	 * Switches ownership from the kernel itself to an external
> >>+	 * user. While onwership is taken, the kernel cannot use IOMMU itself.
> >
> >Typo in "onwership".  I'd also like to see this be even more explicit
> >that "take" is the "core kernel -> vfio/whatever" transition and
> >release is the reverse.
>=20
>=20
> Will this work?
>=20
> /*
>  * Switches ownership from the kernel itself to an external
>  * user.
>  * The ownership is taken when VFIO starts using the IOMMU group
>  * and released when the platform code gets the control over the group ba=
ck.
>  * While ownership is taken, the platform code cannot use IOMMU itself.
>  */

Hrm, verbose and still doesn't emphasise the point that always
confuses me enough.  I'd prefer:

/* Switch ownership from platform code to external user (e.g. VFIO) */

above "take" then

/* Switch ownership from external user (e.g. VFIO) back to core */

above "release"..

>=20
>=20
> >>+	 */
> >>+	void (*take_ownership)(struct iommu_table_group *table_group);
> >>+	void (*release_ownership)(struct iommu_table_group *table_group);
> >>+};
> >>+
> >>  struct iommu_table_group {
> >>  #ifdef CONFIG_IOMMU_API
> >>  	struct iommu_group *group;
> >>  #endif
> >>  	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> >>+	struct iommu_table_group_ops *ops;
> >>  };
> >>
> >>  #ifdef CONFIG_IOMMU_API
> >>diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> >>index 005146b..2856d27 100644
> >>--- a/arch/powerpc/kernel/iommu.c
> >>+++ b/arch/powerpc/kernel/iommu.c
> >>@@ -1057,13 +1057,6 @@ int iommu_take_ownership(struct iommu_table *tbl)
> >>
> >>  	memset(tbl->it_map, 0xff, sz);
> >>
> >>-	/*
> >>-	 * Disable iommu bypass, otherwise the user can DMA to all of
> >>-	 * our physical memory via the bypass window instead of just
> >>-	 * the pages that has been explicitly mapped into the iommu
> >>-	 */
> >>-	if (tbl->set_bypass)
> >>-		tbl->set_bypass(tbl, false);
> >>
> >>  	return 0;
> >>  }
> >>@@ -1078,10 +1071,6 @@ void iommu_release_ownership(struct iommu_table =
*tbl)
> >>  	/* Restore bit#0 set by iommu_init_table() */
> >>  	if (tbl->it_offset =3D=3D 0)
> >>  		set_bit(0, tbl->it_map);
> >>-
> >>-	/* The kernel owns the device now, we can restore the iommu bypass */
> >>-	if (tbl->set_bypass)
> >>-		tbl->set_bypass(tbl, true);
> >>  }
> >>  EXPORT_SYMBOL_GPL(iommu_release_ownership);
> >>
> >>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> >>index 88472cb..718d5cc 100644
> >>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>@@ -1870,10 +1870,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv=
_phb *phb,
> >>  		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
> >>  }
> >>
> >>-static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool ena=
ble)
> >>+static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enab=
le)
> >>  {
> >>-	struct pnv_ioda_pe *pe =3D container_of(tbl->it_table_group,
> >>-			struct pnv_ioda_pe, table_group);
> >>  	uint16_t window_id =3D (pe->pe_number << 1 ) + 1;
> >>  	int64_t rc;
> >>
> >>@@ -1901,7 +1899,8 @@ static void pnv_pci_ioda2_set_bypass(struct iommu=
_table *tbl, bool enable)
> >>  		 * host side.
> >>  		 */
> >>  		if (pe->pdev)
> >>-			set_iommu_table_base(&pe->pdev->dev, tbl);
> >>+			set_iommu_table_base(&pe->pdev->dev,
> >>+					&pe->table_group.tables[0]);
> >>  		else
> >>  			pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
> >>  	}
> >>@@ -1917,13 +1916,35 @@ static void pnv_pci_ioda2_setup_bypass_pe(struc=
t pnv_phb *phb,
> >>  	/* TVE #1 is selected by PCI address bit 59 */
> >>  	pe->tce_bypass_base =3D 1ull << 59;
> >>
> >>-	/* Install set_bypass callback for VFIO */
> >>-	pe->table_group.tables[0].set_bypass =3D pnv_pci_ioda2_set_bypass;
> >>-
> >>  	/* Enable bypass by default */
> >>-	pnv_pci_ioda2_set_bypass(&pe->table_group.tables[0], true);
> >>+	pnv_pci_ioda2_set_bypass(pe, true);
> >>  }
> >>
> >>+#ifdef CONFIG_IOMMU_API
> >>+static void pnv_ioda2_take_ownership(struct iommu_table_group *table_g=
roup)
> >>+{
> >>+	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_=
pe,
> >>+						table_group);
> >>+
> >>+	iommu_take_ownership(&table_group->tables[0]);
> >>+	pnv_pci_ioda2_set_bypass(pe, false);
> >>+}
> >>+
> >>+static void pnv_ioda2_release_ownership(struct iommu_table_group *tabl=
e_group)
> >>+{
> >>+	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_=
pe,
> >>+						table_group);
> >>+
> >>+	iommu_release_ownership(&table_group->tables[0]);
> >>+	pnv_pci_ioda2_set_bypass(pe, true);
> >>+}
> >>+
> >>+static struct iommu_table_group_ops pnv_pci_ioda2_ops =3D {
> >>+	.take_ownership =3D pnv_ioda2_take_ownership,
> >>+	.release_ownership =3D pnv_ioda2_release_ownership,
> >>+};
> >>+#endif
> >>+
> >>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> >>  				       struct pnv_ioda_pe *pe)
> >>  {
> >>@@ -1991,6 +2012,9 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
_phb *phb,
> >>  	}
> >>  	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
> >>  	iommu_init_table(tbl, phb->hose->node);
> >>+#ifdef CONFIG_IOMMU_API
> >>+	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
> >>+#endif
> >>
> >>  	if (pe->flags & PNV_IODA_PE_DEV) {
> >>  		iommu_register_group(&pe->table_group, phb->hose->global_number,
> >>diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_io=
mmu_spapr_tce.c
> >>index 17e884a..dacc738 100644
> >>--- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>@@ -483,6 +483,43 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>  	return -ENOTTY;
> >>  }
> >>
> >>+static void tce_iommu_release_ownership(struct tce_container *containe=
r,
> >>+		struct iommu_table_group *table_group)
> >>+{
> >>+	int i;
> >>+
> >>+	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> >>+		struct iommu_table *tbl =3D &table_group->tables[i];
> >>+
> >>+		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> >>+		if (tbl->it_map)
> >>+			iommu_release_ownership(tbl);
> >>+	}
> >>+}
> >>+
> >>+static int tce_iommu_take_ownership(struct iommu_table_group *table_gr=
oup)
> >>+{
> >>+	int i, j, rc =3D 0;
> >>+
> >>+	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> >>+		struct iommu_table *tbl =3D &table_group->tables[i];
> >>+
> >>+		if (!tbl->it_map)
> >>+			continue;
> >>+
> >>+		rc =3D iommu_take_ownership(tbl);
> >>+		if (rc) {
> >>+			for (j =3D 0; j < i; ++j)
> >>+				iommu_release_ownership(
> >>+						&table_group->tables[j]);
> >>+
> >>+			return rc;
> >>+		}
> >>+	}
> >>+
> >>+	return 0;
> >>+}
> >>+
> >>  static int tce_iommu_attach_group(void *iommu_data,
> >>  		struct iommu_group *iommu_group)
> >>  {
> >>@@ -515,9 +552,23 @@ static int tce_iommu_attach_group(void *iommu_data,
> >>  		goto unlock_exit;
> >>  	}
> >>
> >>-	ret =3D iommu_take_ownership(&table_group->tables[0]);
> >>-	if (!ret)
> >>-		container->grp =3D iommu_group;
> >>+	if (!table_group->ops || !table_group->ops->take_ownership ||
> >>+			!table_group->ops->release_ownership) {
> >>+		ret =3D tce_iommu_take_ownership(table_group);
> >
> >Haven't looked at the rest of the series.  I'm hoping that you're
> >eventually planning to replace this fallback with setting the
> >take_ownership call for p5ioc etc. to point to
> >tce_iommu_take_ownership.
>=20
>=20
> Why? I do not really want p5ioc2 or ioda1 to have
> take_ownership/release_ownership callbacks defined as they will only do t=
his
> default stuff which is not going to change ever as this hardware is quite
> old and extremely rare so there is no real customer for it. Should I still
> convert these to callbacks?

Leave it for now - having this fallback makes more sense in light of
the changes later in the series that I hadn't read when I made the
comment.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQaq8AAoJEGw4ysog2bOSkEIP/2goqV9qmwRPPJj34KMCVVLD
hcEn3vXT9zqjVheG8MtkclX5lNFBodM2zsjGtepqokhVbZS6Aun9EbxN9TKXC0SB
C1Fk0bQABOYFS7ATXnQPhYwwP+J7FK4mNi4cKOQTWdSQf9HBgGNto6piuzPcOf7s
ZB+Y9M+Bt0QmGS1d85SuPf/vEWWgplMP6TEJEL1GpM8pkl4ML7F9ATkWxVRLEvgP
9zTLhsi7+ipMC51bcCsr6swJpxG3at+xiZXl7k9CU3SefrPd30m8+ohSgNDv2HS5
VLKnYNxm3iuMDU0Y/hx83GHoo4S5CksaCgFxNJOe3HTgUbq1yRCTpVqTyLbc0F2V
mib3QcpAVwYYoj9mv1l1bv6vSiRRWXS33+z7Scut7YefQ2eAHrjTXvmx7mOP1uo7
Zr0acYDmD56Msr6fqzebN7Cji8sm/4/USxue4rf7jQGu1qjmRHX7ByQ8Cf+b1D+m
R9v60n+sdeijQlV2ZcAGzMddcCxyOIB0afklpRJSUWVBkFo1RHh0LRbXKpgi0k6Q
qxdgzO6cUUhfKERnOGrLI57MoPjFt/TK2p14H6BVF0QW3RKRlW4Qks87YRWNX2Og
nZsFInFOJMB9E0FNU8XLYoBxGBh7On21eSwumh6IQVQlv/elkC7o/VYrm8vn7hnw
QwwUkhkR7f0lTPuxo77r
=0gzQ
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--

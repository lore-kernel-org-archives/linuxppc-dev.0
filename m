Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0EFA01A0DEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 19:43:17 +1000 (AEST)
Date: Tue, 21 Apr 2015 19:43:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 14/31] vfio: powerpc/spapr:
 powerpc/powernv/ioda2: Rework IOMMU ownership control
Message-ID: <20150421094307.GG31815@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-15-git-send-email-aik@ozlabs.ru>
 <20150416060703.GE3632@voom.redhat.com>
 <5530DBD9.9090004@ozlabs.ru> <20150420024446.GD10218@voom>
 <5534A2E4.8090109@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
In-Reply-To: <5534A2E4.8090109@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2015 at 04:55:32PM +1000, Alexey Kardashevskiy wrote:
> On 04/20/2015 12:44 PM, David Gibson wrote:
> >On Fri, Apr 17, 2015 at 08:09:29PM +1000, Alexey Kardashevskiy wrote:
> >>On 04/16/2015 04:07 PM, David Gibson wrote:
> >>>On Fri, Apr 10, 2015 at 04:30:56PM +1000, Alexey Kardashevskiy wrote:
> >>>>At the moment the iommu_table struct has a set_bypass() which enables/
> >>>>disables DMA bypass on IODA2 PHB. This is exposed to POWERPC IOMMU co=
de
> >>>>which calls this callback when external IOMMU users such as VFIO are
> >>>>about to get over a PHB.
> >>>>
> >>>>The set_bypass() callback is not really an iommu_table function but
> >>>>IOMMU/PE function. This introduces a iommu_table_group_ops struct and
> >>>>adds a set_ownership() callback to it which is called when an external
> >>>>user takes control over the IOMMU.
> >>>
> >>>Do you really need separate ops structures at both the single table
> >>>and table group level?  The different tables in a group will all
> >>>belong to the same basic iommu won't they?
> >>
> >>
> >>IOMMU tables exist alone in VIO. Also, the platform code uses just a ta=
ble
> >>(or it is in bypass mode) and does not care about table groups. It look=
ed
> >>more clean for myself to keep them separated. Should I still merge
> >>those?
> >
> >Ok, that sounds like a reasonable argument for keeping them separate,
> >at least for now.
> >
> >>>>This renames set_bypass() to set_ownership() as it is not necessarily
> >>>>just enabling bypassing, it can be something else/more so let's give =
it
> >>>>more generic name. The bool parameter is inverted.
> >>>>
> >>>>The callback is implemented for IODA2 only. Other platforms (P5IOC2,
> >>>>IODA1) will use the old iommu_take_ownership/iommu_release_ownership =
API.
> >>>>
> >>>>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>---
> >>>>  arch/powerpc/include/asm/iommu.h          | 14 +++++++++++++-
> >>>>  arch/powerpc/platforms/powernv/pci-ioda.c | 30 ++++++++++++++++++++=
++--------
> >>>>  drivers/vfio/vfio_iommu_spapr_tce.c       | 25 ++++++++++++++++++++=
+----
> >>>>  3 files changed, 56 insertions(+), 13 deletions(-)
> >>>>
> >>>>diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/=
asm/iommu.h
> >>>>index b9e50d3..d1f8c6c 100644
> >>>>--- a/arch/powerpc/include/asm/iommu.h
> >>>>+++ b/arch/powerpc/include/asm/iommu.h
> >>>>@@ -92,7 +92,6 @@ struct iommu_table {
> >>>>  	unsigned long  it_page_shift;/* table iommu page size */
> >>>>  	struct iommu_table_group *it_group;
> >>>>  	struct iommu_table_ops *it_ops;
> >>>>-	void (*set_bypass)(struct iommu_table *tbl, bool enable);
> >>>>  };
> >>>>
> >>>>  /* Pure 2^n version of get_order */
> >>>>@@ -127,11 +126,24 @@ extern struct iommu_table *iommu_init_table(str=
uct iommu_table * tbl,
> >>>>
> >>>>  #define IOMMU_TABLE_GROUP_MAX_TABLES	1
> >>>>
> >>>>+struct iommu_table_group;
> >>>>+
> >>>>+struct iommu_table_group_ops {
> >>>>+	/*
> >>>>+	 * Switches ownership from the kernel itself to an external
> >>>>+	 * user. While onwership is enabled, the kernel cannot use IOMMU
> >>>>+	 * for itself.
> >>>>+	 */
> >>>>+	void (*set_ownership)(struct iommu_table_group *table_group,
> >>>>+			bool enable);
> >>>
> >>>The meaning of "enable" in a function called "set_ownership" is
> >>>entirely obscure.
> >>
> >>Suggest something better please :) I have nothing better...
> >
> >Well, given it's "set_ownershuip" you could have "owner" - that would
> >want to be an enum with OWNER_KERNEL and OWNER_VFIO or something
> >rather than a bool.
>=20
>=20
> It is iommu_take_ownership() in upstream and it is assumed that the owner=
 is
> anything but the platform code (for now and probably for ever - VFIO). I =
am
> not changing this now, just using same naming approach when adding a
> callback with a similar name.

So "enabled" is actually that non kernel ownership is enabled.  That
is totally non-obvious.

> >Or you could leave it a bool but call it "allow_bypass".
>=20
> Commented below.
>=20
> >>>>+};
> >>>>+
> >>>>  struct iommu_table_group {
> >>>>  #ifdef CONFIG_IOMMU_API
> >>>>  	struct iommu_group *group;
> >>>>  #endif
> >>>>  	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> >>>>+	struct iommu_table_group_ops *ops;
> >>>>  };
> >>>>
> >>>>  #ifdef CONFIG_IOMMU_API
> >>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc=
/platforms/powernv/pci-ioda.c
> >>>>index a964c50..9687731 100644
> >>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>>>@@ -1255,10 +1255,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct p=
nv_phb *phb,
> >>>>  		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
> >>>>  }
> >>>>
> >>>>-static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool e=
nable)
> >>>>+static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool en=
able)
> >>>>  {
> >>>>-	struct pnv_ioda_pe *pe =3D container_of(tbl->it_group, struct pnv_i=
oda_pe,
> >>>>-					      table_group);
> >>>>  	uint16_t window_id =3D (pe->pe_number << 1 ) + 1;
> >>>>  	int64_t rc;
> >>>>
> >>>>@@ -1286,7 +1284,8 @@ static void pnv_pci_ioda2_set_bypass(struct iom=
mu_table *tbl, bool enable)
> >>>>  		 * host side.
> >>>>  		 */
> >>>>  		if (pe->pdev)
> >>>>-			set_iommu_table_base(&pe->pdev->dev, tbl);
> >>>>+			set_iommu_table_base(&pe->pdev->dev,
> >>>>+					&pe->table_group.tables[0]);
> >>>>  		else
> >>>>  			pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
> >>>>  	}
> >>>>@@ -1302,13 +1301,27 @@ static void pnv_pci_ioda2_setup_bypass_pe(str=
uct pnv_phb *phb,
> >>>>  	/* TVE #1 is selected by PCI address bit 59 */
> >>>>  	pe->tce_bypass_base =3D 1ull << 59;
> >>>>
> >>>>-	/* Install set_bypass callback for VFIO */
> >>>>-	pe->table_group.tables[0].set_bypass =3D pnv_pci_ioda2_set_bypass;
> >>>>-
> >>>>  	/* Enable bypass by default */
> >>>>-	pnv_pci_ioda2_set_bypass(&pe->table_group.tables[0], true);
> >>>>+	pnv_pci_ioda2_set_bypass(pe, true);
> >>>>  }
> >>>>
> >>>>+static void pnv_ioda2_set_ownership(struct iommu_table_group *table_=
group,
> >>>>+				     bool enable)
> >>>>+{
> >>>>+	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_iod=
a_pe,
> >>>>+						table_group);
> >>>>+	if (enable)
> >>>>+		iommu_take_ownership(table_group);
> >>>>+	else
> >>>>+		iommu_release_ownership(table_group);
> >>>>+
> >>>>+	pnv_pci_ioda2_set_bypass(pe, !enable);
> >>>>+}
> >>>>+
> >>>>+static struct iommu_table_group_ops pnv_pci_ioda2_ops =3D {
> >>>>+	.set_ownership =3D pnv_ioda2_set_ownership,
> >>>>+};
> >>>>+
> >>>>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> >>>>  				       struct pnv_ioda_pe *pe)
> >>>>  {
> >>>>@@ -1376,6 +1389,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct p=
nv_phb *phb,
> >>>>  	}
> >>>>  	tbl->it_ops =3D &pnv_iommu_ops;
> >>>>  	iommu_init_table(tbl, phb->hose->node);
> >>>>+	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
> >>>>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
> >>>>  			pe->pe_number);
> >>>>
> >>>>diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_=
iommu_spapr_tce.c
> >>>>index 9f38351..d5d8c50 100644
> >>>>--- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>>+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>>@@ -535,9 +535,22 @@ static int tce_iommu_attach_group(void *iommu_da=
ta,
> >>>>  		goto unlock_exit;
> >>>>  	}
> >>>>
> >>>>-	ret =3D iommu_take_ownership(table_group);
> >>>>-	if (!ret)
> >>>>-		container->grp =3D iommu_group;
> >>>>+	if (!table_group->ops || !table_group->ops->set_ownership) {
> >>>>+		ret =3D iommu_take_ownership(table_group);
> >>>>+	} else {
> >>>>+		/*
> >>>>+		 * Disable iommu bypass, otherwise the user can DMA to all of
> >>>>+		 * our physical memory via the bypass window instead of just
> >>>>+		 * the pages that has been explicitly mapped into the iommu
> >>>>+		 */
> >>>>+		table_group->ops->set_ownership(table_group, true);
> >>>
> >>>And here to disable bypass you call it with enable=3Dtrue, so it doesn=
't
> >>>even have the same meaning as it used to.
> >>
> >>
> >>I do not disable bypass per se (even if it what set_ownership(true) doe=
s) as
> >>it is IODA business and VFIO has no idea about it. I do take control ov=
er
> >>the group. I am not following you here - what used to have the same
> >>meaning?
> >
> >Well, in set_bypass, the enable parameter was whether bypass was
> >enabled.  Here you're setting enable to true, when you want to
> >*disable* bypass (in the existing case).  If the "enable" parameter
> >isn't about enabling bypass, it's meaning is even more confusing than
> >I thought.
>=20
>=20
> Its meaning is "take ownership over the group". In this patch
> set_ownership(true) means set_bypass(false).

Ok.  So "take_ownership" isn't quite as clear as I'd like, but it's
not too bad because it's implied that it's the caller that's taking
the ownership.  *set* ownership makes no sense without saying who the
new owner is.  "enable" has no clear meaning in that context.

Calling it "kernel_owned" or "non_kernel_owned" would be ok if a bit
clunky.

> But later (in 25/31) set_ownership(true) becomes unset(windows0) +
> free(table0) + set_bypass(false) =3D clear DMA setup for the group (i.e.
> invalidate both TVTs) so it is not just about bypass (which is TVT#1 but =
not
> TVT#0) anymore.

Right, I have no problem with a combined function for the operation
here.  It's purely a naming thing "set_ownership" and "enable" are
just not concepts that fit together sensibly.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVNhurAAoJEGw4ysog2bOS32AP/i/JbBnkFLUFOIduUHYNXeYK
Xcn2lcrwEjnOEVxmeMpGBIoWNzG9yU8pOXWJU8DFBP3zeBNzR9K5Y2qowQRVXhp1
WGCPhON4HG7laKO94401izNhmC7StBHupvOwZ/jUCxGmNT0kQNoiEPexSCB1QdL5
Ti3//FPRYiYrALiOeiSipFx71U+VNaia+ujUK+8ceM/tu2+nv4htZwnBGbMidvuG
GCiXAm5fGYFL/Zq6zfzlvvlL151WrmQdTyJcbmVtjfswy6L+ssnEKbZT6THDR72S
kjaKY8x5tjK0cN+BDmcqoHAkAOxdn6d3bhikbzsJNNzCyhMZJtbNbwkibLgK+FJl
RRrBpaIBHDJeW5IweWY4fIKOB1iXqPOcsF3ojoFwnhOZCgIEPMCTavMU6O9kg/LP
2iCbAy2v5UGCWKqxIhcpoMenGv77bxgI/JCEhFtkNaPs962vxOGWGJGL1HfvEfgc
Z4PhE0MTSyE1FBI54EAn6ju8yL7aCpqunkq5B4HnJjQ6X0GMbPlwFFk8Du9DS6HK
k+3TIxUTw1KUZoS4skjWnbq9TVM1AO76V7nhymc8oDlBR414+v4j88uzMHc/YFHL
JHO/txqRAfcaQFTGw4hvyNdaYsI4u74SHzkB2UBRPIUDLH4pNZhhySg9oP+n5Deu
ied5jmH0cbrx1ZT3xts+
=i6Ln
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--

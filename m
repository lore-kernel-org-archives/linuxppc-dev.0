Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74C911A2C4D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 16:02:53 +1000 (AEST)
Date: Mon, 20 Apr 2015 12:44:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 14/31] vfio: powerpc/spapr:
 powerpc/powernv/ioda2: Rework IOMMU ownership control
Message-ID: <20150420024446.GD10218@voom>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-15-git-send-email-aik@ozlabs.ru>
 <20150416060703.GE3632@voom.redhat.com>
 <5530DBD9.9090004@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
In-Reply-To: <5530DBD9.9090004@ozlabs.ru>
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


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2015 at 08:09:29PM +1000, Alexey Kardashevskiy wrote:
> On 04/16/2015 04:07 PM, David Gibson wrote:
> >On Fri, Apr 10, 2015 at 04:30:56PM +1000, Alexey Kardashevskiy wrote:
> >>At the moment the iommu_table struct has a set_bypass() which enables/
> >>disables DMA bypass on IODA2 PHB. This is exposed to POWERPC IOMMU code
> >>which calls this callback when external IOMMU users such as VFIO are
> >>about to get over a PHB.
> >>
> >>The set_bypass() callback is not really an iommu_table function but
> >>IOMMU/PE function. This introduces a iommu_table_group_ops struct and
> >>adds a set_ownership() callback to it which is called when an external
> >>user takes control over the IOMMU.
> >
> >Do you really need separate ops structures at both the single table
> >and table group level?  The different tables in a group will all
> >belong to the same basic iommu won't they?
>=20
>=20
> IOMMU tables exist alone in VIO. Also, the platform code uses just a table
> (or it is in bypass mode) and does not care about table groups. It looked
> more clean for myself to keep them separated. Should I still merge
> those?

Ok, that sounds like a reasonable argument for keeping them separate,
at least for now.

> >>This renames set_bypass() to set_ownership() as it is not necessarily
> >>just enabling bypassing, it can be something else/more so let's give it
> >>more generic name. The bool parameter is inverted.
> >>
> >>The callback is implemented for IODA2 only. Other platforms (P5IOC2,
> >>IODA1) will use the old iommu_take_ownership/iommu_release_ownership AP=
I.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>  arch/powerpc/include/asm/iommu.h          | 14 +++++++++++++-
> >>  arch/powerpc/platforms/powernv/pci-ioda.c | 30 ++++++++++++++++++++++=
--------
> >>  drivers/vfio/vfio_iommu_spapr_tce.c       | 25 +++++++++++++++++++++-=
---
> >>  3 files changed, 56 insertions(+), 13 deletions(-)
> >>
> >>diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/as=
m/iommu.h
> >>index b9e50d3..d1f8c6c 100644
> >>--- a/arch/powerpc/include/asm/iommu.h
> >>+++ b/arch/powerpc/include/asm/iommu.h
> >>@@ -92,7 +92,6 @@ struct iommu_table {
> >>  	unsigned long  it_page_shift;/* table iommu page size */
> >>  	struct iommu_table_group *it_group;
> >>  	struct iommu_table_ops *it_ops;
> >>-	void (*set_bypass)(struct iommu_table *tbl, bool enable);
> >>  };
> >>
> >>  /* Pure 2^n version of get_order */
> >>@@ -127,11 +126,24 @@ extern struct iommu_table *iommu_init_table(struc=
t iommu_table * tbl,
> >>
> >>  #define IOMMU_TABLE_GROUP_MAX_TABLES	1
> >>
> >>+struct iommu_table_group;
> >>+
> >>+struct iommu_table_group_ops {
> >>+	/*
> >>+	 * Switches ownership from the kernel itself to an external
> >>+	 * user. While onwership is enabled, the kernel cannot use IOMMU
> >>+	 * for itself.
> >>+	 */
> >>+	void (*set_ownership)(struct iommu_table_group *table_group,
> >>+			bool enable);
> >
> >The meaning of "enable" in a function called "set_ownership" is
> >entirely obscure.
>=20
> Suggest something better please :) I have nothing better...

Well, given it's "set_ownershuip" you could have "owner" - that would
want to be an enum with OWNER_KERNEL and OWNER_VFIO or something
rather than a bool.

Or you could leave it a bool but call it "allow_bypass".

>=20
>=20
> >
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
> >>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> >>index a964c50..9687731 100644
> >>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>@@ -1255,10 +1255,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv=
_phb *phb,
> >>  		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
> >>  }
> >>
> >>-static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool ena=
ble)
> >>+static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enab=
le)
> >>  {
> >>-	struct pnv_ioda_pe *pe =3D container_of(tbl->it_group, struct pnv_iod=
a_pe,
> >>-					      table_group);
> >>  	uint16_t window_id =3D (pe->pe_number << 1 ) + 1;
> >>  	int64_t rc;
> >>
> >>@@ -1286,7 +1284,8 @@ static void pnv_pci_ioda2_set_bypass(struct iommu=
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
> >>@@ -1302,13 +1301,27 @@ static void pnv_pci_ioda2_setup_bypass_pe(struc=
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
> >>+static void pnv_ioda2_set_ownership(struct iommu_table_group *table_gr=
oup,
> >>+				     bool enable)
> >>+{
> >>+	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_=
pe,
> >>+						table_group);
> >>+	if (enable)
> >>+		iommu_take_ownership(table_group);
> >>+	else
> >>+		iommu_release_ownership(table_group);
> >>+
> >>+	pnv_pci_ioda2_set_bypass(pe, !enable);
> >>+}
> >>+
> >>+static struct iommu_table_group_ops pnv_pci_ioda2_ops =3D {
> >>+	.set_ownership =3D pnv_ioda2_set_ownership,
> >>+};
> >>+
> >>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> >>  				       struct pnv_ioda_pe *pe)
> >>  {
> >>@@ -1376,6 +1389,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
_phb *phb,
> >>  	}
> >>  	tbl->it_ops =3D &pnv_iommu_ops;
> >>  	iommu_init_table(tbl, phb->hose->node);
> >>+	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
> >>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
> >>  			pe->pe_number);
> >>
> >>diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_io=
mmu_spapr_tce.c
> >>index 9f38351..d5d8c50 100644
> >>--- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>@@ -535,9 +535,22 @@ static int tce_iommu_attach_group(void *iommu_data,
> >>  		goto unlock_exit;
> >>  	}
> >>
> >>-	ret =3D iommu_take_ownership(table_group);
> >>-	if (!ret)
> >>-		container->grp =3D iommu_group;
> >>+	if (!table_group->ops || !table_group->ops->set_ownership) {
> >>+		ret =3D iommu_take_ownership(table_group);
> >>+	} else {
> >>+		/*
> >>+		 * Disable iommu bypass, otherwise the user can DMA to all of
> >>+		 * our physical memory via the bypass window instead of just
> >>+		 * the pages that has been explicitly mapped into the iommu
> >>+		 */
> >>+		table_group->ops->set_ownership(table_group, true);
> >
> >And here to disable bypass you call it with enable=3Dtrue, so it doesn't
> >even have the same meaning as it used to.
>=20
>=20
> I do not disable bypass per se (even if it what set_ownership(true) does)=
 as
> it is IODA business and VFIO has no idea about it. I do take control over
> the group. I am not following you here - what used to have the same
> meaning?

Well, in set_bypass, the enable parameter was whether bypass was
enabled.  Here you're setting enable to true, when you want to
*disable* bypass (in the existing case).  If the "enable" parameter
isn't about enabling bypass, it's meaning is even more confusing than
I thought.

> >Plus, you should fold the logic to call the callback if necessary into
> >iommu_take_ownership().
>=20
>=20
> I really want to keep VFIO stuff out of arch/powerpc/kernel/iommu.c as mu=
ch
> as possible as it is for platform DMA/IOMMU, not VFIO (which got SPAPR
> driver for that). ops->set_ownership() is one of these things.

What's VFIO specific about this fragment - it's just if you have the
callback, call it, otherwise fall back to the default.

> iommu_take_ownership()/iommu_release_ownership() are helpers for old-style
> commercially-unsupported P5IOC2/IODA1, and this is kind of a hack while
> ops->set_ownership() is an interface for VFIO to do dynamic windows thing.

Can you put their logic into a set_ownership callback for IODA1 then?

> If it makes sense, I could fold the previous patch into this one and move
> iommu_take_ownership()/iommu_release_ownership() to vfio_iommu_spapr_tce.=
c,
> should I? Or leave things are they are now.

That sounds like it might make sense.

>=20
>=20
> >>+		ret =3D 0;
> >>+	}
> >>+
> >>+	if (ret)
> >>+		goto unlock_exit;
> >>+
> >>+	container->grp =3D iommu_group;
> >>
> >>  unlock_exit:
> >>  	mutex_unlock(&container->lock);
> >>@@ -572,7 +585,11 @@ static void tce_iommu_detach_group(void *iommu_dat=
a,
> >>  	table_group =3D iommu_group_get_iommudata(iommu_group);
> >>  	BUG_ON(!table_group);
> >>
> >>-	iommu_release_ownership(table_group);
> >>+	/* Kernel owns the device now, we can restore bypass */
> >>+	if (!table_group->ops || !table_group->ops->set_ownership)
> >>+		iommu_release_ownership(table_group);
> >>+	else
> >>+		table_group->ops->set_ownership(table_group, false);
> >
> >Likewise fold this if into iommu_release_ownership().
> >
> >>  unlock_exit:
> >>  	mutex_unlock(&container->lock);
> >
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVNGgdAAoJEGw4ysog2bOSzBIQANbdJWb2gs3f2JntFMwSL/Sd
TrtXA0RidvBEMQ4ZqLii1go2wFrCoixi9T2IvuBOL+hHvRdulrAGSZGx0orxvLNc
Eu4+B0oLfVkb2AhR1fwBHONNDBc5nmhdYMMNhOvHduH/CLFThn9fTrKpx+SToGqZ
/4dVnc1r2QBAwM94MBbpWtxulk2z0eYlbcDXkY09HYi/QnuLi2XvvIxII6QsB86V
rPUAUxkFWknqHAe9IDirJJ7ZNr1g5dryAMdRTsQhL1oNZgdPjbgiXwvEpL5Wp6WR
OERd6Dy6OacnqU2+8+IJIBnw3Q4IyueRDzlYHLJG+s4p1db95YXFhtJaqsqRKqEi
oq2jQJmiEc4HrSAOIxUcIF71o+pWX+eulzCPOnzIV4mAglNImwXhqGaZk0T5bM89
ud6/LD7Re2GRWLqrZPQxz7HjngaRDLj1CvBG0z2xgSbpMO04VPmMyGOpLQzNQuJg
2Gu5bKTLg0ZrItuwctvYuTNFw3h4wsKFGa/TZ6BORRIWywyJZIz9CK+X2X9ZMnjk
Om33KM/gtJJwRstOdHKSizmqXTV6xo4k38VpooTxxt4JkeGkIwpgYDC7+TQ72ksi
3JWhhMZ8twOck+ZNY6Ufb42dUhFdqRBbP8Agyzg+piu4kx1BOeK1frwKASoyDvRL
gkARkrUh28pxlNtuGOHS
=9RX9
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--

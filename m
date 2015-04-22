Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ABE1A02D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 15:22:57 +1000 (AEST)
Date: Wed, 22 Apr 2015 15:22:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 14/31] vfio: powerpc/spapr:
 powerpc/powernv/ioda2: Rework IOMMU ownership control
Message-ID: <20150422052241.GJ31815@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-15-git-send-email-aik@ozlabs.ru>
 <20150416060703.GE3632@voom.redhat.com>
 <5530DBD9.9090004@ozlabs.ru> <20150420024446.GD10218@voom>
 <5534A2E4.8090109@ozlabs.ru>
 <20150421094307.GG31815@voom.redhat.com>
 <553638EA.7060701@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0FRtVia6Q6lt+M0P"
In-Reply-To: <553638EA.7060701@ozlabs.ru>
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


--0FRtVia6Q6lt+M0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2015 at 09:47:54PM +1000, Alexey Kardashevskiy wrote:
> On 04/21/2015 07:43 PM, David Gibson wrote:
> >On Mon, Apr 20, 2015 at 04:55:32PM +1000, Alexey Kardashevskiy wrote:
> >>On 04/20/2015 12:44 PM, David Gibson wrote:
> >>>On Fri, Apr 17, 2015 at 08:09:29PM +1000, Alexey Kardashevskiy wrote:
> >>>>On 04/16/2015 04:07 PM, David Gibson wrote:
> >>>>>On Fri, Apr 10, 2015 at 04:30:56PM +1000, Alexey Kardashevskiy wrote:
> >>>>>>At the moment the iommu_table struct has a set_bypass() which enabl=
es/
> >>>>>>disables DMA bypass on IODA2 PHB. This is exposed to POWERPC IOMMU =
code
> >>>>>>which calls this callback when external IOMMU users such as VFIO are
> >>>>>>about to get over a PHB.
> >>>>>>
> >>>>>>The set_bypass() callback is not really an iommu_table function but
> >>>>>>IOMMU/PE function. This introduces a iommu_table_group_ops struct a=
nd
> >>>>>>adds a set_ownership() callback to it which is called when an exter=
nal
> >>>>>>user takes control over the IOMMU.
> >>>>>
> >>>>>Do you really need separate ops structures at both the single table
> >>>>>and table group level?  The different tables in a group will all
> >>>>>belong to the same basic iommu won't they?
> >>>>
> >>>>
> >>>>IOMMU tables exist alone in VIO. Also, the platform code uses just a =
table
> >>>>(or it is in bypass mode) and does not care about table groups. It lo=
oked
> >>>>more clean for myself to keep them separated. Should I still merge
> >>>>those?
> >>>
> >>>Ok, that sounds like a reasonable argument for keeping them separate,
> >>>at least for now.
> >>>
> >>>>>>This renames set_bypass() to set_ownership() as it is not necessari=
ly
> >>>>>>just enabling bypassing, it can be something else/more so let's giv=
e it
> >>>>>>more generic name. The bool parameter is inverted.
> >>>>>>
> >>>>>>The callback is implemented for IODA2 only. Other platforms (P5IOC2,
> >>>>>>IODA1) will use the old iommu_take_ownership/iommu_release_ownershi=
p API.
> >>>>>>
> >>>>>>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>>>---
> >>>>>>  arch/powerpc/include/asm/iommu.h          | 14 +++++++++++++-
> >>>>>>  arch/powerpc/platforms/powernv/pci-ioda.c | 30 ++++++++++++++++++=
++++--------
> >>>>>>  drivers/vfio/vfio_iommu_spapr_tce.c       | 25 ++++++++++++++++++=
+++----
> >>>>>>  3 files changed, 56 insertions(+), 13 deletions(-)
> >>>>>>
> >>>>>>diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/includ=
e/asm/iommu.h
> >>>>>>index b9e50d3..d1f8c6c 100644
> >>>>>>--- a/arch/powerpc/include/asm/iommu.h
> >>>>>>+++ b/arch/powerpc/include/asm/iommu.h
> >>>>>>@@ -92,7 +92,6 @@ struct iommu_table {
> >>>>>>  	unsigned long  it_page_shift;/* table iommu page size */
> >>>>>>  	struct iommu_table_group *it_group;
> >>>>>>  	struct iommu_table_ops *it_ops;
> >>>>>>-	void (*set_bypass)(struct iommu_table *tbl, bool enable);
> >>>>>>  };
> >>>>>>
> >>>>>>  /* Pure 2^n version of get_order */
> >>>>>>@@ -127,11 +126,24 @@ extern struct iommu_table *iommu_init_table(s=
truct iommu_table * tbl,
> >>>>>>
> >>>>>>  #define IOMMU_TABLE_GROUP_MAX_TABLES	1
> >>>>>>
> >>>>>>+struct iommu_table_group;
> >>>>>>+
> >>>>>>+struct iommu_table_group_ops {
> >>>>>>+	/*
> >>>>>>+	 * Switches ownership from the kernel itself to an external
> >>>>>>+	 * user. While onwership is enabled, the kernel cannot use IOMMU
> >>>>>>+	 * for itself.
> >>>>>>+	 */
> >>>>>>+	void (*set_ownership)(struct iommu_table_group *table_group,
> >>>>>>+			bool enable);
> >>>>>
> >>>>>The meaning of "enable" in a function called "set_ownership" is
> >>>>>entirely obscure.
> >>>>
> >>>>Suggest something better please :) I have nothing better...
> >>>
> >>>Well, given it's "set_ownershuip" you could have "owner" - that would
> >>>want to be an enum with OWNER_KERNEL and OWNER_VFIO or something
> >>>rather than a bool.
> >>
> >>
> >>It is iommu_take_ownership() in upstream and it is assumed that the own=
er is
> >>anything but the platform code (for now and probably for ever - VFIO). =
I am
> >>not changing this now, just using same naming approach when adding a
> >>callback with a similar name.
> >
> >So "enabled" is actually that non kernel ownership is enabled.  That
> >is totally non-obvious.
> >
> >>>Or you could leave it a bool but call it "allow_bypass".
> >>
> >>Commented below.
> >>
> >>>>>>+};
> >>>>>>+
> >>>>>>  struct iommu_table_group {
> >>>>>>  #ifdef CONFIG_IOMMU_API
> >>>>>>  	struct iommu_group *group;
> >>>>>>  #endif
> >>>>>>  	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> >>>>>>+	struct iommu_table_group_ops *ops;
> >>>>>>  };
> >>>>>>
> >>>>>>  #ifdef CONFIG_IOMMU_API
> >>>>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/power=
pc/platforms/powernv/pci-ioda.c
> >>>>>>index a964c50..9687731 100644
> >>>>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>>>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>>>>>@@ -1255,10 +1255,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct=
 pnv_phb *phb,
> >>>>>>  		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
> >>>>>>  }
> >>>>>>
> >>>>>>-static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool=
 enable)
> >>>>>>+static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool =
enable)
> >>>>>>  {
> >>>>>>-	struct pnv_ioda_pe *pe =3D container_of(tbl->it_group, struct pnv=
_ioda_pe,
> >>>>>>-					      table_group);
> >>>>>>  	uint16_t window_id =3D (pe->pe_number << 1 ) + 1;
> >>>>>>  	int64_t rc;
> >>>>>>
> >>>>>>@@ -1286,7 +1284,8 @@ static void pnv_pci_ioda2_set_bypass(struct i=
ommu_table *tbl, bool enable)
> >>>>>>  		 * host side.
> >>>>>>  		 */
> >>>>>>  		if (pe->pdev)
> >>>>>>-			set_iommu_table_base(&pe->pdev->dev, tbl);
> >>>>>>+			set_iommu_table_base(&pe->pdev->dev,
> >>>>>>+					&pe->table_group.tables[0]);
> >>>>>>  		else
> >>>>>>  			pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
> >>>>>>  	}
> >>>>>>@@ -1302,13 +1301,27 @@ static void pnv_pci_ioda2_setup_bypass_pe(s=
truct pnv_phb *phb,
> >>>>>>  	/* TVE #1 is selected by PCI address bit 59 */
> >>>>>>  	pe->tce_bypass_base =3D 1ull << 59;
> >>>>>>
> >>>>>>-	/* Install set_bypass callback for VFIO */
> >>>>>>-	pe->table_group.tables[0].set_bypass =3D pnv_pci_ioda2_set_bypass;
> >>>>>>-
> >>>>>>  	/* Enable bypass by default */
> >>>>>>-	pnv_pci_ioda2_set_bypass(&pe->table_group.tables[0], true);
> >>>>>>+	pnv_pci_ioda2_set_bypass(pe, true);
> >>>>>>  }
> >>>>>>
> >>>>>>+static void pnv_ioda2_set_ownership(struct iommu_table_group *tabl=
e_group,
> >>>>>>+				     bool enable)
> >>>>>>+{
> >>>>>>+	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_i=
oda_pe,
> >>>>>>+						table_group);
> >>>>>>+	if (enable)
> >>>>>>+		iommu_take_ownership(table_group);
> >>>>>>+	else
> >>>>>>+		iommu_release_ownership(table_group);
> >>>>>>+
> >>>>>>+	pnv_pci_ioda2_set_bypass(pe, !enable);
> >>>>>>+}
> >>>>>>+
> >>>>>>+static struct iommu_table_group_ops pnv_pci_ioda2_ops =3D {
> >>>>>>+	.set_ownership =3D pnv_ioda2_set_ownership,
> >>>>>>+};
> >>>>>>+
> >>>>>>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> >>>>>>  				       struct pnv_ioda_pe *pe)
> >>>>>>  {
> >>>>>>@@ -1376,6 +1389,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct=
 pnv_phb *phb,
> >>>>>>  	}
> >>>>>>  	tbl->it_ops =3D &pnv_iommu_ops;
> >>>>>>  	iommu_init_table(tbl, phb->hose->node);
> >>>>>>+	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
> >>>>>>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
> >>>>>>  			pe->pe_number);
> >>>>>>
> >>>>>>diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfi=
o_iommu_spapr_tce.c
> >>>>>>index 9f38351..d5d8c50 100644
> >>>>>>--- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>>>>+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>>>>@@ -535,9 +535,22 @@ static int tce_iommu_attach_group(void *iommu_=
data,
> >>>>>>  		goto unlock_exit;
> >>>>>>  	}
> >>>>>>
> >>>>>>-	ret =3D iommu_take_ownership(table_group);
> >>>>>>-	if (!ret)
> >>>>>>-		container->grp =3D iommu_group;
> >>>>>>+	if (!table_group->ops || !table_group->ops->set_ownership) {
> >>>>>>+		ret =3D iommu_take_ownership(table_group);
> >>>>>>+	} else {
> >>>>>>+		/*
> >>>>>>+		 * Disable iommu bypass, otherwise the user can DMA to all of
> >>>>>>+		 * our physical memory via the bypass window instead of just
> >>>>>>+		 * the pages that has been explicitly mapped into the iommu
> >>>>>>+		 */
> >>>>>>+		table_group->ops->set_ownership(table_group, true);
> >>>>>
> >>>>>And here to disable bypass you call it with enable=3Dtrue, so it doe=
sn't
> >>>>>even have the same meaning as it used to.
> >>>>
> >>>>
> >>>>I do not disable bypass per se (even if it what set_ownership(true) d=
oes) as
> >>>>it is IODA business and VFIO has no idea about it. I do take control =
over
> >>>>the group. I am not following you here - what used to have the same
> >>>>meaning?
> >>>
> >>>Well, in set_bypass, the enable parameter was whether bypass was
> >>>enabled.  Here you're setting enable to true, when you want to
> >>>*disable* bypass (in the existing case).  If the "enable" parameter
> >>>isn't about enabling bypass, it's meaning is even more confusing than
> >>>I thought.
> >>
> >>
> >>Its meaning is "take ownership over the group". In this patch
> >>set_ownership(true) means set_bypass(false).
> >
> >Ok.  So "take_ownership" isn't quite as clear as I'd like, but it's
> >not too bad because it's implied that it's the caller that's taking
> >the ownership.  *set* ownership makes no sense without saying who the
> >new owner is.  "enable" has no clear meaning in that context.
> >
> >Calling it "kernel_owned" or "non_kernel_owned" would be ok if a bit
> >clunky.
>=20
>=20
> Strictly speaking VFIO and platform code are both kernel.

Well, true, but VFIO is generally holding the device on behalf of a
userspace process or guest.

> So which one to choose?
>=20
> +struct iommu_table_group_ops {
> +	void (*take_ownership)(struct iommu_table_group *table_group);
> +	void (*release_ownership)(struct iommu_table_group *table_group);
> +};
>=20
>=20
> OR
>=20
> +enum { IOMMU_TABLE_GROUP_OWNER_KERNEL,	IOMMU_TABLE_GROUP_OWNER_VFIO };
> +struct iommu_table_group_ops {
> +	void (*set_ownership)(struct iommu_table_group *table_group,
> +			long owner);
> +};
>=20
>=20
> I have bad taste for names like this, need a hint here, please :)

I think I'd be ok with either.

I think I'd vote for the first option, for consistency with the
existing function names.  If that requires a bunch of code duplication
in the implementations between take and release, I'd probably change
my mind though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0FRtVia6Q6lt+M0P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVNzAhAAoJEGw4ysog2bOSg9oP+wblATvUyX+Xpx/hY0LCvq9z
H1tSWeSqlGORdjYqBB2Xq4K9TW8XT9yRoJq9Uv3W/w8l6N5i52AyWk8LG1er/0l8
LW2wta0kf+gVXlChskdi1oAOWHVAxCZDiKmji1MmA4xJA8SMYGfSf21NChfn93xP
/mNuJyYyKtNuiWV9W8YhSZLE1930qePev54SNz+L8Kc8hYDQbTlT8jdVpyjdwvYW
hLZw/fuCZshVENpO518xHd4pIEPichyMTp78MQ2RCusF3UL+qFUp+kd9ptjeyZSM
E0L9/ZwneDvXRlTS6d8ErsCq93JKaziD+L1jfQTjUV1IRV34/ujjLQ9Eiymc0kSZ
KOje+k7dcVBmmnHHmEqcFR2S3ci+KBOFcKLPF3iD9WZ1L9x6hkWgUJ/LWe0srFCV
rfI3ndzqY/s9ldFx4YH+MedBT1v2R4OY9+bgfGKuKLQa1Rv7OXG8RQIy3tVoWa16
HYaobw2TJX3ItfZP7rd5rcHA77VMuxcMXeE1TSqBEtIrjL4WZA9rqdVSsEAWdEMS
dKn1/DvMw8cd4tFRjcy44WVyck6FOP/zW/XptP/wOu/5g8YFlGf3mtwlVWqYHgeF
1NmUUeuhp3RvMv1uC2O5oIsWRAWgK0w1p8AalzxECtO5figDQi+NLba2aVCp/JHq
dW59hSyl1vffNlbcsjZt
=SXt7
-----END PGP SIGNATURE-----

--0FRtVia6Q6lt+M0P--

Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A5F11A0CF7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 14:53:56 +1000 (AEST)
Date: Fri, 1 May 2015 14:23:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 26/32] powerpc/iommu: Add userspace view of TCE
 table
Message-ID: <20150501042319.GM24886@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-27-git-send-email-aik@ozlabs.ru>
 <20150429063113.GW32589@voom.redhat.com>
 <5542FA8D.2060400@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nb8zVy0QMK3AA1xu"
In-Reply-To: <5542FA8D.2060400@ozlabs.ru>
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


--nb8zVy0QMK3AA1xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2015 at 02:01:17PM +1000, Alexey Kardashevskiy wrote:
> On 04/29/2015 04:31 PM, David Gibson wrote:
> >On Sat, Apr 25, 2015 at 10:14:50PM +1000, Alexey Kardashevskiy wrote:
> >>In order to support memory pre-registration, we need a way to track
> >>the use of every registered memory region and only allow unregistration
> >>if a region is not in use anymore. So we need a way to tell from what
> >>region the just cleared TCE was from.
> >>
> >>This adds a userspace view of the TCE table into iommu_table struct.
> >>It contains userspace address, one per TCE entry. The table is only
> >>allocated when the ownership over an IOMMU group is taken which means
> >>it is only used from outside of the powernv code (such as VFIO).
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>Changes:
> >>v9:
> >>* fixed code flow in error cases added in v8
> >>
> >>v8:
> >>* added ENOMEM on failed vzalloc()
> >>---
> >>  arch/powerpc/include/asm/iommu.h          |  6 ++++++
> >>  arch/powerpc/kernel/iommu.c               | 18 ++++++++++++++++++
> >>  arch/powerpc/platforms/powernv/pci-ioda.c | 22 ++++++++++++++++++++--
> >>  3 files changed, 44 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/as=
m/iommu.h
> >>index 7694546..1472de3 100644
> >>--- a/arch/powerpc/include/asm/iommu.h
> >>+++ b/arch/powerpc/include/asm/iommu.h
> >>@@ -111,9 +111,15 @@ struct iommu_table {
> >>  	unsigned long *it_map;       /* A simple allocation bitmap for now */
> >>  	unsigned long  it_page_shift;/* table iommu page size */
> >>  	struct iommu_table_group *it_table_group;
> >>+	unsigned long *it_userspace; /* userspace view of the table */
> >
> >A single unsigned long doesn't seem like enough.
>=20
> Why single? This is an array.

As in single per page.

> > How do you know
> >which process's address space this address refers to?
>=20
> It is a current task. Multiple userspaces cannot use the same container/t=
ables.

Where is that enforced?

More to the point, that's a VFIO constraint, but it's here affecting
the design of a structure owned by the platform code.

[snip]
> >>  static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb,
> >>@@ -2062,12 +2071,21 @@ static long pnv_pci_ioda2_create_table(struct i=
ommu_table_group *table_group,
> >>  	int nid =3D pe->phb->hose->node;
> >>  	__u64 bus_offset =3D num ? pe->tce_bypass_base : 0;
> >>  	long ret;
> >>+	unsigned long *uas, uas_cb =3D sizeof(*uas) * (window_size >> page_sh=
ift);
> >>+
> >>+	uas =3D vzalloc(uas_cb);
> >>+	if (!uas)
> >>+		return -ENOMEM;
> >
> >I don't see why this is allocated both here as well as in
> >take_ownership.
>=20
> Where else? The only alternative is vfio_iommu_spapr_tce but I really do =
not
> want to touch iommu_table fields there.

Well to put it another way, why isn't take_ownership calling create
itself (or at least a common helper).

Clearly the it_userspace table needs to have lifetime which matches
the TCE table itself, so there should be a single function that marks
the beginning of that joint lifetime.

> >Isn't this function used for core-kernel users of the
> >iommu as well, in which case it shouldn't need the it_userspace.
>=20
>=20
> No. This is an iommu_table_group_ops callback which calls what the platfo=
rm
> code calls (pnv_pci_create_table()) plus allocates this it_userspace thin=
g.
> The callback is only called from VFIO.

Ok.

As touched on above it seems more like this should be owned by VFIO
code than the platform code.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nb8zVy0QMK3AA1xu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQv+3AAoJEGw4ysog2bOSHC8QALDotvZjoDp2Ltx33Jg3DyBR
Xy6uJXmOzb4n8KxOO3f8wrJa6Ayaj9Sm9sJaicC88u+pZpdS/gC2fSnsnraA1ef6
gVJPkDempywSgPSM3mUXE3Hx3cTZ9t3+9lStvvhf6iulxPHlZpoxkieHkDIXs/1J
O55z+36V0MZkWiiEmNeQOgg1+hV/oy2YLnDLKUHXfchr+5hRZ7tQlw16IGl2fm+d
YQkINSI/U9irFhsLlDrnk7a/3VsI64LNv9fThn6RGrk+Awv7YxzaifaxGbSRrAad
9QKugGLpWt6Ft/BncO9VWQC5os0eFBFodPFIwtHNmxsRhNiZF2QS9JBGtwlCTs08
jzJYwh7MwwF0uLF5gqyQXeiUhclDTnFzNeGrkN4f1SFJN3Gy45xvDXJfxSRw9m6g
rXWAxhuM9x3aMg69AyPe7FIiVADSvT7DZ1fHt60gosgRsCFM+ig4G5bFHR6rDZPq
sgmBOb9555UUlR5Yw/SL6jSxO/ieg8lqe3C/2Cd6nHHwEk28bdBf2gWs1oMdsS0Z
f+97YrMhzVc1M0lMouOjOlvruprQ8fnbbcnnpJvamj0Qs89OsAKS1bic/mKAiGqG
LYaFEMi8mmK6g5u50Qa4opxvNincHmPrJByim+jWJ3MObpiC9wEOrIsbrS58PDLf
N/BFXuH4wgOXqJTw/Ctw
=WnJ6
-----END PGP SIGNATURE-----

--nb8zVy0QMK3AA1xu--

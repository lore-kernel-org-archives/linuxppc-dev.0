Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2845C1A06B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 23:09:08 +1000 (AEST)
Date: Tue, 5 May 2015 22:02:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 26/32] powerpc/iommu: Add userspace view of TCE
 table
Message-ID: <20150505120252.GM14090@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-27-git-send-email-aik@ozlabs.ru>
 <20150429063113.GW32589@voom.redhat.com>
 <5542FA8D.2060400@ozlabs.ru>
 <20150501042319.GM24886@voom.redhat.com>
 <5543276D.1090708@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4dlmIwqylWgRDx7z"
In-Reply-To: <5543276D.1090708@ozlabs.ru>
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


--4dlmIwqylWgRDx7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2015 at 05:12:45PM +1000, Alexey Kardashevskiy wrote:
> On 05/01/2015 02:23 PM, David Gibson wrote:
> >On Fri, May 01, 2015 at 02:01:17PM +1000, Alexey Kardashevskiy wrote:
> >>On 04/29/2015 04:31 PM, David Gibson wrote:
> >>>On Sat, Apr 25, 2015 at 10:14:50PM +1000, Alexey Kardashevskiy wrote:
> >>>>In order to support memory pre-registration, we need a way to track
> >>>>the use of every registered memory region and only allow unregistrati=
on
> >>>>if a region is not in use anymore. So we need a way to tell from what
> >>>>region the just cleared TCE was from.
> >>>>
> >>>>This adds a userspace view of the TCE table into iommu_table struct.
> >>>>It contains userspace address, one per TCE entry. The table is only
> >>>>allocated when the ownership over an IOMMU group is taken which means
> >>>>it is only used from outside of the powernv code (such as VFIO).
> >>>>
> >>>>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>---
> >>>>Changes:
> >>>>v9:
> >>>>* fixed code flow in error cases added in v8
> >>>>
> >>>>v8:
> >>>>* added ENOMEM on failed vzalloc()
> >>>>---
> >>>>  arch/powerpc/include/asm/iommu.h          |  6 ++++++
> >>>>  arch/powerpc/kernel/iommu.c               | 18 ++++++++++++++++++
> >>>>  arch/powerpc/platforms/powernv/pci-ioda.c | 22 ++++++++++++++++++++=
--
> >>>>  3 files changed, 44 insertions(+), 2 deletions(-)
> >>>>
> >>>>diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/=
asm/iommu.h
> >>>>index 7694546..1472de3 100644
> >>>>--- a/arch/powerpc/include/asm/iommu.h
> >>>>+++ b/arch/powerpc/include/asm/iommu.h
> >>>>@@ -111,9 +111,15 @@ struct iommu_table {
> >>>>  	unsigned long *it_map;       /* A simple allocation bitmap for now=
 */
> >>>>  	unsigned long  it_page_shift;/* table iommu page size */
> >>>>  	struct iommu_table_group *it_table_group;
> >>>>+	unsigned long *it_userspace; /* userspace view of the table */
> >>>
> >>>A single unsigned long doesn't seem like enough.
> >>
> >>Why single? This is an array.
> >
> >As in single per page.
>=20
>=20
> Sorry, I am not following you here.
> It is per IOMMU page. MAP/UNMAP work with IOMMU pages which are fully bac=
ked
> with either system page or a huge page.
>=20
>=20
> >
> >>>How do you know
> >>>which process's address space this address refers to?
> >>
> >>It is a current task. Multiple userspaces cannot use the same container=
/tables.
> >
> >Where is that enforced?
>=20
>=20
> It is accessed from VFIO DMA map/unmap which are ioctls() to a container's
> fd which is per a process.

Usually, but what enforces that.  If you open a container fd, then
fork(), and attempt to map from both parent and child, what happens?

> Same for KVM - when it registers IOMMU groups in
> KVM, fd's of opened IOMMU groups are passed there. Or I did not understand
> the question...
>=20
>=20
> >More to the point, that's a VFIO constraint, but it's here affecting
> >the design of a structure owned by the platform code.
>=20
> Right. But keeping in mind KVM, I cannot think of any better design here.
>=20
>=20
> >[snip]
> >>>>  static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb,
> >>>>@@ -2062,12 +2071,21 @@ static long pnv_pci_ioda2_create_table(struct=
 iommu_table_group *table_group,
> >>>>  	int nid =3D pe->phb->hose->node;
> >>>>  	__u64 bus_offset =3D num ? pe->tce_bypass_base : 0;
> >>>>  	long ret;
> >>>>+	unsigned long *uas, uas_cb =3D sizeof(*uas) * (window_size >> page_=
shift);
> >>>>+
> >>>>+	uas =3D vzalloc(uas_cb);
> >>>>+	if (!uas)
> >>>>+		return -ENOMEM;
> >>>
> >>>I don't see why this is allocated both here as well as in
> >>>take_ownership.
> >>
> >>Where else? The only alternative is vfio_iommu_spapr_tce but I really d=
o not
> >>want to touch iommu_table fields there.
> >
> >Well to put it another way, why isn't take_ownership calling create
> >itself (or at least a common helper).
>=20
> I am trying to keep DDW stuff away from platform-oriented
> arch/powerpc/kernel/iommu.c which main purpose is to implement
> iommu_alloc()&co. It already has
>=20
> I'd rather move it_userspace allocation completely to vfio_iommu_spapr_tce
> (should have done earlier, actually), would this be ok?

Yeah, that makes more sense to me.

> >Clearly the it_userspace table needs to have lifetime which matches
> >the TCE table itself, so there should be a single function that marks
> >the beginning of that joint lifetime.
>=20
>=20
> No. it_userspace lives as long as the platform code does not control the
> table. For IODA2 it is equal for the lifetime of the table, for IODA1/P5I=
OC2
> it is not.

Right, I was imprecise.  I was thinking of the ownership change as an
end/beginning of lifetime even for IODA1, because the table has to be
fully cleared at that point, even though it's not actually
reallocated.

> >>>Isn't this function used for core-kernel users of the
> >>>iommu as well, in which case it shouldn't need the it_userspace.
> >>
> >>
> >>No. This is an iommu_table_group_ops callback which calls what the plat=
form
> >>code calls (pnv_pci_create_table()) plus allocates this it_userspace th=
ing.
> >>The callback is only called from VFIO.
> >
> >Ok.
> >
> >As touched on above it seems more like this should be owned by VFIO
> >code than the platform code.
>=20
> Agree now :) I'll move the allocation to VFIO. Thanks!
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4dlmIwqylWgRDx7z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJVSLFsAAoJEGw4ysog2bOShpoP+Kj7idRUv7BQd9qRUE34pgLe
yHdlg2hP9OfDjAHZX8fifqxXZd534pv+ybVEr2KReITOS9Ne+9xdiRGvX4bZWT5s
iTZLaxgclytsZzoY93PDG78Ng9+Y7u7q/9VyGg7VPk14UbqgpzfUr1sIkKoKd6uL
9Jeqj2d8wO75CuiYwVWMt1pfT+n2Crw1wVw/lxIzxDMJnvU6Lys3SvbDe51E8qqu
GLLxqjMEa9vfyWRIkhB4ewTVe+4KkVuhmAmGaNh5UOFOdts6oqmtMuL+dWhRd3iX
D8AyrxpOPQXp1U29EcbvPyMWRduMJIiy3jYvQDB6KTdvHDxfmXJ+z12E4SqEZfgB
u2N7K/GS5zVj1q3A/0dIT5oAQaIURMDfraxj9F++DjAqzNCyPl8o/1OrXto9UiSs
d5nxVbT0BooMC5iGcYvVMkQEq+qd8mZW5Ud1vGZn9vM4nl885Rpw/2+2730+Nn9i
Om0vNy9haIr3pRuRgAjOqGEQY3KNmliSpVlJHwGZ5b2BVQtvXB51IWWmtiaxs931
8qfMpla/c41C/6x54MaXRotV1XCYmQWbpCMLcxqruS9H/bFKR9UnJIWXFHKC6+0I
YcdzaAx4ApHk0zC3yYX5I1TGN8Z7S7qyC9lpm6xtCfcyLPkx4SHJf/mCaWxybiX6
j0xYTXljRy3O0/4Poo4=
=WfH5
-----END PGP SIGNATURE-----

--4dlmIwqylWgRDx7z--

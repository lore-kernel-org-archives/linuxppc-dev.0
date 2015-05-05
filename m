Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8AEC1A066A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 23:09:07 +1000 (AEST)
Date: Tue, 5 May 2015 21:50:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 31/32] vfio: powerpc/spapr: Support multiple
 groups in one container if possible
Message-ID: <20150505115025.GJ14090@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-32-git-send-email-aik@ozlabs.ru>
 <20150430072221.GD24886@voom.redhat.com>
 <5541F6D5.9040809@ozlabs.ru>
 <20150501043354.GN24886@voom.redhat.com>
 <554317A4.3090300@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SprEMcskhUyF0lyO"
In-Reply-To: <554317A4.3090300@ozlabs.ru>
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


--SprEMcskhUyF0lyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2015 at 04:05:24PM +1000, Alexey Kardashevskiy wrote:
> On 05/01/2015 02:33 PM, David Gibson wrote:
> >On Thu, Apr 30, 2015 at 07:33:09PM +1000, Alexey Kardashevskiy wrote:
> >>On 04/30/2015 05:22 PM, David Gibson wrote:
> >>>On Sat, Apr 25, 2015 at 10:14:55PM +1000, Alexey Kardashevskiy wrote:
> >>>>At the moment only one group per container is supported.
> >>>>POWER8 CPUs have more flexible design and allows naving 2 TCE tables =
per
> >>>>IOMMU group so we can relax this limitation and support multiple grou=
ps
> >>>>per container.
> >>>
> >>>It's not obvious why allowing multiple TCE tables per PE has any
> >>>pearing on allowing multiple groups per container.
> >>
> >>
> >>This patchset is a global TCE tables rework (patches 1..30, roughly) wi=
th 2
> >>outcomes:
> >>1. reusing the same IOMMU table for multiple groups - patch 31;
> >>2. allowing dynamic create/remove of IOMMU tables - patch 32.
> >>
> >>I can remove this one from the patchset and post it separately later but
> >>since 1..30 aim to support both 1) and 2), I'd think I better keep them=
 all
> >>together (might explain some of changes I do in 1..30).
> >
> >The combined patchset is fine.  My comment is because your commit
> >message says that multiple groups are possible *because* 2 TCE tables
> >per group are allowed, and it's not at all clear why one follows from
> >the other.
>=20
>=20
> Ah. That's wrong indeed, I'll fix it.
>=20
>=20
> >>>>This adds TCE table descriptors to a container and uses iommu_table_g=
roup_ops
> >>>>to create/set DMA windows on IOMMU groups so the same TCE tables will=
 be
> >>>>shared between several IOMMU groups.
> >>>>
> >>>>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>[aw: for the vfio related changes]
> >>>>Acked-by: Alex Williamson <alex.williamson@redhat.com>
> >>>>---
> >>>>Changes:
> >>>>v7:
> >>>>* updated doc
> >>>>---
> >>>>  Documentation/vfio.txt              |   8 +-
> >>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 268 +++++++++++++++++++++++++=
+----------
> >>>>  2 files changed, 199 insertions(+), 77 deletions(-)
> >>>>
> >>>>diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> >>>>index 94328c8..7dcf2b5 100644
> >>>>--- a/Documentation/vfio.txt
> >>>>+++ b/Documentation/vfio.txt
> >>>>@@ -289,10 +289,12 @@ PPC64 sPAPR implementation note
> >>>>
> >>>>  This implementation has some specifics:
> >>>>
> >>>>-1) Only one IOMMU group per container is supported as an IOMMU group
> >>>>-represents the minimal entity which isolation can be guaranteed for =
and
> >>>>-groups are allocated statically, one per a Partitionable Endpoint (P=
E)
> >>>>+1) On older systems (POWER7 with P5IOC2/IODA1) only one IOMMU group =
per
> >>>>+container is supported as an IOMMU table is allocated at the boot ti=
me,
> >>>>+one table per a IOMMU group which is a Partitionable Endpoint (PE)
> >>>>  (PE is often a PCI domain but not always).
> >>>
> >>>I thought the more fundamental problem was that different PEs tended
> >>>to use disjoint bus address ranges, so even by duplicating put_tce
> >>>across PEs you couldn't have a common address space.
> >>
> >>
> >>Sorry, I am not following you here.
> >>
> >>By duplicating put_tce, I can have multiple IOMMU groups on the same vi=
rtual
> >>PHB in QEMU, "[PATCH qemu v7 04/14] spapr_pci_vfio: Enable multiple gro=
ups
> >>per container" does this, the address ranges will the same.
> >
> >Oh, ok.  For some reason I thought that (at least on the older
> >machines) the different PEs used different and not easily changeable
> >DMA windows in bus addresses space.
>=20
>=20
> They do use different tables (which VFIO does not get to remove/create and
> uses these old helpers - iommu_take/release_ownership), correct. But all
> these windows are mapped at zero on a PE's PCI bus and nothing prevents me
> from updating all these tables with the same TCE values when handling
> H_PUT_TCE. Yes it is slow but it works (bit more details below).

Um.. I'm pretty sure that contradicts what Ben was saying on the
thread.

> >>What I cannot do on p5ioc2 is programming the same table to multiple
> >>physical PHBs (or I could but it is very different than IODA2 and pretty
> >>ugly and might not always be possible because I would have to allocate =
these
> >>pages from some common pool and face problems like fragmentation).
> >
> >So allowing multiple groups per container should be possible (at the
> >kernel rather than qemu level) by writing the same value to multiple
> >TCE tables.  I guess its not worth doing for just the almost-obsolete
> >IOMMUs though.
>=20
>=20
> It is done at QEMU level though. As it works now, QEMU opens a group, wal=
ks
> through all existing containers and tries attaching a new group there. If=
 it
> succeeded (x86 always; POWER8 after this patch), a TCE table is shared. If
> it failed, QEMU creates another container, attaches it to the same VFIO/P=
HB
> address space and attaches a group there.
>=20
> Then the only thing left is repeating ioctl() in vfio_container_ioctl() f=
or
> every container in the VFIO address space; this is what that QEMU patch d=
oes
> (the first version of that patch called ioctl() only for the first contai=
ner
> in the address space).
>=20
> From the kernel prospective there are 2 isolated containers; I'd like to
> keep it this way.
>=20
> btw thanks for the detailed review :)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SprEMcskhUyF0lyO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVSK6BAAoJEGw4ysog2bOShgIP/2kF1aSB0BRIxOSMZmxvpK6v
9kx/SnsRtTmtQRIJ/m4qywvsSl1r/X9DyZcMfd74ELqLvBSiLjXIVXXFaIyw2+yy
TDNbvVsROKp1CGTx6K0qRXhhHl+T53Gu1caszWIUGyiW6HMPvjtz2K/CEusGMTVz
8erKp8YpV6I0ESPqiYPYU/CO3l+jh04FhfSnSE4pXcI41y2M7ALAPFwUkTnV2rTR
JJlFLBtRDy190zBXSYvThsuxRapm+3YXyqTi8AwFkMBEtwCY4aggiUvjhqXssC5D
P5y1W3ovcaDhtJQB2uGTKDKCUkw1/LiLLTyMnYPz2ssch50khMOiibcYgtynmyYm
eb/P51h/ZyluE6FBmNIwoNg9CYOpWu/bUCg/zZyGCs/T3QGm5IUGx4iOpPH3iSLA
arE6ME9TN6c+qfeZR/nxc0dLU7e3f9nKs5bQ5kMJmohVOdND2dYEbcg+LGAZyDp/
93w+D2mZ5PXXq2AoEfJ+RBWzX7u4hOsEkIKXGK+5k8t+78qFJo8V91tYGx1XxsGq
zG7w7QFU89XxMli09Q3Dr21ckneaiadvj9nQJMJXN+hHPRPEitjOA2yker78CeDR
anUY3ljcgjsluXFLzreuoFV5Yh0MDiHfYONuNOT3gNMzTOfuxvwGV0CWz7QVgfoI
xwrW5jIZoRJV6qWd67Do
=S8bS
-----END PGP SIGNATURE-----

--SprEMcskhUyF0lyO--

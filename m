Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 998B11A0D07
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 14:53:56 +1000 (AEST)
Date: Fri, 1 May 2015 14:44:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH kernel v9 31/32] vfio: powerpc/spapr: Support multiple
 groups in one container if possible
Message-ID: <20150501044443.GO24886@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-32-git-send-email-aik@ozlabs.ru>
 <20150430072221.GD24886@voom.redhat.com>
 <5541F6D5.9040809@ozlabs.ru>
 <1430441168.7979.39.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tZCmRiovzb4sxAVa"
In-Reply-To: <1430441168.7979.39.camel@kernel.crashing.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
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


--tZCmRiovzb4sxAVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2015 at 10:46:08AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2015-04-30 at 19:33 +1000, Alexey Kardashevskiy wrote:
> > On 04/30/2015 05:22 PM, David Gibson wrote:
> > > On Sat, Apr 25, 2015 at 10:14:55PM +1000, Alexey Kardashevskiy wrote:
> > >> At the moment only one group per container is supported.
> > >> POWER8 CPUs have more flexible design and allows naving 2 TCE tables=
 per
> > >> IOMMU group so we can relax this limitation and support multiple gro=
ups
> > >> per container.
> > >
> > > It's not obvious why allowing multiple TCE tables per PE has any
> > > pearing on allowing multiple groups per container.
> >=20
> >=20
> > This patchset is a global TCE tables rework (patches 1..30, roughly) wi=
th 2=20
> > outcomes:
> > 1. reusing the same IOMMU table for multiple groups - patch 31;
> > 2. allowing dynamic create/remove of IOMMU tables - patch 32.
> >=20
> > I can remove this one from the patchset and post it separately later bu=
t=20
> > since 1..30 aim to support both 1) and 2), I'd think I better keep them=
 all=20
> > together (might explain some of changes I do in 1..30).
>=20
> I think you are talking past each other :-)
>=20
> But yes, having 2 tables per group is orthogonal to the ability of
> having multiple groups per container.
>=20
> The latter is made possible on P8 in large part because each PE has its
> own DMA address space (unlike P5IOC2 or P7IOC where a single address
> space is segmented).
>=20
> Also, on P8 you can actually make the TVT entries point to the same
> table in memory, thus removing the need to duplicate the actual
> tables (though you still have to duplicate the invalidations). I would
> however recommend only sharing the table that way within a chip/node.
>=20
>  .../..
>=20
> > >>
> > >> -1) Only one IOMMU group per container is supported as an IOMMU group
> > >> -represents the minimal entity which isolation can be guaranteed for=
 and
> > >> -groups are allocated statically, one per a Partitionable Endpoint (=
PE)
> > >> +1) On older systems (POWER7 with P5IOC2/IODA1) only one IOMMU group=
 per
> > >> +container is supported as an IOMMU table is allocated at the boot t=
ime,
> > >> +one table per a IOMMU group which is a Partitionable Endpoint (PE)
> > >>   (PE is often a PCI domain but not always).
>=20
> > > I thought the more fundamental problem was that different PEs tended
> > > to use disjoint bus address ranges, so even by duplicating put_tce
> > > across PEs you couldn't have a common address space.
>=20
> Yes. This is the problem with P7IOC and earlier. It *could* be doable on
> P7IOC by making them the same PE but let's not go there.
>=20
> > Sorry, I am not following you here.
> >=20
> > By duplicating put_tce, I can have multiple IOMMU groups on the same=20
> > virtual PHB in QEMU, "[PATCH qemu v7 04/14] spapr_pci_vfio: Enable mult=
iple=20
> > groups per container" does this, the address ranges will the same.
>=20
> But that is only possible on P8 because only there do we have separate
> address spaces between PEs.
>=20
> > What I cannot do on p5ioc2 is programming the same table to multiple=20
> > physical PHBs (or I could but it is very different than IODA2 and prett=
y=20
> > ugly and might not always be possible because I would have to allocate=
=20
> > these pages from some common pool and face problems like fragmentation).
>=20
> And P7IOC has a similar issue. The DMA address top bits indexes the
> window on P7IOC within a shared address space. It's possible to
> configure a TVT to cover multiple devices but with very serious
> limitations.

Ok.  To check my understanding does this sound reasonable:

  * The table_group more-or-less represents a PE, but in a way you can
    reference without first knowing the specific IOMMU hardware type.

  * When attaching multiple groups to the same container, the first PE
    (i.e. table_group) attached is used as a representative so that
    subsequent groups can be checked for compatibility with the first
    PE and therefore all PEs currently included in the container

     - This is why the table_group appears in some places where it
       doesn't seem sensible from a pure object ownership point of
       view

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tZCmRiovzb4sxAVa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQwS7AAoJEGw4ysog2bOSNFkP/iPvwVeGl3ceNKtgJr3WP9c4
a3yZfSzDFXc8iy9kbopPHsGpUIq04jn39T/CR8a6j8SSzMIyayN7C5fI9jVT5pgz
9HERrZVy/DaEdS3W2Cehcj4W2xvOtMSYG63z7TtQkkKW8rGJ4r0A7hoAjffhT14N
vYfJ+T39ixDoraOw5tg7QMxk9z/ClQz902HnZy46QgjcZJmnAolHt8L4WvtmulED
I/ODHUFMTHDsUR3woGQUfq/2d/XkezmUr4jH/KgfNYH9nymqTOOcztNq1IRKb39m
hry/8KTjo67wU9BBMRekc54SkB+jsxgBuXbf8GEdWzs7XvQucZ4ZVRBM15xuWuuU
8UREJACD0kS+FMyWTNFHbmZ9hmDE3RQkVzi0l3dAcvtJlWRoIDbncJ62I+8JbfCU
tcGX1+7HWxp67/yGdxzHjtNqohzGdceTpS7FslkBzgFE5WSHrxvbDsPGMj57AyY4
Ybh61uZgZb5Nu7du5t6xAZhTwWYP0ZKglSZsxBcCOFY54r749YptxSegobeipZSO
1X89Z3gJ4d9ovG8KJ3OZnxZd8+XcR9EiwFPi3oeP9K3JtNV00zwOwZdw2Sku9np6
ieW+uyxjt65bce2YqM89R8Oh6eJgYRJ/8DiC1h+TQkychLIkh2wfzN0LbV3eBoQC
+jL2Fn0smrSNUkhxxRbG
=kje/
-----END PGP SIGNATURE-----

--tZCmRiovzb4sxAVa--

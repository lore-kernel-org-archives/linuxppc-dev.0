Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 921F21A06CF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 14:37:59 +1000 (AEST)
Date: Thu, 30 Apr 2015 14:16:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 15/32] powerpc/powernv/ioda/ioda2: Rework TCE
 invalidation in tce_build()/tce_free()
Message-ID: <20150430041642.GC15238@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-16-git-send-email-aik@ozlabs.ru>
 <20150429031802.GL32589@voom.redhat.com>
 <55419A44.9080804@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
In-Reply-To: <55419A44.9080804@ozlabs.ru>
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


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2015 at 12:58:12PM +1000, Alexey Kardashevskiy wrote:
> On 04/29/2015 01:18 PM, David Gibson wrote:
> >On Sat, Apr 25, 2015 at 10:14:39PM +1000, Alexey Kardashevskiy wrote:
> >>The pnv_pci_ioda_tce_invalidate() helper invalidates TCE cache. It is
> >>supposed to be called on IODA1/2 and not called on p5ioc2. It receives
> >>start and end host addresses of TCE table.
> >>
> >>IODA2 actually needs PCI addresses to invalidate the cache. Those
> >>can be calculated from host addresses but since we are going
> >>to implement multi-level TCE tables, calculating PCI address from
> >>a host address might get either tricky or ugly as TCE table remains flat
> >>on PCI bus but not in RAM.
> >>
> >>This moves pnv_pci_ioda_tce_invalidate() from generic pnv_tce_build/
> >>pnt_tce_free and defines IODA1/2-specific callbacks which call generic
> >>ones and do PHB-model-specific TCE cache invalidation. P5IOC2 keeps
> >>using generic callbacks as before.
> >>
> >>This changes pnv_pci_ioda2_tce_invalidate() to receives TCE index and
> >>number of pages which are PCI addresses shifted by IOMMU page shift.
> >>
> >>No change in behaviour is expected.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>Changes:
> >>v9:
> >>* removed confusing comment from commit log about unintentional calling=
 of
> >>pnv_pci_ioda_tce_invalidate()
> >>* moved mechanical changes away to "powerpc/iommu: Move tce_xxx callbac=
ks from ppc_md to iommu_table"
> >>* fixed bug with broken invalidation in pnv_pci_ioda2_tce_invalidate -
> >>@index includes @tbl->it_offset but old code added it anyway which late=
r broke
> >>DDW
> >>---
> >>  arch/powerpc/platforms/powernv/pci-ioda.c | 86 +++++++++++++++++++++-=
---------
> >>  arch/powerpc/platforms/powernv/pci.c      | 17 ++----
> >>  2 files changed, 64 insertions(+), 39 deletions(-)
> >>
> >>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> >>index 718d5cc..f070c44 100644
> >>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>@@ -1665,18 +1665,20 @@ static void pnv_ioda_setup_bus_dma(struct pnv_i=
oda_pe *pe,
> >>  	}
> >>  }
> >>
> >>-static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
> >>-					 struct iommu_table *tbl,
> >>-					 __be64 *startp, __be64 *endp, bool rm)
> >>+static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
> >>+		unsigned long index, unsigned long npages, bool rm)
> >>  {
> >>+	struct pnv_ioda_pe *pe =3D container_of(tbl->it_table_group,
> >>+			struct pnv_ioda_pe, table_group);
> >>  	__be64 __iomem *invalidate =3D rm ?
> >>  		(__be64 __iomem *)pe->tce_inval_reg_phys :
> >>  		(__be64 __iomem *)tbl->it_index;
> >>  	unsigned long start, end, inc;
> >>  	const unsigned shift =3D tbl->it_page_shift;
> >>
> >>-	start =3D __pa(startp);
> >>-	end =3D __pa(endp);
> >>+	start =3D __pa((__be64 *)tbl->it_base + index - tbl->it_offset);
> >>+	end =3D __pa((__be64 *)tbl->it_base + index - tbl->it_offset +
> >>+			npages - 1);
> >
> >This doesn't look right.  The arguments to __pa don't appear to be
> >addresses (since index and if_offset are in units of (TCE) pages, not
> >bytes).
>=20
>=20
> tbl->it_base is an address and it is casted to __be64* which means:
>=20
> (char*)tbl->it_base + (index - tbl->it_offset)*sizeof(__be64).
>=20
> Which seems to be correct (I just removed extra braces compared to the old
> code), no?

Ah, yes, I'm just forgetting my C pointer arithmetic rules.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQayqAAoJEGw4ysog2bOSixAP/0t+SNSk3rjzuJuAuOx7AbJi
4UgVTcDVWjSZ1G7qIsFtsVBPRSCp19PZj6NLIXkNKJ8xKW3P0gzCi42FojR5NON7
dWQCZOyWCYGiodXaktVe5T8/KAnQWbuQ6e/vzKd6yLqMXfAjJpr5sNEiFLiT38Dg
on1S1ndV0rLXcEeb6+onvzEbjHron8qGFMgFvFHik+M7N9Ri6zYyLBSuQBercJUx
DwnLTBnaSoqAvtI37ObeWP2KMELUCKQ0YXo+uX8GwxL14k0fZNEg1OQ3tMcGG6fU
20EmD0p5Y9lO2dl8wIGn10KxmLm23q7ZIUjhHvy1CprvPM9pVJtYRINw1UrkUGun
8gHWunoEkC6Ok6EE7BNIlfAmAEKpT+ZGqW8GT7qAPBRmOM2IZtLCx4kceB+u8gjb
iAK/9LuGwm6qQnlGtGhW0ofZwReZN716RGt/N6vKi24AsmLjQitIkPkcg5SzSms3
44Ihw46v3ShKmoJpPwfMMGNk5rkppxTkQ8COL+Hfiezjk2724gXadexaftVC4eAZ
uypWkCbCK3r2Suef2RMruUEgQ8Mkmb4xTcsF2lvPfamtIdHfLPXMvFgxnDArKXys
WWlnPmtO3VbTVBuugZo9q+b0ek553BdfyeVARvTm8rlFldbunhHtQcT+XiF6E/oo
V926h2L7uqabVb6HMX6v
=I7DD
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--

Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78C741A04B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 14:37:59 +1000 (AEST)
Date: Thu, 30 Apr 2015 14:18:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 16/32] powerpc/powernv/ioda: Move TCE kill
 register address to PE
Message-ID: <20150430041839.GD15238@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-17-git-send-email-aik@ozlabs.ru>
 <20150429032517.GM32589@voom.redhat.com>
 <55409DAE.2000400@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
In-Reply-To: <55409DAE.2000400@ozlabs.ru>
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


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2015 at 07:00:30PM +1000, Alexey Kardashevskiy wrote:
> On 04/29/2015 01:25 PM, David Gibson wrote:
> >On Sat, Apr 25, 2015 at 10:14:40PM +1000, Alexey Kardashevskiy wrote:
> >>At the moment the DMA setup code looks for the "ibm,opal-tce-kill" prop=
erty
> >>which contains the TCE kill register address. Writes to this register
> >>invalidates TCE cache on IODA/IODA2 hub.
> >>
> >>This moves the register address from iommu_table to pnv_ioda_pe as
> >>later there will be 2 tables per PE and it will be used for both tables.
> >>
> >>This moves the property reading/remapping code to a helper to reduce
> >>code duplication.
> >>
> >>This adds a new pnv_pci_ioda2_tvt_invalidate() helper which invalidates
> >>the entire table. It should be called after every call to
> >>opal_pci_map_pe_dma_window(). It was not required before because
> >>there is just a single TCE table and 64bit DMA is handled via bypass
> >>window (which has no table so no chache is used) but this is going
> >>to change with Dynamic DMA windows (DDW).
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>Changes:
> >>v9:
> >>* new in the series
> >>---
> >>  arch/powerpc/platforms/powernv/pci-ioda.c | 69 +++++++++++++++++++---=
---------
> >>  arch/powerpc/platforms/powernv/pci.h      |  1 +
> >>  2 files changed, 44 insertions(+), 26 deletions(-)
> >>
> >>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> >>index f070c44..b22b3ca 100644
> >>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>@@ -1672,7 +1672,7 @@ static void pnv_pci_ioda1_tce_invalidate(struct i=
ommu_table *tbl,
> >>  			struct pnv_ioda_pe, table_group);
> >>  	__be64 __iomem *invalidate =3D rm ?
> >>  		(__be64 __iomem *)pe->tce_inval_reg_phys :
> >>-		(__be64 __iomem *)tbl->it_index;
> >>+		pe->tce_inval_reg;
> >>  	unsigned long start, end, inc;
> >>  	const unsigned shift =3D tbl->it_page_shift;
> >>
> >>@@ -1743,6 +1743,18 @@ static struct iommu_table_ops pnv_ioda1_iommu_op=
s =3D {
> >>  	.get =3D pnv_tce_get,
> >>  };
> >>
> >>+static inline void pnv_pci_ioda2_tvt_invalidate(struct pnv_ioda_pe *pe)
> >>+{
> >>+	/* 01xb - invalidate TCEs that match the specified PE# */
> >>+	unsigned long addr =3D (0x4ull << 60) | (pe->pe_number & 0xFF);
> >
> >This doesn't really look like an address, but rather the data you're
> >writing to the register.
>=20
>=20
> This thing is made of "invalidate operation" (0x4 here), "invalidate
> address" (pci address but it is zero here as we reset everything, most bi=
ts
> are here) and "invalidate PE number". So what should I call it? :)

Ah, I see.  An address from the hardware point of view, but not so
much from the kernel point of view.  Probably just call it 'val' or
'data'.

>=20
>=20
>=20
> >>+	if (!pe->tce_inval_reg)
> >>+		return;
> >>+
> >>+        mb(); /* Ensure above stores are visible */
> >>+	__raw_writeq(cpu_to_be64(addr), pe->tce_inval_reg);
> >>+}
> >>+
> >>  static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
> >>  		unsigned long index, unsigned long npages, bool rm)
> >>  {
> >>@@ -1751,7 +1763,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct i=
ommu_table *tbl,
> >>  	unsigned long start, end, inc;
> >>  	__be64 __iomem *invalidate =3D rm ?
> >>  		(__be64 __iomem *)pe->tce_inval_reg_phys :
> >>-		(__be64 __iomem *)tbl->it_index;
> >>+		pe->tce_inval_reg;
> >>  	const unsigned shift =3D tbl->it_page_shift;
> >>
> >>  	/* We'll invalidate DMA address in PE scope */
> >>@@ -1803,13 +1815,31 @@ static struct iommu_table_ops pnv_ioda2_iommu_o=
ps =3D {
> >>  	.get =3D pnv_tce_get,
> >>  };
> >>
> >>+static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb,
> >>+		struct pnv_ioda_pe *pe)
> >>+{
> >>+	const __be64 *swinvp;
> >>+
> >>+	/* OPAL variant of PHB3 invalidated TCEs */
> >>+	swinvp =3D of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
> >>+	if (!swinvp)
> >>+		return;
> >>+
> >>+	/* We need a couple more fields -- an address and a data
> >>+	 * to or.  Since the bus is only printed out on table free
> >>+	 * errors, and on the first pass the data will be a relative
> >>+	 * bus number, print that out instead.
> >>+	 */
> >
> >The comment above appears to have nothing to do with the surrounding cod=
e.
>=20
> I'll just remove it.

Ok, good.

>=20
>=20
> >
> >>+	pe->tce_inval_reg_phys =3D be64_to_cpup(swinvp);
> >>+	pe->tce_inval_reg =3D ioremap(pe->tce_inval_reg_phys, 8);
> >>+}
> >>+
> >>  static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
> >>  				      struct pnv_ioda_pe *pe, unsigned int base,
> >>  				      unsigned int segs)
> >>  {
> >>
> >>  	struct page *tce_mem =3D NULL;
> >>-	const __be64 *swinvp;
> >>  	struct iommu_table *tbl;
> >>  	unsigned int i;
> >>  	int64_t rc;
> >>@@ -1823,6 +1853,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_=
phb *phb,
> >>  	if (WARN_ON(pe->tce32_seg >=3D 0))
> >>  		return;
> >>
> >>+	pnv_pci_ioda_setup_opal_tce_kill(phb, pe);
> >>+
> >>  	/* Grab a 32-bit TCE table */
> >>  	pe->tce32_seg =3D base;
> >>  	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
> >>@@ -1865,20 +1897,11 @@ static void pnv_pci_ioda_setup_dma_pe(struct pn=
v_phb *phb,
> >>  				  base << 28, IOMMU_PAGE_SHIFT_4K);
> >>
> >>  	/* OPAL variant of P7IOC SW invalidated TCEs */
> >>-	swinvp =3D of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
> >>-	if (swinvp) {
> >>-		/* We need a couple more fields -- an address and a data
> >>-		 * to or.  Since the bus is only printed out on table free
> >>-		 * errors, and on the first pass the data will be a relative
> >>-		 * bus number, print that out instead.
> >>-		 */
> >
> >.. although I guess it didn't make any more sense in its original contex=
t.
> >
> >>-		pe->tce_inval_reg_phys =3D be64_to_cpup(swinvp);
> >>-		tbl->it_index =3D (unsigned long)ioremap(pe->tce_inval_reg_phys,
> >>-				8);
> >>+	if (pe->tce_inval_reg)
> >>  		tbl->it_type |=3D (TCE_PCI_SWINV_CREATE |
> >>  				 TCE_PCI_SWINV_FREE   |
> >>  				 TCE_PCI_SWINV_PAIR);
> >>-	}
> >>+
> >>  	tbl->it_ops =3D &pnv_ioda1_iommu_ops;
> >>  	iommu_init_table(tbl, phb->hose->node);
> >>
> >>@@ -1984,7 +2007,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
_phb *phb,
> >>  {
> >>  	struct page *tce_mem =3D NULL;
> >>  	void *addr;
> >>-	const __be64 *swinvp;
> >>  	struct iommu_table *tbl;
> >>  	unsigned int tce_table_size, end;
> >>  	int64_t rc;
> >>@@ -1993,6 +2015,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
_phb *phb,
> >>  	if (WARN_ON(pe->tce32_seg >=3D 0))
> >>  		return;
> >>
> >>+	pnv_pci_ioda_setup_opal_tce_kill(phb, pe);
> >>+
> >>  	/* The PE will reserve all possible 32-bits space */
> >>  	pe->tce32_seg =3D 0;
> >>  	end =3D (1 << ilog2(phb->ioda.m32_pci_base));
> >>@@ -2023,6 +2047,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
_phb *phb,
> >>  		goto fail;
> >>  	}
> >>
> >>+	pnv_pci_ioda2_tvt_invalidate(pe);
> >>+
> >
> >This looks to be a change in behavbiour - if it's replacing a previous
> >invalidation, I'm not seeing where.
>=20
>=20
> It is a new thing and the patch adds it. And it does not say anywhere that
> this patch does not change behavior.

Ah, ok, I think I see.

Seems I was even more tired than I realised yesterday and making a
bunch of mistakes while reviewing.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQa0fAAoJEGw4ysog2bOS9gcP/R5G+JxOrujR2uvJG0Tjrdfl
iLe/YNyVjwq1arCPirKoXDAzBI7/8l56bCUemRXyz7VzeP1cKC2aT3Dao5Ubq792
G2cLjlqhiuZV8qi0A2E4AkKC3JNdqqhDsFRAk9ZfRjikpGPe5+vIdwXGSj74Nl96
CkWgiaovPnlBH3XhEvzgFdCToGpC9R2VhCTHoq3cfhF16qIxs7RgiaM4kGafOx4n
APHouse3OkLhgzeUZi6uCD4sQJNItiYoaegNxMFPRuPvnb3NkxAKHGnDdOVPMM1H
UL4qKm1WyqzFE1TToJ9p457bUFdBpH4ix8KIzt5vS4YOMU8AChsyvmC7ObTrs9VC
OMqAaWWqKWWvrhfqoOrGKMt9hcwJKir/goeeV6nfyNjlFqxnvsuPIk5ruxeXKDuF
oYoItVTf2RM1qC/IWLjP7toBiRqhZUhL90II2IqoMzSMHegKhbvoECNp+fi3SYoB
fASBG0HrcCn5DmrsirIn5JEiDhLBQYIfWhDgXvACS3HCRKJ8k/EQev6JFYfbuaDz
BXO3md27eWA/9sSVrmOON1qfoaSIvKgEQkRaCDkWqjG2Mtl3XXKHTUwBPfSimQ7y
UIXjQIVpGnhUkHm8A9Zw5MXJLb9sTVFZArnSsQB+TccppEcYC47BxpS9tKI9/Uwm
9LCKFmafOI6m/6jIjJyR
=qsc1
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--

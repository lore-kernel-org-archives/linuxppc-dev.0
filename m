Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C8C7B1A0CCC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 13:26:04 +1000 (AEST)
Date: Wed, 29 Apr 2015 13:25:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 16/32] powerpc/powernv/ioda: Move TCE kill
 register address to PE
Message-ID: <20150429032517.GM32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-17-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="q8dntDJTu318bll0"
In-Reply-To: <1429964096-11524-17-git-send-email-aik@ozlabs.ru>
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


--q8dntDJTu318bll0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:40PM +1000, Alexey Kardashevskiy wrote:
> At the moment the DMA setup code looks for the "ibm,opal-tce-kill" proper=
ty
> which contains the TCE kill register address. Writes to this register
> invalidates TCE cache on IODA/IODA2 hub.
>=20
> This moves the register address from iommu_table to pnv_ioda_pe as
> later there will be 2 tables per PE and it will be used for both tables.
>=20
> This moves the property reading/remapping code to a helper to reduce
> code duplication.
>=20
> This adds a new pnv_pci_ioda2_tvt_invalidate() helper which invalidates
> the entire table. It should be called after every call to
> opal_pci_map_pe_dma_window(). It was not required before because
> there is just a single TCE table and 64bit DMA is handled via bypass
> window (which has no table so no chache is used) but this is going
> to change with Dynamic DMA windows (DDW).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v9:
> * new in the series
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 69 +++++++++++++++++++------=
------
>  arch/powerpc/platforms/powernv/pci.h      |  1 +
>  2 files changed, 44 insertions(+), 26 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index f070c44..b22b3ca 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1672,7 +1672,7 @@ static void pnv_pci_ioda1_tce_invalidate(struct iom=
mu_table *tbl,
>  			struct pnv_ioda_pe, table_group);
>  	__be64 __iomem *invalidate =3D rm ?
>  		(__be64 __iomem *)pe->tce_inval_reg_phys :
> -		(__be64 __iomem *)tbl->it_index;
> +		pe->tce_inval_reg;
>  	unsigned long start, end, inc;
>  	const unsigned shift =3D tbl->it_page_shift;
> =20
> @@ -1743,6 +1743,18 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops =
=3D {
>  	.get =3D pnv_tce_get,
>  };
> =20
> +static inline void pnv_pci_ioda2_tvt_invalidate(struct pnv_ioda_pe *pe)
> +{
> +	/* 01xb - invalidate TCEs that match the specified PE# */
> +	unsigned long addr =3D (0x4ull << 60) | (pe->pe_number & 0xFF);

This doesn't really look like an address, but rather the data you're
writing to the register.

> +	if (!pe->tce_inval_reg)
> +		return;
> +
> +        mb(); /* Ensure above stores are visible */
> +	__raw_writeq(cpu_to_be64(addr), pe->tce_inval_reg);
> +}
> +
>  static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
>  		unsigned long index, unsigned long npages, bool rm)
>  {
> @@ -1751,7 +1763,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct iom=
mu_table *tbl,
>  	unsigned long start, end, inc;
>  	__be64 __iomem *invalidate =3D rm ?
>  		(__be64 __iomem *)pe->tce_inval_reg_phys :
> -		(__be64 __iomem *)tbl->it_index;
> +		pe->tce_inval_reg;
>  	const unsigned shift =3D tbl->it_page_shift;
> =20
>  	/* We'll invalidate DMA address in PE scope */
> @@ -1803,13 +1815,31 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops=
 =3D {
>  	.get =3D pnv_tce_get,
>  };
> =20
> +static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb,
> +		struct pnv_ioda_pe *pe)
> +{
> +	const __be64 *swinvp;
> +
> +	/* OPAL variant of PHB3 invalidated TCEs */
> +	swinvp =3D of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
> +	if (!swinvp)
> +		return;
> +
> +	/* We need a couple more fields -- an address and a data
> +	 * to or.  Since the bus is only printed out on table free
> +	 * errors, and on the first pass the data will be a relative
> +	 * bus number, print that out instead.
> +	 */

The comment above appears to have nothing to do with the surrounding code.

> +	pe->tce_inval_reg_phys =3D be64_to_cpup(swinvp);
> +	pe->tce_inval_reg =3D ioremap(pe->tce_inval_reg_phys, 8);
> +}
> +
>  static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>  				      struct pnv_ioda_pe *pe, unsigned int base,
>  				      unsigned int segs)
>  {
> =20
>  	struct page *tce_mem =3D NULL;
> -	const __be64 *swinvp;
>  	struct iommu_table *tbl;
>  	unsigned int i;
>  	int64_t rc;
> @@ -1823,6 +1853,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_ph=
b *phb,
>  	if (WARN_ON(pe->tce32_seg >=3D 0))
>  		return;
> =20
> +	pnv_pci_ioda_setup_opal_tce_kill(phb, pe);
> +
>  	/* Grab a 32-bit TCE table */
>  	pe->tce32_seg =3D base;
>  	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
> @@ -1865,20 +1897,11 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_=
phb *phb,
>  				  base << 28, IOMMU_PAGE_SHIFT_4K);
> =20
>  	/* OPAL variant of P7IOC SW invalidated TCEs */
> -	swinvp =3D of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
> -	if (swinvp) {
> -		/* We need a couple more fields -- an address and a data
> -		 * to or.  Since the bus is only printed out on table free
> -		 * errors, and on the first pass the data will be a relative
> -		 * bus number, print that out instead.
> -		 */

=2E. although I guess it didn't make any more sense in its original context.

> -		pe->tce_inval_reg_phys =3D be64_to_cpup(swinvp);
> -		tbl->it_index =3D (unsigned long)ioremap(pe->tce_inval_reg_phys,
> -				8);
> +	if (pe->tce_inval_reg)
>  		tbl->it_type |=3D (TCE_PCI_SWINV_CREATE |
>  				 TCE_PCI_SWINV_FREE   |
>  				 TCE_PCI_SWINV_PAIR);
> -	}
> +
>  	tbl->it_ops =3D &pnv_ioda1_iommu_ops;
>  	iommu_init_table(tbl, phb->hose->node);
> =20
> @@ -1984,7 +2007,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  {
>  	struct page *tce_mem =3D NULL;
>  	void *addr;
> -	const __be64 *swinvp;
>  	struct iommu_table *tbl;
>  	unsigned int tce_table_size, end;
>  	int64_t rc;
> @@ -1993,6 +2015,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  	if (WARN_ON(pe->tce32_seg >=3D 0))
>  		return;
> =20
> +	pnv_pci_ioda_setup_opal_tce_kill(phb, pe);
> +
>  	/* The PE will reserve all possible 32-bits space */
>  	pe->tce32_seg =3D 0;
>  	end =3D (1 << ilog2(phb->ioda.m32_pci_base));
> @@ -2023,6 +2047,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  		goto fail;
>  	}
> =20
> +	pnv_pci_ioda2_tvt_invalidate(pe);
> +

This looks to be a change in behavbiour - if it's replacing a previous
invalidation, I'm not seeing where.

>  	/* Setup iommu */
>  	pe->table_group.tables[0].it_table_group =3D &pe->table_group;
> =20
> @@ -2032,18 +2058,9 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_=
phb *phb,
>  			IOMMU_PAGE_SHIFT_4K);
> =20
>  	/* OPAL variant of PHB3 invalidated TCEs */
> -	swinvp =3D of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
> -	if (swinvp) {
> -		/* We need a couple more fields -- an address and a data
> -		 * to or.  Since the bus is only printed out on table free
> -		 * errors, and on the first pass the data will be a relative
> -		 * bus number, print that out instead.
> -		 */
> -		pe->tce_inval_reg_phys =3D be64_to_cpup(swinvp);
> -		tbl->it_index =3D (unsigned long)ioremap(pe->tce_inval_reg_phys,
> -				8);
> +	if (pe->tce_inval_reg)
>  		tbl->it_type |=3D (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
> -	}
> +
>  	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
>  	iommu_init_table(tbl, phb->hose->node);
>  #ifdef CONFIG_IOMMU_API
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 368d4ed..bd83d85 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -59,6 +59,7 @@ struct pnv_ioda_pe {
>  	int			tce32_segcount;
>  	struct iommu_table_group table_group;
>  	phys_addr_t		tce_inval_reg_phys;
> +	__be64 __iomem		*tce_inval_reg;
> =20
>  	/* 64-bit TCE bypass region */
>  	bool			tce_bypass_enabled;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q8dntDJTu318bll0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQE8cAAoJEGw4ysog2bOSqrIQAKiEn6mTyUvZaSouP5bxdlRQ
QE8OKUdzTXBldM/vzesBcc3AdiNx0Ya7BWhQWUSt6j2AtQRSgqEs1zNVoDHAM2My
8Et2SXEDfoR0ak/QgaLpFHbdkGzVwaUjapw9YNUqLDjZzkMRdzG3cKRP9l1th8y0
vR0VwTbqFnaZOKTc3z7oqSi7v/f7b245rmpMppfztoDYr15OmX37W1nysNjtNLe7
z7bb0ESzMvJJ8k+Ya+MeBaHKPYDLk8au4QPxGNwjReI4TzxHx9DL1NyIVLPCYCpu
Hk0LUnuJExuTH6o4wps6zZFDp85VlbQkFTTBZCiwZGq3lkvf/3ErN07LZzOdTqgs
/1JoSfCu2mwmt+MoeoDMqLqY4Gzwf7RBdtXvOrt6lDP52vfWotnOjjZMnYTmNF6b
cV8NoeR/VsTHTRptya/Gwr9CxBGV1BfXpO56uEzUHaMzD0fkFwZqBhE9Z6BSiZD3
Cyre/ME3QzrHBar6L44P7ytaM8oUbRJSayJizlAZJnyUfUMz+YjQnfTZvyxfaR+i
fL/Zs5fW9w8MRR+YsqoL1lcie1GduzD+AiOjA8vHE6/rD4D40uijW9+Nui484n0B
3VLOCOxzOLHBNL/oygME/3u5jgFmcUpWtDGzaCx6SRd55mkGFQzM+nC3k1GG5hIq
wAMuTfCMHRpG18NSJzsp
=H0lj
-----END PGP SIGNATURE-----

--q8dntDJTu318bll0--

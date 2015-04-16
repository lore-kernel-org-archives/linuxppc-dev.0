Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B6611A0206
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 16:29:25 +1000 (AEST)
Date: Thu, 16 Apr 2015 16:17:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 16/31] powerpc/powernv/ioda/ioda2: Rework
 tce_build()/tce_free()
Message-ID: <20150416061758.GG3632@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-17-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
In-Reply-To: <1428647473-11738-17-git-send-email-aik@ozlabs.ru>
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


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:58PM +1000, Alexey Kardashevskiy wrote:
> The pnv_pci_ioda_tce_invalidate() helper invalidates TCE cache. It is
> supposed to be called on IODA1/2 and not called on p5ioc2. It receives
> start and end host addresses of TCE table. This approach makes it possible
> to get pnv_pci_ioda_tce_invalidate() unintentionally called on
> p5ioc2.

It's not clear what passing start and end addresses has to do with
unintentionally calling the wrong invalidate function.

> Another issue is that IODA2 needs PCI addresses to invalidate the cache
> and those can be calculated from host addresses but since we are going
> to implement multi-level TCE tables, calculating PCI address from
> a host address might get either tricky or ugly as TCE table remains flat
> on PCI bus but not in RAM.
>=20
> This defines separate iommu_table_ops callbacks for p5ioc2 and IODA1/2
> PHBs. They all call common pnv_tce_build/pnv_tce_free/pnv_tce_get helpers
> but call PHB specific TCE invalidation helper (when needed).
>=20
> This changes pnv_pci_ioda2_tce_invalidate() to receives TCE index and
> number of pages which are PCI addresses shifted by IOMMU page shift.
>=20
> The patch is pretty mechanical and behaviour is not expected to change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c   | 92 ++++++++++++++++++++++-=
------
>  arch/powerpc/platforms/powernv/pci-p5ioc2.c |  9 ++-
>  arch/powerpc/platforms/powernv/pci.c        | 76 +++++++++---------------
>  arch/powerpc/platforms/powernv/pci.h        |  7 ++-
>  4 files changed, 111 insertions(+), 73 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 9687731..fd993bc 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1065,18 +1065,20 @@ static void pnv_ioda_setup_bus_dma(struct pnv_iod=
a_pe *pe,
>  	}
>  }
> =20
> -static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
> -					 struct iommu_table *tbl,
> -					 __be64 *startp, __be64 *endp, bool rm)
> +static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
> +		unsigned long index, unsigned long npages, bool rm)
>  {
> +	struct pnv_ioda_pe *pe =3D container_of(tbl->it_group,
> +			struct pnv_ioda_pe, table_group);
>  	__be64 __iomem *invalidate =3D rm ?
>  		(__be64 __iomem *)pe->tce_inval_reg_phys :
>  		(__be64 __iomem *)tbl->it_index;
>  	unsigned long start, end, inc;
>  	const unsigned shift =3D tbl->it_page_shift;
> =20
> -	start =3D __pa(startp);
> -	end =3D __pa(endp);
> +	start =3D __pa((__be64 *)tbl->it_base + index - tbl->it_offset);
> +	end =3D __pa((__be64 *)tbl->it_base + index - tbl->it_offset +
> +			npages - 1);
> =20
>  	/* BML uses this case for p6/p7/galaxy2: Shift addr and put in node */
>  	if (tbl->it_busno) {
> @@ -1112,10 +1114,40 @@ static void pnv_pci_ioda1_tce_invalidate(struct p=
nv_ioda_pe *pe,
>  	 */
>  }
> =20
> -static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
> -					 struct iommu_table *tbl,
> -					 __be64 *startp, __be64 *endp, bool rm)
> +static int pnv_ioda1_tce_build_vm(struct iommu_table *tbl, long index,

What does the the "_vm" stand for?

> +		long npages, unsigned long uaddr,
> +		enum dma_data_direction direction,
> +		struct dma_attrs *attrs)
>  {
> +	long ret =3D pnv_tce_build(tbl, index, npages, uaddr, direction,
> +			attrs);
> +
> +	if (!ret && (tbl->it_type & TCE_PCI_SWINV_CREATE))
> +		pnv_pci_ioda1_tce_invalidate(tbl, index, npages, false);
> +
> +	return ret;
> +}
> +
> +static void pnv_ioda1_tce_free_vm(struct iommu_table *tbl, long index,
> +		long npages)
> +{
> +	pnv_tce_free(tbl, index, npages);
> +
> +	if (tbl->it_type & TCE_PCI_SWINV_FREE)
> +		pnv_pci_ioda1_tce_invalidate(tbl, index, npages, false);
> +}
> +
> +struct iommu_table_ops pnv_ioda1_iommu_ops =3D {
> +	.set =3D pnv_ioda1_tce_build_vm,
> +	.clear =3D pnv_ioda1_tce_free_vm,
> +	.get =3D pnv_tce_get,
> +};
> +
> +static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
> +		unsigned long index, unsigned long npages, bool rm)
> +{
> +	struct pnv_ioda_pe *pe =3D container_of(tbl->it_group,
> +			struct pnv_ioda_pe, table_group);
>  	unsigned long start, end, inc;
>  	__be64 __iomem *invalidate =3D rm ?
>  		(__be64 __iomem *)pe->tce_inval_reg_phys :
> @@ -1128,9 +1160,9 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv=
_ioda_pe *pe,
>  	end =3D start;
> =20
>  	/* Figure out the start, end and step */
> -	inc =3D tbl->it_offset + (((u64)startp - tbl->it_base) / sizeof(u64));
> +	inc =3D tbl->it_offset + index / sizeof(u64);
>  	start |=3D (inc << shift);
> -	inc =3D tbl->it_offset + (((u64)endp - tbl->it_base) / sizeof(u64));
> +	inc =3D tbl->it_offset + (index + npages - 1) / sizeof(u64);
>  	end |=3D (inc << shift);
>  	inc =3D (0x1ull << shift);
>  	mb();
> @@ -1144,19 +1176,35 @@ static void pnv_pci_ioda2_tce_invalidate(struct p=
nv_ioda_pe *pe,
>  	}
>  }
> =20
> -void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
> -				 __be64 *startp, __be64 *endp, bool rm)
> +static int pnv_ioda2_tce_build_vm(struct iommu_table *tbl, long index,
> +		long npages, unsigned long uaddr,
> +		enum dma_data_direction direction,
> +		struct dma_attrs *attrs)
>  {
> -	struct pnv_ioda_pe *pe =3D container_of(tbl->it_group, struct pnv_ioda_=
pe,
> -					      table_group);
> -	struct pnv_phb *phb =3D pe->phb;
> -
> -	if (phb->type =3D=3D PNV_PHB_IODA1)
> -		pnv_pci_ioda1_tce_invalidate(pe, tbl, startp, endp, rm);
> -	else
> -		pnv_pci_ioda2_tce_invalidate(pe, tbl, startp, endp, rm);
> +	long ret =3D pnv_tce_build(tbl, index, npages, uaddr, direction,
> +			attrs);
> +
> +	if (!ret && (tbl->it_type & TCE_PCI_SWINV_CREATE))
> +		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
> +
> +	return ret;
>  }
> =20
> +static void pnv_ioda2_tce_free_vm(struct iommu_table *tbl, long index,
> +		long npages)
> +{
> +	pnv_tce_free(tbl, index, npages);
> +
> +	if (tbl->it_type & TCE_PCI_SWINV_FREE)
> +		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
> +}
> +
> +static struct iommu_table_ops pnv_ioda2_iommu_ops =3D {
> +	.set =3D pnv_ioda2_tce_build_vm,
> +	.clear =3D pnv_ioda2_tce_free_vm,
> +	.get =3D pnv_tce_get,
> +};
> +
>  static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>  				      struct pnv_ioda_pe *pe, unsigned int base,
>  				      unsigned int segs)
> @@ -1236,7 +1284,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_ph=
b *phb,
>  				 TCE_PCI_SWINV_FREE   |
>  				 TCE_PCI_SWINV_PAIR);
>  	}
> -	tbl->it_ops =3D &pnv_iommu_ops;
> +	tbl->it_ops =3D &pnv_ioda1_iommu_ops;
>  	iommu_init_table(tbl, phb->hose->node);
>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
>  			pe->pe_number);
> @@ -1387,7 +1435,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  				8);
>  		tbl->it_type |=3D (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
>  	}
> -	tbl->it_ops =3D &pnv_iommu_ops;
> +	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
>  	iommu_init_table(tbl, phb->hose->node);
>  	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
> diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/p=
latforms/powernv/pci-p5ioc2.c
> index ff68cac..6906a9c 100644
> --- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> +++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> @@ -83,11 +83,18 @@ static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *=
phb)
>  static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb) { }
>  #endif /* CONFIG_PCI_MSI */
> =20
> +static struct iommu_table_ops pnv_p5ioc2_iommu_ops =3D {
> +	.set =3D pnv_tce_build,
> +	.clear =3D pnv_tce_free,
> +	.get =3D pnv_tce_get,
> +};
> +
>  static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
>  					 struct pci_dev *pdev)
>  {
>  	if (phb->p5ioc2.table_group.tables[0].it_map =3D=3D NULL) {
> -		phb->p5ioc2.table_group.tables[0].it_ops =3D &pnv_iommu_ops;
> +		phb->p5ioc2.table_group.tables[0].it_ops =3D
> +				&pnv_p5ioc2_iommu_ops;
>  		iommu_init_table(&phb->p5ioc2.table_group.tables[0],
>  				phb->hose->node);
>  		iommu_register_group(&phb->p5ioc2.table_group,
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index 3050cc8..a8c05de 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -589,70 +589,48 @@ struct pci_ops pnv_pci_ops =3D {
>  	.write =3D pnv_pci_write_config,
>  };
> =20
> -static int pnv_tce_build(struct iommu_table *tbl, long index, long npage=
s,
> -			 unsigned long uaddr, enum dma_data_direction direction,
> -			 struct dma_attrs *attrs, bool rm)
> +static __be64 *pnv_tce(struct iommu_table *tbl, long index)
> +{
> +	__be64 *tmp =3D ((__be64 *)tbl->it_base);
> +
> +	return tmp + index;
> +}
> +
> +int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
> +		unsigned long uaddr, enum dma_data_direction direction,
> +		struct dma_attrs *attrs)
>  {
>  	u64 proto_tce =3D iommu_direction_to_tce_perm(direction);
> -	__be64 *tcep, *tces;
> -	u64 rpn;
> +	u64 rpn =3D __pa(uaddr) >> tbl->it_page_shift;
> +	long i;
> =20
> -	tces =3D tcep =3D ((__be64 *)tbl->it_base) + index - tbl->it_offset;
> -	rpn =3D __pa(uaddr) >> tbl->it_page_shift;
> +	for (i =3D 0; i < npages; i++) {
> +		unsigned long newtce =3D proto_tce |
> +				((rpn + i) << tbl->it_page_shift);
> +		unsigned long idx =3D index - tbl->it_offset + i;
> =20
> -	while (npages--)
> -		*(tcep++) =3D cpu_to_be64(proto_tce |
> -				(rpn++ << tbl->it_page_shift));
> -
> -	/* Some implementations won't cache invalid TCEs and thus may not
> -	 * need that flush. We'll probably turn it_type into a bit mask
> -	 * of flags if that becomes the case
> -	 */
> -	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
> -		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, rm);
> +		*(pnv_tce(tbl, idx)) =3D cpu_to_be64(newtce);
> +	}
> =20
>  	return 0;
>  }
> =20
> -static int pnv_tce_build_vm(struct iommu_table *tbl, long index, long np=
ages,
> -			    unsigned long uaddr,
> -			    enum dma_data_direction direction,
> -			    struct dma_attrs *attrs)
> +void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
>  {
> -	return pnv_tce_build(tbl, index, npages, uaddr, direction, attrs,
> -			false);
> -}
> -
> -static void pnv_tce_free(struct iommu_table *tbl, long index, long npage=
s,
> -		bool rm)
> -{
> -	__be64 *tcep, *tces;
> -
> -	tces =3D tcep =3D ((__be64 *)tbl->it_base) + index - tbl->it_offset;
> +	long i;
> =20
> -	while (npages--)
> -		*(tcep++) =3D cpu_to_be64(0);
> +	for (i =3D 0; i < npages; i++) {
> +		unsigned long idx =3D index - tbl->it_offset + i;
> =20
> -	if (tbl->it_type & TCE_PCI_SWINV_FREE)
> -		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, rm);
> +		*(pnv_tce(tbl, idx)) =3D cpu_to_be64(0);
> +	}
>  }
> =20
> -static void pnv_tce_free_vm(struct iommu_table *tbl, long index, long np=
ages)
> +unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
>  {
> -	pnv_tce_free(tbl, index, npages, false);
> +	return *(pnv_tce(tbl, index));
>  }
> =20
> -static unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
> -{
> -	return ((u64 *)tbl->it_base)[index - tbl->it_offset];
> -}
> -
> -struct iommu_table_ops pnv_iommu_ops =3D {
> -	.set =3D pnv_tce_build_vm,
> -	.clear =3D pnv_tce_free_vm,
> -	.get =3D pnv_tce_get,
> -};
> -
>  void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
>  			       void *tce_mem, u64 tce_size,
>  			       u64 dma_offset, unsigned page_shift)
> @@ -685,7 +663,7 @@ static struct iommu_table *pnv_pci_setup_bml_iommu(st=
ruct pci_controller *hose)
>  		return NULL;
>  	pnv_pci_setup_iommu_table(tbl, __va(be64_to_cpup(basep)),
>  				  be32_to_cpup(sizep), 0, IOMMU_PAGE_SHIFT_4K);
> -	tbl->it_ops =3D &pnv_iommu_ops;
> +	tbl->it_ops =3D &pnv_ioda1_iommu_ops;
>  	iommu_init_table(tbl, hose->node);
>  	iommu_register_group(tbl->it_group, pci_domain_nr(hose->bus), 0);
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 762d906..0d4df32 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -216,7 +216,12 @@ extern struct pci_ops pnv_pci_ops;
>  #ifdef CONFIG_EEH
>  extern struct pnv_eeh_ops ioda_eeh_ops;
>  #endif
> -extern struct iommu_table_ops pnv_iommu_ops;
> +extern int pnv_tce_build(struct iommu_table *tbl, long index, long npage=
s,
> +		unsigned long uaddr, enum dma_data_direction direction,
> +		struct dma_attrs *attrs);
> +extern void pnv_tce_free(struct iommu_table *tbl, long index, long npage=
s);
> +extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
> +extern struct iommu_table_ops pnv_ioda1_iommu_ops;
> =20
>  void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
>  				unsigned char *log_buff);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVL1QVAAoJEGw4ysog2bOSN9QQAL+vFUofTwpFHOUaTFkC/4xY
l6WzgGClDRcpMmXnaAtFmrKl9RKlB8uwPgUgaknyVm2M4J7y6dmRRys3XOVGFqmk
MHXrjs3TyLfCjjwntajqggoJpyp3800Sb5aOWusPQrigI/zf/PYvhChsXztw2WVw
6c3mIYoYIABaKfagI+/RaGprFS0zM5BPWrmG4ebBwgJXb/uTCq6rFTjOvqy4ZYYR
f/PivSAemzkMIInYc3Ycs0rIocRxJNUUYlwinf/f7SW9uiJvyjxKrQbmlRXFBIAM
/L5CgY69w/s18s7HmTDOL50cy2sIA35CGtMowo+SUNDwT+TnNE5pddNaTJhzPyJw
9PnfCbFWSgTE7ovdk47cXgQRZV9cmCR3DdBfHXlxRvOC5UWhpJlh8DQKanL7rwlS
ISctgKxMUdrkd5nx9liwcfVZ65Jy83bI7DroGxm9uiSdrwUD4Y4t46CVZu5DYWkx
YeVeaPv0V6SN2WFlbRhtIBDh6ptfNZDFNnUMB5iyll0nqFqsJ66eHORXSGv7ooKy
yQqB8nDnl/ZVjAOJ+p1Hd9tXVprKtSf5su5zUoR48EwF49S/JSrs6sj5RyLudYnh
kLjR40dn4AL7h2Gc7DepA6FVFkAi4/clUmTUr3scgMVYcwvmpGW1872S9h0QXaIQ
Y6zM++nzGosAEvp4aod0
=Haxo
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--

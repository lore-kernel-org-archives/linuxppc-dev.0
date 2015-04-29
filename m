Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F3131A0CD4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 13:26:05 +1000 (AEST)
Date: Wed, 29 Apr 2015 13:18:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 15/32] powerpc/powernv/ioda/ioda2: Rework TCE
 invalidation in tce_build()/tce_free()
Message-ID: <20150429031802.GL32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-16-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
In-Reply-To: <1429964096-11524-16-git-send-email-aik@ozlabs.ru>
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


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:39PM +1000, Alexey Kardashevskiy wrote:
> The pnv_pci_ioda_tce_invalidate() helper invalidates TCE cache. It is
> supposed to be called on IODA1/2 and not called on p5ioc2. It receives
> start and end host addresses of TCE table.
>=20
> IODA2 actually needs PCI addresses to invalidate the cache. Those
> can be calculated from host addresses but since we are going
> to implement multi-level TCE tables, calculating PCI address from
> a host address might get either tricky or ugly as TCE table remains flat
> on PCI bus but not in RAM.
>=20
> This moves pnv_pci_ioda_tce_invalidate() from generic pnv_tce_build/
> pnt_tce_free and defines IODA1/2-specific callbacks which call generic
> ones and do PHB-model-specific TCE cache invalidation. P5IOC2 keeps
> using generic callbacks as before.
>=20
> This changes pnv_pci_ioda2_tce_invalidate() to receives TCE index and
> number of pages which are PCI addresses shifted by IOMMU page shift.
>=20
> No change in behaviour is expected.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v9:
> * removed confusing comment from commit log about unintentional calling of
> pnv_pci_ioda_tce_invalidate()
> * moved mechanical changes away to "powerpc/iommu: Move tce_xxx callbacks=
 from ppc_md to iommu_table"
> * fixed bug with broken invalidation in pnv_pci_ioda2_tce_invalidate -
> @index includes @tbl->it_offset but old code added it anyway which later =
broke
> DDW
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 86 +++++++++++++++++++++----=
------
>  arch/powerpc/platforms/powernv/pci.c      | 17 ++----
>  2 files changed, 64 insertions(+), 39 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 718d5cc..f070c44 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1665,18 +1665,20 @@ static void pnv_ioda_setup_bus_dma(struct pnv_iod=
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
> +	struct pnv_ioda_pe *pe =3D container_of(tbl->it_table_group,
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

This doesn't look right.  The arguments to __pa don't appear to be
addresses (since index and if_offset are in units of (TCE) pages, not
bytes).

> =20
>  	/* BML uses this case for p6/p7/galaxy2: Shift addr and put in node */
>  	if (tbl->it_busno) {
> @@ -1712,16 +1714,40 @@ static void pnv_pci_ioda1_tce_invalidate(struct p=
nv_ioda_pe *pe,
>  	 */
>  }
> =20
> +static int pnv_ioda1_tce_build(struct iommu_table *tbl, long index,
> +		long npages, unsigned long uaddr,
> +		enum dma_data_direction direction,
> +		struct dma_attrs *attrs)
> +{
> +	long ret =3D pnv_tce_build(tbl, index, npages, uaddr, direction,
> +			attrs);
> +
> +	if (!ret && (tbl->it_type & TCE_PCI_SWINV_CREATE))
> +		pnv_pci_ioda1_tce_invalidate(tbl, index, npages, false);
> +
> +	return ret;
> +}
> +
> +static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
> +		long npages)
> +{
> +	pnv_tce_free(tbl, index, npages);
> +
> +	if (tbl->it_type & TCE_PCI_SWINV_FREE)
> +		pnv_pci_ioda1_tce_invalidate(tbl, index, npages, false);
> +}
> +
>  static struct iommu_table_ops pnv_ioda1_iommu_ops =3D {
> -	.set =3D pnv_tce_build,
> -	.clear =3D pnv_tce_free,
> +	.set =3D pnv_ioda1_tce_build,
> +	.clear =3D pnv_ioda1_tce_free,
>  	.get =3D pnv_tce_get,
>  };
> =20
> -static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
> -					 struct iommu_table *tbl,
> -					 __be64 *startp, __be64 *endp, bool rm)
> +static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
> +		unsigned long index, unsigned long npages, bool rm)
>  {
> +	struct pnv_ioda_pe *pe =3D container_of(tbl->it_table_group,
> +			struct pnv_ioda_pe, table_group);
>  	unsigned long start, end, inc;
>  	__be64 __iomem *invalidate =3D rm ?
>  		(__be64 __iomem *)pe->tce_inval_reg_phys :
> @@ -1734,10 +1760,8 @@ static void pnv_pci_ioda2_tce_invalidate(struct pn=
v_ioda_pe *pe,
>  	end =3D start;
> =20
>  	/* Figure out the start, end and step */
> -	inc =3D tbl->it_offset + (((u64)startp - tbl->it_base) / sizeof(u64));
> -	start |=3D (inc << shift);
> -	inc =3D tbl->it_offset + (((u64)endp - tbl->it_base) / sizeof(u64));
> -	end |=3D (inc << shift);
> +	start |=3D (index << shift);
> +	end |=3D ((index + npages - 1) << shift);
>  	inc =3D (0x1ull << shift);
>  	mb();
> =20
> @@ -1750,22 +1774,32 @@ static void pnv_pci_ioda2_tce_invalidate(struct p=
nv_ioda_pe *pe,
>  	}
>  }
> =20
> -void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
> -				 __be64 *startp, __be64 *endp, bool rm)
> +static int pnv_ioda2_tce_build(struct iommu_table *tbl, long index,
> +		long npages, unsigned long uaddr,
> +		enum dma_data_direction direction,
> +		struct dma_attrs *attrs)
>  {
> -	struct pnv_ioda_pe *pe =3D container_of(tbl->it_table_group,
> -			struct pnv_ioda_pe, table_group);
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
> +}
> +
> +static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
> +		long npages)
> +{
> +	pnv_tce_free(tbl, index, npages);
> +
> +	if (tbl->it_type & TCE_PCI_SWINV_FREE)
> +		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
>  }
> =20
>  static struct iommu_table_ops pnv_ioda2_iommu_ops =3D {
> -	.set =3D pnv_tce_build,
> -	.clear =3D pnv_tce_free,
> +	.set =3D pnv_ioda2_tce_build,
> +	.clear =3D pnv_ioda2_tce_free,
>  	.get =3D pnv_tce_get,
>  };
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index 4c3bbb1..84b4ea4 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -577,37 +577,28 @@ int pnv_tce_build(struct iommu_table *tbl, long ind=
ex, long npages,
>  		struct dma_attrs *attrs)
>  {
>  	u64 proto_tce =3D iommu_direction_to_tce_perm(direction);
> -	__be64 *tcep, *tces;
> +	__be64 *tcep;
>  	u64 rpn;
> =20
> -	tces =3D tcep =3D ((__be64 *)tbl->it_base) + index - tbl->it_offset;
> +	tcep =3D ((__be64 *)tbl->it_base) + index - tbl->it_offset;
>  	rpn =3D __pa(uaddr) >> tbl->it_page_shift;
> =20
>  	while (npages--)
>  		*(tcep++) =3D cpu_to_be64(proto_tce |
>  				(rpn++ << tbl->it_page_shift));
> =20
> -	/* Some implementations won't cache invalid TCEs and thus may not
> -	 * need that flush. We'll probably turn it_type into a bit mask
> -	 * of flags if that becomes the case
> -	 */
> -	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
> -		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, false);
> =20
>  	return 0;
>  }
> =20
>  void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
>  {
> -	__be64 *tcep, *tces;
> +	__be64 *tcep;
> =20
> -	tces =3D tcep =3D ((__be64 *)tbl->it_base) + index - tbl->it_offset;
> +	tcep =3D ((__be64 *)tbl->it_base) + index - tbl->it_offset;
> =20
>  	while (npages--)
>  		*(tcep++) =3D cpu_to_be64(0);
> -
> -	if (tbl->it_type & TCE_PCI_SWINV_FREE)
> -		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, false);
>  }
> =20
>  unsigned long pnv_tce_get(struct iommu_table *tbl, long index)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQE1qAAoJEGw4ysog2bOS2aoQAOWav/GyDJTYYuDLwLdu/tbd
oKV/9H6E4jPdvs+nemDWzhlknfbLg6br04KmQkAiUFvT8Z9RYWrlXl5/3P/mv69t
xCklYU2JjOYEHL/80wTgs5x541lwt7z9tCg7SOuECcG2Xr18pm01jlXkS15iH81V
Bcejb/mEDUrX9yxRwrdgQZOUPv8pbKNNaYXWYTFpg0Xd1wUU93ZvNHaCXCjT4s7C
y0trh4b5mORh2MxgzHUxt1P8OiPsnKIBhv8pUE2ohH4vGdE2MS3rMGvICIC9OQ5b
1NUuLYG1ha6xKm4QJCEKe4Mp1iHjzbc+4tdFXs/JwrAjww4kXAJWXsVlOUv+G3Px
91XE8qf7sgLRrukv5/BY7cZaVmL02QYzSMhHRtV8VUNgBhi3oKNEGHQZMLPvBea4
6NJlsMiv052z1gLmZgSHokyXSpnaS1ndwHiAi3JgiM/MtLQt77IM2oNvBlSkHl0P
y/O6zfnsZ/gBZhf2y/QYLQ42EmcICpVR2dOiumv4bk5iZrTdcgrt3ZTt9rHlXbbc
P8Qav3N4lZpbwCwCaUs2+PCb99FTTQvDSidk+m3Fif7M0LnEri5n2rA0MmuAH8OQ
VcHAVkeiyUZH1tFJLp7q3uPjYNoUI2TGabIsKWRF7LaZ4/G620mg7WIGunONnd1m
84xOjdlovn69OBc0MlxV
=4SFt
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--

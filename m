Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45E941A01E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 15:50:04 +1000 (AEST)
Date: Wed, 29 Apr 2015 14:39:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 20/32] powerpc/powernv/ioda2: Introduce
 pnv_pci_create_table/pnv_pci_free_table
Message-ID: <20150429043949.GQ32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-21-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jigfid2yHjNFZUTO"
In-Reply-To: <1429964096-11524-21-git-send-email-aik@ozlabs.ru>
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


--jigfid2yHjNFZUTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:44PM +1000, Alexey Kardashevskiy wrote:
> This is a part of moving TCE table allocation into an iommu_ops
> callback to support multiple IOMMU groups per one VFIO container.
>=20
> This moves a table creation window to the file with common powernv-pci
> helpers as it does not do anything IODA2-specific.
>=20
> This adds pnv_pci_free_table() helper to release the actual TCE table.
>=20
> This enforces window size to be a power of two.
>=20
> This should cause no behavioural change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> Changes:
> v9:
> * moved helpers to the common powernv pci.c file from pci-ioda.c
> * moved bits from pnv_pci_create_table() to pnv_alloc_tce_table_pages()
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 36 ++++++------------
>  arch/powerpc/platforms/powernv/pci.c      | 61 +++++++++++++++++++++++++=
++++++
>  arch/powerpc/platforms/powernv/pci.h      |  4 ++
>  3 files changed, 76 insertions(+), 25 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index a80be34..b9b3773 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1307,8 +1307,7 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci=
_dev *dev, struct pnv_ioda_pe
>  	if (rc)
>  		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
> =20
> -	iommu_reset_table(tbl, of_node_full_name(dev->dev.of_node));
> -	free_pages(addr, get_order(TCE32_TABLE_SIZE));
> +	pnv_pci_free_table(tbl);
>  }
> =20
>  static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
> @@ -2039,10 +2038,7 @@ static struct iommu_table_group_ops pnv_pci_ioda2_=
ops =3D {
>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>  				       struct pnv_ioda_pe *pe)
>  {
> -	struct page *tce_mem =3D NULL;
> -	void *addr;
>  	struct iommu_table *tbl =3D &pe->table_group.tables[0];
> -	unsigned int tce_table_size, end;
>  	int64_t rc;
> =20
>  	/* We shouldn't already have a 32-bit DMA associated */
> @@ -2053,29 +2049,20 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
_phb *phb,
> =20
>  	/* The PE will reserve all possible 32-bits space */
>  	pe->tce32_seg =3D 0;
> -	end =3D (1 << ilog2(phb->ioda.m32_pci_base));
> -	tce_table_size =3D (end / 0x1000) * 8;
>  	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
> -		end);
> +		phb->ioda.m32_pci_base);
> =20
> -	/* Allocate TCE table */
> -	tce_mem =3D alloc_pages_node(phb->hose->node, GFP_KERNEL,
> -				   get_order(tce_table_size));
> -	if (!tce_mem) {
> -		pe_err(pe, "Failed to allocate a 32-bit TCE memory\n");
> -		goto fail;
> +	rc =3D pnv_pci_create_table(&pe->table_group, pe->phb->hose->node,
> +			0, IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base, tbl);
> +	if (rc) {
> +		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
> +		return;
>  	}
> -	addr =3D page_address(tce_mem);
> -	memset(addr, 0, tce_table_size);
> -
> -	/* Setup iommu */
> -	tbl->it_table_group =3D &pe->table_group;
> -
> -	/* Setup linux iommu table */
> -	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
> -			IOMMU_PAGE_SHIFT_4K);
> =20
>  	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
> +
> +	/* Setup iommu */
> +	tbl->it_table_group =3D &pe->table_group;
>  	iommu_init_table(tbl, phb->hose->node);
>  #ifdef CONFIG_IOMMU_API
>  	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
> @@ -2121,8 +2108,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  fail:
>  	if (pe->tce32_seg >=3D 0)
>  		pe->tce32_seg =3D -1;
> -	if (tce_mem)
> -		__free_pages(tce_mem, get_order(tce_table_size));
> +	pnv_pci_free_table(tbl);
>  }
> =20
>  static void pnv_ioda_setup_dma(struct pnv_phb *phb)
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index e8802ac..6bcfad5 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -20,7 +20,9 @@
>  #include <linux/io.h>
>  #include <linux/msi.h>
>  #include <linux/iommu.h>
> +#include <linux/memblock.h>
> =20
> +#include <asm/mmzone.h>
>  #include <asm/sections.h>
>  #include <asm/io.h>
>  #include <asm/prom.h>
> @@ -645,6 +647,65 @@ void pnv_pci_setup_iommu_table(struct iommu_table *t=
bl,
>  	tbl->it_type =3D TCE_PCI;
>  }
> =20
> +static __be64 *pnv_alloc_tce_table_pages(int nid, unsigned shift,
> +		unsigned long *tce_table_allocated)

I'm a bit confused by the tce_table_allocated parameter.  What's the
circumstance where more memory is requested than required, and why
does it matter to the caller?

> +{
> +	struct page *tce_mem =3D NULL;
> +	__be64 *addr;
> +	unsigned order =3D max_t(unsigned, shift, PAGE_SHIFT) - PAGE_SHIFT;
> +	unsigned long local_allocated =3D 1UL << (order + PAGE_SHIFT);
> +
> +	tce_mem =3D alloc_pages_node(nid, GFP_KERNEL, order);
> +	if (!tce_mem) {
> +		pr_err("Failed to allocate a TCE memory, order=3D%d\n", order);
> +		return NULL;
> +	}
> +	addr =3D page_address(tce_mem);
> +	memset(addr, 0, local_allocated);
> +	*tce_table_allocated =3D local_allocated;
> +
> +	return addr;
> +}
> +
> +long pnv_pci_create_table(struct iommu_table_group *table_group, int nid,
> +		__u64 bus_offset, __u32 page_shift, __u64 window_size,
> +		struct iommu_table *tbl)

The table_group parameter is redundant, isn't it?  It must be equal to
tbl->table_group, yes?

Or would it make more sense for this function to set
tbl->table_group?  And for that matter wouldn't it make more sense for
this to set it_size as well?

> +{
> +	void *addr;
> +	unsigned long tce_table_allocated =3D 0;
> +	const unsigned window_shift =3D ilog2(window_size);
> +	unsigned entries_shift =3D window_shift - page_shift;
> +	unsigned table_shift =3D entries_shift + 3;
> +	const unsigned long tce_table_size =3D max(0x1000UL, 1UL << table_shift=
);

So, here you round up to 4k, the in the alloc function you round up to
PAGE_SIZE (which may or may not be the same).  It's not clear to me why
there are two rounds of rounding up.

> +	if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
> +		return -EINVAL;
> +
> +	/* Allocate TCE table */
> +	addr =3D pnv_alloc_tce_table_pages(nid, table_shift,
> +			&tce_table_allocated);
> +
> +	/* Setup linux iommu table */
> +	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, bus_offset,
> +			page_shift);
> +
> +	pr_info("Created TCE table: window size =3D %08llx, "
> +			"tablesize =3D %lx (%lx), start @%08llx\n",
> +			window_size, tce_table_size, tce_table_allocated,
> +			bus_offset);
> +
> +	return 0;
> +}
> +
> +void pnv_pci_free_table(struct iommu_table *tbl)
> +{
> +	if (!tbl->it_size)
> +		return;
> +
> +	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
> +	iommu_reset_table(tbl, "pnv");
> +}
> +
>  static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
>  {
>  	struct pci_controller *hose =3D pci_bus_to_host(pdev->bus);
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index b15cce5..e6cbbec 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -218,6 +218,10 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
>  extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
>  				      void *tce_mem, u64 tce_size,
>  				      u64 dma_offset, unsigned page_shift);
> +extern long pnv_pci_create_table(struct iommu_table_group *table_group, =
int nid,
> +		__u64 bus_offset, __u32 page_shift, __u64 window_size,
> +		struct iommu_table *tbl);
> +extern void pnv_pci_free_table(struct iommu_table *tbl);
>  extern void pnv_pci_init_p5ioc2_hub(struct device_node *np);
>  extern void pnv_pci_init_ioda_hub(struct device_node *np);
>  extern void pnv_pci_init_ioda2_phb(struct device_node *np);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jigfid2yHjNFZUTO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQGCVAAoJEGw4ysog2bOSmxQQAIGCG6wp7QqhXWTJP0D58ooB
HjuVVfNScFHq2ksqEzGNv4ub2MNiAZkxtX6f5xzoUYyb+RLArzBNvuDv7Ucs3lsd
mCOXUMrd+JdiHHbPiZ+TSS810NcJ+oV6qJNer41xm4XuE0nrlvnb9LUbVG9Hi/we
IYIkkcKRVnPa0+i23yzQjBM4pqxClpc+yiD8KqPlNhm8TosbQHyXFnz3JaRrR+vJ
9SPka6R0DomL1DSji05Cvj7zLMJL8WtTmlEqQy8LkpoUusXvZ2jOUIFK6mrI17Cr
KeWXxJKNI7npe791UFnryA40T59Se4HV5ixu2qjvw3BLxvLddsjK1/wLbfgXNm0u
JjfbDUQqAz33KTmkKFc2z5WBl2RZeQge5wNDmQA9T4Pf4iraA940FDVsno98xrIu
d5Du1v4J1U/QpNhwGfptAaXk7VNIOffxQh8Q6SVAHzwwawCLtRTlWWqReBUyopHe
WvrEk14mE5MZN55vklycmieSXBhbAbmCjNve3B+XmTiR8MubMCiwML5JH8tOU4s7
Zm9C+7FHPZG058KDAjGvCwc+ppdFhnthEqTTE6yrEVs3XwYIxDl++D/ZF2y7b9Fp
8GA0eBDw9kTdyr+LiDXst6QUj/1rexgyHxvYcmjuaqkFKAeZSCa77+qR+u6mB7gc
trSQ3bFjitwmt7pEv29C
=+k/3
-----END PGP SIGNATURE-----

--jigfid2yHjNFZUTO--

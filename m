Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B0B11A0406
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 08:33:18 +1000 (AEST)
Date: Wed, 29 Apr 2015 16:40:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 27/32] powerpc/iommu/ioda2: Add
 get_table_size() to calculate the size of future table
Message-ID: <20150429064029.GX32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-28-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JMKEfAmnQy+WzDHS"
In-Reply-To: <1429964096-11524-28-git-send-email-aik@ozlabs.ru>
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


--JMKEfAmnQy+WzDHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:51PM +1000, Alexey Kardashevskiy wrote:
> This adds a way for the IOMMU user to know how much a new table will
> use so it can be accounted in the locked_vm limit before allocation
> happens.
>=20
> This stores the allocated table size in pnv_pci_create_table()
> so the locked_vm counter can be updated correctly when a table is
> being disposed.
>=20
> This defines an iommu_table_group_ops callback to let VFIO know
> how much memory will be locked if a table is created.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v9:
> * reimplemented the whole patch
> ---
>  arch/powerpc/include/asm/iommu.h          |  5 +++++
>  arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++++
>  arch/powerpc/platforms/powernv/pci.c      | 36 +++++++++++++++++++++++++=
++++++
>  arch/powerpc/platforms/powernv/pci.h      |  2 ++
>  4 files changed, 57 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 1472de3..9844c106 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -99,6 +99,7 @@ struct iommu_table {
>  	unsigned long  it_size;      /* Size of iommu table in entries */
>  	unsigned long  it_indirect_levels;
>  	unsigned long  it_level_size;
> +	unsigned long  it_allocated_size;
>  	unsigned long  it_offset;    /* Offset into global table */
>  	unsigned long  it_base;      /* mapped address of tce table */
>  	unsigned long  it_index;     /* which iommu table this is */
> @@ -155,6 +156,10 @@ extern struct iommu_table *iommu_init_table(struct i=
ommu_table * tbl,
>  struct iommu_table_group;
> =20
>  struct iommu_table_group_ops {
> +	unsigned long (*get_table_size)(
> +			__u32 page_shift,
> +			__u64 window_size,
> +			__u32 levels);
>  	long (*create_table)(struct iommu_table_group *table_group,
>  			int num,
>  			__u32 page_shift,
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index e0be556..7f548b4 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2062,6 +2062,18 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct p=
nv_phb *phb,
>  }
> =20
>  #ifdef CONFIG_IOMMU_API
> +static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
> +		__u64 window_size, __u32 levels)
> +{
> +	unsigned long ret =3D pnv_get_table_size(page_shift, window_size, level=
s);
> +
> +	if (!ret)
> +		return ret;
> +
> +	/* Add size of it_userspace */
> +	return ret + (window_size >> page_shift) * sizeof(unsigned long);

This doesn't make much sense.  The userspace view can't possibly be a
property of the specific low-level IOMMU model.

> +}
> +
>  static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_g=
roup,
>  		int num, __u32 page_shift, __u64 window_size, __u32 levels,
>  		struct iommu_table *tbl)
> @@ -2086,6 +2098,7 @@ static long pnv_pci_ioda2_create_table(struct iommu=
_table_group *table_group,
> =20
>  	BUG_ON(tbl->it_userspace);
>  	tbl->it_userspace =3D uas;
> +	tbl->it_allocated_size +=3D uas_cb;
>  	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
>  	if (pe->tce_inval_reg)
>  		tbl->it_type |=3D (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
> @@ -2160,6 +2173,7 @@ static void pnv_ioda2_release_ownership(struct iomm=
u_table_group *table_group)
>  }
> =20
>  static struct iommu_table_group_ops pnv_pci_ioda2_ops =3D {
> +	.get_table_size =3D pnv_pci_ioda2_get_table_size,
>  	.create_table =3D pnv_pci_ioda2_create_table,
>  	.set_window =3D pnv_pci_ioda2_set_window,
>  	.unset_window =3D pnv_pci_ioda2_unset_window,
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index fc129c4..1b5b48a 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -662,6 +662,38 @@ void pnv_pci_setup_iommu_table(struct iommu_table *t=
bl,
>  	tbl->it_type =3D TCE_PCI;
>  }
> =20
> +unsigned long pnv_get_table_size(__u32 page_shift,
> +		__u64 window_size, __u32 levels)
> +{
> +	unsigned long bytes =3D 0;
> +	const unsigned window_shift =3D ilog2(window_size);
> +	unsigned entries_shift =3D window_shift - page_shift;
> +	unsigned table_shift =3D entries_shift + 3;
> +	unsigned long tce_table_size =3D max(0x1000UL, 1UL << table_shift);
> +	unsigned long direct_table_size;
> +
> +	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS) ||
> +			(window_size > memory_hotplug_max()) ||
> +			!is_power_of_2(window_size))
> +		return 0;
> +
> +	/* Calculate a direct table size from window_size and levels */
> +	entries_shift =3D ROUND_UP(entries_shift, levels) / levels;
> +	table_shift =3D entries_shift + 3;
> +	table_shift =3D max_t(unsigned, table_shift, PAGE_SHIFT);
> +	direct_table_size =3D  1UL << table_shift;
> +
> +	for ( ; levels; --levels) {
> +		bytes +=3D ROUND_UP(tce_table_size, direct_table_size);
> +
> +		tce_table_size /=3D direct_table_size;
> +		tce_table_size <<=3D 3;
> +		tce_table_size =3D ROUND_UP(tce_table_size, direct_table_size);
> +	}
> +
> +	return bytes;
> +}
> +
>  static __be64 *pnv_alloc_tce_table_pages(int nid, unsigned shift,
>  		unsigned levels, unsigned long limit,
>  		unsigned long *tce_table_allocated)
> @@ -741,6 +773,10 @@ long pnv_pci_create_table(struct iommu_table_group *=
table_group, int nid,
>  		return -ENOMEM;
>  	}
> =20
> +	tbl->it_allocated_size =3D pnv_get_table_size(page_shift, window_size,
> +			levels);
> +	WARN_ON(!tbl->it_allocated_size);
> +
>  	/* Setup linux iommu table */
>  	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, bus_offset,
>  			page_shift);
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 3d1ff584..ce4bc3c 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -224,6 +224,8 @@ extern long pnv_pci_create_table(struct iommu_table_g=
roup *table_group, int nid,
>  		__u64 bus_offset, __u32 page_shift, __u64 window_size,
>  		__u32 levels, struct iommu_table *tbl);
>  extern void pnv_pci_free_table(struct iommu_table *tbl);
> +extern unsigned long pnv_get_table_size(__u32 page_shift,
> +		__u64 window_size, __u32 levels);
>  extern void pnv_pci_init_p5ioc2_hub(struct device_node *np);
>  extern void pnv_pci_init_ioda_hub(struct device_node *np);
>  extern void pnv_pci_init_ioda2_phb(struct device_node *np);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JMKEfAmnQy+WzDHS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQHzdAAoJEGw4ysog2bOSihIP/0Q+HiqAvEl8gUo/x/pSEZ7D
OiAqAgSVG0JisUV8QvMnYG7Y0GWxOwyoYYpRUyrHH2+KKKLpmBYYjRD7fwRFyMX4
yisfKyHZ3a9j7a6oDwonOy76T0bTfTXefT5dNqreOvnBgfcmsdj9yFZxUd9V8JtP
ZWFmKJkfjvpiqrZMSFD/Nsu9362v4WcoBBmDJcvKJsYmXpIslkBxUeaUYcqe5PoT
2cb1y6CP0yWezJLUNp/E/5KTOjPD3keN/GU7eQByzVMxLUfcPAHU5mZrOyB+yP7r
eQkl8o5E9xLsmFWWUckTNB2nMxYgAZPnePmYK4dpBMOVFk38L8oMynGhmijblzud
5CPRQa0HcYyOP0hbxNpJbnVlFVupe/++pJ9tzWm9RnPKaeALKDyh+xFBBS43lCR6
T16/wkFpG63O59wJ1pwlgwqydkRWYgS/T5Yf4wswpVrlrwrRLqOSoqAgHSPz6GrE
R47/fycDlKE0O8tyICuCsE+zQtM4HJj7TrPFQ0ZQLUB9DJKw4wt0UQyoVwgV3CA6
APuDXuU0a48J5HAOANKuCzUn6Wk1YIms9vSuNI9Y0dcWPo1b3YZdhIxHdT9MRiM0
2RYtspvjzpKgo05PwdhIT44xzSf9Ty66vBuLbUfoCHkEsVojAwvuVoD/8/NLZs82
OYypBuu9QHw7tLa6ckzt
=4czQ
-----END PGP SIGNATURE-----

--JMKEfAmnQy+WzDHS--

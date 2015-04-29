Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 942FB1A04B2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 08:33:18 +1000 (AEST)
Date: Wed, 29 Apr 2015 16:31:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 26/32] powerpc/iommu: Add userspace view of TCE
 table
Message-ID: <20150429063113.GW32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-27-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PyWBHxIrsGpYNMFw"
In-Reply-To: <1429964096-11524-27-git-send-email-aik@ozlabs.ru>
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


--PyWBHxIrsGpYNMFw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:50PM +1000, Alexey Kardashevskiy wrote:
> In order to support memory pre-registration, we need a way to track
> the use of every registered memory region and only allow unregistration
> if a region is not in use anymore. So we need a way to tell from what
> region the just cleared TCE was from.
>=20
> This adds a userspace view of the TCE table into iommu_table struct.
> It contains userspace address, one per TCE entry. The table is only
> allocated when the ownership over an IOMMU group is taken which means
> it is only used from outside of the powernv code (such as VFIO).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v9:
> * fixed code flow in error cases added in v8
>=20
> v8:
> * added ENOMEM on failed vzalloc()
> ---
>  arch/powerpc/include/asm/iommu.h          |  6 ++++++
>  arch/powerpc/kernel/iommu.c               | 18 ++++++++++++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c | 22 ++++++++++++++++++++--
>  3 files changed, 44 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 7694546..1472de3 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -111,9 +111,15 @@ struct iommu_table {
>  	unsigned long *it_map;       /* A simple allocation bitmap for now */
>  	unsigned long  it_page_shift;/* table iommu page size */
>  	struct iommu_table_group *it_table_group;
> +	unsigned long *it_userspace; /* userspace view of the table */

A single unsigned long doesn't seem like enough.  How do you know
which process's address space this address refers to?

>  	struct iommu_table_ops *it_ops;
>  };
> =20
> +#define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
> +		((tbl)->it_userspace ? \
> +			&((tbl)->it_userspace[(entry) - (tbl)->it_offset]) : \
> +			NULL)
> +
>  /* Pure 2^n version of get_order */
>  static inline __attribute_const__
>  int get_iommu_order(unsigned long size, struct iommu_table *tbl)
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 2eaba0c..74a3f52 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -38,6 +38,7 @@
>  #include <linux/pci.h>
>  #include <linux/iommu.h>
>  #include <linux/sched.h>
> +#include <linux/vmalloc.h>
>  #include <asm/io.h>
>  #include <asm/prom.h>
>  #include <asm/iommu.h>
> @@ -739,6 +740,8 @@ void iommu_reset_table(struct iommu_table *tbl, const=
 char *node_name)
>  		free_pages((unsigned long) tbl->it_map, order);
>  	}
> =20
> +	WARN_ON(tbl->it_userspace);
> +
>  	memset(tbl, 0, sizeof(*tbl));
>  }
> =20
> @@ -1016,6 +1019,7 @@ int iommu_take_ownership(struct iommu_table *tbl)
>  {
>  	unsigned long flags, i, sz =3D (tbl->it_size + 7) >> 3;
>  	int ret =3D 0;
> +	unsigned long *uas;
> =20
>  	/*
>  	 * VFIO does not control TCE entries allocation and the guest
> @@ -1027,6 +1031,10 @@ int iommu_take_ownership(struct iommu_table *tbl)
>  	if (!tbl->it_ops->exchange)
>  		return -EINVAL;
> =20
> +	uas =3D vzalloc(sizeof(*uas) * tbl->it_size);
> +	if (!uas)
> +		return -ENOMEM;
> +
>  	spin_lock_irqsave(&tbl->large_pool.lock, flags);
>  	for (i =3D 0; i < tbl->nr_pools; i++)
>  		spin_lock(&tbl->pools[i].lock);
> @@ -1044,6 +1052,13 @@ int iommu_take_ownership(struct iommu_table *tbl)
>  		memset(tbl->it_map, 0xff, sz);
>  	}
> =20
> +	if (ret) {
> +		vfree(uas);
> +	} else {
> +		BUG_ON(tbl->it_userspace);
> +		tbl->it_userspace =3D uas;
> +	}
> +
>  	for (i =3D 0; i < tbl->nr_pools; i++)
>  		spin_unlock(&tbl->pools[i].lock);
>  	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
> @@ -1056,6 +1071,9 @@ void iommu_release_ownership(struct iommu_table *tb=
l)
>  {
>  	unsigned long flags, i, sz =3D (tbl->it_size + 7) >> 3;
> =20
> +	vfree(tbl->it_userspace);
> +	tbl->it_userspace =3D NULL;
> +
>  	spin_lock_irqsave(&tbl->large_pool.lock, flags);
>  	for (i =3D 0; i < tbl->nr_pools; i++)
>  		spin_lock(&tbl->pools[i].lock);
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 45bc131..e0be556 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -25,6 +25,7 @@
>  #include <linux/memblock.h>
>  #include <linux/iommu.h>
>  #include <linux/sizes.h>
> +#include <linux/vmalloc.h>
> =20
>  #include <asm/sections.h>
>  #include <asm/io.h>
> @@ -1827,6 +1828,14 @@ static void pnv_ioda2_tce_free(struct iommu_table =
*tbl, long index,
>  		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
>  }
> =20
> +void pnv_pci_ioda2_free_table(struct iommu_table *tbl)
> +{
> +	vfree(tbl->it_userspace);
> +	tbl->it_userspace =3D NULL;
> +
> +	pnv_pci_free_table(tbl);
> +}
> +
>  static struct iommu_table_ops pnv_ioda2_iommu_ops =3D {
>  	.set =3D pnv_ioda2_tce_build,
>  #ifdef CONFIG_IOMMU_API
> @@ -1834,7 +1843,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops =
=3D {
>  #endif
>  	.clear =3D pnv_ioda2_tce_free,
>  	.get =3D pnv_tce_get,
> -	.free =3D pnv_pci_free_table,
> +	.free =3D pnv_pci_ioda2_free_table,
>  };
> =20
>  static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb,
> @@ -2062,12 +2071,21 @@ static long pnv_pci_ioda2_create_table(struct iom=
mu_table_group *table_group,
>  	int nid =3D pe->phb->hose->node;
>  	__u64 bus_offset =3D num ? pe->tce_bypass_base : 0;
>  	long ret;
> +	unsigned long *uas, uas_cb =3D sizeof(*uas) * (window_size >> page_shif=
t);
> +
> +	uas =3D vzalloc(uas_cb);
> +	if (!uas)
> +		return -ENOMEM;

I don't see why this is allocated both here as well as in
take_ownership.  Isn't this function used for core-kernel users of the
iommu as well, in which case it shouldn't need the it_userspace.


>  	ret =3D pnv_pci_create_table(table_group, nid, bus_offset, page_shift,
>  			window_size, levels, tbl);
> -	if (ret)
> +	if (ret) {
> +		vfree(uas);
>  		return ret;
> +	}
> =20
> +	BUG_ON(tbl->it_userspace);
> +	tbl->it_userspace =3D uas;
>  	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
>  	if (pe->tce_inval_reg)
>  		tbl->it_type |=3D (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PyWBHxIrsGpYNMFw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQHqxAAoJEGw4ysog2bOSfyMQAL0ldTvjIPC461ZdC849gQn0
I5Yg5SHSdqGfNlHT0tasNCzBdYyzXnhVX9PxKuV6PtZdyTAgbyfGwt1LPUWJ4fZG
7xhnQNCHH42PFbyhrVZyrfIA5O3KBzHZAObgUfgNGZcufNqTp15BPDxPnPoRseQg
GzIuPG626+9IXxiLJfkvhagutbaZu0p9vkhLAIn/LidMnupIc1gyjqvv0uH/L0HX
/6sM0+WqqZCbCBT1B6+nQwj+LAlHMYR4wPRlNaiNquds7J89RvGt+rv+hFQkBbTN
/iN3Ncmvv/n4IUOSofKTCfnGBdvRshwGSK2r4hMA2hZ6WoUMckipnQ9m+y00g9gT
5xv1gE1FTpQlK+CIDJV9xOnHE8ugYVQ65r2d/bCGNSwfMQStW2QMAQOsIc18ykdd
m48xmqXr4Ni7TEO2iaZQrZR+Ls0X6lbeU1HVi9Me9FS/SW40y4H7BFA/hZENxAzv
vuVCUZ7N1rNtD8deIfwaezBQs9sJwE6HkrDjOR8OyQ79WQcl3ZDU/w6F6DfpYX0/
qoc+WvTyahSz0iMkkzHy0AkIq4JE78om2Sc5tE+MJDtBpPnErdNkpvQy+TvHhhsX
9P0nGckA+53vtqXiRc4vF6/+/lM1jaRFBFYuRPc6AE4FBaFL99HHVyw45JipjulK
4UmCtvq2xNMcKrzhq9MY
=bJUp
-----END PGP SIGNATURE-----

--PyWBHxIrsGpYNMFw--

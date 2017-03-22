Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnrbR317MzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 11:46:27 +1100 (AEDT)
Date: Wed, 22 Mar 2017 11:40:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v10 04/10] powerpc/vfio_spapr_tce: Add reference
 counting to iommu_table
Message-ID: <20170322004029.GC19078@umbus.fritz.box>
References: <20170317050959.37312-1-aik@ozlabs.ru>
 <20170317050959.37312-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
In-Reply-To: <20170317050959.37312-5-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2017 at 04:09:53PM +1100, Alexey Kardashevskiy wrote:
> So far iommu_table obejcts were only used in virtual mode and had
> a single owner. We are going to change this by implementing in-kernel
> acceleration of DMA mapping requests. The proposed acceleration
> will handle requests in real mode and KVM will keep references to tables.
>=20
> This adds a kref to iommu_table and defines new helpers to update it.
> This replaces iommu_free_table() with iommu_tce_table_put() and makes
> iommu_free_table() static. iommu_tce_table_get() is not used in this patch
> but it will be in the following patch.
>=20
> Since this touches prototypes, this also removes @node_name parameter as
> it has never been really useful on powernv and carrying it for
> the pseries platform code to iommu_free_table() seems to be quite
> useless as well.
>=20
> This should cause no behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v10:
> * iommu_tce_table_get() can fail now if a table is being destroyed, will =
be
> used in 10/10
> * iommu_tce_table_put() returns what kref_put() returned
> * iommu_tce_table_put() got WARN_ON(!tbl) as the callers already check
> for it and do not call _put() when tbl=3D=3DNULL
>=20
> v9:
> * s/iommu_table_get/iommu_tce_table_get/ and
> s/iommu_table_put/iommu_tce_table_put/ -- so I removed r-b/a-b
> ---
>  arch/powerpc/include/asm/iommu.h          |  5 +++--
>  arch/powerpc/kernel/iommu.c               | 27 ++++++++++++++++++++++---=
--
>  arch/powerpc/platforms/powernv/pci-ioda.c | 14 +++++++-------
>  arch/powerpc/platforms/powernv/pci.c      |  1 +
>  arch/powerpc/platforms/pseries/iommu.c    |  3 ++-
>  arch/powerpc/platforms/pseries/vio.c      |  2 +-
>  drivers/vfio/vfio_iommu_spapr_tce.c       |  2 +-
>  7 files changed, 37 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 4554699aec02..d96142572e6d 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -119,6 +119,7 @@ struct iommu_table {
>  	struct list_head it_group_list;/* List of iommu_table_group_link */
>  	unsigned long *it_userspace; /* userspace view of the table */
>  	struct iommu_table_ops *it_ops;
> +	struct kref    it_kref;
>  };
> =20
>  #define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
> @@ -151,8 +152,8 @@ static inline void *get_iommu_table_base(struct devic=
e *dev)
> =20
>  extern int dma_iommu_dma_supported(struct device *dev, u64 mask);
> =20
> -/* Frees table for an individual device node */
> -extern void iommu_free_table(struct iommu_table *tbl, const char *node_n=
ame);
> +extern struct iommu_table *iommu_tce_table_get(struct iommu_table *tbl);
> +extern int iommu_tce_table_put(struct iommu_table *tbl);
> =20
>  /* Initializes an iommu_table based in values set in the passed-in
>   * structure
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index bc142d87130f..af915da5e03a 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -711,13 +711,13 @@ struct iommu_table *iommu_init_table(struct iommu_t=
able *tbl, int nid)
>  	return tbl;
>  }
> =20
> -void iommu_free_table(struct iommu_table *tbl, const char *node_name)
> +static void iommu_table_free(struct kref *kref)
>  {
>  	unsigned long bitmap_sz;
>  	unsigned int order;
> +	struct iommu_table *tbl;
> =20
> -	if (!tbl)
> -		return;
> +	tbl =3D container_of(kref, struct iommu_table, it_kref);
> =20
>  	if (tbl->it_ops->free)
>  		tbl->it_ops->free(tbl);
> @@ -736,7 +736,7 @@ void iommu_free_table(struct iommu_table *tbl, const =
char *node_name)
> =20
>  	/* verify that table contains no entries */
>  	if (!bitmap_empty(tbl->it_map, tbl->it_size))
> -		pr_warn("%s: Unexpected TCEs for %s\n", __func__, node_name);
> +		pr_warn("%s: Unexpected TCEs\n", __func__);
> =20
>  	/* calculate bitmap size in bytes */
>  	bitmap_sz =3D BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
> @@ -748,7 +748,24 @@ void iommu_free_table(struct iommu_table *tbl, const=
 char *node_name)
>  	/* free table */
>  	kfree(tbl);
>  }
> -EXPORT_SYMBOL_GPL(iommu_free_table);
> +
> +struct iommu_table *iommu_tce_table_get(struct iommu_table *tbl)
> +{
> +	if (kref_get_unless_zero(&tbl->it_kref))
> +		return tbl;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(iommu_tce_table_get);
> +
> +int iommu_tce_table_put(struct iommu_table *tbl)
> +{
> +	if (WARN_ON(!tbl))
> +		return 0;
> +
> +	return kref_put(&tbl->it_kref, iommu_table_free);
> +}
> +EXPORT_SYMBOL_GPL(iommu_tce_table_put);
> =20
>  /* Creates TCEs for a user provided buffer.  The user buffer must be
>   * contiguous real kernel storage (not vmalloc).  The address passed here
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 5dae54cb11e3..ee4cdb5b893f 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1424,7 +1424,7 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci=
_dev *dev, struct pnv_ioda_pe
>  		iommu_group_put(pe->table_group.group);
>  		BUG_ON(pe->table_group.group);
>  	}
> -	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
> +	iommu_tce_table_put(tbl);
>  }
> =20
>  static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
> @@ -2225,7 +2225,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_p=
hb *phb,
>  		__free_pages(tce_mem, get_order(tce32_segsz * segs));
>  	if (tbl) {
>  		pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
> -		iommu_free_table(tbl, "pnv");
> +		iommu_tce_table_put(tbl);
>  	}
>  }
> =20
> @@ -2321,7 +2321,7 @@ static long pnv_pci_ioda2_create_table(struct iommu=
_table_group *table_group,
>  			bus_offset, page_shift, window_size,
>  			levels, tbl);
>  	if (ret) {
> -		iommu_free_table(tbl, "pnv");
> +		iommu_tce_table_put(tbl);
>  		return ret;
>  	}
> =20
> @@ -2365,7 +2365,7 @@ static long pnv_pci_ioda2_setup_default_config(stru=
ct pnv_ioda_pe *pe)
>  	if (rc) {
>  		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
>  				rc);
> -		iommu_free_table(tbl, "");
> +		iommu_tce_table_put(tbl);
>  		return rc;
>  	}
> =20
> @@ -2453,7 +2453,7 @@ static void pnv_ioda2_take_ownership(struct iommu_t=
able_group *table_group)
>  	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
>  	if (pe->pbus)
>  		pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
> -	iommu_free_table(tbl, "pnv");
> +	iommu_tce_table_put(tbl);
>  }
> =20
>  static void pnv_ioda2_release_ownership(struct iommu_table_group *table_=
group)
> @@ -3428,7 +3428,7 @@ static void pnv_pci_ioda1_release_pe_dma(struct pnv=
_ioda_pe *pe)
>  	}
> =20
>  	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
> -	iommu_free_table(tbl, "pnv");
> +	iommu_tce_table_put(tbl);
>  }
> =20
>  static void pnv_pci_ioda2_release_pe_dma(struct pnv_ioda_pe *pe)
> @@ -3455,7 +3455,7 @@ static void pnv_pci_ioda2_release_pe_dma(struct pnv=
_ioda_pe *pe)
>  	}
> =20
>  	pnv_pci_ioda2_table_free_pages(tbl);
> -	iommu_free_table(tbl, "pnv");
> +	iommu_tce_table_put(tbl);
>  }
> =20
>  static void pnv_ioda_free_pe_seg(struct pnv_ioda_pe *pe,
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index eb835e977e33..204a829ff506 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -767,6 +767,7 @@ struct iommu_table *pnv_pci_table_alloc(int nid)
> =20
>  	tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, nid);
>  	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
> +	kref_init(&tbl->it_kref);
> =20
>  	return tbl;
>  }
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platfo=
rms/pseries/iommu.c
> index 4d757eaa46bf..7ce5db209abf 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -74,6 +74,7 @@ static struct iommu_table_group *iommu_pseries_alloc_gr=
oup(int node)
>  		goto fail_exit;
> =20
>  	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
> +	kref_init(&tbl->it_kref);
>  	tgl->table_group =3D table_group;
>  	list_add_rcu(&tgl->next, &tbl->it_group_list);
> =20
> @@ -115,7 +116,7 @@ static void iommu_pseries_free_group(struct iommu_tab=
le_group *table_group,
>  		BUG_ON(table_group->group);
>  	}
>  #endif
> -	iommu_free_table(tbl, node_name);
> +	iommu_tce_table_put(tbl);
> =20
>  	kfree(table_group);
>  }
> diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platform=
s/pseries/vio.c
> index 720493932486..28b09fd797ec 100644
> --- a/arch/powerpc/platforms/pseries/vio.c
> +++ b/arch/powerpc/platforms/pseries/vio.c
> @@ -1318,7 +1318,7 @@ static void vio_dev_release(struct device *dev)
>  	struct iommu_table *tbl =3D get_iommu_table_base(dev);
> =20
>  	if (tbl)
> -		iommu_free_table(tbl, of_node_full_name(dev->of_node));
> +		iommu_tce_table_put(tbl);
>  	of_node_put(dev->of_node);
>  	kfree(to_vio_dev(dev));
>  }
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index fbec7348a7e5..8031d3a55a17 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -680,7 +680,7 @@ static void tce_iommu_free_table(struct tce_container=
 *container,
>  	unsigned long pages =3D tbl->it_allocated_size >> PAGE_SHIFT;
> =20
>  	tce_iommu_userspace_view_free(tbl, container->mm);
> -	iommu_free_table(tbl, "");
> +	iommu_tce_table_put(tbl);
>  	decrement_locked_vm(container->mm, pages);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY0cf7AAoJEGw4ysog2bOS7ioP/1+cHZVG/LqvHAn5bFvsCq4c
biPH3RGnWL9mMb9hXEjVhx+PV7Goq+dgbg9F1r+FgKm/zfzxspx6tvtD4j9CqGCi
/ugEx4zWiguHti0iPHMS2KiM965dY8gLuO6LfnD9nLGIe5wOLHconInS9jDxUYdU
K3roOPeKPPsrJgOOqcTUnik8x5+AxI3yDcORfkNNROIj4eW1PEtDtfGwXVdQCAyL
HHFMUdyYvlNQvhkX/RBzC/O1BpfNvS4Kw8Tsi5dg6kBHstp4YQLCO2DNjavzGS7l
AXV/9xGp6V4l+llzgDtqBmc/3Nzj7X3SP1VlSqDacv4A/aiRoP1QLTbKNkzBfkBu
NG7J68smUsW1daBoa8P6LGOGL7wuFvU76ZIHHhTgpoj6n/SLMwXwspnCEf3eHOyg
YcrUnq46ysbupvWHyw+2ynjzRA+BFMLJH+rrEq4vvBrxwyhF5UAHXusJFgCcro99
WlHGALra166ZCLT3JtO21HjRJ/WZOcjf1XsaoHkjMEnY/9ITRK03BwDJWU1g/7JO
vlr1/Av25NrdazD7dPqyUUzbATluKeondlpbCuAqEBJSGdJJmCyRQwHHnVvS0n/Z
1L2zE1EY2FAnDMyJKiN+ygcA1RVzq2Y5cldIF/7B9lNru6XMaWO899Ob228Cg3rx
5KnQZVJ+Jhbu8xnjHrUe
=9kEY
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--

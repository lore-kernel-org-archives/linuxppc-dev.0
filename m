Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tcV3K0kfrzDvjh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 15:19:25 +1100 (AEDT)
Date: Mon, 12 Dec 2016 15:18:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 3/9] powerpc/vfio_spapr_tce: Add reference
 counting to iommu_table
Message-ID: <20161212041842.GE31441@umbus.fritz.box>
References: <20161208081956.26221-1-aik@ozlabs.ru>
 <20161208081956.26221-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
In-Reply-To: <20161208081956.26221-4-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2016 at 07:19:50PM +1100, Alexey Kardashevskiy wrote:
> So far iommu_table obejcts were only used in virtual mode and had
> a single owner. We are going to change this by implementing in-kernel
> acceleration of DMA mapping requests. The proposed acceleration
> will handle requests in real mode and KVM will keep references to tables.
>=20
> This adds a kref to iommu_table and defines new helpers to update it.
> This replaces iommu_free_table() with iommu_table_put() and makes
> iommu_free_table() static. iommu_table_get() is not used in this patch
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
>  arch/powerpc/include/asm/iommu.h          |  5 +++--
>  arch/powerpc/kernel/iommu.c               | 24 +++++++++++++++++++-----
>  arch/powerpc/platforms/powernv/pci-ioda.c | 14 +++++++-------
>  arch/powerpc/platforms/powernv/pci.c      |  1 +
>  arch/powerpc/platforms/pseries/iommu.c    |  3 ++-
>  arch/powerpc/platforms/pseries/vio.c      |  2 +-
>  drivers/vfio/vfio_iommu_spapr_tce.c       |  2 +-
>  7 files changed, 34 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 2c1d50792944..9de8bad1fdf9 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -114,6 +114,7 @@ struct iommu_table {
>  	struct list_head it_group_list;/* List of iommu_table_group_link */
>  	unsigned long *it_userspace; /* userspace view of the table */
>  	struct iommu_table_ops *it_ops;
> +	struct kref    it_kref;
>  };
> =20
>  #define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
> @@ -146,8 +147,8 @@ static inline void *get_iommu_table_base(struct devic=
e *dev)
> =20
>  extern int dma_iommu_dma_supported(struct device *dev, u64 mask);
> =20
> -/* Frees table for an individual device node */
> -extern void iommu_free_table(struct iommu_table *tbl, const char *node_n=
ame);
> +extern void iommu_table_get(struct iommu_table *tbl);
> +extern void iommu_table_put(struct iommu_table *tbl);
> =20
>  /* Initializes an iommu_table based in values set in the passed-in
>   * structure
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 6744a2771769..d12496889ce9 100644
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
> @@ -748,7 +748,21 @@ void iommu_free_table(struct iommu_table *tbl, const=
 char *node_name)
>  	/* free table */
>  	kfree(tbl);
>  }
> -EXPORT_SYMBOL_GPL(iommu_free_table);
> +
> +void iommu_table_get(struct iommu_table *tbl)
> +{
> +	kref_get(&tbl->it_kref);
> +}
> +EXPORT_SYMBOL_GPL(iommu_table_get);
> +
> +void iommu_table_put(struct iommu_table *tbl)
> +{
> +	if (!tbl)
> +		return;
> +
> +	kref_put(&tbl->it_kref, iommu_table_free);
> +}
> +EXPORT_SYMBOL_GPL(iommu_table_put);
> =20
>  /* Creates TCEs for a user provided buffer.  The user buffer must be
>   * contiguous real kernel storage (not vmalloc).  The address passed here
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index c4f9e812ca6c..ea181f02bebd 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1422,7 +1422,7 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci=
_dev *dev, struct pnv_ioda_pe
>  		iommu_group_put(pe->table_group.group);
>  		BUG_ON(pe->table_group.group);
>  	}
> -	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
> +	iommu_table_put(tbl);
>  }
> =20
>  static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
> @@ -2197,7 +2197,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_p=
hb *phb,
>  		__free_pages(tce_mem, get_order(tce32_segsz * segs));
>  	if (tbl) {
>  		pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
> -		iommu_free_table(tbl, "pnv");
> +		iommu_table_put(tbl);
>  	}
>  }
> =20
> @@ -2291,7 +2291,7 @@ static long pnv_pci_ioda2_create_table(struct iommu=
_table_group *table_group,
>  			bus_offset, page_shift, window_size,
>  			levels, tbl);
>  	if (ret) {
> -		iommu_free_table(tbl, "pnv");
> +		iommu_table_put(tbl);
>  		return ret;
>  	}
> =20
> @@ -2337,7 +2337,7 @@ static long pnv_pci_ioda2_setup_default_config(stru=
ct pnv_ioda_pe *pe)
>  	if (rc) {
>  		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
>  				rc);
> -		iommu_free_table(tbl, "");
> +		iommu_table_put(tbl);
>  		return rc;
>  	}
> =20
> @@ -2423,7 +2423,7 @@ static void pnv_ioda2_take_ownership(struct iommu_t=
able_group *table_group)
> =20
>  	pnv_pci_ioda2_set_bypass(pe, false);
>  	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
> -	iommu_free_table(tbl, "pnv");
> +	iommu_table_put(tbl);
>  }
> =20
>  static void pnv_ioda2_release_ownership(struct iommu_table_group *table_=
group)
> @@ -3393,7 +3393,7 @@ static void pnv_pci_ioda1_release_pe_dma(struct pnv=
_ioda_pe *pe)
>  	}
> =20
>  	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
> -	iommu_free_table(tbl, "pnv");
> +	iommu_table_put(tbl);
>  }
> =20
>  static void pnv_pci_ioda2_release_pe_dma(struct pnv_ioda_pe *pe)
> @@ -3420,7 +3420,7 @@ static void pnv_pci_ioda2_release_pe_dma(struct pnv=
_ioda_pe *pe)
>  	}
> =20
>  	pnv_pci_ioda2_table_free_pages(tbl);
> -	iommu_free_table(tbl, "pnv");
> +	iommu_table_put(tbl);
>  }
> =20
>  static void pnv_ioda_free_pe_seg(struct pnv_ioda_pe *pe,
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index c6d554fe585c..471210913e42 100644
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
> index dc2577fc5fbb..47f0501a94f9 100644
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
> +	iommu_table_put(tbl);
> =20
>  	kfree(table_group);
>  }
> diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platform=
s/pseries/vio.c
> index 2c8fb3ec989e..41e8aa5c0d6a 100644
> --- a/arch/powerpc/platforms/pseries/vio.c
> +++ b/arch/powerpc/platforms/pseries/vio.c
> @@ -1318,7 +1318,7 @@ static void vio_dev_release(struct device *dev)
>  	struct iommu_table *tbl =3D get_iommu_table_base(dev);
> =20
>  	if (tbl)
> -		iommu_free_table(tbl, of_node_full_name(dev->of_node));
> +		iommu_table_put(tbl);
>  	of_node_put(dev->of_node);
>  	kfree(to_vio_dev(dev));
>  }
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index cbac08af400e..be37905012f0 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -677,7 +677,7 @@ static void tce_iommu_free_table(struct tce_container=
 *container,
>  	unsigned long pages =3D tbl->it_allocated_size >> PAGE_SHIFT;
> =20
>  	tce_iommu_userspace_view_free(tbl, container->mm);
> -	iommu_free_table(tbl, "");
> +	iommu_table_put(tbl);
>  	decrement_locked_vm(container->mm, pages);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYTiUiAAoJEGw4ysog2bOSYtEP/iVJVYdLu+9/0oX/4ch9uc7h
zk78JNIewM4Td1CBYxuxAOu5QfKS3PrwLy/+jM1ysFdjH8yjoMS8TcxvzwjpiAh+
Xits9+8K9sgDACp/Q/2l3LJYhZEbjeH5YRfSKguHoRimaoRy1isWexa0FdPFM/KE
bUmzjZLPCmAaj7dXkLuwsXnXj6Bgwme4nssZHtOsuaxeKNK9H5k5TavPghGy7oEQ
AQnTvViHt9YGLCYIBDW4fN9ecgyKxZLdyEK7xeyQc+C4YAlx++LssYPN/Co/AF55
/lpiRs5JK+sS57P5+e7N0EFC6xC84uUtV1ioQIWjyd8/cZ3sX7odZ9eqFUplle6V
aBFRwthhv/rgMbsHWhDLQwEJyfwxbUMyzSu9wL4tkEABEE+aBTMY2HlTLHW8GwgM
VKMj+taPHw+tjI8P4VUmBUef4ImsrBJyhMyT4oQXCQbDWwncf9WYc/s2rxt4nvky
eGCctPlmncMp4IcWhiJTAY13qge8UHwNhZuQUSyPdRjfjKvSkcN8a1qwyfdfSOTF
aqQBZpz2mVRBRd/jCw22dRlDHFGXwDYQfL0Y6F6SnDbp2wvuAeVO1b7Zog+jjh19
6UdiZvfOYYwyuXBaTfNO+bfny5z7T5ASkyTFqFNEtkzwtIj9Hp8y4hqXj2sgWcA3
xdhRAXk+2AwePSeETJl0
=ORJz
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--

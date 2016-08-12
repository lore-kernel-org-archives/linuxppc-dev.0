Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9VzV3twJzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 13:41:10 +1000 (AEST)
Date: Fri, 12 Aug 2016 13:29:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 08/15] powerpc/vfio_spapr_tce: Add reference
 counting to iommu_table
Message-ID: <20160812032921.GK16493@voom.fritz.box>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-9-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kswDJesP0akhmDn8"
In-Reply-To: <1470213656-1042-9-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--kswDJesP0akhmDn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 06:40:49PM +1000, Alexey Kardashevskiy wrote:
> So far iommu_table obejcts were only used in virtual mode and had
> a single owner. We are going to change by implementing in-kernel
> acceleration of DMA mapping requests, including real mode.
>=20
> This adds a kref to iommu_table and defines new helpers to update it.
> This replaces iommu_free_table() with iommu_table_put() and makes
> iommu_free_table() static. iommu_table_get() is not used in this patch
> but will be in the following one.
>=20
> While we are here, this removes @node_name parameter as it has never been
> really useful on powernv and carrying it for the pseries platform code to
> iommu_free_table() seems to be quite useless too.
>=20
> This should cause no behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/iommu.h          |  5 +++--
>  arch/powerpc/kernel/iommu.c               | 24 +++++++++++++++++++-----
>  arch/powerpc/kernel/vio.c                 |  2 +-
>  arch/powerpc/platforms/powernv/pci-ioda.c | 14 +++++++-------
>  arch/powerpc/platforms/powernv/pci.c      |  1 +
>  arch/powerpc/platforms/pseries/iommu.c    |  3 ++-
>  drivers/vfio/vfio_iommu_spapr_tce.c       |  2 +-
>  7 files changed, 34 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index f49a72a..cd4df44 100644
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
> index 13263b0..a8f017a 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -710,13 +710,13 @@ struct iommu_table *iommu_init_table(struct iommu_t=
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
> @@ -735,7 +735,7 @@ void iommu_free_table(struct iommu_table *tbl, const =
char *node_name)
> =20
>  	/* verify that table contains no entries */
>  	if (!bitmap_empty(tbl->it_map, tbl->it_size))
> -		pr_warn("%s: Unexpected TCEs for %s\n", __func__, node_name);
> +		pr_warn("%s: Unexpected TCEs\n", __func__);
> =20
>  	/* calculate bitmap size in bytes */
>  	bitmap_sz =3D BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
> @@ -747,7 +747,21 @@ void iommu_free_table(struct iommu_table *tbl, const=
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
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index 8d7358f..188f452 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -1318,7 +1318,7 @@ static void vio_dev_release(struct device *dev)
>  	struct iommu_table *tbl =3D get_iommu_table_base(dev);
> =20
>  	if (tbl)
> -		iommu_free_table(tbl, of_node_full_name(dev->of_node));
> +		iommu_table_put(tbl);
>  	of_node_put(dev->of_node);
>  	kfree(to_vio_dev(dev));
>  }
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 74ab8382..c04afd2 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1394,7 +1394,7 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci=
_dev *dev, struct pnv_ioda_pe
>  		iommu_group_put(pe->table_group.group);
>  		BUG_ON(pe->table_group.group);
>  	}
> -	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
> +	iommu_table_put(tbl);
>  }
> =20
>  static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
> @@ -2171,7 +2171,7 @@ found:
>  		__free_pages(tce_mem, get_order(tce32_segsz * segs));
>  	if (tbl) {
>  		pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
> -		iommu_free_table(tbl, "pnv");
> +		iommu_table_put(tbl);
>  	}
>  }
> =20
> @@ -2265,7 +2265,7 @@ static long pnv_pci_ioda2_create_table(struct iommu=
_table_group *table_group,
>  			bus_offset, page_shift, window_size,
>  			levels, tbl);
>  	if (ret) {
> -		iommu_free_table(tbl, "pnv");
> +		iommu_table_put(tbl);
>  		return ret;
>  	}
> =20
> @@ -2311,7 +2311,7 @@ static long pnv_pci_ioda2_setup_default_config(stru=
ct pnv_ioda_pe *pe)
>  	if (rc) {
>  		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
>  				rc);
> -		iommu_free_table(tbl, "");
> +		iommu_table_put(tbl);
>  		return rc;
>  	}
> =20
> @@ -2397,7 +2397,7 @@ static void pnv_ioda2_take_ownership(struct iommu_t=
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
> @@ -3311,7 +3311,7 @@ static void pnv_pci_ioda1_release_pe_dma(struct pnv=
_ioda_pe *pe)
>  	}
> =20
>  	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
> -	iommu_free_table(tbl, "pnv");
> +	iommu_table_put(tbl);
>  }
> =20
>  static void pnv_pci_ioda2_release_pe_dma(struct pnv_ioda_pe *pe)
> @@ -3338,7 +3338,7 @@ static void pnv_pci_ioda2_release_pe_dma(struct pnv=
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
> index 6701dd5..5917439 100644
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
> index 0056856..da29518 100644
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
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 79f26c7..3594ad3 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -660,7 +660,7 @@ static void tce_iommu_free_table(struct iommu_table *=
tbl)
>  	unsigned long pages =3D tbl->it_allocated_size >> PAGE_SHIFT;
> =20
>  	tce_iommu_userspace_view_free(tbl);
> -	iommu_free_table(tbl, "");
> +	iommu_table_put(tbl);
>  	decrement_locked_vm(pages);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kswDJesP0akhmDn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrUKRAAoJEGw4ysog2bOSUMEQAOCf96Tj+EH+3xY/+Cq0LRnc
QXRiAHhEITJxsSMLe4DvQI+osYKP6i6QHIeOwzV2K6gF8iil2+PvmKzVwELBj1Zu
dP0IywAcA2dYNocYOuXpMsJrcBsVJwvop3wutMaTEax6cmQePLr7mVJXUhartHpD
ipErW3gowV8NL8fg12UN1RW4ktuThF+Mgjyihax/OgxI4zGD11tZB6+4ciwtxdPz
tX6s8DKrQv2xVr6L5Bgp5Xpovu8htxzJqLT/4OK4c5JtsB89FqV/t3y19TGcWRP4
PXpkzmQZjmzMrJVaKyttf9j+tJpvezA2VSPVCbd4RSAcO7AZs9/bVfe6CZejfL5X
qJkK/5KOX8SdV8yqkWxNQtAw4inMlvwMuFmS7crTsfFw1+L8f+z8CBoF2U5K41eK
19oeOmaWhLJt1vuGs/AgNq+YtfOMZx9o5XZVyagrtgYmgfqUfCO74W+6R84Sl2Dl
j6xjjVD5NBCwd0bZGuIq/13px0XVm2tHWA/jMugM8tI57zaVDvyghXZMq2/RxUW+
rnepdWUnZv11KZ9ComWzt2YBXf0/0BCQKRcsRP39zi7Ah5t/3jqm4JjJhiFJggMX
FwLUwD3lLdR0XFsc98Jeha0mAotNqw90VUJXs7gxqNiLHP20Guhyee851KsH1rWF
E73AQVV3mU9GvKjYpho7
=sWO6
-----END PGP SIGNATURE-----

--kswDJesP0akhmDn8--

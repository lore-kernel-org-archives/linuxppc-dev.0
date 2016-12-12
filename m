Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tcV3J6vrKzDvjg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 15:19:24 +1100 (AEDT)
Date: Mon, 12 Dec 2016 15:15:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 2/9] powerpc/iommu: Cleanup iommu_table disposal
Message-ID: <20161212041500.GD31441@umbus.fritz.box>
References: <20161208081956.26221-1-aik@ozlabs.ru>
 <20161208081956.26221-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
In-Reply-To: <20161208081956.26221-3-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2016 at 07:19:49PM +1100, Alexey Kardashevskiy wrote:
> At the moment iommu_table can be disposed by either calling
> iommu_table_free() directly or it_ops::free(); the only implementation
> of free() is in IODA2 - pnv_ioda2_table_free() - and it calls
> iommu_table_free() anyway.
>=20
> As we are going to have reference counting on tables, we need an unified
> way of disposing tables.
>=20
> This moves it_ops::free() call into iommu_free_table() and makes use
> of the latter. The free() callback now handles only platform-specific
> data.
>=20
> This should cause no behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kernel/iommu.c               | 4 ++++
>  arch/powerpc/platforms/powernv/pci-ioda.c | 6 ++----
>  drivers/vfio/vfio_iommu_spapr_tce.c       | 2 +-
>  3 files changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 5f202a566ec5..6744a2771769 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -719,6 +719,9 @@ void iommu_free_table(struct iommu_table *tbl, const =
char *node_name)
>  	if (!tbl)
>  		return;
> =20
> +	if (tbl->it_ops->free)
> +		tbl->it_ops->free(tbl);
> +
>  	if (!tbl->it_map) {
>  		kfree(tbl);
>  		return;
> @@ -745,6 +748,7 @@ void iommu_free_table(struct iommu_table *tbl, const =
char *node_name)
>  	/* free table */
>  	kfree(tbl);
>  }
> +EXPORT_SYMBOL_GPL(iommu_free_table);
> =20
>  /* Creates TCEs for a user provided buffer.  The user buffer must be
>   * contiguous real kernel storage (not vmalloc).  The address passed here
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 5fcae29107e1..c4f9e812ca6c 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1422,7 +1422,6 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci=
_dev *dev, struct pnv_ioda_pe
>  		iommu_group_put(pe->table_group.group);
>  		BUG_ON(pe->table_group.group);
>  	}
> -	pnv_pci_ioda2_table_free_pages(tbl);
>  	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
>  }
> =20
> @@ -2013,7 +2012,6 @@ static void pnv_ioda2_tce_free(struct iommu_table *=
tbl, long index,
>  static void pnv_ioda2_table_free(struct iommu_table *tbl)
>  {
>  	pnv_pci_ioda2_table_free_pages(tbl);
> -	iommu_free_table(tbl, "pnv");
>  }
> =20
>  static struct iommu_table_ops pnv_ioda2_iommu_ops =3D {
> @@ -2339,7 +2337,7 @@ static long pnv_pci_ioda2_setup_default_config(stru=
ct pnv_ioda_pe *pe)
>  	if (rc) {
>  		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
>  				rc);
> -		pnv_ioda2_table_free(tbl);
> +		iommu_free_table(tbl, "");
>  		return rc;
>  	}
> =20
> @@ -2425,7 +2423,7 @@ static void pnv_ioda2_take_ownership(struct iommu_t=
able_group *table_group)
> =20
>  	pnv_pci_ioda2_set_bypass(pe, false);
>  	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
> -	pnv_ioda2_table_free(tbl);
> +	iommu_free_table(tbl, "pnv");
>  }
> =20
>  static void pnv_ioda2_release_ownership(struct iommu_table_group *table_=
group)
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index c8823578a1b2..cbac08af400e 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -677,7 +677,7 @@ static void tce_iommu_free_table(struct tce_container=
 *container,
>  	unsigned long pages =3D tbl->it_allocated_size >> PAGE_SHIFT;
> =20
>  	tce_iommu_userspace_view_free(tbl, container->mm);
> -	tbl->it_ops->free(tbl);
> +	iommu_free_table(tbl, "");
>  	decrement_locked_vm(container->mm, pages);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYTiREAAoJEGw4ysog2bOSaEkQAK8Mf20LJN2+BU1LgEuBfKNl
mucqMVCWcpxka0InMLfnYH8Q2Jbqi4VReqWIc8Hc8T0R8dPKRdC1JTKuEf+3kYKw
9nJ/hgawXPBQ+XX0JDIxT6InkU7/6061V25hNzGmXa6YncgwMviiOyzFrjK5qHHW
TP/aHH/JjBxdImJN3BDmrcbRe9M5ikZ3fBS74me5wOP1kZ7LdKxv4gtbthK7wsXj
H1ABTF3+75DV6qiIjfox0gwvJFiqHxXc6Z1wbtaFLEF7QM+B/1LP+zmps/TKZgqB
cAwnsEFeLEL9xIP6aiHmDjj96NIZL/Nl7LXZR0A+OCdJN8a+uTf1Z9+bITvRQ8GE
FeHN1bWvFm+/CYuzOnoCFj6tNi941pRlKoYHbAa13u6Xp84fjmfHTHHJnzjqYa1f
pmxl9l8/cY3+hopXRWDWJ4BycD+v30BUbay6d9O1jxaB5F+Dh8Y4fEA68a24NDL1
gL6wG+7KwWYMsXvKC2QeCF1gBgyTTmga9CV2xxPoLeIOL01kOQyk+BM8tSfw5HUp
irTwJlk2ziFfTUf6eoKQNBgJNRDKL3ltNAEhRW3S876yP92qL0B6AP9MO5pIPto5
mgvRBgVv7U4uv24OQ9KHHAtzDZH1xrLD6YArZOkBbJsDRdnw1O1GLl6ixzZmQCbO
bI/eRT+Hmjd+v6O3inas
=Jm1o
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--

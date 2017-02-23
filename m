Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTL6v19LmzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:57:59 +1100 (AEDT)
Date: Thu, 23 Feb 2017 14:31:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v5 03/10] powerpc/iommu/vfio_spapr_tce: Cleanup
 iommu_table disposal
Message-ID: <20170223033138.GF12577@umbus.fritz.box>
References: <20170222082133.10277-1-aik@ozlabs.ru>
 <20170222082133.10277-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UBYeLQbK9sqbzZRV"
In-Reply-To: <20170222082133.10277-4-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--UBYeLQbK9sqbzZRV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2017 at 07:21:26PM +1100, Alexey Kardashevskiy wrote:
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
> As from now on the iommu_free_table() calls it_ops->free(), we need
> to have it_ops initialized before calling iommu_free_table() so this
> moves this initialization in pnv_pci_ioda2_create_table().
>=20
> This should cause no behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v5:
> * moved "tbl->it_ops =3D &pnv_ioda2_iommu_ops" earlier and updated
> the commit log
> ---
>  arch/powerpc/kernel/iommu.c               |  4 ++++
>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++------
>  drivers/vfio/vfio_iommu_spapr_tce.c       |  2 +-
>  3 files changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 9bace5df05d5..bc142d87130f 100644
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
> index 133c7f300c12..27801c61ebdb 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1423,7 +1423,6 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci=
_dev *dev, struct pnv_ioda_pe
>  		iommu_group_put(pe->table_group.group);
>  		BUG_ON(pe->table_group.group);
>  	}
> -	pnv_pci_ioda2_table_free_pages(tbl);
>  	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
>  }
> =20
> @@ -2040,7 +2039,6 @@ static void pnv_ioda2_tce_free(struct iommu_table *=
tbl, long index,
>  static void pnv_ioda2_table_free(struct iommu_table *tbl)
>  {
>  	pnv_pci_ioda2_table_free_pages(tbl);
> -	iommu_free_table(tbl, "pnv");
>  }
> =20
>  static struct iommu_table_ops pnv_ioda2_iommu_ops =3D {
> @@ -2317,6 +2315,8 @@ static long pnv_pci_ioda2_create_table(struct iommu=
_table_group *table_group,
>  	if (!tbl)
>  		return -ENOMEM;
> =20
> +	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
> +
>  	ret =3D pnv_pci_ioda2_table_alloc_pages(nid,
>  			bus_offset, page_shift, window_size,
>  			levels, tbl);
> @@ -2325,8 +2325,6 @@ static long pnv_pci_ioda2_create_table(struct iommu=
_table_group *table_group,
>  		return ret;
>  	}
> =20
> -	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
> -
>  	*ptbl =3D tbl;
> =20
>  	return 0;
> @@ -2367,7 +2365,7 @@ static long pnv_pci_ioda2_setup_default_config(stru=
ct pnv_ioda_pe *pe)
>  	if (rc) {
>  		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
>  				rc);
> -		pnv_ioda2_table_free(tbl);
> +		iommu_free_table(tbl, "");
>  		return rc;
>  	}
> =20
> @@ -2455,7 +2453,7 @@ static void pnv_ioda2_take_ownership(struct iommu_t=
able_group *table_group)
>  	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
>  	if (pe->pbus)
>  		pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
> -	pnv_ioda2_table_free(tbl);
> +	iommu_free_table(tbl, "pnv");
>  }
> =20
>  static void pnv_ioda2_release_ownership(struct iommu_table_group *table_=
group)
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 59b3f62a2d64..ffab01874a22 100644
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

--UBYeLQbK9sqbzZRV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrleaAAoJEGw4ysog2bOS1U0QAMzCq9ygH6NblVxRJ6hQSVcg
6Po4iRORaWHKSSkMXr3B64Zzv3GAUy3GXjCzdt2RXXcXlSbPBesAXIcD+nkCIrnA
C2S940+aMOnIVqBmMsOnZRHjAKqytSSCAkvOJTB20tGWaTbdeP28OtL7Bi+hlcCU
OY8WE7sVSBuvrSjUZk+1Va0Aop+328SzZvdLgMumVxw6MWtrQqTI+tOzfjUqCQgM
UQszT8FV94I96Wj+1urCkYmCrUPRswfImn8/m7rokGPfe/57AdnxOVMXkg8pT3pY
MiYajRRTIICrXUxJCwtgWGoiONj+gHXvUp85eg80/+TroGWeOnSItKcMV7lNKehq
eoLZJdyGhARrehp0G1PSWtKKE4ezUHRKKj8NzavQdjB5dpvfGJTYcYsgdjL9Owp4
V/mrh6hhFXLhOrNrT6d74bUxljavEhFaieA/jVOl4DENd0vX1sCbwpKKI42lBmiV
RtOXgYxl4bnU+8wTj06sVpnk9rF7Cnu5nQENcmLWs3p3sNHJ9GfEWLZgnJeyZP2Z
mJorN9vyygYwAtfot6Fv7d5NoLQJfWEBfoSpz/+kSJ+inFVc8or30AoLdYv9b1mo
bY/d1hXVD7/abYovLpIVTEwG8wrOiVFv1TIkNRP/1u8JbYtH0InZ4jOaSKQJDH28
eYs+7uMaXLrwqoOJaZML
=3g+D
-----END PGP SIGNATURE-----

--UBYeLQbK9sqbzZRV--

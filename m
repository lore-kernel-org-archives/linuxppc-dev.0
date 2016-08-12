Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9VRc17BLzDqJ4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 13:17:00 +1000 (AEST)
Date: Fri, 12 Aug 2016 13:18:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 07/15] powerpc/iommu: Cleanup iommu_table disposal
Message-ID: <20160812031855.GJ16493@voom.fritz.box>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-8-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
In-Reply-To: <1470213656-1042-8-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 06:40:48PM +1000, Alexey Kardashevskiy wrote:
> At the moment iommu_table could be disposed by either calling
> iommu_table_free() directly or it_ops::free() which only implementation
> for IODA2 calls iommu_table_free() anyway.
>=20
> As we are going to have reference counting on tables, we need an unified
> way of disposing tables.
>=20
> This moves it_ops::free() call into iommu_free_table() and makes use
> of the latter everywhere. The free() callback now handles only
> platform-specific data.
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
> index a8e3490..13263b0 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -718,6 +718,9 @@ void iommu_free_table(struct iommu_table *tbl, const =
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
> @@ -744,6 +747,7 @@ void iommu_free_table(struct iommu_table *tbl, const =
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
> index 59c7e7d..74ab8382 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1394,7 +1394,6 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci=
_dev *dev, struct pnv_ioda_pe
>  		iommu_group_put(pe->table_group.group);
>  		BUG_ON(pe->table_group.group);
>  	}
> -	pnv_pci_ioda2_table_free_pages(tbl);
>  	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
>  }
> =20
> @@ -1987,7 +1986,6 @@ static void pnv_ioda2_tce_free(struct iommu_table *=
tbl, long index,
>  static void pnv_ioda2_table_free(struct iommu_table *tbl)
>  {
>  	pnv_pci_ioda2_table_free_pages(tbl);
> -	iommu_free_table(tbl, "pnv");
>  }
> =20
>  static struct iommu_table_ops pnv_ioda2_iommu_ops =3D {
> @@ -2313,7 +2311,7 @@ static long pnv_pci_ioda2_setup_default_config(stru=
ct pnv_ioda_pe *pe)
>  	if (rc) {
>  		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
>  				rc);
> -		pnv_ioda2_table_free(tbl);
> +		iommu_free_table(tbl, "");
>  		return rc;
>  	}
> =20
> @@ -2399,7 +2397,7 @@ static void pnv_ioda2_take_ownership(struct iommu_t=
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
> index 40e71a0..79f26c7 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -660,7 +660,7 @@ static void tce_iommu_free_table(struct iommu_table *=
tbl)
>  	unsigned long pages =3D tbl->it_allocated_size >> PAGE_SHIFT;
> =20
>  	tce_iommu_userspace_view_free(tbl);
> -	tbl->it_ops->free(tbl);
> +	iommu_free_table(tbl, "");
>  	decrement_locked_vm(pages);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrUAfAAoJEGw4ysog2bOSbDQP/j7D6SuWHxhLAswB6QUzXAoj
JKDh40JrRxIT+JxKGn//jZlUndFog5RydlCHYKqKofAOe8F/+yxDT3GXN79PEjym
fxGdnCwEaKwyi17XsghR40D54Q+C4R9d/9r1FUaD/mv1Yj8U4PF91B8OwrFzyXhJ
iT7HPormD0IG2OEl7ul52k1O4DlI4IlGBCiszG9EriKyLsmpuo6G6lOOuvflomzm
A+MMG1v2YT9sw6K8Dzf1MWROOxWMhCtbOY0OWtd3v60cR8h7R8IeA/rqQqjxgDXK
3cFTx9ZjYZR9QlCbw5uneITDexEI8cbBi0Vpws64lCfJ0Ijbwp27l4p4NaAM91jX
N1yxIyRBy37e/UlwoTCc0kG10BhOtipu13w6WAOmpNklW566NFRh9TzEZOHntT35
IP7moxAmpxTxiCfLbaUEKEBF4cLJ8A3CeM1XEISrgujdbLx/ctqRfoCcjj0dVecH
Be2KEvJRwbthv3xjmmZAbJTejthxmIOeEwu4auYA5HzpQ0hVcQ/eXb4uMhoYaWJS
uBybq0olQXiwyhQNbKEVzGAdyeDsogPGtFEhWFuIwFrqyNCx/FgR3o7R2islG2uV
bDWD25q9GemG8ojVYb6+IwEWDlYnX8S4ryVIBMtsvhE3KZ5WygTkQWkFpTlb4dUd
l8KjPXDS+ETetJnmIb4G
=fsIA
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--

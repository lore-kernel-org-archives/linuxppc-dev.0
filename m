Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfwty6mQ4zDw67
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 14:35:38 +1100 (AEDT)
Date: Fri, 16 Dec 2016 12:06:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 6/9] powerpc/powernv/iommu: Add real mode version
 of iommu_table_ops::exchange()
Message-ID: <20161216010623.GC12146@umbus.fritz.box>
References: <20161208081956.26221-1-aik@ozlabs.ru>
 <20161208081956.26221-7-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
In-Reply-To: <20161208081956.26221-7-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2016 at 07:19:53PM +1100, Alexey Kardashevskiy wrote:
> In real mode, TCE tables are invalidated using special
> cache-inhibited store instructions which are not available in
> virtual mode
>=20
> This defines and implements exchange_rm() callback. This does not
> define set_rm/clear_rm/flush_rm callbacks as there is no user for those -
> exchange/exchange_rm are only to be used by KVM for VFIO.
>=20
> The exchange_rm callback is defined for IODA1/IODA2 powernv platforms.
>=20
> This replaces list_for_each_entry_rcu with its lockless version as
> from now on pnv_pci_ioda2_tce_invalidate() can be called in
> the real mode too.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/iommu.h          |  7 +++++++
>  arch/powerpc/kernel/iommu.c               | 23 +++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c | 26 +++++++++++++++++++++++++-
>  3 files changed, 55 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 9de8bad1fdf9..82e77ebf85f4 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -64,6 +64,11 @@ struct iommu_table_ops {
>  			long index,
>  			unsigned long *hpa,
>  			enum dma_data_direction *direction);
> +	/* Real mode */
> +	int (*exchange_rm)(struct iommu_table *tbl,
> +			long index,
> +			unsigned long *hpa,
> +			enum dma_data_direction *direction);
>  #endif
>  	void (*clear)(struct iommu_table *tbl,
>  			long index, long npages);
> @@ -209,6 +214,8 @@ extern void iommu_del_device(struct device *dev);
>  extern int __init tce_iommu_bus_notifier_init(void);
>  extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
>  		unsigned long *hpa, enum dma_data_direction *direction);
> +extern long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long ent=
ry,
> +		unsigned long *hpa, enum dma_data_direction *direction);
>  #else
>  static inline void iommu_register_group(struct iommu_table_group *table_=
group,
>  					int pci_domain_number,
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index d12496889ce9..d02b8d22fb50 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1022,6 +1022,29 @@ long iommu_tce_xchg(struct iommu_table *tbl, unsig=
ned long entry,
>  }
>  EXPORT_SYMBOL_GPL(iommu_tce_xchg);
> =20
> +long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long entry,
> +		unsigned long *hpa, enum dma_data_direction *direction)
> +{
> +	long ret;
> +
> +	ret =3D tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
> +
> +	if (!ret && ((*direction =3D=3D DMA_FROM_DEVICE) ||
> +			(*direction =3D=3D DMA_BIDIRECTIONAL))) {
> +		struct page *pg =3D realmode_pfn_to_page(*hpa >> PAGE_SHIFT);
> +
> +		if (likely(pg)) {
> +			SetPageDirty(pg);
> +		} else {
> +			tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
> +			ret =3D -EFAULT;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_tce_xchg_rm);
> +
>  int iommu_take_ownership(struct iommu_table *tbl)
>  {
>  	unsigned long flags, i, sz =3D (tbl->it_size + 7) >> 3;
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index ea181f02bebd..f2c2ab8fbb3e 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1855,6 +1855,17 @@ static int pnv_ioda1_tce_xchg(struct iommu_table *=
tbl, long index,
> =20
>  	return ret;
>  }
> +
> +static int pnv_ioda1_tce_xchg_rm(struct iommu_table *tbl, long index,
> +		unsigned long *hpa, enum dma_data_direction *direction)
> +{
> +	long ret =3D pnv_tce_xchg(tbl, index, hpa, direction);
> +
> +	if (!ret)
> +		pnv_pci_p7ioc_tce_invalidate(tbl, index, 1, true);
> +
> +	return ret;
> +}
>  #endif
> =20
>  static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
> @@ -1869,6 +1880,7 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops =
=3D {
>  	.set =3D pnv_ioda1_tce_build,
>  #ifdef CONFIG_IOMMU_API
>  	.exchange =3D pnv_ioda1_tce_xchg,
> +	.exchange_rm =3D pnv_ioda1_tce_xchg_rm,
>  #endif
>  	.clear =3D pnv_ioda1_tce_free,
>  	.get =3D pnv_tce_get,
> @@ -1943,7 +1955,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct iom=
mu_table *tbl,
>  {
>  	struct iommu_table_group_link *tgl;
> =20
> -	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
> +	list_for_each_entry_lockless(tgl, &tbl->it_group_list, next) {
>  		struct pnv_ioda_pe *pe =3D container_of(tgl->table_group,
>  				struct pnv_ioda_pe, table_group);
>  		struct pnv_phb *phb =3D pe->phb;
> @@ -1999,6 +2011,17 @@ static int pnv_ioda2_tce_xchg(struct iommu_table *=
tbl, long index,
> =20
>  	return ret;
>  }
> +
> +static int pnv_ioda2_tce_xchg_rm(struct iommu_table *tbl, long index,
> +		unsigned long *hpa, enum dma_data_direction *direction)
> +{
> +	long ret =3D pnv_tce_xchg(tbl, index, hpa, direction);
> +
> +	if (!ret)
> +		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, true);
> +
> +	return ret;
> +}
>  #endif
> =20
>  static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
> @@ -2018,6 +2041,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops =
=3D {
>  	.set =3D pnv_ioda2_tce_build,
>  #ifdef CONFIG_IOMMU_API
>  	.exchange =3D pnv_ioda2_tce_xchg,
> +	.exchange_rm =3D pnv_ioda2_tce_xchg_rm,
>  #endif
>  	.clear =3D pnv_ioda2_tce_free,
>  	.get =3D pnv_tce_get,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUz4PAAoJEGw4ysog2bOSvCsP/Azsk3XvW/e9+tjVl4Pn9uWK
mmiz5BdPZad/T8GfGxQjuInhQ80o9TGxh+u1q+N6TjXsm66hP/isDl9NtnEyn2ra
PqU3W+gN3P+jYVKPYF4XKBR0vnsM99DJWXxUrYZnMYgAcYmRRbALdnzlOY3EZ2Ei
dtZnSAm3b6yiCrVp19wRUtyoTscE3XzT5iLacH53SF700iS+vVutK+cIYp0Hso8N
Isy2/wd3H+XK+2sXnXj/t8CRP2W6V/ZkfqhK41nFFd0HOXKUcIUwL45HawJKw4C+
mkwauUi6J5Gvz58+TPml9+WMxPZ/yFwPPxy5llUCNdp6q7Iohydh8FTCmbPtWGl5
SN5eiHnO6sIrvZmer9e1TiOUsHWNBMvCdsa1tOb+6HqlT6rvmdyM0/v/XUVTrhu9
ZAN4zvcvBJDFIl8fmiiwKRIeIQR+lHnnQx6ILAb+nCj9ZPqOeBF/e1RyrXva0QLn
dQLQ4zjKb6sfPNNpoIB/AcvKHfcpRBC23Wfw5FoKGlWu88QTHLrErNkNa9yeuy+j
xCCLL+jwT11q61e6kekESlsBjl0B1ulxT2XRq+BHzJpwLXUEL5OqIrYwPtF7xRqs
tRgW7MXMPl28XOj/4PFzq3wsu6mi9kjMFOLOSbNE92JxVhtJRFneV92Hcm09TDNW
2Bu3Fx1rjv/v6RWxjhJ8
=eG3e
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--

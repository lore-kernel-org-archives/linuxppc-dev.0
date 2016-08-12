Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9XTd5lsHzDr1r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 14:48:53 +1000 (AEST)
Date: Fri, 12 Aug 2016 14:29:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 11/15] powerpc/powernv/iommu: Add real mode
 version of iommu_table_ops::exchange()
Message-ID: <20160812042902.GN16493@voom.fritz.box>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-12-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4Y142/9l9nQlBiaj"
In-Reply-To: <1470213656-1042-12-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--4Y142/9l9nQlBiaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 06:40:52PM +1000, Alexey Kardashevskiy wrote:
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
> ---
>  arch/powerpc/include/asm/iommu.h          |  7 +++++++
>  arch/powerpc/kernel/iommu.c               | 23 +++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c | 26 +++++++++++++++++++++++++-
>  3 files changed, 55 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index cd4df44..a13d207 100644
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
> index a8f017a..65b2dac 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1020,6 +1020,29 @@ long iommu_tce_xchg(struct iommu_table *tbl, unsig=
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

Isn't there a race here, if someone else updates this TCE entry
between your initial exchange and the rollback exchange below?

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
> index c04afd2..a0b5ea6 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1827,6 +1827,17 @@ static int pnv_ioda1_tce_xchg(struct iommu_table *=
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
> @@ -1841,6 +1852,7 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops =
=3D {
>  	.set =3D pnv_ioda1_tce_build,
>  #ifdef CONFIG_IOMMU_API
>  	.exchange =3D pnv_ioda1_tce_xchg,
> +	.exchange_rm =3D pnv_ioda1_tce_xchg_rm,
>  #endif
>  	.clear =3D pnv_ioda1_tce_free,
>  	.get =3D pnv_tce_get,
> @@ -1915,7 +1927,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct iom=
mu_table *tbl,
>  {
>  	struct iommu_table_group_link *tgl;
> =20
> -	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
> +	list_for_each_entry_lockless(tgl, &tbl->it_group_list, next) {

So.. IIUC, previously this had a bool rm parameter, but wouldn't
actually work in real mode even if it was set?

>  		struct pnv_ioda_pe *pe =3D container_of(tgl->table_group,
>  				struct pnv_ioda_pe, table_group);
>  		struct pnv_phb *phb =3D pe->phb;
> @@ -1973,6 +1985,17 @@ static int pnv_ioda2_tce_xchg(struct iommu_table *=
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
> @@ -1992,6 +2015,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops =
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

--4Y142/9l9nQlBiaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrVCOAAoJEGw4ysog2bOSPZMQALxKk5a+NFs7+Y4jgQOLI6AJ
Yc396uKg0FFgGZZaMUIB8MfpZ2XjA/eDCfNFuln7+BC9kVX4u0YQi0q1tjCSsYmQ
RNoRJftOpfLouEiOOkoBEalzcjWhGuchy/paUjuIU/UBn4c9rmS8wN8MQn1a0gfy
Zkzj1Y4OpqaWgiKZoUsAgMcVnpHRu5atXa5i2ohiFJa3xzqHQ/S1v27+7JhXuI2y
uP2IBuJ+1eSEPpWSefBEzGMuNy3gfvkir4Yc/uUdmREXeQ+QrtCK7gB3VqANXsG9
XgoM0yUkOeH5K6HpwmBNv+NSBG1ghJ8B7uAlOqyWVatnM4Uw+1yUuGdABgeNtxR8
hbVp8bGiXVEZX5gRjfXw+X+7RJ/7u8V7pBhQ+Ki9UmWM+OVlO9oI4HfuMpNL6s9+
OfD6KWFzFB/XL/KoOzYZk9YxEmq8FwqyyfDhbjHfu3yEMrSlp1IiZjNaakqOnmjM
pJc9v3HGMVEuUp+/sXhN7dLTrkZBzek6/SjZl1BF8fIQoyTFkJzvfLq3mZAUZkwZ
5aJz6tB9+FvJiCemTebW+/DBo6tkfLKFgRD8D/mExaIfdFhOsaGkESO7gs7B8V2G
9vGuF62ckqKZIxtSBAd3kCaxm14lCqF0UxIRJmJYGSFkjRuylMaqataxnPvTQimo
7c1yXwpmXorv6LzYwhuU
=/7PC
-----END PGP SIGNATURE-----

--4Y142/9l9nQlBiaj--

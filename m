Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62DE41A02B5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 18:30:25 +1100 (AEDT)
Date: Mon, 7 Mar 2016 17:05:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 4/9] powerpc/powernv/iommu: Add real mode version
 of xchg()
Message-ID: <20160307060519.GM22546@voom.fritz.box>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-5-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vdqwC0msT4ilQ2it"
In-Reply-To: <1457322077-26640-5-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vdqwC0msT4ilQ2it
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 02:41:12PM +1100, Alexey Kardashevskiy wrote:
> In real mode, TCE tables are invalidated using different
> cache-inhibited store instructions which is different from
> the virtual mode.
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
>  arch/powerpc/kernel/iommu.c               | 15 +++++++++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c | 28 +++++++++++++++++++++++++=
++-
>  3 files changed, 49 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 7b87bab..3ca877a 100644
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
> @@ -208,6 +213,8 @@ extern void iommu_del_device(struct device *dev);
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
> index a8e3490..2fcc48b 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1062,6 +1062,21 @@ void iommu_release_ownership(struct iommu_table *t=
bl)
>  }
>  EXPORT_SYMBOL_GPL(iommu_release_ownership);
> =20
> +long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long entry,
> +		unsigned long *hpa, enum dma_data_direction *direction)
> +{
> +	long ret;
> +
> +	ret =3D tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
> +
> +	if (!ret && ((*direction =3D=3D DMA_FROM_DEVICE) ||
> +			(*direction =3D=3D DMA_BIDIRECTIONAL)))
> +		SetPageDirty(realmode_pfn_to_page(*hpa >> PAGE_SHIFT));
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_tce_xchg_rm);

>  int iommu_add_device(struct device *dev)
>  {
>  	struct iommu_table *tbl;
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index c5baaf3..bed1944 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1791,6 +1791,18 @@ static int pnv_ioda1_tce_xchg(struct iommu_table *=
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
> +	if (!ret && (tbl->it_type &
> +			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
> +		pnv_pci_ioda1_tce_invalidate(tbl, index, 1, true);
> +
> +	return ret;
> +}
>  #endif

Both your _rm variants are identical to the non _rm versions.  Why not
just set the function poiinter to the same thing, rather than copying
the whole function.

>  static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
> @@ -1806,6 +1818,7 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops =
=3D {
>  	.set =3D pnv_ioda1_tce_build,
>  #ifdef CONFIG_IOMMU_API
>  	.exchange =3D pnv_ioda1_tce_xchg,
> +	.exchange_rm =3D pnv_ioda1_tce_xchg_rm,
>  #endif
>  	.clear =3D pnv_ioda1_tce_free,
>  	.get =3D pnv_tce_get,
> @@ -1866,7 +1879,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct iom=
mu_table *tbl,
>  {
>  	struct iommu_table_group_link *tgl;
> =20
> -	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
> +	list_for_each_entry_lockless(tgl, &tbl->it_group_list, next) {
>  		struct pnv_ioda_pe *npe;
>  		struct pnv_ioda_pe *pe =3D container_of(tgl->table_group,
>  				struct pnv_ioda_pe, table_group);
> @@ -1918,6 +1931,18 @@ static int pnv_ioda2_tce_xchg(struct iommu_table *=
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
> +	if (!ret && (tbl->it_type &
> +			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
> +		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, true);
> +
> +	return ret;
> +}
>  #endif
> =20
>  static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
> @@ -1939,6 +1964,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops =
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

--vdqwC0msT4ilQ2it
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW3RofAAoJEGw4ysog2bOSmbMP/RBQTV6KbIuQu87h12uGhJJ4
82Ct42CaF9nyfak0negeOfmsjHJTsAlrOzw3EtI6VrDwVLo3CT+ZB0sNaQrI9eMP
dOoP3Pq2rNvioqF+phqi4Vmx3+h4Ptue2UNAgqdSjsZQRTJ6FSjeP8xqvS5MLW5B
XEDmhtP1fE5Q/DHOPuf3lub3DeCW+1G+P7f5wvsBBnNXl/RNoBQi2VIQzhdGSvfz
yYgLRIuWNEHc1uJ/KlkFGkgfphRM+5r0VWKYrGHYxYUjWkhHReqhAOInu5hBeHS3
Pz7iUD/kH7oHNSPk86Ez8gktjdUGrE2a69/hFDwqxGS+/buAUHUh0CbYS4fykflB
T/paXcF0Dx2GRLuuD7G+g99dQKDFdiQ8CJYRR1REQVI/RpBUnidK8EYrXH65qDRc
zkhKoCnVTXV1QpIZe2sqEsxomWOnf4OsPohCJRoY6F0Dth6u4p2qq4v3ahRdoY6X
w3MdLH/76AQ2ZwKhg83CnRhMY1OqgqbSa1ouPufBnINBXZ31oCHRtb2bMiuNFkuM
TWmnDKi1CRIJai04mUPnSRG9ntv1wQwcvbL9PIKUKK7y3bdkpU1cnWEzay21X/Qp
3dolSxvrKXmAfibD322cIMVpT9loQ/bHjsNLDtt4aXufZWMk9NE8oblHD5qVNCFU
bJNGwvDcj1Sva9AyXoAf
=773Y
-----END PGP SIGNATURE-----

--vdqwC0msT4ilQ2it--

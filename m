Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFB781A009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:44:10 +1100 (AEDT)
Date: Thu, 10 Mar 2016 16:42:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel 04/10] powerpc/powernv/npu: TCE Kill helpers cleanup
Message-ID: <20160310054209.GA22546@voom.fritz.box>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
 <1457504946-40649-5-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wtO4+9l+3RkKLqxD"
In-Reply-To: <1457504946-40649-5-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--wtO4+9l+3RkKLqxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 05:29:00PM +1100, Alexey Kardashevskiy wrote:
> NPU PHB TCE Kill register is exactly the same as in the rest of POWER8
> so let's reuse the existing code for NPU. The only bit missing is
> a helper to reset the entire TCE cache so this moves such a helper
> from NPU code and renames it.
>=20
> Since pnv_npu_tce_invalidate() does really invalidate the entire cache,
> this uses pnv_pci_ioda2_tce_invalidate_entire() directly for NPU.
> This adds an explicit comment for workaround for invalidating NPU TCE
> cache.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/npu-dma.c  | 41 -------------------------=
------
>  arch/powerpc/platforms/powernv/pci-ioda.c | 29 ++++++++++++++++++----
>  arch/powerpc/platforms/powernv/pci.h      |  7 +-----
>  3 files changed, 25 insertions(+), 52 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/plat=
forms/powernv/npu-dma.c
> index 7229acd..778570c 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -25,8 +25,6 @@
>   * Other types of TCE cache invalidation are not functional in the
>   * hardware.
>   */
> -#define TCE_KILL_INVAL_ALL PPC_BIT(0)
> -
>  static struct pci_dev *get_pci_dev(struct device_node *dn)
>  {
>  	return PCI_DN(dn)->pcidev;
> @@ -161,45 +159,6 @@ static struct pnv_ioda_pe *get_gpu_pci_dev_and_pe(st=
ruct pnv_ioda_pe *npe,
>  	return pe;
>  }
> =20
> -void pnv_npu_tce_invalidate_entire(struct pnv_ioda_pe *npe)
> -{
> -	struct pnv_phb *phb =3D npe->phb;
> -
> -	if (WARN_ON(phb->type !=3D PNV_PHB_NPU ||
> -		    !phb->ioda.tce_inval_reg ||
> -		    !(npe->flags & PNV_IODA_PE_DEV)))
> -		return;
> -
> -	mb(); /* Ensure previous TCE table stores are visible */
> -	__raw_writeq(cpu_to_be64(TCE_KILL_INVAL_ALL),
> -		phb->ioda.tce_inval_reg);
> -}
> -
> -void pnv_npu_tce_invalidate(struct pnv_ioda_pe *npe,
> -				struct iommu_table *tbl,
> -				unsigned long index,
> -				unsigned long npages,
> -				bool rm)
> -{
> -	struct pnv_phb *phb =3D npe->phb;
> -
> -	/* We can only invalidate the whole cache on NPU */
> -	unsigned long val =3D TCE_KILL_INVAL_ALL;
> -
> -	if (WARN_ON(phb->type !=3D PNV_PHB_NPU ||
> -		    !phb->ioda.tce_inval_reg ||
> -		    !(npe->flags & PNV_IODA_PE_DEV)))
> -		return;
> -
> -	mb(); /* Ensure previous TCE table stores are visible */
> -	if (rm)
> -		__raw_rm_writeq(cpu_to_be64(val),
> -		  (__be64 __iomem *) phb->ioda.tce_inval_reg_phys);
> -	else
> -		__raw_writeq(cpu_to_be64(val),
> -			phb->ioda.tce_inval_reg);
> -}
> -
>  void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe)
>  {
>  	struct pnv_ioda_pe *gpe;
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 33e9489..90cdf49 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1824,9 +1824,23 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops =
=3D {
>  	.get =3D pnv_tce_get,
>  };
> =20
> +#define TCE_KILL_INVAL_ALL  PPC_BIT(0)
>  #define TCE_KILL_INVAL_PE   PPC_BIT(1)
>  #define TCE_KILL_INVAL_TCE  PPC_BIT(2)
> =20
> +void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
> +{
> +	const unsigned long val =3D TCE_KILL_INVAL_ALL;
> +
> +	mb(); /* Ensure previous TCE table stores are visible */
> +	if (rm)
> +		__raw_rm_writeq(cpu_to_be64(val),
> +				(__be64 __iomem *)
> +				phb->ioda.tce_inval_reg_phys);
> +	else
> +		__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
> +}
> +
>  static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *p=
e)
>  {
>  	/* 01xb - invalidate TCEs that match the specified PE# */
> @@ -1847,7 +1861,7 @@ static inline void pnv_pci_ioda2_tce_invalidate_pe(=
struct pnv_ioda_pe *pe)
>  			if (!npe || npe->phb->type !=3D PNV_PHB_NPU)
>  				continue;
> =20
> -			pnv_npu_tce_invalidate_entire(npe);
> +			pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
>  		}
>  }
> =20
> @@ -1896,14 +1910,19 @@ static void pnv_pci_ioda2_tce_invalidate(struct i=
ommu_table *tbl,
>  			index, npages);
> =20
>  		if (pe->flags & PNV_IODA_PE_PEER)
> -			/* Invalidate PEs using the same TCE table */
> +			/*
> +			 * The NVLink hardware does not support TCE kill
> +			 * per TCE entry so we have to invalidate
> +			 * the entire cache for it.
> +			 */
>  			for (i =3D 0; i < PNV_IODA_MAX_PEER_PES; i++) {
>  				npe =3D pe->peers[i];
> -				if (!npe || npe->phb->type !=3D PNV_PHB_NPU)
> +				if (!npe || npe->phb->type !=3D PNV_PHB_NPU ||
> +						!npe->phb->ioda.tce_inval_reg)
>  					continue;
> =20
> -				pnv_npu_tce_invalidate(npe, tbl, index,
> -							npages, rm);
> +				pnv_pci_ioda2_tce_invalidate_entire(npe->phb,
> +						rm);
>  			}
>  	}
>  }
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 3f814f3..0b89a4c 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -237,15 +237,10 @@ extern int pnv_setup_msi_irqs(struct pci_dev *pdev,=
 int nvec, int type);
>  extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
> =20
>  /* Nvlink functions */
> -extern void pnv_npu_tce_invalidate_entire(struct pnv_ioda_pe *npe);
> -extern void pnv_npu_tce_invalidate(struct pnv_ioda_pe *npe,
> -				       struct iommu_table *tbl,
> -				       unsigned long index,
> -				       unsigned long npages,
> -				       bool rm);
>  extern void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe);
>  extern void pnv_npu_setup_dma_pe(struct pnv_ioda_pe *npe);
>  extern int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe, bool enabled);
>  extern int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask);
> +extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, boo=
l rm);
> =20
>  #endif /* __POWERNV_PCI_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wtO4+9l+3RkKLqxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW4QkwAAoJEGw4ysog2bOSlhkP/2vJALIDhbgilvaInVhEvG3F
gXq3+4H/G7v6K0w0UygmH2HgVcMSbCf155NJGuihBqcVGSGCQSsfkEqMv0Kgv3Xj
UYgMpuol6jnI2sPUwpmk2oQ7YiXKOHoBpKXzgS78LxN5hEOBbs8D1iwWGnJ6X0ck
xxrrKeXsJEKDXh14Z7XY3PK06Jm8kSJiVrPWPhLZQVUNhIXSONjsUfdBZFl4FEED
dVxpgGZvwWCGE2LgTM64Z1Kvs3rHgHezNqQArsMYeyPEsB/Da8yO41xLIsK8pG01
DBKhS5ecadON077uhrwZ1SmkvD+QeNlSFD5oTRfml+6h0qI818Lo1ARRpDB44S5n
/XMgF9ZrmV24Q+aNPziwxZlHNpYD9/Ho9Vj4AHzjD3FBcef1USdULpjfh58uDg7J
FDagTDKqSqdviG81WqM32izwLTCwBNC4UxLFYqOutsjJYKlkqPbYuRfJa/ftH3Jn
4r/15EfFVaLd7mKQXfSVqnCTK6eQMqCjRO5Notb5+zboj9NnYKntcgThoPercsQ8
9Fat9i7sAo6wnobLVJ5g9fZ/g+RLvgEaV6YbxCnUpBAn50tfVYdTh+MLbeABbOc6
dOd1KA6bXsl/xr7M4Wa9benXm2fz6Ij1RRenZB+EUQKiIb1h4/HVRmtSk6cVvumE
YnUCrZJTSQx/WIDYEsRI
=sYNw
-----END PGP SIGNATURE-----

--wtO4+9l+3RkKLqxD--

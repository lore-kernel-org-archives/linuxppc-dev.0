Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 320A81A001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 15:58:24 +1000 (AEST)
Date: Thu, 16 Apr 2015 15:31:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 11/31] powerpc/iommu: Introduce
 iommu_table_alloc() helper
Message-ID: <20150416053138.GB3632@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-12-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
In-Reply-To: <1428647473-11738-12-git-send-email-aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:53PM +1000, Alexey Kardashevskiy wrote:
> This replaces multiple calls of kzalloc_node() with a new
> iommu_table_alloc() helper. Right now it calls kzalloc_node() but
> later it will be modified to allocate a iommu_table_group struct with
> a single iommu_table in it.
>=20
> Later the helper will allocate a iommu_table_group struct which embeds
> the iommu table(s).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

I'd prefer to see this folded into the next patch.  This one's very
simple and I have trouble making sense of it without the next.

> ---
>  arch/powerpc/include/asm/iommu.h       |  1 +
>  arch/powerpc/kernel/iommu.c            |  9 +++++++++
>  arch/powerpc/platforms/powernv/pci.c   |  2 +-
>  arch/powerpc/platforms/pseries/iommu.c | 12 ++++--------
>  4 files changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index d909e2a..eb75726 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -117,6 +117,7 @@ static inline void *get_iommu_table_base(struct devic=
e *dev)
>  	return dev->archdata.dma_data.iommu_table_base;
>  }
> =20
> +extern struct iommu_table *iommu_table_alloc(int node);
>  /* Frees table for an individual device node */
>  extern void iommu_free_table(struct iommu_table *tbl, const char *node_n=
ame);
> =20
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index eceb214..b39d00a 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -710,6 +710,15 @@ struct iommu_table *iommu_init_table(struct iommu_ta=
ble *tbl, int nid)
>  	return tbl;
>  }
> =20
> +struct iommu_table *iommu_table_alloc(int node)
> +{
> +	struct iommu_table *tbl;
> +
> +	tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
> +
> +	return tbl;
> +}
> +
>  void iommu_free_table(struct iommu_table *tbl, const char *node_name)
>  {
>  	unsigned long bitmap_sz;
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index c619ec6..1c31ac8 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -680,7 +680,7 @@ static struct iommu_table *pnv_pci_setup_bml_iommu(st=
ruct pci_controller *hose)
>  		       hose->dn->full_name);
>  		return NULL;
>  	}
> -	tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, hose->node=
);
> +	tbl =3D iommu_table_alloc(hose->node);
>  	if (WARN_ON(!tbl))
>  		return NULL;
>  	pnv_pci_setup_iommu_table(tbl, __va(be64_to_cpup(basep)),
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platfo=
rms/pseries/iommu.c
> index 48d1fde..41a8b14 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -617,8 +617,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus =
*bus)
>  	pci->phb->dma_window_size =3D 0x8000000ul;
>  	pci->phb->dma_window_base_cur =3D 0x8000000ul;
> =20
> -	tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
> -			   pci->phb->node);
> +	tbl =3D iommu_table_alloc(pci->phb->node);
> =20
>  	iommu_table_setparms(pci->phb, dn, tbl);
>  	tbl->it_ops =3D &iommu_table_pseries_ops;
> @@ -669,8 +668,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bu=
s *bus)
>  		 pdn->full_name, ppci->iommu_table);
> =20
>  	if (!ppci->iommu_table) {
> -		tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
> -				   ppci->phb->node);
> +		tbl =3D iommu_table_alloc(ppci->phb->node);
>  		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
>  		tbl->it_ops =3D &iommu_table_lpar_multi_ops;
>  		ppci->iommu_table =3D iommu_init_table(tbl, ppci->phb->node);
> @@ -697,8 +695,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev =
*dev)
>  		struct pci_controller *phb =3D PCI_DN(dn)->phb;
> =20
>  		pr_debug(" --> first child, no bridge. Allocating iommu table.\n");
> -		tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
> -				   phb->node);
> +		tbl =3D iommu_table_alloc(phb->node);
>  		iommu_table_setparms(phb, dn, tbl);
>  		tbl->it_ops =3D &iommu_table_pseries_ops;
>  		PCI_DN(dn)->iommu_table =3D iommu_init_table(tbl, phb->node);
> @@ -1120,8 +1117,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_=
dev *dev)
> =20
>  	pci =3D PCI_DN(pdn);
>  	if (!pci->iommu_table) {
> -		tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
> -				   pci->phb->node);
> +		tbl =3D iommu_table_alloc(pci->phb->node);
>  		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
>  		tbl->it_ops =3D &iommu_table_lpar_multi_ops;
>  		pci->iommu_table =3D iommu_init_table(tbl, pci->phb->node);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVL0k6AAoJEGw4ysog2bOSbzcP/3vYap8Xv0NkYOhAEnXZsC6O
M5jE2uE7ZSVlTEZOx81qSuZtyMLCOUTZsPdx/4I4ZwDNAnzCChimwdlXsI0kjsAp
1LTDOsPOBAR9HOtUoA+aSGl1q7mHFXC6c+jrrUPvrBwarnKzuxSYC0iAp6HEW0dC
lAH/1hS0jtoBF4B4+rGcghMb4wEB4Ce8ltHrhZaWDnR4YG3tCYmDgH5SwcFIDPIH
WjdEt/xDxO0wR5cnkfiCxmJrwQG2v3lzDaokmZjeJYIu+NzAhIO+BYBZwZ0x2qgz
Q6gRHDbfswDYtWWWv1gtaG3YNYFsF+zf5hJKpXj7WetgtXKQxoe2b8tnxBFXwB4m
2cOY0qCGt48CBA4GBhwzlPpcwPkpCpv8ImzDg6icHBQYP10U65kPBZ0gF9mBFYLW
CSILPYPJ12JfOVIiKc6OtoOigoInhX2RMChNfvaF3d+dG4eL5wUBM5pz6suYoxNP
KKCHmCQ0LIHiyGki7ij1vJDAnOBIh+vCDEfWxyDPTQKlYgDED0IMrau20oLZ1G36
jHeHyxbYREPkW9+ev0brfzpn67pPH/hVFIJc1NwNObe5UzWwweei/6Kxng8A4wH1
YFRmFDyAGeNXqAGw8DBn9W+GvG13L7aR4tqlZXqrsJH0ZaJplQvpUfKPtCByvuY4
N38CaT+9NmD5dfqDwtNZ
=HQB7
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--

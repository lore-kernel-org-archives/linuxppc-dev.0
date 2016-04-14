Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlkCN5Kj8zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 11:50:40 +1000 (AEST)
Date: Thu, 14 Apr 2016 11:35:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel 1/2] powerpc/iommu: Get rid of default
 group_release()
Message-ID: <20160414013555.GC18218@voom.redhat.com>
References: <1460097404-35422-1-git-send-email-aik@ozlabs.ru>
 <1460097404-35422-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
In-Reply-To: <1460097404-35422-2-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2016 at 04:36:43PM +1000, Alexey Kardashevskiy wrote:
> IBM PPC IOMMU API users always set IOMMU data and IOMMU release callback
> to an IOMMU group. At the moment the callback clears one pointer in
> iommu_table_group and that's it.
>=20
> The platform code calls iommu_group_put() and counts on _put() being
> called last so they check for table_group->group being reset which
> is conceptually wrong as there may be another user holding a reference.
>=20
> This removes the default IOMMU group release() callback and adds it
> as a parameter to iommu_register_group(). As we are changing the prototype
> anyway, this also changes the function name to more distinctive
> iommu_register_table_group().
>=20
> This should cause no behavioral change as it leaves BUG_ON for IODA2
> (where it was reported) and removes BUG_ON for pseries/IODA1 as they
> do not support IOV anyway and this BUG_ON has never been reported for
> these platforms.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/iommu.h          | 12 +++++++-----
>  arch/powerpc/kernel/iommu.c               | 14 ++++----------
>  arch/powerpc/platforms/powernv/pci-ioda.c | 15 +++++++++++----
>  arch/powerpc/platforms/pseries/iommu.c    | 17 +++++++++--------
>  4 files changed, 31 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 7b87bab..d7ba3b4 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -201,17 +201,19 @@ struct iommu_table_group {
> =20
>  #ifdef CONFIG_IOMMU_API
> =20
> -extern void iommu_register_group(struct iommu_table_group *table_group,
> -				 int pci_domain_number, unsigned long pe_num);
> +extern void iommu_register_table_group(struct iommu_table_group *table_g=
roup,
> +		int pci_domain_number, unsigned long pe_num,
> +		void (*release)(void *iommu_data));
>  extern int iommu_add_device(struct device *dev);
>  extern void iommu_del_device(struct device *dev);
>  extern int __init tce_iommu_bus_notifier_init(void);
>  extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
>  		unsigned long *hpa, enum dma_data_direction *direction);
>  #else
> -static inline void iommu_register_group(struct iommu_table_group *table_=
group,
> -					int pci_domain_number,
> -					unsigned long pe_num)
> +static inline void iommu_register_table_group(
> +		struct iommu_table_group *table_group,
> +		int pci_domain_number, unsigned long pe_num,
> +		void (*release)(void *iommu_data))
>  {
>  }
> =20
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index a8e3490..8eed2fa 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -887,15 +887,9 @@ EXPORT_SYMBOL_GPL(iommu_direction_to_tce_perm);
>  /*
>   * SPAPR TCE API
>   */
> -static void group_release(void *iommu_data)
> -{
> -	struct iommu_table_group *table_group =3D iommu_data;
> -
> -	table_group->group =3D NULL;
> -}
> -
> -void iommu_register_group(struct iommu_table_group *table_group,
> -		int pci_domain_number, unsigned long pe_num)
> +void iommu_register_table_group(struct iommu_table_group *table_group,
> +		int pci_domain_number, unsigned long pe_num,
> +		void (*release)(void *iommu_data))
>  {
>  	struct iommu_group *grp;
>  	char *name;
> @@ -907,7 +901,7 @@ void iommu_register_group(struct iommu_table_group *t=
able_group,
>  		return;
>  	}
>  	table_group->group =3D grp;
> -	iommu_group_set_iommudata(grp, table_group, group_release);
> +	iommu_group_set_iommudata(grp, table_group, release);
>  	name =3D kasprintf(GFP_KERNEL, "domain%d-pe%lx",
>  			pci_domain_number, pe_num);
>  	if (!name)
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index c5baaf3..ce9f2bf 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1330,6 +1330,13 @@ static long pnv_pci_ioda2_unset_window(struct iomm=
u_table_group *table_group,
>  		int num);
>  static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable=
);
> =20
> +static void pnv_pci_ioda2_group_release(void *iommu_data)
> +{
> +	struct iommu_table_group *table_group =3D iommu_data;
> +
> +	table_group->group =3D NULL;
> +}
> +
>  static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv=
_ioda_pe *pe)
>  {
>  	struct iommu_table    *tbl;
> @@ -1965,8 +1972,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_ph=
b *phb,
>  		return;
> =20
>  	tbl =3D pnv_pci_table_alloc(phb->hose->node);
> -	iommu_register_group(&pe->table_group, phb->hose->global_number,
> -			pe->pe_number);
> +	iommu_register_table_group(&pe->table_group, phb->hose->global_number,
> +			pe->pe_number, NULL);
>  	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
> =20
>  	/* Grab a 32-bit TCE table */
> @@ -2450,8 +2457,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  	/* TVE #1 is selected by PCI address bit 59 */
>  	pe->tce_bypass_base =3D 1ull << 59;
> =20
> -	iommu_register_group(&pe->table_group, phb->hose->global_number,
> -			pe->pe_number);
> +	iommu_register_table_group(&pe->table_group, phb->hose->global_number,
> +			pe->pe_number, pnv_pci_ioda2_group_release);
> =20
>  	/* The PE will reserve all possible 32-bits space */
>  	pe->tce32_seg =3D 0;
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platfo=
rms/pseries/iommu.c
> index bd98ce2..0f6f06c 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -112,7 +112,7 @@ static void iommu_pseries_free_group(struct iommu_tab=
le_group *table_group,
>  	}
>  	if (table_group->group) {
>  		iommu_group_put(table_group->group);
> -		BUG_ON(table_group->group);
> +		table_group->group =3D NULL;
>  	}
>  #endif
>  	iommu_free_table(tbl, node_name);
> @@ -692,7 +692,8 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus =
*bus)
>  	iommu_table_setparms(pci->phb, dn, tbl);
>  	tbl->it_ops =3D &iommu_table_pseries_ops;
>  	iommu_init_table(tbl, pci->phb->node);
> -	iommu_register_group(pci->table_group, pci_domain_nr(bus), 0);
> +	iommu_register_table_group(pci->table_group, pci_domain_nr(bus), 0,
> +			NULL);
> =20
>  	/* Divide the rest (1.75GB) among the children */
>  	pci->phb->dma_window_size =3D 0x80000000ul;
> @@ -743,8 +744,8 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bu=
s *bus)
>  		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
>  		tbl->it_ops =3D &iommu_table_lpar_multi_ops;
>  		iommu_init_table(tbl, ppci->phb->node);
> -		iommu_register_group(ppci->table_group,
> -				pci_domain_nr(bus), 0);
> +		iommu_register_table_group(ppci->table_group,
> +				pci_domain_nr(bus), 0, NULL);
>  		pr_debug("  created table: %p\n", ppci->table_group);
>  	}
>  }
> @@ -772,8 +773,8 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev =
*dev)
>  		iommu_table_setparms(phb, dn, tbl);
>  		tbl->it_ops =3D &iommu_table_pseries_ops;
>  		iommu_init_table(tbl, phb->node);
> -		iommu_register_group(PCI_DN(dn)->table_group,
> -				pci_domain_nr(phb->bus), 0);
> +		iommu_register_table_group(PCI_DN(dn)->table_group,
> +				pci_domain_nr(phb->bus), 0, NULL);
>  		set_iommu_table_base(&dev->dev, tbl);
>  		iommu_add_device(&dev->dev);
>  		return;
> @@ -1197,8 +1198,8 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_=
dev *dev)
>  		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
>  		tbl->it_ops =3D &iommu_table_lpar_multi_ops;
>  		iommu_init_table(tbl, pci->phb->node);
> -		iommu_register_group(pci->table_group,
> -				pci_domain_nr(pci->phb->bus), 0);
> +		iommu_register_table_group(pci->table_group,
> +				pci_domain_nr(pci->phb->bus), 0, NULL);
>  		pr_debug("  created table: %p\n", pci->table_group);
>  	} else {
>  		pr_debug("  found DMA window, table: %p\n", pci->table_group);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDvP7AAoJEGw4ysog2bOSixwQAMAZlK0acjnuEVM24qRnY3Xh
ygG1M4WhB0H8bEHhLakZhOTLB10Sh3KHhB4vKNeeZEyJg1Uzl31xG/p+jmcHF5ZJ
xEVevxeZth8x8gZHK1RPr8rL3oMdYmXoMc9B6LZi9cOXHVB/A28+PxJqFQWhBS2q
ZNDxvUk3SX1zL1+01BCNmkNtQob8DxNPe1C+Yw2RFmTPQ5xazEOA0T3lVvcMb8Dn
7I+xqP7v0Syy8lAluYQC3FiQHCME9VsjJwThd/bdV8EiSMSInpVrLb/fOAZesvuX
g2cdYcWt7Ux94/d4gm5AF4MKbkwVk5vHqldjl/T2OztejW4s7CBcJTWRuMfWeGWv
AHycXohtiYZquLKeg6QTmtTsDV3t8Qah7jepx9Yg3qjjELvK2UCorWRIt9g84Q/X
drMwzZVd1JN4kCv6erCc0kdbOa1OyIp2zgvxwnvBNY6zjjq91FH0CJgkTSZi999v
k0gnzRNe8FSvXEUGrcnnMOi+bHaQPd6y+JFsDWrNJONrXSE+hPxyRLPUxmLXkNU6
qrluLm9HRLDwBM/9n0dqaiMaHt7h6zVObHkS4yx8N4usr5SSPHQpfVBBYYuL5yq/
Y2IJlM2Y+qLKoTqHJ0Dsb6M+6t/Y+9vgA1CzjIvC4M/uz1AFSWZ7rGP1+JL1jTyW
0oWqZtyiIeI8+KkLWD4B
=J3MC
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--

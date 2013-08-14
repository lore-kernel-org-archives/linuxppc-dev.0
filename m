Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D42642C01B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 19:59:51 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] KVM: PPC: POWERNV: move iommu_add_device earlier
Date: Wed, 14 Aug 2013 09:59:42 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D071108BF@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1376472281-12663-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1376472281-12663-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Ale=
xey
> Kardashevskiy
> Sent: Wednesday, August 14, 2013 2:55 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Alexey Kardashevskiy; Paul Mackerras; linux-kernel@vger.kernel.org
> Subject: [PATCH] KVM: PPC: POWERNV: move iommu_add_device earlier
>=20
> The current implementation of IOMMU on sPAPR does not use iommu_ops
> and therefore does not call IOMMU API's bus_set_iommu() which
> 1) sets iommu_ops for a bus
> 2) registers a bus notifier
> Instead, PCI devices are added to IOMMU groups from
> subsys_initcall_sync(tce_iommu_init) which does basically the same
> thing without using iommu_ops callbacks.
>=20
> However Freescale PAMU driver (https://lkml.org/lkml/2013/7/1/158)
> implements iommu_ops and when tce_iommu_init is called, every PCI device
> is already added to some group so there is a conflict.
>=20
> This patch does 2 things:
> 1. removes the loop in which PCI devices were added to groups and
> adds explicit iommu_add_device() calls to add devices as soon as they get
> the iommu_table pointer assigned to them.
> 2. moves a bus notifier to powernv code in order to avoid conflict with
> the notifier from Freescale driver.
>=20
> iommu_add_device() and iommu_del_device() are public now.

This works for me (able to boot Linux, as expected) :-)
But a question, why not move arch/powerpc/kernel/iommu.c in platform/ ? or =
use this for book3s or not_book3e only?

Thanks
-Bharat

>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/iommu.h            |  2 ++
>  arch/powerpc/kernel/iommu.c                 | 41 +++--------------------=
------
>  arch/powerpc/platforms/powernv/pci-ioda.c   | 12 ++++++---
>  arch/powerpc/platforms/powernv/pci-p5ioc2.c |  1 +
>  arch/powerpc/platforms/powernv/pci.c        | 31 ++++++++++++++++++++++
>  arch/powerpc/platforms/pseries/iommu.c      |  7 +++--
>  6 files changed, 51 insertions(+), 43 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index c34656a..ba74329 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -103,6 +103,8 @@ extern struct iommu_table *iommu_init_table(struct
> iommu_table * tbl,
>  					    int nid);
>  extern void iommu_register_group(struct iommu_table *tbl,
>  				 int pci_domain_number, unsigned long pe_num);
> +extern int iommu_add_device(struct device *dev);
> +extern void iommu_del_device(struct device *dev);
>=20
>  extern int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
>  			struct scatterlist *sglist, int nelems,
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index b20ff17..15f8ca8 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1105,7 +1105,7 @@ void iommu_release_ownership(struct iommu_table *tb=
l)
>  }
>  EXPORT_SYMBOL_GPL(iommu_release_ownership);
>=20
> -static int iommu_add_device(struct device *dev)
> +int iommu_add_device(struct device *dev)
>  {
>  	struct iommu_table *tbl;
>  	int ret =3D 0;
> @@ -1134,46 +1134,13 @@ static int iommu_add_device(struct device *dev)
>=20
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(iommu_add_device);
>=20
> -static void iommu_del_device(struct device *dev)
> +void iommu_del_device(struct device *dev)
>  {
>  	iommu_group_remove_device(dev);
>  }
> -
> -static int iommu_bus_notifier(struct notifier_block *nb,
> -			      unsigned long action, void *data)
> -{
> -	struct device *dev =3D data;
> -
> -	switch (action) {
> -	case BUS_NOTIFY_ADD_DEVICE:
> -		return iommu_add_device(dev);
> -	case BUS_NOTIFY_DEL_DEVICE:
> -		iommu_del_device(dev);
> -		return 0;
> -	default:
> -		return 0;
> -	}
> -}
> -
> -static struct notifier_block tce_iommu_bus_nb =3D {
> -	.notifier_call =3D iommu_bus_notifier,
> -};
> -
> -static int __init tce_iommu_init(void)
> -{
> -	struct pci_dev *pdev =3D NULL;
> -
> -	BUILD_BUG_ON(PAGE_SIZE < IOMMU_PAGE_SIZE);
> -
> -	for_each_pci_dev(pdev)
> -		iommu_add_device(&pdev->dev);
> -
> -	bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
> -	return 0;
> -}
> -
> -subsys_initcall_sync(tce_iommu_init);
> +EXPORT_SYMBOL_GPL(iommu_del_device);
>=20
>  #else
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> b/arch/powerpc/platforms/powernv/pci-ioda.c
> index d8140b1..a9f8fef 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -441,6 +441,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb=
 *phb,
> struct pci_dev *pdev
>=20
>  	pe =3D &phb->ioda.pe_array[pdn->pe_number];
>  	set_iommu_table_base(&pdev->dev, &pe->tce32_table);
> +	iommu_add_device(&pdev->dev);
>  }
>=20
>  static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bu=
s *bus)
> @@ -449,6 +450,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe=
 *pe,
> struct pci_bus *bus)
>=20
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		set_iommu_table_base(&dev->dev, &pe->tce32_table);
> +		iommu_add_device(&dev->dev);
>  		if (dev->subordinate)
>  			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
>  	}
> @@ -610,9 +612,10 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb=
 *phb,
>  	iommu_init_table(tbl, phb->hose->node);
>  	iommu_register_group(tbl, pci_domain_nr(pe->pbus), pe->pe_number);
>=20
> -	if (pe->pdev)
> +	if (pe->pdev) {
>  		set_iommu_table_base(&pe->pdev->dev, tbl);
> -	else
> +		iommu_add_device(&pe->pdev->dev);
> +	} else
>  		pnv_ioda_setup_bus_dma(pe, pe->pbus);
>=20
>  	return;
> @@ -686,9 +689,10 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_ph=
b *phb,
>  	}
>  	iommu_init_table(tbl, phb->hose->node);
>=20
> -	if (pe->pdev)
> +	if (pe->pdev) {
>  		set_iommu_table_base(&pe->pdev->dev, tbl);
> -	else
> +		iommu_add_device(&pe->pdev->dev);
> +	} else
>  		pnv_ioda_setup_bus_dma(pe, pe->pbus);
>=20
>  	return;
> diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> index b68db63..8d1b501 100644
> --- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> +++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> @@ -93,6 +93,7 @@ static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb=
 *phb,
>  	}
>=20
>  	set_iommu_table_base(&pdev->dev, &phb->p5ioc2.iommu_table);
> +	iommu_add_device(&pdev->dev);
>  }
>=20
>  static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 h=
ub_id,
> diff --git a/arch/powerpc/platforms/powernv/pci.c
> b/arch/powerpc/platforms/powernv/pci.c
> index a28d3b5..55447e6 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -505,6 +505,7 @@ static void pnv_pci_dma_fallback_setup(struct pci_con=
troller
> *hose,
>  	if (!pdn->iommu_table)
>  		return;
>  	set_iommu_table_base(&pdev->dev, pdn->iommu_table);
> +	iommu_add_device(&pdev->dev);
>  }
>=20
>  static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
> @@ -623,3 +624,33 @@ void __init pnv_pci_init(void)
>  	ppc_md.teardown_msi_irqs =3D pnv_teardown_msi_irqs;
>  #endif
>  }
> +
> +static int tce_iommu_bus_notifier(struct notifier_block *nb,
> +		unsigned long action, void *data)
> +{
> +	struct device *dev =3D data;
> +
> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		return iommu_add_device(dev);
> +	case BUS_NOTIFY_DEL_DEVICE:
> +		iommu_del_device(dev);
> +		return 0;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static struct notifier_block tce_iommu_bus_nb =3D {
> +	.notifier_call =3D tce_iommu_bus_notifier,
> +};
> +
> +static int __init tce_iommu_bus_notifier_init(void)
> +{
> +	BUILD_BUG_ON(PAGE_SIZE < IOMMU_PAGE_SIZE);
> +
> +	bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
> +	return 0;
> +}
> +
> +subsys_initcall_sync(tce_iommu_bus_notifier_init);
> diff --git a/arch/powerpc/platforms/pseries/iommu.c
> b/arch/powerpc/platforms/pseries/iommu.c
> index 23fc1dc..9c6dc29 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -688,6 +688,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev =
*dev)
>  		PCI_DN(dn)->iommu_table =3D iommu_init_table(tbl, phb->node);
>  		iommu_register_group(tbl, pci_domain_nr(phb->bus), 0);
>  		set_iommu_table_base(&dev->dev, PCI_DN(dn)->iommu_table);
> +		iommu_add_device(&dev->dev);
>  		return;
>  	}
>=20
> @@ -698,9 +699,10 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev=
 *dev)
>  	while (dn && PCI_DN(dn) && PCI_DN(dn)->iommu_table =3D=3D NULL)
>  		dn =3D dn->parent;
>=20
> -	if (dn && PCI_DN(dn))
> +	if (dn && PCI_DN(dn)) {
>  		set_iommu_table_base(&dev->dev, PCI_DN(dn)->iommu_table);
> -	else
> +		iommu_add_device(&dev->dev);
> +	} else
>  		printk(KERN_WARNING "iommu: Device %s has no iommu table\n",
>  		       pci_name(dev));
>  }
> @@ -1194,6 +1196,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_=
dev
> *dev)
>  	}
>=20
>  	set_iommu_table_base(&dev->dev, pci->iommu_table);
> +	iommu_add_device(&dev->dev);
>  }
>=20
>  static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
> --
> 1.8.3.2
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

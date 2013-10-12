Return-Path: <B16395@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E7BE2C034F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2013 18:20:19 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: "joro@8bytes.org" <joro@8bytes.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Yoder Stuart-B08248 <B08248@freescale.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: RE: [PATCH 1/2] iommu/fsl: Factor out PCI specific code.
Date: Sat, 12 Oct 2013 07:20:12 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A53259E@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381343194-24059-1-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1381343194-24059-1-git-send-email-Varun.Sethi@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joerg,
Please consider these patches for 3.12.

Regards
Varun

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Wednesday, October 09, 2013 11:57 PM
> To: joro@8bytes.org; iommu@lists.linux-foundation.org; linuxppc-
> dev@lists.ozabs.org; linux-kernel@vger.kernel.org; Yoder Stuart-B08248;
> alex.williamson@redhat.com
> Cc: Sethi Varun-B16395
> Subject: [PATCH 1/2] iommu/fsl: Factor out PCI specific code.
>=20
> Factor out PCI specific code in the PAMU driver.
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
>  drivers/iommu/fsl_pamu_domain.c |   81 +++++++++++++++++++--------------
> ------
>  1 file changed, 40 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/iommu/fsl_pamu_domain.c
> b/drivers/iommu/fsl_pamu_domain.c index c857c30..e02e1de 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -677,13 +677,9 @@ static int handle_attach_device(struct
> fsl_dma_domain *dma_domain,
>  	return ret;
>  }
>=20
> -static int fsl_pamu_attach_device(struct iommu_domain *domain,
> -				  struct device *dev)
> +static void check_for_pci_dma_device(struct device **dev)
>  {
> -	struct fsl_dma_domain *dma_domain =3D domain->priv;
> -	const u32 *liodn;
> -	u32 liodn_cnt;
> -	int len, ret =3D 0;
> +#ifdef CONFIG_PCI
>  	struct pci_dev *pdev =3D NULL;
>  	struct pci_controller *pci_ctl;
>=20
> @@ -691,25 +687,38 @@ static int fsl_pamu_attach_device(struct
> iommu_domain *domain,
>  	 * Use LIODN of the PCI controller while attaching a
>  	 * PCI device.
>  	 */
> -	if (dev->bus =3D=3D &pci_bus_type) {
> -		pdev =3D to_pci_dev(dev);
> +	if ((*dev)->bus =3D=3D &pci_bus_type) {
> +		pdev =3D to_pci_dev(*dev);
>  		pci_ctl =3D pci_bus_to_host(pdev->bus);
>  		/*
>  		 * make dev point to pci controller device
>  		 * so we can get the LIODN programmed by
>  		 * u-boot.
>  		 */
> -		dev =3D pci_ctl->parent;
> +		*dev =3D pci_ctl->parent;
>  	}
> +#endif
> +}
>=20
> -	liodn =3D of_get_property(dev->of_node, "fsl,liodn", &len);
> +static int fsl_pamu_attach_device(struct iommu_domain *domain,
> +				  struct device *dev)
> +{
> +	struct fsl_dma_domain *dma_domain =3D domain->priv;
> +	struct device *dma_dev =3D dev;
> +	const u32 *liodn;
> +	u32 liodn_cnt;
> +	int len, ret =3D 0;
> +
> +	check_for_pci_dma_device(&dma_dev);
> +
> +	liodn =3D of_get_property(dma_dev->of_node, "fsl,liodn", &len);
>  	if (liodn) {
>  		liodn_cnt =3D len / sizeof(u32);
>  		ret =3D handle_attach_device(dma_domain, dev,
>  					 liodn, liodn_cnt);
>  	} else {
>  		pr_debug("missing fsl,liodn property at %s\n",
> -		          dev->of_node->full_name);
> +		          dma_dev->of_node->full_name);
>  			ret =3D -EINVAL;
>  	}
>=20
> @@ -720,32 +729,18 @@ static void fsl_pamu_detach_device(struct
> iommu_domain *domain,
>  				      struct device *dev)
>  {
>  	struct fsl_dma_domain *dma_domain =3D domain->priv;
> +	struct device *dma_dev =3D dev;
>  	const u32 *prop;
>  	int len;
> -	struct pci_dev *pdev =3D NULL;
> -	struct pci_controller *pci_ctl;
>=20
> -	/*
> -	 * Use LIODN of the PCI controller while detaching a
> -	 * PCI device.
> -	 */
> -	if (dev->bus =3D=3D &pci_bus_type) {
> -		pdev =3D to_pci_dev(dev);
> -		pci_ctl =3D pci_bus_to_host(pdev->bus);
> -		/*
> -		 * make dev point to pci controller device
> -		 * so we can get the LIODN programmed by
> -		 * u-boot.
> -		 */
> -		dev =3D pci_ctl->parent;
> -	}
> +	check_for_pci_dma_device(&dma_dev);
>=20
> -	prop =3D of_get_property(dev->of_node, "fsl,liodn", &len);
> +	prop =3D of_get_property(dma_dev->of_node, "fsl,liodn", &len);
>  	if (prop)
>  		detach_device(dev, dma_domain);
>  	else
>  		pr_debug("missing fsl,liodn property at %s\n",
> -		          dev->of_node->full_name);
> +		          dma_dev->of_node->full_name);
>  }
>=20
>  static  int configure_domain_geometry(struct iommu_domain *domain, void
> *data) @@ -905,6 +900,7 @@ static struct iommu_group
> *get_device_iommu_group(struct device *dev)
>  	return group;
>  }
>=20
> +#ifdef CONFIG_PCI
>  static  bool check_pci_ctl_endpt_part(struct pci_controller *pci_ctl)  {
>  	u32 version;
> @@ -945,13 +941,18 @@ static struct iommu_group
> *get_shared_pci_device_group(struct pci_dev *pdev)
>  	return NULL;
>  }
>=20
> -static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
> +static struct iommu_group *get_pci_device_group(struct device *dev)
>  {
>  	struct pci_controller *pci_ctl;
>  	bool pci_endpt_partioning;
>  	struct iommu_group *group =3D NULL;
> -	struct pci_dev *bridge, *dma_pdev =3D NULL;
> +	struct pci_dev *bridge, *pdev;
> +	struct pci_dev *dma_pdev =3D NULL;
>=20
> +	pdev =3D to_pci_dev(dev);
> +	/* Don't create device groups for virtual PCI bridges */
> +	if (pdev->subordinate)
> +		return NULL;
>  	pci_ctl =3D pci_bus_to_host(pdev->bus);
>  	pci_endpt_partioning =3D check_pci_ctl_endpt_part(pci_ctl);
>  	/* We can partition PCIe devices so assign device group to the
> device */ @@ -1044,11 +1045,11 @@ root_bus:
>=20
>  	return group;
>  }
> +#endif
>=20
>  static int fsl_pamu_add_device(struct device *dev)  {
>  	struct iommu_group *group =3D NULL;
> -	struct pci_dev *pdev;
>  	const u32 *prop;
>  	int ret, len;
>=20
> @@ -1056,19 +1057,15 @@ static int fsl_pamu_add_device(struct device
> *dev)
>  	 * For platform devices we allocate a separate group for
>  	 * each of the devices.
>  	 */
> -	if (dev->bus =3D=3D &pci_bus_type) {
> -		pdev =3D to_pci_dev(dev);
> -		/* Don't create device groups for virtual PCI bridges */
> -		if (pdev->subordinate)
> -			return 0;
> -
> -		group =3D get_pci_device_group(pdev);
> -
> -	} else {
> +	if (dev->bus =3D=3D &platform_bus_type) {
>  		prop =3D of_get_property(dev->of_node, "fsl,liodn", &len);
>  		if (prop)
>  			group =3D get_device_iommu_group(dev);
>  	}
> +#ifdef CONFIG_PCI
> +	else
> +		group =3D get_pci_device_group(dev);
> +#endif
>=20
>  	if (!group || IS_ERR(group))
>  		return PTR_ERR(group);
> @@ -1166,7 +1163,9 @@ int pamu_domain_init()
>  		return ret;
>=20
>  	bus_set_iommu(&platform_bus_type, &fsl_pamu_ops);
> +#ifdef CONFIG_PCI
>  	bus_set_iommu(&pci_bus_type, &fsl_pamu_ops);
> +#endif
>=20
>  	return ret;
>  }
> --
> 1.7.9.5

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 945EEB6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 05:58:54 +1100 (EST)
Subject: Re: [PATCH SDK1.2 1/3] powerpc/fsl-pci: Unify pci/pcie initialization
 code
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D019ADE0E@039-SN1MPN1-002.039d.mgd.msft.net>
Date: Fri, 16 Mar 2012 13:58:46 -0500
Message-Id: <8B27C609-DE50-4B02-B829-E2162CB47E23@kernel.crashing.org>
References: <1324451458-4644-1-git-send-email-B38951@freescale.com>
 <1324451458-4644-2-git-send-email-B38951@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D010060C9@039-SN1MPN1-005.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5D019ADE0E@039-SN1MPN1-002.039d.mgd.msft.net>
To: Jia Hongtao-B38951 <B38951@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 9, 2012, at 8:27 PM, Jia Hongtao-B38951 wrote:

> Hi Kumar,
> This series of patches have been pending for a long time.
> I'd like to know whether they are look good or not so I can do the =
further work on it.
> It's kind of emergency things for me.
> Thanks a lot for your attention.

I commented some time ago that the patches looked fine, but needed to be =
done for ALL the boards (include 86xx).

- k

>=20
> -----Original Message-----
> From: Jia Hongtao-B38951=20
> Sent: Tuesday, January 10, 2012 3:31 PM
> To: Gala Kumar-B11780
> Cc: Li Yang-R58472; Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org
> Subject: RE: [PATCH SDK1.2 1/3] powerpc/fsl-pci: Unify pci/pcie =
initialization code
>=20
> Hi Kumar,
> Do you have any idea on this series of patches?
> Looking forward to your answer.
> Thanks.
>=20
> --Jia Hongtao.
>=20
> -----Original Message-----
> From: Jia Hongtao-B38951
> Sent: Wednesday, December 21, 2011 3:11 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Li Yang-R58472; Gala Kumar-B11780; Jia Hongtao-B38951
> Subject: [PATCH SDK1.2 1/3] powerpc/fsl-pci: Unify pci/pcie =
initialization code
>=20
> We unified the Freescale pci/pcie initialization by changing the =
fsl_pci to a platform driver.
>=20
> In previous version pci/pcie initialization is in platform code which =
Initialize pci bridge base on EP/RC or host/agent settings.
>=20
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/platforms/85xx/p1022_ds.c |   39 +++++++----------------
> arch/powerpc/sysdev/fsl_pci.c          |   53 =
++++++++++++++++++++++++++++++++
> 2 files changed, 65 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c =
b/arch/powerpc/platforms/85xx/p1022_ds.c
> index 2bf4342..41de2c1 100644
> --- a/arch/powerpc/platforms/85xx/p1022_ds.c
> +++ b/arch/powerpc/platforms/85xx/p1022_ds.c
> @@ -277,32 +277,9 @@ void __init mpc85xx_smp_init(void);
>  */
> static void __init p1022_ds_setup_arch(void)  { -#ifdef CONFIG_PCI
> -	struct device_node *np;
> -#endif
> -	dma_addr_t max =3D 0xffffffff;
> -
> 	if (ppc_md.progress)
> 		ppc_md.progress("p1022_ds_setup_arch()", 0);
>=20
> -#ifdef CONFIG_PCI
> -	for_each_compatible_node(np, "pci", "fsl,p1022-pcie") {
> -		struct resource rsrc;
> -		struct pci_controller *hose;
> -
> -		of_address_to_resource(np, 0, &rsrc);
> -
> -		if ((rsrc.start & 0xfffff) =3D=3D 0x8000)
> -			fsl_add_bridge(np, 1);
> -		else
> -			fsl_add_bridge(np, 0);
> -
> -		hose =3D pci_find_hose_for_OF_device(np);
> -		max =3D min(max, hose->dma_window_base_cur +
> -			  hose->dma_window_size);
> -	}
> -#endif
> -
> #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
> 	diu_ops.get_pixel_format	=3D p1022ds_get_pixel_format;
> 	diu_ops.set_gamma_table		=3D p1022ds_set_gamma_table;
> @@ -316,11 +293,8 @@ static void __init p1022_ds_setup_arch(void)  =
#endif
>=20
> #ifdef CONFIG_SWIOTLB
> -	if (memblock_end_of_DRAM() > max) {
> +	if (memblock_end_of_DRAM() > 0xffffffff)
> 		ppc_swiotlb_enable =3D 1;
> -		set_pci_dma_ops(&swiotlb_dma_ops);
> -		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
> -	}
> #endif
>=20
> 	pr_info("Freescale P1022 DS reference board\n"); @@ -339,6 =
+313,17 @@ static int __init p1022_ds_publish_devices(void)  }  =
machine_device_initcall(p1022_ds, p1022_ds_publish_devices);
>=20
> +static struct of_device_id __initdata p1022_pci_ids[] =3D {
> +	{ .compatible =3D "fsl,p1022-pcie", },
> +	{},
> +};
> +
> +static int __init p1022_ds_publish_pci_device(void) {
> +	return of_platform_bus_probe(NULL, p1022_pci_ids, NULL); }=20
> +machine_arch_initcall(p1022_ds, p1022_ds_publish_pci_device);
> +
> machine_arch_initcall(p1022_ds, swiotlb_setup_bus_notifier);
>=20
> /*
> diff --git a/arch/powerpc/sysdev/fsl_pci.c =
b/arch/powerpc/sysdev/fsl_pci.c index 4ce547e..a0f305d 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -712,3 +712,56 @@ u64 fsl_pci_immrbar_base(struct pci_controller =
*hose)
>=20
> 	return 0;
> }
> +
> +static const struct of_device_id pci_ids[] =3D {
> +	{ .compatible =3D "fsl,mpc8540-pci", },
> +	{ .compatible =3D "fsl,mpc8548-pcie", },
> +	{ .compatible =3D "fsl,p1022-pcie", },
> +	{},
> +};
> +
> +static int __devinit fsl_pci_probe(struct platform_device *pdev) {
> +	struct pci_controller *hose;
> +
> +	if (of_match_node(pci_ids, pdev->dev.of_node)) {
> +		struct resource rsrc;
> +		of_address_to_resource(pdev->dev.of_node, 0, &rsrc);
> +		if ((rsrc.start & 0xfffff) =3D=3D 8000)
> +			fsl_add_bridge(pdev->dev.of_node, 1);
> +		else
> +			fsl_add_bridge(pdev->dev.of_node, 0);
> +
> +#ifdef CONFIG_SWIOTLB
> +		hose =3D pci_find_hose_for_OF_device(pdev->dev.of_node);
> +		/*
> +		 * if we couldn't map all of DRAM via the dma windows
> +		 * we need SWIOTLB to handle buffers located outside of
> +		 * dma capable memory region
> +		 */
> +		if (memblock_end_of_DRAM() > hose->dma_window_base_cur
> +				+ hose->dma_window_size) {
> +			ppc_swiotlb_enable =3D 1;
> +			set_pci_dma_ops(&swiotlb_dma_ops);
> +			ppc_md.pci_dma_dev_setup =3D =
pci_dma_dev_setup_swiotlb;
> +		}
> +#endif
> +
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver fsl_pci_driver =3D {
> +	.driver =3D {
> +		.name =3D "fsl-pci",
> +		.of_match_table =3D pci_ids,
> +	},
> +	.probe =3D fsl_pci_probe,
> +};
> +
> +static int __init fsl_pci_init(void)
> +{
> +	return platform_driver_register(&fsl_pci_driver);
> +}
> +arch_initcall(fsl_pci_init);
> --
> 1.7.5.1
>=20

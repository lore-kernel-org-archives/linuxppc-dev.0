Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B97B21007DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 15:50:51 +1100 (EST)
Subject: Re: [PATCH 1/2] Unify pci/pcie initialization code
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5DFD4DB8@039-SN1MPN1-005.039d.mgd.msft.net>
Date: Wed, 23 Nov 2011 22:50:41 -0600
Message-Id: <3E825AD9-1CD5-4D6D-8161-E6B4F1D32457@kernel.crashing.org>
References: <1320040492-6407-1-git-send-email-B38951@freescale.com>
 <1320040492-6407-2-git-send-email-B38951@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5DFD4DB8@039-SN1MPN1-005.039d.mgd.msft.net>
To: Jia Hongtao-B38951 <B38951@freescale.com>
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 22, 2011, at 12:20 AM, Jia Hongtao-B38951 wrote:

> Hi Kumar,
> We want more comments on this series of patches ([1/2] & [2/2]) to =
speed up the pushing-to-kernel progress.
> Thanks.

I think the code is fine, but you need to update it for all the boards =
include the 86xx ones.

- k

>=20
> -----Original Message-----
> From: Jia Hongtao-B38951=20
> Sent: Monday, October 31, 2011 1:55 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Li Yang-R58472; Gala Kumar-B11780; Jia Hongtao-B38951
> Subject: [PATCH 1/2] Unify pci/pcie initialization code
>=20
> In previous version pci/pcie initialization is in platform code which =
Initialize PCI bridge base on EP/RC or host/agent settings.
> We unified pci/pcie initialization as common APIs named fsl_pci_setup =
which can be called by platform code.
>=20
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_ds.c |   30 ++-----------------
> arch/powerpc/sysdev/fsl_pci.c            |   48 =
++++++++++++++++++++++++++++++
> arch/powerpc/sysdev/fsl_pci.h            |    5 +++
> 3 files changed, 56 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c =
b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> index 10e7db0..7188c0b 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> @@ -157,33 +157,12 @@ extern void __init mpc85xx_smp_init(void);  =
#endif  static void __init mpc85xx_ds_setup_arch(void)  { -#ifdef =
CONFIG_PCI
> -	struct device_node *np;
> -	struct pci_controller *hose;
> -#endif
> -	dma_addr_t max =3D 0xffffffff;
> -
> 	if (ppc_md.progress)
> 		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
>=20
> -#ifdef CONFIG_PCI
> -	for_each_node_by_type(np, "pci") {
> -		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
> -		    of_device_is_compatible(np, "fsl,mpc8548-pcie") ||
> -		    of_device_is_compatible(np, "fsl,p2020-pcie")) {
> -			struct resource rsrc;
> -			of_address_to_resource(np, 0, &rsrc);
> -			if ((rsrc.start & 0xfffff) =3D=3D =
primary_phb_addr)
> -				fsl_add_bridge(np, 1);
> -			else
> -				fsl_add_bridge(np, 0);
> -
> -			hose =3D pci_find_hose_for_OF_device(np);
> -			max =3D min(max, hose->dma_window_base_cur +
> -					hose->dma_window_size);
> -		}
> -	}
> +	fsl_pci_setup(primary_phb_addr);
>=20
> +#ifdef CONFIG_PCI
> 	ppc_md.pci_exclude_device =3D mpc85xx_exclude_device;  #endif
>=20
> @@ -192,11 +171,8 @@ static void __init mpc85xx_ds_setup_arch(void)  =
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
> 	printk("MPC85xx DS board from Freescale Semiconductor\n"); diff =
--git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c =
index 80b8b7a..4d4536f 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -402,6 +402,54 @@ int __init fsl_add_bridge(struct device_node =
*dev, int is_primary)  }  #endif /* CONFIG_FSL_SOC_BOOKE || =
CONFIG_PPC_86xx */
>=20
> +static struct of_device_id pci_ids[] =3D {
> +	{ .compatible =3D "fsl,mpc8540-pci", },
> +	{ .compatible =3D "fsl,mpc8548-pcie", },
> +	{},
> +};
> +
> +/**
> + * fsl_pci_setup - Initialization for PCI
> + * @primary_phb_addr: primary bus address
> + *
> + * Add bridge if pci controller is a host  */ void fsl_pci_setup(int=20=

> +primary_phb_addr) {
> +	struct device_node *np;
> +	struct pci_controller *hose;
> +	dma_addr_t min_dma_addr =3D 0xffffffff;
> +
> +	for_each_node_by_type(np, "pci") {
> +		if (of_match_node(pci_ids, np)) {
> +			struct resource rsrc;
> +			of_address_to_resource(np, 0, &rsrc);
> +			if ((rsrc.start & 0xfffff) =3D=3D =
primary_phb_addr)
> +				fsl_add_bridge(np, 1);
> +			else
> +				fsl_add_bridge(np, 0);
> +
> +			hose =3D pci_find_hose_for_OF_device(np);
> +			min_dma_addr =3D min(min_dma_addr,
> +					hose->dma_window_base_cur
> +					+ hose->dma_window_size);
> +
> +		}
> +	}
> +
> +#ifdef CONFIG_SWIOTLB
> +	/*
> +	 * if we couldn't map all of DRAM via the dma windows we need =
SWIOTLB
> +	 * to handle buffers located outside of dma capable memory =
region
> +	 */
> +	if (memblock_end_of_DRAM() > min_dma_addr) {
> +		ppc_swiotlb_enable =3D 1;
> +		set_pci_dma_ops(&swiotlb_dma_ops);
> +		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
> +	}
> +#endif
> +}
> +
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, =
quirk_fsl_pcie_header);
>=20
> #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x) diff --git =
a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h index =
a39ed5c..775ea21 100644
> --- a/arch/powerpc/sysdev/fsl_pci.h
> +++ b/arch/powerpc/sysdev/fsl_pci.h
> @@ -89,6 +89,11 @@ struct ccsr_pci {
> };
>=20
> extern int fsl_add_bridge(struct device_node *dev, int is_primary);
> +#ifndef CONFIG_PCI
> +#define fsl_pci_setup(p)
> +#else
> +extern void fsl_pci_setup(int primary_phb_addr); #endif
> extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);  extern int =
mpc83xx_add_bridge(struct device_node *dev);
> u64 fsl_pci_immrbar_base(struct pci_controller *hose);
> --
> 1.7.5.1
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

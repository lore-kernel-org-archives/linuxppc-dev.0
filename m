Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C73C6B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 00:00:00 +1000 (EST)
Subject: Re: [PATCH 12/14] 85xx/mpc85xx_ds, ads,
	cds: move .pci_exclude_device setting to machine definitions
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1311065631-3429-13-git-send-email-dbaryshkov@gmail.com>
Date: Tue, 19 Jul 2011 08:59:44 -0500
Message-Id: <C7DEE4D7-9707-4A18-A3D7-BECDEC29A258@kernel.crashing.org>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-13-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 19, 2011, at 3:53 AM, Dmitry Eremin-Solenikov wrote:

> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_ads.c |    5 +++--
> arch/powerpc/platforms/85xx/mpc85xx_cds.c |    5 ++---
> arch/powerpc/platforms/85xx/mpc85xx_ds.c  |    5 +++--
> 3 files changed, 8 insertions(+), 7 deletions(-)

I believe these are done this way for a reason (its been some time).  I =
can't remember if it maters or not, but having pci_exclude_device() =
means that any code in fsl_add_bridge() would not be impacted by the =
exclude function.

Not sure what value making this change has at this point.

- k

>=20
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c =
b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> index 3b2c9bb..2483929 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> @@ -200,8 +200,6 @@ static void __init mpc85xx_ads_setup_arch(void)
> #ifdef CONFIG_PCI
> 	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
> 		fsl_add_bridge(np, 1);
> -
> -	ppc_md.pci_exclude_device =3D mpc85xx_exclude_device;
> #endif
> }
>=20
> @@ -254,6 +252,9 @@ define_machine(mpc85xx_ads) {
> 	.probe			=3D mpc85xx_ads_probe,
> 	.setup_arch		=3D mpc85xx_ads_setup_arch,
> 	.init_IRQ		=3D mpc85xx_ads_pic_init,
> +#ifdef CONFIG_PCI
> +	.pci_exclude_device	=3D mpc85xx_exclude_device,
> +#endif
> 	.show_cpuinfo		=3D mpc85xx_ads_show_cpuinfo,
> 	.get_irq		=3D mpic_get_irq,
> 	.restart		=3D fsl_rstcr_restart,
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c =
b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> index 6299a2a..e209c23 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> @@ -297,9 +297,6 @@ static void __init mpc85xx_cds_setup_arch(void)
> 				fsl_add_bridge(np, 0);
> 		}
> 	}
> -
> -	ppc_md.pci_irq_fixup =3D mpc85xx_cds_pci_irq_fixup;
> -	ppc_md.pci_exclude_device =3D mpc85xx_exclude_device;
> #endif
> }
>=20
> @@ -355,6 +352,8 @@ define_machine(mpc85xx_cds) {
> #ifdef CONFIG_PCI
> 	.restart	=3D mpc85xx_cds_restart,
> 	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
> +	.pci_irq_fixup	=3D mpc85xx_cds_pci_irq_fixup,
> +	.pci_exclude_device	=3D mpc85xx_exclude_device,
> #else
> 	.restart	=3D fsl_rstcr_restart,
> #endif
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c =
b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> index c7b97f7..53bf07d 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> @@ -182,8 +182,6 @@ static void __init mpc85xx_ds_setup_arch(void)
> 					hose->dma_window_size);
> 		}
> 	}
> -
> -	ppc_md.pci_exclude_device =3D mpc85xx_exclude_device;
> #endif
>=20
> #ifdef CONFIG_SMP
> @@ -279,6 +277,7 @@ define_machine(mpc8544_ds) {
> 	.init_IRQ		=3D mpc85xx_ds_pic_init,
> #ifdef CONFIG_PCI
> 	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
> +	.pci_exclude_device	=3D mpc85xx_exclude_device,
> #endif
> 	.get_irq		=3D mpic_get_irq,
> 	.restart		=3D fsl_rstcr_restart,
> @@ -293,6 +292,7 @@ define_machine(mpc8572_ds) {
> 	.init_IRQ		=3D mpc85xx_ds_pic_init,
> #ifdef CONFIG_PCI
> 	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
> +	.pci_exclude_device	=3D mpc85xx_exclude_device,
> #endif
> 	.get_irq		=3D mpic_get_irq,
> 	.restart		=3D fsl_rstcr_restart,
> @@ -307,6 +307,7 @@ define_machine(p2020_ds) {
> 	.init_IRQ		=3D mpc85xx_ds_pic_init,
> #ifdef CONFIG_PCI
> 	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
> +	.pci_exclude_device	=3D mpc85xx_exclude_device,
> #endif
> 	.get_irq		=3D mpic_get_irq,
> 	.restart		=3D fsl_rstcr_restart,
> --=20
> 1.7.2.5

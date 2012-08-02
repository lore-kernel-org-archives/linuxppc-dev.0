Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D95A02C0088
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2012 06:18:52 +1000 (EST)
Message-ID: <501AE0A2.4010809@freescale.com>
Date: Thu, 2 Aug 2012 15:18:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1343907741-20589-1-git-send-email-B38951@freescale.com>
 <1343907741-20589-4-git-send-email-B38951@freescale.com>
In-Reply-To: <1343907741-20589-4-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/02/2012 06:42 AM, Jia Hongtao wrote:
> We unified the Freescale pci/pcie initialization by changing the fsl_pci
> to a platform driver. In previous PCI code architecture the initialization
> routine is called at board_setup_arch stage. Now the initialization is done
> in probe function which is architectural better. Also It's convenient for
> adding PM support for PCI controller in later patch.
> 
> Now we registered pci controllers as platform devices. So we combine two
> initialization code as one platform driver.
> 
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> ---
>  arch/powerpc/platforms/85xx/mpc85xx_ds.c |   32 ++--------
>  arch/powerpc/sysdev/fsl_pci.c            |  102 ++++++++++++++++++-----------
>  arch/powerpc/sysdev/fsl_pci.h            |    6 +-
>  drivers/edac/mpc85xx_edac.c              |   43 ++++---------
>  4 files changed, 83 insertions(+), 100 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> index 56f8c8f..f2c7b1c 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> @@ -20,7 +20,6 @@
>  #include <linux/seq_file.h>
>  #include <linux/interrupt.h>
>  #include <linux/of_platform.h>
> -#include <linux/memblock.h>
>  
>  #include <asm/time.h>
>  #include <asm/machdep.h>
> @@ -117,40 +116,16 @@ void __init mpc85xx_ds_pic_init(void)
>  extern int uli_exclude_device(struct pci_controller *hose,
>  				u_char bus, u_char devfn);
>  
> -static struct device_node *pci_with_uli;
> -
>  static int mpc85xx_exclude_device(struct pci_controller *hose,
>  				   u_char bus, u_char devfn)
>  {
> -	if (hose->dn == pci_with_uli)
> +	if (hose->dn == fsl_pci_primary)
>  		return uli_exclude_device(hose, bus, devfn);
>  
>  	return PCIBIOS_SUCCESSFUL;
>  }
>  #endif	/* CONFIG_PCI */
>  
> -static void __init mpc85xx_ds_pci_init(void)
> -{
> -#ifdef CONFIG_PCI
> -	struct device_node *node;
> -
> -	fsl_pci_init();
> -
> -	/* See if we have a ULI under the primary */
> -
> -	node = of_find_node_by_name(NULL, "uli1575");
> -	while ((pci_with_uli = of_get_parent(node))) {
> -		of_node_put(node);
> -		node = pci_with_uli;
> -
> -		if (pci_with_uli == fsl_pci_primary) {
> -			ppc_md.pci_exclude_device = mpc85xx_exclude_device;
> -			break;
> -		}
> -	}
> -#endif
> -}
> -
>  /*
>   * Setup the architecture
>   */
> @@ -159,8 +134,11 @@ static void __init mpc85xx_ds_setup_arch(void)
>  	if (ppc_md.progress)
>  		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
>  
> +#ifdef CONFIG_PCI
> +	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
> +#endif

Why are you eliminating the uli lookup?  We don't want to call
uli_exclude_device on boards that don't have a uli.

-Scott

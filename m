Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41GxNv5zMtzF1RL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 09:50:39 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5SNnMMY001845
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 19:50:37 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jw62mr7ka-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 19:50:37 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 29 Jun 2018 00:50:34 +0100
Subject: Re: [PATCH v2 07/10] Revert "powerpc/powernv: Add support for the cxl
 kernel api on the real phb"
To: Frederic Barrat <fbarrat@linux.ibm.com>, alastair@au1.ibm.com,
 vaibhav@linux.ibm.com, clombard@linux.ibm.com, felix@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: huyn@mellanox.com
References: <20180628100509.17413-1-fbarrat@linux.ibm.com>
 <20180628100509.17413-8-fbarrat@linux.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 29 Jun 2018 09:50:29 +1000
MIME-Version: 1.0
In-Reply-To: <20180628100509.17413-8-fbarrat@linux.ibm.com>
Message-Id: <ab20c2a7-ca65-9624-a6eb-94704dd25853@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/06/18 20:05, Frederic Barrat wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Remove abandonned capi support for the Mellanox CX4.
> 
> This reverts commit 4361b03430d685610e5feea3ec7846e8b9ae795f.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   arch/powerpc/include/asm/pnv-pci.h        |   7 --
>   arch/powerpc/platforms/powernv/pci-cxl.c  | 115 ----------------------
>   arch/powerpc/platforms/powernv/pci-ioda.c |  18 +---
>   arch/powerpc/platforms/powernv/pci.h      |  13 ---
>   4 files changed, 1 insertion(+), 152 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
> index d2d8c28db336..7f627e3f4da4 100644
> --- a/arch/powerpc/include/asm/pnv-pci.h
> +++ b/arch/powerpc/include/asm/pnv-pci.h
> @@ -50,13 +50,6 @@ int pnv_cxl_alloc_hwirq_ranges(struct cxl_irq_ranges *irqs,
>   			       struct pci_dev *dev, int num);
>   void pnv_cxl_release_hwirq_ranges(struct cxl_irq_ranges *irqs,
>   				  struct pci_dev *dev);
> -
> -/* Support for the cxl kernel api on the real PHB (instead of vPHB) */
> -int pnv_cxl_enable_phb_kernel_api(struct pci_controller *hose, bool enable);
> -bool pnv_pci_on_cxl_phb(struct pci_dev *dev);
> -struct cxl_afu *pnv_cxl_phb_to_afu(struct pci_controller *hose);
> -void pnv_cxl_phb_set_peer_afu(struct pci_dev *dev, struct cxl_afu *afu);
> -
>   #endif
>   
>   struct pnv_php_slot {
> diff --git a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
> index c447b7f03c09..1b18111453d7 100644
> --- a/arch/powerpc/platforms/powernv/pci-cxl.c
> +++ b/arch/powerpc/platforms/powernv/pci-cxl.c
> @@ -8,10 +8,8 @@
>    */
>   
>   #include <linux/module.h>
> -#include <asm/pci-bridge.h>
>   #include <asm/pnv-pci.h>
>   #include <asm/opal.h>
> -#include <misc/cxl.h>
>   
>   #include "pci.h"
>   
> @@ -178,116 +176,3 @@ static inline int get_cxl_module(void)
>   #else
>   static inline int get_cxl_module(void) { return 0; }
>   #endif
> -
> -/*
> - * Sets flags and switches the controller ops to enable the cxl kernel api.
> - * Originally the cxl kernel API operated on a virtual PHB, but certain cards
> - * such as the Mellanox CX4 use a peer model instead and for these cards the
> - * cxl kernel api will operate on the real PHB.
> - */
> -int pnv_cxl_enable_phb_kernel_api(struct pci_controller *hose, bool enable)
> -{
> -	struct pnv_phb *phb = hose->private_data;
> -	int rc;
> -
> -	if (!enable) {
> -		/*
> -		 * Once cxl mode is enabled on the PHB, there is currently no
> -		 * known safe method to disable it again, and trying risks a
> -		 * checkstop. If we can find a way to safely disable cxl mode
> -		 * in the future we can revisit this, but for now the only sane
> -		 * thing to do is to refuse to disable cxl mode:
> -		 */
> -		return -EPERM;
> -	}
> -
> -	/*
> -	 * Hold a reference to the cxl module since several PHB operations now
> -	 * depend on it, and it would be insane to allow it to be removed so
> -	 * long as we are in this mode (and since we can't safely disable this
> -	 * mode once enabled...).
> -	 */
> -	rc = get_cxl_module();
> -	if (rc)
> -		return rc;
> -
> -	phb->flags |= PNV_PHB_FLAG_CXL;
> -	hose->controller_ops = pnv_cxl_cx4_ioda_controller_ops;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(pnv_cxl_enable_phb_kernel_api);
> -
> -bool pnv_pci_on_cxl_phb(struct pci_dev *dev)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	struct pnv_phb *phb = hose->private_data;
> -
> -	return !!(phb->flags & PNV_PHB_FLAG_CXL);
> -}
> -EXPORT_SYMBOL_GPL(pnv_pci_on_cxl_phb);
> -
> -struct cxl_afu *pnv_cxl_phb_to_afu(struct pci_controller *hose)
> -{
> -	struct pnv_phb *phb = hose->private_data;
> -
> -	return (struct cxl_afu *)phb->cxl_afu;
> -}
> -EXPORT_SYMBOL_GPL(pnv_cxl_phb_to_afu);
> -
> -void pnv_cxl_phb_set_peer_afu(struct pci_dev *dev, struct cxl_afu *afu)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	struct pnv_phb *phb = hose->private_data;
> -
> -	phb->cxl_afu = afu;
> -}
> -EXPORT_SYMBOL_GPL(pnv_cxl_phb_set_peer_afu);
> -
> -/*
> - * In the peer cxl model, the XSL/PSL is physical function 0, and will be used
> - * by other functions on the device for memory access and interrupts. When the
> - * other functions are enabled we explicitly take a reference on the cxl
> - * function since they will use it, and allocate a default context associated
> - * with that function just like the vPHB model of the cxl kernel API.
> - */
> -bool pnv_cxl_enable_device_hook(struct pci_dev *dev)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	struct pnv_phb *phb = hose->private_data;
> -	struct cxl_afu *afu = phb->cxl_afu;
> -
> -	if (!pnv_pci_enable_device_hook(dev))
> -		return false;
> -
> -
> -	/* No special handling for the cxl function, which is always PF 0 */
> -	if (PCI_FUNC(dev->devfn) == 0)
> -		return true;
> -
> -	if (!afu) {
> -		dev_WARN(&dev->dev, "Attempted to enable function > 0 on CXL PHB without a peer AFU\n");
> -		return false;
> -	}
> -
> -	dev_info(&dev->dev, "Enabling function on CXL enabled PHB with peer AFU\n");
> -
> -	/* Make sure the peer AFU can't go away while this device is active */
> -	cxl_afu_get(afu);
> -
> -	return cxl_pci_associate_default_context(dev, afu);
> -}
> -
> -void pnv_cxl_disable_device(struct pci_dev *dev)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	struct pnv_phb *phb = hose->private_data;
> -	struct cxl_afu *afu = phb->cxl_afu;
> -
> -	/* No special handling for cxl function: */
> -	if (PCI_FUNC(dev->devfn) == 0)
> -		return;
> -
> -	cxl_pci_disable_device(dev);
> -	cxl_afu_put(afu);
> -}
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 41f8f0ff4a55..770c67c4e8f7 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3575,7 +3575,7 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
>   /* Prevent enabling devices for which we couldn't properly
>    * assign a PE
>    */
> -bool pnv_pci_enable_device_hook(struct pci_dev *dev)
> +static bool pnv_pci_enable_device_hook(struct pci_dev *dev)
>   {
>   	struct pci_controller *hose = pci_bus_to_host(dev->bus);
>   	struct pnv_phb *phb = hose->private_data;
> @@ -3843,22 +3843,6 @@ static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {
>   	.shutdown		= pnv_pci_ioda_shutdown,
>   };
>   
> -#ifdef CONFIG_CXL_BASE
> -const struct pci_controller_ops pnv_cxl_cx4_ioda_controller_ops = {
> -	.dma_dev_setup		= pnv_pci_dma_dev_setup,
> -	.dma_bus_setup		= pnv_pci_dma_bus_setup,
> -	.enable_device_hook	= pnv_cxl_enable_device_hook,
> -	.disable_device		= pnv_cxl_disable_device,
> -	.release_device		= pnv_pci_release_device,
> -	.window_alignment	= pnv_pci_window_alignment,
> -	.setup_bridge		= pnv_pci_setup_bridge,
> -	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
> -	.dma_set_mask		= pnv_pci_ioda_dma_set_mask,
> -	.dma_get_required_mask	= pnv_pci_ioda_dma_get_required_mask,
> -	.shutdown		= pnv_pci_ioda_shutdown,
> -};
> -#endif
> -
>   static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   					 u64 hub_id, int ioda_type)
>   {
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index ba41913c7e21..44dfbc37f547 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -88,7 +88,6 @@ struct pnv_ioda_pe {
>   };
>   
>   #define PNV_PHB_FLAG_EEH	(1 << 0)
> -#define PNV_PHB_FLAG_CXL	(1 << 1) /* Real PHB supporting the cxl kernel API */
>   
>   struct pnv_phb {
>   	struct pci_controller	*hose;
> @@ -194,9 +193,6 @@ struct pnv_phb {
>   		bool nmmu_flush;
>   	} npu;
>   
> -#ifdef CONFIG_CXL_BASE
> -	struct cxl_afu *cxl_afu;
> -#endif
>   	int p2p_target_count;
>   };
>   
> @@ -238,7 +234,6 @@ extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
>   extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
>   extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
>   extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
> -extern bool pnv_pci_enable_device_hook(struct pci_dev *dev);
>   extern void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
>   extern int pnv_eeh_post_init(void);
>   
> @@ -262,12 +257,4 @@ extern void pnv_npu_take_ownership(struct pnv_ioda_pe *npe);
>   extern void pnv_npu_release_ownership(struct pnv_ioda_pe *npe);
>   extern int pnv_npu2_init(struct pnv_phb *phb);
>   
> -/* cxl functions */
> -extern bool pnv_cxl_enable_device_hook(struct pci_dev *dev);
> -extern void pnv_cxl_disable_device(struct pci_dev *dev);
> -
> -
> -/* phb ops (cxl switches these when enabling the kernel api on the phb) */
> -extern const struct pci_controller_ops pnv_cxl_cx4_ioda_controller_ops;
> -
>   #endif /* __POWERNV_PCI_H */
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

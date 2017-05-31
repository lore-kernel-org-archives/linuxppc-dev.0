Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcvTy47hLzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 12:25:58 +1000 (AEST)
Message-ID: <1496197542.3354.22.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv: Enable PCI peer-to-peer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 brking@linux.vnet.ibm.com, clsoto@linux.vnet.ibm.com
Date: Wed, 31 May 2017 12:25:42 +1000
In-Reply-To: <20170530135818.19291-1-fbarrat@linux.vnet.ibm.com>
References: <20170530135818.19291-1-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-30 at 15:58 +0200, Frederic Barrat wrote:
> P9 has support for PCI peer-to-peer, enabling a device to write in the
> mmio space of another device directly, without interrupting the CPU.
> 
> This patch adds support for it on powernv, by defining two APIs to
> declare a pci_dev as either a p2p sender or receiver:
> 
>   int pnv_pci_set_p2p_sender(struct pci_dev *dev);
>   int pnv_pci_set_p2p_receiver(struct pci_dev *dev);
> 
> It uses a new OPAL call, as the configuration magic is done on the
> PHBs by skiboot.

I would add an "enable" argument to be able to enable & disable. I
would also do a single call (including at OPAL level) that takes
both the sender and the receiver in case some (future) HW has
specific filters on powerbus originators.

I would also not call them "sender" and "receiver" but "initiator" and
"target", and I would pass an argument indicating a bitmask of the
expected directions (stores, loads, both), so we can appropriately
error out on chips that only support "stores" if load is requested, and
the API can provide support for future chips that do support loads.

This API could also handle P2P bridges for devices on the same PHB (and
in this case support loads).

We might also need a way to provide the "initiator" with translated DMA
addresses that allow to target the receiver.

There is work to do a "generic" API for that but it's far from ready...

Cheers,
Ben.

> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
> Need skiboot patch:
> http://patchwork.ozlabs.org/patch/768613/
> 
>  arch/powerpc/include/asm/opal-api.h            |  9 +++++-
>  arch/powerpc/include/asm/opal.h                |  1 +
>  arch/powerpc/include/asm/pnv-pci.h             |  2 ++
>  arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
>  arch/powerpc/platforms/powernv/pci-ioda.c      |  2 +-
>  arch/powerpc/platforms/powernv/pci.c           | 43 ++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/pci.h           |  1 +
>  7 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index cb3e6242a78c..031f5766b0dd 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -190,7 +190,8 @@
>  #define OPAL_NPU_INIT_CONTEXT			146
>  #define OPAL_NPU_DESTROY_CONTEXT		147
>  #define OPAL_NPU_MAP_LPAR			148
> -#define OPAL_LAST				148
> +#define OPAL_PCI_SET_P2P			149
> +#define OPAL_LAST				149
>  
>  /* Device tree flags */
>  
> @@ -1003,6 +1004,12 @@ enum {
>  	XIVE_DUMP_EMU_STATE	= 5,
>  };
>  
> +/* PCI p2p modes */
> +enum {
> +	OPAL_PCI_P2P_SENDER	= 0,
> +	OPAL_PCI_P2P_RECEIVER	= 1,
> +};
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* __OPAL_API_H */
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 588fb1c23af9..59c20b9da1c0 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -267,6 +267,7 @@ int64_t opal_xive_allocate_irq(uint32_t chip_id);
>  int64_t opal_xive_free_irq(uint32_t girq);
>  int64_t opal_xive_sync(uint32_t type, uint32_t id);
>  int64_t opal_xive_dump(uint32_t type, uint32_t id);
> +int64_t opal_pci_set_p2p(uint64_t phb_id, uint64_t mode);
>  
>  /* Internal functions */
>  extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
> diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
> index de9681034353..1b67c6afd29a 100644
> --- a/arch/powerpc/include/asm/pnv-pci.h
> +++ b/arch/powerpc/include/asm/pnv-pci.h
> @@ -26,6 +26,8 @@ extern int pnv_pci_get_presence_state(uint64_t id, uint8_t *state);
>  extern int pnv_pci_get_power_state(uint64_t id, uint8_t *state);
>  extern int pnv_pci_set_power_state(uint64_t id, uint8_t state,
>  				   struct opal_msg *msg);
> +extern int pnv_pci_set_p2p_sender(struct pci_dev *dev);
> +extern int pnv_pci_set_p2p_receiver(struct pci_dev *dev);
>  
>  int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
>  int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index f620572f891f..cf629d2d89d9 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -310,3 +310,4 @@ OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
>  OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
>  OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
>  OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
> +OPAL_CALL(opal_pci_set_p2p,			OPAL_PCI_SET_P2P);
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 283caf1070c9..63263696f2b6 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2280,7 +2280,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>  	return 0;
>  }
>  
> -static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
> +void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
>  {
>  	uint16_t window_id = (pe->pe_number << 1 ) + 1;
>  	int64_t rc;
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 935ccb249a8a..15d087d5749f 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -901,6 +901,49 @@ void pnv_pci_dma_bus_setup(struct pci_bus *bus)
>  	}
>  }
>  
> +int pnv_pci_set_p2p_sender(struct pci_dev *dev)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> +	struct pnv_phb *phb = hose->private_data;
> +	struct pnv_ioda_pe *pe;
> +	int rc;
> +
> +	if (!opal_check_token(OPAL_PCI_SET_P2P))
> +		return -ENXIO;
> +
> +	pe = pnv_ioda_get_pe(dev);
> +	if (!pe)
> +		return -ENODEV;
> +
> +	rc = opal_pci_set_p2p(phb->opal_id, OPAL_PCI_P2P_SENDER);
> +	if (rc != OPAL_SUCCESS)
> +		return -EIO;
> +	/*
> +	 * Redefine the TVT entry in bypass mode for the device.
> +	 * Now that the PHB is marked as a p2p sender, it disables
> +	 * range checking.
> +	 */
> +	pnv_pci_ioda2_set_bypass(pe, true);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_set_p2p_sender);
> +
> +int pnv_pci_set_p2p_receiver(struct pci_dev *dev)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> +	struct pnv_phb *phb = hose->private_data;
> +	int rc;
> +
> +	if (!opal_check_token(OPAL_PCI_SET_P2P))
> +		return -ENXIO;
> +
> +	rc = opal_pci_set_p2p(phb->opal_id, OPAL_PCI_P2P_RECEIVER);
> +	if (rc != OPAL_SUCCESS)
> +		return -EIO;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_set_p2p_receiver);
> +
>  void pnv_pci_shutdown(void)
>  {
>  	struct pci_controller *hose;
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 18c8a2fa03b8..6cd95c1a2b8b 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -230,6 +230,7 @@ extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
>  extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
>  extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
>  extern bool pnv_pci_enable_device_hook(struct pci_dev *dev);
> +extern void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
>  
>  extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>  			    const char *fmt, ...);

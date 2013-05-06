Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CD7192C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 07:33:20 +1000 (EST)
Message-ID: <1367875982.15842.58.camel@pasglop>
Subject: Re: [PATCH 2/3] powerpc/powernv: Disable IO space for PCI buses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 07 May 2013 07:33:02 +1000
In-Reply-To: <1367847858-6506-2-git-send-email-shangw@linux.vnet.ibm.com>
References: <1367847858-6506-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1367847858-6506-2-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: yinghai@kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-06 at 21:44 +0800, Gavin Shan wrote:
> The patch intends to set the special flag (PCI_BUS_FLAGS_NO_IO) for
> root buses so PCI core will skip assignment for IO stuff. Besides,
> we also clear the IO resources on all PCI devices for PHB3.

Why the new hook ? Can't this be detected simply because there is
no aperture in the pci_host_bridge with IORESOURCE_IO set in the flags ?

Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/machdep.h        |    3 ++
>  arch/powerpc/kernel/pci-common.c          |    7 +++++
>  arch/powerpc/platforms/powernv/pci-ioda.c |   38 +++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> index 3f3f691..ebc2ffd 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -220,6 +220,9 @@ struct machdep_calls {
>  	/* Called during PCI resource reassignment */
>  	resource_size_t (*pcibios_window_alignment)(struct pci_bus *, unsigned long type);
>  
> +	/* Called when adding PCI bus */
> +	void (*pcibios_add_bus)(struct pci_bus *);
> +
>  	/* Called to shutdown machine specific hardware not already controlled
>  	 * by other drivers.
>  	 */
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index f325dc9..7b8a6f1 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -120,6 +120,13 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>  	return 1;
>  }
>  
> +/* The function will be called while adding PCI bus to system */
> +void pcibios_add_bus(struct pci_bus *bus)
> +{
> +	if (ppc_md.pcibios_add_bus)
> +		ppc_md.pcibios_add_bus(bus);
> +}
> +
>  static resource_size_t pcibios_io_size(const struct pci_controller *hose)
>  {
>  #ifdef CONFIG_PPC64
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 8c6c9cf..0c3fa29 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1015,6 +1015,40 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
>  	return phb->ioda.io_segsize;
>  }
>  
> +/*
> + * The function will be called while adding PCI bus to the
> + * system. In turn, we should set flag to indicate that the
> + * root bus doesn't have IO resources.
> + */
> +static void pnv_pci_add_bus(struct pci_bus *bus)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(bus);
> +	struct pnv_phb *phb = hose->private_data;
> +
> +	/*
> +	 * We only need set the flag for root bus since the
> +	 * bus flags are copied over from parent to children
> +	 */
> +	if (pci_is_root_bus(bus) &&
> +	    phb->model == PNV_PHB_MODEL_PHB3)
> +		bus->bus_flags |= PCI_BUS_FLAGS_NO_IO;
> +}
> +
> +static void pnv_pci_fixup_resources(struct pci_dev *dev)
> +{
> +	int i;
> +	struct resource *res;
> +
> +	if (!(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_IO))
> +		return;
> +
> +	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +		res = dev->resource + i;
> +		if (res->flags & IORESOURCE_IO)
> +			res->flags = 0;
> +	}
> +}
> +
>  /* Prevent enabling devices for which we couldn't properly
>   * assign a PE
>   */
> @@ -1189,6 +1223,10 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
>  	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
>  	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
>  	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
> +	if (ioda_type == PNV_PHB_IODA2) {
> +		ppc_md.pcibios_add_bus = pnv_pci_add_bus;
> +		ppc_md.pcibios_fixup_resources = pnv_pci_fixup_resources;
> +	}
>  	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
>  
>  	/* Reset IODA tables to a clean state */

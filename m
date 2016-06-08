Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPZCs2KJLzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 13:48:25 +1000 (AEST)
Received: by mail-pf0-f195.google.com with SMTP id 62so21965420pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jun 2016 20:48:25 -0700 (PDT)
Subject: Re: [PATCH v10 09/18] powerpc/powernv: Extend PCI bridge resources
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1463726502-14679-10-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 alistair@popple.id.au
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <9bd72b5a-c4c5-9ab7-7c82-cb4d7e8d51fd@ozlabs.ru>
Date: Wed, 8 Jun 2016 13:47:16 +1000
MIME-Version: 1.0
In-Reply-To: <1463726502-14679-10-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/05/16 16:41, Gavin Shan wrote:
> The PCI slots are associated with root port or downstream ports
> of the PCIe switch connected to root port. When adapter is hot
> added to the PCI slot, it usually requests more IO or memory
> resource from the directly connected parent bridge (port) and
> update the bridge's windows accordingly. The resource windows
> of upstream bridges can't be updated automatically. It possibly
> leads to unbalanced resource across the bridges: The window of
> downstream bridge is overruning that of upstream bridge. The
> IO or MMIO path won't work.
> 
> This resolves the above issue by extending bridge windows of
> root port and upstream port of the PCIe switch connected to
> the root port to PHB's windows.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


This breaks Garrison machine (g86l):

EEH: Frozen PE#f9 on PHB#5 detected
EEH: PE location: Backplane PLX, PHB location: N/A
EEH: This PCI device has failed 1 times in the last hour
EEH: Notify device drivers to shutdown
EEH: Collect temporary log


PHB#5 has a boot device so we end up in initramdisk.


0005:03:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0
xHCI Host Controller (rev 02)
0005:04:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9235 PCIe
2.0 x2 4-port SATA 6 Gb/s Controller (rev 11)
0005:05:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
(rev 03)
0005:06:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED
Graphics Family (rev 30)



> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 46 +++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 3186a29..e97a5fa 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3221,6 +3221,49 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
>  	return phb->ioda.io_segsize;
>  }
>  
> +/*
> + * We are updating root port or the upstream port of the
> + * bridge behind the root port with PHB's windows in order
> + * to accommodate the changes on required resources during
> + * PCI (slot) hotplug, which is connected to either root
> + * port or the downstream ports of PCIe switch behind the
> + * root port.
> + */
> +static void pnv_pci_fixup_bridge_resources(struct pci_bus *bus,
> +					   unsigned long type)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(bus);
> +	struct pnv_phb *phb = hose->private_data;
> +	struct pci_dev *bridge = bus->self;
> +	struct resource *r, *w;
> +	int i;
> +
> +	/* Check if we need apply fixup to the bridge's windows */
> +	if (!pci_is_root_bus(bridge->bus) &&
> +	    !pci_is_root_bus(bridge->bus->self->bus))
> +		return;
> +
> +	/* Fixup the resources */
> +	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
> +		r = &bridge->resource[PCI_BRIDGE_RESOURCES + i];
> +		if (!r->flags || !r->parent)
> +			continue;
> +
> +		w = NULL;
> +		if (r->flags & type & IORESOURCE_IO)
> +			w = &hose->io_resource;
> +		else if (pnv_pci_is_mem_pref_64(r->flags) &&
> +			 (type & IORESOURCE_PREFETCH) &&
> +			 phb->ioda.m64_segsize)
> +			w = &hose->mem_resources[1];
> +		else if (r->flags & type & IORESOURCE_MEM)
> +			w = &hose->mem_resources[0];
> +
> +		r->start = w->start;
> +		r->end = w->end;
> +	}
> +}
> +
>  static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
>  {
>  	struct pci_controller *hose = pci_bus_to_host(bus);
> @@ -3229,6 +3272,9 @@ static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
>  	struct pnv_ioda_pe *pe;
>  	bool all = (pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE);
>  
> +	/* Extend bridge's windows if necessary */
> +	pnv_pci_fixup_bridge_resources(bus, type);
> +
>  	/* The PE for root bus should be realized before any one else */
>  	if (!phb->ioda.root_pe_populated) {
>  		pe = pnv_ioda_setup_bus_PE(phb->hose->bus, false);
> 


-- 
Alexey

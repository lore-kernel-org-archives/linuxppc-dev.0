Return-Path: <bhelgaas@google.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C25721A1416
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 19:52:39 +1100 (AEDT)
Received: by padfa1 with SMTP id fa1so34570591pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 00:52:37 -0800 (PST)
Date: Tue, 24 Feb 2015 02:52:34 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v12 15/21] powerpc/powernv: Reserve additional space for
 IOV BAR according to the number of total_pe
Message-ID: <20150224085234.GJ6220@google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083442.32124.96716.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150224083442.32124.96716.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 24, 2015 at 02:34:42AM -0600, Bjorn Helgaas wrote:
> From: Wei Yang <weiyang@linux.vnet.ibm.com>
> 
> On PHB3, PF IOV BAR will be covered by M64 window to have better PE
> isolation.  The total_pe number is usually different from total_VFs, which
> can lead to a conflict between MMIO space and the PE number.
> 
> For example, if total_VFs is 128 and total_pe is 256, the second half of
> M64 window will be part of other PCI device, which may already belong
> to other PEs.

I'm still trying to wrap my mind around the explanation here.

I *think* what's going on is that the M64 window must be a power-of-two
size.  If the VF(n) BAR space doesn't completely fill it, we might allocate
the leftover space to another device.  Then the M64 window for *this*
device may cause the other device to be associated with a PE it didn't
expect.

But I don't understand this well enough to describe it clearly.

More serious code question below...

> Prevent the conflict by reserving additional space for the PF IOV BAR,
> which is total_pe number of VF's BAR size.
> 
> [bhelgaas: make dev_printk() output more consistent, index resource[]
> conventionally]
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/include/asm/machdep.h        |    4 ++
>  arch/powerpc/include/asm/pci-bridge.h     |    3 ++
>  arch/powerpc/kernel/pci-common.c          |    5 +++
>  arch/powerpc/platforms/powernv/pci-ioda.c |   58 +++++++++++++++++++++++++++++
>  4 files changed, 70 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> index c8175a3fe560..965547c58497 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -250,6 +250,10 @@ struct machdep_calls {
>  	/* Reset the secondary bus of bridge */
>  	void  (*pcibios_reset_secondary_bus)(struct pci_dev *dev);
>  
> +#ifdef CONFIG_PCI_IOV
> +	void (*pcibios_fixup_sriov)(struct pci_bus *bus);
> +#endif /* CONFIG_PCI_IOV */
> +
>  	/* Called to shutdown machine specific hardware not already controlled
>  	 * by other drivers.
>  	 */
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 513f8f27060d..de11de7d4547 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -175,6 +175,9 @@ struct pci_dn {
>  #define IODA_INVALID_PE		(-1)
>  #ifdef CONFIG_PPC_POWERNV
>  	int	pe_number;
> +#ifdef CONFIG_PCI_IOV
> +	u16     max_vfs;		/* number of VFs IOV BAR expended */
> +#endif /* CONFIG_PCI_IOV */
>  #endif
>  	struct list_head child_list;
>  	struct list_head list;
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 82031011522f..022e9feeb1f2 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1646,6 +1646,11 @@ void pcibios_scan_phb(struct pci_controller *hose)
>  	if (ppc_md.pcibios_fixup_phb)
>  		ppc_md.pcibios_fixup_phb(hose);
>  
> +#ifdef CONFIG_PCI_IOV
> +	if (ppc_md.pcibios_fixup_sriov)
> +		ppc_md.pcibios_fixup_sriov(bus);
> +#endif /* CONFIG_PCI_IOV */
> +
>  	/* Configure PCI Express settings */
>  	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
>  		struct pci_bus *child;
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index cd1a56160ded..36c533da5ccb 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1749,6 +1749,61 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
>  static void pnv_pci_init_ioda_msis(struct pnv_phb *phb) { }
>  #endif /* CONFIG_PCI_MSI */
>  
> +#ifdef CONFIG_PCI_IOV
> +static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> +{
> +	struct pci_controller *hose;
> +	struct pnv_phb *phb;
> +	struct resource *res;
> +	int i;
> +	resource_size_t size;
> +	struct pci_dn *pdn;
> +
> +	if (!pdev->is_physfn || pdev->is_added)
> +		return;
> +
> +	hose = pci_bus_to_host(pdev->bus);
> +	phb = hose->private_data;
> +
> +	pdn = pci_get_pdn(pdev);
> +	pdn->max_vfs = 0;
> +
> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> +		res = &pdev->resource[i + PCI_IOV_RESOURCES];
> +		if (!res->flags || res->parent)
> +			continue;
> +		if (!pnv_pci_is_mem_pref_64(res->flags)) {
> +			dev_warn(&pdev->dev, "Skipping expanding VF BAR%d: %pR\n",
> +				 i, res);
> +			continue;
> +		}
> +
> +		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
> +		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
> +		res->end = res->start + size * phb->ioda.total_pe - 1;
> +		dev_dbg(&pdev->dev, "                       %pR\n", res);
> +		dev_info(&pdev->dev, "VF BAR%d: %pR (expanded to %d VFs for PE alignment)",
> +				i, res, phb->ioda.total_pe);
> +	}
> +	pdn->max_vfs = phb->ioda.total_pe;
> +}
> +
> +static void pnv_pci_ioda_fixup_sriov(struct pci_bus *bus)
> +{
> +	struct pci_dev *pdev;
> +	struct pci_bus *b;
> +
> +	list_for_each_entry(pdev, &bus->devices, bus_list) {
> +		b = pdev->subordinate;
> +
> +		if (b)
> +			pnv_pci_ioda_fixup_sriov(b);
> +
> +		pnv_pci_ioda_fixup_iov_resources(pdev);

I'm not sure this happens at the right time.  We have this call chain:

  pcibios_scan_phb
    pci_create_root_bus
    pci_scan_child_bus
    pnv_pci_ioda_fixup_sriov
      pnv_pci_ioda_fixup_iov_resources
	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
	  increase res->size to accomodate 256 PEs (or roundup(totalVFs)

so we only do the fixup_iov_resources() when we scan the PHB, and we
wouldn't do it at all for hot-added devices.

> +	}
> +}
> +#endif /* CONFIG_PCI_IOV */
> +
>  /*
>   * This function is supposed to be called on basis of PE from top
>   * to bottom style. So the the I/O or MMIO segment assigned to
> @@ -2125,6 +2180,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
>  	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
>  	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
> +#ifdef CONFIG_PCI_IOV
> +	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
> +#endif /* CONFIG_PCI_IOV */
>  	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
>  
>  	/* Reset IODA tables to a clean state */
> 

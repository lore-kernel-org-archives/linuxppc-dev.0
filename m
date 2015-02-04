Return-Path: <bhelgaas@google.com>
Received: from mail-oi0-x232.google.com (mail-oi0-x232.google.com
 [IPv6:2607:f8b0:4003:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6299C1A0A2C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 08:26:13 +1100 (AEDT)
Received: by mail-oi0-f50.google.com with SMTP id h136so3416705oig.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2015 13:26:11 -0800 (PST)
Date: Wed, 4 Feb 2015 15:26:07 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V11 12/17] powerpc/powernv: Reserve additional space for
 IOV BAR according to the number of total_pe
Message-ID: <20150204212607.GA20072@google.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-13-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421288887-7765-13-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 15, 2015 at 10:28:02AM +0800, Wei Yang wrote:
> On PHB3, PF IOV BAR will be covered by M64 BAR to have better PE isolation.
> Mostly the total_pe number is different from the total_VFs, which will lead
> to a conflict between MMIO space and the PE number.
> 
> For example, total_VFs is 128 and total_pe is 256, then the second half of
> M64 BAR space will be part of other PCI device, which may already belongs
> to other PEs.
> 
> This patch reserve additional space for the PF IOV BAR, which is total_pe
> number of VF's BAR size. By doing so, it prevents the conflict.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/machdep.h        |    4 ++
>  arch/powerpc/include/asm/pci-bridge.h     |    3 ++
>  arch/powerpc/kernel/pci-common.c          |    5 +++
>  arch/powerpc/platforms/powernv/pci-ioda.c |   59 +++++++++++++++++++++++++++++
>  4 files changed, 71 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> index c8175a3..965547c 100644
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
> index 334e745..b857ec4 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -170,6 +170,9 @@ struct pci_dn {
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
> index 889f743..832b7e1 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1636,6 +1636,11 @@ void pcibios_scan_phb(struct pci_controller *hose)
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
> index 31335a7..6704fdf 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1721,6 +1721,62 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
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

^^^ point A

> +
> +	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
> +		res = &pdev->resource[i];
> +		if (!res->flags || res->parent)
> +			continue;
> +		if (!pnv_pci_is_mem_pref_64(res->flags)) {
> +			dev_warn(&pdev->dev, " Skipping expanding IOV BAR %pR on %s\n",
> +				 res, pci_name(pdev));
> +			continue;
> +		}
> +
> +		dev_dbg(&pdev->dev, " Fixing VF BAR[%d] %pR to\n", i, res);
> +		size = pci_iov_resource_size(pdev, i);
> +		res->end = res->start + size * phb->ioda.total_pe - 1;
> +		dev_dbg(&pdev->dev, "                       %pR\n", res);
> +		dev_info(&pdev->dev, "VF BAR%d: %pR (expanded to %d VFs for PE alignment)",
> +				i - PCI_IOV_RESOURCES,
> +				res, phb->ioda.total_pe);
> +	}
> +	pdn->max_vfs = phb->ioda.total_pe;

I don't think you change phb->ioda.total_pe between point A (above) and
here.  Does that mean "max_vfs == 0" is some kind of flag, maybe related to
the three cases in pnv_pci_iov_resource_alignment()?  Ewww!

If it doesn't change, just set "pdn->max_vfs = phb->ioda.total_pe" at
point A and be done with it.

But hopefully you can just remove this fixup path altogether.

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
> +	}
> +}
> +#endif /* CONFIG_PCI_IOV */
> +
>  /*
>   * This function is supposed to be called on basis of PE from top
>   * to bottom style. So the the I/O or MMIO segment assigned to
> @@ -2097,6 +2153,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
>  	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
>  	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
> +#ifdef CONFIG_PCI_IOV
> +	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
> +#endif /* CONFIG_PCI_IOV */
>  	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
>  
>  	/* Reset IODA tables to a clean state */
> -- 
> 1.7.9.5
> 

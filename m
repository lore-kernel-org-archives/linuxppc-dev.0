Return-Path: <bhelgaas@google.com>
Received: from mail-oi0-x235.google.com (mail-oi0-x235.google.com
 [IPv6:2607:f8b0:4003:c06::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8ACAA1A0BF0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 08:26:19 +1100 (AEDT)
Received: by mail-oi0-f53.google.com with SMTP id i138so3406956oig.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2015 13:26:17 -0800 (PST)
Date: Wed, 4 Feb 2015 15:26:14 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V11 13/17] powerpc/powernv: Implement
 pcibios_iov_resource_alignment() on powernv
Message-ID: <20150204212614.GB11271@google.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-14-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421288887-7765-14-git-send-email-weiyang@linux.vnet.ibm.com>
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

On Thu, Jan 15, 2015 at 10:28:03AM +0800, Wei Yang wrote:
> This patch implements the pcibios_iov_resource_alignment() on powernv
> platform.
> 
> On PowerNV platform, there are 3 cases for the IOV BAR:
> 1. initial state, the IOV BAR size is multiple times of VF BAR size
> 2. after expanded, the IOV BAR size is expanded to meet the M64 segment size
> 3. sizing stage, the IOV BAR is truncated to 0
> 
> pnv_pci_iov_resource_alignment() handle these three cases respectively.
>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/machdep.h        |    3 +++
>  arch/powerpc/kernel/pci-common.c          |   14 ++++++++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c |   20 ++++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> index 965547c..12e8eb8 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -252,6 +252,9 @@ struct machdep_calls {
>  
>  #ifdef CONFIG_PCI_IOV
>  	void (*pcibios_fixup_sriov)(struct pci_bus *bus);
> +	resource_size_t (*pcibios_iov_resource_alignment)(struct pci_dev *,
> +			                                    int resno,
> +							    resource_size_t align);
>  #endif /* CONFIG_PCI_IOV */
>  
>  	/* Called to shutdown machine specific hardware not already controlled
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 832b7e1..8751dfb 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -130,6 +130,20 @@ void pcibios_reset_secondary_bus(struct pci_dev *dev)
>  	pci_reset_secondary_bus(dev);
>  }
>  
> +#ifdef CONFIG_PCI_IOV
> +resource_size_t pcibios_iov_resource_alignment(struct pci_dev *pdev,
> +						 int resno,
> +						 resource_size_t align)
> +{
> +	if (ppc_md.pcibios_iov_resource_alignment)
> +		return ppc_md.pcibios_iov_resource_alignment(pdev,
> +							       resno,
> +							       align);
> +
> +	return 0;

This isn't right, is it?  The default (weak) version returns
pci_iov_resource_size(dev, resno).  When you don't have a
ppc_md.pcibios_iov_resource_alignment pointer, don't you
want to do that, too?

> +}
> +#endif /* CONFIG_PCI_IOV */
> +
>  static resource_size_t pcibios_io_size(const struct pci_controller *hose)
>  {
>  #ifdef CONFIG_PPC64
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 6704fdf..8bad2b0 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1953,6 +1953,25 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
>  	return phb->ioda.io_segsize;
>  }
>  
> +#ifdef CONFIG_PCI_IOV
> +static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
> +							    int resno,
> +							    resource_size_t align)
> +{
> +	struct pci_dn *pdn = pci_get_pdn(pdev);
> +	resource_size_t iov_align;
> +
> +	iov_align = resource_size(&pdev->resource[resno]);
> +	if (iov_align)
> +		return iov_align;
> +
> +	if (pdn->max_vfs)
> +		return pdn->max_vfs * align;
> +
> +	return align;

pcibios_iov_resource_alignment() returns different things depending on when
you call it?  That doesn't sound good.

Is this related to my questions about sriov_init() and
pnv_pci_ioda_fixup_iov_resources()?  If you adopted my suggestion and set
the size once in sriov_init(), would that get rid of one of these cases?

Maybe it would help me understand if you explained the three cases a bit
more.

> +}
> +#endif /* CONFIG_PCI_IOV */
> +
>  /* Prevent enabling devices for which we couldn't properly
>   * assign a PE
>   */
> @@ -2155,6 +2174,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
>  #ifdef CONFIG_PCI_IOV
>  	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
> +	ppc_md.pcibios_iov_resource_alignment = pnv_pci_iov_resource_alignment;
>  #endif /* CONFIG_PCI_IOV */
>  	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
>  
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

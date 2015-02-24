Return-Path: <bhelgaas@google.com>
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CF981A3474
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 20:07:06 +1100 (AEDT)
Received: by pdbnh10 with SMTP id nh10so31977530pdb.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 01:07:04 -0800 (PST)
Date: Tue, 24 Feb 2015 03:06:57 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v12 18/21] powerpc/powernv: Reserve additional space for
 IOV BAR, with m64_per_iov supported
Message-ID: <20150224090657.GM6220@google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083504.32124.23374.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150224083504.32124.23374.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 24, 2015 at 02:35:04AM -0600, Bjorn Helgaas wrote:
> From: Wei Yang <weiyang@linux.vnet.ibm.com>
> 
> M64 aperture size is limited on PHB3.  When the IOV BAR is too big, this
> will exceed the limitation and failed to be assigned.
> 
> Introduce a different mechanism based on the IOV BAR size:
> 
>   - if IOV BAR size is smaller than 64MB, expand to total_pe
>   - if IOV BAR size is bigger than 64MB, roundup power2
> 
> [bhelgaas: make dev_printk() output more consistent, use PCI_SRIOV_NUM_BARS]
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/include/asm/pci-bridge.h     |    2 ++
>  arch/powerpc/platforms/powernv/pci-ioda.c |   33 ++++++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 011340df8583..d824bb184ab8 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -179,6 +179,8 @@ struct pci_dn {
>  	u16     max_vfs;		/* number of VFs IOV BAR expended */
>  	u16     vf_pes;			/* VF PE# under this PF */
>  	int     offset;			/* PE# for the first VF PE */
> +#define M64_PER_IOV 4
> +	int     m64_per_iov;
>  #define IODA_INVALID_M64        (-1)
>  	int     m64_wins[PCI_SRIOV_NUM_BARS];
>  #endif /* CONFIG_PCI_IOV */
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index a3c2fbe35fc8..30b7c3909746 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2242,6 +2242,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>  	int i;
>  	resource_size_t size;
>  	struct pci_dn *pdn;
> +	int mul, total_vfs;
>  
>  	if (!pdev->is_physfn || pdev->is_added)
>  		return;
> @@ -2252,6 +2253,32 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>  	pdn = pci_get_pdn(pdev);
>  	pdn->max_vfs = 0;
>  
> +	total_vfs = pci_sriov_get_totalvfs(pdev);
> +	pdn->m64_per_iov = 1;
> +	mul = phb->ioda.total_pe;
> +
> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> +		res = &pdev->resource[i + PCI_IOV_RESOURCES];
> +		if (!res->flags || res->parent)
> +			continue;
> +		if (!pnv_pci_is_mem_pref_64(res->flags)) {
> +			dev_warn(&pdev->dev, " non M64 VF BAR%d: %pR\n",
> +				 i, res);

Why is this a dev_warn()?  Can the user do anything about it?  Do you want
bug reports if users see this message?  There are several other instances
of this in the other patches, too.

> +			continue;
> +		}
> +
> +		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
> +
> +		/* bigger than 64M */
> +		if (size > (1 << 26)) {
> +			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size is bigger than 64M, roundup power2\n",
> +				 i, res);
> +			pdn->m64_per_iov = M64_PER_IOV;
> +			mul = __roundup_pow_of_two(total_vfs);

Why is this __roundup_pow_of_two() instead of roundup_pow_of_two()?
I *think* __roundup_pow_of_two() is basically a helper function for
implementing roundup_pow_of_two() and not intended to be used by itself.

I think there are other patches that use __roundup_pow_of_two(), too.

> +			break;
> +		}
> +	}
> +
>  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>  		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>  		if (!res->flags || res->parent)
> @@ -2264,12 +2291,12 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>  
>  		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
>  		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
> -		res->end = res->start + size * phb->ioda.total_pe - 1;
> +		res->end = res->start + size * mul - 1;
>  		dev_dbg(&pdev->dev, "                       %pR\n", res);
>  		dev_info(&pdev->dev, "VF BAR%d: %pR (expanded to %d VFs for PE alignment)",
> -				i, res, phb->ioda.total_pe);
> +			 i, res, mul);
>  	}
> -	pdn->max_vfs = phb->ioda.total_pe;
> +	pdn->max_vfs = mul;
>  }
>  
>  static void pnv_pci_ioda_fixup_sriov(struct pci_bus *bus)
> 

Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w4Mlg5t42zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Apr 2017 01:58:55 +1000 (AEST)
Date: Fri, 14 Apr 2017 10:58:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yongji Xie <elohimes@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alex.williamson@redhat.com,
 gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, zhong@linux.vnet.ibm.com
Subject: Re: [PATCH v10 3/4] powerpc/powernv: Override
 pcibios_default_alignment() to force PCI devices to be page aligned
Message-ID: <20170414155849.GB5864@bhelgaas-glaptop.roam.corp.google.com>
References: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
 <1491825494-19331-4-git-send-email-elohimes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491825494-19331-4-git-send-email-elohimes@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 10, 2017 at 07:58:13PM +0800, Yongji Xie wrote:
> This overrides pcibios_default_alignment() to set default alignment
> to PAGE_SIZE for all PCI devices on PowerNV platform. Thus sub-page
> BARs would not share a page and could be mapped into guest when VFIO
> passthrough them.

Thanks for doing this.  This looks like a reasonable strategy to me,
but it would be good to get a powerpc ack for it.

> Signed-off-by: Yongji Xie <elohimes@gmail.com>
> ---
>  arch/powerpc/include/asm/machdep.h        |    2 ++
>  arch/powerpc/kernel/pci-common.c          |    8 ++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c |    7 +++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> index 5011b69..a82c192 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -173,6 +173,8 @@ struct machdep_calls {
>  	/* Called after scan and before resource survey */
>  	void (*pcibios_fixup_phb)(struct pci_controller *hose);
>  
> +	resource_size_t (*pcibios_default_alignment)(struct pci_dev *);
> +
>  #ifdef CONFIG_PCI_IOV
>  	void (*pcibios_fixup_sriov)(struct pci_dev *pdev);
>  	resource_size_t (*pcibios_iov_resource_alignment)(struct pci_dev *, int resno);
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index ffda24a..ceda574 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -233,6 +233,14 @@ void pcibios_reset_secondary_bus(struct pci_dev *dev)
>  	pci_reset_secondary_bus(dev);
>  }
>  
> +resource_size_t pcibios_default_alignment(struct pci_dev *pdev)
> +{
> +	if (ppc_md.pcibios_default_alignment)
> +		return ppc_md.pcibios_default_alignment(pdev);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PCI_IOV
>  resource_size_t pcibios_iov_resource_alignment(struct pci_dev *pdev, int resno)
>  {
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index e367382..354c852 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3297,6 +3297,11 @@ static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
>  	}
>  }
>  
> +static resource_size_t pnv_pci_default_alignment(struct pci_dev *pdev)
> +{
> +	return PAGE_SIZE;
> +}
> +
>  #ifdef CONFIG_PCI_IOV
>  static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
>  						      int resno)
> @@ -3830,6 +3835,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  		hose->controller_ops = pnv_pci_ioda_controller_ops;
>  	}
>  
> +	ppc_md.pcibios_default_alignment = pnv_pci_default_alignment;
> +
>  #ifdef CONFIG_PCI_IOV
>  	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov_resources;
>  	ppc_md.pcibios_iov_resource_alignment = pnv_pci_iov_resource_alignment;
> -- 
> 1.7.9.5
> 

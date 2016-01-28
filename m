Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F9E31A1052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 09:46:14 +1100 (AEDT)
Message-ID: <1454021169.23148.5.camel@redhat.com>
Subject: Re: [RFC PATCH v3 1/5] PCI: Add support for enforcing all MMIO BARs
 to be page aligned
From: Alex Williamson <alex.williamson@redhat.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com
Date: Thu, 28 Jan 2016 15:46:09 -0700
In-Reply-To: <1452841574-2781-2-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1452841574-2781-2-git-send-email-xyjxie@linux.vnet.ibm.com>
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

On Fri, 2016-01-15 at 15:06 +0800, Yongji Xie wrote:
> When vfio passthrough a PCI device of which MMIO BARs
> are smaller than PAGE_SIZE, guest will not handle the
> mmio accesses to the BARs which leads to mmio emulations
> in host.
> 
> This is because vfio will not allow to passthrough one
> BAR's mmio page which may be shared with other BARs.
> 
> To solve this performance issue, this patch adds a kernel
> parameter "pci=resource_page_aligned=on" to enforce
> the alignment of all MMIO BARs to be at least PAGE_SIZE,
> so that one BAR's mmio page would not be shared with other
> BARs. We can also disable it through kernel parameter
> "pci=resource_page_aligned=off".
> 
> For the default value of the parameter, we think it should be
> arch-independent, so we add a macro
> HAVE_PCI_DEFAULT_RESOURCES_PAGE_ALIGNED to change it. And we
> define this macro to enable this parameter by default on PPC64
> platform which can easily hit this performance issue because
> its PAGE_SIZE is 64KB.
> 
> Note that the kernel parameter won't works if kernel doesn't do
> resources reallocation.

And where do you account for this so that we know whether it's really in
effect?

> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  Documentation/kernel-parameters.txt |    5 +++++
>  arch/powerpc/include/asm/pci.h      |   11 +++++++++++
>  drivers/pci/pci.c                   |   35 +++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h                   |    8 +++++++-
>  include/linux/pci.h                 |    4 ++++
>  5 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 742f69d..3f2a7c9 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2857,6 +2857,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  				PAGE_SIZE is used as alignment.
>  				PCI-PCI bridge can be specified, if resource
>  				windows need to be expanded.
> +		resource_page_aligned=	Enable/disable enforcing the alignment
> +				of all PCI devices' memory resources to be
> +				at least PAGE_SIZE if resources reallocation
> +				is done by kernel.
> +				Format: { "on" | "off" }
>  		ecrc=		Enable/disable PCIe ECRC (transaction layer
>  				end-to-end CRC checking).
>  				bios: Use BIOS/firmware settings. This is the
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
> index 3453bd8..2d2b3ef 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -136,6 +136,17 @@ extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
>  					 unsigned long pfn,
>  					 unsigned long size,
>  					 pgprot_t prot);
> +#ifdef CONFIG_PPC64
> +
> +/* For PPC64, We enforce all PCI MMIO BARs to be page aligned
> + * by default. This would be helpful to improve performance
> + * when we passthrough a PCI device of which BARs are smaller
> + * than PAGE_SIZE(64KB). And we can use kernel parameter
> + * "pci=resource_page_aligned=off" to disable it.
> + */
> +#define HAVE_PCI_DEFAULT_RESOURCES_PAGE_ALIGNED	1
> +
> +#endif
>  
>  #define HAVE_ARCH_PCI_RESOURCE_TO_USER
>  extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 314db8c..7b21238 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -99,6 +99,9 @@ u8 pci_cache_line_size;
>   */
>  unsigned int pcibios_max_latency = 255;
>  
> +bool pci_resources_page_aligned =
> +	IS_ENABLED(HAVE_PCI_DEFAULT_RESOURCES_PAGE_ALIGNED);

I don't think this is proper use of IS_ENABLED, which seems to be
targeted at CONFIG_ type options.  You could define this as that in an
arch Kconfig.

> +
>  /* If set, the PCIe ARI capability will not be used. */
>  static bool pcie_ari_disabled;
>  
> @@ -4746,6 +4749,35 @@ static ssize_t pci_resource_alignment_store(struct bus_type *bus,
>  BUS_ATTR(resource_alignment, 0644, pci_resource_alignment_show,
>  					pci_resource_alignment_store);
>  
> +static void pci_resources_get_page_aligned(char *str)
> +{
> +	if (!strncmp(str, "off", 3))
> +		pci_resources_page_aligned = false;
> +	else if (!strncmp(str, "on", 2))
> +		pci_resources_page_aligned = true;
> +}

"get"?

> +
> +/*
> + * This function checks whether PCI BARs' mmio page will be shared
> + * with other BARs.
> + */
> +bool pci_resources_share_page(struct pci_dev *dev, int resno)
> +{
> +	struct resource *res = dev->resource + resno;
> +
> +	if (resource_size(res) >= PAGE_SIZE)
> +		return false;
> +	if (pci_resources_page_aligned && !(res->start & ~PAGE_MASK) &&
> +	    res->flags & IORESOURCE_MEM) {
> +		if (res->sibling)
> +			return (res->sibling->start & ~PAGE_MASK);
> +		else
> +			return false;
> +	}
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(pci_resources_share_page);
> +
>  static int __init pci_resource_alignment_sysfs_init(void)
>  {
>  	return bus_create_file(&pci_bus_type,
> @@ -4859,6 +4891,9 @@ static int __init pci_setup(char *str)
>  			} else if (!strncmp(str, "resource_alignment=", 19)) {
>  				pci_set_resource_alignment_param(str + 19,
>  							strlen(str + 19));
> +			} else if (!strncmp(str, "resource_page_aligned=",
> +				   22)) {
> +				pci_resources_get_page_aligned(str + 22);

Doesn't this seem rather redundant with the option right above it,
resource_alignment=?  Why not modify that to support syntax where all
devices get the same alignment?


>  			} else if (!strncmp(str, "ecrc=", 5)) {
>  				pcie_ecrc_get_policy(str + 5);
>  			} else if (!strncmp(str, "hpiosize=", 9)) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index d390fc1..b9b333d 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -312,11 +312,17 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
>  #ifdef CONFIG_PCI_IOV
>  	int resno = res - dev->resource;
>  
> -	if (resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END)
> +	if (resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END) {
> +		if (pci_resources_page_aligned && res->flags & IORESOURCE_MEM)
> +			return PAGE_ALIGN(pci_sriov_resource_alignment(dev,
> +					  resno));
>  		return pci_sriov_resource_alignment(dev, resno);
> +	}
>  #endif
>  	if (dev->class >> 8  == PCI_CLASS_BRIDGE_CARDBUS)
>  		return pci_cardbus_resource_alignment(res);
> +	if (pci_resources_page_aligned && res->flags & IORESOURCE_MEM)
> +		return PAGE_ALIGN(resource_alignment(res));
>  	return resource_alignment(res);
>  }


Since we already have resource_alignment=, shouldn't we already have the
code in place to re-align?

>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6ae25aa..b640d65 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1530,6 +1530,10 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>  	 (pci_resource_end((dev), (bar)) -		\
>  	  pci_resource_start((dev), (bar)) + 1))
>  
> +extern bool pci_resources_page_aligned;
> +
> +bool pci_resources_share_page(struct pci_dev *dev, int resno);
> +
>  /* Similar to the helpers above, these manipulate per-pci_dev
>   * driver-specific data.  They are really just a wrapper around
>   * the generic device structure functions of these calls.

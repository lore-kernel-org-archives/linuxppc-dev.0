Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQH634h4PzDr7j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 03:30:35 +1100 (AEDT)
Date: Wed, 16 Mar 2016 10:30:22 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Subject: Re: [RFC PATCH v4 4/7] PCI: Modify resource_alignment to support
 multiple devices
Message-ID: <20160316103022.246edf22@t450s.home>
In-Reply-To: <1457336918-3893-5-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1457336918-3893-5-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon,  7 Mar 2016 15:48:35 +0800
Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:

> When vfio passthrough a PCI device of which MMIO BARs
> are smaller than PAGE_SIZE, guest will not handle the
> mmio accesses to the BARs which leads to mmio emulations
> in host.
> 
> This is because vfio will not allow to passthrough one
> BAR's mmio page which may be shared with other BARs.
> 
> To solve this performance issue, this patch modifies
> resource_alignment to support syntax where multiple
> devices get the same alignment. So we can use something
> like "pci=resource_alignment=*:*:*.*:noresize" to
> enforce the alignment of all MMIO BARs to be at least
> PAGE_SIZE so that one BAR's mmio page would not be
> shared with other BARs.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  Documentation/kernel-parameters.txt |    2 +
>  drivers/pci/pci.c                   |   90 ++++++++++++++++++++++++++++++-----
>  include/linux/pci.h                 |    4 ++
>  3 files changed, 85 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 8028631..74b38ab 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2918,6 +2918,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  				aligned memory resources.
>  				If <order of align> is not specified,
>  				PAGE_SIZE is used as alignment.
> +				<domain>, <bus>, <slot> and <func> can be set to
> +				"*" which means match all values.

I don't see anywhere that you're automatically enabling this for your
platform, so presumably you're expecting users to determine on their
own that they have a performance problem and hoping that they'll figure
out that they need to use this option to resolve it.  The first irate
question you'll get back is why doesn't this happen automatically?

>  				PCI-PCI bridge can be specified, if resource
>  				windows need to be expanded.
>  				noresize: Don't change the resources' sizes when
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 760cce5..44ab59f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -102,6 +102,8 @@ unsigned int pcibios_max_latency = 255;
>  /* If set, the PCIe ARI capability will not be used. */
>  static bool pcie_ari_disabled;
>  
> +bool pci_resources_page_aligned;
> +
>  /**
>   * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
>   * @bus: pointer to PCI bus structure to search
> @@ -4604,6 +4606,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  	int seg, bus, slot, func, align_order, count;
>  	resource_size_t align = 0;
>  	char *p;
> +	bool invalid = false;
>  
>  	spin_lock(&resource_alignment_lock);
>  	p = resource_alignment_param;
> @@ -4615,16 +4618,49 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  		} else {
>  			align_order = -1;
>  		}
> -		if (sscanf(p, "%x:%x:%x.%x%n",
> -			&seg, &bus, &slot, &func, &count) != 4) {
> +		if (p[0] == '*' && p[1] == ':') {
> +			seg = -1;
> +			count = 1;
> +		} else if (sscanf(p, "%x%n", &seg, &count) != 1 ||
> +				p[count] != ':') {
> +			invalid = true;
> +			break;
> +		}
> +		p += count + 1;
> +		if (*p == '*') {
> +			bus = -1;
> +			count = 1;
> +		} else if (sscanf(p, "%x%n", &bus, &count) != 1) {
> +			invalid = true;
> +			break;
> +		}
> +		p += count;
> +		if (*p == '.') {
> +			slot = bus;
> +			bus = seg;
>  			seg = 0;
> -			if (sscanf(p, "%x:%x.%x%n",
> -					&bus, &slot, &func, &count) != 3) {
> -				/* Invalid format */
> -				printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: %s\n",
> -					p);
> +			p++;
> +		} else if (*p == ':') {
> +			p++;
> +			if (p[0] == '*' && p[1] == '.') {
> +				slot = -1;
> +				count = 1;
> +			} else if (sscanf(p, "%x%n", &slot, &count) != 1 ||
> +					p[count] != '.') {
> +				invalid = true;
>  				break;
>  			}
> +			p += count + 1;
> +		} else {
> +			invalid = true;
> +			break;
> +		}
> +		if (*p == '*') {
> +			func = -1;
> +			count = 1;
> +		} else if (sscanf(p, "%x%n", &func, &count) != 1) {
> +			invalid = true;
> +			break;
>  		}
>  		p += count;
>  		if (!strncmp(p, ":noresize", 9)) {
> @@ -4632,23 +4668,34 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  			p += 9;
>  		} else
>  			*resize = true;
> -		if (seg == pci_domain_nr(dev->bus) &&
> -			bus == dev->bus->number &&
> -			slot == PCI_SLOT(dev->devfn) &&
> -			func == PCI_FUNC(dev->devfn)) {
> +		if ((seg == pci_domain_nr(dev->bus) || seg == -1) &&
> +			(bus == dev->bus->number || bus == -1) &&
> +			(slot == PCI_SLOT(dev->devfn) || slot == -1) &&
> +			(func == PCI_FUNC(dev->devfn) || func == -1)) {
>  			if (align_order == -1)
>  				align = PAGE_SIZE;
>  			else
>  				align = 1 << align_order;
> +			if (!pci_resources_page_aligned &&
> +				(align >= PAGE_SIZE &&
> +				seg == -1 && bus == -1 &&
> +				slot == -1 && func == -1))
> +				pci_resources_page_aligned = true;
>  			/* Found */
>  			break;
>  		}
>  		if (*p != ';' && *p != ',') {
>  			/* End of param or invalid format */
> +			invalid = true;
>  			break;
>  		}
>  		p++;
>  	}
> +	if (invalid == true) {
> +		/* Invalid format */
> +		printk(KERN_ERR "PCI: Can't parse resource_alignment parameter:%s\n",
> +				p);
> +	}
>  	spin_unlock(&resource_alignment_lock);
>  	return align;
>  }
> @@ -4769,6 +4816,27 @@ static int __init pci_resource_alignment_sysfs_init(void)
>  }
>  late_initcall(pci_resource_alignment_sysfs_init);
>  
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
> +		res->flags & IORESOURCE_MEM) {
> +		if (res->sibling)
> +			return (res->sibling->start & ~PAGE_MASK);
> +		else
> +			return false;
> +	}
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(pci_resources_share_page);

This should be a separate patch, there's no mention of this part of the
change at all in the commitlog.  Also, pci_resource_page_aligned is
only set if we use the magic wildcards to set alignment for all
devices, it's not set if we use a specific seg:bus:dev.fn.  That's
not consistent.  Can't we make use of the STARTALIGN flag for this or
did that get removed when resources were assigned?

The test itself is not entirely reassuring, I'd like some positive
indication that the device has been aligned, not simply that it should
have been and the start alignment appears that it might have happened.
Apparently you don't trust pci_resources_page_aligned either since you
still test the start alignment.

> +
>  static void pci_no_domains(void)
>  {
>  #ifdef CONFIG_PCI_DOMAINS
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2771625..064a1b6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1511,6 +1511,10 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>  	 (pci_resource_end((dev), (bar)) -		\
>  	  pci_resource_start((dev), (bar)) + 1))
>  
> +extern bool pci_resources_page_aligned;

I'm not seeing why this shouldn't have been static since you're
providing a function that tests it, there shouldn't really be any
external consumers.

> +
> +bool pci_resources_share_page(struct pci_dev *dev, int resno);
> +
>  /* Similar to the helpers above, these manipulate per-pci_dev
>   * driver-specific data.  They are really just a wrapper around
>   * the generic device structure functions of these calls.

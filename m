Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWWDK4Pz8zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 05:54:25 +1000 (AEST)
Date: Fri, 17 Jun 2016 14:54:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michal Simek <monstr@monstr.eu>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] powerpc/pci: Remove __pci_mmap_set_pgprot()
Message-ID: <20160617195419.GA2688@localhost>
References: <20160609181102.13455.33593.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160609182023.13455.82564.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160609182023.13455.82564.stgit@bhelgaas-glaptop2.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 09, 2016 at 01:20:23PM -0500, Bjorn Helgaas wrote:
> From: Yinghai Lu <yinghai@kernel.org>
> 
> The powerpc-specific __pci_mmap_set_pgprot() does two things:
> 
>   1) Disables write combining for I/O port space mappings
> 
>      This only affects procfs mappings.  The pci_mmap_resource() sysfs path
>      only requests write combining for resources with IORESOURCE_PREFETCH
>      set, which doesn't include I/O resources.
> 
>      The only way to request write combining for I/O port space mappings
>      was via the PCIIOC_WRITE_COMBINE ioctl and the proc_bus_pci_mmap()
>      path, and we recently changed that path to ignore write combining for
>      I/O, so this code in powerpc is no longer needed.
> 
>   2) Automatically enables write combining for mappings of prefetchable
>      resources, even if not requested by the user
> 
>      Both procfs (via PCIIOC_MMAP_IS_MEM and PCIIOC_WRITE_COMBINE ioctls)
>      and sysfs (via "resourceN_wc" files, which are created for resources
>      with IORESOURCE_PREFETCH) provide ways for the user to map PCI memory
>      space with write combining.
> 
>      Users that desire write combining should use one of those ways instead
>      of relying on powerpc-specific behavior.
> 
> Remove the powerpc-specific __pci_mmap_set_pgprot().
> 
> The user-visible effect of this change is that users mapping prefetchable
> PCI memory space via procfs without PCIIOC_WRITE_COMBINE or via sysfs
> "resourceN" (not "resourceN_wc") will get regular uncacheable mappings
> instead of the write combining mappings they used to get.
> 
> The new behavior matches the behavior on all other arches that support
> write combining mapping.

Powerpc folks, any thoughts on this?

It's currently on my pci/resource branch, and I plan to merge it for
v4.8 if there are no objections.

> [bhelgaas: changelog]
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/kernel/pci-common.c |   37 ++++---------------------------------
>  1 file changed, 4 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 0f7a60f..8c6beb0 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -356,36 +356,6 @@ static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
>  }
>  
>  /*
> - * Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
> - * device mapping.
> - */
> -static pgprot_t __pci_mmap_set_pgprot(struct pci_dev *dev, struct resource *rp,
> -				      pgprot_t protection,
> -				      enum pci_mmap_state mmap_state,
> -				      int write_combine)
> -{
> -
> -	/* Write combine is always 0 on non-memory space mappings. On
> -	 * memory space, if the user didn't pass 1, we check for a
> -	 * "prefetchable" resource. This is a bit hackish, but we use
> -	 * this to workaround the inability of /sysfs to provide a write
> -	 * combine bit
> -	 */
> -	if (mmap_state != pci_mmap_mem)
> -		write_combine = 0;
> -	else if (write_combine == 0) {
> -		if (rp->flags & IORESOURCE_PREFETCH)
> -			write_combine = 1;
> -	}
> -
> -	/* XXX would be nice to have a way to ask for write-through */
> -	if (write_combine)
> -		return pgprot_noncached_wc(protection);
> -	else
> -		return pgprot_noncached(protection);
> -}
> -
> -/*
>   * This one is used by /dev/mem and fbdev who have no clue about the
>   * PCI device, it tries to find the PCI device first and calls the
>   * above routine
> @@ -458,9 +428,10 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
>  		return -EINVAL;
>  
>  	vma->vm_pgoff = offset >> PAGE_SHIFT;
> -	vma->vm_page_prot = __pci_mmap_set_pgprot(dev, rp,
> -						  vma->vm_page_prot,
> -						  mmap_state, write_combine);
> +	if (write_combine)
> +		vma->vm_page_prot = pgprot_noncached_wc(vma->vm_page_prot);
> +	else
> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  
>  	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
>  			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

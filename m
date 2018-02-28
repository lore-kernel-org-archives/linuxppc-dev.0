Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsB6D651lzF1dZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 10:07:16 +1100 (AEDT)
Date: Wed, 28 Feb 2018 17:07:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use generic pci_mmap_resource_range()
Message-ID: <20180228230713.GP127842@bhelgaas-glaptop.roam.corp.google.com>
References: <1519045191-22145-1-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519045191-22145-1-git-send-email-dwmw@amazon.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 19, 2018 at 12:59:51PM +0000, David Woodhouse wrote:
> Commit f719582435 ("PCI: Add pci_mmap_resource_range() and use it for
> ARM64") added this generic function with the intent of using it
> everywhere and ultimately killing the old arch-specific implementations.
> 
> Let's get on with that eradication...
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Applied to pci/resource-mmap for v4.17, thanks!

Powerpc folks, let me know if you have applied this or would like to, and
I'll drop it.

> ---
>  arch/powerpc/include/asm/pci.h   |   9 ++--
>  arch/powerpc/kernel/pci-common.c | 106 ++++-----------------------------------
>  2 files changed, 15 insertions(+), 100 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
> index d82802f..401c62a 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -76,10 +76,11 @@ extern int pci_proc_domain(struct pci_bus *bus);
>  
>  struct vm_area_struct;
>  
> -/* Tell drivers/pci/proc.c that we have pci_mmap_page_range() and it does WC */
> -#define HAVE_PCI_MMAP		1
> -#define arch_can_pci_mmap_io()	1
> -#define arch_can_pci_mmap_wc()	1
> +/* Tell PCI code what kind of PCI resource mappings we support */
> +#define HAVE_PCI_MMAP			1
> +#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
> +#define arch_can_pci_mmap_io()		1
> +#define arch_can_pci_mmap_wc()		1
>  
>  extern int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val,
>  			   size_t count);
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 446c796..fe9733f 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -410,72 +410,22 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>  }
>  
>  /*
> - * Platform support for /proc/bus/pci/X/Y mmap()s,
> - * modelled on the sparc64 implementation by Dave Miller.
> + * Platform support for /proc/bus/pci/X/Y mmap()s.
>   *  -- paulus.
>   */
> -
> -/*
> - * Adjust vm_pgoff of VMA such that it is the physical page offset
> - * corresponding to the 32-bit pci bus offset for DEV requested by the user.
> - *
> - * Basically, the user finds the base address for his device which he wishes
> - * to mmap.  They read the 32-bit value from the config space base register,
> - * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
> - * offset parameter of mmap on /proc/bus/pci/XXX for that device.
> - *
> - * Returns negative error code on failure, zero on success.
> - */
> -static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
> -					       resource_size_t *offset,
> -					       enum pci_mmap_state mmap_state)
> +int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma)
>  {
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	unsigned long io_offset = 0;
> -	int i, res_bit;
> -
> -	if (hose == NULL)
> -		return NULL;		/* should never happen */
> -
> -	/* If memory, add on the PCI bridge address offset */
> -	if (mmap_state == pci_mmap_mem) {
> -#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
> -		*offset += hose->pci_mem_offset;
> -#endif
> -		res_bit = IORESOURCE_MEM;
> -	} else {
> -		io_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
> -		*offset += io_offset;
> -		res_bit = IORESOURCE_IO;
> -	}
> -
> -	/*
> -	 * Check that the offset requested corresponds to one of the
> -	 * resources of the device.
> -	 */
> -	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
> -		struct resource *rp = &dev->resource[i];
> -		int flags = rp->flags;
> +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> +	resource_size_t ioaddr = pci_resource_start(pdev, bar);
>  
> -		/* treat ROM as memory (should be already) */
> -		if (i == PCI_ROM_RESOURCE)
> -			flags |= IORESOURCE_MEM;
> -
> -		/* Active and same type? */
> -		if ((flags & res_bit) == 0)
> -			continue;
> -
> -		/* In the range of this resource? */
> -		if (*offset < (rp->start & PAGE_MASK) || *offset > rp->end)
> -			continue;
> +	if (!hose)
> +		return -EINVAL;
>  
> -		/* found it! construct the final physical address */
> -		if (mmap_state == pci_mmap_io)
> -			*offset += hose->io_base_phys - io_offset;
> -		return rp;
> -	}
> +	/* Convert to an offset within this PCI controller */
> +	ioaddr -= (unsigned long)hose->io_base_virt - _IO_BASE;
>  
> -	return NULL;
> +	vma->vm_pgoff += (ioaddr + hose->io_base_phys) >> PAGE_SHIFT;
> +	return 0;
>  }
>  
>  /*
> @@ -527,42 +477,6 @@ pgprot_t pci_phys_mem_access_prot(struct file *file,
>  	return prot;
>  }
>  
> -
> -/*
> - * Perform the actual remap of the pages for a PCI device mapping, as
> - * appropriate for this architecture.  The region in the process to map
> - * is described by vm_start and vm_end members of VMA, the base physical
> - * address is found in vm_pgoff.
> - * The pci device structure is provided so that architectures may make mapping
> - * decisions on a per-device or per-bus basis.
> - *
> - * Returns a negative error code on failure, zero on success.
> - */
> -int pci_mmap_page_range(struct pci_dev *dev, int bar,
> -			struct vm_area_struct *vma,
> -			enum pci_mmap_state mmap_state, int write_combine)
> -{
> -	resource_size_t offset =
> -		((resource_size_t)vma->vm_pgoff) << PAGE_SHIFT;
> -	struct resource *rp;
> -	int ret;
> -
> -	rp = __pci_mmap_make_offset(dev, &offset, mmap_state);
> -	if (rp == NULL)
> -		return -EINVAL;
> -
> -	vma->vm_pgoff = offset >> PAGE_SHIFT;
> -	if (write_combine)
> -		vma->vm_page_prot = pgprot_noncached_wc(vma->vm_page_prot);
> -	else
> -		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -
> -	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> -			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
> -
> -	return ret;
> -}
> -
>  /* This provides legacy IO read access on a bus */
>  int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val, size_t size)
>  {
> -- 
> 2.7.4
> 

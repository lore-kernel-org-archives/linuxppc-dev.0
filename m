Return-Path: <bhelgaas@google.com>
Received: from mail-qc0-f202.google.com (mail-qc0-f202.google.com
 [209.85.216.202])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 85BF12C01FD
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 10:47:19 +1000 (EST)
Received: by qcqs25 with SMTP id s25so640375qcq.3
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2012 17:47:16 -0700 (PDT)
Date: Mon, 16 Jul 2012 18:47:16 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/15] pci: resource assignment based on p2p alignment
Message-ID: <20120717004716.GC32203@google.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
 <1342452631-21152-5-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342452631-21152-5-git-send-email-shangw@linux.vnet.ibm.com>
Cc: yinghai@kernel.org, linux-pci@vger.kernel.org, linuxram@us.ibm.com,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 16, 2012 at 11:30:28PM +0800, Gavin Shan wrote:
> The patch changes function pbus_size_io() and pbus_size_mem() to
> do resource (I/O, memory and prefetchable memory) reassignment
> based on the minimal alignments for the p2p bridge, which was
> retrieved by function pcibios_window_alignment().
> 
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/pci/setup-bus.c |   22 +++++++++++++++-------
>  1 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 8fa2d4b..6ccf31a 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -710,6 +710,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
>  	unsigned long size = 0, size0 = 0, size1 = 0;
>  	resource_size_t children_add_size = 0;
> +	resource_size_t io_align;
>  
>  	if (!b_res)
>   		return;
> @@ -735,13 +736,15 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  				children_add_size += get_res_add_size(realloc_head, r);
>  		}
>  	}
> +
> +	io_align = pcibios_window_alignment(bus, IORESOURCE_IO);
>  	size0 = calculate_iosize(size, min_size, size1,
> -			resource_size(b_res), 4096);
> +			resource_size(b_res), io_align);
>  	if (children_add_size > add_size)
>  		add_size = children_add_size;
>  	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
>  		calculate_iosize(size, min_size, add_size + size1,
> -			resource_size(b_res), 4096);
> +			resource_size(b_res), io_align);
>  	if (!size0 && !size1) {
>  		if (b_res->start || b_res->end)
>  			dev_info(&bus->self->dev, "disabling bridge window "
> @@ -751,11 +754,11 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  		return;
>  	}
>  	/* Alignment of the IO window is always 4K */
> -	b_res->start = 4096;
> +	b_res->start = io_align;
>  	b_res->end = b_res->start + size0 - 1;
>  	b_res->flags |= IORESOURCE_STARTALIGN;
>  	if (size1 > size0 && realloc_head) {
> -		add_to_list(realloc_head, bus->self, b_res, size1-size0, 4096);
> +		add_to_list(realloc_head, bus->self, b_res, size1-size0, io_align);
>  		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "
>  				 "%pR to [bus %02x-%02x] add_size %lx\n", b_res,
>  				 bus->secondary, bus->subordinate, size1-size0);
> @@ -785,10 +788,15 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  	struct resource *b_res = find_free_bus_resource(bus, type);
>  	unsigned int mem64_mask = 0;
>  	resource_size_t children_add_size = 0;
> +	resource_size_t mem_align;
> +	int mem_align_shift;
>  
>  	if (!b_res)
>  		return 0;
>  
> +	mem_align = pcibios_window_alignment(bus, type);
> +	mem_align_shift = __ffs(mem_align);
> +
>  	memset(aligns, 0, sizeof(aligns));
>  	max_order = 0;
>  	size = 0;
> @@ -818,8 +826,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  #endif
>  			/* For bridges size != alignment */
>  			align = pci_resource_alignment(dev, r);
> -			order = __ffs(align) - 20;
> -			if (order > 11) {
> +			order = __ffs(align) - mem_align_shift;
> +			if (order > (11 - (mem_align_shift - 20))) {

This doesn't seem right to me.  Aren't we accumulating the amount of
space required at each alignment in aligns[]?  That should be independent
of whatever arch-specific minimum alignment we have.

Does it have to be more complicated than something like this at the
very end?

    min_align = max(min_align, pci_window_alignment(bus, IORESOURCE_MEM));

>  				dev_warn(&dev->dev, "disabling BAR %d: %pR "
>  					 "(bad alignment %#llx)\n", i, r,
>  					 (unsigned long long) align);
> @@ -846,7 +854,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  	for (order = 0; order <= max_order; order++) {
>  		resource_size_t align1 = 1;
>  
> -		align1 <<= (order + 20);
> +		align1 <<= (order + mem_align_shift);
>  
>  		if (!align)
>  			min_align = align1;
> -- 
> 1.7.5.4
> 

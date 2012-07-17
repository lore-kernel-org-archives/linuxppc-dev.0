Return-Path: <linuxram@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 30F392C0161
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 15:06:59 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 16 Jul 2012 23:06:54 -0600
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4E6A5C9005E
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 01:06:02 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6H55qXR44630206
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 01:05:53 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6HAaiIG003163
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 06:36:45 -0400
Date: Tue, 17 Jul 2012 13:05:47 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/15] pci: resource assignment based on p2p alignment
Message-ID: <20120717050547.GD2369@ram-ThinkPad-T61>
References: <1342491799-30303-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1342491799-30303-6-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342491799-30303-6-git-send-email-shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxram@us.ibm.com, linuxppc-dev@ozlabs.org,
 bhelgaas@google.com, yinghai@kernel.org
Reply-To: Ram Pai <linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2012 at 10:23:17AM +0800, Gavin Shan wrote:
> The patch changes function pbus_size_io() and pbus_size_mem() to
> do resource (I/O, memory and prefetchable memory) reassignment
> based on the minimal alignments for the p2p bridge, which was
> retrieved by function window_alignment().
> 
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/pci/setup-bus.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index c0fb9da..a29483a 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -731,6 +731,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
>  	unsigned long size = 0, size0 = 0, size1 = 0;
>  	resource_size_t children_add_size = 0;
> +	resource_size_t io_align;
> 
>  	if (!b_res)
>   		return;
> @@ -756,13 +757,15 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  				children_add_size += get_res_add_size(realloc_head, r);
>  		}
>  	}
> +
> +	io_align = window_alignment(bus, IORESOURCE_IO);

this should also be
	io_align = max(4096, window_alignment(bus, IORESOURCE_IO));

right?


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
> @@ -772,11 +775,11 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
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
> @@ -875,6 +878,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  			min_align = align1 >> 1;
>  		align += aligns[order];
>  	}
> +
> +	min_align = max(min_align, window_alignment(bus, type));

  'type' can sometimes be (IORESOURCE_MEM | IORESOURCE_PREFETCH), which
  can lead to unpredictable results depending on how window_alignment()
  is implemented... Hence to be on the safer side I suggest

	min_align = max(min_align, window_alignment(bus, b_res->flags & mask));

  

RP

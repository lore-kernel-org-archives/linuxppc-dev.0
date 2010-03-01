Return-Path: <stern+4b9b024c@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id AA43CB7D23
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Mar 2010 01:49:50 +1100 (EST)
Date: Mon, 1 Mar 2010 09:49:48 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [RFC PATCH v2 8/9] USB: add HCD_NO_COHERENT_MEM host controller
	driver flag
In-Reply-To: <1267366082-15248-9-git-send-email-albert_herranz@yahoo.es>
Message-ID: <Pine.LNX.4.44L0.1003010943480.1645-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 28 Feb 2010, Albert Herranz wrote:

> The HCD_NO_COHERENT_MEM USB host controller driver flag can be enabled
> to instruct the USB stack to avoid allocating coherent memory for USB
> buffers.
> 
> This flag is useful to overcome some esoteric memory access restrictions
> found in some platforms.
> For example, the Nintendo Wii video game console is a NOT_COHERENT_CACHE
> platform that is unable to safely perform non-32 bit uncached writes
> to RAM because the byte enables are not connected to the bus.
> Thus, in that platform, "coherent" DMA buffers cannot be directly used
> by the kernel code unless it guarantees that all write accesses
> to said buffers are done in 32 bit chunks (which is not the case in the
> USB subsystem).
> 
> To avoid this unwanted behaviour HCD_NO_COHERENT_MEM can be enabled at
> the HCD controller, causing USB buffer allocations to be satisfied from
> normal kernel memory. In this case, the USB stack will make sure that
> the buffers get properly mapped/unmapped for DMA transfers using the DMA
> streaming mapping API.
> 
> Note that other parts of the USB stack may also use coherent memory,
> like for example the hardware descriptors used in the EHCI controllers.
> This needs to be checked and addressed separately. In the EHCI example,
> hardware descriptors are accessed in 32-bit (or 64-bit) chunks, causing
> no problems in the described scenario.

> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1260,6 +1260,34 @@ static void hcd_free_coherent(struct usb_bus *bus, dma_addr_t *dma_handle,
>  	*dma_handle = 0;
>  }
>  
> +static int urb_needs_setup_dma_map(struct usb_hcd *hcd, struct urb *urb)
> +{
> +	return !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP) ||
> +	       ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
> +		urb->setup_dma == ~(dma_addr_t)0);
> +}
> +
> +static int urb_needs_setup_dma_unmap(struct usb_hcd *hcd, struct urb *urb)
> +{
> +	return !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP) ||
> +	       ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
> +		urb->setup_dma && urb->setup_dma != ~(dma_addr_t)0);
> +}
> +
> +static int urb_needs_transfer_dma_map(struct usb_hcd *hcd, struct urb *urb)
> +{
> +	return !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP) ||
> +	       ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
> +		urb->transfer_dma == ~(dma_addr_t)0);
> +}
> +
> +static int urb_needs_transfer_dma_unmap(struct usb_hcd *hcd, struct urb *urb)
> +{
> +	return !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP) ||
> +	       ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
> +		urb->transfer_dma && urb->transfer_dma != ~(dma_addr_t)0);
> +}
> +

These functions would be a lot easier to understand if they were 
expanded into multiple test and return statements, rather than 
squeezing all the Boolean manipulations into single expressions.  (Not 
to mention the fact that other developement is going to make them even 
more complicated than they are now...)

Also, I can't help thinking that the corresponding *_map() and 
*_unmap() routines are so similar, it ought to be possible to combine 
them.  The only difference is a check for a NULL DMA address, and it's 
not clear to me why it is present.  It's also not clear why the test 
for a DMA address of all ones is present.  Maybe they both can be 
removed.

Alan Stern

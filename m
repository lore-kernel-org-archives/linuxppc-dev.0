Return-Path: <stern+4b6f04d4@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id AF7BFB7D3B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Feb 2010 06:46:53 +1100 (EST)
Date: Wed, 3 Feb 2010 14:40:11 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [RFC PATCH 1/2] USB: add HCD_BOUNCE_BUFFERS host controller
	driver flag
In-Reply-To: <1265221840-25634-2-git-send-email-albert_herranz@yahoo.es>
Message-ID: <Pine.LNX.4.44L0.1002031429430.1321-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: USB list <linux-usb@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 3 Feb 2010, Albert Herranz wrote:

> The HCD_BOUNCE_BUFFERS USB host controller driver flag can be enabled
> to instruct the USB stack to always bounce USB buffers to/from coherent
> memory buffers _just_ before/after a host controller transmission.
> 
> This setting allows overcoming some platform-specific limitations.
> 
> For example, the Nintendo Wii video game console is a NOT_COHERENT_CACHE
> platform that is unable to safely perform non-32 bit uncached writes
> to RAM because the byte enables are not connected to the bus.
> Thus, in that platform, "coherent" DMA buffers cannot be directly used
> by the kernel code unless it guarantees that all write accesses
> to said buffers are done in 32 bit chunks (which is not the case in the
> USB subsystem).
> 
> To avoid this unwanted behaviour HCD_BOUNCE_BUFFERS can be enabled at
> the HCD controller, causing buffer allocations to be satisfied from
> normal memory and, only at the very last moment, before the actual
> transfer, buffers get copied to/from their corresponding DMA coherent
> bounce buffers.
> 
> Note that HCD_LOCAL_MEM doesn't help in solving this problem as in that
> case buffers may be allocated from coherent memory in the first place
> and thus potentially accessed in non-32 bit chuncks by USB drivers.

This description sounds hopelessly confused.  Maybe you're just
misusing the term "coherent".  The patch itself doesn't affect the
coherent DMA mappings anyway; it affects the streaming mappings.  Or to
put it another way, what's the justification for replacing a call to
dma_map_single() with a call to dma_alloc_coherent()?

Since the patch doesn't affect any of the coherent mappings (see for 
example the calls to dma_pool_create() in ehci-mem.c), I don't see how 
it can possibly do what you claim.

> +/**
> + * hcd_memcpy32_to_coherent - copy data to a bounce buffer
> + * @dst: destination dma bounce buffer
> + * @src: source buffer
> + * @len: number of bytes to copy
> + *
> + * This function copies @len bytes from @src to @dst in 32 bit chunks.
> + * The caller must guarantee that @dst length is 4 byte aligned and
> + * that @dst length is greater than or equal to @src length.
> + */
> +static void *hcd_memcpy32_to_coherent(void *dst, const void *src, size_t len)
> +{
> +	u32 *q = dst, *p = (void *)src;
> +	u8 *s;
> +
> +	while (len >= 4) {
> +		*q++ = *p++;
> +		len -= 4;
> +	}
> +	s = (u8 *)p;
> +	switch (len) {
> +	case 3:
> +		*q = s[0] << 24 | s[1] << 16 | s[2] << 8;
> +		break;
> +	case 2:
> +		*q = s[0] << 24 | s[1] << 16;
> +		break;
> +	case 1:
> +		*q = s[0] << 24;
> +		break;
> +	default:
> +		break;
> +	}
> +	return dst;
> +}

What happens if somebody tries to use this code on a little-endian CPU?

>  static int map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>  			   gfp_t mem_flags)
>  {
> @@ -1274,53 +1441,80 @@ static int map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>  	if (is_root_hub(urb->dev))
>  		return 0;
>  
> -	if (usb_endpoint_xfer_control(&urb->ep->desc)
> -	    && !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP)) {
> -		if (hcd->self.uses_dma) {
> -			urb->setup_dma = dma_map_single(
> -					hcd->self.controller,
> -					urb->setup_packet,
> -					sizeof(struct usb_ctrlrequest),
> -					DMA_TO_DEVICE);
> -			if (dma_mapping_error(hcd->self.controller,
> -						urb->setup_dma))
> -				return -EAGAIN;
> -		} else if (hcd->driver->flags & HCD_LOCAL_MEM)
> -			ret = hcd_alloc_coherent(
> -					urb->dev->bus, mem_flags,
> +	if (usb_endpoint_xfer_control(&urb->ep->desc)) {
> +		if (hcd->driver->flags & HCD_BOUNCE_BUFFERS) {
> +			if (!(urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
> +				urb->setup_dma = 0;
> +			ret = hcd_bounce_to_coherent(
> +					hcd->self.controller, mem_flags,
>  					&urb->setup_dma,
>  					(void **)&urb->setup_packet,
>  					sizeof(struct usb_ctrlrequest),
>  					DMA_TO_DEVICE);
> +		} else if (!(urb->transfer_flags & URB_NO_SETUP_DMA_MAP)) {
> +			if (hcd->self.uses_dma) {
> +				urb->setup_dma = dma_map_single(
> +						hcd->self.controller,
> +						urb->setup_packet,
> +						sizeof(struct usb_ctrlrequest),
> +						DMA_TO_DEVICE);
> +				if (dma_mapping_error(hcd->self.controller,
> +						      urb->setup_dma))
> +					return -EAGAIN;
> +			} else if (hcd->driver->flags & HCD_LOCAL_MEM)
> +				ret = hcd_alloc_coherent(
> +						urb->dev->bus, mem_flags,
> +						&urb->setup_dma,
> +						(void **)&urb->setup_packet,
> +						sizeof(struct usb_ctrlrequest),
> +						DMA_TO_DEVICE);
> +		}
>  	}
>  
>  	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
> -	if (ret == 0 && urb->transfer_buffer_length != 0
> -	    && !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)) {
> -		if (hcd->self.uses_dma) {
> -			urb->transfer_dma = dma_map_single (
> -					hcd->self.controller,
> -					urb->transfer_buffer,
> -					urb->transfer_buffer_length,
> -					dir);
> -			if (dma_mapping_error(hcd->self.controller,
> -						urb->transfer_dma))
> -				return -EAGAIN;
> -		} else if (hcd->driver->flags & HCD_LOCAL_MEM) {
> -			ret = hcd_alloc_coherent(
> -					urb->dev->bus, mem_flags,
> +	if (ret == 0 && urb->transfer_buffer_length != 0) {
> +		if (hcd->driver->flags & HCD_BOUNCE_BUFFERS) {
> +			if (!(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP))
> +				urb->transfer_dma = 0;
> +			ret = hcd_bounce_to_coherent(
> +					hcd->self.controller, mem_flags,
>  					&urb->transfer_dma,
>  					&urb->transfer_buffer,
>  					urb->transfer_buffer_length,
>  					dir);
>  
> -			if (ret && usb_endpoint_xfer_control(&urb->ep->desc)
> -			    && !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
> -				hcd_free_coherent(urb->dev->bus,
> -					&urb->setup_dma,
> -					(void **)&urb->setup_packet,
> -					sizeof(struct usb_ctrlrequest),
> -					DMA_TO_DEVICE);
> +			if (ret && usb_endpoint_xfer_control(&urb->ep->desc))
> +				hcd_bounce_from_coherent(hcd->self.controller,
> +						&urb->setup_dma,
> +						(void **)&urb->setup_packet,
> +						sizeof(struct usb_ctrlrequest),
> +						DMA_TO_DEVICE);
> +		} else if (!(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)) {
> +			if (hcd->self.uses_dma) {
> +				urb->transfer_dma = dma_map_single(
> +						hcd->self.controller,
> +						urb->transfer_buffer,
> +						urb->transfer_buffer_length,
> +						dir);
> +				if (dma_mapping_error(hcd->self.controller,
> +						      urb->transfer_dma))
> +					return -EAGAIN;
> +			} else if (hcd->driver->flags & HCD_LOCAL_MEM) {
> +				ret = hcd_alloc_coherent(
> +						urb->dev->bus, mem_flags,
> +						&urb->transfer_dma,
> +						&urb->transfer_buffer,
> +						urb->transfer_buffer_length,
> +						dir);
> +
> +				if (ret &&
> +				    usb_endpoint_xfer_control(&urb->ep->desc))
> +					hcd_free_coherent(urb->dev->bus,
> +						&urb->setup_dma,
> +						(void **)&urb->setup_packet,
> +						sizeof(struct usb_ctrlrequest),
> +						DMA_TO_DEVICE);
> +			}
>  		}
>  	}
>  	return ret;

It seems that every time somebody comes up with a new kind of 
memory-access restriction, this function grows by a factor of 2.  After 
a few more iterations it will be larger than the rest of the kernel!

There must be a better way to structure the requirements here.

Alan Stern

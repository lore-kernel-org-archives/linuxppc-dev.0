Return-Path: <albert_herranz@yahoo.es>
Received: from smtp140.mail.ukl.yahoo.com (smtp140.mail.ukl.yahoo.com
	[77.238.184.71]) by ozlabs.org (Postfix) with SMTP id 65DCFB7D16
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Mar 2010 05:38:26 +1100 (EST)
Message-ID: <4B8C099B.30504@yahoo.es>
Date: Mon, 01 Mar 2010 19:38:19 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH v2 8/9] USB: add HCD_NO_COHERENT_MEM host controller
	driver flag
References: <Pine.LNX.4.44L0.1003010943480.1645-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1003010943480.1645-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1
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

Alan Stern wrote:
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
>> @@ -1260,6 +1260,34 @@ static void hcd_free_coherent(struct usb_bus *bus, dma_addr_t *dma_handle,
>>  	*dma_handle = 0;
>>  }
>>  
>> +static int urb_needs_setup_dma_map(struct usb_hcd *hcd, struct urb *urb)
>> +{
>> +	return !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP) ||
>> +	       ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
>> +		urb->setup_dma == ~(dma_addr_t)0);
>> +}
>> +
>> +static int urb_needs_setup_dma_unmap(struct usb_hcd *hcd, struct urb *urb)
>> +{
>> +	return !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP) ||
>> +	       ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
>> +		urb->setup_dma && urb->setup_dma != ~(dma_addr_t)0);
>> +}
>> +
>> +static int urb_needs_transfer_dma_map(struct usb_hcd *hcd, struct urb *urb)
>> +{
>> +	return !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP) ||
>> +	       ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
>> +		urb->transfer_dma == ~(dma_addr_t)0);
>> +}
>> +
>> +static int urb_needs_transfer_dma_unmap(struct usb_hcd *hcd, struct urb *urb)
>> +{
>> +	return !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP) ||
>> +	       ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
>> +		urb->transfer_dma && urb->transfer_dma != ~(dma_addr_t)0);
>> +}
>> +
> 
> These functions would be a lot easier to understand if they were 
> expanded into multiple test and return statements, rather than 
> squeezing all the Boolean manipulations into single expressions.  (Not 
> to mention the fact that other developement is going to make them even 
> more complicated than they are now...)
> 

Yes, agreed. I'll enhance that, thanks.

> Also, I can't help thinking that the corresponding *_map() and 
> *_unmap() routines are so similar, it ought to be possible to combine 
> them.  The only difference is a check for a NULL DMA address, and it's 
> not clear to me why it is present.  It's also not clear why the test 
> for a DMA address of all ones is present.  Maybe they both can be 
> removed.
> 

I think too that I can simplify that logic.
I added those checks in a defensive way seeking robustness while I familiarize with the USB stack innards. So far, those cases are just avoiding mappings when urb_needs_transfer_dma_map()/urb_needs_transfer_dma_unmap() are called with urb->transfer_buffer == 0 and urb->transfer_dma == 0.

I guess that those cases are related to scatterlist-based urb requests.
What should be the correct way to check if a urb has already been scatter/gather-mapped?

The final logic would be something like:
- map if URB_NO_TRANSFER_DMA_MAP is cleared
- otherwise (URB_TRANSFER_NO_DMA_MAP is set so) map if HCD_NO_COHERENT_MEM is set _and_ it's not a scatter/gather request (as that should have been mapped already by usb_buffer_map_sg())

Am I on the right path?

> Alan Stern
> 

Thanks,
Albert

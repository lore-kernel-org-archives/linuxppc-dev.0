Return-Path: <albert_herranz@yahoo.es>
Received: from smtp131.mail.ukl.yahoo.com (smtp131.mail.ukl.yahoo.com
	[77.238.184.62]) by ozlabs.org (Postfix) with SMTP id 07480B7DA0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Mar 2010 09:55:29 +1100 (EST)
Message-ID: <4B8C45DF.50607@yahoo.es>
Date: Mon, 01 Mar 2010 23:55:27 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH v2 8/9] USB: add HCD_NO_COHERENT_MEM host controller
	driver flag
References: <Pine.LNX.4.44L0.1003011528240.1341-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1003011528240.1341-100000@iolanthe.rowland.org>
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
> On Mon, 1 Mar 2010, Albert Herranz wrote:
> 
>>>> Am I on the right path?
>>> More or less.  I would do it somewhat differently:
>>>
>>> 	If URB_NO_TRANSFER_DMA_MAP is set then no map is needed.
>>> 	Otherwise if num_sgs > 0 then no map is needed.
>>> 	Otherwise if HCD_NO_COHERENT_MEM is set then use
>>> 		hcd_alloc_coherent().
>>> 	Otherwise if transfer_buffer_length > 0 then use
>>> 		dma_map_single().
>>>
>> I think that logic is not quite right.
>> Remember that the final goal is to avoid allocating USB buffers from coherent memory (because the USB drivers access USB buffers without access restrictions but the platform I'm working on can't write to coherent memory unless it is done in 32-bit chunks).
> 
> Actually the final goal is to make the mapping/unmapping algorithms 
> clear and correct.  One of the subgoals involves avoiding coherent USB 
> buffers, but there are others as well (if you look back the through the 
> linux-usb mailing list for the last few weeks you'll see a discussion 
> about a controller which has to use PIO for control transfers but can 
> use DMA for other types).
> 

Well, I was talking about our particular case here. I did not imply that we should forget about the other cases.

>> And we want to avoid bouncing at the USB layer too (that's what v1 did).
>>
>> The strategy so far is:
>> - we have modified the USB buffer allocation routines hcd_buffer_alloc()/hcd_buffer_free() to always return normal kernel memory when HCD_NO_COHERENT_MEM is set on the host controller.
>> - during map_urb_for_dma()/unmap_urb_for_dma() we need to make sure that those USB buffers are sync'ed, even if we are told USB_NO_{SETUP,TRANSFER}_DMA_MAP
>>
>> So the logic would be:
>>
>>  	If URB_NO_TRANSFER_DMA_MAP is _cleared_ then do the mapping
> 
> No, that's wrong because it ignores the HCD_LOCAL_MEM flag.
> 

When I said "do the mapping" there I meant to do a dma_map_single() if self.uses_dma, else if HCD_LOCAL_MEM is set then do a hcd_alloc_coherent().
I should have been more clear on that.

>> 	- this case covers normal kernel memory used as a buffer and not already DMA mapped by a USB driver
>>
>>  	Otherwise if HCD_NO_COHERENT_MEM is set _and_ num_sgs == 0 _and_ transfer_buffer_length > 0 then do the mapping too
>> 	- this case covers USB buffers allocated via usb_buffer_alloc() and marked URB_NO_TRANSFER_DMA_MAP by a USB driver, which are allocated from normal kernel memory when HCD_NO_COHERENT_MEM is set (we avoid bouncing buffers here too, at least if they sit already within MEM2 in the Wii, but anyway that's part of the platform DMA mapping code)
>>
>> 	s-g urbs do not need a mapping as they have already been mapped, marked URB_NO_TRANSFER_DMA_MAP and have num_sgs > 0
> 
> Actually the test for transfer_buffer_length == 0 should be done first, 
> since obviously no mapping is needed if there's no data.  (And in fact 
> the current code does do this; I was wrong earlier when I said it 
> doesn't.)
> 
> So let's make things a little easier by first testing the conditions 
> under which no mapping is needed:
> 
> 	If transfer_buffer_length is 0 then do nothing.
> 	Otherwise if num_sgs > 0 then do nothing.
> 	Otherwise if URB_NO_TRANSFER_DMA_MAP and transfer_dma
> 		are both set (this avoids your HCD_NO_COHERENT_MEM
> 		case) then do nothing.
> 

I see. This case would include the PIO case too (for which dma_handle is set to all 1s).

So this assumes that transfer_dma should be set initially to 0 when allocating USB buffers for HCD_NO_COHERENT_MEM.

> The remaining cases all need mapping and/or bounce buffers:
> 
> 	Otherwise if HCD_LOCAL_MEM is set then call hcd_alloc_coherent.
> 	Otherwise call dma_map_single.
> 
> Finally, the unmapping tests can be simplified greatly if the kind of
> mapping is recorded in the URB flags.
> 

Good point.

> Alan Stern
> 

Thanks for your comments,
Albert

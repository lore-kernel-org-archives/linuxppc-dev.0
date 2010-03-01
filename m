Return-Path: <albert_herranz@yahoo.es>
Received: from smtp146.mail.ukl.yahoo.com (smtp146.mail.ukl.yahoo.com
	[77.238.184.77]) by ozlabs.org (Postfix) with SMTP id F2C35B7E88
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Mar 2010 07:11:32 +1100 (EST)
Message-ID: <4B8C1F72.3080902@yahoo.es>
Date: Mon, 01 Mar 2010 21:11:30 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH v2 8/9] USB: add HCD_NO_COHERENT_MEM host controller
	driver flag
References: <Pine.LNX.4.44L0.1003011356040.1341-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1003011356040.1341-100000@iolanthe.rowland.org>
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
> If urb->num_sgs > 0 then urb has been s-g mapped.  Although we don't
> currently check for it, quite a few URBs have transfer_buffer_length ==
> 0 (a number of control requests are like this, for example) so they
> don't need a mapping either.
> 

Ok, I'll use urb->num_sgs > 0 to check for s-g mapped requests.

>> The final logic would be something like:
>> - map if URB_NO_TRANSFER_DMA_MAP is cleared
>> - otherwise (URB_TRANSFER_NO_DMA_MAP is set so) map if
>> HCD_NO_COHERENT_MEM is set _and_ it's not a scatter/gather request
>> (as that should have been mapped already by usb_buffer_map_sg())
>>
>> Am I on the right path?
> 
> More or less.  I would do it somewhat differently:
> 
> 	If URB_NO_TRANSFER_DMA_MAP is set then no map is needed.
> 	Otherwise if num_sgs > 0 then no map is needed.
> 	Otherwise if HCD_NO_COHERENT_MEM is set then use
> 		hcd_alloc_coherent().
> 	Otherwise if transfer_buffer_length > 0 then use
> 		dma_map_single().
> 

I think that logic is not quite right.
Remember that the final goal is to avoid allocating USB buffers from coherent memory (because the USB drivers access USB buffers without access restrictions but the platform I'm working on can't write to coherent memory unless it is done in 32-bit chunks).
And we want to avoid bouncing at the USB layer too (that's what v1 did).

The strategy so far is:
- we have modified the USB buffer allocation routines hcd_buffer_alloc()/hcd_buffer_free() to always return normal kernel memory when HCD_NO_COHERENT_MEM is set on the host controller.
- during map_urb_for_dma()/unmap_urb_for_dma() we need to make sure that those USB buffers are sync'ed, even if we are told USB_NO_{SETUP,TRANSFER}_DMA_MAP

So the logic would be:

 	If URB_NO_TRANSFER_DMA_MAP is _cleared_ then do the mapping
	- this case covers normal kernel memory used as a buffer and not already DMA mapped by a USB driver

 	Otherwise if HCD_NO_COHERENT_MEM is set _and_ num_sgs == 0 _and_ transfer_buffer_length > 0 then do the mapping too
	- this case covers USB buffers allocated via usb_buffer_alloc() and marked URB_NO_TRANSFER_DMA_MAP by a USB driver, which are allocated from normal kernel memory when HCD_NO_COHERENT_MEM is set (we avoid bouncing buffers here too, at least if they sit already within MEM2 in the Wii, but anyway that's part of the platform DMA mapping code)

	s-g urbs do not need a mapping as they have already been mapped, marked URB_NO_TRANSFER_DMA_MAP and have num_sgs > 0
	
> Similar logic is needed for the setup buffer mapping, but you can 
> assume that control URBs never use scatter-gather so there's no need to 
> check num_sgs (and there's no need to check the transfer length, since 
> setup packets are always 8 bytes long).
> 
> In fact, I think URB_NO_SETUP_DMA_MAP doesn't really offer any
> worthwhile advantages.  (About the only place where multiple control
> requests are used in rapid succession is during firmware transfers, and
> those aren't time-constrained.)  It is currently used in a few
> drivers, but we ought to be able to remove it without too much effort.  
> That might make a good project.
> 

I'll leave that projects to others or, in any case, address it later :)

> Alan Stern
> 

Thanks,
Albert

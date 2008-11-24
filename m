Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D326BDDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 07:51:07 +1100 (EST)
In-Reply-To: <492B0B96.5050009@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Async DMA question regarding dma_async_memcpy_buf_to_buf
MIME-Version: 1.0
Message-ID: <OFD9E09DDF.B1C0E27A-ON8825750B.00700150-8825750B.00726C59@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Mon, 24 Nov 2008 12:49:58 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> What exactly do you mean by "the device"?  if it's the DMA engine, then 
> that's a meaningless request, by the definition of "source" and 
> "destination".  If you mean some other device that happens to be 
> providing a buffer for you to DMA into or out of, that's irrelevant to 
> the DMA API; it's just memory that happens to live somewhere else (and 
> possibly not be cached).
> 

Hummm, let me try again, I may be tripping up on my ignorance of the 
kernel.  According to Linux Device Drivers 3, the DMA_TO/FROM_DEVICE 
macros impact when the dma_map/unmap_single functions copy data and do 
cache flushes to ensure cache coherency.  DMA_TO_DEVICE tells 
dma_map_single() to ensure that all data is copied out to memory and cache 
is flushed before doing the transfer and DMA_FROM_DEVICE tell 
dma_unmap_single() to ensure all data is in main memory after the 
transfer.  (My understanding is that this is really only important on 
archs that use bounce buffers which I'm not).

So, no as far as "the device" (and I do mean the DMA engine) is concerned, 
the "mapping" of the src and dest pointers make zero difference, the 
hardware doesn't care since it's just acting on raw addresses.  However, 
it does (or at least I think it does) matter to the kernel and making sure 
that the cache doesn't get screwed up.  That all being said, I may be 
worried about nothing.  I don't know enough about any of this to be sure. 
I do know that in the past I've spent weeks trying to track down problems 
that were caused by cache coherency, and LDD3 is clearly warning about 
cache problems if these macros aren't used correctly.  But it sounds like 
you're saying those macros are unimportant.  The async DMA stuff is new 
since LDD3, so do those macros not apply?  Can 
dma_async_memcpy_buf_to_buf() _safely_ be used to DMA either direction 
(CPU <=> peripheral) _without_ cache coherency problems?

Thanks for the help.

Bruce

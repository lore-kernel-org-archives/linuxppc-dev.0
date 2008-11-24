Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 79265DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 08:00:56 +1100 (EST)
Message-ID: <492B1602.7010102@freescale.com>
Date: Mon, 24 Nov 2008 15:00:50 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Async DMA question regarding dma_async_memcpy_buf_to_buf
References: <OFD9E09DDF.B1C0E27A-ON8825750B.00700150-8825750B.00726C59@selinc.com>
In-Reply-To: <OFD9E09DDF.B1C0E27A-ON8825750B.00700150-8825750B.00726C59@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Bruce_Leonard@selinc.com wrote:
> Hummm, let me try again, I may be tripping up on my ignorance of the 
> kernel.  According to Linux Device Drivers 3, the DMA_TO/FROM_DEVICE 
> macros impact when the dma_map/unmap_single functions copy data and do 
> cache flushes to ensure cache coherency.  DMA_TO_DEVICE tells 
> dma_map_single() to ensure that all data is copied out to memory and cache 
> is flushed before doing the transfer and DMA_FROM_DEVICE tell 
> dma_unmap_single() to ensure all data is in main memory after the 
> transfer.

Right.

> (My understanding is that this is really only important on 
> archs that use bounce buffers which I'm not).

It's also important on architectures where DMA is non-coherent (mpc83xx 
DMA is coherent).

> So, no as far as "the device" (and I do mean the DMA engine) is concerned, 
> the "mapping" of the src and dest pointers make zero difference, the 
> hardware doesn't care since it's just acting on raw addresses.  However, 
> it does (or at least I think it does) matter to the kernel and making sure 
> that the cache doesn't get screwed up.

Right.

> But it sounds like 
> you're saying those macros are unimportant. 

No, they're very important on certain hardware.

> Can dma_async_memcpy_buf_to_buf() _safely_ be used to DMA either direction 
> (CPU <=> peripheral) _without_ cache coherency problems?

Any given memcpy operation involves *both* directions.  Data is copied 
out of host memory into the DMA engine's internal buffer (this is the 
src mapping), and then it its copied back into host memory at a 
different address (this is the dest mapping).

-Scott

Return-Path: <jay_chen@alphanetworks.com>
Received: from Sweeper2.alphanetworks.com (sweeper2.alphanetworks.com
	[210.202.42.140]) by ozlabs.org (Postfix) with ESMTP id 0BA68DDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Nov 2008 22:14:28 +1100 (EST)
From: "jay_chen" <jay_chen@alphanetworks.com>
To: <linuxppc-embedded@ozlabs.org>
References: <0697112B46494D3DB284F1EBA6F65D4E@alphajay>
	<4919CC7D.2070101@freescale.com>
Subject: Re: MPC8349 DMA
Date: Wed, 19 Nov 2008 19:14:11 +0800
Message-ID: <6440C70E43EB4F019FF76DFFA4297B2D@alphajay>
MIME-Version: 1.0
In-Reply-To: <4919CC7D.2070101@freescale.com>
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for your help.
Could you give some hints about how to  "map your memory as
coherence-required"?

                Jay Chen...

-----Original Message-----
From: linuxppc-embedded-bounces+jay_chen=alphanetworks.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+jay_chen=alphanetworks.com@ozlabs.org] 
Sent: Wednesday, November 12, 2008 2:19 AM
To: jay_chen
Cc: linuxppc-embedded@ozlabs.org
Subject: [Spam Mail] Re: MPC8349 DMA

jay_chen wrote:
> I am using 2.6.14.5 and MPC8349.
> I got some DMA problems with PCI devices.
> So, I tried to understand the DMA stuff of linux.

That's very old; have you tried the latest kernel?

> I have one question about cache coherency.
> In dma-mapping.h, I found some functions are defined as NULL.
> For example:
> #define dma_cache_inv(_start,_size)  do { } while (0) #define 
> dma_cache_wback(_start,_size)  do { } while (0) #define 
> dma_cache_wback_inv(_start,_size) do { } while (0)
>  
> #define __dma_alloc_coherent(gfp, size, handle) NULL #define 
> __dma_free_coherent(size, addr)  do { } while (0) #define 
> __dma_sync(addr, size, rw)  do { } while (0) #define 
> __dma_sync_page(pg, off, sz, rw) do { } while (0) Does this mean that 
> I don't need to take care of cache coherency in MPC83xx platform?
> So, I could use any range of memory for DMA transferring and the 
> hardware will take care of the cache coherency for me?

Yes, however it's still a good idea to call the DMA functions in case the
code gets run on hardware that doesn't have coherent DMA, or that needs
special DMA mapping for highmem.

Make sure that the PCI bridge is configured to snoop, and that you map your
memory as coherence-required (normally not necessary on uniprocessor, but
there's some weirdness in the 82xx/83xx PCI controller that requires it).

-Scott

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

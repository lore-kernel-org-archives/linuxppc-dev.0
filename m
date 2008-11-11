Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5CDB1DDFA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Nov 2008 05:20:16 +1100 (EST)
Message-ID: <4919CC7D.2070101@freescale.com>
Date: Tue, 11 Nov 2008 12:18:37 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: jay_chen <jay_chen@alphanetworks.com>
Subject: Re: MPC8349 DMA
References: <0697112B46494D3DB284F1EBA6F65D4E@alphajay>
In-Reply-To: <0697112B46494D3DB284F1EBA6F65D4E@alphajay>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

jay_chen wrote:
> I am using 2.6.14.5 and MPC8349.
> I got some DMA problems with PCI devices.
> So, I tried to understand the DMA stuff of linux.

That's very old; have you tried the latest kernel?

> I have one question about cache coherency.
> In dma-mapping.h, I found some functions are defined as NULL.
> For example:
> #define dma_cache_inv(_start,_size)  do { } while (0)
> #define dma_cache_wback(_start,_size)  do { } while (0)
> #define dma_cache_wback_inv(_start,_size) do { } while (0)
>  
> #define __dma_alloc_coherent(gfp, size, handle) NULL
> #define __dma_free_coherent(size, addr)  do { } while (0)
> #define __dma_sync(addr, size, rw)  do { } while (0)
> #define __dma_sync_page(pg, off, sz, rw) do { } while (0)
> Does this mean that I don't need to take care of cache coherency in 
> MPC83xx platform?
> So, I could use any range of memory for DMA transferring and the 
> hardware will take care of the cache coherency for me?

Yes, however it's still a good idea to call the DMA functions in case 
the code gets run on hardware that doesn't have coherent DMA, or that 
needs special DMA mapping for highmem.

Make sure that the PCI bridge is configured to snoop, and that you map 
your memory as coherence-required (normally not necessary on 
uniprocessor, but there's some weirdness in the 82xx/83xx PCI controller 
that requires it).

-Scott

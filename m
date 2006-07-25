Return-Path: <philn@avalon.com.au>
Received: from camden.avalon.com.au (unknown [150.101.131.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E909967B55
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jul 2006 19:21:13 +1000 (EST)
Received: from lamorak.int.avalon.com.au (lamorak.int.avalon.com.au
	[192.168.1.97])
	by camden.avalon.com.au (8.13.1/8.13.1) with ESMTP id k6P99s0n028100
	for <linuxppc-embedded@ozlabs.org>; Tue, 25 Jul 2006 18:39:54 +0930
Subject: DMA buffer synchronisation
From: Phil Nitschke <philn@avalon.com.au>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 25 Jul 2006 18:39:54 +0930
Message-Id: <1153818594.10422.50.camel@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm transferring data using DMA from a custom PCI device memory into
RAM.  Can someone advise me on the correct buffer synchronisation
strategy for the following 3 scenarios:

Assuming I have three buffers, buf_A, and buf_B, both created using
dma_alloc_noncoherent(NULL, 32 * PAGE_SIZE, ...), and buf_C (much
larger), remapped into the processor's virtual address space using
ioremap(), and 'n' is the number of bytes to copy using DMA channel
'dmanr', ...

1/. DMA copy from PCI device memory into buf_B:

   /* ...prepare DMA engine, then: */
   WARN_ON(buf_B != L1_CACHE_ALIGN(buf_B));
   dma_sync_single_range_for_device(NULL, buf_B, 0, n, DMA_FROM_DEVICE);

   mv64x6x_enable_dma(dmanr);
   wait_for_completion_interruptible_timeout(...)

   dma_sync_single_range_for_cpu(NULL, buf_B, 0, n, DMA_FROM_DEVICE);

2/. DMA copy from buf_A to buf_B (same as above, except now sync the src
buffer prior to DMA):

   /* ...prepare DMA engine, check buffer alignment (x2), then: */
   dma_sync_single_range_for_device(NULL, buf_A,  0, n, DMA_TO_DEVICE);
   dma_sync_single_range_for_device(NULL, buf_B, 0, n, DMA_FROM_DEVICE);

   mv64x6x_enable_dma(dmanr);
   wait_for_completion_interruptible_timeout(...)

   dma_sync_single_range_for_cpu(NULL, buf_B, 0, n, DMA_FROM_DEVICE);

3/. DMA from PCI device memory into ioremap()'ed buffer, buf_C:

   /* ...prepare DMA engine, check buffer alignment, then: */
   /* No buffer sync-ing is required? */

   mv64x6x_enable_dma(dmanr);
   wait_for_completion_interruptible_timeout(...)

   /* No buffer sync'ing is required? */

Will this approach work (particularly case 3/.)?  I tried dma_sync-ing
the region, but got an 'oops' (kernel access of bad area).

I'm using the 2.6.16 kernel (compiled with CONFIG_NOT_COHERENT_CACHE
defined) on an Artesyn PmPPC7448 processor.  The processor utilises its
Marvell MV64460 as the DMA controller for the transaction.  

Thanks,

-- 
Phil

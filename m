Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from hp3.statik.tu-cottbus.de (hp3.statik.tu-cottbus.de
	[141.43.120.68]) by ozlabs.org (Postfix) with ESMTP id B3D41DDF15
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 06:12:10 +1000 (EST)
Message-ID: <48839BF4.6010603@s5r6.in-berlin.de>
Date: Sun, 20 Jul 2008 22:11:32 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: dma_alloc_coherent() on PPC32: physical addresses above 2G
	possible?
References: <488385A7.4010509@s5r6.in-berlin.de>	<20080720114358.6c88e048@infradead.org>	<4883913F.9040706@s5r6.in-berlin.de>
	<20080720123900.02677e6e@infradead.org>
In-Reply-To: <20080720123900.02677e6e@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arjan van de Ven wrote:
> On Sun, 20 Jul 2008 21:25:51 +0200
> Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>> 	if (dev->needs_dma_mask_workaround)
>> 		pci_set_consistent_dma_mask(pdev, DMA_31BIT_MASK);
>> 	allocate_something_special;
>> 	if (dev->needs_dma_mask_workaround)
>> 		pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
...
> something like this.
> But realistically, how many consistent/coherent allocations do you have?
> some ring buffers and other one time stuff surely... but not after that?

It's for DMA programs (i.e. lists of descriptors), not for the data DMA
buffers themselves.  FireWire controllers have several DMA contexts for
isochronous and asynchronous reception and transmission, and some
others.  Only context programs for isochronous reception need the
workaround.

We are dynamically appending new descriptors during runtime.  I.e. the
affected allocations happen during setup of the DMA context and
sometimes while the DMA context is active.  Particularly, in
drivers/firewire/fw-ohci.c:
	ohci_allocate_iso_context
		context_init
			context_add_buffer  <--
and
	ohci_queue_iso
		ohci_queue_iso_receive_dualbuffer
			context_get_descriptors
				context_add_buffer  <--

The other unaffected context types use context_add_buffer too.
-- 
Stefan Richter
-=====-==--- -=== =-=--
http://arcgraph.de/sr/

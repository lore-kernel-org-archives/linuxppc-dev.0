Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from hp3.statik.tu-cottbus.de (hp3.statik.tu-cottbus.de
	[141.43.120.68]) by ozlabs.org (Postfix) with ESMTP id 14214DDFD6
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 05:49:02 +1000 (EST)
Message-ID: <4883913F.9040706@s5r6.in-berlin.de>
Date: Sun, 20 Jul 2008 21:25:51 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: dma_alloc_coherent() on PPC32: physical addresses above 2G
	possible?
References: <488385A7.4010509@s5r6.in-berlin.de>
	<20080720114358.6c88e048@infradead.org>
In-Reply-To: <20080720114358.6c88e048@infradead.org>
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
> On Sun, 20 Jul 2008 20:36:23 +0200
> Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> 
>> PS:  I don't want to set the DMA mask of this device to
>> DMA_31BIT_MASK because that would be detrimental to other functions
>> of the device. It's a TI TSB43AB22A FireWire controller.
> 
> Hi,
> 
> just want to mention that you can set the coherent mask separately from
> the generic mask... is that sufficient for your load?
> (you can even set it just for this allocation..)

Hmm.  Would that be done this way?
During probe:

	if (chip_is_tsb43ab22a) {
		if (dma_supported(dev, DMA_31BIT_MASK))
			chip->needs_dma_mask_workaround = 1;
		else
			chip->needs_some_other_workaround = 1;
	}

Later on:

	if (dev->needs_dma_mask_workaround)
		pci_set_consistent_dma_mask(pdev, DMA_31BIT_MASK);
	allocate_something_special;
	if (dev->needs_dma_mask_workaround)
		pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);

Or is there a variant of dma_alloc_coherent() which directly accepts a
mask argument?
-- 
Stefan Richter
-=====-==--- -=== =-=--
http://arcgraph.de/sr/

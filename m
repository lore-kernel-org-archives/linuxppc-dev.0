Return-Path: <SRS0+ccece2b3983fbc48babd+1792+infradead.org+arjan@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85914DDE45
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 05:38:59 +1000 (EST)
Date: Sun, 20 Jul 2008 12:39:00 -0700
From: Arjan van de Ven <arjan@infradead.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: dma_alloc_coherent() on PPC32: physical addresses above 2G
	possible?
Message-ID: <20080720123900.02677e6e@infradead.org>
In-Reply-To: <4883913F.9040706@s5r6.in-berlin.de>
References: <488385A7.4010509@s5r6.in-berlin.de>
	<20080720114358.6c88e048@infradead.org>
	<4883913F.9040706@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 20 Jul 2008 21:25:51 +0200
Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> 
> Later on:
> 
> 	if (dev->needs_dma_mask_workaround)
> 		pci_set_consistent_dma_mask(pdev, DMA_31BIT_MASK);
> 	allocate_something_special;
> 	if (dev->needs_dma_mask_workaround)
> 		pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
> 
> Or is there a variant of dma_alloc_coherent() which directly accepts a
> mask argument?

something like this.
But realistically, how many consistent/coherent allocations do you have?
some ring buffers and other one time stuff surely... but not after that?

-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org

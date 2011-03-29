Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DB5E2B6F9F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 11:32:53 +1100 (EST)
Subject: Re: minimum guaranteed alignment of dma_alloc_coherent?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <4D500C28.7000704@freescale.com>
References: <AANLkTi=1VkJM6hJH44jeUmYwoEtJj22d6WyKVDitg=KY@mail.gmail.com>
	<2A5A3DDA-94B3-48E3-9E49-6A5260BE1484@digitaldans.com>
	<4D4CB038.9020602@freescale.com>
	<9E25355F-62B4-46A3-9991-FDE89FB6B862@digitaldans.com>
	<4D500C28.7000704@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 29 Mar 2011 11:32:39 +1100
Message-ID: <1301358759.2402.665.camel@pasglop>
Mime-Version: 1.0
Cc: Dan Malek <ppc6dev@digitaldans.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-02-07 at 09:13 -0600, Timur Tabi wrote:
> > This behavior is modified if you specify a restricted DMA
> > mask for the device.  In this case, dma_alloc_coherent
> > will force GFP_DMA on your behalf (on PowerPC).
> 
> Isn't it required for all callers of dma_alloc_coherent to specify a
> mask (via
> dma_set_mask) first?

GFP_DMA historically means ISA DMA memory on x86 :-) Other platforms had
different "use" for it but basically it's old style drivers.

The problem with dma_set_mask() is that there's no way without an iommu
that the implementation of dma_alloc_coherent() can satisfy arbitrary
masks since you don't control where the page allocator gets you the
pages from ... unless you have zones. That's what ZONE_DMA and
ZONE_DMA32 are for.

Cheers,
Ben.

Return-Path: <timur@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 43253B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 02:29:10 +1100 (EST)
Message-ID: <4D500C28.7000704@freescale.com>
Date: Mon, 7 Feb 2011 09:13:44 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Dan Malek <ppc6dev@digitaldans.com>
Subject: Re: minimum guaranteed alignment of dma_alloc_coherent?
References: <AANLkTi=1VkJM6hJH44jeUmYwoEtJj22d6WyKVDitg=KY@mail.gmail.com>
	<2A5A3DDA-94B3-48E3-9E49-6A5260BE1484@digitaldans.com>
	<4D4CB038.9020602@freescale.com>
	<9E25355F-62B4-46A3-9991-FDE89FB6B862@digitaldans.com>
In-Reply-To: <9E25355F-62B4-46A3-9991-FDE89FB6B862@digitaldans.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan Malek wrote:

> So, I did a little research.  It appears in the case of PowerPC,
> the GFP_DMA can change the way the allocation operates.
> Since the coherent allocator works with pages of memory,
> in the case of a system with highmem, not using GFP_DMA
> could hand you a physical page out of the highmem pool.

I think that's true only if SWIOTLB is enabled.  dma_direct_alloc_coherent()
does this:

	/* ignore region specifiers */
	flag  &= ~(__GFP_HIGHMEM);

> This behavior is modified if you specify a restricted DMA
> mask for the device.  In this case, dma_alloc_coherent
> will force GFP_DMA on your behalf (on PowerPC).

Isn't it required for all callers of dma_alloc_coherent to specify a mask (via
dma_set_mask) first?

-- 
Timur Tabi
Linux kernel developer at Freescale

-- 
Timur Tabi
Linux kernel developer at Freescale

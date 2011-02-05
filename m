Return-Path: <ppc6dev@digitaldans.com>
Received: from wsl00026.west-datacenter.net (wsl00026.west-datacenter.net
	[69.36.176.27])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7535B7106
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Feb 2011 13:56:14 +1100 (EST)
Message-Id: <9E25355F-62B4-46A3-9991-FDE89FB6B862@digitaldans.com>
From: Dan Malek <ppc6dev@digitaldans.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
In-Reply-To: <4D4CB038.9020602@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: minimum guaranteed alignment of dma_alloc_coherent?
Date: Fri, 4 Feb 2011 18:56:08 -0800
References: <AANLkTi=1VkJM6hJH44jeUmYwoEtJj22d6WyKVDitg=KY@mail.gmail.com>
	<2A5A3DDA-94B3-48E3-9E49-6A5260BE1484@digitaldans.com>
	<4D4CB038.9020602@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 4, 2011, at 6:04 PM, Tabi Timur-B04825 wrote:

> I guess I'm not clear.  I was wondering why an API called  
> "dma_alloc_coherent" (that has the word "dma" in it) needs to be  
> told to allocate DMA-safe memory.

I understood your question, and I indicated this is used in a
platform specific manner.

>  When would it make sense to call dma_alloc_cohernet without  
> GFP_DMA?  If you don't want DMA-able memory, then you shouldn't be  
> calling dma_alloc_anything.

So, I did a little research.  It appears in the case of PowerPC,
the GFP_DMA can change the way the allocation operates.
Since the coherent allocator works with pages of memory,
in the case of a system with highmem, not using GFP_DMA
could hand you a physical page out of the highmem pool.
If your device is capable of doing a DMA to that physical
location, all is good.  If your device has some addressing
restriction to low memory buffers, you should specify GFP_DMA.
I think for all architectures, GFP_DMA will guarantee a DMA
buffer for any device in a system.  If your device can relax that
constraint, you can elect to not use this flag and conserve
the DMA pool for those devices that require the restrictions.

This behavior is modified if you specify a restricted DMA
mask for the device.  In this case, dma_alloc_coherent
will force GFP_DMA on your behalf (on PowerPC).

Thanks.

	-- Dan

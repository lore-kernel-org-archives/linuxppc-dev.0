Return-Path: <ppc6dev@digitaldans.com>
Received: from wsl00026.west-datacenter.net (wsl00026.west-datacenter.net
	[69.36.176.27])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 47108B7101
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Feb 2011 12:57:02 +1100 (EST)
Message-Id: <2A5A3DDA-94B3-48E3-9E49-6A5260BE1484@digitaldans.com>
From: Dan Malek <ppc6dev@digitaldans.com>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <AANLkTi=1VkJM6hJH44jeUmYwoEtJj22d6WyKVDitg=KY@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: minimum guaranteed alignment of dma_alloc_coherent?
Date: Fri, 4 Feb 2011 17:09:28 -0800
References: <AANLkTi=1VkJM6hJH44jeUmYwoEtJj22d6WyKVDitg=KY@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 4, 2011, at 4:14 PM, Timur Tabi wrote:

> Is there any official statement on what the minimum alignment is for
> memory returned by dma_alloc_coherent?

This is dependent upon the particular implementation.
There have been several over the history of this API,
and some would work out of a DMA pool that would
only provide word alignment.

> Would anyone have a complaint if I did this:
>
> vaddr = dma_alloc_coherent(dev, ssize, &paddr, GFP_DMA | __GFP_ZERO);
> BUG_ON(paddr & (alignment - 1));

Well, the usual design for anything that requires alignment
is that you never assume you get it unless it can be specified,
so over allocate as you are doing currently, and then adjust
the base address.  Or, you could allocate exactly what you
want, if it aligns properly you are good to go, and if not release,
over allocate, and adjust.

The problem with the suggested implementation is the results
aren't predictable.  Even if the API doesn't guarantee your
alignment, you may get it most of the time, but once in a
while this may fail.  You could test and all looks good,
ship something and it fails.

Today, this may work fine, but it would be nice to ensure
it continues to work in the future. :-)

> On a side note, do I really need to pass GFP_DMA ....

The GFP_DMA is architecture dependent.  Are you writing
a driver to be used across multiple architectures?  If it's
necessary, I'd document why you are using it (an ISA device
on x86 for example) and then let other architectures
determine if it's necessary for them.

Thanks.

	-- Dan

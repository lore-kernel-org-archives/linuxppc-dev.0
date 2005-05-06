Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7EC9F67A01
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 02:43:13 +1000 (EST)
In-Reply-To: <20050505172035.GB3339@logos.cnet>
References: <20050505172035.GB3339@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 6 May 2005 12:43:01 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: fix usage of pinned 8Mbyte TLB entries 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 5, 2005, at 1:20 PM, Marcelo Tosatti wrote:

> As can be seen by BDI output from previous messages, the 8Mbyte TLB
> pinned entry is not being actually used.

We know it's not, we know it's broken, I'm working on it :-)

> The following patch changes "mmu_mapin_ram" (hook used by mapin_ram), 
> to
> begin creation of pagetables after the first 8Megs, preserving the
> 8Mbyte TLB entry.

Please don't do this.  It isn't necessary.

> This changes the assumption that DMA allocations can start at the first
> kernel address, given that those need to be marked uncached due to DMA
> cache coherency issues.

VM space for uncached DMA has always been allocated using vmalloc(),
the location of the physical pages backing this space is irrelevant.  
The only
thing you have to ensure is the virtual address is outside of the pinned
entry.  If something about the way the VM space is structured in 2.6 is
different, we need to fix that in general.


> Panto: FEC currently does
>
>         mem_addr = __get_free_page(GFP_KERNEL);
>         cbd_base = (cbd_t *)mem_addr;

This is just plain broken and it shouldn't do this.

> We are still using v2.4 FEC driver, so this fixed it:
>
> //      mem_addr = __get_free_page(GFP_KERNEL);
>         mem_addr = dma_alloc_coherent(NULL, PAGE_SIZE, &physaddr,
>                         GFP_KERNEL);

This is the proper way, and should be moved to the equivalent in 2.6.

> Allocateing from the coherent memory DMA region. Which sits at, I 
> suppose,
> after initial 8Megs in all configurations (should be always).

You are making this too complicated :-)  All we have to do is use the
proper dma allocators and make sure the TLBs are pinned properly.
That is all.

Thanks.


	-- Dan

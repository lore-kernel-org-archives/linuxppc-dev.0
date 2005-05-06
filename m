Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 305B8679E2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 04:10:31 +1000 (EST)
Date: Fri, 6 May 2005 10:38:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050506133858.GA6032@logos.cnet>
References: <20050505172035.GB3339@logos.cnet>
	<1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
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


> >The following patch changes "mmu_mapin_ram" (hook used by mapin_ram), 
> >to
> >begin creation of pagetables after the first 8Megs, preserving the
> >8Mbyte TLB entry.
> 
> Please don't do this.  It isn't necessary.

Why it is not necessary? 

Have you read the section of the manual which I pasted here? 

> >This changes the assumption that DMA allocations can start at the first
> >kernel address, given that those need to be marked uncached due to DMA
> >cache coherency issues.
> 
> VM space for uncached DMA has always been allocated using vmalloc(),
> the location of the physical pages backing this space is irrelevant.    
>
> The only thing you have to ensure is the virtual address is outside 
> of the pinned entry.  

What you replied to is:

"This changes the assumption that DMA allocations can start at the first
kernel address, given that those need to be marked uncached due to DMA
cache coherency issues." 

I think we mean the same, yes? 

> If something about the way the VM space is structured in 2.6 is
> different, we need to fix that in general. 

>
> >Panto: FEC currently does
> >
> >        mem_addr = __get_free_page(GFP_KERNEL);
> >        cbd_base = (cbd_t *)mem_addr;
> 
> This is just plain broken and it shouldn't do this.
> 
> >We are still using v2.4 FEC driver, so this fixed it:
> >
> >//      mem_addr = __get_free_page(GFP_KERNEL);
> >        mem_addr = dma_alloc_coherent(NULL, PAGE_SIZE, &physaddr,
> >                        GFP_KERNEL);
> 
> This is the proper way, and should be moved to the equivalent in 2.6.
> 
> >Allocateing from the coherent memory DMA region. Which sits at, I 
> >suppose,
> >after initial 8Megs in all configurations (should be always).
> 
> You are making this too complicated :-)  All we have to do is use the
> proper dma allocators and make sure the TLBs are pinned properly.
> That is all.

Sorry, but, what is too complicated? 

The patch I sent does two things (pretty much the same thing you suggest 
after stating that its "too complicated", AFAICS):

1) avoids the creation of pte tables in the 8Mbyte range, thus preserving
the pinned TLB entry.
2) restricts bootmem to above 8Mbyte region

And last thing is: 

3) Memory for DMA pages must not be in the pinned region. ie. drivers 
should not allocate memory directly for DMA purposes.

Dan, I would really enjoy having access to some of your precious 8xx
knowledge: share it, along with the correct way to fix this and the 
other pending issues.

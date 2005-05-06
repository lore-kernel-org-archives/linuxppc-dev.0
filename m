Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0FF4679F2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 13:41:47 +1000 (EST)
Date: Fri, 6 May 2005 20:05:23 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050506230523.GA15908@logos.cnet>
References: <20050505172035.GB3339@logos.cnet>
	<1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
	<20050506133858.GA6032@logos.cnet>
	<3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
	<20050506200338.GC14486@logos.cnet>
	<84773f72b8bba863c9471c0d121223a8@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <84773f72b8bba863c9471c0d121223a8@embeddededge.com>
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

On Fri, May 06, 2005 at 11:09:15PM -0400, Dan Malek wrote:
> 
> On May 6, 2005, at 4:03 PM, Marcelo Tosatti wrote:
> 
> >The data I have tells me otherwise. I have seen the I-TLB entries
> >getting created for kernel space.
> 
> Of course.  That's because the pinned entries aren't working :-)
> 
> >Can't the BDI work on the 8Mbyte page?  Same for other software
> >or debuggers...
> 
> The BDI can, but other software functions will walk the page
> tables looking for PTE information.  

Do you have any practical example which you are certain is going
to break? 

I dont remember any, and I dont think any software should be walking
kernel pte's directly...

It is not possible to have the 8Mbyte pinned TLB and 4kb pagetables 
mapping the same kernel virtual addresses.

> >        /* get the PTE for the bootpage */
> >        if (!get_pteptr(&init_mm, bootpage, &pte))
> >               panic("get_pteptr failed\n");
> >
> >        /* and make it uncachable */
> >        pte_val(*pte) |= _PAGE_NO_CACHE;
> >        _tlbie(bootpage);
> 
> This is a bad hack (that I wrote) that needs to get fixed.
> 
> >Because DMA pages need to have their PTE's marked as uncached, which 
> >in turn
> >means their TLB's need to be marked as uncached.
> 
> Right, but these are allocated from the vmalloc() space, far away
> from the pinned entries. 
>
> >I dont think you can have multiple overlapping TLB entries.
> 
> Sure you can, we do it all of the time.  The kernel maps all of
> memory, and then user applications do it again.  The only time
> it causes a problem is when you have different cache attributes
> for the same physical page.  In this case, you need to ensure
> you only use one mapping.  You can't have the same virtual
> address twice in the TLB (iirc, the 8xx automatically invalidates
> an existing one if you do this), but you can have the same
> physical page mapped multiple times.  

You can't have both a 4kb page and a 8Mbyte page mapping the virtual 
address KERNELBASE + 0. 

Do you agree? 

> >How is the MMU supposed to decide between multiple mappings
> >for the same address ?
> 
> You are thinking backward.  The MMU maps the virtual address
> accessed, there is only one valid at a time.  You can have multiple
> VM addresses accessing the same physical page.

Right - I'm talking about kernel virtual addresses: in this specific case,
we can't have more than one mapping for the first page at KERNELBASE.

> >That is how it is now. See previous posts with detailed TLB debugging.
> 
> Something isn't correct if it isn't working.  
>
> >Maybe you thought you got it right because the initial 8Mbyte
> >mapping works?
> 
> No, this is required to work for some execute in place from rom
> systems I have done.  It was adapted from that.  The initial 8M
> mapping must be evicted when the  mapin_ram() is done.  It's
> supposed to happen that way.
> 
> >Unfortunately that mapping is trashed after overlapping
> >pte's are created.
> 
> Right, that is supposed to happen unless TLB pinning
> is configured.

OK, we seem to be on the same page now. 

So you do agree that pte's should not be created for the first
8MBytes if CONFIG_PIN_TLB is set? :) 

Should I send an updated patch or you plan to do that? 

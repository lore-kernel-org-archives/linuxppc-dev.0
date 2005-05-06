Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78044679F7
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 10:38:29 +1000 (EST)
Date: Fri, 6 May 2005 17:03:38 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050506200338.GC14486@logos.cnet>
References: <20050505172035.GB3339@logos.cnet>
	<1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
	<20050506133858.GA6032@logos.cnet>
	<3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
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


Hi Dan,

On Fri, May 06, 2005 at 06:49:11PM -0400, Dan Malek wrote:
> 
> On May 6, 2005, at 9:38 AM, Marcelo Tosatti wrote:
> 
> >1) avoids the creation of pte tables in the 8Mbyte range, thus 
> >preserving
> >the pinned TLB entry.
> 
> This has nothing to do with "preserving" the pinned TLB entry.
> The pinned entries are placed into the reserved portion of the TLB,
> and are never evicted.  

OK.

> We never get a fault on these pages, so wenever look up an 
> entry in the page table. 

The data I have tells me otherwise. I have seen the I-TLB entries 
getting created for kernel space.  

I did the following:

- insert a break at the beginning of start_kernel, another break at 
the end of start_kernel.
- boot, BDI stops at start_kernel.
- dump I-TLB contents, no entries for "start_kernel" pages on I-TLB.
- "go".
- BDI stops at the end of start_kernel.
- dump I-TLB contents, see the 4kb entries for "start_kernel" I-cache
there (ie we _do_ get faults on these pages).

Check it out.

If your setup is not working yet I can get the data for you tomorrow.

> We need to create the
> page tables for informational purposes, so software or debugger
> lookups will do the right thing.

Can't the BDI work on the 8Mbyte page?  Same for other software 
or debuggers... 

Any in-kernel algorithm which relies on direct pte manipulation 
looks fragile... 

i386 and some (?) other architectures do use big pages for the first 
kernel addresses, right? 

> >2) restricts bootmem to above 8Mbyte region
> 
> Why is this necessary? 

void __init
m8xx_setup_arch(void)
{
        int     cpm_page;

        cpm_page = (int) alloc_bootmem_pages(PAGE_SIZE);

        /* Reset the Communication Processor Module.
        */
        m8xx_cpm_reset(cpm_page);

...

void
m8xx_cpm_reset(uint bootpage)
{
...
        /* get the PTE for the bootpage */
        if (!get_pteptr(&init_mm, bootpage, &pte))
               panic("get_pteptr failed\n");

        /* and make it uncachable */
        pte_val(*pte) |= _PAGE_NO_CACHE;
        _tlbie(bootpage);

        host_buffer = bootpage;
        host_end = host_buffer + PAGE_SIZE;

> >3) Memory for DMA pages must not be in the pinned region. ie. drivers
> >should not allocate memory directly for DMA purposes.
> 
> Why not?  

Because DMA pages need to have their PTE's marked as uncached, which in turn 
means their TLB's need to be marked as uncached. 

> It doesn't matter if we cover a VM space with a bunch of 4K
> entries or a single 8M entry.   The physical pages are always going to
> be multiple mapped, either through the mapin_ram() space or a single 8M
> entry, and also through the vmalloc() space.  You just have to ensure,
> in any case, that you don't access the pages through both VM spaces.

I dont think you can have multiple overlapping TLB entries. 

How is the MMU supposed to decide between multiple mappings 
for the same address ? 

> >Dan, I would really enjoy having access to some of your precious 8xx
> >knowledge: share it, along with the correct way to fix this and the
> >other pending issues.
> 
> The correct fix is rather simple, just make sure you configure the TLB
> to reserve entries, and get the pinned entries into those reserved
> entries.

That is how it is now. See previous posts with detailed TLB debugging.

> I know I had it right once, I don't know what happened :-) 

Maybe you thought you got it right because the initial 8Mbyte 
mapping works? 

Unfortunately that mapping is trashed after overlapping 
pte's are created.

> Just hang on and I'll get you some code to test ....

Sure...

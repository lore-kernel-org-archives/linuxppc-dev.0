Message-ID: <3A6C9852.4090201@valinux.com>
Date: Mon, 22 Jan 2001 13:30:10 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: Roman Zippel <zippel@fh-brandenburg.de>, michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <Pine.GSO.4.10.10101221945230.19978-100000@zeus.fh-brandenburg.de> <3A6C8C6E.3C19F151@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:

> ...I don't know who wrote:
>
>>>> There is no pte table and so there is nothing mapped at that address,
>>>
>
> No, there is a pte table there, you just didn't get to printing
> anything from it......
>
> Roman Zipple wrote:
>
>> It depends what you what you want to do.
>
>
> I am really bad at guessing today....someone is going to have to
> tell me what you are trying to do.  From the few lines of code I have
> see posted, you are doing:
>
> 	1. Allocating some kernel virtual address and backing that
> 		with pages in real memory.
>
> 	2. Trying to find something in the kernel page tables, that I
> 		guessed wrong was a physical address of the pages.


Okay let me try and explain things a little better.

We need a virtually contiguous area of memory addressable by the
kernel.  We also need to know what physical pages actually make up this
virtually contiguous area.  Currently there is no kernel function to do
this explicitly (I'm probably going to add one to 2.5 for some other
work I'm doing though.)  So we call vmalloc_32 and get a virtual
address.  We then take that virtual address and grab the list pages that
the kernel just allocated.  We memset this full region in case these are
COW pages (shouldn't ever be COW pages on the Intel ia32, but perhaps on
other arch's.)  We get the list by walking the kernel page tables, as
you can see in the code snippet.

Later on this list of pages will be mapped into user space by the DRM's
mmap routine.  It uses vma_nopage to accomplish this.  vma_nopage
functions should return struct page *, we do this by returning
pagelist[page_offset_in_pages_from_start_of_vma].  This should work on
fine on any arch's kernel.  We haven't gotten to this point in the code
yet, so its not the issue we are addressing.

Another thing that happens later is that we need the bus address of each
of these pages to program the card to do scatter gather dma from this
region.  We do virt_to_bus(pagelist[i]->virtual) to accomplish this
translation.  I assume this is what we would have to do on PPC to
program a device wanting u32 bus pointers on the PPC.  We aren't even
reaching that code yet, so its not the issue here.

I know on the ia32 a pgd/pmd can actually point to 4MB pages rather then
a real pte.  Does the PowerPC have anything like this?  I would doubt
that I would encounter anything like this from a vmalloc'ed area of
memory (since vmalloc is arch independent and it would call alloc_page
for each individual pte.)  Am I correct in this assumption?

Just FYI, the code I posted works fine on the ia32 platform (only tested
with the i386 classic 2-level page tables.)

Another thing we might be running into here is that vmalloc does not
guarantee a virtually contiguous area of memory (or so I am told.)  I've
NEVER seen this in practice on an ia32 platform.  Does this happen only
happen on other platforms, or perhaps happen more often on other platforms?

-Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

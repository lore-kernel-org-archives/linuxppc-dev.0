Date: Wed, 19 Jun 2002 11:07:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: trouble mmapping dma buffer
Message-ID: <20020619010725.GF15985@zax>
References: <3D0F2E73.63D2434B@labs.mot.com> <3D0F673A.7914CAF7@labs.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D0F673A.7914CAF7@labs.mot.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 18, 2002 at 12:00:42PM -0500, Steve Rossi wrote:
>
> Found the problem ... consistent_alloc has changed between 2.4.16 and 2.4.19.
> In 2.4.19 it allocates a new virtual memory area and returns addresses in the
> new virtual area. remap_page_range can't handle this properly - actually to my
> understanding, remap_pte_range doesn't handle it because it does
> virt_to_page(__va(phys_addr)) which doesn't return the correct virtual address
> in the new virtual memory area. Is this intentional - that consistent_alloc
> returns addresses that can't be mmapped? Is there a better way of allocating a
> DMA buffer in RAM and remapping it to user space? For now I'm using an
> allocation routine based on the 2.4.16 version of consistent_alloc, and that
> works.

You can remap it into user space, it's just that you can't get to the
(page *) with virt_to_page() on the virtual address returned by
consistent_alloc() (virt_to_page() is only reliable on kernel lowmem
addresses).

You can use phys_to_page() on the dma handle returned by
consistent_alloc, though.

> Steve Rossi wrote:
>
> > I wrote a driver, which used to work under the stable 2.4.16 kernel, but
> > since I've moved up to the 2.4.19-pre7 development kernel it has stopped
> > working. The driver basically allocates a dma buffer (64K) using
> > consistent_alloc and it marks all of the pages in the kernel's mapping
> > of this buffer reserved (calling mem_map_reserve for each page). A user
> > space application calls mmap on the driver to get direct access to that
> > 64K DMA buffer. The mmap routine in the driver sets VM_RESERVED in
> > vma->vm_flags then uses remap_page_range to map the physical address of
> > the DMA buffer to the user space virtual memory area, one page at a
> > time. It also marks each page _PAGE_NO_CACHE and _PAGE_GUARDED in the
> > user space mapping.
> > This all worked just fine under 2.4.16, but now under 2.4.19-pre7 when I
> > run the application that mmaps the device I get the following:
> >
> > swap_dup: Bad swap file entry 00000004
> >
> > repeated 16 times (note - that's how many pages are in my dma buffer)
> > followed by:
> >
> > swap_free: Bad swap file entry 00000004
> >
> > also repeated 16 times.
> > When the application exists and calls munmap, I get
> > swap_free: Bad swap file entry 00000004
> > another 16 times.
> > I'm running on an 8xx systems with 32MB of RAM. I have no swap space.
> > The DMA buffer typically gets allocated around physical address
> > 0x19A0000, up near the top of the memory. I'm guessing that maybe the
> > kernel thinks that the mmaped pages are swapped out?? But why? Has
> > anything changed between 2.4.16 and 2.4.19-pre7 that could account for
> > this. Is there a problem with using remap_page_range to map RAM? I would
> > appreciate any help!
> >
> > Thanks!
> > Steve
> >
> >
>

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Subject: Re: User buffers and cache flushing.
To: erammsu@kieraypc01.p.y.ki.era.ericsson.se (Marcus Sundberg)
Date: Fri, 17 Mar 2000 08:48:06 +1100 (EST)
Cc: gjohnson@research.canon.com.au (Greg Johnson),
        linuxppc-embedded@lists.linuxppc.org ( Linux PPC Mailing List)
In-Reply-To: <kfy3dprqldd.fsf@kieraypc07.p.y.ki.era.ericsson.se> from "Marcus Sundberg" at Mar 16, 2000 11:07:10 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000316214806.33443355E8@elph.research.canon.com.au>
From: gjohnson@research.canon.com.au (Greg Johnson)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Quoth Marcus Sundberg:
> gjohnson@research.canon.com.au (Greg Johnson) writes:
> > Hi y'all,
> >
> > The buffers I need to IDMA out to a peripheral are allocated by
> > the user with conventional malloc, and are rather dynamic so
> > the driver does not have a lot of control over them that I can
> > see.
> >
> > So I have decided that I will be flushing the cache, either by
> > calling 'flush_page_to_ram' or 'flush_dcache_range'. Now, these
> > require a Kernel virtual address to work on (correct?), and the
> > caller has given me a User virtual address (through 'write (2)').
> > Therefore, before calling the flush function, I need to:
> >
> > * Convert the User virtual address for each page to a Physical
> >   address by doing something along the lines of:
> >
> >     pgd = pgd_offset(current->mm, addr)
> >     pmd = pmd_offset(pgd, addr)
> >     pte = pte_offset(pte, addr)
> >     etc.
> >
> > * Convert the Physical address to a Kernel virtual address by
> >   calling 'phys_to_virt'.
> >
> > Then I can call flush on each page I intend to IDMA out.
> >
> > Does this sound reasonable?
>
> No, you can't do DMA on user-space allocated memory, as you do not
> know where the pages are, or even if they are in memory at all,
> when the DMA starts. (Well, you could if you use mlock(), know
> what you are doing, and are 100% sure that the process will not
> die while DMA operations are still pending, but it's bad practise.)
>
> The right thing to do is allocate memory in the driver and allow
> the user process to mmap() it.

I can find out where they are using the above method. I know that they
have not been paged out since our system has no disk. The only thing
that is uncertain is the cache coherency, hence the flush. The idea of
fidling with page table flags so that the areas are not cached sounds
way too complicated.

I know that the user allocated buffer will likely be fragmented and
that is why I need to resolve each user virtual page address to its
physical to set up the DMA transfer.

I supose that I could lock the physical pages once I have resolved
their addresses, but this is a rather fiddly process and I would
like to avoid that if possible.

In addition, there will unlikely be any great catastrophy if the app
died while DMA's were pending. The driver could stop the DMAs as soon
as the app exits. Also they way the system works, the app dying is
a really bad thing in general, and ensuring the DMA completes properly
in this case is not a priority.


--
+----------------------------------------------------+
| Do you want to know more?                          |
|               --== Greg Johnson ==--               |
| HW/SW Engineer      gjohnson@research.canon.com.au |
| Canon   Information  Systems   Research  Australia |
| 1 Thomas Holt Dr, North Ryde, NSW, 2113, Australia |
| "I FLEXed my BISON and it went YACC!" - me.        |
+----------------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

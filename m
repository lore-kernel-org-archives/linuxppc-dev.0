Subject: Re: User buffers and cache flushing.
To: linuxppc-embedded@lists.linuxppc.org ( Linux PPC Mailing List)
Date: Thu, 16 Mar 2000 13:40:40 +1100 (EST)
In-Reply-To: <38C862A6.224DBDF3@embeddededge.com> from "Dan Malek" at Mar 09, 2000 09:49:10 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000316024040.76894355D1@elph.research.canon.com.au>
From: gjohnson@research.canon.com.au (Greg Johnson)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi y'all,

The buffers I need to IDMA out to a peripheral are allocated by
the user with conventional malloc, and are rather dynamic so
the driver does not have a lot of control over them that I can
see.

So I have decided that I will be flushing the cache, either by
calling 'flush_page_to_ram' or 'flush_dcache_range'. Now, these
require a Kernel virtual address to work on (correct?), and the
caller has given me a User virtual address (through 'write (2)').
Therefore, before calling the flush function, I need to:

* Convert the User virtual address for each page to a Physical
  address by doing something along the lines of:

    pgd = pgd_offset(current->mm, addr)
    pmd = pmd_offset(pgd, addr)
    pte = pte_offset(pte, addr)
    etc.

* Convert the Physical address to a Kernel virtual address by
  calling 'phys_to_virt'.

Then I can call flush on each page I intend to IDMA out.

Does this sound reasonable?

Thanks

Greg.

Quoth Dan Malek:
>
>
> Greg Johnson wrote:
>
> > ....Since I
> > am not wanting to be double handling this data, and the data will
> > most likely be fragmented in memory,
>
> That's no problem, CPM buffer descriptors are made for that.
>
>
> > ....and call flush_dcache_range on each of these fragments.
>
> Depends upon how the data is handled.  In some cases I find it is
> faster to just map the pages uncached and skip the cache push.  Do
> some system design and analysis to determine what works best.
>
> > Have I overlooked anything? (other than the lack of support for IDMA
> > currently in the MPC8xx kernel)
>
> This is pretty trivial, considering all CPM devices use the same DMA
> engine as IDMA.  Take an existing driver, rip the guts of data comm
> out of it, and you nearly have the IDMA driver.
>
>
> 	-- Dan
>
>
>


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

Date: Thu, 9 Aug 2001 18:49:02 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: Daris A Nevil <dnevil@snmc.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Non-cacheable memory
In-Reply-To: <3B7034A0.C55D871F@snmc.com>
Message-ID: <Pine.LNX.4.33.0108091838380.11077-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 7 Aug 2001, Daris A Nevil wrote:

> Gus, Tom,
>
> Here is the procedure I used to allocate pages and mark them as non-cached in
> the 2.2.5 kernel (SNMC's QSLinux):
>
>     mem_addr = __get_free_page(GFP_KERNEL);
>     pte = va_to_pe(&init_task, mem_addr);
>     pte_val(*pte) |= _PAGE_NO_CACHE;
>     flush_tlb_page(current->mm_mmap, mem_addr);
>
> I used these pages for SCC buffer descriptors, so they were never returned to
> the system. I'm not sure if this is the preferred way, but it certainly works.
> I have not tried this in the 2.4 kernel yet.  The functions __get_free_page()
> and flush_tlb_page() do exist in 2.4.4, but I could not locate va_to_pe()  (I
> think that was a macro in 2.2.5).
>
> You may also want to look at the file linux/asm/pgalloc.h, esp. the functions
> get_pgd_slow() and get_pgd_fast().

Indeed, that does look quite like what I would expect to do. But, trust my
luck, it didn't work. I'm on a 2.4 kernel (a few weeks old from the devel
tree (2.4.7-pre6?). Here's how my code looks:

        dev->mem_start = (int)__get_free_pages(GFP_KERNEL, 0);
#ifndef CONFIG_NO_DCACHE
        {
        /* This is where code goes to set the above allocated memory as
        *  non-cacheable. These lines DO NOT WORK right now. */

        pte_t *pte = va_to_pte(dev->mem_start);
        pte_val(*pte) |= _PAGE_NO_CACHE;
        flush_tlb_page(init_mm.mmap, dev->mem_start);
        }
#endif


Notes: CONFIG_NO_DCACHE is an option I added which disables the L1 cache
(no cache means no need for uncached memory :) Also, va_to_pte is in
arch/ppc/mm/fault.c, and is ifdef'd with a CONFIG_8xx. I altered that
ifdef to also include the function for my board.

I might also need to set the addresses 0x10710000 and 0x10718000 to be
non-cacheable (for MMIO with the chip). Would those addresses be in the
page table? And if not, thoughts on how to un-cache those areas (which are
each only a few bytes)?

Thanks,
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

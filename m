Message-ID: <3B7034A0.C55D871F@snmc.com>
Date: Tue, 07 Aug 2001 11:34:09 -0700
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: Tom Roberts <tjroberts@lucent.com>
Cc: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Non-cacheable memory
References: <Pine.LNX.4.33.0108071444530.16835-100000@localhost.localdomain> <3B70104B.C1E6F8EC@lucent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gus, Tom,

Here is the procedure I used to allocate pages and mark them as non-cached in
the 2.2.5 kernel (SNMC's QSLinux):

    mem_addr = __get_free_page(GFP_KERNEL);
    pte = va_to_pe(&init_task, mem_addr);
    pte_val(*pte) |= _PAGE_NO_CACHE;
    flush_tlb_page(current->mm_mmap, mem_addr);

I used these pages for SCC buffer descriptors, so they were never returned to
the system. I'm not sure if this is the preferred way, but it certainly works.
I have not tried this in the 2.4 kernel yet.  The functions __get_free_page()
and flush_tlb_page() do exist in 2.4.4, but I could not locate va_to_pe()  (I
think that was a macro in 2.2.5).

You may also want to look at the file linux/asm/pgalloc.h, esp. the functions
get_pgd_slow() and get_pgd_fast().

Regards,
Daris Nevil


Tom Roberts wrote:

> "Justin (Gus) Hurwitz" wrote:
> > Does the current 2_4_devel tree have support for allocating regions of
> > non-cachable memory? And, if so, what is the proper (or preferred) way of
> > doing this?
>
> What I did in 2.2.15 was to edit the main startup routine to call my driver
> directly so it could "eat up" a region of memory before Linux started its
> memory management. I then used a BAT to reference it uncached. Yes, this
> is ugly, and requires care in making sure the BAT effective address is
> otherwise unused by the kernel, but it works. This is on a MPC7400, and
> other PowerPC CPUs might not have BATs available....

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

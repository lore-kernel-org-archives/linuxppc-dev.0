To: gjohnson@research.canon.com.au (Greg Johnson)
Cc: linuxppc-embedded@lists.linuxppc.org ( Linux PPC Mailing List)
Subject: Re: User buffers and cache flushing.
References: <20000316024040.76894355D1@elph.research.canon.com.au>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 16 Mar 2000 11:07:10 +0100
In-Reply-To: gjohnson@research.canon.com.au's message of "Thu, 16 Mar 2000 13:40:40 +1100 (EST)"
Message-ID: <kfy3dprqldd.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


gjohnson@research.canon.com.au (Greg Johnson) writes:

> Hi y'all,
>
> The buffers I need to IDMA out to a peripheral are allocated by
> the user with conventional malloc, and are rather dynamic so
> the driver does not have a lot of control over them that I can
> see.
>
> So I have decided that I will be flushing the cache, either by
> calling 'flush_page_to_ram' or 'flush_dcache_range'. Now, these
> require a Kernel virtual address to work on (correct?), and the
> caller has given me a User virtual address (through 'write (2)').
> Therefore, before calling the flush function, I need to:
>
> * Convert the User virtual address for each page to a Physical
>   address by doing something along the lines of:
>
>     pgd = pgd_offset(current->mm, addr)
>     pmd = pmd_offset(pgd, addr)
>     pte = pte_offset(pte, addr)
>     etc.
>
> * Convert the Physical address to a Kernel virtual address by
>   calling 'phys_to_virt'.
>
> Then I can call flush on each page I intend to IDMA out.
>
> Does this sound reasonable?

No, you can't do DMA on user-space allocated memory, as you do not
know where the pages are, or even if they are in memory at all,
when the DMA starts. (Well, you could if you use mlock(), know
what you are doing, and are 100% sure that the process will not
die while DMA operations are still pending, but it's bad practise.)

The right thing to do is allocate memory in the driver and allow
the user process to mmap() it.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

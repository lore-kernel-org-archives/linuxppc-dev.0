Message-ID: <3937C38E.86DD80A4@ccrl.mot.com>
Date: Fri, 02 Jun 2000 09:24:14 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: allocating non-cacheable regions
References: <39104A07.D997B6C5@ccrl.mot.com> <3910838C.986942D6@embeddededge.com> <39357BC5.A0B3E713@ccrl.mot.com> <39358E65.145F7EA3@embeddededge.com> <39365EB8.427CD744@ccrl.mot.com> <3936C31C.DFB1CDF0@ccrl.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


well it sort of works. I think I'm running into some strange compiler problems.
There are four scenarios that I'm working with. They are:

compiling driver as a module using x86 cross-compiler - doesn't work
compiling driver as a module using native compiler - works

compiling driver into the kernel using x86 cross-compiler - doesn't work
compiling driver into the kernel using native compiler - sorta works

when I say doesn't work, I mean that invalidate_dcache_range is having no effect -
the powerpc is always getting bad data when it reads memory that was written by the
device - in this case a SCSI controller
when I say sorta works, I mean that what I've observed is the first chunk of data
returned by the scsi controller for the first query command seems to be correct or
partially correct, but subsequent data is not
when I say works - that means it completely works, I can mount the filesystem on the
scsi disk and read and write files with no problem

when I compile on x86 it never works (monta vista cdk, gcc version 2.95.2 19991024
(release)) whether I compile it as a module or into the kernel. compiler
bug? something to do with the fact that invalidate_dcache_range is an assembly
routine? any thoughts on this?

when I compile on ppc (g4 running yellow dog linux cs 1.2, gcc version 2.95.2
19991024 (release/franzo)) I can only get it to work as a module. this is ok, but
not ideal. I would like to be able to compile the driver into the kernel. Does
anyone have any ideas as to why it would be different with respect to regions marked
as no-cache when compiled as a module versus when compiled into the kernel?

will somone verify that my assumptions are correct - the driver that I'm working
with allocates memory for its own data structures - both those used only by the
driver and those shared between the driver and the device - using get_free_pages().
I'm taking the simple approach - attempting to make all of that memory that the
driver allocates non-cacheable - that is I want it to always access external memory
on both write and reads to these addresses and never use the cache.  So for each
call to get_free_pages (which is always called with order = 0 so only returns a
pointer to one page) I track down the pte, mark it as _PAGE_NO_CACHE then flush the
tlb using flush_tlb_page, then invalidate the cache using invalidate_dcache_range
passing the address returned by get_free_pages as the start and that address +
PAGE_SIZE as the end. My assumption is that this is sufficient to ensure that all
further accesses to the addresses within this page will bypass the cache. This
assumption seems to hold for the case of writing to these addresses - as the
_PAGE_NO_CACHE flag appears to force it to writethrough. But I'm a little leary as
to whether I need to invalidate the cache each time before I read these addresses.
I would like to not have to do that. If what I'm doing isn't sufficient to ensure
that reads will never come from the cache, is there something else I can do to
ensure that?

regarding multiple mapping the same physical address - I don't believe that's
happening - or at least the driver isn't doing anything that would cause that to
happen as far as I can tell.

Thanks,
Steve



Steve Rossi wrote:

> Well I found the solution - I needed to added an  extern
> invalidate_dcache_range() declaration to include/asm/cache.h then the kernel will
> compile with invalidate_dcache_range exported in ppc_ksyms.c (contrary to what
> I reported, my problem with compiling the device driver as a module was that the
> kernel wouldn't compile with invalidate_dcache_range exported - not that it
> wouldn't boot. I just wasn't remembering correctly when I wrote that.) Now I can
> compile the driver as a module with invalidate_dcache_range and it works!

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

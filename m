Message-ID: <39365EB8.427CD744@ccrl.mot.com>
Date: Thu, 01 Jun 2000 08:01:44 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: allocating non-cacheable regions
References: <39104A07.D997B6C5@ccrl.mot.com> <3910838C.986942D6@embeddededge.com> <39357BC5.A0B3E713@ccrl.mot.com> <39358E65.145F7EA3@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

>
> > .... How can I make it so that
> > reads as well as writes to a particular page bypass the cache?
>
> You need to invalidate the data cache for this address and the TLB
> entry for this address when you set the flag.  Those drivers in your
> example get away with it because the caches/TLB have been invalidated
> and not yet touched at this point.  You also need to ensure you are not
> multiple mapping the same physical address....
>

I'm invalidating the TLB entry via a call to flush_tlb_page as in the examples
that you pointed me to - which simply maps to tlbia on 8xx. But I haven't yet
figured out how to invalidate the data cache for the entire page. I'm trying
invalidate_dcache_range() - but I'm having really strange problems with it. If
I compile the driver into the kernel with a call to invalidate_dcache_range(),
the kernel won't boot. (It'll get as far as "Uncompressing Linux ..." and
it'll hang). The same happens if I export invalidate_dcache_range in
ppc_ksyms.c in an attempt to load the driver as a module. I haven't looked
into what is going on here - but I do know that it is being caused by the
invalidate_dcache_range being present. Am I totally off base here? Should
I even be using invalidate_dcache_range or is there another method for
invalidating the data cache? A pointer to an example would be sufficient if
anyone has one.

Thanks,
Steve

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

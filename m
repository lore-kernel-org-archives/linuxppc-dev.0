Date: Wed, 15 Aug 2001 00:33:39 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: Dan Malek <dan@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: flush_dcache_range problems
In-Reply-To: <3B79AF73.59EB50C4@mvista.com>
Message-ID: <Pine.LNX.4.33.0108150015240.2590-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 14 Aug 2001, Dan Malek wrote:

> "Justin (Gus) Hurwitz" wrote:
> >
> > Anyone have an idea as to why flush_dcache_range is crashing the kernel on
> > my 603e based board?
>
> Well, a little more information would be helpful.  First, you shouldn't
> need to call it, so a backtrace would be useful.  The whole Linux panic
> printout would be nice, so we can see what is in the registers......


Indeed- I appologize for the brevity of the mail; I knowcked it off as I
ran out of the office this afternoon.

I assume that you say I shouldn't need it because the 603e typically
doesn't need such a call. Our 603e is broken (or, the chipset is): it has
no rupport for hardware snooping.

We're using an Inte; 82596 ethernet chip. This chip requires either
hardware snooping or a region on non-cacheable memory. I have been unable
to get the kernel to allocate the non-cacheable memory, despite trying
many things that have been recommended. In a last ditch effort, I am
trying another approach.

Basically, our driver is nearly identical to drivers/net/lasi_82596.c (I'm
going from memory here- I can get out the code if you give me some more
time later tonight). The lasi_ driver, for a parisc system, uses
pci_consistent_alloc to allocate a block of non-cacheable memory. When
this fails, it resorts to flushing the cache whenever needed, using the
parisc's flush_dcache_range(long start, long size) function (all of the
dma_cache_* functions are macros for flush_dcache_range).

Our driver works perfectly with L1 disabled. We _need_ te L1 enabled
however (the RAM is Reed-Solomon encoded, which up to triples latencies).
With L1 enabled it very quickly bombs. Since I'm been so drastically
unable to get the kernel to allocate non-cached memory on this board (not
for lack of trying, or suggestions from people on the list), I've decided
to borrow the lasi_ driver's cache flushing approach.

Basically, I added a macro to my driver:
#define CC(addr, len)	flush_dcache_range(addr, addr+len)

And wherever there was a CHECK_* macro in the lasi_ driver I added a CC in
my code with the same parameters (remember, despite appearances all of the
three CHECK_* functions in the lasi_ driver all eventually become
flush_dcache_range()'s).

And this crashed dramatically when first called (in i82596_probe(), where
I added the call). And then I looked at my watch and realized I had to be
45 minutes away in 30 minutes (I ended up being 5 minutes late- damn), so
I threw off my email hoping that the working-code fairy would leave a
miracle under my pillow over night :)

If you need any more info, let me know what you need, and I'll get it to
you ASAP :)

Thanks,
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

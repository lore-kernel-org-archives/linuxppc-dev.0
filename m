Message-ID: <3CAC5F5F.9000602@embeddededge.com>
Date: Thu, 04 Apr 2002 09:12:47 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Brad Parker <brad@parker.boston.ma.us>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
References: <200204041235.g34CZDw22993@p2.parker.boston.ma.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brad Parker wrote:

> Maybe I need to go drink some coffee, but I'm confused by this thread.

I'll try to explain it in more detail.

> The real problem, as I recall, was that cache invalidate routine one
> in the 405 port didn't respect the addresses handed to it and instead
> invalidated the entire cache line, even if it went beyond the address
> range provided.

You can't invalidate, flush, manage anything less than a cache line.

The problem is the same on all processors, it doesn't matter how the
DMA object is allocated either.  Suppose you have a processor with
something larger than an 8 byte cache line. Suppose you have some DMA buffer
(kmalloc'ed or just static declared), that is only 8 bytes for example,
and it starts at memory location 0x1000.  Suppose the processor (or
another DMA) had some data that starts at location 0x1008.  The logically
correct thing to do for an incoming DMA is to first invalidate the
cache line, then do the DMA, then when the processor accesses the
DMA buffer it will re-load the cache line.  In this example, if the
processor writes some variable at location 0x1008, the invalidate
will also invalide this processor data, which is wrong.  The next
access by the processor to this variable will read some old piece
of data, not the last thing it wrote to memory.

So, the solution was to first flush this line, then invalidate it.
Well, that works better but still isn't correct.  If the processor
accesses the memory at location 0x1008 before the DMA is complete,
then the cache line is filled with the old stale DMA buffer, and
when the processor accesses the DMA buffer you don't get the
data that is the result of the DMA.

The only reason this patch appears to work is because we are lucky,
and the processor doesn't access anything in the cache line prior
to the DMA completion.

It's the same for all incoherent processors.  Memory is accessed
in cache line chunks, you can't invalidate, flush or otherwise
manage part of a cache line.  The stack is a weird place to put
a DMA buffer, but that has nothing to do with this problem.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

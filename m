Message-ID: <3D0A1D53.6040205@embeddededge.com>
Date: Fri, 14 Jun 2002 12:44:03 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: consistent_free()
References: <20020614042928.GK26146@zax> <20020614153954.GL13541@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:


> My only concern is that is it a good idea to make a 'consistent_alloc'
> and 'consistent_free' functions for  cache-cohernet processors, which
> aren't doing what the name implies?

I don't like it either, but that doesn't seem to matter these days.
In light of the recent discussions about clarity of code, I think the
changes did nothing but make it harder to understand and added nothing
to the value of the functions.

The original purpose of the consistent_alloc() functions was to provide
uncached memory on noncoherent processors that have integrated (or non-PCI)
peripherals.  It just so happened to work (mostly) with the same type of
processors that had a PCI bus, so it was convenient to adapt the PCI
functions to use these.


> I wonder if ARM couldn't just call vfree() like we do..

I've been tracking that, and it may be due to a useful enhancement
they made to consistent_alloc().

The other issue here is these functions are somewhat architecture
specific, but they are expected to work the same way across all platforms.
By keeping similar code in all of these functions, and the same
calling parameters, it is easy to maintain this compatibility.

These functions are not replacements for the pci_* functions, but they
can be used when appropriate.  I thought the way I originally implemented
these functions made it obvious, especially on PowerPC where we have
both coherent and noncoherent caches.

> In fact, I wonder why consistent_alloc/free seem to have some minor
> differences (__get_free_pages vs alloc_pages seems to be the only real
> difference aside from style things).

The newer ARM version only allocates the number of pages necessary to
cover the request.  The old version, and the one in PowerPC right now,
would just use __get_free_pages, which was a power-of-two allocator.
You could end up wasting lots of memory if you weren't allocating power of
two sized buffers.  There were a couple of implementation iterations
to make this work, and I guess this is where ARM ended up.  I think
one version really wanted that page struct, but now it doesn't really matter.

The original use of these functions was for the integrated USB controllers,
so I suspect if anyone tries that on the 8xx today, they will break.  I
don't know how many other peripherals use these functions, except for the
4xx and 8xx that we use locally (and will obviously still work).

> ....  Dan?  Can we get some more insight
> into the workings of your mind? :)

I've been watching the ARM updates and plan to move their changes into
the PowerPC sources.  I don't know why they don't call vfree() directly,
I thought it did the proper clean up.  In any case we will have to adopt
the number of calling parameters, and just ignore the ones we don't need.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

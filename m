Date: Thu, 4 Apr 2002 15:23:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
Message-ID: <20020404052349.GN21034@zax>
References: <20020403024321.GN1026@zax> <3CAB3F0B.8080700@embeddededge.com> <20020403234051.GG21034@zax> <3CABC065.6050107@embeddededge.com> <20020404034809.GL21034@zax> <3CABD1E0.7020008@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CABD1E0.7020008@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 03, 2002 at 11:09:04PM -0500, Dan Malek wrote:
>
> David Gibson wrote:
>
> >Oh, right, yes.  That was actually what I was meaning when I said
> >"aligned" (sort of aligned at both ends), forgetting that the normal
> >meaning only applies to the start address.
>
> I guess if we can ensure a DMA-only pool, simple alignment will work.
> You just can't kmalloc() because you don't know what may follow something
> that isn't modulo cache line size.  You also have to be careful of code
> that allocates a large object, then uses part of it for DMA and other
> parts for processor core data.  I'm not sure we want to require kmalloc()
> to always cache align due to the potential for wasted memory space.

kmalloc() already guarantess cacheline alignment (at the beginning).
Which means it is safe as long as the allocation is a multiple of the
cacheline size (which comes for free on allocations of a largish power
of 2, a common case).

Possibly a better approach would be to make the consistent_sync()
function be more careful and flush rather than invalidate cachelines
which are only partially covered by the region given.  At the moment
it invalidates everything and hence is only safe for regions which are
cacheline aligned, and of size a multiple of cacheline size.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Thu, 4 Apr 2002 09:40:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
Message-ID: <20020403234051.GG21034@zax>
References: <20020403024321.GN1026@zax> <3CAB3F0B.8080700@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CAB3F0B.8080700@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 03, 2002 at 12:42:35PM -0500, Dan Malek wrote:
>
> David Gibson wrote:
>
> >Well, I'm not sure I'd want to pollute the tree with this sort of
> >hack, but on the other hand it makes things work that wouldn't
> >otherwise.
>
> This has been floating around for a long time while we were searching
> for the proper solution.  As you said, if you want things to work, you
> have to do this.  This still isn't logically correct, it just makes
> the window of error smaller.

I'm well aware of that.  In fact I think for most cases in the USB
stack it is safe because the buffers in question are quite a long way
up the stack by the time the DMA is initiated, and the code waits for
the transfer to complete before it pops enough stack frames to touch
this area.  Nonetheless it's certainly a hack and a workaround, not a
solution.

> This is one of several problems in the Linux kernel that has to be
> solved for processors that don't have bus snooping.  All we have been
> doing over time is making the problems less apparent, not solving them.
> There are similar hacks for DMA into sk buffers, which still doesn't
> work in forwarding/bridging applications (you won't notice the bugs
> in endpoint only situations).

Indeed, and the USB people realise that.  Well, amongst other things.
DMA buffers on the stack have other problems as well (I believe the
stack isn't guaranteed physically contiguous on all architectures).

> The real problem to be solved is any memory object that can be the target
> for DMA has to be cache line aligned, and modulo cache line size for
> incoherent processors.  Since few people work with this type of processor,
> it is hard to get maintainers interested in making these general changes
> (and polluting the Linux kernel with knowledge of cache line size).

It's becoming easier though, with the __cacheline_aligned macro.  Plus
I think if the buffer is individually kmalloc()ed it will be properly
aligned.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

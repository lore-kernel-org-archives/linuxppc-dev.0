Date: Thu, 4 Apr 2002 09:34:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
Message-ID: <20020403233410.GE21034@zax>
References: <20020403024321.GN1026@zax> <3CAABAB0.5030000@pacbell.net> <3CAB40C1.8000909@embeddededge.com> <3CAB6955.6000103@routefree.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CAB6955.6000103@routefree.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 03, 2002 at 12:43:01PM -0800, David Blythe wrote:
>
> What he said!  We ended up making all of the changes to move buffers,
> align them, etc for both USB and skbuffs, as well as fixing the overly
> aggressive prefetches in memcpy that overlapped previously
> cache-invalidated memory, etc.  The end result is an ugly set of
> changes, but at least the board works reliably now.  We also found one
> nasty problem with an Epson USB printer where after request buffers were
> bloated to cache line aligned length and the bloated length passed to
> the device, that the device doesn't like the bloated length.  So we
> hacked up the control path a little to get at the original length  too.
>  This sort of stuff is a real pain to fix correctly to deal nicely with
> non-coherent systems.

That sounds closer to the correct way of fixing this.  The USB folks
do consider this a bug, and I heard murmurs that suggested this had
already been fixed in 2.5.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

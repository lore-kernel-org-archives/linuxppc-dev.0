Date: Fri, 07 Jun 2002 22:18:48 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] USB on PPC440GP (cache incoherent)
To: Roland Dreier <roland@topspin.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	linux-usb-devel@lists.sourceforge.net
Message-id: <3D0193B8.9030500@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <52hekebq2a.fsf@topspin.com> <3D0171F2.4080602@pacbell.net>
 <528z5qbfl3.fsf@topspin.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>     David> Could you elaborate?  Documentation/DMA-mapping.txt says
>     David> that kmalloc returns data suitable for DMA, you are saying
>     David> otherwise.  The DMA mapping calls are supposed to handle
>     David> cache flushing as needed.  If they don't, a lot of code
>     David> will be breaking ...
>
> I don't know for a fact that there is an architecture where it breaks,
> but the idea is that for the 440GP, pci_map_single() with
> PCI_DMA_FROMDEVICE invalidates the cache for the memory it is
> mapping.  At least on the 440GP, you can only invalidate entire cache
> lines, which means that if the buffer you are using is smaller than a
 > cache line then you can get memory corruption.

Or more specifically, cache lines can't be shared between DMA and non-DMA
purposes while a DMA mapping is active ... regardless of the size of the
buffer, its start and end could potentially have such cacheline problems.
That makes good sense to me, and I suspect it'd be worth listing the issue
in DMA-mapping.txt. (Assuming the relevant gurus corrroborate... :)

That text might vaguely allude to the issue, it says you can use "the
addresses returned from those routines" (kmalloc and friends) ... but
of course, kmalloc effectively returns a family of addresses (one for
each byte returned).  Docs on "What memory is DMA-able" have slowly
been improving; I can understand why such caching issues might not yet
be well addressed.


> The hub.h change moved the buffer member out of struct usb_hub into
> its own kmalloc'ed buffer.  I don't know that having buffer be part of
> usb_hub was actually causing problems, but I don't think it was safe
> for the reasons I described above: buffer was not cache line aligned
> and was smaller than a cache line, so mixing DMA access into buffer
> and access to other members of struct usb_hub could cause corruption.

A simpler alternate fix might have been to declare that field as aligned,
which I think goes more or less like

	char buffer [...] __attribute__ (aligned (L1_CACHE_BYTES));

and size it accordingly, maybe after rearranging fields.  In any case,
given the subtlety of this issue I'd want to see a comment mentioning
the issue, so it stays safe across many generations of maintainers!

- Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

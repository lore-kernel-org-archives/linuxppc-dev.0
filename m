To: David Brownell <david-b@pacbell.net>
Cc: linuxppc-embedded@lists.linuxppc.org,
	linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] USB on PPC440GP (cache incoherent)
References: <52hekebq2a.fsf@topspin.com> <3D0171F2.4080602@pacbell.net>
From: Roland Dreier <roland@topspin.com>
Date: 07 Jun 2002 20:43:20 -0700
In-Reply-To: <3D0171F2.4080602@pacbell.net>
Message-ID: <528z5qbfl3.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "David" == David Brownell <david-b@pacbell.net> writes:

    Roland> Note that this might not work perfectly on all
    Roland> cache-incoherent processors, since kmalloc could
    Roland> potentially allocate a chunk of memory that is smaller
    Roland> than the processor's cache line size.  However it is safe
    Roland> on the 440GP since the 440GP's cache line size is 32
    Roland> bytes.

    David> Could you elaborate?  Documentation/DMA-mapping.txt says
    David> that kmalloc returns data suitable for DMA, you are saying
    David> otherwise.  The DMA mapping calls are supposed to handle
    David> cache flushing as needed.  If they don't, a lot of code
    David> will be breaking ...

I don't know for a fact that there is an architecture where it breaks,
but the idea is that for the 440GP, pci_map_single() with
PCI_DMA_FROMDEVICE invalidates the cache for the memory it is
mapping.  At least on the 440GP, you can only invalidate entire cache
lines, which means that if the buffer you are using is smaller than a
cache line then you can get memory corruption.  The 440GP does not
flush the cache for PCI_DMA_FROMDEVICE, and even if it did, you could
still have problems if you access the same cache line as the buffer is
in before the DMA completes.

The smallest buffer that kmalloc() will give you is 32 bytes.  If
there is an architecture with cache lines bigger than 32 bytes that is
not cache coherent for DMA and only allows entire cache lines to be
invalidated, then using a kmalloc'ed buffer for DMA could cause
problems if it smaller than a cache line.

    David> This hub.h change (and its follow-ons) should not be
    David> necessary since the struct usb_hub is already allocated
    David> using kmalloc() in hub_probe(), and so it's DMA-ready.
    David> (Modulo the spec issue noted above for DMA-mapping.txt of
    David> course!)

The hub.h change moved the buffer member out of struct usb_hub into
its own kmalloc'ed buffer.  I don't know that having buffer be part of
usb_hub was actually causing problems, but I don't think it was safe
for the reasons I described above: buffer was not cache line aligned
and was smaller than a cache line, so mixing DMA access into buffer
and access to other members of struct usb_hub could cause corruption.

Thanks,
  Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

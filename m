MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16148.36759.265625.268038@nanango.paulus.ozlabs.org>
Date: Wed, 16 Jul 2003 09:34:47 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Darin.Johnson@nokia.com
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [RFC] consistent_sync and non L1 cache line aligned buffers
In-Reply-To: <F0B628F30F48064289D8CCC1EE21B7A80C48A8@mvebe001.americas.nokia.com>
References: <F0B628F30F48064289D8CCC1EE21B7A80C48A8@mvebe001.americas.nokia.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Darin.Johnson@nokia.com writes:

> > IMHO, the easiest solution is
> > alignment of buffers.....plus it's likely to be a performance
> > improvement.
>
> True, it's the easiest solution for the kernel developer, but
> requires more work from driver authors.  Which is ok, *if* it's

If you think about it, you will see that if you are doing DMA to an
unaligned buffer, and some other unrelated part of the kernel is
accessing another part of the cache line, you are in trouble no matter
what sequence of cache flushes/invalidates/whatever you do.

In other words, the driver MUST own the entire extent of all the cache
lines that overlap the DMA buffer.  There really is no other solution
on cache-incoherent machines, assuming you want to allow DMA to
proceed in parallel with the CPU executing other arbitrary code, which
is really the whole point of DMA.

How to achieve that has been the subject of much debate.  It's clear
that tweaks to consistent_sync won't do it, though.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

From: Darin.Johnson@nokia.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [RFC] consistent_sync and non L1 cache line aligned buffers
Date: Tue, 15 Jul 2003 13:18:31 -0700
Message-ID: <F0B628F30F48064289D8CCC1EE21B7A80C48A5@mvebe001.americas.nokia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> invalidate_dcache_range works in L1_CACHE_LINE chunks, so if
> start and/or
> end of the buffer are not aligned we may corrupt data located
> in the same
> cache line (usually stack variable(s) declared before or after buffer
> declaration).

I had noticed this a long time ago when looking to see how PowerPC
Linux had solved this problem, but discovered that it just sidestepped
the problem.

I solved the problem (in a non-Linux system) by just flushing the first
and last lines in the requested range, and invalidating the rest.  The
very slight performance hit is probably less than testing to see if the
buffer is unaligned.

> To be safe I think it's better to modify consistent_sync to
> handle such
> "bad" buffers.

"Bad" is the wrong word to use, in my opinion.  If the function is
not called "invalidate_aligned_dcache_range", or is not otherwise
clearly and unambiguously documented (in an easy to locate place)
that there are severe restrictions on the input parameters, then
the function itself is "bad".  The "principle of least astonishment"
implies that a function should do just what its name implies without
hidden surprises.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

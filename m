MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16217.57099.255798.871698@cargo.ozlabs.ibm.com>
Date: Sat, 6 Sep 2003 23:20:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Copy prefetch optimizations and non-coherent caches
In-Reply-To: <5.1.0.14.2.20030905220237.00b084b8@mail.ebshome.net>
References: <5.1.0.14.2.20030905220237.00b084b8@mail.ebshome.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eugene Surovegin writes:

> There are read prefetch optimization in several PPC specific functions
> responsible for copying memory (copy_page, __copy_tofrom_user). Current
> implementations will try to prefetch up to 4 (MAX_COPY_PREFETCH) cache
> lines _after_ the end of the source buffer.
>
> Unfortunately, it's not a good idea on non-coherent cache CPUs. This
> prefetching may establish cache lines for memory ranges that require
> exactly the opposite (e.g. DMA read buffer).

You are right.

> I think we should disable prefetch if CONFIG_NONCOHERENT_CACHE is defined.
> Other more complex solutions are possible, e.g. we can still prefetch our
> own buffer but don't touch anything outside (I'll try to do some
> performance testing to determine whether it's worth the effort :).

The measurements I did on a ppc64 kernel indicated that most
copy_tofrom_user calls were either for relatively small buffers
(i.e. less than 256 bytes) or were page-sized and page-aligned.
Therefore I did two routines, one optimized for small copies that
didn't use any prefetching or dcbz's, and one optimized for page-sized
copies.

We could do something similar on ppc32 - we could do the small copy
case with no prefetching (or maybe we could just prefetch on the first
cache line), plus a page-copy case that does prefetching.  If you know
you are doing exactly one page, it shouldn't be hard to set up the
prefetching so you don't prefetch past the end of the source buffer.
In fact it should be possible to code up a relatively simple optimized
copy loop that avoids prefetching outside the source region if we just
assume that the source and destination addresses are
cacheline-aligned, and the size is a multiple of the cacheline size
and is at least 8 (say) cache lines.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-Id: <5.1.0.14.2.20030909221313.00b13008@mail.ebshome.net>
Date: Tue, 09 Sep 2003 22:54:10 -0700
To: Paul Mackerras <paulus@samba.org>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Copy prefetch optimizations and non-coherent caches
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <16217.57099.255798.871698@cargo.ozlabs.ibm.com>
References: <5.1.0.14.2.20030905220237.00b084b8@mail.ebshome.net>
 <5.1.0.14.2.20030905220237.00b084b8@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 06:20 AM 9/6/2003, Paul Mackerras wrote:
> > I think we should disable prefetch if CONFIG_NONCOHERENT_CACHE is defined.
> > Other more complex solutions are possible, e.g. we can still prefetch our
> > own buffer but don't touch anything outside (I'll try to do some
> > performance testing to determine whether it's worth the effort :).

I did some simple testing on Ebony, and it turns out that read prefetching
gives significant performance boost (~30%).

>The measurements I did on a ppc64 kernel indicated that most
>copy_tofrom_user calls were either for relatively small buffers
>(i.e. less than 256 bytes) or were page-sized and page-aligned.
>Therefore I did two routines, one optimized for small copies that
>didn't use any prefetching or dcbz's, and one optimized for page-sized
>copies.
>
>We could do something similar on ppc32 - we could do the small copy
>case with no prefetching (or maybe we could just prefetch on the first
>cache line), plus a page-copy case that does prefetching.  If you know
>you are doing exactly one page, it shouldn't be hard to set up the
>prefetching so you don't prefetch past the end of the source buffer.
>In fact it should be possible to code up a relatively simple optimized
>copy loop that avoids prefetching outside the source region if we just
>assume that the source and destination addresses are
>cacheline-aligned, and the size is a multiple of the cacheline size
>and is at least 8 (say) cache lines.

Frankly, I don't feel to be qualified to do such significant changes to
__copy_tofrom_user :).

So, I tried to modify copy_page and __copy_tofrom_user as little as
possible and make them non-coherent cache safe while still using read
prefetching. Idea is simple, we prefetch as before but only till the end of
the source buffer.

Updated patches:

  - against linuxppc-2.4: http://kernel.ebshome.net/read_prefetch-2.4-2.diff

  - against linuxppc-2.5 (not tested, but compiles):
http://kernel.ebshome.net/read_prefetch-2.6-2.diff

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Wed, 8 Oct 2003 14:51:29 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Eugene Surovegin <ebs@ebshome.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Copy prefetch optimizations and non-coherent caches
Message-ID: <20031008145129.B5536@home.com>
References: <5.1.0.14.2.20030905220237.00b084b8@mail.ebshome.net> <16217.57099.255798.871698@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16217.57099.255798.871698@cargo.ozlabs.ibm.com>; from paulus@samba.org on Sat, Sep 06, 2003 at 11:20:11PM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Sep 06, 2003 at 11:20:11PM +1000, Paul Mackerras wrote:
>
> Eugene Surovegin writes:
> > I think we should disable prefetch if CONFIG_NONCOHERENT_CACHE is defined.
> > Other more complex solutions are possible, e.g. we can still prefetch our
> > own buffer but don't touch anything outside (I'll try to do some
> > performance testing to determine whether it's worth the effort :).
>
> The measurements I did on a ppc64 kernel indicated that most
> copy_tofrom_user calls were either for relatively small buffers
> (i.e. less than 256 bytes) or were page-sized and page-aligned.
> Therefore I did two routines, one optimized for small copies that
> didn't use any prefetching or dcbz's, and one optimized for page-sized
> copies.
>
> We could do something similar on ppc32 - we could do the small copy
> case with no prefetching (or maybe we could just prefetch on the first
> cache line), plus a page-copy case that does prefetching.  If you know
> you are doing exactly one page, it shouldn't be hard to set up the
> prefetching so you don't prefetch past the end of the source buffer.
> In fact it should be possible to code up a relatively simple optimized
> copy loop that avoids prefetching outside the source region if we just
> assume that the source and destination addresses are
> cacheline-aligned, and the size is a multiple of the cacheline size
> and is at least 8 (say) cache lines.

It seems that the current version of __copy_tofrom_user() is
optimized for the page-aligned/cacheline-aligned case. i.e. it
seems that there isn't much overhead in detecting that there
are 0 bytes to the start of a cache line and then jumping to
the prefetching line copy. Would it be enough to just simply
detect <256-byte copies and use the non-prefetching byte copy
loop for those buffers while using the full current version
for all other cases?

This is, of course, in combination with Eugene's patch to ensure
that no prefetch past the end of the buffer occurs.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

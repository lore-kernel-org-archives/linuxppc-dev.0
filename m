Message-ID: <3B4CAC0E.2D08B233@aps.anl.gov>
Date: Wed, 11 Jul 2001 14:42:06 -0500
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How fast should a bogomip be
References: <Pine.LNX.3.95.1010711084748.21073D-100000@november.bhjjh.erols.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Justin (Gus) Hurwitz" wrote:
>
> I've seen numbers that indicate on 6xx series processors bogomips is
> usually about 2/3 the processor speed- so about 66.6 for a 100Mhz
> processor. I hope this is accurate, because that's what I'm getting.

When running with cache that sounds right from my very limited experience.

> But, about what should I expect for a 6xx (603e) 100Mhz processor running
> without cache? I've been trying to disable cache so I can continue
> development until the kernel supports propper allocation of non-cacheable
> memory (on a 603e with broken memory controller). When I run the kernel
> with code changes that *should* disable the cache the bootup process does
> feel marginally slower, and bogomips goes down a whopping .64 (from 66.56
> to 65.92). It then crashes with a segfault in kupdated (when in _wake_up).
> And I've been scratching my head trying to figure out a) whether the
> caches are actually disabled b) what causes that segfault, and c) how the
> two are related.

I can't help with the crash except to suggest that your patch isn't doing
what you think, and it certainly isn't disabling your cache.  Could the
segfault be related to the the broken memory controller?

I was porting to a 200 MHz MPC8240 (ppc603ek?) board and initially had the
wrong code in head.S, such that the cache was not being enabled.  The
BogoMIPS rating was then about 9.5; with the cache properly enabled I now
get 133.2 (~200*2/3).  I suspect that the difference is a measurement of
the relative speed of the cache RAM compared to the main RAM - a factor of
13, which certainly seems in the right ballpark.

- Andrew
--
The world is such a cheerful place when viewed from upside-down
It makes a rise of every fall, a smile of every frown

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

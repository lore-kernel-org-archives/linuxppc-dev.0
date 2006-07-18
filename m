Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17597.8378.972640.464219@cargo.ozlabs.ibm.com>
Date: Wed, 19 Jul 2006 03:56:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: <matt@genesi-usa.com>
Subject: RE: AltiVec in the kernel
In-Reply-To: <005701c6aa7c$632a48e0$99dfdfdf@bakuhatsu.net>
References: <E40C6B7A-F2E8-4DB8-97D3-2CFF88C1D90A@kernel.crashing.org>
	<005701c6aa7c$632a48e0$99dfdfdf@bakuhatsu.net>
Cc: 'linuxppc-dev list' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey writes:

> Why isn't it recommended?

Because the overhead of saving away the user altivec state and
restoring it can easily overwhelm any advantage you get from using
altivec.

> We had our own guy look at it and he presented some significant
> performance improvements. One problem was, though, that the best
> improvement in theory came from a function which needed to be
> called very early in kernel boot, well before AltiVec was
> enabled, and everything else is marginal at best (1.n times
> improvement, but it is still 0.n more than 1.0). I am not clear
> on this and cannot find my discussion on the subject in my logs
> and email backups, so. I will leave it for now. 

I tried using altivec for memory copies, and while I was able to show
an improvement in speed of copying stuff that was hot in the cache,
there was no overall improvement in the context of everything else the
kernel does.  In other words, the things being copied were generally
not hot in the cache, and the CPU was able to saturate the memory
bandwidth using ordinary loads and stores.

> There is also plenty of example code (libmotovec, Freescale
> Application Notes) which improve things like TCP checksumming
> and so on using AltiVec. These patches are even used in EEMBC
> benchmarks to boost the scores.

TCP checksumming is simple enough that it is limited by memory
bandwidth rather than computation speed.  This is another example
where you can show an improvement on a microbenchmark because the data
is hot in the cache, but the improvement doesn't translate into any
real improvement in a real application.

> There is also plenty of examples of userspace code (as before,
> checksumming, encryption, compression/decompression) which has
> been improved. libfreevec includes some changes to the zlib
> window functions. For example the kernel includes an MD5, SHA,
> zlib compression framework.. mostly ported userspace code and
> standard libraries. Would these not be candidates?

A lot of compression and encryption algorithms, by their very nature,
are very difficult to parallelize enough to get any significant
improvement from altivec.  I looked at SHA1 for instance, and the
sequential dependencies in the computation are such that it is
practically impossible to find a way to do 4 things in parallel.  The
sequential dependencies are of course a critical part of the way that
SHA1 ensures that a small change in any part of the input data results
in substantial changes in every byte of the output.

> I think there are thousands of places where AltiVec could be
> used - even sparingly - to provide good performance improvements.

I think that there are actually very few places in the kernel where we
are doing something which is parallelizable, sufficiently
compute-intensive, and not bound by memory bandwidth, to be worth
using altivec.

Paul.

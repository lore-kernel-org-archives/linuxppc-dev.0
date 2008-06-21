Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18524.33738.450400.63491@cargo.ozlabs.ibm.com>
Date: Sat, 21 Jun 2008 14:30:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [RFC 1/3] powerpc: __copy_tofrom_user tweaked for
	Cell
In-Reply-To: <200806210400.20794.arnd@arndb.de>
References: <200806191753.59599.markn@au1.ibm.com>
	<OF3C6636F6.52E3D242-ONC125746D.005214B0-C125746D.0053FABE@de.ibm.com>
	<18523.1109.809247.646816@cargo.ozlabs.ibm.com>
	<200806210400.20794.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> On Friday 20 June 2008, Paul Mackerras wrote:
> 
> > Transferring data over loopback is possibly an exception to that.
> > However, it's very rare to transfer large amounts of data over
> > loopback, unless you're running a benchmark like iperf or netperf. :-/
> 
> Well, it is the exact case that came up in a real world scenario
> for cell: On a network intensive application where the SPUs are
> supposed to do all the work, we ended up not getting enough
> data in and out through gbit ethernet because the PPU spent
			  ^^^^^^^^^^^^^
Which isn't loopback... :)

I have no objection to improving copy_tofrom_user, memcpy and
copy_page.  I just want to make sure that we don't make things worse
on some platform.

In fact, Mark and I dug up some experiments I had done 5 or 6 years
ago and just ran through all the copy loops I tried back then, on
QS22, POWER6, POWER5+, POWER5, POWER4, 970, and POWER3, and compared
them to the current kernel routines and the proposed new Cell
routines.  So far we have just looked at the copy_page case (i.e. 4kB
on a 4kB alignment) for cache-cold and cache-hot cases.
Interestingly, some of the routines I discarded back then turn out to
do really well on most of the modern platforms, and quite a lot better
on Cell than Gunnar's code does (~10GB/s vs. ~5.5GB/s in the hot-cache
case, IIRC).  Mark is going to summarise the results and also measure
the speed for smaller copies and misaligned copies.

As for the distribution of sizes, I think it would be worthwhile to
run a fresh set of tests.  As I said, my previous results showed most
copies to be either small (<= 128B) or a multiple of 4k, and I think
that was true for copy_tofrom_user as well as memcpy, but that was a
while ago.

> much of its time in copy_to_user.
> 
> Going to 10gbit will make the problem even more apparent.

Is this application really transferring bulk data and using buffers
that aren't a multiple of the page size?  Do you know whether the
copies ended up being misaligned?

Of course, if we really want the fastest copy possible, the thing to
do is to use VMX loads and stores on 970, POWER6 and Cell.  The
overhead of setting up to use VMX in the kernel would probably kill
any advantage, though -- at least, that's what I found when I tried
using VMX for copy_page in the kernel on 970 a few years ago.

> Doing some static compile-time analysis, I found that most
> of the call sites (which are not necessarily most of
> the run time calls) pass either a small constant size of
> less than a few cache lines, or have a variable size but are
> not at all performance critical.
> Since the prefetching and cache line size awareness was
> most of the improvement for cell (AFAIU), maybe we can
> annotate the few interesting cases, say by introducing a
> new copy_from_user_large() function that can be easily
> optimized for large transfers on a given CPU, while
> the remaining code keeps optmizing for small transfers
> and may even get rid of the full page copy optimization
> in order to save a branch.

Let's see what Mark comes up with.  We may be able to find a way to do
it that works well across all current CPUs and also is OK for small
copies.  If not we might need to do what you suggest.

Regards,
Paul.

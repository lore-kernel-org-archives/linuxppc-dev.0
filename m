Return-Path: <dgibson@ozlabs.org>
Date: Tue, 15 Jul 2008 10:44:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: dtc: Address an assortment of portability problems
Message-ID: <20080715004450.GC26640@yookeroo.seuss>
References: <20080626010349.GH308@yookeroo.seuss> <E1KITC5-0006rG-EI@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1KITC5-0006rG-EI@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Benno Rice <benno@jeamland.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 14, 2008 at 01:54:41PM -0500, Jon Loeliger wrote:
> > I've recently worked with a FreeBSD developer, getting dtc and libfdt
> > working on FreeBSD.  This showed up a number of portability problems
> > in the dtc package which this patch addresses.  Changes are as
> > follows:
> > 
> > 	- the parent_offset and supernode_atdepth_offset testcases
> > used the glibc extension functions strchrnul() and strndupa().  Those
> > are removed, using slightly longer coding with standard C functions
> > instead.
> > 
> > 	- some other testcases had a #define _GNU_SOURCE for no
> > particular reason.  This is removed.
> > 
> > 	- run_tests.sh has bash specific constructs removed, and the
> > interpreter changed to /bin/sh.  This apparently now runs fine on
> > FreeBSD's /bin/sh, and I've also tested it with both ash and dash.
> > 
> > 	- convert-dtsv0-lexer.l has some extra #includes added.  These
> > must have been included indirectly with Linux and glibc, but aren't on
> > FreeBSD.
> > 
> > 	- the endian handling functions in libfdt_env.h, based on
> > endian.h and byteswap.h are replaced with some portable open-coded
> > versions.  Unfortunately, these result in fairly crappy code when
> > compiled, but as far as I can determine there doesn't seem to be any
> > POSIX, SUS or de facto standard way of determining endianness at
> > compile time, nor standard names for byteswapping functions.
> > 
> > 	- some more endian handling, from testdata.h using the
> > problematic endian.h is simply removed, since it wasn't actually being
> > used anyway.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> This patch didn't apply directly.
> 
> The problem appeared to be the  mysterious and suspect "exit 99"
> in the middle of the following context.  I whacked on the patch
> directly by-hand, and managed to get it to apply.

Sod.  When working I usually have an extra patch in my stack that adds
that exit 99 - it's easier to find and fix testsuite failures when it
bombs out after the first one.

Obviously, I forgot to double check that it didn't leak into the
context :(.  Sorry.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

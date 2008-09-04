Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18623.16970.61036.731524@cargo.ozlabs.ibm.com>
Date: Thu, 4 Sep 2008 12:04:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: "prodyut hazarika" <prodyuth@gmail.com>
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
In-Reply-To: <49c0ff980809031333g1b63694bkffbacb0ae8112120@mail.gmail.com>
References: <200808251131.02071.david.jander@protonic.nl>
	<200809010923.28616.david.jander@protonic.nl>
	<1220261775.5234.217.camel@gentoo-jocke.transmode.se>
	<200809021512.10132.david.jander@protonic.nl>
	<49c0ff980809031333g1b63694bkffbacb0ae8112120@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, David Jander <david.jander@protonic.nl>,
	John Rigby <jrigby@freescale.com>, munroesj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

prodyut hazarika writes:

> glibc memxxx for powerpc are horribly inefficient. For optimal performance,
> we should should dcbt instruction to establish the source address in cache, and
> dcbz to establish the destination address in cache. We should do
> dcbt and dcbz such that the touches happen a line ahead of the actual copy.
> 
> The problem which is see is that dcbt and dcbz instructions don't work on
> non-cacheable memory (obviously!). But memxxx function are used for both
> cached and non-cached memory. Thus this optimized memcpy should be smart enough
> to figure out that both source and destination address fall in
> cacheable space, and only then
> used the optimized dcbt/dcbz instructions.

I would be careful about adding overhead to memcpy.  I found that in
the kernel, almost all calls to memcpy are for less than 128 bytes (1
cache line on most 64-bit machines).  So, adding a lot of code to
detect cacheability and do prefetching is just going to slow down the
common case, which is short copies.  I don't have statistics for glibc
but I wouldn't be surprised if most copies were short there also.

The other thing that I have found is that code that is optimal for
cache-cold copies is usually significantly slower than optimal for
cache-hot copies, because the cache management instructions consume
cycles and don't help in the cache-hot case.

In other words, I don't think we should be tuning the glibc memcpy
based on tests of how fast it copies multiple megabytes.

Still, for 6xx/e300 cores, we probably do want to use dcbt/dcbz for
larger copies.  We don't want to use dcbt/dcbz on the larger 64-bit
processors (POWER4/5/6) because the hardware prefetching and
write-combining mean that dcbt/dcbz don't help and just slow things
down.

Paul.

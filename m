Return-Path: <sfr@canb.auug.org.au>
Date: Sat, 6 Aug 2005 00:59:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Message-Id: <20050806005941.5d1fe432.sfr@canb.auug.org.au>
In-Reply-To: <200508051353.23750.arnd@arndb.de>
References: <1123023575.2614.25.camel@cashmere.sps.mot.com>
	<688ba2276de281a9473b030a16a514c0@embeddededge.com>
	<20050805174705.731ffa05.sfr@canb.auug.org.au>
	<200508051353.23750.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] 1/2 Start header file merger (Was: Re: Beginning Merger
 Patch)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd,

On Fri, 5 Aug 2005 13:53:22 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> While I really like your approach in general (I've done it the
> same way when merging asm-s390{,x]), I think we should take
> a little care to move only the files that we really want in
> asm/powerpc.

Sure, this was just a first pass - really to demonstrate that we
can remove header files from their original directories as we go.

> E.g, most of the files that are in asm-ppc but not in asm-ppc64
> seem so be board-specific or cpu-specific, so I'd not move them
> around before (unless) moving the platform code for those as well.

Indeed.

> Also, for everything below include/asm-ppc64/iSeries, it would
> make sense to rename the files to lowercase in the same
> step and change all their users.

That would definitely be a separate set of patches (those include
files are referenced in 47 different files).

> Another help for merging further is to do 
> 
> for i in `ls include/asm-ppc` ; do 
> 	if [ -e include/asm-ppc64/$i ] ; then
> 		diff --ifdef __powerpc64__ include/asm-{ppc,ppc64}/$i > \
> 			include/asm-generic/$i ;
                                    ^^^^^^^
(I assume you meant powerpc as we are not the generic architecture, yet :-))

> 	fi
> done
> 
> Note that you need to hand-edit practically every file that you get from
> this, but many of them become trivial to merge.

I'll have a go and see what happens.

> Another interesting point about it is which define to use. For s390, we
> decided to '#ifdef __s390x__' rather than '#ifdef CONFIG_ARCH_S390X' or
> 'ifdef CONFIG_64BIT', because CONFIG_* does not work when including the
> headers from user space.

Well noone should even include kernel headers from user space :-) and my
understanding is that glibc "sanitizes" its version of the kernel headers
anyway.

> Using CONFIG_64BIT instead of __powerpc64__ only within #ifdef __KERNEL__
> would be correct but less consistant.

The advantage of using CONFIG_64BIT as much as possible is that it shows
us places that can be consolidated across the various architectures
(which is a bit of a passion of mine :-)).  And more consolidation should
make life easier for the glibc folks in the long run.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

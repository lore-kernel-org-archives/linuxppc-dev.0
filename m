Return-Path: <olof@lixom.net>
Date: Thu, 12 Apr 2007 21:03:09 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH] selection of CPU optimization
Message-ID: <20070413020309.GB11134@lixom.net>
References: <20070410111508.GA2969@localhost.localdomain>
	<200704121926.03723.arnd@arndb.de>
	<e5b10849669a764f002d1926838edc76@kernel.crashing.org>
	<200704130210.48508.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704130210.48508.arnd@arndb.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 13, 2007 at 02:10:47AM +0200, Arnd Bergmann wrote:
> On Thursday 12 April 2007, Segher Boessenkool wrote:
> > > What would be the right options to pass on e200 and on
> > > pa6t?
> > 
> > The best thing would be to add GCC -mcpu= options. ?For
> > now, you're probably best of with -mcpu=powerpc and
> > -mcpu=powerpc64 resp., i.e. the "blended models". ?This
> > is a good option for multiplatform kernels too; add -mtune=
> > to optimise for a specific core, but it will *work* on
> > the whole family.
> 
> 970 -> -mcpu=970 >> -mcpu=power4
> cell -> -mcpu=cell >> -mcpu=970
> power5 -> -mcpu=power5 >> -mcpu=power4
> power5+ -> -mcpu=power5+ >> -mcpu=power5
> power6 -> -mcpu=power6 >> -mcpu=power5+
> power6x -> -mcpu=power6x >> -mcpu=power6
> pa6t -> -mcpu=pa6t >> (???)
> 
> So if we select e.g. power6 and cell, it needs to fall back to power4,
> which is the common subset. Selecting both 403 and 405 would result
> in falling back to -mcpu=powerpc, because they don't have any larger
> subset.
> 
> I'm not sure what the right fallback fo pa6t should be. I would guess
> that it's a superset of power6x and 970 when considering the kernel,
> but it's not entirely clear what the fallback should be.

On the kernel side, power6 should be closest. We likely lack some of the
optional features they implemented, but none are used in the kernel.

If we find problems down the road, we'll revise.


-Olof

Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id 735C3B7D4F
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 18:29:35 +1000 (EST)
Date: Wed, 5 May 2010 18:29:31 +1000
From: Simon Horman <horms@verge.net.au>
To: Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH] kexec-tools, ppc64: fix build error on ppc64
Message-ID: <20100505082930.GE3876@verge.net.au>
References: <15110.1273024133@neuling.org>
	<20100505023316.GF13035@verge.net.au>
	<14281.1273030521@neuling.org> <20100505033928.GC2612@verge.net.au>
	<q2y572af9171005050046v929117e8ya5b330a1a0c9c298@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <q2y572af9171005050046v929117e8ya5b330a1a0c9c298@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 05, 2010 at 11:46:25AM +0400, Maxim Uvarov wrote:
> 2010/5/5 Simon Horman <horms@verge.net.au>
> 
> > On Wed, May 05, 2010 at 01:35:21PM +1000, Michael Neuling wrote:
> > >
> > >
> > > In message <20100505023316.GF13035@verge.net.au> you wrote:
> > > > On Wed, May 05, 2010 at 11:48:53AM +1000, Michael Neuling wrote:
> > > > > 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 "some kexec MIPS
> > > > > improvements" broke pp64 as it turned on -Werror for all archs.
> > > > >
> > > > > This fixes the warning and hence ppc64 building.
> > > >
> > > > Thanks.
> > > >
> > > > While I'm very much in favour of using -Werror for testing
> > > > and these kind of patches are great, I think that -Werror
> > > > by default is rather silly. We can't control what will be
> > > > a warning in the future and sometimes fixing warnings isn't
> > > > appropriate - for instance there are warnings in fs2dt.c at
> > > > the moment, that is currently considered an upstream problem.
> > > >
> > > > In short, this patch is great. But I plan to also remove -Werror
> > > > as the default now that its been brought to my attention.
> > >
> > > Cool.  My second patch should do this for all but MIPS.
> >
> > Unfortunately the second patch breaks make tarball.
> > For now I have committed the following:
> >
> > From 76beff0507360f3001e23c9b4c765ef56384d5d5 Mon Sep 17 00:00:00 2001
> > From: Simon Horman <horms@verge.net.au>
> > Date: Wed, 5 May 2010 13:33:21 +1000
> > Subject: [PATCH] build: Don't modify CFLAGS in kexec/arch/mips/Makefile
> >
> > Revert this portion of recent MIPS changes as it actually effects the
> > CFLAGS for all architectures.  Moreover I'm somewhat dubious about
> > defaulting to -Werror for any architecture.
> >
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >  kexec/arch/mips/Makefile |    2 --
> >  1 files changed, 0 insertions(+), 2 deletions(-)
> >
> > diff --git a/kexec/arch/mips/Makefile b/kexec/arch/mips/Makefile
> > index 831b263..03bdb9a 100644
> > --- a/kexec/arch/mips/Makefile
> > +++ b/kexec/arch/mips/Makefile
> > @@ -14,5 +14,3 @@ dist += kexec/arch/mips/Makefile $(mips_KEXEC_SRCS)
> >             \
> >        kexec/arch/mips/kexec-mips.h                                    \
> >        kexec/arch/mips/crashdump-mips.h                                \
> >        kexec/arch/mips/include/arch/options.h
> > -
> > -CFLAGS +=-Wall -Werror
> > --
> > 1.7.1
> >
> >
> Plan was to have -Werror only for mips. Thanks for fixes.

No problem, I should have noticed this earlier.

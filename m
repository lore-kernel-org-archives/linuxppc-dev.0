Return-Path: <apw@shadowen.org>
Received: from tallyho.bytemark.co.uk (tallyho.bytemark.co.uk [80.68.81.166])
	by ozlabs.org (Postfix) with ESMTP id 8D734DDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 19:25:46 +1000 (EST)
Date: Thu, 28 Aug 2008 08:51:20 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: checkpatch nits ...
Message-ID: <20080828075120.GB27763@brain>
References: <48AF5818.7010802@hypersurf.com> <200808231057.22399.arnd@arndb.de>
	<20080827074944.GA4259@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20080827074944.GA4259@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Kevin Diggs <kevdig@hypersurf.com>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 27, 2008 at 09:49:44AM +0200, Wolfram Sang wrote:
> On Sat, Aug 23, 2008 at 10:57:21AM +0200, Arnd Bergmann wrote:
> 
> > On Saturday 23 August 2008, Kevin Diggs wrote:
> > > WARNING: externs should be avoided in .c files
> > > #1137: FILE: powerpc/kernel/cpu/pll_if.c:369:
> > > +       __asm__ __volatile__ (
> > > 
> > > ??? I don't know what this is?
> > > 
> > > The entire block is:
> > > 
> > >         __asm__ __volatile__ (
> > >                 "addi %0,%3,-1\n"
> > >                 "andc %1,%3,%0\n"
> > >                 "cntlzw %1,%1\n"
> > >                 "subfic %1,%1,31\n"
> > >                 "cntlzw %0,%2\n":
> > >                 "=r"(cntlz), "=r"(cnttz):
> > >                 "r"(tmp), "b"(cnttz)
> > >         );
> > > 
> > 
> > It's a bug in checkpatch, your code is correct (although I would write
> > asm volatile, not __asm__ __volatile__, and add \t after each \n).
> > Can you explain why you need that inline assembly? All you do in there
> > are arithmetic operations, so you should be able to express that using
> > C, or at least using the helpers we already have.
> > 
> > Checkpatch thinks that what you wrote is a declaration for a function
> > named __volatile__ returning a variable of type __asm__, and complains
> > that this declaration belongs into a header file.
> 
> I wonder if checkpatch-maintainers read this list, so I put Andy
> Whitcroft to CC.

Thanks for the Cc:, even if you do read the lists you can easily miss
something of direct interest.

I actually think I saw a previous patch flow past showing this issue and
there appears to be a specific exception for __asm__ never being a type.
Cirtainly this fragment does not throw the error with the latest
checkpatch in my tree.  That fix appears to have gone in in 0.20.  Could
you check which version you have, the version number appears in the
usage message when checkpatch is invoked without parameters.  Also give
the version at the URL below a go, it represents the current development
copy.

  http://www.kernel.org/pub/linux/kernel/people/apw/checkpatch/checkpatch.pl-testing

Thanks for the report.

-apw

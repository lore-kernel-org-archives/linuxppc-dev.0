Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B5A9CDDF22
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 11:54:26 +1100 (EST)
Subject: Re: [BUG] 2.6.25-rc3-mm1 kernel panic while bootup on powerpc ()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080305164438.fff7bb7c.akpm@linux-foundation.org>
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<47CD4AB3.3080409@linux.vnet.ibm.com> <20778.1204641656@neuling.org>
	<20080304103350.12d26560.akpm@linux-foundation.org>
	<1204761811.21545.238.camel@pasglop>
	<20080305164438.fff7bb7c.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 11:52:42 +1100
Message-Id: <1204764762.21545.243.camel@pasglop>
Mime-Version: 1.0
Cc: willy@debian.org, linuxppc-dev@ozlabs.org, mikey@neuling.org,
	linux-kernel@vger.kernel.org, kamalesh@linux.vnet.ibm.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-03-05 at 16:44 -0800, Andrew Morton wrote:
> On Thu, 06 Mar 2008 11:03:31 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > 
> > > Yes, we are - it's the semaphore rewrite which is doing this in
> > > start_kernel().  It's being discussed.
> > > 
> > > Enabling interrupts too early on powerpc was discovered to be fatal on
> > > powerpc years ago.  It looks like that remains the case.
> > 
> > Regarding these issues. I could make it non fatal and just WARN_ON,
> > provided that I have a way to differentiate legal vs. illegal calls
> > to local_irq_enable().
> 
> And local_irq_restore() and various other things.

Yes, on powerpc 64 bits, they all go down to one C function that does
the lazy enable/disable, so it would be easy to deal with. 32 bits
doesn't have it that simple tho.

> I'd have thought that the way to do this would be to add it to lockdep -
> lockdep already has all the infrastructure and code sites to do this.
> 
> Set some special flag saying its-ok-to-enable-interrupts-now and test that
> in lockdep.

Ok.

> akpm:/usr/src/25> grep LOCKDEP arch/powerpc/Kconfig 
> akpm:/usr/src/25> 
> 
> losers ;)

I have lockdep patches for powerpc 32 and 64 bits. They aren't upstream
yet as they need a bit more beating up and there's at least one machine
that doesn't seem to like them, so I'm working on just that. That's a
good idea to add the test to lockdep tho, I'll see what I can do.

> Still, doing it for
> 
> akpm:/usr/src/25> grep -l LOCKDEP arch/*/Kconfig 
> arch/arm/Kconfig
> arch/avr32/Kconfig
> arch/mips/Kconfig
> arch/s390/Kconfig
> arch/sh/Kconfig
> arch/sparc64/Kconfig
> arch/um/Kconfig
> arch/x86/Kconfig
> 
> should give pretty good coverage.

Ben.

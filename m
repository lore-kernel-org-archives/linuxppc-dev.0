Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1EE4EDDF2F
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 11:46:01 +1100 (EST)
Date: Wed, 5 Mar 2008 16:44:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: benh@kernel.crashing.org
Subject: Re: [BUG] 2.6.25-rc3-mm1 kernel panic while bootup on powerpc ()
Message-Id: <20080305164438.fff7bb7c.akpm@linux-foundation.org>
In-Reply-To: <1204761811.21545.238.camel@pasglop>
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<47CD4AB3.3080409@linux.vnet.ibm.com>
	<20778.1204641656@neuling.org>
	<20080304103350.12d26560.akpm@linux-foundation.org>
	<1204761811.21545.238.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: willy@debian.org, linuxppc-dev@ozlabs.org, mikey@neuling.org,
	linux-kernel@vger.kernel.org, kamalesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 06 Mar 2008 11:03:31 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > Yes, we are - it's the semaphore rewrite which is doing this in
> > start_kernel().  It's being discussed.
> > 
> > Enabling interrupts too early on powerpc was discovered to be fatal on
> > powerpc years ago.  It looks like that remains the case.
> 
> Regarding these issues. I could make it non fatal and just WARN_ON,
> provided that I have a way to differentiate legal vs. illegal calls
> to local_irq_enable().

And local_irq_restore() and various other things.

> We already have that function mostly out of
> line in C code due to our lazy irq disabling scheme, so the overhead of
> testing some global kernel state would be minimum here.
> 
> However, I don't see anything around init/main.c:start_kernel() that I
> can use. What do you reckon here we should do ? Add some kind of global
> we set before calling local_irq_enable() ? Or make early_boot_irqs_on()
> do that generically 
> 
> It's currently defined as an empty inline without CONFIG_TRACE_IRQFLAGS
> but we could make it set a flag instead.
> 
> I'm pretty sure other archs have similar problems, especially in the
> embedded world where you are booted with random junk firmwares that may
> leave devices, interrupt controllers etc... in random state, and
> enabling incoming IRQs before the arch code properly initializes the
> main interrupt controller can be fatal. I know at least of an ARM board
> I worked on a while ago that had a similar issues.
> 
> On ppc32, unfortunately, our local_irq_enable/restore are nice inlines
> that whack the appropriate MSR bits directly, thus adding a test for a
> global flag would add some bloat/overhead that I'd like to avoid, at
> least until we decide to also do lazy disabling on those, if ever...

I'd have thought that the way to do this would be to add it to lockdep -
lockdep already has all the infrastructure and code sites to do this.

Set some special flag saying its-ok-to-enable-interrupts-now and test that
in lockdep.

akpm:/usr/src/25> grep LOCKDEP arch/powerpc/Kconfig 
akpm:/usr/src/25> 

losers ;)

Still, doing it for

akpm:/usr/src/25> grep -l LOCKDEP arch/*/Kconfig 
arch/arm/Kconfig
arch/avr32/Kconfig
arch/mips/Kconfig
arch/s390/Kconfig
arch/sh/Kconfig
arch/sparc64/Kconfig
arch/um/Kconfig
arch/x86/Kconfig

should give pretty good coverage.

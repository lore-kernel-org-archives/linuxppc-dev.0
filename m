Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E40DCDDEEA
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 11:04:41 +1100 (EST)
Subject: Re: [BUG] 2.6.25-rc3-mm1 kernel panic while bootup on powerpc ()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080304103350.12d26560.akpm@linux-foundation.org>
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<47CD4AB3.3080409@linux.vnet.ibm.com> <20778.1204641656@neuling.org>
	<20080304103350.12d26560.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 11:03:31 +1100
Message-Id: <1204761811.21545.238.camel@pasglop>
Mime-Version: 1.0
Cc: Matthew Wilcox <willy@debian.org>, linuxppc-dev@ozlabs.org,
	Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Yes, we are - it's the semaphore rewrite which is doing this in
> start_kernel().  It's being discussed.
> 
> Enabling interrupts too early on powerpc was discovered to be fatal on
> powerpc years ago.  It looks like that remains the case.

Regarding these issues. I could make it non fatal and just WARN_ON,
provided that I have a way to differentiate legal vs. illegal calls
to local_irq_enable(). We already have that function mostly out of
line in C code due to our lazy irq disabling scheme, so the overhead of
testing some global kernel state would be minimum here.

However, I don't see anything around init/main.c:start_kernel() that I
can use. What do you reckon here we should do ? Add some kind of global
we set before calling local_irq_enable() ? Or make early_boot_irqs_on()
do that generically 

It's currently defined as an empty inline without CONFIG_TRACE_IRQFLAGS
but we could make it set a flag instead.

I'm pretty sure other archs have similar problems, especially in the
embedded world where you are booted with random junk firmwares that may
leave devices, interrupt controllers etc... in random state, and
enabling incoming IRQs before the arch code properly initializes the
main interrupt controller can be fatal. I know at least of an ARM board
I worked on a while ago that had a similar issues.

On ppc32, unfortunately, our local_irq_enable/restore are nice inlines
that whack the appropriate MSR bits directly, thus adding a test for a
global flag would add some bloat/overhead that I'd like to avoid, at
least until we decide to also do lazy disabling on those, if ever...

Cheers,
Ben.

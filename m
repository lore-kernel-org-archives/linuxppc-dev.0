Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E18467B22
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 09:13:59 +1000 (EST)
Subject: Re: SMP in 32-bit arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1G8HvV-0007o7-0C@jdl.com>
References: <1154507145.24203.0.camel@localhost.localdomain>
	<E1G8HvV-0007o7-0C@jdl.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 01:12:48 +0200
Message-Id: <1155769968.11312.110.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-02 at 09:42 -0500, Jon Loeliger wrote:
> So, like, the other day Adrian Cox mumbled:
> > Is anybody else having problems with 32-bit SMP support in arch/powerpc?
> > I'm using 2.6.17 as my current base, because I've not yet merged the
> > latest mpic changes.
> > 
> > I'm currently bringing up a dual-7448 board, and when I build the kernel
> > with CONFIG_SMP, the bootmem allocator corrupts the device tree. The
> > strange thing is, this still happens when I don't start the second CPU.
> > Kernels built without CONFIG_SMP run flawlessly on the same hardware.
> 
> As a point of reference, the 32-bit 8641 HPCN seems to be working fine
> with both CONFIG_SMP and the device tree mechanism in place.  It was working
> both before and after the IRQ changes.
> 
> Can you nail down any more specifics on how it is failing or where
> the corruption happens?

For completeness, there is a known bug with 32 bits and SMP regarding
icache coherency.... If you have random SIGILL/SEGV under load, that's
probably what you are hitting. The problem is due to the way we do the
coherency and isn't trivial to fix unfortunately, though it's also
fairly rare.

Ben.

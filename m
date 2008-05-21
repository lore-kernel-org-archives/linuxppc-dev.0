Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 717C9DDF39
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 00:00:23 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0805201425250.7453@t2.domain.actdsltmp>
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
	<1211318219.8297.177.camel@pasglop>
	<Pine.LNX.4.64.0805201425250.7453@t2.domain.actdsltmp>
Content-Type: text/plain
Date: Wed, 21 May 2008 10:00:10 -0400
Message-Id: <1211378410.8297.192.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Depends on what you define as "necessary".  It's seem clear that I/O accessors
> _no not_ need to be strictly ordered with respect to normal memory accesses,
> by what's defined in memory-barriers.txt.  So if by "necessary" you mean what
> the Linux standard for I/O accessors requires (and what other archs provide),
> then yes, they have the necessary ordering guarantees.
> 
> But, if you want them to be strictly ordered w.r.t to normal memory, that's
> not the case.

They should be.

> For example, in something like:
> 
> u32 *dmabuf = kmalloc(...);
> ...
> dmabuf[0] = 1;
> out_be32(&regs->dmactl, DMA_SEND_BUFFER);
> dmabuf[0] = 2;
> out_be32(&regs->dmactl, DMA_SEND_BUFFER);
> 
> gcc might decide to optimize this code to:
> 
> out_be32(&regs->dmactl, DMA_SEND_BUFFER);
> out_be32(&regs->dmactl, DMA_SEND_BUFFER);
> dmabuf[0] = 2;

If that's the case, there is a bug. Ignoring gcc possible optimisations,
the accessors contain the necessary memory barriers for things to work
the way you describe above. If the use of volatile and clobber in our
macros isn't enough to also prevent optimisations, then we have a bug
and you are welcome to provide a patch to fix it.

> gcc will often not do this optimization, because there might be aliasing
> between "&regs->dmact" and "dmabuf", but it _can_ do it.  gcc can't optimize
> the two identical out_be32's into one, or re-order them if they were to
> different registers, but it can move the normal memory accesses around them.

The linus kernel -cannot- be compiled with strict aliasing rules. This
is one of the many areas where those are violated. Frankly, this strict
aliasing stuff is just a total nightmare turning a pefectly nice and
useable language into something it's not meant to be.

> Here's a quick hack I stuck in a driver to test.  compile with -save-temps and
> check the resulting asm.  gcc will do the optimization I described above.
> 
> static void __iomem *baz = (void*)0x1234;
> static struct bar {
>      u32 bar[256];
> } bar;
> 
> void foo(void) {
>      bar.bar[0] = 44;
>      out_be32(baz+100, 200);
>      bar.bar[0] = 45;
>      out_be32(baz+101, 201);
> }

Have you removed -fno-strict-aliasing ? Just don't do that.

Ben.

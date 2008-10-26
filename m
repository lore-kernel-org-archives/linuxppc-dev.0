Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35395DDDEE
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Oct 2008 19:29:29 +1100 (EST)
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20081026.001656.193696580.davem@davemloft.net>
References: <1224970389.7654.473.camel@pasglop>
	<4903A37A.50607@hypersurf.com> <1225003723.7654.490.camel@pasglop>
	<20081026.001656.193696580.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 26 Oct 2008 19:29:17 +1100
Message-Id: <1225009757.7654.492.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kevdig@hypersurf.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-10-26 at 00:16 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Sun, 26 Oct 2008 17:48:43 +1100
> 
> > 
> > > What does this all mean to my GigE (dual 1.1 GHz 7455s)? Is this
> > > thing supposed to be able to spread irq between its cpus?
> > 
> > Depends on the interrupt controller. I don't know that machine
> > but for example the Apple Dual G5's use an MPIC that can spread
> > based on an internal HW round robin scheme. This isn't always
> > the best idea tho for cache reasons... depends if an at what level
> > your caches are shared between CPUs.
> 
> it's always going to be the wrong thing to do for networking cards,
> especially once we start doing RX flow seperation in software

True, though I don't have policy in the kernel for that, ie, it's pretty
much irqbalanced job to do that. At this stage, the kernel always tries
to spread when it can... at least on powerpc.

Ben.

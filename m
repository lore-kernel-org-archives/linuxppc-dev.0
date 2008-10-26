Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2D4EADDE1B
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Oct 2008 18:17:20 +1100 (EST)
Date: Sun, 26 Oct 2008 00:16:56 -0700 (PDT)
Message-Id: <20081026.001656.193696580.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
From: David Miller <davem@davemloft.net>
In-Reply-To: <1225003723.7654.490.camel@pasglop>
References: <1224970389.7654.473.camel@pasglop> <4903A37A.50607@hypersurf.com>
	<1225003723.7654.490.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kevdig@hypersurf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 26 Oct 2008 17:48:43 +1100

> 
> > What does this all mean to my GigE (dual 1.1 GHz 7455s)? Is this
> > thing supposed to be able to spread irq between its cpus?
> 
> Depends on the interrupt controller. I don't know that machine
> but for example the Apple Dual G5's use an MPIC that can spread
> based on an internal HW round robin scheme. This isn't always
> the best idea tho for cache reasons... depends if an at what level
> your caches are shared between CPUs.

it's always going to be the wrong thing to do for networking cards,
especially once we start doing RX flow seperation in software

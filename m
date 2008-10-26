Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 88C6CDDDFF
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Oct 2008 15:04:36 +1100 (EST)
Date: Sat, 25 Oct 2008 21:04:12 -0700 (PDT)
Message-Id: <20081025.210412.206011121.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
From: David Miller <davem@davemloft.net>
In-Reply-To: <1224970389.7654.473.camel@pasglop>
References: <1224863858-7933-1-git-send-email-galak@kernel.crashing.org>
	<20081024.161813.193686281.davem@davemloft.net>
	<1224970389.7654.473.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	torvalds@osdl.org, maxk@qualcomm.com, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 26 Oct 2008 08:33:09 +1100

> Well, I don't know how you do it but on powerpc, we explicitely fill the
> affinity masks at boot time when we can spread interrupts... Maybe we
> should change it the other way around and limit the mask when we can't ?
> It's hard to tell for sure at this stage.

On sparc64 we look at the cpu mask configured for the interrupt and do
one of two things:

1) If all bits are set, we round robin assign a cpu at IRQ enable time.

2) Else we pick the first bit set in the mask.

One modification I want to make is to make case #1 NUMA aware.

But back to my original wonder, since I've always tipped off of this
generic IRQ layer cpu mask, when was it ever defaulting to zero
and causing the behvaior your powerpc guys actually want? :-)

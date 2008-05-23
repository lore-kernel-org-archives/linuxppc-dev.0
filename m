Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AFF3EDE50F
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 22:37:18 +1000 (EST)
Subject: MMIO and gcc re-ordering (Was: [PATCH] [POWERPC] Improve
	(in|out)_beXX() asm code)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0805221553400.8205@t2.domain.actdsltmp>
References: <4833524C.3040207@freescale.com>
	<20080520.153947.84346222.davem@davemloft.net>
	<4833542E.3040608@freescale.com>
	<20080520.155326.195407196.davem@davemloft.net>
	<1211516683.8297.271.camel@pasglop>
	<Pine.LNX.4.64.0805221553400.8205@t2.domain.actdsltmp>
Content-Type: text/plain
Date: Fri, 23 May 2008 08:36:37 -0400
Message-Id: <1211546197.8297.308.camel@pasglop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > IE. Take an x86 version of that test, writing to memory, doing a writel
> > to some MMIO, then another memory write, can those be re-ordered with
> > the current x86 version of writel ?
> 
> Yes, the same thing can happen on x86.  As far as I could tell, this is
> something that all other arches can have happen.  Usually aliasing prevents
> it, but it's not hard to constuct a test case where it doesn't.

That brings us back to the old debate...

For consistent memory, should we mandate a wmb between write to some dma
data structure in consistent memory and the following mmio write that
trigger it, and the same goes with rmb and read ?

David, you remember we had those discussions a while back when I was
trying to relax a bit the barriers we have in our MMIO accessors on
powerpc, and the overwhelming answer was that x86 being in order, I have
to expect 90% of the drivers to not get any barrier right on any
platform, and thus I should make my MMIO accessors "look like" x86 and
thus ordered.

We did that, adding some barriers in the assembly of our readl/writel. 

However, I didn't change the clobber, it's still *addr, not a full
"memory" clobber, just like x86.

Now if it appears that gcc can indeed re-order things, then we have a
problem on both x86, ppc, and pretty much everybody else. (I'm not sure
about sparc but I don't see any explicit clobber in your accessors
there).

So that brings the whole subject back imho. What should be the approach
here ? I see several options:

	- mandate some kind of dma_sync_for_device/cpu on consistent memory.
Almost no driver do that currently tho. They only do that for non
consistent memory mapped with dma_map_*.

	- mandate the use of wmb,rmb,mb barriers for use between memory
accesses and MMIOs for ordering them. (ie. fix drivers that don't do
it). Advantage for powerpc is that I can remove (after some auditing of
course) the added heavy barriers in the MMIO accessors themselves.

	- stick a full memory clobber in all MMIO (and PIO) accessors on all
archs.

Any other idea ? preference ?

Cheers,
Ben.

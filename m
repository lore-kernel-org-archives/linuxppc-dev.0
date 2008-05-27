Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0D4EDDF6E
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 11:34:20 +1000 (EST)
Subject: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Arch list <linux-arch@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0805221553400.8205@t2.domain.actdsltmp>
References: <4833524C.3040207@freescale.com>
	<20080520.153947.84346222.davem@davemloft.net>
	<4833542E.3040608@freescale.com>
	<20080520.155326.195407196.davem@davemloft.net>
	<1211516683.8297.271.camel@pasglop>
	<Pine.LNX.4.64.0805221553400.8205@t2.domain.actdsltmp>
Content-Type: text/plain
Date: Tue, 27 May 2008 11:33:46 +1000
Message-Id: <1211852026.3286.36.camel@pasglop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Trent Piepho <tpiepho@freescale.com>,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
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

Re-post to linux-arch of a discussion on lkml.

Mostly due to lack of reactions :-)

Quick summary: gcc is happily re-ordering readl/writel vs. surrounding
memory accesses (and thus accesses to DMA coherent memory) which is
obviously a _BAD_THING_.

This is on all archs. Quick fix is to stick a "memory" clobber in all arch
implementations of readl/writel/... (ie, making them a barrier()).

However, I'm using that as an excuse to bring back my pet subject, which
is basically, should we instead just finally mandate the use of explicit
rmb/wmb/mb's (which boils down to barrier() on x86) to drivers who want
to order memory consistent accesses vs. MMIO ?

The reason is that on archs that are out of order, this would allow us
to get rid in the long run of some of the heavy barriers we have put in
our readl/writel implementations to make them look like x86.

Note that there are drivers that already do that (ie. explicit rmb/wmb/mb
to order coherent memory accesses vs. MMIO), such as OHCI/EHCI which
may explain why the new problem with gcc isn't more obviously hitting
people, as those turn into compiler barriers on x86.

If that approach is accepted, then I'll start auditing drivers and send
patches adding wmb/rmb/mb's to them, and in the long run, after mucho
testing, relax powerpc writel/readl implementations. Other archs can then
do the same too

If that approach is generally considered wrong, then we should probably
remove the spurrious readl/writel in drivers that do them.
 
So what are the opinions here ?

Cheers,
Ben.

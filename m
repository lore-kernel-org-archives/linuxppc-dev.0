Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F31B0DDFFD
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 07:12:16 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <adaprr721c6.fsf@cisco.com>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 28 May 2008 07:11:36 +1000
Message-Id: <1211922696.3286.82.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, torvalds@linux-foundation.org,
	tpiepho@freescale.com, alan@lxorguk.ukuu.org.uk,
	Arjan van de Ven <arjan@infradead.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-05-27 at 08:50 -0700, Roland Dreier wrote:
> > Though it's my understanding that at least ia64 does require the
>  > explicit barriers anyway, so we are still in a dodgy situation here
>  > where it's not clear what drivers should do and we end up with
>  > possibly excessive barriers on powerpc where I end up with both
>  > the wmb/rmb/mb that were added for ia64 -and- the ones I have in
>  > readl/writel to make them look synchronous... Not nice.
> 
> ia64 is a disaster with a slightly different ordering problem -- the
> mmiowb() issue.  I know Ben knows far too much about this, but for big
> SGI boxes, you sometimes need mmiowb() to avoid problems with driver
> code that does totally sane stuff like

This is a different issue. We deal with it on powerpc by having writel
set a per-cpu flag and spin_unlock() test it, and do the barrier if
needed there.

However, drivers such as e1000 -also- have a wmb() between filling the
ring buffer and kicking the DMA with MMIO, with a comment about this
being needed for ia64 relaxed ordering.

Ben.

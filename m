Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9BB2CDDF6C
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 16:50:32 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <200806031611.13817.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop>
	<200806031416.18195.nickpiggin@yahoo.com.au>
	<1212467551.9496.23.camel@pasglop>
	<200806031611.13817.nickpiggin@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 03 Jun 2008 16:48:50 +1000
Message-Id: <1212475730.9496.30.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, tpiepho@freescale.com,
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

On Tue, 2008-06-03 at 16:11 +1000, Nick Piggin wrote:
> >       - readl is synchronous (ie, makes the CPU think the
> >           data was actually used before executing subsequent
> >           instructions, thus waits for the data to come back,
> >           for example to ensure that a read used to push out
> >           post buffers followed by a delay will indeed happen
> >           with the right delay).
> 
> So your readl can pass an earlier cacheable store or earlier writel?

I forgot to mention that all MMIO are ordered vs. each other and I
do prevent readl from passing earlier cacheable stores too in my
current implementation but I'n not 100% we want to "guarantee" that,
unless we have stupid devices that trigger DMA's on reads with side
effects.. anyway, it is guaranteed in the current case.

Ben.

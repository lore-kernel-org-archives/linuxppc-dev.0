Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70A1EDDF78
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 17:09:55 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20080526204233.75b71bb8@infradead.org>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
Content-Type: text/plain
Date: Tue, 27 May 2008 17:08:50 +1000
Message-Id: <1211872130.3286.64.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, torvalds@linux-foundation.org,
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


> ... and try to find a way to test for it at runtime or compile time.
> 
> either via sparse or some fancy lockdep like "device store" thing?
> If we can't test for it and it doesn't show up on x86 ... it'll just be
> an eterrnal chase.

It's hard. I haven't managed to come up with a good idea on how
to test for it either at runtime or from sparse.

There -might- be way to test up to a certain point with sparse
by defining a __coherent attribute for coherent memory and trying
to figure out patterns like write to __coherent followed by MMIO
with no barrier in between but that's fishy and won't catch many
cases.

Sticking barriers in the accessors is thus indeed the "easy" and
somewhat safe fix and keeping everything as ordered as possible

Though it's my understanding that at least ia64 does require the
explicit barriers anyway, so we are still in a dodgy situation here
where it's not clear what drivers should do and we end up with
possibly excessive barriers on powerpc where I end up with both
the wmb/rmb/mb that were added for ia64 -and- the ones I have in
readl/writel to make them look synchronous... Not nice.

I'm not sure there is a good answer...

Cheers,
Ben.

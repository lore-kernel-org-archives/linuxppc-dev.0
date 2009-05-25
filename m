Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 97978DE1BE
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 14:35:16 +1000 (EST)
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200905250243.15436.arnd@arndb.de>
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
	<1243160487.22770.59.camel@pasglop> <1243210914.24376.11.camel@pasglop>
	<200905250243.15436.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 25 May 2009 14:19:41 +1000
Message-Id: <1243225181.24376.20.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Albert Herranz <albert_herranz@yahoo.es>,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-05-25 at 02:43 +0100, Arnd Bergmann wrote:
> I might be missing too much context here, but can't we make drivers
> that
> need this allocate an uncached memory range at setup time and call
> dma_declare_coherent_memory() on that to make a later
> dma_alloc_coherent()
> succeed without GFP_KERNEL?

That isn't that much different, and still needs a dedicated allocator
which is pretty much what I'm trying to get rid of.

It would make everybody's life easier if we just banned those
allocations from atomic contexts :-)

Cheers,
Ben.

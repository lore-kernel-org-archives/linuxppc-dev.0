Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8BA49B71B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 10:20:58 +1000 (EST)
Subject: Re: PowerPC PCI DMA issues (prefetch/coherency?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200906162002.12376.arnd@arndb.de>
References: <4A37A503.3030209@oxtel.com> <200906161943.38764.arnd@arndb.de>
	<4A37DB0F.7060801@freescale.com>  <200906162002.12376.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 17 Jun 2009 10:18:45 +1000
Message-Id: <1245197925.21602.0.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	Chris Pringle <chris.pringle@oxtel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-06-16 at 20:02 +0200, Arnd Bergmann wrote:
> On Tuesday 16 June 2009, Scott Wood wrote:
> > > If the
> > > device is the only one, you can also use dma_alloc_noncoherent() and
> > > flush explicitly with dma_cache_sync().
> > 
> > I don't see how that would help -- aren't those also controlled by 
> > CONFIG_NOT_COHERENT_CACHE?
> 
> Ah, yes you are right. PowerPC implements dma_alloc_noncoherent as
> dma_alloc_coherent, so dma_cache_sync() is actually a NOP (or should be).

But we still need to sync the result of dma_map_* when used multiple
times for a single mapping.

Cheers,
Ben.

> Actually there seems to be a bug in here: Since dma_alloc_noncoherent
> gives you a coherent mapping (or NULL) on noncoherent machines,
> dma_cache_sync() is redundant and should not actually flush the
> cache, or we should change dma_alloc_noncoherent to do a simple
> alloc_pages on CONFIG_NON_COHERENT_CACHE and leave dma_cache_sync()
> as it is.
> 
> 	Arnd <><
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

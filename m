Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EDA3CB716E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 10:50:18 +1000 (EST)
Date: Wed, 17 Jun 2009 09:37:14 +0900
To: benh@kernel.crashing.org
Subject: Re: PowerPC PCI DMA issues (prefetch/coherency?)
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1245197925.21602.0.camel@pasglop>
References: <4A37DB0F.7060801@freescale.com> <200906162002.12376.arnd@arndb.de>
	<1245197925.21602.0.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20090617093654B.fujita.tomonori@lab.ntt.co.jp>
Cc: scottwood@freescale.com, chris.pringle@oxtel.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 17 Jun 2009 10:18:45 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2009-06-16 at 20:02 +0200, Arnd Bergmann wrote:
> > On Tuesday 16 June 2009, Scott Wood wrote:
> > > > If the
> > > > device is the only one, you can also use dma_alloc_noncoherent() and
> > > > flush explicitly with dma_cache_sync().
> > > 
> > > I don't see how that would help -- aren't those also controlled by 
> > > CONFIG_NOT_COHERENT_CACHE?
> > 
> > Ah, yes you are right. PowerPC implements dma_alloc_noncoherent as
> > dma_alloc_coherent, so dma_cache_sync() is actually a NOP (or should be).
> 
> But we still need to sync the result of dma_map_* when used multiple
> times for a single mapping.

We have dma_sync_{single|sg}_for_{cpu|device} API for the above
purpose.

dma_cache_sync is supposed to be used only with the buffers that
dma_alloc_noncoherent() returns. On architecutures that maps
dma_alloc_noncoherent to dma_alloc_coherent, dma_cache_sync() is
supposed to be NOP.

Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 10B07B7143
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 04:02:48 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: PowerPC PCI DMA issues (prefetch/coherency?)
Date: Tue, 16 Jun 2009 20:02:11 +0200
References: <4A37A503.3030209@oxtel.com> <200906161943.38764.arnd@arndb.de>
	<4A37DB0F.7060801@freescale.com>
In-Reply-To: <4A37DB0F.7060801@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200906162002.12376.arnd@arndb.de>
Cc: Chris Pringle <chris.pringle@oxtel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 16 June 2009, Scott Wood wrote:
> > If the
> > device is the only one, you can also use dma_alloc_noncoherent() and
> > flush explicitly with dma_cache_sync().
> 
> I don't see how that would help -- aren't those also controlled by 
> CONFIG_NOT_COHERENT_CACHE?

Ah, yes you are right. PowerPC implements dma_alloc_noncoherent as
dma_alloc_coherent, so dma_cache_sync() is actually a NOP (or should be).

Actually there seems to be a bug in here: Since dma_alloc_noncoherent
gives you a coherent mapping (or NULL) on noncoherent machines,
dma_cache_sync() is redundant and should not actually flush the
cache, or we should change dma_alloc_noncoherent to do a simple
alloc_pages on CONFIG_NON_COHERENT_CACHE and leave dma_cache_sync()
as it is.

	Arnd <><

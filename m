Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 25AEFB7149
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 03:44:21 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: PowerPC PCI DMA issues (prefetch/coherency?)
Date: Tue, 16 Jun 2009 19:43:38 +0200
References: <4A37A503.3030209@oxtel.com> <4A37CF02.5080906@oxtel.com>
	<4A37D073.6020802@freescale.com>
In-Reply-To: <4A37D073.6020802@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200906161943.38764.arnd@arndb.de>
Cc: Scott Wood <scottwood@freescale.com>,
	Chris Pringle <chris.pringle@oxtel.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 16 June 2009, Scott Wood wrote:
> Chris Pringle wrote:
> > Ah right - that would explain what we're seeing then... Doh. Thought I 
> > might have been onto something then. Is there any way to force a cache 
> > flush? That'd at least prove it was a caching issue if it resolved the 
> > problem.
> 
> You could enable CONFIG_NOT_COHERENT_CACHE.

If the whole system is noncoherent, that is the right solution. If the
device is the only one, you can also use dma_alloc_noncoherent() and
flush explicitly with dma_cache_sync().

	Arnd <><

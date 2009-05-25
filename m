Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id E5692DE140
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 11:44:06 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
Date: Mon, 25 May 2009 02:43:14 +0100
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
	<1243160487.22770.59.camel@pasglop>
	<1243210914.24376.11.camel@pasglop>
In-Reply-To: <1243210914.24376.11.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200905250243.15436.arnd@arndb.de>
Cc: Albert Herranz <albert_herranz@yahoo.es>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 25 May 2009, Benjamin Herrenschmidt wrote:
> Note that I still think the right approach in the long run is to ban the
> consistent allocs from atomic contexts generically in linux, though that
> will be a hard nut to crack.

I might be missing too much context here, but can't we make drivers that
need this allocate an uncached memory range at setup time and call
dma_declare_coherent_memory() on that to make a later dma_alloc_coherent()
succeed without GFP_KERNEL?

If that is not enough, dma_alloc_coherent could be changed to
try dma_alloc_from_coherent() on the bridge device (PCI HB,
PLB4, ...), if we reserve a reasonably sized amount of uncached
memory for each bridge that has noncoherent devices.

	Arnd <><

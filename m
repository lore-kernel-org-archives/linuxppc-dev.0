Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 8C423DE064
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 08:39:54 +1000 (EST)
Date: Tue, 20 May 2008 15:39:47 -0700 (PDT)
Message-Id: <20080520.153947.84346222.davem@davemloft.net>
To: scottwood@freescale.com
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
From: David Miller <davem@davemloft.net>
In-Reply-To: <4833524C.3040207@freescale.com>
References: <483344C0.3020703@freescale.com> <20080520231516.76b924a2@core>
	<4833524C.3040207@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, tpiepho@freescale.com, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>
Date: Tue, 20 May 2008 17:35:56 -0500

> Alan Cox wrote:
> >> It looks like we rely on -fno-strict-aliasing to prevent reordering 
> >> ordinary memory accesses (such as to DMA descriptors) past the I/O 
> > 
> > DMA descriptors in main memory are dependant on cache behaviour anyway
> > and the dma_* operators should be the ones enforcing the needed behaviour.
> 
> What about memory obtained from dma_alloc_coherent()?  We still need a 
> sync and a compiler barrier.  The current I/O accessors have the former, 
> but not the latter.

The __volatile__ in the asm construct disallows movement of the
inline asm relative to statements surrounding it.

The only reason barrier() in kernel.h needs a memory clobber is
because of a bug in ancient versions of gcc.  In fact, I think
that memory clobber might even be removable.

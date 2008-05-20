Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C5264DDF03
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 08:53:32 +1000 (EST)
Date: Tue, 20 May 2008 15:53:26 -0700 (PDT)
Message-Id: <20080520.155326.195407196.davem@davemloft.net>
To: scottwood@freescale.com
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
From: David Miller <davem@davemloft.net>
In-Reply-To: <4833542E.3040608@freescale.com>
References: <4833524C.3040207@freescale.com>
	<20080520.153947.84346222.davem@davemloft.net>
	<4833542E.3040608@freescale.com>
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
Date: Tue, 20 May 2008 17:43:58 -0500

> David Miller wrote:
> > The __volatile__ in the asm construct disallows movement of the
> > inline asm relative to statements surrounding it.
> > 
> > The only reason barrier() in kernel.h needs a memory clobber is
> > because of a bug in ancient versions of gcc.  In fact, I think
> > that memory clobber might even be removable.
> 
> Current versions of GCC seem quite happy to move non-asm memory accesses 
> around a volatile asm without a memory clobber; see the test Trent posted.

Indeed, and even the GCC manual is clear about this.

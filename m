Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 96DAEDDE1F
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 11:40:53 +1000 (EST)
Date: Mon, 26 May 2008 18:40:47 -0700 (PDT)
Message-Id: <20080526.184047.88207142.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: MMIO and gcc re-ordering issue
From: David Miller <davem@davemloft.net>
In-Reply-To: <1211852026.3286.36.camel@pasglop>
References: <1211516683.8297.271.camel@pasglop>
	<Pine.LNX.4.64.0805221553400.8205@t2.domain.actdsltmp>
	<1211852026.3286.36.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	torvalds@linux-foundation.org, tpiepho@freescale.com,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 27 May 2008 11:33:46 +1000

> Quick summary: gcc is happily re-ordering readl/writel vs. surrounding
> memory accesses (and thus accesses to DMA coherent memory) which is
> obviously a _BAD_THING_.
> 
> This is on all archs. Quick fix is to stick a "memory" clobber in all arch
> implementations of readl/writel/... (ie, making them a barrier()).
> 
> However, I'm using that as an excuse to bring back my pet subject, which
> is basically, should we instead just finally mandate the use of explicit
> rmb/wmb/mb's (which boils down to barrier() on x86) to drivers who want
> to order memory consistent accesses vs. MMIO ?

This is basically what drivers are effectively doing.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62F1EDDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 14:59:24 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20071019044806.GA10080@gondor.apana.org.au>
References: <E1IiWnJ-0000ne-00@gondolin.me.apana.org.au>
	<1192745137.7367.40.camel@pasglop>
	<alpine.LFD.0.999.0710181549330.26902@woody.linux-foundation.org>
	<1192749449.7367.51.camel@pasglop>
	<alpine.LFD.0.999.0710181627091.26902@woody.linux-foundation.org>
	<20071019023219.GB8453@gondor.apana.org.au>
	<alpine.LFD.0.999.0710181941020.26902@woody.linux-foundation.org>
	<alpine.LFD.0.999.0710182007170.26902@woody.linux-foundation.org>
	<20071019042025.GA9617@gondor.apana.org.au>
	<20071019044806.GA10080@gondor.apana.org.au>
Content-Type: text/plain
Date: Fri, 19 Oct 2007 14:58:30 +1000
Message-Id: <1192769910.7367.106.camel@pasglop>
Mime-Version: 1.0
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-10-19 at 12:48 +0800, Herbert Xu wrote:

> [IRQ]: Fix synchronize_irq races with IRQ handler
> 
> As it is some callers of synchronize_irq rely on memory barriers
> to provide synchronisation against the IRQ handlers.  For example,
> the tg3 driver does
> 
> 	tp->irq_sync = 1;
> 	smp_mb();
> 	synchronize_irq();
> 
> and then in the IRQ handler:
> 
> 	if (!tp->irq_sync)
> 		netif_rx_schedule(dev, &tp->napi);
> 
> Unfortunately memory barriers only work well when they come in
> pairs.  Because we don't actually have memory barriers on the
> IRQ path, the memory barrier before the synchronize_irq() doesn't
> actually protect us.
> 
> In particular, synchronize_irq() may return followed by the
> result of netif_rx_schedule being made visible.
> 
> This patch (mostly written by Linus) fixes this by using spin
> locks instead of memory barries on the synchronize_irq() path.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Good for me.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.

Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id EF85EDDEDD
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 15:38:08 +1000 (EST)
Date: Thu, 18 Oct 2007 22:38:20 -0700 (PDT)
Message-Id: <20071018.223820.49264165.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Subject: Re: [NET]: Fix possible dev_deactivate race condition
From: David Miller <davem@davemloft.net>
In-Reply-To: <20071019053624.GA10560@gondor.apana.org.au>
References: <alpine.LFD.0.999.0710182007170.26902@woody.linux-foundation.org>
	<20071019042025.GA9617@gondor.apana.org.au>
	<20071019053624.GA10560@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	netdev@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 19 Oct 2007 13:36:24 +0800

> [NET]: Fix possible dev_deactivate race condition
> 
> The function dev_deactivate is supposed to only return when
> all outstanding transmissions have completed.  Unfortunately
> it is possible for store operations in the driver's transmit
> function to only become visible after dev_deactivate returns.
> 
> This patch fixes this by taking the queue lock after we see
> the end of the queue run.  This ensures that all effects of
> any previous transmit calls are visible.
> 
> If however we detect that there is another queue run occuring,
> then we'll warn about it because this should never happen as
> we have pointed dev->qdisc to noop_qdisc within the same queue
> lock earlier in the functino.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks Herbert!

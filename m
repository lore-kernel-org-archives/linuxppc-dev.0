Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B55B9DDF78
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 13:39:32 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080526.192812.184590464.davem@davemloft.net>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 27 May 2008 13:39:02 +1000
Message-Id: <1211859542.3286.46.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	torvalds@linux-foundation.org, tpiepho@freescale.com,
	alan@lxorguk.ukuu.org.uk
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-05-26 at 19:28 -0700, David Miller wrote:
> > But heh, it's you who was telling me that it would be a bad
> engineering
> > decision and we had to make everybody look like x86 & fully
> ordered :-)
> > I decided to agree back then and stuck all those nasty heavy
> barriers
> > in the powerpc variants of readl/writel/...
> 
> I still believe this.
> 
> It's just another complicated thing for driver authors to get wrong.
> The other side of the coin is of course the cost.
> 
> The only thing I am absolutely sure of is that we should make a
> decision fast, document it, and just stick to it.

Yes. As it is today, tg3 for example is potentially broken on all archs
with newer gcc unless we either add "memory" clobber to readl/writel or
stick some wmb's in there (just a random driver I picked).

So Linus, what is your take on that matter ?

Cheers,
Ben.

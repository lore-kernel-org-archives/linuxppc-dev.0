Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 409D1DDF88
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 12:28:17 +1000 (EST)
Date: Mon, 26 May 2008 19:28:12 -0700 (PDT)
Message-Id: <20080526.192812.184590464.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: MMIO and gcc re-ordering issue
From: David Miller <davem@davemloft.net>
In-Reply-To: <1211854540.3286.42.camel@pasglop>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
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
Date: Tue, 27 May 2008 12:15:40 +1000

> Some of them. USB comes to mind. I'd be happy to make it "the rule" and
> document that MMIO vs. coherent access aren't implicitely ordered. I
> would still keep them ordered on powerpc for a little while tho until
> I'm happy enough with driver auditing.
> 
> But heh, it's you who was telling me that it would be a bad engineering
> decision and we had to make everybody look like x86 & fully ordered :-)
> I decided to agree back then and stuck all those nasty heavy barriers
> in the powerpc variants of readl/writel/...

I still believe this.

It's just another complicated thing for driver authors to get wrong.
The other side of the coin is of course the cost.

The only thing I am absolutely sure of is that we should make a
decision fast, document it, and just stick to it.

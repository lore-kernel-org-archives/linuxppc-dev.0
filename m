Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0315DDEC5
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 07:15:38 +1000 (EST)
Subject: Re: [PATCH/RFC] net: Add __napi_sycnhronize() to sync with napi poll
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Hemminger <shemminger@linux-foundation.org>
In-Reply-To: <20071016115318.0fc36af3@freepuppy.rosehill>
References: <1192513792.19073.23.camel@pasglop>
	<20071016115318.0fc36af3@freepuppy.rosehill>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 07:14:55 +1000
Message-Id: <1192569295.11899.14.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	"David S. Miller" <davem@davemloft.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> So this is really just like synchronize_irq()?  Using msleep is bogus
> because you want to spin, you are only waiting for a softirq on the other
> cpu to finish. If you wait for a whole millisecond and sleep that
> is far longer than the napi routine should take.
> 
> You could even optimize it like synchronize_irq() for the non-SMP case.

It's just like synchronize_irq() indeed. I used the mlseep() just like
napi_disable() mostly because I use it in a very similar context, for
disabling my sub-channels on things like link change etc... where I need
to reconfigure parts of the chip.

I prefer sleeping in my case but I agree that if somebody else was going
to use for something else more performance critical, it might be an
issue. On the other hand, spinning will not be nice for my usage
scenario :-)

I agree about the SMP optimisation though again, in my usage pattern,
it's very unimportant (similar code path as napi_disable)

I'll respin later today though.

Cheers,
Ben.

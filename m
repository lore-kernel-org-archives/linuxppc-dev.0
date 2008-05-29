Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B30AFDDECF
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 07:41:06 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jes Sorensen <jes@sgi.com>
In-Reply-To: <yq0iqwxrwuh.fsf@jaguar.mkp.net>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop>
	<adaprr721c6.fsf@cisco.com> <1211922696.3286.82.camel@pasglop>
	<adaiqwzsa83.fsf@cisco.com>  <yq0iqwxrwuh.fsf@jaguar.mkp.net>
Content-Type: text/plain
Date: Fri, 30 May 2008 07:40:23 +1000
Message-Id: <1212097223.8888.55.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	torvalds@linux-foundation.org, tpiepho@freescale.com,
	alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-05-29 at 10:47 -0400, Jes Sorensen wrote:
> 
> The only way to guarantee ordering in the above setup, is to either
> make writel() fully ordered or adding the mmiowb()'s inbetween the two
> writel's. On Altix you have to go and read from the PCI brige to
> ensure all writes to it have been flushed, which is also what mmiowb()
> is doing. If writel() was to guarantee this ordering, it would make
> every writel() call extremely expensive :-(

Interesting. I've always been taught by ia64 people that mmiowb() was
intended to be used solely between writel() and spin_unlock().

I think in the above case, you really should make writel() ordered.
Anything else is asking for trouble, for the exact same reasons that I
made it fully ordered on powerpc at least vs. previous stores. I only
kept it relaxed vs. subsequent cacheable stores (ie, spin_unlock), for
which I use the trick mentioned before.

Yes, this has some cost (can be fairly significant on powerpc too) but
I think it's a very basic assumption from drivers that consecutive
writel's, especially issued by the same CPU, will get to the device
in order.

If this is a performance problem, then provide relaxed variants and
use them in selected drivers.

Cheers,
Ben.

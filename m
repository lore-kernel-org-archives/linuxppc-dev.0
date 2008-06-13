Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6AE6DDF66
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 10:08:29 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20080612150716.GX30405@parisc-linux.org>
References: <1211852026.3286.36.camel@pasglop> <4843C3D7.7000609@sgi.com>
	<200806031433.12460.nickpiggin@yahoo.com.au>
	<200806030952.10360.jbarnes@virtuousgeek.org> <4847A690.302@sgi.com>
	<1212655433.9496.109.camel@pasglop>
	<20080612150716.GX30405@parisc-linux.org>
Content-Type: text/plain
Date: Fri, 13 Jun 2008 10:07:04 +1000
Message-Id: <1213315624.14478.56.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
	Roland Dreier <rdreier@cisco.com>, Jes Sorensen <jes@sgi.com>,
	linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>, scottwood@freescale.com,
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

On Thu, 2008-06-12 at 09:07 -0600, Matthew Wilcox wrote:
> On Thu, Jun 05, 2008 at 06:43:53PM +1000, Benjamin Herrenschmidt wrote:
> > Note that the powerpc implementation currently clears the flag
> > on spin_lock and tests it on unlock. We are considering changing
> > that to not touch the flag on spin_lock and just clear it whenever
> > we do a sync (ie, on unlock, on explicit mmiowb, and possibly even
> > on readl's where we happen to do sync's).
> 
> Your current scheme sounds like it's broken for
> 
> spin_lock(a)
> writel();
> spin_lock(b);
> spin_unlock(b);
> spin_unlock(a);

Which is why we are considering changing it :-)

But as Paulus said before, he did some measurement and we came to the
conclusion that (pending more measurements on a wider range of HW) we
may as well drop the whole scheme and make writel fully synchronous
instead.

Then, we can get some nice weakly ordered accessors and start adding
them with appropriate explicit barriers to the hot path of perf.
critical drivers we care about.

Cheers,
Ben.

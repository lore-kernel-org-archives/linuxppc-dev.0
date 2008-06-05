Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44C29DDF62
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 18:44:37 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jes Sorensen <jes@sgi.com>
In-Reply-To: <4847A690.302@sgi.com>
References: <1211852026.3286.36.camel@pasglop> <4843C3D7.7000609@sgi.com>
	<200806031433.12460.nickpiggin@yahoo.com.au>
	<200806030952.10360.jbarnes@virtuousgeek.org>  <4847A690.302@sgi.com>
Content-Type: text/plain
Date: Thu, 05 Jun 2008 18:43:53 +1000
Message-Id: <1212655433.9496.109.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
	Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	Jeremy Higdon <jeremy@sgi.com>,
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

On Thu, 2008-06-05 at 10:40 +0200, Jes Sorensen wrote:
> Jesse Barnes wrote:
> > Now, in hindsight, using a PIO write set & test flag approach in 
> > writeX/spin_unlock (ala powerpc) might have been a better approach, but iirc 
> > that never came up in the discussion, probably because we were focused on PCI 
> > posting and not uncached vs. cached ordering.
> 
> Hi Jesse,
> 
> I am going to take a stab at implementing this so we can see how much
> of an impact it will have.

Note that the powerpc implementation currently clears the flag
on spin_lock and tests it on unlock. We are considering changing
that to not touch the flag on spin_lock and just clear it whenever
we do a sync (ie, on unlock, on explicit mmiowb, and possibly even
on readl's where we happen to do sync's).

Ben.

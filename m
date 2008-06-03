Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp116.mail.mud.yahoo.com (smtp116.mail.mud.yahoo.com
	[209.191.84.165]) by ozlabs.org (Postfix) with SMTP id 3B7E2DE110
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 18:19:20 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 3 Jun 2008 18:19:05 +1000
References: <1211852026.3286.36.camel@pasglop>
	<200806031433.12460.nickpiggin@yahoo.com.au>
	<20080603081552.GC117059@sgi.com>
In-Reply-To: <20080603081552.GC117059@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806031819.06559.nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, torvalds@linux-foundation.org,
	tpiepho@freescale.com, alan@lxorguk.ukuu.org.uk,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 03 June 2008 18:15, Jeremy Higdon wrote:
> On Tue, Jun 03, 2008 at 02:33:11PM +1000, Nick Piggin wrote:
> > On Monday 02 June 2008 19:56, Jes Sorensen wrote:

> > > Would we be able to use Ben's trick of setting a per cpu flag in
> > > writel() then and checking that in spin unlock issuing the mmiowb()
> > > there if needed?
> >
> > Yes you could, but your writels would still not be strongly ordered
> > within (or outside) spinlock regions, which is what Linus wants (and
> > I kind of agree with).
>
> Yes they would be.  Writes from the same CPU are always ordered.  Writes
> from different CPUs are not, but that's only a concern if you protect

They are not strongly ordered WRT writes to cacheable memory. If they
were, then they would not leak out of spinlocks.

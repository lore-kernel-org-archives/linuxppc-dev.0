Return-Path: <jeremy@classic.engr.sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.171.30])
	by ozlabs.org (Postfix) with ESMTP id 11029DE0B1
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 18:15:57 +1000 (EST)
Date: Tue, 3 Jun 2008 01:15:52 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080603081552.GC117059@sgi.com>
References: <1211852026.3286.36.camel@pasglop>
	<20080531075242.GC108600@sgi.com> <4843C3D7.7000609@sgi.com>
	<200806031433.12460.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200806031433.12460.nickpiggin@yahoo.com.au>
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

On Tue, Jun 03, 2008 at 02:33:11PM +1000, Nick Piggin wrote:
> On Monday 02 June 2008 19:56, Jes Sorensen wrote:
> > Jeremy Higdon wrote:
> > > We don't actually have that problem on the Altix.  All writes issued
> > > by CPU X will be ordered with respect to each other.  But writes by
> > > CPU X and CPU Y will not be, unless an mmiowb() is done by the
> > > original CPU before the second CPU writes.  I.e.
> > >
> > > 	CPU X	writel
> > > 	CPU X	writel
> > > 	CPU X	mmiowb
> > >
> > > 	CPU Y	writel
> > > 	...
> > >
> > > Note that this implies some sort of locking.  Also note that if in
> > > the above, CPU Y did the mmiowb, that would not work.
> >
> > Hmmm,
> >
> > Then it's less bad than I thought - my apologies for the confusion.
> >
> > Would we be able to use Ben's trick of setting a per cpu flag in
> > writel() then and checking that in spin unlock issuing the mmiowb()
> > there if needed?
> 
> Yes you could, but your writels would still not be strongly ordered
> within (or outside) spinlock regions, which is what Linus wants (and
> I kind of agree with).

Yes they would be.  Writes from the same CPU are always ordered.  Writes
from different CPUs are not, but that's only a concern if you protect
writing via some sort of lock.  If the lock release forces a barrier,
that should take care of the problem.

jeremy

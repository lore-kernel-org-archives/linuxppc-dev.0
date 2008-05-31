Return-Path: <jeremy@classic.engr.sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id BE753DDE28
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 17:57:21 +1000 (EST)
Date: Sat, 31 May 2008 00:57:18 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080531075718.GD108600@sgi.com>
References: <1211852026.3286.36.camel@pasglop>
	<1212073289.3428.30.camel@localhost.localdomain>
	<483FCA94.1060506@sgi.com>
	<200805301021.00883.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200805301021.00883.jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	torvalds@linux-foundation.org, tpiepho@freescale.com,
	alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 30, 2008 at 10:21:00AM -0700, Jesse Barnes wrote:
> On Friday, May 30, 2008 2:36 am Jes Sorensen wrote:
> > James Bottomley wrote:
> > >> The only way to guarantee ordering in the above setup, is to either
> > >> make writel() fully ordered or adding the mmiowb()'s inbetween the two
> > >> writel's. On Altix you have to go and read from the PCI brige to
> > >> ensure all writes to it have been flushed, which is also what mmiowb()
> > >> is doing. If writel() was to guarantee this ordering, it would make
> > >> every writel() call extremely expensive :-(
> > >
> > > So if a read from the bridge achieves the same effect, can't we just put
> > > one after the writes within the spinlock (an unrelaxed one).  That way

A relaxed readX would be sufficient.  It's the next lowest cost way (after
mmiowb) of ensuring write ordering between CPUs.  Regular readX is the
most expensive method (well, we could probably come up with something worse,
but we'd have to work at it  :).

> > > this whole sequence will look like a well understood PCI posting flush
> > > rather than have to muck around with little understood (at least by most
> > > driver writers) io barriers?
> >
> > Hmmm,
> >
> > I think mmiowb() does some sort of status read from the bridge, I am not
> > sure if it's enough to just do a regular readl().
> >
> > I'm adding Jeremy to the list, he should know for sure.
> 
> I think a read from the target host bridge is enough.  What mmiowb() does 
> though is to read a *local* host bridge register, which contains a count of 
> the number of PIO ops still "in flight" on their way to their target bridge.  
> When it reaches 0, all PIOs have arrived at the target host bridge (they 
> still may be bufferd), so ordering is guaranteed.


Note that is the main advantage over a read.  There is no round trip across
the NUMA fabric.

jeremy

Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp119.mail.mud.yahoo.com (smtp119.mail.mud.yahoo.com
	[209.191.84.76]) by ozlabs.org (Postfix) with SMTP id 9F519DDE02
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 14:33:26 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 3 Jun 2008 14:33:11 +1000
References: <1211852026.3286.36.camel@pasglop>
	<20080531075242.GC108600@sgi.com> <4843C3D7.7000609@sgi.com>
In-Reply-To: <4843C3D7.7000609@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806031433.12460.nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>,
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

On Monday 02 June 2008 19:56, Jes Sorensen wrote:
> Jeremy Higdon wrote:
> > We don't actually have that problem on the Altix.  All writes issued
> > by CPU X will be ordered with respect to each other.  But writes by
> > CPU X and CPU Y will not be, unless an mmiowb() is done by the
> > original CPU before the second CPU writes.  I.e.
> >
> > 	CPU X	writel
> > 	CPU X	writel
> > 	CPU X	mmiowb
> >
> > 	CPU Y	writel
> > 	...
> >
> > Note that this implies some sort of locking.  Also note that if in
> > the above, CPU Y did the mmiowb, that would not work.
>
> Hmmm,
>
> Then it's less bad than I thought - my apologies for the confusion.
>
> Would we be able to use Ben's trick of setting a per cpu flag in
> writel() then and checking that in spin unlock issuing the mmiowb()
> there if needed?

Yes you could, but your writels would still not be strongly ordered
within (or outside) spinlock regions, which is what Linus wants (and
I kind of agree with).

This comes back to my posting about mmiowb and io_*mb barriers etc.

Despite what you say, what you've done really _does_ change the semantics
of wmb() for all drivers. It is a really sad situation we've got ourselves
into somehow, AFAIKS in the hope of trying to save ourselves a tiny bit
of work upfront :( (this is not just the sgi folk with mmiowb I'm talking
about, but the whole random undefinedness of ordering and io barriers).

The right way to make any change is never to weaken the postcondition of
an existing interface *unless* you are willing to audit the entire tree
and fix it. Impossible for drivers, so the correct thing to do is introduce
a new interface, and move things over at an easier pace. Not rocket science.

The argument that "Altix only uses a few drivers so this way we can just
fix these up rather than make big modifications to large numbers of drivers"
is bogus. It is far worse even for Altix if you make incompatible changes,
because you first *break* every driver on your platform, then you have to
audit and fix them. If you make compatible changes, then you have to do
exactly the same audits to move them over to the new API, but you go from
slower->faster rather than broken->non broken. As a bonus, you haven't
got random broken stuff all over the tree that you forgot to audit.

I don't know how there is still so much debate about this :(

I have a proposal: I am a neutral party here, not being an arch maintainer,
so I'll take input and write up a backward compatible API specification
and force everybody to conform to it ;)

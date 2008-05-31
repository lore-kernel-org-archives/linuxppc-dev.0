Return-Path: <root@ucw.cz>
Received: from spitz.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id 319C2DDE01
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 00:45:07 +1000 (EST)
Date: Sat, 31 May 2008 10:14:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080531081450.GI5405@ucw.cz>
References: <1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
	<1211922696.3286.82.camel@pasglop> <adaiqwzsa83.fsf@cisco.com>
	<yq0iqwxrwuh.fsf@jaguar.mkp.net>
	<1212097223.8888.55.camel@pasglop> <483FCD5C.208@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <483FCD5C.208@sgi.com>
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

Hi!

> >>The only way to guarantee ordering in the above setup, 
> >>is to either
> >>make writel() fully ordered or adding the mmiowb()'s 
> >>inbetween the two
> >>writel's. On Altix you have to go and read from the 
> >>PCI brige to
> >>ensure all writes to it have been flushed, which is 
> >>also what mmiowb()
> >>is doing. If writel() was to guarantee this ordering, 
> >>it would make
> >>every writel() call extremely expensive :-(
> >
> >Interesting. I've always been taught by ia64 people 
> >that mmiowb() was
> >intended to be used solely between writel() and 
> >spin_unlock().
> >
> >I think in the above case, you really should make 
> >writel() ordered.
> >Anything else is asking for trouble, for the exact same 
> >reasons that I
> >made it fully ordered on powerpc at least vs. previous 
> >stores. I only
> >kept it relaxed vs. subsequent cacheable stores (ie, 
> >spin_unlock), for
> >which I use the trick mentioned before.
> 
> Hmmm I hope I didn't mess up the description of this and 
> added to the
> confusion.
> 
> The net result of that would be to kill performance 
> completely, I really
> don't like that idea.... Having each writel() go out and 
> poll the PCI
> bridge is going to make every driver used on Altix slow 
> as a dog.
> 
> In addition it's still not going to solve the problem 
> for userland
> mapped stuff such as infinibug.
> 
> >Yes, this has some cost (can be fairly significant on 
> >powerpc too) but
> >I think it's a very basic assumption from drivers that 
> >consecutive
> >writel's, especially issued by the same CPU, will get 
> >to the device
> >in order.
> 
> In this case the cost is more than just significant, 
> it's pretty
> crippling.
> 
> >If this is a performance problem, then provide relaxed 
> >variants and
> >use them in selected drivers.
> 
> We'd have to make major changes to drivers like e1000, 
> tg3, mptsas, the
> qla2/3/4xxx and a bunch of others to get performance 
> back. I really
> think the code maintenance issue there will get far 
> worse than what we
> have today :(

Still better than changing semantics of writel for _all_ drivers.

If you are really sure driver does not depend on writel order, it is
just a sed/// command, so I don't see any big code maintenance
issues...
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

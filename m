Return-Path: <jeremy@classic.engr.sgi.com>
Received: from relay.sgi.com (netops-testserver-3-out.sgi.com [192.48.171.28])
	by ozlabs.org (Postfix) with ESMTP id 5D195DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 07:02:20 +1000 (EST)
Date: Mon, 2 Jun 2008 14:02:13 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080602210213.GA116363@sgi.com>
References: <1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
	<1211922696.3286.82.camel@pasglop> <adaiqwzsa83.fsf@cisco.com>
	<yq0iqwxrwuh.fsf@jaguar.mkp.net>
	<20080531075242.GC108600@sgi.com> <4843C3D7.7000609@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4843C3D7.7000609@sgi.com>
Cc: linux-arch@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
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

On Mon, Jun 02, 2008 at 11:56:39AM +0200, Jes Sorensen wrote:
> Jeremy Higdon wrote:
> >We don't actually have that problem on the Altix.  All writes issued
> >by CPU X will be ordered with respect to each other.  But writes by
> >CPU X and CPU Y will not be, unless an mmiowb() is done by the
> >original CPU before the second CPU writes.  I.e.
> >
> >	CPU X	writel
> >	CPU X	writel
> >	CPU X	mmiowb
> >
> >	CPU Y	writel
> >	...
> >
> >Note that this implies some sort of locking.  Also note that if in
> >the above, CPU Y did the mmiowb, that would not work.
> 
> Hmmm,
> 
> Then it's less bad than I thought - my apologies for the confusion.
> 
> Would we be able to use Ben's trick of setting a per cpu flag in
> writel() then and checking that in spin unlock issuing the mmiowb()
> there if needed?


Yes, that should work fine.  You will get more mmiowb's than you
need, since some drivers, such as Fusion, don't need them.  On the
Origins (older SGI MIPS-based Numa), the 'sync' instruction had
the same effect as mmiowb() with respect to mmio write ordering,
and it was issued unconditionally in the spin unlock.  It was
cheaper than mmiowb, however.

If it matters, we could invent and use writel_relaxed() to get
performance back in drivers we care about....

jeremy

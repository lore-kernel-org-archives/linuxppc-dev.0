Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8116BDE149
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 01:50:23 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: benh@kernel.crashing.org
Subject: Re: MMIO and gcc re-ordering issue
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop>
Date: Tue, 27 May 2008 08:50:17 -0700
In-Reply-To: <1211872130.3286.64.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Tue, 27 May 2008 17:08:50 +1000")
Message-ID: <adaprr721c6.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
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

 > Though it's my understanding that at least ia64 does require the
 > explicit barriers anyway, so we are still in a dodgy situation here
 > where it's not clear what drivers should do and we end up with
 > possibly excessive barriers on powerpc where I end up with both
 > the wmb/rmb/mb that were added for ia64 -and- the ones I have in
 > readl/writel to make them look synchronous... Not nice.

ia64 is a disaster with a slightly different ordering problem -- the
mmiowb() issue.  I know Ben knows far too much about this, but for big
SGI boxes, you sometimes need mmiowb() to avoid problems with driver
code that does totally sane stuff like

	spin_lock(&mmio_lock);
	writel(val1, reg1);
	writel(val2, reg2);
	spin_unlock(&mmio_lock);

If that snippet is called on two CPUs at the same time, then the device
might see a sequence like

	CPU1 -- write reg1
	CPU2 -- write reg1
	CPU1 -- write reg2
	CPU2 -- write reg2

in spite of the fact that everything is totally ordered on the CPUs by
the spin lock.

The reason this is such a disaster is because the code looks right,
makes sense, and works fine on 99.99% of all systems out there.  So I
would bet that 99% of our drivers have missing mmiowb() "bugs" -- no one
has plugged the hardware into an Altix box and cared enough to stress
test it.

However for the issue at hand, my expectation as a driver writer is that
readl()/writel() are ordered with respect to MMIO operations, but not
necessarily with respect to normal writes to coherent CPU memory.  And
I've included explicit wmb()s in code I've written like
drivers/infiniband/hw/mthca.

 - R.

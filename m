Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 355E6DDF16
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 07:10:55 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
Content-Type: text/plain
Date: Wed, 28 May 2008 07:10:21 +1000
Message-Id: <1211922621.3286.80.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, David Miller <davem@davemloft.net>,
	alan@lxorguk.ukuu.org.uk
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-05-27 at 08:35 -0700, Linus Torvalds wrote:
> 
> On Tue, 27 May 2008, Benjamin Herrenschmidt wrote:
> > 
> > Yes. As it is today, tg3 for example is potentially broken on all archs
> > with newer gcc unless we either add "memory" clobber to readl/writel or
> > stick some wmb's in there (just a random driver I picked).
> > 
> > So Linus, what is your take on that matter ?
> 
> Let's just serialize the damn things, and add a memory clobber to them.
> 
> Expecting people to fix up all drivers is simply not going to happen. And 
> serializing things shouldn't be *that* expensive. People who cannot take 
> the expense can continue to use the magic __raw_writel() etc stuff.

Ok.

Do we also remove wmb/rmb/... from drivers then ? :-) I think ia64 would
need to be fixed to make their writel serializing...

Regarding __raw_* their semantics are dodgy ... we might want to provide
something better but it's a different subject.

Cheers,
Ben.

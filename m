Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5328DDFF0
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 08:20:01 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
	<1211924335.3286.89.camel@pasglop>
	<alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
Content-Type: text/plain
Date: Wed, 28 May 2008 08:19:39 +1000
Message-Id: <1211926779.3286.104.camel@pasglop>
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


On Tue, 2008-05-27 at 14:55 -0700, Linus Torvalds wrote:
> 
> On Wed, 28 May 2008, Benjamin Herrenschmidt wrote:
> > 
> > A problem with __raw_ though is that they -also- don't do byteswap,
> 
> Well, that's why there is __readl() and __raw_readl(), no?

As I replied to somebody else, __readl() is news to me :-) we dont' have
those on powerpc.

> Neither does ordering, and __raw_readl() doesn't do byte-swap.

But I can add them :-)

> Of course, I'm not going to guarantee every architecture even has all 
> those versions, nor am I going to guarantee they all work as advertised :)
> 
> For x86, they have historially all been 100% identical. With the inline 
> asm patch I posted, the "__" version (whether "raw" or not) lack the 
> "memory" barrier, so they allow a *little* bit more re-ordering.
> 
> (They won't be re-ordered wrt spinlocks etc, unless gcc starts reordering 
> volatile asm's against each other, which would be a bug).
> 
> In practice, I doubt it matters. Whatever small compiler re-ordering it 
> might affect won't have any real performance impack one way or the other, 
> I think.

I prefer explicit endian. Always. Thus I prefer introducing _be variants
(we already have those on powerpc and iomap has it's own _be versions
too) so we should probably generalize _be.

Ben.

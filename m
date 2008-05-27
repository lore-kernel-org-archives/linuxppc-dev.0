Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20FC9DDFD9
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 08:15:10 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <adaiqwzsa83.fsf@cisco.com>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop>
	<adaprr721c6.fsf@cisco.com> <1211922696.3286.82.camel@pasglop>
	<adaiqwzsa83.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 28 May 2008 08:13:30 +1000
Message-Id: <1211926410.3286.95.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, torvalds@linux-foundation.org,
	tpiepho@freescale.com, alan@lxorguk.ukuu.org.uk,
	Arjan van de Ven <arjan@infradead.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-05-27 at 14:33 -0700, Roland Dreier wrote:
> > This is a different issue. We deal with it on powerpc by having writel
>  > set a per-cpu flag and spin_unlock() test it, and do the barrier if
>  > needed there.
> 
> Cool... I assume you do this for mutex_unlock() etc?

That's a good point... I don't think we do. Maybe we should.

> Is there any reason why ia64 can't do this too so we can kill mmiowb and
> save everyone a lot of hassle?  (mips, sh and frv have non-empty
> mmiowb() definitions too but I'd guess that these are all bugs based on
> misunderstandings of the mmiowb() semantics...)

Well, basically our approach was that mmiowb() is a pain in the neck,
nobody (ie. driver writers) really understands what it's for, and so
it's either not there or misused. So we didn't want to introduce it for
powerpc, but instead did the trick above in order to -slightly- improve
our writel (ie avoid a sync -after- the write) .

>  > However, drivers such as e1000 -also- have a wmb() between filling the
>  > ring buffer and kicking the DMA with MMIO, with a comment about this
>  > being needed for ia64 relaxed ordering.
> 
> I put these barriers into mthca, mlx4 etc, although it came from my
> possible misunderstanding of the memory ordering rules in the kernel
> more than any experience of problems (as opposed the the mmiowb()s,
> which all came from real world bugs).

Ben.

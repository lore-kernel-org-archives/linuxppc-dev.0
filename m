Return-Path: <root@ucw.cz>
Received: from spitz.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id 5E386DDF46
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 00:45:18 +1000 (EST)
Date: Sat, 31 May 2008 10:04:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080531080427.GH5405@ucw.cz>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adaprr721c6.fsf@cisco.com>
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

Hi!

>  > Though it's my understanding that at least ia64 does require the
>  > explicit barriers anyway, so we are still in a dodgy situation here
>  > where it's not clear what drivers should do and we end up with
>  > possibly excessive barriers on powerpc where I end up with both
>  > the wmb/rmb/mb that were added for ia64 -and- the ones I have in
>  > readl/writel to make them look synchronous... Not nice.
> 
> ia64 is a disaster with a slightly different ordering problem -- the
> mmiowb() issue.  I know Ben knows far too much about this, but for big
> SGI boxes, you sometimes need mmiowb() to avoid problems with driver
> code that does totally sane stuff like
> 
> 	spin_lock(&mmio_lock);
> 	writel(val1, reg1);
> 	writel(val2, reg2);
> 	spin_unlock(&mmio_lock);
> 
> If that snippet is called on two CPUs at the same time, then the device
> might see a sequence like
> 
> 	CPU1 -- write reg1
> 	CPU2 -- write reg1
> 	CPU1 -- write reg2
> 	CPU2 -- write reg2
> 
> in spite of the fact that everything is totally ordered on the CPUs by
> the spin lock.
> 
> The reason this is such a disaster is because the code looks right,
> makes sense, and works fine on 99.99% of all systems out there.  So I
> would bet that 99% of our drivers have missing mmiowb() "bugs" -- no one
> has plugged the hardware into an Altix box and cared enough to stress
> test it.

Yes, ia64 is a disaster, and needs its spinlock implementation fixed
:-).
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

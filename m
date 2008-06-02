Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D3469DDE41
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 20:37:57 +1000 (EST)
Date: Mon, 2 Jun 2008 12:36:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080602103643.GA21285@elte.hu>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<alpine.LFD.1.10.0805270943100.2958@woody.linux-foundation.org>
	<alpine.LFD.1.10.0805271028520.2958@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.1.10.0805271028520.2958@woody.linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, David Miller <davem@davemloft.net>,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Here's a UNTESTED patch for x86 that may or may not compile and 
> > work, and which serializes (on a compiler level) the IO accesses 
> > against regular memory accesses.
> 
> Ok, so it at least boots on x86-32. Thus probably on x86-64 too (since 
> the code is now shared). I didn't look at whether it generates much 
> bigger code due to the potential extra serialization, but some of the 
> code generation I looked at looked fine.
> 
> IOW, it doesn't at least create any _obviously_ worse code, and it 
> should be arguably safer than assuming the compiler does volatile 
> accesses the way we want it to.

ok, to pursue this topic of making readl*/writel*() more robust i picked 
up your patch into -tip and created a new topic branch for it: 
tip/x86/mmio.

The patch passed initial light testing in -tip (~30 successful random 
self-builds and bootups on various mixed 32-bit/64-bit boxes) but it's 
still v2.6.27 material IMO.

Failures in this area are subtle so there's no good way to tell whether 
it works as intended - we need wider testing. I've also added the 
tip/x86/mmio topic to tip/auto-x86-next rules as well so these changes 
will be picked up by tomorrow's linux-next tree as well, and by the next 
-mm iteration.

	Ingo

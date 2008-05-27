Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 82968DDDF3
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 01:36:19 +1000 (EST)
Date: Tue, 27 May 2008 08:35:29 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <1211859542.3286.46.camel@pasglop>
Message-ID: <alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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



On Tue, 27 May 2008, Benjamin Herrenschmidt wrote:
> 
> Yes. As it is today, tg3 for example is potentially broken on all archs
> with newer gcc unless we either add "memory" clobber to readl/writel or
> stick some wmb's in there (just a random driver I picked).
> 
> So Linus, what is your take on that matter ?

Let's just serialize the damn things, and add a memory clobber to them.

Expecting people to fix up all drivers is simply not going to happen. And 
serializing things shouldn't be *that* expensive. People who cannot take 
the expense can continue to use the magic __raw_writel() etc stuff.

			Linus

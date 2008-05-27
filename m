Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8CBFADE02F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 07:39:46 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
Content-Type: text/plain
Date: Wed, 28 May 2008 07:38:55 +1000
Message-Id: <1211924335.3286.89.camel@pasglop>
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


> So practically speaking, I suspect that the right approach is to just say 
> "ok, x86 will continue to be pretty darn ordered, and the barriers won't 
> really matter (*)" but at the same time also saying "we wish reality was 
> different, and well-maintained drivers should probably try to work in the 
> presense of re-ordering".

Ok, well, I'll slap "memory" clobbers onto powerpc accessors, we made
them fully ordered a while ago anyway. The extra barriers in drivers
like USB etc.. won't hurt us much, we can always fine tune drivers that
really want high performances.

A problem with __raw_ though is that they -also- don't do byteswap,
which is a pain in the neck as people use them for either one reason
(relaxed ordering) or the other (no byteswap) without always knowing the
consequences of doing so...

I'm happy to say that __raw is purely about ordering and make them
byteswap on powerpc tho (ie, make them little endian like the non-raw
counterpart).

Some archs started providing writel_be etc... I added those to powerpc a
little while ago, and I tend to prefer that approach for the byteswap
issue.

What do you think ?

Ben.

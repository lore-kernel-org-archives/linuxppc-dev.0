Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17363DDEED
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 07:54:30 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20080602103643.GA21285@elte.hu>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<alpine.LFD.1.10.0805270943100.2958@woody.linux-foundation.org>
	<alpine.LFD.1.10.0805271028520.2958@woody.linux-foundation.org>
	<20080602103643.GA21285@elte.hu>
Content-Type: text/plain
Date: Tue, 03 Jun 2008 07:53:24 +1000
Message-Id: <1212443604.26672.7.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-06-02 at 12:36 +0200, Ingo Molnar wrote:
> The patch passed initial light testing in -tip (~30 successful random 
> self-builds and bootups on various mixed 32-bit/64-bit boxes) but
> it's 
> still v2.6.27 material IMO.

I think adding the "memory" clobber should be .26 and even -stable. We
know for sure newer gcc will re-order things, we know it for sure some
drivers will break in subtle ways because of that, ad we know as well
that sticking "memory" clobber in there will fix that breakage we know
about ... So I don't see the point of waiting.

Ben.

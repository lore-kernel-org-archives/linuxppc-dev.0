Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69818DDFF0
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 07:59:45 +1000 (EST)
Date: Tue, 27 May 2008 14:59:28 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <20080527223822.57306677@core>
Message-ID: <alpine.LFD.1.10.0805271456060.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
	<20080527223822.57306677@core>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Tue, 27 May 2008, Alan Cox wrote:
>
> > re-ordering, even though I doubt it will be visible in practice. So if you 
> > use the "__" versions, you'd better have barriers even on x86!
> 
> Are we also going to have __ioread*/__iowrite* ?

I doubt there is any reason to. Let's just keep them very strictly 
ordered. 

> Also is the sematics of __readl/__writel defined for all architectures -
> I used it ages ago in the i2o drivers for speed and it got removed
> because it didn't build on some platforms.

Agreed - I'm not sure the __ versions are really worth it. We have them, 
but the semantics are subtle enough that most drivers will never care 
enough to really use them.

I would suggest using them mainly for architecture-specific drivers, on 
architectures where it actually matters (which is not the case on x86).

		Linus

Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AA7E4DDECA
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 08:02:32 +1000 (EST)
Date: Tue, 27 May 2008 15:02:15 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <20080527215328.GB22636@parisc-linux.org>
Message-ID: <alpine.LFD.1.10.0805271459550.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
	<20080527223822.57306677@core>
	<20080527215328.GB22636@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, David Miller <davem@davemloft.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Tue, 27 May 2008, Matthew Wilcox wrote:

> On Tue, May 27, 2008 at 10:38:22PM +0100, Alan Cox wrote:
> > > re-ordering, even though I doubt it will be visible in practice. So if you 
> > > use the "__" versions, you'd better have barriers even on x86!
> > 
> > Are we also going to have __ioread*/__iowrite* ?
> 
> Didn't we already define ioread*() to have loose semantics?

They are supposed to have the same semantics as readl/writel.

And yes, it's "loose", but only when compared to inb/outb (which are 
really very strict, if you want to emulate x86 - an "outb" basically is 
not only ordered, it doesn't even post the write, and waits until it has 
hit the bus!)

		Linus

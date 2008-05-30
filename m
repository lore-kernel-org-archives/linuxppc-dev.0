Return-Path: <Haavard.Skinnemoen@atmel.com>
Received: from bagnes.atmel.com (smtpeu1.atmel.com [195.65.72.27])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35A4CDDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 18:27:36 +1000 (EST)
Date: Fri, 30 May 2008 10:27:06 +0200
From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
To: benh@kernel.crashing.org
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080530102706.56fca248@siona.local>
In-Reply-To: <1212132267.15633.69.camel@pasglop>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
	<1211924335.3286.89.camel@pasglop>
	<20080527214241.GA22636@parisc-linux.org>
	<1211926636.3286.100.camel@pasglop>
	<20080528103648.54eb8734@hskinnemo-gx745.norway.atmel.com>
	<1212110003.15633.0.camel@pasglop>
	<20080530080700.773a82cc@siona.local>
	<1212132267.15633.69.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	linux-kernel@vger.kernel.org, tpiepho@freescale.com,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 30 May 2008 17:24:27 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Fri, 2008-05-30 at 08:07 +0200, Haavard Skinnemoen wrote:
> > I think the drivers I've written have the necessary barriers (or dma
> > ops with implicit barriers) that they don't actually depend on any
> > DMA vs. MMIO ordering guarantees. I hope MMIO vs. MMIO ordering is
> > guaranteed though?
> 
> Only to the same address I'd say.

Right, I sort of suspected that.

Now, I'm pretty sure the architectures that can actually run those
drivers (ARM9 and AVR32 AP7) provide stronger guarantees than that, and
I suspect the same is true on most other embedded architectures that
use __raw_* in their drivers. So I don't think adding barriers is the
right thing to do because they won't do anything useful in practice, so
it's hard to tell whether they are used "correctly". And it will hurt
performance at least on AVR32 since wmb() evaluates to a "sync"
instruction, which flushes the write buffer to RAM. Since MMIO writes
are unbuffered, that's pure overhead.

Maybe we need another interface that does not do byteswapping but
provides stronger ordering guarantees?

Haavard

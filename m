Return-Path: <Haavard.Skinnemoen@atmel.com>
Received: from bagnes.atmel.com (smtpeu1.atmel.com [195.65.72.27])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94D4CDDE24
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 17:46:58 +1000 (EST)
Date: Tue, 3 Jun 2008 09:46:46 +0200
From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080603094646.0dbf2911@hskinnemo-gx745.norway.atmel.com>
In-Reply-To: <20080602154812.GB2734@loki.buserror.net>
References: <1211924335.3286.89.camel@pasglop>
	<20080527214241.GA22636@parisc-linux.org>
	<1211926636.3286.100.camel@pasglop>
	<20080528103648.54eb8734@hskinnemo-gx745.norway.atmel.com>
	<1212110003.15633.0.camel@pasglop>
	<20080530080700.773a82cc@siona.local>
	<1212132267.15633.69.camel@pasglop>
	<20080530102706.56fca248@siona.local>
	<Pine.LNX.4.64.0805301120510.26332@anakin>
	<20080602101102.0d8979c5@hskinnemo-gx745.norway.atmel.com>
	<20080602154812.GB2734@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	linux-kernel@vger.kernel.org, tpiepho@freescale.com,
	linuxppc-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
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

Scott Wood <scottwood@freescale.com> wrote:
> On Mon, Jun 02, 2008 at 10:11:02AM +0200, Haavard Skinnemoen wrote:
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, 30 May 2008, Haavard Skinnemoen wrote:
> > > > Maybe we need another interface that does not do byteswapping but
> > > > provides stronger ordering guarantees?
> > > 
> > > The byte swapping depends on the device/bus.
> > 
> > Of course. But isn't it reasonable to assume that a device integrated
> > on the same silicon as the CPU is connected to a somewhat sane bus
> > which doesn't require any byte swapping?
> 
> No, unfortunately. :-(

Ok, I guess I was being naive.

> See the end of drivers/dma/fsldma.h.  Likewise with Freescale's PCI host
> bridges; for some reason the bus itself being little endian led to the host
> bridge control registers also being little endian.

Right. But still, isn't it better to handle it on a case-by-case basis
in the drivers? In some cases, it's best to explicitly use a certain
byte order, in others it's best to use whatever is native to the CPU.

Haavard

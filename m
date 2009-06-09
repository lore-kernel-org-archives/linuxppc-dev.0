Return-Path: <subrata@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D65A3B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 04:34:41 +1000 (EST)
Subject: Re: [BUILD FAILURE 01/04] Next June 04:PPC64 randconfig
	[drivers/staging/comedi/drivers.o]
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg KH <greg@kroah.com>
In-Reply-To: <1244519418.5235.2.camel@pasglop>
References: <20090605182625.24093.7808.sendpatchset@elm3a191.beaverton.ibm.com>
	<1244261806.31984.36.camel@pasglop> <20090606055103.GA9446@kroah.com>
	<200906060936.22322.fmhess@speakeasy.net>
	<1244385405.5265.7.camel@subratamodak.linux.ibm.com>
	<1244519418.5235.2.camel@pasglop>
Content-Type: text/plain
Date: Wed, 10 Jun 2009 00:04:04 +0530
Message-Id: <1244572446.5497.32.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Cc: sachinp@linux.vnet.ibm.com, fmhess@users.sourceforge.net,
	sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
	Linuxppc-dev@ozlabs.org, Ian Abbott <abbotti@mev.co.uk>,
	linux-next@vger.kernel.org, paulus@samba.org,
	Geert.Uytterhoeven@sonycom.com, geert@linux-m68k.org,
	David Miller <davem@davemloft.net>
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-06-09 at 13:50 +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2009-06-07 at 20:06 +0530, Subrata Modak wrote:
> > On Sat, 2009-06-06 at 09:36 -0400, Frank Mori Hess wrote:
> > > On Saturday 06 June 2009, Greg KH wrote:
> > > > Frank and Ian, any thoughts about the vmap call in the
> > > > comedi_buf_alloc() call?  Why is it using PAGE_KERNEL_NOCACHE, and what
> > > > is the prealloc_buf buffer used for?
> > > 
> > > It is a circular buffer used to hold data streaming either to or from a 
> > > board (for example when producing an analog output waveform).  Reads and 
> > > writes to the device files read/write to the circular buffer, plus a few 
> > > drivers do dma directly to/from it.  I personally don't have a problem 
> > > with requiring drivers to have their own dma buffers and making them copy 
> > > data between their private dma buffers and the main circular buffer.  I 
> > > guess the original design wanted to support zero-copy dma.
> > 
> > Great to hear that. How about a patch that solves my build problem on
> > PPC64(the problem seems to be existing for long) ? 
> 
> In any case, doing PAGE_KERNEL_NOCACHE for DMA memory is incorrect on
> many architectures. So at this stage, there's no much option but ifdef I
> suspect for now until this is fixed properly.

Ok. But, i am not sure whether Greg will agree to this. If, Ok, is the
following patch i sent earlier Ok ?

http://lkml.org/lkml/2009/6/5/462,

Regards--
Subrata

> 
> It does make sense to want to have some memory like that shared between
> user space and DMA, though I don't know what the right approach that
> works on all archs is at this stage. Worth asking the Alsa guys, I think
> they have similar issues :-)
> 
> But doing double buffering might do the trick fine for now.
> 
> Cheers,
> Ben.
> 
> 
> 
> 

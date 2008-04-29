Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 04FCEDE925
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 05:17:21 +1000 (EST)
Date: Tue, 29 Apr 2008 21:17:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: 2.6.25: pmac_newworld undefined
Message-ID: <20080429191753.GA32685@uranus.ravnborg.org>
References: <alpine.DEB.1.10.0804271951190.11017@sheep.housecafe.de>
	<20080428042044.GX20457@bakeyournoodle.com>
	<20080428193324.GC13400@uranus.ravnborg.org>
	<20080429133514.GA30524@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080429133514.GA30524@cs181133002.pp.htv.fi>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2008 at 04:35:14PM +0300, Adrian Bunk wrote:
> On Mon, Apr 28, 2008 at 09:33:24PM +0200, Sam Ravnborg wrote:
> > On Mon, Apr 28, 2008 at 02:20:44PM +1000, Tony Breeds wrote:
> > > On Sun, Apr 27, 2008 at 08:03:46PM +0200, Christian Kujau wrote:
> > > > Hi,
> > > > 
> > > > the build failure reported[0] by Kamalesh back in 01/2008 is still 
> > > > present in today's 2.6.25-git with CONFIG_NVRAM=m (instead of =y):
> > > > 
> > > >   Building modules, stage 2.
> > > >   MODPOST 72 modules
> > > > ERROR: "pmac_newworld" [arch/powerpc/platforms/powermac/nvram.ko] undefined!
> > > > ERROR: "__alloc_bootmem" [arch/powerpc/platforms/powermac/nvram.ko] 
> > > > undefined!
> > > > make[1]: *** [__modpost] Error 1
> > > 
> > > Yeah that isn't really surprising.  Essentially
> > > arch/powerpc/platforms/powermac/nvram.c must be builtin (not modular)
> > > but CONFIG_NVRAM is tristate, and your .config has CONFIG_NVRAM=m.
> > > 
> > > We can probably "fix" this by adding another config config symbol and
> > > "selecting" that from CONFIG_NVRAM.  Then using this new symbol in
> > > arch/powerpc/platforms/powermac/*
> > > 
> > > so I think with we need is:
> > > config NVRAM
> > >   bool "..." if PPC32
> > >   tristate "..." if !PPC32
> > >   ...
> > >   ...
> > > 
> > > Sam is there some way to achieve that or should we just create an
> > > secondary symbol?
> > 
> > In the Makefile you could just do a:
> > 
> > obj-$(CONFIG_NVRAM:m=y)             += nvram.o
> > 
> > Then you would force nvram to be build-in.
> > That looks simpler than messing with Kconfig in this case.
> 
> You miss that this is only true on powerpc.
And so is the Makefile - right?
Or is this only true for 32 bit powerpc - in that case it is the wrong fix.

> And for such issues Kconfig anyway is the right place - assume how your 
> solution would break if NVRAM would some day select or depend on some 
> helper code.

So something like:

config PPC32_NVRAM
	bool
	depends on NVRAM

obj-$(CONFIG_PPC32_NVRAM) += nvram.o
obj-$(CONFIG_NVRAM)       += nvram.o

Or did you have another solution in mind?

	Sam

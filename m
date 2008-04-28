Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id C3328DE4E1
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 05:32:52 +1000 (EST)
Date: Mon, 28 Apr 2008 21:33:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: 2.6.25: pmac_newworld undefined
Message-ID: <20080428193324.GC13400@uranus.ravnborg.org>
References: <alpine.DEB.1.10.0804271951190.11017@sheep.housecafe.de>
	<20080428042044.GX20457@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080428042044.GX20457@bakeyournoodle.com>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 02:20:44PM +1000, Tony Breeds wrote:
> On Sun, Apr 27, 2008 at 08:03:46PM +0200, Christian Kujau wrote:
> > Hi,
> > 
> > the build failure reported[0] by Kamalesh back in 01/2008 is still 
> > present in today's 2.6.25-git with CONFIG_NVRAM=m (instead of =y):
> > 
> >   Building modules, stage 2.
> >   MODPOST 72 modules
> > ERROR: "pmac_newworld" [arch/powerpc/platforms/powermac/nvram.ko] undefined!
> > ERROR: "__alloc_bootmem" [arch/powerpc/platforms/powermac/nvram.ko] 
> > undefined!
> > make[1]: *** [__modpost] Error 1
> 
> Yeah that isn't really surprising.  Essentially
> arch/powerpc/platforms/powermac/nvram.c must be builtin (not modular)
> but CONFIG_NVRAM is tristate, and your .config has CONFIG_NVRAM=m.
> 
> We can probably "fix" this by adding another config config symbol and
> "selecting" that from CONFIG_NVRAM.  Then using this new symbol in
> arch/powerpc/platforms/powermac/*
> 
> so I think with we need is:
> config NVRAM
>   bool "..." if PPC32
>   tristate "..." if !PPC32
>   ...
>   ...
> 
> Sam is there some way to achieve that or should we just create an
> secondary symbol?

In the Makefile you could just do a:

obj-$(CONFIG_NVRAM:m=y)             += nvram.o

Then you would force nvram to be build-in.
That looks simpler than messing with Kconfig in this case.

	Sam

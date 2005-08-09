Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 8177E67FE5
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2005 02:21:35 +1000 (EST)
Date: Tue, 9 Aug 2005 09:21:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050809162133.GL3187@smtp.west.cox.net>
References: <200508091647.32925.arnd@arndb.de>
	<80BD2461-35F1-4B9D-983E-E2BCFFC08C77@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80BD2461-35F1-4B9D-983E-E2BCFFC08C77@freescale.com>
Cc: linuxppc64-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2005 at 10:01:05AM -0500, Kumar Gala wrote:
> >I think you are both right, just using different terminology. The
> >running kernel uses its own representation of the device tree, which
> >is neither the flattened stuff nor using the OF interfaces. The
> >conversion from OF to the flattened tree is done by the kernel itself.
> >
> >      Apple OF  \
> >          SLOF   \
> >       pSeries    |-1- prom_init------,
> >          PIBS   /                     \
> >           ...  /                       \
> >                                         \
> >       other    -----------------------------2-- 
> >unflatten_device_tree--3--
> >   boot loader                              /
> >                                           /
> >       iSeries  ----------- early_setup---`
> >
> >All "regular" machines enter in the traditional prom_init path (1)
> >from Open Firmware. The embedded machines that are too memory  
> >constraint
> >to use SLOF have a flattened device tree in their boot loader and the
> >legacy iSeries boxes can fake the device tree in their  
> >iSeries_early_setup
> >function. The main entry point (2) is entered by all machines when the
> >flattened device tree is there and the kernel builds its tree  
> >representation
> >for run time (3).
> 
> I guess my point is that in the "new" powerpc arch doing steps 1 & 3  
> should no longer be part of the kernel proper.  The should be handled  
> by boot wrappers of some form.  I know Ben tool care to ensure that  
> prom_init was isolated from kernel proper and I'm suggesting we move  
> it into a boot wrapper going forward.

That's not 100% true because as Segher said, prom_init.c is part of the
kernel (tree, image), but is what does the translation.

-- 
Tom Rini
http://gate.crashing.org/~trini/

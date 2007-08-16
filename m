Return-Path: <dgibson@ozlabs.org>
Date: Thu, 16 Aug 2007 15:51:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 3/4] PowerPC 440EPx: Sequoia bootwrapper
Message-ID: <20070816055135.GH3540@localhost.localdomain>
References: <20070814184107.GA6696@ru.mvista.com>
	<20070814185355.GA12472@ru.mvista.com>
	<20070815034622.GB22849@localhost.localdomain>
	<46C2F022.8070106@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46C2F022.8070106@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 15, 2007 at 04:22:58PM +0400, Valentine Barshak wrote:
> David Gibson wrote:
> > On Tue, Aug 14, 2007 at 10:53:55PM +0400, Valentine Barshak wrote:
> >> Bootwrapper code for AMCC 440EPx Sequoia board.
> >> The DDR2 Denali controller support has been moved to
> >>  arch/powerpc/boot/4xx.c
> >> The code also uses 440EP clocking fixups
> >> initially provided for 440EP Bamboo.
> >>
> >> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> > 
> > [snip]
> >> diff -ruN linux-2.6.orig/arch/powerpc/boot/cuboot-sequoia.c linux-2.6/arch/powerpc/boot/cuboot-sequoia.c
> >> --- linux-2.6.orig/arch/powerpc/boot/cuboot-sequoia.c	1970-01-01 03:00:00.000000000 +0300
> >> +++ linux-2.6/arch/powerpc/boot/cuboot-sequoia.c	2007-08-14 17:25:37.000000000 +0400
> >> @@ -0,0 +1,31 @@
> >> +/*
> >> + * Old U-boot compatibility for Sequoia
> >> + *
> >> + * Based on Ebony code by David Gibson <david@gibson.dropbear.id.au>
> >> + *
> >> + * Copyright 2007 David Gibson, IBM Corporatio.
> >> + *   Based on cuboot-83xx.c, which is:
> >> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify it
> >> + * under the terms of the GNU General Public License version 2 as published
> >> + * by the Free Software Foundation.
> >> + */
> >> +
> >> +#include "ops.h"
> >> +#include "stdio.h"
> >> +#include "44x.h"
> >> +#include "cuboot.h"
> >> +
> >> +#define TARGET_4xx
> >> +#define TARGET_44x
> > 
> > Surely you need to be more specific than that to select the correct
> > bd_t structure?
> 
> Both TARGET_4xx and TARGET_44x should be selected for 44x. Otherwise I 
> get wrong bd_t structure (wrong offsets to the eth0/eth1 MAC addresses). 
> In the older arch/ppc code it used to be CONFIG_4xx and it was selected 
> for CONFIG_40x and CONFIG_44x as well.

Yes, I'm not objecting to those TARGET macros, but I'd be very
surprised if you don't need more to really get the correct bd_t
structure.

[snip]
> >> diff -ruN linux-2.6.orig/arch/powerpc/boot/sequoia.c linux-2.6/arch/powerpc/boot/sequoia.c
> >> --- linux-2.6.orig/arch/powerpc/boot/sequoia.c	1970-01-01 03:00:00.000000000 +0300
> >> +++ linux-2.6/arch/powerpc/boot/sequoia.c	2007-08-14 20:52:10.000000000 +0400
> > 
> > Unless another bootloader is expected to come along for Sequoia,
> > there's no reason to separate sequoia.c from cuboot-sequoia.c
> 
> The previous version of Sequoia series had treeboot-sequoia.c, but I've 
> removed it since only u-boot is used now.
> I'm not sure if there are any other bootloaders expected, but is it OK 
> if I leave 2 separate files just in case? :)

Not unless you have a particular reason to expect another bootloader
will come along, which doesn't seem that likely to me.  Or rather the
only likely future bootloader I'd see is newer versions of u-boot
which are device tree aware and handled separately anyway.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

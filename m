Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jan 2008 14:29:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 3/5] Warp Base Platform
Message-ID: <20080110032955.GG17816@localhost.localdomain>
References: <47852C41.8000506@pikatech.com> <47852D16.2070906@pikatech.com>
	<20080110024926.GD17816@localhost.localdomain>
	<47858E46.9010505@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47858E46.9010505@pikatech.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 10:17:26PM -0500, Sean MacLennan wrote:
> David Gibson wrote:
> > On Wed, Jan 09, 2008 at 03:22:46PM -0500, Sean MacLennan wrote:
> >   
> >> Basically the powerpc/boot directory files.
> >>     
> >
> > [snip]
> >   
> >> --- /dev/null	2005-11-20 22:22:37.000000000 -0500
> >> +++ arch/powerpc/boot/cuboot-warp.c	2008-01-08 12:09:39.000000000 -0500
> >> @@ -0,0 +1,25 @@
> >> +/*
> >> + * Copyright (c) 2008 PIKA Technologies
> >> + *   Sean MacLennan <smaclennan@pikatech.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify it
> >> + * under the terms of the GNU General Public License version 2 as published
> >> + * by the Free Software Foundation.
> >> + */
> >> +
> >> +#include "ops.h"
> >> +#include "44x.h"
> >> +#include "cuboot.h"
> >> +
> >> +#define TARGET_44x
> >> +#include "ppcboot.h"
> >> +
> >> +static bd_t bd;
> >> +
> >> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> >> +				   unsigned long r6, unsigned long r7)
> >> +{
> >> +	CUBOOT_INIT();
> >> +
> >> +	warp_init(&bd.bi_enetaddr, &bd.bi_enet1addr);
> >> +}
> >> --- /dev/null	2005-11-20 22:22:37.000000000 -0500
> >> +++ arch/powerpc/boot/warp.c	2008-01-08 12:09:54.000000000 -0500
> >>     
> >
> > Fold all this into cuboot-warp.c, unless you actually anticipate
> > adding another wrapper for another firmware which will also use the
> > functions in warp.c.
> >
> >   
> Yes, there is still a plan to use the u-boot device tree. Although not 
> in the near feature. I could roll them togeather for now and split them 
> out later.

Yes, but device-tree aware u-boot doesn't need anything platform
specific in the bootwrapper, so won't be a second user of warp.c.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

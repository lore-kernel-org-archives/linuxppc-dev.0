Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7209CDDFCB
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 04:50:55 +1000 (EST)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6IHsNK1008262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 13:54:25 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6IHpEA7004611
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 13:51:14 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6IHpEbh266400
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:51:14 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6IHpDgc027130
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:51:13 -0600
Subject: Re: [patch 14/14] Bamboo zImage wrapper
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <6e26faa3f30dddc5fcf6294a1ecb3a78@bga.com>
References: <6e26faa3f30dddc5fcf6294a1ecb3a78@bga.com>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 12:51:13 -0500
Message-Id: <1184781073.16299.29.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-18 at 12:21 -0500, Milton Miller wrote:
> Sorry for the broken reply but the list is broken.
> 
> On Wed Jul 18 04:16:01 EST 2007, Josh Boyer wrote:
> > Add a bootwrapper for Bamboo
> 
> bamboo is what, an evaluation board? for which processor?

Yes, 440EP.

> > --- linux-2.6.orig/arch/powerpc/boot/Makefile
> > +++ linux-2.6/arch/powerpc/boot/Makefile
> > @@ -143,6 +143,7 @@ image-$(CONFIG_PPC_83xx)            += cuImage.83x
> >  image-$(CONFIG_PPC_85xx)               += cuImage.85xx
> >  image-$(CONFIG_EBONY)                  += treeImage.ebony 
> > cuImage.ebony
> >  image-$(CONFIG_WALNUT)                 += treeImage.walnut
> > +image-$(CONFIG_BAMBOO)                 += treeImage.bamboo
> >  endif
> 
> You are only making one target.

Yes... why is that a problem?

> > +static void bamboo_fixups(void)
> > +{
> > +       unsigned long sysclk = 33333333;
> > +       ibm440ep_fixup_clocks(sysclk, 11059200);
> > +       ibm4xx_fixup_memsize();
> > +       ibm4xx_reset_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
> > +}
> 
> This seems to have board specific information ..

I should hope so... it's a wrapper for the bamboo board.

> > --- /dev/null
> > +++ linux-2.6/arch/powerpc/boot/treeboot-bamboo.c
> > @@ -0,0 +1,27 @@
> ... [copyright header]
> > +#include "ops.h"
> > +#include "stdio.h"
> > +#include "44x.h"
> > +
> > +extern char _end[];
> > +
> > +BSS_STACK(4096);
> > +
> > +void platform_init(void)
> > +{
> > +       unsigned long end_of_ram = 0x8000000;
> > +       unsigned long avail_ram = end_of_ram - (unsigned long)_end;
> > +
> > +       simple_alloc_init(_end, avail_ram, 32, 64);
> > +       bamboo_init();
> > +}
> 
> Is there some reason they should not all be merged into this one 
> platform file?

"they" meaning what?

> I can understand wanting the dcr fixups as a library, but lets wait to 
> do the file splits until there are actually users.  Its also easier to 
> see what's going to called when all the platform ops are filled in at 
> one spot, not spread over multiple files.

I copied this from Ebony.  There are multiple users already.  You have
two parts.  The truly common stuff in 4xx.c and the board specific
wrappers that do the things needed for the board.

You've thoroughly confused me.

josh

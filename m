Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0F332DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 07:16:02 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6BLFxKG018259
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 17:15:59 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6BLFxwu258506
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 15:15:59 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6BLFwUu003429
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 15:15:59 -0600
Subject: Re: [RFC][PATCH 3/8] 4xx MMU
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200707112256.38312.arnd@arndb.de>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162179.32199.58.camel@weaponx.rchland.ibm.com>
	<200707112256.38312.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 11 Jul 2007 16:15:57 -0500
Message-Id: <1184188557.32199.101.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-11 at 22:56 +0200, Arnd Bergmann wrote:
> On Wednesday 11 July 2007, Josh Boyer wrote:
> > +#elif defined(CONFIG_40x)
> > +/* 40x-style software loaded TLB */
> > +#  include <asm/mmu-4xx.h>
> >  #elif defined(CONFIG_44x)
> >  /* 44x-style software loaded TLB */
> >  #  include <asm/mmu-44x.h>
> 
> If you call it mmu-4xx, shouldn't it be used
> for 44x as well? I would think this either
> should be

No.  I was following the established convention that's been there for
years.  Which sucks I suppose for people not familiar with 40x/44x.
That would be a lot of stuff to change though...  e.g.:

arch/powerpc/platforms/4xx -> arch/powerpc/platforms/40x
arch/powerpc/kernel/head_4xx.S -> arch/powerpc/platforms/head_40x.S

etc.  I'd need a git tree to do that cleanly.  I've been toying with
creating one for powerpc4xx anyway so I might do that.

> 
> > +#elif defined(CONFIG_4xx)
> > +/* 40x-style software loaded TLB */
> > +#  include <asm/mmu-4xx.h>
> > -#elif defined(CONFIG_44x)
> > -/* 44x-style software loaded TLB */
> > -#  include <asm/mmu-44x.h>
> 
> or 
> 
> > +#elif defined(CONFIG_40x)
> > +/* 40x-style software loaded TLB */
> > +#  include <asm/mmu-40x.h>
> >  #elif defined(CONFIG_44x)
> >  /* 44x-style software loaded TLB */
> >  #  include <asm/mmu-44x.h>

I'll probably change it to this.  Will look a bit odd, given that C file
is arch/powerpc/mm/4xx_mmu.c.

> Is it actually feasible to get to a point where
> you can build a kernel that boots on both
> 40x and 44x, or is it just too different?

The MMUs are entirely different.  40x has real-mode and is 32-bit.  44x
is always virtual and is 36-bit.

josh

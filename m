Return-Path: <jdl@jdl.com>
Received: from jdl.com (www.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5AEBD67C34
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 02:06:11 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/10 v2] Add 8641 CPU and i8259 Setup 
In-Reply-To: Your message of "Fri, 09 Jun 2006 14:23:09 +1000."
	<1149826989.12687.50.camel@localhost.localdomain>
References: <1149803956.23938.284.camel@cashmere.sps.mot.com>
	<1149826989.12687.50.camel@localhost.localdomain>
Date: Fri, 09 Jun 2006 11:05:30 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FojUI-0004N5-E7@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Benjamin Herrenschmidt mumbled:
> 
> [A bunch of SMP issues.]
> 
> The above is wrong, it prevents using the same kernel image on another
> platform.

> Same comment above... #ifdef is bad. You are entering from 0x100 with
> address translation not disabled ?

> > +	bl	clear_bats
> >  	bl	load_up_mmu
> 
> Why do you need to call clear_bats here ? load_up_mmu should load BATs.
> If it doesn't handle the high BATs, then fix it :) 

> > +#ifdef CONFIG_I8259_LEVEL_TRIGGER
> > +	outb(0xfa, 0x4d0); /* level triggered */
> > +	outb(0xde, 0x4d1);
> > +#endif
> 
> Another change that breaks multiplatform... Can you explain precisely
> what you are trying to acheive here ? If necessary, we can add an
> argument to i8259_init. Or you could do the above in your platform
> code ... though I agree it would be a bit ugly :) 

OK.  I don't have direct answers in hand for some of
these questions and issues.  I'll get with original
authors and see what we can do clean this up!

Thanks!

jdl

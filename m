Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B1E7DDFF7
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 16:17:10 +1100 (EST)
Subject: Re: [PATCH 1/5] powerpc: Add platform support for AmigaOne
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090107190718.GA17427@ld0162-tx32.am.freescale.net>
References: <20090107135457.234150@gmx.net>
	<20090107190718.GA17427@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Mon, 12 Jan 2009 16:08:07 +1100
Message-Id: <1231736887.22571.18.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +	/* Flush and disable I/D cache. */
> > +	__asm__ __volatile__ ("mfspr	3, 1008"	::: "r3");
> > +	__asm__ __volatile__ ("ori	5, 5, 0xcc00"	::: "r5");
> > +	__asm__ __volatile__ ("ori	4, 3, 0xc00"	::: "r4");
> > +	__asm__ __volatile__ ("andc	5, 3, 5"	::: "r5");
> 
> Don't do this; instead, have one multi-line asm statement (or better yet,
> just use mfspr()/mtspr()/sync()/isync()).
> 
> GCC is perfectly free to trash your registers in between statements.

Also there's already some code around to properly flush & disable the
caches on those processors.

Ben.

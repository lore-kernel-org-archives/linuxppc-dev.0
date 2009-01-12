Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 11DD3DE124
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 10:39:04 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 13 Jan 2009 00:39:02 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1231737138.22571.22.camel@pasglop>
Message-ID: <20090112233902.221040@gmx.net>
MIME-Version: 1.0
References: <20090107135457.234150@gmx.net>	
	<20090107190718.GA17427@ld0162-tx32.am.freescale.net>	
	<20090107225048.23020@gmx.net> <1231737138.22571.22.camel@pasglop>
Subject: Re: [PATCH 1/5] powerpc: Add platform support for AmigaOne
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, scottwood@freescale.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Mon, 12 Jan 2009 16:08:07 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Scott Wood <scottwood@freescale.com>
> CC: Gerhard Pircher <gerhard_pircher@gmx.net>, linuxppc-dev@ozlabs.org
> Betreff: Re: [PATCH 1/5] powerpc: Add platform support for AmigaOne

> 
> > > +	/* Flush and disable I/D cache. */
> > > +	__asm__ __volatile__ ("mfspr	3, 1008"	::: "r3");
> > > +	__asm__ __volatile__ ("ori	5, 5, 0xcc00"	::: "r5");
> > > +	__asm__ __volatile__ ("ori	4, 3, 0xc00"	::: "r4");
> > > +	__asm__ __volatile__ ("andc	5, 3, 5"	::: "r5");
> > 
> > Don't do this; instead, have one multi-line asm statement (or better
> yet,
> > just use mfspr()/mtspr()/sync()/isync()).
> > 
> > GCC is perfectly free to trash your registers in between statements.
> 
> Also there's already some code around to properly flush & disable the
> caches on those processors.
Ouch! I searched through all assembler files in arch/powerpc/kernel/ for
such a function, but I have missed flush_disable_L1 in l2cr_6xx.S.
Thanks for the hint!

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger

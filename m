Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 32CFADDF81
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 02:40:19 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/6] powerpc: split out CPU specific options into a new
	Kconfig file
Date: Wed, 2 May 2007 18:40:07 +0200
References: <20070502114709.074174446@arndb.de>
	<20070502115644.638734471@arndb.de>
	<4638B42B.7040208@freescale.com>
In-Reply-To: <4638B42B.7040208@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705021840.07965.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 02 May 2007, Timur Tabi wrote:
> Arnd Bergmann wrote:
> 
> > +config CLASSIC32
> > +	bool "52xx/6xx/7xx/74xx"
> > +	select PPC_FPU
> > +	select 6xx
> > +	help
> > +	  There are four families of PowerPC chips supported.  The more common
> > +	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
> > +	  versions (821, 823, 850, 855, 860, 52xx, 82xx, 83xx), the AMCC
> > +	  embedded versions (403 and 405) and the high end 64 bit Power
> > +	  processors (POWER 3, POWER4, and IBM PPC970 also known as G5).
> 
> Is this help text still accurate?  The bool line says "52xx/6xx/7xx/74xx", but you talk 
> about many more processors in the help text.  You mention the 83xx, but not the 85xx or 
> 86xx, nor do you mention Freescale.  Not only that, but the help text implies that 8xx, 
> 52xx, 82xx, and 83xx are part of the same family, but the bool text implies that 52xx is 
> part of a different family.

This patch just moves stuff around, one of the later patches fixes the
text.

> > +	  This option is the catch-all for 6xx types, including some of the
> > +	  embedded versions.  Unless there is see an option for the specific
> > +	  chip family you are using, you want this option.
> 
> So CLASSIC32 is only for 6xx families, not any of the others?  Then what's the "select 
> 6xx" for?  Isn't that redundant?

Currently, CLASSIC32 refers to all Open Firmware based 6xx machines, including
PowerMac, rs6000, CHRP and PReP. 6xx includes those, and also the embedded
platforms based on 6xx cores, like 86xx.

My last patch changes it so that CLASSIC32 and 6xx are actually synonyms,
and we could kill one of them.

> > +	  You do not want this if you are building a kernel for a 64 bit
> > +	  IBM RS/6000 or an Apple G5, choose 6xx.
> 
> This needs to be reworded, as the English doesn't make sense.

It also gets fixed in a later patch.

	Arnd <><

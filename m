Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ABBC9DE0CE
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 02:50:11 +1000 (EST)
Subject: Re: RFC Patch: Use x86 init_hwif in the alim15x3 for x86-like
	PowerPC systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090417124014.GA8944@oksana.dev.rtsoft.ru>
References: <c8485d470904150202s1f5c8cd7p34f0eaf4872f3e17@mail.gmail.com>
	<c8485d470904150734s47ce0f27y3ae984355e823d9f@mail.gmail.com>
	<200904162130.01237.bzolnier@gmail.com>
	<1239954019.7443.47.camel@pasglop>
	<20090417124014.GA8944@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 18:49:44 +0200
Message-Id: <1239986984.7210.9.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, Roderick Colenbrander <thunderbird2k@gmail.com>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> But they don't. On MPC8610HPCD we have IDE interrupt directly
> connected to the MPIC line (through PCI sideband interrupt), and
> i8259 is _completely_ disabled in the bridge.

Hrm why did you do that ? :-)

Just kidding... if what you want is the PCI interrupt, then it should
be in native mode, not legacy mode... Maybe the driver can figure out
how the chip is configured by reading said configuration and use
either the legacy interrupts or the PCI one...

> See this commit:
> 
>   commit 6d1cee44361b8d06ccd1812e80448d86ae60dfe3
>   Author: Anton Vorontsov <avorontsov@ru.mvista.com>
>   Date:   Tue Apr 29 22:57:38 2008 +0200
>   
>       alim15x3: disable init_hwif_ali15x3 for PowerPC
> 
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> If the patch applied, MPC8610HPCD will be broken.
> 
> We need at least some machine_is() check.

That sucks. That's an endless problems with IDE and those on-board
chipsets though. The interrupts should pretty much -always- be provided
by the arch code, but for some reason, that got removed in favor of
various hacks in the drivers themselves...

Ben.

> > > > Regards,
> > > > Roderick Colenbrander
> > > > 
> > > > 
> > > > From 1c40c2f1485ecd3bc5ad7a3af537cb94de0877c3 Mon Sep 17 00:00:00 2001
> > > > From: Roderick Colenbrander <thunderbird2k@gmail.com>
> > > > Date: Wed, 15 Apr 2009 10:45:17 +0200
> > > > Subject: [PATCH] Use the 'x86' init_hwif code in the alim15x3 for
> > > > x86-like PowerPC boards like Xilinx ML310/410/510.
> > > 
> > > Roderick, please add your "Signed-off-by:" line
> > > (per Documentation/SubmittingPatches).
> > > 
> > > Thanks.
> > > 
> > > > ---
> > > >  drivers/ide/alim15x3.c |    9 +++++----
> > > >  1 files changed, 5 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/ide/alim15x3.c b/drivers/ide/alim15x3.c
> > > > index 537da1c..9176c0f 100644
> > > > --- a/drivers/ide/alim15x3.c
> > > > +++ b/drivers/ide/alim15x3.c
> > > > @@ -402,14 +402,15 @@ static u8 ali_cable_detect(ide_hwif_t *hwif)
> > > >      return cbl;
> > > >  }
> > > > 
> > > > -#if !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC)
> > > > +#if !defined(CONFIG_SPARC64)
> > > >  /**
> > > >   *    init_hwif_ali15x3    -    Initialize the ALI IDE x86 stuff
> > > >   *    @hwif: interface to configure
> > > >   *
> > > >   *    Obtain the IRQ tables for an ALi based IDE solution on the PC
> > > > - *    class platforms. This part of the code isn't applicable to the
> > > > - *    Sparc and PowerPC systems.
> > > > + *    class platforms. This part of the code isn't applicable to
> > > > + *    Sparc systems. It is usable on 'x86-like' PowerPC systems
> > > > + *      which use a Ali M15x3 south bridge like e.g. Xilinx ML310/410/510.
> > > >   */
> > > > 
> > > >  static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
> > > > @@ -455,7 +456,7 @@ static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
> > > >  }
> > > >  #else
> > > >  #define init_hwif_ali15x3 NULL
> > > > -#endif /* !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC) */
> > > > +#endif /* !defined(CONFIG_SPARC64) */
> > > > 
> > > >  /**
> > > >   *    init_dma_ali15x3    -    set up DMA on ALi15x3
> > > > --
> > > > 1.5.6.3
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

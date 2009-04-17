Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 12BA6DE1D1
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 17:40:29 +1000 (EST)
Subject: Re: RFC Patch: Use x86 init_hwif in the alim15x3 for x86-like
	PowerPC systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200904162130.01237.bzolnier@gmail.com>
References: <c8485d470904150202s1f5c8cd7p34f0eaf4872f3e17@mail.gmail.com>
	<c8485d470904150734s47ce0f27y3ae984355e823d9f@mail.gmail.com>
	<200904162130.01237.bzolnier@gmail.com>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 09:40:19 +0200
Message-Id: <1239954019.7443.47.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, Roderick Colenbrander <thunderbird2k@gmail.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-16 at 21:30 +0200, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On Wednesday 15 April 2009 16:34:22 Roderick Colenbrander wrote:
> > Hi,
> > 
> > I'm using a Xilinx ML510 it features a PowerPC 440 cpu inside a
> > Virtex-5 FPGA. The board also contains a ALI M1533 south bridge
> > for IDE, USB and Audio. I did a lot of work to get the pci bus working
> > on this board and it works correctly but the default init code
> > of the alim15x3 driver doesn't work for me. The driver explicitly
> > disabled some initialization code for powerpc after uncommenting this
> > code it works properly. Benjamin Herrenschmidt and I think this
> > !CONFIG_PPC check should be removed because the system behaves
> > like a real 'x86' system (also the i8259 interrupt controller is used).
> 
> Ben, I guess you are OK with the change and there are no longer other
> platforms requiring CONFIG_PPC check below?  [I don't see your ACK here]

Yup. I don't see a case where the hack would be of any use, so I'm
happy to remove us from the test. Whenever a 8259 is present we
assign it the legacy interrupts 1...15 with a virtual==physical mapping
so all those x86-ish things should run just fine.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> > Regards,
> > Roderick Colenbrander
> > 
> > 
> > From 1c40c2f1485ecd3bc5ad7a3af537cb94de0877c3 Mon Sep 17 00:00:00 2001
> > From: Roderick Colenbrander <thunderbird2k@gmail.com>
> > Date: Wed, 15 Apr 2009 10:45:17 +0200
> > Subject: [PATCH] Use the 'x86' init_hwif code in the alim15x3 for
> > x86-like PowerPC boards like Xilinx ML310/410/510.
> 
> Roderick, please add your "Signed-off-by:" line
> (per Documentation/SubmittingPatches).
> 
> Thanks.
> 
> > ---
> >  drivers/ide/alim15x3.c |    9 +++++----
> >  1 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ide/alim15x3.c b/drivers/ide/alim15x3.c
> > index 537da1c..9176c0f 100644
> > --- a/drivers/ide/alim15x3.c
> > +++ b/drivers/ide/alim15x3.c
> > @@ -402,14 +402,15 @@ static u8 ali_cable_detect(ide_hwif_t *hwif)
> >      return cbl;
> >  }
> > 
> > -#if !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC)
> > +#if !defined(CONFIG_SPARC64)
> >  /**
> >   *    init_hwif_ali15x3    -    Initialize the ALI IDE x86 stuff
> >   *    @hwif: interface to configure
> >   *
> >   *    Obtain the IRQ tables for an ALi based IDE solution on the PC
> > - *    class platforms. This part of the code isn't applicable to the
> > - *    Sparc and PowerPC systems.
> > + *    class platforms. This part of the code isn't applicable to
> > + *    Sparc systems. It is usable on 'x86-like' PowerPC systems
> > + *      which use a Ali M15x3 south bridge like e.g. Xilinx ML310/410/510.
> >   */
> > 
> >  static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
> > @@ -455,7 +456,7 @@ static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
> >  }
> >  #else
> >  #define init_hwif_ali15x3 NULL
> > -#endif /* !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC) */
> > +#endif /* !defined(CONFIG_SPARC64) */
> > 
> >  /**
> >   *    init_dma_ali15x3    -    set up DMA on ALi15x3
> > --
> > 1.5.6.3

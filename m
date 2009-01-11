Return-Path: <bzolnier@gmail.com>
Received: from mail-bw0-f10.google.com (mail-bw0-f10.google.com
	[209.85.218.10]) by ozlabs.org (Postfix) with ESMTP id 9E4C8DDFC5
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 04:48:15 +1100 (EST)
Received: by bwz3 with SMTP id 3so26622861bwz.9
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 09:48:12 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
	boards
Date: Sun, 11 Jan 2009 17:51:55 +0100
References: <20090107135457.234150@gmx.net>
	<fa686aa40901070713kca10b27y6c6aac03e6224fac@mail.gmail.com>
	<20090107152722.140970@gmx.net>
In-Reply-To: <20090107152722.140970@gmx.net>
MIME-Version: 1.0
Message-Id: <200901111751.55757.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 January 2009, Gerhard Pircher wrote:
> 
> -------- Original-Nachricht --------
> > Datum: Wed, 7 Jan 2009 08:13:06 -0700
> > Von: "Grant Likely" <grant.likely@secretlab.ca>
> > An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> > CC: linuxppc-dev@ozlabs.org, bzolnier@gmail.com
> > Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards
> 
> > On Wed, Jan 7, 2009 at 7:12 AM, Gerhard Pircher <gerhard_pircher@gmx.net>
> > wrote:
> > > The AmigaOne uses the onboard VIA IDE controller in legacy mode (like
> > the
> > > Pegasos).
> > >
> > > Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
> > > ---
> > >  drivers/ide/via82cxxx.c |    5 +++++
> > >  1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > This patch needs to also be posted on the linux-ide mailing list.
> Ouch, I only sent it to the maintainer. I'll fix that.

[ Please also keep all previous recipients on cc: when doing so. ]

> > > diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
> > > index 2a812d3..086f476 100644
> > > --- a/drivers/ide/via82cxxx.c
> > > +++ b/drivers/ide/via82cxxx.c
> > > @@ -450,6 +450,11 @@ static int __devinit via_init_one(struct pci_dev
> > *dev, const struct pci_device_i
> > >                d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
> > >  #endif
> > >
> > > +#ifdef CONFIG_AMIGAONE
> > > +       if (machine_is(amigaone))
> > > +               d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
> > > +#endif
> > > +
> > 
> > I know you're just following the example of the PEGASOS workaround
> > immediately above; but the #defines are really ugly.  I wonder if
> > there is there a cleaner way to manipulate the flags.
> AFAIK the via82cxxx driver doesn't make use of the pci_get_legacy_ide_irq
> approach.

I applied your patch for 2.6.29 but for 2.6.30 I would ask you to clean
up #ifdefs by using ide_pci_is_in_compatibility_mode() helper instead for
checking if IDE_HFLAG_FORCE_LEGACY_IRQS should be set.

[ Some time ago Pegasos got PCI quirk to put controller in the legacy mode
  (arch/powerpc/platforms/chrp/pci.c) so it is OK to also remove Pegasos'
  special case while at it. ]

Thanks,
Bart

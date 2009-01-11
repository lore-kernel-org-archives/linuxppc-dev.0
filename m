Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 473DCDDFC4
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 07:05:33 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Sun, 11 Jan 2009 21:05:30 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <200901111751.55757.bzolnier@gmail.com>
Message-ID: <20090111200530.113910@gmx.net>
MIME-Version: 1.0
References: <20090107135457.234150@gmx.net>
	<fa686aa40901070713kca10b27y6c6aac03e6224fac@mail.gmail.com>
	<20090107152722.140970@gmx.net> <200901111751.55757.bzolnier@gmail.com>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
	boards
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Sun, 11 Jan 2009 17:51:55 +0100
> Von: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: "Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
> Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards

> On Wednesday 07 January 2009, Gerhard Pircher wrote:
> > 
> > -------- Original-Nachricht --------
> > > Datum: Wed, 7 Jan 2009 08:13:06 -0700
> > > Von: "Grant Likely" <grant.likely@secretlab.ca>
> > > An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> > > CC: linuxppc-dev@ozlabs.org, bzolnier@gmail.com
> > > Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for
> AmigaOne boards
> > 
> > > On Wed, Jan 7, 2009 at 7:12 AM, Gerhard Pircher
> <gerhard_pircher@gmx.net>
> > > wrote:
> > > > The AmigaOne uses the onboard VIA IDE controller in legacy mode
> > > >(like the Pegasos).
> > > >
> > > > Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
> > > > ---
> > > >  drivers/ide/via82cxxx.c |    5 +++++
> > > >  1 files changed, 5 insertions(+), 0 deletions(-)
> > > 
> > > This patch needs to also be posted on the linux-ide mailing list.
> > Ouch, I only sent it to the maintainer. I'll fix that.
> 
> [ Please also keep all previous recipients on cc: when doing so. ]
Okay, I'll keep that in mind.

> > > > diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
> > > > index 2a812d3..086f476 100644
> > > > --- a/drivers/ide/via82cxxx.c
> > > > +++ b/drivers/ide/via82cxxx.c
> > > > @@ -450,6 +450,11 @@ static int __devinit via_init_one(struct
> pci_dev
> > > *dev, const struct pci_device_i
> > > >                d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
> > > >  #endif
> > > >
> > > > +#ifdef CONFIG_AMIGAONE
> > > > +       if (machine_is(amigaone))
> > > > +               d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
> > > > +#endif
> > > > +
> > > 
> > > I know you're just following the example of the PEGASOS workaround
> > > immediately above; but the #defines are really ugly.  I wonder if
> > > there is there a cleaner way to manipulate the flags.
> > AFAIK the via82cxxx driver doesn't make use of the
> > pci_get_legacy_ide_irq approach.
> 
> I applied your patch for 2.6.29 but for 2.6.30 I would ask you to clean
> up #ifdefs by using ide_pci_is_in_compatibility_mode() helper instead for
> checking if IDE_HFLAG_FORCE_LEGACY_IRQS should be set.
Wouldn't it be better, if I clean this up now? (I have to resend my AmigaOne
platform patches anyway).

> [ Some time ago Pegasos got PCI quirk to put controller in the legacy mode
>   (arch/powerpc/platforms/chrp/pci.c) so it is OK to also remove Pegasos'
>   special case while at it. ]
Okay, so the change shouldn't break IDE for Pegasos machines (I don't have
a Pegasos for testing).

Thanks!

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger

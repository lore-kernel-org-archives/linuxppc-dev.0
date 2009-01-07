Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 478E5DE2EA
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 02:27:23 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 07 Jan 2009 16:27:22 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <fa686aa40901070713kca10b27y6c6aac03e6224fac@mail.gmail.com>
Message-ID: <20090107152722.140970@gmx.net>
MIME-Version: 1.0
References: <20090107135457.234150@gmx.net> <20090107141254.140990@gmx.net>
	<fa686aa40901070713kca10b27y6c6aac03e6224fac@mail.gmail.com>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
	boards
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, bzolnier@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 7 Jan 2009 08:13:06 -0700
> Von: "Grant Likely" <grant.likely@secretlab.ca>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org, bzolnier@gmail.com
> Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards

> On Wed, Jan 7, 2009 at 7:12 AM, Gerhard Pircher <gerhard_pircher@gmx.net>
> wrote:
> > The AmigaOne uses the onboard VIA IDE controller in legacy mode (like
> the
> > Pegasos).
> >
> > Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
> > ---
> >  drivers/ide/via82cxxx.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> This patch needs to also be posted on the linux-ide mailing list.
Ouch, I only sent it to the maintainer. I'll fix that.

> > diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
> > index 2a812d3..086f476 100644
> > --- a/drivers/ide/via82cxxx.c
> > +++ b/drivers/ide/via82cxxx.c
> > @@ -450,6 +450,11 @@ static int __devinit via_init_one(struct pci_dev
> *dev, const struct pci_device_i
> >                d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
> >  #endif
> >
> > +#ifdef CONFIG_AMIGAONE
> > +       if (machine_is(amigaone))
> > +               d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
> > +#endif
> > +
> 
> I know you're just following the example of the PEGASOS workaround
> immediately above; but the #defines are really ugly.  I wonder if
> there is there a cleaner way to manipulate the flags.
AFAIK the via82cxxx driver doesn't make use of the pci_get_legacy_ide_irq
approach.

Gerhard

-- 
Sensationsangebot verlängert: GMX FreeDSL - Telefonanschluss + DSL 
für nur 16,37 Euro/mtl.!* http://dsl.gmx.de/?ac=OM.AD.PD003K1308T4569a

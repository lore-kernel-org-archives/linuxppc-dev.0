Return-Path: <jonsmirl@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 4DCFFDE178
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 03:33:12 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so1769405pyi
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 08:33:02 -0800 (PST)
Message-ID: <9e4733910711260833t5053ed5fu5227046565eae86b@mail.gmail.com>
Date: Mon, 26 Nov 2007 11:33:00 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Access to PCI Expansion ROMs on PPC
In-Reply-To: <20071126102414.GF14557@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
	<9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
	<20071125111535.GB14557@curie-int.orbis-terrarum.net>
	<20071125114919.GC14557@curie-int.orbis-terrarum.net>
	<9e4733910711250530r454c01ecoe8867a7f492b8704@mail.gmail.com>
	<20071125194101.GD14557@curie-int.orbis-terrarum.net>
	<20071126085928.GE14557@curie-int.orbis-terrarum.net>
	<1196068814.22865.108.camel@thor.sulgenrain.local>
	<20071126102414.GF14557@curie-int.orbis-terrarum.net>
Cc: linuxppc-dev@ozlabs.org, Michel D?nzer <michel@tungstengraphics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/26/07, Robin H. Johnson <robbat2@gentoo.org> wrote:
> On Mon, Nov 26, 2007 at 10:20:14AM +0100, Michel D?nzer wrote:
> > > Regarding the sub-thread on x86 emulation, that is totally out of scope
> > > for this. The 'AtomBIOS' of the ATI cards, consists of multiple parts (I
> > > may have minor errors here, ask airlied if you need more
> > > clarification):
> > > a) Initialization code (I think arch-specific)
> > > b) AtomBIOS script interpreter (I think arch-specific)
> > > c) AtomBIOS scripts (card-specific, but not arch-specific)
> > > d) Data tables (card-specific, but not arch-specific)
> > >
> > > The AtomBIOS parts of the various drivers need data from c+d primarily,
> > > and provide their own script interpreter, or not using the scripts, just
> > > the data tables.
> > Are you sure the X1900 Mac Edition ROM contains any ATOM data structures
> > though? I rather doubt it.
> That's what I'm trying to ascertain actually, because it directly
> impacts what work needs to be done in the drivers.
>
> If it was me writing the ROMs in the first place (but it's not), from
> what I understand of the ATOM, I'd have OpenFirmware versions of a+b,
> and then could re-use c+d.
>
> The fact that both Nvidia and ATI OF-powered cards fail when trying to
> access their expansion ROMs, I'm inclined to think there is something in
> accessing them that we are missing, and that the ROMs must exist (the
> sata_mv one existed and was accessible).

There may well be bugs in the ROM access code on the PowerPC. I don't
own the appropriate hardware nedded to check it out. I'm not sure that
the code has been used on the PowerPC very much. People use it on the
x86 all of the time so it is working fairly well there. But the
generic PowerPC code seems to be working since you can read the
sata_mv ROM.

Did you check out the cards on x86 and ascertain that they have the
standard PCI header in them? 55 AA .... All PCI ROMs are supposed to
have that. If they are missing that the size code in the rom.c isn't
going to work right.

If these are OF ROM and you are booting on OF firmware, the ROM is
getting run. In that case it may not be so simple to turn them back on
if they have been hidden using a proprietary register. That's the
quirk BenH has referred to.


>
> On actually accessing the rest of the ATI X1900 card, the avivotool from
> git://people.freedesktop.org/~airlied/radeontool.git (avivo branch) can
> actually access the rest of the rest of the card registers.
>
> --
> Robin Hugh Johnson
> Gentoo Linux Developer & Infra Guy
> E-Mail     : robbat2@gentoo.org
> GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>


-- 
Jon Smirl
jonsmirl@gmail.com

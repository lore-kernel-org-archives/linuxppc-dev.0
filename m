Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id AB6B6681BD
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jan 2006 09:12:10 +1100 (EST)
Date: Mon, 23 Jan 2006 23:12:07 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1137883724.12998.74.camel@localhost.localdomain>
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
Message-ID: <29335.1138054327@www080.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- Ursprüngliche Nachricht ---
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: AGPGART driver for ArticiaS - ioremap() problem
> Datum: Sun, 22 Jan 2006 09:48:44 +1100
> 
> On Sat, 2006-01-21 at 02:59 +0100, Gerhard Pircher wrote:
> 
> > Yes, I see. :( The code mostly allocates the resources for the AGPGART
> > driver beyond the real memory space, thus preventing the X server to
> > work. Sometimes the resource is also mapped to where the resource of
> > the graphic card resides (address 0x88000000, compare with the included 
> > iomem file).
> 
> The AGP aperture should generally be located "outside" of those spaces.
> That is above RAM and in some place where no device already resides...
> It can be made to overlap RAM but that isn't a good idea (that's what
> happens on Macs though due to a bug in the Apple chipset).
Ahh, so the AGP aperture should not be within the memory space and any other
PCI/IO address range. Slowly but surely I become confused. ;-)

> I don't see anything related to AGP in your output... you didn't post
> the lspci as root thus it's missing all the useful infos ;)
I included a new lspci output log. :-) (now done as root)

> Also, the AGP base isn't generally a PCI BAR of the bridge... it is one
> in your case ?
I'm afraid I can't answer this question (you know, we have no datasheet for
the ArticiaS yet). From what I can see in the log, there is an unassigned
memory region (type 0, should be <4GB I guess). Could this affect AGP
operation? 

Gerhard

-- 
Lust, ein paar Euro nebenbei zu verdienen? Ohne Kosten, ohne Risiko!
Satte Provisionen für GMX Partner: http://www.gmx.net/de/go/partner

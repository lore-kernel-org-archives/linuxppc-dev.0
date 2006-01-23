Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0AB0968926
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jan 2006 10:15:28 +1100 (EST)
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <29335.1138054327@www080.gmx.net>
References: <1137883724.12998.74.camel@localhost.localdomain>
	<29335.1138054327@www080.gmx.net>
Content-Type: text/plain; charset=utf-8
Date: Tue, 24 Jan 2006 10:15:29 +1100
Message-Id: <1138058129.4907.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-01-23 at 23:12 +0100, Gerhard Pircher wrote:
> > --- Ursprüngliche Nachricht ---
> > Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > An: Gerhard Pircher <gerhard_pircher@gmx.net>
> > Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> > Betreff: Re: AGPGART driver for ArticiaS - ioremap() problem
> > Datum: Sun, 22 Jan 2006 09:48:44 +1100
> > 
> > On Sat, 2006-01-21 at 02:59 +0100, Gerhard Pircher wrote:
> > 
> > > Yes, I see. :( The code mostly allocates the resources for the AGPGART
> > > driver beyond the real memory space, thus preventing the X server to
> > > work. Sometimes the resource is also mapped to where the resource of
> > > the graphic card resides (address 0x88000000, compare with the included 
> > > iomem file).
> > 
> > The AGP aperture should generally be located "outside" of those spaces.
> > That is above RAM and in some place where no device already resides...
> > It can be made to overlap RAM but that isn't a good idea (that's what
> > happens on Macs though due to a bug in the Apple chipset).
> Ahh, so the AGP aperture should not be within the memory space and any other
> PCI/IO address range. Slowly but surely I become confused. ;-)
> 
> > I don't see anything related to AGP in your output... you didn't post
> > the lspci as root thus it's missing all the useful infos ;)
> I included a new lspci output log. :-) (now done as root)
> 
> > Also, the AGP base isn't generally a PCI BAR of the bridge... it is one
> > in your case ?
> I'm afraid I can't answer this question (you know, we have no datasheet for
> the ArticiaS yet). From what I can see in the log, there is an unassigned
> memory region (type 0, should be <4GB I guess). Could this affect AGP
> operation? 

No idea... memory BARs on host bridges can be anything... It might just
be the normal PCI DMA region.

Ben.

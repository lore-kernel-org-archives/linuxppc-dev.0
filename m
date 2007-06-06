Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5B213DDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 04:06:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Simple driver for Xilinx SPI controler.
Date: Wed, 6 Jun 2007 11:06:16 -0700
In-Reply-To: <4666F598.2000004@ru.mvista.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Message-Id: <20070606180618.C4D861268059@mail88-blu.bigfish.com>
Cc: spi-devel-general@lists.sourceforge.net,
	Wolfgang Reissnegger <wre@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Yes, except that microblazes systems run in non-virtex FPGAs...

It may be that XILINX_EDK is not the right thing either, but it
seemed like the easiest way to have a superset of powerpc and microblaze
systems

What I'm trying to do is (in concert with Grant's recent configuration
changes)
having an easy way for a new board configuration to select the Kconfig
options for
all of the Xilinx drivers.  Namely:

config XILINX_ML300
	bool "Xilinx-ML300"
	select XILINX_VIRTEX_II_PRO
	select EMBEDDEDBOOT
	help
	  This option enables support for the Xilinx ML300 evaluation
board.

config XILINX_VIRTEX_II_PRO
	bool
	select XILINX_VIRTEX

config XILINX_EDK
	bool
	depends on XILINX_VIRTEX || XILINX_MICROBLAZE
	default y

config XILINX_GPIO
	tristate "Xilinx OPB GPIO Support"
	depends on XILINX_EDK
	help
	This option enables support for Xilinx GPIO.


It seems like I'm using XILINX_EDK to mean something different than you
are.
Perhaps it sould be instead:

config XILINX_DRIVERS
	bool
	depends on XILINX_VIRTEX || XILINX_MICROBLAZE
	default y

config XILINX_GPIO_EDK
	tristate "Xilinx EDK-based OPB GPIO Support"
	depends on XILINX_DRIVERS
	select XILINX_EDK
	help
	This option enables support for Xilinx GPIO using EDK OS
independent driver.

config XILINX_GPIO
	tristate "Xilinx OPB GPIO Support"
	depends on XILINX_DRIVERS
	help
	This option enables support for Xilinx GPIO.

Would this work for you?

Steve

> -----Original Message-----
> From: Andrei Konovalov [mailto:akonovalov@ru.mvista.com]=20
> Sent: Wednesday, June 06, 2007 10:58 AM
> To: Stephen Neuendorffer
> Cc: spi-devel-general@lists.sourceforge.net;=20
> linuxppc-embedded@ozlabs.org; Wolfgang Reissnegger
> Subject: Re: [PATCH] Simple driver for Xilinx SPI controler.
>=20
> Hi Steve,
>=20
> Stephen Neuendorffer wrote:
> > In order to anticipate future Microblaze support with most of these=20
> > drivers, we've been moving towards having all of the Kconfig=20
> > dependencies on XILINX_EDK,
>=20
> There is no XILINX_EDK in the ko tree.
>=20
> > rather than XILINX_VIRTEX...
>=20
> Using XILINX_VIRTEX seems to be a common thing:
>=20
> > -------- Original Message --------
> > Subject: [RFC] Xilinx SystemACE device driver
> > Date: Sat, 14 Apr 2007 19:23:14 -0600
> > From: Grant Likely <grant.likely@secretlab.ca>
> > To: linuxppc-embedded@ozlabs.org, Andrei Konovalov=20
> <akonovalov@ru.mvista.com>,	Peter Korsgaard=20
> <jacmet@sunsite.dk>,	Rick Moleres <Rick.Moleres@xilinx.com>,=20
> Stefan Roese <sr@denx.de>
> >=20
> > Add support for block device access to the Xilinx SystemACE Compact=20
> > flash interface
> <snip>
> > diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig index=20
> > 17ee97f..08ad23c 100644
> > --- a/drivers/block/Kconfig
> > +++ b/drivers/block/Kconfig
> > @@ -453,6 +453,12 @@ config ATA_OVER_ETH
> >  	This driver provides Support for ATA over Ethernet block
> >  	devices like the Coraid EtherDrive (R) Storage Blade.
> > =20
> > +config XILINX_SYSACE
> > +	tristate "Xilinx SystemACE support"
> > +	depends on XILINX_VIRTEX
> > +	help
> > +	  Include support for the Xilinx SystemACE CompactFlash=20
> interface
> > +
>=20
> BTW the SystemACE has been successfully tested with ppc440=20
> based board. So XILINX_VIRTEX doesn't imply ppc405.
>=20
> On the other side,
> UART Lite driver (in the ko tree) doesn't depend on both=20
> XILINX_EDK and XILINX_VIRTEX
>=20
> Couldn't Microblaze port use XILINX_VIRTEX too?
> IMHO XILINX_VIRTEX is more general name for something inside=20
> the Virtex chip (ppc405 core, Microblaze softcore, IP blocks=20
> from EDK or elsewhere).
>=20
> I've recently added XILINX_EDK to linux-xilinx-26.git=20
> repository at source.mvista.com, but to include the level 1=20
> drivers (aka OS independent drivers) from EDK. Haven't=20
> planned to use XILINX_EDK for drivers not using EDK code.
> Here is the relevant snippet from=20
> arch/ppc/platforms/4xx/Kconfig (from linux-xilinx-26.git @=20
> source.mvista.com, ko doesn't have XILINX_EDK and the rest below):
>=20
> =
=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> config XILINX_VIRTEX_II_PRO
> 	bool
> 	select XILINX_VIRTEX
>=20
> config XILINX_VIRTEX_4_FX
> 	bool
> 	select XILINX_VIRTEX
>=20
> config XILINX_VIRTEX
> 	bool
>=20
> # The options selected by EDK based drivers. Not visible from=20
> [menu]config.
> config XILINX_EDK
> 	bool
> config XILINX_IPIF_V123B
> 	bool
> config XILINX_FIFO_V200A
> 	bool
> config XILINX_DMA_V300A
> 	bool
> =
=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> If we do something like
>    config XILINX_MICROBLAZE
> 	bool
> 	select XILINX_VIRTEX
> in arch/microblaze/Kconfig
> would it work?
>=20
>=20
> Thanks,
> Andrei
>=20
>=20
>=20

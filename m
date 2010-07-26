Return-Path: <B21284@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 4D23BB6EFF
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 16:18:49 +1000 (EST)
Received: from mail54-va3 (localhost.localdomain [127.0.0.1])	by
	mail54-va3-R.bigfish.com (Postfix) with ESMTP id 3D2F0A20373	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 06:18:46 +0000 (UTC)
Received: from VA3EHSMHS027.bigfish.com (unknown [10.7.14.248])	by
	mail54-va3.bigfish.com (Postfix) with ESMTP id 703701798053	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 06:18:45 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6Q6IdO4022655	for <linuxppc-dev@ozlabs.org>;
	Sun, 25 Jul 2010 23:18:39 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6Q6Tgdg028336	for <linuxppc-dev@ozlabs.org>;
	Mon, 26 Jul 2010 01:29:43 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 1/6] spi/mpc8xxx: refactor the common code for SPI/eSPI
	controller
Date: Mon, 26 Jul 2010 14:18:37 +0800
Message-ID: <73839B4A0818E747864426270AC332C3054005D5@zmy16exm20.fsl.freescale.net>
In-Reply-To: <20100726001415.GA24562@angua.secretlab.ca>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<20100726001415.GA24562@angua.secretlab.ca>
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	<"@angua.secretlab.ca"@angua.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Zang Roy-R61911 <R61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of=20
> Grant Likely
> Sent: Monday, July 26, 2010 8:14 AM
> To: Hu Mingkai-B21284; "@angua.secretlab.ca"@angua.secretlab.ca
> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang=20
> Roy-R61911
> Subject: Re: [PATCH 1/6] spi/mpc8xxx: refactor the common=20
> code for SPI/eSPI controller
>=20
> On Tue, Jul 20, 2010 at 10:08:20AM +0800, Mingkai Hu wrote:
> > Refactor the common code to file spi_mpc8xxx.c used by SPI/eSPI
> > controller driver, move the SPI controller driver to a new file
> > fsl_spi.c, and leave the QE/CPM SPI controller code in this file.
> >=20
> > Because the register map of the SPI controller and eSPI controller
> > is so different, also leave the code operated the register to the
> > driver code, not the common code.
> >=20
> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> > ---
> >  drivers/spi/Kconfig       |   13 +-
> >  drivers/spi/Makefile      |    1 +
> >  drivers/spi/fsl_spi.c     | 1118=20
> ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/spi/spi_mpc8xxx.c | 1198=20
> ++-------------------------------------------
> >  drivers/spi/spi_mpc8xxx.h |  135 +++++
>=20
> Please name files spi-*.[ch].  I'm going to start enforcing=20
> this naming convention in the drivers/spi directory.
>=20

Ok.

> >  5 files changed, 1299 insertions(+), 1166 deletions(-)
> >  create mode 100644 drivers/spi/fsl_spi.c
> >  create mode 100644 drivers/spi/spi_mpc8xxx.h
> >=20
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index 91c2f4f..cd564e2 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -183,11 +183,18 @@ config SPI_MPC512x_PSC
> >  	  Controller in SPI master mode.
> > =20
> >  config SPI_MPC8xxx
> > -	tristate "Freescale MPC8xxx SPI controller"
> > +	bool
>=20
> This should be tristate so it can be loaded as a module.
>=20

This option is selected by FSL_SPI and FSL_ESPI option, can we load the
driver as a module?

> >  	depends on FSL_SOC
> >  	help
> > -	  This enables using the Freescale MPC8xxx SPI=20
> controllers in master
> > -	  mode.
> > +	  This enables using the Freescale MPC8xxx SPI/eSPI controllers
> > +	  driver library.
>=20
> Drop the help text entirely.  It isn't needed on=20
> non-user-visible options.
>=20

Ok.

> > +
> > +config SPI_FSL_SPI
> > +	tristate "Freescale SPI controller"
>=20
> "Freescale SPI controller is rather generic and doesn't give any clues
> as to which devices actually have this controller.  At the very least
> the help text should state what parts contain this controller.
>=20

Ok.

> On that note, the naming convention seems a little loose. =20
> Since both the eSPI and SPI are using SPI_MPC8xxx, then=20
> really the names should be:
>=20
> config SPI_MPC8xxx_SPI
> and
> config SPI_MPC8xxx_ESPI
>

I'll chage it, SPI_MPC8xxx_SPI/ESPI is more clearer.
=20
> > +static void __exit fsl_spi_exit(void)
> > +{
> > +	of_unregister_platform_driver(&of_fsl_spi_driver);
> > +	legacy_driver_unregister();
> > +}
>=20
> It would appear that the legacy driver should *also* be=20
> separated out into its own module.  I realize you're just cut=20
> & pasting code here, but it should be considered for a followup patch.
>=20

Can we remove the legacy driver thoroughly?
If we separated out the code, what's the proper name for it?
spi_mpc8xxx_legacy.c?

> > +
> > +module_init(fsl_spi_init);
> > +module_exit(fsl_spi_exit);
>=20
> module_init() should appear immediately after the init=20
> fsl_spi_init() function.
>=20

Ok.

Thanks,
Mingkai=20

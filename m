Return-Path: <R61911@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by ozlabs.org (Postfix) with ESMTP id B58BBB6F11
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 17:23:02 +1000 (EST)
Received: from mail155-va3 (localhost.localdomain [127.0.0.1])	by
	mail155-va3-R.bigfish.com (Postfix) with ESMTP id 457E47D020E	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 07:07:54 +0000 (UTC)
Received: from VA3EHSMHS027.bigfish.com (unknown [10.7.14.239])	by
	mail155-va3.bigfish.com (Postfix) with ESMTP id B49C9177004F	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 07:07:53 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6Q77oNf028799	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 00:07:51 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6Q7L8bA012114	for <linuxppc-dev@ozlabs.org>;
	Mon, 26 Jul 2010 02:21:08 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 1/6] spi/mpc8xxx: refactor the common code for SPI/eSPI
	controller
Date: Mon, 26 Jul 2010 15:07:45 +0800
Message-ID: <83024545B35D6445A690EFD603E7869A050ECB@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100726001415.GA24562@angua.secretlab.ca>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<20100726001415.GA24562@angua.secretlab.ca>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Hu Mingkai-B21284" <B21284@freescale.com>, <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
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
> > +
> > +config SPI_FSL_SPI
> > +	tristate "Freescale SPI controller"
>=20
> "Freescale SPI controller is rather generic and doesn't give any clues
> as to which devices actually have this controller.  At the very least
> the help text should state what parts contain this controller.
>=20
> On that note, the naming convention seems a little loose. =20
> Since both the eSPI and SPI are using SPI_MPC8xxx, then=20
> really the names should be:
>=20
> config SPI_MPC8xxx_SPI
> and
> config SPI_MPC8xxx_ESPI

SPI_FSL_SPI and SPI_FSL_ESDP are better at this point.
83xx platforms and some of 85xx platforms use SPI controller.=20
>From mpc8536, 85xx use ESP controller, BUT currently all P10xx, P20xx,
P40xx use ESPI controller.=20
8xxx will not cover pxxx serial processor.
Thanks.
Roy

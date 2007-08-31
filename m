Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89FE6DDFB2
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 23:50:50 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l7VDoidD008599
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 06:50:45 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l7VDohBM010009
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 08:50:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in	QE,
	register mmc_spi stub
Date: Fri, 31 Aug 2007 21:50:43 +0800
Message-ID: <989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
In-Reply-To: <46D73166.6080103@freescale.com>
References: <20070823113349.GA11870@localhost.localdomain><20070823113600.GC18080@localhost.localdomain>
	<46D73166.6080103@freescale.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Tabi Timur-B04825" <timur@freescale.com>,
	"Anton Vorontsov" <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Tabi Timur-B04825
> Sent: Friday, August 31, 2007 5:07 AM
> To: Anton Vorontsov
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts=20
> to use SPI1in QE, register mmc_spi stub
>=20
> Anton Vorontsov wrote:
>=20
> > +static int __init mpc832x_spi_init(void) {
> > +	if (!machine_is(mpc832x_rdb))
> > +		return 0;
> > +
> > +	par_io_config_pin(3,  0, 3, 0, 1, 0); /* SPI1 MOSI, I/O */
> > +	par_io_config_pin(3,  1, 3, 0, 1, 0); /* SPI1 MISO, I/O */
> > +	par_io_config_pin(3,  2, 3, 0, 1, 0); /* SPI1 CLK,  I/O */
> > +	par_io_config_pin(3,  3, 2, 0, 1, 0); /* SPI1 SEL,  I   */
> > +
> > +	par_io_config_pin(3, 13, 1, 0, 0, 0); /* !SD_CS,    O */
> > +	par_io_config_pin(3, 14, 2, 0, 0, 0); /* SD_INSERT, I */
> > +	par_io_config_pin(3, 15, 2, 0, 0, 0); /* SD_PROTECT,I */
>=20
> Why are you doing this here, and not in the device tree?

I saw you used pio node, but later changed to make it hardcoded.  What's
the reason?  IMO, device tree is used to describe the hardware settings,
pio node is a perfect match.  Moreover, changing the device tree is much
easier than changing the code.

- Leo

Return-Path: <B21284@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204]) by ozlabs.org (Postfix) with ESMTP id 8E4C2B7123
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 19:24:00 +1000 (EST)
Received: from mail11-am1 (localhost.localdomain [127.0.0.1])	by
	mail11-am1-R.bigfish.com (Postfix) with ESMTP id 2DC7A3F82B5	for
	<linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 09:23:56 +0000 (UTC)
Received: from am1ehsmhs005.bigfish.com (unknown [10.3.201.246])	by
	mail11-am1.bigfish.com (Postfix) with ESMTP id 8478E5C804F	for
	<linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 09:23:55 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o828SUnE004452	for
	<linuxppc-dev@ozlabs.org>; Thu, 2 Sep 2010 01:28:30 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o828gFXZ011091	for <linuxppc-dev@ozlabs.org>;
	Thu, 2 Sep 2010 03:42:16 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH v2 2/6] eSPI: add eSPI controller support
Date: Thu, 2 Sep 2010 16:28:27 +0800
Message-ID: <73839B4A0818E747864426270AC332C30561B6D0@zmy16exm20.fsl.freescale.net>
In-Reply-To: <AANLkTin3W4++cAFcksVBX3QxeV8QF3d5T2tGy_KbEkRs@mail.gmail.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
	<AANLkTin3W4++cAFcksVBX3QxeV8QF3d5T2tGy_KbEkRs@mail.gmail.com>
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <B11780@freescale.com>,
	Zang Roy-R61911 <R61911@freescale.com>,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of =
Grant
> Likely
> Sent: Tuesday, August 10, 2010 2:45 PM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev@ozlabs.org; spi-devel-general@lists.sourceforge.net; =
Gala
> Kumar-B11780; Zang Roy-R61911
> Subject: Re: [PATCH v2 2/6] eSPI: add eSPI controller support
>=20
> On Mon, Aug 2, 2010 at 1:52 AM, Mingkai Hu <Mingkai.hu@freescale.com> =
wrote:
> > Add eSPI controller support based on the library code spi_fsl_lib.c.
> >
> > The eSPI controller is newer controller 85xx/Pxxx devices supported.
> > There're some differences comparing to the SPI controller:
> >
> > 1. Has different register map and different bit definition
> > =A0 So leave the code operated the register to the driver code, not
> > =A0 the common code.
> >
> > 2. Support 4 dedicated chip selects
> > =A0 The software can't controll the chip selects directly, The =
SPCOM[CS]
> > =A0 field is used to select which chip selects is used, and the
> > =A0 SPCOM[TRANLEN] field is set to tell the controller how long the =
CS
> > =A0 signal need to be asserted. So the driver doesn't need the
> > chipselect
> > =A0 related function when transfering data, just set corresponding
> > register
> > =A0 fields to controll the chipseclect.
> >
> > 3. Different Transmit/Receive FIFO access register behavior
> > =A0 For SPI controller, the Tx/Rx FIFO access register can hold only
> > =A0 one character regardless of the character length, but for eSPI
> > =A0 controller, the register can hold 4 or 2 characters according to
> > =A0 the character lengths. Access the Tx/Rx FIFO access register of =
the
> > =A0 eSPI controller will shift out/in 4/2 characters one time. For =
SPI
> > =A0 subsystem, the command and data are put into different =
transfers, so
> > =A0 we need to combine all the transfers to one transfer in order to
> > pass
> > =A0 the transfer to eSPI controller.
> >
> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
>=20
> I've not dug deep into this patch, but it seems pretty good.  I did =
notice one
> thing below...
> [...]
>=20
> > diff --git a/drivers/spi/spi_fsl_lib.h b/drivers/spi/spi_fsl_lib.h
> > index 774e1c8..0772c98 100644
> > --- a/drivers/spi/spi_fsl_lib.h
> > +++ b/drivers/spi/spi_fsl_lib.h
> > @@ -22,10 +22,12 @@
> > =A0struct mpc8xxx_spi {
> > =A0 =A0 =A0 =A0struct device *dev;
> > =A0 =A0 =A0 =A0struct fsl_spi_reg __iomem *base;
> > + =A0 =A0 =A0 struct fsl_espi_reg __iomem *espi_base;
>=20
> There's got to be a cleaner way to do this.  Rather than putting both =
pointers
> into mpc8xxx_spi, I suggest each driver use its own fsl_spi_priv and
> fsl_espi_priv wrapper structures that contain the controller specific =
properties.
>=20

Make sense, I'll change it.

Thanks,
Mingkai

Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 82A68B70A7
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 16:45:09 +1000 (EST)
Received: by iwn41 with SMTP id 41so4338006iwn.15
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Aug 2010 23:45:08 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 10 Aug 2010 00:44:48 -0600
Message-ID: <AANLkTin3W4++cAFcksVBX3QxeV8QF3d5T2tGy_KbEkRs@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] eSPI: add eSPI controller support
To: Mingkai Hu <Mingkai.hu@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 2, 2010 at 1:52 AM, Mingkai Hu <Mingkai.hu@freescale.com> wrote=
:
> Add eSPI controller support based on the library code spi_fsl_lib.c.
>
> The eSPI controller is newer controller 85xx/Pxxx devices supported.
> There're some differences comparing to the SPI controller:
>
> 1. Has different register map and different bit definition
> =A0 So leave the code operated the register to the driver code, not
> =A0 the common code.
>
> 2. Support 4 dedicated chip selects
> =A0 The software can't controll the chip selects directly, The SPCOM[CS]
> =A0 field is used to select which chip selects is used, and the
> =A0 SPCOM[TRANLEN] field is set to tell the controller how long the CS
> =A0 signal need to be asserted. So the driver doesn't need the chipselect
> =A0 related function when transfering data, just set corresponding regist=
er
> =A0 fields to controll the chipseclect.
>
> 3. Different Transmit/Receive FIFO access register behavior
> =A0 For SPI controller, the Tx/Rx FIFO access register can hold only
> =A0 one character regardless of the character length, but for eSPI
> =A0 controller, the register can hold 4 or 2 characters according to
> =A0 the character lengths. Access the Tx/Rx FIFO access register of the
> =A0 eSPI controller will shift out/in 4/2 characters one time. For SPI
> =A0 subsystem, the command and data are put into different transfers, so
> =A0 we need to combine all the transfers to one transfer in order to pass
> =A0 the transfer to eSPI controller.
>
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>

I've not dug deep into this patch, but it seems pretty good.  I did
notice one thing below...
[...]

> diff --git a/drivers/spi/spi_fsl_lib.h b/drivers/spi/spi_fsl_lib.h
> index 774e1c8..0772c98 100644
> --- a/drivers/spi/spi_fsl_lib.h
> +++ b/drivers/spi/spi_fsl_lib.h
> @@ -22,10 +22,12 @@
> =A0struct mpc8xxx_spi {
> =A0 =A0 =A0 =A0struct device *dev;
> =A0 =A0 =A0 =A0struct fsl_spi_reg __iomem *base;
> + =A0 =A0 =A0 struct fsl_espi_reg __iomem *espi_base;

There's got to be a cleaner way to do this.  Rather than putting both
pointers into mpc8xxx_spi, I suggest each driver use its own
fsl_spi_priv and fsl_espi_priv wrapper structures that contain the
controller specific properties.

cheers,
g.

Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 9B424B7CBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Feb 2010 02:33:58 +1100 (EST)
Received: by yxe8 with SMTP id 8so9404095yxe.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Feb 2010 07:33:56 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100216151240.148f9413.eschwab@online.de>
References: <20100216151240.148f9413.eschwab@online.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Feb 2010 08:32:11 -0700
Message-ID: <fa686aa41002160732w1da68f35ifd0d21407b1052e4@mail.gmail.com>
Subject: Re: [PATCH] spi: Correct SPI clock frequency setting in spi_mpc8xxx
To: Ernst Schwab <eschwab@online.de>, spi-devel-general@lists.sourceforge.net,
	Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[cc'd spi-devel-general, linuxppc-dev & Kumar Gala]

On Tue, Feb 16, 2010 at 7:12 AM, Ernst Schwab <eschwab@online.de> wrote:
> From: Ernst Schwab <eschwab@online.de>
>
> Correct SPI clock frequency division factor rounding, preventing clock ra=
tes
> higher than the maximum specified clock frequency being used.

For a patch like this, it helps to also cc the driver's specific
maintainer (Kumar) and to explicitly state your rational so that I
don't need to re-derive your calculations.  I'm more likely to merge a
brand new, if potentially broken, driver than to merge a change to an
existing driver that I don't know the impact of.

The change forces the division to always round up instead of down.
Please describe (for me now, and for people looking at the commit in
the future) the mathematical reason for the changes.

Thanks,
g.

>
> Signed-off-by: Ernst Schwab <eschwab@online.de>
> ---
> Tested on MPC8314.
>
> diff -up linux-2.6.33-rc8.orig/drivers/spi/spi_mpc8xxx.c linux-2.6.33-rc8=
/drivers/spi/spi_mpc8xxx.c
> --- linux-2.6.33-rc8.orig/drivers/spi/spi_mpc8xxx.c =A0 =A0 2010-02-12 20=
:07:45.000000000 +0100
> +++ linux-2.6.33-rc8/drivers/spi/spi_mpc8xxx.c =A02010-02-15 14:08:33.000=
000000 +0100
> @@ -365,7 +365,7 @@ int mpc8xxx_spi_setup_transfer(struct sp
>
> =A0 =A0 =A0 =A0if ((mpc8xxx_spi->spibrg / hz) > 64) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->hw_mode |=3D SPMODE_DIV16;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm =3D mpc8xxx_spi->spibrg / (hz * 64);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm =3D (mpc8xxx_spi->spibrg - 1) / (hz * 64=
) + 1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WARN_ONCE(pm > 16, "%s: Requested speed is=
 too low: %d Hz. "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Will use %d Hz instea=
d.\n", dev_name(&spi->dev),
> @@ -373,7 +373,7 @@ int mpc8xxx_spi_setup_transfer(struct sp
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pm > 16)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm =3D 16;
> =A0 =A0 =A0 =A0} else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm =3D mpc8xxx_spi->spibrg / (hz * 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm =3D (mpc8xxx_spi->spibrg - 1) / (hz * 4)=
 + 1;
> =A0 =A0 =A0 =A0if (pm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm--;
>
>
>
>
> --
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

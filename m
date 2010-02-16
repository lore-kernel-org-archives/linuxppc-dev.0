Return-Path: <glikely@secretlab.ca>
Received: from mail-qy0-f199.google.com (mail-qy0-f199.google.com
	[209.85.221.199]) by ozlabs.org (Postfix) with ESMTP id 6AFF5B7D64
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Feb 2010 04:39:52 +1100 (EST)
Received: by qyk37 with SMTP id 37so6233076qyk.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Feb 2010 09:39:50 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100216174349.b0ea60ef.eschwab@online.de>
References: <20100216151240.148f9413.eschwab@online.de>
	<fa686aa41002160732w1da68f35ifd0d21407b1052e4@mail.gmail.com>
	<20100216174349.b0ea60ef.eschwab@online.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Feb 2010 10:39:30 -0700
Message-ID: <fa686aa41002160939y475f9634i225e3047f42c9695@mail.gmail.com>
Subject: Re: [PATCH] spi: Correct SPI clock frequency setting in spi_mpc8xxx
To: Ernst Schwab <eschwab@online.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2010 at 9:43 AM, Ernst Schwab <eschwab@online.de> wrote:
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> The change forces the division to always round up instead of down.
>> Please describe (for me now, and for people looking at the commit in
>> the future) the mathematical reason for the changes.
>
> Ok, here are some infos on the problem I observed, and the fix.

Excellent description.  Thank you.  I'll add this to the commit text
when I apply the patch.

g.

>
> Example:
>
> When specifying spi-max-frequency =3D <10000000> in the device tree,
> the resulting frequency was 11.1 MHz, with spibrg being 133333332.
>
> According to the freescale datasheet [1], the spi clock rate is
> spiclk =3D spibrg / (4 * (pm+1))
>
> The existing code calculated
> =A0 pm =3D mpc8xxx_spi->spibrg / (hz * 4); pm--;
> resulting in pm =3D (int) (3.3333) - 1 =3D 2,
> resulting in spiclk =3D 133333332/(4*(2+1)) =3D 11111111
>
> With the fix,
> =A0pm =3D (mpc8xxx_spi->spibrg - 1) / (hz * 4) + 1; pm--;
> resulting in pm =3D (int) (4.3333) - 1 =3D 3,
> resulting in spiclk =3D 133333332/(4*(3+1)) =3D 8333333
>
> Without the fix, for every desired SPI frequency that
> is not exactly deriveable from spibrg, pm will be too
> small due to rounding down, resulting in a too high SPI clock,
> so we need a pm which is one higher.
>
> For values that are exactly deriveable, spibrg will
> be divideable by (hz*4) without remainder, and
> (int) ((spibrg-1)/(hz*4)) will be one lower than
> (int) (spibrg)/(hz*4), which is compensated by adding 1.
> For these values, the fixed version calculates the same pm
> as the unfixed version.
>
> For all values that are not exactly deriveable,
> spibrg will be not divideable by (hz*4) without
> remainder, and (int) ((spibrg-1)/(hz*4)) will be
> the same as (int) (spibrg)/(hz*4), and the calculated pm will
> be one higher than calculated by the unfixed version.
>
> Regards
> Ernst
>
> References:
> [1] http://www.freescale.com/files/32bit/doc/ref_manual/MPC8315ERM.pdf,
> =A0 =A0page 22-10 -> 1398
> "
> pm: Prescale modulus select. Specifies the divide ratio of the
> prescale divider in the SPI clock generator. The SPI baud rate generator
> clock source (either system clock or system clock divided by 16,
> depending on DIV16 bit) is divided by 4 * ([PM] + 1), a range from 4 to 6=
4.
> The clock has a 50% duty cycle. For example, if the prescale
> modulus is set to PM =3D 0011 and DIV16 is set, the system/SPICLK clock
> ratio will be 16 * (4 * (0011 + 1)) =3D 256.
> "
>
>
>> >
>> > Signed-off-by: Ernst Schwab <eschwab@online.de>
>> > ---
>> > Tested on MPC8314.
>> >
>> > diff -up linux-2.6.33-rc8.orig/drivers/spi/spi_mpc8xxx.c linux-2.6.33-=
rc8/drivers/spi/spi_mpc8xxx.c
>> > --- linux-2.6.33-rc8.orig/drivers/spi/spi_mpc8xxx.c =A0 =A0 2010-02-12=
 20:07:45.000000000 +0100
>> > +++ linux-2.6.33-rc8/drivers/spi/spi_mpc8xxx.c =A02010-02-15 14:08:33.=
000000000 +0100
>> > @@ -365,7 +365,7 @@ int mpc8xxx_spi_setup_transfer(struct sp
>> >
>> > =A0 =A0 =A0 =A0if ((mpc8xxx_spi->spibrg / hz) > 64) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->hw_mode |=3D SPMODE_DIV16;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm =3D mpc8xxx_spi->spibrg / (hz * 64);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm =3D (mpc8xxx_spi->spibrg - 1) / (hz *=
 64) + 1;
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WARN_ONCE(pm > 16, "%s: Requested speed=
 is too low: %d Hz. "
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Will use %d Hz ins=
tead.\n", dev_name(&spi->dev),
>> > @@ -373,7 +373,7 @@ int mpc8xxx_spi_setup_transfer(struct sp
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pm > 16)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm =3D 16;
>> > =A0 =A0 =A0 =A0} else
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm =3D mpc8xxx_spi->spibrg / (hz * 4);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm =3D (mpc8xxx_spi->spibrg - 1) / (hz *=
 4) + 1;
>> > =A0 =A0 =A0 =A0if (pm)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm--;
>> >
>> >
>> >
>> >
>> > --
>> >
>> >
>>
>>
>>
>> --
>> Grant Likely, B.Sc., P.Eng.
>> Secret Lab Technologies Ltd.
>
>
> --
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

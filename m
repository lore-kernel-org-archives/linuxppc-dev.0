Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) by ozlabs.org (Postfix) with ESMTP id E46CFB6F01
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 16:48:33 +1000 (EST)
Received: by yxi11 with SMTP id 11so4492814yxi.15
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jul 2010 23:48:31 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <73839B4A0818E747864426270AC332C3054005D5@zmy16exm20.fsl.freescale.net>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<20100726001415.GA24562@angua.secretlab.ca>
	<73839B4A0818E747864426270AC332C3054005D5@zmy16exm20.fsl.freescale.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Jul 2010 00:48:11 -0600
Message-ID: <AANLkTim8GVosXE1F88av7hi38uYdk-x4yfFLsOvG4tT=@mail.gmail.com>
Subject: Re: [PATCH 1/6] spi/mpc8xxx: refactor the common code for SPI/eSPI
	controller
To: Hu Mingkai-B21284 <B21284@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "@angua.secretlab.ca"@angua.secretlab.ca, linuxppc-dev@ozlabs.org,
	Zang Roy-R61911 <R61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 26, 2010 at 12:18 AM, Hu Mingkai-B21284
<B21284@freescale.com> wrote:
>
>
>> -----Original Message-----
>> From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of
>> Grant Likely
>> Sent: Monday, July 26, 2010 8:14 AM
>> To: Hu Mingkai-B21284; "@angua.secretlab.ca"@angua.secretlab.ca
>> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang
>> Roy-R61911
>> Subject: Re: [PATCH 1/6] spi/mpc8xxx: refactor the common
>> code for SPI/eSPI controller
>>
>> On Tue, Jul 20, 2010 at 10:08:20AM +0800, Mingkai Hu wrote:
>> > Refactor the common code to file spi_mpc8xxx.c used by SPI/eSPI
>> > controller driver, move the SPI controller driver to a new file
>> > fsl_spi.c, and leave the QE/CPM SPI controller code in this file.
>> >
>> > Because the register map of the SPI controller and eSPI controller
>> > is so different, also leave the code operated the register to the
>> > driver code, not the common code.
>> >
>> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
>> > ---
>> > =A0drivers/spi/Kconfig =A0 =A0 =A0 | =A0 13 +-
>> > =A0drivers/spi/Makefile =A0 =A0 =A0| =A0 =A01 +
>> > =A0drivers/spi/fsl_spi.c =A0 =A0 | 1118
>> ++++++++++++++++++++++++++++++++++++++++++
>> > =A0drivers/spi/spi_mpc8xxx.c | 1198
>> ++-------------------------------------------
>> > =A0drivers/spi/spi_mpc8xxx.h | =A0135 +++++
>>
>> Please name files spi-*.[ch]. =A0I'm going to start enforcing
>> this naming convention in the drivers/spi directory.
>>
>
> Ok.
>
>> > =A05 files changed, 1299 insertions(+), 1166 deletions(-)
>> > =A0create mode 100644 drivers/spi/fsl_spi.c
>> > =A0create mode 100644 drivers/spi/spi_mpc8xxx.h
>> >
>> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> > index 91c2f4f..cd564e2 100644
>> > --- a/drivers/spi/Kconfig
>> > +++ b/drivers/spi/Kconfig
>> > @@ -183,11 +183,18 @@ config SPI_MPC512x_PSC
>> > =A0 =A0 =A0 Controller in SPI master mode.
>> >
>> > =A0config SPI_MPC8xxx
>> > - =A0 tristate "Freescale MPC8xxx SPI controller"
>> > + =A0 bool
>>
>> This should be tristate so it can be loaded as a module.
>>
>
> This option is selected by FSL_SPI and FSL_ESPI option, can we load the
> driver as a module?

Yes.  You may need to export some symbols, but the common library can
be loaded as a module.

>> > +static void __exit fsl_spi_exit(void)
>> > +{
>> > + =A0 of_unregister_platform_driver(&of_fsl_spi_driver);
>> > + =A0 legacy_driver_unregister();
>> > +}
>>
>> It would appear that the legacy driver should *also* be
>> separated out into its own module. =A0I realize you're just cut
>> & pasting code here, but it should be considered for a followup patch.
>>
>
> Can we remove the legacy driver thoroughly?
> If we separated out the code, what's the proper name for it?
> spi_mpc8xxx_legacy.c?

Sure.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

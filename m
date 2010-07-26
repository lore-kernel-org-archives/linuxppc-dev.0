Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 18CAFB6EEE
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 17:45:48 +1000 (EST)
Received: by gwj15 with SMTP id 15so1790737gwj.15
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 00:45:46 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <83024545B35D6445A690EFD603E7869A050ECB@zch01exm23.fsl.freescale.net>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<20100726001415.GA24562@angua.secretlab.ca>
	<83024545B35D6445A690EFD603E7869A050ECB@zch01exm23.fsl.freescale.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Jul 2010 01:45:26 -0600
Message-ID: <AANLkTimV_mB809qX8enJn1vorJg4eZQbWS6nznEtM_gc@mail.gmail.com>
Subject: Re: [PATCH 1/6] spi/mpc8xxx: refactor the common code for SPI/eSPI
	controller
To: Zang Roy-R61911 <r61911@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Hu Mingkai-B21284 <B21284@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 26, 2010 at 1:07 AM, Zang Roy-R61911 <r61911@freescale.com> wro=
te:
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
>> > =A0 =A0 depends on FSL_SOC
>> > =A0 =A0 help
>> > - =A0 =A0 This enables using the Freescale MPC8xxx SPI
>> controllers in master
>> > - =A0 =A0 mode.
>> > + =A0 =A0 This enables using the Freescale MPC8xxx SPI/eSPI controller=
s
>> > + =A0 =A0 driver library.
>>
>> Drop the help text entirely. =A0It isn't needed on
>> non-user-visible options.
>>
>> > +
>> > +config SPI_FSL_SPI
>> > + =A0 tristate "Freescale SPI controller"
>>
>> "Freescale SPI controller is rather generic and doesn't give any clues
>> as to which devices actually have this controller. =A0At the very least
>> the help text should state what parts contain this controller.
>>
>> On that note, the naming convention seems a little loose.
>> Since both the eSPI and SPI are using SPI_MPC8xxx, then
>> really the names should be:
>>
>> config SPI_MPC8xxx_SPI
>> and
>> config SPI_MPC8xxx_ESPI
>
> SPI_FSL_SPI and SPI_FSL_ESDP are better at this point.
> 83xx platforms and some of 85xx platforms use SPI controller.
> From mpc8536, 85xx use ESP controller, BUT currently all P10xx, P20xx,
> P40xx use ESPI controller.
> 8xxx will not cover pxxx serial processor.

Then the config item for the shared code should be renamed to reflect this.

g.

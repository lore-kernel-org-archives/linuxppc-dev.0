Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A04981007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 18:23:04 +1100 (EST)
Subject: Re: [PATCH] SPI: fix build with CONFIG_SPI_FSL_ESPI=m
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4E5369A0.4080701@gmail.com>
Date: Thu, 24 Nov 2011 01:22:57 -0600
Message-Id: <F8B0661A-E43E-48B9-A8BB-B3D87999FD66@kernel.crashing.org>
References: <1314086345-2818-1-git-send-email-jslaby@suse.cz>
 <4E5369A0.4080701@gmail.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: spi-devel-general@lists.sourceforge.net, Jiri Slaby <jslaby@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 23, 2011, at 3:49 AM, Jiri Slaby wrote:

> On 08/23/2011 09:59 AM, Jiri Slaby wrote:
>> When spi_fsl_espi is chosen to be built as a module, there is a build
>> error because we test only CONFIG_SPI_FSL_ESPI in declaration of
>> struct mpc8xxx_spi in drivers/spi/spi_fsl_lib.h.
>>=20
>> We need to add a test for CONFIG_SPI_FSL_ESPI_MODULE too.
>>=20
>> The error looks like:
>> drivers/spi/spi_fsl_espi.c: In function 'fsl_espi_bufs':
>> drivers/spi/spi_fsl_espi.c:232: error: 'struct mpc8xxx_spi' has no =
member named 'len'
>> ...
>>=20
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>> drivers/spi/spi-fsl-lib.h |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
>> index cbe881b..97968de 100644
>> --- a/drivers/spi/spi-fsl-lib.h
>> +++ b/drivers/spi/spi-fsl-lib.h
>> @@ -28,7 +28,7 @@ struct mpc8xxx_spi {
>> 	/* rx & tx bufs from the spi_transfer */
>> 	const void *tx;
>> 	void *rx;
>> -#ifdef CONFIG_SPI_FSL_ESPI
>> +#if defined(CONFIG_SPI_FSL_ESPI) || =
defined(CONFIG_SPI_FSL_ESPI_MODULE)
>> 	int len;
>> #endif
>=20
> Oh, and there are still link errors:
> ERROR: "mpc8xxx_spi_tx_buf_u32" [drivers/spi/spi_fsl_spi.ko] =
undefined!
> ERROR: "mpc8xxx_spi_rx_buf_u32" [drivers/spi/spi_fsl_spi.ko] =
undefined!
> ERROR: "mpc8xxx_spi_tx_buf_u16" [drivers/spi/spi_fsl_spi.ko] =
undefined!
> ERROR: "mpc8xxx_spi_rx_buf_u16" [drivers/spi/spi_fsl_spi.ko] =
undefined!
> ERROR: "mpc8xxx_spi_tx_buf_u8" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_rx_buf_u8" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "of_mpc8xxx_spi_probe" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_strmode" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_probe" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_remove" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "to_of_pinfo" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_tx_buf_u32" [drivers/spi/spi_fsl_espi.ko] =
undefined!
> ERROR: "mpc8xxx_spi_rx_buf_u32" [drivers/spi/spi_fsl_espi.ko] =
undefined!
> ERROR: "of_mpc8xxx_spi_probe" [drivers/spi/spi_fsl_espi.ko] undefined!
> ERROR: "mpc8xxx_spi_probe" [drivers/spi/spi_fsl_espi.ko] undefined!
> ERROR: "mpc8xxx_spi_remove" [drivers/spi/spi_fsl_espi.ko] undefined!
>=20
> The functions are not exported...
>=20
> Should I export all those or deny CONFIG_SPI_FSL_ESPI=3Dm?

I'd just deny CONFIG_SPI_FSL_ESPI=3Dm, unless you have some need for it =
to be a module.

- k=

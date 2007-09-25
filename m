Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 27791DDE3A
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 01:16:30 +1000 (EST)
Date: Tue, 25 Sep 2007 19:18:19 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] [PATCH 7/7] [POWERPC][SPI] spi_mpc83xx:
	allow use on MPC85xx
Message-ID: <20070925151819.GA6757@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143531.GG5323@localhost.localdomain>
	<16E78F0E-B57B-4084-887E-5D2F9C1D0331@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <16E78F0E-B57B-4084-887E-5D2F9C1D0331@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 25, 2007 at 10:04:41AM -0500, Kumar Gala wrote:
>
> On Sep 25, 2007, at 9:35 AM, Anton Vorontsov wrote:
>
>> MPC85xx's QE SPI controller is almost the same comparing to MPC83xx.
>> Thus lets use that driver. Tested to work in loopback mode.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>>  drivers/spi/Kconfig |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index b915711..14f0d0d 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -125,7 +125,7 @@ config SPI_MPC52xx_PSC
>>
>>  config SPI_MPC83xx
>>  	tristate "Freescale MPC83xx SPI controller"
>> -	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
>> +	depends on SPI_MASTER && (PPC_83xx || PPC_85xx) && EXPERIMENTAL
>>  	select SPI_BITBANG
>>  	help
>>  	  This enables using the Freescale MPC83xx SPI controller in master
>
> Should that really be just PPC_83xx || QUICC_ENGINE?

Well, I thought about that. By now I'm unsure if every QE
implementation will be compatible with further ones. So far
I've tested this driver on MPC8323 and MPC8568. If we'll see
more and more compatible QE SPI controllers, of course we
may just do || QUICC_ENGINE.

PPC_83xx || PPC_85xx
PPC_83xx || QUICC_ENGINE

Today first option saves us four bytes. ;-)

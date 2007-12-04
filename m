Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E38ACDDEE6
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 05:44:25 +1100 (EST)
Date: Tue, 4 Dec 2007 12:48:26 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA
	device driver
Message-ID: <20071204184826.GA5758@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204170719.GB15599@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071204170719.GB15599@localhost.localdomain>
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, Dec 04, 2007 at 08:07:19PM +0300, Anton Vorontsov wrote:
> This driver nicely wraps around pata_platform library functions,
> and provides OF platform bus bindings to the PATA devices.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/ata/Kconfig            |   10 ++++
>  drivers/ata/Makefile           |    1 +
>  drivers/ata/pata_of_platform.c |  102 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/pata_of_platform.c
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index ba63619..5a492fa 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -614,6 +614,16 @@ config PATA_PLATFORM
>  
>  	  If unsure, say N.
>  
> +config PATA_OF_PLATFORM
> +	tristate "OpenFirmware platform device PATA support"
> +	depends on PATA_PLATFORM && PPC_OF
> +	help
> +	  This option enables support for generic directly connected ATA
> +	  devices commonly found on embedded systems with OpenFirmware
> +	  bindings.
> +
> +	  If unsure, say N.
> +

There's a typo in the dependencies for PATA_PLATFORM that you should change:

depends on EMBEDDED || ARCH_RPC

(note ARCH_>R<PC). With my font it's hard to tell a difference :)

It should really be:

depends on EMBEDDED || PPC

Care to change that while you're at it?

> +static struct of_device_id pata_of_platform_match[] = {
> +	{ .compatible = "ata-generic", },
> +};

Needs to be terminated by empty entry, and please add:
MODULE_DEVICE_TABLE(of, pata_of_platform_match);


-Olof

Return-Path: <david-b@pacbell.net>
Received: from smtp101.sbc.mail.mud.yahoo.com (smtp101.sbc.mail.mud.yahoo.com
	[68.142.198.200]) by ozlabs.org (Postfix) with SMTP id 3945ADDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 13:15:00 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [PATCH 1/3] [SPI] Sync spidev.{h,
	c} with spi.h
Date: Thu, 26 Jul 2007 20:02:02 -0700
References: <20070726134754.GA3539@localhost.localdomain>
	<20070726135041.GA5550@localhost.localdomain>
In-Reply-To: <20070726135041.GA5550@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707262002.02677.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 July 2007, Anton Vorontsov wrote:
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -56,8 +56,8 @@ static unsigned long	minors[N_SPI_MINORS / BITS_PER_LONG];
>  
>  
>  /* Bit masks for spi_device.mode management */
> -#define SPI_MODE_MASK			(SPI_CPHA | SPI_CPOL)
> -
> +#define SPI_MODE_MASK			(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | \
> +					 SPI_LSB_FIRST | SPI_3WIRE)

Hmm, I seem to recall explicitly leaving out CS_HIGH on the grounds
that getting it wrong could corrupt the whole bus; Not Good (tm).
And the same argument can apply to 3WIRE mode ...

On the other hand, that's not necessarily a good reason, since there
are other ways to trash hardware too.

Comments anyone?

- Dave

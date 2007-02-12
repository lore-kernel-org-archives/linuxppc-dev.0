Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B3B2DDD08
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 10:11:02 +1100 (EST)
Subject: Re: [PATCH 01/10] powerpc/serial: Dispose irq mapping when done in
	mpc52xx_serial.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <11713184091057-git-send-email-tnt@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 10:10:54 +1100
Message-Id: <1171321854.20192.34.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-12 at 23:13 +0100, Sylvain Munaut wrote:
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  drivers/serial/mpc52xx_uart.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
> index 6999816..ee4ebaf 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -999,6 +999,9 @@ mpc52xx_uart_of_remove(struct of_device 
>  	if (port)
>  		uart_remove_one_port(&mpc52xx_uart_driver, port);
>  
> +	if (port->irq != NO_IRQ)
> +		irq_dispose_mapping(port->irq);
> +
>  	return 0;
>  }

The NO_IRQ test isn't useful.

Cheers,
Ben

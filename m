Return-Path: <tnt@246tNt.com>
Received: from outmx023.isp.belgacom.be (outmx023.isp.belgacom.be
	[195.238.4.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 225CFDDF04
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 04:44:16 +1000 (EST)
Received: from outmx023.isp.belgacom.be (localhost [127.0.0.1])
	by outmx023.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l3JIi9h4027316
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2007 20:44:09 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4627B84E.10904@246tNt.com>
Date: Thu, 19 Apr 2007 20:43:26 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Don't shutdown mpc5200 serial port if it is a console
References: <11770061133776-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11770061133776-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The idea is OK,

but only TX should be left active and the interrupts should still be
disabled (imr set to 0), so we don't generate unhandled interrupts ...


        Sylvain


Grant Likely wrote:
> If the serial port gets shut down, then console output stalls.  9 out
> of 10 kernel hackers agree, this is a bad thing.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Bartlomiej Sieka <tur@semihalf.com>
> ---
>
> This is a simple bug fix, but it's not a critical one.  It would be really
> nice to get this merged for 2.6.21
>  drivers/serial/mpc52xx_uart.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
> index f8c1761..35669f8 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -257,14 +257,16 @@ mpc52xx_uart_shutdown(struct uart_port *port)
>  {
>  	struct mpc52xx_psc __iomem *psc = PSC(port);
>  
> -	/* Shut down the port, interrupt and all */
> -	out_8(&psc->command,MPC52xx_PSC_RST_RX);
> -	out_8(&psc->command,MPC52xx_PSC_RST_TX);
> +	/* We don't want to shut down a port that is used as a console */
> +	if (!uart_console(port)) {
> +		out_8(&psc->command,MPC52xx_PSC_RST_RX);
> +		out_8(&psc->command,MPC52xx_PSC_RST_TX);
>  
> -	port->read_status_mask = 0;
> -	out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
> +		port->read_status_mask = 0;
> +		out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
> +	}
>  
> -	/* Release interrupt */
> +	/* Release interrupt (OK for console port b/c console uses polling) */
>  	free_irq(port->irq, port);
>  }
>  
>   

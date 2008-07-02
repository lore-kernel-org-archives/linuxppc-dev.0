Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41F97DDF57
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 17:46:59 +1000 (EST)
Message-Id: <4768A00D-3C8B-4AF2-A2E1-DE9C9BD055E4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200806261355.09334.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] cpm_uart: Support uart_wait_until_sent()
Date: Wed, 2 Jul 2008 02:46:54 -0500
References: <200806261355.09334.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 26, 2008, at 6:55 AM, Laurent Pinchart wrote:

> Set port->fifosize to the software FIFO size, and update the port  
> timeout
> when the baud rate is modified. SCC ports have an optional 32 byte  
> hardware
> FIFO which is currently not taken into account, as there is no  
> documented way
> to check when the FIFO becomes empty.
>
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
> drivers/serial/cpm_uart/cpm_uart_core.c |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)

I spoke to soon about being able to apply this.  Can you respin this  
against my powerpc-next tree.  Also, I had troubles applying this due  
to mailer formatting issues.

- k

> diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/ 
> serial/cpm_uart/cpm_uart_core.c
> index a19dc7e..151cad2 100644
> --- a/drivers/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_core.c
> @@ -547,6 +547,11 @@ static void cpm_uart_set_termios(struct  
> uart_port *port,
> 	}
>
> 	/*
> +	 * Update the timeout
> +	 */
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	/*
> 	 * Set up parity check flag
> 	 */
> #define RELEVANT_IFLAG(iflag) (iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK| 
> INPCK))
> @@ -1154,6 +1159,7 @@ int cpm_uart_drv_get_platform_data(struct  
> platform_device *pdev, int is_con)
> 	pinfo->port.uartclk = pdata->uart_clk;
> 	pinfo->port.mapbase = (unsigned long)mem;
> 	pinfo->port.irq = platform_get_irq(pdev, 0);
> +	pinfo->port.fifosize = pinfo->tx_nrfifos * pinfo->tx_fifosize;
>
> 	return 0;
> }
> -- 
> 1.5.0
>
> -- 
> Laurent Pinchart
> CSE Semaphore Belgium
>
> Chaussee de Bruxelles, 732A
> B-1410 Waterloo
> Belgium
>
> T +32 (2) 387 42 59
> F +32 (2) 387 42 75

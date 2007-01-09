Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17827.34062.767521.135272@cargo.ozlabs.ibm.com>
Date: Tue, 9 Jan 2007 23:05:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH 1/4] powerpc/serial: Dispose irq mapping when done in
	mpc52xx_serial.c
In-Reply-To: <116777699771-git-send-email-tnt@246tNt.com>
References: <1167776995690-git-send-email-tnt@246tNt.com>
	<116777699771-git-send-email-tnt@246tNt.com>
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sylvain Munaut writes:

> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> ---
>  drivers/serial/mpc52xx_uart.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
> index 9d11a75..eef3b02 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -997,6 +997,9 @@ mpc52xx_uart_of_remove(struct of_device 
>  	if (port)
>  		uart_remove_one_port(&mpc52xx_uart_driver, port);
>  
> +	if (port->irq != NO_IRQ)
> +		irq_dispose_mapping(port->irq);
> +

I didn't put this one in for 2.6.20, because it doesn't solve any
actual problem, and Ben H tells me it might trigger a bug in the
generic irq code.

Paul.

Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 13E0ADDDE0
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 03:40:57 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so245929qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 08:40:56 -0800 (PST)
Message-ID: <9e4733910811270840w23214c91o4f8a141c245cb663@mail.gmail.com>
Date: Thu, 27 Nov 2008 11:40:55 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Wolfram Sang" <w.sang@pengutronix.de>
Subject: Re: [PATCH] mpc52xx/serial: fix error paths in probe function
In-Reply-To: <1227800036-30109-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1227800036-30109-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 27, 2008 at 10:33 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> - error cases for mapbase and irq were unbundled
> - mapped irq now gets disposed on error
> - errors return ENODEV instead of EINVAL as they are not dependant on
>  arguments
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/serial/mpc52xx_uart.c |   27 +++++++++++++++++----------
>  1 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
> index 3234100..93e8893 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -1113,14 +1113,14 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
>                if (mpc52xx_uart_nodes[idx] == op->node)
>                        break;
>        if (idx >= MPC52xx_PSC_MAXNUM)
> -               return -EINVAL;
> +               return -ENODEV;
>        pr_debug("Found %s assigned to ttyPSC%x\n",
>                 mpc52xx_uart_nodes[idx]->full_name, idx);
>
>        uartclk = psc_ops->getuartclk(op->node);
>        if (uartclk == 0) {
>                dev_dbg(&op->dev, "Could not find uart clock frequency!\n");
> -               return -EINVAL;
> +               return -ENODEV;
>        }
>
>        /* Init the port structure */
> @@ -1142,22 +1142,29 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
>                return ret;
>
>        port->mapbase = res.start;
> +       if (!port->mapbase) {
> +               dev_err(&op->dev, "Could not allocate resources for PSC\n");
> +               return -ENODEV;
> +       }
> +
>        port->irq = irq_of_parse_and_map(op->node, 0);
> +       if (port->irq == NO_IRQ) {
> +               dev_err(&op->dev, "Could not get irq\n");
> +               return -ENODEV;
> +       }

Doesn't NO_IRQ imply polling, not an error?

>
>        dev_dbg(&op->dev, "mpc52xx-psc uart at %p, irq=%x, freq=%i\n",
>                (void *)port->mapbase, port->irq, port->uartclk);
>
> -       if ((port->irq == NO_IRQ) || !port->mapbase) {
> -               printk(KERN_ERR "Could not allocate resources for PSC\n");
> -               return -EINVAL;
> -       }
> -
>        /* Add the port to the uart sub-system */
>        ret = uart_add_one_port(&mpc52xx_uart_driver, port);
> -       if (!ret)
> -               dev_set_drvdata(&op->dev, (void *)port);
> +       if (ret) {
> +               irq_dispose_mapping(port->irq);
> +               return -ENODEV;
> +       }
>
> -       return ret;
> +       dev_set_drvdata(&op->dev, (void *)port);
> +       return 0;
>  }
>
>  static int
> --
> 1.5.6.5
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Jon Smirl
jonsmirl@gmail.com

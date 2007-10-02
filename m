Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14EA1DDEED
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 15:53:27 +1000 (EST)
Subject: Re: [PATCH 2 6/7] Uartlite: Add of-platform-bus binding
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20070930224208.1871.2913.stgit@trillian.cg.shawcable.net>
References: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>
	<20070930224208.1871.2913.stgit@trillian.cg.shawcable.net>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 15:53:06 +1000
Message-Id: <1191304386.6310.92.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-09-30 at 16:42 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Add of_platform bus binding so this driver can be used with arch/powerpc

Another option is to have a "constructor" in the platform code that
generates the platform device from the DT. It might even become the
preferred way one of these days, I'm not too sure at this stage. Anyway,
do what you prefer.

> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  drivers/serial/uartlite.c |  101 +++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 93 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
> index ed13b9f..8752fac 100644
> --- a/drivers/serial/uartlite.c
> +++ b/drivers/serial/uartlite.c
> @@ -1,7 +1,8 @@
>  /*
>   * uartlite.c: Serial driver for Xilinx uartlite serial controller
>   *
> - * Peter Korsgaard <jacmet@sunsite.dk>
> + * Copyright (C) 2006 Peter Korsgaard <jacmet@sunsite.dk>
> + * Copyright (C) 2007 Secret Lab Technologies Ltd.
>   *
>   * This file is licensed under the terms of the GNU General Public License
>   * version 2.  This program is licensed "as is" without any warranty of any
> @@ -17,6 +18,10 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <asm/io.h>
> +#if defined(CONFIG_OF)
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#endif
>  
>  #define ULITE_NAME		"ttyUL"
>  #define ULITE_MAJOR		204
> @@ -382,8 +387,10 @@ static int __init ulite_console_setup(struct console *co, char *options)
>  	port = &ulite_ports[co->index];
>  
>  	/* not initialized yet? */
> -	if (!port->membase)
> +	if (!port->membase) {
> +		pr_debug("console on ttyUL%i not initialized\n", co->index);
>  		return -ENODEV;
> +	}
>  
>  	if (options)
>  		uart_parse_options(options, &baud, &parity, &bits, &flow);
> @@ -542,6 +549,72 @@ static struct platform_driver ulite_platform_driver = {
>  };
>  
>  /* ---------------------------------------------------------------------
> + * OF bus bindings
> + */
> +#if defined(CONFIG_OF)
> +static int __devinit
> +ulite_of_probe(struct of_device *op, const struct of_device_id *match)
> +{
> +	struct resource res;
> +	const unsigned int *id;
> +	int irq, rc;
> +
> +	dev_dbg(&op->dev, "%s(%p, %p)\n", __FUNCTION__, op, match);
> +
> +	rc = of_address_to_resource(op->node, 0, &res);
> +	if (rc) {
> +		dev_err(&op->dev, "invalide address\n");
> +		return rc;
> +	}
> +
> +	irq = irq_of_parse_and_map(op->node, 0);
> +
> +	id = of_get_property(op->node, "port-number", NULL);
> +
> +	return ulite_assign(&op->dev, id ? *id : -1, res.start, irq);
> +}
> +
> +static int __devexit ulite_of_remove(struct of_device *op)
> +{
> +	return ulite_release(&op->dev);
> +}
> +
> +/* Match table for of_platform binding */
> +static struct of_device_id __devinit ulite_of_match[] = {
> +	{ .type = "serial", .compatible = "xilinx,uartlite", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ulite_of_match);
> +
> +static struct of_platform_driver ulite_of_driver = {
> +	.owner = THIS_MODULE,
> +	.name = "uartlite",
> +	.match_table = ulite_of_match,
> +	.probe = ulite_of_probe,
> +	.remove = __devexit_p(ulite_of_remove),
> +	.driver = {
> +		.name = "uartlite",
> +	},
> +};
> +
> +/* Registration helpers to keep the number of #ifdefs to a minimum */
> +static inline int __init ulite_of_register(void)
> +{
> +	pr_debug("uartlite: calling of_register_platform_driver()\n");
> +	return of_register_platform_driver(&ulite_of_driver);
> +}
> +
> +static inline void __exit ulite_of_unregister(void)
> +{
> +	of_unregister_platform_driver(&ulite_of_driver);
> +}
> +#else /* CONFIG_OF */
> +/* CONFIG_OF not enabled; do nothing helpers */
> +static inline int __init ulite_of_register(void) { return 0; }
> +static inline void __exit ulite_of_unregister(void) { }
> +#endif /* CONFIG_OF */
> +
> +/* ---------------------------------------------------------------------
>   * Module setup/teardown
>   */
>  
> @@ -549,20 +622,32 @@ int __init ulite_init(void)
>  {
>  	int ret;
>  
> -	ret = uart_register_driver(&ulite_uart_driver);
> -	if (ret)
> -		return ret;
> +	pr_debug("uartlite: calling uart_register_driver()\n");
> +	if ((ret = uart_register_driver(&ulite_uart_driver)) != 0)
> +		goto err_uart;
>  
> -	ret = platform_driver_register(&ulite_platform_driver);
> -	if (ret)
> -		uart_unregister_driver(&ulite_uart_driver);
> +	if ((ret = ulite_of_register()) != 0)
> +		goto err_of;
>  
> +	pr_debug("uartlite: calling platform_driver_register()\n");
> +	if ((ret = platform_driver_register(&ulite_platform_driver)) != 0)
> +		goto err_plat;
> +
> +	return 0;
> +
> +err_plat:
> +	ulite_of_unregister();
> +err_of:
> +	uart_unregister_driver(&ulite_uart_driver);
> +err_uart:
> +	printk(KERN_ERR "registering uartlite driver failed: err=%i", ret);
>  	return ret;
>  }
>  
>  void __exit ulite_exit(void)
>  {
>  	platform_driver_unregister(&ulite_platform_driver);
> +	ulite_of_unregister();
>  	uart_unregister_driver(&ulite_uart_driver);
>  }
>  
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

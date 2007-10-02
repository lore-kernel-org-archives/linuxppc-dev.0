Return-Path: <jacmet@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by ozlabs.org (Postfix) with ESMTP id 387DEDDFB7
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 01:47:40 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so4681123fkz
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 08:47:39 -0700 (PDT)
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 11/18] Virtex: Port UARTLITE driver to of-platform-bus
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181748.18608.62409.stgit@trillian.cg.shawcable.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 02 Oct 2007 17:47:32 +0200
In-Reply-To: <20070928181748.18608.62409.stgit@trillian.cg.shawcable.net>
	(Grant Likely's message of "Fri\, 28 Sep 2007 12\:17\:49 -0600")
Message-ID: <87641p34dn.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 Grant> From: Grant Likely <grant.likely@secretlab.ca>
 Grant> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
 Grant> ---

 Grant>  drivers/serial/uartlite.c |  101 +++++++++++++++++++++++++++++++++++++++++----
 Grant>  1 files changed, 93 insertions(+), 8 deletions(-)

 Grant> diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
 Grant> index ed13b9f..8f742e0 100644
 Grant> --- a/drivers/serial/uartlite.c
 Grant> +++ b/drivers/serial/uartlite.c
 Grant> @@ -1,7 +1,8 @@
 Grant>  /*
 Grant>   * uartlite.c: Serial driver for Xilinx uartlite serial controller
 Grant>   *
 Grant> - * Peter Korsgaard <jacmet@sunsite.dk>
 Grant> + * Copyright (C) 2006 Peter Korsgaard <jacmet@sunsite.dk>
 Grant> + * Copyright (C) 2007 Secret Lab Technologies Ltd.
 Grant>   *
 Grant>   * This file is licensed under the terms of the GNU General Public License
 Grant>   * version 2.  This program is licensed "as is" without any warranty of any
 Grant> @@ -17,6 +18,10 @@
 Grant>  #include <linux/delay.h>
 Grant>  #include <linux/interrupt.h>
 Grant>  #include <asm/io.h>
 Grant> +#if defined(CONFIG_OF)
 Grant> +#include <linux/of_device.h>
 Grant> +#include <linux/of_platform.h>
 Grant> +#endif
 
 Grant>  #define ULITE_NAME		"ttyUL"
 Grant>  #define ULITE_MAJOR		204
 Grant> @@ -382,8 +387,10 @@ static int __init ulite_console_setup(struct console *co, char *options)
 Grant>  	port = &ulite_ports[co->index];
 
 Grant>  	/* not initialized yet? */
 Grant> -	if (!port->membase)
 Grant> +	if (!port->membase) {
 Grant> +		pr_debug("console on ttyUL%i not initialized\n", co->index);
 Grant>  		return -ENODEV;
 Grant> +	}

Unrelated change.
 
 Grant>  	if (options)
 Grant>  		uart_parse_options(options, &baud, &parity, &bits, &flow);
 Grant> @@ -542,6 +549,72 @@ static struct platform_driver ulite_platform_driver = {
 Grant>  };
 
 Grant>  /* ---------------------------------------------------------------------
 Grant> + * OF bus bindings
 Grant> + */
 Grant> +#if defined(CONFIG_OF)
 Grant> +static int __devinit
 Grant> +ulite_of_probe(struct of_device *op, const struct of_device_id *match)
 Grant> +{
 Grant> +	struct resource res;
 Grant> +	const unsigned int *id;
 Grant> +	int irq, rc;
 Grant> +
 Grant> +	dev_dbg(&op->dev, "%s(%p, %p)\n", __FUNCTION__, op, match);
 Grant> +
 Grant> +	rc = of_address_to_resource(op->node, 0, &res);
 Grant> +	if (rc) {
 Grant> +		dev_err(&op->dev, "invalide address\n");
 Grant> +		return rc;
 Grant> +	}
 Grant> +
 Grant> +	irq = irq_of_parse_and_map(op->node, 0);
 Grant> +
 Grant> +	id = of_get_property(op->node, "port-number", NULL);
 Grant> +
 Grant> +	return ulite_assign(&op->dev, id ? *id : -1, res.start, irq);
 Grant> +}
 Grant> +
 Grant> +static int ulite_of_remove(struct of_device *op)
 Grant> +{
 Grant> +	return ulite_release(&op->dev);
 Grant> +}
 Grant> +
 Grant> +/* Match table for of_platform binding */
 Grant> +static struct of_device_id __devinit ulite_of_match[] = {
 Grant> +	{ .type = "serial", .compatible = "xilinx,uartlite", },
 Grant> +	{},
 Grant> +};
 Grant> +MODULE_DEVICE_TABLE(of, ulite_of_match);
 Grant> +
 Grant> +static struct of_platform_driver ulite_of_driver = {
 Grant> +	.owner = THIS_MODULE,
 Grant> +	.name = "uartlite",
 Grant> +	.match_table = ulite_of_match,
 Grant> +	.probe = ulite_of_probe,
 Grant> +	.remove = ulite_of_remove,
 Grant> +	.driver = {
 Grant> +		.name = "uartlite",
 Grant> +	},
 Grant> +};
 Grant> +
 Grant> +/* Registration helpers to keep the number of #ifdefs to a minimum */
 Grant> +static inline int __init ulite_of_register(void)
 Grant> +{
 Grant> +	pr_debug("uartlite: calling of_register_platform_driver()\n");
 Grant> +	return of_register_platform_driver(&ulite_of_driver);
 Grant> +}
 Grant> +
 Grant> +static inline void __init ulite_of_unregister(void)
 Grant> +{
 Grant> +	of_unregister_platform_driver(&ulite_of_driver);
 Grant> +}
 Grant> +#else /* CONFIG_OF */
 Grant> +/* CONFIG_OF not enabled; do nothing helpers */
 Grant> +static inline int __init ulite_of_register(void) { return 0; }
 Grant> +static inline void __init ulite_of_unregister(void) { }
 Grant> +#endif /* CONFIG_OF */
 Grant> +
 Grant> +/* ---------------------------------------------------------------------
 Grant>   * Module setup/teardown
 Grant>   */
 
 Grant> @@ -549,20 +622,32 @@ int __init ulite_init(void)
 Grant>  {
 Grant>  	int ret;
 
 Grant> -	ret = uart_register_driver(&ulite_uart_driver);
 Grant> -	if (ret)
 Grant> -		return ret;
 Grant> +	pr_debug("uartlite: calling uart_register_driver()\n");
 Grant> +	if ((ret = uart_register_driver(&ulite_uart_driver)) != 0)
 Grant> +		goto err_uart;
 
 Grant> -	ret = platform_driver_register(&ulite_platform_driver);
 Grant> -	if (ret)
 Grant> -		uart_unregister_driver(&ulite_uart_driver);
 Grant> +	if ((ret = ulite_of_register()) != 0)
 Grant> +		goto err_of;
 
 Grant> +	pr_debug("uartlite: calling platform_driver_register()\n");
 Grant> +	if ((ret = platform_driver_register(&ulite_platform_driver)) != 0)

I prefer to not have assignments in the if ().
Are all the pr_debug necessary? It looks quite messy.

 Grant> +		goto err_plat;
 Grant> +

 Grant> +	return 0;
 Grant> +
 Grant> +err_plat:
 Grant> +	ulite_of_unregister();
 Grant> +err_of:
 Grant> +	uart_unregister_driver(&ulite_uart_driver);
 Grant> +err_uart:
 Grant> +	printk(KERN_ERR "registering uartlite driver failed: err=%i", ret);
 Grant>  	return ret;
 Grant>  }
 
 Grant>  void __exit ulite_exit(void)
 Grant>  {
 Grant>  	platform_driver_unregister(&ulite_platform_driver);
 Grant> +	ulite_of_unregister();
 Grant>  	uart_unregister_driver(&ulite_uart_driver);
 Grant>  }
 


-- 
Bye, Peter Korsgaard

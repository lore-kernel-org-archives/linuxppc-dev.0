Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 56E4F1007D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 07:06:35 +1100 (EST)
Message-ID: <1323720383.19891.21.camel@pasglop>
Subject: Re: [PATCH 01/16 v3] pmac_zilog: fix unexpected irq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Finn Thain <fthain@telegraphics.com.au>
Date: Tue, 13 Dec 2011 07:06:23 +1100
In-Reply-To: <alpine.LNX.2.00.1112130020000.2550@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
 <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
 <1323318004.12793.21.camel@pasglop> <1323318638.12793.23.camel@pasglop>
 <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
 <1323647315.19891.10.camel@pasglop>
 <alpine.LNX.2.00.1112130020000.2550@nippy.intranet>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-m68k@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-12-13 at 00:34 +1100, Finn Thain wrote:
> On Mon, 12 Dec 2011, Benjamin Herrenschmidt wrote:
> 
> > Any chance you can test this patch ? I would not be surprised if it 
> > broke m68k since I had to do some of the changes in there "blind", so 
> > let me know... with this, I can again suspend/resume properly on a Pismo 
> > while using the internal modem among other things.
> 
> The patch works on a PowerBook 520 given a few changes (below). This 
> PowerBook only has one serial port that I can test (the internal modem is 
> not supported on 68k Macs).

Interesting. The modem is a soft-modem "geoport" or a hw serial modem ?
In the later case it's probably just a matter of finding the right GPIO
bit in Apple ASIC to turn the power on :-)

>  Can you test a machine with two ports? The 
> rest of my Mac hardware is in storage since I moved house last week.

I tried on 2 port powermacs, but I only have one adapter, so I've
basically been running with one serial port open and shooting irda frame
on the other (with nothing to check wether I got the frames on the other
hand), oh well ...

I'll apply your patch and commit via my tree.

Cheers,
Ben.

> Finn
> 
> 
> Index: linux-git/drivers/tty/serial/pmac_zilog.c
> ===================================================================
> --- linux-git.orig/drivers/tty/serial/pmac_zilog.c	2011-12-13 00:18:02.000000000 +1100
> +++ linux-git/drivers/tty/serial/pmac_zilog.c	2011-12-13 00:23:55.000000000 +1100
> @@ -1705,8 +1705,8 @@ static int __init pmz_init_port(struct u
>  	struct resource *r_ports;
>  	int irq;
>  
> -	r_ports = platform_get_resource(uap->node, IORESOURCE_MEM, 0);
> -	irq = platform_get_irq(uap->node, 0);
> +	r_ports = platform_get_resource(uap->pdev, IORESOURCE_MEM, 0);
> +	irq = platform_get_irq(uap->pdev, 0);
>  	if (!r_ports || !irq)
>  		return -ENODEV;
>  
> @@ -1763,8 +1763,10 @@ static void pmz_dispose_port(struct uart
>  
>  static int __init pmz_attach(struct platform_device *pdev)
>  {
> +	struct uart_pmac_port *uap;
>  	int i;
>  
> +	/* Iterate the pmz_ports array to find a matching entry */
>  	for (i = 0; i < pmz_ports_count; i++)
>  		if (pmz_ports[i].pdev == pdev)
>  			break;
> @@ -1773,15 +1775,23 @@ static int __init pmz_attach(struct plat
>  
>  	uap = &pmz_ports[i];
>  	uap->port.dev = &pdev->dev;
> -	dev_set_drvdata(&mdev->ofdev.dev, uap);
> +	platform_set_drvdata(pdev, uap);
>  
> -			return uart_add_one_port(&pmz_uart_reg,
> -						 &pmz_ports[i]->port);
> +	return uart_add_one_port(&pmz_uart_reg, &uap->port);
>  }
>  
>  static int __exit pmz_detach(struct platform_device *pdev)
>  {
> +	struct uart_pmac_port *uap = platform_get_drvdata(pdev);
> +
> +	if (!uap)
> +		return -ENODEV;
> +
>  	uart_remove_one_port(&pmz_uart_reg, &uap->port);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	uap->port.dev = NULL;
> +
>  	return 0;
>  }
>  
> @@ -1918,8 +1928,13 @@ static void __exit exit_pmz(void)
>  
>  	for (i = 0; i < pmz_ports_count; i++) {
>  		struct uart_pmac_port *uport = &pmz_ports[i];
> +#ifdef CONFIG_PPC_PMAC
>  		if (uport->node != NULL)
>  			pmz_dispose_port(uport);
> +#else
> +		if (uport->pdev != NULL)
> +			pmz_dispose_port(uport);
> +#endif
>  	}
>  	/* Unregister UART driver */
>  	uart_unregister_driver(&pmz_uart_reg);
> @@ -1993,6 +2008,9 @@ static int __init pmz_console_setup(stru
>  #ifdef CONFIG_PPC_PMAC
>  	if (uap->node == NULL)
>  		return -ENODEV;
> +#else
> +	if (uap->pdev == NULL)
> +		return -ENODEV;
>  #endif
>  	port = &uap->port;
>  
> Index: linux-git/drivers/tty/serial/pmac_zilog.h
> ===================================================================
> --- linux-git.orig/drivers/tty/serial/pmac_zilog.h	2011-12-13 00:18:02.000000000 +1100
> +++ linux-git/drivers/tty/serial/pmac_zilog.h	2011-12-13 00:23:55.000000000 +1100
> @@ -1,18 +1,9 @@
>  #ifndef __PMAC_ZILOG_H__
>  #define __PMAC_ZILOG_H__
>  
> -#ifdef CONFIG_PPC_PMAC
> -/* We cannot use dev_* because this can be called early, way before
> - * we are matched with a device (when using it as a kernel console)
> - */
>  #define pmz_debug(fmt, arg...)	pr_debug("ttyPZ%d: " fmt, uap->port.line, ## arg)
>  #define pmz_error(fmt, arg...)	pr_err("ttyPZ%d: " fmt, uap->port.line, ## arg)
>  #define pmz_info(fmt, arg...)	pr_info("ttyPZ%d: " fmt, uap->port.line, ## arg)
> -#else
> -#define pmz_debug(fmt, arg...)	dev_dbg(&uap->node->dev, fmt, ## arg)
> -#define pmz_error(fmt, arg...)	dev_err(&uap->node->dev, fmt, ## arg)
> -#define pmz_info(fmt, arg...)	dev_info(&uap->node->dev, fmt, ## arg)
> -#endif
>  
>  /*
>   * At most 2 ESCCs with 2 ports each

Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B23DBDDF00
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 08:53:24 +1000 (EST)
Date: Tue, 3 Apr 2007 13:37:36 -0700
From: Brad Boyer <flar@allandria.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070403203735.GB12332@cynthia.pants.nu>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1175610345.2665.15.camel@shinybook.infradead.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 03, 2007 at 10:25:45AM -0400, David Woodhouse wrote:
> There are proper device numbers registered for pmac_zilog now. Use them.
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 
> diff --git a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
> index 752ef07..579266d 100644
> --- a/drivers/serial/pmac_zilog.c
> +++ b/drivers/serial/pmac_zilog.c
> @@ -99,9 +99,10 @@ static DEFINE_MUTEX(pmz_irq_mutex);
>  
>  static struct uart_driver pmz_uart_reg = {
>  	.owner		=	THIS_MODULE,
> -	.driver_name	=	"ttyS",
> -	.dev_name	=	"ttyS",
> -	.major		=	TTY_MAJOR,
> +	.driver_name	=	"ttyPZ",
> +	.dev_name	=	"ttyPZ",
> +	.major		=	204,
> +	.minor		=	192,
>  };
>  
>  
> @@ -1800,7 +1801,6 @@ static int __init pmz_register(void)
>  	
>  	pmz_uart_reg.nr = pmz_ports_count;
>  	pmz_uart_reg.cons = PMACZILOG_CONSOLE;
> -	pmz_uart_reg.minor = 64;
>  
>  	/*
>  	 * Register this driver with the serial core
> 

Shouldn't we have defines for these? It doesn't seem good to have more
magic numbers floating around in the code.

	Brad Boyer
	flar@allandria.com

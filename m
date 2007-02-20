Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 65979DDDFB
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 01:44:36 +1100 (EST)
Message-ID: <45DB094A.2040309@ru.mvista.com>
Date: Tue, 20 Feb 2007 17:44:26 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 4/14] Use resource_size_t for serial port IO addresses
References: <20070220021234.E27E2DDD0B@ozlabs.org>
In-Reply-To: <20070220021234.E27E2DDD0B@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

David Gibson wrote:
> At present, various parts of the serial code use unsigned long to
> define resource addresses.  This is a problem, because some 32-bit
> platforms have physical addresses larger than 32-bits, and have mmio
> serial uarts located above the 4GB point.
> 
> This patch changes the type of mapbase in both struct uart_port and
> struct plat_serial8250_port to resource_size_t, which can be
> configured to be 64 bits on such platforms.  The mapbase in
> serial_struct can't safely be changed, because that structure is user
> visible.

    Erm, isn't linux-serial@vger.kernel.org more proper list for such patches?
Also, as serial drivers are now unmaintained, this probably needs to go to -mm 
tree.

> Signed-off-by: David Gibson <dwg@au1.ibm.com>

> Index: working-2.6/drivers/serial/serial_core.c
> ===================================================================
> --- working-2.6.orig/drivers/serial/serial_core.c	2007-02-19 11:07:42.000000000 +1100
> +++ working-2.6/drivers/serial/serial_core.c	2007-02-19 11:07:43.000000000 +1100
> @@ -633,7 +633,7 @@ static int uart_get_info(struct uart_sta
>  	tmp.hub6	    = port->hub6;
>  	tmp.io_type         = port->iotype;
>  	tmp.iomem_reg_shift = port->regshift;
> -	tmp.iomem_base      = (void *)port->mapbase;
> +	tmp.iomem_base      = (void *)(unsigned long)port->mapbase;

    For 32-bit kernels this may result in a meaningless address. Have you 
considered also changing iomem_base's type?

MBR, Sergei

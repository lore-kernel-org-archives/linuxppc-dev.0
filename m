Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF71BDDF42
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 02:47:02 +1000 (EST)
In-Reply-To: <4685DB63.7040705@freescale.com>
References: <4685DB63.7040705@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B3EE4BFA-2B20-4EF1-A3BB-BA9781DA8E2F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: current-speed property in serial devices causes kernel panic
Date: Mon, 2 Jul 2007 11:46:41 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 29, 2007, at 11:26 PM, Timur Tabi wrote:

> I see this code in function of_platform_serial_setup():
>
> static int __devinit of_platform_serial_setup(struct of_device *ofdev,
>                                         int type, struct uart_port  
> *port)
> {
>         struct resource resource;
>         struct device_node *np = ofdev->node;
>         const unsigned int *clk, *spd;
>         int ret;
>
>         memset(port, 0, sizeof *port);
>         spd = of_get_property(np, "current-speed", NULL);
> ...
>         port->custom_divisor = *clk / (16 * (*spd));
>
>         return 0;
> }
>
> There is no check in this code to make sure spd is not null.  And  
> sure enough, in most DTS files, current-speed does not exist.  So  
> whenever this function is called on a node like this, the kernel  
> panics.

I'm wondering why we set port->custom_divisor instead of setting port- 
 >speed. (plus the null check).

- k

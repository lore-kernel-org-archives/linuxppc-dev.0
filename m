Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 8E92FDE0E3
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 23:26:15 +1100 (EST)
Message-ID: <47F4CCBA.9060706@ru.mvista.com>
Date: Thu, 03 Apr 2008 16:25:30 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH 2/3] [POWERPC][V3] Xilinx: of_serial support for Xilinx
	uart	16550.
References: <20080402232213.5D87515B8067@mail37-sin.bigfish.com>
In-Reply-To: <20080402232213.5D87515B8067@mail37-sin.bigfish.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

John Linn wrote:

> The Xilinx 16550 uart core is not a standard 16550 because it uses
> word-based addressing rather than byte-based addressing. With
> additional properties it is compatible with the open firmware
> 'ns16550' compatible binding.

> This code updates the of_serial driver to handle the reg-offset
> and reg-shift properties to enable this core to be used.

> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---

> diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
> index 2efb892..73c47a5 100644
> --- a/drivers/serial/of_serial.c
> +++ b/drivers/serial/of_serial.c
> @@ -31,7 +31,8 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
>  	struct resource resource;
>  	struct device_node *np = ofdev->node;
>  	const unsigned int *clk, *spd;
> -	int ret;
> +	const u32 *prop;
> +	int ret, prop_size;
>  
>  	memset(port, 0, sizeof *port);
>  	spd = of_get_property(np, "current-speed", NULL);
> @@ -49,6 +50,17 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
>  
>  	spin_lock_init(&port->lock);
>  	port->mapbase = resource.start;
> +
> +	/* Check for shifted address mapping */
> +	prop = of_get_property(np, "reg-offset", &prop_size);
> +	if (prop && (prop_size == sizeof(u32)))
> +		port->mapbase += *prop;

    I disagree. That trick leads to I/O resource misaccounting/misreporting. 
You should teach 8250.c about the offset trick instead, just as it's been 
taught the shift trick in its time.

> +
> +	/* Check for registers offset within the devices address range */
> +	prop = of_get_property(np, "reg-shift", &prop_size);
> +	if (prop && (prop_size == sizeof(u32)))
> +		port->regshift = *prop;
> +
>  	port->irq = irq_of_parse_and_map(np, 0);
>  	port->iotype = UPIO_MEM;
>  	port->type = type;

WBR, Sergei

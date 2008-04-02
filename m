Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 7A5DBDDFA1
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 10:39:30 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] [POWERPC][V3] Xilinx: of_serial support for Xilinx
	uart 16550.
Date: Thu, 3 Apr 2008 01:34:10 +0200
References: <20080402232213.5D87515B8067@mail37-sin.bigfish.com>
In-Reply-To: <20080402232213.5D87515B8067@mail37-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804030134.11437.arnd@arndb.de>
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 03 April 2008, John Linn wrote:
> The Xilinx 16550 uart core is not a standard 16550 because it uses
> word-based addressing rather than byte-based addressing. With
> additional properties it is compatible with the open firmware
> 'ns16550' compatible binding.
> 
> This code updates the of_serial driver to handle the reg-offset
> and reg-shift properties to enable this core to be used.
> 
> Signed-off-by: John Linn <john.linn@xilinx.com>

I may not be the best driver maintainer, but please keep the illusion
alive for me and Cc me on patches to drivers I wrote ;-)

> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index 87f4d84..4066ec8 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -2539,6 +2539,16 @@ platforms are moved over to use the flattened-device-tree model.
>                        differ between different families.  May be
>                        'virtex2p', 'virtex4', or 'virtex5'.
>  
> +      iv) Xilinx Uart 16550
> +
> +      Xilinx UART 16550 devices are very similar to the NS16550 but with
> +      different register spacing and an offset from the base address.
> +
> +      Requred properties:
> +       - clock-frequency : Frequency of the clock input
> +       - reg-offset : A value of 3 is required
> +       - reg-shift : A value of 2 is required
> +
>     More devices will be defined as this spec matures.

Since it is not really compatible with ns16550, shouldn't you at least specify
a different "compatible" property? That way, the driver won't do incorrect
accesses when you try to use an old driver with a device tree that specifies
one of these.

> @@ -49,6 +50,17 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
>  
>  	spin_lock_init(&port->lock);
>  	port->mapbase = resource.start;
> +
> +	/* Check for shifted address mapping */
> +	prop = of_get_property(np, "reg-offset", &prop_size);
> +	if (prop && (prop_size == sizeof(u32)))
> +		port->mapbase += *prop;
> +
> +	/* Check for registers offset within the devices address range */
> +	prop = of_get_property(np, "reg-shift", &prop_size);
> +	if (prop && (prop_size == sizeof(u32)))
> +		port->regshift = *prop;
> +
>  	port->irq = irq_of_parse_and_map(np, 0);
>  	port->iotype = UPIO_MEM;
>  	port->type = type;

This part looks good to me.

	Arnd <><

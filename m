Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <1124263872.3869.48.camel@localhost.localdomain>
References: <1124263872.3869.48.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7DCB5F52-8452-42C5-A6CD-2ED8E3934C42@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 17 Aug 2005 08:54:47 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Use platform device for 8250 registration
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Yes, that's precisely what I meant. Just remove it from the list in
> serial.h and as Ben says, instantiating a platform device is easy.
>
> static struct plat_serial8250_port my_serial_ports[] = {
>     {
>         .uartclk = 115200*16,
>         .iobase = 0x2f8,
>         .irq = 3,
>         .flags = ASYNC_BOOT_AUTOCONF;
>     },
> };
>
> static struct platform_device my_serial_device = {
>     .name = "serial8250",
>     .dev.platform_data = my_serial_ports,
> };
>
>   ... platform_device_register(&my_serial_device);

If we are going forward with this change for OF, can we kill  
pc_serial.h and just move the default BASE_BAUD and RS_TABLE size  
into serial.h.

- kumar

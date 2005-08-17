Return-Path: <SRS0+4f7dea7c1a1c06760337+724+infradead.org+dwmw2@pentafluge.srs.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <11F30454-6808-44A3-8F5B-F36ED0028EF4@freescale.com>
References: <1124209292.3869.5.camel@localhost.localdomain>
	<11F30454-6808-44A3-8F5B-F36ED0028EF4@freescale.com>
Content-Type: text/plain
Date: Wed, 17 Aug 2005 08:31:11 +0100
Message-Id: <1124263872.3869.48.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Wed, 2005-08-17 at 01:30 -0500, Kumar Gala wrote:
> > We could probably remove all the rest of the crap from asm/serial.h and
> > let platforms register their own serial8250 platform devices...

> Hmm, I wondering if we can provide some standard way of handling this  
> for the embedded platforms as well.  It would be nice to drop the old  
> style of initialization completely and move to using a platform  
> device always.

Yes, that's precisely what I meant. Just remove it from the list in
serial.h and as Ben says, instantiating a platform device is easy.

static struct plat_serial8250_port my_serial_ports[] = {
	{
		.uartclk = 115200*16,
		.iobase = 0x2f8,
		.irq = 3,
		.flags = ASYNC_BOOT_AUTOCONF;
	},
};

static struct platform_device my_serial_device = {
	.name = "serial8250",
	.dev.platform_data = my_serial_ports,
};

  ... platform_device_register(&my_serial_device);

-- 
dwmw2

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E929689E6
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 12:56:16 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: gregkh@suse.de
In-Reply-To: <1EwCY8-1zu-00@press.kroah.org>
References: <1EwCY8-1zu-00@press.kroah.org>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 12:55:14 +1100
Message-Id: <1136944515.5333.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: greg@kroah.com, rmk+kernel@arm.linux.org.uk, rmk@arm.linux.org.uk,
	linuxppc-dev@ozlabs.org
Subject: Re: patch add-macio_bus_type-probe-and-remove-methods.patch added
	to gregkh-2.6 tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-01-09 at 22:00 -0800, gregkh@suse.de wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      Subject: [CFT 19/29] Add macio_bus_type probe and remove methods
> 
> to my gregkh-2.6 tree.  Its filename is
> 
>      add-macio_bus_type-probe-and-remove-methods.patch
> 
> This tree can be found at 
>     http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/
> 
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/macintosh/macio_asic.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- gregkh-2.6.orig/drivers/macintosh/macio_asic.c
> +++ gregkh-2.6/drivers/macintosh/macio_asic.c
> @@ -204,6 +204,9 @@ struct bus_type macio_bus_type = {
>         .name	= "macio",
>         .match	= macio_bus_match,
>         .uevent = macio_uevent,
> +       .probe	= macio_device_probe,
> +       .remove	= macio_device_remove,
> +       .shutdown = macio_device_shutdown,
>         .suspend	= macio_device_suspend,
>         .resume	= macio_device_resume,
>         .dev_attrs = macio_dev_attrs,
> @@ -487,9 +490,6 @@ int macio_register_driver(struct macio_d
>  	/* initialize common driver fields */
>  	drv->driver.name = drv->name;
>  	drv->driver.bus = &macio_bus_type;
> -	drv->driver.probe = macio_device_probe;
> -	drv->driver.remove = macio_device_remove;
> -	drv->driver.shutdown = macio_device_shutdown;
>  
>  	/* register with core */
>  	count = driver_register(&drv->driver);
> 
> 
> Patches currently in gregkh-2.6 which might be from rmk@arm.linux.org.uk are
> 
> driver/add-bttv-sub-bus_type-probe-and-remove-methods.patch
> driver/add-bus_type-probe-remove-shutdown-methods..patch
> driver/add-ccwgroup_bus_type-probe-and-remove-methods.patch
> driver/add-dio_bus_type-probe-and-remove-methods.patch
> driver/add-ecard_bus_type-probe-remove-shutdown-methods.patch
> driver/add-gameport-bus_type-probe-and-remove-methods.patch
> driver/add-i2c_bus_type-probe-and-remove-methods.patch
> driver/add-ide_bus_type-probe-and-remove-methods.patch
> driver/add-locomo-bus_type-probe-remove-methods.patch
> driver/add-logic-module-bus_type-probe-remove-methods.patch
> driver/add-macio_bus_type-probe-and-remove-methods.patch
> driver/add-mcp-bus_type-probe-and-remove-methods.patch
> driver/add-mmc_bus_type-probe-and-remove-methods.patch
> driver/add-ocp_bus_type-probe-and-remove-methods.patch
> driver/add-of_platform_bus_type-probe-and-remove-methods.patch
> driver/add-parisc_bus_type-probe-and-remove-methods.patch
> driver/add-pci_bus_type-probe-and-remove-methods.patch
> driver/add-pcmcia_bus_type-probe-and-remove-methods.patch
> driver/add-pnp_bus_type-probe-and-remove-methods.patch
> driver/add-pseudo-lld-bus_type-probe-and-remove-methods.patch
> driver/add-rio_bus_type-probe-and-remove-methods.patch
> driver/add-sa1111-bus_type-probe-remove-methods.patch
> driver/add-serio-bus_type-probe-and-remove-methods.patch
> driver/add-sh_bus_type-probe-and-remove-methods.patch
> driver/add-superhyway_bus_type-probe-and-remove-methods.patch
> driver/add-tiocx-bus_type-probe-remove-methods.patch
> driver/add-usb_serial_bus_type-probe-and-remove-methods.patch
> driver/add-vio_bus_type-probe-and-remove-methods.patch
> driver/add-zorro_bus_type-probe-and-remove-methods.patch
> driver/remove-usb-gadget-generic-driver-methods.patch
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

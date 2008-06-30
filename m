Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id 0D448DDFC9
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 03:16:33 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1765793wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 10:16:32 -0700 (PDT)
Date: Mon, 30 Jun 2008 11:16:28 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Message-ID: <20080630171628.GF17916@secretlab.ca>
References: <20080630142451.516A41D1006C@mail57-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080630142451.516A41D1006C@mail57-sin.bigfish.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org, Sadanand <sadanan@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 30, 2008 at 07:24:48AM -0700, John Linn wrote:
> Added a new driver for Xilinx XPS PS2 IP. This driver is
> a flat driver to better match the Linux driver pattern.
> 
> Signed-off-by: Sadanand <sadanan@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>

I don't know much about the serio conventions, but I can make some
general comments...

from MAINTAINERS:

INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN) DRIVERS
P:	Dmitry Torokhov
M:	dmitry.torokhov@gmail.com
M:	dtor@mail.ru
L:	linux-input@vger.kernel.org
T:	git kernel.org:/pub/scm/linux/kernel/git/dtor/input.git
S:	Maintained

You need to cc: the linux-input mailing list and Dimitry when you post
the next version of this driver.

> ---
>  drivers/input/serio/Kconfig      |    5 +
>  drivers/input/serio/Makefile     |    1 +
>  drivers/input/serio/xilinx_ps2.c |  464 ++++++++++++++++++++++++++++++++++++++
>  drivers/input/serio/xilinx_ps2.h |   97 ++++++++
>  4 files changed, 567 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/serio/xilinx_ps2.c
>  create mode 100644 drivers/input/serio/xilinx_ps2.h
> 
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index ec4b661..0e62b39 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -190,4 +190,9 @@ config SERIO_RAW
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called serio_raw.
>  
> +config SERIO_XILINX_XPS_PS2
> +	tristate "Xilinx XPS PS/2 Controller Support"
> +	help
> +	  This driver supports XPS PS/2 IP from Xilinx EDK.
> +

Consider moving this block to somewhere in the middle of the file to
reduce the possibility of merge conflicts.

>  endif
> diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
> index 38b8868..9b6c813 100644
> --- a/drivers/input/serio/Makefile
> +++ b/drivers/input/serio/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_SERIO_PCIPS2)	+= pcips2.o
>  obj-$(CONFIG_SERIO_MACEPS2)	+= maceps2.o
>  obj-$(CONFIG_SERIO_LIBPS2)	+= libps2.o
>  obj-$(CONFIG_SERIO_RAW)		+= serio_raw.o
> +obj-$(CONFIG_SERIO_XILINX_XPS_PS2)	+= xilinx_ps2.o

Ditto.
> diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
> new file mode 100644
> index 0000000..670d47f
> --- /dev/null
> +++ b/drivers/input/serio/xilinx_ps2.c
> @@ -0,0 +1,464 @@
> +/*
> + * xilinx_ps2.c

Don't put the .c filename in the header block.

> + *
> + * Xilinx PS/2 driver to interface PS/2 component to Linux
> + *
> + * Author: MontaVista Software, Inc.
> + *	   source@mvista.com

Is this true anymore?

> + *
> + * (c) 2005 MontaVista Software, Inc.
> + * (c) 2008 Xilinx Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.

These two paragraphs are redundant.  Being in the Linux source tree
implies that it is GPL licensed.  You can remove them.

> + */
> +
> +
> +#include <linux/module.h>
> +#include <linux/serio.h>
> +#include <linux/interrupt.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <asm/io.h>
> +
> +#ifdef CONFIG_OF		/* For open firmware */
> + #include <linux/of_device.h>
> + #include <linux/of_platform.h>
> +#endif /* CONFIG_OF */

This is a given for mainline since arch/ppc will not exist in 2.6.27

> +
> +#include "xilinx_ps2.h"

This header can simple be rolled into this .c file because the driver no
longer has multiple .c files.


> +#define DRIVER_DESCRIPTION	"Xilinx XPS PS/2 driver"
> +#define XPS2_NAME_DESC		"Xilinx XPS PS/2 Port #%d"
> +#define XPS2_PHYS_DESC		"xilinxps2/serio%d"

These strings are only used in 1 place each, no need to use a #define

> +
> +
> +static DECLARE_MUTEX(cfg_sem);

This mutex should be part of the driver private data structure

> +
> +/*********************/
> +/* Interrupt handler */
> +/*********************/
> +static irqreturn_t xps2_interrupt(int irq, void *dev_id)
> +{
> +	struct xps2data *drvdata = (struct xps2data *)dev_id;
> +	u32 intr_sr;
> +	u32 ier;
> +	u8 c;
> +	u8 retval;
> +
> +	/* Get the PS/2 interrupts and clear them */
> +	intr_sr = in_be32(drvdata->base_address + XPS2_IPISR_OFFSET);
> +	out_be32(drvdata->base_address + XPS2_IPISR_OFFSET, intr_sr);
> +
> +	/* Check which interrupt is active */
> +	if (intr_sr & XPS2_IPIXR_RX_OVF) {
> +		printk(KERN_ERR "%s: receive overrun error\n",
> +			drvdata->serio.name);
> +	}
> +
> +	if (intr_sr & XPS2_IPIXR_RX_ERR) {
> +		drvdata->dfl |= SERIO_PARITY;
> +	}
> +
> +	if (intr_sr & (XPS2_IPIXR_TX_NOACK | XPS2_IPIXR_WDT_TOUT)) {
> +		drvdata->dfl |= SERIO_TIMEOUT;
> +	}
> +
> +	if (intr_sr & XPS2_IPIXR_RX_FULL) {
> +		retval = xps2_recv(drvdata, &drvdata->rxb);
> +
> +		/* Error, if 1 byte is not received */
> +		if (retval != 1) {
> +			printk(KERN_ERR
> +				"%s: wrong rcvd byte count (%d)\n",
> +				drvdata->serio.name, retval);
> +		}
> +		c = drvdata->rxb;
> +		serio_interrupt(&drvdata->serio, c, drvdata->dfl);
> +		drvdata->dfl = 0;
> +	}
> +
> +	if (intr_sr & XPS2_IPIXR_TX_ACK) {
> +
> +		/* Disable the TX interrupts after the transmission is
> +		 * complete */
> +		ier = in_be32(drvdata->base_address + XPS2_IPIER_OFFSET);
> +		ier &= (~(XPS2_IPIXR_TX_ACK & XPS2_IPIXR_ALL ));
> +		out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, ier);
> +		drvdata->dfl = 0;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*******************/
> +/* serio callbacks */
> +/*******************/
> +
> +/*
> + * sxps2_write() sends a byte out through the PS/2 interface.
> + *
> + * The sole purpose of drvdata->tx_end is to prevent the driver
> + * from locking up in the do {} while; loop when nothing is connected
> + * to the given PS/2 port. That's why we do not try to recover
> + * from the transmission failure.
> + * drvdata->tx_end needs not to be initialized to some "far in the
> + * future" value, as the very first attempt to xps2_send() a byte
> + * is always successful, and drvdata->tx_end will be set to a proper
> + * value at that moment - before the 1st use in the comparison.
> + */

Good comment block.

nitpick: can you reformat the comment blocks to be in kerneldoc format?
That will allow the automatic document generation tools to parse it.

see: Documentation/kernel-doc-nano-HOWTO.txt

> +static int sxps2_write(struct serio *pserio, unsigned char c)
> +{
> +	struct xps2data *drvdata = pserio->port_data;
> +	unsigned long flags;
> +	int retval;
> +
> +	do {
> +		spin_lock_irqsave(&drvdata->lock, flags);
> +		retval = xps2_send(drvdata, &c);
> +		spin_unlock_irqrestore(&drvdata->lock, flags);
> +
> +		if (retval == 1) {
> +			drvdata->tx_end = jiffies + HZ;
> +			return 0;	/* success */
> +		}
> +	} while (!time_after(jiffies, drvdata->tx_end));
> +
> +	return 1;			/* transmission is frozen */
> +}
> +
> +/*
> + * sxps2_open() is called when a port is open by the higher layer.
> + */
> +static int sxps2_open(struct serio *pserio)
> +{
> +	struct xps2data *drvdata = pserio->port_data;
> +	int retval;
> +
> +	retval = request_irq(drvdata->irq, &xps2_interrupt, 0,
> +				DRIVER_NAME, drvdata);
> +	if (retval) {
> +		printk(KERN_ERR
> +			"%s: Couldn't allocate interrupt %d\n",
> +			drvdata->serio.name, drvdata->irq);
> +		return retval;
> +	}
> +
> +	/* start reception by enabling the interrupts */
> +	out_be32(drvdata->base_address + XPS2_GIER_OFFSET, XPS2_GIER_GIE_MASK);
> +	out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, XPS2_IPIXR_RX_ALL);
> +	(void)xps2_recv(drvdata, &drvdata->rxb);
> +
> +	return 0;		/* success */
> +}
> +
> +/*
> + * sxps2_close() frees the interrupt.
> + */
> +static void sxps2_close(struct serio *pserio)
> +{
> +	struct xps2data *drvdata = pserio->port_data;
> +
> +	/* Disable the PS2 interrupts */
> +	out_be32(drvdata->base_address + XPS2_GIER_OFFSET, 0x00);
> +	out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, 0x00);
> +	free_irq(drvdata->irq, drvdata);
> +}
> +
> +/*************************/
> +/* XPS PS/2 driver calls */
> +/*************************/
> +
> +/*
> + * xps2_initialize() initializes the Xilinx PS/2 device.
> + */
> +static int xps2_initialize(struct xps2data *drvdata)
> +{
> +	/* Disable all the interrupts just in case */
> +	out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, 0);
> +
> +	/* Reset the PS2 device and abort any current transaction, to make sure
> +	 * we have the PS2 in a good state */
> +	out_be32(drvdata->base_address + XPS2_SRST_OFFSET, XPS2_SRST_RESET);
> +
> +	return 0;
> +}
> +
> +/*
> + * xps2_send() sends the specified byte of data to the PS/2 port in interrupt
> + * mode.
> + */
> +static u8 xps2_send(struct xps2data *drvdata, u8 *byte)
> +{
> +	u32 sr;
> +	u32 ier;
> +	u8 retval = 0;
> +
> +	/* Enter a critical region by disabling the PS/2 transmit interrupts to
> +	 * allow this call to stop a previous operation that may be interrupt
> +	 * driven. Only stop the transmit interrupt since this critical region
> +	 * is not really exited in the normal manner */
> +	ier = in_be32(drvdata->base_address + XPS2_IPIER_OFFSET);
> +	ier &= (~(XPS2_IPIXR_TX_ALL & XPS2_IPIXR_ALL ));
> +	out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, ier);
> +
> +	/* If the PS/2 transmitter is empty send a byte of data */
> +	sr = in_be32(drvdata->base_address + XPS2_STATUS_OFFSET);
> +	if ((sr & XPS2_STATUS_TX_FULL) == 0) {
> +		out_be32(drvdata->base_address + XPS2_TX_DATA_OFFSET, *byte);
> +		retval = 1;
> +	}
> +
> +	/* Enable the TX interrupts to track the status of the transmission */
> +	ier = in_be32(drvdata->base_address + XPS2_IPIER_OFFSET);
> +	ier |= ((XPS2_IPIXR_TX_ALL | XPS2_IPIXR_WDT_TOUT ));
> +	out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, ier);
> +
> +	return retval;		/* no. of bytes sent */
> +}
> +
> +/*
> + * xps2_recv() will attempt to receive a byte of data from the PS/2 port.
> + */
> +static u8 xps2_recv(struct xps2data *drvdata, u8 *byte)
> +{
> +	u32 sr;
> +	u8 retval = 0;
> +
> +	/* If there is data available in the PS/2 receiver, read it */
> +	sr = in_be32(drvdata->base_address + XPS2_STATUS_OFFSET);
> +	if (sr & XPS2_STATUS_RX_FULL) {
> +		*byte = in_be32(drvdata->base_address + XPS2_RX_DATA_OFFSET);
> +		retval = 1;
> +	}
> +
> +	return retval;		/* no. of bytes received */
> +}

Since xps2_recv() and xps2_send() are used by the sxps2_* routines and
by the irq handler, they should be moved to about them in this file.

> +
> +/******************************/
> +/* The platform device driver */
> +/******************************/
You can drop the platform driver bindings for inclusion in mainline.

<snip>

> +static struct device_driver xps2_driver = {
> +	.name = DRIVER_NAME,
> +	.bus = &platform_bus_type,
> +	.probe = xps2_probe,
> +	.remove = xps2_remove
> +};

This is platform bus stuff that will disappear anyway, but I'm going to
make a comment here regardless.  When registering a platform bus device
driver, you should use 'struct platform_driver' instead of 'struct
device_driver', and it should be registered with
platform_driver_register().

> new file mode 100644
> index 0000000..4db73ca
> --- /dev/null
> +++ b/drivers/input/serio/xilinx_ps2.h
> @@ -0,0 +1,97 @@
> +/*****************************************************************************
> + *
> + *     Author: Xilinx, Inc.
> + *
> + *     This program is free software; you can redistribute it and/or modify it
> + *     under the terms of the GNU General Public License as published by the
> + *     Free Software Foundation; either version 2 of the License, or (at your
> + *     option) any later version.
> + *
> + *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
> + *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
> + *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
> + *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
> + *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
> + *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
> + *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
> + *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
> + *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
> + *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
> + *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
> + *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + *     FOR A PARTICULAR PURPOSE.

Please drop this.

<snip>
> +
> +static u8 xps2_send(struct xps2data *drvdata, u8 *buffer_ptr);
> +static u8 xps2_recv(struct xps2data *drvdata, u8 *buffer_ptr);
> +static int xps2_initialize(struct xps2data *drvdata);
> +static int xps2_setup(struct device *dev, int id, struct resource *regs_res,
> +		      struct resource *irq_res);

These can be removed by reorganizing the .c file so that callees are
always above the caller.

Nice driver.

Cheers,
g.

Return-Path: <John.Linn@xilinx.com>
Received: from mail60-va3-R.bigfish.com (mail-va3.bigfish.com [216.32.180.112])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2BE7DE8E6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 02:38:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] [V3] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Date: Wed, 9 Jul 2008 10:14:06 -0600
In-Reply-To: <878wwcsqcm.fsf@macbook.be.48ers.dk>
References: <20080707153850.4C83B128005C@mail53-wa4.bigfish.com>
	<878wwcsqcm.fsf@macbook.be.48ers.dk>
From: "John Linn" <John.Linn@xilinx.com>
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Message-Id: <20080709161408.55E0F4A006C@mail60-va3.bigfish.com>
Cc: Sadanand Mutyala <sadanan@xilinx.com>, dmitry.torokhov@gmail.com,
	linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These look like good comments from Peter.

Dmitry, how would you like to do this, would you prefer us to do an
incremental patch from the existing patch (V3)?  Or a new V4 for the
patch?

Peter, with regard to the data sheet, I would prefer not to put a
specific URL in as things always seem to get moved around so anything
beyond xilinx.com would likely be wrong sometime in the future.

Thanks,
John

> -----Original Message-----
> From: Peter Korsgaard [mailto:jacmet@gmail.com] On Behalf Of Peter
Korsgaard
> Sent: Tuesday, July 08, 2008 3:00 AM
> To: John Linn
> Cc: linuxppc-dev@ozlabs.org; linux-input@vger.kernel.org;
grant.likely@secretlab.ca;
> jwboyer@linux.vnet.ibm.com; dmitry.torokhov@gmail.com; Sadanand
Mutyala
> Subject: Re: [PATCH] [V3] powerpc: Xilinx: PS2: Added new XPS PS2
driver
> =

> >>>>> "John" =3D=3D John Linn <john.linn@xilinx.com> writes:
> =

> Hi,
> =

>  > Added a new driver for Xilinx XPS PS2 IP. This driver is
>  > a flat driver to better match the Linux driver pattern.
> =

>  > Signed-off-by: Sadanand <sadanan@xilinx.com>
>  > Signed-off-by: John Linn <john.linn@xilinx.com>
>  > ---
>  > V2
>  > 	Updated the driver based on feedback from Dmitry, Peter, and
Grant.
>  > 	We believe Montavista copyright is still valid.
>  > V3
>  > 	Incorporated Dmitry and Grant's 2nd set of comments which were
some
>  > 	minor cleanup and removal of the mutex which was not needed.
> =

>  >  drivers/input/serio/Kconfig      |    5 +
>  >  drivers/input/serio/Makefile     |    1 +
>  >  drivers/input/serio/xilinx_ps2.c |  384
++++++++++++++++++++++++++++++++++++++
>  >  3 files changed, 390 insertions(+), 0 deletions(-)
>  >  create mode 100644 drivers/input/serio/xilinx_ps2.c
> =

>  > diff --git a/drivers/input/serio/Kconfig
b/drivers/input/serio/Kconfig
>  > index ec4b661..0e62b39 100644
>  > --- a/drivers/input/serio/Kconfig
>  > +++ b/drivers/input/serio/Kconfig
>  > @@ -190,4 +190,9 @@ config SERIO_RAW
>  >  	  To compile this driver as a module, choose M here: the
>  >  	  module will be called serio_raw.
> =

>  > +config SERIO_XILINX_XPS_PS2
>  > +	tristate "Xilinx XPS PS/2 Controller Support"
>  > +	help
>  > +	  This driver supports XPS PS/2 IP from Xilinx EDK.
>  > +
>  >  endif
>  > diff --git a/drivers/input/serio/Makefile
b/drivers/input/serio/Makefile
>  > index 38b8868..9b6c813 100644
>  > --- a/drivers/input/serio/Makefile
>  > +++ b/drivers/input/serio/Makefile
>  > @@ -21,3 +21,4 @@ obj-$(CONFIG_SERIO_PCIPS2)	+=3D pcips2.o
>  >  obj-$(CONFIG_SERIO_MACEPS2)	+=3D maceps2.o
>  >  obj-$(CONFIG_SERIO_LIBPS2)	+=3D libps2.o
>  >  obj-$(CONFIG_SERIO_RAW)		+=3D serio_raw.o
>  > +obj-$(CONFIG_SERIO_XILINX_XPS_PS2)	+=3D xilinx_ps2.o
>  > diff --git a/drivers/input/serio/xilinx_ps2.c
b/drivers/input/serio/xilinx_ps2.c
>  > new file mode 100644
>  > index 0000000..e86f11b
>  > --- /dev/null
>  > +++ b/drivers/input/serio/xilinx_ps2.c
>  > @@ -0,0 +1,384 @@
>  > +/*
>  > + * Xilinx XPS PS/2 device driver
>  > + *
>  > + * (c) 2005 MontaVista Software, Inc.
>  > + * (c) 2008 Xilinx, Inc.
>  > + *
>  > + * This program is free software; you can redistribute it and/or
modify it
>  > + * under the terms of the GNU General Public License as published
by the
>  > + * Free Software Foundation; either version 2 of the License, or
(at your
>  > + * option) any later version.
>  > + *
>  > + * You should have received a copy of the GNU General Public
License along
>  > + * with this program; if not, write to the Free Software
Foundation, Inc.,
>  > + * 675 Mass Ave, Cambridge, MA 02139, USA.
>  > + */
>  > +
>  > +
>  > +#include <linux/module.h>
>  > +#include <linux/serio.h>
>  > +#include <linux/interrupt.h>
>  > +#include <linux/errno.h>
>  > +#include <linux/init.h>
>  > +#include <linux/list.h>
>  > +#include <linux/io.h>
>  > +
>  > +#include <linux/of_device.h>
>  > +#include <linux/of_platform.h>
>  > +
>  > +#define DRIVER_NAME		"xilinx_ps2"
>  > +
> =

> Is there an online datasheet available somewhere on xilinx.com? (I
> couldn't find any right away) - If so, please add a link here.
> =

>  > +/* Register offsets for the xps2 device */
>  > +#define XPS2_SRST_OFFSET	0x00000000 /* Software Reset register */
>  > +#define XPS2_STATUS_OFFSET	0x00000004 /* Status register */
>  > +#define XPS2_RX_DATA_OFFSET	0x00000008 /* Receive Data
register */
>  > +#define XPS2_TX_DATA_OFFSET	0x0000000C /* Transmit Data
register */
>  > +#define XPS2_GIER_OFFSET	0x0000002C /* Global Interrupt Enable
reg */
>  > +#define XPS2_IPISR_OFFSET	0x00000030 /* Interrupt Status register
*/
>  > +#define XPS2_IPIER_OFFSET	0x00000038 /* Interrupt Enable register
*/
>  > +
>  > +/* Reset Register Bit Definitions */
>  > +#define XPS2_SRST_RESET		0x0000000A /* Software Reset  */
>  > +
>  > +/* Status Register Bit Positions */
>  > +#define XPS2_STATUS_RX_FULL	0x00000001 /* Receive Full  */
>  > +#define XPS2_STATUS_TX_FULL	0x00000002 /* Transmit Full  */
>  > +
>  > +/* Bit definitions for ISR/IER registers. Both the registers have
the same bit
>  > + * definitions and are only defined once. */
>  > +#define XPS2_IPIXR_WDT_TOUT	0x00000001 /* Watchdog Timeout
Interrupt */
>  > +#define XPS2_IPIXR_TX_NOACK	0x00000002 /* Transmit No ACK
Interrupt */
>  > +#define XPS2_IPIXR_TX_ACK	0x00000004 /* Transmit ACK (Data)
Interrupt */
>  > +#define XPS2_IPIXR_RX_OVF	0x00000008 /* Receive Overflow Interrupt
*/
>  > +#define XPS2_IPIXR_RX_ERR	0x00000010 /* Receive Error Interrupt */
>  > +#define XPS2_IPIXR_RX_FULL	0x00000020 /* Receive Data
Interrupt */
>  > +
>  > +/* Mask for all the Transmit Interrupts */
>  > +#define XPS2_IPIXR_TX_ALL	(XPS2_IPIXR_TX_NOACK |
XPS2_IPIXR_TX_ACK)
>  > +
>  > +/* Mask for all the Receive Interrupts */
>  > +#define XPS2_IPIXR_RX_ALL	(XPS2_IPIXR_RX_OVF | XPS2_IPIXR_RX_ERR |
\
>  > +					XPS2_IPIXR_RX_FULL)
>  > +
>  > +/* Mask for all the Interrupts */
>  > +#define XPS2_IPIXR_ALL		(XPS2_IPIXR_TX_ALL |
XPS2_IPIXR_RX_ALL |  \
>  > +					XPS2_IPIXR_WDT_TOUT)
>  > +
>  > +/* Global Interrupt Enable mask */
>  > +#define XPS2_GIER_GIE_MASK	0x80000000
>  > +
>  > +struct xps2data {
>  > +	int irq;
>  > +	u32 phys_addr;
>  > +	u32 remap_size;
> =

> Do you need to keep track of these? Couldn't you just do an
> of_address_to_resource in the remove to get them?  I guess they should
> be resource_size_t instead of u32s as well.
> =

> =

>  > +	spinlock_t lock;
>  > +	u8 rxb;				/* Rx buffer */
> =

> Why do you need this? It seems like you don't need to keep this value
> between interrupts.
> =

>  > +	void __iomem *base_address;	/* virt. address of control
registers */
>  > +	unsigned int dfl;
> =

> flags is maybe a better name. Do you need to keep track of it between
> interrupts?
> =

>  > +	struct serio serio;		/* serio */
>  > +};
>  > +
>  > +/************************************/
>  > +/* XPS PS/2 data transmission calls */
>  > +/************************************/
>  > +
>  > +/*
>  > + * xps2_recv() will attempt to receive a byte of data from the
PS/2 port.
>  > + */
>  > +static int xps2_recv(struct xps2data *drvdata, u8 *byte)
>  > +{
>  > +	u32 sr;
>  > +	int status =3D -1;
>  > +
>  > +	/* If there is data available in the PS/2 receiver, read it */
>  > +	sr =3D in_be32(drvdata->base_address + XPS2_STATUS_OFFSET);
>  > +	if (sr & XPS2_STATUS_RX_FULL) {
>  > +		*byte =3D in_be32(drvdata->base_address +
XPS2_RX_DATA_OFFSET);
>  > +		status =3D 0;
>  > +	}
>  > +
>  > +	return status;
>  > +}
>  > +
>  > +/*********************/
>  > +/* Interrupt handler */
>  > +/*********************/
>  > +static irqreturn_t xps2_interrupt(int irq, void *dev_id)
>  > +{
>  > +	struct xps2data *drvdata =3D (struct xps2data *)dev_id;
> =

> The cast isn't needed.
> =

>  > +	u32 intr_sr;
>  > +	u8 c;
>  > +	int status;
>  > +
>  > +	/* Get the PS/2 interrupts and clear them */
>  > +	intr_sr =3D in_be32(drvdata->base_address + XPS2_IPISR_OFFSET);
>  > +	out_be32(drvdata->base_address + XPS2_IPISR_OFFSET, intr_sr);
>  > +
>  > +	/* Check which interrupt is active */
>  > +	if (intr_sr & XPS2_IPIXR_RX_OVF) {
>  > +		printk(KERN_ERR "%s: receive overrun error\n",
>  > +			drvdata->serio.name);
>  > +	}
>  > +
>  > +	if (intr_sr & XPS2_IPIXR_RX_ERR)
>  > +		drvdata->dfl |=3D SERIO_PARITY;
>  > +
>  > +	if (intr_sr & (XPS2_IPIXR_TX_NOACK | XPS2_IPIXR_WDT_TOUT))
>  > +		drvdata->dfl |=3D SERIO_TIMEOUT;
>  > +
>  > +	if (intr_sr & XPS2_IPIXR_RX_FULL) {
>  > +		status =3D xps2_recv(drvdata, &drvdata->rxb);
>  > +
>  > +		/* Error, if a byte is not received */
>  > +		if (status) {
>  > +			printk(KERN_ERR
>  > +				"%s: wrong rcvd byte count (%d)\n",
>  > +				drvdata->serio.name, status);
>  > +		} else {
>  > +			c =3D drvdata->rxb;
>  > +			serio_interrupt(&drvdata->serio, c,
drvdata->dfl);
>  > +			drvdata->dfl =3D 0;
>  > +		}
>  > +	}
>  > +
>  > +	if (intr_sr & XPS2_IPIXR_TX_ACK)
>  > +		drvdata->dfl =3D 0;
>  > +
>  > +	return IRQ_HANDLED;
>  > +}
>  > +
>  > +/*******************/
>  > +/* serio callbacks */
>  > +/*******************/
>  > +
>  > +/*
>  > + * sxps2_write() sends a byte out through the PS/2 interface.
>  > + */
>  > +static int sxps2_write(struct serio *pserio, unsigned char c)
>  > +{
>  > +	struct xps2data *drvdata =3D pserio->port_data;
>  > +	unsigned long flags;
>  > +	u32 sr;
>  > +	int status =3D -1;
>  > +
>  > +	spin_lock_irqsave(&drvdata->lock, flags);
>  > +	/* If the PS/2 transmitter is empty send a byte of data */
>  > +	sr =3D in_be32(drvdata->base_address + XPS2_STATUS_OFFSET);
>  > +	if ((sr & XPS2_STATUS_TX_FULL) =3D=3D 0) {
>  > +		out_be32(drvdata->base_address + XPS2_TX_DATA_OFFSET,
c);
>  > +		status =3D 0;
>  > +	}
>  > +	spin_unlock_irqrestore(&drvdata->lock, flags);
>  > +
>  > +	return status;
>  > +}
>  > +
>  > +/*
>  > + * sxps2_open() is called when a port is open by the higher layer.
> =

> s/open/opened/
> =

>  > + */
>  > +static int sxps2_open(struct serio *pserio)
>  > +{
>  > +	struct xps2data *drvdata =3D pserio->port_data;
>  > +	int retval;
>  > +
>  > +	retval =3D request_irq(drvdata->irq, &xps2_interrupt, 0,
>  > +				DRIVER_NAME, drvdata);
>  > +	if (retval) {
>  > +		printk(KERN_ERR
>  > +			"%s: Couldn't allocate interrupt %d\n",
>  > +			drvdata->serio.name, drvdata->irq);
> =

> please use dev_err here and elsewhere.
> =

>  > +		return retval;
>  > +	}
>  > +
>  > +	/* start reception by enabling the interrupts */
>  > +	out_be32(drvdata->base_address + XPS2_GIER_OFFSET,
XPS2_GIER_GIE_MASK);
>  > +	out_be32(drvdata->base_address + XPS2_IPIER_OFFSET,
XPS2_IPIXR_RX_ALL);
>  > +	(void)xps2_recv(drvdata, &drvdata->rxb);
>  > +
>  > +	return 0;		/* success */
>  > +}
>  > +
>  > +/*
>  > + * sxps2_close() frees the interrupt.
>  > + */
>  > +static void sxps2_close(struct serio *pserio)
>  > +{
>  > +	struct xps2data *drvdata =3D pserio->port_data;
>  > +
>  > +	/* Disable the PS2 interrupts */
>  > +	out_be32(drvdata->base_address + XPS2_GIER_OFFSET, 0x00);
>  > +	out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, 0x00);
>  > +	free_irq(drvdata->irq, drvdata);
>  > +}
>  > +
>  > +/*********************/
>  > +/* Device setup code */
>  > +/*********************/
>  > +
>  > +static int xps2_setup(struct device *dev, struct resource
*regs_res,
>  > +		      struct resource *irq_res)
>  > +{
> =

> Why not just merge this with the of_ code now that you only have a
> single user of it?
> =

>  > +	struct xps2data *drvdata;
>  > +	struct serio *serio;
>  > +	unsigned long remap_size;
>  > +	int retval;
>  > +
>  > +	if (!dev)
>  > +		return -EINVAL;
>  > +
>  > +	drvdata =3D kzalloc(sizeof(struct xps2data), GFP_KERNEL);
>  > +	if (!drvdata) {
>  > +		dev_err(dev, "Couldn't allocate device private
record\n");
>  > +		return -ENOMEM;
>  > +	}
>  > +	spin_lock_init(&drvdata->lock);
>  > +	dev_set_drvdata(dev, drvdata);
>  > +
>  > +	if (!regs_res || !irq_res) {
>  > +		dev_err(dev, "IO resource(s) not found\n");
>  > +		retval =3D -EFAULT;
>  > +		goto failed1;
>  > +	}
>  > +
>  > +	drvdata->irq =3D irq_res->start;
>  > +	remap_size =3D regs_res->end - regs_res->start + 1;
>  > +	if (!request_mem_region(regs_res->start, remap_size,
DRIVER_NAME)) {
>  > +
>  > +		dev_err(dev, "Couldn't lock memory region at 0x%08X\n",
>  > +			(unsigned int)regs_res->start);
>  > +		retval =3D -EBUSY;
>  > +		goto failed1;
>  > +	}
>  > +
>  > +	/* Fill in configuration data and add them to the list */
>  > +	drvdata->phys_addr =3D regs_res->start;
>  > +	drvdata->remap_size =3D remap_size;
>  > +	drvdata->base_address =3D ioremap(regs_res->start, remap_size);
>  > +	if (drvdata->base_address =3D=3D NULL) {
>  > +
>  > +		dev_err(dev, "Couldn't ioremap memory at 0x%08X\n",
>  > +			(unsigned int)regs_res->start);
>  > +		retval =3D -EFAULT;
>  > +		goto failed2;
>  > +	}
>  > +
>  > +	/* Disable all the interrupts, just in case */
>  > +	out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, 0);
>  > +
>  > +	/* Reset the PS2 device and abort any current transaction, to
make sure
>  > +	 * we have the PS2 in a good state */
>  > +	out_be32(drvdata->base_address + XPS2_SRST_OFFSET,
XPS2_SRST_RESET);
>  > +
>  > +	dev_info(dev, "Xilinx PS2 at 0x%08X mapped to 0x%08X, irq=3D%d\n",
>  > +		drvdata->phys_addr, (u32)drvdata->base_address,
drvdata->irq);
>  > +
>  > +	serio =3D &drvdata->serio;
>  > +	serio->id.type =3D SERIO_8042;
>  > +	serio->write =3D sxps2_write;
>  > +	serio->open =3D sxps2_open;
>  > +	serio->close =3D sxps2_close;
>  > +	serio->port_data =3D drvdata;
>  > +	serio->dev.parent =3D dev;
>  > +	snprintf(drvdata->serio.name, sizeof(serio->name),
>  > +		 "Xilinx XPS PS/2 at %08X", drvdata->phys_addr);
>  > +	snprintf(drvdata->serio.phys, sizeof(serio->phys),
>  > +		 "xilinxps2/serio at %08X", drvdata->phys_addr);
>  > +	serio_register_port(serio);
>  > +
>  > +	return 0;		/* success */
>  > +
>  > +failed2:
>  > +	release_mem_region(regs_res->start, remap_size);
>  > +
>  > +failed1:
>  > +	kfree(drvdata);
>  > +	dev_set_drvdata(dev, NULL);
>  > +
>  > +	return retval;
>  > +}
>  > +
>  > +/***************************/
>  > +/* OF Platform Bus Support */
>  > +/***************************/
>  > +
>  > +static int __devinit xps2_of_probe(struct of_device *ofdev, const
struct
>  > +				   of_device_id * match)
>  > +{
>  > +	struct resource r_irq; /* Interrupt resources */
>  > +	struct resource r_mem; /* IO mem resources */
>  > +	int rc =3D 0;
>  > +
>  > +	printk(KERN_INFO "Device Tree Probing \'%s\'\n",
>  > +			ofdev->node->name);
>  > +
>  > +	/* Get iospace for the device */
>  > +	rc =3D of_address_to_resource(ofdev->node, 0, &r_mem);
>  > +	if (rc) {
>  > +		dev_err(&ofdev->dev, "invalid address\n");
>  > +		return rc;
>  > +	}
>  > +
>  > +	/* Get IRQ for the device */
>  > +	rc =3D of_irq_to_resource(ofdev->node, 0, &r_irq);
>  > +	if (rc =3D=3D NO_IRQ) {
>  > +		dev_err(&ofdev->dev, "no IRQ found\n");
>  > +		return rc;
>  > +	}
>  > +
>  > +	return xps2_setup(&ofdev->dev, &r_mem, &r_irq);
>  > +}
>  > +
>  > +static int __devexit xps2_of_remove(struct of_device *of_dev)
>  > +{
>  > +	struct xps2data *drvdata;
>  > +	struct device *dev;
>  > +
>  > +	dev =3D &of_dev->dev;
>  > +	if (!dev)
>  > +		return -EINVAL;
>  > +
>  > +	drvdata =3D (struct xps2data *)dev_get_drvdata(dev);
>  > +
>  > +	serio_unregister_port(&drvdata->serio);
>  > +
>  > +	iounmap(drvdata->base_address);
>  > +
>  > +	release_mem_region(drvdata->phys_addr, drvdata->remap_size);
>  > +
>  > +	kfree(drvdata);
>  > +	dev_set_drvdata(dev, NULL);
>  > +
>  > +	return 0;		/* success */
>  > +}
>  > +
>  > +/* Match table for of_platform binding */
>  > +static struct of_device_id xps2_of_match[] __devinitdata =3D {
>  > +	{ .compatible =3D "xlnx,xps-ps2-1.00.a", },
>  > +	{ /* end of list */ },
>  > +};
>  > +MODULE_DEVICE_TABLE(of, xps2_of_match);
>  > +
>  > +static struct of_platform_driver xps2_of_driver =3D {
>  > +	.name		=3D DRIVER_NAME,
>  > +	.match_table	=3D xps2_of_match,
>  > +	.probe		=3D xps2_of_probe,
>  > +	.remove		=3D __devexit_p(xps2_of_remove),
>  > +};
>  > +
>  > +static int __init xps2_init(void)
>  > +{
>  > +	return of_register_platform_driver(&xps2_of_driver);
>  > +}
>  > +
>  > +static void __exit xps2_cleanup(void)
>  > +{
>  > +	of_unregister_platform_driver(&xps2_of_driver);
>  > +}
>  > +
>  > +module_init(xps2_init);
>  > +module_exit(xps2_cleanup);
>  > +
>  > +MODULE_AUTHOR("Xilinx, Inc.");
>  > +MODULE_DESCRIPTION("Xilinx XPS PS/2 driver");
>  > +MODULE_LICENSE("GPL");
>  > +
>  > --
>  > 1.5.2.1
> =

> --
> Bye, Peter Korsgaard


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE005.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id AA5C1DE589
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 05:41:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Date: Mon, 30 Jun 2008 13:41:10 -0600
In-Reply-To: <87y74ndlsf.fsf@macbook.be.48ers.dk>
References: <20080630142451.516A41D1006C@mail57-sin.bigfish.com>
	<87y74ndlsf.fsf@macbook.be.48ers.dk>
From: John Linn <John.Linn@xilinx.com>
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Message-ID: <20080630194112.4F739CF004D@mail40-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Sadanand Mutyala <sadanan@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Peter, those make sense.  We'll incorporate those comments.

-----Original Message-----
From: Peter Korsgaard [mailto:jacmet@gmail.com] On Behalf Of Peter
Korsgaard
Sent: Monday, June 30, 2008 8:45 AM
To: John Linn
Cc: linuxppc-dev@ozlabs.org; Sadanand Mutyala
Subject: Re: [PATCH] powerpc: Xilinx: PS2: Added new XPS PS2 driver

>>>>> "John" =3D=3D John Linn <john.linn@xilinx.com> writes:

> > Added a new driver for Xilinx XPS PS2 IP. This driver is
> > a flat driver to better match the Linux driver pattern.
>
>This should probably go to the linux-input@ list as well.

Agreed, done.

>
> > Signed-off-by: Sadanand <sadanan@xilinx.com>
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> > ---
> >  drivers/input/serio/Kconfig      |    5 +
> >  drivers/input/serio/Makefile     |    1 +
> >  drivers/input/serio/xilinx_ps2.c |  464
++++++++++++++++++++++++++++++++++++++
> >  drivers/input/serio/xilinx_ps2.h |   97 ++++++++
> >  4 files changed, 567 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/input/serio/xilinx_ps2.c
> >  create mode 100644 drivers/input/serio/xilinx_ps2.h
>
> > diff --git a/drivers/input/serio/Kconfig
b/drivers/input/serio/Kconfig
> > index ec4b661..0e62b39 100644
> > --- a/drivers/input/serio/Kconfig
> > +++ b/drivers/input/serio/Kconfig
> > @@ -190,4 +190,9 @@ config SERIO_RAW
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called serio_raw.
> =

> > +config SERIO_XILINX_XPS_PS2
> > +	tristate "Xilinx XPS PS/2 Controller Support"
> > +	help
> > +	  This driver supports XPS PS/2 IP from Xilinx EDK.
> > +
> >  endif
> > diff --git a/drivers/input/serio/Makefile
b/drivers/input/serio/Makefile
> > index 38b8868..9b6c813 100644
> > --- a/drivers/input/serio/Makefile
> > +++ b/drivers/input/serio/Makefile
> > @@ -21,3 +21,4 @@ obj-$(CONFIG_SERIO_PCIPS2)	+=3D pcips2.o
> >  obj-$(CONFIG_SERIO_MACEPS2)	+=3D maceps2.o
> >  obj-$(CONFIG_SERIO_LIBPS2)	+=3D libps2.o
> >  obj-$(CONFIG_SERIO_RAW)		+=3D serio_raw.o
> > +obj-$(CONFIG_SERIO_XILINX_XPS_PS2)	+=3D xilinx_ps2.o
> > diff --git a/drivers/input/serio/xilinx_ps2.c
b/drivers/input/serio/xilinx_ps2.c
> > new file mode 100644
> > index 0000000..670d47f
> > --- /dev/null
> > +++ b/drivers/input/serio/xilinx_ps2.c
> > @@ -0,0 +1,464 @@
> > +/*
> > + * xilinx_ps2.c
> > + *
> > + * Xilinx PS/2 driver to interface PS/2 component to Linux
> > + *
> > + * Author: MontaVista Software, Inc.
> > + *	   source@mvista.com
> > + *
> > + * (c) 2005 MontaVista Software, Inc.
> > + * (c) 2008 Xilinx Inc.
> > + *
>
>Is the montavista stuff still valid?
>

We derived the driver from MontaVista code is the reason we left it in.
Since a significant part of the code was derived, I think we defaulted
to leave it in.

> > + * This program is free software; you can redistribute it and/or
modify it
> > + * under the terms of the GNU General Public License as published
by the
> > + * Free Software Foundation; either version 2 of the License, or
(at your
> > + * option) any later version.
> > + *
> > + * You should have received a copy of the GNU General Public
License along
> > + * with this program; if not, write to the Free Software
Foundation, Inc.,
> > + * 675 Mass Ave, Cambridge, MA 02139, USA.
> > + */
> > +
> > +
> > +#include <linux/module.h>
> > +#include <linux/serio.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/errno.h>
> > +#include <linux/init.h>
> > +#include <linux/list.h>
> > +#include <asm/io.h>
>
>linux/io.h please.
>

Done in v2.

> > +
> > +#ifdef CONFIG_OF		/* For open firmware */
>
>Why support !CONFIG_OF? =

>

Agreed, we just got in the habit.

> > + #include <linux/of_device.h>
> > + #include <linux/of_platform.h>
> > +#endif /* CONFIG_OF */
> > +
> > +#include "xilinx_ps2.h"
>
>Why the seperate header? You're the only user of it, right?
>

That's true, can be incorporated into the c file.

> > +
> > +#define DRIVER_NAME		"xilinx_ps2"
> > +#define DRIVER_DESCRIPTION	"Xilinx XPS PS/2 driver"
> > +
> > +#define XPS2_NAME_DESC		"Xilinx XPS PS/2 Port #%d"
> > +#define XPS2_PHYS_DESC		"xilinxps2/serio%d"
>
>Why have defines to stuff only used once?
>

Agreed, out of habit.

>...
>
> > +
> > +/******************************/
> > +/* The platform device driver */
> > +/******************************/
> > +
> > +static int xps2_probe(struct device *dev)
>
>__devinit please.
>

Agreed.

> > +{
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +
> > +	struct resource *irq_res =3D NULL;	/* Interrupt resources
*/
> > +	struct resource *regs_res =3D NULL;	/* IO mem resources */
> > +
> > +	if (!dev) {
> > +		dev_err(dev, "Probe called with NULL param\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Find irq number, map the control registers in */
> > +	irq_res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +	regs_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	return xps2_setup(dev, pdev->id, regs_res, irq_res);
> > +}
>
>...
>
> > +
> > +/*
> > + * xps2_remove() dissociates the driver with the Xilinx PS/2
device.
> > + */
> > +static int xps2_remove(struct device *dev)
>
>__devexit please.
>

Agreed.

> > +{
> > +	struct xps2data *drvdata;
> > +
> > +	if (!dev)
> > +		return -EINVAL;
> > +
> > +	drvdata =3D (struct xps2data *)dev_get_drvdata(dev);
> > +
> > +	serio_unregister_port(&drvdata->serio);
> > +
> > +	iounmap(drvdata->base_address);
> > +
> > +	release_mem_region(drvdata->phys_addr, drvdata->remap_size);
> > +
> > +	kfree(drvdata);
> > +	dev_set_drvdata(dev, NULL);
> > +
> > +	return 0;		/* success */
> > +}
> > +
> > +static struct device_driver xps2_driver =3D {
>
>Please use a real struct platform_driver instead.
>

Agreed, this will go away I think.

> > +	.name =3D DRIVER_NAME,
> > +	.bus =3D &platform_bus_type,
> > +	.probe =3D xps2_probe,
> > +	.remove =3D xps2_remove
> > +};
> > +
>
-- =

Bye, Peter Korsgaard



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

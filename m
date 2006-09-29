Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C3E2467C1B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 19:06:27 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8T96PUR028248
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Sep 2006 05:06:25 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8T96PUF540984
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Sep 2006 03:06:25 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8T96O61001560
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Sep 2006 03:06:24 -0600
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] IBM GPIO driver for PowerPC 4xx is back from the dead
Date: Fri, 29 Sep 2006 11:06:19 +0200
References: <1159518565.9269.1.camel@jb-portable>
In-Reply-To: <1159518565.9269.1.camel@jb-portable>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200609291106.20987.arnd.bergmann@de.ibm.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 29 September 2006 10:29, Jean-Baptiste Maneyrol wrote:
> diff -Naur linux-2.6.18_gpio/drivers/char/ibm_gpio.c tlgate_gpio/drivers/=
char/ibm_gpio.c
> --- linux-2.6.18_gpio/drivers/char/ibm_gpio.c=A0=A0=A01970-01-01 01:00:00=
=2E000000000 +0100
> +++ tlgate_gpio/drivers/char/ibm_gpio.c=A02006-09-28 16:46:42.000000000 +=
0200
> @@ -0,0 +1,349 @@
> +/*
> + * FILE NAME ibm_gpio.c

<insert usual comment about removing the file name from the file>

> + * BRIEF MODULE DESCRIPTION
> + * =A0API for IBM PowerPC 4xx GPIO device.
> + * =A0Driver for IBM PowerPC 4xx GPIO device.
> + *
> + * =A0Armin Kuster akuster@pacbell.net
> + * =A0Sept, 2001
> + *
> + * =A0Orignial driver
> + * =A0Author: MontaVista Software, Inc. =A0<source@mvista.com>
> + * =A0 =A0 =A0 =A0 =A0Frank Rowand <frank_rowand@mvista.com>
> + * =A0 =A0 =A0 =A0 =A0Debbie Chu =A0 <debbie_chu@mvista.com>
> + *
> + * Copyright 2000,2001,2002 MontaVista Software Inc.

Any new copyright year?


> + *=A0=A0=A0=A0=A0TODO: devfs

surely not.

> + *=A0=A0=A0=A0=A0Version: 02/01/12 - Armin
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conver=
ted to ocp and using ioremap
> + *
> + *=A0=A0=A0=A0=A01.2 02/21/01 - Armin
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0minor compiler warning fixes
> + *
> + *=A0=A0=A0=A0=A01.3 02/22/01 - Armin
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0added apm
> + *
> + *=A0=A0=A0=A0=A01.4 05/07/02 - Armin/David Mueller
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0coverted to core_ocp[];
> + *
> + *=A0=A0=A0=A0=A01.5 05/25/02 - Armin
> + *=A0=A0=A0=A0=A0 name change from *_driver to *_dev
> + *
> + *=A0=A0=A0=A0=A01.6 06/04/02 - Matt Porter
> + *=A0=A0=A0=A0=A0ioremap paddr. Comment as 4xx generic driver.
> + *=A0=A0=A0=A0=A0Fix header to be userland safe and locate in
> + *=A0=A0=A0=A0=A0an accessible area. =A0Add ioctl to configure
> + *=A0=A0=A0=A0=A0multiplexed GPIO pins.
> + *
> + *=A0=A0=A0=A0=A01.7 07/25/02 - Armin
> + *=A0=A0=A0=A0=A0added CPM to enable/disable in init/exit

kill that changelog

> + */
> +
> +#define VUFX "07.25.02"

should be MODULE_VERSION()

> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/miscdevice.h>
> +#include <linux/init.h>
> +#include <linux/ioctl.h>
> +#include <linux/fs.h>
> +#include <asm/ibm_gpio.h>
> +#include <asm/uaccess.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/ocp.h>
> +#include <asm/ibm4xx.h>
> +
> +struct miscdevice ibm_gpio_miscdev;
> +static struct gpio_regs *gpiop;
> +
> +int
> +ibm_gpio_config(__u32 device, __u32 mask, __u32 data)

any symbols should be static. Function arguments are not
visible to users, so they should be 'u32' instead of '__u32'.

> +{
> +=A0=A0=A0=A0=A0=A0=A0u32 cfg_reg;
> +
> +=A0=A0=A0=A0=A0=A0=A0if (device !=3D 0)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENXIO;
> +
> +#ifdef CONFIG_40x
> +#ifdef DCRN_CHCR0
> +=A0=A0=A0=A0=A0=A0=A0/*
> +=A0=A0=A0=A0=A0=A0=A0 * PPC405 uses CPC0_CR0 to select multiplexed GPIO =
pins.
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0cfg_reg =3D mfdcr(DCRN_CHCR0);
> +=A0=A0=A0=A0=A0=A0=A0cfg_reg =3D (cfg_reg & ~mask) | (data & mask);
> +=A0=A0=A0=A0=A0=A0=A0mtdcr(DCRN_CHCR0, cfg_reg);
> +#endif
> +#elif CONFIG_440GP
> +=A0=A0=A0=A0=A0=A0=A0/*
> +=A0=A0=A0=A0=A0=A0=A0 * PPC440GP uses CPC0_GPIO to select multiplexed GP=
IO pins.
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0cfg_reg =3D mfdcr(DCRN_CPC0_GPIO);
> +=A0=A0=A0=A0=A0=A0=A0cfg_reg =3D (cfg_reg & ~mask) | (data & mask);
> +=A0=A0=A0=A0=A0=A0=A0mtdcr(DCRN_CPC0_GPIO, cfg_reg);
> +#elif CONFIG_440GX
> +=A0=A0=A0=A0=A0=A0=A0/*
> +=A0=A0=A0=A0=A0=A0=A0 * PPC440GX uses SDR0_PFC0 to select multiplexed GP=
IO pins
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0cfg_reg =3D SDR_READ(DCRN_SDR_PFC0);
> +=A0=A0=A0=A0=A0=A0=A0cfg_reg =3D (cfg_reg & ~mask) | (data & mask);
> +=A0=A0=A0=A0=A0=A0=A0SDR_WRITE(DCRN_SDR_PFC0, cfg_reg);
> +#else
> +#error This driver is only supported on PPC40x and PPC440 CPUs
> +#endif

This prevents building a single kernel for multiple 440 version.
Please use a run-time check, or better get the necessary information
from the device tree.

> +int
> +ibm_gpio_in(__u32 device, __u32 mask, volatile __u32 * data)
> +{
> +=A0=A0=A0=A0=A0=A0=A0if (device !=3D 0)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENXIO;
> +=A0=A0=A0=A0=A0=A0=A0gpiop->tcr =3D gpiop->tcr & ~mask;
> +=A0=A0=A0=A0=A0=A0=A0eieio();
> +
> +=A0=A0=A0=A0=A0=A0=A0/*
> +=A0=A0=A0=A0=A0=A0=A0 =A0 ** If the previous state was OUT, and gpiop->i=
r is read once, then the
> +=A0=A0=A0=A0=A0=A0=A0 =A0 ** data that was being OUTput will be read. =
=A0One way to get the right
> +=A0=A0=A0=A0=A0=A0=A0 =A0 ** data is to read gpiop->ir twice.
> +=A0=A0=A0=A0=A0=A0=A0 */
> +
> +=A0=A0=A0=A0=A0=A0=A0*data =3D gpiop->ir;
> +=A0=A0=A0=A0=A0=A0=A0*data =3D gpiop->ir & mask;
> +=A0=A0=A0=A0=A0=A0=A0eieio();
> +=A0=A0=A0=A0=A0=A0=A0return 0;
> +}

Don't just assign *data, make that an __iomem pointer and use
an appropriate accessor function (out_be32 or such).


> +
> +static int
> +ibm_gpio_open(struct inode *inode, struct file *file)
> +{
> +=A0=A0=A0=A0=A0=A0=A0return 0;
> +}
> +
> +static int
> +ibm_gpio_release(struct inode *inode, struct file *file)
> +{
> +=A0=A0=A0=A0=A0=A0=A0return 0;
> +}

You don't need these.


> +static int
> +ibm_gpio_ioctl(struct inode *inode, struct file *file,
> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 unsigned int cmd, unsigned long arg)
> +{
> +=A0=A0=A0=A0=A0=A0=A0static struct ibm_gpio_ioctl_data ioctl_data;
> +=A0=A0=A0=A0=A0=A0=A0int status;
> +
> +=A0=A0=A0=A0=A0=A0=A0switch (cmd) {
> +=A0=A0=A0=A0=A0=A0=A0case IBMGPIO_IN:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (copy_from_user(&ioctl_d=
ata,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0 (struct ibm_gpio_ioctl_data *) arg,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0 sizeof (ioctl_data))) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret=
urn -EFAULT;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}

Just do the copy_from_user() once, in the beginning here, instead
of each case.
> +
> +static int __init
> +ibm_gpio_probe(struct ocp_device *ocp)
> +{
> +=A0=A0=A0=A0=A0=A0=A0ibm_gpio_miscdev.minor =3D GPIO_MINOR;
> +=A0=A0=A0=A0=A0=A0=A0ibm_gpio_miscdev.name =3D ocp->name;
> +=A0=A0=A0=A0=A0=A0=A0ibm_gpio_miscdev.fops =3D &ibm_gpio_fops;
> +=A0=A0=A0=A0=A0=A0=A0misc_register(&ibm_gpio_miscdev);
> +
> +=A0=A0=A0=A0=A0=A0=A0if (!request_mem_region(ocp->def->paddr, sizeof(str=
uct gpio_regs), "ibm_gpio"))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EBUSY;
> +=A0=A0=A0=A0=A0=A0=A0
> +=A0=A0=A0=A0=A0=A0=A0gpiop =3D (struct gpio_regs *) ioremap(ocp->def->pa=
ddr,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0siz=
eof(struct gpio_regs));
> +=A0=A0=A0=A0=A0=A0=A0if (!gpiop) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0release_mem_region(ocp->def=
=2D>paddr, sizeof(struct gpio_regs));
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENOMEM;
> +=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0
> +=A0=A0=A0=A0=A0=A0=A0printk("GPIO #%d at 0x%lx\n", ocp->def->index,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(un=
signed long) gpiop);
> +
> +=A0=A0=A0=A0=A0=A0=A0return 0;
> +}
> +
> +static void __exit
> +ibm_gpio_remove(struct ocp_device *ocp)
> +{
> +=A0=A0=A0=A0=A0=A0=A0misc_deregister(&ibm_gpio_miscdev);
> +
> +=A0=A0=A0=A0=A0=A0=A0iounmap(gpiop);
> +=A0=A0=A0=A0=A0=A0=A0gpiop =3D NULL;
> +=A0=A0=A0=A0=A0=A0=A0
> +=A0=A0=A0=A0=A0=A0=A0release_mem_region(ocp->def->paddr, sizeof(struct g=
pio_regs));
> +}
> +
> +static struct ocp_device_id ibm_gpio_ids[] __devinitdata =3D
> +{
> +=A0=A0=A0=A0=A0=A0=A0{ .vendor =3D OCP_VENDOR_IBM, .function =3D OCP_FUN=
C_GPIO },
> +=A0=A0=A0=A0=A0=A0=A0{ .vendor =3D OCP_VENDOR_INVALID }
> +};
> +
> +MODULE_DEVICE_TABLE(ocp, ibm_gpio_ids);
> +
> +static struct ocp_driver ibm_gpio_driver =3D
> +{
> +=A0=A0=A0=A0=A0=A0=A0.name =A0 =A0 =A0 =A0 =A0 =3D "ibm_gpio",
> +=A0=A0=A0=A0=A0=A0=A0.id_table =A0 =A0 =A0 =3D ibm_gpio_ids,
> +=A0=A0=A0=A0=A0=A0=A0.probe =A0 =A0 =A0 =A0 =A0=3D ibm_gpio_probe,
> +=A0=A0=A0=A0=A0=A0=A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(ibm_gpio_re=
move),
> +#if defined(CONFIG_PM)
> +=A0=A0=A0=A0=A0=A0=A0.suspend =A0 =A0 =A0 =A0=3D NULL,
> +=A0=A0=A0=A0=A0=A0=A0.resume =A0 =A0 =A0 =A0 =3D NULL,
> +#endif
> +};
> +
> +static int __init
> +ibm_gpio_init(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0printk("IBM GPIO driver version %s\n", VUFX);
> +=A0=A0=A0=A0=A0=A0=A0return ocp_register_driver(&ibm_gpio_driver);
> +}
> +
> +static void __exit
> +ibm_gpio_exit(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0ocp_unregister_driver(&ibm_gpio_driver);
> +}

ocp will die a painful death soon, when 440 has been converted over
to use the device tree and of_device.

> +EXPORT_SYMBOL(ibm_gpio_tristate);
> +EXPORT_SYMBOL(ibm_gpio_open_drain);
> +EXPORT_SYMBOL(ibm_gpio_in);
> +EXPORT_SYMBOL(ibm_gpio_out);

Why export these at all? They don't seem to be used elsewhere?

If you need to export them, make it EXPORT_SYMBOL_GPL and put that
line directly under the functions.

> +
> +struct ibm_gpio_ioctl_data {
> + =A0 =A0 =A0 =A0__u32 device;
> + =A0 =A0 =A0 =A0__u32 mask;
> + =A0 =A0 =A0 =A0__u32 data;
> +};
> +
> +#define IBMGPIO_IOCTL_BASE=A0=A0=A0=A0=A0'Z'
> +
> +#define IBMGPIO_IN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0_IOWR(IBMGPIO_I=
OCTL_BASE, 0, struct ibm_gpio_ioctl_data)
> +#define IBMGPIO_OUT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0_IOW (IBMGPIO_IOC=
TL_BASE, 1, struct ibm_gpio_ioctl_data)
> +#define IBMGPIO_OPEN_DRAIN=A0=A0=A0=A0=A0_IOW (IBMGPIO_IOCTL_BASE, 2, st=
ruct ibm_gpio_ioctl_data)
> +#define IBMGPIO_TRISTATE=A0=A0=A0=A0=A0=A0=A0_IOW (IBMGPIO_IOCTL_BASE, 3=
, struct ibm_gpio_ioctl_data)
> +#define IBMGPIO_CFG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0_IOW (IBMGPIO_IOC=
TL_BASE, 4, struct ibm_gpio_ioctl_data)

Is that the same ioctl interface as for the other gpio drivers?

> +#endif

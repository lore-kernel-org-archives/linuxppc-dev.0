Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.224])
	by ozlabs.org (Postfix) with ESMTP id 0E0F0DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 06:25:52 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so176276wxd.15
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 13:25:49 -0700 (PDT)
Message-ID: <fa686aa40804291325m3d97a66em2407f967e05dc980@mail.gmail.com>
Date: Tue, 29 Apr 2008 14:25:49 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [patch v11 2/4] USB: add Cypress c67x00 OTG controller core driver
In-Reply-To: <20080427070231.764077242@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080427065942.514492739@sunsite.dk>
	<20080427070231.764077242@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	linux-usb@vger.kernel.org, greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 27, 2008 at 12:59 AM, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> This patch add the core driver for the c67x00 USB OTG controller.  The core
>  driver is responsible for the platform bus binding and creating either
>  USB HCD or USB Gadget instances for each of the serial interface engines
>  on the chip.
>
>  This driver does not directly implement the HCD or gadget behaviours; it
>  just controls access to the chip.
>
>  Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
>  Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Grant Likely <grant.likely@secretlab.ca>


>  ---
>   MAINTAINERS                     |    6 +
>   drivers/usb/c67x00/c67x00-drv.c |  230 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/usb/c67x00.h      |   48 ++++++++
>   3 files changed, 284 insertions(+)
>
>  Index: linux-2.6/drivers/usb/c67x00/c67x00-drv.c
>  ===================================================================
>  --- /dev/null
>  +++ linux-2.6/drivers/usb/c67x00/c67x00-drv.c
>  @@ -0,0 +1,230 @@
>  +/*
>  + * c67x00-drv.c: Cypress C67X00 USB Common infrastructure
>  + *
>  + * Copyright (C) 2006-2008 Barco N.V.
>  + *    Derived from the Cypress cy7c67200/300 ezusb linux driver and
>  + *    based on multiple host controller drivers inside the linux kernel.
>  + *
>  + * This program is free software; you can redistribute it and/or modify
>  + * it under the terms of the GNU General Public License as published by
>  + * the Free Software Foundation; either version 2 of the License, or
>  + * (at your option) any later version.
>  + *
>  + * This program is distributed in the hope that it will be useful,
>  + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  + * GNU General Public License for more details.
>  + *
>  + * You should have received a copy of the GNU General Public License
>  + * along with this program; if not, write to the Free Software
>  + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
>  + * MA  02110-1301  USA.
>  + */
>  +
>  +/*
>  + * This file implements the common infrastructure for using the c67x00.
>  + * It is both the link between the platform configuration and subdrivers and
>  + * the link between the common hardware parts and the subdrivers (e.g.
>  + * interrupt handling).
>  + *
>  + * The c67x00 has 2 SIE's (serial interface engine) wich can be configured
>  + * to be host, device or OTG (with some limitations, E.G. only SIE1 can be OTG).
>  + *
>  + * Depending on the platform configuration, the SIE's are created and
>  + * the corresponding subdriver is initialized (c67x00_probe_sie).
>  + */
>  +
>  +#include <linux/device.h>
>  +#include <linux/io.h>
>  +#include <linux/list.h>
>  +#include <linux/usb.h>
>  +#include <linux/usb/c67x00.h>
>  +
>  +#include "c67x00.h"
>  +
>  +static void c67x00_probe_sie(struct c67x00_sie *sie,
>  +                            struct c67x00_device *dev, int sie_num)
>  +{
>  +       spin_lock_init(&sie->lock);
>  +       sie->dev = dev;
>  +       sie->sie_num = sie_num;
>  +       sie->mode = c67x00_sie_config(dev->pdata->sie_config, sie_num);
>  +
>  +       switch (sie->mode) {
>  +       case C67X00_SIE_UNUSED:
>  +               dev_info(sie_dev(sie),
>  +                        "Not using SIE %d as requested\n", sie->sie_num);
>  +               break;
>  +
>  +       default:
>  +               dev_err(sie_dev(sie),
>  +                       "Unsupported configuration: 0x%x for SIE %d\n",
>  +                       sie->mode, sie->sie_num);
>  +               break;
>  +       }
>  +}
>  +
>  +static void c67x00_remove_sie(struct c67x00_sie *sie)
>  +{
>  +}
>  +
>  +static irqreturn_t c67x00_irq(int irq, void *__dev)
>  +{
>  +       struct c67x00_device *c67x00 = __dev;
>  +       struct c67x00_sie *sie;
>  +       u16 msg, int_status;
>  +       int i, count = 8;
>  +
>  +       int_status = c67x00_ll_hpi_status(c67x00);
>  +       if (!int_status)
>  +               return IRQ_NONE;
>  +
>  +       while (int_status != 0 && (count-- >= 0)) {
>  +               c67x00_ll_irq(c67x00, int_status);
>  +               for (i = 0; i < C67X00_SIES; i++) {
>  +                       sie = &c67x00->sie[i];
>  +                       msg = 0;
>  +                       if (int_status & SIEMSG_FLG(i))
>  +                               msg = c67x00_ll_fetch_siemsg(c67x00, i);
>  +                       if (sie->irq)
>  +                               sie->irq(sie, int_status, msg);
>  +               }
>  +               int_status = c67x00_ll_hpi_status(c67x00);
>  +       }
>  +
>  +       if (int_status)
>  +               dev_warn(&c67x00->pdev->dev, "Not all interrupts handled! "
>  +                        "status = 0x%04x\n", int_status);
>  +
>  +       return IRQ_HANDLED;
>  +}
>  +
>  +/* ------------------------------------------------------------------------- */
>  +
>  +static int __devinit c67x00_drv_probe(struct platform_device *pdev)
>  +{
>  +       struct c67x00_device *c67x00;
>  +       struct c67x00_platform_data *pdata;
>  +       struct resource *res, *res2;
>  +       int ret, i;
>  +
>  +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  +       if (!res)
>  +               return -ENODEV;
>  +
>  +       res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  +       if (!res2)
>  +               return -ENODEV;
>  +
>  +       pdata = pdev->dev.platform_data;
>  +       if (!pdata)
>  +               return -ENODEV;
>  +
>  +       c67x00 = kzalloc(sizeof(*c67x00), GFP_KERNEL);
>  +       if (!c67x00)
>  +               return -ENOMEM;
>  +
>  +       if (!request_mem_region(res->start, res->end - res->start + 1,
>  +                               pdev->name)) {
>  +               dev_err(&pdev->dev, "Memory region busy\n");
>  +               ret = -EBUSY;
>  +               goto request_mem_failed;
>  +       }
>  +       c67x00->hpi.base = ioremap(res->start, res->end - res->start + 1);
>  +       if (!c67x00->hpi.base) {
>  +               dev_err(&pdev->dev, "Unable to map HPI registers\n");
>  +               ret = -EIO;
>  +               goto map_failed;
>  +       }
>  +
>  +       spin_lock_init(&c67x00->hpi.lock);
>  +       c67x00->hpi.regstep = pdata->hpi_regstep;
>  +       c67x00->pdata = pdev->dev.platform_data;
>  +       c67x00->pdev = pdev;
>  +
>  +       c67x00_ll_init(c67x00);
>  +       c67x00_ll_hpi_reg_init(c67x00);
>  +
>  +       ret = request_irq(res2->start, c67x00_irq, 0, pdev->name, c67x00);
>  +       if (ret) {
>  +               dev_err(&pdev->dev, "Cannot claim IRQ\n");
>  +               goto request_irq_failed;
>  +       }
>  +
>  +       ret = c67x00_ll_reset(c67x00);
>  +       if (ret) {
>  +               dev_err(&pdev->dev, "Device reset failed\n");
>  +               goto reset_failed;
>  +       }
>  +
>  +       for (i = 0; i < C67X00_SIES; i++)
>  +               c67x00_probe_sie(&c67x00->sie[i], c67x00, i);
>  +
>  +       platform_set_drvdata(pdev, c67x00);
>  +
>  +       return 0;
>  +
>  + reset_failed:
>  +       free_irq(res2->start, c67x00);
>  + request_irq_failed:
>  +       iounmap(c67x00->hpi.base);
>  + map_failed:
>  +       release_mem_region(res->start, res->end - res->start + 1);
>  + request_mem_failed:
>  +       kfree(c67x00);
>  +
>  +       return ret;
>  +}
>  +
>  +static int __devexit c67x00_drv_remove(struct platform_device *pdev)
>  +{
>  +       struct c67x00_device *c67x00 = platform_get_drvdata(pdev);
>  +       struct resource *res;
>  +       int i;
>  +
>  +       for (i = 0; i < C67X00_SIES; i++)
>  +               c67x00_remove_sie(&c67x00->sie[i]);
>  +
>  +       c67x00_ll_release(c67x00);
>  +
>  +       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  +       if (res)
>  +               free_irq(res->start, c67x00);
>  +
>  +       iounmap(c67x00->hpi.base);
>  +
>  +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  +       if (res)
>  +               release_mem_region(res->start, res->end - res->start + 1);
>  +
>  +       kfree(c67x00);
>  +
>  +       return 0;
>  +}
>  +
>  +static struct platform_driver c67x00_driver = {
>  +       .probe  = c67x00_drv_probe,
>  +       .remove = __devexit_p(c67x00_drv_remove),
>  +       .driver = {
>  +               .owner = THIS_MODULE,
>  +               .name = "c67x00",
>  +       },
>  +};
>  +MODULE_ALIAS("platform:c67x00");
>  +
>  +static int __init c67x00_init(void)
>  +{
>  +       return platform_driver_register(&c67x00_driver);
>  +}
>  +
>  +static void __exit c67x00_exit(void)
>  +{
>  +       platform_driver_unregister(&c67x00_driver);
>  +}
>  +
>  +module_init(c67x00_init);
>  +module_exit(c67x00_exit);
>  +
>  +MODULE_AUTHOR("Peter Korsgaard, Jan Veldeman, Grant Likely");
>  +MODULE_DESCRIPTION("Cypress C67X00 USB Controller Driver");
>  +MODULE_LICENSE("GPL");
>  Index: linux-2.6/include/linux/usb/c67x00.h
>  ===================================================================
>  --- /dev/null
>  +++ linux-2.6/include/linux/usb/c67x00.h
>  @@ -0,0 +1,48 @@
>  +/*
>  + * usb_c67x00.h: platform definitions for the Cypress C67X00 USB chip
>  + *
>  + * Copyright (C) 2006-2008 Barco N.V.
>  + *
>  + * This program is free software; you can redistribute it and/or modify
>  + * it under the terms of the GNU General Public License as published by
>  + * the Free Software Foundation; either version 2 of the License, or
>  + * (at your option) any later version.
>  + *
>  + * This program is distributed in the hope that it will be useful,
>  + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  + * GNU General Public License for more details.
>  + *
>  + * You should have received a copy of the GNU General Public License
>  + * along with this program; if not, write to the Free Software
>  + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
>  + * MA  02110-1301  USA.
>  + */
>  +
>  +#ifndef _LINUX_USB_C67X00_H
>  +#define _LINUX_USB_C67X00_H
>  +
>  +/* SIE configuration */
>  +#define C67X00_SIE_UNUSED      0
>  +#define C67X00_SIE_HOST                1
>  +#define C67X00_SIE_PERIPHERAL_A        2       /* peripheral on A port */
>  +#define C67X00_SIE_PERIPHERAL_B        3       /* peripheral on B port */
>  +
>  +#define c67x00_sie_config(config, n)  (((config)>>(4*(n)))&0x3)
>  +
>  +#define C67X00_SIE1_UNUSED             (C67X00_SIE_UNUSED              << 0)
>  +#define C67X00_SIE1_HOST               (C67X00_SIE_HOST                << 0)
>  +#define C67X00_SIE1_PERIPHERAL_A       (C67X00_SIE_PERIPHERAL_A        << 0)
>  +#define C67X00_SIE1_PERIPHERAL_B       (C67X00_SIE_PERIPHERAL_B        << 0)
>  +
>  +#define C67X00_SIE2_UNUSED             (C67X00_SIE_UNUSED              << 4)
>  +#define C67X00_SIE2_HOST               (C67X00_SIE_HOST                << 4)
>  +#define C67X00_SIE2_PERIPHERAL_A       (C67X00_SIE_PERIPHERAL_A        << 4)
>  +#define C67X00_SIE2_PERIPHERAL_B       (C67X00_SIE_PERIPHERAL_B        << 4)
>  +
>  +struct c67x00_platform_data {
>  +       int sie_config;                 /* SIEs config (C67X00_SIEx_*) */
>  +       unsigned long hpi_regstep;      /* Step between HPI registers  */
>  +};
>  +
>  +#endif /* _LINUX_USB_C67X00_H */
>  Index: linux-2.6/MAINTAINERS
>  ===================================================================
>  --- linux-2.6.orig/MAINTAINERS
>  +++ linux-2.6/MAINTAINERS
>  @@ -4010,6 +4010,12 @@
>   S:     Maintained
>   W:     http://www.kroah.com/linux-usb/
>
>  +USB CYPRESS C67X00 DRIVER
>  +P:     Peter Korsgaard
>  +M:     jacmet@sunsite.dk
>  +L:     linux-usb@vger.kernel.org
>  +S:     Maintained
>  +
>   USB DAVICOM DM9601 DRIVER
>   P:     Peter Korsgaard
>   M:     jacmet@sunsite.dk
>
>  --
>  Bye, Peter Korsgaard
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

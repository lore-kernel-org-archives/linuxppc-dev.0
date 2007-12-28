Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 7A0FBDDE08
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 10:54:39 +1100 (EST)
Received: from pd4mr3so.prod.shaw.ca
	(pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JTS00D8YAC0IW70@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Dec 2007 16:52:48 -0700 (MST)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JTS008M2ABXGD10@pd4mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Dec 2007 16:52:48 -0700 (MST)
Received: from trillian.cg.shawcable.net ([70.72.177.167])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JTS00302ABTQ630@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Dec 2007 16:52:45 -0700 (MST)
Date: Fri, 28 Dec 2007 16:52:36 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 2/4] USB: add Cypress c67x00 OTG controller core driver
In-reply-to: <20071228234537.16003.56035.stgit@trillian.secretlab.ca>
To: linux-usb-devel@lists.sourceforge.net, akpm@osdl.org,
	dbrownell@users.sourceforge.net, gregkh@suse.de, linuxppc-dev@ozlabs.org,
	jacmet@sunsite.dk, stern@rowland.harvard.edu
Message-id: <20071228235236.16003.44475.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071228234537.16003.56035.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch add the core driver for the c67x00 USB OTG controller.  The core
driver is responsible for the platform bus binding and creating either
USB HCD or USB Gadget instances for each of the serial interface engines
on the chip.

This driver does not directly implement the HCD or gadget behaviours; it
just controls access to the chip.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/usb/c67x00/c67x00-drv.c |  278 +++++++++++++++++++++++++++++++++++++++
 include/linux/usb/c67x00.h      |   45 ++++++
 2 files changed, 323 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-drv.c b/drivers/usb/c67x00/c67x00-drv.c
new file mode 100644
index 0000000..be90002
--- /dev/null
+++ b/drivers/usb/c67x00/c67x00-drv.c
@@ -0,0 +1,278 @@
+/*
+ * c67x00-drv.c: Cypress C67X00 USB Common infrastructure
+ *
+ * Copyright (C) 2006-2007 Barco N.V.
+ *    Derived from the Cypress cy7c67200/300 ezusb linux driver and
+ *    based on multiple host controller drivers inside the linux kernel.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA  02110-1301  USA.
+ */
+
+/*
+ * This file implements the common infrastructure for using the c67x00.
+ * It is both the link between the platform configuration and subdrivers and
+ * the link between the common hardware parts and the subdrivers (e.g.
+ * interrupt handling).
+ *
+ * The c67x00 has 2 SIE's (serial interface engine) wich can be configured
+ * to be host, device or OTG (with some limitations, E.G. only SIE1 can be OTG).
+ *
+ * Depending on the platform configuration, the SIE's are created (setup_sie)
+ * and the corresponding subdriver is initialized (c67x00_probe_sie).
+ */
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/usb.h>
+#include <linux/usb/c67x00.h>
+#include <asm/io.h>
+
+#include "c67x00.h"
+
+static struct platform_driver c67x00_driver;
+
+static void
+c67x00_setup_sie(struct c67x00_sie *sie, struct c67x00_device *dev, int sie_num)
+{
+	static unsigned int id = 0;
+
+	/* Fill in needed attributes */
+	sie->pdev = platform_device_register_simple("c67x00_sie",
+						    id++, NULL, 0);
+	/* driver used in hub.c: hub_port_init */
+	sie->pdev->dev.driver = &c67x00_driver.driver;
+	spin_lock_init(&sie->lock);
+	sie->dev = dev;
+	sie->sie_num = sie_num;
+	sie->mode = c67x00_sie_config(dev->pdata->sie_config, sie_num);
+}
+
+static void c67x00_teardown_sie(struct c67x00_sie *sie)
+{
+	sie->pdev->dev.driver = NULL;
+	platform_device_unregister(sie->pdev);
+}
+
+/* ------------------------------------------------------------------ */
+
+static void c67x00_probe_sie(struct c67x00_sie *sie)
+{
+	switch (c67x00_sie_config(sie->dev->pdata->sie_config, sie->sie_num)) {
+	case C67X00_SIE_HOST:
+		c67x00_hcd_probe(sie);
+		break;
+
+	case C67X00_SIE_UNUSED:
+		dev_info(sie_dev(sie),
+			 "Not using SIE %d as requested\n", sie->sie_num);
+		break;
+
+	default:
+		dev_err(sie_dev(sie),
+			"Unsupported configuration: 0x%x for SIE %d\n",
+			c67x00_sie_config(sie->dev->pdata->sie_config,
+					  sie->sie_num), sie->sie_num);
+		break;
+	}
+}
+
+static void c67x00_remove_sie(struct c67x00_sie *sie)
+{
+	switch (c67x00_sie_config(sie->dev->pdata->sie_config, sie->sie_num)) {
+	case C67X00_SIE_HOST:
+		c67x00_hcd_remove(sie);
+		break;
+
+	default:
+		break;
+	}
+}
+
+/* ------------------------------------------------------------------ */
+
+static irqreturn_t c67x00_irq(int irq, void *__dev)
+{
+	struct c67x00_device *c67x00 = __dev;
+	struct c67x00_sie *sie;
+	u16 msg;
+	int i, count = 8;
+
+	c67x00->int_status = c67x00_ll_hpi_status(c67x00);
+	if (!c67x00->int_status)
+		return IRQ_NONE;
+
+	while (c67x00->int_status != 0 && (count-- >= 0)) {
+		c67x00_ll_irq(c67x00);
+		for (i = 0; i < C67X00_SIES; i++) {
+			sie = &c67x00->sie[i];
+			msg = 0;
+			spin_lock(&sie->lock);
+			if (c67x00->int_status & SIEMSG_FLAG(sie->sie_num))
+				msg = c67x00_ll_get_siemsg(c67x00,sie->sie_num);
+			if (sie->irq)
+				sie->irq(sie, msg);
+			spin_unlock(&sie->lock);
+		}
+		c67x00->int_status = c67x00_ll_hpi_status(c67x00);
+	}
+
+	if (c67x00->int_status)
+		dev_warn(&c67x00->pdev->dev, "Not all interrupts handled! "
+			 "status = 0x%04x\n", c67x00->int_status);
+
+	return IRQ_HANDLED;
+}
+
+/* ---------------------------------------------------------------------
+ * Platform bus binding
+ */
+
+static int __devinit c67x00_drv_probe(struct platform_device *pdev)
+{
+	struct c67x00_device *c67x00;
+	struct c67x00_platform_data *pdata;
+	struct resource *res, *res2;
+	int ret, i;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res2)
+		return -ENODEV;
+
+	pdata = (struct c67x00_platform_data*)pdev->dev.platform_data;
+	if (!pdata)
+		return -ENODEV;
+
+	c67x00 = kzalloc(sizeof(*c67x00), GFP_KERNEL);
+	if (!c67x00)
+		return -ENOMEM;
+
+	if (!request_mem_region(res->start, res->end - res->start + 1,
+				pdev->name)) {
+		dev_err(&pdev->dev, "Memory region busy\n");
+		ret = -EBUSY;
+		goto request_mem_failed;
+	}
+	c67x00->hpi.base = ioremap(res->start, res->end - res->start + 1);
+	if (!c67x00->hpi.base) {
+		dev_err(&pdev->dev, "Unable to map HPI registers\n");
+		ret = -EIO;
+		goto map_failed;
+	}
+
+	spin_lock_init(&c67x00->hw_lock);
+	c67x00->hpi.regstep = pdata->hpi_regstep;
+	c67x00->pdata = pdev->dev.platform_data;
+	c67x00->pdev = pdev;
+
+	for (i = 0; i < C67X00_SIES; i++)
+		c67x00_setup_sie(&c67x00->sie[i], c67x00, i);
+
+	c67x00_ll_init(c67x00);
+	c67x00_ll_hpi_reg_init(c67x00);
+
+	dev_info(&pdev->dev, "USB OTG controller, p:0x%x, v:0x%p, irq:%i\n",
+	         res->start, c67x00->hpi.base, res2->start);
+
+	ret = request_irq(res2->start, c67x00_irq, 0, pdev->name, c67x00);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot claim IRQ\n");
+		goto request_irq_failed;
+	}
+
+	ret = c67x00_ll_reset(c67x00);
+	if (ret) {
+		dev_err(&pdev->dev, "Device reset failed\n");
+		goto reset_failed;
+	}
+
+	for (i = 0; i < C67X00_SIES; i++)
+		c67x00_probe_sie(&c67x00->sie[i]);
+
+	platform_set_drvdata(pdev, c67x00);
+
+	return 0;
+
+ reset_failed:
+	free_irq(res2->start, c67x00);
+ request_irq_failed:
+	iounmap(c67x00->hpi.base);
+ map_failed:
+	release_mem_region(res->start, res->end - res->start + 1);
+ request_mem_failed:
+	kfree(c67x00);
+
+	return ret;
+}
+
+static int __devexit c67x00_drv_remove(struct platform_device *pdev)
+{
+	struct c67x00_device *c67x00 = platform_get_drvdata(pdev);
+	struct resource *res;
+	int i;
+
+	for (i = 0; i < C67X00_SIES; i++) {
+		c67x00_remove_sie(&c67x00->sie[i]);
+		c67x00_teardown_sie(&c67x00->sie[i]);
+	}
+
+	c67x00_ll_release(c67x00);
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (res)
+		free_irq(res->start, c67x00);
+
+	iounmap(c67x00->hpi.base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res)
+		release_mem_region(res->start, res->end - res->start + 1);
+
+	kfree(c67x00);
+
+	return 0;
+}
+
+static struct platform_driver c67x00_driver = {
+	.probe = c67x00_drv_probe,
+	.remove = __devexit_p(c67x00_drv_remove),
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "c67x00",
+	},
+};
+
+static int __init c67x00_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	return platform_driver_register(&c67x00_driver);
+}
+module_init(c67x00_init);
+
+static void __exit c67x00_exit(void)
+{
+	platform_driver_unregister(&c67x00_driver);
+}
+module_exit(c67x00_exit);
+
+MODULE_AUTHOR("Peter Korsgaard, Jan Veldeman, Grant Likely");
+MODULE_DESCRIPTION("Cypress C67X00 USB Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/usb/c67x00.h b/include/linux/usb/c67x00.h
new file mode 100644
index 0000000..80b1a87
--- /dev/null
+++ b/include/linux/usb/c67x00.h
@@ -0,0 +1,45 @@
+/*
+ * usb_c67x00.h: platform definitions for the Cypress C67X00 USB chip
+ *
+ * Copyright (C) 2006-2007 Barco N.V.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA  02110-1301  USA.
+ */
+
+#ifndef _LINUX_USB_C67X00_H
+#define _LINUX_USB_C67X00_H
+
+/* SIE configuration */
+#define C67X00_SIE_UNUSED	0
+#define C67X00_SIE_HOST		1
+#define C67X00_SIE_PERIPHERAL	2
+
+#define c67x00_sie_config(config, n)  (((config)>>(4*(n)))&0x3)
+
+#define C67X00_SIE1_UNUSED	(C67X00_SIE_UNUSED	<< 0)
+#define C67X00_SIE1_HOST	(C67X00_SIE_HOST	<< 0)
+#define C67X00_SIE1_PERIPHERAL	(C67X00_SIE_PERIPHERAL	<< 0)
+
+#define C67X00_SIE2_UNUSED	(C67X00_SIE_UNUSED	<< 4)
+#define C67X00_SIE2_HOST	(C67X00_SIE_HOST	<< 4)
+#define C67X00_SIE2_PERIPHERAL	(C67X00_SIE_PERIPHERAL	<< 4)
+
+struct c67x00_platform_data {
+	int sie_config;			/* SIEs config (C67X00_SIEx_*) */
+	unsigned long hpi_regstep;	/* Step between HPI registers  */
+};
+
+#endif /* _LINUX_USB_C67X00_H */

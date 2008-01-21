Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id DABF7DDDE9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 08:16:43 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so961250uge.0
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 13:16:41 -0800 (PST)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
References: <20080121103434.397382000@sunsite.dk>
	<200801211201.41142.david-b@pacbell.net>
	<fa686aa40801211214u31581036m2ea2cf11d82c3f75@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 21 Jan 2008 22:16:35 +0100
In-Reply-To: <fa686aa40801211214u31581036m2ea2cf11d82c3f75@mail.gmail.com>
	(Grant Likely's message of "Mon\, 21 Jan 2008 13\:14\:21 -0700")
Message-ID: <87sl0qzxos.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

 Grant> Personally, I'd prefer to see the v3 series picked up now (as I
 Grant> believe all outstanding comments from the list have been addressed)
 Grant> and have new patches build on top of that, but that's just my
 Grant> preference.

Here's the v3->v4 without gadget diff:

diff --git a/MAINTAINERS b/MAINTAINERS
index 2340cfb..e3b7866 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3832,6 +3832,12 @@ L:      linux-usb@vger.kernel.org
 S:	Maintained
 W:	http://www.kroah.com/linux-usb/
 
+USB CYPRESS C67X00 DRIVER
+P:	Peter Korsgaard
+M:	jacmet@sunsite.dk
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+
 USB DAVICOM DM9601 DRIVER
 P:	Peter Korsgaard
 M:	jacmet@sunsite.dk
diff --git a/drivers/usb/c67x00/c67x00-drv.c b/drivers/usb/c67x00/c67x00-drv.c
index 0f0720a..c2ea3b6 100644
--- a/drivers/usb/c67x00/c67x00-drv.c
+++ b/drivers/usb/c67x00/c67x00-drv.c
@@ -1,7 +1,7 @@
 /*
  * c67x00-drv.c: Cypress C67X00 USB Common infrastructure
  *
- * Copyright (C) 2006-2007 Barco N.V.
+ * Copyright (C) 2006-2008 Barco N.V.
  *    Derived from the Cypress cy7c67200/300 ezusb linux driver and
  *    based on multiple host controller drivers inside the linux kernel.
  *
@@ -30,8 +30,8 @@
  * The c67x00 has 2 SIE's (serial interface engine) wich can be configured
  * to be host, device or OTG (with some limitations, E.G. only SIE1 can be OTG).
  *
- * Depending on the platform configuration, the SIE's are created (setup_sie)
- * and the corresponding subdriver is initialized (c67x00_probe_sie).
+ * Depending on the platform configuration, the SIE's are created and
+ * the corresponding subdriver is initialized (c67x00_probe_sie).
  */
 
 #include <linux/device.h>
@@ -41,36 +41,17 @@
 #include <asm/io.h>
 
 #include "c67x00.h"
+#include "c67x00-hcd.h"
 
-static struct platform_driver c67x00_driver;
-
-static void
-c67x00_setup_sie(struct c67x00_sie *sie, struct c67x00_device *dev, int sie_num)
+static void c67x00_probe_sie(struct c67x00_sie *sie,
+			     struct c67x00_device *dev, int sie_num)
 {
-	static unsigned int id = 0;
-
-	/* Fill in needed attributes */
-	sie->pdev = platform_device_register_simple("c67x00_sie",
-						    id++, NULL, 0);
-	/* driver used in hub.c: hub_port_init */
-	sie->pdev->dev.driver = &c67x00_driver.driver;
 	spin_lock_init(&sie->lock);
 	sie->dev = dev;
 	sie->sie_num = sie_num;
 	sie->mode = c67x00_sie_config(dev->pdata->sie_config, sie_num);
-}
 
-static void c67x00_teardown_sie(struct c67x00_sie *sie)
-{
-	sie->pdev->dev.driver = NULL;
-	platform_device_unregister(sie->pdev);
-}
-
-/* ------------------------------------------------------------------ */
-
-static void c67x00_probe_sie(struct c67x00_sie *sie)
-{
-	switch (c67x00_sie_config(sie->dev->pdata->sie_config, sie->sie_num)) {
+	switch (sie->mode) {
 	case C67X00_SIE_HOST:
 		c67x00_hcd_probe(sie);
 		break;
@@ -83,15 +64,14 @@ static void c67x00_probe_sie(struct c67x00_sie *sie)
 	default:
 		dev_err(sie_dev(sie),
 			"Unsupported configuration: 0x%x for SIE %d\n",
-			c67x00_sie_config(sie->dev->pdata->sie_config,
-					  sie->sie_num), sie->sie_num);
+			sie->mode, sie->sie_num);
 		break;
 	}
 }
 
 static void c67x00_remove_sie(struct c67x00_sie *sie)
 {
-	switch (c67x00_sie_config(sie->dev->pdata->sie_config, sie->sie_num)) {
+	switch (sie->mode) {
 	case C67X00_SIE_HOST:
 		c67x00_hcd_remove(sie);
 		break;
@@ -101,44 +81,42 @@ static void c67x00_remove_sie(struct c67x00_sie *sie)
 	}
 }
 
-/* ------------------------------------------------------------------ */
 
 static irqreturn_t c67x00_irq(int irq, void *__dev)
 {
 	struct c67x00_device *c67x00 = __dev;
 	struct c67x00_sie *sie;
-	u16 msg;
+	u16 msg, int_status;
 	int i, count = 8;
 
-	c67x00->int_status = c67x00_ll_hpi_status(c67x00);
-	if (!c67x00->int_status)
+	int_status = c67x00_ll_hpi_status(c67x00);
+	if (!int_status)
 		return IRQ_NONE;
 
-	while (c67x00->int_status != 0 && (count-- >= 0)) {
-		c67x00_ll_irq(c67x00);
+	while (int_status != 0 && (count-- >= 0)) {
+		c67x00_ll_irq(c67x00, int_status);
 		for (i = 0; i < C67X00_SIES; i++) {
 			sie = &c67x00->sie[i];
 			msg = 0;
-			spin_lock(&sie->lock);
-			if (c67x00->int_status & SIEMSG_FLAG(sie->sie_num))
-				msg = c67x00_ll_get_siemsg(c67x00,sie->sie_num);
+			if (int_status & SIEMSG_FLG(i)) {
+				msg = c67x00_ll_get_siemsg(sie);
+				/* clear register to allow next message */
+				c67x00_ll_set_siemsg(sie, 0);
+			}
 			if (sie->irq)
-				sie->irq(sie, msg);
-			spin_unlock(&sie->lock);
+				sie->irq(sie, int_status, msg);
 		}
-		c67x00->int_status = c67x00_ll_hpi_status(c67x00);
+		int_status = c67x00_ll_hpi_status(c67x00);
 	}
 
-	if (c67x00->int_status)
+	if (int_status)
 		dev_warn(&c67x00->pdev->dev, "Not all interrupts handled! "
-			 "status = 0x%04x\n", c67x00->int_status);
+			 "status = 0x%04x\n", int_status);
 
 	return IRQ_HANDLED;
 }
 
-/* ---------------------------------------------------------------------
- * Platform bus binding
- */
+/* ------------------------------------------------------------------------- */
 
 static int __devinit c67x00_drv_probe(struct platform_device *pdev)
 {
@@ -176,20 +154,14 @@ static int __devinit c67x00_drv_probe(struct platform_device *pdev)
 		goto map_failed;
 	}
 
-	spin_lock_init(&c67x00->hw_lock);
+	spin_lock_init(&c67x00->hpi.lock);
 	c67x00->hpi.regstep = pdata->hpi_regstep;
 	c67x00->pdata = pdev->dev.platform_data;
 	c67x00->pdev = pdev;
 
-	for (i = 0; i < C67X00_SIES; i++)
-		c67x00_setup_sie(&c67x00->sie[i], c67x00, i);
-
 	c67x00_ll_init(c67x00);
 	c67x00_ll_hpi_reg_init(c67x00);
 
-	dev_info(&pdev->dev, "USB OTG controller, p:0x%x, v:0x%p, irq:%i\n",
-	         res->start, c67x00->hpi.base, res2->start);
-
 	ret = request_irq(res2->start, c67x00_irq, 0, pdev->name, c67x00);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot claim IRQ\n");
@@ -203,19 +175,19 @@ static int __devinit c67x00_drv_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < C67X00_SIES; i++)
-		c67x00_probe_sie(&c67x00->sie[i]);
+		c67x00_probe_sie(&c67x00->sie[i], c67x00, i);
 
 	platform_set_drvdata(pdev, c67x00);
 
 	return 0;
 
- reset_failed:
+reset_failed:
 	free_irq(res2->start, c67x00);
- request_irq_failed:
+request_irq_failed:
 	iounmap(c67x00->hpi.base);
- map_failed:
+map_failed:
 	release_mem_region(res->start, res->end - res->start + 1);
- request_mem_failed:
+request_mem_failed:
 	kfree(c67x00);
 
 	return ret;
@@ -227,10 +199,8 @@ static int __devexit c67x00_drv_remove(struct platform_device *pdev)
 	struct resource *res;
 	int i;
 
-	for (i = 0; i < C67X00_SIES; i++) {
+	for (i = 0; i < C67X00_SIES; i++)
 		c67x00_remove_sie(&c67x00->sie[i]);
-		c67x00_teardown_sie(&c67x00->sie[i]);
-	}
 
 	c67x00_ll_release(c67x00);
 
@@ -250,9 +220,9 @@ static int __devexit c67x00_drv_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver c67x00_driver = {
-	.probe = c67x00_drv_probe,
-	.remove = __devexit_p(c67x00_drv_remove),
-	.driver = {
+	.probe	= c67x00_drv_probe,
+	.remove	= __devexit_p(c67x00_drv_remove),
+	.driver	= {
 		.owner = THIS_MODULE,
 		.name = "c67x00",
 	},
@@ -265,12 +235,13 @@ static int __init c67x00_init(void)
 
 	return platform_driver_register(&c67x00_driver);
 }
-module_init(c67x00_init);
 
 static void __exit c67x00_exit(void)
 {
 	platform_driver_unregister(&c67x00_driver);
 }
+
+module_init(c67x00_init);
 module_exit(c67x00_exit);
 
 MODULE_AUTHOR("Peter Korsgaard, Jan Veldeman, Grant Likely");
diff --git a/drivers/usb/c67x00/c67x00-hcd.c b/drivers/usb/c67x00/c67x00-hcd.c
index 3d0b77e..4afb291 100644
--- a/drivers/usb/c67x00/c67x00-hcd.c
+++ b/drivers/usb/c67x00/c67x00-hcd.c
@@ -1,7 +1,7 @@
 /*
  * c67x00-hcd.c: Cypress C67X00 USB Host Controller Driver
  *
- * Copyright (C) 2006-2007 Barco N.V.
+ * Copyright (C) 2006-2008 Barco N.V.
  *    Derived from the Cypress cy7c67200/300 ezusb linux driver and
  *    based on multiple host controller drivers inside the linux kernel.
  *
@@ -66,7 +66,7 @@ static int c67x00_hub_status_data(struct usb_hcd *hcd, char *buf)
 	int i;
 
 	*buf = 0;
-	status = c67x00_ll_husb_get_status(sie);
+	status = c67x00_ll_usb_get_status(sie);
 	for (i = 0; i < C67X00_PORTS; i++)
 		if (status & PORT_CONNECT_CHANGE(i))
 			*buf |= (1 << i);
@@ -91,13 +91,14 @@ static int c67x00_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 	case GetHubStatus:
 		*(__le32 *) buf = cpu_to_le32(0);
-		len = 4;	/* hub power */
+		len = 4;		/* hub power */
 		break;
+
 	case GetPortStatus:
 		if (wIndex > C67X00_PORTS)
 			return -EPIPE;
 
-		status = c67x00_ll_husb_get_status(sie);
+		status = c67x00_ll_usb_get_status(sie);
 		usb_status = c67x00_ll_get_usb_ctl(sie);
 
 		wPortChange = 0;
@@ -120,6 +121,7 @@ static int c67x00_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		*(__le16 *) (buf + 2) = cpu_to_le16(wPortChange);
 		len = 4;
 		break;
+
 	case SetHubFeature:	/* We don't implement these */
 	case ClearHubFeature:
 		switch (wValue) {
@@ -127,35 +129,41 @@ static int c67x00_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case C_HUB_LOCAL_POWER:
 			len = 0;
 			break;
+
 		default:
 			return -EPIPE;
 		}
 		break;
+
 	case SetPortFeature:
 		if (wIndex > C67X00_PORTS)
 			return -EPIPE;
 
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
-			dev_dbg(c67x00_hcd_dev(c67x00),
+			dev_dbg(c67x00_dev(c67x00),
 				"SetPortFeature %d (SUSPEND)\n", port);
 			len = 0;
 			break;
+
 		case USB_PORT_FEAT_RESET:
 			c67x00_hub_reset_host_port(sie, port);
 			len = 0;
 			break;
+
 		case USB_PORT_FEAT_POWER:
 			/* Power always enabled */
 			len = 0;
 			break;
+
 		default:
-			dev_dbg(c67x00_hcd_dev(c67x00),
+			dev_dbg(c67x00_dev(c67x00),
 				"%s: SetPortFeature %d (0x%04x) Error!\n",
 				__FUNCTION__, port, wValue);
 			return -EPIPE;
 		}
 		break;
+
 	case ClearPortFeature:
 		if (wIndex > C67X00_PORTS)
 			return -EPIPE;
@@ -167,53 +175,64 @@ static int c67x00_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			c67x00_hub_reset_host_port(sie, port);
 			len = 0;
 			break;
+
 		case USB_PORT_FEAT_C_ENABLE:
-			dev_dbg(c67x00_hcd_dev(c67x00),
+			dev_dbg(c67x00_dev(c67x00),
 				"ClearPortFeature (%d): C_ENABLE\n", port);
 			len = 0;
 			break;
+
 		case USB_PORT_FEAT_SUSPEND:
-			dev_dbg(c67x00_hcd_dev(c67x00),
+			dev_dbg(c67x00_dev(c67x00),
 				"ClearPortFeature (%d): SUSPEND\n", port);
 			len = 0;
 			break;
+
 		case USB_PORT_FEAT_C_SUSPEND:
-			dev_dbg(c67x00_hcd_dev(c67x00),
+			dev_dbg(c67x00_dev(c67x00),
 				"ClearPortFeature (%d): C_SUSPEND\n", port);
 			len = 0;
 			break;
+
 		case USB_PORT_FEAT_POWER:
-			dev_dbg(c67x00_hcd_dev(c67x00),
+			dev_dbg(c67x00_dev(c67x00),
 				"ClearPortFeature (%d): POWER\n", port);
 			return -EPIPE;
+
 		case USB_PORT_FEAT_C_CONNECTION:
-			c67x00_ll_husb_clear_status(sie,
-						    PORT_CONNECT_CHANGE(port));
+			c67x00_ll_usb_clear_status(sie,
+						   PORT_CONNECT_CHANGE(port));
 			len = 0;
 			break;
+
 		case USB_PORT_FEAT_C_OVER_CURRENT:
-			dev_dbg(c67x00_hcd_dev(c67x00),
+			dev_dbg(c67x00_dev(c67x00),
 				"ClearPortFeature (%d): OVER_CURRENT\n", port);
 			len = 0;
 			break;
+
 		case USB_PORT_FEAT_C_RESET:
-			dev_dbg(c67x00_hcd_dev(c67x00),
+			dev_dbg(c67x00_dev(c67x00),
 				"ClearPortFeature (%d): C_RESET\n", port);
 			len = 0;
 			break;
+
 		default:
-			dev_dbg(c67x00_hcd_dev(c67x00),
+			dev_dbg(c67x00_dev(c67x00),
 				"%s: ClearPortFeature %d (0x%04x) Error!\n",
 				__FUNCTION__, port, wValue);
 			return -EPIPE;
 		}
 		break;
+
 	case GetHubDescriptor:
 		len = min_t(unsigned int, sizeof(c67x00_hub_des), wLength);
 		memcpy(buf, c67x00_hub_des, len);
 		break;
+
 	default:
-		dev_dbg(c67x00_hcd_dev(c67x00), "%s: unknown\n", __FUNCTION__);
+		dev_dbg(c67x00_dev(c67x00), "%s: unknown\n", __FUNCTION__);
+		return -EPIPE;
 	}
 
 	return 0;
@@ -228,18 +247,17 @@ static int c67x00_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
  *
  * This function is called from the interrupt handler in c67x00-drv.c
  */
-static void c67x00_hcd_irq(struct c67x00_sie *sie, u16 msg)
+static void c67x00_hcd_irq(struct c67x00_sie *sie, u16 int_status, u16 msg)
 {
-	struct c67x00_device *c67x00 = sie->dev;
-	struct c67x00_hcd *c67x00_hcd = sie->private_data;
-	struct usb_hcd *hcd = c67x00_hcd_to_hcd(c67x00_hcd);
+	struct c67x00_hcd *c67x00 = sie->private_data;
+	struct usb_hcd *hcd = c67x00_hcd_to_hcd(c67x00);
 
 	/* Handle sie message flags */
 	if (msg) {
 		if (msg & HUSB_TDListDone)
-			c67x00_sched_kick(c67x00_hcd);
+			c67x00_sched_kick(c67x00);
 		else
-			dev_warn(c67x00_hcd_dev(c67x00_hcd),
+			dev_warn(c67x00_dev(c67x00),
 				 "Unknown SIE msg flag(s): 0x%04x\n", msg);
 	}
 
@@ -250,30 +268,31 @@ static void c67x00_hcd_irq(struct c67x00_sie *sie, u16 msg)
 		return;
 
 	/* Handle Start of frame events */
-	if (sie->dev->int_status & SOFEOP_FLG(sie->sie_num)) {
-		c67x00_ll_husb_clear_status(sie, SOF_EOP_IRQ_FLG);
-		c67x00_sched_kick(c67x00_hcd);
+	if (int_status & SOFEOP_FLG(sie->sie_num)) {
+		c67x00_ll_usb_clear_status(sie, SOF_EOP_IRQ_FLG);
+		c67x00_sched_kick(c67x00);
 		set_bit(HCD_FLAG_SAW_IRQ, &hcd->flags);
 	}
 }
 
 /**
- * c67x00_hcd_start: Host Controller start hook
+ * c67x00_hcd_start: Host controller start hook
  */
 static int c67x00_hcd_start(struct usb_hcd *hcd)
 {
 	hcd->uses_new_polling = 1;
 	hcd->state = HC_STATE_RUNNING;
 	hcd->poll_rh = 1;
+
 	return 0;
 }
 
 /**
- * c67x00_hcd_start: Host Controller stop hook
+ * c67x00_hcd_stop: Host controller stop hook
  */
 static void c67x00_hcd_stop(struct usb_hcd *hcd)
 {
-	/* Nothing todo */
+	/* Nothing to do */
 }
 
 static int c67x00_hcd_get_frame(struct usb_hcd *hcd)
@@ -281,29 +300,29 @@ static int c67x00_hcd_get_frame(struct usb_hcd *hcd)
 	struct c67x00_hcd *c67x00 = hcd_to_c67x00_hcd(hcd);
 	u16 temp_val;
 
-	dev_dbg(c67x00_hcd_dev(c67x00), "%s\n", __FUNCTION__);
+	dev_dbg(c67x00_dev(c67x00), "%s\n", __FUNCTION__);
 	temp_val = c67x00_ll_husb_get_frame(c67x00->sie);
 	temp_val &= HOST_FRAME_MASK;
 	return temp_val ? (temp_val - 1) : HOST_FRAME_MASK;
 }
 
 static struct hc_driver c67x00_hc_driver = {
-	.description = "c67x00-hcd",
-	.product_desc = "Cypress C67X00 Host Controller",
-	.hcd_priv_size = sizeof(struct c67x00_hcd),
-	.flags = HCD_USB11 | HCD_MEMORY,
+	.description	= "c67x00-hcd",
+	.product_desc	= "Cypress C67X00 Host Controller",
+	.hcd_priv_size	= sizeof(struct c67x00_hcd),
+	.flags		= HCD_USB11 | HCD_MEMORY,
 
 	/*
 	 * basic lifecycle operations
 	 */
-	.start = c67x00_hcd_start,
-	.stop = c67x00_hcd_stop,
+	.start		= c67x00_hcd_start,
+	.stop		= c67x00_hcd_stop,
 
 	/*
 	 * managing i/o requests and associated device resources
 	 */
-	.urb_enqueue = c67x00_urb_enqueue,
-	.urb_dequeue = c67x00_urb_dequeue,
+	.urb_enqueue	= c67x00_urb_enqueue,
+	.urb_dequeue	= c67x00_urb_dequeue,
 	.endpoint_disable = c67x00_endpoint_disable,
 
 	/*
@@ -315,7 +334,7 @@ static struct hc_driver c67x00_hc_driver = {
 	 * root hub support
 	 */
 	.hub_status_data = c67x00_hub_status_data,
-	.hub_control = c67x00_hub_control,
+	.hub_control	= c67x00_hub_control,
 };
 
 /* ---------------------------------------------------------------------
@@ -324,9 +343,10 @@ static struct hc_driver c67x00_hc_driver = {
 
 int c67x00_hcd_probe(struct c67x00_sie *sie)
 {
-	int retval;
-	struct usb_hcd *hcd = NULL;
 	struct c67x00_hcd *c67x00;
+	struct usb_hcd *hcd;
+	unsigned long flags;
+	int retval;
 
 	hcd = usb_create_hcd(&c67x00_hc_driver, sie_dev(sie), "c67x00_sie");
 	if (!hcd) {
@@ -349,11 +369,6 @@ int c67x00_hcd_probe(struct c67x00_sie *sie)
 	c67x00->buf_base_addr = CY_HCD_BUF_ADDR + SIE_BUF_OFFSET(sie->sie_num);
 	c67x00->max_frame_bw = MAX_FRAME_BW_STD;
 
-	spin_lock(&sie->lock);
-	sie->private_data = c67x00;
-	sie->irq = c67x00_hcd_irq;
-	spin_unlock(&sie->lock);
-
 	c67x00_ll_husb_init_host_port(sie);
 
 	init_completion(&c67x00->endpoint_disable);
@@ -368,23 +383,26 @@ int c67x00_hcd_probe(struct c67x00_sie *sie)
 		goto err2;
 	}
 
+	spin_lock_irqsave(&sie->lock, flags);
+	sie->private_data = c67x00;
+	sie->irq = c67x00_hcd_irq;
+	spin_unlock_irqrestore(&sie->lock, flags);
+
 	return retval;
- err2:
+err2:
 	c67x00_sched_stop_scheduler(c67x00);
- err1:
+err1:
 	usb_put_hcd(hcd);
- err0:
+err0:
 	return retval;
 }
 
 /* may be called with controller, bus, and devices active */
 void c67x00_hcd_remove(struct c67x00_sie *sie)
 {
-	struct usb_hcd *hcd;
-	struct c67x00_hcd *c67x00;
+	struct c67x00_hcd *c67x00 = sie->private_data;
+	struct usb_hcd *hcd = c67x00_hcd_to_hcd(c67x00);
 
-	c67x00 = sie->private_data;
-	hcd = c67x00_hcd_to_hcd(c67x00);
 	c67x00_sched_stop_scheduler(c67x00);
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
diff --git a/drivers/usb/c67x00/c67x00-hcd.h b/drivers/usb/c67x00/c67x00-hcd.h
index 5b35f01..daee4cd 100644
--- a/drivers/usb/c67x00/c67x00-hcd.h
+++ b/drivers/usb/c67x00/c67x00-hcd.h
@@ -1,7 +1,7 @@
 /*
  * c67x00-hcd.h: Cypress C67X00 USB HCD
  *
- * Copyright (C) 2006-2007 Barco N.V.
+ * Copyright (C) 2006-2008 Barco N.V.
  *    Derived from the Cypress cy7c67200/300 ezusb linux driver and
  *    based on multiple host controller drivers inside the linux kernel.
  *
@@ -69,15 +69,6 @@
 struct c67x00_hcd {
 	spinlock_t lock;
 	struct c67x00_sie *sie;
-	/* Requirement:
-	 * All enabled bits in ports must have a position <= MAX_NB_HCD_PORTS
-	 * (position starts counting from 1!)
-	 *    ( ports & ~((1<<MAX_NB_HCD_PORTS)-1) ) == 0
-	 *
-	 * This might be relaxed if needed by using an other indexing scheme
-	 * for port[] (e.g. use wIndex instead of real port number)
-	 * */
-#define MAX_NB_HCD_PORTS 2
 	unsigned int low_speed_ports;	/* bitmask of low speed ports */
 	unsigned int urb_count;
 	unsigned int urb_iso_count;
@@ -119,6 +110,30 @@ static inline struct usb_hcd *c67x00_hcd_to_hcd(struct c67x00_hcd *c67x00)
 	return container_of((void *)c67x00, struct usb_hcd, hcd_priv);
 }
 
+/* -------------------------------------------------------------------------- */
+
+#ifdef CONFIG_USB_C67X00_HCD
+/* Functions used by drv */
+int c67x00_hcd_probe(struct c67x00_sie *sie);
+void c67x00_hcd_remove(struct c67x00_sie *sie);
+#else
+static inline int c67x00_hcd_probe(struct c67x00_sie *sie)
+{
+	printk(KERN_ERR "hcd requested but CONFIG_USB_C67X00_HCD "
+	       "not enabled!\n");
+	return -ENODEV;
+}
+
+static inline void c67x00_hcd_remove(struct c67x00_sie *sie)
+{
+}
+
+static int usb_disabled(void)
+{
+	return 0;
+}
+#endif				/* CONFIG_USB_C67X00_HCD */
+
 /* ---------------------------------------------------------------------
  * Transfer Descriptor scheduling functions
  */
@@ -132,6 +147,6 @@ void c67x00_sched_kick(struct c67x00_hcd *c67x00);
 int c67x00_sched_start_scheduler(struct c67x00_hcd *c67x00);
 void c67x00_sched_stop_scheduler(struct c67x00_hcd *c67x00);
 
-#define c67x00_hcd_dev(x)	(c67x00_hcd_to_hcd(x)->self.controller)
+#define c67x00_dev(x)	(c67x00_hcd_to_hcd(x)->self.controller)
 
 #endif				/* _USB_C67X00_HCD_H */
diff --git a/drivers/usb/c67x00/c67x00-ll-hpi.c b/drivers/usb/c67x00/c67x00-ll-hpi.c
index d6a95d6..ebf58e3 100644
--- a/drivers/usb/c67x00/c67x00-ll-hpi.c
+++ b/drivers/usb/c67x00/c67x00-ll-hpi.c
@@ -1,7 +1,7 @@
 /*
  * c67x00-ll-hpi.c: Cypress C67X00 USB Low level interface using HPI
  *
- * Copyright (C) 2006-2007 Barco N.V.
+ * Copyright (C) 2006-2008 Barco N.V.
  *    Derived from the Cypress cy7c67200/300 ezusb linux driver and
  *    based on multiple host controller drivers inside the linux kernel.
  *
@@ -23,37 +23,41 @@
 
 #include <asm/io.h>
 #include <asm/byteorder.h>
+#include <linux/usb/c67x00.h>
 #include "c67x00.h"
 
+#define COMM_REGS 14
+
+struct lcp_int_data {
+	u16 regs[COMM_REGS];
+};
+
 /* -------------------------------------------------------------------------- */
 /* Interface definitions */
 
 #define COMM_ACK			0x0FED
 #define COMM_NAK			0xDEAD
 
-#define COMM_CTRL_REG_ADDR		0x01BC
-#define COMM_CTRL_REG_DATA		0x01BE
-#define COMM_CTRL_REG_LOGIC		0x01C0
-#define COMM_WRITE_CTRL_REG		0xCE03
-#define COMM_READ_CTRL_REG		0xCE02
-
 #define COMM_RESET			0xFA50
 #define COMM_EXEC_INT			0xCE01
 #define COMM_INT_NUM			0x01C2
+
 /* Registers 0 to COMM_REGS-1 */
 #define COMM_R(x)			(0x01C4 + 2 * (x))
 
-#define HUSB_SIE_pCurrentTDPtr(x)	( (x) ? 0x01B2 : 0x01B0 )
-#define HUSB_SIE_pTDListDone_Sem(x)	( (x) ? 0x01B8 : 0x01B6 )
+#define HUSB_SIE_pCurrentTDPtr(x)	((x) ? 0x01B2 : 0x01B0)
+#define HUSB_SIE_pTDListDone_Sem(x)	((x) ? 0x01B8 : 0x01B6)
 #define HUSB_pEOT			0x01B4
 
 /* Software interrupts */
 /* 114, 115: */
-#define HUSB_SIE_INIT_INT(x)		( (x) ? 0x0073 : 0x0072 )
-#define HUSB_RESET_INT			0x0074	/* 116 */
+#define HUSB_SIE_INIT_INT(x)		((x) ? 0x0073 : 0x0072)
+#define HUSB_RESET_INT			0x0074
 
 #define SUSB_INIT_INT			0x0071
-/* ---------------------------------------------------------------------
+#define SUSB_INIT_INT_LOC		(SUSB_INIT_INT * 2)
+
+/* -----------------------------------------------------------------------
  * HPI implementation
  *
  * The c67x00 chip also support control via SPI or HSS serial
@@ -89,9 +93,9 @@ static inline u16 hpi_read_word(struct c67x00_device *dev, u16 reg)
 	u16 value;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dev->hw_lock, flags);
+	spin_lock_irqsave(&dev->hpi.lock, flags);
 	value = hpi_read_word_nolock(dev, reg);
-	spin_unlock_irqrestore(&dev->hw_lock, flags);
+	spin_unlock_irqrestore(&dev->hpi.lock, flags);
 
 	return value;
 }
@@ -107,43 +111,43 @@ static inline void hpi_write_word(struct c67x00_device *dev, u16 reg, u16 value)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&dev->hw_lock, flags);
+	spin_lock_irqsave(&dev->hpi.lock, flags);
 	hpi_write_word_nolock(dev, reg, value);
-	spin_unlock_irqrestore(&dev->hw_lock, flags);
+	spin_unlock_irqrestore(&dev->hpi.lock, flags);
 }
 
 /*
  * Only data is little endian, addr has cpu endianess
  */
 static inline void hpi_write_words_le16(struct c67x00_device *dev, u16 addr,
-					u16 * data, u16 count)
+					u16 *data, u16 count)
 {
 	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&dev->hw_lock, flags);
+	spin_lock_irqsave(&dev->hpi.lock, flags);
 
 	hpi_write_reg(dev, HPI_ADDR, addr);
 	for (i = 0; i < count; i++)
 		hpi_write_reg(dev, HPI_DATA, cpu_to_le16(*data++));
 
-	spin_unlock_irqrestore(&dev->hw_lock, flags);
+	spin_unlock_irqrestore(&dev->hpi.lock, flags);
 }
 
 /*
  * Only data is little endian, addr has cpu endianess
  */
 static inline void hpi_read_words_le16(struct c67x00_device *dev, u16 addr,
-				       u16 * data, u16 count)
+				       u16 *data, u16 count)
 {
 	unsigned long flags;
 	int i;
-	spin_lock_irqsave(&dev->hw_lock, flags);
+	spin_lock_irqsave(&dev->hpi.lock, flags);
 	hpi_write_reg(dev, HPI_ADDR, addr);
 	for (i = 0; i < count; i++)
 		*data++ = le16_to_cpu(hpi_read_reg(dev, HPI_DATA));
 
-	spin_unlock_irqrestore(&dev->hw_lock, flags);
+	spin_unlock_irqrestore(&dev->hpi.lock, flags);
 }
 
 static inline void hpi_set_bits(struct c67x00_device *dev, u16 reg, u16 mask)
@@ -151,10 +155,10 @@ static inline void hpi_set_bits(struct c67x00_device *dev, u16 reg, u16 mask)
 	u16 value;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dev->hw_lock, flags);
+	spin_lock_irqsave(&dev->hpi.lock, flags);
 	value = hpi_read_word_nolock(dev, reg);
 	hpi_write_word_nolock(dev, reg, value | mask);
-	spin_unlock_irqrestore(&dev->hw_lock, flags);
+	spin_unlock_irqrestore(&dev->hpi.lock, flags);
 }
 
 static inline void hpi_clear_bits(struct c67x00_device *dev, u16 reg, u16 mask)
@@ -162,10 +166,10 @@ static inline void hpi_clear_bits(struct c67x00_device *dev, u16 reg, u16 mask)
 	u16 value;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dev->hw_lock, flags);
+	spin_lock_irqsave(&dev->hpi.lock, flags);
 	value = hpi_read_word_nolock(dev, reg);
 	hpi_write_word_nolock(dev, reg, value & ~mask);
-	spin_unlock_irqrestore(&dev->hw_lock, flags);
+	spin_unlock_irqrestore(&dev->hpi.lock, flags);
 }
 
 static inline u16 hpi_recv_mbox(struct c67x00_device *dev)
@@ -173,9 +177,9 @@ static inline u16 hpi_recv_mbox(struct c67x00_device *dev)
 	u16 value;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dev->hw_lock, flags);
+	spin_lock_irqsave(&dev->hpi.lock, flags);
 	value = hpi_read_reg(dev, HPI_MAILBOX);
-	spin_unlock_irqrestore(&dev->hw_lock, flags);
+	spin_unlock_irqrestore(&dev->hpi.lock, flags);
 
 	return value;
 }
@@ -184,21 +188,21 @@ static inline u16 hpi_send_mbox(struct c67x00_device *dev, u16 value)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&dev->hw_lock, flags);
+	spin_lock_irqsave(&dev->hpi.lock, flags);
 	hpi_write_reg(dev, HPI_MAILBOX, value);
-	spin_unlock_irqrestore(&dev->hw_lock, flags);
+	spin_unlock_irqrestore(&dev->hpi.lock, flags);
 
 	return value;
 }
 
-u16 c67x00_ll_hpi_status(struct c67x00_device * dev)
+u16 c67x00_ll_hpi_status(struct c67x00_device *dev)
 {
 	u16 value;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dev->hw_lock, flags);
+	spin_lock_irqsave(&dev->hpi.lock, flags);
 	value = hpi_read_reg(dev, HPI_STATUS);
-	spin_unlock_irqrestore(&dev->hw_lock, flags);
+	spin_unlock_irqrestore(&dev->hpi.lock, flags);
 
 	return value;
 }
@@ -211,7 +215,7 @@ void c67x00_ll_hpi_reg_init(struct c67x00_device *dev)
 	c67x00_ll_hpi_status(dev);
 	hpi_write_word(dev, HPI_IRQ_ROUTING_REG, 0);
 
-	for (i=0; i<C67X00_SIES; i++) {
+	for (i = 0; i < C67X00_SIES; i++) {
 		hpi_write_word(dev, SIEMSG_REG(i), 0);
 		hpi_read_word(dev, SIEMSG_REG(i));
 	}
@@ -236,69 +240,81 @@ static inline u16 ll_recv_msg(struct c67x00_device *dev)
 {
 	u16 res;
 
-	res = wait_for_completion_timeout(&dev->lcp.msg_received, 5 * HZ);
+	res = wait_for_completion_timeout(&dev->hpi.lcp.msg_received, 5 * HZ);
 	WARN_ON(!res);
 
 	return (res == 0) ? -EIO : 0;
 }
 
 /* -------------------------------------------------------------------------- */
+/* General functions */
 
-u16 c67x00_comm_read_ctrl_reg(struct c67x00_device * dev, u16 addr)
+u16 c67x00_ll_get_siemsg(struct c67x00_sie *sie)
 {
-	unsigned long msg, res;
-	int rc;
+	return hpi_read_word(sie->dev, SIEMSG_REG(sie->sie_num));
+}
 
-	mutex_lock(&dev->lcp.mutex);
-	hpi_write_word(dev, COMM_CTRL_REG_ADDR, addr);
-	hpi_send_mbox(dev, COMM_READ_CTRL_REG);
-	rc = ll_recv_msg(dev);
+void c67x00_ll_set_siemsg(struct c67x00_sie *sie, u16 val)
+{
+	hpi_write_word(sie->dev, SIEMSG_REG(sie->sie_num), val);
+}
 
-	BUG_ON(rc); /* No return path for error code; crash spectacularly */
+u16 c67x00_ll_get_usb_ctl(struct c67x00_sie *sie)
+{
+	return hpi_read_word(sie->dev, USB_CTL_REG(sie->sie_num));
+}
 
-	msg = dev->lcp.last_msg;
-	if (msg != COMM_ACK) {
-		dev_warn(&dev->pdev->dev, "COMM_READ_CTRL_REG didn't ACK!\n");
-		res = 0;
-	} else {
-		res = hpi_read_word(dev, COMM_CTRL_REG_DATA);
-	}
-	mutex_unlock(&dev->lcp.mutex);
-	return res;
+void c67x00_ll_set_ep_ctrl_reg(struct c67x00_sie *sie, int ep_num, u16 val)
+{
+	hpi_write_word(sie->dev,
+		       DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep_num), val);
+}
+
+void c67x00_ll_set_ep_packet_size_reg(struct c67x00_sie *sie, int ep_num,
+				      u16 val)
+{
+	/* This undocumented register needs to be set to the packet size
+	   Normally the BIOS sets this correctly when it is able to parse
+	   the configuration descriptor correctly */
+	hpi_write_word(sie->dev,
+		       (DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep_num)
+			+ 0x0A), val);
+}
+
+/**
+ * c67x00_ll_usb_clear_status - clear the USB status bits
+ */
+void c67x00_ll_usb_clear_status(struct c67x00_sie *sie, u16 bits)
+{
+	hpi_write_word(sie->dev, USB_STAT_REG(sie->sie_num), bits);
 }
 
-int c67x00_comm_exec_int(struct c67x00_device *dev, u16 nr,
-			 struct c67x00_lcp_int_data *data)
+u16 c67x00_ll_usb_get_status(struct c67x00_sie *sie)
+{
+	return hpi_read_word(sie->dev, USB_STAT_REG(sie->sie_num));
+}
+
+/* -------------------------------------------------------------------------- */
+
+static int c67x00_comm_exec_int(struct c67x00_device *dev, u16 nr,
+				struct lcp_int_data *data)
 {
 	int i, rc;
 
-	mutex_lock(&dev->lcp.mutex);
+	mutex_lock(&dev->hpi.lcp.mutex);
 	hpi_write_word(dev, COMM_INT_NUM, nr);
 	for (i = 0; i < COMM_REGS; i++)
 		hpi_write_word(dev, COMM_R(i), data->regs[i]);
 	hpi_send_mbox(dev, COMM_EXEC_INT);
 	rc = ll_recv_msg(dev);
-	mutex_unlock(&dev->lcp.mutex);
+	mutex_unlock(&dev->hpi.lcp.mutex);
 
 	return rc;
 }
 
-/* -------------------------------------------------------------------------- */
-/* General functions */
-
-u16 c67x00_ll_get_siemsg(struct c67x00_device *dev, int sie)
+static u16 c67x00_get_comm_reg(struct c67x00_device *dev, u16 nr)
 {
-	return hpi_read_word(dev, SIEMSG_REG(sie));
-}
-
-void c67x00_ll_set_siemsg(struct c67x00_device *dev, int sie, u16 val)
-{
-	hpi_write_word(dev, SIEMSG_REG(sie), val);
-}
-
-u16 c67x00_ll_get_usb_ctl(struct c67x00_sie *sie)
-{
-	return hpi_read_word(sie->dev, USB_CTL_REG(sie->sie_num));
+	return hpi_read_word(dev, COMM_R(nr));
 }
 
 /* -------------------------------------------------------------------------- */
@@ -306,15 +322,15 @@ u16 c67x00_ll_get_usb_ctl(struct c67x00_sie *sie)
 
 void c67x00_ll_set_husb_eot(struct c67x00_device *dev, u16 value)
 {
-	mutex_lock(&dev->lcp.mutex);
+	mutex_lock(&dev->hpi.lcp.mutex);
 	hpi_write_word(dev, HUSB_pEOT, value);
-	mutex_unlock(&dev->lcp.mutex);
+	mutex_unlock(&dev->hpi.lcp.mutex);
 }
 
 static inline void c67x00_ll_husb_sie_init(struct c67x00_sie *sie)
 {
 	struct c67x00_device *dev = sie->dev;
-	struct c67x00_lcp_int_data data;
+	struct lcp_int_data data;
 	int rc;
 
 	rc = c67x00_comm_exec_int(dev, HUSB_SIE_INIT_INT(sie->sie_num), &data);
@@ -324,7 +340,7 @@ static inline void c67x00_ll_husb_sie_init(struct c67x00_sie *sie)
 void c67x00_ll_husb_reset(struct c67x00_sie *sie, int port)
 {
 	struct c67x00_device *dev = sie->dev;
-	struct c67x00_lcp_int_data data;
+	struct lcp_int_data data;
 	int rc;
 
 	data.regs[0] = 50;	/* Reset USB port for 50ms */
@@ -343,20 +359,7 @@ u16 c67x00_ll_husb_get_current_td(struct c67x00_sie *sie)
 	return hpi_read_word(sie->dev, HUSB_SIE_pCurrentTDPtr(sie->sie_num));
 }
 
-/**
- * c67x00_ll_husb_clear_status - clear the host status bits
- */
-void c67x00_ll_husb_clear_status(struct c67x00_sie *sie, u16 bits)
-{
-	hpi_write_word(sie->dev, HOST_STAT_REG(sie->sie_num), bits);
-}
-
-u16 c67x00_ll_husb_get_status(struct c67x00_sie *sie)
-{
-	return hpi_read_word(sie->dev, HOST_STAT_REG(sie->sie_num));
-}
-
-u16 c67x00_ll_husb_get_frame(struct c67x00_sie * sie)
+u16 c67x00_ll_husb_get_frame(struct c67x00_sie *sie)
 {
 	return hpi_read_word(sie->dev, HOST_FRAME_REG(sie->sie_num));
 }
@@ -367,7 +370,7 @@ void c67x00_ll_husb_init_host_port(struct c67x00_sie *sie)
 	hpi_set_bits(sie->dev, USB_CTL_REG(sie->sie_num), HOST_MODE);
 	c67x00_ll_husb_sie_init(sie);
 	/* Clear interrupts */
-	c67x00_ll_husb_clear_status(sie, HOST_STAT_MASK);
+	c67x00_ll_usb_clear_status(sie, HOST_STAT_MASK);
 	/* Check */
 	if (!(hpi_read_word(sie->dev, USB_CTL_REG(sie->sie_num)) & HOST_MODE))
 		dev_warn(sie_dev(sie),
@@ -377,7 +380,7 @@ void c67x00_ll_husb_init_host_port(struct c67x00_sie *sie)
 void c67x00_ll_husb_reset_port(struct c67x00_sie *sie, int port)
 {
 	/* Clear connect change */
-	c67x00_ll_husb_clear_status(sie, PORT_CONNECT_CHANGE(port));
+	c67x00_ll_usb_clear_status(sie, PORT_CONNECT_CHANGE(port));
 
 	/* Enable interrupts */
 	hpi_set_bits(sie->dev, HPI_IRQ_ROUTING_REG,
@@ -390,31 +393,14 @@ void c67x00_ll_husb_reset_port(struct c67x00_sie *sie, int port)
 }
 
 /* -------------------------------------------------------------------------- */
-void c67x00_ll_susb_init(struct c67x00_sie *sie)
-{
-	struct c67x00_device *dev = sie->dev;
-	struct c67x00_lcp_int_data data;
-	int rc;
-
-	data.regs[1] = 1;	/* full speed */
-	data.regs[2] = sie->sie_num + 1;
-	rc = c67x00_comm_exec_int(dev, SUSB_INIT_INT, &data);
-	BUG_ON(rc); /* No return path for error code; crash spectacularly */
-
-	hpi_clear_bits(dev, HPI_IRQ_ROUTING_REG,
-		       SOFEOP_TO_HPI_EN(sie->sie_num));
-	hpi_set_bits(dev, HPI_IRQ_ROUTING_REG, SOFEOP_TO_CPU_EN(sie->sie_num));
-}
-
-/* -------------------------------------------------------------------------- */
 
-void c67x00_ll_irq(struct c67x00_device *dev)
+void c67x00_ll_irq(struct c67x00_device *dev, u16 int_status)
 {
-	if ((dev->int_status & MBX_OUT_FLG) == 0)
+	if ((int_status & MBX_OUT_FLG) == 0)
 		return;
 
-	dev->lcp.last_msg = hpi_recv_mbox(dev);
-	complete(&dev->lcp.msg_received);
+	dev->hpi.lcp.last_msg = hpi_recv_mbox(dev);
+	complete(&dev->hpi.lcp.msg_received);
 }
 
 /* -------------------------------------------------------------------------- */
@@ -423,10 +409,10 @@ int c67x00_ll_reset(struct c67x00_device *dev)
 {
 	int rc;
 
-	mutex_lock(&dev->lcp.mutex);
+	mutex_lock(&dev->hpi.lcp.mutex);
 	hpi_send_mbox(dev, COMM_RESET);
 	rc = ll_recv_msg(dev);
-	mutex_unlock(&dev->lcp.mutex);
+	mutex_unlock(&dev->hpi.lcp.mutex);
 
 	return rc;
 }
@@ -434,12 +420,14 @@ int c67x00_ll_reset(struct c67x00_device *dev)
 /* -------------------------------------------------------------------------- */
 
 /**
- * c67x00_write_mem_le16 - write into c67x00 memory
+ * c67x00_ll_write_mem_le16 - write into c67x00 memory
  * Only data is little endian, addr has cpu endianess.
  */
-void c67x00_ll_hpi_write_mem_le16(struct c67x00_device *dev, u16 addr, int len,
-				  char *data)
+void c67x00_ll_write_mem_le16(struct c67x00_device *dev, u16 addr,
+			      void *data, int len)
 {
+	u8 *buf = data;
+
 	/* Sanity check */
 	if (addr + len > 0xffff) {
 		dev_err(&dev->pdev->dev,
@@ -451,55 +439,52 @@ void c67x00_ll_hpi_write_mem_le16(struct c67x00_device *dev, u16 addr, int len,
 		/* unaligned access */
 		u16 tmp;
 		tmp = hpi_read_word(dev, addr - 1);
-		tmp = (tmp & 0x00ff) | (*data++ << 8);
+		tmp = (tmp & 0x00ff) | (*buf++ << 8);
 		hpi_write_word(dev, addr - 1, tmp);
 		addr++;
 		len--;
 	}
 
-	hpi_write_words_le16(dev, addr, (u16 *) data, len / 2);
-	data += len & ~0x01;
+	hpi_write_words_le16(dev, addr, (u16 *)buf, len / 2);
+	buf += len & ~0x01;
 	addr += len & ~0x01;
 	len &= 0x01;
 
 	if (len) {
 		u16 tmp;
 		tmp = hpi_read_word(dev, addr);
-		tmp = (tmp & 0xff00) | (*data++);
+		tmp = (tmp & 0xff00) | *buf;
 		hpi_write_word(dev, addr, tmp);
-		addr++;
-		len--;
 	}
-
 }
 
 /**
- * c67x00_ll_hpi_read_mem_le16 - read from c67x00 memory
+ * c67x00_ll_read_mem_le16 - read from c67x00 memory
  * Only data is little endian, addr has cpu endianess.
  */
-void c67x00_ll_hpi_read_mem_le16(struct c67x00_device *dev, u16 addr, int len,
-				 char *data)
+void c67x00_ll_read_mem_le16(struct c67x00_device *dev, u16 addr,
+			     void *data, int len)
 {
+	u8 *buf = data;
+
 	if (addr & 0x01) {
 		/* unaligned access */
 		u16 tmp;
 		tmp = hpi_read_word(dev, addr - 1);
-		*data++ = (tmp >> 8) & 0x00ff;
+		*buf++ = (tmp >> 8) & 0x00ff;
 		addr++;
 		len--;
 	}
 
-	hpi_read_words_le16(dev, addr, (u16 *) data, len / 2);
-	data += len & ~0x01;
+	hpi_read_words_le16(dev, addr, (u16 *)buf, len / 2);
+	buf += len & ~0x01;
 	addr += len & ~0x01;
 	len &= 0x01;
 
 	if (len) {
 		u16 tmp;
 		tmp = hpi_read_word(dev, addr);
-		*data++ = tmp & 0x00ff;
-		addr++;
-		len--;
+		*buf = tmp & 0x00ff;
 	}
 }
 
@@ -507,8 +492,8 @@ void c67x00_ll_hpi_read_mem_le16(struct c67x00_device *dev, u16 addr, int len,
 
 void c67x00_ll_init(struct c67x00_device *dev)
 {
-	mutex_init(&dev->lcp.mutex);
-	init_completion(&dev->lcp.msg_received);
+	mutex_init(&dev->hpi.lcp.mutex);
+	init_completion(&dev->hpi.lcp.msg_received);
 }
 
 void c67x00_ll_release(struct c67x00_device *dev)
diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
index 35d7318..3140d89 100644
--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -1,7 +1,7 @@
 /*
  * c67x00-sched.c: Cypress C67X00 USB Host Controller Driver - TD scheduling
  *
- * Copyright (C) 2006-2007 Barco N.V.
+ * Copyright (C) 2006-2008 Barco N.V.
  *    Derived from the Cypress cy7c67200/300 ezusb linux driver and
  *    based on multiple host controller drivers inside the linux kernel.
  *
@@ -71,7 +71,7 @@ struct c67x00_td {
 	/* SW part */
 	struct list_head td_list;
 	u16 td_addr;
-	char *data;
+	void *data;
 	struct urb *urb;
 	unsigned long privdata;
 
@@ -113,7 +113,7 @@ struct c67x00_urb_priv {
 #define TD_STATUSMASK_STALL	0x80
 
 #define TD_ERROR_MASK		(TD_STATUSMASK_ERR | TD_STATUSMASK_TMOUT | \
-				 TD_STATUSMASK_STALL )
+				 TD_STATUSMASK_STALL)
 
 #define TD_RETRYCNT_OFFSET	0x08
 #define TD_RETRYCNTMASK_ACT_FLG	0x10
@@ -134,8 +134,8 @@ struct c67x00_urb_priv {
 #define td_length(td)		(td_port_length(td) & TD_PORTLENMASK_DL)
 
 #define td_sequence_ok(td)	(!td->status || \
-				 ( !(td->status & TD_STATUSMASK_SEQ) == \
-				   !(td->ctrl_reg & SEQ_SEL) ))
+				 (!(td->status & TD_STATUSMASK_SEQ) ==	\
+				  !(td->ctrl_reg & SEQ_SEL)))
 
 #define td_acked(td)		(!td->status || \
 				 (td->status & TD_STATUSMASK_ACK))
@@ -144,21 +144,14 @@ struct c67x00_urb_priv {
 /* -------------------------------------------------------------------------- */
 
 #ifdef DEBUG
-/*
- * These patterns are written into the c67x00 internal memory and the
- * urb->transfer_buffer respectively in order to simplify debugging.
- */
-#define NON_RECEIVED_PATTERN	0xac
-#define UNREAD_PATTERN		0x0c
-/* #define DEBUG_PATTERN */
 
 /**
  * dbg_td - Dump the contents of the TD
  */
 static void dbg_td(struct c67x00_hcd *c67x00, struct c67x00_td *td, char *msg)
 {
-	struct device *dev = c67x00_hcd_dev(c67x00);
-	int i, len = td_length(td);
+	struct device *dev = c67x00_dev(c67x00);
+
 	dev_dbg(dev, "### %s at 0x%04x\n", msg, td->td_addr);
 	dev_dbg(dev, "urb:      0x%p\n", td->urb);
 	dev_dbg(dev, "endpoint:   %4d\n", usb_pipeendpoint(td->pipe));
@@ -173,12 +166,8 @@ static void dbg_td(struct c67x00_hcd *c67x00, struct c67x00_td *td, char *msg)
 	dev_dbg(dev, "residue:        0x%02x\n", td->residue);
 	dev_dbg(dev, "next_td_addr: 0x%04x\n", td_next_td_addr(td));
 	dev_dbg(dev, "data:");
-	for (i = 0; i < len; i++) {
-		if (!(i % 8))
-			printk("\n     ");
-		printk("  0x%02x", td->data[i]);
-	}
-	printk("\n");
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 16, 1,
+		       td->data, td_length(td), 1);
 }
 #else				/* DEBUG */
 
@@ -190,8 +179,6 @@ dbg_td(struct c67x00_hcd *c67x00, struct c67x00_td *td, char *msg) { }
 /* -------------------------------------------------------------------------- */
 /* Helper functions */
 
-/* -------------------------------------------------------------------------- */
-
 static inline u16 c67x00_get_current_frame_number(struct c67x00_hcd *c67x00)
 {
 	u16 temp_val;
@@ -254,12 +241,10 @@ static void c67x00_release_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 	 *   * only clear when needed
 	 *   * keep a list of tds with earch urbp
 	 */
-	list_for_each_entry(td, &c67x00->td_list, td_list) {
+	list_for_each_entry(td, &c67x00->td_list, td_list)
 		if (urb == td->urb)
 			td->urb = NULL;
-	}
 
-	/* Discard the urb private data */
 	urbp = urb->hcpriv;
 	urb->hcpriv = NULL;
 	list_del(&urbp->hep_node);
@@ -271,10 +256,8 @@ static void c67x00_release_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 static struct c67x00_ep_data *
 c67x00_ep_data_alloc(struct c67x00_hcd *c67x00, struct urb *urb)
 {
-	//struct usb_device *udev = urb->dev;
 	struct usb_host_endpoint *hep = urb->ep;
 	struct c67x00_ep_data *ep_data;
-	struct c67x00_ep_data *prev;
 	int type;
 
 	c67x00->current_frame = c67x00_get_current_frame_number(c67x00);
@@ -306,11 +289,13 @@ c67x00_ep_data_alloc(struct c67x00_hcd *c67x00, struct urb *urb)
 	ep_data->next_frame = frame_add(c67x00->current_frame, 1);
 
 	/* Add the endpoint data to one of the pipe lists; must be added
-	 * in order of endpoint address */
+	   in order of endpoint address */
 	type = usb_pipetype(urb->pipe);
 	if (list_empty(&ep_data->node)) {
 		list_add(&ep_data->node, &c67x00->list[type]);
 	} else {
+		struct c67x00_ep_data *prev;
+
 		list_for_each_entry(prev, &c67x00->list[type], node) {
 			if (prev->hep->desc.bEndpointAddress >
 			    hep->desc.bEndpointAddress) {
@@ -326,6 +311,7 @@ c67x00_ep_data_alloc(struct c67x00_hcd *c67x00, struct urb *urb)
 static int c67x00_ep_data_free(struct usb_host_endpoint *hep)
 {
 	struct c67x00_ep_data *ep_data = hep->hcpriv;
+
 	if (!ep_data)
 		return 0;
 
@@ -348,11 +334,11 @@ void c67x00_endpoint_disable(struct usb_hcd *hcd, struct usb_host_endpoint *ep)
 	unsigned long flags;
 
 	if (!list_empty(&ep->urb_list))
-		dev_warn(c67x00_hcd_dev(c67x00), "error: urb list not empty\n");
+		dev_warn(c67x00_dev(c67x00), "error: urb list not empty\n");
 
 	spin_lock_irqsave(&c67x00->lock, flags);
 
-	/* Loop waiting for all transfers in the endpoint queue to complete */
+	/* loop waiting for all transfers in the endpoint queue to complete */
 	while (c67x00_ep_data_free(ep)) {
 		/* Drop the lock so we can sleep waiting for the hardware */
 		spin_unlock_irqrestore(&c67x00->lock, flags);
@@ -384,7 +370,7 @@ int c67x00_urb_enqueue(struct usb_hcd *hcd,
 {
 	int ret;
 	unsigned long flags;
-	struct c67x00_urb_priv *urbp = NULL;
+	struct c67x00_urb_priv *urbp;
 	struct c67x00_hcd *c67x00 = hcd_to_c67x00_hcd(hcd);
 	int port = get_root_port(urb->dev)-1;
 
@@ -406,11 +392,13 @@ int c67x00_urb_enqueue(struct usb_hcd *hcd,
 		ret = -ENOMEM;
 		goto err_urbp;
 	}
+
 	INIT_LIST_HEAD(&urbp->hep_node);
 	urbp->urb = urb;
 	urbp->port = port;
 
 	urbp->ep_data = c67x00_ep_data_alloc(c67x00, urb);
+
 	if (!urbp->ep_data) {
 		ret = -ENOMEM;
 		goto err_epdata;
@@ -443,7 +431,8 @@ int c67x00_urb_enqueue(struct usb_hcd *hcd,
 			struct urb *last_urb;
 
 			last_urb = list_entry(urbp->ep_data->queue.prev,
-					      struct c67x00_urb_priv, hep_node)->urb;
+					      struct c67x00_urb_priv,
+					      hep_node)->urb;
 			urb->start_frame =
 			    frame_add(last_urb->start_frame,
 				      last_urb->number_of_packets *
@@ -456,22 +445,22 @@ int c67x00_urb_enqueue(struct usb_hcd *hcd,
 	/* Add the URB to the endpoint queue */
 	list_add_tail(&urbp->hep_node, &urbp->ep_data->queue);
 
-	/* If this is the only urb, kick start the controller */
+	/* If this is the only URB, kick start the controller */
 	if (!c67x00->urb_count++)
 		c67x00_ll_hpi_enable_sofeop(c67x00->sie);
 
 	c67x00_sched_kick(c67x00);
-
 	spin_unlock_irqrestore(&c67x00->lock, flags);
+
 	return 0;
 
-	/* Something went wrong; unwind the allocations */
- err_epdata:
+err_epdata:
 	kfree(urbp);
- err_urbp:
+err_urbp:
 	usb_hcd_unlink_urb_from_ep(hcd, urb);
- err_not_linked:
+err_not_linked:
 	spin_unlock_irqrestore(&c67x00->lock, flags);
+
 	return ret;
 }
 
@@ -487,6 +476,12 @@ int c67x00_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		goto done;
 
 	c67x00_release_urb(c67x00, urb);
+	usb_hcd_unlink_urb_from_ep(hcd, urb);
+	spin_unlock_irqrestore(&c67x00->lock, flags);
+
+	usb_hcd_giveback_urb(hcd, urb, status);
+
+	return 0;
 
 done:
 	spin_unlock_irqrestore(&c67x00->lock, flags);
@@ -502,6 +497,7 @@ static inline void
 c67x00_giveback_urb(struct c67x00_hcd *c67x00, struct urb *urb, int status)
 {
 	struct c67x00_urb_priv *urbp;
+
 	if (!urb)
 		return;
 
@@ -515,8 +511,8 @@ c67x00_giveback_urb(struct c67x00_hcd *c67x00, struct urb *urb, int status)
 
 /* -------------------------------------------------------------------------- */
 
-static int claim_frame_bw(struct c67x00_hcd *c67x00, struct urb *urb,
-			  int len, int periodic)
+static int c67x00_claim_frame_bw(struct c67x00_hcd *c67x00, struct urb *urb,
+				 int len, int periodic)
 {
 	struct c67x00_urb_priv *urbp = urb->hcpriv;
 	int bit_time;
@@ -583,10 +579,9 @@ static int claim_frame_bw(struct c67x00_hcd *c67x00, struct urb *urb,
 /**
  * td_addr and buf_addr must be word aligned
  */
-static int create_td(struct c67x00_hcd *c67x00,
-		     struct urb *urb,
-		     char *data,
-		     int len, int pid, int toggle, unsigned long privdata)
+static int c67x00_create_td(struct c67x00_hcd *c67x00, struct urb *urb,
+			    void *data, int len, int pid, int toggle,
+			    unsigned long privdata)
 {
 	struct c67x00_td *td;
 	struct c67x00_urb_priv *urbp = urb->hcpriv;
@@ -594,8 +589,8 @@ static int create_td(struct c67x00_hcd *c67x00,
 	__u8 cmd = 0;
 	int tt = 0;
 
-	if (claim_frame_bw(c67x00, urb, len,
-			   usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe)))
+	if (c67x00_claim_frame_bw(c67x00, urb, len, usb_pipeisoc(urb->pipe)
+				  || usb_pipeint(urb->pipe)))
 		return -EMSGSIZE;	/* Not really an error, but expected */
 
 	td = kzalloc(sizeof(*td), GFP_ATOMIC);
@@ -658,7 +653,7 @@ static int create_td(struct c67x00_hcd *c67x00,
 	return 0;
 }
 
-static inline void release_td(struct c67x00_td *td)
+static inline void c67x00_release_td(struct c67x00_td *td)
 {
 	list_del_init(&td->td_list);
 	kfree(td);
@@ -666,7 +661,7 @@ static inline void release_td(struct c67x00_td *td)
 
 /* -------------------------------------------------------------------------- */
 
-static int add_data_urb(struct c67x00_hcd *c67x00, struct urb *urb)
+static int c67x00_add_data_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 {
 	int remaining;
 	int toggle;
@@ -695,8 +690,8 @@ static int add_data_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 		pid = usb_pipeout(urb->pipe) ? USB_PID_OUT : USB_PID_IN;
 		td_buf = urb->transfer_buffer + urb->transfer_buffer_length -
 		    remaining;
-		ret = create_td(c67x00, urb, td_buf, len, pid, toggle,
-				DATA_STAGE);
+		ret = c67x00_create_td(c67x00, urb, td_buf, len, pid, toggle,
+				       DATA_STAGE);
 		if (ret)
 			goto out;	/* td wasn't created */
 		toggle ^= 1;
@@ -704,15 +699,14 @@ static int add_data_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 		if (usb_pipecontrol(urb->pipe))
 			break;
 	}
-      out:
+out:
 	return ret;
 }
 
 /**
- *
  * return 0 in case more bandwidth is available, else errorcode
  */
-static int add_ctrl_urb(struct c67x00_hcd *c67x00, struct urb *urb)
+static int c67x00_add_ctrl_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 {
 	int ret;
 	int pid;
@@ -720,9 +714,8 @@ static int add_ctrl_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 	switch (urb->interval) {
 	default:
 	case SETUP_STAGE:
-		ret = create_td(c67x00, urb,
-				urb->setup_packet,
-				8, USB_PID_SETUP, 0, SETUP_STAGE);
+		ret = c67x00_create_td(c67x00, urb, urb->setup_packet,
+				       8, USB_PID_SETUP, 0, SETUP_STAGE);
 		if (ret)
 			return ret;
 		urb->interval = SETUP_STAGE;
@@ -731,14 +724,15 @@ static int add_ctrl_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 		break;
 	case DATA_STAGE:
 		if (urb->transfer_buffer_length) {
-			ret = add_data_urb(c67x00, urb);
+			ret = c67x00_add_data_urb(c67x00, urb);
 			if (ret)
 				return ret;
 			break;
 		}		/* else fallthrough */
 	case STATUS_STAGE:
 		pid = !usb_pipeout(urb->pipe) ? USB_PID_OUT : USB_PID_IN;
-		ret = create_td(c67x00, urb, NULL, 0, pid, 1, STATUS_STAGE);
+		ret = c67x00_create_td(c67x00, urb, NULL, 0, pid, 1,
+				       STATUS_STAGE);
 		if (ret)
 			return ret;
 		break;
@@ -750,19 +744,19 @@ static int add_ctrl_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 /*
  * return 0 in case more bandwidth is available, else errorcode
  */
-static int add_int_urb(struct c67x00_hcd *c67x00, struct urb *urb)
+static int c67x00_add_int_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 {
 	struct c67x00_urb_priv *urbp = urb->hcpriv;
 
 	if (frame_after_eq(c67x00->current_frame, urbp->ep_data->next_frame)) {
 		urbp->ep_data->next_frame =
 		    frame_add(urbp->ep_data->next_frame, urb->interval);
-		return add_data_urb(c67x00, urb);
+		return c67x00_add_data_urb(c67x00, urb);
 	}
 	return 0;
 }
 
-static int add_iso_urb(struct c67x00_hcd *c67x00, struct urb *urb)
+static int c67x00_add_iso_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 {
 	struct c67x00_urb_priv *urbp = urb->hcpriv;
 
@@ -777,7 +771,8 @@ static int add_iso_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 		len = urb->iso_frame_desc[urbp->cnt].length;
 		pid = usb_pipeout(urb->pipe) ? USB_PID_OUT : USB_PID_IN;
 
-		ret = create_td(c67x00, urb, td_buf, len, pid, 0, urbp->cnt);
+		ret = c67x00_create_td(c67x00, urb, td_buf, len, pid, 0,
+				       urbp->cnt);
 		if (ret) {
 			printk(KERN_DEBUG "create failed: %d\n", ret);
 			urb->iso_frame_desc[urbp->cnt].actual_length = 0;
@@ -806,7 +801,8 @@ static void c67x00_fill_from_list(struct c67x00_hcd *c67x00, int type,
 		if (!list_empty(&ep_data->queue)) {
 			/* and add the first urb */
 			/* isochronous transfer rely on this */
-			urb = list_entry(ep_data->queue.next, struct c67x00_urb_priv,
+			urb = list_entry(ep_data->queue.next,
+					 struct c67x00_urb_priv,
 					 hep_node)->urb;
 			add(c67x00, urb);
 		}
@@ -819,11 +815,11 @@ static void c67x00_fill_frame(struct c67x00_hcd *c67x00)
 
 	/* Check if we can proceed */
 	if (!list_empty(&c67x00->td_list)) {
-		dev_warn(c67x00_hcd_dev(c67x00),
+		dev_warn(c67x00_dev(c67x00),
 			 "TD list not empty! This should not happen!\n");
 		list_for_each_entry_safe(td, ttd, &c67x00->td_list, td_list) {
 			dbg_td(c67x00, td, "Unprocessed td");
-			release_td(td);
+			c67x00_release_td(td);
 		}
 	}
 
@@ -835,10 +831,10 @@ static void c67x00_fill_frame(struct c67x00_hcd *c67x00)
 	c67x00->next_buf_addr = c67x00->buf_base_addr;
 
 	/* Fill the list */
-	c67x00_fill_from_list(c67x00, PIPE_ISOCHRONOUS, add_iso_urb);
-	c67x00_fill_from_list(c67x00, PIPE_INTERRUPT, add_int_urb);
-	c67x00_fill_from_list(c67x00, PIPE_CONTROL, add_ctrl_urb);
-	c67x00_fill_from_list(c67x00, PIPE_BULK, add_data_urb);
+	c67x00_fill_from_list(c67x00, PIPE_ISOCHRONOUS, c67x00_add_iso_urb);
+	c67x00_fill_from_list(c67x00, PIPE_INTERRUPT, c67x00_add_int_urb);
+	c67x00_fill_from_list(c67x00, PIPE_CONTROL, c67x00_add_ctrl_urb);
+	c67x00_fill_from_list(c67x00, PIPE_BULK, c67x00_add_data_urb);
 }
 
 /* -------------------------------------------------------------------------- */
@@ -849,19 +845,15 @@ static void c67x00_fill_frame(struct c67x00_hcd *c67x00)
 static inline void
 c67x00_parse_td(struct c67x00_hcd *c67x00, struct c67x00_td *td)
 {
-	c67x00_ll_hpi_read_mem_le16(c67x00->sie->dev, td->td_addr, CY_TD_SIZE,
-				    (char *)td);
+	c67x00_ll_read_mem_le16(c67x00->sie->dev,
+				td->td_addr, td, CY_TD_SIZE);
 
 	if (usb_pipein(td->pipe) && td_actual_bytes(td))
-		c67x00_ll_hpi_read_mem_le16(c67x00->sie->dev,
-					    td_ly_base_addr(td),
-					    td_actual_bytes(td), td->data);
+		c67x00_ll_read_mem_le16(c67x00->sie->dev, td_ly_base_addr(td),
+					td->data, td_actual_bytes(td));
 }
 
-/* -------------------------------------------------------------------------- */
-
-static int
-c67x00_td_to_error(struct c67x00_hcd *c67x00, struct c67x00_td *td)
+static int c67x00_td_to_error(struct c67x00_hcd *c67x00, struct c67x00_td *td)
 {
 	if (td->status & TD_STATUSMASK_ERR) {
 		dbg_td(c67x00, td, "ERROR_FLAG");
@@ -910,8 +902,8 @@ static inline int c67x00_end_of_data(struct c67x00_td *td)
 /* Remove all td's from the list which come
  * after last_td and are meant for the same pipe.
  * This is used when a short packet has occured */
-static inline void
-c67x00_clear_pipe(struct c67x00_hcd *c67x00, struct c67x00_td *last_td)
+static inline void c67x00_clear_pipe(struct c67x00_hcd *c67x00,
+				     struct c67x00_td *last_td)
 {
 	struct c67x00_td *td, *tmp;
 	td = last_td;
@@ -919,7 +911,7 @@ c67x00_clear_pipe(struct c67x00_hcd *c67x00, struct c67x00_td *last_td)
 	while (td->td_list.next != &c67x00->td_list) {
 		td = list_entry(td->td_list.next, struct c67x00_td, td_list);
 		if (td->pipe == last_td->pipe) {
-			release_td(td);
+			c67x00_release_td(td);
 			td = tmp;
 		}
 		tmp = td;
@@ -929,7 +921,7 @@ c67x00_clear_pipe(struct c67x00_hcd *c67x00, struct c67x00_td *last_td)
 /* -------------------------------------------------------------------------- */
 
 static void c67x00_handle_successful_td(struct c67x00_hcd *c67x00,
-				 struct c67x00_td *td)
+					struct c67x00_td *td)
 {
 	struct urb *urb = td->urb;
 
@@ -949,18 +941,21 @@ static void c67x00_handle_successful_td(struct c67x00_hcd *c67x00,
 			/* Don't count setup_packet with normal data: */
 			urb->actual_length = 0;
 			break;
+
 		case DATA_STAGE:
 			if (c67x00_end_of_data(td)) {
 				urb->interval = STATUS_STAGE;
 				c67x00_clear_pipe(c67x00, td);
 			}
 			break;
+
 		case STATUS_STAGE:
 			urb->interval = 0;
 			c67x00_giveback_urb(c67x00, urb, 0);
 			break;
 		}
 		break;
+
 	case PIPE_INTERRUPT:
 	case PIPE_BULK:
 		if (unlikely(c67x00_end_of_data(td))) {
@@ -1023,7 +1018,8 @@ static inline void c67x00_check_td_list(struct c67x00_hcd *c67x00)
 		 * inactive state. This state matches successful transfers so
 		 * we must make sure not to service them. */
 		if (td->status & TD_ERROR_MASK) {
-			c67x00_giveback_urb(c67x00, urb, c67x00_td_to_error(c67x00, td));
+			c67x00_giveback_urb(c67x00, urb,
+					    c67x00_td_to_error(c67x00, td));
 			goto cont;
 		}
 
@@ -1045,7 +1041,7 @@ static inline void c67x00_check_td_list(struct c67x00_hcd *c67x00)
 		clear_endpoint = 0;
 		c67x00_handle_successful_td(c67x00, td);
 
-	  cont:
+	cont:
 		if (clear_endpoint)
 			c67x00_clear_pipe(c67x00, td);
 		if (ack_ok)
@@ -1054,7 +1050,7 @@ static inline void c67x00_check_td_list(struct c67x00_hcd *c67x00)
 				      !(td->ctrl_reg & SEQ_SEL));
 		/* next in list could have been removed, due to clear_pipe! */
 		tmp = list_entry(td->td_list.next, typeof(*td), td_list);
-		release_td(td);
+		c67x00_release_td(td);
 	}
 }
 
@@ -1076,12 +1072,11 @@ static void c67x00_send_td(struct c67x00_hcd *c67x00, struct c67x00_td *td)
 	int len = td_length(td);
 
 	if (len && ((td->pid_ep & TD_PIDEPMASK_PID) != TD_PID_IN))
-		c67x00_ll_hpi_write_mem_le16(c67x00->sie->dev,
-					     td_ly_base_addr(td),
-					     len, td->data);
+		c67x00_ll_write_mem_le16(c67x00->sie->dev, td_ly_base_addr(td),
+					 td->data, len);
 
-	c67x00_ll_hpi_write_mem_le16(c67x00->sie->dev, td->td_addr,
-				     CY_TD_SIZE, (char *)td);
+	c67x00_ll_write_mem_le16(c67x00->sie->dev,
+				 td->td_addr, td, CY_TD_SIZE);
 }
 
 static void c67x00_send_frame(struct c67x00_hcd *c67x00)
@@ -1089,7 +1084,7 @@ static void c67x00_send_frame(struct c67x00_hcd *c67x00)
 	struct c67x00_td *td;
 
 	if (list_empty(&c67x00->td_list))
-		dev_warn(c67x00_hcd_dev(c67x00),
+		dev_warn(c67x00_dev(c67x00),
 			 "%s: td list should not be empty here!\n",
 			 __FUNCTION__);
 
@@ -1136,15 +1131,11 @@ static void c67x00_do_work(struct c67x00_hcd *c67x00)
 	}
 
 	c67x00_fill_frame(c67x00);
-	if (list_empty(&c67x00->td_list))
-		/* URBs aren't for this frame */
-		goto out;
-	else {
+	if (!list_empty(&c67x00->td_list))
 		/* TD's have been added to the frame */
 		c67x00_send_frame(c67x00);
-		goto out;
-	}
- out:
+
+out:
 	spin_unlock(&c67x00->lock);
 }
 
@@ -1160,24 +1151,23 @@ static void c67x00_sched_done(unsigned long __c67x00)
 {
 	struct c67x00_hcd *c67x00 = (struct c67x00_hcd *)__c67x00;
 	struct c67x00_urb_priv *urbp, *tmp;
-	struct usb_hcd *hcd = c67x00_hcd_to_hcd(c67x00);
 	struct urb *urb;
-	int status;
 
 	spin_lock(&c67x00->lock);
 
 	/* Loop over the done list and give back all the urbs */
 	list_for_each_entry_safe(urbp, tmp, &c67x00->done_list, hep_node) {
 		urb = urbp->urb;
-		status = urbp->status;
-
 		c67x00_release_urb(c67x00, urb);
-
-		usb_hcd_unlink_urb_from_ep(hcd, urb);
-
-		spin_unlock(&c67x00->lock);
-		usb_hcd_giveback_urb(hcd, urb, status);
-		spin_lock(&c67x00->lock);
+		if (!usb_hcd_check_unlink_urb(c67x00_hcd_to_hcd(c67x00),
+					      urb, urbp->status)) {
+			usb_hcd_unlink_urb_from_ep(c67x00_hcd_to_hcd(c67x00),
+						   urb);
+			spin_unlock(&c67x00->lock);
+			usb_hcd_giveback_urb(c67x00_hcd_to_hcd(c67x00), urb,
+					     urbp->status);
+			spin_lock(&c67x00->lock);
+		}
 	}
 	spin_unlock(&c67x00->lock);
 }
diff --git a/drivers/usb/c67x00/c67x00.h b/drivers/usb/c67x00/c67x00.h
index 00a38df..35f81d7 100644
--- a/drivers/usb/c67x00/c67x00.h
+++ b/drivers/usb/c67x00/c67x00.h
@@ -1,7 +1,7 @@
 /*
  * c67x00.h: Cypress C67X00 USB register and field definitions
  *
- * Copyright (C) 2006-2007 Barco N.V.
+ * Copyright (C) 2006-2008 Barco N.V.
  *    Derived from the Cypress cy7c67200/300 ezusb linux driver and
  *    based on multiple host controller drivers inside the linux kernel.
  *
@@ -24,8 +24,7 @@
 #ifndef _USB_C67X00_H
 #define _USB_C67X00_H
 
-#include <linux/interrupt.h>
-#include <linux/list.h>
+#include <linux/spinlock.h>
 #include <linux/platform_device.h>
 #include <linux/completion.h>
 #include <linux/mutex.h>
@@ -34,9 +33,6 @@
  * Cypress C67x00 register definitions
  */
 
-/* Processor control registers */
-/* =========================== */
-
 /* Hardware Revision Register */
 #define HW_REV_REG		0xC004
 
@@ -44,12 +40,28 @@
 /* ===================== */
 
 /* USB Control Register */
-#define USB_CTL_REG(x)		( (x) ? 0xC0AA : 0xC08A )
+#define USB_CTL_REG(x)		((x) ? 0xC0AA : 0xC08A)
 
-#define LOW_SPEED_PORT(x)	( (x) ? 0x0800 : 0x0400 )
+#define LOW_SPEED_PORT(x)	((x) ? 0x0800 : 0x0400)
 #define HOST_MODE		0x0200
-#define PORT_RES_EN(x)		( (x) ? 0x0100 : 0x0080 )
-#define SOF_EOP_EN(x)		( (x) ? 0x0002 : 0x0001 )
+#define PORT_RES_EN(x)		((x) ? 0x0100 : 0x0080)
+#define SOF_EOP_EN(x)		((x) ? 0x0002 : 0x0001)
+
+/* USB status register - Notice it has different content in hcd/udc mode */
+#define USB_STAT_REG(x)		((x) ? 0xC0B0 : 0xC090)
+
+#define EP0_IRQ_FLG		0x0001
+#define EP1_IRQ_FLG		0x0002
+#define EP2_IRQ_FLG		0x0004
+#define EP3_IRQ_FLG		0x0008
+#define EP4_IRQ_FLG		0x0010
+#define EP5_IRQ_FLG		0x0020
+#define EP6_IRQ_FLG		0x0040
+#define EP7_IRQ_FLG		0x0080
+#define RESET_IRQ_FLG		0x0100
+#define SOF_EOP_IRQ_FLG		0x0200
+#define ID_IRQ_FLG		0x4000
+#define VBUS_IRQ_FLG		0x8000
 
 /* USB Host only registers */
 /* ======================= */
@@ -63,50 +75,119 @@
 #define ARM_EN			0x0001	/* Arm operation */
 
 /* Host n Interrupt Enable Register */
-#define HOST_IRQ_EN_REG(x)	( (x) ? 0xC0AC : 0xC08C)
+#define HOST_IRQ_EN_REG(x)	((x) ? 0xC0AC : 0xC08C)
 
 #define SOF_EOP_IRQ_EN		0x0200	/* SOF/EOP Interrupt Enable  */
+#define SOF_EOP_TMOUT_IRQ_EN	0x0800	/* SOF/EOP Timeout Interrupt Enable  */
+#define ID_IRQ_EN		0x4000	/* ID interrupt enable */
+#define VBUS_IRQ_EN		0x8000	/* VBUS interrupt enable */
 #define DONE_IRQ_EN		0x0001	/* Done Interrupt Enable  */
 
-/* Host n status register */
-#define HOST_STAT_REG(x)	( (x) ? 0xC0B0 : 0xC090 )
-
+/* USB status register */
 #define HOST_STAT_MASK		0x02FD
-#define SOF_EOP_IRQ_FLG		0x0200
-#define PORT_CONNECT_CHANGE(x)	( (x) ? 0x0020 : 0x0010 )
-#define PORT_SE0_STATUS(x)	( (x) ? 0x0008 : 0x0004 )
+#define PORT_CONNECT_CHANGE(x)	((x) ? 0x0020 : 0x0010)
+#define PORT_SE0_STATUS(x)	((x) ? 0x0008 : 0x0004)
 
 /* Host Frame Register */
-#define HOST_FRAME_REG(x)	( (x) ? 0xC0B6 : 0xC096 )
+#define HOST_FRAME_REG(x)	((x) ? 0xC0B6 : 0xC096)
 
 #define HOST_FRAME_MASK		0x07FF
 
+/* USB Peripheral only registers */
+/* ============================= */
+
+/* Device n Port Sel reg */
+#define DEVICE_N_PORT_SEL(x)	((x) ? 0xC0A4 : 0xC084)
+
+/* Device n Interrupt Enable Register */
+#define DEVICE_N_IRQ_EN_REG(x)	((x) ? 0xC0AC : 0xC08C)
+
+#define DEVICE_N_ENDPOINT_N_CTL_REG(dev, ep)	((dev)  		\
+						 ? (0x0280 + (ep << 4)) \
+						 : (0x0200 + (ep << 4)))
+#define DEVICE_N_ENDPOINT_N_STAT_REG(dev, ep)	((dev)			\
+						 ? (0x0286 + (ep << 4)) \
+						 : (0x0206 + (ep << 4)))
+
+#define DEVICE_N_ADDRESS(dev)	((dev) ? (0xC0AE) : (0xC08E))
+
 /* HPI registers */
 /* ============= */
 
 /* HPI Status register */
-#define SOFEOP_FLG(x)		(1 << ( (x) ? 12 : 10 ))
-#define SIEMSG_FLAG(x)		(1 << (4 + (x)))
+#define SOFEOP_FLG(x)		(1 << ((x) ? 12 : 10))
+#define SIEMSG_FLG(x)		(1 << (4 + (x)))
+#define RESET_FLG(x)		((x) ? 0x0200 : 0x0002)
+#define DONE_FLG(x)		(1 << (2 + (x)))
+#define RESUME_FLG(x)		(1 << (6 + (x)))
 #define MBX_OUT_FLG		0x0001	/* Message out available */
+#define MBX_IN_FLG		0x0100
+#define ID_FLG			0x4000
+#define VBUS_FLG		0x8000
 
 /* Interrupt routing register */
 #define HPI_IRQ_ROUTING_REG	0x0142
 
-#define SOFEOP_TO_HPI_EN(x)	( (x) ? 0x2000 : 0x0800 )
-#define SOFEOP_TO_CPU_EN(x)	( (x) ? 0x1000 : 0x0400 )
+#define HPI_SWAP_ENABLE(x)	((x) ? 0x0100 : 0x0001)
+#define RESET_TO_HPI_ENABLE(x)	((x) ? 0x0200 : 0x0002)
+#define DONE_TO_HPI_ENABLE(x)	((x) ? 0x0008 : 0x0004)
+#define RESUME_TO_HPI_ENABLE(x)	((x) ? 0x0080 : 0x0040)
+#define SOFEOP_TO_HPI_EN(x)	((x) ? 0x2000 : 0x0800)
+#define SOFEOP_TO_CPU_EN(x)	((x) ? 0x1000 : 0x0400)
+#define ID_TO_HPI_ENABLE	0x4000
+#define VBUS_TO_HPI_ENABLE	0x8000
 
 /* SIE msg registers */
-#define SIEMSG_REG(x)		( (x) ? 0x0148 : 0x0144 )
+#define SIEMSG_REG(x)		((x) ? 0x0148 : 0x0144)
 
 #define HUSB_TDListDone		0x1000
 
+#define SUSB_EP0_MSG		0x0001
+#define SUSB_EP1_MSG		0x0002
+#define SUSB_EP2_MSG		0x0004
+#define SUSB_EP3_MSG		0x0008
+#define SUSB_EP4_MSG		0x0010
+#define SUSB_EP5_MSG		0x0020
+#define SUSB_EP6_MSG		0x0040
+#define SUSB_EP7_MSG		0x0080
+#define SUSB_RST_MSG		0x0100
+#define SUSB_SOF_MSG		0x0200
+#define SUSB_CFG_MSG		0x0400
+#define SUSB_SUS_MSG		0x0800
+#define SUSB_ID_MSG	       	0x4000
+#define SUSB_VBUS_MSG		0x8000
+
+/* BIOS interrupt routines */
+
+#define SUSBx_RECEIVE_INT(x)	((x) ? 97 : 81)
+#define SUSBx_SEND_INT(x)	((x) ? 96 : 80)
+
+#define SUSBx_DEV_DESC_VEC(x)	((x) ? 0x00D4 : 0x00B4)
+#define SUSBx_CONF_DESC_VEC(x)	((x) ? 0x00D6 : 0x00B6)
+#define SUSBx_STRING_DESC_VEC(x) ((x) ? 0x00D8 : 0x00B8)
+
 #define CY_HCD_BUF_ADDR		0x500	/* Base address for host */
 #define SIE_TD_SIZE		0x200	/* size of the td list */
 #define SIE_TD_BUF_SIZE		0x400	/* size of the data buffer */
 
-#define SIE_TD_OFFSET(host)	( (host) ? (SIE_TD_SIZE+SIE_TD_BUF_SIZE) : 0 )
+#define SIE_TD_OFFSET(host)	((host) ? (SIE_TD_SIZE+SIE_TD_BUF_SIZE) : 0)
 #define SIE_BUF_OFFSET(host)	(SIE_TD_OFFSET(host) + SIE_TD_SIZE)
 
+/* Base address of HCD + 2 x TD_SIZE + 2 x TD_BUF_SIZE */
+#define CY_UDC_REQ_HEADER_BASE	0x1100
+/* 8- byte request headers for IN/OUT transfers */
+#define CY_UDC_REQ_HEADER_SIZE	8
+
+#define CY_UDC_REQ_HEADER_ADDR(ep_num)	(CY_UDC_REQ_HEADER_BASE + \
+					 ((ep_num) * CY_UDC_REQ_HEADER_SIZE))
+#define CY_UDC_DESC_BASE_ADDRESS	(CY_UDC_REQ_HEADER_ADDR(8))
+
+#define CY_UDC_BIOS_REPLACE_BASE	0x1800
+#define CY_UDC_REQ_BUFFER_BASE		0x2000
+#define CY_UDC_REQ_BUFFER_SIZE		0x0400
+#define CY_UDC_REQ_BUFFER_ADDR(ep_num)	(CY_UDC_REQ_BUFFER_BASE + \
+					 ((ep_num) * CY_UDC_REQ_BUFFER_SIZE))
+
 /* ---------------------------------------------------------------------
  * Driver data structures
  */
@@ -114,44 +195,19 @@
 struct c67x00_device;
 
 /**
- * struct c67x00_lcp
- */
-struct c67x00_lcp {
-	/* Internal use only */
-	struct mutex mutex;
-	struct completion msg_received;
-	u16 last_msg;
-};
-
-/**
- * struct c67x00_lcp_data
- */
-#define COMM_REGS 14
-struct c67x00_lcp_int_data {
-	u16 regs[COMM_REGS];
-};
-
-/**
- * struct c67x00_sie - Common data associated with an SIE
+ * struct c67x00_sie - Common data associated with a SIE
  * @lock: lock to protect this struct
  * @private_data: subdriver dependent data
- * @pdev: platform device associated with this SIE, created in c67x00-drv.c
- * @irq: subdriver depenent irq handler, set NULL when not used
- * @msg_received: called when an SIEmsg has been received
+ * @irq: subdriver dependent irq handler, set NULL when not used
  * @dev: link to common driver structure
  * @sie_num: SIE number on chip, starting from 0
  * @mode: SIE mode (host/peripheral/otg/not used)
- *
- * Each SIE has a separate platform_device associated with it, because the
- * hcd needs such a device for itself (TODO: use a struct device instead
- * of a new platform device).
  */
 struct c67x00_sie {
 	/* Entries to be used by the subdrivers */
 	spinlock_t lock;	/* protect this structure */
 	void *private_data;
-	struct platform_device *pdev;
-	void (*irq) (struct c67x00_sie * sie, u16 msg);
+	void (*irq) (struct c67x00_sie *sie, u16 int_status, u16 msg);
 
 	/* Read only: */
 	struct c67x00_device *dev;
@@ -159,80 +215,80 @@ struct c67x00_sie {
 	int mode;
 };
 
-#define sie_dev(s)	(&(s)->pdev->dev)
+#define sie_dev(s)	(&(s)->dev->pdev->dev)
+
+/**
+ * struct c67x00_lcp
+ */
+struct c67x00_lcp {
+	/* Internal use only */
+	struct mutex mutex;
+	struct completion msg_received;
+	u16 last_msg;
+};
 
+/*
+ * struct c67x00_hpi
+ */
 struct c67x00_hpi {
 	void __iomem *base;
 	int regstep;
+	spinlock_t lock;
+	struct c67x00_lcp lcp;
 };
 
 #define C67X00_SIES	2
 #define C67X00_PORTS	2
 
 /**
- * struct c67x00_device - Common data structure for a c67x00 instance
+ * struct c67x00_device - Common data associated with a c67x00 instance
  * @hpi: hpi addresses
  * @sie: array of sie's on this chip
+ * @pdev: platform device of instance
  * @pdata: configuration provided by the platform
- * @hw_lock: hardware lock
- * @int_status: interrupt status register, only valid in_interrupt()
- * @lcp: link control protocol dependent data
  */
 struct c67x00_device {
 	struct c67x00_hpi hpi;
 	struct c67x00_sie sie[C67X00_SIES];
 	struct platform_device *pdev;
 	struct c67x00_platform_data *pdata;
-	spinlock_t hw_lock;
-
-	u16 int_status;
-	struct c67x00_lcp lcp;
 };
 
 /* ---------------------------------------------------------------------
- * HCD setup and teardown hooks; defined here because these are the
- * only routines which are called directly by the core driver.
- */
-extern int c67x00_hcd_probe(struct c67x00_sie *sie);
-extern void c67x00_hcd_remove(struct c67x00_sie *sie);
-
-/* ---------------------------------------------------------------------
  * Low level interface functions
  */
 
-/* Host Port Interface (hpi) functions */
+/* Host Port Interface (HPI) functions */
 u16 c67x00_ll_hpi_status(struct c67x00_device *dev);
 void c67x00_ll_hpi_reg_init(struct c67x00_device *dev);
 void c67x00_ll_hpi_enable_sofeop(struct c67x00_sie *sie);
 void c67x00_ll_hpi_disable_sofeop(struct c67x00_sie *sie);
 
 /* General functions */
-u16 c67x00_ll_get_siemsg(struct c67x00_device *dev, int sie);
-void c67x00_ll_set_siemsg(struct c67x00_device *dev, int sie, u16 val);
+u16 c67x00_ll_get_siemsg(struct c67x00_sie *sie);
+void c67x00_ll_set_siemsg(struct c67x00_sie *sie, u16 val);
 u16 c67x00_ll_get_usb_ctl(struct c67x00_sie *sie);
+void c67x00_ll_set_ep_ctrl_reg(struct c67x00_sie *sie, int ep_num, u16 val);
+void c67x00_ll_set_ep_packet_size_reg(struct c67x00_sie *sie, int ep_num,
+				      u16 val);
+void c67x00_ll_usb_clear_status(struct c67x00_sie *sie, u16 bits);
+u16 c67x00_ll_usb_get_status(struct c67x00_sie *sie);
+void c67x00_ll_write_mem_le16(struct c67x00_device *dev, u16 addr,
+			      void *data, int len);
+void c67x00_ll_read_mem_le16(struct c67x00_device *dev, u16 addr,
+			     void *data, int len);
 
 /* Host specific functions */
 void c67x00_ll_set_husb_eot(struct c67x00_device *dev, u16 value);
 void c67x00_ll_husb_reset(struct c67x00_sie *sie, int port);
 void c67x00_ll_husb_set_current_td(struct c67x00_sie *sie, u16 addr);
 u16 c67x00_ll_husb_get_current_td(struct c67x00_sie *sie);
-void c67x00_ll_husb_clear_status(struct c67x00_sie *sie, u16 bits);
-u16 c67x00_ll_husb_get_status(struct c67x00_sie *sie);
 u16 c67x00_ll_husb_get_frame(struct c67x00_sie *sie);
 void c67x00_ll_husb_init_host_port(struct c67x00_sie *sie);
 void c67x00_ll_husb_reset_port(struct c67x00_sie *sie, int port);
 
-/* Slave specific functions */
-void c67x00_ll_susb_init(struct c67x00_sie *sie);
-
-/* Read and write to memory */
-void c67x00_ll_hpi_write_mem_le16(struct c67x00_device *dev, u16 addr,
-				  int len, char *data);
-void c67x00_ll_hpi_read_mem_le16(struct c67x00_device *dev, u16 addr,
-				 int len, char *data);
-
 /* Called by c67x00_irq to handle lcp interrupts */
-void c67x00_ll_irq(struct c67x00_device *dev);
+void c67x00_ll_irq(struct c67x00_device *dev, u16 int_status);
 
 /* Setup and teardown */
 void c67x00_ll_init(struct c67x00_device *dev);
diff --git a/include/linux/usb/c67x00.h b/include/linux/usb/c67x00.h
index 80b1a87..3a4b9ce 100644
--- a/include/linux/usb/c67x00.h
+++ b/include/linux/usb/c67x00.h
@@ -25,17 +25,20 @@
 /* SIE configuration */
 #define C67X00_SIE_UNUSED	0
 #define C67X00_SIE_HOST		1
-#define C67X00_SIE_PERIPHERAL	2
+#define C67X00_SIE_PERIPHERAL_A	2	/* peripheral on A port */
+#define C67X00_SIE_PERIPHERAL_B	3	/* peripheral on B port */
 
 #define c67x00_sie_config(config, n)  (((config)>>(4*(n)))&0x3)
 
-#define C67X00_SIE1_UNUSED	(C67X00_SIE_UNUSED	<< 0)
-#define C67X00_SIE1_HOST	(C67X00_SIE_HOST	<< 0)
-#define C67X00_SIE1_PERIPHERAL	(C67X00_SIE_PERIPHERAL	<< 0)
+#define C67X00_SIE1_UNUSED	        (C67X00_SIE_UNUSED		<< 0)
+#define C67X00_SIE1_HOST	        (C67X00_SIE_HOST		<< 0)
+#define C67X00_SIE1_PERIPHERAL_A        (C67X00_SIE_PERIPHERAL_A	<< 0)
+#define C67X00_SIE1_PERIPHERAL_B	(C67X00_SIE_PERIPHERAL_B	<< 0)
 
-#define C67X00_SIE2_UNUSED	(C67X00_SIE_UNUSED	<< 4)
-#define C67X00_SIE2_HOST	(C67X00_SIE_HOST	<< 4)
-#define C67X00_SIE2_PERIPHERAL	(C67X00_SIE_PERIPHERAL	<< 4)
+#define C67X00_SIE2_UNUSED	        (C67X00_SIE_UNUSED		<< 4)
+#define C67X00_SIE2_HOST	        (C67X00_SIE_HOST		<< 4)
+#define C67X00_SIE2_PERIPHERAL_A	(C67X00_SIE_PERIPHERAL_A	<< 4)
+#define C67X00_SIE2_PERIPHERAL_B	(C67X00_SIE_PERIPHERAL_B	<< 4)
 
 struct c67x00_platform_data {
 	int sie_config;			/* SIEs config (C67X00_SIEx_*) */

-- 
Bye, Peter Korsgaard

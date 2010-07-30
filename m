Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 133DDB6EDD
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jul 2010 00:53:00 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-usb@vger.kernel.org
Subject: [PATCH RFC] usb gadget: introduce usb_gadget_probe_driver
Date: Fri, 30 Jul 2010 16:49:14 +0200
Message-Id: <1280501361-13410-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Cliff Cai <cliff.cai@analog.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Dinh Nguyen <Dinh.Nguyen@freescale.com>, Tony Lindgren <tony@atomide.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Julia Lawall <julia@diku.dk>, Philipp Zabel <philipp.zabel@gmail.com>,
	Felipe Balbi <felipe.balbi@nokia.com>,
	Andrea Gelmini <andrea.gelmini@gelma.net>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Fabien Chouteau <fabien.chouteau@barco.com>,
	Dan Carpenter <error27@gmail.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Vladimir Zapolskiy <vzapolskiy@gmail.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Vincent Sanders <support@simtec.co.uk>, Marc Singer <elf@buici.com>,
	=?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Tobias Klauser <tklauser@distanz.ch>,
	Marc Kleine-Budde <m.kleine-budde@pengutronix.de>,
	Eirik Aanonsen <eaa@wprmedical.com>, Mike Frysinger <vapier@gentoo.org>,
	Thomas Dahlmann <dahlmann.thomas@arcor.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-geode@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>,
	Magnus Damm <damm@igel.co.jp>, Anton Vorontsov <avorontsov@ru.mvista.com>,
	Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org,
	Anatolij Gustschin <agust@denx.de>, Eric Miao <eric.y.miao@gmail.com>,
	=?UTF-8?q?N=C3=A9meth=20M=C3=A1rton?= <nm127@freemail.hu>,
	Jiri Kosina <jkosina@suse.cz>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michal Nazarewicz <m.nazarewicz@samsung.com>,
	Harro Haan <hrhaan@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cory Maccarrone <darkstar6262@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is like usb_gadget_register_driver with the only difference that it
gets the bind function as parameter instead of using driver->bind.  This
allows fixing section mismatches like

	WARNING: drivers/usb/gadget/g_printer.o(.data+0xc): Section mismatch in
	reference from the variable printer_driver to the function
	.init.text:printer_bind()
	The variable printer_driver references
	the function __init printer_bind()

by using usb_gadget_probe_driver with driver->bind = NULL.  When all
drivers are fixed to use the new function the bind member of struct
usb_gadget_driver can go away.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Michal Nazarewicz <m.nazarewicz@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
Hello,

there is an alternative patch in Greg's tree [1], but IMHO mine is
better as it doesn't need __ref.

Thoughts?

Uwe

[1] http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/usb/usb-gadget-section-mismatch-warning-fixed.patch
 drivers/usb/gadget/amd5536udc.c     |    9 +++++----
 drivers/usb/gadget/at91_udc.c       |    9 +++++----
 drivers/usb/gadget/atmel_usba_udc.c |    7 ++++---
 drivers/usb/gadget/ci13xxx_udc.c    |   16 ++++++++--------
 drivers/usb/gadget/dummy_hcd.c      |    8 ++++----
 drivers/usb/gadget/fsl_qe_udc.c     |   12 ++++++------
 drivers/usb/gadget/fsl_udc_core.c   |   10 +++++-----
 drivers/usb/gadget/goku_udc.c       |    9 +++++----
 drivers/usb/gadget/imx_udc.c        |    9 +++++----
 drivers/usb/gadget/langwell_udc.c   |    9 +++++----
 drivers/usb/gadget/lh7a40x_udc.c    |    9 +++++----
 drivers/usb/gadget/m66592-udc.c     |    9 +++++----
 drivers/usb/gadget/net2280.c        |    8 ++++----
 drivers/usb/gadget/omap_udc.c       |   10 +++++-----
 drivers/usb/gadget/pxa25x_udc.c     |    9 +++++----
 drivers/usb/gadget/pxa27x_udc.c     |   12 +++++++-----
 drivers/usb/gadget/r8a66597-udc.c   |    9 +++++----
 drivers/usb/gadget/s3c-hsotg.c      |    9 +++++----
 drivers/usb/gadget/s3c2410_udc.c    |   14 +++++++-------
 drivers/usb/musb/musb_gadget.c      |    8 ++++----
 include/linux/usb/gadget.h          |   27 ++++++++++++++++++++++++---
 21 files changed, 128 insertions(+), 94 deletions(-)

diff --git a/drivers/usb/gadget/amd5536udc.c b/drivers/usb/gadget/amd5536udc.c
index 731150d..c266c1e 100644
--- a/drivers/usb/gadget/amd5536udc.c
+++ b/drivers/usb/gadget/amd5536udc.c
@@ -1954,13 +1954,14 @@ static int setup_ep0(struct udc *dev)
 }
 
 /* Called by gadget driver to register itself */
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct udc		*dev = udc;
 	int			retval;
 	u32 tmp;
 
-	if (!driver || !driver->bind || !driver->setup
+	if (!driver || bind || !driver->setup
 			|| driver->speed != USB_SPEED_HIGH)
 		return -EINVAL;
 	if (!dev)
@@ -1972,7 +1973,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	dev->driver = driver;
 	dev->gadget.dev.driver = &driver->driver;
 
-	retval = driver->bind(&dev->gadget);
+	retval = bind(&dev->gadget);
 
 	/* Some gadget drivers use both ep0 directions.
 	 * NOTE: to gadget driver, ep0 is just one endpoint...
@@ -2000,7 +2001,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 
 	return 0;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 /* shutdown requests and disconnect from gadget */
 static void
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index eaa79c8..fc7bbb7 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1570,14 +1570,15 @@ static irqreturn_t at91_vbus_irq(int irq, void *_udc)
 	return IRQ_HANDLED;
 }
 
-int usb_gadget_register_driver (struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver (struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct at91_udc	*udc = &controller;
 	int		retval;
 
 	if (!driver
 			|| driver->speed < USB_SPEED_FULL
-			|| !driver->bind
+			|| !bind
 			|| !driver->setup) {
 		DBG("bad parameter.\n");
 		return -EINVAL;
@@ -1594,9 +1595,9 @@ int usb_gadget_register_driver (struct usb_gadget_driver *driver)
 	udc->enabled = 1;
 	udc->selfpowered = 1;
 
-	retval = driver->bind(&udc->gadget);
+	retval = bind(&udc->gadget);
 	if (retval) {
-		DBG("driver->bind() returned %d\n", retval);
+		DBG("bind() returned %d\n", retval);
 		udc->driver = NULL;
 		udc->gadget.dev.driver = NULL;
 		dev_set_drvdata(&udc->gadget.dev, NULL);
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index d623c7b..e4810c6 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1789,7 +1789,8 @@ out:
 	return IRQ_HANDLED;
 }
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct usba_udc *udc = &the_udc;
 	unsigned long flags;
@@ -1812,7 +1813,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	clk_enable(udc->pclk);
 	clk_enable(udc->hclk);
 
-	ret = driver->bind(&udc->gadget);
+	ret = bind(&udc->gadget);
 	if (ret) {
 		DBG(DBG_ERR, "Could not bind to driver %s: error %d\n",
 			driver->driver.name, ret);
@@ -1841,7 +1842,7 @@ err_driver_bind:
 	udc->gadget.dev.driver = NULL;
 	return ret;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 {
diff --git a/drivers/usb/gadget/ci13xxx_udc.c b/drivers/usb/gadget/ci13xxx_udc.c
index 6996951..83fc0d4 100644
--- a/drivers/usb/gadget/ci13xxx_udc.c
+++ b/drivers/usb/gadget/ci13xxx_udc.c
@@ -2340,12 +2340,13 @@ static const struct usb_ep_ops usb_ep_ops = {
 static const struct usb_gadget_ops usb_gadget_ops;
 
 /**
- * usb_gadget_register_driver: register a gadget driver
+ * usb_gadget_probe_driver: register a gadget driver
  *
- * Check usb_gadget_register_driver() at "usb_gadget.h" for details
- * Interrupts are enabled here
+ * Check usb_gadget_probe_driver() at "usb_gadget.h" for details.
+ * Interrupts are enabled here.
  */
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct ci13xxx *udc = _udc;
 	unsigned long i, k, flags;
@@ -2354,7 +2355,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	trace("%p", driver);
 
 	if (driver             == NULL ||
-	    driver->bind       == NULL ||
+	    bind               == NULL ||
 	    driver->unbind     == NULL ||
 	    driver->setup      == NULL ||
 	    driver->disconnect == NULL ||
@@ -2430,7 +2431,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	udc->gadget.dev.driver = &driver->driver;
 
 	spin_unlock_irqrestore(udc->lock, flags);
-	retval = driver->bind(&udc->gadget);                /* MAY SLEEP */
+	retval = bind(&udc->gadget);                /* MAY SLEEP */
 	spin_lock_irqsave(udc->lock, flags);
 
 	if (retval) {
@@ -2447,7 +2448,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 		usb_gadget_unregister_driver(driver);
 	return retval;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 /**
  * usb_gadget_unregister_driver: unregister a gadget driver
@@ -2462,7 +2463,6 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	trace("%p", driver);
 
 	if (driver             == NULL ||
-	    driver->bind       == NULL ||
 	    driver->unbind     == NULL ||
 	    driver->setup      == NULL ||
 	    driver->disconnect == NULL ||
diff --git a/drivers/usb/gadget/dummy_hcd.c b/drivers/usb/gadget/dummy_hcd.c
index 4f9e578..e81c939 100644
--- a/drivers/usb/gadget/dummy_hcd.c
+++ b/drivers/usb/gadget/dummy_hcd.c
@@ -748,7 +748,8 @@ static DEVICE_ATTR (function, S_IRUGO, show_function, NULL);
  */
 
 int
-usb_gadget_register_driver (struct usb_gadget_driver *driver)
+usb_gadget_probe_driver (struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct dummy	*dum = the_controller;
 	int		retval, i;
@@ -757,8 +758,7 @@ usb_gadget_register_driver (struct usb_gadget_driver *driver)
 		return -EINVAL;
 	if (dum->driver)
 		return -EBUSY;
-	if (!driver->bind || !driver->setup
-			|| driver->speed == USB_SPEED_UNKNOWN)
+	if (!bind || !driver->setup || driver->speed == USB_SPEED_UNKNOWN)
 		return -EINVAL;
 
 	/*
@@ -796,7 +796,7 @@ usb_gadget_register_driver (struct usb_gadget_driver *driver)
 	dum->gadget.dev.driver = &driver->driver;
 	dev_dbg (udc_dev(dum), "binding gadget driver '%s'\n",
 			driver->driver.name);
-	retval = driver->bind(&dum->gadget);
+	retval = bind(&dum->gadget);
 	if (retval) {
 		dum->driver = NULL;
 		dum->gadget.dev.driver = NULL;
diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index 82506ca..9b4f4b5 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2301,9 +2301,10 @@ static irqreturn_t qe_udc_irq(int irq, void *_udc)
 }
 
 /*-------------------------------------------------------------------------
-	Gadget driver register and unregister.
+	Gadget driver probe and unregister.
  --------------------------------------------------------------------------*/
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	int retval;
 	unsigned long flags = 0;
@@ -2314,8 +2315,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 
 	if (!driver || (driver->speed != USB_SPEED_FULL
 			&& driver->speed != USB_SPEED_HIGH)
-			|| !driver->bind || !driver->disconnect
-			|| !driver->setup)
+			|| !bind || !driver->disconnect || !driver->setup)
 		return -EINVAL;
 
 	if (udc_controller->driver)
@@ -2331,7 +2331,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	udc_controller->gadget.speed = (enum usb_device_speed)(driver->speed);
 	spin_unlock_irqrestore(&udc_controller->lock, flags);
 
-	retval = driver->bind(&udc_controller->gadget);
+	retval = bind(&udc_controller->gadget);
 	if (retval) {
 		dev_err(udc_controller->dev, "bind to %s --> %d",
 				driver->driver.name, retval);
@@ -2352,7 +2352,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 		udc_controller->gadget.name, driver->driver.name);
 	return 0;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 {
diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 08a9a62..c16b402 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -1765,7 +1765,8 @@ static irqreturn_t fsl_udc_irq(int irq, void *_udc)
  * Hook to gadget drivers
  * Called by initialization code of gadget drivers
 *----------------------------------------------------------------*/
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	int retval = -ENODEV;
 	unsigned long flags = 0;
@@ -1775,8 +1776,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 
 	if (!driver || (driver->speed != USB_SPEED_FULL
 				&& driver->speed != USB_SPEED_HIGH)
-			|| !driver->bind || !driver->disconnect
-			|| !driver->setup)
+			|| !bind || !driver->disconnect || !driver->setup)
 		return -EINVAL;
 
 	if (udc_controller->driver)
@@ -1792,7 +1792,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	spin_unlock_irqrestore(&udc_controller->lock, flags);
 
 	/* bind udc driver to gadget driver */
-	retval = driver->bind(&udc_controller->gadget);
+	retval = bind(&udc_controller->gadget);
 	if (retval) {
 		VDBG("bind to %s --> %d", driver->driver.name, retval);
 		udc_controller->gadget.dev.driver = NULL;
@@ -1814,7 +1814,7 @@ out:
 		       retval);
 	return retval;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 /* Disconnect from gadget driver */
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
diff --git a/drivers/usb/gadget/goku_udc.c b/drivers/usb/gadget/goku_udc.c
index 1088d08..49fbd4d 100644
--- a/drivers/usb/gadget/goku_udc.c
+++ b/drivers/usb/gadget/goku_udc.c
@@ -1343,14 +1343,15 @@ static struct goku_udc	*the_controller;
  * disconnect is reported.  then a host may connect again, or
  * the driver might get unbound.
  */
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct goku_udc	*dev = the_controller;
 	int			retval;
 
 	if (!driver
 			|| driver->speed < USB_SPEED_FULL
-			|| !driver->bind
+			|| !bind
 			|| !driver->disconnect
 			|| !driver->setup)
 		return -EINVAL;
@@ -1363,7 +1364,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	driver->driver.bus = NULL;
 	dev->driver = driver;
 	dev->gadget.dev.driver = &driver->driver;
-	retval = driver->bind(&dev->gadget);
+	retval = bind(&dev->gadget);
 	if (retval) {
 		DBG(dev, "bind to driver %s --> error %d\n",
 				driver->driver.name, retval);
@@ -1380,7 +1381,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	DBG(dev, "registered gadget driver '%s'\n", driver->driver.name);
 	return 0;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 static void
 stop_activity(struct goku_udc *dev, struct usb_gadget_driver *driver)
diff --git a/drivers/usb/gadget/imx_udc.c b/drivers/usb/gadget/imx_udc.c
index e743122..ed02664 100644
--- a/drivers/usb/gadget/imx_udc.c
+++ b/drivers/usb/gadget/imx_udc.c
@@ -1319,14 +1319,15 @@ static struct imx_udc_struct controller = {
  * USB gadged driver functions
  *******************************************************************************
  */
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct imx_udc_struct *imx_usb = &controller;
 	int retval;
 
 	if (!driver
 		|| driver->speed < USB_SPEED_FULL
-		|| !driver->bind
+		|| !bind
 		|| !driver->disconnect
 		|| !driver->setup)
 			return -EINVAL;
@@ -1342,7 +1343,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	retval = device_add(&imx_usb->gadget.dev);
 	if (retval)
 		goto fail;
-	retval = driver->bind(&imx_usb->gadget);
+	retval = bind(&imx_usb->gadget);
 	if (retval) {
 		D_ERR(imx_usb->dev, "<%s> bind to driver %s --> error %d\n",
 			__func__, driver->driver.name, retval);
@@ -1362,7 +1363,7 @@ fail:
 	imx_usb->gadget.dev.driver = NULL;
 	return retval;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 {
diff --git a/drivers/usb/gadget/langwell_udc.c b/drivers/usb/gadget/langwell_udc.c
index a391351..e7222de 100644
--- a/drivers/usb/gadget/langwell_udc.c
+++ b/drivers/usb/gadget/langwell_udc.c
@@ -1807,7 +1807,8 @@ static DEVICE_ATTR(langwell_udc, S_IRUGO, show_langwell_udc, NULL);
  * the driver might get unbound.
  */
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct langwell_udc	*dev = the_controller;
 	unsigned long		flags;
@@ -1830,7 +1831,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	retval = driver->bind(&dev->gadget);
+	retval = bind(&dev->gadget);
 	if (retval) {
 		DBG(dev, "bind to driver %s --> %d\n",
 				driver->driver.name, retval);
@@ -1868,7 +1869,7 @@ err_unbind:
 	DBG(dev, "<--- %s()\n", __func__);
 	return retval;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 
 /* unregister gadget driver */
@@ -1882,7 +1883,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 
 	DBG(dev, "---> %s()\n", __func__);
 
-	if (unlikely(!driver || !driver->bind || !driver->unbind))
+	if (unlikely(!driver || !driver->unbind))
 		return -EINVAL;
 
 	/* unbind OTG transceiver */
diff --git a/drivers/usb/gadget/lh7a40x_udc.c b/drivers/usb/gadget/lh7a40x_udc.c
index fded3fc..470c45c 100644
--- a/drivers/usb/gadget/lh7a40x_udc.c
+++ b/drivers/usb/gadget/lh7a40x_udc.c
@@ -408,7 +408,8 @@ static void udc_enable(struct lh7a40x_udc *dev)
 /*
   Register entry point for the peripheral controller driver.
 */
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct lh7a40x_udc *dev = the_controller;
 	int retval;
@@ -417,7 +418,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 
 	if (!driver
 			|| driver->speed != USB_SPEED_FULL
-			|| !driver->bind
+			|| !bind
 			|| !driver->disconnect
 			|| !driver->setup)
 		return -EINVAL;
@@ -431,7 +432,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	dev->gadget.dev.driver = &driver->driver;
 
 	device_add(&dev->gadget.dev);
-	retval = driver->bind(&dev->gadget);
+	retval = bind(&dev->gadget);
 	if (retval) {
 		printk(KERN_WARNING "%s: bind to driver %s --> error %d\n",
 		       dev->gadget.name, driver->driver.name, retval);
@@ -454,7 +455,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	return 0;
 }
 
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 /*
   Unregister entry point for the peripheral controller driver.
diff --git a/drivers/usb/gadget/m66592-udc.c b/drivers/usb/gadget/m66592-udc.c
index 166bf71..2ce1f49 100644
--- a/drivers/usb/gadget/m66592-udc.c
+++ b/drivers/usb/gadget/m66592-udc.c
@@ -1454,14 +1454,15 @@ static struct usb_ep_ops m66592_ep_ops = {
 /*-------------------------------------------------------------------------*/
 static struct m66592 *the_controller;
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct m66592 *m66592 = the_controller;
 	int retval;
 
 	if (!driver
 			|| driver->speed != USB_SPEED_HIGH
-			|| !driver->bind
+			|| !bind
 			|| !driver->setup)
 		return -EINVAL;
 	if (!m66592)
@@ -1480,7 +1481,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 		goto error;
 	}
 
-	retval = driver->bind (&m66592->gadget);
+	retval = bind(&m66592->gadget);
 	if (retval) {
 		pr_err("bind to driver error (%d)\n", retval);
 		device_del(&m66592->gadget.dev);
@@ -1505,7 +1506,7 @@ error:
 
 	return retval;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 {
diff --git a/drivers/usb/gadget/net2280.c b/drivers/usb/gadget/net2280.c
index 9498be8..a469b27 100644
--- a/drivers/usb/gadget/net2280.c
+++ b/drivers/usb/gadget/net2280.c
@@ -1929,7 +1929,8 @@ static void ep0_start (struct net2280 *dev)
  * disconnect is reported.  then a host may connect again, or
  * the driver might get unbound.
  */
-int usb_gadget_register_driver (struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct net2280		*dev = the_controller;
 	int			retval;
@@ -1941,8 +1942,7 @@ int usb_gadget_register_driver (struct usb_gadget_driver *driver)
 	 */
 	if (!driver
 			|| driver->speed != USB_SPEED_HIGH
-			|| !driver->bind
-			|| !driver->setup)
+			|| !bind || !driver->setup)
 		return -EINVAL;
 	if (!dev)
 		return -ENODEV;
@@ -1957,7 +1957,7 @@ int usb_gadget_register_driver (struct usb_gadget_driver *driver)
 	driver->driver.bus = NULL;
 	dev->driver = driver;
 	dev->gadget.dev.driver = &driver->driver;
-	retval = driver->bind (&dev->gadget);
+	retval = bind(&dev->gadget);
 	if (retval) {
 		DEBUG (dev, "bind to driver %s --> %d\n",
 				driver->driver.name, retval);
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index f81e4f0..61d3ca6 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2102,7 +2102,8 @@ static inline int machine_without_vbus_sense(void)
 		);
 }
 
-int usb_gadget_register_driver (struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	int		status = -ENODEV;
 	struct omap_ep	*ep;
@@ -2114,8 +2115,7 @@ int usb_gadget_register_driver (struct usb_gadget_driver *driver)
 	if (!driver
 			// FIXME if otg, check:  driver->is_otg
 			|| driver->speed < USB_SPEED_FULL
-			|| !driver->bind
-			|| !driver->setup)
+			|| !bind || !driver->setup)
 		return -EINVAL;
 
 	spin_lock_irqsave(&udc->lock, flags);
@@ -2145,7 +2145,7 @@ int usb_gadget_register_driver (struct usb_gadget_driver *driver)
 	if (udc->dc_clk != NULL)
 		omap_udc_enable_clock(1);
 
-	status = driver->bind (&udc->gadget);
+	status = bind(&udc->gadget);
 	if (status) {
 		DBG("bind to %s --> %d\n", driver->driver.name, status);
 		udc->gadget.dev.driver = NULL;
@@ -2186,7 +2186,7 @@ done:
 		omap_udc_enable_clock(0);
 	return status;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 int usb_gadget_unregister_driver (struct usb_gadget_driver *driver)
 {
diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index be5fb34..b37f92c 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -1280,14 +1280,15 @@ static void udc_enable (struct pxa25x_udc *dev)
  * disconnect is reported.  then a host may connect again, or
  * the driver might get unbound.
  */
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct pxa25x_udc	*dev = the_controller;
 	int			retval;
 
 	if (!driver
 			|| driver->speed < USB_SPEED_FULL
-			|| !driver->bind
+			|| !bind
 			|| !driver->disconnect
 			|| !driver->setup)
 		return -EINVAL;
@@ -1308,7 +1309,7 @@ fail:
 		dev->gadget.dev.driver = NULL;
 		return retval;
 	}
-	retval = driver->bind(&dev->gadget);
+	retval = bind(&dev->gadget);
 	if (retval) {
 		DMSG("bind to driver %s --> error %d\n",
 				driver->driver.name, retval);
@@ -1338,7 +1339,7 @@ fail:
 bind_fail:
 	return retval;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 static void
 stop_activity(struct pxa25x_udc *dev, struct usb_gadget_driver *driver)
diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
index 85b0d89..798d280 100644
--- a/drivers/usb/gadget/pxa27x_udc.c
+++ b/drivers/usb/gadget/pxa27x_udc.c
@@ -1792,8 +1792,9 @@ static void udc_enable(struct pxa_udc *udc)
 }
 
 /**
- * usb_gadget_register_driver - Register gadget driver
+ * usb_gadget_probe_driver - Register gadget driver
  * @driver: gadget driver
+ * @bind: bind function
  *
  * When a driver is successfully registered, it will receive control requests
  * including set_configuration(), which enables non-control requests.  Then
@@ -1805,12 +1806,13 @@ static void udc_enable(struct pxa_udc *udc)
  *
  * Returns 0 if no error, -EINVAL, -ENODEV, -EBUSY otherwise
  */
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct pxa_udc *udc = the_controller;
 	int retval;
 
-	if (!driver || driver->speed < USB_SPEED_FULL || !driver->bind
+	if (!driver || driver->speed < USB_SPEED_FULL || !bind
 			|| !driver->disconnect || !driver->setup)
 		return -EINVAL;
 	if (!udc)
@@ -1828,7 +1830,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 		dev_err(udc->dev, "device_add error %d\n", retval);
 		goto add_fail;
 	}
-	retval = driver->bind(&udc->gadget);
+	retval = bind(&udc->gadget);
 	if (retval) {
 		dev_err(udc->dev, "bind to driver %s --> error %d\n",
 			driver->driver.name, retval);
@@ -1859,7 +1861,7 @@ add_fail:
 	udc->gadget.dev.driver = NULL;
 	return retval;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 
 /**
diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index 70a8178..5545d41 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1405,14 +1405,15 @@ static struct usb_ep_ops r8a66597_ep_ops = {
 /*-------------------------------------------------------------------------*/
 static struct r8a66597 *the_controller;
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct r8a66597 *r8a66597 = the_controller;
 	int retval;
 
 	if (!driver
 			|| driver->speed != USB_SPEED_HIGH
-			|| !driver->bind
+			|| !bind
 			|| !driver->setup)
 		return -EINVAL;
 	if (!r8a66597)
@@ -1431,7 +1432,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 		goto error;
 	}
 
-	retval = driver->bind(&r8a66597->gadget);
+	retval = bind(&r8a66597->gadget);
 	if (retval) {
 		printk(KERN_ERR "bind to driver error (%d)\n", retval);
 		device_del(&r8a66597->gadget.dev);
@@ -1456,7 +1457,7 @@ error:
 
 	return retval;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 {
diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 26193ec..89f04bc 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -2478,7 +2478,8 @@ static int s3c_hsotg_corereset(struct s3c_hsotg *hsotg)
 	return 0;
 }
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct s3c_hsotg *hsotg = our_hsotg;
 	int ret;
@@ -2498,7 +2499,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 		dev_err(hsotg->dev, "%s: bad speed\n", __func__);
 	}
 
-	if (!driver->bind || !driver->setup) {
+	if (!bind || !driver->setup) {
 		dev_err(hsotg->dev, "%s: missing entry points\n", __func__);
 		return -EINVAL;
 	}
@@ -2517,7 +2518,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 		goto err;
 	}
 
-	ret = driver->bind(&hsotg->gadget);
+	ret = bind(&hsotg->gadget);
 	if (ret) {
 		dev_err(hsotg->dev, "failed bind %s\n", driver->driver.name);
 
@@ -2641,7 +2642,7 @@ err:
 	hsotg->gadget.dev.driver = NULL;
 	return ret;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 {
diff --git a/drivers/usb/gadget/s3c2410_udc.c b/drivers/usb/gadget/s3c2410_udc.c
index e724a05..bcface6 100644
--- a/drivers/usb/gadget/s3c2410_udc.c
+++ b/drivers/usb/gadget/s3c2410_udc.c
@@ -1628,9 +1628,10 @@ static void s3c2410_udc_enable(struct s3c2410_udc *dev)
 }
 
 /*
- *	usb_gadget_register_driver
+ *	usb_gadget_probe_driver
  */
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	struct s3c2410_udc *udc = the_controller;
 	int		retval;
@@ -1645,10 +1646,9 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	if (udc->driver)
 		return -EBUSY;
 
-	if (!driver->bind || !driver->setup
-			|| driver->speed < USB_SPEED_FULL) {
+	if (!bind || !driver->setup || driver->speed < USB_SPEED_FULL) {
 		printk(KERN_ERR "Invalid driver: bind %p setup %p speed %d\n",
-			driver->bind, driver->setup, driver->speed);
+			bind, driver->setup, driver->speed);
 		return -EINVAL;
 	}
 #if defined(MODULE)
@@ -1671,7 +1671,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	dprintk(DEBUG_NORMAL, "binding gadget driver '%s'\n",
 		driver->driver.name);
 
-	if ((retval = driver->bind (&udc->gadget)) != 0) {
+	if ((retval = bind(&udc->gadget)) != 0) {
 		device_del(&udc->gadget.dev);
 		goto register_error;
 	}
@@ -2045,7 +2045,7 @@ static void __exit udc_exit(void)
 }
 
 EXPORT_SYMBOL(usb_gadget_unregister_driver);
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 module_init(udc_init);
 module_exit(udc_exit);
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 6fca870..529d216 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1698,7 +1698,8 @@ void musb_gadget_cleanup(struct musb *musb)
  * @param driver the gadget driver
  * @return <0 if error, 0 if everything is fine
  */
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *))
 {
 	int retval;
 	unsigned long flags;
@@ -1706,8 +1707,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 
 	if (!driver
 			|| driver->speed != USB_SPEED_HIGH
-			|| !driver->bind
-			|| !driver->setup)
+			|| !bind || !driver->setup)
 		return -EINVAL;
 
 	/* driver must be initialized to support peripheral mode */
@@ -1735,7 +1735,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	spin_unlock_irqrestore(&musb->lock, flags);
 
 	if (retval == 0) {
-		retval = driver->bind(&musb->g);
+		retval = bind(&musb->g);
 		if (retval != 0) {
 			DBG(3, "bind to driver %s failed --> %d\n",
 					driver->driver.name, retval);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index d3ef42d..aa4a877 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -798,17 +798,38 @@ struct usb_gadget_driver {
  */
 
 /**
+ * usb_gadget_probe_driver - probe a gadget driver
+ * @driver: the driver being registered
+ * Context: can sleep
+ *
+ * Call this in your gadget driver's module initialization function,
+ * to tell the underlying usb controller driver about your driver.
+ * The bind() function will be called to bind it to a gadget before this
+ * registration call returns.  It's expected that the bind() function will
+ * be in init sections.
+ */
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
+		int (*bind)(struct usb_gadget *));
+
+/**
  * usb_gadget_register_driver - register a gadget driver
- * @driver:the driver being registered
+ * @driver: the driver being registered
  * Context: can sleep
  *
  * Call this in your gadget driver's module initialization function,
  * to tell the underlying usb controller driver about your driver.
  * The driver's bind() function will be called to bind it to a
  * gadget before this registration call returns.  It's expected that
- * the bind() functions will be in init sections.
+ * the bind() functions will be in init sections.  As this results in
+ * a section mismatch better use usb_gadget_probe_driver directly though.
  */
-int usb_gadget_register_driver(struct usb_gadget_driver *driver);
+static inline int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+{
+	if (!driver)
+		return -EINVAL;
+
+	return usb_gadget_probe_driver(driver, driver->bind);
+}
 
 /**
  * usb_gadget_unregister_driver - unregister a gadget driver
-- 
1.7.1

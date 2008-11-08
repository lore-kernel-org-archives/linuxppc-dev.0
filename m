Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D2D54DDE00
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 04:57:00 +1100 (EST)
Date: Sat, 8 Nov 2008 20:56:59 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH] usb/fsl_qe_udc: Implement port reset
Message-ID: <20081108175659.GA7371@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Greg Kroah-Hartman <greg@kroah.com>, Li Yang <leoli@freescale.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Without that patch a USB host won't find the QE UDC device if a USB
cable plugged before the QE UDC probe. A user have to re-plug the
USB cable so that the host would reenumerate the device.

To solve the issues the QE UDC should reset the port at bind time.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Please do not apply this patch now. It depends on few patches that
should be merged into powerpc-next tree. I'll repost this patch when
everything will be ready for the merge.

 drivers/usb/gadget/fsl_qe_udc.c |   91 ++++++++++++++++++++++++++++++++++++++-
 drivers/usb/gadget/fsl_qe_udc.h |   19 ++++++++
 2 files changed, 109 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index 94c38e4..91ad856 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -34,6 +34,9 @@
 #include <linux/moduleparam.h>
 #include <linux/of_platform.h>
 #include <linux/dma-mapping.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
@@ -2285,6 +2288,26 @@ static irqreturn_t qe_udc_irq(int irq, void *_udc)
 	return status;
 }
 
+static void qe_udc_port_generate_reset(struct qe_udc *udc)
+{
+	if (!udc->can_reset_port)
+		return;
+
+	qe_pin_set_gpio(udc->pins[PIN_USBOE]);
+	qe_pin_set_gpio(udc->pins[PIN_USBTP]);
+	qe_pin_set_gpio(udc->pins[PIN_USBTN]);
+
+	gpio_direction_output(udc->gpios[GPIO_USBOE], 0);
+	gpio_direction_output(udc->gpios[GPIO_USBTP], 0);
+	gpio_direction_output(udc->gpios[GPIO_USBTN], 0);
+
+	msleep(5);
+
+	qe_pin_set_dedicated(udc->pins[PIN_USBOE]);
+	qe_pin_set_dedicated(udc->pins[PIN_USBTP]);
+	qe_pin_set_dedicated(udc->pins[PIN_USBTN]);
+}
+
 /*-------------------------------------------------------------------------
 	Gadget driver register and unregister.
  --------------------------------------------------------------------------*/
@@ -2335,6 +2358,8 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	udc_controller->ep0_dir = USB_DIR_OUT;
 	dev_info(udc_controller->dev, "%s bind to driver %s \n",
 		udc_controller->gadget.name, driver->driver.name);
+
+	qe_udc_port_generate_reset(udc_controller);
 	return 0;
 }
 EXPORT_SYMBOL(usb_gadget_register_driver);
@@ -2504,9 +2529,11 @@ static int __devinit qe_udc_probe(struct of_device *ofdev,
 			const struct of_device_id *match)
 {
 	struct device_node *np = ofdev->node;
+	struct device *dev = &ofdev->dev;
 	struct qe_ep *ep;
 	unsigned int ret = 0;
-	unsigned int i;
+	int i;
+	int j;
 	const void *prop;
 
 	prop = of_get_property(np, "mode", NULL);
@@ -2610,6 +2637,45 @@ static int __devinit qe_udc_probe(struct of_device *ofdev,
 		goto err5;
 	}
 
+	/*
+	 * Get GPIOs and pins. Bail out only if something really failed,
+	 * that is, silently accept `not implemented' errors. For CPM we
+	 * don't (yet) support Pinmux API, so CPM gadgets will unable to
+	 * do the port reset.
+	 */
+	for (i = 0; i < NUM_GPIOS; i++) {
+		int gpio = of_get_gpio(np, i, NULL);
+
+		udc_controller->gpios[i] = gpio;
+
+		ret = gpio_request(gpio, dev->bus_id);
+		if (!ret)
+			continue;
+
+		udc_controller->gpios[i] = ret;
+		if (ret == -ENOSYS)
+			continue;
+
+		dev_err(dev, "failed to request gpio #%d", i);
+		goto err_gpios;
+	}
+
+	for (j = 0; j < NUM_PINS; j++) {
+		udc_controller->pins[j] = qe_pin_request(ofdev->node, j);
+		if (!IS_ERR(udc_controller->pins[j]))
+			continue;
+
+		ret = PTR_ERR(udc_controller->pins[j]);
+		if (ret == -ENOSYS)
+			continue;
+
+		dev_err(dev, "can't get pin #%d: %d\n", j, ret);
+		goto err_pins;
+	}
+
+	if (i == NUM_GPIOS && j == NUM_PINS)
+		udc_controller->can_reset_port = true;
+
 	ret = device_add(&udc_controller->gadget.dev);
 	if (ret)
 		goto err6;
@@ -2620,6 +2686,14 @@ static int __devinit qe_udc_probe(struct of_device *ofdev,
 	return 0;
 
 err6:
+err_pins:
+	while (--j >= 0)
+		qe_pin_free(udc_controller->pins[j]);
+err_gpios:
+	while (--i >= 0) {
+		if (gpio_is_valid(udc_controller->gpios[i]))
+			gpio_free(udc_controller->gpios[i]);
+	}
 	free_irq(udc_controller->usb_irq, udc_controller);
 err5:
 	if (udc_controller->nullmap) {
@@ -2665,6 +2739,7 @@ static int __devexit qe_udc_remove(struct of_device *ofdev)
 {
 	struct qe_ep *ep;
 	unsigned int size;
+	int i;
 
 	DECLARE_COMPLETION(done);
 
@@ -2706,6 +2781,20 @@ static int __devexit qe_udc_remove(struct of_device *ofdev)
 	kfree(ep->rxbuffer);
 	kfree(ep->txframe);
 
+	for (i = 0; i < NUM_GPIOS; i++) {
+		if (gpio_is_valid(udc_controller->gpios[i]))
+			continue;
+		gpio_free(udc_controller->gpios[i]);
+	}
+
+	for (i = 0; i < NUM_PINS; i++) {
+		struct qe_pin *pin = udc_controller->pins[i];
+
+		if (!pin || IS_ERR(pin))
+			continue;
+		qe_pin_free(pin);
+	}
+
 	free_irq(udc_controller->usb_irq, udc_controller);
 
 	tasklet_kill(&udc_controller->rx_tasklet);
diff --git a/drivers/usb/gadget/fsl_qe_udc.h b/drivers/usb/gadget/fsl_qe_udc.h
index 31b2710..c1226c3 100644
--- a/drivers/usb/gadget/fsl_qe_udc.h
+++ b/drivers/usb/gadget/fsl_qe_udc.h
@@ -317,6 +317,22 @@ struct qe_ep {
 	struct timer_list timer;
 };
 
+enum qe_udc_gpios {
+	GPIO_USBOE = 0,
+	GPIO_USBTP,
+	GPIO_USBTN,
+	NUM_GPIOS,
+};
+
+enum qe_udc_pins {
+	PIN_USBOE = 0,
+	PIN_USBTP,
+	PIN_USBTN,
+	NUM_PINS,
+};
+
+struct qe_pin;
+
 struct qe_udc {
 	struct usb_gadget gadget;
 	struct usb_gadget_driver *driver;
@@ -357,6 +373,9 @@ struct qe_udc {
 	unsigned int usb_clock;
 	unsigned int usb_irq;
 	struct usb_ctlr __iomem *usb_regs;
+	struct qe_pin *pins[NUM_PINS];
+	int gpios[NUM_GPIOS];
+	bool can_reset_port;
 
 	struct tasklet_struct rx_tasklet;
 
-- 
1.5.6.3

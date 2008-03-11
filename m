Return-Path: <mh@omnisys.se>
Received: from mail.omnisys.se (static-213-115-84-26.sme.bredbandsbolaget.se
	[213.115.84.26]) by ozlabs.org (Postfix) with ESMTP id 5B0B1DE13A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Mar 2008 03:13:04 +1100 (EST)
From: "Magnus Hjorth" <mh@omnisys.se>
To: <git@xilinx.com>
Subject: [PATCH] Ported Xilinx GPIO driver to OpenFirmware.
Date: Tue, 11 Mar 2008 17:12:54 +0100
Message-ID: <000001c88392$c38a8c40$4a9fa4c0$@se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Magnus Hjorth <mh@omnisys.se>

 Added of_device structure and init code.=20
 Basic functionality tested (LED:s on/off).
 Added code to validate channel number in ioctl.

Signed-off-by: Magnus Hjorth <mh@omnisys.se>
---

 Patch against Xilinx GIT tree (commit 7fb2b...)
 Did this as a learning exercise. Hope it gets through Outlook in one =
piece :)
 Cheers /Magnus

diff --git a/drivers/char/xilinx_gpio/adapter.c =
b/drivers/char/xilinx_gpio/adapter.c
index ecd2897..6fdf7aa 100644
--- a/drivers/char/xilinx_gpio/adapter.c
+++ b/drivers/char/xilinx_gpio/adapter.c
@@ -43,15 +43,22 @@
 #include <asm/irq.h>
 #include <linux/interrupt.h>
=20
+#ifdef CONFIG_OF
+// For open firmware.
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#endif
+
 #define BUFSIZE		200
 #define MIN(x,y) (x < y ? x : y)
=20
-
 struct xgpio_instance {
 	struct list_head link;
 	unsigned long base_phys;	/* GPIO base address - physical */
 	unsigned long remap_size;
-	u32 device_id;
+	u32 device_id;		/* Dev ID for platform devices, 0 for OF devices */
+	void *of_id;		/* of_dev pointer for OF devices, NULL for plat devices =
*/
+	int is_dual;
 	wait_queue_head_t wait;
 	unsigned int head, tail, count;
 	__u64 buf[BUFSIZE];	/* 32xChan1, 32xChan2 */
@@ -125,8 +132,7 @@ static struct xgpio_instance *xgpio_getinst(unsigned =
int minor)
 			up_read(&inst_list_sem);
 			if (XGpio_IsReady(&inst->gpio)) {
 				return inst;
-			}
-			else {
+			} else {
 				return NULL;
 			}
 		}
@@ -147,6 +153,10 @@ static int xgpio_ioctl(struct inode *inode, struct =
file *file,
 	if (copy_from_user(&ioctl_data, (void *) arg, sizeof(ioctl_data)))
 		return -EFAULT;
=20
+	/* Validate channel number */
+	if (ioctl_data.chan !=3D 1 && (ioctl_data.chan !=3D 2 || =
!inst->is_dual))
+		return -EINVAL;
+
 	switch (cmd) {
 	case XGPIO_IN:
 		/*
@@ -216,6 +226,7 @@ static int xgpio_ioctl(struct inode *inode, struct =
file *file,
 		return -ENOIOCTLCMD;
=20
 	}
+
 	return 0;
 }
=20
@@ -237,7 +248,6 @@ static unsigned int prev(unsigned int ptr)
 	return ptr;
 }
=20
-
 static ssize_t xgpio_read(struct file *file, char *buf,
 			  size_t count, loff_t * ppos)
 {
@@ -278,7 +288,6 @@ static ssize_t xgpio_read(struct file *file, char =
*buf,
 	return 0;
 }
=20
-
 static irqreturn_t xgpio_interrupt(int irq, void *dev_id)
 {
 	struct xgpio_instance *inst =3D dev_id;
@@ -287,7 +296,6 @@ static irqreturn_t xgpio_interrupt(int irq, void =
*dev_id)
 		inst->gpio.IsDual ? XIo_In32(inst->gpio.BaseAddress + 0x08) : 0;
 	__u32 int_status =3D XIo_In32(inst->gpio.BaseAddress + 0x120);
=20
-
 	if (inst->buf[prev(inst->tail)] !=3D
 	    (((__u64) val_1) | ((__u64) (val_2) << 32)))
 		if (next(inst->tail) !=3D inst->head) {
@@ -303,7 +311,6 @@ static irqreturn_t xgpio_interrupt(int irq, void =
*dev_id)
 	return IRQ_HANDLED;
 }
=20
-
 /*
  * We get to all of the GPIOs through one minor number.  Here's the
  * miscdevice that gets registered for that minor number.
@@ -335,45 +342,33 @@ char *names[] =3D {
=20
 static int minor =3D XGPIO_MINOR;
=20
-static int xgpio_probe(struct device *dev)
+static int xgpio_probe_main(struct device *dev, int dev_id, void =
*of_dev_id,
+			    int is_dual,
+			    struct resource *irq_res, struct resource *regs_res)
 {
 	XGpio_Config xgpio_config;
 	struct xgpio_instance *xgpio_inst;
 	struct miscdevice *miscdev =3D 0;
-	struct platform_device *pdev =3D to_platform_device(dev);
-	struct resource *irq_res, *regs_res;
 	void *v_addr;
 	int retval;
=20
-	if (!dev)
-		return -EINVAL;
-
 	memset(&xgpio_config, 0, sizeof(XGpio_Config));
 	xgpio_inst =3D kmalloc(sizeof(struct xgpio_instance), GFP_KERNEL);
 	if (!xgpio_inst) {
 		printk(KERN_ERR
 		       "%s #%d: Couldn't allocate device private record\n",
-		       miscdev->name, pdev->id);
+		       miscdev->name, dev_id);
 		return -ENOMEM;
 	}
 	memset(xgpio_inst, 0, sizeof(struct xgpio_instance));
=20
-	/* Map the control registers in */
-	regs_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs_res || (regs_res->end - regs_res->start + 1 < 8)) {
-		printk(KERN_ERR "%s #%d: Couldn't get registers resource\n",
-		       miscdev->name, pdev->id);
-		retval =3D -EFAULT;
-		goto failed1;
-	}
-
 	xgpio_inst->remap_size =3D regs_res->end - regs_res->start + 1;
 	if (!request_mem_region(regs_res->start, xgpio_inst->remap_size,
 				DRIVER_NAME)) {
 		printk(KERN_ERR "Couldn't lock memory region at 0x%08lX\n",
 		       (unsigned long) regs_res->start);
 		retval =3D -EBUSY;
-		goto failed2;
+		goto failed1;
 	}
=20
 	v_addr =3D ioremap(regs_res->start, xgpio_inst->remap_size);
@@ -381,21 +376,22 @@ static int xgpio_probe(struct device *dev)
 		printk(KERN_ERR "Couldn't ioremap memory at 0x%08lX\n",
 		       (unsigned long) regs_res->start);
 		retval =3D -EFAULT;
-		goto failed3;
+		goto failed2;
 	}
=20
 	xgpio_inst->base_phys =3D regs_res->start;
 	/* The 1st GPIO channel uses */
-	xgpio_inst->device_id =3D pdev->id;
-	xgpio_config.DeviceId =3D pdev->id;
-	xgpio_config.IsDual =3D
-		((unsigned) (dev->platform_data) & XGPIO_IS_DUAL) ? 1 : 0;
+	xgpio_inst->device_id =3D dev_id;
+	xgpio_inst->of_id =3D of_dev_id;
+	xgpio_inst->is_dual =3D is_dual ? 1 : 0;
+	xgpio_config.DeviceId =3D dev_id;
+	xgpio_config.IsDual =3D is_dual ? 1 : 0;
=20
 	/* Tell the Xilinx code to bring this GPIO interface up. */
 	if (XGpio_CfgInitialize(&xgpio_inst->gpio, &xgpio_config,
 				(u32) v_addr) !=3D XST_SUCCESS) {
 		printk(KERN_ERR "%s #%d: Could not initialize instance.\n",
-		       miscdev->name, pdev->id);
+		       miscdev->name, dev_id);
 		retval =3D -ENODEV;
 		goto failed3;
 	}
@@ -407,7 +403,7 @@ static int xgpio_probe(struct device *dev)
 	if (!miscdev) {
 		printk(KERN_ERR
 		       "%s #%d: Couldn't allocate device private record\n",
-		       "xgpio", pdev->id);
+		       "xgpio", dev_id);
 		return -ENOMEM;
 	}
=20
@@ -419,7 +415,7 @@ static int xgpio_probe(struct device *dev)
 	if (retval !=3D 0) {
 		up_write(&inst_list_sem);
 		printk(KERN_ERR "%s #%d: Could not register miscdev.\n",
-		       miscdev->name, pdev->id);
+		       miscdev->name, dev_id);
 		goto failed3;
 	}
=20
@@ -427,7 +423,6 @@ static int xgpio_probe(struct device *dev)
=20
 	minor++;
=20
-	irq_res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_res) {
 		if (request_irq(irq_res->start,
 				xgpio_interrupt, 0, "XGPIO", xgpio_inst))
@@ -471,24 +466,45 @@ static int xgpio_probe(struct device *dev)
 	return retval;
 }
=20
-static int xgpio_remove(struct device *dev)
+static int xgpio_probe(struct device *dev)
 {
-	struct list_head *entry;
-	struct xgpio_instance *xgpio_inst =3D NULL;
 	struct platform_device *pdev =3D to_platform_device(dev);
+	struct resource *irq_res, *regs_res;
+	int is_dual;
=20
 	if (!dev)
 		return -EINVAL;
=20
+	/* Map the control registers in */
+	regs_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs_res || (regs_res->end - regs_res->start + 1 < 8)) {
+		dev_err(dev, "couldn't get registers resource\n");
+		return -EFAULT;
+	}
+
+	irq_res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+
+	is_dual =3D ((unsigned)(dev->platform_data) & XGPIO_IS_DUAL);
+
+	return xgpio_probe_main(dev, pdev->id, NULL, is_dual, irq_res,
+				regs_res);
+}
+
+static int xgpio_remove_main(struct device *dev, int dev_id, void =
*of_dev_id)
+{
+	struct list_head *entry;
+	struct xgpio_instance *xgpio_inst =3D NULL;
+	struct platform_device *pdev =3D to_platform_device(dev);
+
 	/* Set xgpio_inst based on pdev->id match */
=20
 	down_read(&inst_list_sem);
 	list_for_each(entry, &inst_list) {
 		xgpio_inst =3D list_entry(entry, struct xgpio_instance, link);
-		if (pdev->id =3D=3D xgpio_inst->device_id) {
+		if (pdev->id =3D=3D xgpio_inst->device_id &&
+		    of_dev_id =3D=3D xgpio_inst->of_id) {
 			break;
-		}
-		else {
+		} else {
 			xgpio_inst =3D NULL;
 		}
 	}
@@ -515,6 +531,16 @@ static int xgpio_remove(struct device *dev)
 	return 0;		/* success */
 }
=20
+static int xgpio_remove(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+
+	if (!dev)
+		return -EINVAL;
+
+	return xgpio_remove_main(dev, pdev->id, NULL);
+}
+
 static struct device_driver xgpio_driver =3D {
 	.name =3D DRIVER_NAME,
 	.bus =3D &platform_bus_type,
@@ -523,13 +549,77 @@ static struct device_driver xgpio_driver =3D {
 	.remove =3D xgpio_remove
 };
=20
+#ifdef CONFIG_OF
+
+static int __devinit xgpio_of_probe(struct of_device *ofdev,
+				    const struct of_device_id *match)
+{
+	struct resource r_irq_struct, r_mem_struct;
+	struct resource *r_irq;
+	int rc;
+	int l;
+	const u32 *p;
+	int is_dual;
+
+	rc =3D of_address_to_resource(ofdev->node, 0, &r_mem_struct);
+	if (rc) {
+		dev_warn(&ofdev->dev, "invalid address\n");
+		return rc;
+	}
+
+	rc =3D of_irq_to_resource(ofdev->node, 0, &r_irq_struct);
+	if (rc =3D=3D NO_IRQ)
+		r_irq =3D NULL;
+	else
+		r_irq =3D &r_irq_struct;
+
+	p =3D of_get_property(ofdev->node, "xlnx,is-dual", &l);
+	if (p =3D=3D NULL || l !=3D sizeof(*p)) {
+		dev_warn(&ofdev->dev, "Property not found: xlnx,is-dual\n");
+		is_dual =3D 0;
+	} else
+		is_dual =3D *p;
+
+	return xgpio_probe_main(&ofdev->dev, 0, ofdev, is_dual, r_irq,
+				&r_mem_struct);
+}
+
+static int __devexit xgpio_of_remove(struct of_device *ofdev)
+{
+	if (!ofdev)
+		return -EINVAL;
+
+	return xgpio_remove_main(&ofdev->dev, 0, ofdev);
+}
+
+static struct of_device_id xgpio_of_match[] =3D {
+	{.compatible =3D "xlnx,xps-gpio-1.00.a"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, xgpio_of_match);
+
+static struct of_platform_driver xgpio_of_driver =3D {
+	.name =3D DRIVER_NAME,
+	.match_table =3D xgpio_of_match,
+	.probe =3D xgpio_of_probe,
+	.remove =3D __devexit_p(xgpio_of_remove),
+};
+
+#endif
+
 static int __init xgpio_init(void)
 {
+	int s;
 	/*
 	 * No kernel boot options used,
 	 * so we just need to register the driver
 	 */
-	return driver_register(&xgpio_driver);
+	s =3D driver_register(&xgpio_driver);
+#ifdef CONFIG_OF
+	s |=3D of_register_platform_driver(&xgpio_of_driver);
+#endif
+	return s;
 }
=20
 static void __exit xgpio_cleanup(void)
--=20
1.5.4.4


--

Magnus Hjorth, M.Sc.
Omnisys Instruments AB
Gruvgatan 8
SE-421 30  V=E4stra Fr=F6lunda, SWEDEN
Phone: +46 31 734 34 09
Fax: +46 31 734 34 29
http://www.omnisys.se

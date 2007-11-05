Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id 7F883DDE2D
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 02:14:24 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1336580rvf
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 07:14:23 -0800 (PST)
Message-ID: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
Date: Mon, 5 Nov 2007 10:14:23 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
Subject: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tjernlund <tjernlund@tjernlund.se>, Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is my first pass at reworking the Freescale i2c driver. It
switches the driver from being a platform driver to an open firmware
one. I've checked it out on my hardware and it is working.

You can specific i2c devices on a bus by adding child nodes for them
in the device tree. It does not know how to autoload the i2c chip
driver modules.

i2c@3d40 {
	device_type = "i2c";
	compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
	cell-index = <1>;
	reg = <3d40 40>;
	interrupts = <2 10 0>;
	interrupt-parent = <&mpc5200_pic>;
	fsl5200-clocking;

	rtc@32 {
		device_type = "rtc";
		compatible = "epson,pcf8564";
		reg = <51>;
	};
};

One side effect is that legacy style i2c drivers won't work anymore.
The rtc driver in the patch has been converted from legacy i2c style
to new i2c style. It took about ten minutes to change it and it
eliminates a lot of code. The patch uses the broad_info support in the
i2c core which does not support legacy style drivers.

The driver contains a table for mapping device tree style names to
linux kernel ones.

+static struct i2c_driver_device i2c_devices[] = {
+	{"ricoh,rs5c372a", "rtc-rs5c372", "rs5c372a",},
+	{"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
+	{"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
+	{"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
+	{"epson,pcf8564", "rtc-pcf8563", "pcf8564",},
+};

I'd like to get rid of this table.  There are two obvious solutions,
use names in the device tree that match up with the linux device
driver names. Or push these strings into the chip drivers and modify
i2c-core to also match on the device tree style names. Without one of
these changes the table is going to need a mapping for every i2c
device on the market.

If someone can supply a fix for this I will add it:

On 10/26/07, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> On Fri, 2007-10-26 at 11:53 +0200, Jean Delvare wrote:
> > > 2) mpc_read(), according to the comment below it sends a STOP condition here but
> > >    this function does not known if this is the last read or not. mpc_xfer is
> > >    the one that knows when the transaction is over and should send the stop,
> > >    which it already does.
> > >
> > >  /* Generate stop on last byte */
> > >   if (i == length - 1)
> > >        writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_TXAK);
> >
> > Probably correct, although I am not familiar with this specific
> > hardware. I guess that the same is true of mpc_write as well, which is
> > even worse because write + read combined transactions are very common
> > (while read + write are not.)
>
> Don't think write is a problem, only read. I would have to look at the
> HW spec to make sure though.

Convert i2c to of_platform_driver from platform_driver

From: Jon Smirl <jonsmirl@gmail.com>


---

 arch/powerpc/sysdev/fsl_soc.c |  116 -------------------------
 drivers/i2c/busses/i2c-mpc.c  |  193 +++++++++++++++++++++++++++++++----------
 drivers/rtc/rtc-pcf8563.c     |  103 ++++------------------
 3 files changed, 166 insertions(+), 246 deletions(-)


diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 1cf29c9..6f80216 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -306,122 +306,6 @@ err:

 arch_initcall(gfar_of_init);

-#ifdef CONFIG_I2C_BOARDINFO
-#include <linux/i2c.h>
-struct i2c_driver_device {
-	char	*of_device;
-	char	*i2c_driver;
-	char	*i2c_type;
-};
-
-static struct i2c_driver_device i2c_devices[] __initdata = {
-	{"ricoh,rs5c372a", "rtc-rs5c372", "rs5c372a",},
-	{"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
-	{"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
-	{"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
-};
-
-static int __init of_find_i2c_driver(struct device_node *node, struct
i2c_board_info *info)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
-		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
-			continue;
-		strncpy(info->driver_name, i2c_devices[i].i2c_driver, KOBJ_NAME_LEN);
-		strncpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);
-		return 0;
-	}
-	return -ENODEV;
-}
-
-static void __init of_register_i2c_devices(struct device_node
*adap_node, int bus_num)
-{
-	struct device_node *node = NULL;
-
-	while ((node = of_get_next_child(adap_node, node))) {
-		struct i2c_board_info info;
-		const u32 *addr;
-		int len;
-
-		addr = of_get_property(node, "reg", &len);
-		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
-			printk(KERN_WARNING "fsl_ioc.c: invalid i2c device entry\n");
-			continue;
-		}
-
-		info.irq = irq_of_parse_and_map(node, 0);
-		if (info.irq == NO_IRQ)
-			info.irq = -1;
-
-		if (of_find_i2c_driver(node, &info) < 0)
-			continue;
-
-		info.platform_data = NULL;
-		info.addr = *addr;
-
-		i2c_register_board_info(bus_num, &info, 1);
-	}
-}
-
-static int __init fsl_i2c_of_init(void)
-{
-	struct device_node *np;
-	unsigned int i;
-	struct platform_device *i2c_dev;
-	int ret;
-
-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "i2c", "fsl-i2c")) != NULL;
-	     i++) {
-		struct resource r[2];
-		struct fsl_i2c_platform_data i2c_data;
-		const unsigned char *flags = NULL;
-
-		memset(&r, 0, sizeof(r));
-		memset(&i2c_data, 0, sizeof(i2c_data));
-
-		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			goto err;
-
-		of_irq_to_resource(np, 0, &r[1]);
-
-		i2c_dev = platform_device_register_simple("fsl-i2c", i, r, 2);
-		if (IS_ERR(i2c_dev)) {
-			ret = PTR_ERR(i2c_dev);
-			goto err;
-		}
-
-		i2c_data.device_flags = 0;
-		flags = of_get_property(np, "dfsrr", NULL);
-		if (flags)
-			i2c_data.device_flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
-
-		flags = of_get_property(np, "fsl5200-clocking", NULL);
-		if (flags)
-			i2c_data.device_flags |= FSL_I2C_DEV_CLOCK_5200;
-
-		ret =
-		    platform_device_add_data(i2c_dev, &i2c_data,
-					     sizeof(struct
-						    fsl_i2c_platform_data));
-		if (ret)
-			goto unreg;
-
-		of_register_i2c_devices(np, i);
-	}
-
-	return 0;
-
-unreg:
-	platform_device_unregister(i2c_dev);
-err:
-	return ret;
-}
-
-arch_initcall(fsl_i2c_of_init);
-#endif

 #ifdef CONFIG_PPC_83xx
 static int __init mpc83xx_wdt_init(void)
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index d8de4ac..5ceb936 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
+#include <asm/of_platform.h>

 #include <asm/io.h>
 #include <linux/fsl_devices.h>
@@ -25,6 +25,8 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>

+#define DRV_NAME "mpc-i2c"
+
 #define MPC_I2C_ADDR  0x00
 #define MPC_I2C_FDR 	0x04
 #define MPC_I2C_CR	0x08
@@ -180,7 +182,7 @@ static void mpc_i2c_stop(struct mpc_i2c *i2c)
 static int mpc_write(struct mpc_i2c *i2c, int target,
 		     const u8 * data, int length, int restart)
 {
-	int i;
+	int i, result;
 	unsigned timeout = i2c->adap.timeout;
 	u32 flags = restart ? CCR_RSTA : 0;

@@ -192,15 +194,15 @@ static int mpc_write(struct mpc_i2c *i2c, int target,
 	/* Write target byte */
 	writeb((target << 1), i2c->base + MPC_I2C_DR);

-	if (i2c_wait(i2c, timeout, 1) < 0)
-		return -1;
+	if ((result = i2c_wait(i2c, timeout, 1)) < 0)
+		return result;

 	for (i = 0; i < length; i++) {
 		/* Write data byte */
 		writeb(data[i], i2c->base + MPC_I2C_DR);

-		if (i2c_wait(i2c, timeout, 1) < 0)
-			return -1;
+		if ((result = i2c_wait(i2c, timeout, 1)) < 0)
+			return result;
 	}

 	return 0;
@@ -210,7 +212,7 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 		    u8 * data, int length, int restart)
 {
 	unsigned timeout = i2c->adap.timeout;
-	int i;
+	int i, result;
 	u32 flags = restart ? CCR_RSTA : 0;

 	/* Start with MEN */
@@ -221,8 +223,8 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 	/* Write target address byte - this time with the read flag set */
 	writeb((target << 1) | 1, i2c->base + MPC_I2C_DR);

-	if (i2c_wait(i2c, timeout, 1) < 0)
-		return -1;
+	if ((result = i2c_wait(i2c, timeout, 1)) < 0)
+		return result;

 	if (length) {
 		if (length == 1)
@@ -234,8 +236,8 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 	}

 	for (i = 0; i < length; i++) {
-		if (i2c_wait(i2c, timeout, 0) < 0)
-			return -1;
+		if ((result = i2c_wait(i2c, timeout, 0)) < 0)
+			return result;

 		/* Generate txack on next to last byte */
 		if (i == length - 2)
@@ -312,74 +314,151 @@ static struct i2c_adapter mpc_ops = {
 	.retries = 1
 };

-static int fsl_i2c_probe(struct platform_device *pdev)
+struct i2c_driver_device {
+	char	*of_device;
+	char	*i2c_driver;
+	char	*i2c_type;
+};
+
+static struct i2c_driver_device i2c_devices[] = {
+	{"ricoh,rs5c372a", "rtc-rs5c372", "rs5c372a",},
+	{"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
+	{"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
+	{"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
+	{"epson,pcf8564", "rtc-pcf8563", "pcf8564",},
+};
+
+static int of_find_i2c_driver(struct device_node *node, struct
i2c_board_info *info)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
+		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
+			continue;
+		strncpy(info->driver_name, i2c_devices[i].i2c_driver, KOBJ_NAME_LEN);
+		strncpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);
+		printk("i2c driver is %s\n", info->driver_name);
+		return 0;
+	}
+	return -ENODEV;
+}
+
+static void of_register_i2c_devices(struct i2c_adapter *adap, struct
device_node *adap_node)
+{
+	struct device_node *node = NULL;
+
+	while ((node = of_get_next_child(adap_node, node))) {
+		struct i2c_board_info info;
+		const u32 *addr;
+		int len;
+
+		addr = of_get_property(node, "reg", &len);
+		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
+			printk(KERN_WARNING "i2c-mpc.c: invalid i2c device entry\n");
+			continue;
+		}
+
+		info.irq = irq_of_parse_and_map(node, 0);
+		if (info.irq == NO_IRQ)
+			info.irq = -1;
+
+		if (of_find_i2c_driver(node, &info) < 0)
+			continue;
+
+		info.platform_data = NULL;
+		info.addr = *addr;
+
+		i2c_new_device(adap, &info);
+	}
+}
+
+static int mpc_i2c_probe(struct of_device *op, const struct
of_device_id *match)
 {
 	int result = 0;
 	struct mpc_i2c *i2c;
-	struct fsl_i2c_platform_data *pdata;
-	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct resource mem;
+	const u32 *index;
+	const unsigned char *flags = NULL;

-	pdata = (struct fsl_i2c_platform_data *) pdev->dev.platform_data;
+	memset(&mem, 0, sizeof(mem));
+	result = of_address_to_resource(op->node, 0, &mem);
+	if (result)
+		return result;

+	index = of_get_property(op->node, "cell-index", NULL);
+    if (!index || *index > 5) {
+            printk(KERN_ERR "mpc_i2c_probe: Device node %s has invalid "
+                            "cell-index property\n", op->node->full_name);
+            return -EINVAL;
+    }
+
 	if (!(i2c = kzalloc(sizeof(*i2c), GFP_KERNEL))) {
 		return -ENOMEM;
 	}

-	i2c->irq = platform_get_irq(pdev, 0);
-	if (i2c->irq < 0) {
-		result = -ENXIO;
-		goto fail_get_irq;
-	}
-	i2c->flags = pdata->device_flags;
-	init_waitqueue_head(&i2c->queue);
+	flags = of_get_property(op->node, "dfsrr", NULL);
+	if (flags)
+		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;

-	i2c->base = ioremap((phys_addr_t)r->start, MPC_I2C_REGION);
+	flags = of_get_property(op->node, "fsl5200-clocking", NULL);
+	if (flags)
+		i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
+
+	init_waitqueue_head(&i2c->queue);

+	i2c->base = ioremap((phys_addr_t)mem.start, MPC_I2C_REGION);
 	if (!i2c->base) {
 		printk(KERN_ERR "i2c-mpc - failed to map controller\n");
 		result = -ENOMEM;
 		goto fail_map;
 	}

+	i2c->irq = irq_of_parse_and_map(op->node, 0);
+	if (i2c->irq < 0) {
+		result = -ENXIO;
+		goto fail_irq;
+	}
+	
 	if (i2c->irq != 0)
 		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
-					  IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
-			printk(KERN_ERR
-			       "i2c-mpc - failed to attach interrupt\n");
+					  	IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
+			printk(KERN_ERR "i2c-mpc - failed to attach interrupt\n");
 			goto fail_irq;
 		}

 	mpc_i2c_setclock(i2c);
-	platform_set_drvdata(pdev, i2c);
+	
+	dev_set_drvdata(&op->dev, i2c);

 	i2c->adap = mpc_ops;
-	i2c->adap.nr = pdev->id;
+	i2c->adap.nr = *index;
 	i2c_set_adapdata(&i2c->adap, i2c);
-	i2c->adap.dev.parent = &pdev->dev;
+	i2c->adap.dev.parent = &op->dev;
 	if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
 		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
 		goto fail_add;
 	}
+	
+	of_register_i2c_devices(&i2c->adap, op->node);

 	return result;

-      fail_add:
+fail_add:
 	if (i2c->irq != 0)
 		free_irq(i2c->irq, i2c);
-      fail_irq:
+fail_irq:
 	iounmap(i2c->base);
-      fail_map:
-      fail_get_irq:
+fail_map:
 	kfree(i2c);
 	return result;
 };

-static int fsl_i2c_remove(struct platform_device *pdev)
+static int mpc_i2c_remove(struct of_device *op)
 {
-	struct mpc_i2c *i2c = platform_get_drvdata(pdev);
+	struct mpc_i2c *i2c = dev_get_drvdata(&op->dev);

 	i2c_del_adapter(&i2c->adap);
-	platform_set_drvdata(pdev, NULL);
+	dev_set_drvdata(&op->dev, NULL);

 	if (i2c->irq != 0)
 		free_irq(i2c->irq, i2c);
@@ -389,28 +468,46 @@ static int fsl_i2c_remove(struct platform_device *pdev)
 	return 0;
 };

+static struct of_device_id mpc_i2c_of_match[] = {
+	{
+		.type		= "i2c",
+		.compatible	= "fsl-i2c",
+	},
+};
+MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
+
+
 /* Structure for a device driver */
-static struct platform_driver fsl_i2c_driver = {
-	.probe = fsl_i2c_probe,
-	.remove = fsl_i2c_remove,
-	.driver	= {
-		.owner = THIS_MODULE,
-		.name = "fsl-i2c",
+static struct of_platform_driver mpc_i2c_driver = {
+	.owner		= THIS_MODULE,
+	.name		= DRV_NAME,
+	.match_table	= mpc_i2c_of_match,
+	.probe		= mpc_i2c_probe,
+	.remove		= __devexit_p(mpc_i2c_remove),
+	.driver		= {
+		.name	= DRV_NAME,
 	},
 };

-static int __init fsl_i2c_init(void)
+static int __init mpc_i2c_init(void)
 {
-	return platform_driver_register(&fsl_i2c_driver);
+	int rv;
+
+	rv = of_register_platform_driver(&mpc_i2c_driver);
+	if (rv) {
+		printk(KERN_ERR DRV_NAME " of_register_platform_driver failed (%i)\n", rv);
+		return rv;
+	}
+	return 0;
 }

-static void __exit fsl_i2c_exit(void)
+static void __exit mpc_i2c_exit(void)
 {
-	platform_driver_unregister(&fsl_i2c_driver);
+	of_unregister_platform_driver(&mpc_i2c_driver);
 }

-module_init(fsl_i2c_init);
-module_exit(fsl_i2c_exit);
+module_init(mpc_i2c_init);
+module_exit(mpc_i2c_exit);

 MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
 MODULE_DESCRIPTION
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 0242d80..b778d35 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -25,10 +25,6 @@
  * located at 0x51 will pass the validation routine due to
  * the way the registers are implemented.
  */
-static unsigned short normal_i2c[] = { I2C_CLIENT_END };
-
-/* Module parameters */
-I2C_CLIENT_INSMOD;

 #define PCF8563_REG_ST1		0x00 /* status */
 #define PCF8563_REG_ST2		0x01
@@ -72,9 +68,6 @@ struct pcf8563 {
 	int c_polarity;	/* 0: MO_C=1 means 19xx, otherwise MO_C=1 means 20xx */
 };

-static int pcf8563_probe(struct i2c_adapter *adapter, int address, int kind);
-static int pcf8563_detach(struct i2c_client *client);
-
 /*
  * In the routines that deal directly with the pcf8563 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
@@ -257,98 +250,44 @@ static const struct rtc_class_ops pcf8563_rtc_ops = {
 	.set_time	= pcf8563_rtc_set_time,
 };

-static int pcf8563_attach(struct i2c_adapter *adapter)
+static int pcf8563_remove(struct i2c_client *client)
 {
-	return i2c_probe(adapter, &addr_data, pcf8563_probe);
+	struct rtc_device *rtc = i2c_get_clientdata(client);
+
+	if (rtc)
+		rtc_device_unregister(rtc);
+	
+	return 0;
 }

+static int pcf8563_probe(struct i2c_client *client);
+
 static struct i2c_driver pcf8563_driver = {
 	.driver		= {
-		.name	= "pcf8563",
+		.name	= "rtc-pcf8563",
 	},
 	.id		= I2C_DRIVERID_PCF8563,
-	.attach_adapter = &pcf8563_attach,
-	.detach_client	= &pcf8563_detach,
+	.probe = &pcf8563_probe,
+	.remove = &pcf8563_remove,
 };

-static int pcf8563_probe(struct i2c_adapter *adapter, int address, int kind)
+static int pcf8563_probe(struct i2c_client *client)
 {
-	struct pcf8563 *pcf8563;
-	struct i2c_client *client;
+	int result;
 	struct rtc_device *rtc;
-
-	int err = 0;
-
-	dev_dbg(&adapter->dev, "%s\n", __FUNCTION__);
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
-		err = -ENODEV;
-		goto exit;
-	}
-
-	if (!(pcf8563 = kzalloc(sizeof(struct pcf8563), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	client = &pcf8563->client;
-	client->addr = address;
-	client->driver = &pcf8563_driver;
-	client->adapter	= adapter;
-
-	strlcpy(client->name, pcf8563_driver.driver.name, I2C_NAME_SIZE);
-
-	/* Verify the chip is really an PCF8563 */
-	if (kind < 0) {
-		if (pcf8563_validate_client(client) < 0) {
-			err = -ENODEV;
-			goto exit_kfree;
-		}
-	}
-
-	/* Inform the i2c layer */
-	if ((err = i2c_attach_client(client)))
-		goto exit_kfree;
-
-	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
-
+	
+	result = pcf8563_validate_client(client);
+	if (result)
+		return result;
+	
 	rtc = rtc_device_register(pcf8563_driver.driver.name, &client->dev,
 				&pcf8563_rtc_ops, THIS_MODULE);
-
-	if (IS_ERR(rtc)) {
-		err = PTR_ERR(rtc);
-		goto exit_detach;
-	}
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);

 	i2c_set_clientdata(client, rtc);

 	return 0;
-
-exit_detach:
-	i2c_detach_client(client);
-
-exit_kfree:
-	kfree(pcf8563);
-
-exit:
-	return err;
-}
-
-static int pcf8563_detach(struct i2c_client *client)
-{
-	struct pcf8563 *pcf8563 = container_of(client, struct pcf8563, client);
-	int err;
-	struct rtc_device *rtc = i2c_get_clientdata(client);
-
-	if (rtc)
-		rtc_device_unregister(rtc);
-
-	if ((err = i2c_detach_client(client)))
-		return err;
-
-	kfree(pcf8563);
-
-	return 0;
 }

 static int __init pcf8563_init(void)
		
-- 
Jon Smirl
jonsmirl@gmail.com

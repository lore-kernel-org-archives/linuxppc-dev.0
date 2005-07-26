Return-Path: <gregkh@suse.de>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id 43C3767CDD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 07:48:21 +1000 (EST)
To: galak@freescale.com, greg@kroah.com, gregkh@suse.de,
	kumar.gala@freescale.com, linuxppc-embedded@ozlabs.org
From: <gregkh@suse.de>
Date: Tue, 26 Jul 2005 14:48:48 -0700
In-Reply-To: <Pine.LNX.4.61.0507142157350.14920@nylon.am.freescale.net>
Message-ID: <1DxXI9-2sG-00@press.kroah.org>
Subject: patch i2c-mpc-restore-code-removed.patch added to gregkh-2.6 tree
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: I2C-MPC: Restore code removed

to my gregkh-2.6 tree.  Its filename is

     i2c-mpc-restore-code-removed.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from galak@freescale.com are

i2c-mpc-restore-code-removed.patch


>From galak@freescale.com Thu Jul 14 20:02:54 2005
Date: Thu, 14 Jul 2005 21:58:46 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org,
        linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: I2C-MPC: Restore code removed
Message-ID: <Pine.LNX.4.61.0507142157350.14920@nylon.am.freescale.net>


I2C-MPC: Restore code removed

A previous patch to remove support for the OCP device model was way
to generious and moved some of the platform device model code, oops.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -288,6 +288,100 @@ static struct i2c_adapter mpc_ops = {
 	.retries = 1
 };
 
+static int fsl_i2c_probe(struct device *device)
+{
+	int result = 0;
+	struct mpc_i2c *i2c;
+	struct platform_device *pdev = to_platform_device(device);
+	struct fsl_i2c_platform_data *pdata;
+	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	pdata = (struct fsl_i2c_platform_data *) pdev->dev.platform_data;
+
+	if (!(i2c = kmalloc(sizeof(*i2c), GFP_KERNEL))) {
+		return -ENOMEM;
+	}
+	memset(i2c, 0, sizeof(*i2c));
+
+	i2c->irq = platform_get_irq(pdev, 0);
+	i2c->flags = pdata->device_flags;
+	init_waitqueue_head(&i2c->queue);
+
+	i2c->base = ioremap((phys_addr_t)r->start, MPC_I2C_REGION);
+
+	if (!i2c->base) {
+		printk(KERN_ERR "i2c-mpc - failed to map controller\n");
+		result = -ENOMEM;
+		goto fail_map;
+	}
+
+	if (i2c->irq != 0)
+		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
+					  SA_SHIRQ, "i2c-mpc", i2c)) < 0) {
+			printk(KERN_ERR
+			       "i2c-mpc - failed to attach interrupt\n");
+			goto fail_irq;
+		}
+
+	mpc_i2c_setclock(i2c);
+	dev_set_drvdata(device, i2c);
+
+	i2c->adap = mpc_ops;
+	i2c_set_adapdata(&i2c->adap, i2c);
+	i2c->adap.dev.parent = &pdev->dev;
+	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
+		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
+		goto fail_add;
+	}
+
+	return result;
+
+      fail_add:
+	if (i2c->irq != 0)
+		free_irq(i2c->irq, NULL);
+      fail_irq:
+	iounmap(i2c->base);
+      fail_map:
+	kfree(i2c);
+	return result;
+};
+
+static int fsl_i2c_remove(struct device *device)
+{
+	struct mpc_i2c *i2c = dev_get_drvdata(device);
+
+	i2c_del_adapter(&i2c->adap);
+	dev_set_drvdata(device, NULL);
+
+	if (i2c->irq != 0)
+		free_irq(i2c->irq, i2c);
+
+	iounmap(i2c->base);
+	kfree(i2c);
+	return 0;
+};
+
+/* Structure for a device driver */
+static struct device_driver fsl_i2c_driver = {
+	.name = "fsl-i2c",
+	.bus = &platform_bus_type,
+	.probe = fsl_i2c_probe,
+	.remove = fsl_i2c_remove,
+};
+
+static int __init fsl_i2c_init(void)
+{
+	return driver_register(&fsl_i2c_driver);
+}
+
+static void __exit fsl_i2c_exit(void)
+{
+	driver_unregister(&fsl_i2c_driver);
+}
+
+module_init(fsl_i2c_init);
+module_exit(fsl_i2c_exit);
+
 MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
 MODULE_DESCRIPTION
     ("I2C-Bus adapter for MPC107 bridge and MPC824x/85xx/52xx processors");

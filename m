Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B5869DDDFC
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 04:37:52 +1000 (EST)
Date: Mon, 19 May 2008 22:37:51 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 2/8] [WATCHDOG] mpc83xx_wdt: convert to the OF platform driver
Message-ID: <20080519183751.GB16650@polina.dev.rtsoft.ru>
References: <20080519183709.GA5957@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080519183709.GA5957@polina.dev.rtsoft.ru>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Chen Gong <G.Chen@freescale.com>, Scott Wood <scottwood@freescale.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch simply converts mpc83xx_wdt to the OF platform driver so we
can directly work with the device tree without passing various stuff
through platform data.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/watchdog/mpc83xx_wdt.c |   62 +++++++++++++++++++--------------------
 1 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/watchdog/mpc83xx_wdt.c b/drivers/watchdog/mpc83xx_wdt.c
index 6905712..127d85e 100644
--- a/drivers/watchdog/mpc83xx_wdt.c
+++ b/drivers/watchdog/mpc83xx_wdt.c
@@ -19,11 +19,12 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
-#include <linux/platform_device.h>
+#include <linux/of_platform.h>
 #include <linux/module.h>
 #include <linux/watchdog.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <sysdev/fsl_soc.h>
 
 struct mpc83xx_wdt {
 	__be32 res0;
@@ -149,53 +150,42 @@ static struct miscdevice mpc83xx_wdt_miscdev = {
 	.fops	= &mpc83xx_wdt_fops,
 };
 
-static int __devinit mpc83xx_wdt_probe(struct platform_device *dev)
+static int __devinit mpc83xx_wdt_probe(struct of_device *ofdev,
+				       const struct of_device_id *match)
 {
-	struct resource *r;
 	int ret;
-	unsigned int *freq = dev->dev.platform_data;
+	u32 freq = fsl_get_sys_freq();
 
-	/* get a pointer to the register memory */
-	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!freq || freq == -1)
+		return -EINVAL;
 
-	if (!r) {
-		ret = -ENODEV;
-		goto err_out;
-	}
-
-	wd_base = ioremap(r->start, sizeof(struct mpc83xx_wdt));
-
-	if (wd_base == NULL) {
-		ret = -ENOMEM;
-		goto err_out;
-	}
+	wd_base = of_iomap(ofdev->node, 0);
+	if (!wd_base)
+		return -ENOMEM;
 
 	ret = misc_register(&mpc83xx_wdt_miscdev);
 	if (ret) {
-		printk(KERN_ERR "cannot register miscdev on minor=%d "
-				"(err=%d)\n",
-				WATCHDOG_MINOR, ret);
+		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
 		goto err_unmap;
 	}
 
 	/* Calculate the timeout in seconds */
 	if (prescale)
-		timeout_sec = (timeout * 0x10000) / (*freq);
+		timeout_sec = (timeout * 0x10000) / freq;
 	else
-		timeout_sec = timeout / (*freq);
+		timeout_sec = timeout / freq;
 
-	printk(KERN_INFO "WDT driver for MPC83xx initialized. "
-		"mode:%s timeout=%d (%d seconds)\n",
-		reset ? "reset":"interrupt", timeout, timeout_sec);
+	pr_info("WDT driver for MPC83xx initialized. mode:%s timeout=%d "
+		"(%d seconds)\n", reset ? "reset" : "interrupt", timeout,
+		timeout_sec);
 	return 0;
-
 err_unmap:
 	iounmap(wd_base);
-err_out:
 	return ret;
 }
 
-static int __devexit mpc83xx_wdt_remove(struct platform_device *dev)
+static int __devexit mpc83xx_wdt_remove(struct of_device *ofdev)
 {
 	misc_deregister(&mpc83xx_wdt_miscdev);
 	iounmap(wd_base);
@@ -203,7 +193,16 @@ static int __devexit mpc83xx_wdt_remove(struct platform_device *dev)
 	return 0;
 }
 
-static struct platform_driver mpc83xx_wdt_driver = {
+static const struct of_device_id mpc83xx_wdt_match[] = {
+	{
+		.compatible = "mpc83xx_wdt",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpc83xx_wdt_match);
+
+static struct of_platform_driver mpc83xx_wdt_driver = {
+	.match_table	= mpc83xx_wdt_match,
 	.probe		= mpc83xx_wdt_probe,
 	.remove		= __devexit_p(mpc83xx_wdt_remove),
 	.driver		= {
@@ -214,12 +213,12 @@ static struct platform_driver mpc83xx_wdt_driver = {
 
 static int __init mpc83xx_wdt_init(void)
 {
-	return platform_driver_register(&mpc83xx_wdt_driver);
+	return of_register_platform_driver(&mpc83xx_wdt_driver);
 }
 
 static void __exit mpc83xx_wdt_exit(void)
 {
-	platform_driver_unregister(&mpc83xx_wdt_driver);
+	of_unregister_platform_driver(&mpc83xx_wdt_driver);
 }
 
 module_init(mpc83xx_wdt_init);
@@ -229,4 +228,3 @@ MODULE_AUTHOR("Dave Updegraff, Kumar Gala");
 MODULE_DESCRIPTION("Driver for watchdog timer in MPC83xx uProcessor");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-MODULE_ALIAS("platform:mpc83xx_wdt");
-- 
1.5.5.1

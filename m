Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id C160CDDFDF
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 00:14:56 +1000 (EST)
Date: Tue, 13 May 2008 18:14:54 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 1/6] [WATCHDOG] mpc83xx_wdt: convert to the OF platform driver
Message-ID: <20080513141454.GA15717@polina.dev.rtsoft.ru>
References: <20080513141411.GA8981@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080513141411.GA8981@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
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
---
 drivers/watchdog/mpc83xx_wdt.c |   64 ++++++++++++++++++----------------------
 1 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/watchdog/mpc83xx_wdt.c b/drivers/watchdog/mpc83xx_wdt.c
index b16c5cd..8f59225 100644
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
 #include <asm/io.h>
 #include <asm/uaccess.h>
+#include <sysdev/fsl_soc.h>
 
 struct mpc83xx_wdt {
 	__be32 res0;
@@ -147,53 +148,42 @@ static struct miscdevice mpc83xx_wdt_miscdev = {
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
-	wd_base = ioremap(r->start, sizeof (struct mpc83xx_wdt));
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
@@ -201,23 +191,27 @@ static int __devexit mpc83xx_wdt_remove(struct platform_device *dev)
 	return 0;
 }
 
-static struct platform_driver mpc83xx_wdt_driver = {
+static const struct of_device_id mpc83xx_wdt_match[] = {
+	{ .compatible = "mpc83xx_wdt", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpc83xx_wdt_match);
+
+static struct of_platform_driver mpc83xx_wdt_driver = {
+	.name		= "mpc83xx_wdt",
+	.match_table	= mpc83xx_wdt_match,
 	.probe		= mpc83xx_wdt_probe,
 	.remove		= __devexit_p(mpc83xx_wdt_remove),
-	.driver		= {
-		.name	= "mpc83xx_wdt",
-		.owner	= THIS_MODULE,
-	},
 };
 
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
-- 
1.5.5.1

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8EB32DE96D
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 02:44:32 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/10] mpc52xx_psc_spi: remove code associated with
	!CONFIG_PPC_MERGE
Date: Fri,  1 Aug 2008 11:44:17 -0500
Message-Id: <1217609060-6381-8-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1217609060-6381-7-git-send-email-galak@kernel.crashing.org>
References: <1217609060-6381-1-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-2-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-3-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-4-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-5-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-6-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-7-git-send-email-galak@kernel.crashing.org>
Cc: spi-devel-general@lists.sourceforge.net, dbrownell@users.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that arch/ppc is gone we don't need CONFIG_PPC_MERGE anymore
remove the dead code associated with !CONFIG_PPC_MERGE.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/spi/mpc52xx_psc_spi.c |   55 -----------------------------------------
 1 files changed, 0 insertions(+), 55 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 25eda71..c3a9e5c 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -15,13 +15,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
-
-#if defined(CONFIG_PPC_MERGE)
 #include <linux/of_platform.h>
-#else
-#include <linux/platform_device.h>
-#endif
-
 #include <linux/workqueue.h>
 #include <linux/completion.h>
 #include <linux/io.h>
@@ -471,53 +465,6 @@ static int __exit mpc52xx_psc_spi_do_remove(struct device *dev)
 	return 0;
 }
 
-#if !defined(CONFIG_PPC_MERGE)
-static int __init mpc52xx_psc_spi_probe(struct platform_device *dev)
-{
-	switch(dev->id) {
-	case 1:
-	case 2:
-	case 3:
-	case 6:
-		return mpc52xx_psc_spi_do_probe(&dev->dev,
-			MPC52xx_PA(MPC52xx_PSCx_OFFSET(dev->id)),
-			MPC52xx_PSC_SIZE, platform_get_irq(dev, 0), dev->id);
-	default:
-		return -EINVAL;
-	}
-}
-
-static int __exit mpc52xx_psc_spi_remove(struct platform_device *dev)
-{
-	return mpc52xx_psc_spi_do_remove(&dev->dev);
-}
-
-/* work with hotplug and coldplug */
-MODULE_ALIAS("platform:mpc52xx-psc-spi");
-
-static struct platform_driver mpc52xx_psc_spi_platform_driver = {
-	.remove = __exit_p(mpc52xx_psc_spi_remove),
-	.driver = {
-		.name = "mpc52xx-psc-spi",
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init mpc52xx_psc_spi_init(void)
-{
-	return platform_driver_probe(&mpc52xx_psc_spi_platform_driver,
-			mpc52xx_psc_spi_probe);
-}
-module_init(mpc52xx_psc_spi_init);
-
-static void __exit mpc52xx_psc_spi_exit(void)
-{
-	platform_driver_unregister(&mpc52xx_psc_spi_platform_driver);
-}
-module_exit(mpc52xx_psc_spi_exit);
-
-#else	/* defined(CONFIG_PPC_MERGE) */
-
 static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
 	const struct of_device_id *match)
 {
@@ -586,8 +533,6 @@ static void __exit mpc52xx_psc_spi_exit(void)
 }
 module_exit(mpc52xx_psc_spi_exit);
 
-#endif	/* defined(CONFIG_PPC_MERGE) */
-
 MODULE_AUTHOR("Dragos Carp");
 MODULE_DESCRIPTION("MPC52xx PSC SPI Driver");
 MODULE_LICENSE("GPL");
-- 
1.5.5.1

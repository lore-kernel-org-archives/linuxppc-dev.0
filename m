Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id 1EB8210081F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Apr 2011 07:43:23 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/14] ARM / OMAP: Use struct syscore_ops for "core" power
	management
Date: Sun, 17 Apr 2011 23:08:07 +0200
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
In-Reply-To: <201104172301.54115.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201104172308.08049.rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Russell King <linux@arm.linux.org.uk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Greg KH <gregkh@suse.de>, Ralf Baechle <ralf@linux-mips.org>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>,
	Kay Sievers <kay.sievers@suse.de>, Mike Frysinger <vapier@gentoo.org>,
	Linux PM mailing list <linux-pm@lists.linux-foundation.org>,
	linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rafael J. Wysocki <rjw@sisk.pl>

Replace the sysdev class and struct sys_device used for power
management in the OMAP's GPIO code with a struct syscore_ops object
which is simpler.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/gpio.c |   35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

Index: linux-2.6/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/gpio.c
+++ linux-2.6/arch/arm/plat-omap/gpio.c
@@ -17,7 +17,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -1372,9 +1372,7 @@ static const struct dev_pm_ops omap_mpui
 	.resume_noirq = omap_mpuio_resume_noirq,
 };
 
-/* use platform_driver for this, now that there's no longer any
- * point to sys_device (other than not disturbing old code).
- */
+/* use platform_driver for this. */
 static struct platform_driver omap_mpuio_driver = {
 	.driver		= {
 		.name	= "mpuio",
@@ -1745,7 +1743,7 @@ static int __devinit omap_gpio_probe(str
 }
 
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
+static int omap_gpio_suspend(void)
 {
 	int i;
 
@@ -1795,12 +1793,12 @@ static int omap_gpio_suspend(struct sys_
 	return 0;
 }
 
-static int omap_gpio_resume(struct sys_device *dev)
+static void omap_gpio_resume(void)
 {
 	int i;
 
 	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
-		return 0;
+		return;
 
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
@@ -1836,21 +1834,13 @@ static int omap_gpio_resume(struct sys_d
 		__raw_writel(bank->saved_wakeup, wake_set);
 		spin_unlock_irqrestore(&bank->lock, flags);
 	}
-
-	return 0;
 }
 
-static struct sysdev_class omap_gpio_sysclass = {
-	.name		= "gpio",
+static struct syscore_ops omap_gpio_syscore_ops = {
 	.suspend	= omap_gpio_suspend,
 	.resume		= omap_gpio_resume,
 };
 
-static struct sys_device omap_gpio_device = {
-	.id		= 0,
-	.cls		= &omap_gpio_sysclass,
-};
-
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
@@ -2108,21 +2098,14 @@ postcore_initcall(omap_gpio_drv_reg);
 
 static int __init omap_gpio_sysinit(void)
 {
-	int ret = 0;
-
 	mpuio_init();
 
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
-		if (ret == 0) {
-			ret = sysdev_class_register(&omap_gpio_sysclass);
-			if (ret == 0)
-				ret = sysdev_register(&omap_gpio_device);
-		}
-	}
+	if (cpu_is_omap16xx() || cpu_class_is_omap2())
+		register_syscore_ops(&omap_gpio_syscore_ops);
 #endif
 
-	return ret;
+	return 0;
 }
 
 arch_initcall(omap_gpio_sysinit);

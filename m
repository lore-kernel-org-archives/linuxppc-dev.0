Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3648E1A08B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:29:50 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XbNLI-002c2Y-8N
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Oct 2014 05:29:48 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 12/44] mfd: ab8500-sysctrl: Register with kernel poweroff
 handler
Date: Mon,  6 Oct 2014 22:28:14 -0700
Message-Id: <1412659726-29957-13-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, Linus Walleij <linus.walleij@linaro.org>,
 Lee Jones <lee.jones@linaro.org>, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, lguest@lists.ozlabs.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-pm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
 linux-tegra@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Samuel Ortiz <sameo@linux.intel.com>, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with a low priority value of 64 to reflect that
the original code only sets pm_power_off if it was not already set.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mfd/ab8500-sysctrl.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 8e0dae5..677438f 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -6,6 +6,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/reboot.h>
@@ -23,7 +24,8 @@
 
 static struct device *sysctrl_dev;
 
-static void ab8500_power_off(void)
+static int ab8500_power_off(struct notifier_block *this, unsigned long unused1,
+			    void *unused2)
 {
 	sigset_t old;
 	sigset_t all;
@@ -34,11 +36,6 @@ static void ab8500_power_off(void)
 	struct power_supply *psy;
 	int ret;
 
-	if (sysctrl_dev == NULL) {
-		pr_err("%s: sysctrl not initialized\n", __func__);
-		return;
-	}
-
 	/*
 	 * If we have a charger connected and we're powering off,
 	 * reboot into charge-only mode.
@@ -83,8 +80,15 @@ shutdown:
 					 AB8500_STW4500CTRL1_SWRESET4500N);
 		(void)sigprocmask(SIG_SETMASK, &old, NULL);
 	}
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block ab8500_poweroff_nb = {
+	.notifier_call = ab8500_power_off,
+	.priority = 64,
+};
+
 /*
  * Use the AB WD to reset the platform. It will perform a hard
  * reset instead of a soft reset. Write the reset reason to
@@ -185,6 +189,7 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
 	struct ab8500_platform_data *plat;
 	struct ab8500_sysctrl_platform_data *pdata;
+	int err;
 
 	plat = dev_get_platdata(pdev->dev.parent);
 
@@ -193,8 +198,9 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 
 	sysctrl_dev = &pdev->dev;
 
-	if (!pm_power_off)
-		pm_power_off = ab8500_power_off;
+	err = register_poweroff_handler(&ab8500_poweroff_nb);
+	if (err)
+		dev_err(&pdev->dev, "Failed to register poweroff handler\n");
 
 	pdata = plat->sysctrl;
 	if (pdata) {
@@ -226,11 +232,9 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 
 static int ab8500_sysctrl_remove(struct platform_device *pdev)
 {
+	unregister_poweroff_handler(&ab8500_poweroff_nb);
 	sysctrl_dev = NULL;
 
-	if (pm_power_off == ab8500_power_off)
-		pm_power_off = NULL;
-
 	return 0;
 }
 
-- 
1.9.1

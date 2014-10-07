Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C49291A070C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:29:49 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XbNLH-002c1Y-Sn
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Oct 2014 05:29:47 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 13/44] mfd: max8907: Register with kernel poweroff handler
Date: Mon,  6 Oct 2014 22:28:15 -0700
Message-Id: <1412659726-29957-14-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, Lee Jones <lee.jones@linaro.org>,
 devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 lguest@lists.ozlabs.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, linux-pm@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-m68k@lists.linux-m68k.org,
 linux-am33-list@redhat.com, linux-tegra@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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

Note that this patch fixes a problem on driver unload as side effect:
The old code did not restore or clean up pm_power_off on remove,
meaning the pointer was left in an undefined state.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mfd/max8907.c       | 24 ++++++++++++++++++------
 include/linux/mfd/max8907.h |  2 ++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 232749c..b8cddc1 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -177,11 +178,16 @@ static const struct regmap_irq_chip max8907_rtc_irq_chip = {
 	.num_irqs = ARRAY_SIZE(max8907_rtc_irqs),
 };
 
-static struct max8907 *max8907_pm_off;
-static void max8907_power_off(void)
+static int max8907_power_off(struct notifier_block *this, unsigned long unused1,
+			     void *unused2)
 {
-	regmap_update_bits(max8907_pm_off->regmap_gen, MAX8907_REG_RESET_CNFG,
+	struct max8907 *max8907 = container_of(this, struct max8907,
+					       poweroff_nb);
+
+	regmap_update_bits(max8907->regmap_gen, MAX8907_REG_RESET_CNFG,
 			MAX8907_MASK_POWER_OFF, MAX8907_MASK_POWER_OFF);
+
+	return NOTIFY_DONE;
 }
 
 static int max8907_i2c_probe(struct i2c_client *i2c,
@@ -267,9 +273,13 @@ static int max8907_i2c_probe(struct i2c_client *i2c,
 		goto err_add_devices;
 	}
 
-	if (pm_off && !pm_power_off) {
-		max8907_pm_off = max8907;
-		pm_power_off = max8907_power_off;
+	if (pm_off) {
+		max8907->poweroff_nb.notifier_call = max8907_power_off;
+		max8907->poweroff_nb.priority = 64;
+		ret = register_poweroff_handler(&max8907->poweroff_nb);
+		if (ret)
+			dev_err(&i2c->dev,
+				"Failed to register poweroff handler");
 	}
 
 	return 0;
@@ -293,6 +303,8 @@ static int max8907_i2c_remove(struct i2c_client *i2c)
 {
 	struct max8907 *max8907 = i2c_get_clientdata(i2c);
 
+	unregister_poweroff_handler(&max8907->poweroff_nb);
+
 	mfd_remove_devices(max8907->dev);
 
 	regmap_del_irq_chip(max8907->i2c_gen->irq, max8907->irqc_rtc);
diff --git a/include/linux/mfd/max8907.h b/include/linux/mfd/max8907.h
index b06f7a6..016428e 100644
--- a/include/linux/mfd/max8907.h
+++ b/include/linux/mfd/max8907.h
@@ -13,6 +13,7 @@
 #define __LINUX_MFD_MAX8907_H
 
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/pm.h>
 
 #define MAX8907_GEN_I2C_ADDR		(0x78 >> 1)
@@ -247,6 +248,7 @@ struct max8907 {
 	struct regmap_irq_chip_data	*irqc_chg;
 	struct regmap_irq_chip_data	*irqc_on_off;
 	struct regmap_irq_chip_data	*irqc_rtc;
+	struct notifier_block		poweroff_nb;
 };
 
 #endif
-- 
1.9.1

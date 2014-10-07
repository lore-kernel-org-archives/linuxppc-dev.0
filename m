Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449591A0697
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:29:50 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XbNLI-002c2n-9g
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Oct 2014 05:29:48 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/44] mfd: axp20x: Register with kernel poweroff handler
Date: Mon,  6 Oct 2014 22:28:12 -0700
Message-Id: <1412659726-29957-11-git-send-email-linux@roeck-us.net>
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

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mfd/axp20x.c       | 30 +++++++++++++++++-------------
 include/linux/mfd/axp20x.h |  1 +
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index dee6539..238db4c 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -17,7 +17,8 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/pm_runtime.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
@@ -161,11 +162,16 @@ static struct mfd_cell axp20x_cells[] = {
 	},
 };
 
-static struct axp20x_dev *axp20x_pm_power_off;
-static void axp20x_power_off(void)
+static int axp20x_power_off(struct notifier_block *this, unsigned long unused1,
+			    void *unused2)
+
 {
-	regmap_write(axp20x_pm_power_off->regmap, AXP20X_OFF_CTRL,
-		     AXP20X_OFF);
+	struct axp20x_dev *axp20x = container_of(this, struct axp20x_dev,
+						 poweroff_nb);
+
+	regmap_write(axp20x->regmap, AXP20X_OFF_CTRL, AXP20X_OFF);
+
+	return NOTIFY_DONE;
 }
 
 static int axp20x_i2c_probe(struct i2c_client *i2c,
@@ -215,10 +221,11 @@ static int axp20x_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (!pm_power_off) {
-		axp20x_pm_power_off = axp20x;
-		pm_power_off = axp20x_power_off;
-	}
+	axp20x->poweroff_nb.notifier_call = axp20x_power_off;
+	axp20x->poweroff_nb.priority = 64;
+	ret = register_poweroff_handler(&axp20x->poweroff_nb);
+	if (ret)
+		dev_err(&i2c->dev, "failed to register poweroff handler\n");
 
 	dev_info(&i2c->dev, "AXP20X driver loaded\n");
 
@@ -229,10 +236,7 @@ static int axp20x_i2c_remove(struct i2c_client *i2c)
 {
 	struct axp20x_dev *axp20x = i2c_get_clientdata(i2c);
 
-	if (axp20x == axp20x_pm_power_off) {
-		axp20x_pm_power_off = NULL;
-		pm_power_off = NULL;
-	}
+	unregister_poweroff_handler(&axp20x->poweroff_nb);
 
 	mfd_remove_devices(axp20x->dev);
 	regmap_del_irq_chip(axp20x->i2c_client->irq, axp20x->regmap_irqc);
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index d0e31a2..8f23b39 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -175,6 +175,7 @@ struct axp20x_dev {
 	struct regmap			*regmap;
 	struct regmap_irq_chip_data	*regmap_irqc;
 	long				variant;
+	struct notifier_block		poweroff_nb;
 };
 
 #endif /* __LINUX_MFD_AXP20X_H */
-- 
1.9.1

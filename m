Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0EF331A03A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:29:56 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XbNLO-002cWC-SO
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Oct 2014 05:29:54 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 11/44] mfd: retu: Register with kernel poweroff handler
Date: Mon,  6 Oct 2014 22:28:13 -0700
Message-Id: <1412659726-29957-12-git-send-email-linux@roeck-us.net>
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
 drivers/mfd/retu-mfd.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
index 663f8a3..64b60fa 100644
--- a/drivers/mfd/retu-mfd.c
+++ b/drivers/mfd/retu-mfd.c
@@ -22,6 +22,8 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/retu.h>
@@ -43,6 +45,7 @@ struct retu_dev {
 	struct device			*dev;
 	struct mutex			mutex;
 	struct regmap_irq_chip_data	*irq_data;
+	struct notifier_block		poweroff_nb;
 };
 
 static struct resource retu_pwrbutton_res[] = {
@@ -81,9 +84,6 @@ static struct regmap_irq_chip retu_irq_chip = {
 	.ack_base	= RETU_REG_IDR,
 };
 
-/* Retu device registered for the power off. */
-static struct retu_dev *retu_pm_power_off;
-
 static struct resource tahvo_usb_res[] = {
 	{
 		.name	= "tahvo-usb",
@@ -165,12 +165,14 @@ int retu_write(struct retu_dev *rdev, u8 reg, u16 data)
 }
 EXPORT_SYMBOL_GPL(retu_write);
 
-static void retu_power_off(void)
+static int retu_power_off(struct notifier_block *this, unsigned long unused1,
+			  void *unused2)
 {
-	struct retu_dev *rdev = retu_pm_power_off;
+	struct retu_dev *rdev = container_of(this, struct retu_dev,
+					     poweroff_nb);
 	int reg;
 
-	mutex_lock(&retu_pm_power_off->mutex);
+	mutex_lock(&rdev->mutex);
 
 	/* Ignore power button state */
 	regmap_read(rdev->regmap, RETU_REG_CC1, &reg);
@@ -183,7 +185,9 @@ static void retu_power_off(void)
 	for (;;)
 		cpu_relax();
 
-	mutex_unlock(&retu_pm_power_off->mutex);
+	mutex_unlock(&rdev->mutex);
+
+	return NOTIFY_DONE;
 }
 
 static int retu_regmap_read(void *context, const void *reg, size_t reg_size,
@@ -279,9 +283,13 @@ static int retu_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 		return ret;
 	}
 
-	if (i2c->addr == 1 && !pm_power_off) {
-		retu_pm_power_off = rdev;
-		pm_power_off	  = retu_power_off;
+	if (i2c->addr == 1) {
+		rdev->poweroff_nb.notifier_call = retu_power_off;
+		rdev->poweroff_nb.priority = 64;
+		ret = register_poweroff_handler(&rdev->poweroff_nb);
+		if (ret)
+			dev_err(rdev->dev,
+				"Failed to register poweroff handler\n");
 	}
 
 	return 0;
@@ -291,10 +299,7 @@ static int retu_remove(struct i2c_client *i2c)
 {
 	struct retu_dev *rdev = i2c_get_clientdata(i2c);
 
-	if (retu_pm_power_off == rdev) {
-		pm_power_off	  = NULL;
-		retu_pm_power_off = NULL;
-	}
+	unregister_poweroff_handler(&rdev->poweroff_nb);
 	mfd_remove_devices(rdev->dev);
 	regmap_del_irq_chip(i2c->irq, rdev->irq_data);
 
-- 
1.9.1

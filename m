Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E84181A0A42
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:30:26 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XbNLs-002fDQ-PK
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Oct 2014 05:30:24 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 29/44] staging: nvec: Register with kernel poweroff handler
Date: Mon,  6 Oct 2014 22:28:31 -0700
Message-Id: <1412659726-29957-30-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, lguest@lists.ozlabs.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-pm@vger.kernel.org, Julian Andres Klode <jak@jak-linux.org>,
 adi-buildroot-devel@lists.sourceforge.net, linux-m68k@lists.linux-m68k.org,
 linux-am33-list@redhat.com, linux-tegra@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
directly. Register with default priority value of 128 since we don't know
any better.

Cc: Julian Andres Klode <jak@jak-linux.org>
Cc: Marc Dietrich <marvin24@gmx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/nvec/nvec.c | 24 +++++++++++++++---------
 drivers/staging/nvec/nvec.h |  2 ++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index a93208a..33d406c 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -33,6 +33,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
@@ -80,8 +81,6 @@ enum nvec_sleep_subcmds {
 #define LID_SWITCH BIT(1)
 #define PWR_BUTTON BIT(15)
 
-static struct nvec_chip *nvec_power_handle;
-
 static const struct mfd_cell nvec_devices[] = {
 	{
 		.name = "nvec-kbd",
@@ -759,12 +758,17 @@ static void nvec_disable_i2c_slave(struct nvec_chip *nvec)
 }
 #endif
 
-static void nvec_power_off(void)
+static int nvec_power_off(struct notifier_block *this, unsigned long unused1,
+			  void *unused2)
 {
+	struct nvec_chip *nvec = container_of(this, struct nvec_chip,
+					      poweroff_nb);
 	char ap_pwr_down[] = { NVEC_SLEEP, AP_PWR_DOWN };
 
-	nvec_toggle_global_events(nvec_power_handle, false);
-	nvec_write_async(nvec_power_handle, ap_pwr_down, 2);
+	nvec_toggle_global_events(nvec, false);
+	nvec_write_async(nvec, ap_pwr_down, 2);
+
+	return NOTIFY_DONE;
 }
 
 /*
@@ -878,8 +882,11 @@ static int tegra_nvec_probe(struct platform_device *pdev)
 	nvec->nvec_status_notifier.notifier_call = nvec_status_notifier;
 	nvec_register_notifier(nvec, &nvec->nvec_status_notifier, 0);
 
-	nvec_power_handle = nvec;
-	pm_power_off = nvec_power_off;
+	nvec->poweroff_nb.notifier_call = nvec_power_off;
+	nvec->poweroff_nb.priority = 128;
+	ret = register_poweroff_handler(&nvec->poweroff_nb);
+	if (ret)
+		dev_err(nvec->dev, "Failed to register poweroff handler\n");
 
 	/* Get Firmware Version */
 	msg = nvec_write_sync(nvec, get_firmware_version, 2);
@@ -914,13 +921,12 @@ static int tegra_nvec_remove(struct platform_device *pdev)
 {
 	struct nvec_chip *nvec = platform_get_drvdata(pdev);
 
+	unregister_poweroff_handler(&nvec->poweroff_nb);
 	nvec_toggle_global_events(nvec, false);
 	mfd_remove_devices(nvec->dev);
 	nvec_unregister_notifier(nvec, &nvec->nvec_status_notifier);
 	cancel_work_sync(&nvec->rx_work);
 	cancel_work_sync(&nvec->tx_work);
-	/* FIXME: needs check wether nvec is responsible for power off */
-	pm_power_off = NULL;
 
 	return 0;
 }
diff --git a/drivers/staging/nvec/nvec.h b/drivers/staging/nvec/nvec.h
index e271375..e5ee2af 100644
--- a/drivers/staging/nvec/nvec.h
+++ b/drivers/staging/nvec/nvec.h
@@ -163,6 +163,8 @@ struct nvec_chip {
 	struct nvec_msg *last_sync_msg;
 
 	int state;
+
+	struct notifier_block poweroff_nb;
 };
 
 extern int nvec_write_async(struct nvec_chip *nvec, const unsigned char *data,
-- 
1.9.1

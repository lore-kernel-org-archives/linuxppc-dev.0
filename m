Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14F071A03A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:30:18 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XbNLj-002eKv-LV
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Oct 2014 05:30:15 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 26/44] x86: iris: Register with kernel poweroff handler
Date: Mon,  6 Oct 2014 22:28:28 -0700
Message-Id: <1412659726-29957-27-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, lguest@lists.ozlabs.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, linux-pm@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-m68k@lists.linux-m68k.org,
 linux-am33-list@redhat.com, linux-tegra@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
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
directly. Register with high priority value of 192 to reflect that
the original code overwrites existing poweroff handlers.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/platform/iris/iris.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/iris/iris.c b/arch/x86/platform/iris/iris.c
index 4d171e8..662c4e8 100644
--- a/arch/x86/platform/iris/iris.c
+++ b/arch/x86/platform/iris/iris.c
@@ -23,6 +23,7 @@
 
 #include <linux/moduleparam.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -47,15 +48,21 @@ static bool force;
 module_param(force, bool, 0);
 MODULE_PARM_DESC(force, "Set to one to force poweroff handler installation.");
 
-static void (*old_pm_power_off)(void);
-
-static void iris_power_off(void)
+static int iris_power_off(struct notifier_block *this, unsigned long unused1,
+			  void *unused2)
 {
 	outb(IRIS_GIO_PULSE, IRIS_GIO_OUTPUT);
 	msleep(850);
 	outb(IRIS_GIO_REST, IRIS_GIO_OUTPUT);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block iris_poweroff_nb = {
+	.notifier_call = iris_power_off,
+	.priority = 192,
+};
+
 /*
  * Before installing the power_off handler, try to make sure the OS is
  * running on an Iris.  Since Iris does not support DMI, this is done
@@ -65,20 +72,26 @@ static void iris_power_off(void)
 static int iris_probe(struct platform_device *pdev)
 {
 	unsigned char status = inb(IRIS_GIO_INPUT);
+	int ret;
+
 	if (status == IRIS_GIO_NODEV) {
 		printk(KERN_ERR "This machine does not seem to be an Iris. "
 			"Power off handler not installed.\n");
 		return -ENODEV;
 	}
-	old_pm_power_off = pm_power_off;
-	pm_power_off = &iris_power_off;
+
+	ret = register_poweroff_handler(&iris_poweroff_nb);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register poweroff handler\n");
+		return ret;
+	}
 	printk(KERN_INFO "Iris power_off handler installed.\n");
 	return 0;
 }
 
 static int iris_remove(struct platform_device *pdev)
 {
-	pm_power_off = old_pm_power_off;
+	unregister_poweroff_handler(&iris_poweroff_nb);
 	printk(KERN_INFO "Iris power_off handler uninstalled.\n");
 	return 0;
 }
-- 
1.9.1

Return-Path: <arnd@arndb.de>
Message-Id: <20080715195739.681740070@arndb.de>
References: <20080715195139.316677337@arndb.de>
Date: Tue, 15 Jul 2008 21:51:45 +0200
From: arnd@arndb.de
To: benh@kernel.crashing.org, cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: [patch 6/9] powerpc/cell: add support for power button of future IBM
	cell blades
Cc: Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Krafft <krafft@de.ibm.com>

This patch adds support for the power button on future IBM cell blades.
It actually doesn't shut down the machine. Instead it exposes an
input device /dev/input/event0 to userspace which sends KEY_POWER
if power button has been pressed.
haldaemon actually recognizes the button, so a plattform independent acpid
replacement should handle it correctly.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/Kconfig           |    8 ++
 arch/powerpc/platforms/cell/Makefile          |    2 +
 arch/powerpc/platforms/cell/cbe_powerbutton.c |  117 +++++++++++++++++++++++++
 include/asm-powerpc/pmi.h                     |    1 +
 4 files changed, 128 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/cell/cbe_powerbutton.c

diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 2d1957b..c14d7d8 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -91,6 +91,14 @@ config PPC_IBM_CELL_RESETBUTTON
 	  Support Pinhole Resetbutton on IBM Cell blades.
 	  This adds a method to trigger system reset via front panel pinhole button.
 
+config PPC_IBM_CELL_POWERBUTTON
+	tristate "IBM Cell Blade power button"
+	depends on PPC_IBM_CELL_BLADE && PPC_PMI && INPUT_EVDEV
+	default y
+	help
+	  Support Powerbutton on IBM Cell blades.
+	  This will enable the powerbutton as an input device.
+
 config CBE_THERM
 	tristate "CBE thermal support"
 	default m
diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
index 7fcf09b..7fd8308 100644
--- a/arch/powerpc/platforms/cell/Makefile
+++ b/arch/powerpc/platforms/cell/Makefile
@@ -10,6 +10,8 @@ obj-$(CONFIG_CBE_CPUFREQ)		+= cbe-cpufreq.o
 cbe-cpufreq-y				+= cbe_cpufreq_pervasive.o cbe_cpufreq.o
 obj-$(CONFIG_CBE_CPUFREQ_SPU_GOVERNOR)	+= cpufreq_spudemand.o
 
+obj-$(CONFIG_PPC_IBM_CELL_POWERBUTTON)	+= cbe_powerbutton.o
+
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_CELL_NATIVE)		+= smp.o
 endif
diff --git a/arch/powerpc/platforms/cell/cbe_powerbutton.c b/arch/powerpc/platforms/cell/cbe_powerbutton.c
new file mode 100644
index 0000000..dcddaa5
--- /dev/null
+++ b/arch/powerpc/platforms/cell/cbe_powerbutton.c
@@ -0,0 +1,117 @@
+/*
+ * driver for powerbutton on IBM cell blades
+ *
+ * (C) Copyright IBM Corp. 2005-2008
+ *
+ * Author: Christian Krafft <krafft@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/input.h>
+#include <linux/platform_device.h>
+#include <asm/pmi.h>
+#include <asm/prom.h>
+
+static struct input_dev *button_dev;
+static struct platform_device *button_pdev;
+
+static void cbe_powerbutton_handle_pmi(pmi_message_t pmi_msg)
+{
+	BUG_ON(pmi_msg.type != PMI_TYPE_POWER_BUTTON);
+
+	input_report_key(button_dev, KEY_POWER, 1);
+	input_sync(button_dev);
+	input_report_key(button_dev, KEY_POWER, 0);
+	input_sync(button_dev);
+}
+
+static struct pmi_handler cbe_pmi_handler = {
+	.type			= PMI_TYPE_POWER_BUTTON,
+	.handle_pmi_message	= cbe_powerbutton_handle_pmi,
+};
+
+static int __init cbe_powerbutton_init(void)
+{
+	int ret = 0;
+	struct input_dev *dev;
+
+	if (!machine_is_compatible("IBM,CBPLUS-1.0")) {
+		printk(KERN_ERR "%s: Not a cell blade.\n", __func__);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	dev = input_allocate_device();
+	if (!dev) {
+		ret = -ENOMEM;
+		printk(KERN_ERR "%s: Not enough memory.\n", __func__);
+		goto out;
+	}
+
+	set_bit(EV_KEY, dev->evbit);
+	set_bit(KEY_POWER, dev->keybit);
+
+	dev->name = "Power Button";
+	dev->id.bustype = BUS_HOST;
+
+	/* this makes the button look like an acpi power button
+	 * no clue whether anyone relies on that though */
+	dev->id.product = 0x02;
+	dev->phys = "LNXPWRBN/button/input0";
+
+	button_pdev = platform_device_register_simple("power_button", 0, NULL, 0);
+	if (IS_ERR(button_pdev)) {
+		ret = PTR_ERR(button_pdev);
+		goto out_free_input;
+	}
+
+	dev->dev.parent = &button_pdev->dev;
+	ret = input_register_device(dev);
+	if (ret) {
+		printk(KERN_ERR "%s: Failed to register device\n", __func__);
+		goto out_free_pdev;
+	}
+
+	button_dev = dev;
+
+	ret = pmi_register_handler(&cbe_pmi_handler);
+	if (ret) {
+		printk(KERN_ERR "%s: Failed to register with pmi.\n", __func__);
+		goto out_free_pdev;
+	}
+
+	goto out;
+
+out_free_pdev:
+	platform_device_unregister(button_pdev);
+out_free_input:
+	input_free_device(dev);
+out:
+	return ret;
+}
+
+static void __exit cbe_powerbutton_exit(void)
+{
+	pmi_unregister_handler(&cbe_pmi_handler);
+	platform_device_unregister(button_pdev);
+	input_free_device(button_dev);
+}
+
+module_init(cbe_powerbutton_init);
+module_exit(cbe_powerbutton_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Christian Krafft <krafft@de.ibm.com>");
diff --git a/include/asm-powerpc/pmi.h b/include/asm-powerpc/pmi.h
index e1dc090..b4e91fb 100644
--- a/include/asm-powerpc/pmi.h
+++ b/include/asm-powerpc/pmi.h
@@ -30,6 +30,7 @@
 #ifdef __KERNEL__
 
 #define PMI_TYPE_FREQ_CHANGE	0x01
+#define PMI_TYPE_POWER_BUTTON	0x02
 #define PMI_READ_TYPE		0
 #define PMI_READ_DATA0		1
 #define PMI_READ_DATA1		2
-- 
1.5.4.3

-- 

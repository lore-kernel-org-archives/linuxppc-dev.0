Return-Path: <arnd@arndb.de>
Message-Id: <20080704190805.638836822@arndb.de>
References: <20080704190535.316377278@arndb.de>
Date: Fri, 04 Jul 2008 21:05:36 +0200
From: arnd@arndb.de
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 01/11] powerpc/cell: add support for power button of future
	IBM cell blades
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for the power button on future IBM cell blades.
It actually doesn't shut down the machine. Instead it exposes an
input device /dev/input/event0 to userspace which sends KEY_POWER
if power button has been pressed.
haldaemon actually recognizes the button, so a plattform independent acpid
replacement should handle it correctly.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/pervasive.c |   70 ++++++++++++++++++++++++++++++-
 1 files changed, 69 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/cell/pervasive.c b/arch/powerpc/platforms/cell/pervasive.c
index 8a3631c..e5bd08c 100644
--- a/arch/powerpc/platforms/cell/pervasive.c
+++ b/arch/powerpc/platforms/cell/pervasive.c
@@ -24,8 +24,10 @@
 #undef DEBUG
 
 #include <linux/interrupt.h>
+#include <linux/input.h>
 #include <linux/irq.h>
 #include <linux/percpu.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/kallsyms.h>
 
@@ -40,6 +42,9 @@
 
 static int sysreset_hack;
 
+static struct input_dev *button_dev;
+static struct platform_device *button_pdev;
+
 static void cbe_power_save(void)
 {
 	unsigned long ctrl, thread_switch_control;
@@ -105,10 +110,21 @@ static int cbe_system_reset_exception(struct pt_regs *regs)
 		 */
 		if (sysreset_hack && (cpu = smp_processor_id()) == 0) {
 			pmd = cbe_get_cpu_pmd_regs(cpu);
-			if (in_be64(&pmd->ras_esc_0) & 0xffff) {
+			if (in_be64(&pmd->ras_esc_0) & 0x0000ffff) {
 				out_be64(&pmd->ras_esc_0, 0);
 				return 0;
 			}
+			if (in_be64(&pmd->ras_esc_0) & 0x00010000) {
+				out_be64(&pmd->ras_esc_0, 0);
+				if (!button_dev)
+					return 0;
+
+				input_report_key(button_dev, KEY_POWER, 1);
+				input_sync(button_dev);
+				input_report_key(button_dev, KEY_POWER, 0);
+				input_sync(button_dev);
+				return 1;
+			}
 		}
 		break;
 #ifdef CONFIG_CBE_RAS
@@ -155,3 +171,55 @@ void __init cbe_pervasive_init(void)
 	ppc_md.power_save = cbe_power_save;
 	ppc_md.system_reset_exception = cbe_system_reset_exception;
 }
+
+static int __init cbe_power_button_init(void)
+{
+	int ret;
+	struct input_dev *dev;
+
+	if (!sysreset_hack)
+		return 0;
+
+	dev = input_allocate_device();
+        if (!dev) {
+		ret = -ENOMEM;
+                printk(KERN_ERR "%s: Not enough memory\n", __func__);
+                goto out;
+        }
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
+
+	ret = input_register_device(dev);
+	if (ret) {
+                printk(KERN_ERR "%s: Failed to register device\n", __func__);
+		goto out_free_pdev;
+        }
+
+	button_dev = dev;
+	return ret;
+
+out_free_pdev:
+	platform_device_unregister(button_pdev);
+out_free_input:
+	input_free_device(dev);
+out:
+	return ret;
+}
+device_initcall(cbe_power_button_init);
-- 
1.5.4.3

-- 

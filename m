Return-Path: <krafft@de.ibm.com>
Date: Mon, 7 Jul 2008 18:56:44 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@linux.ibm.com>
Subject: Re: [Cbe-oss-dev] [patch 02/02] powerpc/cell: add support for power
	button of future IBM cell blades
Message-ID: <20080707185644.0d6c9757@de.ibm.com>
In-Reply-To: <20080707184756.16e52677@linux.ibm.com>
References: <20080704190535.316377278@arndb.de>
	<20080704190805.638836822@arndb.de>
	<1215407543.8970.61.camel@pasglop>
	<20080707112322.26a21902@de.ibm.com>
	<20080707184756.16e52677@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: cbe-oss-dev@ozlabs.org, arnd@arndb.de, linuxppc-dev@ozlabs.org
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

Index: linux.git/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linux.git.orig/arch/powerpc/platforms/cell/Kconfig
+++ linux.git/arch/powerpc/platforms/cell/Kconfig
@@ -87,9 +87,12 @@ config PPC_IBM_CELL_BLADE_BUTTONS
 	bool "IBM Cell Blade Buttons"
 	depends on CBE_RAS && PPC_IBM_CELL_BLADE
 	default y
+	select INPUT
+	select INPUT_EVDEV
 	help
 	  Support Buttons on IBM Cell blades. This adds a method to
-	  trigger system reset via front panel pinhole button.
+	  trigger system reset via front panel pinhole button and
+	  an input device for the power button.
 
 config CBE_THERM
 	tristate "CBE thermal support"
Index: linux.git/arch/powerpc/platforms/cell/ras.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/cell/ras.c
+++ linux.git/arch/powerpc/platforms/cell/ras.c
@@ -14,6 +14,11 @@
 #include <linux/smp.h>
 #include <linux/reboot.h>
 
+#ifdef CONFIG_PPC_IBM_CELL_BLADE_BUTTONS
+#include <linux/input.h>
+#include <linux/platform_device.h>
+#endif /* CONFIG_PPC_IBM_CELL_BLADE_BUTTONS */
+
 #include <asm/reg.h>
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -232,31 +237,76 @@ static struct notifier_block cbe_ptcal_r
 
 #ifdef CONFIG_PPC_IBM_CELL_BLADE_BUTTONS
 static int sysreset_hack;
+static struct input_dev *button_dev;
+static struct platform_device *button_pdev;
 
 static int __init cbe_sysreset_init(void)
 {
+	int ret = 0;
+	struct input_dev *dev;
 	struct cbe_pmd_regs __iomem *regs;
 
 	sysreset_hack = machine_is_compatible("IBM,CBPLUS-1.0");
 	if (!sysreset_hack)
-		return 0;
+		goto out;
 
 	regs = cbe_get_cpu_pmd_regs(0);
 	if (!regs)
-		return 0;
+		goto out;
 
 	/* Enable JTAG system-reset hack */
 	out_be32(&regs->fir_mode_reg,
 		in_be32(&regs->fir_mode_reg) |
 		CBE_PMD_FIR_MODE_M8);
 
-	return 0;
+	dev = input_allocate_device();
+	if (!dev) {
+		ret = -ENOMEM;
+		printk(KERN_ERR "%s: Not enough memory\n", __func__);
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
+ 	ret = input_register_device(dev);
+
+	if (ret) {
+		printk(KERN_ERR "%s: Failed to register device\n", __func__);
+		goto out_free_pdev;
+	}
+
+	button_dev = dev;
+	goto out;
+
+out_free_pdev:
+	platform_device_unregister(button_pdev);
+out_free_input:
+	input_free_device(dev);
+out:
+	return ret;
 }
 device_initcall(cbe_sysreset_init);
 
 int cbe_sysreset_hack(void)
 {
 	struct cbe_pmd_regs __iomem *regs;
+	u64 status;
 
 	/*
 	 * The BMC can inject user triggered system reset exceptions,
@@ -267,10 +317,20 @@ int cbe_sysreset_hack(void)
 		regs = cbe_get_cpu_pmd_regs(0);
 		if (!regs)
 			return 0;
-		if (in_be64(&regs->ras_esc_0) & 0x0000ffff) {
+		status = in_be64(&regs->ras_esc_0);
+		if (status & 0x0000ffff) {
 			out_be64(&regs->ras_esc_0, 0);
 			return 0;
 		}
+		if (status & 0x00010000) {
+			out_be64(&regs->ras_esc_0, 0);
+			if (!button_dev)
+				return 0;
+			input_report_key(button_dev, KEY_POWER, 1);
+			input_sync(button_dev);
+			input_report_key(button_dev, KEY_POWER, 0);
+			input_sync(button_dev);
+		}
 	}
 	return 1;
 }

-- 
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
Linux Kernel Development
IBM Systems & Technology Group
Phone: +49-07031-16-2032

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaetsfuehung:		Herbert Kircher
Sitz der Gesellschaft:		Boelingen
Registergericht:		Amtsgericht Stuttgart, HRB 243294

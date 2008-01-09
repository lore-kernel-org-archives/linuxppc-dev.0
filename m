Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id A8058DDF51
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 16:18:33 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] sbc8548: Add basic support for Wind River SBC8548 as
	powerpc
Date: Wed,  9 Jan 2008 00:18:26 -0500
Message-Id: <11998559111835-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1199855910574-git-send-email-paul.gortmaker@windriver.com>
References: <1199855910574-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <93a0b006474cd6884392682c82b232fc2aea7794.1199854466.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the basic support for the Wind River SBC8548 board, implemented
as powerpc.  It closely follows the implementation of the MPC8548CDS.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/platforms/85xx/Kconfig   |   10 ++-
 arch/powerpc/platforms/85xx/Makefile  |    1 +
 arch/powerpc/platforms/85xx/sbc8548.c |  182 +++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 33d3bea..8407f43 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -39,6 +39,12 @@ config MPC85xx_DS
 	help
 	  This option enables support for the MPC85xx DS (MPC8544 DS) board
 
+config SBC8548
+	bool "Wind River SBC8548"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the Wind River SBC8548 board
+
 config SBC8560
 	bool "Wind River SBC8560"
 	select DEFAULT_UIMAGE
@@ -52,7 +58,7 @@ config MPC8540
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
-	default y if MPC8540_ADS || MPC85xx_CDS
+	default y if MPC8540_ADS || MPC85xx_CDS || SBC8548
 
 config MPC8560
 	bool
@@ -66,4 +72,4 @@ config MPC85xx
 	select FSL_PCI if PCI
 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
 	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS \
-		|| MPC85xx_MDS || MPC85xx_DS || SBC8560
+		|| MPC85xx_MDS || MPC85xx_DS || SBC8560 || SBC8548
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index c3f4d01..3a47b7a 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
 obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
+obj-$(CONFIG_SBC8548) += sbc8548.o
 obj-$(CONFIG_SBC8560) += sbc8560.o
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
new file mode 100644
index 0000000..f3ab271
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -0,0 +1,182 @@
+/*
+ * Wind River SBC8548 setup and early boot code.
+ *
+ * Copyright 2007 Wind River Systems Inc.
+ *
+ * By Paul Gortmaker (see MAINTAINERS for contact information)
+ *
+ * Based largely on the MPC8548CDS support - Copyright 2005 Freescale Inc.
+ *
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/initrd.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/fsl_devices.h>
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/atomic.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ipic.h>
+#include <asm/pci-bridge.h>
+#include <asm/irq.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+#ifdef CONFIG_PCI
+static int sbc8548_exclude_device(struct pci_controller *hose,
+				  u_char bus, u_char devfn)
+{
+	if (bus == 0 && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+#endif
+
+static void __init sbc8548_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np = NULL;
+
+	np = of_find_node_by_type(np, "open-pic");
+
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Failed to map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
+			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			0, 256, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+
+	/* Return the mpic node */
+	of_node_put(np);
+
+	mpic_init(mpic);
+}
+
+/*
+ * Setup the architecture
+ */
+static void __init sbc8548_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("sbc8548_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
+		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
+			struct resource rsrc;
+			of_address_to_resource(np, 0, &rsrc);
+			if ((rsrc.start & 0xfffff) == 0x8000)
+				fsl_add_bridge(np, 1);
+			else
+				fsl_add_bridge(np, 0);
+		}
+	}
+
+	ppc_md.pci_exclude_device = sbc8548_exclude_device;
+#endif
+}
+
+static void sbc8548_show_cpuinfo(struct seq_file *m)
+{
+	uint pvid, svid, phid1;
+	uint memsize = total_memory;
+
+	pvid = mfspr(SPRN_PVR);
+	svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: Wind River\n");
+	seq_printf(m, "Machine\t\t: SBC8548\n");
+	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+
+	/* Display cpu Pll setting */
+	phid1 = mfspr(SPRN_HID1);
+	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+
+	/* Display the amount of memory */
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+}
+
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .type = "soc", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	if (!machine_is(sbc8548))
+		return 0;
+
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	return 0;
+}
+device_initcall(declare_of_platform_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init sbc8548_probe(void)
+{
+        unsigned long root = of_get_flat_dt_root();
+
+        return of_flat_dt_is_compatible(root, "SBC8548");
+}
+
+define_machine(sbc8548) {
+	.name		= "SBC8548",
+	.probe		= sbc8548_probe,
+	.setup_arch	= sbc8548_setup_arch,
+	.init_IRQ	= sbc8548_pic_init,
+	.show_cpuinfo	= sbc8548_show_cpuinfo,
+	.get_irq	= mpic_get_irq,
+	.restart	= fsl_rstcr_restart,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.calibrate_decr = generic_calibrate_decr,
+	.progress	= udbg_progress,
+};
-- 
1.5.0.rc1.gf4b6c

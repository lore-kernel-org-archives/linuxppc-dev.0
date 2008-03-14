Return-Path: <asmirnov@ru.mvista.com>
Received: from spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1C5ABDE3B7
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Mar 2008 01:21:23 +1100 (EST)
Received: from spb.rtsoft.ru (spb.rtsoft.ru [127.0.0.1])
	by spb.rtsoft.ru (8.13.5/8.13.5) with ESMTP id m2EEUChg008408
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 17:30:12 +0300
Received: (from alex@localhost)
	by spb.rtsoft.ru (8.13.5/8.13.5/Submit) id m2EEUCiE008407
	for linuxppc-dev@ozlabs.org; Fri, 14 Mar 2008 17:30:12 +0300
Date: Fri, 14 Mar 2008 17:30:12 +0300
From: Alexandr Smirnov <asmirnov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] Emerson ATCA-C125 base support
Message-ID: <20080314143012.GE8228@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080314142220.GA8228@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The ATCA-C125 is a single-slot Advanced Telecom Computing Architecture
(AdvancedTCA®, ATCA™) carrier with up to four Advanced Mezzanine Cards
(AdvancedMC) expansion modules. This expansion capability enables a wide
variety of control and packet processing applications such as WAN access,
traffic processing, signaling gateways, media gateways, and many others.

The board has altera maxii CPLD, that is used to obtain and manage board
configuration.

 b/arch/powerpc/platforms/85xx/Kconfig  |    6 +
 b/arch/powerpc/platforms/85xx/Makefile |    1
 b/arch/powerpc/platforms/85xx/c125.c   |  191 +++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)

Signed-off-by: Alexandr Smirnov <asmirnov@ru.mvista.com>

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 7e76ddb..1f159a8 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -103,6 +103,12 @@ config SBC8560
 	help
 	  This option enables support for the Wind River SBC8560 board
 
+config C125
+	bool "Emerson ATCA-C125 board"
+	select DEFAULT_UIMAGE
+	help
+	  This option enable support for the Emerson ATCA-C125 board
+
 endif # MPC85xx
 
 config TQM85xx
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index cb7af4e..26b3307 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8560)     += sbc8560.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
+obj-$(CONFIG_C125)	  += c125.o
diff --git a/arch/powerpc/platforms/85xx/c125.c b/arch/powerpc/platforms/85xx/c125.c
new file mode 100644
index 0000000..919b70a
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/c125.c
@@ -0,0 +1,191 @@
+/*
+ * Board setup routines for the Emerson ATCA-C125
+ *
+ * Author: Andrei Dolnikov <adolnikov@ru.mvista.com>
+ *         Alexandr Smirnov <asmirnov@ru.mvista.com>
+ *
+ * Based on mpc85xx_cds.c maintained by Kumar Gala
+ *
+ * 2008 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/seq_file.h>
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/io.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+
+#include <mm/mmu_decl.h>
+
+/* CPLD registers definitions */
+#define C125_CPLD_HVR		0x04		/* Hardware Version Register */
+#define C125_CPLD_RCR		0x24		/* Reset Command Register */
+#define C125_CPLD_RCR_CPUHR	(1 << 7)	/* CPU Hard Reset */
+
+static void __iomem *cpld_base = NULL;
+
+static void machine_restart(char *cmd)
+{
+	local_irq_disable();
+
+	if (cpld_base)
+		out_8(cpld_base + C125_CPLD_RCR, C125_CPLD_RCR_CPUHR);
+	else
+		printk(KERN_ERR "Can't find CPLD base, hang forever\n");
+
+	for (;;);
+}
+
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .type = "soc", },
+	{ .name = "localbus", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(c125, declare_of_platform_devices);
+
+/*
+ * ATCA-C125 has hardware issues when mpic.c code is allowed to reset
+ * the mpic.  The issue is related to interrupt polarity and pass
+ * through mode.  The mpic.c code resets the mpic and then proceeds
+ * to set up internal regs with the mode set to 'pass through' and
+ * then later changes the mode.  This causes unexpected interrupts
+ * that hang the kernel.  So instead the MPIC reset is done
+ * here, immediately followed with changing the mode to 'mixed' and the
+ * mpic code is told to not reset (MPIC_WANTS_RESET is not set).
+ */
+
+static void __init c125_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np;
+	void __iomem *mpic_regs;
+
+	np = of_find_node_by_type(NULL, "open-pic");
+
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	/* Reset MPIC and put it in a mixed mode */
+	mpic_regs = of_iomap(np, 0);
+
+	out_be32(mpic_regs + MPIC_GREG_BASE + MPIC_GREG_GLOBAL_CONF_0,
+		in_be32(mpic_regs + MPIC_GREG_BASE + MPIC_GREG_GLOBAL_CONF_0)
+		| MPIC_GREG_GCONF_RESET);
+
+	while (in_be32(mpic_regs + MPIC_GREG_BASE + MPIC_GREG_GLOBAL_CONF_0)
+		& MPIC_GREG_GCONF_RESET)
+		mb();
+
+	out_be32(mpic_regs + MPIC_GREG_BASE + MPIC_GREG_GLOBAL_CONF_0,
+		in_be32(mpic_regs + MPIC_GREG_BASE + MPIC_GREG_GLOBAL_CONF_0)
+		| MPIC_GREG_GCONF_8259_PTHROU_DIS);
+
+	iounmap(mpic_regs);
+	/* End MPIC reset */
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Failed to map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
+			MPIC_PRIMARY | MPIC_BIG_ENDIAN,
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
+static void __init c125_setup_arch(void)
+{
+	struct device_node *cpld;
+
+	/*
+	 * ioremap cpld registers in case they are later
+	 * needed by machine_restart().
+	 */
+	cpld = of_find_compatible_node(NULL, NULL, "emerson,ATCA-C125-cpld");
+	if (cpld)
+		cpld_base = of_iomap(cpld, 0);
+	else
+		printk(KERN_ERR "Can't find CPLD in device tree\n");
+
+	if (ppc_md.progress)
+		ppc_md.progress("c125_setup_arch()", 0);
+}
+
+static void c125_show_cpuinfo(struct seq_file *m)
+{
+	uint pvid, svid, phid1;
+	uint memsize = total_memory;
+
+	pvid = mfspr(SPRN_PVR);
+	svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: Emerson Network Power\n");
+
+	if (cpld_base)
+		seq_printf(m, "Hardware rev\t: %d\n",
+					in_8(cpld_base + C125_CPLD_HVR));
+	else
+		seq_printf(m, "Unknown Hardware rev\n");
+
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
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init c125_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "emerson,ATCA-C125");
+}
+
+define_machine(c125) {
+	.name		= "ATCA-C125",
+	.probe		= c125_probe,
+	.setup_arch	= c125_setup_arch,
+	.init_IRQ	= c125_pic_init,
+	.show_cpuinfo	= c125_show_cpuinfo,
+	.get_irq	= mpic_get_irq,
+	.restart	= machine_restart,
+	.calibrate_decr = generic_calibrate_decr,
+	.progress	= udbg_progress,
+};

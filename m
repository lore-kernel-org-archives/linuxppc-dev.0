Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D236EDE6C0
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 05:42:01 +1000 (EST)
Subject: [PATCH 3/5 v2] powerpc: C2K board driver
From: Remi Machet <rmachet@slac.stanford.edu>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 16 May 2008 12:31:04 -0700
Message-Id: <1210966264.14883.5.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Support for the C2K cPCI Single Board Computer from GEFanuc
(PowerPC MPC7448 with a Marvell MV64460 chipset)
All features of the board are not supported yet, but the board
boots, flash works, all Ethernet ports are working and PCI 
devices are all found (USB and SATA on PCI1 do not work yet).

Part 3 of 5: driver for the board. At this time it is very generic 
and similar to its original, the driver for the prpmc2800.

Signed-off-by: Remi Machet <rmachet@slac.stanford.edu>
---
Changes:
v1: original patch
v2: re-organized the include files in c2k.c, putting all the linux/ 
at the top. Also added linux/of.h (thanks to Stephen Rothwell).

Note: checkpatch.pl reported one warning, but asm/time.h is needed
(defines generic_calibrate_decr):
WARNING: Use #include <linux/time.h> instead of <asm/time.h>
#71: FILE: arch/powerpc/platforms/embedded6xx/c2k.c:28:
+#include <asm/time.h>

 Makefile |    1
 c2k.c    |  158 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
index 06524d3..0773c08 100644
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_LINKSTATION)	+= linkstation.o ls_uart.o
 obj-$(CONFIG_STORCENTER)	+= storcenter.o
 obj-$(CONFIG_PPC_HOLLY)		+= holly.o
 obj-$(CONFIG_PPC_PRPMC2800)	+= prpmc2800.o
+obj-$(CONFIG_PPC_C2K)		+= c2k.o
diff --git a/arch/powerpc/platforms/embedded6xx/c2k.c b/arch/powerpc/platforms/embedded6xx/c2k.c
new file mode 100644
index 0000000..d0b25b8
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/c2k.c
@@ -0,0 +1,158 @@
+/*
+ * Board setup routines for the GEFanuc C2K board
+ *
+ * Author: Remi Machet <rmachet@slac.stanford.edu>
+ *
+ * Originated from prpmc2800.c
+ *
+ * 2008 (c) Stanford University
+ * 2007 (c) MontaVista, Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/seq_file.h>
+#include <linux/time.h>
+#include <linux/of.h>
+#include <linux/kexec.h>
+
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/system.h>
+#include <asm/time.h>
+
+#include <mm/mmu_decl.h>
+
+#include <sysdev/mv64x60.h>
+
+#define MV64x60_MPP_CNTL_0	0x0000
+#define MV64x60_MPP_CNTL_2	0x0008
+
+#define MV64x60_GPP_IO_CNTL	0x0000
+#define MV64x60_GPP_LEVEL_CNTL	0x0010
+#define MV64x60_GPP_VALUE_SET	0x0018
+
+static void __iomem *mv64x60_mpp_reg_base;
+static void __iomem *mv64x60_gpp_reg_base;
+
+static void __init c2k_setup_arch(void)
+{
+	struct device_node *np;
+	phys_addr_t paddr;
+	const unsigned int *reg;
+
+	/*
+	 * ioremap mpp and gpp registers in case they are later
+	 * needed by c2k_reset_board().
+	 */
+	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360-mpp");
+	reg = of_get_property(np, "reg", NULL);
+	paddr = of_translate_address(np, reg);
+	of_node_put(np);
+	mv64x60_mpp_reg_base = ioremap(paddr, reg[1]);
+
+	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360-gpp");
+	reg = of_get_property(np, "reg", NULL);
+	paddr = of_translate_address(np, reg);
+	of_node_put(np);
+	mv64x60_gpp_reg_base = ioremap(paddr, reg[1]);
+
+#ifdef CONFIG_PCI
+	mv64x60_pci_init();
+#endif
+}
+
+static void c2k_reset_board(void)
+{
+	u32 temp;
+
+	local_irq_disable();
+
+	temp = in_le32(mv64x60_mpp_reg_base + MV64x60_MPP_CNTL_0);
+	temp &= 0xFFFF0FFF;
+	out_le32(mv64x60_mpp_reg_base + MV64x60_MPP_CNTL_0, temp);
+
+	temp = in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_LEVEL_CNTL);
+	temp |= 0x00000004;
+	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_LEVEL_CNTL, temp);
+
+	temp = in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_IO_CNTL);
+	temp |= 0x00000004;
+	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_IO_CNTL, temp);
+
+	temp = in_le32(mv64x60_mpp_reg_base + MV64x60_MPP_CNTL_2);
+	temp &= 0xFFFF0FFF;
+	out_le32(mv64x60_mpp_reg_base + MV64x60_MPP_CNTL_2, temp);
+
+	temp = in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_LEVEL_CNTL);
+	temp |= 0x00080000;
+	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_LEVEL_CNTL, temp);
+
+	temp = in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_IO_CNTL);
+	temp |= 0x00080000;
+	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_IO_CNTL, temp);
+
+	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_VALUE_SET, 0x00080004);
+}
+
+static void c2k_restart(char *cmd)
+{
+	c2k_reset_board();
+	msleep(100);
+	panic("restart failed\n");
+}
+
+#ifdef CONFIG_NOT_COHERENT_CACHE
+#define COHERENCY_SETTING "off"
+#else
+#define COHERENCY_SETTING "on"
+#endif
+
+void c2k_show_cpuinfo(struct seq_file *m)
+{
+	uint memsize = total_memory;
+
+	seq_printf(m, "Vendor\t\t: GEFanuc\n");
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+	seq_printf(m, "coherency\t: %s\n", COHERENCY_SETTING);
+}
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init c2k_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "GEFanuc,C2K"))
+		return 0;
+
+	printk(KERN_INFO "Detected a GEFanuc C2K board\n");
+
+	_set_L2CR(0);
+	_set_L2CR(L2CR_L2E | L2CR_L2PE | L2CR_L2I);
+	return 1;
+}
+
+define_machine(c2k) {
+	.name			= "C2K",
+	.probe			= c2k_probe,
+	.setup_arch		= c2k_setup_arch,
+	.init_early		= mv64x60_init_early,
+	.show_cpuinfo		= c2k_show_cpuinfo,
+	.init_IRQ		= mv64x60_init_irq,
+	.get_irq		= mv64x60_get_irq,
+	.restart		= c2k_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+#ifdef CONFIG_KEXEC
+	.machine_kexec		= default_machine_kexec,
+	.machine_kexec_prepare	= default_machine_kexec_prepare,
+	.machine_crash_shutdown	= default_machine_crash_shutdown,
+#endif
+};

Return-Path: <asmirnov@ru.mvista.com>
Received: from spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE248DDF2A
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 03:24:44 +1100 (EST)
Received: from spb.rtsoft.ru (spb.rtsoft.ru [127.0.0.1])
	by spb.rtsoft.ru (8.13.5/8.13.5) with ESMTP id m24GX5iA020249
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 19:33:05 +0300
Received: (from alex@localhost)
	by spb.rtsoft.ru (8.13.5/8.13.5/Submit) id m24GX5GF020248
	for linuxppc-dev@ozlabs.org; Tue, 4 Mar 2008 19:33:05 +0300
Date: Tue, 4 Mar 2008 19:33:05 +0300
From: Alexandr Smirnov <asmirnov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] Emerson KSI8560 base support
Message-ID: <20080304163305.GB19634@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080304162322.GA19634@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The KSI8560 is a single compact, mid-, or full-size Advanced Mezzanine Card
(AdvancedMC™) based on the Freescale™ Semiconductor MPC8560 PowerQUICC III™
microprocessor. This product will serve in data and signaling applications such
as signaling gateways (SGW) and softswitch signaling interface cards.

The board has altera maxii CPLD, that is used to obtain and manage board
configuration. Also there are two SCC UART serial consoles and FCC ethernet,
that is routed to the front panel, while other ethernet controlers (TSEC's) are
routed to the backplane.

Signed-off-by: Alexandr Smirnov <asmirnov@ru.mvista.com>

 arch/powerpc/platforms/85xx/Kconfig   |    7
 arch/powerpc/platforms/85xx/Makefile  |    1
 arch/powerpc/platforms/85xx/ksi8560.c |  257 ++++++++++++++++++++++++++++++++++
 3 files changed, 265 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 7e76ddb..28bc6e5 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -46,6 +46,13 @@ config MPC85xx_DS
 	help
 	  This option enables support for the MPC85xx DS (MPC8544 DS) board
 
+config KSI8560
+        bool "Emerson KSI8560"
+        select PPC_CPM_NEW_BINDING
+        select DEFAULT_UIMAGE
+        help
+          This option enables support for the Emerson KSI8560 board
+
 config STX_GP3
 	bool "Silicon Turnkey Express GP3"
 	help
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index cb7af4e..6cea185 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8560)     += sbc8560.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
+obj-$(CONFIG_KSI8560)	  += ksi8560.o
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
new file mode 100644
index 0000000..b3b8194
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -0,0 +1,257 @@
+/*
+ * Board setup routines for the Emerson KSI8560
+ *
+ * Author: Alexandr Smirnov <asmirnov@ru.mvista.com>
+ *
+ * Based on mpc85xx_ads.c maintained by Kumar Gala
+ *
+ * 2008 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpic.h>
+#include <mm/mmu_decl.h>
+#include <asm/udbg.h>
+#include <asm/prom.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+#include <asm/cpm2.h>
+#include <sysdev/cpm2_pic.h>
+
+
+#define KSI8560_CPLD_HVR		0x04 /* Hardware Version Register */
+#define KSI8560_CPLD_PVR		0x08 /* PLD Version Register */
+#define KSI8560_CPLD_RCR1		0x30 /* Reset Command Register 1 */
+
+#define KSI8560_CPLD_RCR1_CPUHR		0x80 /* CPU Hard Reset */
+
+static void __iomem *cpld_base = NULL;
+
+static void machine_restart(char *cmd)
+{
+	if (cpld_base)
+		out_8(cpld_base + KSI8560_CPLD_RCR1, KSI8560_CPLD_RCR1_CPUHR);
+	else
+		printk(KERN_ERR "Can't find CPLD base, hang forever\n");
+
+	for (;;);
+}
+
+static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	int cascade_irq;
+
+	while ((cascade_irq = cpm2_get_irq()) >= 0)
+		generic_handle_irq(cascade_irq);
+
+	desc->chip->eoi(irq);
+}
+
+static void __init ksi8560_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np;
+#ifdef CONFIG_CPM2
+	int irq;
+#endif
+
+	np = of_find_node_by_type(NULL, "open-pic");
+
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Could not map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
+			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			0, 256, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	mpic_init(mpic);
+
+#ifdef CONFIG_CPM2
+	/* Setup CPM2 PIC */
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
+	if (np == NULL) {
+		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
+		return;
+	}
+	irq = irq_of_parse_and_map(np, 0);
+
+	cpm2_pic_init(np);
+	of_node_put(np);
+	set_irq_chained_handler(irq, cpm2_cascade);
+
+	setup_irq(0, NULL);
+#endif
+}
+
+#ifdef CONFIG_CPM2
+/*
+ * Setup I/O ports
+ */
+struct cpm_pin {
+	int port, pin, flags;
+};
+
+static struct cpm_pin __initdata ksi8560_pins[] = {
+	/* SCC1 */
+	{3, 29, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* SCC2 */
+	{3, 26, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 27, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* FCC1 */
+	{0, 14, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 15, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 18, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 19, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 20, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 26, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 27, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 28, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{0, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{0, 30, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 31, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{2, 23, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* CLK9 */
+	{2, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* CLK10 */
+
+};
+
+static void __init init_ioports(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ksi8560_pins); i++) {
+		struct cpm_pin *pin = &ksi8560_pins[i];
+		cpm2_set_pin(pin->port, pin->pin, pin->flags);
+	}
+
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK9, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_TX);
+}
+#endif
+
+/*
+ * Setup the architecture
+ */
+static void __init ksi8560_setup_arch(void)
+{
+	struct device_node *cpld;
+
+	cpld = of_find_compatible_node(NULL, NULL, "altera,maxii");
+	if (cpld)
+		cpld_base = of_iomap(cpld, 0);
+	else
+		printk(KERN_ERR "Can't find CPLD in device tree\n");
+
+	if (ppc_md.progress)
+		ppc_md.progress("ksi8560_setup_arch()", 0);
+
+#ifdef CONFIG_CPM2
+	cpm2_reset();
+	init_ioports();
+#endif
+}
+
+static void ksi8560_show_cpuinfo(struct seq_file *m)
+{
+	uint pvid, svid, phid1;
+	uint memsize = total_memory;
+
+	pvid = mfspr(SPRN_PVR);
+	svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: Emerson Network Power\n");
+	seq_printf(m, "Board\t\t: KSI8560\n");
+
+	if (cpld_base) {
+		seq_printf(m, "Hardware rev\t: %d\n",
+					in_8(cpld_base + KSI8560_CPLD_HVR));
+		seq_printf(m, "CPLD rev\t: %d\n",
+					in_8(cpld_base + KSI8560_CPLD_PVR));
+	} else
+		seq_printf(m, "Unknown Hardware and CPLD revs\n");
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
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .type = "soc", },
+	{ .name = "cpm", },
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
+machine_device_initcall(ksi8560, declare_of_platform_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init ksi8560_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "emerson,KSI8560");
+}
+
+define_machine(ksi8560) {
+	.name			= "KSI8560",
+	.probe			= ksi8560_probe,
+	.setup_arch		= ksi8560_setup_arch,
+	.init_IRQ		= ksi8560_pic_init,
+	.show_cpuinfo		= ksi8560_show_cpuinfo,
+	.get_irq		= mpic_get_irq,
+	.restart		= machine_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+};

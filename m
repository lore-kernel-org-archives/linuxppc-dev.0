Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 783FFDDE02
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 08:05:20 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 23 May 2007 15:05:18 -0700
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Add Marvell mv64x60 udbg putc/getc functions
Message-ID: <20070523220518.GA2312@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, when the Marvell mpsc driver is used as console,
any console output that occurs before the Marvell mpsc driver
is initialized is discarded by the udbg console.

This patch resolves that issue by providing udbg_putc() and
udbg_getc() functions for the Marvell mv64x60 chips. These functions
are enabled if an mv64x60 port is to be used as the console as
determined from the device tree.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Acked-by: Mark A. Greer <mgreer@mvista.com>
---

Paul, this patch is unchanged from the one I posted 10 days ago.
At that time, I saw no discussion, other than Mark's ACK.  I'd 
argue that this is a bugfix, and hope that it could go into 2.6.22.

Thanks.

-Dale

 arch/powerpc/platforms/embedded6xx/prpmc2800.c |    1 
 arch/powerpc/sysdev/Makefile                   |    3 
 arch/powerpc/sysdev/mv64x60.h                  |    1 
 arch/powerpc/sysdev/mv64x60_udbg.c             |  152 +++++++++++++++
 4 files changed, 156 insertions(+), 1 deletion(-)

Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60_udbg.c
===================================================================
--- /dev/null
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60_udbg.c
@@ -0,0 +1,152 @@
+/*
+ * udbg serial input/output routines for the Marvell MV64x60 (Discovery).
+ *
+ * Author: Dale Farnsworth <dale@farnsworth.org>
+ *
+ * 2007 (c) MontaVista Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+
+#include <sysdev/mv64x60.h>
+
+#define MPSC_0_CR1_OFFSET	0x000c
+
+#define MPSC_0_CR2_OFFSET	0x0010
+#define MPSC_CHR_2_TCS		(1 << 9)
+
+#define MPSC_0_CHR_10_OFFSET	0x0030
+
+#define MPSC_INTR_CAUSE_OFF_0	0x0004
+#define MPSC_INTR_CAUSE_OFF_1	0x000c
+#define MPSC_INTR_CAUSE_RCC	(1<<6)
+
+static void __iomem *mpsc_base;
+static void __iomem *mpsc_intr_cause;
+
+static void mv64x60_udbg_putc(char c)
+{
+	if (c == '\n')
+		mv64x60_udbg_putc('\r');
+
+	while(in_le32(mpsc_base + MPSC_0_CR2_OFFSET) & MPSC_CHR_2_TCS)
+		;
+	out_le32(mpsc_base + MPSC_0_CR1_OFFSET, c);
+	out_le32(mpsc_base + MPSC_0_CR2_OFFSET, MPSC_CHR_2_TCS);
+}
+
+static int mv64x60_udbg_testc(void)
+{
+	return (in_le32(mpsc_intr_cause) & MPSC_INTR_CAUSE_RCC) != 0;
+}
+
+static int mv64x60_udbg_getc(void)
+{
+	int cause = 0;
+	int c;
+
+	while (!mv64x60_udbg_testc())
+		;
+
+	c = in_8(mpsc_base + MPSC_0_CHR_10_OFFSET + 2);
+	out_8(mpsc_base + MPSC_0_CHR_10_OFFSET + 2, c);
+	out_le32(mpsc_intr_cause, cause & ~MPSC_INTR_CAUSE_RCC);
+	return c;
+}
+
+static int mv64x60_udbg_getc_poll(void)
+{
+	if (!mv64x60_udbg_testc())
+		return -1;
+
+	return mv64x60_udbg_getc();
+}
+
+static void mv64x60_udbg_init(void)
+{
+	struct device_node *np, *mpscintr, *stdout = NULL;
+	const char *path;
+	const phandle *ph;
+	struct resource r[2];
+	const int *block_index;
+	int intr_cause_offset;
+	int err;
+
+	path = of_get_property(of_chosen, "linux,stdout-path", NULL);
+	if (!path)
+		return;
+
+	stdout = of_find_node_by_path(path);
+	if (!stdout)
+		return;
+
+	for (np = NULL;
+	     (np = of_find_compatible_node(np, "serial", "marvell,mpsc")); )
+		if (np == stdout)
+			break;
+
+	of_node_put(stdout);
+	if (!np)
+		return;
+
+	block_index = of_get_property(np, "block-index", NULL);
+	if (!block_index)
+		goto error;
+
+	switch (*block_index) {
+	case 0:
+		intr_cause_offset = MPSC_INTR_CAUSE_OFF_0;
+		break;
+	case 1:
+		intr_cause_offset = MPSC_INTR_CAUSE_OFF_1;
+		break;
+	default:
+		goto error;
+	}
+
+	err = of_address_to_resource(np, 0, &r[0]);
+	if (err)
+		goto error;
+
+	ph = of_get_property(np, "mpscintr", NULL);
+	mpscintr = of_find_node_by_phandle(*ph);
+	if (!mpscintr)
+		goto error;
+
+	err = of_address_to_resource(mpscintr, 0, &r[1]);
+	of_node_put(mpscintr);
+	if (err)
+		goto error;
+
+	of_node_put(np);
+
+	mpsc_base = ioremap(r[0].start, r[0].end - r[0].start + 1);
+	if (!mpsc_base)
+		return;
+
+	mpsc_intr_cause = ioremap(r[1].start, r[1].end - r[1].start + 1);
+	if (!mpsc_intr_cause) {
+		iounmap(mpsc_base);
+		return;
+	}
+	mpsc_intr_cause += intr_cause_offset;
+
+	udbg_putc = mv64x60_udbg_putc;
+	udbg_getc = mv64x60_udbg_getc;
+	udbg_getc_poll = mv64x60_udbg_getc_poll;
+
+	return;
+
+error:
+	of_node_put(np);
+}
+
+void mv64x60_init_early(void)
+{
+	mv64x60_udbg_init();
+}
Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/Makefile
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/Makefile
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/Makefile
@@ -17,7 +17,8 @@ obj-$(CONFIG_FSL_PCIE)		+= fsl_pcie.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o
-obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o
+obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o \
+				   mv64x60_udbg.o
 
 # contains only the suspend handler for time
 obj-$(CONFIG_PM)		+= timer.o
Index: linux-2.6-powerpc-df/arch/powerpc/platforms/embedded6xx/prpmc2800.c
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/platforms/embedded6xx/prpmc2800.c
+++ linux-2.6-powerpc-df/arch/powerpc/platforms/embedded6xx/prpmc2800.c
@@ -158,6 +158,7 @@ define_machine(prpmc2800){
 	.name			= prpmc2800_platform_name,
 	.probe			= prpmc2800_probe,
 	.setup_arch		= prpmc2800_setup_arch,
+	.init_early		= mv64x60_init_early,
 	.show_cpuinfo		= prpmc2800_show_cpuinfo,
 	.init_IRQ		= mv64x60_init_irq,
 	.get_irq		= mv64x60_get_irq,
Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.h
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/mv64x60.h
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.h
@@ -7,5 +7,6 @@ extern void __init mv64x60_init_irq(void
 extern unsigned int mv64x60_get_irq(void);
 
 extern void __init mv64x60_pci_init(void);
+extern void __init mv64x60_init_early(void);
 
 #endif /* __MV64X60_H__ */

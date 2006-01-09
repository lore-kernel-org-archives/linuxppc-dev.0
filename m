Return-Path: <grant.likely@secretlab.ca>
Received: from localhost.localdomain (S0106001346b91f0f.cg.shawcable.net
	[68.147.210.21]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4B53689EC
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jan 2006 19:33:09 +1100 (EST)
In-Reply-To: <11367955793438-git-send-email-grant.likely@secretlab.ca>
Date: Mon, 9 Jan 2006 01:33:01 -0700
Message-Id: <11367955811523-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: glikely@gmail.com, mporter@kernel.crashing.org,
	linuxppc-embedded@ozlabs.org, gnathita@gmail.com, dhlii@dlasys.net
From: grant.likely@secretlab.ca
Subject: [PATCH 07/10] Add support for Xilinx ML403 reference design
Reply-To: grant.likely@secretlab.ca
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>

---

 arch/ppc/boot/simple/embed_config.c              |   43 +++++
 arch/ppc/platforms/4xx/Kconfig                   |    8 +
 arch/ppc/platforms/4xx/Makefile                  |    2 
 arch/ppc/platforms/4xx/xilinx_ml403.c            |  177 ++++++++++++++++++++++
 arch/ppc/platforms/4xx/xilinx_ml403.h            |   49 ++++++
 arch/ppc/platforms/4xx/xparameters/xparameters.h |   13 ++
 include/asm-ppc/ibm4xx.h                         |    4 
 7 files changed, 293 insertions(+), 3 deletions(-)
 create mode 100644 arch/ppc/platforms/4xx/xilinx_ml403.c
 create mode 100644 arch/ppc/platforms/4xx/xilinx_ml403.h

d8ec1973726dba317a7212ddbd0299fe459270e0
diff --git a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
index df24202..32c7132 100644
--- a/arch/ppc/boot/simple/embed_config.c
+++ b/arch/ppc/boot/simple/embed_config.c
@@ -745,7 +745,7 @@ embed_config(bd_t **bdp)
 }
 #endif /* WILLOW */
 
-#ifdef CONFIG_XILINX_ML300
+#if defined(CONFIG_XILINX_ML300)
 void
 embed_config(bd_t ** bdp)
 {
@@ -784,6 +784,47 @@ embed_config(bd_t ** bdp)
 }
 #endif /* CONFIG_XILINX_ML300 */
 
+#if defined(CONFIG_XILINX_ML403)
+void
+embed_config(bd_t ** bdp)
+{
+	static const unsigned long line_size = 32;
+	static const unsigned long congruence_classes = 256;
+	unsigned long addr;
+	unsigned long dccr;
+	bd_t *bd;
+
+	/*
+	 * Invalidate the data cache if the data cache is turned off.
+	 * - The 405 core does not invalidate the data cache on power-up
+	 *   or reset but does turn off the data cache. We cannot assume
+	 *   that the cache contents are valid.
+	 * - If the data cache is turned on this must have been done by
+	 *   a bootloader and we assume that the cache contents are
+	 *   valid.
+	 */
+	__asm__("mfdccr %0": "=r" (dccr));
+	if (dccr == 0) {
+		for (addr = 0;
+		     addr < (congruence_classes * line_size);
+		     addr += line_size) {
+			__asm__("dccci 0,%0": :"b"(addr));
+		}
+	}
+
+	bd = &bdinfo;
+	*bdp = bd;
+	bd->bi_memsize = 64 * 1024 * 1024; /* ML403 has 64 MB of RAM */
+            /* Note, memsize does NOT == XPAR_PLB_DDR_0_MEM0_HIGHADDR+1,
+             * memory controller window is larger than actual mem size */
+	bd->bi_intfreq = XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ;
+	bd->bi_busfreq = XPAR_XUARTNS550_CLOCK_HZ;
+	bd->bi_pci_busfreq = 0;
+	timebase_period_ns = 1000000000 / bd->bi_tbfreq;
+	/* see bi_tbfreq definition in arch/ppc/platforms/4xx/xilinx_ml300.h */
+}
+#endif /* CONFIG_XILINX_ML403 */
+
 #ifdef CONFIG_IBM_OPENBIOS
 /* This could possibly work for all treeboot roms.
 */
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index cbb90fc..48def71 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -57,6 +57,10 @@ config XILINX_ML300
 	help
 	  This option enables support for the Xilinx ML300 evaluation board.
 
+config XILINX_ML403
+	bool "Xilinx-ML403"
+	help
+	  This option enables support for the Xilinx ML403 evaluation board.
 endchoice
 
 choice
@@ -205,7 +209,7 @@ config 405GPR
 
 config XILINX_VIRTEX
 	bool
-	depends on XILINX_ML300
+	depends on XILINX_ML300 || XILINX_ML403
 	default y
 
 config STB03xxx
@@ -215,7 +219,7 @@ config STB03xxx
 
 config EMBEDDEDBOOT
 	bool
-	depends on EP405 || XILINX_ML300
+	depends on EP405 || XILINX_ML300 || XILINX_ML403
 	default y
 
 config IBM_OPENBIOS
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
index be4163c..a04a0d0 100644
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_REDWOOD_6)		+= redwood6.o
 obj-$(CONFIG_SYCAMORE)		+= sycamore.o
 obj-$(CONFIG_WALNUT)		+= walnut.o
 obj-$(CONFIG_XILINX_ML300)	+= xilinx_ml300.o
+obj-$(CONFIG_XILINX_ML403)	+= xilinx_ml403.o
 
 obj-$(CONFIG_405GP)		+= ibm405gp.o
 obj-$(CONFIG_REDWOOD_5)		+= ibmstb4.o
@@ -27,3 +28,4 @@ obj-$(CONFIG_440SPE)		+= ppc440spe.o
 obj-$(CONFIG_405EP)		+= ibm405ep.o
 obj-$(CONFIG_405GPR)		+= ibm405gpr.o
 obj-$(CONFIG_XILINX_VIRTEX)	+= virtex.o
+
diff --git a/arch/ppc/platforms/4xx/xilinx_ml403.c b/arch/ppc/platforms/4xx/xilinx_ml403.c
new file mode 100644
index 0000000..4c0c7e4
--- /dev/null
+++ b/arch/ppc/platforms/4xx/xilinx_ml403.c
@@ -0,0 +1,177 @@
+/*
+ * arch/ppc/platforms/4xx/xilinx_ml403.c
+ *
+ * Xilinx ML403 evaluation board initialization
+ *
+ * Author: Grant Likely <grant.likely@secretlab.ca>
+ *
+ * 2005 (c) Secret Lab Technologies Ltd.
+ * 2002-2004 (c) MontaVista Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+#include <linux/serialP.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ppc_sys.h>
+
+#include <syslib/gen550.h>
+#include <platforms/4xx/xparameters/xparameters.h>
+
+/*
+ * As an overview of how the following functions (platform_init,
+ * ml403_map_io, ml403_setup_arch and ml403_init_IRQ) fit into the
+ * kernel startup procedure, here's a call tree:
+ *
+ * start_here					arch/ppc/kernel/head_4xx.S
+ *  early_init					arch/ppc/kernel/setup.c
+ *  machine_init				arch/ppc/kernel/setup.c
+ *    platform_init				this file
+ *      ppc4xx_init				arch/ppc/syslib/ppc4xx_setup.c
+ *        parse_bootinfo
+ *          find_bootinfo
+ *        "setup some default ppc_md pointers"
+ *  MMU_init					arch/ppc/mm/init.c
+ *    *ppc_md.setup_io_mappings == ml403_map_io	this file
+ *      ppc4xx_map_io				arch/ppc/syslib/ppc4xx_setup.c
+ *  start_kernel				init/main.c
+ *    setup_arch				arch/ppc/kernel/setup.c
+ * #if defined(CONFIG_KGDB)
+ *      *ppc_md.kgdb_map_scc() == gen550_kgdb_map_scc
+ * #endif
+ *      *ppc_md.setup_arch == ml403_setup_arch	this file
+ *        ppc4xx_setup_arch			arch/ppc/syslib/ppc4xx_setup.c
+ *          ppc4xx_find_bridges			arch/ppc/syslib/ppc405_pci.c
+ *    init_IRQ					arch/ppc/kernel/irq.c
+ *      *ppc_md.init_IRQ == ml403_init_IRQ	this file
+ *        ppc4xx_init_IRQ			arch/ppc/syslib/ppc4xx_setup.c
+ *          ppc4xx_pic_init			arch/ppc/syslib/xilinx_pic.c
+ */
+
+/* Board specifications structures */
+struct ppc_sys_spec *cur_ppc_sys_spec;
+struct ppc_sys_spec ppc_sys_specs[] = {
+	{
+		/* Only one entry, always assume the same design */
+		.ppc_sys_name	= "Xilinx ML403 Reference Design",
+		.mask 		= 0x00000000,
+		.value 		= 0x00000000,
+		.num_devices	= 1,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			VIRTEX_UART,
+		},
+	},
+};
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+
+static volatile unsigned *powerdown_base =
+    (volatile unsigned *) XPAR_POWER_0_POWERDOWN_BASEADDR;
+
+static void
+xilinx_power_off(void)
+{
+	local_irq_disable();
+	out_be32(powerdown_base, XPAR_POWER_0_POWERDOWN_VALUE);
+	while (1) ;
+}
+#endif
+
+void __init
+ml403_map_io(void)
+{
+	ppc4xx_map_io();
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+	powerdown_base = ioremap((unsigned long) powerdown_base,
+				 XPAR_POWER_0_POWERDOWN_HIGHADDR -
+				 XPAR_POWER_0_POWERDOWN_BASEADDR + 1);
+#endif
+}
+
+/* Early serial support functions */
+static void __init
+ml403_early_serial_init(int num, struct plat_serial8250_port *pdata)
+{
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	struct uart_port serial_req;
+
+	memset(&serial_req, 0, sizeof(serial_req));
+	serial_req.mapbase	= pdata->mapbase;
+	serial_req.membase	= pdata->membase;
+	serial_req.irq		= pdata->irq;
+	serial_req.uartclk	= pdata->uartclk;
+	serial_req.regshift	= pdata->regshift;
+	serial_req.iotype	= pdata->iotype;
+	serial_req.flags	= pdata->flags;
+	gen550_init(num, &serial_req);
+#endif
+}
+
+void __init
+ml403_early_serial_map(void)
+{
+#ifdef CONFIG_SERIAL_8250
+	struct plat_serial8250_port *pdata;
+	int i = 0;
+
+	pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(VIRTEX_UART);
+	while(pdata && pdata->flags)
+	{
+		pdata->membase = ioremap(pdata->mapbase, 0x100);
+		ml403_early_serial_init(i, pdata);
+		pdata++;
+		i++;
+	}
+#endif /* CONFIG_SERIAL_8250 */
+}
+
+void __init
+ml403_setup_arch(void)
+{
+	ml403_early_serial_map();
+	ppc4xx_setup_arch();	/* calls ppc4xx_find_bridges() */
+
+	/* Identify the system */
+	printk(KERN_INFO "Xilinx ML403 Reference System (Virtex-4 FX)\n");
+}
+
+/* Called after board_setup_irq from ppc4xx_init_IRQ(). */
+void __init
+ml403_init_irq(void)
+{
+	ppc4xx_init_IRQ();
+}
+
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	      unsigned long r6, unsigned long r7)
+{
+	ppc4xx_init(r3, r4, r5, r6, r7);
+
+	identify_ppc_sys_by_id(mfspr(SPRN_PVR));
+
+	ppc_md.setup_arch = ml403_setup_arch;
+	ppc_md.setup_io_mappings = ml403_map_io;
+	ppc_md.init_IRQ = ml403_init_irq;
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+	ppc_md.power_off = xilinx_power_off;
+#endif
+
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = ml403_early_serial_map;
+#endif
+}
+
diff --git a/arch/ppc/platforms/4xx/xilinx_ml403.h b/arch/ppc/platforms/4xx/xilinx_ml403.h
new file mode 100644
index 0000000..4735969
--- /dev/null
+++ b/arch/ppc/platforms/4xx/xilinx_ml403.h
@@ -0,0 +1,49 @@
+/*
+ * arch/ppc/platforms/4xx/xilinx_ml403.h
+ *
+ * Include file that defines the Xilinx ML403 reference design
+ *
+ * Author: Grant Likely <grant.likely@secretlab.ca>
+ *
+ * 2005 (c) Secret Lab Technologies Ltd.
+ * 2002-2004 (c) MontaVista Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_XILINX_ML403_H__
+#define __ASM_XILINX_ML403_H__
+
+/* ML403 has a Xilinx Virtex-4 FPGA with a PPC405 hard core */
+#include <platforms/4xx/virtex.h>
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+typedef struct board_info {
+	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
+	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
+	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
+	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
+	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
+} bd_t;
+
+/* Some 4xx parts use a different timebase frequency from the internal clock.
+*/
+#define bi_tbfreq bi_intfreq
+
+#endif /* !__ASSEMBLY__ */
+
+/* We don't need anything mapped.  Size of zero will accomplish that. */
+#define PPC4xx_ONB_IO_PADDR	0u
+#define PPC4xx_ONB_IO_VADDR	0u
+#define PPC4xx_ONB_IO_SIZE	0u
+
+#define PPC4xx_MACHINE_NAME "Xilinx ML403 Reference Design"
+
+#endif /* __ASM_XILINX_ML403_H__ */
+#endif /* __KERNEL__ */
diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters.h b/arch/ppc/platforms/4xx/xparameters/xparameters.h
index 26ee822..22b0088 100644
--- a/arch/ppc/platforms/4xx/xparameters/xparameters.h
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters.h
@@ -32,6 +32,19 @@
   #define VIRTEX_INTC_BASEADDR           XPAR_DCR_INTC_0_BASEADDR
   #define VIRTEX_INTC_KIND_OF_INTR       XPAR_DCR_INTC_0_KIND_OF_INTR
 
+#elif defined(CONFIG_XILINX_ML403)
+  #include "xparameters_ml403.h"
+
+  /* Serial ports */
+  #define VIRTEX_UART_0_BASEADDR  (XPAR_OPB_UART16550_0_BASEADDR + 0x1000)
+  #define VIRTEX_UART_0_IRQ  XPAR_OPB_INTC_0_OPB_UART16550_0_IP2INTC_IRPT_INTR
+  #define VIRTEX_UART_0_CLK  XPAR_XUARTNS550_CLOCK_HZ
+
+  /* Values for setting up interrupt controller */
+  #define VIRTEX_XINTC_USE_DCR           XPAR_XINTC_USE_DCR
+  #define VIRTEX_INTC_BASEADDR           XPAR_OPB_INTC_0_BASEADDR
+  #define VIRTEX_INTC_KIND_OF_INTR       XPAR_OPB_INTC_0_KIND_OF_INTR
+
 #else
   /* Add other board xparameter includes here before the #else */
   #error No *_xparameters.h file included
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
index 6c28ae7..38f9971 100644
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -51,6 +51,10 @@
 #include <platforms/4xx/xilinx_ml300.h>
 #endif
 
+#if defined(CONFIG_XILINX_ML403)
+#include <platforms/4xx/xilinx_ml403.h>
+#endif
+
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_40x
-- 
1.0.6-g58e3

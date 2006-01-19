Return-Path: <grant@secretlab.ca>
Received: from localhost.secretlab.ca (S0106001346b91f0f.cg.shawcable.net
	[68.147.210.21]) by ozlabs.org (Postfix) with ESMTP id 49CE968A2D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jan 2006 19:13:38 +1100 (EST)
Date: Thu, 19 Jan 2006 01:13:37 -0700
From: "Grant C. Likely" <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org, akonovalov@ru.mvista.com,
	peter.ryser@xilinx.com
Subject: [PATCH 8/9] Add support for Xilinx ML403 reference design
Message-ID: <20060119081337.GA24929@weasley-twins.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Includes fix for Xilinx silicon errata 213

Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>

---

 arch/ppc/boot/simple/Makefile                    |    1 
 arch/ppc/boot/simple/embed_config.c              |    4 
 arch/ppc/boot/simple/head.S                      |    7 +
 arch/ppc/platforms/4xx/Kconfig                   |   13 +-
 arch/ppc/platforms/4xx/Makefile                  |    2 
 arch/ppc/platforms/4xx/xilinx_ml403.c            |  177 ++++++++++++++++++++++
 arch/ppc/platforms/4xx/xilinx_ml403.h            |   49 ++++++
 arch/ppc/platforms/4xx/xparameters/xparameters.h |    2 
 include/asm-ppc/ibm4xx.h                         |    4 
 9 files changed, 255 insertions(+), 4 deletions(-)
 create mode 100644 arch/ppc/platforms/4xx/xilinx_ml403.c
 create mode 100644 arch/ppc/platforms/4xx/xilinx_ml403.h

a6b31a88ce3340c144db41fe6e6805c80f108924
diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
index 9533f8d..28be01b 100644
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -192,6 +192,7 @@ boot-$(CONFIG_8xx)		+= embed_config.o
 boot-$(CONFIG_8260)		+= embed_config.o
 boot-$(CONFIG_EP405)		+= embed_config.o
 boot-$(CONFIG_XILINX_ML300)	+= embed_config.o
+boot-$(CONFIG_XILINX_ML403)	+= embed_config.o
 boot-$(CONFIG_BSEIP)		+= iic.o
 boot-$(CONFIG_MBX)		+= iic.o pci.o qspan_pci.o
 boot-$(CONFIG_MV64X60)		+= misc-mv64x60.o
diff --git a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
index df24202..3a51b10 100644
--- a/arch/ppc/boot/simple/embed_config.c
+++ b/arch/ppc/boot/simple/embed_config.c
@@ -745,7 +745,7 @@ embed_config(bd_t **bdp)
 }
 #endif /* WILLOW */
 
-#ifdef CONFIG_XILINX_ML300
+#if defined(CONFIG_XILINX_ML300) || defined(CONFIG_XILINX_ML403)
 void
 embed_config(bd_t ** bdp)
 {
@@ -782,7 +782,7 @@ embed_config(bd_t ** bdp)
 	timebase_period_ns = 1000000000 / bd->bi_tbfreq;
 	/* see bi_tbfreq definition in arch/ppc/platforms/4xx/xilinx_ml300.h */
 }
-#endif /* CONFIG_XILINX_ML300 */
+#endif /* CONFIG_XILINX_ML300 || CONFIG_XILINX_ML403 */
 
 #ifdef CONFIG_IBM_OPENBIOS
 /* This could possibly work for all treeboot roms.
diff --git a/arch/ppc/boot/simple/head.S b/arch/ppc/boot/simple/head.S
index 5e4adc2..119b9dc 100644
--- a/arch/ppc/boot/simple/head.S
+++ b/arch/ppc/boot/simple/head.S
@@ -65,6 +65,13 @@ start_:
 			 */
 #endif
 
+#if defined(CONFIG_XILINX_VIRTEX_4_FX)
+	/* PPC errata 213: only for Virtex-4 FX */
+	mfccr0  0
+	oris    0,0,0x50000000@h
+	mtccr0  0
+#endif
+
 	mflr	r3	/* Save our actual starting address. */
 
 	/* The following functions we call must not modify r3 or r4.....
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 057c7c2..174ddbc 100644
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
@@ -208,9 +212,14 @@ config XILINX_VIRTEX_II_PRO
 	depends on XILINX_ML300
 	default y
 
+config XILINX_VIRTEX_4_FX
+	bool
+	depends on XILINX_ML403
+	default y
+
 config XILINX_VIRTEX
 	bool
-	depends on XILINX_VIRTEX_II_PRO
+	depends on XILINX_VIRTEX_II_PRO || XILINX_VIRTEX_4_FX
 	default y
 
 config STB03xxx
@@ -220,7 +229,7 @@ config STB03xxx
 
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
index 7b73043..4cf21f2 100644
--- a/arch/ppc/platforms/4xx/xparameters/xparameters.h
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters.h
@@ -16,6 +16,8 @@
 
 #if defined(CONFIG_XILINX_ML300)
   #include "xparameters_ml300.h"
+#elif defined(CONFIG_XILINX_ML403)
+  #include "xparameters_ml403.h"
 #else
   /* Add other board xparameter includes here before the #else */
   #error No xparameters_*.h file included
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
1.1.GIT

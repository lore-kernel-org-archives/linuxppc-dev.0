Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 2CE0F2BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 03:13:42 +1000 (EST)
Message-ID: <4166CCF5.7040705@ru.mvista.com>
Date: Fri, 08 Oct 2004 21:23:01 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: akpm@osdl.org, linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="------------050007060703020803010405"
Cc: 
Subject: [PATCH][PPC32] Xilinx ML300 board support (very basic)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050007060703020803010405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adds minimal Xilinx ML300 board support (enough to boot with ramdisk).
The only peripheral devices supported are 16x50 compatible UARTs.

Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>

--------------050007060703020803010405
Content-Type: text/plain;
 name="linux-2.5-20041008-0.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.5-20041008-0.diff"

diff -Naur linux-2.5.base/arch/ppc/boot/simple/embed_config.c linux-2.5.current/arch/ppc/boot/simple/embed_config.c
--- linux-2.5.base/arch/ppc/boot/simple/embed_config.c	2004-10-08 17:02:32.000000000 +0400
+++ linux-2.5.current/arch/ppc/boot/simple/embed_config.c	2004-10-08 17:47:59.000000000 +0400
@@ -749,25 +749,25 @@
 	static const unsigned long line_size = 32;
 	static const unsigned long congruence_classes = 256;
 	unsigned long addr;
-	u_char *cp;
-	int i;
+	unsigned long dccr;
 	bd_t *bd;
 
 	/*
-	 * At one point, we were getting machine checks.  Linux was not
-	 * invalidating the data cache before it was enabled.  The
-	 * following code was added to do that.  Soon after we had done
-	 * that, we found the real reasons for the machine checks.  I've
-	 * run the kernel a few times with the following code
-	 * temporarily removed without any apparent problems.  However,
-	 * I objdump'ed the kernel and boot code and found out that
-	 * there were no other dccci's anywhere, so I put the code back
-	 * in and have been reluctant to remove it.  It seems safer to
-	 * just leave it here.
+	 * Invalidate the data cache if the data cache is turned off.
+	 * - The 405 core does not invalidate the data cache on power-up
+	 *   or reset but does turn off the data cache. We cannot assume
+	 *   that the cache contents are valid.
+	 * - If the data cache is turned on this must have been done by
+	 *   a bootloader and we assume that the cache contents are
+	 *   valid.
 	 */
-	for (addr = 0;
-	     addr < (congruence_classes * line_size); addr += line_size) {
-	      __asm__("dccci 0,%0": :"b"(addr));
+	__asm__("mfdccr %0": "=r" (dccr));
+	if (dccr == 0) {
+		for (addr = 0;
+		     addr < (congruence_classes * line_size);
+		     addr += line_size) {
+			__asm__("dccci 0,%0": :"b"(addr));
+		}
 	}
 
 	bd = &bdinfo;
@@ -775,6 +775,9 @@
 	bd->bi_memsize = XPAR_DDR_0_SIZE;
 	bd->bi_intfreq = XPAR_CORE_CLOCK_FREQ_HZ;
 	bd->bi_busfreq = XPAR_PLB_CLOCK_FREQ_HZ;
+	bd->bi_pci_busfreq = XPAR_PCI_0_CLOCK_FREQ_HZ;
+	timebase_period_ns = 1000000000 / bd->bi_tbfreq;
+	/* see bi_tbfreq definition in arch/ppc/platforms/4xx/xilinx_ml300.h */
 }
 #endif /* CONFIG_XILINX_ML300 */
 
diff -Naur linux-2.5.base/arch/ppc/Kconfig.debug linux-2.5.current/arch/ppc/Kconfig.debug
--- linux-2.5.base/arch/ppc/Kconfig.debug	2004-10-08 17:06:08.000000000 +0400
+++ linux-2.5.current/arch/ppc/Kconfig.debug	2004-10-08 17:47:59.000000000 +0400
@@ -78,7 +78,7 @@
 
 config PPC_OCP
 	bool
-	depends on IBM_OCP || FSL_OCP
+	depends on IBM_OCP || FSL_OCP || XILINX_OCP
 	default y
 
 endmenu
diff -Naur linux-2.5.base/arch/ppc/platforms/4xx/Kconfig linux-2.5.current/arch/ppc/platforms/4xx/Kconfig
--- linux-2.5.base/arch/ppc/platforms/4xx/Kconfig	2004-10-08 17:02:32.000000000 +0400
+++ linux-2.5.current/arch/ppc/platforms/4xx/Kconfig	2004-10-08 17:47:59.000000000 +0400
@@ -56,6 +56,11 @@
 	help
 	  This option enables support for the IBM PPC405GP evaluation board.
 
+config XILINX_ML300
+	bool "Xilinx-ML300"
+	help
+	  This option enables support for the Xilinx ML300 evaluation board.
+
 endchoice
 
 choice
@@ -130,6 +135,11 @@
 	depends on ASH || BUBINGA || CPCI405 || EBONY || EP405 || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
 	default y
 
+config XILINX_OCP
+	bool
+	depends on XILINX_ML300
+	default y
+
 config IBM_EMAC4
 	bool
 	depends on 440GX
@@ -160,6 +170,11 @@
 	depends on SYCAMORE
 	default y
 
+config VIRTEX_II_PRO
+	bool
+	depends on XILINX_ML300
+	default y
+
 config STB03xxx
 	bool
 	depends on REDWOOD_5 || REDWOOD_6
@@ -167,7 +182,7 @@
 
 config EMBEDDEDBOOT
 	bool
-	depends on EP405
+	depends on EP405 || XILINX_ML300
 	default y
 
 config IBM_OPENBIOS
diff -Naur linux-2.5.base/arch/ppc/platforms/4xx/Makefile linux-2.5.current/arch/ppc/platforms/4xx/Makefile
--- linux-2.5.base/arch/ppc/platforms/4xx/Makefile	2004-10-08 17:06:06.000000000 +0400
+++ linux-2.5.current/arch/ppc/platforms/4xx/Makefile	2004-10-08 17:47:59.000000000 +0400
@@ -12,6 +12,7 @@
 obj-$(CONFIG_REDWOOD_6)		+= redwood6.o
 obj-$(CONFIG_SYCAMORE)		+= sycamore.o
 obj-$(CONFIG_WALNUT)		+= walnut.o
+obj-$(CONFIG_XILINX_ML300)	+= xilinx_ml300.o
 
 obj-$(CONFIG_405GP)		+= ibm405gp.o
 obj-$(CONFIG_REDWOOD_5)		+= ibmstb4.o
@@ -21,3 +22,4 @@
 obj-$(CONFIG_440GX)		+= ibm440gx.o
 obj-$(CONFIG_405EP)		+= ibm405ep.o
 obj-$(CONFIG_405GPR)		+= ibm405gpr.o
+obj-$(CONFIG_VIRTEX_II_PRO)	+= virtex-ii_pro.o
diff -Naur linux-2.5.base/arch/ppc/platforms/4xx/virtex-ii_pro.c linux-2.5.current/arch/ppc/platforms/4xx/virtex-ii_pro.c
--- linux-2.5.base/arch/ppc/platforms/4xx/virtex-ii_pro.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.5.current/arch/ppc/platforms/4xx/virtex-ii_pro.c	2004-10-08 17:47:59.000000000 +0400
@@ -0,0 +1,60 @@
+/*
+ * arch/ppc/platforms/4xx/virtex-ii_pro.c
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <asm/ocp.h>
+#include "virtex-ii_pro.h"
+
+/* Have OCP take care of the serial ports. */
+struct ocp_def core_ocp[] = {
+#ifdef XPAR_UARTNS550_0_BASEADDR
+	{ .vendor	= OCP_VENDOR_XILINX,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= XPAR_UARTNS550_0_BASEADDR,
+	  .irq		= XPAR_INTC_0_UARTNS550_0_VEC_ID,
+	  .pm		= OCP_CPM_NA
+	},
+#ifdef XPAR_UARTNS550_1_BASEADDR
+	{ .vendor	= OCP_VENDOR_XILINX,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= XPAR_UARTNS550_1_BASEADDR,
+	  .irq		= XPAR_INTC_0_UARTNS550_1_VEC_ID,
+	  .pm		= OCP_CPM_NA
+	},
+#ifdef XPAR_UARTNS550_2_BASEADDR
+	{ .vendor	= OCP_VENDOR_XILINX,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 2,
+	  .paddr	= XPAR_UARTNS550_2_BASEADDR,
+	  .irq		= XPAR_INTC_0_UARTNS550_2_VEC_ID,
+	  .pm		= OCP_CPM_NA
+	},
+#ifdef XPAR_UARTNS550_3_BASEADDR
+	{ .vendor	= OCP_VENDOR_XILINX,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 3,
+	  .paddr	= XPAR_UARTNS550_3_BASEADDR,
+	  .irq		= XPAR_INTC_0_UARTNS550_3_VEC_ID,
+	  .pm		= OCP_CPM_NA
+	},
+#ifdef XPAR_UARTNS550_4_BASEADDR
+#error Edit this file to add more devices.
+#endif			/* 4 */
+#endif			/* 3 */
+#endif			/* 2 */
+#endif			/* 1 */
+#endif			/* 0 */
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
diff -Naur linux-2.5.base/arch/ppc/platforms/4xx/virtex-ii_pro.h linux-2.5.current/arch/ppc/platforms/4xx/virtex-ii_pro.h
--- linux-2.5.base/arch/ppc/platforms/4xx/virtex-ii_pro.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.5.current/arch/ppc/platforms/4xx/virtex-ii_pro.h	2004-10-08 17:47:59.000000000 +0400
@@ -0,0 +1,99 @@
+/*
+ * arch/ppc/platforms/4xx/virtex-ii_pro.h
+ *
+ * Include file that defines the Xilinx Virtex-II Pro processor
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_VIRTEXIIPRO_H__
+#define __ASM_VIRTEXIIPRO_H__
+
+#include <linux/config.h>
+#include <asm/xparameters.h>
+
+/* serial defines */
+
+#define RS_TABLE_SIZE  4	/* change this and add more devices below 
+				   if you have more then 4 16x50 UARTs */
+
+#define BASE_BAUD		(XPAR_UARTNS550_0_CLOCK_FREQ_HZ/16)
+
+/* The serial ports in the Virtex-II Pro have each I/O byte in the
+ * LSByte of a word.  This means that iomem_reg_shift needs to be 2 to
+ * change the byte offsets into word offsets.  In addition the base
+ * addresses need to have 3 added to them to get to the LSByte.
+ */
+#define STD_UART_OP(num)						 \
+	{ 0, BASE_BAUD, 0, XPAR_INTC_0_UARTNS550_##num##_VEC_ID,	 \
+		ASYNC_BOOT_AUTOCONF,		 			 \
+		.iomem_base = (u8 *)XPAR_UARTNS550_##num##_BASEADDR + 3, \
+		.iomem_reg_shift = 2,					 \
+		.io_type = SERIAL_IO_MEM},
+
+#if defined(XPAR_INTC_0_UARTNS550_0_VEC_ID)
+#define ML300_UART0 STD_UART_OP(0)
+#else
+#define ML300_UART0
+#endif
+
+#if defined(XPAR_INTC_0_UARTNS550_1_VEC_ID)
+#define ML300_UART1 STD_UART_OP(1)
+#else
+#define ML300_UART1
+#endif
+
+#if defined(XPAR_INTC_0_UARTNS550_2_VEC_ID)
+#define ML300_UART2 STD_UART_OP(2)
+#else
+#define ML300_UART2
+#endif
+
+#if defined(XPAR_INTC_0_UARTNS550_3_VEC_ID)
+#define ML300_UART3 STD_UART_OP(3)
+#else
+#define ML300_UART3
+#endif
+
+#if defined(XPAR_INTC_0_UARTNS550_4_VEC_ID)
+#error Edit this file to add more devices.
+#elif defined(XPAR_INTC_0_UARTNS550_3_VEC_ID)
+#define NR_SER_PORTS	4
+#elif defined(XPAR_INTC_0_UARTNS550_2_VEC_ID)
+#define NR_SER_PORTS	3
+#elif defined(XPAR_INTC_0_UARTNS550_1_VEC_ID)
+#define NR_SER_PORTS	2
+#elif defined(XPAR_INTC_0_UARTNS550_0_VEC_ID)
+#define NR_SER_PORTS	1
+#else
+#define NR_SER_PORTS	0
+#endif
+
+#if defined(CONFIG_UART0_TTYS0)
+#define SERIAL_PORT_DFNS	\
+	ML300_UART0		\
+	ML300_UART1		\
+	ML300_UART2		\
+	ML300_UART3
+#endif
+
+#if defined(CONFIG_UART0_TTYS1)
+#define SERIAL_PORT_DFNS	\
+	ML300_UART1		\
+	ML300_UART0		\
+	ML300_UART2		\
+	ML300_UART3
+#endif
+
+#define DCRN_CPMFR_BASE	0
+
+#include <asm/ibm405.h>
+
+#endif				/* __ASM_VIRTEXIIPRO_H__ */
+#endif				/* __KERNEL__ */
diff -Naur linux-2.5.base/arch/ppc/platforms/4xx/xilinx_ml300.c linux-2.5.current/arch/ppc/platforms/4xx/xilinx_ml300.c
--- linux-2.5.base/arch/ppc/platforms/4xx/xilinx_ml300.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.5.current/arch/ppc/platforms/4xx/xilinx_ml300.c	2004-10-08 17:47:59.000000000 +0400
@@ -0,0 +1,164 @@
+/*
+ * arch/ppc/platforms/4xx/xilinx_ml300.c
+ *
+ * Xilinx ML300 evaluation board initialization
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serialP.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ocp.h>
+
+#include <platforms/4xx/virtex-ii_pro.h>	/* for NR_SER_PORTS */
+
+/*
+ * As an overview of how the following functions (platform_init,
+ * ml300_map_io, ml300_setup_arch and ml300_init_IRQ) fit into the
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
+ *    *ppc_md.setup_io_mappings == ml300_map_io	this file
+ *      ppc4xx_map_io				arch/ppc/syslib/ppc4xx_setup.c
+ *  start_kernel				init/main.c
+ *    setup_arch				arch/ppc/kernel/setup.c
+ * #if defined(CONFIG_KGDB)
+ *      *ppc_md.kgdb_map_scc() == gen550_kgdb_map_scc
+ * #endif
+ *      *ppc_md.setup_arch == ml300_setup_arch	this file
+ *        ppc4xx_setup_arch			arch/ppc/syslib/ppc4xx_setup.c
+ *          ppc4xx_find_bridges			arch/ppc/syslib/ppc405_pci.c
+ *    init_IRQ					arch/ppc/kernel/irq.c
+ *      *ppc_md.init_IRQ == ml300_init_IRQ	this file
+ *        ppc4xx_init_IRQ			arch/ppc/syslib/ppc4xx_setup.c
+ *          ppc4xx_pic_init			arch/ppc/syslib/xilinx_pic.c
+ */
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
+ml300_map_io(void)
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
+static void __init
+ml300_early_serial_map(void)
+{
+#ifdef CONFIG_SERIAL_8250
+	struct serial_state old_ports[] = { SERIAL_PORT_DFNS };
+	struct uart_port port;
+	int i;
+
+	/* Setup ioremapped serial port access */
+	for (i = 0; i < ARRAY_SIZE(old_ports); i++ ) {
+		memset(&port, 0, sizeof(port));
+		port.membase = ioremap((phys_addr_t)(old_ports[i].iomem_base), 16);
+		port.irq = old_ports[i].irq;
+		port.uartclk = old_ports[i].baud_base * 16;
+		port.regshift = old_ports[i].iomem_reg_shift;
+		port.iotype = SERIAL_IO_MEM;
+		port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+		port.line = i;
+
+		if (early_serial_setup(&port) != 0) {
+			printk("Early serial init of port %d failed\n", i);
+		}
+	}
+#endif /* CONFIG_SERIAL_8250 */
+}
+
+void __init
+ml300_setup_arch(void)
+{
+	ppc4xx_setup_arch();	/* calls ppc4xx_find_bridges() */
+
+	ml300_early_serial_map();
+
+	/* Identify the system */
+	printk(KERN_INFO "Xilinx Virtex-II Pro port\n");
+	printk(KERN_INFO "Port by MontaVista Software, Inc. (source@mvista.com)\n");
+}
+
+/* Called after board_setup_irq from ppc4xx_init_IRQ(). */
+void __init
+ml300_init_irq(void)
+{
+	unsigned int i;
+
+	ppc4xx_init_IRQ();
+
+	/*
+	 * For PowerPC 405 cores the default value for NR_IRQS is 32.
+	 * See include/asm-ppc/irq.h for details.
+	 * This is just fine for ML300.
+	 */
+#if (NR_IRQS != 32)
+#error NR_IRQS must be 32 for ML300
+#endif
+
+	for (i = 0; i < NR_IRQS; i++) {
+		if (XPAR_INTC_0_KIND_OF_INTR & (0x80000000 >> i))
+			irq_desc[i].status &= ~IRQ_LEVEL;
+		else
+			irq_desc[i].status |= IRQ_LEVEL;
+	}
+}
+
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	      unsigned long r6, unsigned long r7)
+{
+	ppc4xx_init(r3, r4, r5, r6, r7);
+
+	ppc_md.setup_arch = ml300_setup_arch;
+	ppc_md.setup_io_mappings = ml300_map_io;
+	ppc_md.init_IRQ = ml300_init_irq;
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+	ppc_md.power_off = xilinx_power_off;
+#endif
+
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = ml300_early_serial_map;
+#endif
+}
+
diff -Naur linux-2.5.base/arch/ppc/platforms/4xx/xilinx_ml300.h linux-2.5.current/arch/ppc/platforms/4xx/xilinx_ml300.h
--- linux-2.5.base/arch/ppc/platforms/4xx/xilinx_ml300.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.5.current/arch/ppc/platforms/4xx/xilinx_ml300.h	2004-10-08 17:47:59.000000000 +0400
@@ -0,0 +1,47 @@
+/*
+ * arch/ppc/platforms/4xx/xilinx_ml300.h
+ *
+ * Include file that defines the Xilinx ML300 evaluation board
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_XILINX_ML300_H__
+#define __ASM_XILINX_ML300_H__
+
+/* ML300 has a Xilinx Virtex-II Pro processor */
+#include <platforms/4xx/virtex-ii_pro.h>
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
+#define PPC4xx_MACHINE_NAME "Xilinx ML300"
+
+#endif /* __ASM_XILINX_ML300_H__ */
+#endif /* __KERNEL__ */
diff -Naur linux-2.5.base/arch/ppc/platforms/4xx/xparameters/xparameters_ml300.h linux-2.5.current/arch/ppc/platforms/4xx/xparameters/xparameters_ml300.h
--- linux-2.5.base/arch/ppc/platforms/4xx/xparameters/xparameters_ml300.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.5.current/arch/ppc/platforms/4xx/xparameters/xparameters_ml300.h	2004-10-08 17:47:59.000000000 +0400
@@ -0,0 +1,310 @@
+/*******************************************************************
+*
+*     Author: Xilinx, Inc.
+*     
+*     
+*     This program is free software; you can redistribute it and/or modify it
+*     under the terms of the GNU General Public License as published by the
+*     Free Software Foundation; either version 2 of the License, or (at your
+*     option) any later version.
+*     
+*     
+*     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
+*     COURTESY TO YOU. BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
+*     ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD,
+*     XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE
+*     FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING
+*     ANY THIRD PARTY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
+*     XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
+*     THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY
+*     WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM
+*     CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND
+*     FITNESS FOR A PARTICULAR PURPOSE.
+*     
+*     
+*     Xilinx hardware products are not intended for use in life support
+*     appliances, devices, or systems. Use in such applications is
+*     expressly prohibited.
+*     
+*     
+*     (c) Copyright 2002-2004 Xilinx Inc.
+*     All rights reserved.
+*     
+*     
+*     You should have received a copy of the GNU General Public License along
+*     with this program; if not, write to the Free Software Foundation, Inc.,
+*     675 Mass Ave, Cambridge, MA 02139, USA.
+* 
+* Description: Driver parameters
+*
+*******************************************************************/
+
+#define XPAR_XPCI_NUM_INSTANCES 1
+#define XPAR_XPCI_CLOCK_HZ 33333333
+#define XPAR_OPB_PCI_REF_0_DEVICE_ID 0
+#define XPAR_OPB_PCI_REF_0_BASEADDR 0x20000000
+#define XPAR_OPB_PCI_REF_0_HIGHADDR 0x3FFFFFFF
+#define XPAR_OPB_PCI_REF_0_CONFIG_ADDR 0x3C000000
+#define XPAR_OPB_PCI_REF_0_CONFIG_DATA 0x3C000004
+#define XPAR_OPB_PCI_REF_0_LCONFIG_ADDR 0x3E000000
+#define XPAR_OPB_PCI_REF_0_MEM_BASEADDR 0x20000000
+#define XPAR_OPB_PCI_REF_0_MEM_HIGHADDR 0x37FFFFFF
+#define XPAR_OPB_PCI_REF_0_IO_BASEADDR 0x38000000
+#define XPAR_OPB_PCI_REF_0_IO_HIGHADDR 0x3BFFFFFF
+
+/******************************************************************/
+
+#define XPAR_XEMAC_NUM_INSTANCES 1
+#define XPAR_OPB_ETHERNET_0_BASEADDR 0x60000000
+#define XPAR_OPB_ETHERNET_0_HIGHADDR 0x60003FFF
+#define XPAR_OPB_ETHERNET_0_DEVICE_ID 0
+#define XPAR_OPB_ETHERNET_0_ERR_COUNT_EXIST 1
+#define XPAR_OPB_ETHERNET_0_DMA_PRESENT 1
+#define XPAR_OPB_ETHERNET_0_MII_EXIST 1
+
+/******************************************************************/
+
+#define XPAR_MY_OPB_GPIO_0_DEVICE_ID_0 0
+#define XPAR_MY_OPB_GPIO_0_BASEADDR_0 0x90000000
+#define XPAR_MY_OPB_GPIO_0_HIGHADDR_0 (0x90000000+0x7)
+#define XPAR_MY_OPB_GPIO_0_DEVICE_ID_1 1
+#define XPAR_MY_OPB_GPIO_0_BASEADDR_1 (0x90000000+0x8)
+#define XPAR_MY_OPB_GPIO_0_HIGHADDR_1 (0x90000000+0x1F)
+#define XPAR_XGPIO_NUM_INSTANCES 2
+
+/******************************************************************/
+
+#define XPAR_XIIC_NUM_INSTANCES 1
+#define XPAR_OPB_IIC_0_BASEADDR 0xA8000000
+#define XPAR_OPB_IIC_0_HIGHADDR 0xA80001FF
+#define XPAR_OPB_IIC_0_DEVICE_ID 0
+#define XPAR_OPB_IIC_0_TEN_BIT_ADR 0
+
+/******************************************************************/
+
+#define XPAR_XUARTNS550_NUM_INSTANCES 2
+#define XPAR_XUARTNS550_CLOCK_HZ 100000000
+#define XPAR_OPB_UART16550_0_BASEADDR 0xA0000000
+#define XPAR_OPB_UART16550_0_HIGHADDR 0xA0001FFF
+#define XPAR_OPB_UART16550_0_DEVICE_ID 0
+#define XPAR_OPB_UART16550_1_BASEADDR 0xA0010000
+#define XPAR_OPB_UART16550_1_HIGHADDR 0xA0011FFF
+#define XPAR_OPB_UART16550_1_DEVICE_ID 1
+
+/******************************************************************/
+
+#define XPAR_XSPI_NUM_INSTANCES 1
+#define XPAR_OPB_SPI_0_BASEADDR 0xA4000000
+#define XPAR_OPB_SPI_0_HIGHADDR 0xA400007F
+#define XPAR_OPB_SPI_0_DEVICE_ID 0
+#define XPAR_OPB_SPI_0_FIFO_EXIST 1
+#define XPAR_OPB_SPI_0_SPI_SLAVE_ONLY 0
+#define XPAR_OPB_SPI_0_NUM_SS_BITS 1
+
+/******************************************************************/
+
+#define XPAR_XPS2_NUM_INSTANCES 2
+#define XPAR_OPB_PS2_DUAL_REF_0_DEVICE_ID_0 0
+#define XPAR_OPB_PS2_DUAL_REF_0_BASEADDR_0 0xA9000000
+#define XPAR_OPB_PS2_DUAL_REF_0_HIGHADDR_0 (0xA9000000+0x3F)
+#define XPAR_OPB_PS2_DUAL_REF_0_DEVICE_ID_1 1
+#define XPAR_OPB_PS2_DUAL_REF_0_BASEADDR_1 (0xA9000000+0x1000)
+#define XPAR_OPB_PS2_DUAL_REF_0_HIGHADDR_1 (0xA9000000+0x103F)
+
+/******************************************************************/
+
+#define XPAR_XTOUCHSCREEN_NUM_INSTANCES 1
+#define XPAR_OPB_TSD_REF_0_BASEADDR 0xAA000000
+#define XPAR_OPB_TSD_REF_0_HIGHADDR 0xAA000007
+#define XPAR_OPB_TSD_REF_0_DEVICE_ID 0
+
+/******************************************************************/
+
+#define XPAR_OPB_AC97_CONTROLLER_REF_0_BASEADDR 0xA6000000
+#define XPAR_OPB_AC97_CONTROLLER_REF_0_HIGHADDR 0xA60000FF
+#define XPAR_OPB_PAR_PORT_REF_0_BASEADDR 0x90010000
+#define XPAR_OPB_PAR_PORT_REF_0_HIGHADDR 0x900100FF
+#define XPAR_PLB_DDR_0_BASEADDR 0x00000000
+#define XPAR_PLB_DDR_0_HIGHADDR 0x0FFFFFFF
+
+/******************************************************************/
+
+#define XPAR_XINTC_HAS_IPR 1
+#define XPAR_INTC_MAX_NUM_INTR_INPUTS 18
+#define XPAR_XINTC_USE_DCR 0
+#define XPAR_XINTC_NUM_INSTANCES 1
+#define XPAR_DCR_INTC_0_BASEADDR 0xD0000FC0
+#define XPAR_DCR_INTC_0_HIGHADDR 0xD0000FDF
+#define XPAR_DCR_INTC_0_DEVICE_ID 0
+#define XPAR_DCR_INTC_0_KIND_OF_INTR 0x00038000
+
+/******************************************************************/
+
+#define XPAR_DCR_INTC_0_MISC_LOGIC_0_PHY_MII_INT_INTR 0
+#define XPAR_DCR_INTC_0_OPB_ETHERNET_0_IP2INTC_IRPT_INTR 1
+#define XPAR_DCR_INTC_0_MISC_LOGIC_0_IIC_TEMP_CRIT_INTR 2
+#define XPAR_DCR_INTC_0_MISC_LOGIC_0_IIC_IRQ_INTR 3
+#define XPAR_DCR_INTC_0_OPB_IIC_0_IP2INTC_IRPT_INTR 4
+#define XPAR_DCR_INTC_0_OPB_SYSACE_0_SYSACE_IRQ_INTR 5
+#define XPAR_DCR_INTC_0_OPB_UART16550_0_IP2INTC_IRPT_INTR 6
+#define XPAR_DCR_INTC_0_OPB_UART16550_1_IP2INTC_IRPT_INTR 7
+#define XPAR_DCR_INTC_0_OPB_PS2_DUAL_REF_0_SYS_INTR1_INTR 8
+#define XPAR_DCR_INTC_0_OPB_PS2_DUAL_REF_0_SYS_INTR2_INTR 9
+#define XPAR_DCR_INTC_0_OPB_SPI_0_IP2INTC_IRPT_INTR 10
+#define XPAR_DCR_INTC_0_OPB_TSD_REF_0_INTR_INTR 11
+#define XPAR_DCR_INTC_0_OPB_AC97_CONTROLLER_REF_0_PLAYBACK_INTERRUPT_INTR 12
+#define XPAR_DCR_INTC_0_OPB_AC97_CONTROLLER_REF_0_RECORD_INTERRUPT_INTR 13
+#define XPAR_DCR_INTC_0_OPB_PCI_REF_0_INTR_OUT_INTR 14
+#define XPAR_DCR_INTC_0_PLB2OPB_BRIDGE_0_BUS_ERROR_DET_INTR 15
+#define XPAR_DCR_INTC_0_PLB_V34_0_BUS_ERROR_DET_INTR 16
+#define XPAR_DCR_INTC_0_OPB2PLB_BRIDGE_0_BUS_ERROR_DET_INTR 17
+
+/******************************************************************/
+
+#define XPAR_XTFT_NUM_INSTANCES 1
+#define XPAR_PLB_TFT_CNTLR_REF_0_DCR_BASEADDR 0xD0000200
+#define XPAR_PLB_TFT_CNTLR_REF_0_DCR_HIGHADDR 0xD0000207
+#define XPAR_PLB_TFT_CNTLR_REF_0_DEVICE_ID 0
+
+/******************************************************************/
+
+#define XPAR_XSYSACE_MEM_WIDTH 8
+#define XPAR_XSYSACE_NUM_INSTANCES 1
+#define XPAR_OPB_SYSACE_0_BASEADDR 0xCF000000
+#define XPAR_OPB_SYSACE_0_HIGHADDR 0xCF0001FF
+#define XPAR_OPB_SYSACE_0_DEVICE_ID 0
+#define XPAR_OPB_SYSACE_0_MEM_WIDTH 8
+
+/******************************************************************/
+
+#define XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ 300000000
+
+/******************************************************************/
+
+/******************************************************************/
+
+/* Linux Redefines */
+
+/******************************************************************/
+
+#define XPAR_UARTNS550_0_BASEADDR (XPAR_OPB_UART16550_0_BASEADDR+0x1000)
+#define XPAR_UARTNS550_0_HIGHADDR XPAR_OPB_UART16550_0_HIGHADDR
+#define XPAR_UARTNS550_0_CLOCK_FREQ_HZ XPAR_XUARTNS550_CLOCK_HZ
+#define XPAR_UARTNS550_0_DEVICE_ID XPAR_OPB_UART16550_0_DEVICE_ID
+#define XPAR_UARTNS550_1_BASEADDR (XPAR_OPB_UART16550_1_BASEADDR+0x1000)
+#define XPAR_UARTNS550_1_HIGHADDR XPAR_OPB_UART16550_1_HIGHADDR
+#define XPAR_UARTNS550_1_CLOCK_FREQ_HZ XPAR_XUARTNS550_CLOCK_HZ
+#define XPAR_UARTNS550_1_DEVICE_ID XPAR_OPB_UART16550_1_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_GPIO_0_BASEADDR XPAR_MY_OPB_GPIO_0_BASEADDR_0
+#define XPAR_GPIO_0_HIGHADDR XPAR_MY_OPB_GPIO_0_HIGHADDR_0
+#define XPAR_GPIO_0_DEVICE_ID XPAR_MY_OPB_GPIO_0_DEVICE_ID_0
+#define XPAR_GPIO_1_BASEADDR XPAR_MY_OPB_GPIO_0_BASEADDR_1
+#define XPAR_GPIO_1_HIGHADDR XPAR_MY_OPB_GPIO_0_HIGHADDR_1
+#define XPAR_GPIO_1_DEVICE_ID XPAR_MY_OPB_GPIO_0_DEVICE_ID_1
+
+/******************************************************************/
+
+#define XPAR_IIC_0_BASEADDR XPAR_OPB_IIC_0_BASEADDR
+#define XPAR_IIC_0_HIGHADDR XPAR_OPB_IIC_0_HIGHADDR
+#define XPAR_IIC_0_TEN_BIT_ADR XPAR_OPB_IIC_0_TEN_BIT_ADR
+#define XPAR_IIC_0_DEVICE_ID XPAR_OPB_IIC_0_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_SYSACE_0_BASEADDR XPAR_OPB_SYSACE_0_BASEADDR
+#define XPAR_SYSACE_0_HIGHADDR XPAR_OPB_SYSACE_0_HIGHADDR
+#define XPAR_SYSACE_0_DEVICE_ID XPAR_OPB_SYSACE_0_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_INTC_0_BASEADDR XPAR_DCR_INTC_0_BASEADDR
+#define XPAR_INTC_0_HIGHADDR XPAR_DCR_INTC_0_HIGHADDR
+#define XPAR_INTC_0_KIND_OF_INTR XPAR_DCR_INTC_0_KIND_OF_INTR
+#define XPAR_INTC_0_DEVICE_ID XPAR_DCR_INTC_0_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_INTC_0_EMAC_0_VEC_ID XPAR_DCR_INTC_0_OPB_ETHERNET_0_IP2INTC_IRPT_INTR
+#define XPAR_INTC_0_IIC_0_VEC_ID XPAR_DCR_INTC_0_OPB_IIC_0_IP2INTC_IRPT_INTR
+#define XPAR_INTC_0_SYSACE_0_VEC_ID XPAR_DCR_INTC_0_OPB_SYSACE_0_SYSACE_IRQ_INTR
+#define XPAR_INTC_0_UARTNS550_0_VEC_ID XPAR_DCR_INTC_0_OPB_UART16550_0_IP2INTC_IRPT_INTR
+#define XPAR_INTC_0_UARTNS550_1_VEC_ID XPAR_DCR_INTC_0_OPB_UART16550_1_IP2INTC_IRPT_INTR
+#define XPAR_INTC_0_PS2_0_VEC_ID XPAR_DCR_INTC_0_OPB_PS2_DUAL_REF_0_SYS_INTR1_INTR
+#define XPAR_INTC_0_PS2_1_VEC_ID XPAR_DCR_INTC_0_OPB_PS2_DUAL_REF_0_SYS_INTR2_INTR
+#define XPAR_INTC_0_SPI_0_VEC_ID XPAR_DCR_INTC_0_OPB_SPI_0_IP2INTC_IRPT_INTR
+#define XPAR_INTC_0_TOUCHSCREEN_0_VEC_ID XPAR_DCR_INTC_0_OPB_TSD_REF_0_INTR_INTR
+#define XPAR_INTC_0_PCI_0_VEC_ID_A XPAR_DCR_INTC_0_OPB_PCI_REF_0_INTR_OUT_INTR
+#define XPAR_INTC_0_PCI_0_VEC_ID_B XPAR_DCR_INTC_0_OPB_PCI_REF_0_INTR_OUT_INTR
+#define XPAR_INTC_0_PCI_0_VEC_ID_C XPAR_DCR_INTC_0_OPB_PCI_REF_0_INTR_OUT_INTR
+#define XPAR_INTC_0_PCI_0_VEC_ID_D XPAR_DCR_INTC_0_OPB_PCI_REF_0_INTR_OUT_INTR
+
+/******************************************************************/
+
+#define XPAR_EMAC_0_BASEADDR XPAR_OPB_ETHERNET_0_BASEADDR
+#define XPAR_EMAC_0_HIGHADDR XPAR_OPB_ETHERNET_0_HIGHADDR
+#define XPAR_EMAC_0_DMA_PRESENT XPAR_OPB_ETHERNET_0_DMA_PRESENT
+#define XPAR_EMAC_0_MII_EXIST XPAR_OPB_ETHERNET_0_MII_EXIST
+#define XPAR_EMAC_0_ERR_COUNT_EXIST XPAR_OPB_ETHERNET_0_ERR_COUNT_EXIST
+#define XPAR_EMAC_0_DEVICE_ID XPAR_OPB_ETHERNET_0_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_SPI_0_BASEADDR XPAR_OPB_SPI_0_BASEADDR
+#define XPAR_SPI_0_HIGHADDR XPAR_OPB_SPI_0_HIGHADDR
+#define XPAR_SPI_0_DEVICE_ID XPAR_OPB_SPI_0_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_TOUCHSCREEN_0_BASEADDR XPAR_OPB_TSD_REF_0_BASEADDR
+#define XPAR_TOUCHSCREEN_0_HIGHADDR XPAR_OPB_TSD_REF_0_HIGHADDR
+#define XPAR_TOUCHSCREEN_0_DEVICE_ID XPAR_OPB_TSD_REF_0_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_TFT_0_BASEADDR XPAR_PLB_TFT_CNTLR_REF_0_DCR_BASEADDR
+
+/******************************************************************/
+
+#define XPAR_PCI_0_BASEADDR XPAR_OPB_PCI_REF_0_BASEADDR
+#define XPAR_PCI_0_HIGHADDR XPAR_OPB_PCI_REF_0_HIGHADDR
+#define XPAR_PCI_0_CONFIG_ADDR XPAR_OPB_PCI_REF_0_CONFIG_ADDR
+#define XPAR_PCI_0_CONFIG_DATA XPAR_OPB_PCI_REF_0_CONFIG_DATA
+#define XPAR_PCI_0_LCONFIG_ADDR XPAR_OPB_PCI_REF_0_LCONFIG_ADDR
+#define XPAR_PCI_0_MEM_BASEADDR XPAR_OPB_PCI_REF_0_MEM_BASEADDR
+#define XPAR_PCI_0_MEM_HIGHADDR XPAR_OPB_PCI_REF_0_MEM_HIGHADDR
+#define XPAR_PCI_0_IO_BASEADDR XPAR_OPB_PCI_REF_0_IO_BASEADDR
+#define XPAR_PCI_0_IO_HIGHADDR XPAR_OPB_PCI_REF_0_IO_HIGHADDR
+#define XPAR_PCI_0_CLOCK_FREQ_HZ XPAR_XPCI_CLOCK_HZ
+#define XPAR_PCI_0_DEVICE_ID XPAR_OPB_PCI_REF_0_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_PS2_0_BASEADDR XPAR_OPB_PS2_DUAL_REF_0_BASEADDR_0
+#define XPAR_PS2_0_HIGHADDR XPAR_OPB_PS2_DUAL_REF_0_HIGHADDR_0
+#define XPAR_PS2_0_DEVICE_ID XPAR_OPB_PS2_DUAL_REF_0_DEVICE_ID_0
+#define XPAR_PS2_1_BASEADDR XPAR_OPB_PS2_DUAL_REF_0_BASEADDR_1
+#define XPAR_PS2_1_HIGHADDR XPAR_OPB_PS2_DUAL_REF_0_HIGHADDR_1
+#define XPAR_PS2_1_DEVICE_ID XPAR_OPB_PS2_DUAL_REF_0_DEVICE_ID_1
+
+/******************************************************************/
+
+#define XPAR_PLB_CLOCK_FREQ_HZ 100000000
+#define XPAR_CORE_CLOCK_FREQ_HZ XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ
+#define XPAR_DDR_0_SIZE 0x08000000
+
+/******************************************************************/
+
+#define XPAR_PERSISTENT_0_IIC_0_BASEADDR 0x00000400
+#define XPAR_PERSISTENT_0_IIC_0_HIGHADDR 0x000007FF
+#define XPAR_PERSISTENT_0_IIC_0_EEPROMADDR 0xA0
+
+/******************************************************************/
+
+#define XPAR_POWER_0_POWERDOWN_BASEADDR 0x90000004
+#define XPAR_POWER_0_POWERDOWN_HIGHADDR 0x90000007
+#define XPAR_POWER_0_POWERDOWN_VALUE 0xFF
+
+/******************************************************************/
diff -Naur linux-2.5.base/arch/ppc/syslib/Makefile linux-2.5.current/arch/ppc/syslib/Makefile
--- linux-2.5.base/arch/ppc/syslib/Makefile	2004-10-08 17:02:22.000000000 +0400
+++ linux-2.5.current/arch/ppc/syslib/Makefile	2004-10-08 17:47:59.000000000 +0400
@@ -14,7 +14,12 @@
 obj-$(CONFIG_440GP)		+= ibm440gp_common.o
 obj-$(CONFIG_440GX)		+= ibm440gx_common.o
 ifeq ($(CONFIG_4xx),y)
-obj-$(CONFIG_4xx)		+= ppc4xx_pic.o
+ifeq ($(CONFIG_VIRTEX_II_PRO),y)
+obj-$(CONFIG_40x)		+= xilinx_pic.o
+else
+obj-$(CONFIG_40x)		+= ppc4xx_pic.o
+endif
+obj-$(CONFIG_44x)		+= ppc4xx_pic.o
 obj-$(CONFIG_40x)		+= ppc4xx_setup.o
 obj-$(CONFIG_GEN_RTC)		+= todc_time.o
 obj-$(CONFIG_PPC4xx_DMA)	+= ppc4xx_dma.o
diff -Naur linux-2.5.base/arch/ppc/syslib/xilinx_pic.c linux-2.5.current/arch/ppc/syslib/xilinx_pic.c
--- linux-2.5.base/arch/ppc/syslib/xilinx_pic.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.5.current/arch/ppc/syslib/xilinx_pic.c	2004-10-08 17:48:35.000000000 +0400
@@ -0,0 +1,142 @@
+/*
+ * arch/ppc/syslib/xilinx_pic.c
+ *
+ * Interrupt controller driver for Xilinx Virtex-II Pro.
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <asm/io.h>
+#include <asm/xparameters.h>
+#include <asm/ibm4xx.h>
+
+/* No one else should require these constants, so define them locally here. */
+#define ISR 0			/* Interrupt Status Register */
+#define IPR 1			/* Interrupt Pending Register */
+#define IER 2			/* Interrupt Enable Register */
+#define IAR 3			/* Interrupt Acknowledge Register */
+#define SIE 4			/* Set Interrupt Enable bits */
+#define CIE 5			/* Clear Interrupt Enable bits */
+#define IVR 6			/* Interrupt Vector Register */
+#define MER 7			/* Master Enable Register */
+
+#if XPAR_XINTC_USE_DCR == 0
+static volatile u32 *intc;
+#define intc_out_be32(addr, mask)     out_be32((addr), (mask))
+#define intc_in_be32(addr)            in_be32((addr))
+#else
+#define intc    XPAR_INTC_0_BASEADDR
+#define intc_out_be32(addr, mask)     mtdcr((addr), (mask))
+#define intc_in_be32(addr)            mfdcr((addr))
+#endif
+
+/* Global Variables */
+struct hw_interrupt_type *ppc4xx_pic;
+
+static void
+xilinx_intc_enable(unsigned int irq)
+{
+	unsigned long mask = (0x00000001 << (irq & 31));
+	pr_debug("enable: %d\n", irq);
+	intc_out_be32(intc + SIE, mask);
+}
+
+static void
+xilinx_intc_disable(unsigned int irq)
+{
+	unsigned long mask = (0x00000001 << (irq & 31));
+	pr_debug("disable: %d\n", irq);
+	intc_out_be32(intc + CIE, mask);
+}
+
+static void
+xilinx_intc_disable_and_ack(unsigned int irq)
+{
+	unsigned long mask = (0x00000001 << (irq & 31));
+	pr_debug("disable_and_ack: %d\n", irq);
+	intc_out_be32(intc + CIE, mask);
+	if (!(irq_desc[irq].status & IRQ_LEVEL))
+		intc_out_be32(intc + IAR, mask);	/* ack edge triggered intr */
+}
+
+static void
+xilinx_intc_end(unsigned int irq)
+{
+	unsigned long mask = (0x00000001 << (irq & 31));
+
+	pr_debug("end: %d\n", irq);
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
+		intc_out_be32(intc + SIE, mask);
+		/* ack level sensitive intr */
+		if (irq_desc[irq].status & IRQ_LEVEL)
+			intc_out_be32(intc + IAR, mask);
+	}
+}
+
+static struct hw_interrupt_type xilinx_intc = {
+	"Xilinx Interrupt Controller",
+	NULL,
+	NULL,
+	xilinx_intc_enable,
+	xilinx_intc_disable,
+	xilinx_intc_disable_and_ack,
+	xilinx_intc_end,
+	0
+};
+
+int
+xilinx_pic_get_irq(struct pt_regs *regs)
+{
+	int irq;
+
+	/*
+	 * NOTE: This function is the one that needs to be improved in
+	 * order to handle multiple interrupt controllers.  It currently
+	 * is hardcoded to check for interrupts only on the first INTC.
+	 */
+
+	irq = intc_in_be32(intc + IVR);
+	if (irq != -1)
+		irq = irq;
+
+	pr_debug("get_irq: %d\n", irq);
+
+	return (irq);
+}
+
+void __init
+ppc4xx_pic_init(void)
+{
+#if XPAR_XINTC_USE_DCR == 0
+	intc = ioremap(XPAR_INTC_0_BASEADDR, 32);
+
+	printk(KERN_INFO "Xilinx INTC #0 at 0x%08lX mapped to 0x%08lX\n",
+	       (unsigned long) XPAR_INTC_0_BASEADDR, (unsigned long) intc);
+#else
+	printk(KERN_INFO "Xilinx INTC #0 at 0x%08lX (DCR)\n",
+	       (unsigned long) XPAR_INTC_0_BASEADDR);
+#endif
+
+	/*
+	 * Disable all external interrupts until they are
+	 * explicity requested.
+	 */
+	intc_out_be32(intc + IER, 0);
+
+	/* Acknowledge any pending interrupts just in case. */
+	intc_out_be32(intc + IAR, ~(u32) 0);
+
+	/* Turn on the Master Enable. */
+	intc_out_be32(intc + MER, 0x3UL);
+
+	ppc4xx_pic = &xilinx_intc;
+	ppc_md.get_irq = xilinx_pic_get_irq;
+}
diff -Naur linux-2.5.base/include/asm-ppc/ibm4xx.h linux-2.5.current/include/asm-ppc/ibm4xx.h
--- linux-2.5.base/include/asm-ppc/ibm4xx.h	2004-10-08 17:04:20.000000000 +0400
+++ linux-2.5.current/include/asm-ppc/ibm4xx.h	2004-10-08 17:47:59.000000000 +0400
@@ -59,6 +59,10 @@
 #include <platforms/4xx/walnut.h>
 #endif
 
+#if defined(CONFIG_XILINX_ML300)
+#include <platforms/4xx/xilinx_ml300.h>
+#endif
+
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_40x
diff -Naur linux-2.5.base/include/asm-ppc/xparameters.h linux-2.5.current/include/asm-ppc/xparameters.h
--- linux-2.5.base/include/asm-ppc/xparameters.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.5.current/include/asm-ppc/xparameters.h	2004-10-08 17:47:59.000000000 +0400
@@ -0,0 +1,18 @@
+/*
+ * include/asm-ppc/xparameters.h
+ *
+ * This file includes the correct xparameters.h for the CONFIG'ed board
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2004 (c) MontaVista Software, Inc.  This file is licensed under the terms
+ * of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+
+#if defined(CONFIG_XILINX_ML300)
+#include <platforms/4xx/xparameters/xparameters_ml300.h>
+#endif

--------------050007060703020803010405--

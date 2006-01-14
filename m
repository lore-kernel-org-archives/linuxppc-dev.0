Return-Path: <grant@secretlab.ca>
Received: from localhost (S0106001346b91f0f.cg.shawcable.net [68.147.210.21])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EE17689EF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jan 2006 21:32:35 +1100 (EST)
Date: Sat, 14 Jan 2006 02:48:16 -0700
From: "Grant C. Likely" <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org, mporter@kernel.crashing.org,
	glikely@gmail.com
Subject: [PATCH 02/10] Make Virtex-II Pro support generic for all Virtex
	devices
Message-ID: <20060114094816.GA12726@secretlab.ca>
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

The PPC405 hard core is used in both the Virtex-II Pro and Virtex 4 FX
FPGAs.  This patch cleans up the Virtex naming convention to reflect more
than just the Virtex-II Pro.

Rename files virtex-ii_pro.[ch] to virtex.[ch]
Rename config value VIRTEX_II_PRO to XILINX_VIRTEX

Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>

---

 arch/ppc/platforms/4xx/Kconfig         |    2 -
 arch/ppc/platforms/4xx/Makefile        |    2 -
 arch/ppc/platforms/4xx/virtex-ii_pro.c |   60 -------------------
 arch/ppc/platforms/4xx/virtex-ii_pro.h |   99 --------------------------------
 arch/ppc/platforms/4xx/virtex.c        |   60 +++++++++++++++++++
 arch/ppc/platforms/4xx/virtex.h        |   99 ++++++++++++++++++++++++++++++++
 arch/ppc/platforms/4xx/xilinx_ml300.c  |    2 -
 arch/ppc/platforms/4xx/xilinx_ml300.h  |    2 -
 arch/ppc/syslib/Makefile               |    2 -
 9 files changed, 164 insertions(+), 164 deletions(-)
 delete mode 100644 arch/ppc/platforms/4xx/virtex-ii_pro.c
 delete mode 100644 arch/ppc/platforms/4xx/virtex-ii_pro.h
 create mode 100644 arch/ppc/platforms/4xx/virtex.c
 create mode 100644 arch/ppc/platforms/4xx/virtex.h

d40e4910743dd1a103de9af79528eb715e2e13df
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index d883791..73d9bef 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -208,7 +208,7 @@ config 405GPR
 	depends on SYCAMORE
 	default y
 
-config VIRTEX_II_PRO
+config XILINX_VIRTEX
 	bool
 	depends on XILINX_ML300
 	default y
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
index c9bb611..be4163c 100644
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -26,4 +26,4 @@ obj-$(CONFIG_440SP)		+= ibm440sp.o
 obj-$(CONFIG_440SPE)		+= ppc440spe.o
 obj-$(CONFIG_405EP)		+= ibm405ep.o
 obj-$(CONFIG_405GPR)		+= ibm405gpr.o
-obj-$(CONFIG_VIRTEX_II_PRO)	+= virtex-ii_pro.o
+obj-$(CONFIG_XILINX_VIRTEX)	+= virtex.o
diff --git a/arch/ppc/platforms/4xx/virtex-ii_pro.c b/arch/ppc/platforms/4xx/virtex-ii_pro.c
deleted file mode 100644
index 097cc9d..0000000
--- a/arch/ppc/platforms/4xx/virtex-ii_pro.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * arch/ppc/platforms/4xx/virtex-ii_pro.c
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
- * terms of the GNU General Public License version 2.  This program is licensed
- * "as is" without any warranty of any kind, whether express or implied.
- */
-
-#include <linux/config.h>
-#include <linux/init.h>
-#include <asm/ocp.h>
-#include "virtex-ii_pro.h"
-
-/* Have OCP take care of the serial ports. */
-struct ocp_def core_ocp[] = {
-#ifdef XPAR_UARTNS550_0_BASEADDR
-	{ .vendor	= OCP_VENDOR_XILINX,
-	  .function	= OCP_FUNC_16550,
-	  .index	= 0,
-	  .paddr	= XPAR_UARTNS550_0_BASEADDR,
-	  .irq		= XPAR_INTC_0_UARTNS550_0_VEC_ID,
-	  .pm		= OCP_CPM_NA
-	},
-#ifdef XPAR_UARTNS550_1_BASEADDR
-	{ .vendor	= OCP_VENDOR_XILINX,
-	  .function	= OCP_FUNC_16550,
-	  .index	= 1,
-	  .paddr	= XPAR_UARTNS550_1_BASEADDR,
-	  .irq		= XPAR_INTC_0_UARTNS550_1_VEC_ID,
-	  .pm		= OCP_CPM_NA
-	},
-#ifdef XPAR_UARTNS550_2_BASEADDR
-	{ .vendor	= OCP_VENDOR_XILINX,
-	  .function	= OCP_FUNC_16550,
-	  .index	= 2,
-	  .paddr	= XPAR_UARTNS550_2_BASEADDR,
-	  .irq		= XPAR_INTC_0_UARTNS550_2_VEC_ID,
-	  .pm		= OCP_CPM_NA
-	},
-#ifdef XPAR_UARTNS550_3_BASEADDR
-	{ .vendor	= OCP_VENDOR_XILINX,
-	  .function	= OCP_FUNC_16550,
-	  .index	= 3,
-	  .paddr	= XPAR_UARTNS550_3_BASEADDR,
-	  .irq		= XPAR_INTC_0_UARTNS550_3_VEC_ID,
-	  .pm		= OCP_CPM_NA
-	},
-#ifdef XPAR_UARTNS550_4_BASEADDR
-#error Edit this file to add more devices.
-#endif			/* 4 */
-#endif			/* 3 */
-#endif			/* 2 */
-#endif			/* 1 */
-#endif			/* 0 */
-	{ .vendor	= OCP_VENDOR_INVALID
-	}
-};
diff --git a/arch/ppc/platforms/4xx/virtex-ii_pro.h b/arch/ppc/platforms/4xx/virtex-ii_pro.h
deleted file mode 100644
index 026130c..0000000
--- a/arch/ppc/platforms/4xx/virtex-ii_pro.h
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- * arch/ppc/platforms/4xx/virtex-ii_pro.h
- *
- * Include file that defines the Xilinx Virtex-II Pro processor
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
- * terms of the GNU General Public License version 2.  This program is licensed
- * "as is" without any warranty of any kind, whether express or implied.
- */
-
-#ifdef __KERNEL__
-#ifndef __ASM_VIRTEXIIPRO_H__
-#define __ASM_VIRTEXIIPRO_H__
-
-#include <linux/config.h>
-#include <platforms/4xx/xparameters/xparameters.h>
-
-/* serial defines */
-
-#define RS_TABLE_SIZE  4	/* change this and add more devices below
-				   if you have more then 4 16x50 UARTs */
-
-#define BASE_BAUD		(XPAR_UARTNS550_0_CLOCK_FREQ_HZ/16)
-
-/* The serial ports in the Virtex-II Pro have each I/O byte in the
- * LSByte of a word.  This means that iomem_reg_shift needs to be 2 to
- * change the byte offsets into word offsets.  In addition the base
- * addresses need to have 3 added to them to get to the LSByte.
- */
-#define STD_UART_OP(num)						 \
-	{ 0, BASE_BAUD, 0, XPAR_INTC_0_UARTNS550_##num##_VEC_ID,	 \
-		ASYNC_BOOT_AUTOCONF,		 			 \
-		.iomem_base = (u8 *)XPAR_UARTNS550_##num##_BASEADDR + 3, \
-		.iomem_reg_shift = 2,					 \
-		.io_type = SERIAL_IO_MEM},
-
-#if defined(XPAR_INTC_0_UARTNS550_0_VEC_ID)
-#define ML300_UART0 STD_UART_OP(0)
-#else
-#define ML300_UART0
-#endif
-
-#if defined(XPAR_INTC_0_UARTNS550_1_VEC_ID)
-#define ML300_UART1 STD_UART_OP(1)
-#else
-#define ML300_UART1
-#endif
-
-#if defined(XPAR_INTC_0_UARTNS550_2_VEC_ID)
-#define ML300_UART2 STD_UART_OP(2)
-#else
-#define ML300_UART2
-#endif
-
-#if defined(XPAR_INTC_0_UARTNS550_3_VEC_ID)
-#define ML300_UART3 STD_UART_OP(3)
-#else
-#define ML300_UART3
-#endif
-
-#if defined(XPAR_INTC_0_UARTNS550_4_VEC_ID)
-#error Edit this file to add more devices.
-#elif defined(XPAR_INTC_0_UARTNS550_3_VEC_ID)
-#define NR_SER_PORTS	4
-#elif defined(XPAR_INTC_0_UARTNS550_2_VEC_ID)
-#define NR_SER_PORTS	3
-#elif defined(XPAR_INTC_0_UARTNS550_1_VEC_ID)
-#define NR_SER_PORTS	2
-#elif defined(XPAR_INTC_0_UARTNS550_0_VEC_ID)
-#define NR_SER_PORTS	1
-#else
-#define NR_SER_PORTS	0
-#endif
-
-#if defined(CONFIG_UART0_TTYS0)
-#define SERIAL_PORT_DFNS	\
-	ML300_UART0		\
-	ML300_UART1		\
-	ML300_UART2		\
-	ML300_UART3
-#endif
-
-#if defined(CONFIG_UART0_TTYS1)
-#define SERIAL_PORT_DFNS	\
-	ML300_UART1		\
-	ML300_UART0		\
-	ML300_UART2		\
-	ML300_UART3
-#endif
-
-#define DCRN_CPMFR_BASE	0
-
-#include <asm/ibm405.h>
-
-#endif				/* __ASM_VIRTEXIIPRO_H__ */
-#endif				/* __KERNEL__ */
diff --git a/arch/ppc/platforms/4xx/virtex.c b/arch/ppc/platforms/4xx/virtex.c
new file mode 100644
index 0000000..bbb12c0
--- /dev/null
+++ b/arch/ppc/platforms/4xx/virtex.c
@@ -0,0 +1,60 @@
+/*
+ * arch/ppc/platforms/4xx/virtex.c
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
+#include <platforms/4xx/virtex.h>
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
diff --git a/arch/ppc/platforms/4xx/virtex.h b/arch/ppc/platforms/4xx/virtex.h
new file mode 100644
index 0000000..049c767
--- /dev/null
+++ b/arch/ppc/platforms/4xx/virtex.h
@@ -0,0 +1,99 @@
+/*
+ * arch/ppc/platforms/4xx/virtex.h
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
+#ifndef __ASM_VIRTEX_H__
+#define __ASM_VIRTEX_H__
+
+#include <linux/config.h>
+#include <platforms/4xx/xparameters/xparameters.h>
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
+#endif				/* __ASM_VIRTEX_H__ */
+#endif				/* __KERNEL__ */
diff --git a/arch/ppc/platforms/4xx/xilinx_ml300.c b/arch/ppc/platforms/4xx/xilinx_ml300.c
index 0b1b77d..b0de0a2 100644
--- a/arch/ppc/platforms/4xx/xilinx_ml300.c
+++ b/arch/ppc/platforms/4xx/xilinx_ml300.c
@@ -22,7 +22,7 @@
 #include <asm/machdep.h>
 #include <asm/ocp.h>
 
-#include <platforms/4xx/virtex-ii_pro.h>	/* for NR_SER_PORTS */
+#include <platforms/4xx/virtex.h>	/* for NR_SER_PORTS */
 
 /*
  * As an overview of how the following functions (platform_init,
diff --git a/arch/ppc/platforms/4xx/xilinx_ml300.h b/arch/ppc/platforms/4xx/xilinx_ml300.h
index f8c5884..8993981 100644
--- a/arch/ppc/platforms/4xx/xilinx_ml300.h
+++ b/arch/ppc/platforms/4xx/xilinx_ml300.h
@@ -16,7 +16,7 @@
 #define __ASM_XILINX_ML300_H__
 
 /* ML300 has a Xilinx Virtex-II Pro processor */
-#include <platforms/4xx/virtex-ii_pro.h>
+#include <platforms/4xx/virtex.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index 84ef030..dc75f6e 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_440GX)		+= ibm440gx_common.
 obj-$(CONFIG_440SP)		+= ibm440gx_common.o ibm440sp_common.o
 obj-$(CONFIG_440SPE)		+= ibm440gx_common.o ibm440sp_common.o ppc440spe_pcie.o
 ifeq ($(CONFIG_4xx),y)
-ifeq ($(CONFIG_VIRTEX_II_PRO),y)
+ifeq ($(CONFIG_XILINX_VIRTEX),y)
 obj-$(CONFIG_40x)		+= xilinx_pic.o
 else
 ifeq ($(CONFIG_403),y)
-- 
1.1.2-g9e9b-dirty

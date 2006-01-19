Return-Path: <grant@secretlab.ca>
Received: from localhost.secretlab.ca (S0106001346b91f0f.cg.shawcable.net
	[68.147.210.21]) by ozlabs.org (Postfix) with ESMTP id 77D0568A03
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jan 2006 19:12:49 +1100 (EST)
Date: Thu, 19 Jan 2006 01:12:48 -0700
From: "Grant C. Likely" <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org, akonovalov@ru.mvista.com,
	peter.ryser@xilinx.com
Subject: [PATCH 3/9] Migrate Xilinx Vertex support from the OCP bus to the
	platfom bus.
Message-ID: <20060119081248.GA24901@weasley-twins.secretlab.ca>
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

This patch only deals with the serial port definitions as there is no
support for any other xilinx IP cores in the kernel tree at the moment.

Board specific configuration moved out of virtex.[ch] and into the
xparameters.h wrapper.

This also prepares for the transition to the flattened device tree model.
When the bootloader provides a device tree generated from an xparameters.h
files, the kernel will no longer need xparameters/*.  The platform bus will
get populated with data from the device tree, and the device drivers will
be automatically connected to the devices.  Only the bootloader (or
ppcboot) will need xparameters directly.

Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>

---

 arch/ppc/boot/common/ns16550.c                   |    3 +
 arch/ppc/boot/simple/embed_config.c              |    3 +
 arch/ppc/platforms/4xx/Kconfig                   |    5 -
 arch/ppc/platforms/4xx/virtex.c                  |   88 +++++++++++-----------
 arch/ppc/platforms/4xx/virtex.h                  |   88 +++-------------------
 arch/ppc/platforms/4xx/xparameters/xparameters.h |   21 +++++
 include/asm-ppc/ppc_sys.h                        |    2 +
 7 files changed, 81 insertions(+), 129 deletions(-)

8b0b2cd17462813c6c5edb11ef1ea9f7370ac4ed
diff --git a/arch/ppc/boot/common/ns16550.c b/arch/ppc/boot/common/ns16550.c
index 26818bb..4f00c93 100644
--- a/arch/ppc/boot/common/ns16550.c
+++ b/arch/ppc/boot/common/ns16550.c
@@ -8,6 +8,9 @@
 #include <linux/serial_reg.h>
 #include <asm/serial.h>
 
+#if defined(CONFIG_XILINX_VIRTEX)
+#include <platforms/4xx/xparameters/xparameters.h>
+#endif
 #include "nonstdio.h"
 #include "serial.h"
 
diff --git a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
index 491a691..df24202 100644
--- a/arch/ppc/boot/simple/embed_config.c
+++ b/arch/ppc/boot/simple/embed_config.c
@@ -21,6 +21,9 @@
 #ifdef CONFIG_40x
 #include <asm/io.h>
 #endif
+#ifdef CONFIG_XILINX_VIRTEX
+#include <platforms/4xx/xparameters/xparameters.h>
+#endif
 extern unsigned long timebase_period_ns;
 
 /* For those boards that don't provide one.
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 203abab..057c7c2 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -172,11 +172,6 @@ config IBM_OCP
 	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || YUCCA || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
 	default y
 
-config XILINX_OCP
-	bool
-	depends on XILINX_ML300
-	default y
-
 config IBM_EMAC4
 	bool
 	depends on 440GX || 440SP || 440SPE
diff --git a/arch/ppc/platforms/4xx/virtex.c b/arch/ppc/platforms/4xx/virtex.c
index bbb12c0..133a831 100644
--- a/arch/ppc/platforms/4xx/virtex.c
+++ b/arch/ppc/platforms/4xx/virtex.c
@@ -1,60 +1,56 @@
 /*
- * arch/ppc/platforms/4xx/virtex.c
+ * Virtex-II Pro & Virtex-4 FX common infrastructure
  *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
+ * Maintainer: Grant Likely <grant.likely@secretlab.ca>
  *
- * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
- * terms of the GNU General Public License version 2.  This program is licensed
- * "as is" without any warranty of any kind, whether express or implied.
+ * Copyright 2005 Secret Lab Technologies Ltd.
+ * Copyright 2005 General Dynamics Canada Ltd.
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
  */
 
-#include <linux/config.h>
 #include <linux/init.h>
-#include <asm/ocp.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/serial_8250.h>
+#include <asm/ppc_sys.h>
 #include <platforms/4xx/virtex.h>
+#include <platforms/4xx/xparameters/xparameters.h>
+
+#define XPAR_UART(num) { \
+		.mapbase  = XPAR_UARTNS550_##num##_BASEADDR + 3, \
+		.irq	  = XPAR_INTC_0_UARTNS550_##num##_VEC_ID, \
+		.iotype	  = UPIO_MEM, \
+		.uartclk  = XPAR_UARTNS550_##num##_CLOCK_FREQ_HZ, \
+		.flags	  = UPF_BOOT_AUTOCONF, \
+		.regshift = 2, \
+	}
 
-/* Have OCP take care of the serial ports. */
-struct ocp_def core_ocp[] = {
+struct plat_serial8250_port serial_platform_data[] = {
 #ifdef XPAR_UARTNS550_0_BASEADDR
-	{ .vendor	= OCP_VENDOR_XILINX,
-	  .function	= OCP_FUNC_16550,
-	  .index	= 0,
-	  .paddr	= XPAR_UARTNS550_0_BASEADDR,
-	  .irq		= XPAR_INTC_0_UARTNS550_0_VEC_ID,
-	  .pm		= OCP_CPM_NA
-	},
+	XPAR_UART(0),
+#endif
 #ifdef XPAR_UARTNS550_1_BASEADDR
-	{ .vendor	= OCP_VENDOR_XILINX,
-	  .function	= OCP_FUNC_16550,
-	  .index	= 1,
-	  .paddr	= XPAR_UARTNS550_1_BASEADDR,
-	  .irq		= XPAR_INTC_0_UARTNS550_1_VEC_ID,
-	  .pm		= OCP_CPM_NA
-	},
+	XPAR_UART(1),
+#endif
 #ifdef XPAR_UARTNS550_2_BASEADDR
-	{ .vendor	= OCP_VENDOR_XILINX,
-	  .function	= OCP_FUNC_16550,
-	  .index	= 2,
-	  .paddr	= XPAR_UARTNS550_2_BASEADDR,
-	  .irq		= XPAR_INTC_0_UARTNS550_2_VEC_ID,
-	  .pm		= OCP_CPM_NA
-	},
+	XPAR_UART(2),
+#endif
 #ifdef XPAR_UARTNS550_3_BASEADDR
-	{ .vendor	= OCP_VENDOR_XILINX,
-	  .function	= OCP_FUNC_16550,
-	  .index	= 3,
-	  .paddr	= XPAR_UARTNS550_3_BASEADDR,
-	  .irq		= XPAR_INTC_0_UARTNS550_3_VEC_ID,
-	  .pm		= OCP_CPM_NA
+	XPAR_UART(3),
+#endif
+	{ }, /* terminated by empty record */
+};
+
+struct platform_device ppc_sys_platform_devices[] = {
+	[VIRTEX_UART] = {
+		.name		= "serial8250",
+		.id		= 0,
+		.dev.platform_data = serial_platform_data,
 	},
-#ifdef XPAR_UARTNS550_4_BASEADDR
-#error Edit this file to add more devices.
-#endif			/* 4 */
-#endif			/* 3 */
-#endif			/* 2 */
-#endif			/* 1 */
-#endif			/* 0 */
-	{ .vendor	= OCP_VENDOR_INVALID
-	}
 };
+
diff --git a/arch/ppc/platforms/4xx/virtex.h b/arch/ppc/platforms/4xx/virtex.h
index 049c767..1a01b81 100644
--- a/arch/ppc/platforms/4xx/virtex.h
+++ b/arch/ppc/platforms/4xx/virtex.h
@@ -15,85 +15,21 @@
 #ifndef __ASM_VIRTEX_H__
 #define __ASM_VIRTEX_H__
 
-#include <linux/config.h>
-#include <platforms/4xx/xparameters/xparameters.h>
-
 /* serial defines */
 
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
 #include <asm/ibm405.h>
 
+/* Ugly, ugly, ugly! BASE_BAUD defined here to keep 8250.c happy. */
+#if !defined(BASE_BAUD)
+ #define BASE_BAUD		(0) /* dummy value; not used */
+#endif
+  
+/* Device type enumeration for platform bus definitions */
+#ifndef __ASSEMBLY__
+enum ppc_sys_devices {
+	VIRTEX_UART,
+};
+#endif
+  
 #endif				/* __ASM_VIRTEX_H__ */
 #endif				/* __KERNEL__ */
diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters.h b/arch/ppc/platforms/4xx/xparameters/xparameters.h
index fe4eac6..7b73043 100644
--- a/arch/ppc/platforms/4xx/xparameters/xparameters.h
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters.h
@@ -1,7 +1,8 @@
 /*
  * include/asm-ppc/xparameters.h
  *
- * This file includes the correct xparameters.h for the CONFIG'ed board
+ * This file includes the correct xparameters.h for the CONFIG'ed board plus
+ * fixups to translate board specific XPAR values to a common set of names
  *
  * Author: MontaVista Software, Inc.
  *         source@mvista.com
@@ -14,5 +15,21 @@
 #include <linux/config.h>
 
 #if defined(CONFIG_XILINX_ML300)
-#include <platforms/4xx/xparameters/xparameters_ml300.h>
+  #include "xparameters_ml300.h"
+#else
+  /* Add other board xparameter includes here before the #else */
+  #error No xparameters_*.h file included
+#endif
+
+#ifndef SERIAL_PORT_DFNS
+  /* zImage serial port definitions */
+  #define RS_TABLE_SIZE 1
+  #define SERIAL_PORT_DFNS {						\
+	.baud_base	 = XPAR_UARTNS550_0_CLOCK_FREQ_HZ/16,		\
+	.irq		 = XPAR_INTC_0_UARTNS550_0_VEC_ID,		\
+	.flags		 = ASYNC_BOOT_AUTOCONF,				\
+	.iomem_base	 = (u8 *)XPAR_UARTNS550_0_BASEADDR + 3,		\
+	.iomem_reg_shift = 2,						\
+	.io_type	 = SERIAL_IO_MEM,				\
+  },
 #endif
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
index 83d8c77..bdc4dde 100644
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -33,6 +33,8 @@
 #include <asm/mpc52xx.h>
 #elif defined(CONFIG_MPC10X_BRIDGE)
 #include <asm/mpc10x.h>
+#elif defined(CONFIG_XILINX_VIRTEX)
+#include <platforms/4xx/virtex.h>
 #else
 #error "need definition of ppc_sys_devices"
 #endif
-- 
1.1.GIT

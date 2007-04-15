Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id 3E5DADE041
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Apr 2007 17:28:16 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org, Andrei Konovalov <akonovalov@ru.mvista.com>,
	Peter Korsgaard <jacmet@sunsite.dk>,
	Rick Moleres <Rick.Moleres@xilinx.com>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/5] [PPC] Stop using ppc_sys for Xilinx Virtex boards
Date: Sun, 15 Apr 2007 01:27:41 -0600
Message-Id: <11766220702647-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1176622070387-git-send-email-grant.likely@secretlab.ca>
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
	<11766220693636-git-send-email-grant.likely@secretlab.ca>
	<1176622070387-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The arch/ppc/syslib/ppc_sys.c infrastructure does not work well for the
virtex ports.  Move the ml300 and ml403 board ports over to use the new
virtex_devices infrastructure.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/ppc/platforms/4xx/Makefile       |    1 -
 arch/ppc/platforms/4xx/virtex.c       |   56 ----------------------------
 arch/ppc/platforms/4xx/virtex.h       |    7 +---
 arch/ppc/platforms/4xx/xilinx_ml300.c |   64 ++------------------------------
 arch/ppc/platforms/4xx/xilinx_ml403.c |   65 ++-------------------------------
 arch/ppc/syslib/Makefile              |    3 +-
 include/asm-ppc/ppc_sys.h             |    2 -
 7 files changed, 11 insertions(+), 187 deletions(-)
 delete mode 100644 arch/ppc/platforms/4xx/virtex.c

diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
index fa6610b..723ad79 100644
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -28,5 +28,4 @@ obj-$(CONFIG_440SP)		+= ibm440sp.o
 obj-$(CONFIG_440SPE)		+= ppc440spe.o
 obj-$(CONFIG_405EP)		+= ibm405ep.o
 obj-$(CONFIG_405GPR)		+= ibm405gpr.o
-obj-$(CONFIG_XILINX_VIRTEX)	+= virtex.o
 
diff --git a/arch/ppc/platforms/4xx/virtex.c b/arch/ppc/platforms/4xx/virtex.c
deleted file mode 100644
index 133a831..0000000
--- a/arch/ppc/platforms/4xx/virtex.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * Virtex-II Pro & Virtex-4 FX common infrastructure
- *
- * Maintainer: Grant Likely <grant.likely@secretlab.ca>
- *
- * Copyright 2005 Secret Lab Technologies Ltd.
- * Copyright 2005 General Dynamics Canada Ltd.
- * Copyright 2005 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/serial_8250.h>
-#include <asm/ppc_sys.h>
-#include <platforms/4xx/virtex.h>
-#include <platforms/4xx/xparameters/xparameters.h>
-
-#define XPAR_UART(num) { \
-		.mapbase  = XPAR_UARTNS550_##num##_BASEADDR + 3, \
-		.irq	  = XPAR_INTC_0_UARTNS550_##num##_VEC_ID, \
-		.iotype	  = UPIO_MEM, \
-		.uartclk  = XPAR_UARTNS550_##num##_CLOCK_FREQ_HZ, \
-		.flags	  = UPF_BOOT_AUTOCONF, \
-		.regshift = 2, \
-	}
-
-struct plat_serial8250_port serial_platform_data[] = {
-#ifdef XPAR_UARTNS550_0_BASEADDR
-	XPAR_UART(0),
-#endif
-#ifdef XPAR_UARTNS550_1_BASEADDR
-	XPAR_UART(1),
-#endif
-#ifdef XPAR_UARTNS550_2_BASEADDR
-	XPAR_UART(2),
-#endif
-#ifdef XPAR_UARTNS550_3_BASEADDR
-	XPAR_UART(3),
-#endif
-	{ }, /* terminated by empty record */
-};
-
-struct platform_device ppc_sys_platform_devices[] = {
-	[VIRTEX_UART] = {
-		.name		= "serial8250",
-		.id		= 0,
-		.dev.platform_data = serial_platform_data,
-	},
-};
-
diff --git a/arch/ppc/platforms/4xx/virtex.h b/arch/ppc/platforms/4xx/virtex.h
index e9f58a7..4fc76da 100644
--- a/arch/ppc/platforms/4xx/virtex.h
+++ b/arch/ppc/platforms/4xx/virtex.h
@@ -19,13 +19,8 @@
 #if !defined(BASE_BAUD)
  #define BASE_BAUD		(0) /* dummy value; not used */
 #endif
-  
-/* Device type enumeration for platform bus definitions */
+
 #ifndef __ASSEMBLY__
-enum ppc_sys_devices {
-	VIRTEX_UART, NUM_PPC_SYS_DEVS,
-};
-  
 typedef struct board_info {
 	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
 	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
diff --git a/arch/ppc/platforms/4xx/xilinx_ml300.c b/arch/ppc/platforms/4xx/xilinx_ml300.c
index 4e4aca4..6e522fe 100644
--- a/arch/ppc/platforms/4xx/xilinx_ml300.c
+++ b/arch/ppc/platforms/4xx/xilinx_ml300.c
@@ -18,9 +18,9 @@
 #include <linux/serialP.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/ppc_sys.h>
 
 #include <syslib/gen550.h>
+#include <syslib/virtex_devices.h>
 #include <platforms/4xx/xparameters/xparameters.h>
 
 /*
@@ -53,25 +53,9 @@
  *          ppc4xx_pic_init			arch/ppc/syslib/xilinx_pic.c
  */
 
-/* Board specifications structures */
-struct ppc_sys_spec *cur_ppc_sys_spec;
-struct ppc_sys_spec ppc_sys_specs[] = {
-	{
-		/* Only one entry, always assume the same design */
-		.ppc_sys_name	= "Xilinx ML300 Reference Design",
-		.mask 		= 0x00000000,
-		.value 		= 0x00000000,
-		.num_devices	= 1,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			VIRTEX_UART,
-		},
-	},
-};
 const char* virtex_machine_name = "ML300 Reference Design";
 
 #if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
-
 static volatile unsigned *powerdown_base =
     (volatile unsigned *) XPAR_POWER_0_POWERDOWN_BASEADDR;
 
@@ -96,52 +80,14 @@ ml300_map_io(void)
 #endif
 }
 
-/* Early serial support functions */
-static void __init
-ml300_early_serial_init(int num, struct plat_serial8250_port *pdata)
-{
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
-	struct uart_port serial_req;
-
-	memset(&serial_req, 0, sizeof(serial_req));
-	serial_req.mapbase	= pdata->mapbase;
-	serial_req.membase	= pdata->membase;
-	serial_req.irq		= pdata->irq;
-	serial_req.uartclk	= pdata->uartclk;
-	serial_req.regshift	= pdata->regshift;
-	serial_req.iotype	= pdata->iotype;
-	serial_req.flags	= pdata->flags;
-	gen550_init(num, &serial_req);
-#endif
-}
-
-void __init
-ml300_early_serial_map(void)
-{
-#ifdef CONFIG_SERIAL_8250
-	struct plat_serial8250_port *pdata;
-	int i = 0;
-
-	pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(VIRTEX_UART);
-	while(pdata && pdata->flags)
-	{
-		pdata->membase = ioremap(pdata->mapbase, 0x100);
-		ml300_early_serial_init(i, pdata);
-		pdata++;
-		i++;
-	}
-#endif /* CONFIG_SERIAL_8250 */
-}
-
 void __init
 ml300_setup_arch(void)
 {
-	ml300_early_serial_map();
+	virtex_early_serial_map();
 	ppc4xx_setup_arch();	/* calls ppc4xx_find_bridges() */
 
 	/* Identify the system */
-	printk(KERN_INFO "Xilinx Virtex-II Pro port\n");
-	printk(KERN_INFO "Port by MontaVista Software, Inc. (source@mvista.com)\n");
+	printk(KERN_INFO "Xilinx ML300 Reference System (Virtex-II Pro)\n");
 }
 
 /* Called after board_setup_irq from ppc4xx_init_IRQ(). */
@@ -157,8 +103,6 @@ platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 {
 	ppc4xx_init(r3, r4, r5, r6, r7);
 
-	identify_ppc_sys_by_id(mfspr(SPRN_PVR));
-
 	ppc_md.setup_arch = ml300_setup_arch;
 	ppc_md.setup_io_mappings = ml300_map_io;
 	ppc_md.init_IRQ = ml300_init_irq;
@@ -168,7 +112,7 @@ platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 #endif
 
 #ifdef CONFIG_KGDB
-	ppc_md.early_serial_map = ml300_early_serial_map;
+	ppc_md.early_serial_map = virtex_early_serial_map;
 #endif
 }
 
diff --git a/arch/ppc/platforms/4xx/xilinx_ml403.c b/arch/ppc/platforms/4xx/xilinx_ml403.c
index c98e40a..bc3ace3 100644
--- a/arch/ppc/platforms/4xx/xilinx_ml403.c
+++ b/arch/ppc/platforms/4xx/xilinx_ml403.c
@@ -1,11 +1,9 @@
 /*
- * arch/ppc/platforms/4xx/xilinx_ml403.c
- *
  * Xilinx ML403 evaluation board initialization
  *
  * Author: Grant Likely <grant.likely@secretlab.ca>
  *
- * 2005 (c) Secret Lab Technologies Ltd.
+ * 2005-2007 (c) Secret Lab Technologies Ltd.
  * 2002-2004 (c) MontaVista Software, Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
@@ -22,9 +20,9 @@
 #include <linux/serialP.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/ppc_sys.h>
 
 #include <syslib/gen550.h>
+#include <syslib/virtex_devices.h>
 #include <platforms/4xx/xparameters/xparameters.h>
 
 /*
@@ -57,25 +55,9 @@
  *          ppc4xx_pic_init			arch/ppc/syslib/xilinx_pic.c
  */
 
-/* Board specifications structures */
-struct ppc_sys_spec *cur_ppc_sys_spec;
-struct ppc_sys_spec ppc_sys_specs[] = {
-	{
-		/* Only one entry, always assume the same design */
-		.ppc_sys_name	= "Xilinx ML403 Reference Design",
-		.mask 		= 0x00000000,
-		.value 		= 0x00000000,
-		.num_devices	= 1,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			VIRTEX_UART,
-		},
-	},
-};
 const char* virtex_machine_name = "ML403 Reference Design";
 
 #if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
-
 static volatile unsigned *powerdown_base =
     (volatile unsigned *) XPAR_POWER_0_POWERDOWN_BASEADDR;
 
@@ -100,47 +82,10 @@ ml403_map_io(void)
 #endif
 }
 
-/* Early serial support functions */
-static void __init
-ml403_early_serial_init(int num, struct plat_serial8250_port *pdata)
-{
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
-	struct uart_port serial_req;
-
-	memset(&serial_req, 0, sizeof(serial_req));
-	serial_req.mapbase	= pdata->mapbase;
-	serial_req.membase	= pdata->membase;
-	serial_req.irq		= pdata->irq;
-	serial_req.uartclk	= pdata->uartclk;
-	serial_req.regshift	= pdata->regshift;
-	serial_req.iotype	= pdata->iotype;
-	serial_req.flags	= pdata->flags;
-	gen550_init(num, &serial_req);
-#endif
-}
-
-void __init
-ml403_early_serial_map(void)
-{
-#ifdef CONFIG_SERIAL_8250
-	struct plat_serial8250_port *pdata;
-	int i = 0;
-
-	pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(VIRTEX_UART);
-	while(pdata && pdata->flags)
-	{
-		pdata->membase = ioremap(pdata->mapbase, 0x100);
-		ml403_early_serial_init(i, pdata);
-		pdata++;
-		i++;
-	}
-#endif /* CONFIG_SERIAL_8250 */
-}
-
 void __init
 ml403_setup_arch(void)
 {
-	ml403_early_serial_map();
+	virtex_early_serial_map();
 	ppc4xx_setup_arch();	/* calls ppc4xx_find_bridges() */
 
 	/* Identify the system */
@@ -160,8 +105,6 @@ platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 {
 	ppc4xx_init(r3, r4, r5, r6, r7);
 
-	identify_ppc_sys_by_id(mfspr(SPRN_PVR));
-
 	ppc_md.setup_arch = ml403_setup_arch;
 	ppc_md.setup_io_mappings = ml403_map_io;
 	ppc_md.init_IRQ = ml403_init_irq;
@@ -171,7 +114,7 @@ platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 #endif
 
 #ifdef CONFIG_KGDB
-	ppc_md.early_serial_map = ml403_early_serial_map;
+	ppc_md.early_serial_map = virtex_early_serial_map;
 #endif
 }
 
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index 0991111..9569415 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -18,7 +18,8 @@ obj-$(CONFIG_440SP)		+= ibm440gx_common.o ibm440sp_common.o
 obj-$(CONFIG_440SPE)		+= ibm440gx_common.o ibm440sp_common.o ppc440spe_pcie.o
 ifeq ($(CONFIG_4xx),y)
 ifeq ($(CONFIG_XILINX_VIRTEX),y)
-obj-$(CONFIG_40x)		+= xilinx_pic.o ppc_sys.o
+obj-$(CONFIG_40x)		+= xilinx_pic.o
+obj-y				+= virtex_devices.o
 else
 ifeq ($(CONFIG_403),y)
 obj-$(CONFIG_40x)		+= ppc403_pic.o
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
index 40f197a..de99e92 100644
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -33,8 +33,6 @@
 #include <asm/mpc52xx.h>
 #elif defined(CONFIG_MPC10X_BRIDGE)
 #include <asm/mpc10x.h>
-#elif defined(CONFIG_XILINX_VIRTEX)
-#include <platforms/4xx/virtex.h>
 #else
 #error "need definition of ppc_sys_devices"
 #endif
-- 
1.5.1

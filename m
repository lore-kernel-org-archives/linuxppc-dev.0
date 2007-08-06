Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound4-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 20666DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Aug 2007 08:56:48 +1000 (EST)
Received: from outbound4-fra.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound4-fra-R.bigfish.com (Postfix) with ESMTP id 643F38D8002
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 22:56:44 +0000 (UTC)
Received: from mail34-fra-R.bigfish.com (unknown [10.4.252.3])
	by outbound4-fra.bigfish.com (Postfix) with ESMTP id 5789B85009E
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 22:56:44 +0000 (UTC)
Received: from mail34-fra (localhost.localdomain [127.0.0.1])
	by mail34-fra-R.bigfish.com (Postfix) with ESMTP id 18A2C9C0108
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 22:56:44 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail34-fra.bigfish.com (Postfix) with ESMTP id 7D72A7B005B
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 22:56:42 +0000 (UTC)
Received: from unknown-38-66.xilinx.com
	([149.199.38.66] helo=xsj-smtp1.xilinx.com
	ident=[U2FsdGVkX19T+vHnBNXMa+1H19gop9/fsivGUhe/2Z0=])
	by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <wolfgang.reissnegger@xilinx.com>) id 1IIBVB-0001hF-RR
	for linuxppc-embedded@ozlabs.org; Mon, 06 Aug 2007 15:56:41 -0700
Date: Mon, 06 Aug 2007 15:57:25 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Consolidate XILINX_VIRTEX board support
Content-Type: multipart/mixed; boundary="------------000103000201010208040208"
Message-Id: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
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
--------------000103000201010208040208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Make support for Xilinx boards more generic, making it easier
to add new boards.  Add initial support for xupv2p and ml410 boards.

Thanks,
   Wolfgang

--------------000103000201010208040208
Content-Type: text/plain;
 name="[PATCH] Consolidate XILINX_VIRTEX board support.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] Consolidate XILINX_VIRTEX board support.txt"


Signed-off-by: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 arch/ppc/boot/simple/Makefile                      |    3 +-
 arch/ppc/boot/simple/embed_config.c                |    4 +-
 arch/ppc/platforms/4xx/Kconfig                     |   15 +
 arch/ppc/platforms/4xx/Makefile                    |    2 +
 arch/ppc/platforms/4xx/virtex.h                    |    9 +
 arch/ppc/platforms/4xx/xilinx_generic_ppc.c        |  129 ++++++++
 arch/ppc/platforms/4xx/xilinx_xupv2p.c             |   43 +++
 arch/ppc/platforms/4xx/xparameters/xparameters.h   |    4 +
 .../platforms/4xx/xparameters/xparameters_ml41x.h  |  277 +++++++++++++++++
 .../platforms/4xx/xparameters/xparameters_xupv2p.h |  327 ++++++++++++++++++++
 10 files changed, 809 insertions(+), 4 deletions(-)
 create mode 100644 arch/ppc/platforms/4xx/xilinx_generic_ppc.c
 create mode 100644 arch/ppc/platforms/4xx/xilinx_xupv2p.c
 create mode 100644 arch/ppc/platforms/4xx/xparameters/xparameters_ml41x.h
 create mode 100644 arch/ppc/platforms/4xx/xparameters/xparameters_xupv2p.h

diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
index 5b87779..05631fe 100644
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -187,8 +187,7 @@ boot-$(CONFIG_REDWOOD_6)	+= embed_config.o
 boot-$(CONFIG_8xx)		+= embed_config.o
 boot-$(CONFIG_8260)		+= embed_config.o
 boot-$(CONFIG_EP405)		+= embed_config.o
-boot-$(CONFIG_XILINX_ML300)	+= embed_config.o
-boot-$(CONFIG_XILINX_ML403)	+= embed_config.o
+boot-$(CONFIG_XILINX_VIRTEX)	+= embed_config.o
 boot-$(CONFIG_BSEIP)		+= iic.o
 boot-$(CONFIG_MBX)		+= iic.o pci.o qspan_pci.o
 boot-$(CONFIG_MV64X60)		+= misc-mv64x60.o
diff --git a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
index 840bff2..e0b8954 100644
--- a/arch/ppc/boot/simple/embed_config.c
+++ b/arch/ppc/boot/simple/embed_config.c
@@ -744,7 +744,7 @@ embed_config(bd_t **bdp)
 }
 #endif /* WILLOW */
 
-#if defined(CONFIG_XILINX_ML300) || defined(CONFIG_XILINX_ML403)
+#if defined(CONFIG_XILINX_VIRTEX)
 void
 embed_config(bd_t ** bdp)
 {
@@ -781,7 +781,7 @@ embed_config(bd_t ** bdp)
 	timebase_period_ns = 1000000000 / bd->bi_tbfreq;
 	/* see bi_tbfreq definition in arch/ppc/platforms/4xx/xilinx_ml300.h */
 }
-#endif /* CONFIG_XILINX_ML300 || CONFIG_XILINX_ML403 */
+#endif /* CONFIG_XILINX_VIRTEX */
 
 #ifdef CONFIG_IBM_OPENBIOS
 /* This could possibly work for all treeboot roms.
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index d7db7e4..56965cb 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -60,12 +60,27 @@ config XILINX_ML300
 	help
 	  This option enables support for the Xilinx ML300 evaluation board.
 
+config XILINX_XUPV2P
+	bool "Xilinx-XUPV2P"
+	select XILINX_VIRTEX_II_PRO
+	select EMBEDDEDBOOT
+	help
+	  This option enables support for the Xilinx University Program (XUP) Virtex 2 Pro board.
+
 config XILINX_ML403
 	bool "Xilinx-ML403"
 	select XILINX_VIRTEX_4_FX
 	select EMBEDDEDBOOT
 	help
 	  This option enables support for the Xilinx ML403 evaluation board.
+
+config XILINX_ML41x
+	bool "Xilinx-ML41x"
+	select XILINX_VIRTEX_4_FX
+	select EMBEDDEDBOOT
+	help
+	  This option enables support for the Xilinx ML410/411 evaluation boards.
+
 endchoice
 
 choice
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
index 723ad79..bcf1a63 100644
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -15,7 +15,9 @@ obj-$(CONFIG_SYCAMORE)		+= sycamore.o
 obj-$(CONFIG_TAISHAN)		+= taishan.o
 obj-$(CONFIG_WALNUT)		+= walnut.o
 obj-$(CONFIG_XILINX_ML300)	+= xilinx_ml300.o
+obj-$(CONFIG_XILINX_XUPV2P)	+= xilinx_generic_ppc.o xilinx_xupv2p.o
 obj-$(CONFIG_XILINX_ML403)	+= xilinx_ml403.o
+obj-$(CONFIG_XILINX_ML41x)	+= xilinx_generic_ppc.o
 
 obj-$(CONFIG_405GP)		+= ibm405gp.o
 obj-$(CONFIG_REDWOOD_5)		+= ibmstb4.o
diff --git a/arch/ppc/platforms/4xx/virtex.h b/arch/ppc/platforms/4xx/virtex.h
index 7382804..47f67b3 100644
--- a/arch/ppc/platforms/4xx/virtex.h
+++ b/arch/ppc/platforms/4xx/virtex.h
@@ -31,5 +31,14 @@ extern const char* virtex_machine_name;
 #define PPC4xx_ONB_IO_VADDR	0u
 #define PPC4xx_ONB_IO_SIZE	0u
 
+
+#if defined(CONFIG_XILINX_VIRTEX_II_PRO)
+#define XILINX_ARCH "Virtex-II Pro"
+#elif defined(CONFIG_XILINX_VIRTEX_4_FX)
+#define XILINX_ARCH "Virtex-4 FX"
+#else
+#error "No Xilinx Architecture recognized."
+#endif
+
 #endif				/* __ASM_VIRTEX_H__ */
 #endif				/* __KERNEL__ */
diff --git a/arch/ppc/platforms/4xx/xilinx_generic_ppc.c b/arch/ppc/platforms/4xx/xilinx_generic_ppc.c
new file mode 100644
index 0000000..103e762
--- /dev/null
+++ b/arch/ppc/platforms/4xx/xilinx_generic_ppc.c
@@ -0,0 +1,129 @@
+/*
+ * Xilinx Generic PPC evaluation board initialization
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+#include <linux/serialP.h>
+#include <linux/io.h>
+#include <asm/machdep.h>
+
+#include <syslib/gen550.h>
+#include <syslib/virtex_devices.h>
+#include <platforms/4xx/xparameters/xparameters.h>
+
+/*
+ * As an overview of how the following functions (platform_init,
+ * xilinx_generic_ppc_map_io, xilinx_generic_ppc_setup_arch and xilinx_generic_ppc_init_IRQ) fit into the
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
+ *    *ppc_md.setup_io_mappings == xilinx_generic_ppc_map_io	this file
+ *      ppc4xx_map_io				arch/ppc/syslib/ppc4xx_setup.c
+ *  start_kernel				init/main.c
+ *    setup_arch				arch/ppc/kernel/setup.c
+ * #if defined(CONFIG_KGDB)
+ *      *ppc_md.kgdb_map_scc() == gen550_kgdb_map_scc
+ * #endif
+ *      *ppc_md.setup_arch == xilinx_generic_ppc_setup_arch	this file
+ *        ppc4xx_setup_arch			arch/ppc/syslib/ppc4xx_setup.c
+ *          ppc4xx_find_bridges			arch/ppc/syslib/ppc405_pci.c
+ *    init_IRQ					arch/ppc/kernel/irq.c
+ *      *ppc_md.init_IRQ == xilinx_generic_ppc_init_IRQ	this file
+ *        ppc4xx_init_IRQ			arch/ppc/syslib/ppc4xx_setup.c
+ *          ppc4xx_pic_init			arch/ppc/syslib/xilinx_pic.c
+ */
+
+#if defined(CONFIG_XILINX_ML300)
+const char *virtex_machine_name = "Xilinx ML300";
+#elif defined(CONFIG_XILINX_XUPV2P)
+const char *virtex_machine_name = "Xilinx XUPV2P";
+#elif defined(CONFIG_XILINX_ML40x)
+const char *virtex_machine_name = "Xilinx ML40x";
+#elif defined(CONFIG_XILINX_ML41x)
+const char *virtex_machine_name = "Xilinx ML41x";
+#else
+const char *virtex_machine_name = "Unknown Xilinx with PowerPC";
+#endif
+
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
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
+xilinx_generic_ppc_map_io(void)
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
+void __init
+xilinx_generic_ppc_setup_arch(void)
+{
+	virtex_early_serial_map();
+	ppc4xx_setup_arch();	/* calls ppc4xx_find_bridges() */
+
+	/* Identify the system */
+	printk(KERN_INFO "Xilinx Generic PowerPC board support package (%s) (%s)\n", PPC4xx_MACHINE_NAME, XILINX_ARCH);
+}
+
+/* Called after board_setup_irq from ppc4xx_init_IRQ(). */
+void __init
+xilinx_generic_ppc_init_irq(void)
+{
+	ppc4xx_init_IRQ();
+}
+
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	 unsigned long r6, unsigned long r7)
+{
+	ppc4xx_init(r3, r4, r5, r6, r7);
+
+	ppc_md.setup_arch = xilinx_generic_ppc_setup_arch;
+	ppc_md.setup_io_mappings = xilinx_generic_ppc_map_io;
+	ppc_md.init_IRQ = xilinx_generic_ppc_init_irq;
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+	ppc_md.power_off = xilinx_power_off;
+#endif
+
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = virtex_early_serial_map;
+#endif
+}
+
diff --git a/arch/ppc/platforms/4xx/xilinx_xupv2p.c b/arch/ppc/platforms/4xx/xilinx_xupv2p.c
new file mode 100644
index 0000000..aa2d890
--- /dev/null
+++ b/arch/ppc/platforms/4xx/xilinx_xupv2p.c
@@ -0,0 +1,43 @@
+/*
+ * Xilinx XUPV2P board initialization
+ *
+ * Author: Stephen.Neuendorffer@xilinx.com
+ *
+ * 2007 (c) Xilinx, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/xilinx_devices.h>
+#include <platforms/4xx/xparameters/xparameters.h>
+
+int virtex_device_fixup(struct platform_device *dev)
+{
+ int i;
+#ifdef XPAR_ONEWIRE_0_BASEADDR
+ /* Use the Silicon Serial ID attached on the onewire bus to */
+ /* generate sensible MAC addresses. */
+ unsigned char *pOnewire = ioremap(XPAR_ONEWIRE_0_BASEADDR, 6);
+ struct xemac_platform_data *pdata = dev->dev.platform_data;
+ if (strcmp(dev->name, "xilinx_emac") == 0) {
+  printk(KERN_INFO "Fixup MAC address for %s:%d\n",
+    dev->name, dev->id);
+  /* FIXME.. this doesn't seem to return data that is consistent */
+  /* with the self test... why not? */
+  pdata->mac_addr[0] = 0x00;
+  pdata->mac_addr[1] = 0x0A;
+  pdata->mac_addr[2] = 0x35;
+  pdata->mac_addr[3] = dev->id;
+  pdata->mac_addr[4] = pOnewire[4];
+  pdata->mac_addr[5] = pOnewire[5];
+  printk(KERN_INFO "MAC address is now %2x:%2x:%2x:%2x:%2x:%2x\n",
+   pdata->mac_addr[0],
+   pdata->mac_addr[1],
+   pdata->mac_addr[2],
+   pdata->mac_addr[3],
+   pdata->mac_addr[4],
+   pdata->mac_addr[5]);
+ }
+#endif
+ return 0;
+}
diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters.h b/arch/ppc/platforms/4xx/xparameters/xparameters.h
index 01aa043..34d9844 100644
--- a/arch/ppc/platforms/4xx/xparameters/xparameters.h
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters.h
@@ -15,8 +15,12 @@
 
 #if defined(CONFIG_XILINX_ML300)
   #include "xparameters_ml300.h"
+#elif defined(CONFIG_XILINX_XUPV2P)
+  #include "xparameters_xupv2p.h"
 #elif defined(CONFIG_XILINX_ML403)
   #include "xparameters_ml403.h"
+#elif defined(CONFIG_XILINX_ML41x)
+  #include "xparameters_ml41x.h"
 #else
   /* Add other board xparameter includes here before the #else */
   #error No xparameters_*.h file included
diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters_ml41x.h b/arch/ppc/platforms/4xx/xparameters/xparameters_ml41x.h
new file mode 100644
index 0000000..ff6956f
--- /dev/null
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters_ml41x.h
@@ -0,0 +1,277 @@
+
+/*******************************************************************
+*
+* CAUTION: This file is automatically generated by libgen.
+* Version: Xilinx EDK 8.2.02 EDK_Im_Sp2.4
+* DO NOT EDIT.
+*
+* Copyright (c) 2005 Xilinx, Inc.  All rights reserved.
+*
+* Description: Driver parameters
+*
+*******************************************************************/
+
+/* Definitions for driver PLBARB */
+#define XPAR_XPLBARB_NUM_INSTANCES 1
+
+/* Definitions for peripheral PLB */
+#define XPAR_PLB_BASEADDR 0x00000000
+#define XPAR_PLB_HIGHADDR 0x00000000
+#define XPAR_PLB_DEVICE_ID 0
+#define XPAR_PLB_PLB_NUM_MASTERS 3
+
+
+/******************************************************************/
+
+/* Definitions for driver OPBARB */
+#define XPAR_XOPBARB_NUM_INSTANCES 1
+
+/* Definitions for peripheral OPB */
+#define XPAR_OPB_BASEADDR 0xFFFFFFFF
+#define XPAR_OPB_HIGHADDR 0x00000000
+#define XPAR_OPB_DEVICE_ID 0
+#define XPAR_OPB_NUM_MASTERS 1
+
+/******************************************************************/
+
+
+/* Definitions for peripheral OPB_SOCKET_0 */
+#define XPAR_OPB_SOCKET_0_BASEADDR 0x40000000
+#define XPAR_OPB_SOCKET_0_HIGHADDR 0x7FFFFFFF
+#define XPAR_OPB_SOCKET_0_DCR_BASEADDR 0x40700300
+#define XPAR_OPB_SOCKET_0_DCR_HIGHADDR 0x40700307
+
+/******************************************************************/
+
+/* Definitions for driver UARTNS550 */
+#define XPAR_XUARTNS550_NUM_INSTANCES 2
+#define XPAR_XUARTNS550_CLOCK_HZ 100000000
+
+/* Definitions for peripheral RS232_UART_1 */
+#define XPAR_RS232_UART_1_BASEADDR 0x40400000
+#define XPAR_RS232_UART_1_HIGHADDR 0x4040FFFF
+#define XPAR_RS232_UART_1_DEVICE_ID 0
+
+
+/* Definitions for peripheral RS232_UART_2 */
+#define XPAR_RS232_UART_2_BASEADDR 0x40420000
+#define XPAR_RS232_UART_2_HIGHADDR 0x4042FFFF
+#define XPAR_RS232_UART_2_DEVICE_ID 1
+
+
+/******************************************************************/
+
+/* Definitions for driver SPI */
+#define XPAR_XSPI_NUM_INSTANCES 1
+
+/* Definitions for peripheral SPI_EEPROM */
+#define XPAR_SPI_EEPROM_BASEADDR 0x40A00000
+#define XPAR_SPI_EEPROM_HIGHADDR 0x40A0FFFF
+#define XPAR_SPI_EEPROM_DEVICE_ID 0
+#define XPAR_SPI_EEPROM_FIFO_EXIST 1
+#define XPAR_SPI_EEPROM_SPI_SLAVE_ONLY 0
+#define XPAR_SPI_EEPROM_NUM_SS_BITS 1
+
+
+/******************************************************************/
+
+#define XPAR_XSYSACE_MEM_WIDTH 16
+/* Definitions for driver SYSACE */
+#define XPAR_XSYSACE_NUM_INSTANCES 1
+
+/* Definitions for peripheral SYSACE_COMPACTFLASH */
+#define XPAR_SYSACE_COMPACTFLASH_BASEADDR 0x41800000
+#define XPAR_SYSACE_COMPACTFLASH_HIGHADDR 0x4180FFFF
+#define XPAR_SYSACE_COMPACTFLASH_DEVICE_ID 0
+#define XPAR_SYSACE_COMPACTFLASH_MEM_WIDTH 16
+
+
+/******************************************************************/
+
+/* Definitions for driver IIC */
+#define XPAR_XIIC_NUM_INSTANCES 1
+
+/* Definitions for peripheral IIC_BUS */
+#define XPAR_IIC_BUS_BASEADDR 0x40800000
+#define XPAR_IIC_BUS_HIGHADDR 0x4080FFFF
+#define XPAR_IIC_BUS_DEVICE_ID 0
+#define XPAR_IIC_BUS_TEN_BIT_ADR 0
+#define XPAR_IIC_BUS_GPO_WIDTH 1
+
+
+/******************************************************************/
+
+#define XPAR_INTC_MAX_NUM_INTR_INPUTS 6
+#define XPAR_XINTC_HAS_IPR 1
+#define XPAR_XINTC_USE_DCR 0
+/* Definitions for driver INTC */
+#define XPAR_XINTC_NUM_INSTANCES 1
+
+/* Definitions for peripheral OPB_INTC_0 */
+#define XPAR_OPB_INTC_0_BASEADDR 0x41200000
+#define XPAR_OPB_INTC_0_HIGHADDR 0x4120FFFF
+#define XPAR_OPB_INTC_0_DEVICE_ID 0
+#define XPAR_OPB_INTC_0_KIND_OF_INTR 0x00000000
+
+
+/******************************************************************/
+
+#define XPAR_INTC_SINGLE_BASEADDR 0x41200000
+#define XPAR_INTC_SINGLE_HIGHADDR 0x4120FFFF
+#define XPAR_INTC_SINGLE_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID
+#define XPAR_ETHERNET_MAC_IP2INTC_IRPT_MASK 0X000001
+#define XPAR_OPB_INTC_0_ETHERNET_MAC_IP2INTC_IRPT_INTR 0
+#define XPAR_IIC_BUS_IP2INTC_IRPT_MASK 0X000002
+#define XPAR_OPB_INTC_0_IIC_BUS_IP2INTC_IRPT_INTR 1
+#define XPAR_SYSACE_COMPACTFLASH_SYSACE_IRQ_MASK 0X000004
+#define XPAR_OPB_INTC_0_SYSACE_COMPACTFLASH_SYSACE_IRQ_INTR 2
+#define XPAR_SPI_EEPROM_IP2INTC_IRPT_MASK 0X000008
+#define XPAR_OPB_INTC_0_SPI_EEPROM_IP2INTC_IRPT_INTR 3
+#define XPAR_RS232_UART_2_IP2INTC_IRPT_MASK 0X000010
+#define XPAR_OPB_INTC_0_RS232_UART_2_IP2INTC_IRPT_INTR 4
+#define XPAR_RS232_UART_1_IP2INTC_IRPT_MASK 0X000020
+#define XPAR_OPB_INTC_0_RS232_UART_1_IP2INTC_IRPT_INTR 5
+
+/******************************************************************/
+
+/* Definitions for driver HWICAP */
+#define XPAR_XHWICAP_NUM_INSTANCES 1
+
+/* Definitions for peripheral OPB_HWICAP_0 */
+#define XPAR_OPB_HWICAP_0_BASEADDR 0x41300000
+#define XPAR_OPB_HWICAP_0_HIGHADDR 0x4130FFFF
+#define XPAR_OPB_HWICAP_0_DEVICE_ID 0
+
+/******************************************************************/
+
+/* Definitions for driver DDR */
+#define XPAR_XDDR_NUM_INSTANCES 1
+
+/* Definitions for peripheral DDR_SDRAM_32MX64 */
+#define XPAR_DDR_SDRAM_32MX64_ECC_BASEADDR 0xFFFFFFFF
+#define XPAR_DDR_SDRAM_32MX64_ECC_HIGHADDR 0x00000000
+#define XPAR_DDR_SDRAM_32MX64_DEVICE_ID 0
+#define XPAR_DDR_SDRAM_32MX64_INCLUDE_ECC_INTR 0
+
+
+/******************************************************************/
+
+/* Definitions for peripheral DDR_SDRAM_32MX64 */
+#define XPAR_DDR_SDRAM_32MX64_MEM0_BASEADDR 0x00000000
+#define XPAR_DDR_SDRAM_32MX64_MEM0_HIGHADDR 0x03FFFFFF
+
+/******************************************************************/
+
+/* Definitions for driver EMAC */
+#define XPAR_XEMAC_NUM_INSTANCES 1
+
+/* Definitions for peripheral ETHERNET_MAC */
+#define XPAR_ETHERNET_MAC_BASEADDR 0x80400000
+#define XPAR_ETHERNET_MAC_HIGHADDR 0x8040FFFF
+#define XPAR_ETHERNET_MAC_DEVICE_ID 0
+#define XPAR_ETHERNET_MAC_ERR_COUNT_EXIST 1
+#define XPAR_ETHERNET_MAC_DMA_PRESENT 1
+#define XPAR_ETHERNET_MAC_MII_EXIST 1
+
+
+/******************************************************************/
+
+
+/* Definitions for peripheral PLB_BRAM_IF_CNTLR_1 */
+#define XPAR_PLB_BRAM_IF_CNTLR_1_BASEADDR 0xfffff000
+#define XPAR_PLB_BRAM_IF_CNTLR_1_HIGHADDR 0xffffffff
+
+
+/******************************************************************/
+
+#define XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ 300000000
+
+/******************************************************************/
+
+
+/******************************************************************/
+
+/* Cannonical Constant Names */
+
+/******************************************************************/
+
+#define XPAR_UARTNS550_0_BASEADDR (XPAR_RS232_UART_1_BASEADDR+0x1000)
+#define XPAR_UARTNS550_0_HIGHADDR XPAR_RS232_UART_1_HIGHADDR
+#define XPAR_UARTNS550_0_CLOCK_FREQ_HZ XPAR_XUARTNS550_CLOCK_HZ
+#define XPAR_UARTNS550_0_DEVICE_ID XPAR_RS232_UART_1_DEVICE_ID
+#define XPAR_UARTNS550_1_BASEADDR (XPAR_RS232_UART_2_BASEADDR+0x1000)
+#define XPAR_UARTNS550_1_HIGHADDR XPAR_RS232_UART_2_HIGHADDR
+#define XPAR_UARTNS550_1_CLOCK_FREQ_HZ XPAR_XUARTNS550_CLOCK_HZ
+#define XPAR_UARTNS550_1_DEVICE_ID XPAR_RS232_UART_2_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_SPI_0_BASEADDR XPAR_SPI_EEPROM_BASEADDR
+#define XPAR_SPI_0_HIGHADDR XPAR_SPI_EEPROM_HIGHADDR
+#define XPAR_SPI_0_FIFO_EXIST XPAR_SPI_EEPROM_FIFO_EXIST
+#define XPAR_SPI_0_SPI_SLAVE_ONLY XPAR_SPI_EEPROM_SPI_SLAVE_ONLY
+#define XPAR_SPI_0_NUM_SS_BITS XPAR_SPI_EEPROM_NUM_SS_BITS
+#define XPAR_SPI_0_DEVICE_ID XPAR_SPI_EEPROM_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_SYSACE_0_BASEADDR XPAR_SYSACE_COMPACTFLASH_BASEADDR
+#define XPAR_SYSACE_0_HIGHADDR XPAR_SYSACE_COMPACTFLASH_HIGHADDR
+#define XPAR_SYSACE_0_DEVICE_ID XPAR_SYSACE_COMPACTFLASH_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_IIC_0_BASEADDR XPAR_IIC_BUS_BASEADDR
+#define XPAR_IIC_0_HIGHADDR XPAR_IIC_BUS_HIGHADDR
+#define XPAR_IIC_0_TEN_BIT_ADR XPAR_IIC_BUS_TEN_BIT_ADR
+#define XPAR_IIC_0_DEVICE_ID XPAR_IIC_BUS_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_EMAC_0_BASEADDR XPAR_ETHERNET_MAC_BASEADDR
+#define XPAR_EMAC_0_HIGHADDR XPAR_ETHERNET_MAC_HIGHADDR
+#define XPAR_EMAC_0_DMA_PRESENT XPAR_ETHERNET_MAC_DMA_PRESENT
+#define XPAR_EMAC_0_MII_EXIST XPAR_ETHERNET_MAC_MII_EXIST
+#define XPAR_EMAC_0_ERR_COUNT_EXIST XPAR_ETHERNET_MAC_ERR_COUNT_EXIST
+#define XPAR_EMAC_0_DEVICE_ID XPAR_ETHERNET_MAC_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_HWICAP_0_BASEADDR XPAR_OPB_HWICAP_0_BASEADDR
+#define XPAR_HWICAP_0_HIGHADDR XPAR_OPB_HWICAP_0_HIGHADDR
+#define XPAR_HWICAP_0_DEVICE_ID XPAR_OPB_HWICAP_0_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_INTC_0_BASEADDR XPAR_OPB_INTC_0_BASEADDR
+#define XPAR_INTC_0_HIGHADDR XPAR_OPB_INTC_0_HIGHADDR
+#define XPAR_INTC_0_KIND_OF_INTR XPAR_OPB_INTC_0_KIND_OF_INTR
+#define XPAR_INTC_0_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_INTC_0_EMAC_0_VEC_ID XPAR_OPB_INTC_0_ETHERNET_MAC_IP2INTC_IRPT_INTR
+#define XPAR_INTC_0_IIC_0_VEC_ID XPAR_OPB_INTC_0_IIC_BUS_IP2INTC_IRPT_INTR
+#define XPAR_INTC_0_SYSACE_0_VEC_ID XPAR_OPB_INTC_0_SYSACE_COMPACTFLASH_SYSACE_IRQ_INTR
+#define XPAR_INTC_0_SPI_0_VEC_ID XPAR_OPB_INTC_0_SPI_EEPROM_IP2INTC_IRPT_INTR
+#define XPAR_INTC_0_UARTNS550_1_VEC_ID XPAR_OPB_INTC_0_RS232_UART_2_IP2INTC_IRPT_INTR
+#define XPAR_INTC_0_UARTNS550_0_VEC_ID XPAR_OPB_INTC_0_RS232_UART_1_IP2INTC_IRPT_INTR
+
+/******************************************************************/
+
+#define XPAR_PLB_CLOCK_FREQ_HZ 100000000
+#define XPAR_CORE_CLOCK_FREQ_HZ XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ
+#define XPAR_DDR_0_SIZE 64000000
+
+/******************************************************************/
+
+#define XPAR_PERSISTENT_0_IIC_0_BASEADDR 1024
+#define XPAR_PERSISTENT_0_IIC_0_HIGHADDR 2047
+#define XPAR_PERSISTENT_0_IIC_0_EEPROMADDR 0xA0
+
+/******************************************************************/
+
+#define XPAR_PCI_0_CLOCK_FREQ_HZ    0
+
+/******************************************************************/
+
diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters_xupv2p.h b/arch/ppc/platforms/4xx/xparameters/xparameters_xupv2p.h
new file mode 100644
index 0000000..cdaf28f
--- /dev/null
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters_xupv2p.h
@@ -0,0 +1,327 @@
+
+/*******************************************************************
+*
+* CAUTION: This file is automatically generated by libgen.
+* Version: Xilinx EDK 8.2.02 EDK_Im_Sp2.4
+* DO NOT EDIT.
+*
+* Copyright (c) 2005 Xilinx, Inc.  All rights reserved.
+*
+* Description: Driver parameters
+*
+*******************************************************************/
+
+/* Definitions for driver PLBARB */
+#define XPAR_XPLBARB_NUM_INSTANCES 1
+
+/* Definitions for peripheral PLB */
+#define XPAR_PLB_BASEADDR 0x00000000
+#define XPAR_PLB_HIGHADDR 0x00000000
+#define XPAR_PLB_DEVICE_ID 0
+#define XPAR_PLB_PLB_NUM_MASTERS 3
+
+
+/******************************************************************/
+
+/* Definitions for driver OPBARB */
+#define XPAR_XOPBARB_NUM_INSTANCES 1
+
+/* Definitions for peripheral OPB */
+#define XPAR_OPB_BASEADDR 0xFFFFFFFF
+#define XPAR_OPB_HIGHADDR 0x00000000
+#define XPAR_OPB_DEVICE_ID 0
+#define XPAR_OPB_NUM_MASTERS 1
+
+
+/******************************************************************/
+
+
+/* Definitions for peripheral OPB_SOCKET_0 */
+#define XPAR_OPB_SOCKET_0_BASEADDR 0x7D400000
+#define XPAR_OPB_SOCKET_0_HIGHADDR 0x7D4000FF
+#define XPAR_OPB_SOCKET_0_DCR_BASEADDR 0x40700300
+#define XPAR_OPB_SOCKET_0_DCR_HIGHADDR 0x40700307
+
+/******************************************************************/
+
+/* Definitions for driver OPB_ONEWIRE */
+#define XPAR_OPB_ONEWIRE_NUM_INSTANCES 1
+
+/* Definitions for peripheral ONEWIRE_0 */
+#define XPAR_ONEWIRE_0_BASEADDR 0x7A200000
+#define XPAR_ONEWIRE_0_HIGHADDR 0x7A20FFFF
+
+
+/******************************************************************/
+
+/* Definitions for driver UARTNS550 */
+#define XPAR_XUARTNS550_NUM_INSTANCES 1
+#define XPAR_XUARTNS550_CLOCK_HZ 100000000
+
+/* Definitions for peripheral RS232_UART_1 */
+#define XPAR_RS232_UART_1_BASEADDR 0x40400000
+#define XPAR_RS232_UART_1_HIGHADDR 0x4040FFFF
+#define XPAR_RS232_UART_1_DEVICE_ID 0
+
+
+/******************************************************************/
+
+#define XPAR_XSYSACE_MEM_WIDTH 16
+/* Definitions for driver SYSACE */
+#define XPAR_XSYSACE_NUM_INSTANCES 1
+
+/* Definitions for peripheral SYSACE_COMPACTFLASH */
+#define XPAR_SYSACE_COMPACTFLASH_BASEADDR 0x41800000
+#define XPAR_SYSACE_COMPACTFLASH_HIGHADDR 0x4180FFFF
+#define XPAR_SYSACE_COMPACTFLASH_DEVICE_ID 0
+#define XPAR_SYSACE_COMPACTFLASH_MEM_WIDTH 16
+
+
+/******************************************************************/
+
+/* Definitions for driver GPIO */
+#define XPAR_XGPIO_NUM_INSTANCES 3
+
+/* Definitions for peripheral LEDS_4BIT */
+#define XPAR_LEDS_4BIT_BASEADDR 0x40000000
+#define XPAR_LEDS_4BIT_HIGHADDR 0x4000FFFF
+#define XPAR_LEDS_4BIT_DEVICE_ID 0
+#define XPAR_LEDS_4BIT_INTERRUPT_PRESENT 0
+#define XPAR_LEDS_4BIT_IS_DUAL 0
+
+
+/* Definitions for peripheral DIPSWS_4BIT */
+#define XPAR_DIPSWS_4BIT_BASEADDR 0x40020000
+#define XPAR_DIPSWS_4BIT_HIGHADDR 0x4002FFFF
+#define XPAR_DIPSWS_4BIT_DEVICE_ID 1
+#define XPAR_DIPSWS_4BIT_INTERRUPT_PRESENT 0
+#define XPAR_DIPSWS_4BIT_IS_DUAL 0
+
+
+/* Definitions for peripheral PUSHBUTTONS_5BIT */
+#define XPAR_PUSHBUTTONS_5BIT_BASEADDR 0x40040000
+#define XPAR_PUSHBUTTONS_5BIT_HIGHADDR 0x4004FFFF
+#define XPAR_PUSHBUTTONS_5BIT_DEVICE_ID 2
+#define XPAR_PUSHBUTTONS_5BIT_INTERRUPT_PRESENT 0
+#define XPAR_PUSHBUTTONS_5BIT_IS_DUAL 0
+
+
+/******************************************************************/
+
+#define XPAR_XPS2_NUM_INSTANCES 2
+#define XPAR_PS2_PORTS_DEVICE_ID_0 0
+#define XPAR_PS2_PORTS_BASEADDR_0 0x7a400000
+#define XPAR_PS2_PORTS_HIGHADDR_0 (0x7a400000+0x3F)
+#define XPAR_PS2_PORTS_DEVICE_ID_1 1
+#define XPAR_PS2_PORTS_BASEADDR_1 (0x7a400000+0x1000)
+#define XPAR_PS2_PORTS_HIGHADDR_1 (0x7a400000+0x103F)
+
+/******************************************************************/
+
+#define XPAR_INTC_MAX_NUM_INTR_INPUTS 7
+#define XPAR_XINTC_HAS_IPR 1
+#define XPAR_XINTC_USE_DCR 0
+/* Definitions for driver INTC */
+#define XPAR_XINTC_NUM_INSTANCES 1
+
+/* Definitions for peripheral OPB_INTC_0 */
+#define XPAR_OPB_INTC_0_BASEADDR 0x41200000
+#define XPAR_OPB_INTC_0_HIGHADDR 0x4120FFFF
+#define XPAR_OPB_INTC_0_DEVICE_ID 0
+#define XPAR_OPB_INTC_0_KIND_OF_INTR 0x00000000
+
+
+/******************************************************************/
+
+#define XPAR_INTC_SINGLE_BASEADDR 0x41200000
+#define XPAR_INTC_SINGLE_HIGHADDR 0x4120FFFF
+#define XPAR_INTC_SINGLE_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID
+#define XPAR_OPB_TIMER_0_INTERRUPT_MASK 0X000001
+#define XPAR_OPB_INTC_0_OPB_TIMER_0_INTERRUPT_INTR 0
+#define XPAR_OPB_SOCKET_IP2INTC_IRPT_MASK 0X000002
+#define XPAR_OPB_INTC_0_OPB_SOCKET_IP2INTC_IRPT_INTR 1
+#define XPAR_ETHERNET_MAC_IP2INTC_IRPT_MASK 0X000004
+#define XPAR_OPB_INTC_0_ETHERNET_MAC_IP2INTC_IRPT_INTR 2
+#define XPAR_SYSACE_COMPACTFLASH_SYSACE_IRQ_MASK 0X000008
+#define XPAR_OPB_INTC_0_SYSACE_COMPACTFLASH_SYSACE_IRQ_INTR 3
+#define XPAR_RS232_UART_1_IP2INTC_IRPT_MASK 0X000010
+#define XPAR_OPB_INTC_0_RS232_UART_1_IP2INTC_IRPT_INTR 4
+#define XPAR_PS2_PORTS_SYS_INTR2_MASK 0X000020
+#define XPAR_OPB_INTC_0_PS2_PORTS_SYS_INTR2_INTR 5
+#define XPAR_PS2_PORTS_SYS_INTR1_MASK 0X000040
+#define XPAR_OPB_INTC_0_PS2_PORTS_SYS_INTR1_INTR 6
+
+/******************************************************************/
+
+/* Definitions for driver HWICAP */
+#define XPAR_XHWICAP_NUM_INSTANCES 1
+
+/* Definitions for peripheral OPB_HWICAP_0 */
+#define XPAR_OPB_HWICAP_0_BASEADDR 0x41300000
+#define XPAR_OPB_HWICAP_0_HIGHADDR 0x4130FFFF
+#define XPAR_OPB_HWICAP_0_DEVICE_ID 0
+
+/******************************************************************/
+
+/* Definitions for driver TFT_REF */
+#define XPAR_XTFT_NUM_INSTANCES 1
+
+/* Definitions for peripheral VGA_FRAMEBUFFER */
+#define XPAR_VGA_FRAMEBUFFER_DCR_BASEADDR 0x40700200
+#define XPAR_VGA_FRAMEBUFFER_DCR_HIGHADDR 0x40700207
+#define XPAR_VGA_FRAMEBUFFER_DEVICE_ID 0
+
+
+/******************************************************************/
+
+/* Definitions for driver TMRCTR */
+#define XPAR_XTMRCTR_NUM_INSTANCES 1
+
+/* Definitions for peripheral OPB_TIMER_0 */
+#define XPAR_OPB_TIMER_0_BASEADDR 0x40800000
+#define XPAR_OPB_TIMER_0_HIGHADDR 0x408000FF
+#define XPAR_OPB_TIMER_0_DEVICE_ID 0
+
+
+/******************************************************************/
+
+/* Definitions for driver EMAC */
+#define XPAR_XEMAC_NUM_INSTANCES 1
+
+/* Definitions for peripheral ETHERNET_MAC */
+#define XPAR_ETHERNET_MAC_BASEADDR 0x80400000
+#define XPAR_ETHERNET_MAC_HIGHADDR 0x8040FFFF
+#define XPAR_ETHERNET_MAC_DEVICE_ID 0
+#define XPAR_ETHERNET_MAC_ERR_COUNT_EXIST 1
+#define XPAR_ETHERNET_MAC_DMA_PRESENT 1
+#define XPAR_ETHERNET_MAC_MII_EXIST 1
+
+
+/******************************************************************/
+
+/* Definitions for driver DDR */
+#define XPAR_XDDR_NUM_INSTANCES 1
+
+/* Definitions for peripheral DDR_256MB_32MX64_RANK1_ROW13_COL10_CL2_5 */
+#define XPAR_DDR_256MB_32MX64_RANK1_ROW13_COL10_CL2_5_ECC_BASEADDR 0xFFFFFFFF
+#define XPAR_DDR_256MB_32MX64_RANK1_ROW13_COL10_CL2_5_ECC_HIGHADDR 0x00000000
+#define XPAR_DDR_256MB_32MX64_RANK1_ROW13_COL10_CL2_5_DEVICE_ID 0
+#define XPAR_DDR_256MB_32MX64_RANK1_ROW13_COL10_CL2_5_INCLUDE_ECC_INTR 0
+
+
+/******************************************************************/
+
+/* Definitions for peripheral DDR_256MB_32MX64_RANK1_ROW13_COL10_CL2_5 */
+#define XPAR_DDR_256MB_32MX64_RANK1_ROW13_COL10_CL2_5_MEM0_BASEADDR 0x00000000
+#define XPAR_DDR_256MB_32MX64_RANK1_ROW13_COL10_CL2_5_MEM0_HIGHADDR 0x0FFFFFFF
+
+/******************************************************************/
+
+
+/* Definitions for peripheral PLB_BRAM_IF_CNTLR_1 */
+#define XPAR_PLB_BRAM_IF_CNTLR_1_BASEADDR 0xffffc000
+#define XPAR_PLB_BRAM_IF_CNTLR_1_HIGHADDR 0xffffffff
+
+
+/******************************************************************/
+
+#define XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ 300000000
+
+/******************************************************************/
+
+
+/******************************************************************/
+
+/* Cannonical Constant Names */
+
+/******************************************************************/
+
+#define XPAR_UARTNS550_0_BASEADDR (XPAR_RS232_UART_1_BASEADDR+0x1000)
+#define XPAR_UARTNS550_0_HIGHADDR XPAR_RS232_UART_1_HIGHADDR
+#define XPAR_UARTNS550_0_CLOCK_FREQ_HZ XPAR_XUARTNS550_CLOCK_HZ
+#define XPAR_UARTNS550_0_DEVICE_ID XPAR_RS232_UART_1_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_EMAC_0_BASEADDR XPAR_ETHERNET_MAC_BASEADDR
+#define XPAR_EMAC_0_HIGHADDR XPAR_ETHERNET_MAC_HIGHADDR
+#define XPAR_EMAC_0_DMA_PRESENT XPAR_ETHERNET_MAC_DMA_PRESENT
+#define XPAR_EMAC_0_MII_EXIST XPAR_ETHERNET_MAC_MII_EXIST
+#define XPAR_EMAC_0_ERR_COUNT_EXIST XPAR_ETHERNET_MAC_ERR_COUNT_EXIST
+#define XPAR_EMAC_0_DEVICE_ID XPAR_ETHERNET_MAC_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_SYSACE_0_BASEADDR XPAR_SYSACE_COMPACTFLASH_BASEADDR
+#define XPAR_SYSACE_0_HIGHADDR XPAR_SYSACE_COMPACTFLASH_HIGHADDR
+#define XPAR_SYSACE_0_DEVICE_ID XPAR_SYSACE_COMPACTFLASH_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_TMRCTR_0_BASEADDR XPAR_OPB_TIMER_0_BASEADDR
+#define XPAR_TMRCTR_0_HIGHADDR XPAR_OPB_TIMER_0_HIGHADDR
+#define XPAR_TMRCTR_0_DEVICE_ID XPAR_OPB_TIMER_0_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_HWICAP_0_BASEADDR XPAR_OPB_HWICAP_0_BASEADDR
+#define XPAR_HWICAP_0_HIGHADDR XPAR_OPB_HWICAP_0_HIGHADDR
+#define XPAR_HWICAP_0_DEVICE_ID XPAR_OPB_HWICAP_0_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_GPIO_0_BASEADDR XPAR_LEDS_4BIT_BASEADDR
+#define XPAR_GPIO_0_HIGHADDR XPAR_LEDS_4BIT_HIGHADDR
+#define XPAR_GPIO_0_IS_DUAL XPAR_LEDS_4BIT_IS_DUAL
+#define XPAR_GPIO_0_DEVICE_ID XPAR_LEDS_4BIT_DEVICE_ID
+#define XPAR_GPIO_1_BASEADDR XPAR_DIPSWS_4BIT_BASEADDR
+#define XPAR_GPIO_1_HIGHADDR XPAR_DIPSWS_4BIT_HIGHADDR
+#define XPAR_GPIO_1_IS_DUAL XPAR_DIPSWS_4BIT_IS_DUAL
+#define XPAR_GPIO_1_DEVICE_ID XPAR_DIPSWS_4BIT_DEVICE_ID
+#define XPAR_GPIO_2_BASEADDR XPAR_PUSHBUTTONS_5BIT_BASEADDR
+#define XPAR_GPIO_2_HIGHADDR XPAR_PUSHBUTTONS_5BIT_HIGHADDR
+#define XPAR_GPIO_2_IS_DUAL XPAR_PUSHBUTTONS_5BIT_IS_DUAL
+#define XPAR_GPIO_2_DEVICE_ID XPAR_PUSHBUTTONS_5BIT_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_PS2_0_BASEADDR XPAR_PS2_PORTS_BASEADDR_0
+#define XPAR_PS2_0_HIGHADDR XPAR_PS2_PORTS_HIGHADDR_0
+#define XPAR_PS2_0_DEVICE_ID XPAR_PS2_PORTS_DEVICE_ID_0
+#define XPAR_PS2_1_BASEADDR XPAR_PS2_PORTS_BASEADDR_1
+#define XPAR_PS2_1_HIGHADDR XPAR_PS2_PORTS_HIGHADDR_1
+#define XPAR_PS2_1_DEVICE_ID XPAR_PS2_PORTS_DEVICE_ID_1
+
+/******************************************************************/
+
+#define XPAR_INTC_0_BASEADDR XPAR_OPB_INTC_0_BASEADDR
+#define XPAR_INTC_0_HIGHADDR XPAR_OPB_INTC_0_HIGHADDR
+#define XPAR_INTC_0_KIND_OF_INTR XPAR_OPB_INTC_0_KIND_OF_INTR
+#define XPAR_INTC_0_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_INTC_0_TMRCTR_0_VEC_ID XPAR_OPB_INTC_0_OPB_TIMER_0_INTERRUPT_INTR
+#define XPAR_INTC_0_OPB_SOCKET_0_VEC_ID XPAR_OPB_INTC_0_OPB_SOCKET_IP2INTC_IRPT_INTR
+#define XPAR_INTC_0_EMAC_0_VEC_ID XPAR_OPB_INTC_0_ETHERNET_MAC_IP2INTC_IRPT_INTR
+#define XPAR_INTC_0_SYSACE_0_VEC_ID XPAR_OPB_INTC_0_SYSACE_COMPACTFLASH_SYSACE_IRQ_INTR
+#define XPAR_INTC_0_UARTNS550_0_VEC_ID XPAR_OPB_INTC_0_RS232_UART_1_IP2INTC_IRPT_INTR
+#define XPAR_INTC_0_PS2_1_VEC_ID XPAR_OPB_INTC_0_PS2_PORTS_SYS_INTR2_INTR
+#define XPAR_INTC_0_PS2_0_VEC_ID XPAR_OPB_INTC_0_PS2_PORTS_SYS_INTR1_INTR
+
+/******************************************************************/
+
+#define XPAR_TFT_0_BASEADDR XPAR_VGA_FRAMEBUFFER_DCR_BASEADDR
+
+/******************************************************************/
+
+#define XPAR_PLB_CLOCK_FREQ_HZ 100000000
+#define XPAR_CORE_CLOCK_FREQ_HZ XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ
+#define XPAR_DDR_0_SIZE 0x10000000
+
+/******************************************************************/
+
+#define XPAR_PCI_0_CLOCK_FREQ_HZ    0
+
+/******************************************************************/
+
-- 
1.5.1


--------------000103000201010208040208--

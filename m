Return-Path: <glikely@gmail.com>
Received: from qproxy.gmail.com (qproxy.gmail.com [72.14.204.205])
	by ozlabs.org (Postfix) with ESMTP id 811B868237
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 17:44:50 +1000 (EST)
Received: by qproxy.gmail.com with SMTP id k13so65034qbf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 00:44:48 -0700 (PDT)
Message-ID: <528646bc05091000377417dc16@mail.gmail.com>
Date: Sat, 10 Sep 2005 01:37:39 -0600
From: Grant Likely <glikely@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [PATCH 2/2] Add support for MEMEC 2VP30-FF1152 eval board with
	simple FPGA design
Reply-To: glikely@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here is an example port to another V2PRO based board.

This patch is for information only and is NOT suitable for submission up to
mainline

---

 arch/ppc/boot/simple/embed_config.c                |   12 +-
 arch/ppc/platforms/4xx/Kconfig                     |    9 +
 arch/ppc/platforms/4xx/Makefile                    |    1=20
 arch/ppc/platforms/4xx/memec_2vp30.c               |  157 ++++++++++++++++=
++++
 arch/ppc/platforms/4xx/memec_2vp30.h               |   47 ++++++
 arch/ppc/platforms/4xx/memec_2vp30_devices.c       |   59 ++++++++
 arch/ppc/platforms/4xx/xparameters/xparameters.h   |   29 ++++
 .../4xx/xparameters/xparameters_memec_2vp30.h      |  100 +++++++++++++++
 include/asm-ppc/ibm4xx.h                           |    4 +
 9 files changed, 410 insertions(+), 8 deletions(-)
 create mode 100644 arch/ppc/platforms/4xx/memec_2vp30.c
 create mode 100644 arch/ppc/platforms/4xx/memec_2vp30.h
 create mode 100644 arch/ppc/platforms/4xx/memec_2vp30_devices.c
 create mode 100644 arch/ppc/platforms/4xx/xparameters/xparameters_memec_2v=
p30.h

5f6cd89ad6b695ac30c18dff79c9054f66979899
diff --git a/arch/ppc/boot/simple/embed_config.c
b/arch/ppc/boot/simple/embed_config.c
--- a/arch/ppc/boot/simple/embed_config.c
+++ b/arch/ppc/boot/simple/embed_config.c
@@ -745,7 +745,7 @@ embed_config(bd_t **bdp)
 }
 #endif /* WILLOW */
=20
-#ifdef CONFIG_XILINX_ML300
+#ifdef CONFIG_VIRTEX_II_PRO
 void
 embed_config(bd_t ** bdp)
 {
@@ -775,14 +775,14 @@ embed_config(bd_t ** bdp)
=20
 =09bd =3D &bdinfo;
 =09*bdp =3D bd;
-=09bd->bi_memsize =3D XPAR_DDR_0_SIZE;
-=09bd->bi_intfreq =3D XPAR_CORE_CLOCK_FREQ_HZ;
-=09bd->bi_busfreq =3D XPAR_PLB_CLOCK_FREQ_HZ;
-=09bd->bi_pci_busfreq =3D XPAR_PCI_0_CLOCK_FREQ_HZ;
+=09bd->bi_memsize =3D V2PRO_BI_MEMSIZE;
+=09bd->bi_intfreq =3D V2PRO_BI_INTFREQ;
+=09bd->bi_busfreq =3D V2PRO_BI_BUSFREQ;
+=09bd->bi_pci_busfreq =3D V2PRO_BI_PCI_BUSFREQ;
 =09timebase_period_ns =3D 1000000000 / bd->bi_tbfreq;
 =09/* see bi_tbfreq definition in arch/ppc/platforms/4xx/xilinx_ml300.h */
 }
-#endif /* CONFIG_XILINX_ML300 */
+#endif /* CONFIG_VIRTEX_II_PRO */
=20
 #ifdef CONFIG_IBM_OPENBIOS
 /* This could possibly work for all treeboot roms.
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfi=
g
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -67,6 +67,11 @@ config XILINX_ML300
 =09help
 =09  This option enables support for the Xilinx ML300 evaluation board.
=20
+config MEMEC_2VP30
+=09bool "MEMEC 2VP30 Eval Board"
+=09help
+=09  This option enables support for the MEMEC 2VP30-FF1152 eval board.
+
 endchoice
=20
 choice
@@ -203,7 +208,7 @@ config 405GPR
=20
 config VIRTEX_II_PRO
 =09bool
-=09depends on XILINX_ML300
+=09depends on XILINX_ML300 || MEMEC_2VP30
 =09default y
=20
 config VIRTEX_II_PRO_TLB_FIX
@@ -229,7 +234,7 @@ config STB03xxx
=20
 config EMBEDDEDBOOT
 =09bool
-=09depends on EP405 || XILINX_ML300
+=09depends on EP405 || XILINX_ML300 || MEMEC_2VP30
 =09default y
=20
 config IBM_OPENBIOS
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makef=
ile
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_REDWOOD_6)=09=09+=3D redwood6.o
 obj-$(CONFIG_SYCAMORE)=09=09+=3D sycamore.o
 obj-$(CONFIG_WALNUT)=09=09+=3D walnut.o
 obj-$(CONFIG_XILINX_ML300)=09+=3D xilinx_ml300.o xilinx_ml300_devices.o
+obj-$(CONFIG_MEMEC_2VP30)=09+=3D memec_2vp30.o memec_2vp30_devices.o
=20
 obj-$(CONFIG_405GP)=09=09+=3D ibm405gp.o
 obj-$(CONFIG_REDWOOD_5)=09=09+=3D ibmstb4.o
diff --git a/arch/ppc/platforms/4xx/memec_2vp30.c
b/arch/ppc/platforms/4xx/memec_2vp30.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/memec_2vp30.c
@@ -0,0 +1,157 @@
+/*
+ * arch/ppc/platforms/4xx/memec_2vp30.c
+ *
+ * MEMEC 2VP30-FF1152 evaluation board initialization
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under th=
e
+ * terms of the GNU General Public License version 2.  This program is lic=
ensed
+ * "as is" without any warranty of any kind, whether express or implied.
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
+#include "xparameters/xparameters.h"
+
+/*
+ * As an overview of how the following functions (platform_init,
+ * memec_map_io, memec_setup_arch and memec_init_IRQ) fit into the
+ * kernel startup procedure, here's a call tree:
+ *
+ * start_here=09=09=09=09=09arch/ppc/kernel/head_4xx.S
+ *  early_init=09=09=09=09=09arch/ppc/kernel/setup.c
+ *  machine_init=09=09=09=09arch/ppc/kernel/setup.c
+ *    platform_init=09=09=09=09this file
+ *      ppc4xx_init=09=09=09=09arch/ppc/syslib/ppc4xx_setup.c
+ *        parse_bootinfo
+ *          find_bootinfo
+ *        "setup some default ppc_md pointers"
+ *  MMU_init=09=09=09=09=09arch/ppc/mm/init.c
+ *    *ppc_md.setup_io_mappings =3D=3D memec_map_io=09this file
+ *      ppc4xx_map_io=09=09=09=09arch/ppc/syslib/ppc4xx_setup.c
+ *  start_kernel=09=09=09=09init/main.c
+ *    setup_arch=09=09=09=09arch/ppc/kernel/setup.c
+ * #if defined(CONFIG_KGDB)
+ *      *ppc_md.kgdb_map_scc() =3D=3D gen550_kgdb_map_scc
+ * #endif
+ *      *ppc_md.setup_arch =3D=3D memec_setup_arch=09this file
+ *        ppc4xx_setup_arch=09=09=09arch/ppc/syslib/ppc4xx_setup.c
+ *          ppc4xx_find_bridges=09=09=09arch/ppc/syslib/ppc405_pci.c
+ *    init_IRQ=09=09=09=09=09arch/ppc/kernel/irq.c
+ *      *ppc_md.init_IRQ =3D=3D memec_init_IRQ=09this file
+ *        ppc4xx_init_IRQ=09=09=09arch/ppc/syslib/ppc4xx_setup.c
+ *          ppc4xx_pic_init=09=09=09arch/ppc/syslib/xilinx_pic.c
+ */
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+
+static volatile unsigned *powerdown_base =3D
+    (volatile unsigned *) XPAR_POWER_0_POWERDOWN_BASEADDR;
+
+static void
+xilinx_power_off(void)
+{
+=09local_irq_disable();
+=09out_be32(powerdown_base, XPAR_POWER_0_POWERDOWN_VALUE);
+=09while (1) ;
+}
+#endif
+
+void __init
+memec_map_io(void)
+{
+=09ppc4xx_map_io();
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+=09powerdown_base =3D ioremap((unsigned long) powerdown_base,
+=09=09=09=09 XPAR_POWER_0_POWERDOWN_HIGHADDR -
+=09=09=09=09 XPAR_POWER_0_POWERDOWN_BASEADDR + 1);
+#endif
+}
+
+#ifdef CONFIG_SERIAL_8250
+static void __init
+memec_early_serial_map(void)
+{
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+=09struct uart_port serial_req;
+#endif
+=09struct plat_serial8250_port *pdata;
+=09int i =3D 0;
+
+=09pdata =3D (struct plat_serial8250_port *) ppc_sys_get_pdata(V2PRO_UART)=
;
+=09while(pdata && pdata->flags)
+=09{
+=09=09pdata->membase =3D ioremap(pdata->mapbase, 0x100);
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+=09=09memset(&serial_req, 0, sizeof(serial_req));
+=09=09serial_req.mapbase=09=3D pdata->mapbase;
+=09=09serial_req.membase=09=3D pdata->membase;
+=09=09serial_req.irq=09=09=3D pdata->irq;
+=09=09serial_req.uartclk=09=3D pdata->uartclk;
+=09=09serial_req.regshift=09=3D pdata->regshift;
+=09=09serial_req.iotype=09=3D pdata->iotype;
+=09=09serial_req.flags=09=3D pdata->flags;
+=09=09gen550_init(i, &serial_req);
+#endif
+=09=09pdata++;
+=09=09i++;
+=09}
+}
+#endif /* CONFIG_SERIAL_8250 */
+
+void __init
+memec_setup_arch(void)
+{
+#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_KGDB)
+=09memec_early_serial_map();
+#endif
+
+=09ppc4xx_setup_arch();=09/* calls ppc4xx_find_bridges() */
+
+=09/* Identify the system */
+=09printk(KERN_INFO "Xilinx Virtex-II Pro port\n");
+}
+
+/* Called after board_setup_irq from ppc4xx_init_IRQ(). */
+void __init
+memec_init_irq(void)
+{
+=09ppc4xx_init_IRQ();
+}
+
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+=09      unsigned long r6, unsigned long r7)
+{
+=09ppc4xx_init(r3, r4, r5, r6, r7);
+
+=09identify_ppc_sys_by_id(mfspr(SPRN_PVR));
+
+=09ppc_md.setup_arch =3D memec_setup_arch;
+=09ppc_md.setup_io_mappings =3D memec_map_io;
+=09ppc_md.init_IRQ =3D memec_init_irq;
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+=09ppc_md.power_off =3D xilinx_power_off;
+#endif
+
+#ifdef CONFIG_KGDB
+=09ppc_md.early_serial_map =3D memec_early_serial_map;
+#endif
+}
+
diff --git a/arch/ppc/platforms/4xx/memec_2vp30.h
b/arch/ppc/platforms/4xx/memec_2vp30.h
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/memec_2vp30.h
@@ -0,0 +1,47 @@
+/*
+ * arch/ppc/platforms/4xx/memec_2vp30.h
+ *
+ * Include file that defines the MEMEC 2VP30-FF1152 evaluation board
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under th=
e
+ * terms of the GNU General Public License version 2.  This program is lic=
ensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_MEMEC_2VP30_H__
+#define __ASM_MEMEC_2VP30_H__
+
+/* MEMEC 2VP30 has a Xilinx Virtex-II Pro processor */
+#include <platforms/4xx/virtex-ii_pro.h>
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+typedef struct board_info {
+=09unsigned int=09 bi_memsize;=09=09/* DRAM installed, in bytes */
+=09unsigned char=09 bi_enetaddr[6];=09/* Local Ethernet MAC address */
+=09unsigned int=09 bi_intfreq;=09=09/* Processor speed, in Hz */
+=09unsigned int=09 bi_busfreq;=09=09/* PLB Bus speed, in Hz */
+=09unsigned int=09 bi_pci_busfreq;=09/* PCI Bus speed, in Hz */
+} bd_t;
+
+/* Some 4xx parts use a different timebase frequency from the internal clo=
ck.
+*/
+#define bi_tbfreq bi_intfreq
+
+#endif /* !__ASSEMBLY__ */
+
+/* We don't need anything mapped.  Size of zero will accomplish that. */
+#define PPC4xx_ONB_IO_PADDR=090u
+#define PPC4xx_ONB_IO_VADDR=090u
+#define PPC4xx_ONB_IO_SIZE=090u
+
+#define PPC4xx_MACHINE_NAME "MEMEC 2VP30-FF1152 eval board"
+
+#endif /* __ASM_MEMEC_2VP30_H__ */
+#endif /* __KERNEL__ */
diff --git a/arch/ppc/platforms/4xx/memec_2vp30_devices.c
b/arch/ppc/platforms/4xx/memec_2vp30_devices.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/memec_2vp30_devices.c
@@ -0,0 +1,59 @@
+/*
+ * arch/ppc/platforms/4xx/memec_2vp30_devices.c
+ *
+ * Virtex-II Pro Device descriptions
+ *
+ * Maintainer: Grant Likely <grant.likely@gdcanada.com>
+ *
+ * Copyright 2005 General Dynamics Canada Ltd.
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify i=
t
+ * under  the terms of  the GNU General  Public License as published by th=
e
+ * Free Software Foundation;  either version 2 of the  License, or (at you=
r
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/serial_8250.h>
+#include <asm/ppc_sys.h>
+#include "virtex-ii_pro.h"
+#include "xparameters/xparameters.h"
+
+struct plat_serial8250_port serial_platform_data[] =3D {
+=09{
+=09=09.mapbase  =3D XPAR_RS232_BASEADDR + 0x1003,
+=09=09.irq=09  =3D XPAR_OPB_INTC_0_RS232_IP2INTC_IRPT_INTR,
+=09=09.iotype=09  =3D UPIO_MEM,
+=09=09.uartclk  =3D XPAR_XUARTNS550_CLOCK_HZ,
+=09=09.flags=09  =3D UPF_BOOT_AUTOCONF,
+=09=09.regshift =3D 2,
+=09},
+=09{ }, /* terminated by empty record */
+};
+
+struct platform_device ppc_sys_platform_devices[] =3D {
+=09[V2PRO_UART] =3D {
+=09=09.name=09=09=3D "serial8250",
+=09=09.id=09=09=3D 0,
+=09=09.dev.platform_data =3D serial_platform_data,
+=09},
+};
+
+struct ppc_sys_spec *cur_ppc_sys_spec;
+struct ppc_sys_spec ppc_sys_specs[] =3D {
+=09{
+=09=09/* Only one entry, always assume the same design */
+=09=09.ppc_sys_name=09=3D "MEMEC 2VP30-FF1152 eval board",
+=09=09.mask =09=09=3D 0x00000000,
+=09=09.value =09=09=3D 0x00000000,
+=09=09.num_devices=09=3D 1,
+=09=09.device_list=09=3D (enum ppc_sys_devices[])
+=09=09{
+=09=09=09V2PRO_UART,
+=09=09},
+=09},
+};
+
diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters.h
b/arch/ppc/platforms/4xx/xparameters/xparameters.h
--- a/arch/ppc/platforms/4xx/xparameters/xparameters.h
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters.h
@@ -31,6 +31,12 @@
 #if defined(CONFIG_XILINX_ML300)
   #include "xparameters_ml300.h"
=20
+  /* Setup for board information structure */
+  #define V2PRO_BI_MEMSIZE              XPAR_DDR_0_SIZE
+  #define V2PRO_BI_INTFREQ              XPAR_CORE_CLOCK_FREQ_HZ
+  #define V2PRO_BI_BUSFREQ              XPAR_PLB_CLOCK_FREQ_HZ
+  #define V2PRO_BI_PCI_BUSFREQ          XPAR_PCI_0_CLOCK_FREQ_HZ
+
   /* Values for setting up interrupt controller */
   #define V2PRO_XINTC_USE_DCR           XPAR_XINTC_USE_DCR
   #define V2PRO_INTC_BASEADDR           XPAR_INTC_0_BASEADDR
@@ -45,6 +51,29 @@
         .iomem_reg_shift =3D 2,                                           =
\
         .io_type         =3D SERIAL_IO_MEM,                               =
\
   },
+#elif defined(CONFIG_MEMEC_2VP30)
+  #include "xparameters_memec_2vp30.h"
+
+  /* Setup for board information structure */
+  #define V2PRO_BI_MEMSIZE              (XPAR_SDRAM_8MX32_HIGHADDR+1)
+  #define V2PRO_BI_INTFREQ              XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ
+  #define V2PRO_BI_BUSFREQ              XPAR_XUARTNS550_CLOCK_HZ
+  #define V2PRO_BI_PCI_BUSFREQ          0
+
+  /* Values for setting up interrupt controller */
+  #define V2PRO_XINTC_USE_DCR           XPAR_XINTC_USE_DCR
+  #define V2PRO_INTC_BASEADDR           XPAR_OPB_INTC_0_BASEADDR
+  #define V2PRO_INTC_KIND_OF_INTR       XPAR_OPB_INTC_0_KIND_OF_INTR
+
+  /* zImage serial port definitions */
+  #define SERIAL_PORT_DFNS {                                            \
+        .baud_base       =3D XPAR_XUARTNS550_CLOCK_HZ/16,                 =
\
+        .irq             =3D XPAR_OPB_INTC_0_RS232_IP2INTC_IRPT_INTR,     =
\
+        .flags           =3D ASYNC_BOOT_AUTOCONF,                         =
\
+        .iomem_base      =3D (u8 *)XPAR_RS232_BASEADDR + 0x1003,          =
\
+        .iomem_reg_shift =3D 2,                                           =
\
+        .io_type         =3D SERIAL_IO_MEM,                               =
\
+  },
 #else
   /* Add other board xparameter includes here before the #else */
   #error No *_xparameters.h file included
diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters_memec_2vp30.h
b/arch/ppc/platforms/4xx/xparameters/xparameters_memec_2vp30.h
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters_memec_2vp30.h
@@ -0,0 +1,100 @@
+
+/*******************************************************************
+*
+* CAUTION: This file is automatically generated by libgen.
+* Version: Xilinx EDK 7.1 EDK_H.10.4
+* DO NOT EDIT.
+*
+* Copyright (c) 2005 Xilinx, Inc.  All rights reserved.=20
+*=20
+* Description: Driver parameters
+*
+*******************************************************************/
+
+#define STDIN_BASEADDRESS 0x40400000
+#define STDOUT_BASEADDRESS 0x40400000
+
+/******************************************************************/
+
+#define XPAR_XUARTNS550_NUM_INSTANCES 1
+#define XPAR_XUARTNS550_CLOCK_HZ 100000000
+#define XPAR_RS232_BASEADDR 0x40400000
+#define XPAR_RS232_HIGHADDR 0x4040FFFF
+#define XPAR_RS232_DEVICE_ID 0
+
+/******************************************************************/
+
+#define XPAR_XGPIO_NUM_INSTANCES 2
+#define XPAR_LEDS_4BIT_BASEADDR 0x40020000
+#define XPAR_LEDS_4BIT_HIGHADDR 0x4002FFFF
+#define XPAR_LEDS_4BIT_DEVICE_ID 0
+#define XPAR_LEDS_4BIT_INTERRUPT_PRESENT 0
+#define XPAR_LEDS_4BIT_IS_DUAL 0
+#define XPAR_PUSH_BUTTONS_3BIT_BASEADDR 0x40000000
+#define XPAR_PUSH_BUTTONS_3BIT_HIGHADDR 0x4000FFFF
+#define XPAR_PUSH_BUTTONS_3BIT_DEVICE_ID 1
+#define XPAR_PUSH_BUTTONS_3BIT_INTERRUPT_PRESENT 1
+#define XPAR_PUSH_BUTTONS_3BIT_IS_DUAL 0
+
+/******************************************************************/
+
+#define XPAR_XSYSACE_MEM_WIDTH 16
+#define XPAR_XSYSACE_NUM_INSTANCES 1
+#define XPAR_SYSACE_COMPACTFLASH_BASEADDR 0x41800000
+#define XPAR_SYSACE_COMPACTFLASH_HIGHADDR 0x4180FFFF
+#define XPAR_SYSACE_COMPACTFLASH_DEVICE_ID 0
+#define XPAR_SYSACE_COMPACTFLASH_MEM_WIDTH 16
+
+/******************************************************************/
+
+#define XPAR_INTC_MAX_NUM_INTR_INPUTS 4
+#define XPAR_XINTC_HAS_IPR 1
+#define XPAR_XINTC_USE_DCR 0
+#define XPAR_XINTC_NUM_INSTANCES 1
+#define XPAR_OPB_INTC_0_BASEADDR 0x41200000
+#define XPAR_OPB_INTC_0_HIGHADDR 0x4120FFFF
+#define XPAR_OPB_INTC_0_DEVICE_ID 0
+#define XPAR_OPB_INTC_0_KIND_OF_INTR 0x00000000
+
+/******************************************************************/
+
+#define XPAR_INTC_SINGLE_BASEADDR 0x41200000
+#define XPAR_INTC_SINGLE_HIGHADDR 0x4120FFFF
+#define XPAR_INTC_SINGLE_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID
+#define XPAR_ETHERNET_MAC_IP2INTC_IRPT_MASK 0X000001
+#define XPAR_OPB_INTC_0_ETHERNET_MAC_IP2INTC_IRPT_INTR 0
+#define XPAR_PUSH_BUTTONS_3BIT_IP2INTC_IRPT_MASK 0X000002
+#define XPAR_OPB_INTC_0_PUSH_BUTTONS_3BIT_IP2INTC_IRPT_INTR 1
+#define XPAR_SYSACE_COMPACTFLASH_SYSACE_IRQ_MASK 0X000004
+#define XPAR_OPB_INTC_0_SYSACE_COMPACTFLASH_SYSACE_IRQ_INTR 2
+#define XPAR_RS232_IP2INTC_IRPT_MASK 0X000008
+#define XPAR_OPB_INTC_0_RS232_IP2INTC_IRPT_INTR 3
+
+/******************************************************************/
+
+#define XPAR_XEMAC_NUM_INSTANCES 1
+#define XPAR_ETHERNET_MAC_BASEADDR 0x80400000
+#define XPAR_ETHERNET_MAC_HIGHADDR 0x8040FFFF
+#define XPAR_ETHERNET_MAC_DEVICE_ID 0
+#define XPAR_ETHERNET_MAC_ERR_COUNT_EXIST 1
+#define XPAR_ETHERNET_MAC_DMA_PRESENT 1
+#define XPAR_ETHERNET_MAC_MII_EXIST 1
+#define XPAR_ETHERNET_MAC_CAM_EXIST 0
+#define XPAR_ETHERNET_MAC_JUMBO_EXIST 0
+
+/******************************************************************/
+
+#define XPAR_SDRAM_8MX32_BASEADDR 0x00000000
+#define XPAR_SDRAM_8MX32_HIGHADDR 0x01FFFFFF
+
+/******************************************************************/
+
+#define XPAR_PLB_BRAM_IF_CNTLR_1_BASEADDR 0xffffc000
+#define XPAR_PLB_BRAM_IF_CNTLR_1_HIGHADDR 0xffffffff
+
+/******************************************************************/
+
+#define XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ 300000000
+
+/******************************************************************/
+
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -63,6 +63,10 @@
 #include <platforms/4xx/xilinx_ml300.h>
 #endif
=20
+#if defined(CONFIG_MEMEC_2VP30)
+#include <platforms/4xx/memec_2vp30.h>
+#endif
+
 #ifndef __ASSEMBLY__
=20
 #ifdef CONFIG_40x

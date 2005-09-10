Return-Path: <glikely@gmail.com>
Received: from qproxy.gmail.com (qproxy.gmail.com [72.14.204.200])
	by ozlabs.org (Postfix) with ESMTP id 56C6868237
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 17:43:05 +1000 (EST)
Received: by qproxy.gmail.com with SMTP id k13so65030qbf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 00:43:04 -0700 (PDT)
Message-ID: <528646bc050910003630c25dca@mail.gmail.com>
Date: Sat, 10 Sep 2005 01:36:28 -0600
From: Grant Likely <glikely@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [PATCH 1/2] Move Virtex-II Pro / ML300 port over to the platform
	bus.
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

This is a large patch that moves the ML300 to the platform bus.

It also isolates most of the linux tree from changes to the xparameters.h
file.  Ultimately, the goal is to move everything over to the flattened
device tree for telling the kernel about devices.  That way xparameters.h
can go away entirely for the kernel proper.  (Isolated to the bootloader)

This patch will be split up into smaller parts before submitting to mainlin=
e

Comments are appreciated.

---

 arch/ppc/Kconfig.debug                           |    2 -
 arch/ppc/boot/common/ns16550.c                   |   15 ++++
 arch/ppc/boot/simple/embed_config.c              |    3 +
 arch/ppc/platforms/4xx/Kconfig                   |    5 -
 arch/ppc/platforms/4xx/Makefile                  |    3 -
 arch/ppc/platforms/4xx/virtex-ii_pro.c           |   60 ------------------
 arch/ppc/platforms/4xx/virtex-ii_pro.h           |   74 ++----------------=
----
 arch/ppc/platforms/4xx/xilinx_ml300.c            |   60 +++++++++++-------
 arch/ppc/platforms/4xx/xilinx_ml300.h            |    2 -
 arch/ppc/platforms/4xx/xilinx_ml300_devices.c    |   71 ++++++++++++++++++=
+++
 arch/ppc/platforms/4xx/xparameters/xparameters.h |   51 +++++++++++++++
 arch/ppc/syslib/Makefile                         |    2 -
 arch/ppc/syslib/gen550_dbg.c                     |    2 +
 arch/ppc/syslib/xilinx_pic.c                     |   12 ++--
 include/asm-ppc/ppc_sys.h                        |    2 +
 include/asm-ppc/xparameters.h                    |   18 -----
 16 files changed, 196 insertions(+), 186 deletions(-)
 delete mode 100644 arch/ppc/platforms/4xx/virtex-ii_pro.c
 create mode 100644 arch/ppc/platforms/4xx/xilinx_ml300_devices.c
 create mode 100644 arch/ppc/platforms/4xx/xparameters/xparameters.h
 delete mode 100644 include/asm-ppc/xparameters.h

c434b6a7edfa498ed01ee9c3677e687bad87d805
diff --git a/arch/ppc/Kconfig.debug b/arch/ppc/Kconfig.debug
--- a/arch/ppc/Kconfig.debug
+++ b/arch/ppc/Kconfig.debug
@@ -66,7 +66,7 @@ config SERIAL_TEXT_DEBUG
=20
 config PPC_OCP
 =09bool
-=09depends on IBM_OCP || XILINX_OCP
+=09depends on IBM_OCP
 =09default y
=20
 endmenu
diff --git a/arch/ppc/boot/common/ns16550.c b/arch/ppc/boot/common/ns16550.=
c
--- a/arch/ppc/boot/common/ns16550.c
+++ b/arch/ppc/boot/common/ns16550.c
@@ -11,6 +11,10 @@
 #include "nonstdio.h"
 #include "serial.h"
=20
+#if defined(CONFIG_VIRTEX_II_PRO)
+#include <platforms/4xx/xparameters/xparameters.h>
+#endif
+
 #define SERIAL_BAUD=099600
=20
 extern unsigned long ISA_io;
@@ -25,6 +29,7 @@ unsigned long serial_init(int chan, void
 {
 =09unsigned long com_port;
 =09unsigned char lcr, dlm;
+=09unsigned long baud_base;
=20
 =09/* We need to find out which type io we're expecting.  If it's
 =09 * 'SERIAL_IO_PORT', we get an offset from the isa_io_base.
@@ -43,6 +48,12 @@ unsigned long serial_init(int chan, void
=20
 =09/* How far apart the registers are. */
 =09shift =3D rs_table[chan].iomem_reg_shift;
+=09baud_base =3D rs_table[chan].baud_base;
+#if defined(BASE_BAUD)
+=09if (!baud_base)
+=09=09baud_base =3D BASE_BAUD;
+#endif
+
 =09
 =09/* save the LCR */
 =09lcr =3D inb(com_port + (UART_LCR << shift));
@@ -62,9 +73,9 @@ unsigned long serial_init(int chan, void
 =09else {
 =09=09/* Input clock. */
 =09=09outb(com_port + (UART_DLL << shift),
-=09=09     (BASE_BAUD / SERIAL_BAUD) & 0xFF);
+=09=09     (baud_base / SERIAL_BAUD) & 0xFF);
 =09=09outb(com_port + (UART_DLM << shift),
-=09=09     (BASE_BAUD / SERIAL_BAUD) >> 8);
+=09=09     (baud_base / SERIAL_BAUD) >> 8);
 =09=09/* 8 data, 1 stop, no parity */
 =09=09outb(com_port + (UART_LCR << shift), 0x03);
 =09=09/* RTS/DTR */
diff --git a/arch/ppc/boot/simple/embed_config.c
b/arch/ppc/boot/simple/embed_config.c
--- a/arch/ppc/boot/simple/embed_config.c
+++ b/arch/ppc/boot/simple/embed_config.c
@@ -21,6 +21,9 @@
 #ifdef CONFIG_40x
 #include <asm/io.h>
 #endif
+#ifdef CONFIG_VIRTEX_II_PRO
+#include <platforms/4xx/xparameters/xparameters.h>
+#endif
 extern unsigned long timebase_period_ns;
=20
 /* For those boards that don't provide one.
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfi=
g
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -212,11 +212,6 @@ config VIRTEX_II_PRO_TLB_FIX
 =09  It is safe to say Y here, but there is a performance impact.
 =09  Say N if unsure.
=20
-config XILINX_OCP
-=09bool
-=09depends on VIRTEX_II_PRO
-=09default y
-
 config STB03xxx
 =09bool
 =09depends on REDWOOD_5 || REDWOOD_6
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makef=
ile
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_REDWOOD_5)=09=09+=3D redwood5.o
 obj-$(CONFIG_REDWOOD_6)=09=09+=3D redwood6.o
 obj-$(CONFIG_SYCAMORE)=09=09+=3D sycamore.o
 obj-$(CONFIG_WALNUT)=09=09+=3D walnut.o
-obj-$(CONFIG_XILINX_ML300)=09+=3D xilinx_ml300.o
+obj-$(CONFIG_XILINX_ML300)=09+=3D xilinx_ml300.o xilinx_ml300_devices.o
=20
 obj-$(CONFIG_405GP)=09=09+=3D ibm405gp.o
 obj-$(CONFIG_REDWOOD_5)=09=09+=3D ibmstb4.o
@@ -26,4 +26,3 @@ obj-$(CONFIG_440GX)=09=09+=3D ibm440gx.o
 obj-$(CONFIG_440SP)=09=09+=3D ibm440sp.o
 obj-$(CONFIG_405EP)=09=09+=3D ibm405ep.o
 obj-$(CONFIG_405GPR)=09=09+=3D ibm405gpr.o
-obj-$(CONFIG_VIRTEX_II_PRO)=09+=3D virtex-ii_pro.o
diff --git a/arch/ppc/platforms/4xx/virtex-ii_pro.c
b/arch/ppc/platforms/4xx/virtex-ii_pro.c
deleted file mode 100644
--- a/arch/ppc/platforms/4xx/virtex-ii_pro.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * arch/ppc/platforms/4xx/virtex-ii_pro.c
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under th=
e
- * terms of the GNU General Public License version 2.  This program is lic=
ensed
- * "as is" without any warranty of any kind, whether express or implied.
- */
-
-#include <linux/config.h>
-#include <linux/init.h>
-#include <asm/ocp.h>
-#include "virtex-ii_pro.h"
-
-/* Have OCP take care of the serial ports. */
-struct ocp_def core_ocp[] =3D {
-#ifdef XPAR_UARTNS550_0_BASEADDR
-=09{ .vendor=09=3D OCP_VENDOR_XILINX,
-=09  .function=09=3D OCP_FUNC_16550,
-=09  .index=09=3D 0,
-=09  .paddr=09=3D XPAR_UARTNS550_0_BASEADDR,
-=09  .irq=09=09=3D XPAR_INTC_0_UARTNS550_0_VEC_ID,
-=09  .pm=09=09=3D OCP_CPM_NA
-=09},
-#ifdef XPAR_UARTNS550_1_BASEADDR
-=09{ .vendor=09=3D OCP_VENDOR_XILINX,
-=09  .function=09=3D OCP_FUNC_16550,
-=09  .index=09=3D 1,
-=09  .paddr=09=3D XPAR_UARTNS550_1_BASEADDR,
-=09  .irq=09=09=3D XPAR_INTC_0_UARTNS550_1_VEC_ID,
-=09  .pm=09=09=3D OCP_CPM_NA
-=09},
-#ifdef XPAR_UARTNS550_2_BASEADDR
-=09{ .vendor=09=3D OCP_VENDOR_XILINX,
-=09  .function=09=3D OCP_FUNC_16550,
-=09  .index=09=3D 2,
-=09  .paddr=09=3D XPAR_UARTNS550_2_BASEADDR,
-=09  .irq=09=09=3D XPAR_INTC_0_UARTNS550_2_VEC_ID,
-=09  .pm=09=09=3D OCP_CPM_NA
-=09},
-#ifdef XPAR_UARTNS550_3_BASEADDR
-=09{ .vendor=09=3D OCP_VENDOR_XILINX,
-=09  .function=09=3D OCP_FUNC_16550,
-=09  .index=09=3D 3,
-=09  .paddr=09=3D XPAR_UARTNS550_3_BASEADDR,
-=09  .irq=09=09=3D XPAR_INTC_0_UARTNS550_3_VEC_ID,
-=09  .pm=09=09=3D OCP_CPM_NA
-=09},
-#ifdef XPAR_UARTNS550_4_BASEADDR
-#error Edit this file to add more devices.
-#endif=09=09=09/* 4 */
-#endif=09=09=09/* 3 */
-#endif=09=09=09/* 2 */
-#endif=09=09=09/* 1 */
-#endif=09=09=09/* 0 */
-=09{ .vendor=09=3D OCP_VENDOR_INVALID
-=09}
-};
diff --git a/arch/ppc/platforms/4xx/virtex-ii_pro.h
b/arch/ppc/platforms/4xx/virtex-ii_pro.h
--- a/arch/ppc/platforms/4xx/virtex-ii_pro.h
+++ b/arch/ppc/platforms/4xx/virtex-ii_pro.h
@@ -15,84 +15,26 @@
 #ifndef __ASM_VIRTEXIIPRO_H__
 #define __ASM_VIRTEXIIPRO_H__
=20
-#include <linux/config.h>
-#include <asm/xparameters.h>
-
 /* serial defines */
=20
 #define RS_TABLE_SIZE  4=09/* change this and add more devices below
 =09=09=09=09   if you have more then 4 16x50 UARTs */
=20
-#define BASE_BAUD=09=09(XPAR_UARTNS550_0_CLOCK_FREQ_HZ/16)
-
-/* The serial ports in the Virtex-II Pro have each I/O byte in the
- * LSByte of a word.  This means that iomem_reg_shift needs to be 2 to
- * change the byte offsets into word offsets.  In addition the base
- * addresses need to have 3 added to them to get to the LSByte.
+/* Ugly, ugly, ugly! BASE_BAUD defined here to keep 8250.c happy.
  */
-#define STD_UART_OP(num)=09=09=09=09=09=09 \
-=09{ 0, BASE_BAUD, 0, XPAR_INTC_0_UARTNS550_##num##_VEC_ID,=09 \
-=09=09ASYNC_BOOT_AUTOCONF,=09=09 =09=09=09 \
-=09=09.iomem_base =3D (u8 *)XPAR_UARTNS550_##num##_BASEADDR + 3, \
-=09=09.iomem_reg_shift =3D 2,=09=09=09=09=09 \
-=09=09.io_type =3D SERIAL_IO_MEM},
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
+#if !defined(BASE_BAUD)
+ #define BASE_BAUD=09=09(0) /* dummy value; not used */
 #endif
=20
-#if defined(XPAR_INTC_0_UARTNS550_2_VEC_ID)
-#define ML300_UART2 STD_UART_OP(2)
-#else
-#define ML300_UART2
-#endif
+#ifndef __ASSEMBLY__
=20
-#if defined(XPAR_INTC_0_UARTNS550_3_VEC_ID)
-#define ML300_UART3 STD_UART_OP(3)
-#else
-#define ML300_UART3
-#endif
+/* Device type enumeration for platform bus definitions */
+enum ppc_sys_devices {
+=09V2PRO_UART,
+};
=20
-#if defined(XPAR_INTC_0_UARTNS550_4_VEC_ID)
-#error Edit this file to add more devices.
-#elif defined(XPAR_INTC_0_UARTNS550_3_VEC_ID)
-#define NR_SER_PORTS=094
-#elif defined(XPAR_INTC_0_UARTNS550_2_VEC_ID)
-#define NR_SER_PORTS=093
-#elif defined(XPAR_INTC_0_UARTNS550_1_VEC_ID)
-#define NR_SER_PORTS=092
-#elif defined(XPAR_INTC_0_UARTNS550_0_VEC_ID)
-#define NR_SER_PORTS=091
-#else
-#define NR_SER_PORTS=090
 #endif
=20
-#if defined(CONFIG_UART0_TTYS0)
-#define SERIAL_PORT_DFNS=09\
-=09ML300_UART0=09=09\
-=09ML300_UART1=09=09\
-=09ML300_UART2=09=09\
-=09ML300_UART3
-#endif
-
-#if defined(CONFIG_UART0_TTYS1)
-#define SERIAL_PORT_DFNS=09\
-=09ML300_UART1=09=09\
-=09ML300_UART0=09=09\
-=09ML300_UART2=09=09\
-=09ML300_UART3
-#endif
-
-#define DCRN_CPMFR_BASE=090
-
 #include <asm/ibm405.h>
=20
 #endif=09=09=09=09/* __ASM_VIRTEXIIPRO_H__ */
diff --git a/arch/ppc/platforms/4xx/xilinx_ml300.c
b/arch/ppc/platforms/4xx/xilinx_ml300.c
--- a/arch/ppc/platforms/4xx/xilinx_ml300.c
+++ b/arch/ppc/platforms/4xx/xilinx_ml300.c
@@ -17,12 +17,14 @@
 #include <linux/tty.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
+#include <linux/serial_8250.h>
 #include <linux/serialP.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/ocp.h>
+#include <asm/ppc_sys.h>
=20
-#include <platforms/4xx/virtex-ii_pro.h>=09/* for NR_SER_PORTS */
+#include <syslib/gen550.h>
+#include "xparameters/xparameters.h"
=20
 /*
  * As an overview of how the following functions (platform_init,
@@ -80,38 +82,46 @@ ml300_map_io(void)
 #endif
 }
=20
+#ifdef CONFIG_SERIAL_8250
 static void __init
 ml300_early_serial_map(void)
 {
-#ifdef CONFIG_SERIAL_8250
-=09struct serial_state old_ports[] =3D { SERIAL_PORT_DFNS };
-=09struct uart_port port;
-=09int i;
-
-=09/* Setup ioremapped serial port access */
-=09for (i =3D 0; i < ARRAY_SIZE(old_ports); i++ ) {
-=09=09memset(&port, 0, sizeof(port));
-=09=09port.membase =3D ioremap((phys_addr_t)(old_ports[i].iomem_base), 16)=
;
-=09=09port.irq =3D old_ports[i].irq;
-=09=09port.uartclk =3D old_ports[i].baud_base * 16;
-=09=09port.regshift =3D old_ports[i].iomem_reg_shift;
-=09=09port.iotype =3D SERIAL_IO_MEM;
-=09=09port.flags =3D ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
-=09=09port.line =3D i;
-
-=09=09if (early_serial_setup(&port) !=3D 0) {
-=09=09=09printk("Early serial init of port %d failed\n", i);
-=09=09}
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
 =09}
-#endif /* CONFIG_SERIAL_8250 */
 }
+#endif /* CONFIG_SERIAL_8250 */
=20
 void __init
 ml300_setup_arch(void)
 {
-=09ppc4xx_setup_arch();=09/* calls ppc4xx_find_bridges() */
-
+#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_KGDB)
 =09ml300_early_serial_map();
+#endif
+
+=09ppc4xx_setup_arch();=09/* calls ppc4xx_find_bridges() */
=20
 =09/* Identify the system */
 =09printk(KERN_INFO "Xilinx Virtex-II Pro port\n");
@@ -131,6 +141,8 @@ platform_init(unsigned long r3, unsigned
 {
 =09ppc4xx_init(r3, r4, r5, r6, r7);
=20
+=09identify_ppc_sys_by_id(mfspr(SPRN_PVR));
+
 =09ppc_md.setup_arch =3D ml300_setup_arch;
 =09ppc_md.setup_io_mappings =3D ml300_map_io;
 =09ppc_md.init_IRQ =3D ml300_init_irq;
diff --git a/arch/ppc/platforms/4xx/xilinx_ml300.h
b/arch/ppc/platforms/4xx/xilinx_ml300.h
--- a/arch/ppc/platforms/4xx/xilinx_ml300.h
+++ b/arch/ppc/platforms/4xx/xilinx_ml300.h
@@ -41,7 +41,7 @@ typedef struct board_info {
 #define PPC4xx_ONB_IO_VADDR=090u
 #define PPC4xx_ONB_IO_SIZE=090u
=20
-#define PPC4xx_MACHINE_NAME "Xilinx ML300"
+#define PPC4xx_MACHINE_NAME "Xilinx ML300 Reference System"
=20
 #endif /* __ASM_XILINX_ML300_H__ */
 #endif /* __KERNEL__ */
diff --git a/arch/ppc/platforms/4xx/xilinx_ml300_devices.c
b/arch/ppc/platforms/4xx/xilinx_ml300_devices.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/xilinx_ml300_devices.c
@@ -0,0 +1,71 @@
+/*
+ * arch/ppc/syslib/virtex2pro_devices.c
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
+#ifdef XPAR_OPB_UART16550_0_BASEADDR
+=09{
+=09=09.mapbase  =3D XPAR_OPB_UART16550_0_BASEADDR + 3,
+=09=09.irq=09  =3D XPAR_DCR_INTC_0_OPB_UART16550_0_IP2INTC_IRPT_INTR,
+=09=09.iotype=09  =3D UPIO_MEM,
+=09=09.uartclk  =3D XPAR_XUARTNS550_CLOCK_HZ,
+=09=09.flags=09  =3D UPF_BOOT_AUTOCONF,
+=09=09.regshift =3D 2,
+=09},
+#endif
+#ifdef XPAR_OPB_UART16550_1_BASEADDR
+=09{
+=09=09.mapbase  =3D XPAR_OPB_UART16550_1_BASEADDR + 3,
+=09=09.irq=09  =3D XPAR_DCR_INTC_0_OPB_UART16550_1_IP2INTC_IRPT_INTR,
+=09=09.iotype=09  =3D UPIO_MEM,
+=09=09.uartclk  =3D XPAR_XUARTNS550_CLOCK_HZ,
+=09=09.flags=09  =3D UPF_BOOT_AUTOCONF,
+=09=09.regshift =3D 2,
+=09},
+#endif
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
+=09=09.ppc_sys_name=09=3D "Xilinx ML300 Reference Design",
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
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters.h
@@ -0,0 +1,51 @@
+/*
+ * arch/ppc/platforms/4xx/xparameters/xparameters.h
+ *
+ * This file includes the correct xparameters.h for the CONFIG'ed board
+ *
+ * Authors:
+ *    Grant C. Likely, glikely@gmail.com
+ *    MontaVista Software, Inc. source@mvista.com
+ *
+ * 2005 (c) Grant C. Likely, glikely@gmail.com
+ * 2004 (c) MontaVista Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of an=
y
+ * kind, whether express or implied.
+ */
+
+/*
+ * This file has three purposes:
+ * 1. Include the correct xparameters.h for the configured design
+ * 2. Translate design specific macros from xparam to common names
+ * 3. Provide a SERIAL_PORT_DFNS macro to setup up very early serial ports
+ *    zImage debug.  Later serial ports are advertised via the platform bu=
s
+ *
+ * The xparameters.h file is the pristine copy generated from Xilinx EDK
+ * toolset.  If you need to make changes, make the changes in this file
+ * rather than modifying the generated file.  That way if the design chang=
es
+ * then you just need to drop in the new xparameters.h
+ */
+
+#if defined(CONFIG_XILINX_ML300)
+  #include "xparameters_ml300.h"
+
+  /* Values for setting up interrupt controller */
+  #define V2PRO_XINTC_USE_DCR           XPAR_XINTC_USE_DCR
+  #define V2PRO_INTC_BASEADDR           XPAR_INTC_0_BASEADDR
+  #define V2PRO_INTC_KIND_OF_INTR       XPAR_INTC_0_KIND_OF_INTR
+
+  /* zImage serial port definitions */
+  #define SERIAL_PORT_DFNS {                                            \
+        .baud_base       =3D XPAR_XUARTNS550_CLOCK_HZ/16,                 =
\
+        .irq             =3D XPAR_DCR_INTC_0_OPB_UART16550_0_IP2INTC_IRPT_=
INTR, \
+        .flags           =3D ASYNC_BOOT_AUTOCONF,                         =
\
+        .iomem_base      =3D (u8 *)XPAR_OPB_UART16550_0_BASEADDR + 3,     =
\
+        .iomem_reg_shift =3D 2,                                           =
\
+        .io_type         =3D SERIAL_IO_MEM,                               =
\
+  },
+#else
+  /* Add other board xparameter includes here before the #else */
+  #error No *_xparameters.h file included
+#endif
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_440GX)=09=09+=3D ibm440gx_common.
 obj-$(CONFIG_440SP)=09=09+=3D ibm440gx_common.o ibm440sp_common.o
 ifeq ($(CONFIG_4xx),y)
 ifeq ($(CONFIG_VIRTEX_II_PRO),y)
-obj-$(CONFIG_40x)=09=09+=3D xilinx_pic.o
+obj-$(CONFIG_40x)=09=09+=3D xilinx_pic.o ppc_sys.o
 else
 ifeq ($(CONFIG_403),y)
 obj-$(CONFIG_40x)=09=09+=3D ppc403_pic.o
diff --git a/arch/ppc/syslib/gen550_dbg.c b/arch/ppc/syslib/gen550_dbg.c
--- a/arch/ppc/syslib/gen550_dbg.c
+++ b/arch/ppc/syslib/gen550_dbg.c
@@ -155,6 +155,8 @@ serial_close(unsigned long com_port)
 void
 gen550_init(int i, struct uart_port *serial_req)
 {
+=09if (i > RS_TABLE_SIZE)
+=09=09return;
 =09rs_table[i].io_type =3D serial_req->iotype;
 =09rs_table[i].port =3D serial_req->iobase;
 =09rs_table[i].iomem_base =3D serial_req->membase;
diff --git a/arch/ppc/syslib/xilinx_pic.c b/arch/ppc/syslib/xilinx_pic.c
--- a/arch/ppc/syslib/xilinx_pic.c
+++ b/arch/ppc/syslib/xilinx_pic.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <asm/io.h>
-#include <asm/xparameters.h>
+#include <platforms/4xx/xparameters/xparameters.h>
 #include <asm/ibm4xx.h>
=20
 /* No one else should require these constants, so define them locally here=
. */
@@ -122,14 +122,14 @@ ppc4xx_pic_init(void)
 #error NR_IRQS > 32 not supported
 #endif
=20
-#if XPAR_XINTC_USE_DCR =3D=3D 0
-=09intc =3D ioremap(XPAR_INTC_0_BASEADDR, 32);
+#if V2PRO_XINTC_USE_DCR =3D=3D 0
+=09intc =3D ioremap(V2PRO_INTC_BASEADDR, 32);
=20
 =09printk(KERN_INFO "Xilinx INTC #0 at 0x%08lX mapped to 0x%08lX\n",
-=09       (unsigned long) XPAR_INTC_0_BASEADDR, (unsigned long) intc);
+=09       (unsigned long) V2PRO_INTC_BASEADDR, (unsigned long) intc);
 #else
 =09printk(KERN_INFO "Xilinx INTC #0 at 0x%08lX (DCR)\n",
-=09       (unsigned long) XPAR_INTC_0_BASEADDR);
+=09       (unsigned long) V2PRO_INTC_BASEADDR);
 #endif
=20
 =09/*
@@ -149,7 +149,7 @@ ppc4xx_pic_init(void)
 =09for (i =3D 0; i < NR_IRQS; ++i) {
 =09=09irq_desc[i].handler =3D &xilinx_intc;
=20
-=09=09if (XPAR_INTC_0_KIND_OF_INTR & (0x00000001 << i))
+=09=09if (V2PRO_INTC_KIND_OF_INTR & (0x00000001 << i))
 =09=09=09irq_desc[i].status &=3D ~IRQ_LEVEL;
 =09=09else
 =09=09=09irq_desc[i].status |=3D IRQ_LEVEL;
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -29,6 +29,8 @@
 #include <asm/mpc52xx.h>
 #elif defined(CONFIG_MPC10X_BRIDGE)
 #include <asm/mpc10x.h>
+#elif defined(CONFIG_VIRTEX_II_PRO)
+#include <platforms/4xx/virtex-ii_pro.h>
 #else
 #error "need definition of ppc_sys_devices"
 #endif
diff --git a/include/asm-ppc/xparameters.h b/include/asm-ppc/xparameters.h
deleted file mode 100644
--- a/include/asm-ppc/xparameters.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * include/asm-ppc/xparameters.h
- *
- * This file includes the correct xparameters.h for the CONFIG'ed board
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * 2004 (c) MontaVista Software, Inc.  This file is licensed under the ter=
ms
- * of the GNU General Public License version 2.  This program is licensed
- * "as is" without any warranty of any kind, whether express or implied.
- */
-
-#include <linux/config.h>
-
-#if defined(CONFIG_XILINX_ML300)
-#include <platforms/4xx/xparameters/xparameters_ml300.h>
-#endif

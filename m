Date: Wed, 4 Sep 2002 22:02:33 +0200
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Xilinx virtex 2 pro platform support
Message-ID: <20020904200233.GL781@mind.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SFyWQ0h3ruR435lw"
From: p2@mind.be (Peter 'p2' De Schrijver)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Attached you will find a patch adding support for the Xilinx virtex 2
Pro platform, in particular the Xilinx interrupt controller. It was
tested on a Virtex 2 Pro implementation with 1 CPU core.

Comments welcome,

Peter.
--

--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xilinx-platform.patch"

diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/arch/ppc/config.in linuxppc_2_4_xseg2.new.clean2/arch/ppc/config.in
--- linuxppc_2_4_clean/arch/ppc/config.in	2002-07-20 12:03:21.000000000 +0200
+++ linuxppc_2_4_xseg2.new.clean2/arch/ppc/config.in	2002-09-01 17:07:42.000000000 +0200
@@ -83,6 +83,7 @@
 	 Redwood-5	CONFIG_REDWOOD_5 	\
 	 Redwood-6	CONFIG_REDWOOD_6 	\
 	 Tivo		CONFIG_TIVO 		\
+	 XSEG2 		CONFIG_XSEG2   		\
 	 Walnut		CONFIG_WALNUT"	Walnut

    if [ "$CONFIG_EP405" = "y" ]; then
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/arch/ppc/kernel/Makefile linuxppc_2_4_xseg2.new.clean2/arch/ppc/kernel/Makefile
--- linuxppc_2_4_clean/arch/ppc/kernel/Makefile	2002-07-20 12:04:24.000000000 +0200
+++ linuxppc_2_4_xseg2.new.clean2/arch/ppc/kernel/Makefile	2002-09-04 20:48:31.000000000 +0200
@@ -53,9 +53,9 @@
 ifeq ($(CONFIG_4xx),y)
 obj-$(CONFIG_40x)		+= ppc4xx_setup.o ppc4xx_pic.o ocp.o
 ifneq ($(CONFIG_RAINIER),y)
-ifeq ($(CONFIG_SERIAL),y)
-obj-$(CONFIG_40x)		+= ocp_uart.o
-endif
+#ifeq ($(CONFIG_SERIAL),y)
+#obj-$(CONFIG_40x)		+= ocp_uart.o
+#endif
 endif
 obj-$(CONFIG_440)		+= ppc4xx_pic.o ocp.o
 obj-$(CONFIG_PPC_RTC)		+= todc_time.o
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/arch/ppc/kernel/cputable.c linuxppc_2_4_xseg2.new.clean2/arch/ppc/kernel/cputable.c
--- linuxppc_2_4_clean/arch/ppc/kernel/cputable.c	2002-07-20 12:03:30.000000000 +0200
+++ linuxppc_2_4_xseg2.new.clean2/arch/ppc/kernel/cputable.c	2002-07-20 19:03:53.000000000 +0200
@@ -335,6 +335,14 @@
 	32, 32,
 	0, /*__setup_cpu_405 */
     },
+    {
+  	/* 405 softcore */
+	0xffff0000, 0x20010000, "405 Softcore",
+	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
+	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+	32, 32,
+	0, /*__setup_cpu_405 */
+    },
     {	/* STB 03xxx */
     	0xffff0000, 0x40130000, "STB03xxx",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/arch/ppc/kernel/ppc4xx_pic.c linuxppc_2_4_xseg2.new.clean2/arch/ppc/kernel/ppc4xx_pic.c
--- linuxppc_2_4_clean/arch/ppc/kernel/ppc4xx_pic.c	2002-07-20 12:03:53.000000000 +0200
+++ linuxppc_2_4_xseg2.new.clean2/arch/ppc/kernel/ppc4xx_pic.c	2002-09-01 18:12:56.000000000 +0200
@@ -140,7 +140,62 @@
 	mtdcr(DCRN_EXISR, (1 << (31 - bit)));
 }

-#else
+#elif defined(CONFIG_XSEG2)
+
+/* Function Prototypes */
+
+static void      ppc405_xintc_enable(unsigned int irq);
+static void      ppc405_xintc_disable(unsigned int irq);
+static void      ppc405_xintc_disable_and_ack(unsigned int irq);
+
+static struct hw_interrupt_type ppc405_xintc = {
+        "V2PRO 405 XINTC",
+        NULL,
+        NULL,
+        ppc405_xintc_enable,
+        ppc405_xintc_disable,
+        ppc405_xintc_disable_and_ack,
+        0
+};
+
+int ppc405_xintc_get_irq(struct pt_regs *regs) {
+
+       int vector;
+
+       vector=31 - ((*DCRN_XINTC0_IVR) >> 2);
+       if(vector==NR_IRQS)
+		vector=-1;
+
+       return vector;
+
+}
+
+static void  ppc405_xintc_enable(unsigned int irq) {
+
+      irq&=0x1f;
+
+      *DCRN_XINTC0_SIE=1<<irq;
+
+}
+
+static void ppc405_xintc_disable(unsigned int irq) {
+
+      irq&=0x1f;
+
+      *DCRN_XINTC0_CIE=1<<irq;
+
+}
+
+static void ppc405_xintc_disable_and_ack(unsigned int irq) {
+
+      irq&=0x1f;
+
+      *DCRN_XINTC0_CIE=1<<irq;
+      *DCRN_XINTC0_IAR=1<<irq;
+
+}
+
+#else /* !CONFIG_403  && !CONFIG_XSEG2 */

 #ifndef UIC1
 #define UIC1 UIC0
@@ -331,6 +386,7 @@
 }
 #endif

+#if !defined(CONFIG_403) && !defined(CONFIG_XSEG2)
 void __init
 ppc4xx_extpic_init(void)
 {
@@ -396,6 +452,8 @@
 	}

 }
+#endif
+
 void __init
 ppc4xx_pic_init(void)
 {
@@ -412,6 +470,15 @@

 	ppc4xx_pic = &ppc403_aic;
 	ppc_md.get_irq = ppc403_pic_get_irq;
+
+#elif defined(CONFIG_XSEG2)
+
+    *DCRN_XINTC0_IER=0;
+    *DCRN_XINTC0_MER=1<<31;
+
+    ppc4xx_pic = &ppc405_xintc;
+    ppc_md.get_irq = ppc405_xintc_get_irq;
+
 #else
 #if  (NR_UICS > 1)
 	ppc_cached_irq_mask[0] |= 1 << (31 - UIC0_UIC1NC);	/* enable cascading interrupt */
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/arch/ppc/kernel/ppc4xx_setup.c linuxppc_2_4_xseg2.new.clean2/arch/ppc/kernel/ppc4xx_setup.c
--- linuxppc_2_4_clean/arch/ppc/kernel/ppc4xx_setup.c	2002-07-20 12:04:09.000000000 +0200
+++ linuxppc_2_4_xseg2.new.clean2/arch/ppc/kernel/ppc4xx_setup.c	2002-09-04 20:41:23.000000000 +0200
@@ -104,7 +104,8 @@
 #if defined(CONFIG_FB)
 	conswitchp = &dummy_con;
 #endif
-#if defined (CONFIG_SERIAL) && !defined (CONFIG_RAINIER)
+#if defined (CONFIG_SERIAL) && !defined (CONFIG_RAINIER) && \
+	!defined(CONFIG_XSEG2)
 	early_uart_init();
 #endif
 	board_setup_arch();
@@ -161,8 +162,10 @@
 static void __init
 m4xx_map_io(void)
 {
+#if !defined(CONFIG_XSEG2)
 	io_block_mapping(PPC4xx_ONB_IO_VADDR,
 			 PPC4xx_ONB_IO_PADDR, PPC4xx_ONB_IO_SIZE, _PAGE_IO);
+#endif
 #ifdef CONFIG_PCI
 	io_block_mapping(PPC4xx_PCI_IO_VADDR,
 			 PPC4xx_PCI_IO_PADDR, PPC4xx_PCI_IO_SIZE, _PAGE_IO);
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/arch/ppc/platforms/Makefile linuxppc_2_4_xseg2.new.clean2/arch/ppc/platforms/Makefile
--- linuxppc_2_4_clean/arch/ppc/platforms/Makefile	2002-07-20 12:03:17.000000000 +0200
+++ linuxppc_2_4_xseg2.new.clean2/arch/ppc/platforms/Makefile	2002-09-01 17:08:06.000000000 +0200
@@ -29,6 +29,7 @@
 obj-$(CONFIG_CEDER)		+= ceder.o ibmnp405l.o
 obj-$(CONFIG_CPCI405)		+= cpci405.o ibm405gp.o
 obj-$(CONFIG_EP405)		+= ep405.o ibm405gp.o
+obj-$(CONFIG_XSEG2)    		+= xseg2.o
 obj-$(CONFIG_REDWOOD_4)		+= redwood.o ibmstb3.o
 obj-$(CONFIG_REDWOOD_5)		+= redwood5.o ibmstb4.o
 obj-$(CONFIG_REDWOOD_6)		+= redwood6.o ibmstbx25.o
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/arch/ppc/platforms/xseg2.c linuxppc_2_4_xseg2.new.clean2/arch/ppc/platforms/xseg2.c
--- linuxppc_2_4_clean/arch/ppc/platforms/xseg2.c	1970-01-01 01:00:00.000000000 +0100
+++ linuxppc_2_4_xseg2.new.clean2/arch/ppc/platforms/xseg2.c	2002-09-04 21:12:19.000000000 +0200
@@ -0,0 +1,111 @@
+/*
+ * xseg2.c: Support for the Xilinx V2Pro development board
+ *
+ * Copyright 2002 Mind NV
+ *
+ * http://www.mind.be/
+ *
+ * Author : Peter De Schrijver (p2@mind.be)
+ *
+ * This software may be used and distributed according to the terms of
+ * the GNU General Public License (GPL) version 2, incorporated herein by
+ * reference. Drivers based on or derived from this code fall under the GPL
+ * and must retain the authorship, copyright and this license notice. This
+ * file is not a complete program and may only be used when the entire
+ * operating system is licensed under the GPL.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/system.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/todc.h>
+#include <asm/ocp.h>
+
+struct ocp_def core_ocp[] = {
+		{OCP_NULL_TYPE, 0x0, OCP_IRQ_NA, OCP_CPM_NA},
+
+};
+
+extern int xilinx_kbd_setkeycode(unsigned int scancode, unsigned int keycode);
+extern int xilinx_kbd_getkeycode(unsigned int scancode);
+extern int xilinx_kbd_translate(unsigned char scancode, unsigned char *keycode, char raw_mode);
+extern char xilinx_kbd_unexpected_up(unsigned char keycode);
+extern void xilinx_kbd_init_hw(void);
+extern unsigned char xilinx_kbd_sysrq_xlate[128];
+
+#undef DEBUG
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+void *xseg2_gpio_base;
+
+int __init
+ppc405_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	/*
+	 *      PCI IDSEL/INTPIN->INTLINE
+	 *      A       B       C       D
+	 */
+	{
+                {28, 28, 28, 28},       /* IDSEL 1 - PCI slot 1 */
+        };
+	const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+};
+
+
+void __init
+board_setup_arch(void)
+{
+
+	io_block_mapping(0xe0000000, 0xa0000000, 0x20000, _PAGE_IO);
+	io_block_mapping(0xe0020000, 0xd0000000, 0x1000, _PAGE_IO);
+	io_block_mapping(0xe0030000, 0x60000000, 0x4000, _PAGE_IO);
+	io_block_mapping(0xe0040000, 0xa9000000, 0x2000, _PAGE_IO);
+
+}
+
+void __init
+bios_fixup(struct pci_controller *hose, void *pcil0_base)
+{
+
+}
+
+void __init
+board_io_mapping(void)
+{
+	xseg2_gpio_base = ioremap(XSEG2_GPIO_PADDR,
+				  XSEG2_GPIO_SIZE);
+}
+
+void __init
+board_setup_irq(void)
+{
+}
+
+void __init
+board_init(void)
+{
+
+#ifdef CONFIG_VT
+    /* these are adjusted in if we have an ADB keyboard */
+    ppc_md.kbd_setkeycode    = xilinx_kbd_setkeycode;
+    ppc_md.kbd_getkeycode    = xilinx_kbd_getkeycode;
+    ppc_md.kbd_translate     = xilinx_kbd_translate;
+    ppc_md.kbd_unexpected_up = xilinx_kbd_unexpected_up;
+    ppc_md.kbd_leds          = NULL;
+    ppc_md.kbd_init_hw       = xilinx_kbd_init_hw;
+#ifdef CONFIG_MAGIC_SYSRQ
+    ppc_md.ppc_kbd_sysrq_xlate   = xilinx_kbd_sysrq_xlate;
+#endif /* CONFIG_MAGIC_SYSRQ */
+#endif /* CONFIG_VT */
+
+}
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/arch/ppc/platforms/xseg2.h linuxppc_2_4_xseg2.new.clean2/arch/ppc/platforms/xseg2.h
--- linuxppc_2_4_clean/arch/ppc/platforms/xseg2.h	1970-01-01 01:00:00.000000000 +0100
+++ linuxppc_2_4_xseg2.new.clean2/arch/ppc/platforms/xseg2.h	2002-09-01 17:55:56.000000000 +0200
@@ -0,0 +1,102 @@
+/*
+ * xseg2.h
+ *
+ * Copyright 2002 Mind NV
+ *
+ * http://www.mind.be/
+ *
+ * Author : Peter De Schrijver (p2@mind.be)
+ *
+ * This software may be used and distributed according to the terms of
+ * the GNU General Public License (GPL) version 2, incorporated herein by
+ * reference. Drivers based on or derived from this code fall under the GPL
+ * and must retain the authorship, copyright and this license notice. This
+ * file is not a complete program and may only be used when the entire
+ * operating system is licensed under the GPL.
+ *
+ */
+
+
+#ifdef __KERNEL__
+#ifndef __XSEG2_H__
+#define __XSEG2_H__
+
+#include <linux/config.h>
+#include <asm/ppcboot.h>
+
+#ifndef __ASSEMBLY__
+
+#define bi_tbfreq bi_intfreq
+
+extern void *xseg2_gpio_base;
+
+#endif
+
+#define XSEG2_GPIO_PADDR	((uint)0x90000000)
+#define XSEG2_GPIO_SIZE	((uint)16)
+
+#define PPC4xx_PCI_IO_PADDR	((uint)0xB8000000)
+#define PPC4xx_PCI_IO_VADDR	PPC4xx_PCI_IO_PADDR
+#define PPC4xx_PCI_IO_SIZE	((uint)64*1024)
+#define PPC4xx_PCI_CFG_PADDR	((uint)0xBC020000)
+#define PPC4xx_PCI_CFG_VADDR	PPC4xx_PCI_CFG_PADDR
+#define PPC4xx_PCI_CFG_SIZE	((uint)4*1024)
+
+/* serial defines */
+#define BASE_BAUD		3125000
+
+#define PPC4xx_MACHINE_NAME "Xilinx Virtex 2 Pro Development board"
+
+/* serial port defines */
+#ifdef CONFIG_SERIAL_MANY_PORTS
+#define RS_TABLE_SIZE   64
+#else
+#define RS_TABLE_SIZE   4
+#endif
+
+#define UART0_INT   31
+#define UART1_INT   1
+
+#define UART0_IO_BASE   (u8 *) 0xE0001003
+#define UART1_IO_BASE   (u8 *) 0xE0011003
+
+#ifdef CONFIG_SERIAL_DETECT_IRQ
+#define STD_COM_FLAGS   (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)#define STD_COM4_FLAGS  (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
+#else
+#define STD_COM_FLAGS   (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
+#define STD_COM4_FLAGS  (ASYNC_BOOT_AUTOCONF)
+#endif
+
+#define STD_UART_OP(num)                                        \
+        { 0, BASE_BAUD, 0, UART##num##_INT, STD_COM_FLAGS,      \
+                iomem_base: UART##num##_IO_BASE,                \
+                io_type: SERIAL_IO_MEM, \
+                iomem_reg_shift: 2,},
+
+#if defined(CONFIG_UART0_TTYS0)
+#define SERIAL_PORT_DFNS        \
+		STD_UART_OP(0)          \
+		STD_UART_OP(1)
+#endif
+
+#if defined(CONFIG_UART0_TTYS1) || defined (CONFIG_UART1_DFLT_CONSOLE)
+#define SERIAL_PORT_DFNS        \
+		STD_UART_OP(1)          \
+	    STD_UART_OP(0)
+#endif
+
+/* XINTC defines */
+
+#define DCRN_XINTC0_BASE      0xE0020FC0
+
+#define DCRN_XINTC0_ISR    ((unsigned int *)(DCRN_XINTC0_BASE + (0x0<<2)))
+#define DCRN_XINTC0_IPR    ((unsigned int *)(DCRN_XINTC0_BASE + (0x1<<2)))
+#define DCRN_XINTC0_IER    ((unsigned int *)(DCRN_XINTC0_BASE + (0x2<<2)))
+#define DCRN_XINTC0_IAR    ((unsigned int *)(DCRN_XINTC0_BASE + (0x3<<2)))
+#define DCRN_XINTC0_SIE    ((unsigned int *)(DCRN_XINTC0_BASE + (0x4<<2)))
+#define DCRN_XINTC0_CIE    ((unsigned int *)(DCRN_XINTC0_BASE + (0x5<<2)))
+#define DCRN_XINTC0_IVR    ((unsigned int *)(DCRN_XINTC0_BASE + (0x6<<2)))
+#define DCRN_XINTC0_MER    ((unsigned int *)(DCRN_XINTC0_BASE + (0x7<<2)))
+
+#endif /* __XSEG2_H__ */
+#endif /* __KERNEL__ */
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/include/asm-ppc/ibm4xx.h linuxppc_2_4_xseg2.new.clean2/include/asm-ppc/ibm4xx.h
--- linuxppc_2_4_clean/include/asm-ppc/ibm4xx.h	2002-07-20 12:03:50.000000000 +0200
+++ linuxppc_2_4_xseg2.new.clean2/include/asm-ppc/ibm4xx.h	2002-09-04 20:55:19.000000000 +0200
@@ -105,6 +105,10 @@
 #include <platforms/beech.h>
 #endif

+#if defined(CONFIG_XSEG2)
+#include <platforms/xseg2.h>
+#endif
+
 #ifndef PPC4xx_MACHINE_NAME
 #define PPC4xx_MACHINE_NAME	"Unidentified 4xx class"
 #endif

--SFyWQ0h3ruR435lw--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

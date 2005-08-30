Return-Path: <Tony.Li@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 31F37681AC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 18:55:34 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	j7U92fAE022583 for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 02:02:41 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j7U8xZXH016178
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 03:59:37 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467302C7C0CC@zch01exm40.ap.freescale.net>
From: Li Tony-r64360 <Tony.Li@freescale.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Tue, 30 Aug 2005 16:55:26 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5AD40.9086BA2F"
Cc: Li Tony-r64360 <Tony.Li@freescale.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
Subject: [PATCH] ppc32 :Added PCI support for MPC83xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5AD40.9086BA2F
Content-Type: text/plain

MPC83xx cpu has two PCI buses. This patch adds support for them.
 
After system boot. The code initializes PCI inbound/outbound
windows, allocate and register PCI memory/io space. Be aware
that this patch depand on the firmware.
 
Signed-off-by: Tony Li <tony.li@freescale.com <mailto:tony.li@freescale.com> >
 
---
author Tony Li <tony.li@freescale.com <mailto:tony.li@freescale.com> > Tue, 30 Aug 2005
committer Tony Li <tony.li@freescale.com <mailto:tony.li@freescale.com> > Tue, 30 Aug 2005
 
diff -urN -X dontdiff linux-2.6.13-rc6/arch/ppc/Kconfig linux-2.6.13-rc6-pci/arch/ppc/Kconfig
--- linux-2.6.13-rc6/arch/ppc/Kconfig 2005-08-09 18:00:47.000000000 +0800
+++ linux-2.6.13-rc6-pci/arch/ppc/Kconfig 2005-08-19 18:17:27.000000000 +0800
@@ -712,6 +712,11 @@
  bool "Freescale MPC834x SYS"
  help
    This option enables support for the MPC 834x SYS evaluation board.
+   Be aware that PCI buses can only function when SYS board is plugged on
+   PIB (Platform IO Board) board from Freescale which provide 3 PCI slots.
+   Just like PC,the board level initalization is bootloader`s responsiblilty.
+   The PCI deponds on bootloader configurate board corretly. Refer to Freescale
+   to get more information about this. 
 
 endchoice
 
@@ -1191,6 +1196,10 @@
  bool
  default PCI
 
+config MPC834x_PCI2
+ bool
+ default y if PCI && MPC834x_SYS
+
 config PCI_QSPAN
  bool "QSpan PCI"
  depends on !4xx && !CPM2 && 8xx
diff -urN -X dontdiff linux-2.6.13-rc6/arch/ppc/platforms/83xx/mpc834x_sys.c linux-2.6.13-rc6-pci/arch/ppc/platforms/83xx/mpc834x_sys.c
--- linux-2.6.13-rc6/arch/ppc/platforms/83xx/mpc834x_sys.c 2005-08-09 18:00:47.000000000 +0800
+++ linux-2.6.13-rc6-pci/arch/ppc/platforms/83xx/mpc834x_sys.c 2005-08-30 16:38:52.000000000 +0800
@@ -62,9 +62,28 @@
 unsigned char __res[sizeof (bd_t)];
 
 #ifdef CONFIG_PCI
-#error "PCI is not supported"
-/* NEED mpc83xx_map_irq & mpc83xx_exclude_device
-   see platforms/85xx/mpc85xx_ads_common.c */
+int
+mpc83xx_ads_map_irq(struct pci_dev *dev,unsigned char idsel,unsigned char pin)
+{
+ char pci_irq_table[][4]=
+ /*
+  *      PCI IDSEL&INTPIN -> INTLINE
+  *      INTA    INTB    INTC    INTD
+  */
+ {
+  {PIRQA, PIRQB,  PIRQC,  PIRQD}, /* idsel 0x11 */
+  {PIRQC, PIRQD,  PIRQA,  PIRQB}, /* idsel 0x12 */
+  {PIRQD, PIRQA,  PIRQB,  PIRQC}  /* idsel 0x13 */
+ };
+ /* MPC8349 MDS board specific */
+ const long min_idsel=0x11,max_idsel=0x13,irqs_per_slot=4;
+ return PCI_IRQ_TABLE_LOOKUP;
+}
+int
+mpc83xx_ads_exclude_device(u_char bus, u_char devfn)
+{
+ return PCIBIOS_SUCCESSFUL;
+}
 #endif /* CONFIG_PCI */
 
 /* ************************************************************************
@@ -88,7 +107,7 @@
 
 #ifdef CONFIG_PCI
  /* setup PCI host bridges */
- mpc83xx_sys_setup_hose();
+ mpc83xx_setup_hose();
 #endif
  mpc83xx_early_serial_map();
 
@@ -175,10 +194,10 @@
   IRQ_SENSE_LEVEL, /* EXT 1 */
   IRQ_SENSE_LEVEL, /* EXT 2 */
   0,   /* EXT 3 */
-  0,   /* EXT 4 */
-  0,   /* EXT 5 */
-  0,   /* EXT 6 */
-  0,   /* EXT 7 */
+  IRQ_SENSE_LEVEL, /* EXT 4 */
+  IRQ_SENSE_LEVEL, /* EXT 5 */
+  IRQ_SENSE_LEVEL, /* EXT 6 */
+  IRQ_SENSE_LEVEL, /* EXT 7 */
  };
 
  ipic_init(binfo->bi_immr_base + 0x00700, 0, MPC83xx_IPIC_IRQ_OFFSET, senses, 8);
diff -urN -X dontdiff linux-2.6.13-rc6/arch/ppc/platforms/83xx/mpc834x_sys.h linux-2.6.13-rc6-pci/arch/ppc/platforms/83xx/mpc834x_sys.h
--- linux-2.6.13-rc6/arch/ppc/platforms/83xx/mpc834x_sys.h 2005-06-18 03:48:29.000000000 +0800
+++ linux-2.6.13-rc6-pci/arch/ppc/platforms/83xx/mpc834x_sys.h 2005-08-23 10:00:08.000000000 +0800
@@ -26,7 +26,7 @@
 #define VIRT_IMMRBAR  ((uint)0xfe000000)
 
 #define BCSR_PHYS_ADDR  ((uint)0xf8000000)
-#define BCSR_SIZE  ((uint)(32 * 1024))
+#define BCSR_SIZE               ((uint)(128 * 1024))
 
 #define BCSR_MISC_REG2_OFF 0x07
 #define BCSR_MISC_REG2_PORESET 0x01
@@ -35,22 +35,34 @@
 #define BCSR_MISC_REG3_CNFLOCK 0x80
 
 #ifdef CONFIG_PCI
-/* PCI interrupt controller */
-#define PIRQA        MPC83xx_IRQ_IRQ4
-#define PIRQB        MPC83xx_IRQ_IRQ5
-#define PIRQC        MPC83xx_IRQ_IRQ6
-#define PIRQD        MPC83xx_IRQ_IRQ7
-
-#define MPC834x_SYS_PCI1_LOWER_IO        0x00000000
-#define MPC834x_SYS_PCI1_UPPER_IO        0x00ffffff
 
-#define MPC834x_SYS_PCI1_LOWER_MEM       0x80000000
-#define MPC834x_SYS_PCI1_UPPER_MEM       0x9fffffff
+#define PCI1_CFG_ADDR_OFFSET (0x8300)
+#define PCI1_CFG_DATA_OFFSET (0x8304)
 
-#define MPC834x_SYS_PCI1_IO_BASE         0xe2000000
-#define MPC834x_SYS_PCI1_MEM_OFFSET      0x00000000
+#define PCI2_CFG_ADDR_OFFSET (0x8380)
+#define PCI2_CFG_DATA_OFFSET (0x8384)
+
+#define PIRQA MPC83xx_IRQ_EXT4
+#define PIRQB MPC83xx_IRQ_EXT5
+#define PIRQC MPC83xx_IRQ_EXT6
+#define PIRQD MPC83xx_IRQ_EXT7
+
+#define MPC83xx_PCI1_LOWER_IO 0x00000000
+#define MPC83xx_PCI1_UPPER_IO 0x00ffffff
+#define MPC83xx_PCI1_LOWER_MEM 0x80000000
+#define MPC83xx_PCI1_UPPER_MEM 0x9fffffff
+#define MPC83xx_PCI1_IO_BASE 0xe2000000
+#define MPC83xx_PCI1_MEM_OFFSET 0x00000000
+#define MPC83xx_PCI1_IO_SIZE 0x01000000
+
+#define MPC83xx_PCI2_LOWER_IO 0x00000000
+#define MPC83xx_PCI2_UPPER_IO 0x00ffffff
+#define MPC83xx_PCI2_LOWER_MEM 0xa0000000
+#define MPC83xx_PCI2_UPPER_MEM 0xbfffffff
+#define MPC83xx_PCI2_IO_BASE 0xe3000000
+#define MPC83xx_PCI2_MEM_OFFSET 0x00000000
+#define MPC83xx_PCI2_IO_SIZE 0x01000000
 
-#define MPC834x_SYS_PCI1_IO_SIZE         0x01000000
 #endif /* CONFIG_PCI */
 
 #endif                /* __MACH_MPC83XX_SYS_H__ */
diff -urN -X dontdiff linux-2.6.13-rc6/arch/ppc/syslib/ppc834x_pci.h linux-2.6.13-rc6-pci/arch/ppc/syslib/ppc834x_pci.h
--- linux-2.6.13-rc6/arch/ppc/syslib/ppc834x_pci.h 1970-01-01 08:30:00.000000000 +0830
+++ linux-2.6.13-rc6-pci/arch/ppc/syslib/ppc834x_pci.h 2005-08-19 18:30:11.000000000 +0800
@@ -0,0 +1,161 @@
+/* Created by Tony Li <tony.li@freescale.com <mailto:tony.li@freescale.com> > 2005.6
+ * Copyright (c) 2005 freescale semiconductor
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __MPC834X_PCI_H__
+#define __MPC834X_PCI_H__
+
+typedef struct immr_clk {
+ u32 spmr; /* system PLL mode Register  */
+ u32 occr; /* output clock control Register  */
+ u32 sccr; /* system clock control Register  */
+ u8 res0[0xF4];
+} immr_clk_t;
+
+/*
+ * PCI Software Configuration Registers
+ */
+typedef struct immr_pciconf {
+ u32 config_address;
+ u32 config_data;
+ u32 int_ack;
+ u8 res[116];
+} immr_pciconf_t;
+
+/*
+ * Sequencer
+ */
+typedef struct immr_ios {
+ u32 potar0;
+ u8 res0[4];
+ u32 pobar0;
+ u8 res1[4];
+ u32 pocmr0;
+ u8 res2[4];
+        u32 potar1;
+        u8 res3[4];
+        u32 pobar1;
+        u8 res4[4];
+        u32 pocmr1;
+        u8 res5[4];
+        u32 potar2;
+        u8 res6[4];
+        u32 pobar2;
+        u8 res7[4];
+        u32 pocmr2;
+        u8 res8[4];
+        u32 potar3;
+        u8 res9[4];
+        u32 pobar3;
+        u8 res10[4];
+        u32 pocmr3;
+        u8 res11[4];
+        u32 potar4;
+        u8 res12[4];
+        u32 pobar4;
+        u8 res13[4];
+        u32 pocmr4;
+        u8 res14[4];
+        u32 potar5;
+        u8 res15[4];
+        u32 pobar5;
+        u8 res16[4];
+        u32 pocmr5;
+        u8 res17[4];
+ u8 res18[0x60];
+ u32 pmcr;
+ u8 res19[4];
+ u32 dtcr;
+ u8 res20[4];
+} immr_ios_t;
+#define POTAR_TA_MASK 0x000fffff
+#define POBAR_BA_MASK 0x000fffff
+#define POCMR_EN 0x80000000
+#define POCMR_IO 0x40000000 /* 0--memory space 1--I/O space */
+#define POCMR_SE 0x20000000 /* streaming enable */
+#define POCMR_DST 0x10000000 /* 0--PCI1 1--PCI2 */
+#define POCMR_CM_MASK 0x000fffff
+
+/*
+ * PCI Controller Control and Status Registers
+ */
+typedef struct immr_pcictrl {
+ u32 esr;
+ u32 ecdr;
+ u32 eer;
+ u32 eatcr;
+ u32 eacr;
+ u32 eeacr;
+ u32 edlcr;
+ u32 edhcr;
+ u32 gcr;
+ u32 ecr;
+ u32 gsr;
+ u8 res0[12];
+ u32 pitar2;
+ u8 res1[4];
+ u32 pibar2;
+ u32 piebar2;
+ u32 piwar2;
+ u8 res2[4];
+ u32 pitar1;
+ u8 res3[4];
+ u32 pibar1;
+ u32 piebar1;
+ u32 piwar1;
+ u8 res4[4];
+ u32 pitar0;
+ u8 res5[4];
+ u32 pibar0;
+ u8 res6[4];
+ u32 piwar0;
+ u8 res7[132];
+} immr_pcictrl_t;
+#define PITAR_TA_MASK 0x000fffff
+#define PIBAR_MASK 0xffffffff
+#define PIEBAR_EBA_MASK 0x000fffff
+#define PIWAR_EN 0x80000000
+#define PIWAR_PF 0x20000000
+#define PIWAR_RTT_MASK 0x000f0000
+#define PIWAR_RTT_NO_SNOOP 0x00040000
+#define PIWAR_RTT_SNOOP 0x00050000
+#define PIWAR_WTT_MASK 0x0000f000
+#define PIWAR_WTT_NO_SNOOP 0x00004000
+#define PIWAR_WTT_SNOOP 0x00005000
+#define PIWAR_IWS_MASK 0x0000003F
+#define PIWAR_IWS_4K 0x0000000B
+#define PIWAR_IWS_8K 0x0000000C
+#define PIWAR_IWS_16K 0x0000000D
+#define PIWAR_IWS_32K 0x0000000E
+#define PIWAR_IWS_64K 0x0000000F
+#define PIWAR_IWS_128K 0x00000010
+#define PIWAR_IWS_256K 0x00000011
+#define PIWAR_IWS_512K 0x00000012
+#define PIWAR_IWS_1M 0x00000013
+#define PIWAR_IWS_2M 0x00000014
+#define PIWAR_IWS_4M 0x00000015
+#define PIWAR_IWS_8M 0x00000016
+#define PIWAR_IWS_16M 0x00000017
+#define PIWAR_IWS_32M 0x00000018
+#define PIWAR_IWS_64M 0x00000019
+#define PIWAR_IWS_128M 0x0000001A
+#define PIWAR_IWS_256M 0x0000001B
+#define PIWAR_IWS_512M 0x0000001C
+#define PIWAR_IWS_1G 0x0000001D
+#define PIWAR_IWS_2G 0x0000001E
+
+#endif /*__MPC834X_PCI_H__*/
diff -urN -X dontdiff linux-2.6.13-rc6/arch/ppc/syslib/ppc83xx_setup.c linux-2.6.13-rc6-pci/arch/ppc/syslib/ppc83xx_setup.c
--- linux-2.6.13-rc6/arch/ppc/syslib/ppc83xx_setup.c 2005-08-09 18:00:47.000000000 +0800
+++ linux-2.6.13-rc6-pci/arch/ppc/syslib/ppc83xx_setup.c 2005-08-23 10:18:04.000000000 +0800
@@ -11,6 +11,20 @@
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * July 2005, Tony Li<tony.li@freescale.com <mailto:tony.li@freescale.com> >
+ *      Added PCI support
+ * PCI can be enabled only if MPC834x SYS board combined with PIB(Platform
+ * IO Board) board in which three physical PCI slots locate.
  */
 
 #include <linux/config.h>
@@ -19,7 +33,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/serial.h>
-#include <linux/tty.h> /* for linux/serial_core.h */
+#include <linux/tty.h>  /* for linux/serial_core.h */
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
 
@@ -31,27 +45,29 @@
 #include <asm/delay.h>
 
 #include <syslib/ppc83xx_setup.h>
+#if defined(CONFIG_PCI)
+#include <asm/delay.h>
+#include <syslib/ppc834x_pci.h>
+#endif
 
 phys_addr_t immrbar;
 
 /* Return the amount of memory */
-unsigned long __init
-mpc83xx_find_end_of_memory(void)
+unsigned long __init mpc83xx_find_end_of_memory(void)
 {
-        bd_t *binfo;
+ bd_t *binfo;
 
-        binfo = (bd_t *) __res;
+ binfo = (bd_t *) __res;
 
-        return binfo->bi_memsize;
+ return binfo->bi_memsize;
 }
 
-long __init
-mpc83xx_time_init(void)
+long __init mpc83xx_time_init(void)
 {
 #define SPCR_OFFS   0x00000110
 #define SPCR_TBEN   0x00400000
 
- bd_t *binfo = (bd_t *)__res;
+ bd_t *binfo = (bd_t *) __res;
  u32 *spcr = ioremap(binfo->bi_immr_base + SPCR_OFFS, 4);
 
  *spcr |= SPCR_TBEN;
@@ -62,11 +78,10 @@
 }
 
 /* The decrementer counts at the system (internal) clock freq divided by 4 */
-void __init
-mpc83xx_calibrate_decr(void)
+void __init mpc83xx_calibrate_decr(void)
 {
-        bd_t *binfo = (bd_t *) __res;
-        unsigned int freq, divisor;
+ bd_t *binfo = (bd_t *) __res;
+ unsigned int freq, divisor;
 
  freq = binfo->bi_busfreq;
  divisor = 4;
@@ -75,15 +90,14 @@
 }
 
 #ifdef CONFIG_SERIAL_8250
-void __init
-mpc83xx_early_serial_map(void)
+void __init mpc83xx_early_serial_map(void)
 {
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
  struct uart_port serial_req;
 #endif
  struct plat_serial8250_port *pdata;
  bd_t *binfo = (bd_t *) __res;
- pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(MPC83xx_DUART);
+ pdata = (struct plat_serial8250_port *)ppc_sys_get_pdata(MPC83xx_DUART);
 
  /* Setup serial port access */
  pdata[0].uartclk = binfo->bi_busfreq;
@@ -91,7 +105,7 @@
  pdata[0].membase = ioremap(pdata[0].mapbase, 0x100);
 
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
- memset(&serial_req, 0, sizeof (serial_req));
+ memset(&serial_req, 0, sizeof(serial_req));
  serial_req.iotype = SERIAL_IO_MEM;
  serial_req.mapbase = pdata[0].mapbase;
  serial_req.membase = pdata[0].membase;
@@ -114,8 +128,7 @@
 }
 #endif
 
-void
-mpc83xx_restart(char *cmd)
+void mpc83xx_restart(char *cmd)
 {
  volatile unsigned char __iomem *reg;
  unsigned char tmp;
@@ -129,7 +142,7 @@
   * Otherwise the reset asserts but doesn't clear.
   */
  tmp = in_8(reg + BCSR_MISC_REG3_OFF);
- tmp |= BCSR_MISC_REG3_CNFLOCK; /* low true, high false */
+ tmp |= BCSR_MISC_REG3_CNFLOCK; /* low true, high false */
  out_8(reg + BCSR_MISC_REG3_OFF, tmp);
 
  /*
@@ -145,21 +158,252 @@
  tmp |= BCSR_MISC_REG2_PORESET;
  out_8(reg + BCSR_MISC_REG2_OFF, tmp);
 
- for(;;);
+ for (;;) ;
 }
 
-void
-mpc83xx_power_off(void)
+void mpc83xx_power_off(void)
 {
  local_irq_disable();
- for(;;);
+ for (;;) ;
 }
 
-void
-mpc83xx_halt(void)
+void mpc83xx_halt(void)
 {
  local_irq_disable();
- for(;;);
+ for (;;) ;
+}
+
+#if defined(CONFIG_PCI)
+void __init mpc83xx_setup_pci1(struct pci_controller *hose)
+{
+ unsigned short reg16;
+ volatile immr_pcictrl_t *pci_ctrl;
+ volatile immr_ios_t *ios;
+ bd_t *binfo = (bd_t *) __res;
+
+ pci_ctrl = ioremap(binfo->bi_immr_base + 0x8500,
+      sizeof(immr_pcictrl_t));
+ ios = ioremap(binfo->bi_immr_base + 0x8400, sizeof(immr_ios_t));
+
+ /*
+  * Configure PCI Outbound Translation Windows
+  */
+ ios->potar0 = (MPC83xx_PCI1_LOWER_MEM >> 12) & POTAR_TA_MASK;
+ ios->pobar0 = (MPC83xx_PCI1_LOWER_MEM >> 12) & POBAR_BA_MASK;
+ ios->pocmr0 = POCMR_EN |
+     (((~0UL -
+        (MPC83xx_PCI1_UPPER_MEM -
+  MPC83xx_PCI1_LOWER_MEM)) >> 12) & POCMR_CM_MASK);
+
+ /* mapped to PCI1 IO space 0x0 to local 0xe2000000  */
+ ios->potar1 = (MPC83xx_PCI1_LOWER_IO >> 12) & POTAR_TA_MASK;
+ ios->pobar1 = (MPC83xx_PCI1_IO_BASE >> 12) & POBAR_BA_MASK;
+ ios->pocmr1 = POCMR_EN | POCMR_IO |
+     (((~0UL -
+        (MPC83xx_PCI1_UPPER_IO -
+  MPC83xx_PCI1_LOWER_IO)) >> 12) & POCMR_CM_MASK);
+
+ /*
+  * Configure PCI Inbound Translation Windows
+  */
+ pci_ctrl->pitar1 = 0x0;
+ pci_ctrl->pibar1 = 0x0;
+ pci_ctrl->piebar1 = 0x0;
+ pci_ctrl->piwar1 =
+     PIWAR_EN | PIWAR_PF | PIWAR_RTT_SNOOP | PIWAR_WTT_SNOOP |
+     PIWAR_IWS_2G;
+
+ /*
+  * Release PCI RST signal
+  */
+ pci_ctrl->gcr = 0;
+ udelay(2000);
+ pci_ctrl->gcr = 1;
+ udelay(2000);
+
+ reg16 = 0xff;
+ early_read_config_word(hose, hose->first_busno, 0, PCI_COMMAND, &reg16);
+ reg16 |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
+ early_write_config_word(hose, hose->first_busno, 0, PCI_COMMAND, reg16);
+
+ /*
+  * Clear non-reserved bits in status register.
+  */
+ early_write_config_word(hose, hose->first_busno, 0, PCI_STATUS, 0xffff);
+ early_write_config_byte(hose, hose->first_busno, 0, PCI_LATENCY_TIMER,
+    0x80);
 }
 
-/* PCI SUPPORT DOES NOT EXIT, MODEL after ppc85xx_setup.c */
+void __init mpc834x_ads_setup_pci2(struct pci_controller *hose)
+{
+ unsigned short reg16;
+ volatile immr_pcictrl_t *pci_ctrl;
+ volatile immr_ios_t *ios;
+ bd_t *binfo = (bd_t *) __res;
+
+ pci_ctrl = ioremap(binfo->bi_immr_base + 0x8600,
+      sizeof(immr_pcictrl_t));
+ ios = ioremap(binfo->bi_immr_base + 0x8400, sizeof(immr_ios_t));
+
+ /*
+  * Configure PCI Outbound Translation Windows
+  */
+ ios->potar3 = (MPC83xx_PCI2_LOWER_MEM >> 12) & POTAR_TA_MASK;
+ ios->pobar3 = (MPC83xx_PCI2_LOWER_MEM >> 12) & POBAR_BA_MASK;
+ ios->pocmr3 = POCMR_EN | POCMR_DST |
+     (((~0UL -
+        (MPC83xx_PCI2_UPPER_MEM -
+  MPC83xx_PCI2_LOWER_MEM)) >> 12) & POCMR_CM_MASK);
+
+ /* mapped to PCI2 IO space 0x0 to local 0xe3000000  */
+ ios->potar4 = (MPC83xx_PCI2_LOWER_IO >> 12) & POTAR_TA_MASK;
+ ios->pobar4 = (MPC83xx_PCI2_IO_BASE >> 12) & POBAR_BA_MASK;
+ ios->pocmr4 = POCMR_EN | POCMR_DST | POCMR_IO |
+     (((~0UL -
+        (MPC83xx_PCI2_UPPER_IO -
+  MPC83xx_PCI2_LOWER_IO)) >> 12) & POCMR_CM_MASK);
+
+ /*
+  * Configure PCI Inbound Translation Windows
+  */
+ pci_ctrl->pitar1 = 0x0;
+ pci_ctrl->pibar1 = 0x0;
+ pci_ctrl->piebar1 = 0x0;
+ pci_ctrl->piwar1 =
+     PIWAR_EN | PIWAR_PF | PIWAR_RTT_SNOOP | PIWAR_WTT_SNOOP |
+     PIWAR_IWS_2G;
+
+ /*
+  * Release PCI RST signal
+  */
+ pci_ctrl->gcr = 0;
+ udelay(2000);
+ pci_ctrl->gcr = 1;
+ udelay(2000);
+
+ reg16 = 0xff;
+ early_read_config_word(hose, hose->first_busno, 0, PCI_COMMAND, &reg16);
+ reg16 |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
+ early_write_config_word(hose, hose->first_busno, 0, PCI_COMMAND, reg16);
+
+ /*
+  * Clear non-reserved bits in status register.
+  */
+ early_write_config_word(hose, hose->first_busno, 0, PCI_STATUS, 0xffff);
+ early_write_config_byte(hose, hose->first_busno, 0, PCI_LATENCY_TIMER,
+    0x80);
+}
+
+extern int mpc83xx_ads_map_irq(struct pci_dev *dev, unsigned char idsel,
+          unsigned char pin);
+extern int mpc83xx_ads_exclude_device(u_char bus, u_char devfn);
+
+/*
+ * PCI buses can be enabled only if SYS board combinates with PIB(Platform IO Board) board
+ * which provide 3 PCI slots. There is 2 PCI buses and 3 PCI slots,so people must configure
+ * the routes between them before enable PCI bus. This routes are under the control of PCA9555PW 
+ * device which can be accessed via I2C bus 2 and are configured by firmware. Refer to Freescale to
+ * get more information about firmware configuration.
+ */
+void __init mpc83xx_setup_hose(void)
+{
+ unsigned long val32;
+ volatile immr_clk_t *clk;
+ volatile struct pci_controller *hose1;
+#ifdef CONFIG_MPC834x_PCI2
+ volatile struct pci_controller *hose2;
+#endif
+ volatile bd_t *binfo = (bd_t *) __res;
+
+ clk = ioremap(binfo->bi_immr_base + 0xA00, sizeof(immr_clk_t));
+
+ /*
+  * Configure PCI controller and PCI_CLK_OUTPUT both in 66M mode
+  */
+ val32 = clk->occr;
+ udelay(2000);
+ clk->occr = 0xff000000;
+ udelay(2000);
+
+ hose1 = pcibios_alloc_controller();
+ if (!hose1)
+  return;
+
+ ppc_md.pci_swizzle = common_swizzle;
+ ppc_md.pci_map_irq = mpc83xx_ads_map_irq;
+
+ hose1->bus_offset = 0;
+ hose1->first_busno = 0;
+ hose1->last_busno = 0xff;
+
+ setup_indirect_pci(hose1, binfo->bi_immr_base + PCI1_CFG_ADDR_OFFSET,
+      binfo->bi_immr_base + PCI1_CFG_DATA_OFFSET);
+ hose1->set_cfg_type = 1;
+
+ mpc83xx_setup_pci1(hose1);
+
+ hose1->pci_mem_offset = MPC83xx_PCI1_MEM_OFFSET;
+ hose1->mem_space.start = MPC83xx_PCI1_LOWER_MEM;
+ hose1->mem_space.end = MPC83xx_PCI1_UPPER_MEM;
+
+ hose1->io_base_phys = MPC83xx_PCI1_IO_BASE;
+ hose1->io_space.start = MPC83xx_PCI1_LOWER_IO;
+ hose1->io_space.end = MPC83xx_PCI1_UPPER_IO;
+#ifdef CONFIG_MPC834x_PCI2
+ isa_io_base = (unsigned long)ioremap(MPC83xx_PCI1_IO_BASE,
+          MPC83xx_PCI1_IO_SIZE +
+          MPC83xx_PCI2_IO_SIZE);
+#else
+ isa_io_base = (unsigned long)ioremap(MPC83xx_PCI1_IO_BASE,
+          MPC83xx_PCI1_IO_SIZE);
+#endif    /* CONFIG_MPC834x_PCI2 */
+ hose1->io_base_virt = (void *)isa_io_base;
+ /* setup resources */
+ pci_init_resource(&hose1->io_resource,
+     MPC83xx_PCI1_LOWER_IO,
+     MPC83xx_PCI1_UPPER_IO,
+     IORESOURCE_IO, "PCI host bridge 1");
+ pci_init_resource(&hose1->mem_resources[0],
+     MPC83xx_PCI1_LOWER_MEM,
+     MPC83xx_PCI1_UPPER_MEM,
+     IORESOURCE_MEM, "PCI host bridge 1");
+
+ ppc_md.pci_exclude_device = mpc83xx_ads_exclude_device;
+ hose1->last_busno = pciauto_bus_scan(hose1, hose1->first_busno);
+
+#ifdef CONFIG_MPC834x_PCI2
+ hose2 = pcibios_alloc_controller();
+ if (!hose2)
+  return;
+
+ hose2->bus_offset = hose1->last_busno + 1;
+ hose2->first_busno = hose1->last_busno + 1;
+ hose2->last_busno = 0xff;
+ setup_indirect_pci(hose2, binfo->bi_immr_base + PCI2_CFG_ADDR_OFFSET,
+      binfo->bi_immr_base + PCI2_CFG_DATA_OFFSET);
+ hose2->set_cfg_type = 1;
+
+ mpc834x_ads_setup_pci2(hose2);
+
+ hose2->pci_mem_offset = MPC83xx_PCI2_MEM_OFFSET;
+ hose2->mem_space.start = MPC83xx_PCI2_LOWER_MEM;
+ hose2->mem_space.end = MPC83xx_PCI2_UPPER_MEM;
+
+ hose2->io_base_phys = MPC83xx_PCI2_IO_BASE;
+ hose2->io_space.start = MPC83xx_PCI2_LOWER_IO;
+ hose2->io_space.end = MPC83xx_PCI2_UPPER_IO;
+ hose2->io_base_virt = (void *)(isa_io_base + MPC83xx_PCI1_IO_SIZE);
+ /* setup resources */
+ pci_init_resource(&hose2->io_resource,
+     MPC83xx_PCI2_LOWER_IO,
+     MPC83xx_PCI2_UPPER_IO,
+     IORESOURCE_IO, "PCI host bridge 2");
+ pci_init_resource(&hose2->mem_resources[0],
+     MPC83xx_PCI2_LOWER_MEM,
+     MPC83xx_PCI2_UPPER_MEM,
+     IORESOURCE_MEM, "PCI host bridge 2");
+
+ hose2->last_busno = pciauto_bus_scan(hose2, hose2->first_busno);
+#endif    /* CONFIG_MPC834x_PCI2 */
+}
+#endif    /*CONFIG_PCI */
diff -urN -X dontdiff linux-2.6.13-rc6/arch/ppc/syslib/ppc83xx_setup.h linux-2.6.13-rc6-pci/arch/ppc/syslib/ppc83xx_setup.h
--- linux-2.6.13-rc6/arch/ppc/syslib/ppc83xx_setup.h 2005-06-18 03:48:29.000000000 +0800
+++ linux-2.6.13-rc6-pci/arch/ppc/syslib/ppc83xx_setup.h 2005-08-23 10:25:43.000000000 +0800
@@ -12,6 +12,14 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #ifndef __PPC_SYSLIB_PPC83XX_SETUP_H
@@ -20,6 +28,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <asm/ppcboot.h>
+#include <asm/mpc83xx.h>
 
 extern unsigned long mpc83xx_find_end_of_memory(void) __init;
 extern long mpc83xx_time_init(void) __init;
@@ -30,15 +39,6 @@
 extern void mpc83xx_halt(void);
 extern void mpc83xx_setup_hose(void) __init;
 
-/* PCI config */
-#if 0
-#define PCI1_CFG_ADDR_OFFSET (FIXME)
-#define PCI1_CFG_DATA_OFFSET (FIXME)
-
-#define PCI2_CFG_ADDR_OFFSET (FIXME)
-#define PCI2_CFG_DATA_OFFSET (FIXME)
-#endif
-
 /* Serial Config */
 #ifdef CONFIG_SERIAL_MANY_PORTS
 #define RS_TABLE_SIZE  64
@@ -50,4 +50,4 @@
 #define BASE_BAUD 115200
 #endif
 
-#endif /* __PPC_SYSLIB_PPC83XX_SETUP_H */
+#endif    /* __PPC_SYSLIB_PPC83XX_SETUP_H */


------_=_NextPart_001_01C5AD40.9086BA2F
Content-Type: text/html
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgSFRUUC1FUVVJVj0iQ29udGVudC1UeXBlIiBDT05U
RU5UPSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9VVMtQVNDSUkiPg0KDQoNCjxNRVRBIGNvbnRlbnQ9Ik1T
SFRNTCA2LjAwLjI4MDAuMTQ5MSIgbmFtZT1HRU5FUkFUT1I+PC9IRUFEPg0KPEJPRFk+DQo8RElW
PjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPk1QQzgzeHggY3B1IGhhcyB0d28gUENJIGJ1c2VzLiBU
aGlzIHBhdGNoIGFkZHMgDQpzdXBwb3J0IGZvciB0aGVtLjwvRk9OVD48L0RJVj4NCjxESVY+Jm5i
c3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPkFmdGVyIHN5c3RlbSBib290
LiBUaGUgY29kZSBpbml0aWFsaXplcyBQQ0kgDQppbmJvdW5kL291dGJvdW5kPEJSPndpbmRvd3Ms
IGFsbG9jYXRlIGFuZCByZWdpc3RlciBQQ0kgbWVtb3J5L2lvIHNwYWNlLiBCZSANCmF3YXJlPEJS
PnRoYXQgdGhpcyBwYXRjaCBkZXBhbmQgb24gdGhlIGZpcm13YXJlLjwvRk9OVD48L0RJVj4NCjxE
SVY+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPlNpZ25lZC1vZmYt
Ynk6IFRvbnkgTGkgJmx0OzxBIA0KaHJlZj0ibWFpbHRvOnRvbnkubGlAZnJlZXNjYWxlLmNvbSI+
dG9ueS5saUBmcmVlc2NhbGUuY29tPC9BPiZndDs8L0ZPTlQ+PC9ESVY+DQo8RElWPiZuYnNwOzwv
RElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj4tLS08QlI+YXV0aG9yIFRvbnkgTGkg
Jmx0OzxBIA0KaHJlZj0ibWFpbHRvOnRvbnkubGlAZnJlZXNjYWxlLmNvbSI+dG9ueS5saUBmcmVl
c2NhbGUuY29tPC9BPiZndDsgVHVlLCAzMCBBdWcgDQoyMDA1PEJSPmNvbW1pdHRlciBUb255IExp
ICZsdDs8QSANCmhyZWY9Im1haWx0bzp0b255LmxpQGZyZWVzY2FsZS5jb20iPnRvbnkubGlAZnJl
ZXNjYWxlLmNvbTwvQT4mZ3Q7IFR1ZSwgMzAgQXVnIA0KMjAwNTwvRk9OVD48L0RJVj4NCjxESVY+
Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPmRpZmYgLXVyTiAtWCBk
b250ZGlmZiANCmxpbnV4LTIuNi4xMy1yYzYvYXJjaC9wcGMvS2NvbmZpZyBsaW51eC0yLjYuMTMt
cmM2LXBjaS9hcmNoL3BwYy9LY29uZmlnPEJSPi0tLSANCmxpbnV4LTIuNi4xMy1yYzYvYXJjaC9w
cGMvS2NvbmZpZyZuYnNwOzIwMDUtMDgtMDkgMTg6MDA6NDcuMDAwMDAwMDAwIA0KKzA4MDA8QlI+
KysrIGxpbnV4LTIuNi4xMy1yYzYtcGNpL2FyY2gvcHBjL0tjb25maWcmbmJzcDsyMDA1LTA4LTE5
IA0KMTg6MTc6MjcuMDAwMDAwMDAwICswODAwPEJSPkBAIC03MTIsNiArNzEyLDExIEBAPEJSPiZu
YnNwOyZuYnNwO2Jvb2wgIkZyZWVzY2FsZSANCk1QQzgzNHggU1lTIjxCUj4mbmJzcDsmbmJzcDto
ZWxwPEJSPiZuYnNwOyZuYnNwOyZuYnNwOyBUaGlzIG9wdGlvbiBlbmFibGVzIA0Kc3VwcG9ydCBm
b3IgdGhlIE1QQyA4MzR4IFNZUyBldmFsdWF0aW9uIGJvYXJkLjxCUj4rJm5ic3A7Jm5ic3A7IEJl
IGF3YXJlIHRoYXQgDQpQQ0kgYnVzZXMgY2FuIG9ubHkgZnVuY3Rpb24gd2hlbiBTWVMgYm9hcmQg
aXMgcGx1Z2dlZCBvbjxCUj4rJm5ic3A7Jm5ic3A7IFBJQiANCihQbGF0Zm9ybSBJTyBCb2FyZCkg
Ym9hcmQgZnJvbSBGcmVlc2NhbGUgd2hpY2ggcHJvdmlkZSAzIFBDSSANCnNsb3RzLjxCUj4rJm5i
c3A7Jm5ic3A7IEp1c3QgbGlrZSBQQyx0aGUgYm9hcmQgbGV2ZWwgaW5pdGFsaXphdGlvbiBpcyAN
CmJvb3Rsb2FkZXJgcyByZXNwb25zaWJsaWx0eS48QlI+KyZuYnNwOyZuYnNwOyBUaGUgUENJIGRl
cG9uZHMgb24gYm9vdGxvYWRlciANCmNvbmZpZ3VyYXRlIGJvYXJkIGNvcnJldGx5LiBSZWZlciB0
byBGcmVlc2NhbGU8QlI+KyZuYnNwOyZuYnNwOyB0byBnZXQgbW9yZSANCmluZm9ybWF0aW9uIGFi
b3V0IHRoaXMuIDxCUj4mbmJzcDs8QlI+Jm5ic3A7ZW5kY2hvaWNlPEJSPiZuYnNwOzxCUj5AQCAt
MTE5MSw2IA0KKzExOTYsMTAgQEA8QlI+Jm5ic3A7Jm5ic3A7Ym9vbDxCUj4mbmJzcDsmbmJzcDtk
ZWZhdWx0IFBDSTxCUj4mbmJzcDs8QlI+K2NvbmZpZyANCk1QQzgzNHhfUENJMjxCUj4rJm5ic3A7
Ym9vbDxCUj4rJm5ic3A7ZGVmYXVsdCB5IGlmIFBDSSAmYW1wOyZhbXA7IA0KTVBDODM0eF9TWVM8
QlI+KzxCUj4mbmJzcDtjb25maWcgUENJX1FTUEFOPEJSPiZuYnNwOyZuYnNwO2Jvb2wgIlFTcGFu
IA0KUENJIjxCUj4mbmJzcDsmbmJzcDtkZXBlbmRzIG9uICE0eHggJmFtcDsmYW1wOyAhQ1BNMiAm
YW1wOyZhbXA7IDh4eDxCUj5kaWZmIC11ck4gDQotWCBkb250ZGlmZiBsaW51eC0yLjYuMTMtcmM2
L2FyY2gvcHBjL3BsYXRmb3Jtcy84M3h4L21wYzgzNHhfc3lzLmMgDQpsaW51eC0yLjYuMTMtcmM2
LXBjaS9hcmNoL3BwYy9wbGF0Zm9ybXMvODN4eC9tcGM4MzR4X3N5cy5jPEJSPi0tLSANCmxpbnV4
LTIuNi4xMy1yYzYvYXJjaC9wcGMvcGxhdGZvcm1zLzgzeHgvbXBjODM0eF9zeXMuYyZuYnNwOzIw
MDUtMDgtMDkgDQoxODowMDo0Ny4wMDAwMDAwMDAgKzA4MDA8QlI+KysrIA0KbGludXgtMi42LjEz
LXJjNi1wY2kvYXJjaC9wcGMvcGxhdGZvcm1zLzgzeHgvbXBjODM0eF9zeXMuYyZuYnNwOzIwMDUt
MDgtMzAgDQoxNjozODo1Mi4wMDAwMDAwMDAgKzA4MDA8QlI+QEAgLTYyLDkgKzYyLDI4IEBAPEJS
PiZuYnNwO3Vuc2lnbmVkIGNoYXIgDQpfX3Jlc1tzaXplb2YgKGJkX3QpXTs8QlI+Jm5ic3A7PEJS
PiZuYnNwOyNpZmRlZiBDT05GSUdfUENJPEJSPi0jZXJyb3IgIlBDSSBpcyANCm5vdCBzdXBwb3J0
ZWQiPEJSPi0vKiBORUVEIG1wYzgzeHhfbWFwX2lycSAmYW1wOyANCm1wYzgzeHhfZXhjbHVkZV9k
ZXZpY2U8QlI+LSZuYnNwOyZuYnNwOyBzZWUgcGxhdGZvcm1zLzg1eHgvbXBjODV4eF9hZHNfY29t
bW9uLmMgDQoqLzxCUj4raW50PEJSPittcGM4M3h4X2Fkc19tYXBfaXJxKHN0cnVjdCBwY2lfZGV2
ICpkZXYsdW5zaWduZWQgY2hhciANCmlkc2VsLHVuc2lnbmVkIGNoYXIgcGluKTxCUj4rezxCUj4r
Jm5ic3A7Y2hhciANCnBjaV9pcnFfdGFibGVbXVs0XT08QlI+KyZuYnNwOy8qPEJSPismbmJzcDsg
KiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBQQ0kgDQpJRFNFTCZhbXA7SU5UUElOIC0m
Z3Q7IElOVExJTkU8QlI+KyZuYnNwOyAqJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0K
SU5UQSZuYnNwOyZuYnNwOyZuYnNwOyBJTlRCJm5ic3A7Jm5ic3A7Jm5ic3A7IElOVEMmbmJzcDsm
bmJzcDsmbmJzcDsgDQpJTlREPEJSPismbmJzcDsgKi88QlI+KyZuYnNwO3s8QlI+KyZuYnNwOyZu
YnNwO3tQSVJRQSwgUElSUUIsJm5ic3A7IFBJUlFDLCZuYnNwOyANClBJUlFEfSwgLyogaWRzZWwg
MHgxMSAqLzxCUj4rJm5ic3A7Jm5ic3A7e1BJUlFDLCBQSVJRRCwmbmJzcDsgUElSUUEsJm5ic3A7
IA0KUElSUUJ9LCAvKiBpZHNlbCAweDEyICovPEJSPismbmJzcDsmbmJzcDt7UElSUUQsIFBJUlFB
LCZuYnNwOyBQSVJRQiwmbmJzcDsgDQpQSVJRQ30mbmJzcDsgLyogaWRzZWwgMHgxMyAqLzxCUj4r
Jm5ic3A7fTs8QlI+KyZuYnNwOy8qIE1QQzgzNDkgTURTIGJvYXJkIA0Kc3BlY2lmaWMgKi88QlI+
KyZuYnNwO2NvbnN0IGxvbmcgDQptaW5faWRzZWw9MHgxMSxtYXhfaWRzZWw9MHgxMyxpcnFzX3Bl
cl9zbG90PTQ7PEJSPismbmJzcDtyZXR1cm4gDQpQQ0lfSVJRX1RBQkxFX0xPT0tVUDs8QlI+K308
QlI+K2ludDxCUj4rbXBjODN4eF9hZHNfZXhjbHVkZV9kZXZpY2UodV9jaGFyIGJ1cywgDQp1X2No
YXIgZGV2Zm4pPEJSPit7PEJSPismbmJzcDtyZXR1cm4gUENJQklPU19TVUNDRVNTRlVMOzxCUj4r
fTxCUj4mbmJzcDsjZW5kaWYgDQovKiBDT05GSUdfUENJICovPEJSPiZuYnNwOzxCUj4mbmJzcDsv
KiANCioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKjxCUj5AQCANCi04OCw3ICsxMDcsNyBAQDxCUj4mbmJzcDs8QlI+
Jm5ic3A7I2lmZGVmIENPTkZJR19QQ0k8QlI+Jm5ic3A7Jm5ic3A7Lyogc2V0dXAgUENJIA0KaG9z
dCBicmlkZ2VzIA0KKi88QlI+LSZuYnNwO21wYzgzeHhfc3lzX3NldHVwX2hvc2UoKTs8QlI+KyZu
YnNwO21wYzgzeHhfc2V0dXBfaG9zZSgpOzxCUj4mbmJzcDsjZW5kaWY8QlI+Jm5ic3A7Jm5ic3A7
bXBjODN4eF9lYXJseV9zZXJpYWxfbWFwKCk7PEJSPiZuYnNwOzxCUj5AQCANCi0xNzUsMTAgKzE5
NCwxMCBAQDxCUj4mbmJzcDsmbmJzcDsmbmJzcDtJUlFfU0VOU0VfTEVWRUwsJm5ic3A7LyogRVhU
IDEgDQoqLzxCUj4mbmJzcDsmbmJzcDsmbmJzcDtJUlFfU0VOU0VfTEVWRUwsJm5ic3A7LyogRVhU
IDIgDQoqLzxCUj4mbmJzcDsmbmJzcDsmbmJzcDswLCZuYnNwOyZuYnNwOyZuYnNwOy8qIEVYVCAz
IA0KKi88QlI+LSZuYnNwOyZuYnNwOzAsJm5ic3A7Jm5ic3A7Jm5ic3A7LyogRVhUIDQgDQoqLzxC
Uj4tJm5ic3A7Jm5ic3A7MCwmbmJzcDsmbmJzcDsmbmJzcDsvKiBFWFQgNSANCiovPEJSPi0mbmJz
cDsmbmJzcDswLCZuYnNwOyZuYnNwOyZuYnNwOy8qIEVYVCA2IA0KKi88QlI+LSZuYnNwOyZuYnNw
OzAsJm5ic3A7Jm5ic3A7Jm5ic3A7LyogRVhUIDcgDQoqLzxCUj4rJm5ic3A7Jm5ic3A7SVJRX1NF
TlNFX0xFVkVMLCZuYnNwOy8qIEVYVCA0IA0KKi88QlI+KyZuYnNwOyZuYnNwO0lSUV9TRU5TRV9M
RVZFTCwmbmJzcDsvKiBFWFQgNSANCiovPEJSPismbmJzcDsmbmJzcDtJUlFfU0VOU0VfTEVWRUws
Jm5ic3A7LyogRVhUIDYgDQoqLzxCUj4rJm5ic3A7Jm5ic3A7SVJRX1NFTlNFX0xFVkVMLCZuYnNw
Oy8qIEVYVCA3IA0KKi88QlI+Jm5ic3A7Jm5ic3A7fTs8QlI+Jm5ic3A7PEJSPiZuYnNwOyZuYnNw
O2lwaWNfaW5pdChiaW5mby0mZ3Q7YmlfaW1tcl9iYXNlICsgDQoweDAwNzAwLCAwLCBNUEM4M3h4
X0lQSUNfSVJRX09GRlNFVCwgc2Vuc2VzLCA4KTs8QlI+ZGlmZiAtdXJOIC1YIGRvbnRkaWZmIA0K
bGludXgtMi42LjEzLXJjNi9hcmNoL3BwYy9wbGF0Zm9ybXMvODN4eC9tcGM4MzR4X3N5cy5oIA0K
bGludXgtMi42LjEzLXJjNi1wY2kvYXJjaC9wcGMvcGxhdGZvcm1zLzgzeHgvbXBjODM0eF9zeXMu
aDxCUj4tLS0gDQpsaW51eC0yLjYuMTMtcmM2L2FyY2gvcHBjL3BsYXRmb3Jtcy84M3h4L21wYzgz
NHhfc3lzLmgmbmJzcDsyMDA1LTA2LTE4IA0KMDM6NDg6MjkuMDAwMDAwMDAwICswODAwPEJSPisr
KyANCmxpbnV4LTIuNi4xMy1yYzYtcGNpL2FyY2gvcHBjL3BsYXRmb3Jtcy84M3h4L21wYzgzNHhf
c3lzLmgmbmJzcDsyMDA1LTA4LTIzIA0KMTA6MDA6MDguMDAwMDAwMDAwICswODAwPEJSPkBAIC0y
Niw3ICsyNiw3IEBAPEJSPiZuYnNwOyNkZWZpbmUgDQpWSVJUX0lNTVJCQVImbmJzcDsmbmJzcDso
KHVpbnQpMHhmZTAwMDAwMCk8QlI+Jm5ic3A7PEJSPiZuYnNwOyNkZWZpbmUgDQpCQ1NSX1BIWVNf
QUREUiZuYnNwOyZuYnNwOygodWludCkweGY4MDAwMDAwKTxCUj4tI2RlZmluZSANCkJDU1JfU0la
RSZuYnNwOyZuYnNwOygodWludCkoMzIgKiAxMDI0KSk8QlI+KyNkZWZpbmUgDQpCQ1NSX1NJWkUm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQooKHVpbnQpKDEyOCAqIDEwMjQpKTxCUj4mbmJz
cDs8QlI+Jm5ic3A7I2RlZmluZSANCkJDU1JfTUlTQ19SRUcyX09GRiZuYnNwOzB4MDc8QlI+Jm5i
c3A7I2RlZmluZSANCkJDU1JfTUlTQ19SRUcyX1BPUkVTRVQmbmJzcDsweDAxPEJSPkBAIC0zNSwy
MiArMzUsMzQgQEA8QlI+Jm5ic3A7I2RlZmluZSANCkJDU1JfTUlTQ19SRUczX0NORkxPQ0smbmJz
cDsweDgwPEJSPiZuYnNwOzxCUj4mbmJzcDsjaWZkZWYgQ09ORklHX1BDSTxCUj4tLyogUENJIA0K
aW50ZXJydXB0IGNvbnRyb2xsZXIgKi88QlI+LSNkZWZpbmUgDQpQSVJRQSZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBNUEM4M3h4X0lSUV9JUlE0PEJSPi0jZGVmaW5l
IA0KUElSUUImbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgTVBDODN4
eF9JUlFfSVJRNTxCUj4tI2RlZmluZSANClBJUlFDJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IE1QQzgzeHhfSVJRX0lSUTY8QlI+LSNkZWZpbmUgDQpQSVJRRCZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyANCk1QQzgzeHhfSVJRX0lSUTc8
QlI+LTxCUj4tI2RlZmluZSANCk1QQzgzNHhfU1lTX1BDSTFfTE9XRVJfSU8mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQoweDAwMDAwMDAwPEJSPi0jZGVmaW5lIA0K
TVBDODM0eF9TWVNfUENJMV9VUFBFUl9JTyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyANCjB4MDBmZmZmZmY8QlI+Jm5ic3A7PEJSPi0jZGVmaW5lIA0KTVBDODM0eF9T
WVNfUENJMV9MT1dFUl9NRU0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQow
eDgwMDAwMDAwPEJSPi0jZGVmaW5lIA0KTVBDODM0eF9TWVNfUENJMV9VUFBFUl9NRU0mbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQoweDlmZmZmZmZmPEJSPisjZGVmaW5lJm5i
c3A7UENJMV9DRkdfQUREUl9PRkZTRVQmbmJzcDsoMHg4MzAwKTxCUj4rI2RlZmluZSZuYnNwO1BD
STFfQ0ZHX0RBVEFfT0ZGU0VUJm5ic3A7KDB4ODMwNCk8QlI+Jm5ic3A7PEJSPi0jZGVmaW5lIA0K
TVBDODM0eF9TWVNfUENJMV9JT19CQVNFJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IA0KMHhlMjAwMDAwMDxCUj4tI2RlZmluZSBNUEM4MzR4X1NZU19QQ0kx
X01FTV9PRkZTRVQmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQoweDAwMDAwMDAwPEJS
PisjZGVmaW5lJm5ic3A7UENJMl9DRkdfQUREUl9PRkZTRVQmbmJzcDsoMHg4MzgwKTxCUj4rI2Rl
ZmluZSZuYnNwO1BDSTJfQ0ZHX0RBVEFfT0ZGU0VUJm5ic3A7KDB4ODM4NCk8QlI+KzxCUj4rI2Rl
ZmluZSZuYnNwO1BJUlFBJm5ic3A7TVBDODN4eF9JUlFfRVhUNDxCUj4rI2RlZmluZSZuYnNwO1BJ
UlFCJm5ic3A7TVBDODN4eF9JUlFfRVhUNTxCUj4rI2RlZmluZSZuYnNwO1BJUlFDJm5ic3A7TVBD
ODN4eF9JUlFfRVhUNjxCUj4rI2RlZmluZSZuYnNwO1BJUlFEJm5ic3A7TVBDODN4eF9JUlFfRVhU
NzxCUj4rPEJSPisjZGVmaW5lJm5ic3A7TVBDODN4eF9QQ0kxX0xPV0VSX0lPJm5ic3A7MHgwMDAw
MDAwMDxCUj4rI2RlZmluZSZuYnNwO01QQzgzeHhfUENJMV9VUFBFUl9JTyZuYnNwOzB4MDBmZmZm
ZmY8QlI+KyNkZWZpbmUmbmJzcDtNUEM4M3h4X1BDSTFfTE9XRVJfTUVNJm5ic3A7MHg4MDAwMDAw
MDxCUj4rI2RlZmluZSZuYnNwO01QQzgzeHhfUENJMV9VUFBFUl9NRU0mbmJzcDsweDlmZmZmZmZm
PEJSPisjZGVmaW5lJm5ic3A7TVBDODN4eF9QQ0kxX0lPX0JBU0UmbmJzcDsweGUyMDAwMDAwPEJS
PisjZGVmaW5lJm5ic3A7TVBDODN4eF9QQ0kxX01FTV9PRkZTRVQmbmJzcDsweDAwMDAwMDAwPEJS
PisjZGVmaW5lJm5ic3A7TVBDODN4eF9QQ0kxX0lPX1NJWkUmbmJzcDsweDAxMDAwMDAwPEJSPis8
QlI+KyNkZWZpbmUmbmJzcDtNUEM4M3h4X1BDSTJfTE9XRVJfSU8mbmJzcDsweDAwMDAwMDAwPEJS
PisjZGVmaW5lJm5ic3A7TVBDODN4eF9QQ0kyX1VQUEVSX0lPJm5ic3A7MHgwMGZmZmZmZjxCUj4r
I2RlZmluZSZuYnNwO01QQzgzeHhfUENJMl9MT1dFUl9NRU0mbmJzcDsweGEwMDAwMDAwPEJSPisj
ZGVmaW5lJm5ic3A7TVBDODN4eF9QQ0kyX1VQUEVSX01FTSZuYnNwOzB4YmZmZmZmZmY8QlI+KyNk
ZWZpbmUmbmJzcDtNUEM4M3h4X1BDSTJfSU9fQkFTRSZuYnNwOzB4ZTMwMDAwMDA8QlI+KyNkZWZp
bmUmbmJzcDtNUEM4M3h4X1BDSTJfTUVNX09GRlNFVCZuYnNwOzB4MDAwMDAwMDA8QlI+KyNkZWZp
bmUmbmJzcDtNUEM4M3h4X1BDSTJfSU9fU0laRSZuYnNwOzB4MDEwMDAwMDA8QlI+Jm5ic3A7PEJS
Pi0jZGVmaW5lIA0KTVBDODM0eF9TWVNfUENJMV9JT19TSVpFJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0KMHgwMTAwMDAwMDxCUj4mbmJzcDsjZW5kaWYg
LyogQ09ORklHX1BDSSANCiovPEJSPiZuYnNwOzxCUj4mbmJzcDsjZW5kaWYmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgDQovKiBfX01BQ0hfTVBDODNYWF9TWVNfSF9fICovPEJSPmRp
ZmYgLXVyTiAtWCBkb250ZGlmZiANCmxpbnV4LTIuNi4xMy1yYzYvYXJjaC9wcGMvc3lzbGliL3Bw
YzgzNHhfcGNpLmggDQpsaW51eC0yLjYuMTMtcmM2LXBjaS9hcmNoL3BwYy9zeXNsaWIvcHBjODM0
eF9wY2kuaDxCUj4tLS0gDQpsaW51eC0yLjYuMTMtcmM2L2FyY2gvcHBjL3N5c2xpYi9wcGM4MzR4
X3BjaS5oJm5ic3A7MTk3MC0wMS0wMSANCjA4OjMwOjAwLjAwMDAwMDAwMCArMDgzMDxCUj4rKysg
DQpsaW51eC0yLjYuMTMtcmM2LXBjaS9hcmNoL3BwYy9zeXNsaWIvcHBjODM0eF9wY2kuaCZuYnNw
OzIwMDUtMDgtMTkgDQoxODozMDoxMS4wMDAwMDAwMDAgKzA4MDA8QlI+QEAgLTAsMCArMSwxNjEg
QEA8QlI+Ky8qIENyZWF0ZWQgYnkgVG9ueSBMaSAmbHQ7PEEgDQpocmVmPSJtYWlsdG86dG9ueS5s
aUBmcmVlc2NhbGUuY29tIj50b255LmxpQGZyZWVzY2FsZS5jb208L0E+Jmd0OyAyMDA1LjY8QlI+
KyAqIA0KQ29weXJpZ2h0IChjKSAyMDA1IGZyZWVzY2FsZSBzZW1pY29uZHVjdG9yPEJSPisgKjxC
Uj4rICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgDQpzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1
dGUmbmJzcDsgaXQgYW5kL29yIG1vZGlmeSBpdDxCUj4rICogdW5kZXImbmJzcDsgdGhlIA0KdGVy
bXMgb2YmbmJzcDsgdGhlIEdOVSBHZW5lcmFsJm5ic3A7IFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxp
c2hlZCBieSB0aGU8QlI+KyAqIA0KRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyZuYnNwOyBlaXRo
ZXIgdmVyc2lvbiAyIG9mIHRoZSZuYnNwOyBMaWNlbnNlLCBvciAoYXQgDQp5b3VyPEJSPisgKiBv
cHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLjxCUj4rICo8QlI+KyAqIFRoaXMgcHJvZ3JhbSBpcyBk
aXN0cmlidXRlZCANCmluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1dDxCUj4r
ICogV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgDQpldmVuIHRoZSBpbXBsaWVkIHdhcnJh
bnR5IG9mPEJSPisgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFS
IA0KUFVSUE9TRS4mbmJzcDsgU2VlIHRoZSBHTlU8QlI+KyAqIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgZm9yIG1vcmUgZGV0YWlscy48QlI+KyANCio8QlI+KyAqIFlvdSBzaG91bGQgaGF2ZSByZWNl
aXZlZCBhIGNvcHkgb2YgdGhlJm5ic3A7IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIA0KYWxv
bmc8QlI+KyAqIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlJm5ic3A7IHRvIHRoZSBG
cmVlIFNvZnR3YXJlIA0KRm91bmRhdGlvbiwgSW5jLiw8QlI+KyAqIDY3NSBNYXNzIEF2ZSwgQ2Ft
YnJpZGdlLCBNQSAwMjEzOSwgVVNBLjxCUj4rIA0KKi88QlI+KzxCUj4rI2lmbmRlZiZuYnNwO19f
TVBDODM0WF9QQ0lfSF9fPEJSPisjZGVmaW5lJm5ic3A7X19NUEM4MzRYX1BDSV9IX188QlI+KzxC
Uj4rdHlwZWRlZiANCnN0cnVjdCBpbW1yX2NsayB7PEJSPismbmJzcDt1MzIgc3BtcjsmbmJzcDsv
KiBzeXN0ZW0gUExMIG1vZGUgUmVnaXN0ZXImbmJzcDsgDQoqLzxCUj4rJm5ic3A7dTMyIG9jY3I7
Jm5ic3A7Lyogb3V0cHV0IGNsb2NrIGNvbnRyb2wgUmVnaXN0ZXImbmJzcDsgDQoqLzxCUj4rJm5i
c3A7dTMyIHNjY3I7Jm5ic3A7Lyogc3lzdGVtIGNsb2NrIGNvbnRyb2wgUmVnaXN0ZXImbmJzcDsg
DQoqLzxCUj4rJm5ic3A7dTggcmVzMFsweEY0XTs8QlI+K30gaW1tcl9jbGtfdDs8QlI+KzxCUj4r
Lyo8QlI+KyAqIFBDSSBTb2Z0d2FyZSANCkNvbmZpZ3VyYXRpb24gUmVnaXN0ZXJzPEJSPisgKi88
QlI+K3R5cGVkZWYgc3RydWN0IGltbXJfcGNpY29uZiB7PEJSPismbmJzcDt1MzIgDQpjb25maWdf
YWRkcmVzczs8QlI+KyZuYnNwO3UzMiBjb25maWdfZGF0YTs8QlI+KyZuYnNwO3UzMiBpbnRfYWNr
OzxCUj4rJm5ic3A7dTggDQpyZXNbMTE2XTs8QlI+K30gaW1tcl9wY2ljb25mX3Q7PEJSPis8QlI+
Ky8qPEJSPisgKiBTZXF1ZW5jZXI8QlI+KyAqLzxCUj4rdHlwZWRlZiANCnN0cnVjdCBpbW1yX2lv
cyB7PEJSPismbmJzcDt1MzIgcG90YXIwOzxCUj4rJm5ic3A7dTggcmVzMFs0XTs8QlI+KyZuYnNw
O3UzMiANCnBvYmFyMDs8QlI+KyZuYnNwO3U4IHJlczFbNF07PEJSPismbmJzcDt1MzIgcG9jbXIw
OzxCUj4rJm5ic3A7dTggDQpyZXMyWzRdOzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IHUzMiANCnBvdGFyMTs8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyB1OCANCnJlczNbNF07PEJSPismbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdTMyIA0KcG9iYXIxOzxCUj4rJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHU4IA0KcmVzNFs0XTs8QlI+KyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1MzIgDQpwb2NtcjE7PEJSPismbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdTggDQpyZXM1WzRdOzxCUj4rJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHUzMiANCnBvdGFyMjs8QlI+
KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1OCANCnJlczZbNF07
PEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdTMyIA0KcG9i
YXIyOzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHU4IA0K
cmVzN1s0XTs8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1
MzIgDQpwb2NtcjI7PEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgdTggDQpyZXM4WzRdOzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IHUzMiANCnBvdGFyMzs8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyB1OCANCnJlczlbNF07PEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgdTMyIA0KcG9iYXIzOzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IHU4IA0KcmVzMTBbNF07PEJSPismbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdTMyIA0KcG9jbXIzOzxCUj4rJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHU4IA0KcmVzMTFbNF07PEJSPismbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdTMyIA0KcG90YXI0OzxCUj4rJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHU4IA0KcmVzMTJbNF07PEJSPism
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdTMyIA0KcG9iYXI0OzxC
Uj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHU4IA0KcmVzMTNb
NF07PEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdTMyIA0K
cG9jbXI0OzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHU4
IA0KcmVzMTRbNF07PEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgdTMyIA0KcG90YXI1OzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IHU4IA0KcmVzMTVbNF07PEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgdTMyIA0KcG9iYXI1OzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IHU4IA0KcmVzMTZbNF07PEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgdTMyIA0KcG9jbXI1OzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHU4IHJlczE3WzRdOzxCUj4rJm5ic3A7dTggDQpyZXMx
OFsweDYwXTs8QlI+KyZuYnNwO3UzMiBwbWNyOzxCUj4rJm5ic3A7dTggcmVzMTlbNF07PEJSPism
bmJzcDt1MzIgDQpkdGNyOzxCUj4rJm5ic3A7dTggcmVzMjBbNF07PEJSPit9IGltbXJfaW9zX3Q7
PEJSPisjZGVmaW5lIA0KUE9UQVJfVEFfTUFTSyZuYnNwOzB4MDAwZmZmZmY8QlI+KyNkZWZpbmUg
DQpQT0JBUl9CQV9NQVNLJm5ic3A7MHgwMDBmZmZmZjxCUj4rI2RlZmluZSBQT0NNUl9FTiZuYnNw
OzB4ODAwMDAwMDA8QlI+KyNkZWZpbmUgDQpQT0NNUl9JTyZuYnNwOzB4NDAwMDAwMDAmbmJzcDsv
KiAwLS1tZW1vcnkgc3BhY2UgMS0tSS9PIHNwYWNlICovPEJSPisjZGVmaW5lIA0KUE9DTVJfU0Um
bmJzcDsweDIwMDAwMDAwJm5ic3A7Lyogc3RyZWFtaW5nIGVuYWJsZSAqLzxCUj4rI2RlZmluZSAN
ClBPQ01SX0RTVCZuYnNwOzB4MTAwMDAwMDAmbmJzcDsvKiAwLS1QQ0kxIDEtLVBDSTIgKi88QlI+
KyNkZWZpbmUgDQpQT0NNUl9DTV9NQVNLJm5ic3A7MHgwMDBmZmZmZjxCUj4rPEJSPisvKjxCUj4r
ICogUENJIENvbnRyb2xsZXIgQ29udHJvbCBhbmQgDQpTdGF0dXMgUmVnaXN0ZXJzPEJSPisgKi88
QlI+K3R5cGVkZWYgc3RydWN0IGltbXJfcGNpY3RybCB7PEJSPismbmJzcDt1MzIgDQplc3I7PEJS
PismbmJzcDt1MzIgZWNkcjs8QlI+KyZuYnNwO3UzMiBlZXI7PEJSPismbmJzcDt1MzIgZWF0Y3I7
PEJSPismbmJzcDt1MzIgDQplYWNyOzxCUj4rJm5ic3A7dTMyIGVlYWNyOzxCUj4rJm5ic3A7dTMy
IGVkbGNyOzxCUj4rJm5ic3A7dTMyIA0KZWRoY3I7PEJSPismbmJzcDt1MzIgZ2NyOzxCUj4rJm5i
c3A7dTMyIGVjcjs8QlI+KyZuYnNwO3UzMiBnc3I7PEJSPismbmJzcDt1OCANCnJlczBbMTJdOzxC
Uj4rJm5ic3A7dTMyIHBpdGFyMjs8QlI+KyZuYnNwO3U4IHJlczFbNF07PEJSPismbmJzcDt1MzIg
DQpwaWJhcjI7PEJSPismbmJzcDt1MzIgcGllYmFyMjs8QlI+KyZuYnNwO3UzMiBwaXdhcjI7PEJS
PismbmJzcDt1OCANCnJlczJbNF07PEJSPismbmJzcDt1MzIgcGl0YXIxOzxCUj4rJm5ic3A7dTgg
cmVzM1s0XTs8QlI+KyZuYnNwO3UzMiANCnBpYmFyMTs8QlI+KyZuYnNwO3UzMiBwaWViYXIxOzxC
Uj4rJm5ic3A7dTMyIHBpd2FyMTs8QlI+KyZuYnNwO3U4IA0KcmVzNFs0XTs8QlI+KyZuYnNwO3Uz
MiBwaXRhcjA7PEJSPismbmJzcDt1OCByZXM1WzRdOzxCUj4rJm5ic3A7dTMyIA0KcGliYXIwOzxC
Uj4rJm5ic3A7dTggcmVzNls0XTs8QlI+KyZuYnNwO3UzMiBwaXdhcjA7PEJSPismbmJzcDt1OCAN
CnJlczdbMTMyXTs8QlI+K30gDQppbW1yX3BjaWN0cmxfdDs8QlI+KyNkZWZpbmUmbmJzcDtQSVRB
Ul9UQV9NQVNLJm5ic3A7MHgwMDBmZmZmZjxCUj4rI2RlZmluZSZuYnNwO1BJQkFSX01BU0smbmJz
cDsweGZmZmZmZmZmPEJSPisjZGVmaW5lJm5ic3A7UElFQkFSX0VCQV9NQVNLJm5ic3A7MHgwMDBm
ZmZmZjxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX0VOJm5ic3A7MHg4MDAwMDAwMDxCUj4rI2RlZmlu
ZSZuYnNwO1BJV0FSX1BGJm5ic3A7MHgyMDAwMDAwMDxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX1JU
VF9NQVNLJm5ic3A7MHgwMDBmMDAwMDxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX1JUVF9OT19TTk9P
UCZuYnNwOzB4MDAwNDAwMDA8QlI+KyNkZWZpbmUmbmJzcDtQSVdBUl9SVFRfU05PT1AmbmJzcDsw
eDAwMDUwMDAwPEJSPisjZGVmaW5lJm5ic3A7UElXQVJfV1RUX01BU0smbmJzcDsweDAwMDBmMDAw
PEJSPisjZGVmaW5lJm5ic3A7UElXQVJfV1RUX05PX1NOT09QJm5ic3A7MHgwMDAwNDAwMDxCUj4r
I2RlZmluZSZuYnNwO1BJV0FSX1dUVF9TTk9PUCZuYnNwOzB4MDAwMDUwMDA8QlI+KyNkZWZpbmUm
bmJzcDtQSVdBUl9JV1NfTUFTSyZuYnNwOzB4MDAwMDAwM0Y8QlI+KyNkZWZpbmUmbmJzcDtQSVdB
Ul9JV1NfNEsmbmJzcDsweDAwMDAwMDBCPEJSPisjZGVmaW5lJm5ic3A7UElXQVJfSVdTXzhLJm5i
c3A7MHgwMDAwMDAwQzxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX0lXU18xNksmbmJzcDsweDAwMDAw
MDBEPEJSPisjZGVmaW5lJm5ic3A7UElXQVJfSVdTXzMySyZuYnNwOzB4MDAwMDAwMEU8QlI+KyNk
ZWZpbmUmbmJzcDtQSVdBUl9JV1NfNjRLJm5ic3A7MHgwMDAwMDAwRjxCUj4rI2RlZmluZSZuYnNw
O1BJV0FSX0lXU18xMjhLJm5ic3A7MHgwMDAwMDAxMDxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX0lX
U18yNTZLJm5ic3A7MHgwMDAwMDAxMTxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX0lXU181MTJLJm5i
c3A7MHgwMDAwMDAxMjxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX0lXU18xTSZuYnNwOzB4MDAwMDAw
MTM8QlI+KyNkZWZpbmUmbmJzcDtQSVdBUl9JV1NfMk0mbmJzcDsweDAwMDAwMDE0PEJSPisjZGVm
aW5lJm5ic3A7UElXQVJfSVdTXzRNJm5ic3A7MHgwMDAwMDAxNTxCUj4rI2RlZmluZSZuYnNwO1BJ
V0FSX0lXU184TSZuYnNwOzB4MDAwMDAwMTY8QlI+KyNkZWZpbmUmbmJzcDtQSVdBUl9JV1NfMTZN
Jm5ic3A7MHgwMDAwMDAxNzxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX0lXU18zMk0mbmJzcDsweDAw
MDAwMDE4PEJSPisjZGVmaW5lJm5ic3A7UElXQVJfSVdTXzY0TSZuYnNwOzB4MDAwMDAwMTk8QlI+
KyNkZWZpbmUmbmJzcDtQSVdBUl9JV1NfMTI4TSZuYnNwOzB4MDAwMDAwMUE8QlI+KyNkZWZpbmUm
bmJzcDtQSVdBUl9JV1NfMjU2TSZuYnNwOzB4MDAwMDAwMUI8QlI+KyNkZWZpbmUmbmJzcDtQSVdB
Ul9JV1NfNTEyTSZuYnNwOzB4MDAwMDAwMUM8QlI+KyNkZWZpbmUmbmJzcDtQSVdBUl9JV1NfMUcm
bmJzcDsweDAwMDAwMDFEPEJSPisjZGVmaW5lJm5ic3A7UElXQVJfSVdTXzJHJm5ic3A7MHgwMDAw
MDAxRTxCUj4rPEJSPisjZW5kaWYgDQovKl9fTVBDODM0WF9QQ0lfSF9fKi88QlI+ZGlmZiAtdXJO
IC1YIGRvbnRkaWZmIA0KbGludXgtMi42LjEzLXJjNi9hcmNoL3BwYy9zeXNsaWIvcHBjODN4eF9z
ZXR1cC5jIA0KbGludXgtMi42LjEzLXJjNi1wY2kvYXJjaC9wcGMvc3lzbGliL3BwYzgzeHhfc2V0
dXAuYzxCUj4tLS0gDQpsaW51eC0yLjYuMTMtcmM2L2FyY2gvcHBjL3N5c2xpYi9wcGM4M3h4X3Nl
dHVwLmMmbmJzcDsyMDA1LTA4LTA5IA0KMTg6MDA6NDcuMDAwMDAwMDAwICswODAwPEJSPisrKyAN
CmxpbnV4LTIuNi4xMy1yYzYtcGNpL2FyY2gvcHBjL3N5c2xpYi9wcGM4M3h4X3NldHVwLmMmbmJz
cDsyMDA1LTA4LTIzIA0KMTA6MTg6MDQuMDAwMDAwMDAwICswODAwPEJSPkBAIC0xMSw2ICsxMSwy
MCBAQDxCUj4mbmJzcDsgKiB1bmRlciZuYnNwOyB0aGUgdGVybXMgDQpvZiZuYnNwOyB0aGUgR05V
IEdlbmVyYWwmbmJzcDsgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5IHRoZTxCUj4mbmJz
cDsgKiANCkZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsmbmJzcDsgZWl0aGVyIHZlcnNpb24gMiBv
ZiB0aGUmbmJzcDsgTGljZW5zZSwgb3IgKGF0IA0KeW91cjxCUj4mbmJzcDsgKiBvcHRpb24pIGFu
eSBsYXRlciB2ZXJzaW9uLjxCUj4rICo8QlI+KyAqIFRoaXMgcHJvZ3JhbSBpcyANCmRpc3RyaWJ1
dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1dDxCUj4rICogV0lUSE9V
VCBBTlkgV0FSUkFOVFk7IA0Kd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mPEJS
PisgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSANClBBUlRJQ1VMQVIgUFVSUE9T
RS4mbmJzcDsgU2VlIHRoZSBHTlU8QlI+KyAqIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1v
cmUgDQpkZXRhaWxzLjxCUj4rICo8QlI+KyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNv
cHkgb2YgdGhlJm5ic3A7IEdOVSBHZW5lcmFsIA0KUHVibGljIExpY2Vuc2UgYWxvbmc8QlI+KyAq
IHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlJm5ic3A7IHRvIHRoZSBGcmVlIA0KU29m
dHdhcmUgRm91bmRhdGlvbiwgSW5jLiw8QlI+KyAqIDY3NSBNYXNzIEF2ZSwgQ2FtYnJpZGdlLCBN
QSAwMjEzOSwgVVNBLjxCUj4rIA0KKjxCUj4rICogSnVseSAyMDA1LCBUb255IExpJmx0OzxBIA0K
aHJlZj0ibWFpbHRvOnRvbnkubGlAZnJlZXNjYWxlLmNvbSI+dG9ueS5saUBmcmVlc2NhbGUuY29t
PC9BPiZndDs8QlI+KyANCiombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgQWRkZWQgUENJ
IHN1cHBvcnQ8QlI+KyAqIFBDSSBjYW4gYmUgZW5hYmxlZCBvbmx5IA0KaWYgTVBDODM0eCBTWVMg
Ym9hcmQgY29tYmluZWQgd2l0aCBQSUIoUGxhdGZvcm08QlI+KyAqIElPIEJvYXJkKSBib2FyZCBp
biB3aGljaCANCnRocmVlIHBoeXNpY2FsIFBDSSBzbG90cyBsb2NhdGUuPEJSPiZuYnNwOyAqLzxC
Uj4mbmJzcDs8QlI+Jm5ic3A7I2luY2x1ZGUgDQombHQ7bGludXgvY29uZmlnLmgmZ3Q7PEJSPkBA
IC0xOSw3ICszMyw3IEBAPEJSPiZuYnNwOyNpbmNsdWRlIA0KJmx0O2xpbnV4L2luaXQuaCZndDs8
QlI+Jm5ic3A7I2luY2x1ZGUgJmx0O2xpbnV4L3BjaS5oJmd0OzxCUj4mbmJzcDsjaW5jbHVkZSAN
CiZsdDtsaW51eC9zZXJpYWwuaCZndDs8QlI+LSNpbmNsdWRlICZsdDtsaW51eC90dHkuaCZndDsm
bmJzcDsvKiBmb3IgDQpsaW51eC9zZXJpYWxfY29yZS5oICovPEJSPisjaW5jbHVkZSAmbHQ7bGlu
dXgvdHR5LmgmZ3Q7Jm5ic3A7Jm5ic3A7LyogZm9yIA0KbGludXgvc2VyaWFsX2NvcmUuaCAqLzxC
Uj4mbmJzcDsjaW5jbHVkZSANCiZsdDtsaW51eC9zZXJpYWxfY29yZS5oJmd0OzxCUj4mbmJzcDsj
aW5jbHVkZSANCiZsdDtsaW51eC9zZXJpYWxfODI1MC5oJmd0OzxCUj4mbmJzcDs8QlI+QEAgLTMx
LDI3ICs0NSwyOSBAQDxCUj4mbmJzcDsjaW5jbHVkZSANCiZsdDthc20vZGVsYXkuaCZndDs8QlI+
Jm5ic3A7PEJSPiZuYnNwOyNpbmNsdWRlIA0KJmx0O3N5c2xpYi9wcGM4M3h4X3NldHVwLmgmZ3Q7
PEJSPisjaWYgZGVmaW5lZChDT05GSUdfUENJKTxCUj4rI2luY2x1ZGUgDQombHQ7YXNtL2RlbGF5
LmgmZ3Q7PEJSPisjaW5jbHVkZSANCiZsdDtzeXNsaWIvcHBjODM0eF9wY2kuaCZndDs8QlI+KyNl
bmRpZjxCUj4mbmJzcDs8QlI+Jm5ic3A7cGh5c19hZGRyX3QgDQppbW1yYmFyOzxCUj4mbmJzcDs8
QlI+Jm5ic3A7LyogUmV0dXJuIHRoZSBhbW91bnQgb2YgbWVtb3J5ICovPEJSPi11bnNpZ25lZCBs
b25nIA0KX19pbml0PEJSPi1tcGM4M3h4X2ZpbmRfZW5kX29mX21lbW9yeSh2b2lkKTxCUj4rdW5z
aWduZWQgbG9uZyBfX2luaXQgDQptcGM4M3h4X2ZpbmRfZW5kX29mX21lbW9yeSh2b2lkKTxCUj4m
bmJzcDt7PEJSPi0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQpi
ZF90ICpiaW5mbzs8QlI+KyZuYnNwO2JkX3QgDQoqYmluZm87PEJSPiZuYnNwOzxCUj4tJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGJpbmZvID0gKGJkX3QgDQoqKSBf
X3Jlczs8QlI+KyZuYnNwO2JpbmZvID0gKGJkX3QgKikgDQpfX3Jlczs8QlI+Jm5ic3A7PEJSPi0m
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuIA0KYmluZm8t
Jmd0O2JpX21lbXNpemU7PEJSPismbmJzcDtyZXR1cm4gDQpiaW5mby0mZ3Q7YmlfbWVtc2l6ZTs8
QlI+Jm5ic3A7fTxCUj4mbmJzcDs8QlI+LWxvbmcgDQpfX2luaXQ8QlI+LW1wYzgzeHhfdGltZV9p
bml0KHZvaWQpPEJSPitsb25nIF9faW5pdCANCm1wYzgzeHhfdGltZV9pbml0KHZvaWQpPEJSPiZu
YnNwO3s8QlI+Jm5ic3A7I2RlZmluZSBTUENSX09GRlMmbmJzcDsmbmJzcDsgDQoweDAwMDAwMTEw
PEJSPiZuYnNwOyNkZWZpbmUgU1BDUl9UQkVOJm5ic3A7Jm5ic3A7IA0KMHgwMDQwMDAwMDxCUj4m
bmJzcDs8QlI+LSZuYnNwO2JkX3QgKmJpbmZvID0gKGJkX3QgKilfX3Jlczs8QlI+KyZuYnNwO2Jk
X3QgDQoqYmluZm8gPSAoYmRfdCAqKSBfX3Jlczs8QlI+Jm5ic3A7Jm5ic3A7dTMyICpzcGNyID0g
DQppb3JlbWFwKGJpbmZvLSZndDtiaV9pbW1yX2Jhc2UgKyBTUENSX09GRlMsIDQpOzxCUj4mbmJz
cDs8QlI+Jm5ic3A7Jm5ic3A7KnNwY3IgDQp8PSBTUENSX1RCRU47PEJSPkBAIC02MiwxMSArNzgs
MTAgQEA8QlI+Jm5ic3A7fTxCUj4mbmJzcDs8QlI+Jm5ic3A7LyogVGhlIA0KZGVjcmVtZW50ZXIg
Y291bnRzIGF0IHRoZSBzeXN0ZW0gKGludGVybmFsKSBjbG9jayBmcmVxIGRpdmlkZWQgYnkgNCAq
LzxCUj4tdm9pZCANCl9faW5pdDxCUj4tbXBjODN4eF9jYWxpYnJhdGVfZGVjcih2b2lkKTxCUj4r
dm9pZCBfX2luaXQgDQptcGM4M3h4X2NhbGlicmF0ZV9kZWNyKHZvaWQpPEJSPiZuYnNwO3s8QlI+
LSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyANCmJkX3QgKmJpbmZv
ID0gKGJkX3QgKikgX19yZXM7PEJSPi0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgDQp1bnNpZ25lZCBpbnQgZnJlcSwgZGl2aXNvcjs8QlI+KyZuYnNwO2JkX3QgKmJp
bmZvID0gKGJkX3QgKikgDQpfX3Jlczs8QlI+KyZuYnNwO3Vuc2lnbmVkIGludCBmcmVxLCBkaXZp
c29yOzxCUj4mbmJzcDs8QlI+Jm5ic3A7Jm5ic3A7ZnJlcSA9IA0KYmluZm8tJmd0O2JpX2J1c2Zy
ZXE7PEJSPiZuYnNwOyZuYnNwO2Rpdmlzb3IgPSA0OzxCUj5AQCAtNzUsMTUgKzkwLDE0IA0KQEA8
QlI+Jm5ic3A7fTxCUj4mbmJzcDs8QlI+Jm5ic3A7I2lmZGVmIENPTkZJR19TRVJJQUxfODI1MDxC
Uj4tdm9pZCANCl9faW5pdDxCUj4tbXBjODN4eF9lYXJseV9zZXJpYWxfbWFwKHZvaWQpPEJSPit2
b2lkIF9faW5pdCANCm1wYzgzeHhfZWFybHlfc2VyaWFsX21hcCh2b2lkKTxCUj4mbmJzcDt7PEJS
PiZuYnNwOyNpZiANCmRlZmluZWQoQ09ORklHX1NFUklBTF9URVhUX0RFQlVHKSB8fCBkZWZpbmVk
KENPTkZJR19LR0RCKTxCUj4mbmJzcDsmbmJzcDtzdHJ1Y3QgDQp1YXJ0X3BvcnQgc2VyaWFsX3Jl
cTs8QlI+Jm5ic3A7I2VuZGlmPEJSPiZuYnNwOyZuYnNwO3N0cnVjdCBwbGF0X3NlcmlhbDgyNTBf
cG9ydCANCipwZGF0YTs8QlI+Jm5ic3A7Jm5ic3A7YmRfdCAqYmluZm8gPSAoYmRfdCAqKSBfX3Jl
czs8QlI+LSZuYnNwO3BkYXRhID0gKHN0cnVjdCANCnBsYXRfc2VyaWFsODI1MF9wb3J0ICopIHBw
Y19zeXNfZ2V0X3BkYXRhKE1QQzgzeHhfRFVBUlQpOzxCUj4rJm5ic3A7cGRhdGEgPSANCihzdHJ1
Y3QgcGxhdF9zZXJpYWw4MjUwX3BvcnQgDQoqKXBwY19zeXNfZ2V0X3BkYXRhKE1QQzgzeHhfRFVB
UlQpOzxCUj4mbmJzcDs8QlI+Jm5ic3A7Jm5ic3A7LyogU2V0dXAgc2VyaWFsIA0KcG9ydCBhY2Nl
c3MgKi88QlI+Jm5ic3A7Jm5ic3A7cGRhdGFbMF0udWFydGNsayA9IGJpbmZvLSZndDtiaV9idXNm
cmVxOzxCUj5AQCANCi05MSw3ICsxMDUsNyBAQDxCUj4mbmJzcDsmbmJzcDtwZGF0YVswXS5tZW1i
YXNlID0gaW9yZW1hcChwZGF0YVswXS5tYXBiYXNlLCANCjB4MTAwKTs8QlI+Jm5ic3A7PEJSPiZu
YnNwOyNpZiBkZWZpbmVkKENPTkZJR19TRVJJQUxfVEVYVF9ERUJVRykgfHwgDQpkZWZpbmVkKENP
TkZJR19LR0RCKTxCUj4tJm5ic3A7bWVtc2V0KCZhbXA7c2VyaWFsX3JlcSwgMCwgc2l6ZW9mIA0K
KHNlcmlhbF9yZXEpKTs8QlI+KyZuYnNwO21lbXNldCgmYW1wO3NlcmlhbF9yZXEsIDAsIA0Kc2l6
ZW9mKHNlcmlhbF9yZXEpKTs8QlI+Jm5ic3A7Jm5ic3A7c2VyaWFsX3JlcS5pb3R5cGUgPSANClNF
UklBTF9JT19NRU07PEJSPiZuYnNwOyZuYnNwO3NlcmlhbF9yZXEubWFwYmFzZSA9IA0KcGRhdGFb
MF0ubWFwYmFzZTs8QlI+Jm5ic3A7Jm5ic3A7c2VyaWFsX3JlcS5tZW1iYXNlID0gcGRhdGFbMF0u
bWVtYmFzZTs8QlI+QEAgDQotMTE0LDggKzEyOCw3IA0KQEA8QlI+Jm5ic3A7fTxCUj4mbmJzcDsj
ZW5kaWY8QlI+Jm5ic3A7PEJSPi12b2lkPEJSPi1tcGM4M3h4X3Jlc3RhcnQoY2hhciANCipjbWQp
PEJSPit2b2lkIG1wYzgzeHhfcmVzdGFydChjaGFyICpjbWQpPEJSPiZuYnNwO3s8QlI+Jm5ic3A7
Jm5ic3A7dm9sYXRpbGUgDQp1bnNpZ25lZCBjaGFyIF9faW9tZW0gKnJlZzs8QlI+Jm5ic3A7Jm5i
c3A7dW5zaWduZWQgY2hhciB0bXA7PEJSPkBAIC0xMjksNyANCisxNDIsNyBAQDxCUj4mbmJzcDsm
bmJzcDsgKiBPdGhlcndpc2UgdGhlIHJlc2V0IGFzc2VydHMgYnV0IGRvZXNuJ3QgDQpjbGVhci48
QlI+Jm5ic3A7Jm5ic3A7ICovPEJSPiZuYnNwOyZuYnNwO3RtcCA9IGluXzgocmVnICsgDQpCQ1NS
X01JU0NfUkVHM19PRkYpOzxCUj4tJm5ic3A7dG1wIHw9IEJDU1JfTUlTQ19SRUczX0NORkxPQ0s7
IC8qIGxvdyB0cnVlLCBoaWdoIA0KZmFsc2UgKi88QlI+KyZuYnNwO3RtcCB8PSBCQ1NSX01JU0Nf
UkVHM19DTkZMT0NLOyZuYnNwOy8qIGxvdyB0cnVlLCBoaWdoIGZhbHNlIA0KKi88QlI+Jm5ic3A7
Jm5ic3A7b3V0XzgocmVnICsgQkNTUl9NSVNDX1JFRzNfT0ZGLCANCnRtcCk7PEJSPiZuYnNwOzxC
Uj4mbmJzcDsmbmJzcDsvKjxCUj5AQCAtMTQ1LDIxICsxNTgsMjUyIEBAPEJSPiZuYnNwOyZuYnNw
O3RtcCANCnw9IEJDU1JfTUlTQ19SRUcyX1BPUkVTRVQ7PEJSPiZuYnNwOyZuYnNwO291dF84KHJl
ZyArIEJDU1JfTUlTQ19SRUcyX09GRiwgDQp0bXApOzxCUj4mbmJzcDs8QlI+LSZuYnNwO2Zvcig7
Oyk7PEJSPismbmJzcDtmb3IgKDs7KSANCjs8QlI+Jm5ic3A7fTxCUj4mbmJzcDs8QlI+LXZvaWQ8
QlI+LW1wYzgzeHhfcG93ZXJfb2ZmKHZvaWQpPEJSPit2b2lkIA0KbXBjODN4eF9wb3dlcl9vZmYo
dm9pZCk8QlI+Jm5ic3A7ezxCUj4mbmJzcDsmbmJzcDtsb2NhbF9pcnFfZGlzYWJsZSgpOzxCUj4t
Jm5ic3A7Zm9yKDs7KTs8QlI+KyZuYnNwO2ZvciANCig7OykgOzxCUj4mbmJzcDt9PEJSPiZuYnNw
OzxCUj4tdm9pZDxCUj4tbXBjODN4eF9oYWx0KHZvaWQpPEJSPit2b2lkIA0KbXBjODN4eF9oYWx0
KHZvaWQpPEJSPiZuYnNwO3s8QlI+Jm5ic3A7Jm5ic3A7bG9jYWxfaXJxX2Rpc2FibGUoKTs8QlI+
LSZuYnNwO2Zvcig7Oyk7PEJSPismbmJzcDtmb3IgDQooOzspIDs8QlI+K308QlI+KzxCUj4rI2lm
IGRlZmluZWQoQ09ORklHX1BDSSk8QlI+K3ZvaWQgX19pbml0IA0KbXBjODN4eF9zZXR1cF9wY2kx
KHN0cnVjdCBwY2lfY29udHJvbGxlciAqaG9zZSk8QlI+K3s8QlI+KyZuYnNwO3Vuc2lnbmVkIHNo
b3J0IA0KcmVnMTY7PEJSPismbmJzcDt2b2xhdGlsZSBpbW1yX3BjaWN0cmxfdCAqcGNpX2N0cmw7
PEJSPismbmJzcDt2b2xhdGlsZSANCmltbXJfaW9zX3QgKmlvczs8QlI+KyZuYnNwO2JkX3QgKmJp
bmZvID0gKGJkX3QgKikgX19yZXM7PEJSPis8QlI+KyZuYnNwO3BjaV9jdHJsIA0KPSBpb3JlbWFw
KGJpbmZvLSZndDtiaV9pbW1yX2Jhc2UgKyAweDg1MDAsPEJSPismbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgDQpzaXplb2YoaW1tcl9wY2ljdHJsX3QpKTs8QlI+KyZuYnNwO2lvcyA9IGlv
cmVtYXAoYmluZm8tJmd0O2JpX2ltbXJfYmFzZSArIA0KMHg4NDAwLCBzaXplb2YoaW1tcl9pb3Nf
dCkpOzxCUj4rPEJSPismbmJzcDsvKjxCUj4rJm5ic3A7ICogQ29uZmlndXJlIFBDSSANCk91dGJv
dW5kIFRyYW5zbGF0aW9uIFdpbmRvd3M8QlI+KyZuYnNwOyAqLzxCUj4rJm5ic3A7aW9zLSZndDtw
b3RhcjAgPSANCihNUEM4M3h4X1BDSTFfTE9XRVJfTUVNICZndDsmZ3Q7IDEyKSAmYW1wOyANClBP
VEFSX1RBX01BU0s7PEJSPismbmJzcDtpb3MtJmd0O3BvYmFyMCA9IChNUEM4M3h4X1BDSTFfTE9X
RVJfTUVNICZndDsmZ3Q7IDEyKSANCiZhbXA7IFBPQkFSX0JBX01BU0s7PEJSPismbmJzcDtpb3Mt
Jmd0O3BvY21yMCA9IFBPQ01SX0VOIA0KfDxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICgo
KH4wVUwgDQotPEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
KE1QQzgzeHhfUENJMV9VUFBFUl9NRU0gDQotPEJSPismbmJzcDsmbmJzcDtNUEM4M3h4X1BDSTFf
TE9XRVJfTUVNKSkgJmd0OyZndDsgMTIpICZhbXA7IA0KUE9DTVJfQ01fTUFTSyk7PEJSPis8QlI+
KyZuYnNwOy8qIG1hcHBlZCB0byBQQ0kxIElPIHNwYWNlIDB4MCB0byBsb2NhbCANCjB4ZTIwMDAw
MDAmbmJzcDsgKi88QlI+KyZuYnNwO2lvcy0mZ3Q7cG90YXIxID0gKE1QQzgzeHhfUENJMV9MT1dF
Ul9JTyAmZ3Q7Jmd0OyANCjEyKSAmYW1wOyBQT1RBUl9UQV9NQVNLOzxCUj4rJm5ic3A7aW9zLSZn
dDtwb2JhcjEgPSAoTVBDODN4eF9QQ0kxX0lPX0JBU0UgDQomZ3Q7Jmd0OyAxMikgJmFtcDsgUE9C
QVJfQkFfTUFTSzs8QlI+KyZuYnNwO2lvcy0mZ3Q7cG9jbXIxID0gUE9DTVJfRU4gfCBQT0NNUl9J
TyANCnw8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAoKCh+MFVMIA0KLTxCUj4rJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IChNUEM4M3h4X1BDSTFfVVBQRVJf
SU8gDQotPEJSPismbmJzcDsmbmJzcDtNUEM4M3h4X1BDSTFfTE9XRVJfSU8pKSAmZ3Q7Jmd0OyAx
MikgJmFtcDsgDQpQT0NNUl9DTV9NQVNLKTs8QlI+KzxCUj4rJm5ic3A7Lyo8QlI+KyZuYnNwOyAq
IENvbmZpZ3VyZSBQQ0kgSW5ib3VuZCBUcmFuc2xhdGlvbiANCldpbmRvd3M8QlI+KyZuYnNwOyAq
LzxCUj4rJm5ic3A7cGNpX2N0cmwtJmd0O3BpdGFyMSA9IA0KMHgwOzxCUj4rJm5ic3A7cGNpX2N0
cmwtJmd0O3BpYmFyMSA9IDB4MDs8QlI+KyZuYnNwO3BjaV9jdHJsLSZndDtwaWViYXIxID0gDQow
eDA7PEJSPismbmJzcDtwY2lfY3RybC0mZ3Q7cGl3YXIxID08QlI+KyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBQSVdBUl9FTiB8IA0KUElXQVJfUEYgfCBQSVdBUl9SVFRfU05PT1AgfCBQSVdBUl9X
VFRfU05PT1AgfDxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0KUElXQVJfSVdTXzJHOzxC
Uj4rPEJSPismbmJzcDsvKjxCUj4rJm5ic3A7ICogUmVsZWFzZSBQQ0kgUlNUIHNpZ25hbDxCUj4r
Jm5ic3A7IA0KKi88QlI+KyZuYnNwO3BjaV9jdHJsLSZndDtnY3IgPSANCjA7PEJSPismbmJzcDt1
ZGVsYXkoMjAwMCk7PEJSPismbmJzcDtwY2lfY3RybC0mZ3Q7Z2NyID0gDQoxOzxCUj4rJm5ic3A7
dWRlbGF5KDIwMDApOzxCUj4rPEJSPismbmJzcDtyZWcxNiA9IA0KMHhmZjs8QlI+KyZuYnNwO2Vh
cmx5X3JlYWRfY29uZmlnX3dvcmQoaG9zZSwgaG9zZS0mZ3Q7Zmlyc3RfYnVzbm8sIDAsIA0KUENJ
X0NPTU1BTkQsICZhbXA7cmVnMTYpOzxCUj4rJm5ic3A7cmVnMTYgfD0gUENJX0NPTU1BTkRfU0VS
UiB8IA0KUENJX0NPTU1BTkRfTUFTVEVSIHwgUENJX0NPTU1BTkRfTUVNT1JZOzxCUj4rJm5ic3A7
ZWFybHlfd3JpdGVfY29uZmlnX3dvcmQoaG9zZSwgDQpob3NlLSZndDtmaXJzdF9idXNubywgMCwg
UENJX0NPTU1BTkQsIHJlZzE2KTs8QlI+KzxCUj4rJm5ic3A7Lyo8QlI+KyZuYnNwOyAqIA0KQ2xl
YXIgbm9uLXJlc2VydmVkIGJpdHMgaW4gc3RhdHVzIHJlZ2lzdGVyLjxCUj4rJm5ic3A7IA0KKi88
QlI+KyZuYnNwO2Vhcmx5X3dyaXRlX2NvbmZpZ193b3JkKGhvc2UsIGhvc2UtJmd0O2ZpcnN0X2J1
c25vLCAwLCBQQ0lfU1RBVFVTLCANCjB4ZmZmZik7PEJSPismbmJzcDtlYXJseV93cml0ZV9jb25m
aWdfYnl0ZShob3NlLCBob3NlLSZndDtmaXJzdF9idXNubywgMCwgDQpQQ0lfTEFURU5DWV9USU1F
Uiw8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOzB4ODApOzxCUj4mbmJzcDt9PEJSPiZuYnNw
OzxCUj4tLyogDQpQQ0kgU1VQUE9SVCBET0VTIE5PVCBFWElULCBNT0RFTCBhZnRlciBwcGM4NXh4
X3NldHVwLmMgKi88QlI+K3ZvaWQgX19pbml0IA0KbXBjODM0eF9hZHNfc2V0dXBfcGNpMihzdHJ1
Y3QgcGNpX2NvbnRyb2xsZXIgKmhvc2UpPEJSPit7PEJSPismbmJzcDt1bnNpZ25lZCANCnNob3J0
IHJlZzE2OzxCUj4rJm5ic3A7dm9sYXRpbGUgaW1tcl9wY2ljdHJsX3QgKnBjaV9jdHJsOzxCUj4r
Jm5ic3A7dm9sYXRpbGUgDQppbW1yX2lvc190ICppb3M7PEJSPismbmJzcDtiZF90ICpiaW5mbyA9
IChiZF90ICopIF9fcmVzOzxCUj4rPEJSPismbmJzcDtwY2lfY3RybCANCj0gaW9yZW1hcChiaW5m
by0mZ3Q7YmlfaW1tcl9iYXNlICsgMHg4NjAwLDxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IA0Kc2l6ZW9mKGltbXJfcGNpY3RybF90KSk7PEJSPismbmJzcDtpb3MgPSBpb3JlbWFw
KGJpbmZvLSZndDtiaV9pbW1yX2Jhc2UgKyANCjB4ODQwMCwgc2l6ZW9mKGltbXJfaW9zX3QpKTs8
QlI+KzxCUj4rJm5ic3A7Lyo8QlI+KyZuYnNwOyAqIENvbmZpZ3VyZSBQQ0kgDQpPdXRib3VuZCBU
cmFuc2xhdGlvbiBXaW5kb3dzPEJSPismbmJzcDsgKi88QlI+KyZuYnNwO2lvcy0mZ3Q7cG90YXIz
ID0gDQooTVBDODN4eF9QQ0kyX0xPV0VSX01FTSAmZ3Q7Jmd0OyAxMikgJmFtcDsgDQpQT1RBUl9U
QV9NQVNLOzxCUj4rJm5ic3A7aW9zLSZndDtwb2JhcjMgPSAoTVBDODN4eF9QQ0kyX0xPV0VSX01F
TSAmZ3Q7Jmd0OyAxMikgDQomYW1wOyBQT0JBUl9CQV9NQVNLOzxCUj4rJm5ic3A7aW9zLSZndDtw
b2NtcjMgPSBQT0NNUl9FTiB8IFBPQ01SX0RTVCANCnw8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyAoKCh+MFVMIA0KLTxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IChNUEM4M3h4X1BDSTJfVVBQRVJfTUVNIA0KLTxCUj4rJm5ic3A7Jm5ic3A7TVBDODN4
eF9QQ0kyX0xPV0VSX01FTSkpICZndDsmZ3Q7IDEyKSAmYW1wOyANClBPQ01SX0NNX01BU0spOzxC
Uj4rPEJSPismbmJzcDsvKiBtYXBwZWQgdG8gUENJMiBJTyBzcGFjZSAweDAgdG8gbG9jYWwgDQow
eGUzMDAwMDAwJm5ic3A7ICovPEJSPismbmJzcDtpb3MtJmd0O3BvdGFyNCA9IChNUEM4M3h4X1BD
STJfTE9XRVJfSU8gJmd0OyZndDsgDQoxMikgJmFtcDsgUE9UQVJfVEFfTUFTSzs8QlI+KyZuYnNw
O2lvcy0mZ3Q7cG9iYXI0ID0gKE1QQzgzeHhfUENJMl9JT19CQVNFIA0KJmd0OyZndDsgMTIpICZh
bXA7IFBPQkFSX0JBX01BU0s7PEJSPismbmJzcDtpb3MtJmd0O3BvY21yNCA9IFBPQ01SX0VOIHwg
DQpQT0NNUl9EU1QgfCBQT0NNUl9JTyB8PEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKCgo
fjBVTCANCi08QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAo
TVBDODN4eF9QQ0kyX1VQUEVSX0lPIA0KLTxCUj4rJm5ic3A7Jm5ic3A7TVBDODN4eF9QQ0kyX0xP
V0VSX0lPKSkgJmd0OyZndDsgMTIpICZhbXA7IA0KUE9DTVJfQ01fTUFTSyk7PEJSPis8QlI+KyZu
YnNwOy8qPEJSPismbmJzcDsgKiBDb25maWd1cmUgUENJIEluYm91bmQgVHJhbnNsYXRpb24gDQpX
aW5kb3dzPEJSPismbmJzcDsgKi88QlI+KyZuYnNwO3BjaV9jdHJsLSZndDtwaXRhcjEgPSANCjB4
MDs8QlI+KyZuYnNwO3BjaV9jdHJsLSZndDtwaWJhcjEgPSAweDA7PEJSPismbmJzcDtwY2lfY3Ry
bC0mZ3Q7cGllYmFyMSA9IA0KMHgwOzxCUj4rJm5ic3A7cGNpX2N0cmwtJmd0O3Bpd2FyMSA9PEJS
PismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgUElXQVJfRU4gfCANClBJV0FSX1BGIHwgUElXQVJf
UlRUX1NOT09QIHwgUElXQVJfV1RUX1NOT09QIHw8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyANClBJV0FSX0lXU18yRzs8QlI+KzxCUj4rJm5ic3A7Lyo8QlI+KyZuYnNwOyAqIFJlbGVhc2Ug
UENJIFJTVCBzaWduYWw8QlI+KyZuYnNwOyANCiovPEJSPismbmJzcDtwY2lfY3RybC0mZ3Q7Z2Ny
ID0gDQowOzxCUj4rJm5ic3A7dWRlbGF5KDIwMDApOzxCUj4rJm5ic3A7cGNpX2N0cmwtJmd0O2dj
ciA9IA0KMTs8QlI+KyZuYnNwO3VkZWxheSgyMDAwKTs8QlI+KzxCUj4rJm5ic3A7cmVnMTYgPSAN
CjB4ZmY7PEJSPismbmJzcDtlYXJseV9yZWFkX2NvbmZpZ193b3JkKGhvc2UsIGhvc2UtJmd0O2Zp
cnN0X2J1c25vLCAwLCANClBDSV9DT01NQU5ELCAmYW1wO3JlZzE2KTs8QlI+KyZuYnNwO3JlZzE2
IHw9IFBDSV9DT01NQU5EX1NFUlIgfCANClBDSV9DT01NQU5EX01BU1RFUiB8IFBDSV9DT01NQU5E
X01FTU9SWTs8QlI+KyZuYnNwO2Vhcmx5X3dyaXRlX2NvbmZpZ193b3JkKGhvc2UsIA0KaG9zZS0m
Z3Q7Zmlyc3RfYnVzbm8sIDAsIFBDSV9DT01NQU5ELCByZWcxNik7PEJSPis8QlI+KyZuYnNwOy8q
PEJSPismbmJzcDsgKiANCkNsZWFyIG5vbi1yZXNlcnZlZCBiaXRzIGluIHN0YXR1cyByZWdpc3Rl
ci48QlI+KyZuYnNwOyANCiovPEJSPismbmJzcDtlYXJseV93cml0ZV9jb25maWdfd29yZChob3Nl
LCBob3NlLSZndDtmaXJzdF9idXNubywgMCwgUENJX1NUQVRVUywgDQoweGZmZmYpOzxCUj4rJm5i
c3A7ZWFybHlfd3JpdGVfY29uZmlnX2J5dGUoaG9zZSwgaG9zZS0mZ3Q7Zmlyc3RfYnVzbm8sIDAs
IA0KUENJX0xBVEVOQ1lfVElNRVIsPEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsweDgwKTs8
QlI+K308QlI+KzxCUj4rZXh0ZXJuIGludCANCm1wYzgzeHhfYWRzX21hcF9pcnEoc3RydWN0IHBj
aV9kZXYgKmRldiwgdW5zaWduZWQgY2hhciANCmlkc2VsLDxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHVuc2lnbmVkIGNoYXIgDQpwaW4p
OzxCUj4rZXh0ZXJuIGludCBtcGM4M3h4X2Fkc19leGNsdWRlX2RldmljZSh1X2NoYXIgYnVzLCB1
X2NoYXIgDQpkZXZmbik7PEJSPis8QlI+Ky8qPEJSPisgKiBQQ0kgYnVzZXMgY2FuIGJlIGVuYWJs
ZWQgb25seSBpZiBTWVMgYm9hcmQgY29tYmluYXRlcyANCndpdGggUElCKFBsYXRmb3JtIElPIEJv
YXJkKSBib2FyZDxCUj4rICogd2hpY2ggcHJvdmlkZSAzIFBDSSBzbG90cy4gVGhlcmUgaXMgMiAN
ClBDSSBidXNlcyBhbmQgMyBQQ0kgc2xvdHMsc28gcGVvcGxlIG11c3QgY29uZmlndXJlPEJSPisg
KiB0aGUgcm91dGVzIGJldHdlZW4gDQp0aGVtIGJlZm9yZSBlbmFibGUgUENJIGJ1cy4gVGhpcyBy
b3V0ZXMgYXJlIHVuZGVyIHRoZSBjb250cm9sIG9mIFBDQTk1NTVQVyA8QlI+KyANCiogZGV2aWNl
IHdoaWNoIGNhbiBiZSBhY2Nlc3NlZCB2aWEgSTJDIGJ1cyAyIGFuZCBhcmUgY29uZmlndXJlZCBi
eSBmaXJtd2FyZS4gDQpSZWZlciB0byBGcmVlc2NhbGUgdG88QlI+KyAqIGdldCBtb3JlIGluZm9y
bWF0aW9uIGFib3V0IGZpcm13YXJlIA0KY29uZmlndXJhdGlvbi48QlI+KyAqLzxCUj4rdm9pZCBf
X2luaXQgDQptcGM4M3h4X3NldHVwX2hvc2Uodm9pZCk8QlI+K3s8QlI+KyZuYnNwO3Vuc2lnbmVk
IGxvbmcgdmFsMzI7PEJSPismbmJzcDt2b2xhdGlsZSANCmltbXJfY2xrX3QgKmNsazs8QlI+KyZu
YnNwO3ZvbGF0aWxlIHN0cnVjdCBwY2lfY29udHJvbGxlciAqaG9zZTE7PEJSPisjaWZkZWYgDQpD
T05GSUdfTVBDODM0eF9QQ0kyPEJSPismbmJzcDt2b2xhdGlsZSBzdHJ1Y3QgcGNpX2NvbnRyb2xs
ZXIgDQoqaG9zZTI7PEJSPisjZW5kaWY8QlI+KyZuYnNwO3ZvbGF0aWxlIGJkX3QgKmJpbmZvID0g
KGJkX3QgKikgDQpfX3Jlczs8QlI+KzxCUj4rJm5ic3A7Y2xrID0gaW9yZW1hcChiaW5mby0mZ3Q7
YmlfaW1tcl9iYXNlICsgMHhBMDAsIA0Kc2l6ZW9mKGltbXJfY2xrX3QpKTs8QlI+KzxCUj4rJm5i
c3A7Lyo8QlI+KyZuYnNwOyAqIENvbmZpZ3VyZSBQQ0kgY29udHJvbGxlciBhbmQgDQpQQ0lfQ0xL
X09VVFBVVCBib3RoIGluIDY2TSBtb2RlPEJSPismbmJzcDsgKi88QlI+KyZuYnNwO3ZhbDMyID0g
DQpjbGstJmd0O29jY3I7PEJSPismbmJzcDt1ZGVsYXkoMjAwMCk7PEJSPismbmJzcDtjbGstJmd0
O29jY3IgPSANCjB4ZmYwMDAwMDA7PEJSPismbmJzcDt1ZGVsYXkoMjAwMCk7PEJSPis8QlI+KyZu
YnNwO2hvc2UxID0gDQpwY2liaW9zX2FsbG9jX2NvbnRyb2xsZXIoKTs8QlI+KyZuYnNwO2lmIA0K
KCFob3NlMSk8QlI+KyZuYnNwOyZuYnNwO3JldHVybjs8QlI+KzxCUj4rJm5ic3A7cHBjX21kLnBj
aV9zd2l6emxlID0gDQpjb21tb25fc3dpenpsZTs8QlI+KyZuYnNwO3BwY19tZC5wY2lfbWFwX2ly
cSA9IA0KbXBjODN4eF9hZHNfbWFwX2lycTs8QlI+KzxCUj4rJm5ic3A7aG9zZTEtJmd0O2J1c19v
ZmZzZXQgPSANCjA7PEJSPismbmJzcDtob3NlMS0mZ3Q7Zmlyc3RfYnVzbm8gPSAwOzxCUj4rJm5i
c3A7aG9zZTEtJmd0O2xhc3RfYnVzbm8gPSANCjB4ZmY7PEJSPis8QlI+KyZuYnNwO3NldHVwX2lu
ZGlyZWN0X3BjaShob3NlMSwgYmluZm8tJmd0O2JpX2ltbXJfYmFzZSArIA0KUENJMV9DRkdfQURE
Ul9PRkZTRVQsPEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYmluZm8tJmd0O2Jp
X2ltbXJfYmFzZSANCisgUENJMV9DRkdfREFUQV9PRkZTRVQpOzxCUj4rJm5ic3A7aG9zZTEtJmd0
O3NldF9jZmdfdHlwZSA9IA0KMTs8QlI+KzxCUj4rJm5ic3A7bXBjODN4eF9zZXR1cF9wY2kxKGhv
c2UxKTs8QlI+KzxCUj4rJm5ic3A7aG9zZTEtJmd0O3BjaV9tZW1fb2Zmc2V0IA0KPSBNUEM4M3h4
X1BDSTFfTUVNX09GRlNFVDs8QlI+KyZuYnNwO2hvc2UxLSZndDttZW1fc3BhY2Uuc3RhcnQgPSAN
Ck1QQzgzeHhfUENJMV9MT1dFUl9NRU07PEJSPismbmJzcDtob3NlMS0mZ3Q7bWVtX3NwYWNlLmVu
ZCA9IA0KTVBDODN4eF9QQ0kxX1VQUEVSX01FTTs8QlI+KzxCUj4rJm5ic3A7aG9zZTEtJmd0O2lv
X2Jhc2VfcGh5cyA9IA0KTVBDODN4eF9QQ0kxX0lPX0JBU0U7PEJSPismbmJzcDtob3NlMS0mZ3Q7
aW9fc3BhY2Uuc3RhcnQgPSANCk1QQzgzeHhfUENJMV9MT1dFUl9JTzs8QlI+KyZuYnNwO2hvc2Ux
LSZndDtpb19zcGFjZS5lbmQgPSANCk1QQzgzeHhfUENJMV9VUFBFUl9JTzs8QlI+KyNpZmRlZiBD
T05GSUdfTVBDODM0eF9QQ0kyPEJSPismbmJzcDtpc2FfaW9fYmFzZSA9IA0KKHVuc2lnbmVkIA0K
bG9uZylpb3JlbWFwKE1QQzgzeHhfUENJMV9JT19CQVNFLDxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0KTVBDODN4eF9QQ0kxX0lPX1NJ
WkUgDQorPEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgDQpNUEM4M3h4X1BDSTJfSU9fU0laRSk7PEJSPisjZWxzZTxCUj4rJm5ic3A7aXNh
X2lvX2Jhc2UgPSAodW5zaWduZWQgDQpsb25nKWlvcmVtYXAoTVBDODN4eF9QQ0kxX0lPX0JBU0Us
PEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgDQpNUEM4M3h4X1BDSTFfSU9fU0laRSk7PEJSPisjZW5kaWYmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsvKiBDT05GSUdfTVBDODM0eF9QQ0kyIA0KKi88QlI+KyZuYnNwO2hvc2UxLSZndDtpb19i
YXNlX3ZpcnQgPSAodm9pZCAqKWlzYV9pb19iYXNlOzxCUj4rJm5ic3A7Lyogc2V0dXAgDQpyZXNv
dXJjZXMgDQoqLzxCUj4rJm5ic3A7cGNpX2luaXRfcmVzb3VyY2UoJmFtcDtob3NlMS0mZ3Q7aW9f
cmVzb3VyY2UsPEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQpNUEM4M3h4X1BDSTFfTE9X
RVJfSU8sPEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQpNUEM4M3h4X1BDSTFfVVBQRVJf
SU8sPEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSU9SRVNPVVJDRV9JTywgIlBDSSBob3N0
IA0KYnJpZGdlIA0KMSIpOzxCUj4rJm5ic3A7cGNpX2luaXRfcmVzb3VyY2UoJmFtcDtob3NlMS0m
Z3Q7bWVtX3Jlc291cmNlc1swXSw8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyANCk1QQzgz
eHhfUENJMV9MT1dFUl9NRU0sPEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQpNUEM4M3h4
X1BDSTFfVVBQRVJfTUVNLDxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IElPUkVTT1VSQ0Vf
TUVNLCAiUENJIGhvc3QgDQpicmlkZ2UgMSIpOzxCUj4rPEJSPismbmJzcDtwcGNfbWQucGNpX2V4
Y2x1ZGVfZGV2aWNlID0gDQptcGM4M3h4X2Fkc19leGNsdWRlX2RldmljZTs8QlI+KyZuYnNwO2hv
c2UxLSZndDtsYXN0X2J1c25vID0gDQpwY2lhdXRvX2J1c19zY2FuKGhvc2UxLCBob3NlMS0mZ3Q7
Zmlyc3RfYnVzbm8pOzxCUj4rPEJSPisjaWZkZWYgDQpDT05GSUdfTVBDODM0eF9QQ0kyPEJSPism
bmJzcDtob3NlMiA9IHBjaWJpb3NfYWxsb2NfY29udHJvbGxlcigpOzxCUj4rJm5ic3A7aWYgDQoo
IWhvc2UyKTxCUj4rJm5ic3A7Jm5ic3A7cmV0dXJuOzxCUj4rPEJSPismbmJzcDtob3NlMi0mZ3Q7
YnVzX29mZnNldCA9IA0KaG9zZTEtJmd0O2xhc3RfYnVzbm8gKyAxOzxCUj4rJm5ic3A7aG9zZTIt
Jmd0O2ZpcnN0X2J1c25vID0gaG9zZTEtJmd0O2xhc3RfYnVzbm8gDQorIDE7PEJSPismbmJzcDto
b3NlMi0mZ3Q7bGFzdF9idXNubyA9IDB4ZmY7PEJSPismbmJzcDtzZXR1cF9pbmRpcmVjdF9wY2ko
aG9zZTIsIA0KYmluZm8tJmd0O2JpX2ltbXJfYmFzZSArIA0KUENJMl9DRkdfQUREUl9PRkZTRVQs
PEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYmluZm8tJmd0O2JpX2ltbXJfYmFz
ZSANCisgUENJMl9DRkdfREFUQV9PRkZTRVQpOzxCUj4rJm5ic3A7aG9zZTItJmd0O3NldF9jZmdf
dHlwZSA9IA0KMTs8QlI+KzxCUj4rJm5ic3A7bXBjODM0eF9hZHNfc2V0dXBfcGNpMihob3NlMik7
PEJSPis8QlI+KyZuYnNwO2hvc2UyLSZndDtwY2lfbWVtX29mZnNldCANCj0gTVBDODN4eF9QQ0ky
X01FTV9PRkZTRVQ7PEJSPismbmJzcDtob3NlMi0mZ3Q7bWVtX3NwYWNlLnN0YXJ0ID0gDQpNUEM4
M3h4X1BDSTJfTE9XRVJfTUVNOzxCUj4rJm5ic3A7aG9zZTItJmd0O21lbV9zcGFjZS5lbmQgPSAN
Ck1QQzgzeHhfUENJMl9VUFBFUl9NRU07PEJSPis8QlI+KyZuYnNwO2hvc2UyLSZndDtpb19iYXNl
X3BoeXMgPSANCk1QQzgzeHhfUENJMl9JT19CQVNFOzxCUj4rJm5ic3A7aG9zZTItJmd0O2lvX3Nw
YWNlLnN0YXJ0ID0gDQpNUEM4M3h4X1BDSTJfTE9XRVJfSU87PEJSPismbmJzcDtob3NlMi0mZ3Q7
aW9fc3BhY2UuZW5kID0gDQpNUEM4M3h4X1BDSTJfVVBQRVJfSU87PEJSPismbmJzcDtob3NlMi0m
Z3Q7aW9fYmFzZV92aXJ0ID0gKHZvaWQgKikoaXNhX2lvX2Jhc2UgKyANCk1QQzgzeHhfUENJMV9J
T19TSVpFKTs8QlI+KyZuYnNwOy8qIHNldHVwIHJlc291cmNlcyANCiovPEJSPismbmJzcDtwY2lf
aW5pdF9yZXNvdXJjZSgmYW1wO2hvc2UyLSZndDtpb19yZXNvdXJjZSw8QlI+KyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyANCk1QQzgzeHhfUENJMl9MT1dFUl9JTyw8QlI+KyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyANCk1QQzgzeHhfUENJMl9VUFBFUl9JTyw8QlI+KyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBJT1JFU09VUkNFX0lPLCAiUENJIGhvc3QgDQpicmlkZ2UgDQoyIik7PEJSPismbmJz
cDtwY2lfaW5pdF9yZXNvdXJjZSgmYW1wO2hvc2UyLSZndDttZW1fcmVzb3VyY2VzWzBdLDxCUj4r
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0KTVBDODN4eF9QQ0kyX0xPV0VSX01FTSw8QlI+KyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyANCk1QQzgzeHhfUENJMl9VUFBFUl9NRU0sPEJSPismbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgSU9SRVNPVVJDRV9NRU0sICJQQ0kgaG9zdCANCmJyaWRnZSAy
Iik7PEJSPis8QlI+KyZuYnNwO2hvc2UyLSZndDtsYXN0X2J1c25vID0gcGNpYXV0b19idXNfc2Nh
bihob3NlMiwgDQpob3NlMi0mZ3Q7Zmlyc3RfYnVzbm8pOzxCUj4rI2VuZGlmJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7LyogQ09ORklHX01QQzgzNHhfUENJMiANCiovPEJSPit9PEJSPisjZW5kaWYm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsvKkNPTkZJR19QQ0kgKi88QlI+ZGlmZiAtdXJOIC1YIA0K
ZG9udGRpZmYgbGludXgtMi42LjEzLXJjNi9hcmNoL3BwYy9zeXNsaWIvcHBjODN4eF9zZXR1cC5o
IA0KbGludXgtMi42LjEzLXJjNi1wY2kvYXJjaC9wcGMvc3lzbGliL3BwYzgzeHhfc2V0dXAuaDxC
Uj4tLS0gDQpsaW51eC0yLjYuMTMtcmM2L2FyY2gvcHBjL3N5c2xpYi9wcGM4M3h4X3NldHVwLmgm
bmJzcDsyMDA1LTA2LTE4IA0KMDM6NDg6MjkuMDAwMDAwMDAwICswODAwPEJSPisrKyANCmxpbnV4
LTIuNi4xMy1yYzYtcGNpL2FyY2gvcHBjL3N5c2xpYi9wcGM4M3h4X3NldHVwLmgmbmJzcDsyMDA1
LTA4LTIzIA0KMTA6MjU6NDMuMDAwMDAwMDAwICswODAwPEJSPkBAIC0xMiw2ICsxMiwxNCBAQDxC
Uj4mbmJzcDsgKiBGcmVlIFNvZnR3YXJlIA0KRm91bmRhdGlvbjsmbmJzcDsgZWl0aGVyIHZlcnNp
b24gMiBvZiB0aGUmbmJzcDsgTGljZW5zZSwgb3IgKGF0IHlvdXI8QlI+Jm5ic3A7ICogDQpvcHRp
b24pIGFueSBsYXRlciB2ZXJzaW9uLjxCUj4mbmJzcDsgKjxCUj4rICogVGhpcyBwcm9ncmFtIGlz
IGRpc3RyaWJ1dGVkIGluIHRoZSANCmhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0PEJS
PisgKiBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSANCmltcGxpZWQgd2Fy
cmFudHkgb2Y8QlI+KyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VM
QVIgDQpQVVJQT1NFLiZuYnNwOyBTZWUgdGhlIEdOVTxCUj4rICogR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBmb3IgbW9yZSBkZXRhaWxzLjxCUj4rIA0KKjxCUj4rICogWW91IHNob3VsZCBoYXZlIHJl
Y2VpdmVkIGEgY29weSBvZiB0aGUmbmJzcDsgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgDQph
bG9uZzxCUj4rICogd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUmbmJzcDsgdG8gdGhl
IEZyZWUgU29mdHdhcmUgDQpGb3VuZGF0aW9uLCBJbmMuLDxCUj4rICogNjc1IE1hc3MgQXZlLCBD
YW1icmlkZ2UsIE1BIDAyMTM5LCBVU0EuPEJSPiZuYnNwOyANCiovPEJSPiZuYnNwOzxCUj4mbmJz
cDsjaWZuZGVmIF9fUFBDX1NZU0xJQl9QUEM4M1hYX1NFVFVQX0g8QlI+QEAgLTIwLDYgKzI4LDcg
DQpAQDxCUj4mbmJzcDsjaW5jbHVkZSAmbHQ7bGludXgvY29uZmlnLmgmZ3Q7PEJSPiZuYnNwOyNp
bmNsdWRlIA0KJmx0O2xpbnV4L2luaXQuaCZndDs8QlI+Jm5ic3A7I2luY2x1ZGUgJmx0O2FzbS9w
cGNib290LmgmZ3Q7PEJSPisjaW5jbHVkZSANCiZsdDthc20vbXBjODN4eC5oJmd0OzxCUj4mbmJz
cDs8QlI+Jm5ic3A7ZXh0ZXJuIHVuc2lnbmVkIGxvbmcgDQptcGM4M3h4X2ZpbmRfZW5kX29mX21l
bW9yeSh2b2lkKSBfX2luaXQ7PEJSPiZuYnNwO2V4dGVybiBsb25nIA0KbXBjODN4eF90aW1lX2lu
aXQodm9pZCkgX19pbml0OzxCUj5AQCAtMzAsMTUgKzM5LDYgQEA8QlI+Jm5ic3A7ZXh0ZXJuIHZv
aWQgDQptcGM4M3h4X2hhbHQodm9pZCk7PEJSPiZuYnNwO2V4dGVybiB2b2lkIG1wYzgzeHhfc2V0
dXBfaG9zZSh2b2lkKSANCl9faW5pdDs8QlI+Jm5ic3A7PEJSPi0vKiBQQ0kgY29uZmlnICovPEJS
Pi0jaWYgMDxCUj4tI2RlZmluZSANClBDSTFfQ0ZHX0FERFJfT0ZGU0VUJm5ic3A7KEZJWE1FKTxC
Uj4tI2RlZmluZSANClBDSTFfQ0ZHX0RBVEFfT0ZGU0VUJm5ic3A7KEZJWE1FKTxCUj4tPEJSPi0j
ZGVmaW5lIA0KUENJMl9DRkdfQUREUl9PRkZTRVQmbmJzcDsoRklYTUUpPEJSPi0jZGVmaW5lIA0K
UENJMl9DRkdfREFUQV9PRkZTRVQmbmJzcDsoRklYTUUpPEJSPi0jZW5kaWY8QlI+LTxCUj4mbmJz
cDsvKiBTZXJpYWwgQ29uZmlnIA0KKi88QlI+Jm5ic3A7I2lmZGVmIENPTkZJR19TRVJJQUxfTUFO
WV9QT1JUUzxCUj4mbmJzcDsjZGVmaW5lIFJTX1RBQkxFX1NJWkUmbmJzcDsgDQo2NDxCUj5AQCAt
NTAsNCArNTAsNCBAQDxCUj4mbmJzcDsjZGVmaW5lIEJBU0VfQkFVRCANCjExNTIwMDxCUj4mbmJz
cDsjZW5kaWY8QlI+Jm5ic3A7PEJSPi0jZW5kaWYgLyogX19QUENfU1lTTElCX1BQQzgzWFhfU0VU
VVBfSCANCiovPEJSPisjZW5kaWYmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsvKiBfX1BQQ19TWVNM
SUJfUFBDODNYWF9TRVRVUF9IIA0KKi88QlI+PC9GT05UPjwvRElWPjwvQk9EWT48L0hUTUw+DQo=

------_=_NextPart_001_01C5AD40.9086BA2F--

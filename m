Return-Path: <Tony.Li@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id AFC0F6814A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 19:03:51 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	j7T9AueV012787 for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 02:10:56 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j7T994uR013944
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 04:09:05 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467302BEB583@zch01exm40.ap.freescale.net>
From: Li Tony-r64360 <Tony.Li@freescale.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 29 Aug 2005 17:03:42 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5AC78.8DA96B5B"
Cc: Li Tony-r64360 <Tony.Li@freescale.com>, linux-kernel@vger.kernel.org,
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

------_=_NextPart_001_01C5AC78.8DA96B5B
Content-Type: text/plain

MPC83xx cpu has two PCI buses. This patch adds support for them.
 
After system boot. The code initializes PCI inbound/outbound 
windows, allocate and register PCI memory/io space. Be aware 
that this patch depand on the firmware.
 
Signed-off-by: Tony Li <tony.li@freescale.com <mailto:tony.li@freescale.com> >
 
---
author Tony Li <tony.li@freescale.com <mailto:tony.li@freescale.com> > Mon, 29 Aug 2005
committer Tony Li <tony.li@freescale.com <mailto:tony.li@freescale.com> > Mon, 29 Aug 2005
 
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
+++ linux-2.6.13-rc6-pci/arch/ppc/platforms/83xx/mpc834x_sys.c 2005-08-18 13:22:59.000000000 +0800
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
+++ linux-2.6.13-rc6-pci/arch/ppc/syslib/ppc83xx_setup.c 2005-08-23 10:05:03.000000000 +0800
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
@@ -31,6 +45,10 @@
 #include <asm/delay.h>
 
 #include <syslib/ppc83xx_setup.h>
+#if defined(CONFIG_PCI)
+#include <asm/delay.h>
+#include <syslib/ppc834x_pci.h>
+#endif
 
 phys_addr_t immrbar;
 
@@ -162,4 +180,227 @@
  for(;;);
 }
 
-/* PCI SUPPORT DOES NOT EXIT, MODEL after ppc85xx_setup.c */
+#if defined(CONFIG_PCI)
+void __init
+mpc83xx_setup_pci1(struct pci_controller *hose)
+{
+ unsigned short reg16;
+ volatile immr_pcictrl_t * pci_ctrl;
+ volatile immr_ios_t * ios;
+ bd_t *binfo = (bd_t *) __res;
+
+ pci_ctrl = ioremap(binfo->bi_immr_base + 0x8500,
+  sizeof(immr_pcictrl_t));
+ ios = ioremap(binfo->bi_immr_base + 0x8400,
+  sizeof(immr_ios_t));
+ 
+ /*
+  * Configure PCI Outbound Translation Windows
+  */
+ ios->potar0 = (MPC83xx_PCI1_LOWER_MEM >> 12) & POTAR_TA_MASK;
+ ios->pobar0 = (MPC83xx_PCI1_LOWER_MEM >> 12) & POBAR_BA_MASK;
+ ios->pocmr0 = POCMR_EN |
+  (((~0UL - (MPC83xx_PCI1_UPPER_MEM - MPC83xx_PCI1_LOWER_MEM)) >> 12) & POCMR_CM_MASK);
+
+ /* mapped to PCI1 IO space 0x0 to local 0xe2000000  */
+ ios->potar1 = (MPC83xx_PCI1_LOWER_IO >> 12) & POTAR_TA_MASK;
+ ios->pobar1 = (MPC83xx_PCI1_IO_BASE >> 12) & POBAR_BA_MASK;
+ ios->pocmr1 = POCMR_EN | POCMR_IO |
+  (((~0UL - (MPC83xx_PCI1_UPPER_IO - MPC83xx_PCI1_LOWER_IO)) >> 12) & POCMR_CM_MASK);
+
+ /*
+  * Configure PCI Inbound Translation Windows
+  */
+ pci_ctrl->pitar1 = 0x0;
+ pci_ctrl->pibar1 = 0x0;
+ pci_ctrl->piebar1 = 0x0;
+ pci_ctrl->piwar1 = PIWAR_EN | PIWAR_PF | PIWAR_RTT_SNOOP | PIWAR_WTT_SNOOP | PIWAR_IWS_2G;
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
+ early_read_config_word (hose,hose->first_busno,0,PCI_COMMAND, &reg16);
+ reg16 |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
+ early_write_config_word(hose,hose->first_busno,0,PCI_COMMAND, reg16);
+
+ /*
+  * Clear non-reserved bits in status register.
+  */
+ early_write_config_word(hose,hose->first_busno,0,PCI_STATUS, 0xffff);
+ early_write_config_byte(hose,hose->first_busno,0,PCI_LATENCY_TIMER,0x80);
+}
+
+void __init
+mpc834x_ads_setup_pci2(struct pci_controller *hose)
+{
+ unsigned short reg16;
+ volatile immr_pcictrl_t * pci_ctrl;
+ volatile immr_ios_t * ios;
+ bd_t *binfo = (bd_t *) __res;
+
+ pci_ctrl = ioremap(binfo->bi_immr_base + 0x8600,
+  sizeof(immr_pcictrl_t));
+ ios = ioremap(binfo->bi_immr_base + 0x8400,
+  sizeof(immr_ios_t));
+
+ /*
+  * Configure PCI Outbound Translation Windows
+  */
+ ios->potar3 = (MPC83xx_PCI2_LOWER_MEM >> 12) & POTAR_TA_MASK;
+ ios->pobar3 = (MPC83xx_PCI2_LOWER_MEM >> 12) & POBAR_BA_MASK;
+ ios->pocmr3 = POCMR_EN | POCMR_DST | 
+  (((~0UL - (MPC83xx_PCI2_UPPER_MEM - MPC83xx_PCI2_LOWER_MEM)) >> 12) & POCMR_CM_MASK);
+
+ /* mapped to PCI2 IO space 0x0 to local 0xe3000000  */
+ ios->potar4 = (MPC83xx_PCI2_LOWER_IO >> 12) & POTAR_TA_MASK;
+ ios->pobar4 = (MPC83xx_PCI2_IO_BASE >> 12) & POBAR_BA_MASK;
+ ios->pocmr4 = POCMR_EN | POCMR_DST | POCMR_IO |
+  (((~0UL - (MPC83xx_PCI2_UPPER_IO - MPC83xx_PCI2_LOWER_IO)) >> 12) & POCMR_CM_MASK);
+
+ /*
+  * Configure PCI Inbound Translation Windows
+  */
+ pci_ctrl->pitar1 = 0x0;
+ pci_ctrl->pibar1 = 0x0;
+ pci_ctrl->piebar1 = 0x0;
+ pci_ctrl->piwar1 = PIWAR_EN | PIWAR_PF | PIWAR_RTT_SNOOP | PIWAR_WTT_SNOOP | PIWAR_IWS_2G;
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
+ early_read_config_word (hose,hose->first_busno,0,PCI_COMMAND, &reg16);
+ reg16 |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
+ early_write_config_word(hose,hose->first_busno,0,PCI_COMMAND, reg16);
+
+ /*
+  * Clear non-reserved bits in status register.
+  */
+ early_write_config_word(hose,hose->first_busno,0,PCI_STATUS, 0xffff);
+ early_write_config_byte(hose,hose->first_busno,0,PCI_LATENCY_TIMER,0x80);
+}
+
+extern int mpc83xx_ads_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin);
+extern int mpc83xx_ads_exclude_device(u_char bus,u_char devfn);
+
+/*
+ * PCI buses can be enabled only if SYS board combinates with PIB(Platform IO Board) board
+ * which provide 3 PCI slots. There is 2 PCI buses and 3 PCI slots,so people must configure
+ * the routes between them before enable PCI bus. This routes are under the control of PCA9555PW 
+ * device which can be accessed via I2C bus 2 and are configured by firmware. Refer to Freescale to
+ * get more information about firmware configuration.
+ */
+void __init
+mpc83xx_setup_hose(void)
+{
+ unsigned long val32;
+ volatile immr_clk_t * clk;
+ volatile struct pci_controller * hose1;
+#ifdef CONFIG_MPC834x_PCI2
+ volatile struct pci_controller * hose2;
+#endif
+ volatile bd_t * binfo = (bd_t *)__res;
+
+ clk = ioremap(binfo->bi_immr_base + 0xA00,
+  sizeof(immr_clk_t));
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
+ if(!hose1)
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
+  binfo->bi_immr_base + PCI1_CFG_DATA_OFFSET);
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
+  MPC83xx_PCI1_IO_SIZE+MPC83xx_PCI2_IO_SIZE);
+#else
+ isa_io_base = (unsigned long)ioremap(MPC83xx_PCI1_IO_BASE,
+  MPC83xx_PCI1_IO_SIZE);
+#endif /* CONFIG_MPC834x_PCI2 */
+ hose1->io_base_virt = (void *)isa_io_base;
+ /* setup resources */
+ pci_init_resource(&hose1->io_resource,
+   MPC83xx_PCI1_LOWER_IO,
+   MPC83xx_PCI1_UPPER_IO,
+   IORESOURCE_IO,"PCI host bridge 1");
+ pci_init_resource(&hose1->mem_resources[0],
+   MPC83xx_PCI1_LOWER_MEM,
+   MPC83xx_PCI1_UPPER_MEM,
+   IORESOURCE_MEM,"PCI host bridge 1");
+
+ ppc_md.pci_exclude_device = mpc83xx_ads_exclude_device;
+ hose1->last_busno = pciauto_bus_scan(hose1, hose1->first_busno);
+
+#ifdef CONFIG_MPC834x_PCI2
+ hose2 = pcibios_alloc_controller();
+ if(!hose2)
+  return;
+
+ hose2->bus_offset = hose1->last_busno + 1;
+ hose2->first_busno = hose1->last_busno + 1;
+ hose2->last_busno = 0xff;
+ setup_indirect_pci(hose2, binfo->bi_immr_base + PCI2_CFG_ADDR_OFFSET,
+  binfo->bi_immr_base + PCI2_CFG_DATA_OFFSET);
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
+   MPC83xx_PCI2_LOWER_IO,
+   MPC83xx_PCI2_UPPER_IO,
+   IORESOURCE_IO,"PCI host bridge 2");
+ pci_init_resource(&hose2->mem_resources[0],
+   MPC83xx_PCI2_LOWER_MEM,
+   MPC83xx_PCI2_UPPER_MEM,
+   IORESOURCE_MEM,"PCI host bridge 2");
+
+ hose2->last_busno = pciauto_bus_scan(hose2, hose2->first_busno);
+#endif /* CONFIG_MPC834x_PCI2 */
+}
+#endif /*CONFIG_PCI*/
diff -urN -X dontdiff linux-2.6.13-rc6/arch/ppc/syslib/ppc83xx_setup.h linux-2.6.13-rc6-pci/arch/ppc/syslib/ppc83xx_setup.h
--- linux-2.6.13-rc6/arch/ppc/syslib/ppc83xx_setup.h 2005-06-18 03:48:29.000000000 +0800
+++ linux-2.6.13-rc6-pci/arch/ppc/syslib/ppc83xx_setup.h 2005-08-23 10:00:54.000000000 +0800
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


------_=_NextPart_001_01C5AC78.8DA96B5B
Content-Type: text/html
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgSFRUUC1FUVVJVj0iQ29udGVudC1UeXBlIiBDT05U
RU5UPSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9VVMtQVNDSUkiPg0KDQoNCjxNRVRBIGNvbnRlbnQ9Ik1T
SFRNTCA2LjAwLjI4MDAuMTQ5MSIgbmFtZT1HRU5FUkFUT1I+PC9IRUFEPg0KPEJPRFk+DQo8RElW
PjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPk1QQzgzeHggY3B1IGhhcyB0d28gUENJIGJ1c2VzLiBU
aGlzIHBhdGNoIGFkZHMgDQpzdXBwb3J0IGZvciB0aGVtLjwvRk9OVD48L0RJVj4NCjxESVY+Jm5i
c3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPkFmdGVyIHN5c3RlbSBib290
LiBUaGUgY29kZSBpbml0aWFsaXplcyBQQ0kgDQppbmJvdW5kL291dGJvdW5kIDxCUj53aW5kb3dz
LCBhbGxvY2F0ZSBhbmQgcmVnaXN0ZXIgUENJIG1lbW9yeS9pbyBzcGFjZS4gQmUgDQphd2FyZSA8
QlI+dGhhdCB0aGlzIHBhdGNoIGRlcGFuZCBvbiB0aGUgZmlybXdhcmUuPC9GT05UPjwvRElWPg0K
PERJVj4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+U2lnbmVkLW9m
Zi1ieTogVG9ueSBMaSAmbHQ7PEEgDQpocmVmPSJtYWlsdG86dG9ueS5saUBmcmVlc2NhbGUuY29t
Ij50b255LmxpQGZyZWVzY2FsZS5jb208L0E+Jmd0OzwvRk9OVD48L0RJVj4NCjxESVY+Jm5ic3A7
PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPi0tLTxCUj5hdXRob3IgVG9ueSBM
aSAmbHQ7PEEgDQpocmVmPSJtYWlsdG86dG9ueS5saUBmcmVlc2NhbGUuY29tIj50b255LmxpQGZy
ZWVzY2FsZS5jb208L0E+Jmd0OyBNb24sIDI5IEF1ZyANCjIwMDU8QlI+Y29tbWl0dGVyIFRvbnkg
TGkgJmx0OzxBIA0KaHJlZj0ibWFpbHRvOnRvbnkubGlAZnJlZXNjYWxlLmNvbSI+dG9ueS5saUBm
cmVlc2NhbGUuY29tPC9BPiZndDsgTW9uLCAyOSBBdWcgDQoyMDA1PC9GT05UPjwvRElWPg0KPERJ
Vj4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+ZGlmZiAtdXJOIC1Y
IGRvbnRkaWZmIA0KbGludXgtMi42LjEzLXJjNi9hcmNoL3BwYy9LY29uZmlnIGxpbnV4LTIuNi4x
My1yYzYtcGNpL2FyY2gvcHBjL0tjb25maWc8QlI+LS0tIA0KbGludXgtMi42LjEzLXJjNi9hcmNo
L3BwYy9LY29uZmlnJm5ic3A7MjAwNS0wOC0wOSAxODowMDo0Ny4wMDAwMDAwMDAgDQorMDgwMDxC
Uj4rKysgbGludXgtMi42LjEzLXJjNi1wY2kvYXJjaC9wcGMvS2NvbmZpZyZuYnNwOzIwMDUtMDgt
MTkgDQoxODoxNzoyNy4wMDAwMDAwMDAgKzA4MDA8QlI+QEAgLTcxMiw2ICs3MTIsMTEgQEA8QlI+
Jm5ic3A7Jm5ic3A7Ym9vbCAiRnJlZXNjYWxlIA0KTVBDODM0eCBTWVMiPEJSPiZuYnNwOyZuYnNw
O2hlbHA8QlI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IFRoaXMgb3B0aW9uIGVuYWJsZXMgDQpzdXBwb3J0
IGZvciB0aGUgTVBDIDgzNHggU1lTIGV2YWx1YXRpb24gYm9hcmQuPEJSPismbmJzcDsmbmJzcDsg
QmUgYXdhcmUgdGhhdCANClBDSSBidXNlcyBjYW4gb25seSBmdW5jdGlvbiB3aGVuIFNZUyBib2Fy
ZCBpcyBwbHVnZ2VkIG9uPEJSPismbmJzcDsmbmJzcDsgUElCIA0KKFBsYXRmb3JtIElPIEJvYXJk
KSBib2FyZCBmcm9tIEZyZWVzY2FsZSB3aGljaCBwcm92aWRlIDMgUENJIA0Kc2xvdHMuPEJSPism
bmJzcDsmbmJzcDsgSnVzdCBsaWtlIFBDLHRoZSBib2FyZCBsZXZlbCBpbml0YWxpemF0aW9uIGlz
IA0KYm9vdGxvYWRlcmBzIHJlc3BvbnNpYmxpbHR5LjxCUj4rJm5ic3A7Jm5ic3A7IFRoZSBQQ0kg
ZGVwb25kcyBvbiBib290bG9hZGVyIA0KY29uZmlndXJhdGUgYm9hcmQgY29ycmV0bHkuIFJlZmVy
IHRvIEZyZWVzY2FsZTxCUj4rJm5ic3A7Jm5ic3A7IHRvIGdldCBtb3JlIA0KaW5mb3JtYXRpb24g
YWJvdXQgdGhpcy4gPEJSPiZuYnNwOzxCUj4mbmJzcDtlbmRjaG9pY2U8QlI+Jm5ic3A7PEJSPkBA
IC0xMTkxLDYgDQorMTE5NiwxMCBAQDxCUj4mbmJzcDsmbmJzcDtib29sPEJSPiZuYnNwOyZuYnNw
O2RlZmF1bHQgUENJPEJSPiZuYnNwOzxCUj4rY29uZmlnIA0KTVBDODM0eF9QQ0kyPEJSPismbmJz
cDtib29sPEJSPismbmJzcDtkZWZhdWx0IHkgaWYgUENJICZhbXA7JmFtcDsgDQpNUEM4MzR4X1NZ
UzxCUj4rPEJSPiZuYnNwO2NvbmZpZyBQQ0lfUVNQQU48QlI+Jm5ic3A7Jm5ic3A7Ym9vbCAiUVNw
YW4gDQpQQ0kiPEJSPiZuYnNwOyZuYnNwO2RlcGVuZHMgb24gITR4eCAmYW1wOyZhbXA7ICFDUE0y
ICZhbXA7JmFtcDsgOHh4PEJSPmRpZmYgLXVyTiANCi1YIGRvbnRkaWZmIGxpbnV4LTIuNi4xMy1y
YzYvYXJjaC9wcGMvcGxhdGZvcm1zLzgzeHgvbXBjODM0eF9zeXMuYyANCmxpbnV4LTIuNi4xMy1y
YzYtcGNpL2FyY2gvcHBjL3BsYXRmb3Jtcy84M3h4L21wYzgzNHhfc3lzLmM8QlI+LS0tIA0KbGlu
dXgtMi42LjEzLXJjNi9hcmNoL3BwYy9wbGF0Zm9ybXMvODN4eC9tcGM4MzR4X3N5cy5jJm5ic3A7
MjAwNS0wOC0wOSANCjE4OjAwOjQ3LjAwMDAwMDAwMCArMDgwMDxCUj4rKysgDQpsaW51eC0yLjYu
MTMtcmM2LXBjaS9hcmNoL3BwYy9wbGF0Zm9ybXMvODN4eC9tcGM4MzR4X3N5cy5jJm5ic3A7MjAw
NS0wOC0xOCANCjEzOjIyOjU5LjAwMDAwMDAwMCArMDgwMDxCUj5AQCAtNjIsOSArNjIsMjggQEA8
QlI+Jm5ic3A7dW5zaWduZWQgY2hhciANCl9fcmVzW3NpemVvZiAoYmRfdCldOzxCUj4mbmJzcDs8
QlI+Jm5ic3A7I2lmZGVmIENPTkZJR19QQ0k8QlI+LSNlcnJvciAiUENJIGlzIA0Kbm90IHN1cHBv
cnRlZCI8QlI+LS8qIE5FRUQgbXBjODN4eF9tYXBfaXJxICZhbXA7IA0KbXBjODN4eF9leGNsdWRl
X2RldmljZTxCUj4tJm5ic3A7Jm5ic3A7IHNlZSBwbGF0Zm9ybXMvODV4eC9tcGM4NXh4X2Fkc19j
b21tb24uYyANCiovPEJSPitpbnQ8QlI+K21wYzgzeHhfYWRzX21hcF9pcnEoc3RydWN0IHBjaV9k
ZXYgKmRldix1bnNpZ25lZCBjaGFyIA0KaWRzZWwsdW5zaWduZWQgY2hhciBwaW4pPEJSPit7PEJS
PismbmJzcDtjaGFyIA0KcGNpX2lycV90YWJsZVtdWzRdPTxCUj4rJm5ic3A7Lyo8QlI+KyZuYnNw
OyAqJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFBDSSANCklEU0VMJmFtcDtJTlRQSU4g
LSZndDsgSU5UTElORTxCUj4rJm5ic3A7ICombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
DQpJTlRBJm5ic3A7Jm5ic3A7Jm5ic3A7IElOVEImbmJzcDsmbmJzcDsmbmJzcDsgSU5UQyZuYnNw
OyZuYnNwOyZuYnNwOyANCklOVEQ8QlI+KyZuYnNwOyAqLzxCUj4rJm5ic3A7ezxCUj4rJm5ic3A7
Jm5ic3A7e1BJUlFBLCBQSVJRQiwmbmJzcDsgUElSUUMsJm5ic3A7IA0KUElSUUR9LCAvKiBpZHNl
bCAweDExICovPEJSPismbmJzcDsmbmJzcDt7UElSUUMsIFBJUlFELCZuYnNwOyBQSVJRQSwmbmJz
cDsgDQpQSVJRQn0sIC8qIGlkc2VsIDB4MTIgKi88QlI+KyZuYnNwOyZuYnNwO3tQSVJRRCwgUElS
UUEsJm5ic3A7IFBJUlFCLCZuYnNwOyANClBJUlFDfSZuYnNwOyAvKiBpZHNlbCAweDEzICovPEJS
PismbmJzcDt9OzxCUj4rJm5ic3A7LyogTVBDODM0OSBNRFMgYm9hcmQgDQpzcGVjaWZpYyAqLzxC
Uj4rJm5ic3A7Y29uc3QgbG9uZyANCm1pbl9pZHNlbD0weDExLG1heF9pZHNlbD0weDEzLGlycXNf
cGVyX3Nsb3Q9NDs8QlI+KyZuYnNwO3JldHVybiANClBDSV9JUlFfVEFCTEVfTE9PS1VQOzxCUj4r
fTxCUj4raW50PEJSPittcGM4M3h4X2Fkc19leGNsdWRlX2RldmljZSh1X2NoYXIgYnVzLCANCnVf
Y2hhciBkZXZmbik8QlI+K3s8QlI+KyZuYnNwO3JldHVybiBQQ0lCSU9TX1NVQ0NFU1NGVUw7PEJS
Pit9PEJSPiZuYnNwOyNlbmRpZiANCi8qIENPTkZJR19QQ0kgKi88QlI+Jm5ic3A7PEJSPiZuYnNw
Oy8qIA0KKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqPEJSPkBAIA0KLTg4LDcgKzEwNyw3IEBAPEJSPiZuYnNwOzxC
Uj4mbmJzcDsjaWZkZWYgQ09ORklHX1BDSTxCUj4mbmJzcDsmbmJzcDsvKiBzZXR1cCBQQ0kgDQpo
b3N0IGJyaWRnZXMgDQoqLzxCUj4tJm5ic3A7bXBjODN4eF9zeXNfc2V0dXBfaG9zZSgpOzxCUj4r
Jm5ic3A7bXBjODN4eF9zZXR1cF9ob3NlKCk7PEJSPiZuYnNwOyNlbmRpZjxCUj4mbmJzcDsmbmJz
cDttcGM4M3h4X2Vhcmx5X3NlcmlhbF9tYXAoKTs8QlI+Jm5ic3A7PEJSPmRpZmYgDQotdXJOIC1Y
IGRvbnRkaWZmIGxpbnV4LTIuNi4xMy1yYzYvYXJjaC9wcGMvcGxhdGZvcm1zLzgzeHgvbXBjODM0
eF9zeXMuaCANCmxpbnV4LTIuNi4xMy1yYzYtcGNpL2FyY2gvcHBjL3BsYXRmb3Jtcy84M3h4L21w
YzgzNHhfc3lzLmg8QlI+LS0tIA0KbGludXgtMi42LjEzLXJjNi9hcmNoL3BwYy9wbGF0Zm9ybXMv
ODN4eC9tcGM4MzR4X3N5cy5oJm5ic3A7MjAwNS0wNi0xOCANCjAzOjQ4OjI5LjAwMDAwMDAwMCAr
MDgwMDxCUj4rKysgDQpsaW51eC0yLjYuMTMtcmM2LXBjaS9hcmNoL3BwYy9wbGF0Zm9ybXMvODN4
eC9tcGM4MzR4X3N5cy5oJm5ic3A7MjAwNS0wOC0yMyANCjEwOjAwOjA4LjAwMDAwMDAwMCArMDgw
MDxCUj5AQCAtMjYsNyArMjYsNyBAQDxCUj4mbmJzcDsjZGVmaW5lIA0KVklSVF9JTU1SQkFSJm5i
c3A7Jm5ic3A7KCh1aW50KTB4ZmUwMDAwMDApPEJSPiZuYnNwOzxCUj4mbmJzcDsjZGVmaW5lIA0K
QkNTUl9QSFlTX0FERFImbmJzcDsmbmJzcDsoKHVpbnQpMHhmODAwMDAwMCk8QlI+LSNkZWZpbmUg
DQpCQ1NSX1NJWkUmbmJzcDsmbmJzcDsoKHVpbnQpKDMyICogMTAyNCkpPEJSPisjZGVmaW5lIA0K
QkNTUl9TSVpFJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0KKCh1aW50KSgxMjggKiAxMDI0
KSk8QlI+Jm5ic3A7PEJSPiZuYnNwOyNkZWZpbmUgDQpCQ1NSX01JU0NfUkVHMl9PRkYmbmJzcDsw
eDA3PEJSPiZuYnNwOyNkZWZpbmUgDQpCQ1NSX01JU0NfUkVHMl9QT1JFU0VUJm5ic3A7MHgwMTxC
Uj5AQCAtMzUsMjIgKzM1LDM0IEBAPEJSPiZuYnNwOyNkZWZpbmUgDQpCQ1NSX01JU0NfUkVHM19D
TkZMT0NLJm5ic3A7MHg4MDxCUj4mbmJzcDs8QlI+Jm5ic3A7I2lmZGVmIENPTkZJR19QQ0k8QlI+
LS8qIFBDSSANCmludGVycnVwdCBjb250cm9sbGVyICovPEJSPi0jZGVmaW5lIA0KUElSUUEmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgTVBDODN4eF9JUlFfSVJRNDxC
Uj4tI2RlZmluZSANClBJUlFCJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IE1QQzgzeHhfSVJRX0lSUTU8QlI+LSNkZWZpbmUgDQpQSVJRQyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBNUEM4M3h4X0lSUV9JUlE2PEJSPi0jZGVmaW5lIA0K
UElSUUQmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQpNUEM4M3h4
X0lSUV9JUlE3PEJSPi08QlI+LSNkZWZpbmUgDQpNUEM4MzR4X1NZU19QQ0kxX0xPV0VSX0lPJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0KMHgwMDAwMDAwMDxCUj4t
I2RlZmluZSANCk1QQzgzNHhfU1lTX1BDSTFfVVBQRVJfSU8mbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgDQoweDAwZmZmZmZmPEJSPiZuYnNwOzxCUj4tI2RlZmluZSAN
Ck1QQzgzNHhfU1lTX1BDSTFfTE9XRVJfTUVNJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IA0KMHg4MDAwMDAwMDxCUj4tI2RlZmluZSANCk1QQzgzNHhfU1lTX1BDSTFfVVBQRVJf
TUVNJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0KMHg5ZmZmZmZmZjxCUj4r
I2RlZmluZSZuYnNwO1BDSTFfQ0ZHX0FERFJfT0ZGU0VUJm5ic3A7KDB4ODMwMCk8QlI+KyNkZWZp
bmUmbmJzcDtQQ0kxX0NGR19EQVRBX09GRlNFVCZuYnNwOygweDgzMDQpPEJSPiZuYnNwOzxCUj4t
I2RlZmluZSANCk1QQzgzNHhfU1lTX1BDSTFfSU9fQkFTRSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyANCjB4ZTIwMDAwMDA8QlI+LSNkZWZpbmUgTVBDODM0
eF9TWVNfUENJMV9NRU1fT0ZGU0VUJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0KMHgw
MDAwMDAwMDxCUj4rI2RlZmluZSZuYnNwO1BDSTJfQ0ZHX0FERFJfT0ZGU0VUJm5ic3A7KDB4ODM4
MCk8QlI+KyNkZWZpbmUmbmJzcDtQQ0kyX0NGR19EQVRBX09GRlNFVCZuYnNwOygweDgzODQpPEJS
Pis8QlI+KyNkZWZpbmUmbmJzcDtQSVJRQSZuYnNwO01QQzgzeHhfSVJRX0VYVDQ8QlI+KyNkZWZp
bmUmbmJzcDtQSVJRQiZuYnNwO01QQzgzeHhfSVJRX0VYVDU8QlI+KyNkZWZpbmUmbmJzcDtQSVJR
QyZuYnNwO01QQzgzeHhfSVJRX0VYVDY8QlI+KyNkZWZpbmUmbmJzcDtQSVJRRCZuYnNwO01QQzgz
eHhfSVJRX0VYVDc8QlI+KzxCUj4rI2RlZmluZSZuYnNwO01QQzgzeHhfUENJMV9MT1dFUl9JTyZu
YnNwOzB4MDAwMDAwMDA8QlI+KyNkZWZpbmUmbmJzcDtNUEM4M3h4X1BDSTFfVVBQRVJfSU8mbmJz
cDsweDAwZmZmZmZmPEJSPisjZGVmaW5lJm5ic3A7TVBDODN4eF9QQ0kxX0xPV0VSX01FTSZuYnNw
OzB4ODAwMDAwMDA8QlI+KyNkZWZpbmUmbmJzcDtNUEM4M3h4X1BDSTFfVVBQRVJfTUVNJm5ic3A7
MHg5ZmZmZmZmZjxCUj4rI2RlZmluZSZuYnNwO01QQzgzeHhfUENJMV9JT19CQVNFJm5ic3A7MHhl
MjAwMDAwMDxCUj4rI2RlZmluZSZuYnNwO01QQzgzeHhfUENJMV9NRU1fT0ZGU0VUJm5ic3A7MHgw
MDAwMDAwMDxCUj4rI2RlZmluZSZuYnNwO01QQzgzeHhfUENJMV9JT19TSVpFJm5ic3A7MHgwMTAw
MDAwMDxCUj4rPEJSPisjZGVmaW5lJm5ic3A7TVBDODN4eF9QQ0kyX0xPV0VSX0lPJm5ic3A7MHgw
MDAwMDAwMDxCUj4rI2RlZmluZSZuYnNwO01QQzgzeHhfUENJMl9VUFBFUl9JTyZuYnNwOzB4MDBm
ZmZmZmY8QlI+KyNkZWZpbmUmbmJzcDtNUEM4M3h4X1BDSTJfTE9XRVJfTUVNJm5ic3A7MHhhMDAw
MDAwMDxCUj4rI2RlZmluZSZuYnNwO01QQzgzeHhfUENJMl9VUFBFUl9NRU0mbmJzcDsweGJmZmZm
ZmZmPEJSPisjZGVmaW5lJm5ic3A7TVBDODN4eF9QQ0kyX0lPX0JBU0UmbmJzcDsweGUzMDAwMDAw
PEJSPisjZGVmaW5lJm5ic3A7TVBDODN4eF9QQ0kyX01FTV9PRkZTRVQmbmJzcDsweDAwMDAwMDAw
PEJSPisjZGVmaW5lJm5ic3A7TVBDODN4eF9QQ0kyX0lPX1NJWkUmbmJzcDsweDAxMDAwMDAwPEJS
PiZuYnNwOzxCUj4tI2RlZmluZSANCk1QQzgzNHhfU1lTX1BDSTFfSU9fU0laRSZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyANCjB4MDEwMDAwMDA8QlI+Jm5i
c3A7I2VuZGlmIC8qIENPTkZJR19QQ0kgDQoqLzxCUj4mbmJzcDs8QlI+Jm5ic3A7I2VuZGlmJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0KLyogX19NQUNIX01QQzgzWFhfU1lTX0hf
XyAqLzxCUj5kaWZmIC11ck4gLVggZG9udGRpZmYgDQpsaW51eC0yLjYuMTMtcmM2L2FyY2gvcHBj
L3N5c2xpYi9wcGM4MzR4X3BjaS5oIA0KbGludXgtMi42LjEzLXJjNi1wY2kvYXJjaC9wcGMvc3lz
bGliL3BwYzgzNHhfcGNpLmg8QlI+LS0tIA0KbGludXgtMi42LjEzLXJjNi9hcmNoL3BwYy9zeXNs
aWIvcHBjODM0eF9wY2kuaCZuYnNwOzE5NzAtMDEtMDEgDQowODozMDowMC4wMDAwMDAwMDAgKzA4
MzA8QlI+KysrIA0KbGludXgtMi42LjEzLXJjNi1wY2kvYXJjaC9wcGMvc3lzbGliL3BwYzgzNHhf
cGNpLmgmbmJzcDsyMDA1LTA4LTE5IA0KMTg6MzA6MTEuMDAwMDAwMDAwICswODAwPEJSPkBAIC0w
LDAgKzEsMTYxIEBAPEJSPisvKiBDcmVhdGVkIGJ5IFRvbnkgTGkgJmx0OzxBIA0KaHJlZj0ibWFp
bHRvOnRvbnkubGlAZnJlZXNjYWxlLmNvbSI+dG9ueS5saUBmcmVlc2NhbGUuY29tPC9BPiZndDsg
MjAwNS42PEJSPisgKiANCkNvcHlyaWdodCAoYykgMjAwNSBmcmVlc2NhbGUgc2VtaWNvbmR1Y3Rv
cjxCUj4rICo8QlI+KyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIA0Kc29mdHdhcmU7IHlvdSBjYW4g
cmVkaXN0cmlidXRlJm5ic3A7IGl0IGFuZC9vciBtb2RpZnkgaXQ8QlI+KyAqIHVuZGVyJm5ic3A7
IHRoZSANCnRlcm1zIG9mJm5ic3A7IHRoZSBHTlUgR2VuZXJhbCZuYnNwOyBQdWJsaWMgTGljZW5z
ZSBhcyBwdWJsaXNoZWQgYnkgdGhlPEJSPisgKiANCkZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsm
bmJzcDsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUmbmJzcDsgTGljZW5zZSwgb3IgKGF0IA0KeW91
cjxCUj4rICogb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi48QlI+KyAqPEJSPisgKiBUaGlzIHBy
b2dyYW0gaXMgZGlzdHJpYnV0ZWQgDQppbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVs
LCBidXQ8QlI+KyAqIFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IA0KZXZlbiB0aGUgaW1w
bGllZCB3YXJyYW50eSBvZjxCUj4rICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEg
UEFSVElDVUxBUiANClBVUlBPU0UuJm5ic3A7IFNlZSB0aGUgR05VPEJSPisgKiBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuPEJSPisgDQoqPEJSPisgKiBZb3Ugc2hvdWxk
IGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSZuYnNwOyBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSANCmFsb25nPEJSPisgKiB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSZuYnNw
OyB0byB0aGUgRnJlZSBTb2Z0d2FyZSANCkZvdW5kYXRpb24sIEluYy4sPEJSPisgKiA2NzUgTWFz
cyBBdmUsIENhbWJyaWRnZSwgTUEgMDIxMzksIFVTQS48QlI+KyANCiovPEJSPis8QlI+KyNpZm5k
ZWYmbmJzcDtfX01QQzgzNFhfUENJX0hfXzxCUj4rI2RlZmluZSZuYnNwO19fTVBDODM0WF9QQ0lf
SF9fPEJSPis8QlI+K3R5cGVkZWYgDQpzdHJ1Y3QgaW1tcl9jbGsgezxCUj4rJm5ic3A7dTMyIHNw
bXI7Jm5ic3A7Lyogc3lzdGVtIFBMTCBtb2RlIFJlZ2lzdGVyJm5ic3A7IA0KKi88QlI+KyZuYnNw
O3UzMiBvY2NyOyZuYnNwOy8qIG91dHB1dCBjbG9jayBjb250cm9sIFJlZ2lzdGVyJm5ic3A7IA0K
Ki88QlI+KyZuYnNwO3UzMiBzY2NyOyZuYnNwOy8qIHN5c3RlbSBjbG9jayBjb250cm9sIFJlZ2lz
dGVyJm5ic3A7IA0KKi88QlI+KyZuYnNwO3U4IHJlczBbMHhGNF07PEJSPit9IGltbXJfY2xrX3Q7
PEJSPis8QlI+Ky8qPEJSPisgKiBQQ0kgU29mdHdhcmUgDQpDb25maWd1cmF0aW9uIFJlZ2lzdGVy
czxCUj4rICovPEJSPit0eXBlZGVmIHN0cnVjdCBpbW1yX3BjaWNvbmYgezxCUj4rJm5ic3A7dTMy
IA0KY29uZmlnX2FkZHJlc3M7PEJSPismbmJzcDt1MzIgY29uZmlnX2RhdGE7PEJSPismbmJzcDt1
MzIgaW50X2Fjazs8QlI+KyZuYnNwO3U4IA0KcmVzWzExNl07PEJSPit9IGltbXJfcGNpY29uZl90
OzxCUj4rPEJSPisvKjxCUj4rICogU2VxdWVuY2VyPEJSPisgKi88QlI+K3R5cGVkZWYgDQpzdHJ1
Y3QgaW1tcl9pb3MgezxCUj4rJm5ic3A7dTMyIHBvdGFyMDs8QlI+KyZuYnNwO3U4IHJlczBbNF07
PEJSPismbmJzcDt1MzIgDQpwb2JhcjA7PEJSPismbmJzcDt1OCByZXMxWzRdOzxCUj4rJm5ic3A7
dTMyIHBvY21yMDs8QlI+KyZuYnNwO3U4IA0KcmVzMls0XTs8QlI+KyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1MzIgDQpwb3RhcjE7PEJSPismbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdTggDQpyZXMzWzRdOzxCUj4rJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHUzMiANCnBvYmFyMTs8QlI+KyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1OCANCnJlczRbNF07PEJSPism
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdTMyIA0KcG9jbXIxOzxC
Uj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHU4IA0KcmVzNVs0
XTs8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1MzIgDQpw
b3RhcjI7PEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdTgg
DQpyZXM2WzRdOzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IHUzMiANCnBvYmFyMjs8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyB1OCANCnJlczdbNF07PEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgdTMyIA0KcG9jbXIyOzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IHU4IA0KcmVzOFs0XTs8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyB1MzIgDQpwb3RhcjM7PEJSPismbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgdTggDQpyZXM5WzRdOzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHUzMiANCnBvYmFyMzs8QlI+KyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1OCANCnJlczEwWzRdOzxCUj4rJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHUzMiANCnBvY21yMzs8QlI+KyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1OCANCnJlczExWzRdOzxCUj4r
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHUzMiANCnBvdGFyNDs8
QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1OCANCnJlczEy
WzRdOzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHUzMiAN
CnBvYmFyNDs8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1
OCANCnJlczEzWzRdOzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IHUzMiANCnBvY21yNDs8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyB1OCANCnJlczE0WzRdOzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IHUzMiANCnBvdGFyNTs8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyB1OCANCnJlczE1WzRdOzxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHUzMiANCnBvYmFyNTs8QlI+KyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1OCANCnJlczE2WzRdOzxCUj4rJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHUzMiANCnBvY21yNTs8QlI+KyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1OCByZXMxN1s0XTs8QlI+KyZuYnNw
O3U4IA0KcmVzMThbMHg2MF07PEJSPismbmJzcDt1MzIgcG1jcjs8QlI+KyZuYnNwO3U4IHJlczE5
WzRdOzxCUj4rJm5ic3A7dTMyIA0KZHRjcjs8QlI+KyZuYnNwO3U4IHJlczIwWzRdOzxCUj4rfSBp
bW1yX2lvc190OzxCUj4rI2RlZmluZSANClBPVEFSX1RBX01BU0smbmJzcDsweDAwMGZmZmZmPEJS
PisjZGVmaW5lIA0KUE9CQVJfQkFfTUFTSyZuYnNwOzB4MDAwZmZmZmY8QlI+KyNkZWZpbmUgUE9D
TVJfRU4mbmJzcDsweDgwMDAwMDAwPEJSPisjZGVmaW5lIA0KUE9DTVJfSU8mbmJzcDsweDQwMDAw
MDAwJm5ic3A7LyogMC0tbWVtb3J5IHNwYWNlIDEtLUkvTyBzcGFjZSAqLzxCUj4rI2RlZmluZSAN
ClBPQ01SX1NFJm5ic3A7MHgyMDAwMDAwMCZuYnNwOy8qIHN0cmVhbWluZyBlbmFibGUgKi88QlI+
KyNkZWZpbmUgDQpQT0NNUl9EU1QmbmJzcDsweDEwMDAwMDAwJm5ic3A7LyogMC0tUENJMSAxLS1Q
Q0kyICovPEJSPisjZGVmaW5lIA0KUE9DTVJfQ01fTUFTSyZuYnNwOzB4MDAwZmZmZmY8QlI+KzxC
Uj4rLyo8QlI+KyAqIFBDSSBDb250cm9sbGVyIENvbnRyb2wgYW5kIA0KU3RhdHVzIFJlZ2lzdGVy
czxCUj4rICovPEJSPit0eXBlZGVmIHN0cnVjdCBpbW1yX3BjaWN0cmwgezxCUj4rJm5ic3A7dTMy
IA0KZXNyOzxCUj4rJm5ic3A7dTMyIGVjZHI7PEJSPismbmJzcDt1MzIgZWVyOzxCUj4rJm5ic3A7
dTMyIGVhdGNyOzxCUj4rJm5ic3A7dTMyIA0KZWFjcjs8QlI+KyZuYnNwO3UzMiBlZWFjcjs8QlI+
KyZuYnNwO3UzMiBlZGxjcjs8QlI+KyZuYnNwO3UzMiANCmVkaGNyOzxCUj4rJm5ic3A7dTMyIGdj
cjs8QlI+KyZuYnNwO3UzMiBlY3I7PEJSPismbmJzcDt1MzIgZ3NyOzxCUj4rJm5ic3A7dTggDQpy
ZXMwWzEyXTs8QlI+KyZuYnNwO3UzMiBwaXRhcjI7PEJSPismbmJzcDt1OCByZXMxWzRdOzxCUj4r
Jm5ic3A7dTMyIA0KcGliYXIyOzxCUj4rJm5ic3A7dTMyIHBpZWJhcjI7PEJSPismbmJzcDt1MzIg
cGl3YXIyOzxCUj4rJm5ic3A7dTggDQpyZXMyWzRdOzxCUj4rJm5ic3A7dTMyIHBpdGFyMTs8QlI+
KyZuYnNwO3U4IHJlczNbNF07PEJSPismbmJzcDt1MzIgDQpwaWJhcjE7PEJSPismbmJzcDt1MzIg
cGllYmFyMTs8QlI+KyZuYnNwO3UzMiBwaXdhcjE7PEJSPismbmJzcDt1OCANCnJlczRbNF07PEJS
PismbmJzcDt1MzIgcGl0YXIwOzxCUj4rJm5ic3A7dTggcmVzNVs0XTs8QlI+KyZuYnNwO3UzMiAN
CnBpYmFyMDs8QlI+KyZuYnNwO3U4IHJlczZbNF07PEJSPismbmJzcDt1MzIgcGl3YXIwOzxCUj4r
Jm5ic3A7dTggDQpyZXM3WzEzMl07PEJSPit9IA0KaW1tcl9wY2ljdHJsX3Q7PEJSPisjZGVmaW5l
Jm5ic3A7UElUQVJfVEFfTUFTSyZuYnNwOzB4MDAwZmZmZmY8QlI+KyNkZWZpbmUmbmJzcDtQSUJB
Ul9NQVNLJm5ic3A7MHhmZmZmZmZmZjxCUj4rI2RlZmluZSZuYnNwO1BJRUJBUl9FQkFfTUFTSyZu
YnNwOzB4MDAwZmZmZmY8QlI+KyNkZWZpbmUmbmJzcDtQSVdBUl9FTiZuYnNwOzB4ODAwMDAwMDA8
QlI+KyNkZWZpbmUmbmJzcDtQSVdBUl9QRiZuYnNwOzB4MjAwMDAwMDA8QlI+KyNkZWZpbmUmbmJz
cDtQSVdBUl9SVFRfTUFTSyZuYnNwOzB4MDAwZjAwMDA8QlI+KyNkZWZpbmUmbmJzcDtQSVdBUl9S
VFRfTk9fU05PT1AmbmJzcDsweDAwMDQwMDAwPEJSPisjZGVmaW5lJm5ic3A7UElXQVJfUlRUX1NO
T09QJm5ic3A7MHgwMDA1MDAwMDxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX1dUVF9NQVNLJm5ic3A7
MHgwMDAwZjAwMDxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX1dUVF9OT19TTk9PUCZuYnNwOzB4MDAw
MDQwMDA8QlI+KyNkZWZpbmUmbmJzcDtQSVdBUl9XVFRfU05PT1AmbmJzcDsweDAwMDA1MDAwPEJS
PisjZGVmaW5lJm5ic3A7UElXQVJfSVdTX01BU0smbmJzcDsweDAwMDAwMDNGPEJSPisjZGVmaW5l
Jm5ic3A7UElXQVJfSVdTXzRLJm5ic3A7MHgwMDAwMDAwQjxCUj4rI2RlZmluZSZuYnNwO1BJV0FS
X0lXU184SyZuYnNwOzB4MDAwMDAwMEM8QlI+KyNkZWZpbmUmbmJzcDtQSVdBUl9JV1NfMTZLJm5i
c3A7MHgwMDAwMDAwRDxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX0lXU18zMksmbmJzcDsweDAwMDAw
MDBFPEJSPisjZGVmaW5lJm5ic3A7UElXQVJfSVdTXzY0SyZuYnNwOzB4MDAwMDAwMEY8QlI+KyNk
ZWZpbmUmbmJzcDtQSVdBUl9JV1NfMTI4SyZuYnNwOzB4MDAwMDAwMTA8QlI+KyNkZWZpbmUmbmJz
cDtQSVdBUl9JV1NfMjU2SyZuYnNwOzB4MDAwMDAwMTE8QlI+KyNkZWZpbmUmbmJzcDtQSVdBUl9J
V1NfNTEySyZuYnNwOzB4MDAwMDAwMTI8QlI+KyNkZWZpbmUmbmJzcDtQSVdBUl9JV1NfMU0mbmJz
cDsweDAwMDAwMDEzPEJSPisjZGVmaW5lJm5ic3A7UElXQVJfSVdTXzJNJm5ic3A7MHgwMDAwMDAx
NDxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX0lXU180TSZuYnNwOzB4MDAwMDAwMTU8QlI+KyNkZWZp
bmUmbmJzcDtQSVdBUl9JV1NfOE0mbmJzcDsweDAwMDAwMDE2PEJSPisjZGVmaW5lJm5ic3A7UElX
QVJfSVdTXzE2TSZuYnNwOzB4MDAwMDAwMTc8QlI+KyNkZWZpbmUmbmJzcDtQSVdBUl9JV1NfMzJN
Jm5ic3A7MHgwMDAwMDAxODxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX0lXU182NE0mbmJzcDsweDAw
MDAwMDE5PEJSPisjZGVmaW5lJm5ic3A7UElXQVJfSVdTXzEyOE0mbmJzcDsweDAwMDAwMDFBPEJS
PisjZGVmaW5lJm5ic3A7UElXQVJfSVdTXzI1Nk0mbmJzcDsweDAwMDAwMDFCPEJSPisjZGVmaW5l
Jm5ic3A7UElXQVJfSVdTXzUxMk0mbmJzcDsweDAwMDAwMDFDPEJSPisjZGVmaW5lJm5ic3A7UElX
QVJfSVdTXzFHJm5ic3A7MHgwMDAwMDAxRDxCUj4rI2RlZmluZSZuYnNwO1BJV0FSX0lXU18yRyZu
YnNwOzB4MDAwMDAwMUU8QlI+KzxCUj4rI2VuZGlmIA0KLypfX01QQzgzNFhfUENJX0hfXyovPEJS
PmRpZmYgLXVyTiAtWCBkb250ZGlmZiANCmxpbnV4LTIuNi4xMy1yYzYvYXJjaC9wcGMvc3lzbGli
L3BwYzgzeHhfc2V0dXAuYyANCmxpbnV4LTIuNi4xMy1yYzYtcGNpL2FyY2gvcHBjL3N5c2xpYi9w
cGM4M3h4X3NldHVwLmM8QlI+LS0tIA0KbGludXgtMi42LjEzLXJjNi9hcmNoL3BwYy9zeXNsaWIv
cHBjODN4eF9zZXR1cC5jJm5ic3A7MjAwNS0wOC0wOSANCjE4OjAwOjQ3LjAwMDAwMDAwMCArMDgw
MDxCUj4rKysgDQpsaW51eC0yLjYuMTMtcmM2LXBjaS9hcmNoL3BwYy9zeXNsaWIvcHBjODN4eF9z
ZXR1cC5jJm5ic3A7MjAwNS0wOC0yMyANCjEwOjA1OjAzLjAwMDAwMDAwMCArMDgwMDxCUj5AQCAt
MTEsNiArMTEsMjAgQEA8QlI+Jm5ic3A7ICogdW5kZXImbmJzcDsgdGhlIHRlcm1zIA0Kb2YmbmJz
cDsgdGhlIEdOVSBHZW5lcmFsJm5ic3A7IFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieSB0
aGU8QlI+Jm5ic3A7ICogDQpGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247Jm5ic3A7IGVpdGhlciB2
ZXJzaW9uIDIgb2YgdGhlJm5ic3A7IExpY2Vuc2UsIG9yIChhdCANCnlvdXI8QlI+Jm5ic3A7ICog
b3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi48QlI+KyAqPEJSPisgKiBUaGlzIHByb2dyYW0gaXMg
DQpkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLCBidXQ8QlI+
KyAqIFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyANCndpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJy
YW50eSBvZjxCUj4rICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgDQpQQVJUSUNV
TEFSIFBVUlBPU0UuJm5ic3A7IFNlZSB0aGUgR05VPEJSPisgKiBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlIGZvciBtb3JlIA0KZGV0YWlscy48QlI+KyAqPEJSPisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVj
ZWl2ZWQgYSBjb3B5IG9mIHRoZSZuYnNwOyBHTlUgR2VuZXJhbCANClB1YmxpYyBMaWNlbnNlIGFs
b25nPEJSPisgKiB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSZuYnNwOyB0byB0aGUg
RnJlZSANClNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4sPEJSPisgKiA2NzUgTWFzcyBBdmUsIENh
bWJyaWRnZSwgTUEgMDIxMzksIFVTQS48QlI+KyANCio8QlI+KyAqIEp1bHkgMjAwNSwgVG9ueSBM
aSZsdDs8QSANCmhyZWY9Im1haWx0bzp0b255LmxpQGZyZWVzY2FsZS5jb20iPnRvbnkubGlAZnJl
ZXNjYWxlLmNvbTwvQT4mZ3Q7PEJSPisgDQoqJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IEFkZGVkIFBDSSBzdXBwb3J0PEJSPisgKiBQQ0kgY2FuIGJlIGVuYWJsZWQgb25seSANCmlmIE1Q
QzgzNHggU1lTIGJvYXJkIGNvbWJpbmVkIHdpdGggUElCKFBsYXRmb3JtPEJSPisgKiBJTyBCb2Fy
ZCkgYm9hcmQgaW4gd2hpY2ggDQp0aHJlZSBwaHlzaWNhbCBQQ0kgc2xvdHMgbG9jYXRlLjxCUj4m
bmJzcDsgKi88QlI+Jm5ic3A7PEJSPiZuYnNwOyNpbmNsdWRlIA0KJmx0O2xpbnV4L2NvbmZpZy5o
Jmd0OzxCUj5AQCAtMzEsNiArNDUsMTAgQEA8QlI+Jm5ic3A7I2luY2x1ZGUgDQombHQ7YXNtL2Rl
bGF5LmgmZ3Q7PEJSPiZuYnNwOzxCUj4mbmJzcDsjaW5jbHVkZSANCiZsdDtzeXNsaWIvcHBjODN4
eF9zZXR1cC5oJmd0OzxCUj4rI2lmIGRlZmluZWQoQ09ORklHX1BDSSk8QlI+KyNpbmNsdWRlIA0K
Jmx0O2FzbS9kZWxheS5oJmd0OzxCUj4rI2luY2x1ZGUgDQombHQ7c3lzbGliL3BwYzgzNHhfcGNp
LmgmZ3Q7PEJSPisjZW5kaWY8QlI+Jm5ic3A7PEJSPiZuYnNwO3BoeXNfYWRkcl90IA0KaW1tcmJh
cjs8QlI+Jm5ic3A7PEJSPkBAIC0xNjIsNCArMTgwLDIyNyANCkBAPEJSPiZuYnNwOyZuYnNwO2Zv
cig7Oyk7PEJSPiZuYnNwO308QlI+Jm5ic3A7PEJSPi0vKiBQQ0kgU1VQUE9SVCBET0VTIE5PVCAN
CkVYSVQsIE1PREVMIGFmdGVyIHBwYzg1eHhfc2V0dXAuYyAqLzxCUj4rI2lmIGRlZmluZWQoQ09O
RklHX1BDSSk8QlI+K3ZvaWQgDQpfX2luaXQ8QlI+K21wYzgzeHhfc2V0dXBfcGNpMShzdHJ1Y3Qg
cGNpX2NvbnRyb2xsZXIgDQoqaG9zZSk8QlI+K3s8QlI+KyZuYnNwO3Vuc2lnbmVkIHNob3J0IHJl
ZzE2OzxCUj4rJm5ic3A7dm9sYXRpbGUgaW1tcl9wY2ljdHJsX3QgKiANCnBjaV9jdHJsOzxCUj4r
Jm5ic3A7dm9sYXRpbGUgaW1tcl9pb3NfdCAqIGlvczs8QlI+KyZuYnNwO2JkX3QgKmJpbmZvID0g
KGJkX3QgKikgDQpfX3Jlczs8QlI+KzxCUj4rJm5ic3A7cGNpX2N0cmwgPSBpb3JlbWFwKGJpbmZv
LSZndDtiaV9pbW1yX2Jhc2UgKyANCjB4ODUwMCw8QlI+KyZuYnNwOyZuYnNwO3NpemVvZihpbW1y
X3BjaWN0cmxfdCkpOzxCUj4rJm5ic3A7aW9zID0gDQppb3JlbWFwKGJpbmZvLSZndDtiaV9pbW1y
X2Jhc2UgKyANCjB4ODQwMCw8QlI+KyZuYnNwOyZuYnNwO3NpemVvZihpbW1yX2lvc190KSk7PEJS
PismbmJzcDs8QlI+KyZuYnNwOy8qPEJSPismbmJzcDsgDQoqIENvbmZpZ3VyZSBQQ0kgT3V0Ym91
bmQgVHJhbnNsYXRpb24gV2luZG93czxCUj4rJm5ic3A7IA0KKi88QlI+KyZuYnNwO2lvcy0mZ3Q7
cG90YXIwID0gKE1QQzgzeHhfUENJMV9MT1dFUl9NRU0gJmd0OyZndDsgMTIpICZhbXA7IA0KUE9U
QVJfVEFfTUFTSzs8QlI+KyZuYnNwO2lvcy0mZ3Q7cG9iYXIwID0gKE1QQzgzeHhfUENJMV9MT1dF
Ul9NRU0gJmd0OyZndDsgMTIpIA0KJmFtcDsgUE9CQVJfQkFfTUFTSzs8QlI+KyZuYnNwO2lvcy0m
Z3Q7cG9jbXIwID0gUE9DTVJfRU4gDQp8PEJSPismbmJzcDsmbmJzcDsoKCh+MFVMIC0gKE1QQzgz
eHhfUENJMV9VUFBFUl9NRU0gLSBNUEM4M3h4X1BDSTFfTE9XRVJfTUVNKSkgDQomZ3Q7Jmd0OyAx
MikgJmFtcDsgUE9DTVJfQ01fTUFTSyk7PEJSPis8QlI+KyZuYnNwOy8qIG1hcHBlZCB0byBQQ0kx
IElPIHNwYWNlIDB4MCANCnRvIGxvY2FsIDB4ZTIwMDAwMDAmbmJzcDsgKi88QlI+KyZuYnNwO2lv
cy0mZ3Q7cG90YXIxID0gKE1QQzgzeHhfUENJMV9MT1dFUl9JTyANCiZndDsmZ3Q7IDEyKSAmYW1w
OyBQT1RBUl9UQV9NQVNLOzxCUj4rJm5ic3A7aW9zLSZndDtwb2JhcjEgPSANCihNUEM4M3h4X1BD
STFfSU9fQkFTRSAmZ3Q7Jmd0OyAxMikgJmFtcDsgUE9CQVJfQkFfTUFTSzs8QlI+KyZuYnNwO2lv
cy0mZ3Q7cG9jbXIxIA0KPSBQT0NNUl9FTiB8IFBPQ01SX0lPIHw8QlI+KyZuYnNwOyZuYnNwOygo
KH4wVUwgLSAoTVBDODN4eF9QQ0kxX1VQUEVSX0lPIC0gDQpNUEM4M3h4X1BDSTFfTE9XRVJfSU8p
KSAmZ3Q7Jmd0OyAxMikgJmFtcDsgDQpQT0NNUl9DTV9NQVNLKTs8QlI+KzxCUj4rJm5ic3A7Lyo8
QlI+KyZuYnNwOyAqIENvbmZpZ3VyZSBQQ0kgSW5ib3VuZCBUcmFuc2xhdGlvbiANCldpbmRvd3M8
QlI+KyZuYnNwOyAqLzxCUj4rJm5ic3A7cGNpX2N0cmwtJmd0O3BpdGFyMSA9IA0KMHgwOzxCUj4r
Jm5ic3A7cGNpX2N0cmwtJmd0O3BpYmFyMSA9IDB4MDs8QlI+KyZuYnNwO3BjaV9jdHJsLSZndDtw
aWViYXIxID0gDQoweDA7PEJSPismbmJzcDtwY2lfY3RybC0mZ3Q7cGl3YXIxID0gUElXQVJfRU4g
fCBQSVdBUl9QRiB8IFBJV0FSX1JUVF9TTk9PUCB8IA0KUElXQVJfV1RUX1NOT09QIHwgUElXQVJf
SVdTXzJHOzxCUj4rPEJSPismbmJzcDsvKjxCUj4rJm5ic3A7ICogUmVsZWFzZSBQQ0kgUlNUIA0K
c2lnbmFsPEJSPismbmJzcDsgKi88QlI+KyZuYnNwO3BjaV9jdHJsLSZndDtnY3IgPSANCjA7PEJS
PismbmJzcDt1ZGVsYXkoMjAwMCk7PEJSPismbmJzcDtwY2lfY3RybC0mZ3Q7Z2NyID0gDQoxOzxC
Uj4rJm5ic3A7dWRlbGF5KDIwMDApOzxCUj4rPEJSPismbmJzcDtyZWcxNiA9IA0KMHhmZjs8QlI+
KyZuYnNwO2Vhcmx5X3JlYWRfY29uZmlnX3dvcmQgKGhvc2UsaG9zZS0mZ3Q7Zmlyc3RfYnVzbm8s
MCxQQ0lfQ09NTUFORCwgDQomYW1wO3JlZzE2KTs8QlI+KyZuYnNwO3JlZzE2IHw9IFBDSV9DT01N
QU5EX1NFUlIgfCBQQ0lfQ09NTUFORF9NQVNURVIgfCANClBDSV9DT01NQU5EX01FTU9SWTs8QlI+
KyZuYnNwO2Vhcmx5X3dyaXRlX2NvbmZpZ193b3JkKGhvc2UsaG9zZS0mZ3Q7Zmlyc3RfYnVzbm8s
MCxQQ0lfQ09NTUFORCwgDQpyZWcxNik7PEJSPis8QlI+KyZuYnNwOy8qPEJSPismbmJzcDsgKiBD
bGVhciBub24tcmVzZXJ2ZWQgYml0cyBpbiBzdGF0dXMgDQpyZWdpc3Rlci48QlI+KyZuYnNwOyAN
CiovPEJSPismbmJzcDtlYXJseV93cml0ZV9jb25maWdfd29yZChob3NlLGhvc2UtJmd0O2ZpcnN0
X2J1c25vLDAsUENJX1NUQVRVUywgDQoweGZmZmYpOzxCUj4rJm5ic3A7ZWFybHlfd3JpdGVfY29u
ZmlnX2J5dGUoaG9zZSxob3NlLSZndDtmaXJzdF9idXNubywwLFBDSV9MQVRFTkNZX1RJTUVSLDB4
ODApOzxCUj4rfTxCUj4rPEJSPit2b2lkIA0KX19pbml0PEJSPittcGM4MzR4X2Fkc19zZXR1cF9w
Y2kyKHN0cnVjdCBwY2lfY29udHJvbGxlciANCipob3NlKTxCUj4rezxCUj4rJm5ic3A7dW5zaWdu
ZWQgc2hvcnQgcmVnMTY7PEJSPismbmJzcDt2b2xhdGlsZSBpbW1yX3BjaWN0cmxfdCAqIA0KcGNp
X2N0cmw7PEJSPismbmJzcDt2b2xhdGlsZSBpbW1yX2lvc190ICogaW9zOzxCUj4rJm5ic3A7YmRf
dCAqYmluZm8gPSAoYmRfdCAqKSANCl9fcmVzOzxCUj4rPEJSPismbmJzcDtwY2lfY3RybCA9IGlv
cmVtYXAoYmluZm8tJmd0O2JpX2ltbXJfYmFzZSArIA0KMHg4NjAwLDxCUj4rJm5ic3A7Jm5ic3A7
c2l6ZW9mKGltbXJfcGNpY3RybF90KSk7PEJSPismbmJzcDtpb3MgPSANCmlvcmVtYXAoYmluZm8t
Jmd0O2JpX2ltbXJfYmFzZSArIA0KMHg4NDAwLDxCUj4rJm5ic3A7Jm5ic3A7c2l6ZW9mKGltbXJf
aW9zX3QpKTs8QlI+KzxCUj4rJm5ic3A7Lyo8QlI+KyZuYnNwOyAqIA0KQ29uZmlndXJlIFBDSSBP
dXRib3VuZCBUcmFuc2xhdGlvbiBXaW5kb3dzPEJSPismbmJzcDsgDQoqLzxCUj4rJm5ic3A7aW9z
LSZndDtwb3RhcjMgPSAoTVBDODN4eF9QQ0kyX0xPV0VSX01FTSAmZ3Q7Jmd0OyAxMikgJmFtcDsg
DQpQT1RBUl9UQV9NQVNLOzxCUj4rJm5ic3A7aW9zLSZndDtwb2JhcjMgPSAoTVBDODN4eF9QQ0ky
X0xPV0VSX01FTSAmZ3Q7Jmd0OyAxMikgDQomYW1wOyBQT0JBUl9CQV9NQVNLOzxCUj4rJm5ic3A7
aW9zLSZndDtwb2NtcjMgPSBQT0NNUl9FTiB8IFBPQ01SX0RTVCB8IA0KPEJSPismbmJzcDsmbmJz
cDsoKCh+MFVMIC0gKE1QQzgzeHhfUENJMl9VUFBFUl9NRU0gLSBNUEM4M3h4X1BDSTJfTE9XRVJf
TUVNKSkgDQomZ3Q7Jmd0OyAxMikgJmFtcDsgUE9DTVJfQ01fTUFTSyk7PEJSPis8QlI+KyZuYnNw
Oy8qIG1hcHBlZCB0byBQQ0kyIElPIHNwYWNlIDB4MCANCnRvIGxvY2FsIDB4ZTMwMDAwMDAmbmJz
cDsgKi88QlI+KyZuYnNwO2lvcy0mZ3Q7cG90YXI0ID0gKE1QQzgzeHhfUENJMl9MT1dFUl9JTyAN
CiZndDsmZ3Q7IDEyKSAmYW1wOyBQT1RBUl9UQV9NQVNLOzxCUj4rJm5ic3A7aW9zLSZndDtwb2Jh
cjQgPSANCihNUEM4M3h4X1BDSTJfSU9fQkFTRSAmZ3Q7Jmd0OyAxMikgJmFtcDsgUE9CQVJfQkFf
TUFTSzs8QlI+KyZuYnNwO2lvcy0mZ3Q7cG9jbXI0IA0KPSBQT0NNUl9FTiB8IFBPQ01SX0RTVCB8
IFBPQ01SX0lPIHw8QlI+KyZuYnNwOyZuYnNwOygoKH4wVUwgLSANCihNUEM4M3h4X1BDSTJfVVBQ
RVJfSU8gLSBNUEM4M3h4X1BDSTJfTE9XRVJfSU8pKSAmZ3Q7Jmd0OyAxMikgJmFtcDsgDQpQT0NN
Ul9DTV9NQVNLKTs8QlI+KzxCUj4rJm5ic3A7Lyo8QlI+KyZuYnNwOyAqIENvbmZpZ3VyZSBQQ0kg
SW5ib3VuZCBUcmFuc2xhdGlvbiANCldpbmRvd3M8QlI+KyZuYnNwOyAqLzxCUj4rJm5ic3A7cGNp
X2N0cmwtJmd0O3BpdGFyMSA9IA0KMHgwOzxCUj4rJm5ic3A7cGNpX2N0cmwtJmd0O3BpYmFyMSA9
IDB4MDs8QlI+KyZuYnNwO3BjaV9jdHJsLSZndDtwaWViYXIxID0gDQoweDA7PEJSPismbmJzcDtw
Y2lfY3RybC0mZ3Q7cGl3YXIxID0gUElXQVJfRU4gfCBQSVdBUl9QRiB8IFBJV0FSX1JUVF9TTk9P
UCB8IA0KUElXQVJfV1RUX1NOT09QIHwgUElXQVJfSVdTXzJHOzxCUj4rPEJSPismbmJzcDsvKjxC
Uj4rJm5ic3A7ICogUmVsZWFzZSBQQ0kgUlNUIA0Kc2lnbmFsPEJSPismbmJzcDsgKi88QlI+KyZu
YnNwO3BjaV9jdHJsLSZndDtnY3IgPSANCjA7PEJSPismbmJzcDt1ZGVsYXkoMjAwMCk7PEJSPism
bmJzcDtwY2lfY3RybC0mZ3Q7Z2NyID0gDQoxOzxCUj4rJm5ic3A7dWRlbGF5KDIwMDApOzxCUj4r
PEJSPismbmJzcDtyZWcxNiA9IA0KMHhmZjs8QlI+KyZuYnNwO2Vhcmx5X3JlYWRfY29uZmlnX3dv
cmQgKGhvc2UsaG9zZS0mZ3Q7Zmlyc3RfYnVzbm8sMCxQQ0lfQ09NTUFORCwgDQomYW1wO3JlZzE2
KTs8QlI+KyZuYnNwO3JlZzE2IHw9IFBDSV9DT01NQU5EX1NFUlIgfCBQQ0lfQ09NTUFORF9NQVNU
RVIgfCANClBDSV9DT01NQU5EX01FTU9SWTs8QlI+KyZuYnNwO2Vhcmx5X3dyaXRlX2NvbmZpZ193
b3JkKGhvc2UsaG9zZS0mZ3Q7Zmlyc3RfYnVzbm8sMCxQQ0lfQ09NTUFORCwgDQpyZWcxNik7PEJS
Pis8QlI+KyZuYnNwOy8qPEJSPismbmJzcDsgKiBDbGVhciBub24tcmVzZXJ2ZWQgYml0cyBpbiBz
dGF0dXMgDQpyZWdpc3Rlci48QlI+KyZuYnNwOyANCiovPEJSPismbmJzcDtlYXJseV93cml0ZV9j
b25maWdfd29yZChob3NlLGhvc2UtJmd0O2ZpcnN0X2J1c25vLDAsUENJX1NUQVRVUywgDQoweGZm
ZmYpOzxCUj4rJm5ic3A7ZWFybHlfd3JpdGVfY29uZmlnX2J5dGUoaG9zZSxob3NlLSZndDtmaXJz
dF9idXNubywwLFBDSV9MQVRFTkNZX1RJTUVSLDB4ODApOzxCUj4rfTxCUj4rPEJSPitleHRlcm4g
DQppbnQgbXBjODN4eF9hZHNfbWFwX2lycShzdHJ1Y3QgcGNpX2RldiAqZGV2LCB1bnNpZ25lZCBj
aGFyIGlkc2VsLCB1bnNpZ25lZCBjaGFyIA0KcGluKTs8QlI+K2V4dGVybiBpbnQgbXBjODN4eF9h
ZHNfZXhjbHVkZV9kZXZpY2UodV9jaGFyIGJ1cyx1X2NoYXIgDQpkZXZmbik7PEJSPis8QlI+Ky8q
PEJSPisgKiBQQ0kgYnVzZXMgY2FuIGJlIGVuYWJsZWQgb25seSBpZiBTWVMgYm9hcmQgY29tYmlu
YXRlcyANCndpdGggUElCKFBsYXRmb3JtIElPIEJvYXJkKSBib2FyZDxCUj4rICogd2hpY2ggcHJv
dmlkZSAzIFBDSSBzbG90cy4gVGhlcmUgaXMgMiANClBDSSBidXNlcyBhbmQgMyBQQ0kgc2xvdHMs
c28gcGVvcGxlIG11c3QgY29uZmlndXJlPEJSPisgKiB0aGUgcm91dGVzIGJldHdlZW4gDQp0aGVt
IGJlZm9yZSBlbmFibGUgUENJIGJ1cy4gVGhpcyByb3V0ZXMgYXJlIHVuZGVyIHRoZSBjb250cm9s
IG9mIFBDQTk1NTVQVyA8QlI+KyANCiogZGV2aWNlIHdoaWNoIGNhbiBiZSBhY2Nlc3NlZCB2aWEg
STJDIGJ1cyAyIGFuZCBhcmUgY29uZmlndXJlZCBieSBmaXJtd2FyZS4gDQpSZWZlciB0byBGcmVl
c2NhbGUgdG88QlI+KyAqIGdldCBtb3JlIGluZm9ybWF0aW9uIGFib3V0IGZpcm13YXJlIA0KY29u
ZmlndXJhdGlvbi48QlI+KyAqLzxCUj4rdm9pZCANCl9faW5pdDxCUj4rbXBjODN4eF9zZXR1cF9o
b3NlKHZvaWQpPEJSPit7PEJSPismbmJzcDt1bnNpZ25lZCBsb25nIA0KdmFsMzI7PEJSPismbmJz
cDt2b2xhdGlsZSBpbW1yX2Nsa190ICogY2xrOzxCUj4rJm5ic3A7dm9sYXRpbGUgc3RydWN0IA0K
cGNpX2NvbnRyb2xsZXIgKiBob3NlMTs8QlI+KyNpZmRlZiBDT05GSUdfTVBDODM0eF9QQ0kyPEJS
PismbmJzcDt2b2xhdGlsZSBzdHJ1Y3QgDQpwY2lfY29udHJvbGxlciAqIGhvc2UyOzxCUj4rI2Vu
ZGlmPEJSPismbmJzcDt2b2xhdGlsZSBiZF90ICogYmluZm8gPSAoYmRfdCANCiopX19yZXM7PEJS
Pis8QlI+KyZuYnNwO2NsayA9IGlvcmVtYXAoYmluZm8tJmd0O2JpX2ltbXJfYmFzZSArIA0KMHhB
MDAsPEJSPismbmJzcDsmbmJzcDtzaXplb2YoaW1tcl9jbGtfdCkpOzxCUj4rJm5ic3A7PEJSPism
bmJzcDsvKjxCUj4rJm5ic3A7ICogDQpDb25maWd1cmUgUENJIGNvbnRyb2xsZXIgYW5kIFBDSV9D
TEtfT1VUUFVUIGJvdGggaW4gNjZNIG1vZGU8QlI+KyZuYnNwOyANCiovPEJSPismbmJzcDt2YWwz
MiA9IA0KY2xrLSZndDtvY2NyOzxCUj4rJm5ic3A7dWRlbGF5KDIwMDApOzxCUj4rJm5ic3A7Y2xr
LSZndDtvY2NyID0gDQoweGZmMDAwMDAwOzxCUj4rJm5ic3A7dWRlbGF5KDIwMDApOzxCUj4rPEJS
PismbmJzcDtob3NlMSA9IA0KcGNpYmlvc19hbGxvY19jb250cm9sbGVyKCk7PEJSPismbmJzcDtp
ZighaG9zZTEpPEJSPismbmJzcDsmbmJzcDtyZXR1cm47PEJSPis8QlI+KyZuYnNwO3BwY19tZC5w
Y2lfc3dpenpsZSANCj0gY29tbW9uX3N3aXp6bGU7PEJSPismbmJzcDtwcGNfbWQucGNpX21hcF9p
cnEgPSANCm1wYzgzeHhfYWRzX21hcF9pcnE7PEJSPis8QlI+KyZuYnNwO2hvc2UxLSZndDtidXNf
b2Zmc2V0ID0gDQowOzxCUj4rJm5ic3A7aG9zZTEtJmd0O2ZpcnN0X2J1c25vID0gMDs8QlI+KyZu
YnNwO2hvc2UxLSZndDtsYXN0X2J1c25vID0gDQoweGZmOzxCUj4rPEJSPismbmJzcDtzZXR1cF9p
bmRpcmVjdF9wY2koaG9zZTEsIGJpbmZvLSZndDtiaV9pbW1yX2Jhc2UgKyANClBDSTFfQ0ZHX0FE
RFJfT0ZGU0VULDxCUj4rJm5ic3A7Jm5ic3A7YmluZm8tJmd0O2JpX2ltbXJfYmFzZSArIA0KUENJ
MV9DRkdfREFUQV9PRkZTRVQpOzxCUj4rJm5ic3A7aG9zZTEtJmd0O3NldF9jZmdfdHlwZSA9IA0K
MTs8QlI+KzxCUj4rJm5ic3A7bXBjODN4eF9zZXR1cF9wY2kxKGhvc2UxKTs8QlI+KzxCUj4rJm5i
c3A7aG9zZTEtJmd0O3BjaV9tZW1fb2Zmc2V0IA0KPSBNUEM4M3h4X1BDSTFfTUVNX09GRlNFVDs8
QlI+KyZuYnNwO2hvc2UxLSZndDttZW1fc3BhY2Uuc3RhcnQgPSANCk1QQzgzeHhfUENJMV9MT1dF
Ul9NRU07PEJSPismbmJzcDtob3NlMS0mZ3Q7bWVtX3NwYWNlLmVuZCA9IA0KTVBDODN4eF9QQ0kx
X1VQUEVSX01FTTs8QlI+KzxCUj4rJm5ic3A7aG9zZTEtJmd0O2lvX2Jhc2VfcGh5cyA9IA0KTVBD
ODN4eF9QQ0kxX0lPX0JBU0U7PEJSPismbmJzcDtob3NlMS0mZ3Q7aW9fc3BhY2Uuc3RhcnQgPSAN
Ck1QQzgzeHhfUENJMV9MT1dFUl9JTzs8QlI+KyZuYnNwO2hvc2UxLSZndDtpb19zcGFjZS5lbmQg
PSANCk1QQzgzeHhfUENJMV9VUFBFUl9JTzs8QlI+KyNpZmRlZiBDT05GSUdfTVBDODM0eF9QQ0ky
PEJSPismbmJzcDtpc2FfaW9fYmFzZSA9IA0KKHVuc2lnbmVkIA0KbG9uZylpb3JlbWFwKE1QQzgz
eHhfUENJMV9JT19CQVNFLDxCUj4rJm5ic3A7Jm5ic3A7TVBDODN4eF9QQ0kxX0lPX1NJWkUrTVBD
ODN4eF9QQ0kyX0lPX1NJWkUpOzxCUj4rI2Vsc2U8QlI+KyZuYnNwO2lzYV9pb19iYXNlIA0KPSAo
dW5zaWduZWQgDQpsb25nKWlvcmVtYXAoTVBDODN4eF9QQ0kxX0lPX0JBU0UsPEJSPismbmJzcDsm
bmJzcDtNUEM4M3h4X1BDSTFfSU9fU0laRSk7PEJSPisjZW5kaWYgDQovKiBDT05GSUdfTVBDODM0
eF9QQ0kyICovPEJSPismbmJzcDtob3NlMS0mZ3Q7aW9fYmFzZV92aXJ0ID0gKHZvaWQgDQoqKWlz
YV9pb19iYXNlOzxCUj4rJm5ic3A7Lyogc2V0dXAgcmVzb3VyY2VzIA0KKi88QlI+KyZuYnNwO3Bj
aV9pbml0X3Jlc291cmNlKCZhbXA7aG9zZTEtJmd0O2lvX3Jlc291cmNlLDxCUj4rJm5ic3A7Jm5i
c3A7Jm5ic3A7TVBDODN4eF9QQ0kxX0xPV0VSX0lPLDxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7TVBD
ODN4eF9QQ0kxX1VQUEVSX0lPLDxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7SU9SRVNPVVJDRV9JTywi
UENJIA0KaG9zdCBicmlkZ2UgDQoxIik7PEJSPismbmJzcDtwY2lfaW5pdF9yZXNvdXJjZSgmYW1w
O2hvc2UxLSZndDttZW1fcmVzb3VyY2VzWzBdLDxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7TVBDODN4
eF9QQ0kxX0xPV0VSX01FTSw8QlI+KyZuYnNwOyZuYnNwOyZuYnNwO01QQzgzeHhfUENJMV9VUFBF
Ul9NRU0sPEJSPismbmJzcDsmbmJzcDsmbmJzcDtJT1JFU09VUkNFX01FTSwiUENJIA0KaG9zdCBi
cmlkZ2UgMSIpOzxCUj4rPEJSPismbmJzcDtwcGNfbWQucGNpX2V4Y2x1ZGVfZGV2aWNlID0gDQpt
cGM4M3h4X2Fkc19leGNsdWRlX2RldmljZTs8QlI+KyZuYnNwO2hvc2UxLSZndDtsYXN0X2J1c25v
ID0gDQpwY2lhdXRvX2J1c19zY2FuKGhvc2UxLCBob3NlMS0mZ3Q7Zmlyc3RfYnVzbm8pOzxCUj4r
PEJSPisjaWZkZWYgDQpDT05GSUdfTVBDODM0eF9QQ0kyPEJSPismbmJzcDtob3NlMiA9IA0KcGNp
Ymlvc19hbGxvY19jb250cm9sbGVyKCk7PEJSPismbmJzcDtpZighaG9zZTIpPEJSPismbmJzcDsm
bmJzcDtyZXR1cm47PEJSPis8QlI+KyZuYnNwO2hvc2UyLSZndDtidXNfb2Zmc2V0IA0KPSBob3Nl
MS0mZ3Q7bGFzdF9idXNubyArIDE7PEJSPismbmJzcDtob3NlMi0mZ3Q7Zmlyc3RfYnVzbm8gPSAN
Cmhvc2UxLSZndDtsYXN0X2J1c25vICsgMTs8QlI+KyZuYnNwO2hvc2UyLSZndDtsYXN0X2J1c25v
ID0gDQoweGZmOzxCUj4rJm5ic3A7c2V0dXBfaW5kaXJlY3RfcGNpKGhvc2UyLCBiaW5mby0mZ3Q7
YmlfaW1tcl9iYXNlICsgDQpQQ0kyX0NGR19BRERSX09GRlNFVCw8QlI+KyZuYnNwOyZuYnNwO2Jp
bmZvLSZndDtiaV9pbW1yX2Jhc2UgKyANClBDSTJfQ0ZHX0RBVEFfT0ZGU0VUKTs8QlI+KyZuYnNw
O2hvc2UyLSZndDtzZXRfY2ZnX3R5cGUgPSANCjE7PEJSPis8QlI+KyZuYnNwO21wYzgzNHhfYWRz
X3NldHVwX3BjaTIoaG9zZTIpOzxCUj4rPEJSPismbmJzcDtob3NlMi0mZ3Q7cGNpX21lbV9vZmZz
ZXQgDQo9IE1QQzgzeHhfUENJMl9NRU1fT0ZGU0VUOzxCUj4rJm5ic3A7aG9zZTItJmd0O21lbV9z
cGFjZS5zdGFydCA9IA0KTVBDODN4eF9QQ0kyX0xPV0VSX01FTTs8QlI+KyZuYnNwO2hvc2UyLSZn
dDttZW1fc3BhY2UuZW5kID0gDQpNUEM4M3h4X1BDSTJfVVBQRVJfTUVNOzxCUj4rPEJSPismbmJz
cDtob3NlMi0mZ3Q7aW9fYmFzZV9waHlzID0gDQpNUEM4M3h4X1BDSTJfSU9fQkFTRTs8QlI+KyZu
YnNwO2hvc2UyLSZndDtpb19zcGFjZS5zdGFydCA9IA0KTVBDODN4eF9QQ0kyX0xPV0VSX0lPOzxC
Uj4rJm5ic3A7aG9zZTItJmd0O2lvX3NwYWNlLmVuZCA9IA0KTVBDODN4eF9QQ0kyX1VQUEVSX0lP
OzxCUj4rJm5ic3A7aG9zZTItJmd0O2lvX2Jhc2VfdmlydCA9ICh2b2lkICopKGlzYV9pb19iYXNl
ICsgDQpNUEM4M3h4X1BDSTFfSU9fU0laRSk7PEJSPismbmJzcDsvKiBzZXR1cCByZXNvdXJjZXMg
DQoqLzxCUj4rJm5ic3A7cGNpX2luaXRfcmVzb3VyY2UoJmFtcDtob3NlMi0mZ3Q7aW9fcmVzb3Vy
Y2UsPEJSPismbmJzcDsmbmJzcDsmbmJzcDtNUEM4M3h4X1BDSTJfTE9XRVJfSU8sPEJSPismbmJz
cDsmbmJzcDsmbmJzcDtNUEM4M3h4X1BDSTJfVVBQRVJfSU8sPEJSPismbmJzcDsmbmJzcDsmbmJz
cDtJT1JFU09VUkNFX0lPLCJQQ0kgDQpob3N0IGJyaWRnZSANCjIiKTs8QlI+KyZuYnNwO3BjaV9p
bml0X3Jlc291cmNlKCZhbXA7aG9zZTItJmd0O21lbV9yZXNvdXJjZXNbMF0sPEJSPismbmJzcDsm
bmJzcDsmbmJzcDtNUEM4M3h4X1BDSTJfTE9XRVJfTUVNLDxCUj4rJm5ic3A7Jm5ic3A7Jm5ic3A7
TVBDODN4eF9QQ0kyX1VQUEVSX01FTSw8QlI+KyZuYnNwOyZuYnNwOyZuYnNwO0lPUkVTT1VSQ0Vf
TUVNLCJQQ0kgDQpob3N0IGJyaWRnZSAyIik7PEJSPis8QlI+KyZuYnNwO2hvc2UyLSZndDtsYXN0
X2J1c25vID0gcGNpYXV0b19idXNfc2Nhbihob3NlMiwgDQpob3NlMi0mZ3Q7Zmlyc3RfYnVzbm8p
OzxCUj4rI2VuZGlmIC8qIENPTkZJR19NUEM4MzR4X1BDSTIgKi88QlI+K308QlI+KyNlbmRpZiAN
Ci8qQ09ORklHX1BDSSovPEJSPmRpZmYgLXVyTiAtWCBkb250ZGlmZiANCmxpbnV4LTIuNi4xMy1y
YzYvYXJjaC9wcGMvc3lzbGliL3BwYzgzeHhfc2V0dXAuaCANCmxpbnV4LTIuNi4xMy1yYzYtcGNp
L2FyY2gvcHBjL3N5c2xpYi9wcGM4M3h4X3NldHVwLmg8QlI+LS0tIA0KbGludXgtMi42LjEzLXJj
Ni9hcmNoL3BwYy9zeXNsaWIvcHBjODN4eF9zZXR1cC5oJm5ic3A7MjAwNS0wNi0xOCANCjAzOjQ4
OjI5LjAwMDAwMDAwMCArMDgwMDxCUj4rKysgDQpsaW51eC0yLjYuMTMtcmM2LXBjaS9hcmNoL3Bw
Yy9zeXNsaWIvcHBjODN4eF9zZXR1cC5oJm5ic3A7MjAwNS0wOC0yMyANCjEwOjAwOjU0LjAwMDAw
MDAwMCArMDgwMDxCUj5AQCAtMTIsNiArMTIsMTQgQEA8QlI+Jm5ic3A7ICogRnJlZSBTb2Z0d2Fy
ZSANCkZvdW5kYXRpb247Jm5ic3A7IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlJm5ic3A7IExpY2Vu
c2UsIG9yIChhdCB5b3VyPEJSPiZuYnNwOyAqIA0Kb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi48
QlI+Jm5ic3A7ICo8QlI+KyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgDQpo
b3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1dDxCUj4rICogV0lUSE9VVCBBTlkgV0FSUkFO
VFk7IHdpdGhvdXQgZXZlbiB0aGUgDQppbXBsaWVkIHdhcnJhbnR5IG9mPEJSPisgKiBNRVJDSEFO
VEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIA0KUFVSUE9TRS4mbmJzcDsgU2Vl
IHRoZSBHTlU8QlI+KyAqIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy48
QlI+KyANCio8QlI+KyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlJm5i
c3A7IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIA0KYWxvbmc8QlI+KyAqIHdpdGggdGhpcyBw
cm9ncmFtOyBpZiBub3QsIHdyaXRlJm5ic3A7IHRvIHRoZSBGcmVlIFNvZnR3YXJlIA0KRm91bmRh
dGlvbiwgSW5jLiw8QlI+KyAqIDY3NSBNYXNzIEF2ZSwgQ2FtYnJpZGdlLCBNQSAwMjEzOSwgVVNB
LjxCUj4mbmJzcDsgDQoqLzxCUj4mbmJzcDs8QlI+Jm5ic3A7I2lmbmRlZiBfX1BQQ19TWVNMSUJf
UFBDODNYWF9TRVRVUF9IPEJSPkBAIC0yMCw2ICsyOCw3IA0KQEA8QlI+Jm5ic3A7I2luY2x1ZGUg
Jmx0O2xpbnV4L2NvbmZpZy5oJmd0OzxCUj4mbmJzcDsjaW5jbHVkZSANCiZsdDtsaW51eC9pbml0
LmgmZ3Q7PEJSPiZuYnNwOyNpbmNsdWRlICZsdDthc20vcHBjYm9vdC5oJmd0OzxCUj4rI2luY2x1
ZGUgDQombHQ7YXNtL21wYzgzeHguaCZndDs8QlI+Jm5ic3A7PEJSPiZuYnNwO2V4dGVybiB1bnNp
Z25lZCBsb25nIA0KbXBjODN4eF9maW5kX2VuZF9vZl9tZW1vcnkodm9pZCkgX19pbml0OzxCUj4m
bmJzcDtleHRlcm4gbG9uZyANCm1wYzgzeHhfdGltZV9pbml0KHZvaWQpIF9faW5pdDs8QlI+QEAg
LTMwLDE1ICszOSw2IEBAPEJSPiZuYnNwO2V4dGVybiB2b2lkIA0KbXBjODN4eF9oYWx0KHZvaWQp
OzxCUj4mbmJzcDtleHRlcm4gdm9pZCBtcGM4M3h4X3NldHVwX2hvc2Uodm9pZCkgDQpfX2luaXQ7
PEJSPiZuYnNwOzxCUj4tLyogUENJIGNvbmZpZyAqLzxCUj4tI2lmIDA8QlI+LSNkZWZpbmUgDQpQ
Q0kxX0NGR19BRERSX09GRlNFVCZuYnNwOyhGSVhNRSk8QlI+LSNkZWZpbmUgDQpQQ0kxX0NGR19E
QVRBX09GRlNFVCZuYnNwOyhGSVhNRSk8QlI+LTxCUj4tI2RlZmluZSANClBDSTJfQ0ZHX0FERFJf
T0ZGU0VUJm5ic3A7KEZJWE1FKTxCUj4tI2RlZmluZSANClBDSTJfQ0ZHX0RBVEFfT0ZGU0VUJm5i
c3A7KEZJWE1FKTxCUj4tI2VuZGlmPEJSPi08QlI+Jm5ic3A7LyogU2VyaWFsIENvbmZpZyANCiov
PEJSPiZuYnNwOyNpZmRlZiBDT05GSUdfU0VSSUFMX01BTllfUE9SVFM8QlI+Jm5ic3A7I2RlZmlu
ZSBSU19UQUJMRV9TSVpFJm5ic3A7IA0KNjQ8QlI+PC9GT05UPjwvRElWPjwvQk9EWT48L0hUTUw+
DQo=

------_=_NextPart_001_01C5AC78.8DA96B5B--

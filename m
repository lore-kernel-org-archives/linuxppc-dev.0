Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 4F5F1679E1
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 02:16:27 +1000 (EST)
Message-ID: <429F30D7.2040806@ru.mvista.com>
Date: Thu, 02 Jun 2005 20:16:23 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------030003070506090707000309"
Subject: [RFC] PlatformDevice definitions for 82xx
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
--------------030003070506090707000309
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hi!
This adds platform definition files for 82xx, while the platform_info is 
filled in board-specific .C file residing in platforms/82xx. Another 
disputable thing I did - I moved m8260_setup.c from the syslib/ up to 
platforms/82xx/. The file was slightly changed  - added 2 prototypes 
from the cpm2_pic.h and removed the respective include.

These defs will be utilized by fs_enet driver which is developed 
currently by Pantelis and me.

Comments, suggestions appreciated.

-- 
Sincerely, 
Vitaly


--------------030003070506090707000309
Content-Type: text/x-patch;
 name="platf_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="platf_init.patch"

initial platform defenitions

---
commit 1a7a351106fed3353484b808074522e223b012a6
tree 072e120576417512a61676af3bfc422268ebfdf9
parent 88d7bd8cb9eb8d64bf7997600b0d64f7834047c5
author Vitaly Bordug <vvv@localhost.localdomain> 1117637659 +0400
committer Vitaly Bordug <vvv@localhost.localdomain> 1117637659 +0400

Index: arch/ppc/Makefile
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/arch/ppc/Makefile  (mode:100644 sha1:0432a25b47354e75d0a09e4b2817d1afe7849313)
+++ 072e120576417512a61676af3bfc422268ebfdf9/arch/ppc/Makefile  (mode:100644 sha1:b251420f5dd9e85be90699e682799ff1e6993cc4)
@@ -60,6 +60,7 @@
 core-$(CONFIG_4xx)		+= arch/ppc/platforms/4xx/
 core-$(CONFIG_83xx)		+= arch/ppc/platforms/83xx/
 core-$(CONFIG_85xx)		+= arch/ppc/platforms/85xx/
+core-$(CONFIG_8260)		+= arch/ppc/platforms/82xx/
 core-$(CONFIG_MATH_EMULATION)	+= arch/ppc/math-emu/
 core-$(CONFIG_XMON)		+= arch/ppc/xmon/
 core-$(CONFIG_APUS)		+= arch/ppc/amiga/
Index: arch/ppc/platforms/82xx/Makefile
===================================================================
--- /dev/null  (tree:eed337ef5e9ae7d62caa84b7974a11fddc7f06e0)
+++ 072e120576417512a61676af3bfc422268ebfdf9/arch/ppc/platforms/82xx/Makefile  (mode:100644 sha1:6909aa63a062de13c246439b5fd97b4c45b110db)
@@ -0,0 +1,4 @@
+#
+# Makefile for the PowerPC 82xx linux kernel.
+#
+obj-$(CONFIG_8260)	+= m8260_setup.o pq2ads_pd.o
\ No newline at end of file
Index: arch/ppc/platforms/82xx/m8260_setup.c
===================================================================
--- /dev/null  (tree:eed337ef5e9ae7d62caa84b7974a11fddc7f06e0)
+++ 072e120576417512a61676af3bfc422268ebfdf9/arch/ppc/platforms/82xx/m8260_setup.c  (mode:100644 sha1:77d88db0490ccf71ddad38f6b10d0698e7aeb4cb)
@@ -0,0 +1,268 @@
+/*
+ *  arch/ppc/syslib/m8260_setup.c
+ *
+ *  Copyright (C) 1995  Linus Torvalds
+ *  Adapted from 'alpha' version by Gary Thomas
+ *  Modified by Cort Dougan (cort@cs.nmt.edu)
+ *  Modified for MBX using prep/chrp/pmac functions by Dan (dmalek@jlc.net)
+ *  Further modified for generic 8xx and 8260 by Dan.
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/initrd.h>
+#include <linux/root_dev.h>
+#include <linux/seq_file.h>
+#include <linux/irq.h>
+
+#include <asm/mmu.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/mpc8260.h>
+#include <asm/immap_cpm2.h>
+#include <asm/machdep.h>
+#include <asm/bootinfo.h>
+#include <asm/time.h>
+
+
+unsigned char __res[sizeof(bd_t)];
+
+extern int cpm2_get_irq(struct pt_regs *regs);
+extern void cpm2_init_IRQ(void);
+
+extern void cpm2_reset(void);
+extern void m8260_find_bridges(void);
+extern void idma_pci9_init(void);
+extern void pq2_setup_pd(void);
+
+/* Place-holder for board-specific init */
+void __attribute__ ((weak)) __init
+m82xx_board_setup(void)
+{
+}
+
+static void __init
+m8260_setup_arch(void)
+{
+	/* Print out Vendor and Machine info. */
+	printk(KERN_INFO "%s %s port\n", CPUINFO_VENDOR, CPUINFO_MACHINE);
+
+	/* Reset the Communication Processor Module. */
+	cpm2_reset();
+#ifdef CONFIG_8260_PCI9
+	/* Initialise IDMA for PCI erratum workaround */
+	idma_pci9_init();
+#endif
+#ifdef CONFIG_PCI_8260
+	m8260_find_bridges();
+#endif
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+#endif
+	m82xx_board_setup();
+	pq2_setup_pd();
+}
+
+/* The decrementer counts at the system (internal) clock frequency
+ * divided by four.
+ */
+static void __init
+m8260_calibrate_decr(void)
+{
+	bd_t *binfo = (bd_t *)__res;
+	int freq, divisor;
+
+	freq = binfo->bi_busfreq;
+        divisor = 4;
+        tb_ticks_per_jiffy = freq / HZ / divisor;
+	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
+}
+
+/* The 8260 has an internal 1-second timer update register that
+ * we should use for this purpose.
+ */
+static uint rtc_time;
+
+static int
+m8260_set_rtc_time(unsigned long time)
+{
+	rtc_time = time;
+
+	return(0);
+}
+
+static unsigned long
+m8260_get_rtc_time(void)
+{
+	/* Get time from the RTC.
+	*/
+	return((unsigned long)rtc_time);
+}
+
+#ifndef BOOTROM_RESTART_ADDR
+#warning "Using default BOOTROM_RESTART_ADDR!"
+#define BOOTROM_RESTART_ADDR	0xff000104
+#endif
+
+static void
+m8260_restart(char *cmd)
+{
+	extern void m8260_gorom(bd_t *bi, uint addr);
+	uint	startaddr;
+
+	/* Most boot roms have a warmstart as the second instruction
+	 * of the reset vector.  If that doesn't work for you, change this
+	 * or the reboot program to send a proper address.
+	 */
+	startaddr = BOOTROM_RESTART_ADDR;
+	if (cmd != NULL) {
+		if (!strncmp(cmd, "startaddr=", 10))
+			startaddr = simple_strtoul(&cmd[10], NULL, 0);
+	}
+
+	m8260_gorom((void*)__pa(__res), startaddr);
+}
+
+static void
+m8260_halt(void)
+{
+	local_irq_disable();
+	while (1);
+}
+
+static void
+m8260_power_off(void)
+{
+	m8260_halt();
+}
+
+static int
+m8260_show_cpuinfo(struct seq_file *m)
+{
+	bd_t *bp = (bd_t *)__res;
+
+	seq_printf(m, "vendor\t\t: %s\n"
+		   "machine\t\t: %s\n"
+		   "\n"
+		   "mem size\t\t: 0x%08x\n"
+		   "console baud\t\t: %d\n"
+		   "\n"
+		   "core clock\t: %u MHz\n"
+		   "CPM  clock\t: %u MHz\n"
+		   "bus  clock\t: %u MHz\n",
+		   CPUINFO_VENDOR, CPUINFO_MACHINE, bp->bi_memsize,
+		   bp->bi_baudrate, bp->bi_intfreq / 1000000,
+		   bp->bi_cpmfreq / 1000000, bp->bi_busfreq / 1000000);
+	return 0;
+}
+
+/* Initialize the internal interrupt controller.  The number of
+ * interrupts supported can vary with the processor type, and the
+ * 8260 family can have up to 64.
+ * External interrupts can be either edge or level triggered, and
+ * need to be initialized by the appropriate driver.
+ */
+static void __init
+m8260_init_IRQ(void)
+{
+	cpm2_init_IRQ();
+
+	/* Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	cpm2_immr->im_intctl.ic_siprr = 0x05309770;
+}
+
+/*
+ * Same hack as 8xx
+ */
+static unsigned long __init
+m8260_find_end_of_memory(void)
+{
+	bd_t *binfo = (bd_t *)__res;
+
+	return binfo->bi_memsize;
+}
+
+/* Map the IMMR, plus anything else we can cover
+ * in that upper space according to the memory controller
+ * chip select mapping.  Grab another bunch of space
+ * below that for stuff we can't cover in the upper.
+ */
+static void __init
+m8260_map_io(void)
+{
+	uint addr;
+
+	/* Map IMMR region to a 256MB BAT */
+	addr = (cpm2_immr != NULL) ? (uint)cpm2_immr : CPM_MAP_ADDR;
+	io_block_mapping(addr, addr, 0x10000000, _PAGE_IO);
+
+	/* Map I/O region to a 256MB BAT */
+	io_block_mapping(IO_VIRT_ADDR, IO_PHYS_ADDR, 0x10000000, _PAGE_IO);
+}
+
+/* Place-holder for board-specific ppc_md hooking */
+void __attribute__ ((weak)) __init
+m82xx_board_init(void)
+{
+}
+
+/* Inputs:
+ *   r3 - Optional pointer to a board information structure.
+ *   r4 - Optional pointer to the physical starting address of the init RAM
+ *        disk.
+ *   r5 - Optional pointer to the physical ending address of the init RAM
+ *        disk.
+ *   r6 - Optional pointer to the physical starting address of any kernel
+ *        command-line parameters.
+ *   r7 - Optional pointer to the physical ending address of any kernel
+ *        command-line parameters.
+ */
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	      unsigned long r6, unsigned long r7)
+{
+	parse_bootinfo(find_bootinfo());
+
+	if ( r3 )
+		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* take care of initrd if we have one */
+	if ( r4 ) {
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+	/* take care of cmd line */
+	if ( r6 ) {
+		*(char *)(r7+KERNELBASE) = 0;
+		strcpy(cmd_line, (char *)(r6+KERNELBASE));
+	}
+
+	ppc_md.setup_arch		= m8260_setup_arch;
+	ppc_md.show_cpuinfo		= m8260_show_cpuinfo;
+	ppc_md.init_IRQ			= m8260_init_IRQ;
+	ppc_md.get_irq			= cpm2_get_irq;
+
+	ppc_md.restart			= m8260_restart;
+	ppc_md.power_off		= m8260_power_off;
+	ppc_md.halt			= m8260_halt;
+
+	ppc_md.set_rtc_time		= m8260_set_rtc_time;
+	ppc_md.get_rtc_time		= m8260_get_rtc_time;
+	ppc_md.calibrate_decr		= m8260_calibrate_decr;
+
+	ppc_md.find_end_of_memory	= m8260_find_end_of_memory;
+	ppc_md.setup_io_mappings	= m8260_map_io;
+
+	/* Call back for board-specific settings and overrides. */
+	m82xx_board_init();
+}
Index: arch/ppc/platforms/82xx/pq2ads_pd.c
===================================================================
--- /dev/null  (tree:eed337ef5e9ae7d62caa84b7974a11fddc7f06e0)
+++ 072e120576417512a61676af3bfc422268ebfdf9/arch/ppc/platforms/82xx/pq2ads_pd.c  (mode:100644 sha1:e4c6ce54f2d8def183dbdc6490c0a9bbcb9c9470)
@@ -0,0 +1,117 @@
+/*
+ * arch/ppc/platforms/82xx/pq2ads_pd.c
+ *
+ * MPC82xx Board-specific PlatformDevice descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include <linux/fs_enet_pd.h>
+
+#include <asm/mpc8260.h>
+#include <asm/cpm2.h>
+#include <asm/immap_cpm2.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+#include <asm/ppcboot.h>
+
+#include "pq2ads_pd.h"
+
+static struct fs_mii_bus_info mii_bus_info = {
+	.method                 = fsmii_bitbang,
+	.id                     = 0,
+	.i.bitbang = {
+		.mdio_port	= fsiop_portc,
+		.mdio_bit	= 9,
+		.mdc_port	= fsiop_portc,
+		.mdc_bit	= 10,
+		.delay		= 1,
+	},
+};
+
+
+/*
+ The PHY_INTERRUPT crap is odd but will be replaced by pmac-like feature_call 
+ as soon as it will be checked in. -vb
+ */
+
+static struct fs_platform_info mpc82xx_fcc1_pdata = {
+	.fs_no		= fsid_fcc1,
+	.cp_page	= CPM_CR_FCC1_PAGE,
+	.cp_block 	= CPM_CR_FCC1_SBLOCK,
+	.clk_trx 	= (PC_F1RXCLK | PC_F1TXCLK),
+	.clk_route	= CMX1_CLK_ROUTE,
+	.clk_mask	= CMX1_CLK_MASK,
+	.mdio		= PC_MDIO,
+	.mdck		= PC_MDCK,
+	
+	.phy_addr	= -1,
+#ifdef PHY_INTERRUPT
+	.phy_irq	= PHY_INTERRUPT,
+#endif
+	.bus_info	= &mii_bus_info,
+	.rx_ring	= 32,
+	.tx_ring	= 32,
+	.rx_copybreak	= 240,
+	.use_napi	= 0,
+	.napi_weight	= 17,
+};
+
+static struct fs_platform_info mpc82xx_fcc2_pdata = {
+	.fs_no		= fsid_fcc2,
+	.cp_page	= CPM_CR_FCC2_PAGE,
+	.cp_block 	= CPM_CR_FCC2_SBLOCK,
+	.clk_trx 	= (PC_F2RXCLK | PC_F2TXCLK),
+	.clk_route	= CMX2_CLK_ROUTE,
+	.clk_mask	= CMX2_CLK_MASK,
+	.mdio		= PC_MDIO,
+	.mdck		= PC_MDCK,
+	
+	.phy_addr	= -1,
+#ifdef PHY_INTERRUPT
+	.phy_irq	= PHY_INTERRUPT,
+#endif
+
+	.bus_info	= &mii_bus_info,
+	.rx_ring	= 32,
+	.tx_ring	= 32,
+	.rx_copybreak	= 240,
+	.use_napi	= 0,
+	.napi_weight	= 17,
+};
+
+
+void pq2_setup_pd(void)
+{
+	bd_t* bi = (void*)__res;
+
+	/* first we need to identify platform on the bus */
+	identify_ppc_sys_by_id(cpm2_immr->im_memctl.memc_immr << 16); 
+
+	/* Do some runtime PD setup */
+	memcpy(&mpc82xx_fcc1_pdata.macaddr,bi->bi_enetaddr,6);
+
+	/* Since some boards have 2 or more MAC's passed from the firmware, you may replace 
+	 the stuff below by the real address (bi->enet1addr & so on) but first ensure that 
+	 respective struct contain field you wish to use here */
+	memcpy(&mpc82xx_fcc2_pdata.macaddr,bi->bi_enetaddr,6);
+	mpc82xx_fcc2_pdata.macaddr[5] ^= 1;
+
+	/* At last wi fill the platform_data pointers with respective data */
+	ppc_sys_platform_devices[MPC82xx_FCC1].dev.platform_data = &mpc82xx_fcc1_pdata;
+	ppc_sys_platform_devices[MPC82xx_FCC2].dev.platform_data = &mpc82xx_fcc2_pdata;
+
+}
+
Index: arch/ppc/platforms/82xx/pq2ads_pd.h
===================================================================
--- /dev/null  (tree:eed337ef5e9ae7d62caa84b7974a11fddc7f06e0)
+++ 072e120576417512a61676af3bfc422268ebfdf9/arch/ppc/platforms/82xx/pq2ads_pd.h  (mode:100644 sha1:4debf007859d6043d0647f8f3e6741834b78b689)
@@ -0,0 +1,63 @@
+#ifndef __PQ2ADS_PD_H
+#define __PQ2ADS_PD_H
+/*
+ * arch/ppc/platforms/82xx/pq2ads_pd.h
+ *
+ * Some defines for MPC82xx board-specific PlatformDevice descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+/* FCC1 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK9-12 */
+
+#define F1_RXCLK	11
+#define F1_TXCLK	10
+
+/* FCC2 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK13-16 */
+#define F2_RXCLK	15
+#define F2_TXCLK	16
+
+/* FCC3 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK13-16 */
+#define F3_RXCLK	15
+#define F3_TXCLK	16
+
+/* MDIO and MDCK settings. These can be redefined in the board specific file.*/
+#define PC_MDIO		0x00002000U
+#define PC_MDCK		0x00001000U
+
+/* Automatically generates register configurations */
+#define PC_CLK(x)	((uint)(1<<(x-1)))	/* FCC CLK I/O ports */
+
+#define CMXFCR_RF1CS(x)	((uint)((x-5)<<27))	/* FCC1 Receive Clock Source */
+#define CMXFCR_TF1CS(x)	((uint)((x-5)<<24))	/* FCC1 Transmit Clock Source */
+#define CMXFCR_RF2CS(x)	((uint)((x-9)<<19))	/* FCC2 Receive Clock Source */
+#define CMXFCR_TF2CS(x) ((uint)((x-9)<<16))	/* FCC2 Transmit Clock Source */
+#define CMXFCR_RF3CS(x)	((uint)((x-9)<<11))	/* FCC3 Receive Clock Source */
+#define CMXFCR_TF3CS(x) ((uint)((x-9)<<8))	/* FCC3 Transmit Clock Source */
+
+#define PC_F1RXCLK	PC_CLK(F1_RXCLK)
+#define PC_F1TXCLK	PC_CLK(F1_TXCLK)
+#define CMX1_CLK_ROUTE	(CMXFCR_RF1CS(F1_RXCLK) | CMXFCR_TF1CS(F1_TXCLK))
+#define CMX1_CLK_MASK	((uint)0xff000000)
+
+#define PC_F2RXCLK	PC_CLK(F2_RXCLK)
+#define PC_F2TXCLK	PC_CLK(F2_TXCLK)
+#define CMX2_CLK_ROUTE	(CMXFCR_RF2CS(F2_RXCLK) | CMXFCR_TF2CS(F2_TXCLK))
+#define CMX2_CLK_MASK	((uint)0x00ff0000)
+
+#define PC_F3RXCLK	PC_CLK(F3_RXCLK)
+#define PC_F3TXCLK	PC_CLK(F3_TXCLK)
+#define CMX3_CLK_ROUTE	(CMXFCR_RF3CS(F3_RXCLK) | CMXFCR_TF3CS(F3_TXCLK))
+#define CMX3_CLK_MASK	((uint)0x0000ff00)
+
+#endif
Index: arch/ppc/syslib/Makefile
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/arch/ppc/syslib/Makefile  (mode:100644 sha1:dd418ea3426c70a4ed065986e464967fce8122fb)
+++ 072e120576417512a61676af3bfc422268ebfdf9/arch/ppc/syslib/Makefile  (mode:100644 sha1:ed2da02b7bba6780761857ccb082e4a5b5704fe1)
@@ -80,10 +80,11 @@
 obj-$(CONFIG_SBC82xx)		+= todc_time.o
 obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o indirect_pci.o pci_auto.o \
 				   todc_time.o
-obj-$(CONFIG_8260)		+= m8260_setup.o
 obj-$(CONFIG_PCI_8260)		+= m8260_pci.o indirect_pci.o
 obj-$(CONFIG_8260_PCI9)		+= m8260_pci_erratum9.o
-obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
+obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o \
+				    mpc82xx_devices.o mpc82xx_sys.o ppc_sys.o
+
 ifeq ($(CONFIG_PPC_GEN550),y)
 obj-$(CONFIG_KGDB)		+= gen550_kgdb.o gen550_dbg.o
 obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= gen550_dbg.o
Index: arch/ppc/syslib/m8260_setup.c
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/arch/ppc/syslib/m8260_setup.c  (mode:100644 sha1:23ea3f694de2066ec5b324ebedb38b1c027415ce)
+++ /dev/null  (tree:072e120576417512a61676af3bfc422268ebfdf9)
@@ -1,264 +0,0 @@
-/*
- *  arch/ppc/syslib/m8260_setup.c
- *
- *  Copyright (C) 1995  Linus Torvalds
- *  Adapted from 'alpha' version by Gary Thomas
- *  Modified by Cort Dougan (cort@cs.nmt.edu)
- *  Modified for MBX using prep/chrp/pmac functions by Dan (dmalek@jlc.net)
- *  Further modified for generic 8xx and 8260 by Dan.
- */
-
-#include <linux/config.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/stddef.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/initrd.h>
-#include <linux/root_dev.h>
-#include <linux/seq_file.h>
-#include <linux/irq.h>
-
-#include <asm/mmu.h>
-#include <asm/io.h>
-#include <asm/pgtable.h>
-#include <asm/mpc8260.h>
-#include <asm/immap_cpm2.h>
-#include <asm/machdep.h>
-#include <asm/bootinfo.h>
-#include <asm/time.h>
-
-#include "cpm2_pic.h"
-
-unsigned char __res[sizeof(bd_t)];
-
-extern void cpm2_reset(void);
-extern void m8260_find_bridges(void);
-extern void idma_pci9_init(void);
-
-/* Place-holder for board-specific init */
-void __attribute__ ((weak)) __init
-m82xx_board_setup(void)
-{
-}
-
-static void __init
-m8260_setup_arch(void)
-{
-	/* Print out Vendor and Machine info. */
-	printk(KERN_INFO "%s %s port\n", CPUINFO_VENDOR, CPUINFO_MACHINE);
-
-	/* Reset the Communication Processor Module. */
-	cpm2_reset();
-#ifdef CONFIG_8260_PCI9
-	/* Initialise IDMA for PCI erratum workaround */
-	idma_pci9_init();
-#endif
-#ifdef CONFIG_PCI_8260
-	m8260_find_bridges();
-#endif
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		ROOT_DEV = Root_RAM0;
-#endif
-	m82xx_board_setup();
-}
-
-/* The decrementer counts at the system (internal) clock frequency
- * divided by four.
- */
-static void __init
-m8260_calibrate_decr(void)
-{
-	bd_t *binfo = (bd_t *)__res;
-	int freq, divisor;
-
-	freq = binfo->bi_busfreq;
-        divisor = 4;
-        tb_ticks_per_jiffy = freq / HZ / divisor;
-	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
-}
-
-/* The 8260 has an internal 1-second timer update register that
- * we should use for this purpose.
- */
-static uint rtc_time;
-
-static int
-m8260_set_rtc_time(unsigned long time)
-{
-	rtc_time = time;
-
-	return(0);
-}
-
-static unsigned long
-m8260_get_rtc_time(void)
-{
-	/* Get time from the RTC.
-	*/
-	return((unsigned long)rtc_time);
-}
-
-#ifndef BOOTROM_RESTART_ADDR
-#warning "Using default BOOTROM_RESTART_ADDR!"
-#define BOOTROM_RESTART_ADDR	0xff000104
-#endif
-
-static void
-m8260_restart(char *cmd)
-{
-	extern void m8260_gorom(bd_t *bi, uint addr);
-	uint	startaddr;
-
-	/* Most boot roms have a warmstart as the second instruction
-	 * of the reset vector.  If that doesn't work for you, change this
-	 * or the reboot program to send a proper address.
-	 */
-	startaddr = BOOTROM_RESTART_ADDR;
-	if (cmd != NULL) {
-		if (!strncmp(cmd, "startaddr=", 10))
-			startaddr = simple_strtoul(&cmd[10], NULL, 0);
-	}
-
-	m8260_gorom((void*)__pa(__res), startaddr);
-}
-
-static void
-m8260_halt(void)
-{
-	local_irq_disable();
-	while (1);
-}
-
-static void
-m8260_power_off(void)
-{
-	m8260_halt();
-}
-
-static int
-m8260_show_cpuinfo(struct seq_file *m)
-{
-	bd_t *bp = (bd_t *)__res;
-
-	seq_printf(m, "vendor\t\t: %s\n"
-		   "machine\t\t: %s\n"
-		   "\n"
-		   "mem size\t\t: 0x%08x\n"
-		   "console baud\t\t: %d\n"
-		   "\n"
-		   "core clock\t: %u MHz\n"
-		   "CPM  clock\t: %u MHz\n"
-		   "bus  clock\t: %u MHz\n",
-		   CPUINFO_VENDOR, CPUINFO_MACHINE, bp->bi_memsize,
-		   bp->bi_baudrate, bp->bi_intfreq / 1000000,
-		   bp->bi_cpmfreq / 1000000, bp->bi_busfreq / 1000000);
-	return 0;
-}
-
-/* Initialize the internal interrupt controller.  The number of
- * interrupts supported can vary with the processor type, and the
- * 8260 family can have up to 64.
- * External interrupts can be either edge or level triggered, and
- * need to be initialized by the appropriate driver.
- */
-static void __init
-m8260_init_IRQ(void)
-{
-	cpm2_init_IRQ();
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	cpm2_immr->im_intctl.ic_siprr = 0x05309770;
-}
-
-/*
- * Same hack as 8xx
- */
-static unsigned long __init
-m8260_find_end_of_memory(void)
-{
-	bd_t *binfo = (bd_t *)__res;
-
-	return binfo->bi_memsize;
-}
-
-/* Map the IMMR, plus anything else we can cover
- * in that upper space according to the memory controller
- * chip select mapping.  Grab another bunch of space
- * below that for stuff we can't cover in the upper.
- */
-static void __init
-m8260_map_io(void)
-{
-	uint addr;
-
-	/* Map IMMR region to a 256MB BAT */
-	addr = (cpm2_immr != NULL) ? (uint)cpm2_immr : CPM_MAP_ADDR;
-	io_block_mapping(addr, addr, 0x10000000, _PAGE_IO);
-
-	/* Map I/O region to a 256MB BAT */
-	io_block_mapping(IO_VIRT_ADDR, IO_PHYS_ADDR, 0x10000000, _PAGE_IO);
-}
-
-/* Place-holder for board-specific ppc_md hooking */
-void __attribute__ ((weak)) __init
-m82xx_board_init(void)
-{
-}
-
-/* Inputs:
- *   r3 - Optional pointer to a board information structure.
- *   r4 - Optional pointer to the physical starting address of the init RAM
- *        disk.
- *   r5 - Optional pointer to the physical ending address of the init RAM
- *        disk.
- *   r6 - Optional pointer to the physical starting address of any kernel
- *        command-line parameters.
- *   r7 - Optional pointer to the physical ending address of any kernel
- *        command-line parameters.
- */
-void __init
-platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
-	      unsigned long r6, unsigned long r7)
-{
-	parse_bootinfo(find_bootinfo());
-
-	if ( r3 )
-		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	/* take care of initrd if we have one */
-	if ( r4 ) {
-		initrd_start = r4 + KERNELBASE;
-		initrd_end = r5 + KERNELBASE;
-	}
-#endif /* CONFIG_BLK_DEV_INITRD */
-	/* take care of cmd line */
-	if ( r6 ) {
-		*(char *)(r7+KERNELBASE) = 0;
-		strcpy(cmd_line, (char *)(r6+KERNELBASE));
-	}
-
-	ppc_md.setup_arch		= m8260_setup_arch;
-	ppc_md.show_cpuinfo		= m8260_show_cpuinfo;
-	ppc_md.init_IRQ			= m8260_init_IRQ;
-	ppc_md.get_irq			= cpm2_get_irq;
-
-	ppc_md.restart			= m8260_restart;
-	ppc_md.power_off		= m8260_power_off;
-	ppc_md.halt			= m8260_halt;
-
-	ppc_md.set_rtc_time		= m8260_set_rtc_time;
-	ppc_md.get_rtc_time		= m8260_get_rtc_time;
-	ppc_md.calibrate_decr		= m8260_calibrate_decr;
-
-	ppc_md.find_end_of_memory	= m8260_find_end_of_memory;
-	ppc_md.setup_io_mappings	= m8260_map_io;
-
-	/* Call back for board-specific settings and overrides. */
-	m82xx_board_init();
-}
Index: arch/ppc/syslib/mpc82xx_devices.c
===================================================================
--- /dev/null  (tree:eed337ef5e9ae7d62caa84b7974a11fddc7f06e0)
+++ 072e120576417512a61676af3bfc422268ebfdf9/arch/ppc/syslib/mpc82xx_devices.c  (mode:100644 sha1:42501a5f121d8524576162eb03f3bc945bf19636)
@@ -0,0 +1,121 @@
+/*
+ * arch/ppc/syslib/mpc82xx_devices.c
+ *
+ * MPC82xx Device descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include <linux/fs_enet_pd.h>
+#include <asm/mpc8260.h>
+#include <asm/cpm2.h>
+#include <asm/immap_cpm2.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+#include <asm/ppcboot.h>
+
+
+struct platform_device ppc_sys_platform_devices[] = {
+	[MPC82xx_FCC1] = {
+		.name = FS_ENET_NAME,
+		.id	= 1,
+		.num_resources	 = 5,
+		.resource = (struct resource[]) {
+			{
+				.name	= "fcc_regs",
+				.start	= 0x11300,
+				.end	= 0x1131f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_regs_c",
+				.start	= 0x11380,
+				.end	= 0x1139f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_pram",
+				.start	= 0x8400,
+				.end	= 0x84ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_mem",
+				.start	= 0x9000,
+				.end	= 0x907f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_FCC1,
+				.end	= SIU_INT_FCC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_FCC2] = {
+		.name = FS_ENET_NAME,
+		.id	= 2,
+		.num_resources	 = 5,
+		.resource = (struct resource[]) {
+			{
+				.name	= "fcc_regs",
+				.start	= 0x11320,
+				.end	= 0x1133f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_regs_c",
+				.start	= 0x113a0,
+				.end	= 0x113bf,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_pram",
+				.start	= 0x8500,
+				.end	= 0x85ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_mem",
+				.start	= 0x9080,
+				.end	= 0x90ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_FCC2,
+				.end	= SIU_INT_FCC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	}
+};
+
+static int __init mach_mpc82xx_fixup(struct platform_device *pdev)
+{
+	ppc_sys_fixup_mem_resource(pdev, CPM_MAP_ADDR);
+	return 0;
+}
+
+static int __init mach_mpc82xx_init(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("mach_mpc82xx_init:enter", 0);
+	ppc_sys_device_fixup = mach_mpc82xx_fixup;
+	return 0;
+}
+
+postcore_initcall(mach_mpc82xx_init);
Index: arch/ppc/syslib/mpc82xx_sys.c
===================================================================
--- /dev/null  (tree:eed337ef5e9ae7d62caa84b7974a11fddc7f06e0)
+++ 072e120576417512a61676af3bfc422268ebfdf9/arch/ppc/syslib/mpc82xx_sys.c  (mode:100644 sha1:b793dd75df5055157e804e892223920c03641a73)
@@ -0,0 +1,42 @@
+/*
+ * arch/ppc/syslib/mpc82xx_devices.c
+ *
+ * MPC82xx System descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+
+#include <asm/ppc_sys.h>
+
+
+struct ppc_sys_spec *cur_ppc_sys_spec;
+struct ppc_sys_spec ppc_sys_specs[] = {
+
+	{	
+		.ppc_sys_name	= "MPC8272ads",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x0c100000,
+		.num_devices 	= 2,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_FCC1,
+			MPC82xx_FCC2,
+		},
+	},
+	{	/* default match */
+		.ppc_sys_name	= "",
+		.mask 		= 0x00000000,
+		.value 		= 0x00000000,
+	},
+};
Index: include/asm-ppc/mpc8260.h
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/include/asm-ppc/mpc8260.h  (mode:100644 sha1:d820894e59916a4c491b8bdd0312830acec228a9)
+++ 072e120576417512a61676af3bfc422268ebfdf9/include/asm-ppc/mpc8260.h  (mode:100644 sha1:a9c046b16be566e215143fb044e17a233a1c4194)
@@ -74,6 +74,11 @@
 extern unsigned char __res[];
 #endif
 
+enum ppc_sys_devices {
+	MPC82xx_FCC1,
+	MPC82xx_FCC2,
+};
+
 #endif /* CONFIG_8260 */
 #endif /* !__ASM_PPC_MPC8260_H__ */
 #endif /* __KERNEL__ */
Index: include/asm-ppc/ppc_sys.h
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/include/asm-ppc/ppc_sys.h  (mode:100644 sha1:24b991c427694d425225c2cacde01b5bc469ed0a)
+++ 072e120576417512a61676af3bfc422268ebfdf9/include/asm-ppc/ppc_sys.h  (mode:100644 sha1:2a7636166c83f1187631cbfe5aa1003c691d2d2b)
@@ -27,6 +27,8 @@
 #include <asm/mpc85xx.h>
 #elif defined(CONFIG_PPC_MPC52xx)
 #include <asm/mpc52xx.h>
+#elif defined(CONFIG_8260)
+#include <asm/mpc8260.h>
 #else
 #error "need definition of ppc_sys_devices"
 #endif
Index: include/linux/fs_enet_pd.h
===================================================================
--- /dev/null  (tree:eed337ef5e9ae7d62caa84b7974a11fddc7f06e0)
+++ 072e120576417512a61676af3bfc422268ebfdf9/include/linux/fs_enet_pd.h  (mode:100644 sha1:314b72e4dab21c36f431c2c2950fee8586dcce8e)
@@ -0,0 +1,107 @@
+#ifndef FS_ENET_PD_H
+#define FS_ENET_PD_H
+
+#include <asm/types.h>
+
+#define FS_ENET_NAME	"fs_enet"
+
+enum fs_id {
+	fsid_fec1,
+	fsid_fec2,
+	fsid_fcc1,
+	fsid_fcc2,
+	fsid_fcc3,
+	fsid_scc1,
+	fsid_scc2,
+	fsid_scc3,
+	fsid_scc4,
+};
+
+#define FS_MAX_INDEX	9
+
+static inline int fs_get_fec_index(enum fs_id id)
+{
+	if (id >= fsid_fec1 && id <= fsid_fec2)
+		return id - fsid_fec1;
+	return -1;
+}
+
+static inline int fs_get_fcc_index(enum fs_id id)
+{
+	if (id >= fsid_fcc1 && id <= fsid_fcc3)
+		return id - fsid_fcc1;
+	return -1;
+}
+
+static inline int fs_get_scc_index(enum fs_id id)
+{
+	if (id >= fsid_scc1 && id <= fsid_scc4)
+		return id - fsid_scc1;
+	return -1;
+}
+
+enum fs_mii_method {
+	fsmii_fixed,
+	fsmii_fec,
+	fsmii_bitbang,
+};
+
+enum fs_ioport {
+	fsiop_porta,
+	fsiop_portb,
+	fsiop_portc,
+	fsiop_portd,
+	fsiop_porte,
+};
+
+struct fs_mii_bus_info {
+	int method;		/* mii method                  */
+	int id;			/* the id of the mii_bus       */
+	union {
+		struct {
+			int duplex;
+			int speed;
+		} fixed;
+
+		struct {
+			/* nothing */
+		} fec;
+
+		struct {
+			int mdio_port;	/* port & bit for MDIO */
+			int mdio_bit;
+			int mdc_port;	/* port & bit for MDC  */
+			int mdc_bit;
+			int delay;	/* delay in us         */
+		} bitbang;
+	} i;
+};
+
+struct fs_platform_info {
+	/* device specific information */
+	int fs_no;		/* controller index            */
+
+	u32 cp_page;		/* CPM page */
+	u32 cp_block;		/* CPM sblock */
+	
+	u32 clk_trx;		/* some stuff for pins & mux configuration*/
+	u32 clk_route;
+	u32 clk_mask;
+	
+	u32 device_flags;
+
+	int phy_addr;		/* the phy address (-1 no phy) */
+	int phy_irq;		/* the phy irq (if it exists)  */
+
+	const struct fs_mii_bus_info *bus_info;
+
+	int rx_ring, tx_ring;	/* number of buffers on rx     */
+	__u8 macaddr[6];	/* mac address                 */
+	int rx_copybreak;	/* limit we copy small frames  */
+	int use_napi;		/* use NAPI                    */
+	int napi_weight;	/* NAPI weight                 */
+	
+	int use_rmii; 		/* use RMII */
+};
+
+#endif



!-------------------------------------------------------------flip-



--------------030003070506090707000309--

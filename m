Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 40E2E679EB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 22:24:53 +1000 (EST)
Message-ID: <428C8593.6020901@ru.mvista.com>
Date: Thu, 19 May 2005 16:24:51 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------090305080005090601080609"
Cc: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
	Kumar Gala <galak@freescale.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Support for 82xx PQII on-chip PCI bridge 
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
--------------090305080005090601080609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds on-chip PCI bridge support for the PQ2 family. The 
incomplete existent code is updated with interrupt handling stuff and 
board-specific bits for 8272ADS and PQ2FADS; the related files were 
renamed (from m8260_pci to m82xx_pci) to be of more generic fashion.
This is tested with 8266ADS and 8272ADS, should work on PQ2FADS as well.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>


--------------090305080005090601080609
Content-Type: text/x-patch;
 name="current.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="current.patch"

support for PCI bridge on Freescale 8272ADS

---
commit fd47b8335113abcfb34553a83e641cd5ee5e8637
tree 874039bc658fe59955b149328a70521a56744a27
parent 88d7bd8cb9eb8d64bf7997600b0d64f7834047c5
author Vitaly Bordug <vvv@localhost.localdomain> 1116425444 +0400
committer Vitaly Bordug <vvv@localhost.localdomain> 1116425444 +0400

Index: arch/ppc/Kconfig
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/arch/ppc/Kconfig  (mode:100644 sha1:600f23d7fd33aae9e5115875ada43a289e075b5d)
+++ 874039bc658fe59955b149328a70521a56744a27/arch/ppc/Kconfig  (mode:100644 sha1:6e6377a69d5bc58c16de9f12013b377b3af7d17e)
@@ -1143,12 +1143,12 @@
 
 config PCI_8260
 	bool
-	depends on PCI && 8260 && !8272
+	depends on PCI && 8260
 	default y
 
 config 8260_PCI9
 	bool "  Enable workaround for MPC826x erratum PCI 9"
-	depends on PCI_8260
+	depends on PCI_8260 && !ADS8272
 	default y
 
 choice
Index: arch/ppc/platforms/pq2ads.h
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/arch/ppc/platforms/pq2ads.h  (mode:100644 sha1:cf5e5dd06d6300d7733b20f4e5b21c31a1bdda48)
+++ 874039bc658fe59955b149328a70521a56744a27/arch/ppc/platforms/pq2ads.h  (mode:100644 sha1:067d9a5aebc108f7301913e74d3d218161c23ea7)
@@ -49,10 +49,10 @@
 /* PCI interrupt controller */
 #define PCI_INT_STAT_REG	0xF8200000
 #define PCI_INT_MASK_REG	0xF8200004
-#define PIRQA			(NR_SIU_INTS + 0)
-#define PIRQB			(NR_SIU_INTS + 1)
-#define PIRQC			(NR_SIU_INTS + 2)
-#define PIRQD			(NR_SIU_INTS + 3)
+#define PIRQA			(NR_CPM_INTS + 0)
+#define PIRQB			(NR_CPM_INTS + 1)
+#define PIRQC			(NR_CPM_INTS + 2)
+#define PIRQD			(NR_CPM_INTS + 3)
 
 /*
  * PCI memory map definitions for MPC8266ADS-PCI.
@@ -68,28 +68,23 @@
  *	0x00000000-0x1FFFFFFF	0x00000000-0x1FFFFFFF	MPC8266 local memory
  */
 
-/* window for a PCI master to access MPC8266 memory */
-#define PCI_SLV_MEM_LOCAL	0x00000000	/* Local base */
-#define PCI_SLV_MEM_BUS		0x00000000	/* PCI base */
-
-/* window for the processor to access PCI memory with prefetching */
-#define PCI_MSTR_MEM_LOCAL	0x80000000	/* Local base */
-#define PCI_MSTR_MEM_BUS	0x80000000	/* PCI base   */
-#define PCI_MSTR_MEM_SIZE	0x20000000	/* 512MB */
-
-/* window for the processor to access PCI memory without prefetching */
-#define PCI_MSTR_MEMIO_LOCAL	0xA0000000	/* Local base */
-#define PCI_MSTR_MEMIO_BUS	0xA0000000	/* PCI base   */
-#define PCI_MSTR_MEMIO_SIZE	0x20000000	/* 512MB */
-
-/* window for the processor to access PCI I/O */
-#define PCI_MSTR_IO_LOCAL	0xF4000000	/* Local base */
-#define PCI_MSTR_IO_BUS         0x00000000	/* PCI base   */
-#define PCI_MSTR_IO_SIZE        0x04000000	/* 64MB */
-
-#define _IO_BASE		PCI_MSTR_IO_LOCAL
-#define _ISA_MEM_BASE		PCI_MSTR_MEMIO_LOCAL
-#define PCI_DRAM_OFFSET		PCI_SLV_MEM_BUS
+/* All the other PCI memory map definitions reside at syslib/m82xx_pci.h
+   Here we should redefine what is unique for this board */
+#define M82xx_PCI_SLAVE_MEM_LOCAL	0x00000000	/* Local base */
+#define M82xx_PCI_SLAVE_MEM_BUS		0x00000000	/* PCI base */
+#define M82xx_PCI_SLAVE_MEM_SIZE	0x10000000	/* 256 Mb */
+
+#define M82xx_PCI_SLAVE_SEC_WND_SIZE	~(0x40000000 - 1U)	/* 2 x 512Mb  */
+#define M82xx_PCI_SLAVE_SEC_WND_BASE	0x80000000		/* PCI Memory base */
+
+#if defined(CONFIG_ADS8272)
+#define PCI_INT_TO_SIU 	SIU_INT_IRQ2
+#elif defined(CONFIG_PQ2FADS)
+#define PCI_INT_TO_SIU 	SIU_INT_IRQ6
+#else
+#warning PCI Bridge will be without interrupts support
+#endif
+
 #endif /* CONFIG_PCI */
 
 #endif /* __MACH_ADS8260_DEFS */
Index: arch/ppc/syslib/Makefile
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/arch/ppc/syslib/Makefile  (mode:100644 sha1:dd418ea3426c70a4ed065986e464967fce8122fb)
+++ 874039bc658fe59955b149328a70521a56744a27/arch/ppc/syslib/Makefile  (mode:100644 sha1:14c90119c2802283d6e96f71d990365170e89eb7)
@@ -81,7 +81,7 @@
 obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o indirect_pci.o pci_auto.o \
 				   todc_time.o
 obj-$(CONFIG_8260)		+= m8260_setup.o
-obj-$(CONFIG_PCI_8260)		+= m8260_pci.o indirect_pci.o
+obj-$(CONFIG_PCI_8260)		+= m82xx_pci.o indirect_pci.o pci_auto.o
 obj-$(CONFIG_8260_PCI9)		+= m8260_pci_erratum9.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
 ifeq ($(CONFIG_PPC_GEN550),y)
Index: arch/ppc/syslib/m8260_pci.c
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/arch/ppc/syslib/m8260_pci.c  (mode:100644 sha1:057cc3f8ff378c0de881482d55b47255e3c5ea72)
+++ /dev/null  (tree:874039bc658fe59955b149328a70521a56744a27)
@@ -1,193 +0,0 @@
-/*
- * (C) Copyright 2003
- * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
- *
- * (C) Copyright 2004 Red Hat, Inc.
- *
- * See file CREDITS for list of people who contributed to this
- * project.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-
-#include <asm/byteorder.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/uaccess.h>
-#include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <asm/immap_cpm2.h>
-#include <asm/mpc8260.h>
-
-#include "m8260_pci.h"
-
-
-/* PCI bus configuration registers.
- */
-
-static void __init m8260_setup_pci(struct pci_controller *hose)
-{
-	volatile cpm2_map_t *immap = cpm2_immr;
-	unsigned long pocmr;
-	u16 tempShort;
-
-#ifndef CONFIG_ATC 	/* already done in U-Boot */
-	/* 
-	 * Setting required to enable IRQ1-IRQ7 (SIUMCR [DPPC]), 
-	 * and local bus for PCI (SIUMCR [LBPC]).
-	 */
-	immap->im_siu_conf.siu_82xx.sc_siumcr = 0x00640000;
-#endif
-
-	/* Make PCI lowest priority */
-	/* Each 4 bits is a device bus request  and the MS 4bits 
-	   is highest priority */
-	/* Bus               4bit value 
-	   ---               ----------
-	   CPM high          0b0000
-	   CPM middle        0b0001
-	   CPM low           0b0010
-	   PCI reguest       0b0011
-	   Reserved          0b0100
-	   Reserved          0b0101
-	   Internal Core     0b0110
-	   External Master 1 0b0111
-	   External Master 2 0b1000
-	   External Master 3 0b1001
-	   The rest are reserved */
-	immap->im_siu_conf.siu_82xx.sc_ppc_alrh = 0x61207893;
-
-	/* Park bus on core while modifying PCI Bus accesses */
-	immap->im_siu_conf.siu_82xx.sc_ppc_acr = 0x6;
-
-	/* 
-	 * Set up master window that allows the CPU to access PCI space. This 
-	 * window is set up using the first SIU PCIBR registers.
-	 */
-	immap->im_memctl.memc_pcimsk0 = MPC826x_PCI_MASK;
-	immap->im_memctl.memc_pcibr0 =	MPC826x_PCI_BASE | PCIBR_ENABLE;
-
-	/* Disable machine check on no response or target abort */
-	immap->im_pci.pci_emr = cpu_to_le32(0x1fe7);
-	/* Release PCI RST (by default the PCI RST signal is held low)  */
-	immap->im_pci.pci_gcr = cpu_to_le32(PCIGCR_PCI_BUS_EN);
-
-	/* give it some time */
-	mdelay(1);
-
-	/* 
-	 * Set up master window that allows the CPU to access PCI Memory (prefetch) 
-	 * space. This window is set up using the first set of Outbound ATU registers.
-	 */
-	immap->im_pci.pci_potar0 = cpu_to_le32(MPC826x_PCI_LOWER_MEM >> 12);
-	immap->im_pci.pci_pobar0 = cpu_to_le32((MPC826x_PCI_LOWER_MEM - MPC826x_PCI_MEM_OFFSET) >> 12);
-	pocmr = ((MPC826x_PCI_UPPER_MEM - MPC826x_PCI_LOWER_MEM) >> 12) ^ 0xfffff;
-	immap->im_pci.pci_pocmr0 = cpu_to_le32(pocmr | POCMR_ENABLE | POCMR_PREFETCH_EN);
-
-	/* 
-	 * Set up master window that allows the CPU to access PCI Memory (non-prefetch) 
-	 * space. This window is set up using the second set of Outbound ATU registers.
-	 */
-	immap->im_pci.pci_potar1 = cpu_to_le32(MPC826x_PCI_LOWER_MMIO >> 12);
-	immap->im_pci.pci_pobar1 = cpu_to_le32((MPC826x_PCI_LOWER_MMIO - MPC826x_PCI_MMIO_OFFSET) >> 12);
-	pocmr = ((MPC826x_PCI_UPPER_MMIO - MPC826x_PCI_LOWER_MMIO) >> 12) ^ 0xfffff;
-	immap->im_pci.pci_pocmr1 = cpu_to_le32(pocmr | POCMR_ENABLE);
-
-	/* 
-	 * Set up master window that allows the CPU to access PCI IO space. This window
-	 * is set up using the third set of Outbound ATU registers.
-	 */
-	immap->im_pci.pci_potar2 = cpu_to_le32(MPC826x_PCI_IO_BASE >> 12);
-	immap->im_pci.pci_pobar2 = cpu_to_le32(MPC826x_PCI_LOWER_IO >> 12);
-	pocmr = ((MPC826x_PCI_UPPER_IO - MPC826x_PCI_LOWER_IO) >> 12) ^ 0xfffff;
-	immap->im_pci.pci_pocmr2 = cpu_to_le32(pocmr | POCMR_ENABLE | POCMR_PCI_IO);
-
-	/* 
-	 * Set up slave window that allows PCI masters to access MPC826x local memory. 
-	 * This window is set up using the first set of Inbound ATU registers
-	 */
-
-	immap->im_pci.pci_pitar0 = cpu_to_le32(MPC826x_PCI_SLAVE_MEM_LOCAL >> 12);
-	immap->im_pci.pci_pibar0 = cpu_to_le32(MPC826x_PCI_SLAVE_MEM_BUS >> 12);
-	pocmr = ((MPC826x_PCI_SLAVE_MEM_SIZE-1) >> 12) ^ 0xfffff;
-	immap->im_pci.pci_picmr0 = cpu_to_le32(pocmr | PICMR_ENABLE | PICMR_PREFETCH_EN);
-
-	/* See above for description - puts PCI request as highest priority */
-	immap->im_siu_conf.siu_82xx.sc_ppc_alrh = 0x03124567;
-
-	/* Park the bus on the PCI */
-	immap->im_siu_conf.siu_82xx.sc_ppc_acr = PPC_ACR_BUS_PARK_PCI;
-
-	/* Host mode - specify the bridge as a host-PCI bridge */
-	early_write_config_word(hose, 0, 0, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_HOST);
-
-	/* Enable the host bridge to be a master on the PCI bus, and to act as a PCI memory target */
-	early_read_config_word(hose, 0, 0, PCI_COMMAND, &tempShort);
-	early_write_config_word(hose, 0, 0, PCI_COMMAND,
-				tempShort | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
-}
-
-void __init m8260_find_bridges(void)
-{
-	extern int pci_assign_all_busses;
-	struct pci_controller * hose;
-
-	pci_assign_all_busses = 1;
-
-	hose = pcibios_alloc_controller();
-
-	if (!hose)
-		return;
-
-	ppc_md.pci_swizzle = common_swizzle;
-
-	hose->first_busno = 0;
-	hose->bus_offset = 0;
-	hose->last_busno = 0xff;
-
-	setup_m8260_indirect_pci(hose, 
-				 (unsigned long)&cpm2_immr->im_pci.pci_cfg_addr,
-				 (unsigned long)&cpm2_immr->im_pci.pci_cfg_data);
-
-	m8260_setup_pci(hose);
-        hose->pci_mem_offset = MPC826x_PCI_MEM_OFFSET;
-
-        hose->io_base_virt = ioremap(MPC826x_PCI_IO_BASE,
-                                        MPC826x_PCI_IO_SIZE);
-        isa_io_base = (unsigned long) hose->io_base_virt;
- 
-        /* setup resources */
-        pci_init_resource(&hose->mem_resources[0],
-			  MPC826x_PCI_LOWER_MEM,
-			  MPC826x_PCI_UPPER_MEM,
-			  IORESOURCE_MEM|IORESOURCE_PREFETCH, "PCI prefetchable memory");
-
-        pci_init_resource(&hose->mem_resources[1],
-			  MPC826x_PCI_LOWER_MMIO,
-			  MPC826x_PCI_UPPER_MMIO,
-			  IORESOURCE_MEM, "PCI memory");
-
-        pci_init_resource(&hose->io_resource,
-			  MPC826x_PCI_LOWER_IO,
-			  MPC826x_PCI_UPPER_IO,
-			  IORESOURCE_IO, "PCI I/O");
-}
Index: arch/ppc/syslib/m8260_pci.h
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/arch/ppc/syslib/m8260_pci.h  (mode:100644 sha1:d1352120acd7ef7853041098bf12ae79a8ac1e0a)
+++ /dev/null  (tree:874039bc658fe59955b149328a70521a56744a27)
@@ -1,76 +0,0 @@
-
-#ifndef _PPC_KERNEL_M8260_PCI_H
-#define _PPC_KERNEL_M8260_PCI_H
-
-#include <asm/m8260_pci.h>
-
-/*
- *   Local->PCI map (from CPU)                             controlled by
- *   MPC826x master window
- *
- *   0x80000000 - 0xBFFFFFFF    Total CPU2PCI space        PCIBR0
- *                       
- *   0x80000000 - 0x9FFFFFFF    PCI Mem with prefetch      (Outbound ATU #1)
- *   0xA0000000 - 0xAFFFFFFF    PCI Mem w/o  prefetch      (Outbound ATU #2)
- *   0xB0000000 - 0xB0FFFFFF    32-bit PCI IO              (Outbound ATU #3)
- *                      
- *   PCI->Local map (from PCI)
- *   MPC826x slave window                                  controlled by
- *
- *   0x00000000 - 0x07FFFFFF    MPC826x local memory       (Inbound ATU #1)
- */
-
-/* 
- * Slave window that allows PCI masters to access MPC826x local memory. 
- * This window is set up using the first set of Inbound ATU registers
- */
-
-#ifndef MPC826x_PCI_SLAVE_MEM_LOCAL
-#define MPC826x_PCI_SLAVE_MEM_LOCAL	(((struct bd_info *)__res)->bi_memstart)
-#define MPC826x_PCI_SLAVE_MEM_BUS	(((struct bd_info *)__res)->bi_memstart)
-#define MPC826x_PCI_SLAVE_MEM_SIZE	(((struct bd_info *)__res)->bi_memsize)
-#endif
-
-/* 
- * This is the window that allows the CPU to access PCI address space.
- * It will be setup with the SIU PCIBR0 register. All three PCI master
- * windows, which allow the CPU to access PCI prefetch, non prefetch,
- * and IO space (see below), must all fit within this window. 
- */
-#ifndef MPC826x_PCI_BASE
-#define MPC826x_PCI_BASE	0x80000000
-#define MPC826x_PCI_MASK	0xc0000000
-#endif
-
-#ifndef MPC826x_PCI_LOWER_MEM
-#define MPC826x_PCI_LOWER_MEM  0x80000000
-#define MPC826x_PCI_UPPER_MEM  0x9fffffff
-#define MPC826x_PCI_MEM_OFFSET 0x00000000
-#endif
-
-#ifndef MPC826x_PCI_LOWER_MMIO
-#define MPC826x_PCI_LOWER_MMIO  0xa0000000
-#define MPC826x_PCI_UPPER_MMIO  0xafffffff
-#define MPC826x_PCI_MMIO_OFFSET 0x00000000
-#endif
-
-#ifndef MPC826x_PCI_LOWER_IO
-#define MPC826x_PCI_LOWER_IO   0x00000000
-#define MPC826x_PCI_UPPER_IO   0x00ffffff
-#define MPC826x_PCI_IO_BASE    0xb0000000
-#define MPC826x_PCI_IO_SIZE    0x01000000
-#endif
-
-#ifndef _IO_BASE
-#define _IO_BASE isa_io_base
-#endif
-
-#ifdef CONFIG_8260_PCI9
-struct pci_controller;
-extern void setup_m8260_indirect_pci(struct pci_controller* hose,
-				     u32 cfg_addr, u32 cfg_data);
-#else
-#define setup_m8260_indirect_pci setup_indirect_pci
-#endif
-
-#endif /* _PPC_KERNEL_M8260_PCI_H */
Index: arch/ppc/syslib/m8260_pci_erratum9.c
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/arch/ppc/syslib/m8260_pci_erratum9.c  (mode:100644 sha1:9c0582d639e051ccba4d213044045bf99211550c)
+++ 874039bc658fe59955b149328a70521a56744a27/arch/ppc/syslib/m8260_pci_erratum9.c  (mode:100644 sha1:1dc7e4e1d4914ed5d11f583b944de475092436d7)
@@ -31,7 +31,7 @@
 #include <asm/immap_cpm2.h>
 #include <asm/cpm2.h>
 
-#include "m8260_pci.h"
+#include "m82xx_pci.h"
 
 #ifdef CONFIG_8260_PCI9
 /*#include <asm/mpc8260_pci9.h>*/ /* included in asm/io.h */
@@ -248,11 +248,11 @@
 
 static inline int is_pci_mem(unsigned long addr)
 {
-	if (addr >= MPC826x_PCI_LOWER_MMIO &&
-	    addr <= MPC826x_PCI_UPPER_MMIO)
+	if (addr >= M82xx_PCI_LOWER_MMIO &&
+		addr <= M82xx_PCI_UPPER_MMIO)
 		return 1;
-	if (addr >= MPC826x_PCI_LOWER_MEM &&
-	    addr <= MPC826x_PCI_UPPER_MEM)
+	if (addr >= M82xx_PCI_LOWER_MEM &&
+		addr <= M82xx_PCI_UPPER_MEM)
 		return 1;
 	return 0;
 }
Index: arch/ppc/syslib/m8260_setup.c
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/arch/ppc/syslib/m8260_setup.c  (mode:100644 sha1:23ea3f694de2066ec5b324ebedb38b1c027415ce)
+++ 874039bc658fe59955b149328a70521a56744a27/arch/ppc/syslib/m8260_setup.c  (mode:100644 sha1:fda75d79050c3e9201ce7033193645bd74609aec)
@@ -34,7 +34,8 @@
 unsigned char __res[sizeof(bd_t)];
 
 extern void cpm2_reset(void);
-extern void m8260_find_bridges(void);
+extern void pq2_find_bridges(void);
+extern void pq2pci_init_irq(void);
 extern void idma_pci9_init(void);
 
 /* Place-holder for board-specific init */
@@ -56,7 +57,7 @@
 	idma_pci9_init();
 #endif
 #ifdef CONFIG_PCI_8260
-	m8260_find_bridges();
+	pq2_find_bridges();
 #endif
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
@@ -173,6 +174,12 @@
 	 * in case the boot rom changed something on us.
 	 */
 	cpm2_immr->im_intctl.ic_siprr = 0x05309770;
+
+#if defined(CONFIG_PCI) && (defined(CONFIG_ADS8272) || defined(CONFIG_PQ2FADS))
+ 	/* Initialize stuff for the 82xx CPLD IC and install demux  */
+ 	pq2pci_init_irq();
+#endif
+
 }
 
 /*
Index: arch/ppc/syslib/m82xx_pci.c
===================================================================
--- /dev/null  (tree:eed337ef5e9ae7d62caa84b7974a11fddc7f06e0)
+++ 874039bc658fe59955b149328a70521a56744a27/arch/ppc/syslib/m82xx_pci.c  (mode:100644 sha1:0e56792a88b73ee42b3496caeaaf94015baaa752)
@@ -0,0 +1,383 @@
+/*
+ *
+ * (C) Copyright 2003
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ *
+ * (C) Copyright 2004 Red Hat, Inc.
+ *
+ * 2005 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#include <asm/byteorder.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/immap_cpm2.h>
+#include <asm/mpc8260.h>
+#include <asm/cpm2.h>
+
+#include "m82xx_pci.h"
+
+/*
+ * Interrupt routing
+ */
+
+static inline int
+pq2pci_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	/*
+	 *	PCI IDSEL/INTPIN->INTLINE
+	 * 	  A      B      C      D
+	 */
+	{
+		{ PIRQA, PIRQB, PIRQC, PIRQD },	/* IDSEL 22 - PCI slot 0 */
+		{ PIRQD, PIRQA, PIRQB, PIRQC },	/* IDSEL 23 - PCI slot 1 */
+		{ PIRQC, PIRQD, PIRQA, PIRQB },	/* IDSEL 24 - PCI slot 2 */
+	};
+
+	const long min_idsel = 22, max_idsel = 24, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+
+static void
+pq2pci_mask_irq(unsigned int irq)
+{
+	int bit = irq - NR_CPM_INTS;
+
+	*(volatile unsigned long *) PCI_INT_MASK_REG |= (1 << (31 - bit));
+	return;
+}
+
+static void
+pq2pci_unmask_irq(unsigned int irq)
+{
+	int bit = irq - NR_CPM_INTS;
+
+	*(volatile unsigned long *) PCI_INT_MASK_REG &= ~(1 << (31 - bit));
+	return;
+}
+
+static void
+pq2pci_mask_and_ack(unsigned int irq)
+{
+	int bit = irq - NR_CPM_INTS;
+
+	*(volatile unsigned long *) PCI_INT_MASK_REG |= (1 << (31 - bit));
+	return;
+}
+
+static void
+pq2pci_end_irq(unsigned int irq)
+{
+	int bit = irq - NR_CPM_INTS;
+
+	*(volatile unsigned long *) PCI_INT_MASK_REG &= ~(1 << (31 - bit));
+	return;
+}
+
+struct hw_interrupt_type pq2pci_ic = {
+	"PQ2 PCI",
+	NULL,
+	NULL,
+	pq2pci_unmask_irq,
+	pq2pci_mask_irq,
+	pq2pci_mask_and_ack,
+	pq2pci_end_irq,
+	0
+};
+
+static irqreturn_t
+pq2pci_irq_demux(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long stat, mask, pend;
+	int bit;
+
+	for(;;) {
+		stat = *(volatile unsigned long *) PCI_INT_STAT_REG;
+		mask = *(volatile unsigned long *) PCI_INT_MASK_REG;
+		pend = stat & ~mask & 0xf0000000;
+		if (!pend)
+			break;
+		for (bit = 0; pend != 0; ++bit, pend <<= 1) {
+			if (pend & 0x80000000)
+				__do_IRQ(NR_CPM_INTS + bit, regs);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction pq2pci_irqaction = {
+	.handler = pq2pci_irq_demux,
+	.flags 	 = SA_INTERRUPT,
+	.mask	 = CPU_MASK_NONE,
+	.name	 = "PQ2 PCI cascade",
+};
+
+
+void
+pq2pci_init_irq(void)
+{
+	int irq;
+	volatile cpm2_map_t *immap = cpm2_immr;
+#if defined CONFIG_ADS8272
+	/* configure chip select for PCI interrupt controller */
+	immap->im_memctl.memc_br3 = PCI_INT_STAT_REG | 0x00001801;
+	immap->im_memctl.memc_or3 = 0xffff8010;
+#elif defined CONFIG_PQ2FADS
+	immap->im_memctl.memc_br8 = PCI_INT_STAT_REG | 0x00001801;
+	immap->im_memctl.memc_or8 = 0xffff8010;
+#endif
+	for (irq = NR_CPM_INTS; irq < NR_CPM_INTS + 4; irq++)
+		irq_desc[irq].handler = &pq2pci_ic;
+
+	/* make PCI IRQ level sensitive */
+	immap->im_intctl.ic_siexr &=
+		~(1 << (14 - (PCI_INT_TO_SIU - SIU_INT_IRQ1)));
+	
+	/* mask all PCI interrupts */
+	*(volatile unsigned long *) PCI_INT_MASK_REG |= 0xfff00000;
+
+	/* install the demultiplexer for the PCI cascade interrupt */
+	setup_irq(PCI_INT_TO_SIU, &pq2pci_irqaction);	
+	return;
+}
+
+static int
+pq2pci_exclude_device(u_char bus, u_char devfn)
+{
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/* PCI bus configuration registers.
+ */
+static void
+pq2ads_setup_pci(struct pci_controller *hose)
+{
+	__u32 val;
+	volatile cpm2_map_t *immap = cpm2_immr;
+	bd_t* binfo = (bd_t*) __res;
+	u32 sccr = immap->im_clkrst.car_sccr;
+	uint pci_div,freq,time;
+		/* PCI int lowest prio */
+	/* Each 4 bits is a device bus request	and the MS 4bits
+	 is highest priority */
+	/* Bus                4bit value
+	   ---                ----------
+	   CPM high      	0b0000
+	   CPM middle           0b0001
+	   CPM low       	0b0010
+	   PCI reguest          0b0011
+	   Reserved      	0b0100
+	   Reserved      	0b0101
+	   Internal Core     	0b0110
+	   External Master 1 	0b0111
+	   External Master 2 	0b1000
+	   External Master 3 	0b1001
+	   The rest are reserved
+	 */
+	immap->im_siu_conf.siu_82xx.sc_ppc_alrh = 0x61207893;
+	/* park bus on core */
+	immap->im_siu_conf.siu_82xx.sc_ppc_acr = PPC_ACR_BUS_PARK_CORE;
+	/*
+	 * Set up master windows that allow the CPU to access PCI space. These
+	 * windows are set up using the two SIU PCIBR registers.
+	 */
+	
+	immap->im_memctl.memc_pcimsk0 = M82xx_PCI_PRIM_WND_SIZE;
+	immap->im_memctl.memc_pcibr0  = M82xx_PCI_PRIM_WND_BASE | PCIBR_ENABLE;
+
+#ifdef M82xx_PCI_SEC_WND_SIZE	
+	immap->im_memctl.memc_pcimsk1 = M82xx_PCI_SEC_WND_SIZE;
+	immap->im_memctl.memc_pcibr1  = M82xx_PCI_SEC_WND_BASE | PCIBR_ENABLE;
+#endif
+
+#if defined CONFIG_ADS8272
+	immap->im_siu_conf.siu_82xx.sc_siumcr =
+		(immap->im_siu_conf.siu_82xx.sc_siumcr &
+		~(SIUMCR_BBD | SIUMCR_ESE | SIUMCR_PBSE |
+		SIUMCR_CDIS | SIUMCR_DPPC11 | SIUMCR_L2CPC11 |
+		SIUMCR_LBPC11 | SIUMCR_APPC11 |
+		SIUMCR_CS10PC11 | SIUMCR_BCTLC11 | SIUMCR_MMR11)) |
+		SIUMCR_DPPC11 | SIUMCR_L2CPC01 | SIUMCR_LBPC00 |
+		SIUMCR_APPC10 | SIUMCR_CS10PC00 |
+		SIUMCR_BCTLC00 | SIUMCR_MMR11 ;
+
+#elif defined CONFIG_PQ2FADS
+	/*
+	 * Setting required to enable IRQ1-IRQ7 (SIUMCR [DPPC]),
+	 * and local bus for PCI (SIUMCR [LBPC]).
+	 */
+	immap->im_siu_conf.siu_82xx.sc_siumcr = (immap->im_siu_conf.sc_siumcr &
+				~(SIUMCR_L2PC11 | SIUMCR_LBPC11 | SIUMCR_CS10PC11 | SIUMCR_APPC11) |
+				SIUMCR_BBD | SIUMCR_LBPC01 | SIUMCR_DPPC11 | SIUMCR_APPC10;
+#endif
+	/* Enable PCI  */
+	immap->im_pci.pci_gcr = cpu_to_le32(PCIGCR_PCI_BUS_EN);
+	
+	pci_div = ( (sccr & SCCR_PCI_MODCK) ? 2 : 1) *
+			( ( (sccr & SCCR_PCIDF_MSK) >> SCCR_PCIDF_SHIFT) + 1);
+	freq = (uint)((2*binfo->bi_cpmfreq)/(pci_div));
+	time = (int)666666/freq;
+	/* due to PCI Local Bus spec, some devices needs to wait such a long
+	time after RST 	deassertion. More specifically, 0.508s for 66MHz & twice more for 33 */
+	printk("%s: The PCI bus is %d Mhz.\nWaiting %s after deasserting RST...\n",__FILE__,freq,
+	(time==1) ? "0.5 seconds":"1 second" );
+	
+	{
+		int i;
+		for(i=0;i<(500*time);i++)
+			udelay(1000);
+	}	
+						
+	/* setup ATU registers */
+	immap->im_pci.pci_pocmr0 = cpu_to_le32(POCMR_ENABLE | POCMR_PCI_IO |
+				((~(M82xx_PCI_IO_SIZE - 1U)) >> POTA_ADDR_SHIFT));
+	immap->im_pci.pci_potar0 = cpu_to_le32(M82xx_PCI_LOWER_IO >> POTA_ADDR_SHIFT);
+	immap->im_pci.pci_pobar0 = cpu_to_le32(M82xx_PCI_IO_BASE >> POTA_ADDR_SHIFT);
+
+	/* Set-up non-prefetchable window */
+	immap->im_pci.pci_pocmr1 = cpu_to_le32(POCMR_ENABLE | ((~(M82xx_PCI_MMIO_SIZE-1U)) >> POTA_ADDR_SHIFT));
+	immap->im_pci.pci_potar1 = cpu_to_le32(M82xx_PCI_LOWER_MMIO >> POTA_ADDR_SHIFT);
+	immap->im_pci.pci_pobar1 = cpu_to_le32((M82xx_PCI_LOWER_MMIO - M82xx_PCI_MMIO_OFFSET) >> POTA_ADDR_SHIFT);
+
+	/* Set-up prefetchable window */
+	immap->im_pci.pci_pocmr2 = cpu_to_le32(POCMR_ENABLE |POCMR_PREFETCH_EN |
+		(~(M82xx_PCI_MEM_SIZE-1U) >> POTA_ADDR_SHIFT));
+	immap->im_pci.pci_potar2 = cpu_to_le32(M82xx_PCI_LOWER_MEM >> POTA_ADDR_SHIFT);
+	immap->im_pci.pci_pobar2 = cpu_to_le32((M82xx_PCI_LOWER_MEM - M82xx_PCI_MEM_OFFSET) >> POTA_ADDR_SHIFT);
+
+ 	/* Inbound transactions from PCI memory space */
+	immap->im_pci.pci_picmr0 = cpu_to_le32(PICMR_ENABLE | PICMR_PREFETCH_EN |
+					((~(M82xx_PCI_SLAVE_MEM_SIZE-1U)) >> PITA_ADDR_SHIFT));
+	immap->im_pci.pci_pibar0 = cpu_to_le32(M82xx_PCI_SLAVE_MEM_BUS  >> PITA_ADDR_SHIFT);
+	immap->im_pci.pci_pitar0 = cpu_to_le32(M82xx_PCI_SLAVE_MEM_LOCAL>> PITA_ADDR_SHIFT);
+
+#if defined CONFIG_ADS8272
+	/* PCI int highest prio */
+	immap->im_siu_conf.siu_82xx.sc_ppc_alrh = 0x01236745;
+#elif defined CONFIG_PQ2FADS
+	immap->im_siu_conf.siu_82xx.sc_ppc_alrh = 0x03124567;
+#endif
+	/* park bus on PCI */
+	immap->im_siu_conf.siu_82xx.sc_ppc_acr = PPC_ACR_BUS_PARK_PCI;
+
+	/* Enable bus mastering and inbound memory transactions */
+	early_read_config_dword(hose, hose->first_busno, 0, PCI_COMMAND, &val);
+	val &= 0xffff0000;
+	val |= PCI_COMMAND_MEMORY|PCI_COMMAND_MASTER;
+	early_write_config_dword(hose, hose->first_busno, 0, PCI_COMMAND, val);	
+
+}
+
+void __init pq2_find_bridges(void)
+{
+	extern int pci_assign_all_busses;
+	struct pci_controller * hose;
+	int host_bridge;
+
+	pci_assign_all_busses = 1;
+
+	hose = pcibios_alloc_controller();
+
+	if (!hose)
+		return;
+
+	ppc_md.pci_swizzle = common_swizzle;
+
+	hose->first_busno = 0;
+	hose->bus_offset = 0;
+	hose->last_busno = 0xff;
+
+#ifdef CONFIG_ADS8272
+	hose->set_cfg_type = 1;
+#endif
+
+	setup_m8260_indirect_pci(hose,
+				 (unsigned long)&cpm2_immr->im_pci.pci_cfg_addr,
+				 (unsigned long)&cpm2_immr->im_pci.pci_cfg_data);
+
+	/* Make sure it is a supported bridge */
+	early_read_config_dword(hose,
+				0,
+				PCI_DEVFN(0,0),
+				PCI_VENDOR_ID,
+				&host_bridge);
+	switch (host_bridge) {
+		case PCI_DEVICE_ID_MPC8265:
+			break;
+		case PCI_DEVICE_ID_MPC8272:
+			break;
+		default:
+			printk("Attempting to use unrecognized host bridge ID"
+				" 0x%08x.\n", host_bridge);
+			break;
+	}
+
+	pq2ads_setup_pci(hose);
+
+	hose->io_space.start =	M82xx_PCI_LOWER_IO;
+	hose->io_space.end = M82xx_PCI_UPPER_IO;
+	hose->mem_space.start = M82xx_PCI_LOWER_MEM;
+	hose->mem_space.end = M82xx_PCI_UPPER_MMIO;
+	hose->pci_mem_offset = M82xx_PCI_MEM_OFFSET;
+
+	isa_io_base =
+	(unsigned long) ioremap(M82xx_PCI_IO_BASE,
+					M82xx_PCI_IO_SIZE);
+	hose->io_base_virt = (void *) isa_io_base;
+
+	/* setup resources */
+	pci_init_resource(&hose->mem_resources[0],
+			M82xx_PCI_LOWER_MEM,
+			M82xx_PCI_UPPER_MEM,
+			IORESOURCE_MEM|IORESOURCE_PREFETCH, "PCI prefetchable memory");
+
+	pci_init_resource(&hose->mem_resources[1],
+			M82xx_PCI_LOWER_MMIO,
+			M82xx_PCI_UPPER_MMIO,
+			IORESOURCE_MEM, "PCI memory");
+
+	pci_init_resource(&hose->io_resource,
+			M82xx_PCI_LOWER_IO,
+			M82xx_PCI_UPPER_IO,
+			IORESOURCE_IO | 1, "PCI I/O");
+
+	ppc_md.pci_exclude_device = pq2pci_exclude_device;
+	hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
+
+	ppc_md.pci_map_irq = pq2pci_map_irq;
+	ppc_md.pcibios_fixup = NULL;
+	ppc_md.pcibios_fixup_bus = NULL;
+
+}
Index: arch/ppc/syslib/m82xx_pci.h
===================================================================
--- /dev/null  (tree:eed337ef5e9ae7d62caa84b7974a11fddc7f06e0)
+++ 874039bc658fe59955b149328a70521a56744a27/arch/ppc/syslib/m82xx_pci.h  (mode:100644 sha1:0e95bf6a73b0be65ee5dcc36374f4e8870f82c37)
@@ -0,0 +1,92 @@
+
+#ifndef _PPC_KERNEL_M82XX_PCI_H
+#define _PPC_KERNEL_M82XX_PCI_H
+
+#include <asm/m8260_pci.h>
+/*
+ *   Local->PCI map (from CPU)                             controlled by
+ *   MPC826x master window
+ *
+ *   0xF6000000 - 0xF7FFFFFF    IO space
+ *   0x80000000 - 0xBFFFFFFF    CPU2PCI memory space       PCIBR0
+ *   	                    
+ *   0x80000000 - 0x9FFFFFFF    PCI Mem with prefetch      (Outbound ATU #1)
+ *   0xA0000000 - 0xBFFFFFFF    PCI Mem w/o  prefetch      (Outbound ATU #2)
+ *   0xF6000000 - 0xF7FFFFFF    32-bit PCI IO              (Outbound ATU #3)
+ *                      
+ *   PCI->Local map (from PCI)
+ *   MPC826x slave window                                  controlled by
+ *
+ *   0x00000000 - 0x07FFFFFF    MPC826x local memory       (Inbound ATU #1)
+ */
+
+/* 
+ * Slave window that allows PCI masters to access MPC826x local memory. 
+ * This window is set up using the first set of Inbound ATU registers
+ */
+
+#ifndef M82xx_PCI_SLAVE_MEM_LOCAL
+#define M82xx_PCI_SLAVE_MEM_LOCAL	(((struct bd_info *)__res)->bi_memstart)
+#define M82xx_PCI_SLAVE_MEM_BUS		(((struct bd_info *)__res)->bi_memstart)
+#define M82xx_PCI_SLAVE_MEM_SIZE	(((struct bd_info *)__res)->bi_memsize)
+#endif
+
+/* 
+ * This is the window that allows the CPU to access PCI address space.
+ * It will be setup with the SIU PCIBR0 register. All three PCI master
+ * windows, which allow the CPU to access PCI prefetch, non prefetch,
+ * and IO space (see below), must all fit within this window.
+ */
+
+#ifndef M82xx_PCI_LOWER_MEM
+#define M82xx_PCI_LOWER_MEM		0x80000000
+#define M82xx_PCI_UPPER_MEM		0x9fffffff
+#define M82xx_PCI_MEM_OFFSET		0x00000000
+#define M82xx_PCI_MEM_SIZE		0x20000000
+#endif
+
+#ifndef M82xx_PCI_LOWER_MMIO
+#define M82xx_PCI_LOWER_MMIO		0xa0000000
+#define M82xx_PCI_UPPER_MMIO		0xafffffff
+#define M82xx_PCI_MMIO_OFFSET		0x00000000
+#define M82xx_PCI_MMIO_SIZE		0x20000000
+#endif
+
+#ifndef M82xx_PCI_LOWER_IO
+#define M82xx_PCI_LOWER_IO		0x00000000
+#define M82xx_PCI_UPPER_IO		0x01ffffff
+#define M82xx_PCI_IO_BASE		0xf6000000
+#define M82xx_PCI_IO_SIZE		0x02000000
+#endif
+
+#ifndef M82xx_PCI_PRIM_WND_SIZE
+#define M82xx_PCI_PRIM_WND_SIZE 	~(M82xx_PCI_IO_SIZE - 1U)
+#define M82xx_PCI_PRIM_WND_BASE		(M82xx_PCI_IO_BASE)
+#endif
+
+#ifndef M82xx_PCI_SEC_WND_SIZE
+#define M82xx_PCI_SEC_WND_SIZE 		~(M82xx_PCI_MEM_SIZE + M82xx_PCI_MMIO_SIZE - 1U)
+#define M82xx_PCI_SEC_WND_BASE 		(M82xx_PCI_LOWER_MEM)
+#endif
+
+#ifndef POTA_ADDR_SHIFT
+#define POTA_ADDR_SHIFT		12
+#endif
+
+#ifndef PITA_ADDR_SHIFT
+#define PITA_ADDR_SHIFT		12
+#endif
+
+#ifndef _IO_BASE
+#define _IO_BASE isa_io_base
+#endif
+
+#ifdef CONFIG_8260_PCI9
+struct pci_controller;
+extern void setup_m8260_indirect_pci(struct pci_controller* hose,
+					u32 cfg_addr, u32 cfg_data);
+#else
+#define setup_m8260_indirect_pci setup_indirect_pci
+#endif
+
+#endif /* _PPC_KERNEL_M8260_PCI_H */
Index: include/asm-ppc/cpm2.h
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/include/asm-ppc/cpm2.h  (mode:100644 sha1:42fd1068cf2a4100f468f439f69c2da3c0fe5b38)
+++ 874039bc658fe59955b149328a70521a56744a27/include/asm-ppc/cpm2.h  (mode:100644 sha1:c5883dbed63f8bbf84d8d1eeb11d6f77a93a62ac)
@@ -1039,6 +1039,52 @@
 #define CMXSCR_TS4CS_CLK7  0x00000006   /* SCC4 Tx Clock Source is CLK7 */
 #define CMXSCR_TS4CS_CLK8  0x00000007   /* SCC4 Tx Clock Source is CLK8 */
 
+/*-----------------------------------------------------------------------
+ * SIUMCR - SIU Module Configuration Register				 4-31
+ */
+#define SIUMCR_BBD	0x80000000	/* Bus Busy Disable		*/
+#define SIUMCR_ESE	0x40000000	/* External Snoop Enable	*/
+#define SIUMCR_PBSE	0x20000000	/* Parity Byte Select Enable	*/
+#define SIUMCR_CDIS	0x10000000	/* Core Disable			*/
+#define SIUMCR_DPPC00	0x00000000	/* Data Parity Pins Configuration*/
+#define SIUMCR_DPPC01	0x04000000	/* - " -			*/
+#define SIUMCR_DPPC10	0x08000000	/* - " -			*/
+#define SIUMCR_DPPC11	0x0c000000	/* - " -			*/
+#define SIUMCR_L2CPC00	0x00000000	/* L2 Cache Pins Configuration	*/
+#define SIUMCR_L2CPC01	0x01000000	/* - " -			*/
+#define SIUMCR_L2CPC10	0x02000000	/* - " -			*/
+#define SIUMCR_L2CPC11	0x03000000	/* - " -			*/
+#define SIUMCR_LBPC00	0x00000000	/* Local Bus Pins Configuration	*/
+#define SIUMCR_LBPC01	0x00400000	/* - " -			*/
+#define SIUMCR_LBPC10	0x00800000	/* - " -			*/
+#define SIUMCR_LBPC11	0x00c00000	/* - " -			*/
+#define SIUMCR_APPC00	0x00000000	/* Address Parity Pins Configuration*/
+#define SIUMCR_APPC01	0x00100000	/* - " -			*/
+#define SIUMCR_APPC10	0x00200000	/* - " -			*/
+#define SIUMCR_APPC11	0x00300000	/* - " -			*/
+#define SIUMCR_CS10PC00	0x00000000	/* CS10 Pin Configuration	*/
+#define SIUMCR_CS10PC01	0x00040000	/* - " -			*/
+#define SIUMCR_CS10PC10	0x00080000	/* - " -			*/
+#define SIUMCR_CS10PC11	0x000c0000	/* - " -			*/
+#define SIUMCR_BCTLC00	0x00000000	/* Buffer Control Configuration	*/
+#define SIUMCR_BCTLC01	0x00010000	/* - " -			*/
+#define SIUMCR_BCTLC10	0x00020000	/* - " -			*/
+#define SIUMCR_BCTLC11	0x00030000	/* - " -			*/
+#define SIUMCR_MMR00	0x00000000	/* Mask Masters Requests	*/
+#define SIUMCR_MMR01	0x00004000	/* - " -			*/
+#define SIUMCR_MMR10	0x00008000	/* - " -			*/
+#define SIUMCR_MMR11	0x0000c000	/* - " -			*/
+#define SIUMCR_LPBSE	0x00002000	/* LocalBus Parity Byte Select Enable*/
+
+/*-----------------------------------------------------------------------
+ * SCCR - System Clock Control Register					 9-8
+*/
+#define SCCR_PCI_MODE	0x00000100	/* PCI Mode	*/
+#define SCCR_PCI_MODCK	0x00000080	/* Value of PCI_MODCK pin	*/
+#define SCCR_PCIDF_MSK	0x00000078	/* PCI division factor	*/
+#define SCCR_PCIDF_SHIFT 3
+
+
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */
 
Index: include/asm-ppc/m8260_pci.h
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/include/asm-ppc/m8260_pci.h  (mode:100644 sha1:163a6b91d5b2ffe0c49f9d9814a65a5bc23d0cd0)
+++ 874039bc658fe59955b149328a70521a56744a27/include/asm-ppc/m8260_pci.h  (mode:100644 sha1:bf9e05dd54b5243d256f12c5e5df70f6b5a6c128)
@@ -19,6 +19,7 @@
  * Define the vendor/device ID for the MPC8265.
  */
 #define	PCI_DEVICE_ID_MPC8265	((0x18C0 << 16) | PCI_VENDOR_ID_MOTOROLA)
+#define	PCI_DEVICE_ID_MPC8272	((0x18C1 << 16) | PCI_VENDOR_ID_MOTOROLA)
 
 #define M8265_PCIBR0	0x101ac
 #define M8265_PCIBR1	0x101b0
Index: include/asm-ppc/mpc8260.h
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/include/asm-ppc/mpc8260.h  (mode:100644 sha1:d820894e59916a4c491b8bdd0312830acec228a9)
+++ 874039bc658fe59955b149328a70521a56744a27/include/asm-ppc/mpc8260.h  (mode:100644 sha1:89eb8a2ac6934552eeaf74d5ed222690ed504732)
@@ -41,7 +41,7 @@
 #endif
 
 #ifdef CONFIG_PCI_8260
-#include <syslib/m8260_pci.h>
+#include <syslib/m82xx_pci.h>
 #endif
 
 /* Make sure the memory translation stuff is there if PCI not used.

--------------090305080005090601080609--

Date: Fri, 13 Dec 2002 15:36:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Support for Arctic platform (405LP based)
Message-ID: <20021213043628.GI21319@zax.zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The patch below adds support for IBM's Arctic-II development system,
based on the 405LP processor.  For now this is just the core support,
more drivers coming soon.  Are there any objections, or suggestions
for doing things better before I commit this to linuxppc_2_4_devel?

In particular, I'd welcome comments on the handling of the bootstrap
for Arctic:  the normal bootloader is PIBS, which is quite different
from IBM OpenBIOS, but uses the same image format.  For now I'm *not*
defining CONFIG_IBM_OPENBIOS, but duplicating the targets in the
arch/ppc/boot/simple/Makefile so that we get a treeboot image.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/boot/simple/Makefile linux-bartholomew/arch/ppc/boot/simple/Makefile
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/boot/simple/Makefile	2002-10-03 12:09:32.000000000 +1000
+++ linux-bartholomew/arch/ppc/boot/simple/Makefile	2002-12-12 14:32:18.000000000 +1100
@@ -19,6 +19,12 @@
 # Normally, we use the 'misc-simple.c' file for decompress_kernel and
 # whatnot.  Sometimes we need to override this however.
 MISC				:= ../common/misc-simple.o
+ifeq ($(CONFIG_ARCTIC2),y)
+ZIMAGE				:= zImage-TREE
+ZIMAGEINITRD			:= zImage.initrd-TREE
+TFTPIMAGE			:= /tftpboot/zImage.embedded
+MISC				:= misc-embedded.o
+endif
 ifeq ($(CONFIG_IBM_OPENBIOS),y)
 ZIMAGE				:= zImage-TREE
 ZIMAGEINITRD			:= zImage.initrd-TREE
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/boot/simple/embed_config.c linux-bartholomew/arch/ppc/boot/simple/embed_config.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/boot/simple/embed_config.c	2002-12-04 10:44:50.000000000 +1100
+++ linux-bartholomew/arch/ppc/boot/simple/embed_config.c	2002-12-12 14:32:27.000000000 +1100
@@ -941,6 +941,68 @@
 #endif /* CONFIG_BEECH */
 #endif /* CONFIG_IBM_OPENBIOS */

+#ifdef CONFIG_ARCTIC2
+/* Several bootloaders have been used on the Arctic.  We assume either
+ * SSX or PIBS */
+
+#define SSX_BIOS_ADDR 		0xFFFF0000
+#define SSX_BIOS_GET_BOARD_INFO 0
+#define	PIBS_BOARD_INFO_VECTOR	0xFFF62004
+
+struct ssx_bios_id {
+	unsigned int boot_branch;	/* Branch to bootcode */
+	char ssx_bios[8];		/* "SSX BIOS" (no \0) */
+	void (*bios_entry_point)(unsigned int, bd_t *); /* Call bios_entry_point(cmd, &data) */
+};
+
+extern int memcmp(const void *s1, const void *s2, size_t n);
+
+static void get_board_info(bd_t **bdp)
+{
+	struct ssx_bios_id *ssx = (struct ssx_bios_id *)SSX_BIOS_ADDR;
+
+	/* Check for SSX signature */
+
+	if (memcmp(&ssx->ssx_bios, "SSX BIOS", 8) == 0) {
+		ssx->bios_entry_point(SSX_BIOS_GET_BOARD_INFO, *bdp);
+	} else {
+		/* It's not SSX, so assume PIBS */
+		typedef void (*PFV)(bd_t *bd);
+		((PFV)(*(unsigned long *)PIBS_BOARD_INFO_VECTOR))(*bdp);
+	}
+}
+
+void embed_config(bd_t **bdp)
+{
+        *bdp = &bdinfo;
+	get_board_info(bdp);
+	/* HACK! PIBS seems to get the UART clock wrong at the moment */
+	mtdcr(DCRN_CPC0_CGCR0, (mfdcr(DCRN_CPC0_CGCR0) & ~0x003e0000) | 0x00160000);
+#if 0
+	/* Enable RefClk/4 mode for both UARTs */
+	mtdcr(DCRN_CPC0_CR0, mfdcr(DCRN_CPC0_CR0) | 0x30000000);
+#endif
+}
+
+#endif
+
+#ifdef CONFIG_BEECH
+static void
+get_board_info(bd_t **bdp)
+{
+	typedef void (*PFV)(bd_t *bd);
+	((PFV)(*(unsigned long *)BOARD_INFO_VECTOR))(*bdp);
+	return;
+}
+
+void
+embed_config(bd_t **bdp)
+{
+        *bdp = &bdinfo;
+	get_board_info(bdp);
+}
+#endif
+
 #ifdef CONFIG_EP405
 #include <linux/serial_reg.h>

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/config.in linux-bartholomew/arch/ppc/config.in
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/config.in	2002-10-03 12:09:32.000000000 +1000
+++ linux-bartholomew/arch/ppc/config.in	2002-12-11 16:17:18.000000000 +1100
@@ -73,7 +73,8 @@

 if [ "$CONFIG_40x" = "y" ]; then
     choice 'Machine Type'			\
-	"Ash		CONFIG_ASH		\
+	"Arctic-II	CONFIG_ARCTIC2		\
+	 Ash		CONFIG_ASH		\
 	 Ceder		CONFIG_CEDER		\
 	 Beech		CONFIG_BEECH		\
 	 CPCI405	CONFIG_CPCI405 		\
@@ -309,10 +310,14 @@
     define_bool CONFIG_IBM405_ERR77 y
     define_bool CONFIG_IBM_OCP y
   fi
+  if [ "$CONFIG_ARCTIC2" = "y" ]; then
+    define_bool CONFIG_405LP y
+    define_bool CONFIG_IBM405_ERR77 y
+    define_bool CONFIG_IBM_OCP y
+  fi
   if [ "$CONFIG_SYCAMORE" = "y" ]; then
     define_bool CONFIG_405GPR y
     define_bool CONFIG_BIOS_FIXUP y
-    define_bool CONFIG_IBM_OPENBIOS y
     define_bool CONFIG_IBM405_ERR77 y
     define_bool CONFIG_IBM_OCP y
   fi
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/Makefile linux-bartholomew/arch/ppc/platforms/Makefile
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/Makefile	2002-08-08 15:04:56.000000000 +1000
+++ linux-bartholomew/arch/ppc/platforms/Makefile	2002-12-11 16:00:06.000000000 +1100
@@ -40,6 +40,7 @@
 obj-$(CONFIG_RAINIER)		+= rainier.o ibmnp4gs.o
 obj-$(CONFIG_APUS)		+= apus_setup.o
 obj-$(CONFIG_BEECH)		+= beech.o ibm405lp.o
+obj-$(CONFIG_ARCTIC2)		+= arctic2.o subzero.o ibm405lp.o
 obj-$(CONFIG_SYCAMORE)		+= sycamore.o ibm405gpr.o

 obj-$(CONFIG_EBONY)		+= ebony.o ibm440gp.o
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/arctic2.c linux-bartholomew/arch/ppc/platforms/arctic2.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/arctic2.c	Thu Jan 01 10:00:00 1970
+++ linux-bartholomew/arch/ppc/platforms/arctic2.c	Thu Dec 12 17:14:44 2002
@@ -0,0 +1,113 @@
+/*
+ * arch/ppc/platforms/arctic2.c  Platform setup for the IBM Arctic-2 reference platform
+ *					with the Subzero core card and Beech personality card
+ * 				      Based on beech.c by Bishop Brock
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Copyright (C) 2002, International Business Machines Corporation
+ * All Rights Reserved.
+ *
+ * Ken Inoue
+ * IBM Thomas J. Watson Research Center
+ * keninoue@us.ibm.com
+ *
+ * David Gibson
+ * IBM Ozlabs, Canberra, Australia
+ * arctic@gibson.dropbear.id.au
+ */
+
+#include <linux/blk.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/param.h>
+#include <linux/rtc.h>
+#include <linux/string.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/time.h>
+
+#include <platforms/arctic2.h>
+
+void __init
+board_setup_arch(void)
+{
+}
+
+/* All Arctic-2 core physical memory resources are direct-mapped at boot time.
+*  Need to change that. */
+
+void __init
+board_io_mapping(void)
+{
+	/* FIXME: yuck.  Need to get rid of these */
+	io_block_mapping(ARCTIC2_FPGA8_VADDR, ARCTIC2_FPGA8_PADDR,
+			 ARCTIC2_FPGA8_SIZE, _PAGE_IO);
+	io_block_mapping(ARCTIC2_FPGA16_VADDR, ARCTIC2_FPGA16_PADDR,
+			 ARCTIC2_FPGA16_SIZE, _PAGE_IO);
+	io_block_mapping(SUBZERO_BEECH_PCMCIA_VADDR, SUBZERO_BEECH_PCMCIA_PADDR,
+			 SUBZERO_BEECH_PCMCIA_SIZE, _PAGE_IO);
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
+#ifdef CONFIG_PPC_RTC
+	ppc_md.time_init = ibm405lp_time_init;
+	ppc_md.set_rtc_time = ibm405lp_set_rtc_time;
+	ppc_md.get_rtc_time = ibm405lp_get_rtc_time;
+#endif
+
+	/* Set up the EBC, then Disable the LCD controller, which may have been
+	   left on by the BIOS. */
+
+	subzero_core_ebc_setup();
+
+	/* Configure the Arctic-II specific EBC banks */
+
+	/* Bank 1: 16-bit FPGA peripherals (ethernet data, SDIO, USB, DOC)
+	 * 1MB, RW, 16-bit at 0xf1000000-0xf10fffff */
+	/* The access parameters are programmed assuming a 33Mhz EBC
+	   clock, which is true for nearly all the operating points we
+	   have defined:
+	   	BME=0, TWT=5, CSN=0, OEN=1, WBN=1, WBF=1 TH=4
+		RE=1, SOR=0, BEM=0, PEN=0
+	 */
+	mtdcri(DCRN_EBC0, BnAP(1), 0x02815900);
+	mtdcri(DCRN_EBC0, BnCR(1), ARCTIC2_FPGA16_PADDR | 0x1a000);
+
+	/* Bank 2: 8-bit FPGA peripherals (switch/control, ethernet regs, TCPA)
+	 * 1MB, RW, 8-bit at 0xf8000000-0xf80fffff */
+	mtdcri(DCRN_EBC0, BnAP(2), 0x02815580);
+	mtdcri(DCRN_EBC0, BnCR(2), ARCTIC2_FPGA8_PADDR | 0x18000);
+
+	mtdcri(DCRN_LCD0, DER, 0);
+}
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End: */
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/arctic2.h linux-bartholomew/arch/ppc/platforms/arctic2.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/arctic2.h	Thu Jan 01 10:00:00 1970
+++ linux-bartholomew/arch/ppc/platforms/arctic2.h	Thu Dec 12 16:52:42 2002
@@ -0,0 +1,63 @@
+/*
+ * arch/ppc/platforms/arctic2.h   Platform definitions for the IBM Arctic-II
+ *				based on beech.h by Bishop Brock
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Copyright (C) 2002, International Business Machines Corporation
+ * All Rights Reserved.
+ *
+ * Ken Inoue
+ * IBM Thomas J. Watson Research Center
+ * keninoue@us.ibm.com
+ *
+ * David Gibson
+ * IBM Ozlabs, Canberra, Australia
+ * arctic@gibson.dropbear.id.au
+ *
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_ARCTIC2_H__
+#define __ASM_ARCTIC2_H__
+
+#include <platforms/subzero.h>
+
+#ifndef __ASSEMBLY__
+
+#define ARCTIC2_FPGA8_PADDR	(0xf8000000)
+#define ARCTIC2_FPGA8_VADDR	ARCTIC2_FPGA8_PADDR
+#define ARCTIC2_FPGA8_SIZE	(768*1024)
+
+#define ARCTIC2_FPGA16_PADDR	(0xf9000000)
+#define ARCTIC2_FPGA16_VADDR	ARCTIC2_FPGA16_PADDR
+#define ARCTIC2_FPGA16_SIZE	(1024*1024)
+
+/* Arctic II uses the internal clock for UART. Note that the OPB
+   frequency must be more than 2x the UART clock frequency. At OPB
+   frequencies less than this the serial port will not function due to
+   the way that SerClk is sampled.  We use 11.1111MHz as the frequency
+   because it can be generated from a wide range of OPB frequencies we
+   want to use. */
+
+#define PPC4xx_SERCLK_FREQ 11111111
+
+#define BASE_BAUD (PPC4xx_SERCLK_FREQ / 16)
+
+#define PPC4xx_MACHINE_NAME	"IBM Arctic II"
+
+#endif /* !__ASSEMBLY__ */
+#endif /* __ASM_ARCTIC2_H__ */
+#endif /* __KERNEL__ */
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/subzero.c linux-bartholomew/arch/ppc/platforms/subzero.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/subzero.c	Thu Jan 01 10:00:00 1970
+++ linux-bartholomew/arch/ppc/platforms/subzero.c	Thu Dec 12 14:57:18 2002
@@ -0,0 +1,96 @@
+/*
+ * arch/ppc/platforms/subzero.c  Platform setup for the IBM Subzero CPU core card.
+ *
+ *				Based on arctic1.c by Ken Inoue, which
+ *				was based on beech.c by Bishop Brock
+ *
+ * The source code contained herein is licensed under the IBM Public License
+ * Version 1.0, which has been approved by the Open Source Initiative.
+ * Copyright (C) 2002, International Business Machines Corporation
+ * All Rights Reserved.
+ *
+ * David Gibson
+ * IBM OzLabs, Canberra, Australia
+ * <dwg@au1.ibm.com>
+ */
+
+#include <linux/blk.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/param.h>
+#include <linux/rtc.h>
+#include <linux/string.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/time.h>
+
+/*
+   Subzero core card physical memory map:
+
+   Main Memory (Initialized by the BIOS)
+   =======================================================================
+
+   SDRAM (32 MB)     0x00000000 - 0x02000000
+
+   OPB Space: (Mapped virtual = physical in ppc4xx_setup.c)
+   =======================================================================
+
+   UART0               	      0xEF600300
+   UART1               	      0xEF600400
+   IIC                 	      0xEF600500
+   OPB Arbiter         	      0xEF600600
+   GPIO Controller     	      0xEF600700
+   CODEC Interface            0xEF600900
+   Touch Panel Controller     0xEF600A00
+   DES Controller             0xEF600B00
+
+
+   EBC Space: (Mapped virtual = physical in board_io_mapping())
+	      (EBC setup for personality cards left to individual card setups)
+   Space             EBC Bank    Physical Addresses  EBC Base Address
+   =========================================================================
+   Boot/Linux Flash      0       FF000000 - FFFFFFFF  FF000000 (16MB)
+
+*/
+
+
+/****************************************************************************
+ * EBC Setup
+ ****************************************************************************/
+
+/* The EBC is set up for Arctic1.  This may simply replicate the setup already
+   done by the IBM BIOS for Arctic1 (possibly with some address map changes), or
+   may be the first initialization if the board is booting from another BIOS.
+   Virtually all that is required to boot Linux on Subzero is that the BIOS
+   enable the memory controller, load a Linux image from flash, and run it.
+
+   For optimal dynamic frequency scaling the EBC settings will also vary as the
+   frequency varies.
+*/
+
+void __init
+subzero_core_ebc_setup(void)
+{
+	ebc0_bnap_t ap;
+
+	/* Set EBC bank 0 for the boot/data flash.
+
+	   Access parameters assume 150ns Intel flash @ 66.66 MHz maximum bus
+	   speed = 10 cycle access with 2 turnaround cycles (30 ns).
+
+	   NB: IBM BIOS sets this bank to burst, however bursting will never
+	   happen in Linux because this region is mapped non-cacheable and
+	   guarded, so it is set non-burst here. */
+	ap.reg = mfdcri(DCRN_EBC0, BnAP(0)) & EBC0_BnAP_MASK;
+	ap.fields.twt = 10;
+	ap.fields.th = 2;
+	mtdcri(DCRN_EBC0, BnAP(0), ap.reg);
+
+}
+
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/subzero.h linux-bartholomew/arch/ppc/platforms/subzero.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/subzero.h	Thu Jan 01 10:00:00 1970
+++ linux-bartholomew/arch/ppc/platforms/subzero.h	Thu Dec 12 15:22:30 2002
@@ -0,0 +1,114 @@
+/*
+ * arch/ppc/platforms/subzero.h   Platform definitions for the IBM
+ *				Subzero card, based on beech.h by Bishop Brock
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Copyright (C) 2002, International Business Machines Corporation
+ * All Rights Reserved.
+ *
+ * David Gibson
+ * IBM OzLabs, Canberra, Australia
+ * <arctic@gibson.dropbear.id.au>
+ *
+ * Ken Inoue
+ * IBM Thomas J. Watson Research Center
+ * <keninoue@us.ibm.com>
+ *
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_SUBZERO_CORE_H__
+#define __ASM_SUBZERO_CORE_H__
+
+#include <platforms/ibm405lp.h>
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/*
+ * Data structure defining board information maintained by the standard boot
+ * ROM on the IBM Subzero card. An effort has been made to
+ * keep the field names consistent with the 8xx 'bd_t' board info
+ * structures.
+ *
+ * Original Beech BIOS Definition:
+ *
+ * typedef struct board_cfg_data {
+ *    unsigned char     usr_config_ver[4];
+ *    unsigned long     timerclk_freq;
+ *    unsigned char     rom_sw_ver[30];
+ *    unsigned int      mem_size;
+ *    unsigned long     sysclock_period;
+ *    unsigned long     sys_speed;
+ *    unsigned long     cpu_speed;
+ *    unsigned long     vco_speed;
+ *    unsigned long     plb_speed;
+ *    unsigned long     opb_speed;
+ *    unsigned long     ebc_speed;
+ *  } bd_t;
+ */
+
+typedef struct board_info {
+	unsigned char     bi_s_version[4];  /* Version of this structure */
+	unsigned long     bi_tbfreq;        /* Frequency of SysTmrClk */
+	unsigned char     bi_r_version[30]; /* Version of the IBM ROM */
+	unsigned int      bi_memsize;       /* DRAM installed, in bytes */
+	unsigned long     sysclock_period;  /* SysClk period in ns */
+	unsigned long     sys_speed;        /* SysCLk frequency in Hz */
+	unsigned long     bi_intfreq;       /* Processor speed, in Hz */
+	unsigned long     vco_speed;        /* PLL VCO speed, in Hz */
+	unsigned long     bi_busfreq;       /* PLB Bus speed, in Hz */
+	unsigned long     opb_speed;        /* OPB Bus speed, in Hz */
+	unsigned long     ebc_speed;        /* EBC Bus speed, in Hz */
+
+} bd_t;
+
+/* EBC Bank 0 controls the boot flash
+ *
+ * FIXME? these values assume that there is 16MB of flash on the
+ * personality card, in addition to the 16MB on the subzero card
+ * itself */
+#define SUBZERO_BANK0_PADDR      ((uint)0xfe000000)
+#define SUBZERO_BANK0_EBC_SIZE   EBC0_BnCR_BS_32MB
+
+#define SUBZERO_BOOTFLASH_PADDR  (SUBZERO_BANK0_PADDR)
+#define SUBZERO_BOOTFLASH_SIZE   ((uint)(32 * 1024 * 1024))
+
+/* The PCMCIA controller driver 4xx_pccf.c is responsible for the EBC setup of
+   PCMCIA.  Externally, EBC bank selects 3..7 take on PCMCIA functions when
+   PCMCIA is enabled. */
+
+#define SUBZERO_BEECH_PCMCIA_PADDR     ((uint)0xf0000000)
+#define SUBZERO_BEECH_PCMCIA_VADDR     SUBZERO_BEECH_PCMCIA_PADDR
+#define SUBZERO_BEECH_PCMCIA_SIZE      ((uint)(32 * 1024 * 1024))
+
+#define SUBZERO_BEECH_PCMCIA_IO_BASE (SUBZERO_BEECH_PCMCIA_VADDR + 0x01800000)
+
+/* Define _IO_BASE for PCMCIA; other defines are required as well. */
+
+#define _IO_BASE SUBZERO_BEECH_PCMCIA_IO_BASE
+#define _ISA_MEM_BASE 0
+#define PCI_DRAM_OFFSET 0
+
+void *beech_sram_alloc(size_t size);
+int beech_sram_free(void *p);
+
+void subzero_core_ebc_setup(void);
+
+#endif /* !__ASSEMBLY__ */
+#endif /* __ASM_SUBZERO_CORE_H__ */
+#endif /* __KERNEL__ */
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/ibm4xx.h linux-bartholomew/include/asm-ppc/ibm4xx.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/ibm4xx.h	2002-08-05 10:37:17.000000000 +1000
+++ linux-bartholomew/include/asm-ppc/ibm4xx.h	2002-12-12 15:50:48.000000000 +1100
@@ -109,6 +109,10 @@
 #include <platforms/beech.h>
 #endif

+#if defined(CONFIG_ARCTIC2)
+#include <platforms/arctic2.h>
+#endif
+
 #if defined(CONFIG_SYCAMORE)
 #include <platforms/sycamore.h>
 #endif


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

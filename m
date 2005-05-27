Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D5EDB679E7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 May 2005 05:14:26 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	j4RJIKK1003619 for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 12:18:20 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j4RJFijS015020
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 14:15:44 -0500 (CDT)
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
In-Reply-To: <f003613a0526b7b6a00a0bd477cd5ac3@freescale.com>
References: <1116607235.29111.20.camel@gleep>
	<f003613a0526b7b6a00a0bd477cd5ac3@freescale.com>
Content-Type: text/plain
Message-Id: <1117221259.26114.91.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 27 May 2005 14:14:20 -0500
Subject: bd_t Cleaning: Interface Part
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-05-26 at 18:08, Kumar Gala wrote:
> Jon,
> 
> Can you break the patch up into a few pieces, it will be easier to 
> review that way.  Here are the following pieces that make sense to me:
> 
> 0. New firmware interface (fw_bdt*, Kconfig, ...)
> 1. board code changes (everything in arch/ppc/platforms/*)
> 2. driver changes (things in *_io, ide, net, serial dirs -- try to give 
> a better list below)
> 3. System changes (files in arch/ppc/syslib and include/asm-ppc)


OK.

Here's the first of the same patch in four part harmony.

 ppc/Kconfig                             |   29 +
 ppc/syslib/fw_bdt.c                     |  598 ++++++++++++++++++++++++++++++++
 ppc/syslib/fw_bdt.h                     |  453 ++++++++++++++++++++++++
 ppc/syslib/Makefile                     |    4 
 asm-ppc/firmware.h                      |   62 +++
 ppc/kernel/ppc_ksyms.c                  |    4 

Index: arch/ppc/Kconfig
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/Kconfig  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/Kconfig  (mode:100644)
@@ -955,6 +955,35 @@
 	  some command-line options at build time by entering them here.  In
 	  most cases you will need to specify the root device here.
 
+choice
+	prompt "Firmware setup interface"
+	default FW_BDT
+	help
+	  The bd_t structure setup by U-Boot is a flat structure with a
+	  fixed structure that must be consistent between U-Boot and Linux.
+	  Often that structure definition is out of date and inconsistent.
+	  The Open Firmware Flattened Device Tree provides a less fragile
+	  mechanism for communicating setup data from the firmware to Linux.
+
+	  The Implementation of the Open Firwmare flattened Device Tree
+	  hasn't been added to U-Boot yet, so select the bd_t option.
+
+config FW_BDT
+	bool "bd_t structure"
+	help
+	  Select this option to use the traditional bd_t style interface
+	  to pass residual data from U-Boot to the Linux startup code.
+
+	  Select this choice if unsure.
+
+config FW_OF
+	bool "OF Flattened Device Tree"
+	help
+	  Select this option to use a flattened Open Firmware device tree
+	  to pass data from U-Boot to the Linux startup code.
+
+endchoice
+
 config AMIGA
 	bool
 	depends on APUS
Index: arch/ppc/syslib/fw_bdt.c
===================================================================
--- /dev/null  (tree:c7d7a187a2125518e655dfeadffd38156239ffc3)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/fw_bdt.c  (mode:100644)
@@ -0,0 +1,598 @@
+/*
+ * arch/ppc/syslib/fw_bdt.c
+ *
+ * Implements the interface to Firmware information based
+ * on U-Boot's bd_t structure definition.
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include <asm/firmware.h>
+
+#include "fw_bdt.h"
+
+
+/*
+ * The "residual" data area holds data supplied by the firmware in order
+ * to communicate initialization and setup data to the Linux startup.
+ */
+bd_t __res;
+static bd_t *binfo = &__res;
+
+EXPORT_SYMBOL(__res);
+
+
+/*
+ * Perform any initialization needed in order to setup the interface
+ * between the Firmware-supplied setup data and the Linux use of it.
+ *
+ * That is, copy the data pointed to by r3 to the __res "residual" structure.
+ */
+
+void __init
+fw_initialize(unsigned long r3)
+{
+	if (r3) {
+		memcpy((void *) &__res,
+		       (void *) (r3 + KERNELBASE),
+		       sizeof(bd_t));
+	}
+}
+
+
+/*
+ * Return the address of an in-memory structure that can be used
+ * to initialize the bd_t firware setup. Woo.
+ */
+
+void *
+fw_get_init_data(void)
+{
+	return &__res;
+}
+
+
+/*
+ * Return the start of DRAM memory.
+ */
+unsigned long
+fw_get_memory_start(void)
+{
+#if defined(FW_BDT_HAS_MEMSTART)
+        return binfo->bi_memstart;
+#else
+	return 0;
+#endif
+}
+
+
+/*
+ * Return the amount of memory in bytes.
+ */
+unsigned long
+fw_get_memory_size(void)
+{
+#if defined(FW_BDT_HAS_MEMSIZE)
+        return binfo->bi_memsize;
+#else
+	return 0;
+#endif
+}
+
+
+/*
+ * Return the start of FLASH memory.
+ */
+unsigned long
+fw_get_flash_start(void)
+{
+#if defined(FW_BDT_HAS_FLASHSTART)
+        return binfo->bi_flashstart;
+#else
+	return 0;
+#endif
+}
+
+
+/*
+ * Return the amount of FLASH memory in bytes.
+ */
+unsigned long
+fw_get_flash_size(void)
+{
+#if defined(FW_BDT_HAS_FLASHSIZE)
+        return binfo->bi_flashsize;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_flash_offset(void)
+{
+#if defined(FW_BDT_HAS_FLASHOFFSET)
+        return binfo->bi_flashoffset;
+#else
+	return 0;
+#endif
+}
+
+
+/*
+ * Return the start of SRAM memory.
+ */
+unsigned long
+fw_get_sram_start(void)
+{
+#if defined(FW_BDT_HAS_SRAMSTART)
+        return binfo->bi_sramstart;
+#else
+	return 0;
+#endif
+}
+
+
+/*
+ * Return the amount of SRAM memory in bytes.
+ */
+unsigned long
+fw_get_sram_size(void)
+{
+#if defined(FW_BDT_HAS_SRAMSIZE)
+        return binfo->bi_sramsize;
+#else
+	return 0;
+#endif
+}
+
+
+/*
+ * Return the amount of NVRAM in bytes.
+ */
+unsigned long
+fw_get_nvram_size(void)
+{
+#if defined(FW_BDT_HAS_NVRAM_SIZE)
+        return binfo->bi_nvramsize;
+#else
+	return 0;
+#endif
+}
+
+
+
+/*
+ * Return the internal core frequency in MHz.
+ */
+unsigned long
+fw_get_intfreq(void)
+{
+#if defined(FW_BDT_HAS_INTFREQ)
+        return binfo->bi_intfreq;
+#else
+	return 0;
+#endif
+}
+
+
+/*
+ * Return the bus frequency in MHz.
+ */
+unsigned long
+fw_get_busfreq(void)
+{
+#if defined(FW_BDT_HAS_BUSFREQ)
+        return binfo->bi_busfreq;
+#else
+	return 0;
+#endif
+}
+
+
+/*
+ * Return the CPM frequency.
+ */
+unsigned long
+fw_get_cpmfreq(void)
+{
+#if defined(FW_BDT_HAS_CPMFREQ)
+        return binfo->bi_cpmfreq;
+#else
+	return 0;
+#endif
+}
+
+
+/*
+ * Return the BRG frequency.
+ */
+unsigned long
+fw_get_brgfreq(void)
+{
+#if defined(FW_BDT_HAS_BRGFREQ)
+        return binfo->bi_brgfreq;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_sccfreq(void)
+{
+#if defined(FW_BDT_HAS_SCCFREQ)
+        return binfo->bi_sccfreq;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_ipbfreq(void)
+{
+#if defined(FW_BDT_HAS_IPBFREQ)
+        return binfo->bi_ipbfreq;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_procfreq(void)
+{
+#if defined(FW_BDT_HAS_PROCFREQ)
+        return binfo->bi_procfreq;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_tbfreq(void)
+{
+#if defined(FW_BDT_HAS_TBFREQ)
+        return binfo->bi_tbfreq;
+#elif defined(FW_BDT_HAS_INTFREQ)
+	/* This should be the case for:
+	 *     ep405, Ash, Oak, Sycamore, Walnut, xilinx_ml300,
+	 *     bubinga, cpci405
+	 */
+        return binfo->bi_intfreq;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_opbfreq(void)
+{
+#if defined(FW_BDT_HAS_OPBFREQ)
+        return binfo->bi_opbfreq;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_opb_busfreq(void)
+{
+#if defined(FW_BDT_HAS_OPB_BUSFREQ)
+        return binfo->bi_opb_busfreq;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_pllouta_freq(void)
+{
+#if defined(FW_BDT_HAS_PLLOUTA_FREQ)
+        return binfo->bi_pllouta_freq;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_pcifreq(void)
+{
+#if defined(FW_BDT_HAS_PCIFREQ)
+        return binfo->bi_pcifreq;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_pci_busfreq(void)
+{
+#if defined(FW_BDT_HAS_PCI_BUSFREQ)
+        return binfo->bi_pci_busfreq;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_plb_busfreq(void)
+{
+#if defined(FW_BDT_HAS_PLB_BUSFREQ)
+        return binfo->bi_plb_busfreq;
+#else
+	return 0;
+#endif
+}
+
+
+/*
+ * Return the baudrate.
+ */
+unsigned long
+fw_get_baudrate(void)
+{
+#if defined(FW_BDT_HAS_BAUDRATE)
+	return binfo->bi_baudrate;
+#else
+	return 0;
+#endif
+}
+
+
+/*
+ * Return IMMR base address.
+ */
+unsigned long
+fw_get_immr_base(void)
+{
+#if defined(FW_BDT_HAS_IMMR_BASE)
+        return binfo->bi_immr_base;
+#else
+	return 0;
+#endif
+}
+
+
+/*
+ * Return the base address of a 6-element array of unsigned bytes
+ * that contains the MAC address of the given Ethernet device.
+ *
+ * which_one should be [0 .. num_of_ethaddrs), for some num_of_ethaddrs
+ *
+ *     0 == enetaddr  == enetaddr[0]
+ *     1 == enet1addr == enetaddr[1]
+ *     2 == enet2addr == enetaddr[2]
+ *     3 == enet3addr == enetaddr[3]
+ */
+
+unsigned char *
+fw_get_enetaddr(unsigned int which_one)
+{
+
+#if defined(FW_BDT_HAS_ENETADDR_A2) || defined(FW_BDT_HAS_ENETADDR_A4)
+	/* FIXME: Could check range 0 .. 1 or  0 .. 3 respectively */
+	return &binfo->bi_enetaddr[which_one][0];
+#else
+
+	if (which_one == 0) {
+
+#if defined(FW_BDT_HAS_ENETADDR)
+		return &binfo->bi_enetaddr[0];
+#endif
+
+#if defined(FW_BDT_HAS_ENET1ADDR)
+	} else if (which_one == 1) {
+		return &binfo->bi_enet1addr[0];
+#endif
+
+#if defined(FW_BDT_HAS_ENET2ADDR)
+	} else if (which_one == 2) {
+		return &binfo->bi_enet2addr[0];
+#endif
+
+#if defined(FW_BDT_HAS_ENET3ADDR)
+	} else if (which_one == 3) {
+		return &binfo->bi_enet3addr[0];
+#endif
+
+	}
+
+#endif
+
+	return 0;
+}
+
+
+unsigned char *
+fw_get_pci_enetaddr(void)
+{
+#if defined(FW_BDT_HAS_PCI_ENETADDR)
+        return binfo->bi_pci_enetaddr;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_ethspped(void)
+{
+#if defined(FW_BDT_HAS_ETHSPEED)
+	return binfo->bi_ethspeed;
+#else
+	return 0;
+#endif
+}
+
+
+char *
+fw_get_s_version(void)
+{
+#if defined(FW_BDT_HAS_S_VERSION)
+	return &binfo->bi_s_version[0];
+#else
+	return 0;
+#endif
+}
+
+
+char *
+fw_get_r_version(void)
+{
+#if defined(FW_BDT_HAS_R_VERSION)
+	return &binfo->bi_r_version[0];
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_bootflags(void)
+{
+#if defined(FW_BDT_HAS_BOOTFLAGS)
+	return binfo->bi_bootflags;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_ip_addr(void)
+{
+#if defined(FW_BDT_HAS_IP_ADDR)
+	return binfo->bi_ip_addr;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_vco(void)
+{
+#if defined(FW_BDT_HAS_VCO)
+	return binfo->bi_vco;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_tag(void)
+{
+#if defined(FW_BDT_HAS_TAG)
+	return binfo->bi_tag;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_size(void)
+{
+#if defined(FW_BDT_HAS_SIZE)
+	return binfo->bi_size;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_revision(void)
+{
+#if defined(FW_BDT_HAS_REVISION)
+	return binfo->bi_revision;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_bdate(void)
+{
+#if defined(FW_BDT_HAS_BDATE)
+	return binfo->bi_bdate;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_clun(void)
+{
+#if defined(FW_BDT_HAS_CLUN)
+	return binfo->bi_clun;
+#else
+	return 0;
+#endif
+}
+
+
+unsigned long
+fw_get_dlun(void)
+{
+#if defined(FW_BDT_HAS_DLUN)
+	return binfo->bi_dlun;
+#else
+	return 0;
+#endif
+}
+
+
+
+
+void
+fw_set_busfreq(unsigned long freq)
+{
+	binfo->bi_busfreq = freq;
+}
+
+void
+fw_set_intfreq(unsigned long freq)
+{
+	binfo->bi_intfreq = freq;
+}
+
+void
+fw_set_ipbfreq(unsigned long freq)
+{
+#if defined(FW_BDT_HAS_IPBFREQ)
+	binfo->bi_ipbfreq = freq;
+#endif
+}
+
+void
+fw_set_pcifreq(unsigned long freq)
+{
+#if defined(FW_BDT_HAS_PCIFREQ)
+	binfo->bi_pcifreq = freq;
+#endif
+}
Index: arch/ppc/syslib/fw_bdt.h
===================================================================
--- /dev/null  (tree:c7d7a187a2125518e655dfeadffd38156239ffc3)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/fw_bdt.h  (mode:100644)
@@ -0,0 +1,453 @@
+/*
+ * (C) Copyright 2000, 2001
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
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
+#ifndef __PPC_SYSLIB_FW_BDT_H__
+#define __PPC_SYSLIB_FW_BDT_H__
+
+/*
+ * Board information passed to kernel from U-Boot
+ */
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/*
+ * The following set of boards have special bd_info structures below.
+ * All other boards use the generic bd_info.
+ */
+#if    !defined(CONFIG_MBX) \
+    && !defined(CONFIG_RPXCLASSIC) \
+    && !defined(CONFIG_RPXLITE) \
+    && !defined(CONFIG_BSEIP) \
+    && !defined(CONFIG_SBS8260) \
+    && !defined(CONFIG_EST8260) \
+    && !defined(CONFIG_RPX8260) \
+    && !defined(CONFIG_EP405) \
+    && !defined(CONFIG_XILINX_ML300) \
+    && !defined(CONFIG_REDWOOD_5) \
+    && !defined(CONFIG_REDWOOD_6) \
+    && !defined(CONFIG_BUBINGA) \
+    && !defined(CONFIG_ASH) \
+    && !defined(CONFIG_OAK) \
+    && !defined(CONFIG_SYCAMORE) \
+    && !defined(CONFIG_WALNUT)
+
+
+/*
+ * The "generic" bd_info as originally defined in ppcboot.h
+ * and used by the majority of ppc32 boards.
+ */
+typedef struct bd_info {
+
+#define FW_BDT_HAS_MEMSTART
+#define FW_BDT_HAS_MEMSIZE
+#define FW_BDT_HAS_FLASHSTART
+#define FW_BDT_HAS_FLASHSIZE
+#define FW_BDT_HAS_FLASHOFFSET
+#define FW_BDT_HAS_SRAMSTART
+#define FW_BDT_HAS_SRAMSIZE
+	unsigned long	bi_memstart;	/* start of DRAM memory */
+	unsigned long	bi_memsize;	/* size	 of DRAM memory in bytes */
+	unsigned long	bi_flashstart;	/* start of FLASH memory */
+	unsigned long	bi_flashsize;	/* size	 of FLASH memory */
+	unsigned long	bi_flashoffset; /* reserved area for startup monitor */
+	unsigned long	bi_sramstart;	/* start of SRAM memory */
+	unsigned long	bi_sramsize;	/* size	 of SRAM memory */
+
+#if    defined(CONFIG_8xx) \
+    || defined(CONFIG_CPM2) \
+    || defined(CONFIG_85xx) \
+    || defined(CONFIG_83xx)
+#define FW_BDT_HAS_IMMR_BASE
+	unsigned long	bi_immr_base;	/* base of IMMR register */
+#endif
+
+#if defined(CONFIG_PPC_MPC52xx)
+#define FW_BDT_HAS_MBAR_BASE
+	unsigned long   bi_mbar_base;   /* base of internal registers */
+#endif
+
+#define FW_BDT_HAS_BOOTFLAGS
+#define FW_BDT_HAS_IP_ADDR
+#define FW_BDT_HAS_ENETADDR
+#define FW_BDT_HAS_ETHSPEED
+#define FW_BDT_HAS_INTFREQ
+#define FW_BDT_HAS_BUSFREQ
+	unsigned long	bi_bootflags;	/* boot / reboot flag (for LynxOS) */
+	unsigned long	bi_ip_addr;	/* IP Address */
+	unsigned char	bi_enetaddr[6];	/* Ethernet address */
+	unsigned short	bi_ethspeed;	/* Ethernet speed in Mbps */
+	unsigned long	bi_intfreq;	/* Internal Freq, in MHz */
+	unsigned long	bi_busfreq;	/* Bus Freq, in MHz */
+
+#if defined(CONFIG_CPM2)
+#define FW_BDT_HAS_CPMFREQ
+#define FW_BDT_HAS_BRGFREQ
+#define FW_BDT_HAS_SCCFREQ
+#define FW_BDT_HAS_VCO
+	unsigned long	bi_cpmfreq;	/* CPM_CLK Freq, in MHz */
+	unsigned long	bi_brgfreq;	/* BRG_CLK Freq, in MHz */
+	unsigned long	bi_sccfreq;	/* SCC_CLK Freq, in MHz */
+	unsigned long	bi_vco;		/* VCO Out from PLL, in MHz */
+#endif
+
+#if defined(CONFIG_PPC_MPC52xx)
+#define FW_BDT_HAS_IPBFREQ
+#define FW_BDT_HAS_PCIFREQ
+	unsigned long   bi_ipbfreq;     /* IPB Bus Freq, in MHz */
+	unsigned long   bi_pcifreq;     /* PCI Bus Freq, in MHz */
+#endif
+
+#define FW_BDT_HAS_BAUDRATE
+	unsigned long	bi_baudrate;	/* Console Baudrate */
+
+#if defined(CONFIG_4xx)
+#define FW_BDT_HAS_S_VERSION
+#define FW_BDT_HAS_R_VERSION
+#define FW_BDT_HAS_PROCFREQ
+#define FW_BDT_HAS_PLB_BUSFREQ
+#define FW_BDT_HAS_PCI_BUSFREQ
+#define FW_BDT_HAS_PCI_ENETADDR
+	unsigned char	bi_s_version[4];	/* Version of this structure */
+	unsigned char	bi_r_version[32];	/* Version of the ROM (IBM) */
+	unsigned int	bi_procfreq;	/* CPU (Internal) Freq, in Hz */
+	unsigned int	bi_plb_busfreq;	/* PLB Bus speed, in Hz */
+	unsigned int	bi_pci_busfreq;	/* PCI Bus speed, in Hz */
+	unsigned char	bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
+#endif
+
+#if defined(CONFIG_HYMOD)
+#define FW_BDT_HAS_HYMOD_CONF
+	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
+#endif
+
+#if    defined(CONFIG_EVB64260) \
+    || defined(CONFIG_44x) \
+    || defined(CONFIG_85xx) \
+    || defined(CONFIG_83xx)
+#define FW_BDT_HAS_ENET1ADDR
+	/* second onboard ethernet port */
+	unsigned char	bi_enet1addr[6];
+#endif
+
+#if    defined(CONFIG_EVB64260) \
+    || defined(CONFIG_440GX) \
+    || defined(CONFIG_85xx)
+#define FW_BDT_HAS_ENET2ADDR
+	/* third onboard ethernet ports */
+	unsigned char	bi_enet2addr[6];
+#endif
+
+#if defined(CONFIG_440GX)
+#define FW_BDT_HAS_ENET3ADDR
+	/* fourth onboard ethernet ports */
+	unsigned char	bi_enet3addr[6];
+#endif
+
+#if defined(CONFIG_4xx)
+#define FW_BDT_HAS_OBPFREQ
+#define FW_BDT_HAS_IIC_FAST
+	unsigned int	bi_opbfreq;		/* OB clock in Hz */
+	int		bi_iic_fast[2];		/* Use fast i2c mode */
+#endif
+
+#if defined(CONFIG_440GX)
+#define FW_BDT_HAS_PHYNUM
+#define FW_BDT_HAS_PHYMODE
+	int		bi_phynum[4];		/* phy mapping */
+	int		bi_phymode[4];		/* phy mode */
+#endif
+
+} bd_t;
+
+
+#else	/* non-generic bd_info declarations */
+
+
+#if defined(CONFIG_MBX)
+
+typedef struct bd_info {
+
+#define FW_BDT_HAS_TAG
+#define FW_BDT_HAS_SIZE
+#define FW_BDT_HAS_REVISION
+#define FW_BDT_HAS_BDATE
+#define FW_BDT_HAS_MEMSTART
+#define FW_BDT_HAS_MEMSIZE
+#define FW_BDT_HAS_INTFREQ
+#define FW_BDT_HAS_BUSFREQ
+#define FW_BDT_HAS_CLUN
+#define FW_BDT_HAS_DLUN
+	unsigned int	bi_tag;		/* Should be 0x42444944 "BDID" */
+	unsigned int	bi_size;	/* Size of this structure */
+	unsigned int	bi_revision;	/* revision of this structure */
+	unsigned int	bi_bdate;	/* EPPCbug date, i.e. 0x11061997 */
+	unsigned int	bi_memstart;	/* Memory start address */
+	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
+	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
+	unsigned int	bi_busfreq;	/* Bus Freq, in Hz */
+	unsigned int	bi_clun;	/* Boot device controller */
+	unsigned int	bi_dlun;	/* Boot device logical dev */
+
+	/* These fields are not part of the board information structure
+	 * provided by the boot rom.  They are filled in by embed_config.c
+	 * so we have the information consistent with other platforms.
+	 */
+#define FW_BDT_HAS_ENETADDR
+#define FW_BDT_HAS_BAUDRATE
+	unsigned char	bi_enetaddr[6];
+	unsigned int	bi_baudrate;
+} bd_t;
+#endif
+
+
+#if    defined(CONFIG_RPXCLASSIC) \
+    || defined(CONFIG_RPXLITE) \
+    || defined(CONFIG_BSEIP)
+
+typedef struct bd_info {
+
+#define FW_BDT_HAS_MEMSTART
+#define FW_BDT_HAS_MEMSIZE
+#define FW_BDT_HAS_INTFREQ
+#define FW_BDT_HAS_BUSFREQ
+#define FW_BDT_HAS_ENETADDR
+#define FW_BDT_HAS_BAUDRATE
+	unsigned int	bi_memstart;	/* Memory start address */
+	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
+	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
+	unsigned int	bi_busfreq;	/* Bus Freq, in Hz */
+	unsigned char	bi_enetaddr[6];
+	unsigned int	bi_baudrate;
+} bd_t;
+#endif
+
+
+#if    defined(CONFIG_SBS8260) \
+    || defined(CONFIG_EST8260) \
+    || defined(CONFIG_RPX8260)
+
+typedef struct bd_info {
+
+#define FW_BDT_HAS_MEMSTART
+#define FW_BDT_HAS_MEMSIZE
+	unsigned int	bi_memstart;	/* Memory start address */
+	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
+
+#if defined(CONFIG_RPX8260)
+#define FW_BDT_HAS_NVRAMSIZE
+	unsigned int	bi_nvramsize;	/* NVRAM size in bytes (can be 0) */
+#endif
+
+#define FW_BDT_HAS_INTFREQ
+#define FW_BDT_HAS_BUSFREQ
+#define FW_BDT_HAS_CPMFREQ
+#define FW_BDT_HAS_BRGFREQ
+#define FW_BDT_HAS_VCO
+#define FW_BDT_HAS_BAUDRATE
+#define FW_BDT_HAS_IMMR_BASE
+#define FW_BDT_HAS_ENETADDR
+	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
+	unsigned int	bi_busfreq;	/* Bus Freq, in MHz */
+	unsigned int	bi_cpmfreq;	/* CPM Freq, in MHz */
+	unsigned int	bi_brgfreq;	/* BRG Freq, in MHz */
+	unsigned int	bi_vco;		/* VCO Out from PLL */
+	unsigned int	bi_baudrate;	/* Default console baud rate */
+	unsigned int	bi_immr_base;	/* IMMR when called from boot rom */
+	unsigned char	bi_enetaddr[6];
+} bd_t;
+#endif
+
+
+#if    defined(CONFIG_EP405) \
+    || defined(CONFIG_XILINX_ML300)
+
+typedef struct bd_info {
+
+#define FW_BDT_HAS_MEMSIZE
+#define FW_BDT_HAS_ENETADDR
+#define FW_BDT_HAS_INTFREQ
+#define FW_BDT_HAS_BUSFREQ
+#define FW_BDT_HAS_PCI_BUSFREQ
+	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
+	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address*/
+	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
+	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
+	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
+
+#if defined(CONFIG_EP405)
+#define FW_BDT_HAS_NVRAMSIZE
+	unsigned int	 bi_nvramsize;		/* Size of the NVRAM/RTC */
+#endif
+
+} bd_t;
+#endif
+
+
+#if    defined(CONFIG_REDWOOD_5) \
+    || defined(CONFIG_REDWOOD_6)
+
+typedef struct bd_info {
+
+#define FW_BDT_HAS_S_VERSION
+#define FW_BDT_HAS_R_VERSION
+#define FW_BDT_HAS_MEMSIZE
+#define FW_BDT_HAS_ENETADDR
+#define FW_BDT_HAS_INTFREQ
+#define FW_BDT_HAS_BUSFREQ
+#define FW_BDT_HAS_TBFREQ
+	unsigned char	bi_s_version[4];	/* Version of this structure */
+	unsigned char	bi_r_version[30];	/* Version of the IBM ROM */
+	unsigned int	bi_memsize;		/* DRAM installed, in bytes */
+	unsigned int	bi_dummy;		/* field shouldn't exist */
+	unsigned char	bi_enetaddr[6];		/* Ethernet MAC address */
+	unsigned int	bi_intfreq;		/* Processor speed, in Hz */
+	unsigned int	bi_busfreq;		/* Bus speed, in Hz */
+	unsigned int	bi_tbfreq;		/* Software timebase freq */
+} bd_t;
+#endif
+
+
+#if defined(CONFIG_BUBINGA)
+
+typedef struct bd_info {
+
+#define FW_BDT_HAS_S_VERSION
+#define FW_BDT_HAS_R_VERSION
+#define FW_BDT_HAS_MEMSIZE
+#define FW_BDT_HAS_ENETADDR_A2
+#define FW_BDT_HAS_PCI_ENETADDR
+#define FW_BDT_HAS_INTFREQ
+#define FW_BDT_HAS_BUSFREQ
+#define FW_BDT_HAS_PCI_BUSFREQ
+#define FW_BDT_HAS_OPB_BUSFREQ
+#define FW_BDT_HAS_PLLOUTA_FREQ
+        unsigned char    bi_s_version[4];       /* Version of this structure */
+        unsigned char    bi_r_version[30];      /* Version of the IBM ROM */
+        unsigned int     bi_memsize;            /* DRAM installed, in bytes */
+        unsigned char    bi_enetaddr[2][6];     /* Local Ethernet MAC address*/
+        unsigned char    bi_pci_enetaddr[6];    /* PCI Ethernet MAC address */
+        unsigned int     bi_intfreq;            /* Processor speed, in Hz */
+        unsigned int     bi_busfreq;            /* PLB Bus speed, in Hz */
+        unsigned int     bi_pci_busfreq;        /* PCI Bus speed, in Hz */
+        unsigned int     bi_opb_busfreq;        /* OPB Bus speed, in Hz */
+        unsigned int     bi_pllouta_freq;       /* PLL OUTA speed, in Hz */
+} bd_t;
+#endif
+
+
+#if defined(CONFIG_ASH)
+
+typedef struct bd_info {
+
+#define FW_BDT_HAS_S_VERSION
+#define FW_BDT_HAS_R_VERSION
+#define FW_BDT_HAS_MEMSIZE
+#define FW_BDT_HAS_ENETADDR_A4
+#define FW_BDT_HAS_PCI_ENETADDR
+#define FW_BDT_HAS_INTFREQ
+#define FW_BDT_HAS_BUSFREQ
+#define FW_BDT_HAS_PCI_BUSFREQ
+	unsigned char	 bi_s_version[4];	/* Version of this structure */
+	unsigned char	 bi_r_version[30];	/* Version of the IBM ROM */
+	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
+	unsigned char	 bi_enetaddr[4][6];	/* Local Ethernet MAC address*/
+	unsigned char	 bi_pci_enetaddr[6];
+	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
+	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
+	unsigned int	 bi_pci_busfreq;	/* PCI speed in Hz */
+} bd_t;
+#endif
+
+
+#if defined(CONFIG_OAK)
+
+typedef struct bd_info {
+
+#define FW_BDT_HAS_S_VERSION
+#define FW_BDT_HAS_R_VERSION
+#define FW_BDT_HAS_MEMSIZE
+#define FW_BDT_HAS_ENETADDR
+#define FW_BDT_HAS_INTFREQ
+#define FW_BDT_HAS_BUSFREQ
+	unsigned char	 bi_s_version[4];	/* Version of this structure */
+	unsigned char	 bi_r_version[30];	/* Version of the IBM ROM */
+	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
+	unsigned char	 bi_enetaddr[6];	/* Ethernet MAC address */
+	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
+	unsigned int	 bi_busfreq;		/* Bus speed, in Hz */
+} bd_t;
+#endif
+
+
+#if defined(CONFIG_SYCAMORE)
+
+typedef struct bd_info {
+
+#define FW_BDT_HAS_S_VERSION
+#define FW_BDT_HAS_R_VERSION
+#define FW_BDT_HAS_MEMSIZE
+#define FW_BDT_HAS_ENETADDR
+#define FW_BDT_HAS_PCI_ENETADDR
+#define FW_BDT_HAS_INTFREQ
+#define FW_BDT_HAS_BUSFREQ
+#define FW_BDT_HAS_PCI_BUSFREQ
+	unsigned char	 bi_s_version[4];	/* Version of this structure */
+	unsigned char	 bi_r_version[30];	/* Version of the IBM ROM */
+	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
+	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address*/
+	unsigned char	 bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
+	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
+	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
+	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
+} bd_t;
+#endif
+
+
+#if defined(CONFIG_WALNUT)
+
+typedef struct bd_info {
+
+#define FW_BDT_HAS_S_VERSION
+#define FW_BDT_HAS_R_VERSION
+#define FW_BDT_HAS_MEMSIZE
+#define FW_BDT_HAS_ENETADDR
+#define FW_BDT_HAS_PCI_ENETADDR
+#define FW_BDT_HAS_INTFREQ
+#define FW_BDT_HAS_BUSFREQ
+#define FW_BDT_HAS_PCI_BUSFREQ
+	unsigned char	 bi_s_version[4];	/* Version of this structure */
+	unsigned char	 bi_r_version[30];	/* Version of the IBM ROM */
+	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
+	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address*/
+	unsigned char	 bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
+	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
+	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
+	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
+} bd_t;
+#endif
+
+#endif	/* non-generic bd_info structures */
+
+
+#endif /* __ASSEMBLY__ */
+#endif	/* __PPC_SYSLIB_FW_BDT_H__ */
+
Index: arch/ppc/syslib/Makefile
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/syslib/Makefile  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/Makefile  (mode:100644)
@@ -113,3 +113,7 @@
 ifeq ($(CONFIG_PPC_MPC52xx),y)
 obj-$(CONFIG_PCI)		+= mpc52xx_pci.o
 endif
+
+obj-$(CONFIG_FW_BDT)		+= fw_bdt.o
+obj-$(CONFIG_FW_OF)		+= fw_of.o
+
Index: include/asm-ppc/firmware.h
===================================================================
--- /dev/null  (tree:c7d7a187a2125518e655dfeadffd38156239ffc3)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/include/asm-ppc/firmware.h  (mode:100644)
@@ -0,0 +1,62 @@
+/*
+ * include/asm-ppc/firmware.h
+ *
+ * Provide an abstract interface to firmware information
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+
+void __init fw_initialize(unsigned long r3);
+unsigned long fw_get_memory_size(void);
+unsigned long fw_get_memory_start(void);
+unsigned long fw_get_flash_size(void);
+unsigned long fw_get_flash_start(void);
+unsigned long fw_get_flash_offset(void);
+unsigned long fw_get_sram_start(void);
+unsigned long fw_get_sram_size(void);
+unsigned long fw_get_nvram_size(void);
+
+unsigned long fw_get_intfreq(void);
+unsigned long fw_get_busfreq(void);
+unsigned long fw_get_cpmfreq(void);
+unsigned long fw_get_brgfreq(void);
+unsigned long fw_get_sccfreq(void);
+unsigned long fw_get_ipbfreq(void);
+unsigned long fw_get_procfreq(void);
+unsigned long fw_get_tbfreq(void);
+unsigned long fw_get_opbfreq(void);
+unsigned long fw_get_opb_busfreq(void);
+unsigned long fw_get_pllouta_freq(void);
+unsigned long fw_get_pcifreq(void);
+unsigned long fw_get_pci_busfreq(void);
+unsigned long fw_get_plb_busfreq(void);
+unsigned long fw_get_baudrate(void);
+unsigned long fw_get_immr_base(void);
+unsigned char *fw_get_enetaddr(unsigned int which_one);
+unsigned char *fw_get_pci_enetaddr(void);
+unsigned long fw_get_ethspped(void);
+char *fw_get_s_version(void);
+char *fw_get_r_version(void);
+unsigned long fw_get_bootflags(void);
+unsigned long fw_get_ip_addr(void);
+unsigned long fw_get_vco(void);
+
+void *fw_get_init_data(void);
+
+void fw_set_busfreq(unsigned long freq);
+void fw_set_intfreq(unsigned long freq);
+void fw_set_ipbfreq(unsigned long freq);
+void fw_set_pcifreq(unsigned long freq);
+
+#endif /* __KERNEL__ */
Index: arch/ppc/kernel/ppc_ksyms.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/kernel/ppc_ksyms.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/kernel/ppc_ksyms.c  (mode:100644)
@@ -319,10 +319,6 @@
 EXPORT_SYMBOL(cpm_install_handler);
 EXPORT_SYMBOL(cpm_free_handler);
 #endif /* CONFIG_8xx */
-#if defined(CONFIG_8xx) || defined(CONFIG_40x) || defined(CONFIG_85xx) ||\
-	defined(CONFIG_83xx)
-EXPORT_SYMBOL(__res);
-#endif
 
 EXPORT_SYMBOL(next_mmu_context);
 EXPORT_SYMBOL(set_context);

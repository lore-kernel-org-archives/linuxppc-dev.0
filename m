Message-Id: <5.2.1.1.2.20030910174452.02767580@192.168.1.10>
Date: Wed, 10 Sep 2003 17:50:59 -0700
To: PPC Embedded <linuxppc-embedded@lists.linuxppc.org>
From: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>(by way of Allen Curtis <acurtis@onz.com>)
Subject: MPC8266ADS patch
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here is a patch to make MPC8266ADS its own platform. Instead of creating a
new platforms/ads8266.h header, I could have inserted conditional compiles
into the ads8260.h for the memory map differences.

Note: This is enough to get the kernel to build, boot and run. There are
other issues that still need to be addressed.

Thanks


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1380  -> 1.1381
#	arch/ppc/platforms/Makefile	1.45    -> 1.46
#	  arch/ppc/config.in	1.206   -> 1.207
#	arch/ppc/boot/simple/embed_config.c	1.33    -> 1.34
#	arch/ppc/boot/simple/m8260_tty.c	1.3     -> 1.4
#	include/asm-ppc/mpc8260.h	1.17    -> 1.18
#	               (new)	        -> 1.1
arch/ppc/platforms/ads8266.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/09	curtisa@irvsoftws21.devdom.local
<mailto:curtisa@irvsoftws21.devdom.local> 	1.1381
# Fixed MPC8266ADS platform configuration and build
# --------------------------------------------
#
diff -Nru a/arch/ppc/boot/simple/embed_config.c
b/arch/ppc/boot/simple/embed_config.c
--- a/arch/ppc/boot/simple/embed_config.c	Tue Sep  9 16:43:58 2003
+++ b/arch/ppc/boot/simple/embed_config.c	Tue Sep  9 16:43:58 2003
@@ -616,7 +616,7 @@
  }
#endif /* RPX6 for testing */
*	#ifdef CONFIG_ADS8260
		+#if defined(CONFIG_ADS8260) || defined(CONFIG_ADS8266)
		void
		embed_config(bd_t **bdp)
	{
	diff -Nru a/arch/ppc/boot/simple/m8260_tty.c
b/arch/ppc/boot/simple/m8260_tty.c
	--- a/arch/ppc/boot/simple/m8260_tty.c	Tue Sep  9 16:43:58 2003
	+++ b/arch/ppc/boot/simple/m8260_tty.c	Tue Sep  9 16:43:58 2003
	@@ -46,7 +46,7 @@
		*/
		while (cp->cp_cpcr & CPM_CR_FLG);
*	#ifdef CONFIG_ADS8260
	+#if defined(CONFIG_ADS8260) || defined(CONFIG_ADS8266)
		/* Enable the RS-232 transceivers.
		*/
		*(volatile uint *)(BCSR_ADDR + 4) &=
	diff -Nru a/arch/ppc/config.in b/arch/ppc/config.in
	--- a/arch/ppc/config.in	Tue Sep  9 16:43:58 2003
	+++ b/arch/ppc/config.in	Tue Sep  9 16:43:58 2003
	@@ -61,6 +61,7 @@
		define_bool CONFIG_SERIAL_CONSOLE y
	   choice 'Machine Type'	\
		"ADS8260	CONFIG_ADS8260	\
*	ADS8266	CONFIG_ADS8266	\
  	EST8260	CONFIG_EST8260	\
  	SBS8260	CONFIG_SBS8260	\
  	RPXSUPER	CONFIG_RPX6	\
diff -Nru a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
--- a/arch/ppc/platforms/Makefile	Tue Sep  9 16:43:58 2003
+++ b/arch/ppc/platforms/Makefile	Tue Sep  9 16:43:58 2003
@@ -64,7 +64,7 @@
ifeq ($(CONFIG_8260),y)
obj-$(CONFIG_PCI)		+= mpc8260_pci9.o
endif
*	ifeq ($(CONFIG_ADS8260),y)
+ifeq ($(CONFIG_ADS8266),y)
obj-$(CONFIG_PCI)		+= mpc8266ads_pci.o
endif
obj-$(CONFIG_ALL_PPC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
diff -Nru a/arch/ppc/platforms/ads8266.h b/arch/ppc/platforms/ads8266.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/platforms/ads8266.h	Tue Sep  9 16:43:58 2003
@@ -0,0 +1,87 @@
+
+/*
+ * A collection of structures, addresses, and values associated with + *
the Motorola MPC8266ADS-PCI board.
+ * Copied from the RPX-Classic and SBS8260 stuff.
+ *
+ * Copyright © 2001 Dan Malek (dan@mvista.com <mailto:dan@mvista.com> )
+ */
+#ifdef __KERNEL__
+#ifndef __MACH_ADS8266_DEFS
+#define __MACH_ADS8266_DEFS
+
+#include <linux/config.h>
+
+#include <asm/ppcboot.h>
+
+/* Memory map is configured by the PROM startup.
+ * We just map a few things we need.  The CSR is actually 4 byte-wide + *
registers that can be accessed as 8-, 16-, or 32-bit values.
+ */
+#define IMAP_ADDR		((uint)0xf0000000)
+#define BCSR_ADDR		((uint)0x04500000)
+#define BCSR_SIZE		((uint)(32 * 1024))
+
+/* The ADS8260 has 16, 32-bit wide control/status registers, accessed + *
only on word boundaries.
+ * Not all are used (yet), or are interesting to us (yet).
+ */
+
+/* Things of interest in the CSR.
+*/
+#define BCSR1_FETHIEN		((uint)0x08000000)	/* 0 == enable */
+#define BCSR1_FETH_RST		((uint)0x04000000)	/* 0 == reset */
+#define BCSR1_RS232_EN1		((uint)0x02000000)	/* 0 ==
enable */
+#define BCSR1_RS232_EN2		((uint)0x01000000)	/* 0 ==
enable */
+
+#define PHY_INTERRUPT	SIU_INT_IRQ7
+
+#ifdef CONFIG_PCI
+/* PCI interrupt controller */
+#define PCI_INT_STAT_REG	0x04730000
+#define PCI_INT_MASK_REG	0x04730004
+#define PIRQA			(NR_SIU_INTS + 0)
+#define PIRQB			(NR_SIU_INTS + 1)
+#define PIRQC			(NR_SIU_INTS + 2)
+#define PIRQD			(NR_SIU_INTS + 3)
+
+/*
+ * PCI memory map definitions for MPC8266ADS-PCI.
+ *
+ * processor view
+ *	local address		PCI address		target
+ *	0x80000000-0x9FFFFFFF	0x80000000-0x9FFFFFFF	PCI mem with
prefetch
+ *	0xA0000000-0xBFFFFFFF	0xA0000000-0xBFFFFFFF	PCI mem w/o prefetch
+ *	0xF4000000-0xF7FFFFFF	0x00000000-0x03FFFFFF	PCI IO
+ *
+ * PCI master view
+ *	local address		PCI address		target
+ *	0x00000000-0x1FFFFFFF	0x00000000-0x1FFFFFFF	MPC8266 local memory
+ */
+
+/* window for a PCI master to access MPC8266 memory */
+#define PCI_SLV_MEM_LOCAL	0x00000000	/* Local base */
+#define PCI_SLV_MEM_BUS		0x00000000	/* PCI base */
+
+/* window for the processor to access PCI memory with prefetching */
+#define PCI_MSTR_MEM_LOCAL	0x80000000	/* Local base */
+#define PCI_MSTR_MEM_BUS	0x80000000	/* PCI base   */
+#define PCI_MSTR_MEM_SIZE	0x20000000	/* 512MB */
+
+/* window for the processor to access PCI memory without prefetching */
+#define PCI_MSTR_MEMIO_LOCAL	0xA0000000	/* Local base */
+#define PCI_MSTR_MEMIO_BUS	0xA0000000	/* PCI base   */
+#define PCI_MSTR_MEMIO_SIZE	0x20000000	/* 512MB */
+
+/* window for the processor to access PCI I/O */
+#define PCI_MSTR_IO_LOCAL	0xF4000000	/* Local base */
+#define PCI_MSTR_IO_BUS         0x00000000	/* PCI base   */
+#define PCI_MSTR_IO_SIZE        0x04000000	/* 64MB */
+
+#define _IO_BASE		PCI_MSTR_IO_LOCAL
+#define _ISA_MEM_BASE		PCI_MSTR_MEMIO_LOCAL
+#define PCI_DRAM_OFFSET		PCI_SLV_MEM_BUS
+#endif /* CONFIG_PCI */
+
+#endif /* __MACH_ADS8266_DEFS */
+#endif /* __KERNEL__ */
diff -Nru a/include/asm-ppc/mpc8260.h b/include/asm-ppc/mpc8260.h
--- a/include/asm-ppc/mpc8260.h	Tue Sep  9 16:43:58 2003
+++ b/include/asm-ppc/mpc8260.h	Tue Sep  9 16:43:58 2003
@@ -28,6 +28,10 @@
#include <platforms/ads8260.h>
#endif

+#ifdef CONFIG_ADS8266
+#include <platforms/ads8266.h>
+#endif
+
#ifdef CONFIG_WILLOW
#include <platforms/willow.h>
#endif


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

To: Matt Porter <porter@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Ebony crash fix & 440GP cleanup step one
From: Roland Dreier <roland@topspin.com>
Date: 28 May 2002 15:04:22 -0700
In-Reply-To: <20020524134731.A21503@home.com>
Message-ID: <523cwcudy1.fsf_-_@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This email includes two patches.  First, a very small change to
ocp.h.  Somewhere in the recent cleanup, paddr got changed from a
phys_addr_t to a void *; this doesn't work on 440GP because we have
36-bit physical addresses.  (You get a machine check when the kernel
tries to access the ZMII)

Second, the beginning of moving generic IBM 440GP stuff out of
ebony.c/ebony.h and into platforms/ibm440gp.h.  I tested this on my
Ebony and it boots and runs fine.  I didn't go too far because I want
to make sure everyone feels what I'm doing is the right way to go.
Please let me know what you think.

Best,
Roland

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1039  -> 1.1040
#	include/asm-ppc/ocp.h	1.16    -> 1.17
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/28	roland@gold.topspincom.com	1.1040
# Fix paddr in ocp.h
# --------------------------------------------
#
diff -Nru a/include/asm-ppc/ocp.h b/include/asm-ppc/ocp.h
--- a/include/asm-ppc/ocp.h	Tue May 28 14:57:19 2002
+++ b/include/asm-ppc/ocp.h	Tue May 28 14:57:19 2002
@@ -117,7 +117,7 @@
 	char name[16];
 	u16 num;
 	enum ocp_type type;	/* OCP devive type */
-	void *paddr;
+        phys_addr_t paddr;
 	void *vaddr;
 	u32 flags;
 	struct irq_resources irq_resource[MAX_EMACS][OCP_MAX_IRQS];


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1025  -> 1.1025.1.1
#	include/asm-ppc/ibm4xx.h	1.15    -> 1.16
#	include/asm-ppc/ibm440.h	1.8     -> 1.9
#	arch/ppc/platforms/ebony.h	1.8     -> 1.9
#	arch/ppc/platforms/ibm440gp.c	1.11    -> 1.12
#	arch/ppc/platforms/ebony.c	1.9     -> 1.10
#	               (new)	        -> 1.2     arch/ppc/platforms/ibm440gp.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/27	dgibson@zax.zax	1.1026
# Change OCP ENET driver to use the proper PCI_DMA_* direction constants
# as arguments to consistent_sync(), instead of defining its own.  TODO:
# change consistent_sync() and/or other code to remove the need for the
# PCI constants.
# --------------------------------------------
# 02/05/27	trini@bill-the-cat.bloom.county	1.1027
# Minor 4xx serial fixups from Scott Anderson <scott_anderson@mvista.com>.
# --------------------------------------------
# 02/05/27	trini@bill-the-cat.bloom.county	1.1028
# We don't really want to be using PCI_DMA_* directional constants for consistent_sync() since it is not necessarily PCI.
# Cset exclude: dgibson@zax.zax|ChangeSet|20020527053847|07881
# --------------------------------------------
# 02/05/27	trini@bill-the-cat.bloom.county	1.1029
# Convert IBM OCP IDE to use the DMA_* directional constants.
# --------------------------------------------
# 02/05/27	trini@bill-the-cat.bloom.county	1.1030
# Odd.  bk didn't fix this in the cset -x.  Bring back include/asm-ppc/ocp-dma.h
# --------------------------------------------
# 02/05/27	trini@bill-the-cat.bloom.county	1.1031
# Well, that's what I get for not reading my email before working.. Backout my last changes.
# Cset exclude: trini@bill-the-cat.bloom.county|ChangeSet|20020527160528|10008
# Cset exclude: trini@bill-the-cat.bloom.county|ChangeSet|20020527160119|11671
# Cset exclude: trini@bill-the-cat.bloom.county|ChangeSet|20020527155917|11666
# --------------------------------------------
# 02/05/27	trini@bill-the-cat.bloom.county	1.1032
# ...and bk didn't catch the re-deletion again either.  Larry, are you
# snooping this? :)
# --------------------------------------------
# 02/05/27	trini@opus.bloom.county	1.118.1.516
# Critical fix from Paul (from linux-kernel):
# The patch below fixes two bugs in the PPC code.  The first bug was
# caused by an exception table entry pointing to the wrong instruction.
# As a result of this bug, a copy_to_user() with an unmapped or
# inaccessible destination address could cause an oops.  The second bug
# was that clear_user on PPC was returning -EFAULT rather than the
# number of bytes not cleared.
#
# Thanks to Rusty Russell for demonstrating the existence of these bugs
# with his test-read.c program.
# --------------------------------------------
# 02/05/27	trini@bill-the-cat.bloom.county	1.1033
# Merge in recent linuxppc_2_4 changes.
# --------------------------------------------
# 02/05/27	trini@bill-the-cat.bloom.county	1.1034
# Actually remove the right file.  It'd be nice if cset -x did this right
# to start with...
# --------------------------------------------
# 02/05/28	trini@opus.bloom.county	1.1035
# Add support for the Davicom DM9131 PHY to the 8260 FCC driver.  From
# Murray Jensen <Murray.Jensen@csiro.au>
# --------------------------------------------
# 02/05/28	trini@opus.bloom.county	1.1036
# Better describe (and modify slightly) how we come up with 3 ethernet
# addresses from 1 in the 8260 FCC enet driver.  From
# Murray Jensen <Murray.Jensen@csiro.au>
# --------------------------------------------
# 02/05/28	trini@bill-the-cat.bloom.county	1.1037
# Lots of OCP updates from Armin:
# Rename functions to <class>_<action>_<object>.
# Change ocp_driver to ocp_dev.
# Added type_info struct for the name/desc.
# --------------------------------------------
# 02/05/28	trini@bill-the-cat.bloom.county	1.1038
# Add in OCP documentation, from Armin.
# --------------------------------------------
# 02/05/28	roland@gold.topspincom.com	1.1025.1.1
# Begin reorganization of IBM 440GP code out of Ebony-specific files.
# --------------------------------------------
#
diff -Nru a/arch/ppc/platforms/ebony.c b/arch/ppc/platforms/ebony.c
--- a/arch/ppc/platforms/ebony.c	Tue May 28 14:57:14 2002
+++ b/arch/ppc/platforms/ebony.c	Tue May 28 14:57:14 2002
@@ -44,15 +44,8 @@
 #endif /* CONFIG_PPC_RTC */
 #include <asm/bootinfo.h>
 #include <asm/ppc4xx_pic.h>
-#include <asm/ocp.h>
-
-#include <platforms/ibm_ocp.h>
-#include <platforms/ebony.h>

 extern void abort(void);
-extern struct emac_regs *EMAC_ADDR[];
-extern struct zmii_regs *ZMII_ADDR[];
-extern struct ocp_def core_ocp[];

 /* Global Variables */
 unsigned char __res[sizeof (bd_t)];
@@ -208,8 +201,6 @@
 	ppc_md.pci_map_irq = ebony_map_irq;
 }

-extern char cmd_line[];
-
 #ifdef CONFIG_PPC_RTC
 TODC_ALLOC();
 #endif /* CONFIG_PPC_RTC */
@@ -234,16 +225,6 @@
 			ioremap64(EBONY_RTC_ADDR, EBONY_RTC_SIZE),
 			8);
 #endif /* CONFIG_PPC_RTC */
-
-	/* Setup EMAC access */
-	EMAC_ADDR[0] = (struct emac_regs *)
-		ioremap64(EBONY_EMAC0_ADDR, EBONY_EMAC_SIZE);
-	EMAC_ADDR[1] = (struct emac_regs *)
-		ioremap64(EBONY_EMAC1_ADDR, EBONY_EMAC_SIZE);
-
-	/* Setup ZMII access */
-	ZMII_ADDR[0] = (struct zmii_regs *)
-		ioremap64(EBONY_ZMII_ADDR, EBONY_ZMII_SIZE);

 	/* init to some ~sane value until calibrate_delay() runs */
         loops_per_jiffy = 50000000/HZ;
diff -Nru a/arch/ppc/platforms/ebony.h b/arch/ppc/platforms/ebony.h
--- a/arch/ppc/platforms/ebony.h	Tue May 28 14:57:14 2002
+++ b/arch/ppc/platforms/ebony.h	Tue May 28 14:57:14 2002
@@ -21,7 +21,7 @@
 #define __ASM_EBONY_H__

 #include <linux/config.h>
-#include <asm/ibm440.h>
+#include <platforms/ibm440gp.h>

 /* F/W TLB mapping used in bootloader glue to reset EMAC */
 #define EBONY_EMAC0_MR0		0xE0000800
@@ -37,23 +37,6 @@
 /* Default clock rates for Rev. B and Rev. C silicon */
 #define EBONY_440GP_RB_SYSCLK	33000000
 #define EBONY_440GP_RC_SYSCLK	400000000
-
-/* EMAC location */
-#define EBONY_EMAC0_ADDR	0x0000000140000800
-#define EBONY_EMAC1_ADDR	0x0000000140000900
-#define EBONY_EMAC_SIZE		0x70
-
-/* ZMII location */
-#define EBONY_ZMII_ADDR		0x0000000140000780
-#define EBONY_ZMII_SIZE		0x0c
-
-/* I2C location */
-#define EBONY_IIC0_ADDR		0x40000400
-#define EBONY_IIC1_ADDR		0x40000500
-
-/* RTC/NVRAM location */
-#define EBONY_RTC_ADDR		0x0000000148000000
-#define EBONY_RTC_SIZE		0x2000

 /*
  * Serial port defines
diff -Nru a/arch/ppc/platforms/ibm440gp.c b/arch/ppc/platforms/ibm440gp.c
--- a/arch/ppc/platforms/ibm440gp.c	Tue May 28 14:57:14 2002
+++ b/arch/ppc/platforms/ibm440gp.c	Tue May 28 14:57:14 2002
@@ -61,23 +61,21 @@
 struct ocp_def core_ocp[] = {
 	{UART, UART0_IO_BASE, UART0_INT},
 	{UART, UART1_IO_BASE, UART1_INT},
-	{IIC, EBONY_IIC0_ADDR, IIC0_IRQ},
-	{IIC, EBONY_IIC1_ADDR, IIC1_IRQ},
+	{IIC, PPC440GP_IIC0_ADDR, IIC0_IRQ},
+	{IIC, PPC440GP_IIC1_ADDR, IIC1_IRQ},
 #if 0 /* FIXME: Undefined */
 	{GPIO, GPIO0_BASE, OCP_IRQ_NA},
 	{PCI, PCI0_BASE, OCP_IRQ_NA},
 	{OPB, OPB0_BASE, OCP_IRQ_NA},
 #endif
-	{EMAC, EBONY_EMAC0_ADDR, OCP_IRQ_NA},
-	{EMAC, EBONY_EMAC1_ADDR, OCP_IRQ_NA},
-	{ZMII, EBONY_ZMII_ADDR, OCP_IRQ_NA},
+	{EMAC, PPC440GP_EMAC0_ADDR, OCP_IRQ_NA},
+	{EMAC, PPC440GP_EMAC1_ADDR, OCP_IRQ_NA},
+	{ZMII, PPC440GP_ZMII_ADDR, OCP_IRQ_NA},
 	{OCP_NULL_TYPE, 0x0, OCP_IRQ_NA},

 };

-struct emac_regs *EMAC_ADDR[EMAC_NUMS];
-struct zmii_regs *ZMII_ADDR[ZMII_NUMS];
 struct iic_regs *IIC_ADDR[] = {
-	(struct iic_regs *) EBONY_IIC0_ADDR,
-	(struct iic_regs *) EBONY_IIC1_ADDR
+	(struct iic_regs *) PPC440GP_IIC0_ADDR,
+	(struct iic_regs *) PPC440GP_IIC1_ADDR
 };
diff -Nru a/arch/ppc/platforms/ibm440gp.h b/arch/ppc/platforms/ibm440gp.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/platforms/ibm440gp.h	Tue May 28 14:57:14 2002
@@ -0,0 +1,58 @@
+/*
+ * arch/ppc/platforms/ibm440gp.h
+ *
+ * PPC440GP definitions
+ *
+ * Roland Dreier <roland@digitalvampire.org>
+ *
+ * Copyright 2002 Roland Dreier
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This file contains code that was originally in the files ibm440.h
+ * and ebony.h, which were written by Matt Porter of MontaVista Software Inc.
+ *
+ */
+
+#ifdef __KERNEL__
+#ifndef __PPC_PLATFORMS_IBM440GP_H
+#define __PPC_PLATFORMS_IBM440GP_H
+
+#include <linux/config.h>
+
+#define EMAC_NUMS		2
+#define UART_NUMS		2
+#define ZMII_NUMS		1
+#define IIC_NUMS		2
+#define IIC0_IRQ		2
+#define IIC1_IRQ		3
+
+/* EMAC location */
+#define PPC440GP_EMAC0_ADDR	0x0000000140000800
+#define PPC440GP_EMAC1_ADDR	0x0000000140000900
+#define PPC440GP_EMAC_SIZE	0x70
+
+/* ZMII location */
+#define PPC440GP_ZMII_ADDR	0x0000000140000780
+#define PPC440GP_ZMII_SIZE	0x0c
+
+/* I2C location */
+#define PPC440GP_IIC0_ADDR	0x40000400
+#define PPC440GP_IIC1_ADDR	0x40000500
+
+/* RTC/NVRAM location */
+#define PPC440GP_RTC_ADDR	0x0000000148000000
+#define PPC440GP_RTC_SIZE	0x2000
+
+/*
+ * Serial port defines
+ */
+#define RS_TABLE_SIZE	2
+
+#include <asm/ibm440.h>
+
+#endif /* __PPC_PLATFORMS_IBM440GP_H */
+#endif /* __KERNEL__ */
diff -Nru a/include/asm-ppc/ibm440.h b/include/asm-ppc/ibm440.h
--- a/include/asm-ppc/ibm440.h	Tue May 28 14:57:14 2002
+++ b/include/asm-ppc/ibm440.h	Tue May 28 14:57:14 2002
@@ -77,26 +77,6 @@
  * into the kernel.
  */
 #ifndef __ASSEMBLY__
-extern unsigned char __res[];
-
-/* Device Control Registers */
-
-#define stringify(s)	tostring(s)
-#define tostring(s)	#s
-
-#define mfdcr(rn) mfdcr_or_dflt(rn, 0)
-
-#define mfdcr_or_dflt(rn,default_rval) \
-	({unsigned int rval;						\
-	if (rn == 0)							\
-		rval = default_rval;					\
-	else								\
-		asm volatile("mfdcr %0," stringify(rn) : "=r" (rval));	\
-	rval;})
-
-#define mtdcr(rn, v)  \
-	{if (rn != 0) \
-		asm volatile("mtdcr " stringify(rn) ",%0" : : "r" (v));}

 /*
  * DCRN definitions
@@ -318,13 +298,6 @@
 #define PCIX0_MSGOH		0x10c
 #define PCIX0_IM		0x1f8

-#define EMAC_NUMS		2
-#define UART_NUMS		2
-#define ZMII_NUMS		1
-#define IIC_NUMS		2
-#define IIC0_IRQ		2
-#define IIC1_IRQ		3
-
 #define IIC_OWN			0x55
 #define IIC_CLOCK		50

@@ -333,6 +306,8 @@
 #define UIC_CASCADE_MASK	0x0003		/* bits 30 & 31 */

 #define BD_EMAC_ADDR(e,i) bi_enetaddr[e][i]
+
+#include <asm/ibm4xx.h>

 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_IBM440_H__ */
diff -Nru a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
--- a/include/asm-ppc/ibm4xx.h	Tue May 28 14:57:14 2002
+++ b/include/asm-ppc/ibm4xx.h	Tue May 28 14:57:14 2002
@@ -16,6 +16,34 @@

 #include <linux/config.h>

+#ifdef CONFIG_4xx
+
+#ifndef __ASSEMBLY__
+extern unsigned char __res[];
+
+/* Device Control Registers */
+
+#define stringify(s)	tostring(s)
+#define tostring(s)	#s
+
+#define mfdcr(rn) mfdcr_or_dflt(rn, 0)
+
+#define mfdcr_or_dflt(rn,default_rval) \
+	({unsigned int rval;						\
+	if (rn == 0)							\
+		rval = default_rval;					\
+	else								\
+		asm volatile("mfdcr %0," stringify(rn) : "=r" (rval));	\
+	rval;})
+
+#define mtdcr(rn, v)  \
+	{if (rn != 0) \
+		asm volatile("mtdcr " stringify(rn) ",%0" : : "r" (v));}
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_4xx */
+
 #ifdef CONFIG_40x

 #if defined(CONFIG_ASH)
@@ -74,32 +102,8 @@
  * The "residual" board information structure the boot loader passes
  * into the kernel.
  */
-#ifndef __ASSEMBLY__
-extern unsigned char __res[];
-
-/* Device Control Registers */
-
-#define stringify(s)	tostring(s)
-#define tostring(s)	#s
-
-#define mfdcr(rn) mfdcr_or_dflt(rn, 0)
-
-#define mfdcr_or_dflt(rn,default_rval) \
-	({unsigned int rval;						\
-	if (rn == 0)							\
-		rval = default_rval;					\
-	else								\
-		asm volatile("mfdcr %0," stringify(rn) : "=r" (rval));	\
-	rval;})
-
-#define mtdcr(rn, v)  \
-	{if (rn != 0) \
-		asm volatile("mtdcr " stringify(rn) ",%0" : : "r" (v));}
-
-#endif /* __ASSEMBLY__ */

 #elif CONFIG_440
-#include <asm/ibm440.h>

 #if defined(CONFIG_EBONY)
 #include <platforms/ebony.h>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Mon, 16 Aug 2004 08:44:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [RFC] Rework MPC82xx hooks in 2.6
Message-ID: <20040816154448.GA7015@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi.  I've done a slight re-org of how m8260_setup.c is supposed to be
used.  Before I push this out, I'd like comments from others actually
using the code.  The way this works now, boards such as the rpx8260 and
est8260 only need to provide a header file with the various defines
(almost all of which they have been already).  Other platforms such as
sbc82xx or pq2ads only need to provide their own version of already
provided hooks to do things such as setup late_time_init or setup the
2nd UART, or so on.  I've compile-tested this on 8540 and it works on my
rpx8260.

diff -zrupN old/arch/ppc/platforms/Makefile new/arch/ppc/platforms/Makefile
--- old/arch/ppc/platforms/Makefile	2004-08-16 08:34:40.728576653 -0700
+++ new/arch/ppc/platforms/Makefile	2004-08-16 08:34:03.379269355 -0700
@@ -21,7 +21,6 @@ endif
 obj-$(CONFIG_PMAC_BACKLIGHT)	+= pmac_backlight.o
 obj-$(CONFIG_PREP_RESIDUAL)	+= residual.o
 obj-$(CONFIG_ADIR)		+= adir_setup.o adir_pic.o adir_pci.o
-obj-$(CONFIG_EST8260)		+= est8260_setup.o
 obj-$(CONFIG_PQ2ADS)		+= pq2ads.o
 obj-$(CONFIG_TQM8260)		+= tqm8260_setup.o
 obj-$(CONFIG_EV64260)		+= ev64260_setup.o
@@ -37,7 +36,6 @@ obj-$(CONFIG_POWERPMC250)	+= powerpmc250
 obj-$(CONFIG_PPLUS)		+= pplus.o
 obj-$(CONFIG_PRPMC750)		+= prpmc750.o
 obj-$(CONFIG_PRPMC800)		+= prpmc800.o
-obj-$(CONFIG_RPX8260)		+= rpx8260.o
 obj-$(CONFIG_SANDPOINT)		+= sandpoint.o
 obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
diff -zrupN old/arch/ppc/platforms/est8260.h new/arch/ppc/platforms/est8260.h
--- old/arch/ppc/platforms/est8260.h	2004-08-16 08:28:57.135556289 -0700
+++ new/arch/ppc/platforms/est8260.h	2004-08-16 08:28:54.209237575 -0700
@@ -10,6 +10,9 @@

 #define BOOTROM_RESTART_ADDR	((uint)0xff000104)

+/* For our show_cpuinfo hooks. */
+#define CPUINFO_VENDOR		"EST Corporation"
+#define CPUINFO_MACHINE		"SBC8260 PowerPC"

 /* A Board Information structure that is given to a program when
  * prom starts it up.
diff -zrupN old/arch/ppc/platforms/est8260_setup.c new/arch/ppc/platforms/est8260_setup.c
--- old/arch/ppc/platforms/est8260_setup.c	2004-08-16 08:20:31.000000000 -0700
+++ new/arch/ppc/platforms/est8260_setup.c	1969-12-31 17:00:00.000000000 -0700
@@ -1,65 +0,0 @@
-/*
- * arch/ppc/platforms/est8260_setup.c
- *
- * EST8260 platform support
- *
- * Author: Allen Curtis <acurtis@onz.com>
- * Derived from: m8260_setup.c by Dan Malek, MVista
- *
- * Copyright 2002 Ones and Zeros, Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/config.h>
-#include <linux/seq_file.h>
-
-#include <asm/mpc8260.h>
-#include <asm/machdep.h>
-
-static void (*callback_setup_arch)(void);
-
-extern unsigned char __res[sizeof(bd_t)];
-
-extern void m8260_init(unsigned long r3, unsigned long r4,
-	unsigned long r5, unsigned long r6, unsigned long r7);
-
-static int
-est8260_show_cpuinfo(struct seq_file *m)
-{
-	bd_t	*binfo = (bd_t *)__res;
-
-	seq_printf(m, "vendor\t\t: EST Corporation\n"
-		      "machine\t\t: SBC8260 PowerPC\n"
-		      "\n"
-		      "mem size\t\t: 0x%08x\n"
-		      "console baud\t\t: %d\n"
-		      "\n",
-		      binfo->bi_memsize,
-		      binfo->bi_baudrate);
-	return 0;
-}
-
-static void __init
-est8260_setup_arch(void)
-{
-	printk("EST SBC8260 Port\n");
-	callback_setup_arch();
-}
-
-void __init
-platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
-	      unsigned long r6, unsigned long r7)
-{
-	/* Generic 8260 platform initialization */
-	m8260_init(r3, r4, r5, r6, r7);
-
-	/* Anything special for this platform */
-	ppc_md.show_cpuinfo	= est8260_show_cpuinfo;
-
-	callback_setup_arch	= ppc_md.setup_arch;
-	ppc_md.setup_arch	= est8260_setup_arch;
-}
diff -zrupN old/arch/ppc/platforms/pq2ads.c new/arch/ppc/platforms/pq2ads.c
--- old/arch/ppc/platforms/pq2ads.c	2004-08-16 08:34:42.105256249 -0700
+++ new/arch/ppc/platforms/pq2ads.c	2004-08-16 08:34:12.481150950 -0700
@@ -14,53 +14,13 @@
  * option) any later version.
  */

-#include <linux/config.h>
-#include <linux/seq_file.h>
+#include <linux/init.h>

 #include <asm/mpc8260.h>
-#include <asm/machdep.h>
-
-static void (*callback_setup_arch)(void);
-
-extern unsigned char __res[sizeof(bd_t)];
-
-extern void m8260_init(unsigned long r3, unsigned long r4,
-	unsigned long r5, unsigned long r6, unsigned long r7);
-
-static int
-pq2ads_show_cpuinfo(struct seq_file *m)
-{
-	bd_t	*binfo = (bd_t *)__res;
-
-	seq_printf(m, "vendor\t\t: Motorola\n"
-		      "machine\t\t: PQ2 ADS PowerPC\n"
-		      "\n"
-		      "mem size\t\t: 0x%08lx\n"
-		      "console baud\t\t: %ld\n"
-		      "\n",
-		      binfo->bi_memsize,
-		      binfo->bi_baudrate);
-	return 0;
-}
-
-static void __init
-pq2ads_setup_arch(void)
-{
-	printk("PQ2 ADS Port\n");
-	callback_setup_arch();
-        *(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_RS232_EN2;
-}

 void __init
-platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
-	      unsigned long r6, unsigned long r7)
+m82xx_board_init(void)
 {
-	/* Generic 8260 platform initialization */
-	m8260_init(r3, r4, r5, r6, r7);
-
-	/* Anything special for this platform */
-	ppc_md.show_cpuinfo	= pq2ads_show_cpuinfo;
-
-	callback_setup_arch	= ppc_md.setup_arch;
-	ppc_md.setup_arch	= pq2ads_setup_arch;
+	/* Enable the 2nd UART port */
+        *(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_RS232_EN2;
 }
diff -zrupN old/arch/ppc/platforms/pq2ads.h new/arch/ppc/platforms/pq2ads.h
--- old/arch/ppc/platforms/pq2ads.h	2004-08-16 08:26:30.242757361 -0700
+++ new/arch/ppc/platforms/pq2ads.h	2004-08-16 08:26:30.080795073 -0700
@@ -23,6 +23,10 @@

 #define BOOTROM_RESTART_ADDR	((uint)0xff000104)

+/* For our show_cpuinfo hooks. */
+#define CPUINFO_VENDOR		"Motorola"
+#define CPUINFO_MACHINE		"PQ2 ADS PowerPC"
+
 /* The ADS8260 has 16, 32-bit wide control/status registers, accessed
  * only on word boundaries.
  * Not all are used (yet), or are interesting to us (yet).
diff -zrupN old/arch/ppc/platforms/rpx8260.c new/arch/ppc/platforms/rpx8260.c
--- old/arch/ppc/platforms/rpx8260.c	2004-08-16 08:26:02.231279859 -0700
+++ new/arch/ppc/platforms/rpx8260.c	1969-12-31 17:00:00.000000000 -0700
@@ -1,65 +0,0 @@
-/*
- * arch/ppc/platforms/rpx8260.c
- *
- * RPC EP8260 platform support
- *
- * Author: Dan Malek <dan@embeddededge.com>
- * Derived from: pq2ads_setup.c by Kumar
- *
- * Copyright 2004 Embedded Edge, LLC
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/config.h>
-#include <linux/seq_file.h>
-
-#include <asm/mpc8260.h>
-#include <asm/machdep.h>
-
-static void (*callback_setup_arch)(void);
-
-extern unsigned char __res[sizeof(bd_t)];
-
-extern void m8260_init(unsigned long r3, unsigned long r4,
-	unsigned long r5, unsigned long r6, unsigned long r7);
-
-static int
-ep8260_show_cpuinfo(struct seq_file *m)
-{
-	bd_t	*binfo = (bd_t *)__res;
-
-	seq_printf(m, "vendor\t\t: RPC\n"
-		      "machine\t\t: EP8260 PPC\n"
-		      "\n"
-		      "mem size\t\t: 0x%08x\n"
-		      "console baud\t\t: %d\n"
-		      "\n",
-		      binfo->bi_memsize,
-		      binfo->bi_baudrate);
-	return 0;
-}
-
-static void __init
-ep8260_setup_arch(void)
-{
-	printk("RPC EP8260 Port\n");
-	callback_setup_arch();
-}
-
-void __init
-platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
-	      unsigned long r6, unsigned long r7)
-{
-	/* Generic 8260 platform initialization */
-	m8260_init(r3, r4, r5, r6, r7);
-
-	/* Anything special for this platform */
-	ppc_md.show_cpuinfo	= ep8260_show_cpuinfo;
-
-	callback_setup_arch	= ppc_md.setup_arch;
-	ppc_md.setup_arch	= ep8260_setup_arch;
-}
diff -zrupN old/arch/ppc/platforms/rpx8260.h new/arch/ppc/platforms/rpx8260.h
--- old/arch/ppc/platforms/rpx8260.h	2004-08-16 08:26:12.755829186 -0700
+++ new/arch/ppc/platforms/rpx8260.h	2004-08-16 08:26:12.801818477 -0700
@@ -70,5 +70,12 @@ extern volatile u_char *rpx6_csr_addr;

 #define PHY_INTERRUPT	SIU_INT_IRQ7

+/* For our show_cpuinfo hooks. */
+#define CPUINFO_VENDOR		"Embedded Planet"
+#define CPUINFO_MACHINE		"EP8260 PowerPC"
+
+/* Warm reset vector. */
+#define BOOTROM_RESTART_ADDR	((uint)0xfff00104)
+
 #endif /* __ASM_PLATFORMS_RPX8260_H__ */
 #endif /* __KERNEL__ */
diff -zrupN old/arch/ppc/platforms/sbc82xx.c new/arch/ppc/platforms/sbc82xx.c
--- old/arch/ppc/platforms/sbc82xx.c	2004-08-16 08:23:12.000000000 -0700
+++ new/arch/ppc/platforms/sbc82xx.c	2004-08-16 08:23:12.000000000 -0700
@@ -16,10 +16,10 @@
  */

 #include <linux/config.h>
-#include <linux/seq_file.h>
 #include <linux/stddef.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/init.h>

 #include <asm/mpc8260.h>
 #include <asm/machdep.h>
@@ -28,39 +28,12 @@
 #include <asm/immap_cpm2.h>
 #include <asm/pci.h>

-static void (*callback_setup_arch)(void);
 static void (*callback_init_IRQ)(void);

 extern unsigned char __res[sizeof(bd_t)];

-extern void m8260_init(unsigned long r3, unsigned long r4,
-	unsigned long r5, unsigned long r6, unsigned long r7);
-
 extern void (*late_time_init)(void);

-static int
-sbc82xx_show_cpuinfo(struct seq_file *m)
-{
-	bd_t	*binfo = (bd_t *)__res;
-
-	seq_printf(m, "vendor\t\t: Wind River\n"
-		      "machine\t\t: SBC PowerQUICC II\n"
-		      "\n"
-		      "mem size\t\t: 0x%08lx\n"
-		      "console baud\t\t: %ld\n"
-		      "\n",
-		      binfo->bi_memsize,
-		      binfo->bi_baudrate);
-	return 0;
-}
-
-static void __init
-sbc82xx_setup_arch(void)
-{
-	printk("SBC PowerQUICC II Port\n");
-	callback_setup_arch();
-}
-
 #ifdef CONFIG_GEN_RTC
 TODC_ALLOC();

@@ -236,23 +209,14 @@ static int sbc82xx_pci_map_irq(struct pc
 	return PCI_IRQ_TABLE_LOOKUP;
 }

-
-
 void __init
-platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
-	      unsigned long r6, unsigned long r7)
+m82xx_board_init(void)
 {
-	/* Generic 8260 platform initialization */
-	m8260_init(r3, r4, r5, r6, r7);
-
 	/* u-boot may be using one of the FCC Ethernet devices.
 	   Use the MAC address to the SCC. */
 	__res[offsetof(bd_t, bi_enetaddr[5])] &= ~3;

 	/* Anything special for this platform */
-	ppc_md.show_cpuinfo	= sbc82xx_show_cpuinfo;
-
-	callback_setup_arch	= ppc_md.setup_arch;
 	callback_init_IRQ	= ppc_md.init_IRQ;

 	ppc_md.setup_arch	= sbc82xx_setup_arch;
diff -zrupN old/arch/ppc/platforms/sbc82xx.h new/arch/ppc/platforms/sbc82xx.h
--- old/arch/ppc/platforms/sbc82xx.h	2004-08-16 08:33:32.157536158 -0700
+++ new/arch/ppc/platforms/sbc82xx.h	2004-08-16 08:33:32.098549887 -0700
@@ -18,6 +18,10 @@
 #define SBC82xx_MACADDR_NVRAM_FCC2	0x220000d5	/* JP7A */
 #define SBC82xx_MACADDR_NVRAM_FCC3	0x220000db	/* JP7B */

+/* For our show_cpuinfo hooks. */
+#define CPUINFO_VENDOR		"Wind River"
+#define CPUINFO_MACHINE		"SBC PowerQUICC II"
+
 #define BOOTROM_RESTART_ADDR      ((uint)0x40000104)

 #define SBC82xx_PC_IRQA (NR_SIU_INTS+0)
diff -zrupN old/arch/ppc/platforms/tqm8260.h new/arch/ppc/platforms/tqm8260.h
--- old/arch/ppc/platforms/tqm8260.h	2004-08-16 08:26:03.945880607 -0700
+++ new/arch/ppc/platforms/tqm8260.h	2004-08-16 08:26:03.927884798 -0700
@@ -14,6 +14,10 @@
 #define CPM_MAP_ADDR		((uint)0xFFF00000)
 #define PHY_INTERRUPT		25

+/* For our show_cpuinfo hooks. */
+#define CPUINFO_VENDOR		"IN2 Systems"
+#define CPUINFO_MACHINE		"TQM8260 PowerPC"
+
 #define BOOTROM_RESTART_ADDR	((uint)0x40000104)

 #endif	/* __TQM8260_PLATFORM */
diff -zrupN old/arch/ppc/platforms/tqm8260_setup.c new/arch/ppc/platforms/tqm8260_setup.c
--- old/arch/ppc/platforms/tqm8260_setup.c	2004-08-16 08:24:07.000000000 -0700
+++ new/arch/ppc/platforms/tqm8260_setup.c	2004-08-16 08:24:07.000000000 -0700
@@ -14,33 +14,12 @@
  * option) any later version.
  */

-#include <linux/config.h>
-#include <linux/seq_file.h>
+#include <linux/init.h>

 #include <asm/immap_cpm2.h>
 #include <asm/mpc8260.h>
 #include <asm/machdep.h>

-static void (*callback_setup_arch)(void);
-
-extern unsigned char __res[sizeof(bd_t)];
-
-extern void m8260_init(unsigned long r3, unsigned long r4,
-	unsigned long r5, unsigned long r6, unsigned long r7);
-
-static int
-tqm8260_show_cpuinfo(struct seq_file *m)
-{
-	bd_t	*binfo = (bd_t *)__res;
-
-	seq_printf(m, "vendor\t\t: IN2 Systems\n"
-		      "machine\t\t: TQM8260 PowerPC\n"
-		      "mem size\t\t: 0x%08x\n"
-		      "\n",
-		      binfo->bi_memsize);
-	return 0;
-}
-
 static int
 tqm8260_set_rtc_time(unsigned long time)
 {
@@ -56,24 +35,10 @@ tqm8260_get_rtc_time(void)
 	return ((cpm2_map_t *)CPM_MAP_ADDR)->im_sit.sit_tmcnt;
 }

-static void __init
-tqm8260_setup_arch(void)
-{
-	printk("IN2 Systems TQM8260 port\n");
-	callback_setup_arch();
-}
-
 void __init
-platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
-	      unsigned long r6, unsigned long r7)
+m82xx_board_init(void)
 {
-	/* Generic 8260 platform initialization */
-	m8260_init(r3, r4, r5, r6, r7);
-
 	/* Anything special for this platform */
-	ppc_md.show_cpuinfo	= tqm8260_show_cpuinfo;
 	ppc_md.set_rtc_time	= tqm8260_set_rtc_time;
 	ppc_md.get_rtc_time	= tqm8260_get_rtc_time;
-
-	callback_setup_arch	= ppc_md.setup_arch;
-	ppc_md.setup_arch	= tqm8260_setup_arch;
+}
diff -zrupN old/arch/ppc/syslib/cpm2_pic.c new/arch/ppc/syslib/cpm2_pic.c
--- old/arch/ppc/syslib/cpm2_pic.c	2004-08-16 08:26:29.629900063 -0700
+++ new/arch/ppc/syslib/cpm2_pic.c	2004-08-16 08:26:29.405952209 -0700
@@ -1,12 +1,3 @@
-#include <linux/stddef.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <asm/irq.h>
-#include <asm/immap_cpm2.h>
-#include <asm/mpc8260.h>
-#include "cpm2_pic.h"
-
 /* The CPM2 internal interrupt controller.  It is usually
  * the only interrupt controller.
  * There are two 32-bit registers (high/low) for up to 64
@@ -18,6 +9,18 @@
  * We create two tables, indexed by vector number, to indicate
  * which register to use and which bit in the register to use.
  */
+
+#include <linux/stddef.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/irq.h>
+
+#include <asm/immap_cpm2.h>
+#include <asm/mpc8260.h>
+
+#include "cpm2_pic.h"
+
 static	u_char	irq_to_siureg[] = {
 	1, 1, 1, 1, 1, 1, 1, 1,
 	1, 1, 1, 1, 1, 1, 1, 1,
@@ -123,9 +126,5 @@ cpm2_get_irq(struct pt_regs *regs)

 	if (irq == 0)
 		return(-1);
-#if 0
-        irq += ppc8260_pic.irq_offset;
-#endif
 	return irq;
 }
-
diff -zrupN old/arch/ppc/syslib/cpm2_pic.h new/arch/ppc/syslib/cpm2_pic.h
--- old/arch/ppc/syslib/cpm2_pic.h	2004-08-16 08:33:32.158535926 -0700
+++ new/arch/ppc/syslib/cpm2_pic.h	2004-08-16 08:33:32.041563151 -0700
@@ -1,13 +1,7 @@
 #ifndef _PPC_KERNEL_CPM2_H
 #define _PPC_KERNEL_CPM2_H

-#include <linux/irq.h>
-
 extern struct hw_interrupt_type cpm2_pic;
-
-void cpm2_pic_init(void);
-void cpm2_do_IRQ(struct pt_regs *regs,
-                 int            cpu);
-int cpm2_get_irq(struct pt_regs *regs);
+extern int cpm2_get_irq(struct pt_regs *regs);

 #endif /* _PPC_KERNEL_CPM2_H */
diff -zrupN old/arch/ppc/syslib/m8260_setup.c new/arch/ppc/syslib/m8260_setup.c
--- old/arch/ppc/syslib/m8260_setup.c	2004-08-16 08:26:11.888031254 -0700
+++ new/arch/ppc/syslib/m8260_setup.c	2004-08-16 08:26:11.775057560 -0700
@@ -1,5 +1,5 @@
 /*
- *  arch/ppc/kernel/setup.c
+ *  arch/ppc/syslib/m8260_setup.c
  *
  *  Copyright (C) 1995  Linus Torvalds
  *  Adapted from 'alpha' version by Gary Thomas
@@ -8,36 +8,20 @@
  *  Further modified for generic 8xx and 8260 by Dan.
  */

-/*
- * bootup setup stuff..
- */
-
 #include <linux/config.h>
-#include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/stddef.h>
-#include <linux/unistd.h>
-#include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
-#include <linux/a.out.h>
-#include <linux/tty.h>
-#include <linux/major.h>
-#include <linux/interrupt.h>
-#include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/initrd.h>
-#include <linux/ioport.h>
-#include <linux/ide.h>
 #include <linux/seq_file.h>
+#include <linux/irq.h>

 #include <asm/mmu.h>
-#include <asm/residual.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
-#include <asm/ide.h>
 #include <asm/mpc8260.h>
 #include <asm/immap_cpm2.h>
 #include <asm/machdep.h>
@@ -46,10 +30,6 @@

 #include "cpm2_pic.h"

-static int m8260_set_rtc_time(unsigned long time);
-static unsigned long m8260_get_rtc_time(void);
-static void m8260_calibrate_decr(void);
-
 unsigned char __res[sizeof(bd_t)];

 extern void cpm2_reset(void);
@@ -59,8 +39,10 @@ extern void idma_pci9_init(void);
 static void __init
 m8260_setup_arch(void)
 {
-	/* Reset the Communication Processor Module.
-	*/
+	/* Print out Vendor and Machine info. */
+	printk(KERN_INFO "%s %s port\n", CPUINFO_VENDOR, CPUINFO_MACHINE);
+
+	/* Reset the Communication Processor Module. */
 	cpm2_reset();
 #ifdef CONFIG_8260_PCI9
 	/* Initialise IDMA for PCI erratum workaround */
@@ -77,7 +59,7 @@ m8260_setup_arch(void)
 static void __init
 m8260_calibrate_decr(void)
 {
-	bd_t	*binfo = (bd_t *)__res;
+	bd_t *binfo = (bd_t *)__res;
 	int freq, divisor;

 	freq = binfo->bi_busfreq;
@@ -145,18 +127,22 @@ m8260_power_off(void)
 }

 static int
-m8260_show_percpuinfo(struct seq_file *m, int i)
+m8260_show_cpuinfo(struct seq_file *m)
 {
-	bd_t	*bp;
+	bd_t *bp = (bd_t *)__res;

-	bp = (bd_t *)__res;
-
-	seq_printf(m, "core clock\t: %ld MHz\n"
-		   "CPM  clock\t: %ld MHz\n"
-		   "bus  clock\t: %ld MHz\n",
-		   bp->bi_intfreq / 1000000,
-		   bp->bi_cpmfreq / 1000000,
-		   bp->bi_busfreq / 1000000);
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
 	return 0;
 }

@@ -170,7 +156,6 @@ static void __init
 m8260_init_IRQ(void)
 {
 	int i;
-	void cpm_interrupt_init(void);

         for ( i = 0 ; i < NR_SIU_INTS ; i++ )
                 irq_desc[i].handler = &cpm2_pic;
@@ -190,10 +175,7 @@ m8260_init_IRQ(void)
 static unsigned long __init
 m8260_find_end_of_memory(void)
 {
-	bd_t	*binfo;
-	extern unsigned char __res[];
-
-	binfo = (bd_t *)__res;
+	bd_t *binfo = (bd_t *)__res;

 	return binfo->bi_memsize;
 }
@@ -216,6 +198,12 @@ m8260_map_io(void)
 	io_block_mapping(IO_VIRT_ADDR, IO_PHYS_ADDR, 0x10000000, _PAGE_IO);
 }

+/* Place-holder for board-specific init */
+void __attribute__ ((weak)) __init
+m82xx_board_init(void)
+{
+}
+
 /* Inputs:
  *   r3 - Optional pointer to a board information structure.
  *   r4 - Optional pointer to the physical starting address of the init RAM
@@ -228,7 +216,7 @@ m8260_map_io(void)
  *        command-line parameters.
  */
 void __init
-m8260_init(unsigned long r3, unsigned long r4, unsigned long r5,
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	      unsigned long r6, unsigned long r7)
 {
 	parse_bootinfo(find_bootinfo());
@@ -249,18 +237,18 @@ m8260_init(unsigned long r3, unsigned lo
 		strcpy(cmd_line, (char *)(r6+KERNELBASE));
 	}

+	/* Call back for board-specific settings. */
+	m82xx_board_init();
+
 	ppc_md.setup_arch		= m8260_setup_arch;
-	ppc_md.show_percpuinfo		= m8260_show_percpuinfo;
-	ppc_md.irq_canonicalize	= NULL;
+	ppc_md.show_cpuinfo		= m8260_show_cpuinfo;
 	ppc_md.init_IRQ			= m8260_init_IRQ;
 	ppc_md.get_irq			= cpm2_get_irq;
-	ppc_md.init			= NULL;

 	ppc_md.restart			= m8260_restart;
 	ppc_md.power_off		= m8260_power_off;
 	ppc_md.halt			= m8260_halt;

-	ppc_md.time_init		= NULL;
 	ppc_md.set_rtc_time		= m8260_set_rtc_time;
 	ppc_md.get_rtc_time		= m8260_get_rtc_time;
 	ppc_md.calibrate_decr		= m8260_calibrate_decr;

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

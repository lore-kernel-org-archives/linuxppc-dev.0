Return-Path: <kevdig@hypersurf.com>
Received: from mail.hypersurf.com (mail.hypersurf.com [209.237.0.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A319667D55
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jul 2005 03:32:46 +1000 (EST)
Received: from [192.168.1.37] (DIALPAT65.hypersurf.com [206.40.42.65])
	by mail.hypersurf.com (8.13.1/8.13.1) with ESMTP id j6QHVm2C031685
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jul 2005 10:32:28 -0700 (PDT)
Message-ID: <42E672B1.7050709@hypersurf.com>
Date: Tue, 26 Jul 2005 10:28:17 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="------------090705080806090603020406"
Subject: preliminary 750GX PLL control patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090705080806090603020406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

         I've attached a patch that adds preliminary access to the HID1 
register in the 750GX (aka the PLL config register). The patch is 
against 2.4.30. It has been lightly tested on a PowerMac 8600 with a 
PowerLogix PowerForce 750GX cpu card.

         Depending on the values for the pllx_cfg field, this should 
work on the 750FX as well ... except for the stuff in idle_6xx.S. Since 
there are plenty of people on this list way more smarterer than me I was 
hoping someone could answer a question about the powersave modes that 
some of the PowerPC processors have:

         Since, as I understand it, the clock is shut off to much of the 
chip when a powersave mode is engaged does it really buy you that much 
to switch to a lower clock speed? Wouldn't you be better off shutting 
off the unused PLL?

         Also, please note that I am not very experienced creating 
patches so please use a backup of your source tree.

                                         kevin


--------------090705080806090603020406
Content-Type: text/plain;
 name="pllpatch.u"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="pllpatch.u"

diff -Naur linux-2.4.30.orig/Documentation/Configure.help linux-2.4.30/Documentation/Configure.help
--- linux-2.4.30.orig/Documentation/Configure.help	Fri Apr  8 15:47:19 2005
+++ linux-2.4.30/Documentation/Configure.help	Wed Jun 22 18:00:35 2005
@@ -24304,6 +24304,11 @@
   a lot, or the TAU hardware is broken (likely on some G4's). If the range
   is small (around 4 degrees), the temperature is relatively stable.
 
+Dual PLL support
+CONFIG_DUAL_PLL
+  This option enables sysctl support for checking and modifying the PLLs in
+  the IBM 750FX and 750GX processors.
+
 Power management support for PowerBooks
 CONFIG_PMAC_PBOOK
   This provides support for putting a PowerBook to sleep; it also
diff -Naur linux-2.4.30.orig/arch/ppc/config.in linux-2.4.30/arch/ppc/config.in
--- linux-2.4.30.orig/arch/ppc/config.in	Thu Apr  7 22:25:11 2005
+++ linux-2.4.30/arch/ppc/config.in	Tue Jun 21 18:02:56 2005
@@ -175,10 +175,12 @@
     bool '    Average high and low temp' CONFIG_TAU_AVERAGE
   fi
   define_bool CONFIG_PPC_ISATIMER y
+
+  bool 'Dual PLL Support (750FX/GX)' CONFIG_DUAL_PLL
 fi
-if [ "$CONFIG_POWER4" = "y" ]; then
-  bool 'VMX (same as AltiVec) support' CONFIG_ALTIVEC
-fi
+#if [ "$CONFIG_POWER4" = "y" ]; then
+#  bool 'VMX (same as AltiVec) support' CONFIG_ALTIVEC
+#fi
 
 if [ "$CONFIG_4xx" = "y" -o "$CONFIG_8xx" = "y" ]; then
   bool 'Math emulation' CONFIG_MATH_EMULATION
diff -Naur linux-2.4.30.orig/arch/ppc/kernel/Makefile linux-2.4.30/arch/ppc/kernel/Makefile
--- linux-2.4.30.orig/arch/ppc/kernel/Makefile	Thu Apr  7 22:24:19 2005
+++ linux-2.4.30/arch/ppc/kernel/Makefile	Tue Jun 21 18:10:03 2005
@@ -50,6 +50,7 @@
 obj-$(CONFIG_PPCBUG_NVRAM)	+= prep_nvram.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_TAU)		+= temp.o
+obj-$(CONFIG_DUAL_PLL)		+= pll.o pll_init.o
 ifeq ($(CONFIG_SERIAL)$(CONFIG_GEN550),yy)
 obj-$(CONFIG_KGDB)		+= gen550_kgdb.o gen550_dbg.o
 obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= gen550_dbg.o
@@ -97,6 +98,8 @@
 entry.o: entry.S ppc_defs.h
 misc.o: misc.S ppc_defs.h
 l2cr.o: l2cr.S ppc_defs.h
+pll.o: pll.S ppc_defs.h
+pll_init.o: pll_init.c ppc_defs.h
 head.o: head.S ppc_defs.h
 head_4xx.o: head_4xx.S ppc_defs.h
 head_44x.o: head_44x.S ppc_defs.h
diff -Naur linux-2.4.30.orig/arch/ppc/kernel/cpu_setup_6xx.S linux-2.4.30/arch/ppc/kernel/cpu_setup_6xx.S
--- linux-2.4.30.orig/arch/ppc/kernel/cpu_setup_6xx.S	Thu Apr  7 22:22:52 2005
+++ linux-2.4.30/arch/ppc/kernel/cpu_setup_6xx.S	Sun May 15 12:16:39 2005
@@ -48,6 +48,13 @@
 	bl	setup_750fx
 	mtlr	r4
 	blr
+_GLOBAL(__setup_cpu_750gx)
+	mflr	r4
+	bl	setup_common_caches
+	bl	setup_750_7400_hid0
+	bl	setup_750gx
+	mtlr	r4
+	blr
 _GLOBAL(__setup_cpu_7400)
 	mflr	r4
 	bl	setup_7400_workarounds
@@ -200,6 +207,11 @@
 /* 750fx specific
  */
 setup_750fx:
+	blr
+
+/* 750gx specific
+ */
+setup_750gx:
 	blr
 
 /* MPC 745x
diff -Naur linux-2.4.30.orig/arch/ppc/kernel/cputable.c linux-2.4.30/arch/ppc/kernel/cputable.c
--- linux-2.4.30.orig/arch/ppc/kernel/cputable.c	Fri Apr  8 15:47:21 2005
+++ linux-2.4.30/arch/ppc/kernel/cputable.c	Thu Jun 23 12:22:14 2005
@@ -24,6 +24,7 @@
 extern void __setup_cpu_750(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 extern void __setup_cpu_750cx(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 extern void __setup_cpu_750fx(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
+extern void __setup_cpu_750gx(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 extern void __setup_cpu_7400(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 extern void __setup_cpu_7410(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 extern void __setup_cpu_745x(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
@@ -60,6 +61,19 @@
 #define CPU_FTR_COMMON                  0
 #endif
 
+#if 0
+const char *cpu_type_strings[] = {
+	"601","603","603e","603ev","604","604e","604r","604ev","740/750",
+	"745/755","750CX","750FX","750GX","7400","7400 (1.1)","7410","7450",
+	"7455","7457","7447A","82xx","8280","(generic PPC)","Power3 (630)",
+	"Power3 (630+)","I-star","S-star","Power4","PPC970","8xx","403GC",
+	"403GCX","403G ??","405GP","STB03xxx","440GP Rev. B","440GP Rev. C",
+	"440GX Rev. A","440GX Rev. B","440GX Rev. C"
+};
+
+#define CPU_TYPE_601 cpu_type_strings[0]
+#endif
+
 struct cpu_spec	cpu_specs[] = {
 #if CLASSIC_PPC
     { 	/* 601 */
@@ -165,7 +179,7 @@
 	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
-	CPU_FTR_750FX | CPU_FTR_NO_DPM,
+	CPU_FTR_750FX | CPU_FTR_NO_DPM | CPU_FTR_DUALPLL,
 	COMMON_PPC,
 	32, 32,
 	__setup_cpu_750
@@ -175,7 +189,8 @@
 	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
-	CPU_FTR_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NO_DPM,
+	CPU_FTR_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NO_DPM |
+	CPU_FTR_DUALPLL,
 	COMMON_PPC,
 	32, 32,
 	__setup_cpu_750
@@ -185,10 +200,40 @@
 	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
-	CPU_FTR_750FX | CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_DUALPLL,
 	COMMON_PPC,
 	32, 32,
 	__setup_cpu_750fx
+    },
+    {	/* 750GX (rev 1.x) */
+    	0xffffff00, 0x70020100, "750GX",
+	CPU_FTR_COMMON |
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
+	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
+	CPU_FTR_750GX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_DUALPLL,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_750gx
+    },
+    {	/* 750GX (rev  2.3, as used on PowerLogix 750GX) */
+    	0xffffffff, 0x00080203, "750GX",
+	CPU_FTR_COMMON |
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
+	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
+	CPU_FTR_750GX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_DUALPLL,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_750gx
+    },
+    {	/* 750GX (All revs >= 2.0) */
+    	0xffffff00, 0x70020200, "750GX",
+	CPU_FTR_COMMON |
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
+	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
+	CPU_FTR_750GX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_DUALPLL,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_750gx
     },
     {	/* 740/750 (L2CR bit need fixup for 740) */
     	0xffff0000, 0x00080000, "740/750",
diff -Naur linux-2.4.30.orig/arch/ppc/kernel/pll.S linux-2.4.30/arch/ppc/kernel/pll.S
--- linux-2.4.30.orig/arch/ppc/kernel/pll.S	Wed Dec 31 16:00:00 1969
+++ linux-2.4.30/arch/ppc/kernel/pll.S	Wed Jun 22 18:15:51 2005
@@ -0,0 +1,182 @@
+/*
+	Dual PLL functions, for 750FX & 750GX
+	Copyright © 2005 by Kevin Diggs
+
+	This program is free software; you can redistribute it and/or modify
+	it under the terms of the GNU General Public License as published by
+	the Free Software Foundation; either version 2 of the License, or
+	(at your option) any later version.
+
+	This program is distributed in the hope that it will be useful,
+	but WITHOUT ANY WARRANTY; without even the implied warranty of
+	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+	GNU General Public License for more details.
+
+	You should have received a copy of the GNU General Public License
+	along with this program; if not, write to the Free Software
+	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+/*
+	Tue, June 14, 2005.
+	- First public release, contributed by Kevin Diggs.
+	***********
+	***********
+
+	Author:	Kevin Diggs ()
+	Please e-mail updates to this file to me, thanks!
+*/
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/cputable.h>
+#include <asm/ppc_asm.h>
+#include <asm/cache.h>
+
+/* Usage:
+
+	Examples:
+
+	_setPLL(0)		- disables the cache
+	_setPLL(0xB3A04000)	- enables my G3 upgrade card:
+				- L2E set to turn on the cache
+				- L2SIZ set to 1MB
+				- L2CLK set to 1:1
+				- L2RAM set to pipelined synchronous late-write
+				- L2I set to perform a global invalidation
+				- L2OH set to 0.5 nS
+				- L2DF set because this upgrade card
+				  requires it
+
+	The layout of the PLL register (HID1) is:
+
+	0  4|5 6|7|8| 9 11|12 13|14| 15 |16 20|21 22|24 28|29 30| 31
+	PCE |PRE|v|v| Res | Res |v | PS | PC0 | PR0 | PC1 | PR1 |Res
+                 | |             |
+	 PSTAT1 -| |             |
+         ECLK -----|             |
+         PI0 --------------------|
+
+	PCE	PLL0 read-only external config
+	PRE	PLL0 read-only external range
+	PSTAT1	PLL status (0 -> PLL0, 1 -> PLL1)
+	ECLK	1 -> enable clkout pin
+	PI0	PLL0 control:  0 -> external
+	PS	PLL select:  0 -> PLL0, 1 -> PLL1
+	PC0	PLL0 configuration
+	PR0	PLL0 range
+	PC1	PLL1 configuration
+	PR1	PLL1 range
+
+	PLL_CFG		bus ratio	PLL_CFG		bus ratio
+	 00000		   off		 10000		    8
+	 00001		   off		 10001		   8.5
+	 00010		 bypass		 10010		    9
+	 00011		 bypass		 10011		   9.5
+	 00100		    2		 10100		   10
+	 00101		   2.5		 10101		   11
+	 00110		    3		 10110		   12
+	 00111		   3.5		 10111		   13
+	 01000		    4		 11000		   14
+	 01001		   4.5		 11001		   15
+	 01010		    5		 11010		   16
+	 01011		   5.5		 11011		   17
+	 01100		    6		 11100		   18
+	 01101		   6.5		 11101		   19
+	 01110		    7		 11110		   20
+	 01111		   7.5		 11111		   off
+
+	PLL_RNG		  range
+	  00		600 -  900
+	  01		900 - 1000
+	  10		500 -  600
+*/
+
+/*
+ * Return current PLL configuration
+ */
+_GLOBAL(_get_PLL)
+	/* Make sure this is a 750FX or 750GX chip */
+BEGIN_FTR_SECTION
+	li	r3,-1
+	blr
+END_FTR_SECTION_IFCLR(CPU_FTR_DUALPLL)
+	mfspr	r3,HID1			/* Get current PLL config */
+	blr
+
+/*
+ * Return active (selected) PLL from configuration (0 or 1)
+ * r3 contains configuration to dig selection out of
+ */
+_GLOBAL(_get_active_PLL)
+	/* Make sure this is a 750FX or 750GX chip */
+BEGIN_FTR_SECTION
+	li	r3,-1
+	blr
+END_FTR_SECTION_IFCLR(CPU_FTR_DUALPLL)
+	rlwinm	r3,r3,8,31,31		/* PSTAT1 to LSBit and mask */
+	blr
+
+/*
+ * Return next PLL from configuration (0 or 1)
+ * r3 contains configuration to dig next PLL out of (PS bit)
+ */
+_GLOBAL(_get_next_PLL)
+	/* Make sure this is a 750FX or 750GX chip */
+BEGIN_FTR_SECTION
+	li	r3,-1
+	blr
+END_FTR_SECTION_IFCLR(CPU_FTR_DUALPLL)
+	rlwinm	r3,r3,16,31,31		/* PS to LSBit and mask */
+	blr
+
+/*
+ * Return selected ratio
+ * r3 contains ratio to return (0 or 1)
+ * r4 contains the configuration to pick it out of
+ */
+_GLOBAL(_get_PLL_ratio)
+BEGIN_FTR_SECTION
+	li	r3,-1
+	blr
+END_FTR_SECTION_IFCLR(CPU_FTR_DUALPLL)
+	/*
+	 * Turn r3 into a rotate count for the selected configuration.
+	 * 0 needs to become 21, 1 needs to become 29.
+	 */
+	slwi	r3,r3,3
+	addi	r3,r3,21
+
+	rlwnm	r3,r4,r3,27,31
+	blr
+
+/*
+ * Return selected range
+ * r3 contains range to return (0 or 1)
+ * r4 contains the configuration to pick it out of
+ */
+_GLOBAL(_get_PLL_range)
+BEGIN_FTR_SECTION
+	li	r3,-1
+	blr
+END_FTR_SECTION_IFCLR(CPU_FTR_DUALPLL)
+	/*
+	 * Turn r3 into a rotate count for the selected range.
+	 * 0 needs to become 23, 1 needs to become 31.
+	 */
+	slwi	r3,r3,3
+	addi	r3,r3,23
+
+	rlwnm	r3,r4,r3,30,31
+	blr
+
+/*
+ * Update the value of the PLL configuration register
+ */
+_GLOBAL(_set_PLL)
+	/* Make sure this is a 750FX or 750GX chip */
+BEGIN_FTR_SECTION
+	li	r3,-1
+	blr
+END_FTR_SECTION_IFCLR(CPU_FTR_DUALPLL)
+
+	mtspr	HID1,r3			/* Get current PLL config */
+	blr
diff -Naur linux-2.4.30.orig/arch/ppc/kernel/pll_init.c linux-2.4.30/arch/ppc/kernel/pll_init.c
--- linux-2.4.30.orig/arch/ppc/kernel/pll_init.c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.30/arch/ppc/kernel/pll_init.c	Sat Jun 25 21:15:14 2005
@@ -0,0 +1,506 @@
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/proc_fs.h>
+#include <linux/stat.h>
+#include <linux/sysctl.h>
+#include <linux/ctype.h>
+#include <linux/threads.h>
+#include <linux/init.h>
+
+#include <asm/uaccess.h>
+#include <asm/bitops.h>
+#include <asm/mmu.h>
+#include <asm/processor.h>
+#include <asm/residual.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/cputable.h>
+#include <asm/system.h>
+#include <asm/pll.h>
+
+extern unsigned long loops_per_jiffy;
+
+static struct timer_list pll_timer;
+
+unsigned long boot_loops;
+unsigned int boot_ratio;
+
+#define TMPBUFLEN 128
+
+/*
+ * This initializes the code for the PLL control:
+ * boot_ratio is used to scale the loops_per_jiffy value from its boot value
+ * boot_loops is the boot value of loops_per_jiffy and is used to compute new
+ * values
+ */
+void __init init_PLL()
+{
+int temp;
+
+	temp=_get_PLL();
+	temp=_get_PLL_ratio(_get_active_PLL(temp),temp);
+
+	/*
+	 * Units for boot ratio is halves, i.e. 20 is a ratio of 10.
+	 * From 21 on the returned value needs to be converted to halves.
+	 */
+	if(temp>20) temp=(temp-10)<<1;
+
+	boot_ratio=temp;
+	boot_loops=loops_per_jiffy;
+}
+
+__initcall(init_PLL);
+
+static unsigned long pllNewLPJ(unsigned int oldRatio, unsigned int newRatio,
+	unsigned long LPJ)
+{
+	if(LPJ>200000000) return LPJ/oldRatio*newRatio;
+	else return LPJ*newRatio/oldRatio;
+}
+
+static void pllSwitchPLLs(unsigned int newPLL)
+{
+#if 0
+unsigned long flags;
+#endif
+unsigned int new_ratio,old_ratio,current_pll,masked_boot_ratio;
+
+#if DEBUG
+printk(__FILE__"-%d:  newPLL=0x%08x\n",__LINE__,newPLL);
+#endif
+	/*
+	 * Compute new loops_per_jiffy
+	 */
+	current_pll=_get_PLL();
+	new_ratio=_get_PLL_ratio(_get_next_PLL(newPLL),current_pll);
+	old_ratio=_get_PLL_ratio(_get_active_PLL(current_pll),current_pll);
+	masked_boot_ratio=boot_ratio&0xff;
+#if DEBUG
+	printk(__FILE__"-%d:  current_pll=0x%08x, new=%d, old=%d\n",__LINE__,
+		current_pll,new_ratio,old_ratio);
+#endif
+	current_pll=(current_pll&~PLL_SEL_MASK)|newPLL;
+
+#if DEBUG
+	printk(__FILE__"-%d:  current_pll=0x%08x, new=%d, old=%d\n",__LINE__,
+		current_pll,new_ratio,old_ratio);
+#endif
+	/*
+	 * Convert to halves
+	 */
+	if(new_ratio>20) new_ratio=(new_ratio-10)<<1;
+	if(old_ratio>20) old_ratio=(old_ratio-10)<<1;
+
+	/*
+	 * Make sure that we never shorten the sleep values
+	 */
+	if(new_ratio>old_ratio)
+	{
+		loops_per_jiffy=pllNewLPJ(masked_boot_ratio,new_ratio,
+			boot_loops);
+#if DEBUG
+	printk(__FILE__"-%d:  masked_boot_ratio=%d, new_ratio=%d, boot_loops=%d"
+		", loops_per_jiffy=%d\n",__LINE__,masked_boot_ratio,new_ratio,
+	boot_loops,loops_per_jiffy);
+#endif
+
+		_set_PLL(current_pll);
+	}
+	else
+	{
+#if DEBUG
+		printk(__FILE__"-%d:  masked_boot_ratio=%d, new_ratio=%d, "
+			"boot_loops=%d, loops_per_jiffy=%d\n",__LINE__,
+			masked_boot_ratio,new_ratio,boot_loops,
+			loops_per_jiffy);
+#endif
+		_set_PLL(current_pll);
+
+		loops_per_jiffy=pllNewLPJ(masked_boot_ratio,new_ratio,
+			boot_loops);
+#if DEBUG
+		printk(__FILE__"-%d:  masked_boot_ratio=%d, new_ratio=%d, "
+			"boot_loops=%d, loops_per_jiffy=%d\n",__LINE__,
+			masked_boot_ratio,new_ratio,boot_loops,
+			loops_per_jiffy);
+#endif
+	}
+
+#if 0
+	save_flags(flags);
+	cli();
+
+	loops_per_jiffy=pllNewLPJ(masked_boot_ratio,new_ratio,boot_loops);
+
+	_set_PLL(current_pll);
+
+	restore_flags(flags);
+#endif
+}
+
+static void pllTimerF(unsigned long newPLL)
+{
+	if((unsigned int)newPLL) pllSwitchPLLs((unsigned int)newPLL);
+
+	/*
+	 * Clear all lock bits
+	 */
+	boot_ratio&=~(PLL_TIMER|PLL0_LOCK|PLL1_LOCK);
+}
+
+static int checkPLL(unsigned int pll)
+{
+unsigned int current_pll,work_mask,pll_x;
+int rval;
+
+	/*
+	 * This is not reentrant
+	 */
+	if(test_and_set_bit(PLL_LOCK_BIT,&boot_ratio)) return -EBUSY;
+
+	/*
+	 * Don't allow any changes if a timer is pending
+	 */
+	if(boot_ratio&PLL_TIMER) goto checkPLLBusy;
+
+	current_pll=_get_PLL();
+	work_mask=pll>>24;
+
+	/*
+	 * Check to see if the currently selected PLL is being modified
+	 */
+	pll_x=_get_active_PLL(current_pll);
+
+	if(pll_x==0 && work_mask&(PLL0_DO_CFG|PLL0_DO_RNG|PLL0_DO_CONTROL) ||
+		pll_x==1 && work_mask&(PLL1_DO_CFG|PLL1_DO_RNG))
+		goto checkPLLInVal;
+
+	/*
+	 * Can't change to a PLL that is off. Also can't immediately change to
+	 * one that is not locked. Catch that supposedly impossible condition.
+	 */
+	if(work_mask&PLL_DO_SEL)
+	{
+	int next_ratio;
+	unsigned int which_config;
+
+		pll_x=_get_next_PLL(pll);
+
+		/*
+		 * Figure out where the next ratio comes from. It will be from
+		 * pll if we are changing the next pll and current_pll if not.
+		 */
+		which_config=pll_x?((work_mask&PLL1_DO_CFG)?pll:current_pll):
+			((work_mask&PLL0_DO_CFG)?pll:current_pll);
+		next_ratio=_get_PLL_ratio(pll_x,which_config);
+		if(next_ratio<4 || next_ratio>30) goto checkPLLInVal;
+
+		pll_x=(pll_x==0 && boot_ratio&PLL0_LOCK || pll_x==1 &&
+			boot_ratio&PLL1_LOCK)?1:0;
+
+	}
+	/*
+	 * To avoid complications, don't allow both plls to be half ratios
+	 */
+	if(work_mask&PLL0_DO_CFG)
+	{
+	int old_ratio1,new_ratio0;
+
+		old_ratio1=_get_PLL_ratio(1,current_pll);
+		new_ratio0=_get_PLL_ratio(0,pll);
+
+		if(old_ratio1>4 && old_ratio1<20 && new_ratio0>4 && new_ratio0<
+			20 && (old_ratio1&0x1) & (new_ratio0&0x1))
+			goto checkPLLInVal;
+	}
+	else if(work_mask&PLL1_DO_CFG)
+	{
+	int old_ratio0,new_ratio1;
+
+		old_ratio0=_get_PLL_ratio(0,current_pll);
+		new_ratio1=_get_PLL_ratio(1,pll);
+
+		if(old_ratio0>4 && old_ratio0<20 && new_ratio1>4 && new_ratio1<
+			20 && (old_ratio0&0x1) & (new_ratio1&0x1))
+			goto checkPLLInVal;
+	}
+
+	/*
+	 * Determine if we will need to schedule a timer for a PLL relock. If
+	 * any PLL config is being changed then a timer will be needed. Also
+	 * need one if changing to a PLL that is not locked, though that should
+	 * not happen.
+	 */
+	if(work_mask&(PLL0_DO_CFG|PLL0_DO_RNG|PLL1_DO_CFG|PLL1_DO_RNG|
+		PLL0_DO_CONTROL) || work_mask&PLL_DO_SEL && pll_x)
+	{
+	unsigned int pll_mask,temp;
+
+		pll_mask=0;
+
+		if(work_mask&PLL0_DO_CFG)
+		{
+			pll_mask|=PLL0_CFG_MASK;
+
+			/*
+			 * Flag that PLL0 needs to relock
+			 */
+			boot_ratio|=PLL0_LOCK;
+		}
+
+		if(work_mask&PLL0_DO_RNG) pll_mask|=PLL0_RNG_MASK;
+
+		if(work_mask&PLL1_DO_CFG)
+		{
+			pll_mask|=PLL1_CFG_MASK;
+
+			/*
+			 * Flag that PLL1 needs to relock
+			 */
+			boot_ratio|=PLL1_LOCK;
+		}
+
+		if(work_mask&PLL1_DO_RNG) pll_mask|=PLL1_RNG_MASK;
+
+		temp=current_pll&~pll_mask|pll&pll_mask;
+
+		if(pll_mask) _set_PLL(temp);
+
+		/*
+		 * Flag that a timer is pending
+		 */
+		boot_ratio|=PLL_TIMER;
+
+		/*
+		 * Schedule a timer to clear the PLL lock bits (and signal that
+		 * it is ok to select the PLL)
+		 */
+		init_timer(&pll_timer);
+
+		pll_timer.function=pllTimerF;
+		pll_timer.data=(work_mask&PLL_DO_SEL)?pll&
+			PLL_SEL_MASK:0;
+
+		/*
+		 * Relock takes 100 us. See how many jiffies will take care of
+		 * it.
+		 */
+		pll_timer.expires=(100*HZ/1000000);
+		if(pll_timer.expires==0) pll_timer.expires=2;
+
+		pll_timer.expires=jiffies+pll_timer.expires;
+		add_timer(&pll_timer);
+	}
+	else if(work_mask&PLL_DO_SEL)
+		pllSwitchPLLs(pll&PLL_SEL_MASK);
+
+	rval=0;
+
+checkPLLErr:
+	clear_bit(PLL_LOCK_BIT,&boot_ratio);
+
+	return rval;
+checkPLLBusy:
+	rval=-EBUSY;
+	goto checkPLLErr;
+checkPLLInVal:
+	rval=-EINVAL;
+	goto checkPLLErr;
+}
+
+/*
+ * Handle accesses to the pll file. Examples for write:
+ *	  value		CFGx/RNGx/res	   effect
+ *	0x08010000			switch to PLL1
+ *	0x08000000			switch to PLL0
+ *	0xc000fa00	1111 1/01/0	PLL0 off (CFG/RNG 31/1)
+ *	0xc000f200	1111 0/01/0	PLL0 to 20x (CFG/RNG 30/1)
+ *	0x30000004	0000 0/10/0	PLL1 off (CFG/RNG 0/2)
+ *	0x30000054	0101 0/10/0	PLL1 to 5x (CFG/RNG a/2)
+ */
+int proc_dopllvec(ctl_table *table, int write, struct file *filp,
+	void *buffer, size_t *lenp)
+{
+	int vleft, first=1, len, left, val;
+	char buf[TMPBUFLEN], *p;
+#if DEBUG
+	printk(__FILE__"-%d:  int proc_dopllvec()\n",__LINE__);
+#endif
+	if (!(cur_cpu_spec[0]->cpu_features & CPU_FTR_DUALPLL))
+		return -EFAULT;
+
+#if DEBUG
+	printk(__FILE__"-%d:  int proc_dopllvec()\n",__LINE__);
+#endif
+	if ( /*!table->maxlen ||*/ (filp->f_pos && !write)) {
+		*lenp = 0;
+		return 0;
+	}
+
+	vleft = table->maxlen / sizeof(int);
+	left = *lenp;
+
+	for (; left /*&& vleft--*/; first=0) {
+		if (write) {
+			while (left) {
+				char c;
+				if(get_user(c,(char *) buffer))
+					return -EFAULT;
+				if (!isspace(c))
+					break;
+				left--;
+				buffer++;
+			}
+			if (!left)
+				break;
+			len = left;
+			if (len > TMPBUFLEN-1)
+				len = TMPBUFLEN-1;
+			if(copy_from_user(buf, buffer, len))
+				return -EFAULT;
+			buf[len] = 0;
+			p = buf;
+			if (*p < '0' || *p > '9')
+				break;
+			val = simple_strtoul(p, &p, 0);
+			len = p-buf;
+			if ((len < left) && *p && !isspace(*p))
+				break;
+			buffer += len;
+			left -= len;
+			val=checkPLL(val);
+		} else {
+		static const char *range_string[]={"default","high","low",
+			"reserved"};
+		static const char *fmt_list[]={"off","bypass","%d","%d.5"};
+		char pll0_cfg_ext[8],pll0_cfg[8],pll1_cfg[8];
+		unsigned int pll,temp0,rng0_ext,rng0,rng1;
+
+#if DEBUG
+			printk(__FILE__"-%d:  int proc_dopllvec()\n",__LINE__);
+#endif
+			val=0;
+
+			pll=_get_PLL();
+
+#if DEBUG
+			printk(__FILE__"-%d:  pll=0x%08x\n",__LINE__,pll);
+#endif
+			temp0=pll>>27;
+
+			switch(temp0)
+			{
+				case 0: case 1: case 31:
+					rng0=0;
+					break;
+				case 2: case 3:
+					rng0=1;
+					break;
+				case 5: case 7: case 9: case 11: case 13:
+				case 15: case 17: case 19:
+					rng0=3;
+					break;
+				default:
+					rng0=2;
+					break;
+			}
+
+			if(temp0>20) temp0=(temp0-10)<<1;
+
+			sprintf(pll0_cfg_ext,fmt_list[rng0],temp0>>1);
+
+			rng0_ext=(pll>>25)&0x3;
+
+			temp0=_get_PLL_ratio(0,pll);
+
+			switch(temp0)
+			{
+				case 0: case 1: case 31:
+					rng0=0;
+					break;
+				case 2: case 3:
+					rng0=1;
+					break;
+				case 5: case 7: case 9: case 11: case 13:
+				case 15: case 17: case 19:
+					rng0=3;
+					break;
+				default:
+					rng0=2;
+					break;
+			}
+
+			if(temp0>20) temp0=(temp0-10)<<1;
+
+			sprintf(pll0_cfg,fmt_list[rng0],temp0>>1);
+
+			rng0=_get_PLL_range(0,pll);
+
+			temp0=_get_PLL_ratio(1,pll);
+
+			switch(temp0)
+			{
+				case 0: case 1: case 31:
+					rng1=0;
+					break;
+				case 2: case 3:
+					rng1=1;
+					break;
+				case 5: case 7: case 9: case 11: case 13:
+				case 15: case 17: case 19:
+					rng1=3;
+					break;
+				default:
+					rng1=2;
+					break;
+			}
+
+			if(temp0>20) temp0=(temp0-10)<<1;
+
+			sprintf(pll1_cfg,fmt_list[rng1],temp0>>1);
+
+			rng1=_get_PLL_range(1,pll);
+
+			sprintf(buf,"0x%08x:  PLL0 external (%s, %s), PLL %d "
+				"selected, PLL0 %s, PLL0 (%s, %s), PLL1 (%s, "
+				"%s)\n",pll,pll0_cfg_ext,range_string[rng0_ext],
+				_get_active_PLL(pll),(pll>>17)&0x1?"internal":
+				"external",pll0_cfg,range_string[rng0],
+				pll1_cfg,range_string[rng1]);
+
+			len = strlen(buf);
+			if (len > left)
+				len = left;
+			if(copy_to_user(buffer, buf, len))
+				return -EFAULT;
+			left -= len;
+			buffer += len;
+			break;
+		}
+	}
+
+	if (!write && !first && left) {
+		if(put_user('\n', (char *) buffer))
+			return -EFAULT;
+		left--, buffer++;
+	}
+	if (write) {
+		p = (char *) buffer;
+		while (left) {
+			char c;
+			if(get_user(c, p++))
+				return -EFAULT;
+			if (!isspace(c))
+				break;
+			left--;
+		}
+	}
+	if (write && first)
+		return -EINVAL;
+	*lenp -= left;
+	filp->f_pos += *lenp;
+
+	return val;
+}
diff -Naur linux-2.4.30.orig/arch/ppc/kernel/ppc_htab.c linux-2.4.30/arch/ppc/kernel/ppc_htab.c
--- linux-2.4.30.orig/arch/ppc/kernel/ppc_htab.c	Thu Apr  7 22:26:06 2005
+++ linux-2.4.30/arch/ppc/kernel/ppc_htab.c	Wed Jun 22 10:41:26 2005
@@ -510,7 +510,15 @@
 			left -= len;
 			_set_L2CR(val);
 		} else {
-			int is750fx = cur_cpu_spec[0]->cpu_features & CPU_FTR_750FX;
+			int is750fgx = cur_cpu_spec[0]->cpu_features & 
+				(CPU_FTR_750FX | CPU_FTR_750GX);
+
+			/*
+			 * For identifying memory size
+			 */
+			if(is750fgx) is750fgx=(cur_cpu_spec[0]->cpu_features
+				& CPU_FTR_750GX)?3:2;
+
 			p = buf;
 			if (!first)
 				*p++ = '\t';
@@ -520,7 +528,7 @@
 				     	"disabled");
 			if (!(val>>30&1))
 				p += sprintf(p, "no ");
-			if (is750fx)
+			if (is750fgx)
 				p += sprintf(p, "ECC checkstop");
 			else
 				p += sprintf(p, "parity");
@@ -528,7 +536,7 @@
 			/* 75x & 74x0 have different L2CR than 745x */
 			if (!(cur_cpu_spec[0]->cpu_features &
 						CPU_FTR_SPEC7450)) {
-				if (!is750fx) {
+				if (!is750fgx) {
 					p += sprintf(p, ", %s",
 						     sizestrings[(val >> 28) & 3]);
 					p += sprintf(p, ", %s",
@@ -536,9 +544,14 @@
 					p += sprintf(p, ", %s",
 						     typestrings[(val >> 23) & 3]);
 				}
+				else
+					p += sprintf(p, ", %s, +1 clock, "
+						"on chip, ",sizestrings[
+						is750fgx]);
+
 				p += sprintf(p, "%s", (val>>22)&1 ?
 					     ", data only" : "");
-				if (!is750fx) {
+				if (!is750fgx) {
 					p += sprintf(p, "%s", (val>>20)&1 ?
 						     ", ZZ enabled": "");
 				}
@@ -546,7 +559,7 @@
 					"write-through" : "copy-back");
 				p += sprintf(p, "%s", (val>>18)&1 ?
 					", testing" : "");
-				if (!is750fx) {
+				if (!is750fgx) {
 					p += sprintf(p, ", %sns hold",
 						     holdstrings[(val>>16)&3]);
 					p += sprintf(p, "%s", (val>>15)&1 ?
diff -Naur linux-2.4.30.orig/include/asm-ppc/cputable.h linux-2.4.30/include/asm-ppc/cputable.h
--- linux-2.4.30.orig/include/asm-ppc/cputable.h	Thu Apr  7 22:26:22 2005
+++ linux-2.4.30/include/asm-ppc/cputable.h	Tue Jun 14 01:52:54 2005
@@ -76,6 +76,8 @@
 #define CPU_FTR_NO_DPM			0x00008000
 #define CPU_FTR_HAS_HIGH_BATS		0x00010000
 #define CPU_FTR_NEED_COHERENT           0x00020000
+#define CPU_FTR_750GX			0x00040000
+#define CPU_FTR_DUALPLL			0x00080000
 
 #ifdef __ASSEMBLY__
 
diff -Naur linux-2.4.30.orig/include/asm-ppc/pll.h linux-2.4.30/include/asm-ppc/pll.h
--- linux-2.4.30.orig/include/asm-ppc/pll.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.30/include/asm-ppc/pll.h	Thu Jun 23 11:32:28 2005
@@ -0,0 +1,125 @@
+#ifndef __PPC_PLL_H
+#define __PPC_PLL_H
+/*
+	Dual PLL functions, for 750FX & 750GX
+	Copyright © 2005 by Kevin Diggs
+
+	This program is free software; you can redistribute it and/or modify
+	it under the terms of the GNU General Public License as published by
+	the Free Software Foundation; either version 2 of the License, or
+	(at your option) any later version.
+
+	This program is distributed in the hope that it will be useful,
+	but WITHOUT ANY WARRANTY; without even the implied warranty of
+	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+	GNU General Public License for more details.
+
+	You should have received a copy of the GNU General Public License
+	along with this program; if not, write to the Free Software
+	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+/*
+	Tue, June 14, 2005.
+	- First public release, contributed by Kevin Diggs.
+	***********
+	***********
+
+	Author:	Kevin Diggs ()
+	Please e-mail updates to this file to me, thanks!
+*/
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/cputable.h>
+#include <asm/ppc_asm.h>
+#include <asm/cache.h>
+
+/*
+	The layout of the PLL register (HID1) is:
+
+	0  4|5 6|7|8| 9 11|12 13|14| 15 |16 20|21 22|23|24 28|29 30| 31
+	PCE |PRE|v|v| Res | Res |v | PS | PC0 | PR0 |v | PC1 | PR1 |Res
+                 | |             |                   |
+	 PSTAT1 -| |             |                   |
+         ECLK -----|             |                   |
+         PI0 --------------------|                   |
+	 Res ----------------------------------------|
+
+	PCE	PLL0 read-only external config
+	PRE	PLL0 read-only external range
+	PSTAT1	PLL status (0 -> PLL0, 1 -> PLL1)
+	ECLK	1 -> enable clkout pin
+	PI0	PLL0 control:  0 -> external
+	PS	PLL select:  0 -> PLL0, 1 -> PLL1
+	PC0	PLL0 configuration
+	PR0	PLL0 range
+	PC1	PLL1 configuration
+	PR1	PLL1 range
+
+	PLL_CFG		bus ratio	PLL_CFG		bus ratio
+	 00000		   off		 10000		    8
+	 00001		   off		 10001		   8.5
+	 00010		 bypass		 10010		    9
+	 00011		 bypass		 10011		   9.5
+	 00100		    2		 10100		   10
+	 00101		   2.5		 10101		   11
+	 00110		    3		 10110		   12
+	 00111		   3.5		 10111		   13
+	 01000		    4		 11000		   14
+	 01001		   4.5		 11001		   15
+	 01010		    5		 11010		   16
+	 01011		   5.5		 11011		   17
+	 01100		    6		 11100		   18
+	 01101		   6.5		 11101		   19
+	 01110		    7		 11110		   20
+	 01111		   7.5		 11111		   off
+
+	PLL_RNG		  range
+	  00		600 -  900
+	  01		900 - 1000
+	  10		500 -  600
+
+ * Update the value of the PLL configuration register based on the crap passed
+ * in. The upper 8 bits (0 - 7) are read only and will be used as flags to con-
+ * trol what we are doing:
+ *	0x80	PLL0 configuration is valid
+ *	0x40	PLL0 range is valid
+ *	0x20	PLL1 configuration is valid
+ *	0x10	PLL1 range is valid
+ *	0x08	PLL select is valid
+ *	0x04	PLL0 control is valid
+ *
+ * Make sure that sufficient time (100 us) is given for a PLL that is changed
+ * to relock before selecting it.
+ */
+
+#define PLL0_DO_CFG	(0x80)
+#define PLL0_DO_RNG	(0x40)
+#define PLL1_DO_CFG	(0x20)
+#define PLL1_DO_RNG	(0x10)
+#define PLL_DO_SEL	(0x08)
+#define PLL0_DO_CONTROL	(0x04)
+
+#define PLL0_CONTROL_MASK	(0x20000)
+#define PLL_SEL_MASK		(0x10000)
+#define PLL0_CFG_MASK		(0x0f800)
+#define PLL0_RNG_MASK		(0x00600)
+#define PLL1_CFG_MASK		(0x000f8)
+#define PLL1_RNG_MASK		(0x00006)
+
+#define PLL_LOCK	(0x80000000)		/* Code lock bit */
+#define PLL_LOCK_BIT (31)
+#define PLL_TIMER	(0x40000000)		/* Timer is scheduled */
+#define PLL_TIMER_BIT (30)
+#define PLL0_LOCK	(0x20000000)		/* PLL 0 unsynced */
+#define PLL0_LOCK_BIT (29)
+#define PLL1_LOCK	(0x10000000)		/* PLL 1 unsynced */
+#define PLL1_LOCK_BIT (28)
+
+extern int _get_PLL(void);
+extern int _get_active_PLL(unsigned int pll);
+extern int _get_next_PLL(unsigned int pll);
+extern int _get_PLL_ratio(int which, unsigned int pll);
+extern int _get_PLL_range(int which, unsigned int pll);
+extern int _set_PLL(unsigned int pll);
+
+#endif
diff -Naur linux-2.4.30.orig/include/linux/sysctl.h linux-2.4.30/include/linux/sysctl.h
--- linux-2.4.30.orig/include/linux/sysctl.h	Sat May 28 22:47:35 2005
+++ linux-2.4.30/include/linux/sysctl.h	Tue Jun 14 01:26:41 2005
@@ -128,6 +128,7 @@
 	KERN_PPC_L3CR=57,       /* l3cr register on PPC */
 	KERN_EXCEPTION_TRACE=58, /* boolean: exception trace */
  	KERN_CORE_SETUID=59,	/* int: set to allow core dumps of setuid apps */
+	KERN_PPC_PLL=60,	/* PLL control register (HID1) on some PPC */
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
 };
 
diff -Naur linux-2.4.30.orig/kernel/sysctl.c linux-2.4.30/kernel/sysctl.c
--- linux-2.4.30.orig/kernel/sysctl.c	Thu Apr  7 22:27:17 2005
+++ linux-2.4.30/kernel/sysctl.c	Tue Jun 21 20:22:23 2005
@@ -100,6 +100,8 @@
 		void *buffer, size_t *lenp);
 int proc_dol3crvec(ctl_table *table, int write, struct file *filp,
 		void *buffer, size_t *lenp);
+int proc_dopllvec(ctl_table *table, int write, struct file *filp,
+		void *buffer, size_t *lenp);
 #endif
 
 #ifdef CONFIG_BSD_PROCESS_ACCT
@@ -210,6 +212,10 @@
 	 0644, NULL, &proc_dol2crvec},
 	{KERN_PPC_L3CR, "l3cr", NULL, 0,
 	 0644, NULL, &proc_dol3crvec},
+#ifdef CONFIG_DUAL_PLL
+	{KERN_PPC_PLL, "pll", NULL, 0,
+	 0644, NULL, &proc_dopllvec},
+#endif
 #endif
 	{KERN_CTLALTDEL, "ctrl-alt-del", &C_A_D, sizeof(int),
 	 0644, NULL, &proc_dointvec},

--------------090705080806090603020406--

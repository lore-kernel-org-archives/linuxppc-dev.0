Date: Fri, 5 Apr 2002 15:23:26 +0200 (CEST)
From: Christian Pellegrin <chri@infis.univ.trieste.it>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Patch: MPC850SARDB FADS and a SARPHY board
Message-ID: <Pine.LNX.4.44.0204051520440.29531-100000@sole.infis.univ.trieste.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, this is a patch to the atm driver from mpc860sar.sf.net v1.3 to
make it work on a MPC850SARDB FADS and a SARPHY board. I tested it by
connecting it to a Forerunner 200E PCI board on a standard pc. The phy
is completly supported (sonetdiag & C.). Unfortunatly on my FADS, even
by setting the FADS_BUG #define in errata.h, the nasty SMC1 problem
doesn't go away. But i don't care much about this (just killed console
on SMC1 :-), since now I'm moving on my final design.

The behavior is controlled by the following defines:

CONFIG_850_SARPHY for specific stuff to this board

CONFIG_SARPHY_E1T1CLK for activate the E1T1 clock on the sarphy

SERIAL_USE_LOOPBACK_SCC loopback of serial via SCC

SUNI_LOOPBACK put the suni phy in loopback mode

KERNEL_HZ_CLOCK if the clock (bus_freq) is in Hz

IDT_LOOPBACK put the idt phy in loopback mode

Any feedback is appreciated!

Bye!


----------8<--------------------------------------------------------
diff -ubBPr 1.3/850sarphy.c 1.3-ascensit/850sarphy.c
--- 1.3/850sarphy.c	Thu Jan  1 00:00:00 1970
+++ 1.3-ascensit/850sarphy.c	Fri Apr  5 12:48:15 2002
@@ -0,0 +1,190 @@
+#include "850sarphy.h"
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <linux/atmdev.h>
+#include <linux/sonet.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/init.h>
+#include <linux/capability.h>
+#include <linux/atm_suni.h>
+#include <asm/system.h>
+#include <asm/param.h>
+#include <asm/uaccess.h>
+#include <asm/8xx_immap.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <linux/ioport.h>
+
+// this is actually very crappy, but don't blame me, I did't projected the SAR-PHY ;-)
+// look at MPC850SARDB user manual 0.1. pages 16-17
+
+#define PORT_A 0
+#define PORT_B 1
+#define PORT_C 2
+#define PORT_D 3
+
+#define PHY_SLOW_DOWN udelay(1);
+
+int rw_port_pin(int port, int pin, int rw, int v) {
+  volatile immap_t* immap = (immap_t*)IMAP_ADDR;
+  volatile ushort *dir, *par, *dat;
+  volatile uint *bdir, *bpar, *bdat;
+  int r = 0;
+
+  if (port==PORT_A) {
+    dir = &immap->im_ioport.iop_padir;
+    par = &immap->im_ioport.iop_papar;
+    dat = &immap->im_ioport.iop_padat;
+  }
+  else if (port==PORT_B) {
+    bdir = &immap->im_cpm.cp_pbdir;
+    bpar = &immap->im_cpm.cp_pbpar;
+    bdat = &immap->im_cpm.cp_pbdat;
+  }
+  else if (port==PORT_C) {
+    dir = &immap->im_ioport.iop_pcdir;
+    par = &immap->im_ioport.iop_pcpar;
+    dat = &immap->im_ioport.iop_pcdat;
+  }
+  else if (port==PORT_D) {
+    dir = &immap->im_ioport.iop_pddir;
+    par = &immap->im_ioport.iop_pdpar;
+    dat = &immap->im_ioport.iop_pddat;
+  }
+  if (rw) {
+    if (port==PORT_B) {
+      *bpar &= ~(0x80000000>>pin);
+      *bdir |= (0x80000000>>pin);
+      if (v) {
+	*bdat |= (0x80000000>>pin);
+      }
+      else {
+	*bdat &= ~(0x80000000>>pin);
+      }
+    }
+    else {
+      *par &= ~(0x8000>>pin);
+      *dir |= (0x8000>>pin);
+      if (v) {
+	*dat |= (0x8000>>pin);
+      }
+      else {
+	*dat &= ~(0x8000>>pin);
+      }
+    }
+  }
+  else {
+    if (port==PORT_B) {
+      *bpar &= ~(0x80000000>>pin);
+      *bdir &= ~(0x80000000>>pin);
+      if (*bdat & (0x80000000>>pin)) {
+	r=1;
+      }
+      else {
+	r=0;
+      }
+    }
+    else {
+      *par &= ~(0x8000>>pin);
+      *dir &= ~(0x8000>>pin);
+      if (*dat & (0x8000>>pin)) {
+	r=1;
+      }
+      else {
+	r=0;
+      }
+    }
+  }
+  return r;
+}
+
+#define PHY_DA0 PORT_B,19
+#define PHY_DA1 PORT_D, 8
+#define PHY_DA2 PORT_C, 7
+#define PHY_DA3 PORT_C,10
+#define PHY_DA4 PORT_B,16
+#define PHY_DA5 PORT_B,17
+#define PHY_DA6 PORT_C, 6
+#define PHY_DA7 PORT_C,11
+#define PHY_ALE PORT_B,22
+#define PHY_CS PORT_B,27
+#define PHY_WR PORT_C,14
+#define PHY_RD PORT_C,13
+#define PHY_RST PORT_B,26
+
+void sarphy_phy_reset(void) {
+  rw_port_pin(PHY_ALE,1,0);	/* ALE 0 */
+  rw_port_pin(PHY_CS,1,0);	/* CS 0 */
+  rw_port_pin(PHY_WR,1,1);	/* WR 1 */
+  rw_port_pin(PHY_RD,1,1);	/* RD 1 */
+  rw_port_pin(PHY_RST,1,0);	/* RST 0 */
+  PHY_SLOW_DOWN
+  rw_port_pin(PHY_RST,1,1);	/* RST 1 */
+  rw_port_pin(PHY_CS,1,1);	/* CS 1 */
+}
+
+
+void sarphy_phy_write(unsigned long a, unsigned char v) {
+  rw_port_pin(PHY_CS,1,0);	/* CS 0 */
+  rw_port_pin(PHY_DA0,1,a & 0x01); /* DA 0 */
+  rw_port_pin(PHY_DA1,1,a & 0x02); /* DA 1 */
+  rw_port_pin(PHY_DA2,1,a & 0x04); /* DA 2 */
+  rw_port_pin(PHY_DA3,1,a & 0x08); /* DA 3 */
+  rw_port_pin(PHY_DA4,1,a & 0x10); /* DA 4 */
+  rw_port_pin(PHY_DA5,1,a & 0x20); /* DA 5 */
+  rw_port_pin(PHY_DA6,1,a & 0x40); /* DA 6 */
+  rw_port_pin(PHY_DA7,1,a & 0x80); /* DA 7 */
+  rw_port_pin(PHY_ALE,1,1);	/* ALE 1 */
+  PHY_SLOW_DOWN
+  rw_port_pin(PHY_ALE,1,0);	/* ALE 0 */
+  rw_port_pin(PHY_DA0,1,v & 0x01); /* DA 0 */
+  rw_port_pin(PHY_DA1,1,v & 0x02); /* DA 1 */
+  rw_port_pin(PHY_DA2,1,v & 0x04); /* DA 2 */
+  rw_port_pin(PHY_DA3,1,v & 0x08); /* DA 3 */
+  rw_port_pin(PHY_DA4,1,v & 0x10); /* DA 4 */
+  rw_port_pin(PHY_DA5,1,v & 0x20); /* DA 5 */
+  rw_port_pin(PHY_DA6,1,v & 0x40); /* DA 6 */
+  rw_port_pin(PHY_DA7,1,v & 0x80); /* DA 7 */
+  rw_port_pin(PHY_WR,1,0);	/* WR 0 */
+  PHY_SLOW_DOWN
+  rw_port_pin(PHY_WR,1,1);	/* WR 1 */
+  rw_port_pin(PHY_CS,1,1);	/* CS 1 */
+}
+
+unsigned char sarphy_phy_read(unsigned long a) {
+  unsigned char r=0;
+
+  rw_port_pin(PHY_CS,1,0);	/* CS 0 */
+  rw_port_pin(PHY_DA0,1,a & 0x01); /* DA 0 */
+  rw_port_pin(PHY_DA1,1,a & 0x02); /* DA 1 */
+  rw_port_pin(PHY_DA2,1,a & 0x04); /* DA 2 */
+  rw_port_pin(PHY_DA3,1,a & 0x08); /* DA 3 */
+  rw_port_pin(PHY_DA4,1,a & 0x10); /* DA 4 */
+  rw_port_pin(PHY_DA5,1,a & 0x20); /* DA 5 */
+  rw_port_pin(PHY_DA6,1,a & 0x40); /* DA 6 */
+  rw_port_pin(PHY_DA7,1,a & 0x80); /* DA 7 */
+  rw_port_pin(PHY_ALE,1,1);	/* ALE 1 */
+  PHY_SLOW_DOWN
+  rw_port_pin(PHY_ALE,1,0);	/* ALE 0 */
+  rw_port_pin(PHY_RD,1,0);	/* RD 0 */
+  PHY_SLOW_DOWN
+  r |= rw_port_pin(PHY_DA0,0,0) << 0; /* DA 0 */
+  r |= rw_port_pin(PHY_DA1,0,0) << 1; /* DA 1 */
+  r |= rw_port_pin(PHY_DA2,0,0) << 2; /* DA 2 */
+  r |= rw_port_pin(PHY_DA3,0,0) << 3; /* DA 3 */
+  r |= rw_port_pin(PHY_DA4,0,0) << 4; /* DA 4 */
+  r |= rw_port_pin(PHY_DA5,0,0) << 5; /* DA 5 */
+  r |= rw_port_pin(PHY_DA6,0,0) << 6; /* DA 6 */
+  r |= rw_port_pin(PHY_DA7,0,0) << 7; /* DA 7 */
+  rw_port_pin(PHY_RD,1,1);	/* RD 1 */
+  rw_port_pin(PHY_CS,1,1);	/* CS 1 */
+  return r;
+}
diff -ubBPr 1.3/850sarphy.h 1.3-ascensit/850sarphy.h
--- 1.3/850sarphy.h	Thu Jan  1 00:00:00 1970
+++ 1.3-ascensit/850sarphy.h	Fri Apr  5 12:48:15 2002
@@ -0,0 +1,8 @@
+#ifndef D850_SARPHY_H
+#define D850_SARPHY_H 1
+
+void sarphy_phy_reset(void);
+void sarphy_phy_write(unsigned long, unsigned char);
+unsigned char sarphy_phy_read(unsigned long);
+
+#endif
diff -ubBPr 1.3/Makefile 1.3-ascensit/Makefile
--- 1.3/Makefile	Thu Feb  7 15:18:19 2002
+++ 1.3-ascensit/Makefile	Fri Apr  5 12:48:15 2002
@@ -19,13 +19,15 @@
 # MA 02111-1307 USA
 #

+EXTRA_CFLAGS := -DEXPORT_SYMTAB -DCONFIG_850_SARPHY -DKERNEL_HZ_CLOCK -DCONFIG_PHY_SUNI_155
+
 O_TARGET := atm.o

 obj-$(CONFIG_ESAR_SUPPORT) += atm-860.o

 list-multi := atm-860.o

-atm-objs := mpc860sar_detect.o mm.o risctimer.o cpmtimer.o mpc860sar.o intpool.o mpool.o
+atm-objs := mpc860sar_detect.o mm.o risctimer.o cpmtimer.o mpc860sar.o intpool.o mpool.o 850sarphy.o
 ifeq ($(CONFIG_PTP_SWITCHING),y)
     atm-objs += switcher.o
 endif
diff -ubBPr 1.3/cpm.h 1.3-ascensit/cpm.h
--- 1.3/cpm.h	Thu Feb  7 15:18:19 2002
+++ 1.3-ascensit/cpm.h	Fri Apr  5 12:48:15 2002
@@ -28,8 +28,11 @@

 #ifdef __KERNEL__

+#define MPC860SAR_DRIVER
+// This is an ugly workaround for different definitions in this driver
+
 #include <asm/8xx_immap.h>
-#include "../8xx_io/commproc.h"
+#include <asm/commproc.h>

 // Parameter RAM offsets.
 #define PROFF_RTIMER    ((uint)0x01B0)          // CP RISC Timers
diff -ubBPr 1.3/cpmtimer.c 1.3-ascensit/cpmtimer.c
--- 1.3/cpmtimer.c	Thu Feb  7 15:18:20 2002
+++ 1.3-ascensit/cpmtimer.c	Fri Apr  5 12:48:15 2002
@@ -401,7 +401,9 @@
 			immap->im_cpmtimer.cpmt_trr4 = trr;

 		DEBUG("cpm trr4=%lx\n", trr);
-
+		//immap->im_cpmtimer.cpmt_tmr4 = 0x0a;
+		//immap->im_cpmtimer.cpmt_trr4 = 0x350;
+		immap->im_cpmtimer.cpmt_tcn4 = 0; /* from the motorola example */
 		break;

 	default:
diff -ubBPr 1.3/errata.h 1.3-ascensit/errata.h
--- 1.3/errata.h	Thu Feb  7 15:18:20 2002
+++ 1.3-ascensit/errata.h	Fri Apr  5 12:48:15 2002
@@ -63,7 +63,7 @@
 # requests the lowest priority - i.e. by setting
 # RCCR[DRQP] = 10.
 */
-#define FADS_BUG
+//#define FADS_BUG

 /*
 # In Table 2-1 (recieve Buffer Descriptors) of the "Enhanced SAR Functionality Supplement" it says:
diff -ubBPr 1.3/idt77106.c 1.3-ascensit/idt77106.c
--- 1.3/idt77106.c	Thu Feb  7 15:18:20 2002
+++ 1.3-ascensit/idt77106.c	Fri Apr  5 12:48:15 2002
@@ -56,18 +56,36 @@
 #include "idt77106.h"
 #include "debug.h"

+#ifdef CONFIG_850_SARPHY
+#include "850sarphy.h"
+#endif

 volatile unsigned char *regs = NULL;

 static unsigned char idt77106_phy_get(unsigned long location) {
-
+#ifdef CONFIG_850_SARPHY
+  unsigned r;
+  r = sarphy_phy_read(location);
+#ifdef DEBUG_PHY_IO
+  printk(KERN_ERR "suni_phy_pu: reading value %x from register %lx\n", r, location);
+#endif
+  return r;
+#else
   return readb(&regs[(location & 0xff)]);
+#endif
 }

+#undef DEBUG_PHY_IO
 static void idt77106_phy_put(unsigned long location, unsigned char value) {
-
-  //printk(KERN_ERR "idt77106_phy_pu: writing value %x to register %x\n", value, location);
+#ifdef CONFIG_850_SARPHY
+  sarphy_phy_write(location, value);
+#ifdef DEBUG_PHY_IO
+  printk(KERN_ERR "suni_phy_put: writing value %x to register %lx\n", value, location);
+#endif
+  return;
+#else
   regs[(location & 0xff)] = value;
+#endif
 }

 static int do_register(struct atm_dev *dev,void *arg, unsigned int isWrite)
@@ -104,13 +122,15 @@
 	ioctl:      idt77106_ioctl,
 };

-#if 0 // Stubb out for now - later on we'll implement this properly
 int __init idt77106_init(struct atm_dev *dev)
 {
     volatile immap_t* immap = (immap_t*)IMAP_ADDR;
     int result;

-
+#ifdef CONFIG_850_SARPHY
+  DOPENCLOSE_PRINTK("IDT on SARPHY: resetting\n");
+  sarphy_phy_reset();
+#else
     // Memory map the IDT77106

     // Get a usable virtual address corresponding to the actual IDT77106
@@ -132,24 +152,32 @@
         printk(KERN_ERR "Error: (" __FUNCTION__ ") ioremap failed\n");
         return -EFAULT;
     }
+ #endif

     dev->phy = &idt77106_ops;

+#ifdef IDT_LOOPBACK
+     {
+       idt77106_phy_put(0x2, 0x2);
+       printk("idt status: MCR %x diag %x\n",
+	      idt77106_phy_get(0x0),
+	      idt77106_phy_get(0x2));
+     }
+#endif
+
     return 0;
 }

 // Release any resource held by PHY
 int idt77106_release(void)
 {
+#ifdef CONFIG_850_SARPHY
+#else
   // Unmap address used by PHY management interface
   iounmap((void *) regs);

   // Release memory region
   release_mem_region(CONFIG_PHY_IDT77106_BASE_ADDR,0x100);
-
+#endif
   return 0;
 }
-#else
-int __init idt77106_init(struct atm_dev *dev) { return 0; }
-int idt77106_release(void) { return 0; }
-#endif
diff -ubBPr 1.3/mpc860sar.c 1.3-ascensit/mpc860sar.c
--- 1.3/mpc860sar.c	Thu Feb  7 15:18:22 2002
+++ 1.3-ascensit/mpc860sar.c	Fri Apr  5 12:48:15 2002
@@ -99,7 +99,10 @@

 // Define this if we've got an Enhanced SAR
 // AJZ TODO: Detect this automatically
+#ifdef CONFIG_850_SARPHY
+#else
 #define GOT_ESAR
+#endif

 /*############# useful macros ######################*/
 // Round up to a power of 2
@@ -1902,7 +1905,12 @@
 {
     static BOOL called = FALSE;
 	bd_t* bd = (bd_t*)__res;
+
+#ifdef KERNEL_HZ_CLOCK
+	unsigned int system_clock = bd->bi_busfreq ;
+#else
 	unsigned int system_clock = bd->bi_busfreq * 1000000;
+#endif

     /* Protect against being called more than once */
     if (called)
@@ -1913,7 +1921,11 @@
     called = TRUE;

 	/* Set the CPM Timer 4 divisor.  See 8xxSAR Supplement, 5-4 */
+#ifdef KERNEL_HZ_CLOCK
+    cpm_timer_divisor = bd->bi_busfreq/1000000 * us;
+#else
 	cpm_timer_divisor = bd->bi_busfreq * us;
+#endif

     /* Save the actual APC tickrate for later use */
     apc_tickrate = system_clock/cpm_timer_divisor;
@@ -1943,6 +1955,7 @@
 	DINIT_PRINTK("cpm_timer_divisor =%ld\n", cpm_timer_divisor);
 	DINIT_PRINTK("cpm_timer_iclk =%ld\n", cpm_timer_iclk);

+
     return 0;
 }
 /*
diff -ubBPr 1.3/mpc860sar.h 1.3-ascensit/mpc860sar.h
--- 1.3/mpc860sar.h	Thu Feb  7 15:18:23 2002
+++ 1.3-ascensit/mpc860sar.h	Fri Apr  5 12:54:10 2002
@@ -69,7 +69,9 @@
  * APC_SLOT_TIME_US.  In turn, this increases
  * loading on the CPM.
  */
-#define MAX_CHANNEL_BITRATE Mbs(20)
+//#define MAX_CHANNEL_BITRATE Mbs(20)
+// CHRI: we suppose total bandwidth we deal with is 2 mbs
+#define MAX_CHANNEL_BITRATE Mbs(2)

 #define MAX_CHANNEL_PCR (MAX_CHANNEL_BITRATE/(53*8))

diff -ubBPr 1.3/mpc860sar_detect.c 1.3-ascensit/mpc860sar_detect.c
--- 1.3/mpc860sar_detect.c	Thu Feb  7 15:18:23 2002
+++ 1.3-ascensit/mpc860sar_detect.c	Fri Apr  5 12:48:15 2002
@@ -29,6 +29,11 @@
 #include <linux/module.h>
 #endif

+// Check for the 850SAR FADS case
+#if defined(CONFIG_SERIAL_ATM_TDMB) && defined(CONFIG_850_SARPHY)
+#error "Only TDMa with the 850 + SARPHY"
+#endif
+
 /*###########################################################################
  # The following needs to be compiled if we've configured ESAR support to
  # be resident in the kernel.
diff -ubBPr 1.3/mpool.c 1.3-ascensit/mpool.c
--- 1.3/mpool.c	Thu Feb  7 15:18:24 2002
+++ 1.3-ascensit/mpool.c	Fri Apr  5 12:48:15 2002
@@ -168,7 +168,6 @@
 #    define OUTPUT(format,args...) printf(format,##args)
 #else
 #    include <linux/kernel.h>
-#    include <string.h>
 #    define OUTPUT(format,args...) printk(KERN_INFO format,##args)
 #endif

diff -ubBPr 1.3/risctimer.c 1.3-ascensit/risctimer.c
--- 1.3/risctimer.c	Thu Feb  7 15:18:25 2002
+++ 1.3-ascensit/risctimer.c	Fri Apr  5 12:48:15 2002
@@ -21,8 +21,11 @@
 #
 */

+#define EXPORT_SYMTAB
+
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/delay.h>

 #include <asm/system.h>
 #include "risctimer.h"
@@ -332,7 +335,9 @@
         ;

 	// Initialize the timer by sending a command to the CP
-	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_TIMER, CPM_CR_SET_TIMER) | CPM_CR_FLG;
+	//cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_TIMER, CPM_CR_SET_TIMER) | CPM_CR_FLG;
+    // FIXME, see page 560 of MPC850UM ..... I'll add to commproc.h aesthetic macros
+    cp->cp_cpcr = 0x0851;
 	while (cp->cp_cpcr & CPM_CR_FLG)
         ;

@@ -426,8 +431,10 @@
         ;

 	// Initialize the timer by sending a command to the CP
-	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_TIMER, CPM_CR_SET_TIMER) |
-		CPM_CR_FLG;
+	//cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_TIMER, CPM_CR_SET_TIMER) |
+	//	CPM_CR_FLG;
+    // FIXME, see page 560 of MPC850UM ..... I'll add to commproc.h aesthetic macros
+    cp->cp_cpcr = 0x0851;
 	while (cp->cp_cpcr & CPM_CR_FLG)
         ;

diff -ubBPr 1.3/serial.c 1.3-ascensit/serial.c
--- 1.3/serial.c	Thu Feb  7 15:18:25 2002
+++ 1.3-ascensit/serial.c	Fri Apr  5 12:48:15 2002
@@ -111,8 +111,8 @@
 //#define SERIAL_APPLY_HEC_COSET

 // The SCCs which use TDMa and TDMb
-#define SCCa (1)  // 1 to 3 - Do NOT use SCC4 as this is reserved by utopia.c
-#define SCCb (3)  // 1 to 3 - Do NOT use SCC4 as this is reserved by utopia.c
+#define SCCa (3)  // 1 to 3 - Do NOT use SCC4 as this is reserved by utopia.c
+#define SCCb (1)  // 1 to 3 - Do NOT use SCC4 as this is reserved by utopia.c

 // Phy rates and (minimum) channel rates for the serial devices
 #define SERIAL_PHY_BITRATE           4160000
@@ -222,9 +222,37 @@
         immap->im_ioport.iop_pcdir |= (0x8000>>4);
         immap->im_ioport.iop_pcpar |= (0x8000>>4);

+        #ifdef CONFIG_SARPHY_E1T1CLK
+	// Use the oscilator on the sarphy to generate the E1T1 clock.
+	// Note that this will kill the ethernet on 850SARFADS
+	// this is a really brain-damaged motorola design IMHO
+	// L1TCLKA in
+        immap->im_ioport.iop_padir &= ~(0x8000>>5);
+        immap->im_ioport.iop_papar |=  (0x8000>>5);
+	// L1TSYNCA in
+        immap->im_ioport.iop_pcdir &= ~(0x8000>>5);
+        immap->im_ioport.iop_pcpar |= (0x8000>>5);
+	// rip ehternet
+	{
+	  volatile	scc_t		*sccp;
+	  volatile	cpm8xx_t	*cp;
+	  extern cpm8xx_t        *cpmp;          /* Pointer to comm processor space */
+
+	  #define SCC_ENET 1
+	  cp = cpmp;	/* Get pointer to Communication Processor */
+	  sccp = (volatile scc_t *)(&cp->cp_scc[SCC_ENET]);
+	  sccp->scc_gsmrl &= ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT); /* disable receiver and trasmitter */
+	  sccp->scc_sccm = 0;	/* dislabe ints */
+
+	}
+	// TOUT2 out
+        immap->im_ioport.iop_padir |=  (0x8000>>4);
+        immap->im_ioport.iop_papar |=  (0x8000>>5);
+	#else
         // NOTE We do not have to configure L1TCLKa and L1TSYNCa
         // because we use the same clock and sync source for xmit
         // as we do for recv.
+	#endif
     }
     else
     {
@@ -469,6 +497,17 @@
         SCC_GSMRH_CTSP |
         SCC_GSMRH_CDS |
         SCC_GSMRH_CTSS ;
+
+#ifdef SERIAL_USE_LOOPBACK_SCC
+    {
+      // Loopback directly on the SCC
+      // This is taken from the Motorola SAR example
+      // and looks undocumented from the MPC850UM
+      immap->im_cpm.cp_scc[scc-1].scc_gsmrl |= SCC_GSMRL_DIAG_LOOP;
+      printk("Activating SCC loopback for SCC %d, gsmrl is %x\n",scc, immap->im_cpm.cp_scc[scc-1].scc_gsmrl);
+    }
+#endif
+
     immap->im_cpm.cp_scc[scc-1].scc_gsmrh = gmsrh;

     // GMSRL[MODE] is ignored because we've set GSMRH[TRX] and GSMRH[TTX] for
diff -ubBPr 1.3/suni.c 1.3-ascensit/suni.c
--- 1.3/suni.c	Thu Feb  7 15:18:26 2002
+++ 1.3-ascensit/suni.c	Fri Apr  5 12:48:15 2002
@@ -58,10 +58,8 @@
 #include "suni.h"
 #include "debug.h"

-#if 0
-#define DPRINTK(format,args...) printk(KERN_DEBUG format,##args)
-#else
-#define DPRINTK(format,args...)
+#ifdef CONFIG_850_SARPHY
+#include "850sarphy.h"
 #endif

 static unsigned char suni_phy_get(unsigned long location);
@@ -201,15 +199,38 @@

 volatile unsigned char *regs = NULL;

-static unsigned char suni_phy_get(unsigned long location) {

-  return readb(&regs[(location & 0xff)]);
+#undef DEBUG_PHY_IO
+unsigned char suni_phy_get(unsigned long location) {
+  unsigned r;
+#ifdef CONFIG_850_SARPHY
+  r = sarphy_phy_read(location);
+#ifdef DEBUG_PHY_IO
+  printk(KERN_ERR "suni_phy_pu: reading value %x from register %lx\n", r, location);
+#endif
+  return r;
+#else
+  r = readb(&regs[(location & 0xff)]);
+#ifdef DEBUG_PHY_IO
+  printk(KERN_ERR "suni_phy_pu: reading value %x from register %lx\n", r, location);
+#endif
+  return r;
+#endif
 }

-static void suni_phy_put(unsigned long location, unsigned char value) {
-
-  //printk(KERN_ERR "suni_phy_pu: writing value %x to register %x\n", value, location);
+void suni_phy_put(unsigned long location, unsigned char value) {
+#ifdef CONFIG_850_SARPHY
+  sarphy_phy_write(location, value);
+#ifdef DEBUG_PHY_IO
+  printk(KERN_ERR "suni_phy_put: writing value %x to register %lx\n", value, location);
+#endif
+  return;
+#else
+#ifdef DEBUG_PHY_IO
+  printk(KERN_ERR "suni_phy_put: writing value %x to register %lx\n", value, location);
+#endif
   regs[(location & 0xff)] = value;
+#endif
 }

 static int do_register(struct atm_dev *dev,void *arg, unsigned int op)
@@ -344,7 +365,10 @@
     volatile immap_t* immap = (immap_t*)IMAP_ADDR;
     int result;

-
+#ifdef CONFIG_850_SARPHY
+  DOPENCLOSE_PRINTK("SUNI on SARPHY: resetting\n");
+  sarphy_phy_reset();
+#else
     // Memory map the S/UNI Ultra

     // Get a usable virtual address corresponding to the actual SUNI
@@ -366,19 +390,40 @@
         return -EFAULT;
     }

+ #endif
+
     dev->phy = &suni_ops;

+     suni_phy_put(SUNI_MRI,0xff);
+     suni_phy_put(SUNI_MRI,0);
+     printk("Suni PHY version: %x\n",suni_phy_get(SUNI_MRI));
+
+     dev->phy->start(dev);
+
+ #ifdef SUNI_LOOPBACK
+     {
+       suni_phy_put(SUNI_MCT, suni_phy_get(SUNI_MCT)| SUNI_MCT_DLE);
+       //suni_phy_put(0x50, suni_phy_get(0x50)| 0x20);
+       printk("Suni loopback enabled, MCT now %x, RACP now %x\n",
+	      suni_phy_get(SUNI_MCT),
+	      suni_phy_get(0x50));
+     }
+ #endif
+
+
     return 0;
 }

 // Release any resource held by PHY
 int suni_release(void)
 {
+#ifdef CONFIG_850_SARPHY
+#else
   // Unmap address used by PHY management interface
   iounmap((void *) regs);

   // Release memory region
   release_mem_region(CONFIG_PHY_SUNI_155_BASE_ADDR,0x100);
-
+#endif
   return 0;
 }
diff -ubBPr 1.3/utopia.c 1.3-ascensit/utopia.c
--- 1.3/utopia.c	Thu Feb  7 15:18:27 2002
+++ 1.3-ascensit/utopia.c	Fri Apr  5 12:49:16 2002
@@ -67,9 +67,13 @@
 #include "idt77106.h"

 /*################## defines ##################*/
-#define UTOPIA_CLOCK_HZ     MHz(24)
+//#define UTOPIA_CLOCK_HZ     MHz(24)
+#define UTOPIA_CLOCK_HZ 17333333
 #define MAX_UTOPIA_CLOCK	MHz(25) // See UTOPIA 1 spec

+//#define UTOPIA_CLOCK_HZ     12100000
+//#define MAX_UTOPIA_CLOCK	MHz(13) // See UTOPIA 1 spec
+
 // Minimum channel rates for the utopia device
 #define UTOPIA_MIN_CHANNEL_BITRATE   Mbs(1)
 #define UTOPIA_MIN_CHANNEL_BYTERATE  (UTOPIA_MIN_CHANNEL_BITRATE / 8)
@@ -93,7 +97,7 @@
 #define UTOPIA_SCREEN_OAM   (FALSE)

 /* Allowed VCI range is 0 to UTOPIA_NUM_VCIS_PER_VPI-1 (must be power of 2)*/
-#define UTOPIA_LOG2_NUM_VCIS_PER_VPI 14
+#define UTOPIA_LOG2_NUM_VCIS_PER_VPI 7
 #define UTOPIA_NUM_VCIS_PER_VPI (1<<UTOPIA_LOG2_NUM_VCIS_PER_VPI)

 // Number of entries in the interrupt queue pointed to by SCC4 param ram
@@ -172,8 +176,11 @@
 	// Configure port D[1] as UT - 7.1.1 - 860SAR supplement
 	immap->im_ioport.iop_pdpar |= (0x8000 >> 1);

+#ifdef CONFIG_850_SARPHY
+#else
     // Configure MUXED mode for UTOPIA bus - makes possible use of port A for MII
     immap->im_ioport.utmode &= ~0x80;
+#endif

 	// Configure port D[3] as SOC - 7.2.4 - 860SAR supplement
 	immap->im_ioport.iop_pdpar |= (0x8000 >> 3);
@@ -206,6 +213,14 @@
 	// 8 are used. Make sue these bits are configured correctly.
 	immap->im_ioport.iop_pddir &= 0x2080;

+#ifdef CONFIG_850_SARPHY
+	immap->im_ioport.iop_pdpar |= 0xDF7F;
+	immap->im_ioport.iop_pddir &= 0x2080;
+	immap->im_ioport.iop_pcpar &= 0xfff6;
+	immap->im_ioport.iop_pcdir &= 0xfff6;
+	immap->im_ioport.iop_pcso |= 0x0009;
+	/* quick and dirty ;-) */
+#else
 	// Configure port C[15] as RXCAV - 7.2.3 - 860SAR supplement
 	immap->im_ioport.iop_pcpar |=  (0x8000 >> 15);
 	immap->im_ioport.iop_pcdir &= ~(0x8000 >> 15);
@@ -214,6 +229,7 @@
 	// Configure port B[15] as TXCAV - 7.2.2 - 860SAR supplement
 	immap->im_cpm.cp_pbpar |= 0x80000000 >> 15;
 	immap->im_cpm.cp_pbdir &= ~(0x80000000 >> 15);
+#endif

 	// Make sure at least 20 system clocks elapse between the
 	// configuration of the PDPAR and clearing SRFCR[DIS].
@@ -249,7 +265,11 @@
 static int utopia_calculate_timing(void)
 {
 	bd_t* bd = (bd_t*)__res;
+#ifdef KERNEL_HZ_CLOCK
+	unsigned int system_clock = bd->bi_busfreq;
+#else
 	unsigned int system_clock = bd->bi_busfreq *1000000;
+#endif

 	// Make sure the requested utopia clock does not exceed the
 	// documented maximum


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
